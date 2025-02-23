Return-Path: <linux-kernel+bounces-527684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283A8A40E2C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB2DC7AB86C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 10:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EA22AF19;
	Sun, 23 Feb 2025 10:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TIc8+i4n"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F1F2046B1;
	Sun, 23 Feb 2025 10:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740308114; cv=none; b=OnlZbQyz3QT9i5RIshmUqSZ6fVQrCAWfjH7gaAgIwlUycXKEkMSaMMj5BoVpXYyNwMKcEgdl0xId0qVrQx2wxxdkctQETCCJXHlZR53HTIBshb5x3Z3z4wRyx0lhIppT80ep1AGg87jPtMWWsm+lIuRLYa78eLHjMgNoPLRqPj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740308114; c=relaxed/simple;
	bh=q+XKvnoPYXVMw3lt5027W6PxhHtQyOx1spmmaf15AQM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oD38SUKcikReLCCBJssblz7xkrI/x8Jf7iEj4HMqU6Cb8LDYKaXWPAcF/KYh3NcNGXDGS6fQt7am+QaUkOcYLtCQcJIBUwMlk5rN0Bq9hvZqQ4iw9cPQHYgEt96lUn2JhH+CuSifhtOYxuhJXAZ9UX9AO5R/Ay6JcJb04KAZhWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=TIc8+i4n; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1740308105; x=1740567305;
	bh=ftzWwZe5dgJ/2krdr+BnmHjM/Of8UIn31pqhWbkUW0w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=TIc8+i4nJO4GaclByTGBjPsuhaA1wqdCDfdcFs6d22nhJbCAIDlyvsoA6yvtiS14L
	 +LQu+NNL6H76fvUJL0IT58ZiOiCPmeY94l55YR8q7ZSY+NcrG+Uo3CJzctLQhfzIoc
	 MBZZKpWH2KJj+ZihjO9zuJQDjucCgkAF6cVjSm86hs9lonDN9P/Y0rhwbWFfeNk03J
	 2Ld9HW8CY0UDhElS44ZP1LFiWPEfKFy4AkZWhR5r22xHfDSH2GAGtvPCAudURLcWh6
	 AYBLsEGfLJND3rneszZDnUDcAQSivOuHR6mMOZBrhlN5mATrsjFtCV4MYNq9flmbq8
	 sFWx//4ZhNSAQ==
Date: Sun, 23 Feb 2025 10:54:59 +0000
To: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Subject: Re: [PATCH] rust: sync: lock: Add an example for Guard::lock_ref()
Message-ID: <f834d8bf-3860-4087-937d-d9937c1be3f2@proton.me>
In-Reply-To: <20250223072114.3715-1-boqun.feng@gmail.com>
References: <20250223072114.3715-1-boqun.feng@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 41ca317b5d80adbd5557b5012302b0a3c5eb8c34
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.02.25 08:21, Boqun Feng wrote:
> To provide examples on usage of `Guard::lock_ref()` along with the unit
> test, an "assert a lock is held by a guard" example is added.
>=20
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
> This depends on Alice's patch:
>=20
> =09https://lore.kernel.org/all/20250130-guard-get-lock-v1-1-8ed87899920a@=
google.com/
>=20
> I'm also OK to fold this in if Alice thinks it's fine.
>=20
>  rust/kernel/sync/lock.rs | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 3701fac6ebf6..6d868e35b0a3 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -201,6 +201,30 @@ unsafe impl<T: Sync + ?Sized, B: Backend> Sync for G=
uard<'_, T, B> {}
>=20
>  impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
>      /// Returns the lock that this guard originates from.
> +    ///
> +    /// # Examples
> +    ///
> +    /// The following example shows how to use [`Guard::lock_ref()`] to =
assert the corresponding
> +    /// lock is held.
> +    ///
> +    /// ```
> +    /// # use kernel::{new_spinlock, stack_pin_init, sync::lock::{Backen=
d, Guard, Lock}};
> +    ///
> +    /// fn assert_held<T, B: Backend>(guard: &Guard<'_, T, B>, lock: &Lo=
ck<T, B>) {
> +    ///     // Address-equal means the same lock.
> +    ///     assert!(core::ptr::eq(guard.lock_ref(), lock));
> +    /// }
> +    ///
> +    /// // Creates a new lock on stack.

I would be inclined to write "new lock on the stack.", but maybe that is
incorrect.

---
Cheers,
Benno

> +    /// stack_pin_init!{
> +    ///     let l =3D new_spinlock!(42)
> +    /// }
> +    ///
> +    /// let g =3D l.lock();
> +    ///
> +    /// // `g` originates from `l`.
> +    /// assert_held(&g, &l);
> +    /// ```
>      pub fn lock_ref(&self) -> &'a Lock<T, B> {
>          self.lock
>      }
> --
> 2.39.5 (Apple Git-154)
>=20


