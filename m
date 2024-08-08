Return-Path: <linux-kernel+bounces-279118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FD994B92A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013731C24479
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A131898E4;
	Thu,  8 Aug 2024 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dUzQOAnb"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674DB188017;
	Thu,  8 Aug 2024 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723106415; cv=none; b=Y97a6l6WXR/AltU4tewMkEEwMCbN1qUDs2MwWjpdtX/BboFqvkgBr31vpj/24/exTao73YHYAicoeQMKfmjErwQev+QMQKmd5KmeiHPlhHbpnVJ3qdDh7e0Awky6xo9ZkYKJOKPnfb0XXJJ5iKW+xFtKrMsF7XCiwqcdP1PNGjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723106415; c=relaxed/simple;
	bh=FwhEe7tsk+lsulgTzfUjB7Gd6Z6YEX/oh/K8WN7S0k4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FdDSuvBUkd5sPRMWcBY7ihm0hFn4bYqR3sQq6IRQvUVz+s0cpglR4foG693BhU2H21UrfufDjvo1L7xpKcLJba1bvZOfzmdTS30GT4p6X6ZDPRmDkAs+4Nq5hxkF8yW8iPHpmrhgptZHyBCE7fLkZ9HYdloa3FoIx0xzNtEluoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=dUzQOAnb; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723106407; x=1723365607;
	bh=JYVzY2/df0bR8l+qC5/ROuPxQ4v2pUIqeB6P/XtY5ac=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dUzQOAnb+Ni76NXTJBdzxworfccAQsYOX8g9mqp4Y0Tk2sgeRIKZV4TsPDUPOtAJt
	 8jxdiCYgu38goPcJ7FGM44YiHRm+aTVqejphsWqh+U1gSjh4ioChTd9Wh+G0gvPrN0
	 bkPCtPDtGBYRDtTNbrAMl0fAgqUAePf9thNIvvQ0IDQoOAtQ5ySNTi3ZInCS31+Aqr
	 X5FyK6cZsaLbgNKO2reSV5UQVKM7251rMrE04I8K+yPAKO3RqSCbTMstx5OYi6tOWO
	 DJVf3GMoVDfeyI9x3iQ+eJHq9XlR6U0KBkgauqFa9HbK1aACJENuyftzHG/3ByxTEm
	 TFIL55f+UWI2g==
Date: Thu, 08 Aug 2024 08:40:01 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 20/28] rust: alloc: add `Vec` to prelude
Message-ID: <ca0aa9a6-3adb-4b40-a0e4-96687e72fdf3@proton.me>
In-Reply-To: <20240805152004.5039-21-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-21-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 10c4b4ac3cd7900e2598201bb7685ad03b76fa5e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.08.24 17:19, Danilo Krummrich wrote:
> Now that we removed `VecExt` and the corresponding includes in
> prelude.rs, add the new kernel `Vec` type instead.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/prelude.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index fcc8656fdb51..b049ab96202e 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -14,7 +14,7 @@
>  #[doc(no_inline)]
>  pub use core::pin::Pin;
>=20
> -pub use crate::alloc::{flags::*, Box, KBox, KVBox, KVVec, KVec, VBox, VV=
ec};
> +pub use crate::alloc::{flags::*, Box, KBox, KVBox, KVVec, KVec, VBox, VV=
ec, Vec};
>=20
>  #[doc(no_inline)]
>  pub use macros::{module, pin_data, pinned_drop, vtable, Zeroable};
> --
> 2.45.2
>=20


