Return-Path: <linux-kernel+bounces-278951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FB194B6FF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D627E1F24D66
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B19187FF0;
	Thu,  8 Aug 2024 06:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OMFJ79j4"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DBE18454F;
	Thu,  8 Aug 2024 06:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723100333; cv=none; b=FbmJ8NmfAnykc95dKDDe4FwnR6wvlnz8+yOThL+Dndu2Hj1QpIRcyA5shtlX5aDd3Jpm1Vmzj4fcrh7Z0YZIDrfEhKbiXlM6DAKGcpAC1bnorheW5JQFNhcCj+fMi9uIhLIUqos1i6DXcEJY1mPvJ/5n3zAoOZ1uXFWvxI6J/dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723100333; c=relaxed/simple;
	bh=16rmbYO3s2QKoxYmTWLhZZOEa339Tp3SddTmwpRS7NY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/oy9ckJusLiphcCYbB5e9yIewpNs35NNqxcybiEMouIisBILzbdcrAVN1bwhE3HKcz9Y9LryKyR4sRR/LvCwkVzIYYAu8YAKR1SLFR1vrEcB71TRCdQN5P7FYXlZ48QnsCysXvs+ANqgZUhj6j1+3tWh9Mwmcfw/FGb7JcA/DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OMFJ79j4; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=4j5sgbw6zranvjeyxaiukd6oqy.protonmail; t=1723100328; x=1723359528;
	bh=Pt9CkHZPaha/LAPnzz7aO/OUrpV2czpkgZBZ/H3KaUs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OMFJ79j4+/s/X2WDIO+2lf9tDbepuwrVvV5Yd9zUo1tSr+/RBdSfdzcuW3qQC4pux
	 OEeLnv/C4sJwqxyrS7HBs9i+TmueT5cxb2AaNo2I7DHW+HO3KbyJmS76I4fWPsTtVd
	 6vfrlZT4pSXrXUpoz0wcH3Fc8NFB3QtWGwlX8rDLxR7qrxdI7KGmdcurbF+kAPZefL
	 I/BMhPqhAE6ov5KkSNAXgr2wndRebYndNVSczIuxUQrYVTibTrpSQqaYf6rcRy5iKz
	 fus8TSJKleXB0q1t+ktfu4A4KjUyyYBnddMkb/4UQaBXcl55NJOUE5HembZw3+cRRH
	 V2fwozrJ7txBA==
Date: Thu, 08 Aug 2024 06:58:26 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 28/28] kbuild: rust: remove the `alloc` crate
Message-ID: <45621f42-80a8-4361-8eb6-3e6294819978@proton.me>
In-Reply-To: <20240805152004.5039-29-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-29-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 9a0ba4d0fbf6ba155982593b22c74a8671a9da45
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.08.24 17:19, Danilo Krummrich wrote:
> Now that we have our own `Allocator`, `Box` and `Vec` types we can remove
> Rust's `alloc` crate and the corresponding unstable features.

Would be great if you could include the list of unstable features that
are now no longer needed here.

---
Cheers,
Benno

> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/Makefile          | 44 ++++++++++--------------------------------
>  rust/exports.c         |  1 -
>  scripts/Makefile.build |  7 +------
>  3 files changed, 11 insertions(+), 41 deletions(-)


