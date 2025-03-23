Return-Path: <linux-kernel+bounces-572796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAABFA6CED1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 11:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2942716FD39
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 10:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F272E203719;
	Sun, 23 Mar 2025 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="AEW9UApa"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A3A1EDA07
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742726305; cv=none; b=p6ySMRKEKBmWGXk6ZuJI5kvqsLLdf7U8HHE6pQMxinZf42UxiVFch2DaSsLzlLcZL45+IJQP8PLF8SWaQoMGRPE/Dt3Xvtc2aRq5XfjeiM+uQt97VtGADAej/NhvhjuQAd0ao62CJ3zAybGr4U9+S6LkrmoM1W/PLfYmGHRr53c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742726305; c=relaxed/simple;
	bh=2WdCRvs1sUkmEEUK1LC0i8qzti5aHQtF8Ti+JfUtUR4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GCShzJxGlcXHdRKXfk6GcRd3S4Ea3NV8emqbiSypWlDs+wiABU+vxS7MxhjWqjdRVk1Eg3b1krxCbkKLscif+JKsx9OcaZd9sSH7KHh+uUUFXvFBSL8oOm7LxDWnMSmvuaR6uyQJuBInd5Sv7P80IZxHZnw3gRf0XdQtPzSFgTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=AEW9UApa; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742726302; x=1742985502;
	bh=2JgJh2J6m4AP672rD2rN34JCsBBoXTRkwtHyIXpap/I=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=AEW9UApaTpQ2tvSz08e+tc+w0sPSfTQUR7tKB8lVBh98lY3/UvTYKavKABJ7EjJg3
	 yPi7WvfN2oK0LWEJ3zBbU+XKEqsB8TOUalc6iwGxbF5BduDiyJkbWwtZYMC86DEwBQ
	 UHU3gRxz5dKkPt/Wgv7+Wta1YpeSvxoIwPTn1Xpj7oWsPFoxxCmMtcGkdFBMlhfMKN
	 /1qNgiJ8/kgbNFuOREKklnfS2B56m+gPNw0gFMOk0YxHebhoh3Efp/9AMuQrCjhDC+
	 v+inLfnuvDVyg+FTQK10/+KZGGBwaHhsq0XwD6gm0YiOmxzCLJyAtfjW1C8TgUHvak
	 +f1+/zsrov6sQ==
Date: Sun, 23 Mar 2025 10:38:17 +0000
To: Antonio Hickey <contact@antoniohickey.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/17] rust: workqueue: replace `raw_get` with pointer cast
Message-ID: <D8NKWUQK703Y.38SYPI7LCXKO3@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 8f96a89c1b0b8046897cd4d722875da30abbc529
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 20, 2025 at 3:07 AM CET, Antonio Hickey wrote:
> Now that `Work` is initialized via `pin-init`, the `work` field
> is always used. This allows us to replace the use of unsafe
> `Opaque::raw_get` with direct pointer casting.
>
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Link: https://lore.kernel.org/all/20250316061429.817126-1-contact@antonio=
hickey.com/T/#mc7a4757e8c132f84228b728c7d123d73841501d6
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>

One nit below, but regardless:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>  rust/kernel/workqueue.rs | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index 4e27df324d26..5cc259c1e502 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -399,12 +399,8 @@ pub fn new(name: &'static CStr, key: &'static LockCl=
assKey) -> impl PinInit<Self
>      /// need not be initialized.)
>      #[inline]
>      pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struc=
t {
> -        // SAFETY: The caller promises that the pointer is aligned and n=
ot dangling.
> -        //
> -        // A pointer cast would also be ok due to `#[repr(transparent)]`=
. We use
> -        // `&raw const (*ptr).work` so that the compiler does not compla=
in that the
> -        // `work` field is unused.
> -        unsafe { Opaque::raw_get(&raw const (*ptr).work) }
> +        // CAST: `Work` is transparent to `bindings::work_struct`.

I usually write:

    // CAST: `Work` is transparently wrapping `bindings::work_struct`.

So feel free to use that. (I find the "transparent to" a bit strange,
but this isn't a huge complaint)

---
Cheers,
Benno

> +        ptr.cast_mut().cast()
>      }
>  }
> =20



