Return-Path: <linux-kernel+bounces-559668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C72FAA5F7CE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D28B177ACD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4A1267F47;
	Thu, 13 Mar 2025 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DMX36sRr"
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34B313BC3F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875601; cv=none; b=Xu9Q9xf/5AwiWpd2DMyo12P93y7Tv9s4iTnKdA6+oI208381CQlNeg6lFe/mCjpnPcprnoEkp2lSVT89a+JmQXF5XLEhq5HD6dhp0lKNG8BcV9FuqOMayRzuBtY4SJeHxFcGN0yzRkW5FFsmPlmWIGirAKl5egdsLehmYvPko5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875601; c=relaxed/simple;
	bh=Q2lgocfnOAjX7JytasmyzbbZo0yCTSp5iyaOzyn7N+g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LteVO5K2FWyq/pnlFbSWw1K2P4m1RDpKMONFQT7ptWrfZ5vTWT9PpcM+4O7JCqlYuqUhfBwlIKaay2unQGTOLDIaHwhYPZGV6eHej1QUDs3QWc5aluYvWPsxgpVIWJ/Pc0rRX3kPs/oKqxwdC4blgSChOUGPC9SX8w+TbUxG0uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DMX36sRr; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741875597; x=1742134797;
	bh=Dnw04njDbwVRNnEXV5HlTTNcN497/TbBtBGKqQc5NgQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=DMX36sRroSnPjQ+BM9wDhmrZUA4XJBdzKmYbnor0ebmlOmmyejgi6JdgVzaVsdm4b
	 RebLrrofg7bKjmlDJ80g4fE8o1zs61Ep68l1u78zH1u5QeRPXnSrw/5v0E8bS1jXzm
	 qs73VsYtcobmSPFb7gnM0FqaFtWZfr1Calf/wyyIAYVOvWPr0NScW6ncf4dGfxeHGD
	 8zGkCjC5x/Ij9+4ZViJ3Jb5tZqZZR1Jdrbn//TUCcASXutIM+2rh3Gz6IQwkjgW0X0
	 dR72Y0pHnLZegrPP5D/RuI+asHr4NZ2qAzLK/hHFIL+f4Nn+TqlT9/RGDwGc6x7gk0
	 xinMxMPZKdJig==
Date: Thu, 13 Mar 2025 14:19:53 +0000
To: Alexandre Courbot <acourbot@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, Danilo Krummrich <dakr@kernel.org>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust/revocable: add try_with() convenience method
Message-ID: <D8F7D2RPRVAO.2EF39MZXM6FPR@proton.me>
In-Reply-To: <20250313-try_with-v1-1-adcae7ed98a9@nvidia.com>
References: <20250313-try_with-v1-1-adcae7ed98a9@nvidia.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 97f2069102048a141ea95a42830e1f0b98aea16f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 13, 2025 at 1:40 PM CET, Alexandre Courbot wrote:
> diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
> index 1e5a9d25c21b279b01f90b02997492aa4880d84f..0157b20373b5b2892cb618b46=
958bfe095e428b6 100644
> --- a/rust/kernel/revocable.rs
> +++ b/rust/kernel/revocable.rs
> @@ -105,6 +105,28 @@ pub fn try_access(&self) -> Option<RevocableGuard<'_=
, T>> {
>          }
>      }
> =20
> +    /// Tries to access the wrapped object and run the closure `f` on it=
 with the guard held.
> +    ///
> +    /// This is a convenience method to run short non-sleepable code blo=
cks while ensuring the
> +    /// guard is dropped afterwards. [`Self::try_access`] carries the ri=
sk that the caller
> +    /// will forget to explicitly drop that returned guard before callin=
g sleepable code ; this

Space after `;`?

> +    /// method adds an extra safety to make sure it doesn't happen.

To be clear, you still can call a sleeping function form within the
closure and have the same issue, but I agree that that should not happen
accidentally (or at least not as often).

> +    ///
> +    /// Returns `Err(ENXIO)` if the wrapped object has been revoked, or =
the result of `f` after it
> +    /// has been run.
> +    pub fn try_with<R, F: Fn(&T) -> Result<R>>(&self, f: F) -> Result<R>=
 {

This (and below) can be a `FnOnce(&T) -> Result<R>`.

Would it make sense to not use `Result` here and continue with `Option`?

---
Cheers,
Benno

> +        self.try_access().ok_or(ENXIO).and_then(|t| f(&*t))
> +    }
> +
> +    /// Tries to access the wrapped object and run the closure `f` on it=
 with the guard held.
> +    ///
> +    /// This is the same as [`Self::try_with`], with the exception that =
`f` is expected to
> +    /// always succeed and thus does not need to return a `Result`. Thus=
 the only error case is if
> +    /// the wrapped object has been revoked.
> +    pub fn try_with_ok<R, F: Fn(&T) -> R>(&self, f: F) -> Result<R> {
> +        self.try_with(|t| Ok(f(t)))
> +    }
> +
>      /// Tries to access the revocable wrapped object.
>      ///
>      /// Returns `None` if the object has been revoked and is therefore n=
o longer accessible.
>
> ---
> base-commit: 4d872d51bc9d7b899c1f61534e3dbde72613f627
> change-id: 20250313-try_with-cc9f91dd3b60
>
> Best regards,



