Return-Path: <linux-kernel+bounces-279174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD69F94B9EC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B1328165D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0668189BA3;
	Thu,  8 Aug 2024 09:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bpL9e5zk"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A7173466;
	Thu,  8 Aug 2024 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723110368; cv=none; b=oj1GgZuDP62dVbNjgj7U212NtlQEQWSLVV1coIgMxJMz6apaPeeoFkFdTuChF3G6MUW520+xczJgz9+h3UWDXI4hqFzsz6W2URZCO7XATiueknGxPMlJ11NdO+nbf+q0bn/7qiXpSKNA91O2q0R9FHo0DCwRRWqz6KdtCtUdnNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723110368; c=relaxed/simple;
	bh=/C5Qt4HH3Wpa1HREUVejhdrW94JkRUDqO/0c4Ve4+as=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XAdDY+S4Uaog6mB6I1lNZtEs+WA4VWhVKjEmS6+HhhZBvC6V3zWsiriXxlNnA3QmjdpU1lhYxONNQoYfduTaz6ScGdSNHBlBIJ3LGG0iLJRIX/1Mikd7mSOFZIqPFRy3ZHtrSYeJpnUMxfdPFghGD8bxGsZqsN3E+ikknYNlkG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bpL9e5zk; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723110359; x=1723369559;
	bh=VhZ5Utkdi+wygUi1pRTxl2uzoCXze0BLZoCBO1FoE78=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bpL9e5zkjdqvOy53ebyyKAMkTWjs/EA+6GtAQcAvaLwqPo52DIqOhpqG9tjr/ppRe
	 ZPUanlaML/qlstx4BuRemg9bRhq9yFBkRXGIHSE3223UldC/iIkiTIcHkeQNjgAWYh
	 3YjaR1bZOWHHoQucag7/gTnySZShgEnozr8klccgbXAQllb2Z0swjYZg3cCHz7iqaj
	 BycGJPdW3X8XtBBdjBXpdFtSeFuyR4HaeIG/gup3m6CuQaCeifDerVAtE6k4w/7Zvh
	 UzZ5Oui89F9oVrdnZr1xs0aqx0sxz8iLQtq0Zl38N6LRsGkNFTEbQeR6MRcM2wU07U
	 1IsdieeMHcyOA==
Date: Thu, 08 Aug 2024 09:45:48 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 28/28] kbuild: rust: remove the `alloc` crate
Message-ID: <712cb2e7-bb13-4131-a100-74f8ad0cd2df@proton.me>
In-Reply-To: <20240805152004.5039-29-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-29-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f387583dbc63744e41f076a18ecf22480fdca8d6
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

Should this patch also remove `alloc` from
`scripts/generate_rust_analyzer`?
Or do we need that when editing our `macros` crate (since it depends on
std)?

---
Cheers,
Benno

>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/Makefile          | 44 ++++++++++--------------------------------
>  rust/exports.c         |  1 -
>  scripts/Makefile.build |  7 +------
>  3 files changed, 11 insertions(+), 41 deletions(-)


