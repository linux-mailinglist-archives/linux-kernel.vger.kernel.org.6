Return-Path: <linux-kernel+bounces-279140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E66694B97B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A2F1F21750
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFCF189BAD;
	Thu,  8 Aug 2024 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TeVL48QW"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5471189917
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723108102; cv=none; b=XLhdflcp2X56iqcVw+FNqs3UXEbcn5ReqeNQo2keJArDRJzSji6pciXcmGmeFpf1HbfQjH1SGzz9mzmODe8qTa4iQbMetVQKSXCOcySor2wVrOQwn/y+kKA7LEU2s6EW21GOP9DORQfGzVoVe9043ZUfzuq5bJ6aUvQxQkkZJr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723108102; c=relaxed/simple;
	bh=uAc2ZG3ukw60sc6m6JNUFse46tNj8RxOsLbTub41flo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYQofq6FkK/lVTcKMBDfxKM26Z7znslpUaGd5ubPAAsUd/idVCAFbYvW2NZEI6PJWpBUmSLCGpzHUP5vJYrhiaRfrW9s1Ai8axfc5KIBe/gYNgOdftMDx9baiL1vLL+3BsteCYbCNY3jIRZrXW/6tuaV3QNy/F413G753wTTU8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=TeVL48QW; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=uxdqx6g4jbgnba2mrar46fsg3a.protonmail; t=1723108097; x=1723367297;
	bh=4+O/PRWpVpxDVZY+qCPNm52oMb0TpQQtgaQHZ09Ht5c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TeVL48QW7o2NuQ0aUiX+K5Bqbk5KWEalW+aXv6yejJR2QQW/ldCyy5RYlfiIFyLBe
	 sI9AAhbOpohz/V9xMWeg6eNqpjlD0RRvoWmS5cvP4svc/vYMDoUlyBes5Mvmw6n0DB
	 AkKN/NgaexJiOlRnfZH1TTk0D3/ATOD4RYZ4QtAjkAFTU8RKRdt9xKu8NfJX3kpYrX
	 gz+HM/Ddweq25Wo+lVyuD3hL+GFnX6Jebauy252r/jfSpDiDDqUGGdMdiCC7xZeH+I
	 HfEtxpzY+0KjWOMN67a2KLMdp622MXce7iF9CtLCMuKdvw0DTqpovm3/rmWlR6Xn70
	 ILCcl377xTs1Q==
Date: Thu, 08 Aug 2024 09:08:10 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 18/28] rust: treewide: switch to the kernel `Vec` type
Message-ID: <3237696e-4009-4d3c-b2d4-85d3b4adbb85@proton.me>
In-Reply-To: <20240805152004.5039-19-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-19-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a7f3162e886c0daa82e26e7b3c820f1b72604ab3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.08.24 17:19, Danilo Krummrich wrote:
> Now that we got the kernel `Vec` in place, convert all existing `Vec`
> users to make use of it.

You missed one in `rust/kernel/uaccess.rs:92`, but this doesn't
prevent it from compiling since the allocator is correctly inferred from
the context.

---
Cheers,
Benno

> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/str.rs            | 12 +++++-------
>  rust/kernel/sync/locked_by.rs |  2 +-
>  rust/kernel/types.rs          |  2 +-
>  rust/kernel/uaccess.rs        | 15 ++++++---------
>  samples/rust/rust_minimal.rs  |  4 ++--
>  5 files changed, 15 insertions(+), 20 deletions(-)


