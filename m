Return-Path: <linux-kernel+bounces-570455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0C9A6B088
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C9316EFDB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6735227E9B;
	Thu, 20 Mar 2025 22:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="a42aE7eW"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688182222DD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 22:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742508684; cv=none; b=ilBSSXKWoOK1CyxwsAWzQXkJjFyzRnE0q4HiOr4vHCPIurGd2AYgqOQWp0KmHiJP+hcqriDnrKkU5seYxgd1BwpyCoXSJxtKda1gVWhlKgyL1SeP/U4H3jg0HqnTpCTV6UCHoFfA79ARzl38jgyhgWW2B2rjfy5WZUM4zQigDqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742508684; c=relaxed/simple;
	bh=j4m/4kR3AKIDf1SGcymhk4lpp5b2oiTqmH3M80tjwaU=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Q14sSsBg+4XS3vObUjCOE+ZISk36UY1WIanwDB+IG0lR/DEsXpoGhiFPX7CNFhRg92+bILT7jPLg4AHuMUk5akGOTrcuY7RJT9bau4+s1oLM2fV9DTWD1sIYommLmIO7m71m2VAO2xbMAeRU4e2xwZOowkAD1aC1eZpz5eLeqQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=a42aE7eW; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742508675; x=1742767875;
	bh=8j0eHeB4bjnnAP0B/WbCNB3mG2MsYZ2VTB5+OyhqIWc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=a42aE7eWqFnDX3Wp+LBVfwzs+Q111qUU9KLlmIgoaUph/wPm0ewKiSRKOnJGD5xrm
	 FV1BY3PwVDEVCH2HS4oxKhR9eA4Wevd9gVVrccgSWV4ry1KSaoVGarqz0gl0MSUll2
	 +u0jwhtTaBvz3zYPGfYqmko4dJlvm0UbipqyPGTo3/F75XcZ+e4RFdZWcT/szs1Rkz
	 kNLWYFYbRLmYMx+S/qpZrnseWcW5CVNdkkk/3t5wBZyx+9AVu30dK3eN92r9bz8wAu
	 m/8ziESVYlcgFyWEhlejuiAiXKd4KactbdkEHwKcZHsB1ZtC3C0qk+zT/5MmGUuk5V
	 QqUYIM68MMuKA==
Date: Thu, 20 Mar 2025 22:11:09 +0000
To: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] rust: alloc: add Vec::pop
Message-ID: <D8LFRQ5IX33R.35U012LFZ06W0@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: b20d688fdac027eaa34781278aefbde8eb19aedc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 20, 2025 at 2:52 PM CET, Alice Ryhl wrote:
> This introduces a basic method that our custom Vec is missing. I expect
> that it will be used in many places, but at the time of writing, Rust
> Binder has six calls to Vec::pop.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/alloc/kvec.rs | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index 95e752ed27395fce72d372976b74fb1b0e957194..9943358c70aa63f5ad7ed9782=
cb8879d7a80a8fb 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -302,6 +302,37 @@ pub fn push(&mut self, v: T, flags: Flags) -> Result=
<(), AllocError> {
>          Ok(())
>      }
> =20
> +    /// Removes the last element from a vector and returns it, or `None`=
 if it is empty.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let mut v =3D KVec::new();
> +    /// v.push(1, GFP_KERNEL)?;
> +    /// v.push(2, GFP_KERNEL)?;
> +    /// assert_eq!(&v, &[1, 2]);
> +    ///
> +    /// assert_eq!(v.pop(), Some(2));
> +    /// assert_eq!(v.pop(), Some(1));
> +    /// assert_eq!(v.pop(), None);
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn pop(&mut self) -> Option<T> {
> +        let Some(len_sub_1) =3D self.len.checked_sub(1) else {
> +            return None;
> +        };

Isn't it possible to do:?
   =20
    let len_sub_1 =3D self.len.checked_sub(1)?;

> +
> +        // INVARIANT: If the first `len` elements are valid, then the fi=
rst `len-1` elements are

Please add spaces around `-`.

> +        // valid.
> +        self.len =3D len_sub_1;
> +
> +        // INVARIANT: This invalidates a value in this vector's allocati=
on, but the Vec invariants
> +        // do not require it to be valid because `self.len <=3D len_sub_=
1`.

I don't think this should be an `INVARIANT` comment. Maybe we don't even
need it.

---
Cheers,
Benno

> +        // SAFETY: Since `len_sub_1` is less than the value `self.len` h=
ad at the beginning of
> +        // `pop`, this index holds a valid value.
> +        Some(unsafe { self.as_mut_ptr().add(len_sub_1).read() })
> +    }
> +
>      /// Creates a new [`Vec`] instance with at least the given capacity.
>      ///
>      /// # Examples



