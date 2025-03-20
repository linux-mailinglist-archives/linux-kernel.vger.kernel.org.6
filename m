Return-Path: <linux-kernel+bounces-569739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB25A6A6E1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696C8980357
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384821DF247;
	Thu, 20 Mar 2025 13:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OlyTizJ4"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDDD33CA;
	Thu, 20 Mar 2025 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742476192; cv=none; b=L2w9TD4qeeZcSo2BT64n+dkFsP8nHxAOohu5ZAEIgaveGTa5UFqy8MjzWWKqfCygU09wNBpUHsm33Ushb7/IOprPaLP0CbdUJzWrCcbaYzhS49QXGnDxU/G34ZMXQvn4+xiK7XiQ5EgHMHWOrTvN91eIVjoaT4R/RrNKGAtgV7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742476192; c=relaxed/simple;
	bh=PdiIGraiOw9bwMuvO4i566zHRLO1u+vsTi/k2RXBFuE=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PCyoICQy/63mb9OJqZOPQt6PmUhgpQv1easgR6NhF1Y/WOcAxXtu5PkSyfbmMp8Ijdq2K0+J7Qyg211MAxDnHgBVVjs6DRwXgNdiJS06CGnfZxo7v0eUSMldRQySbZwVszUWVt1dg+z5AeeymM0kj8zKIHQEmPW2wksPUAoJxds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OlyTizJ4; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742476186; x=1742735386;
	bh=LaY6eOWwORdgVYlhLSu6IdjkgHcpxvIHee+V/Mwu5u0=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=OlyTizJ4/TXOzOotZGgTW8t0gHrAEiTQyGKf2wGwfxzrSAHCejmG+scYn/57Fv2wx
	 3xLaJcyFf2kEG6y8ucHc+mWRAELG+NV1ML5ysDwst0hev9x4B8iQCCLnQepVI7k7Oz
	 HSfVTnw0+ZYLbGb4WZVslCrpQF5WUapEUljmyPO5ivZZGviefbx9UqiF+H3x5+cLAn
	 KRUv0qu6zL/yFfcg8AucX0VnWsq5wdrJSM5WkTOP68co8xmuqSR4MzSG53QO/KxS6M
	 SOEvA3XNmuRDB4bbbwn61kR1Wp/HKiC2KTZj8bdQpucfOvSJ8aBucIasE9DTo6+Mw8
	 JIbEySafUCbug==
Date: Thu, 20 Mar 2025 13:09:40 +0000
To: "Christian S. Lima" <christiansantoslima21@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, ~lkcamp/patches@lists.sr.ht, richard120310@gmail.com
From: Benno Lossin <benno.lossin@proton.me>
Subject: Re: [PATCH v5] rust: transmute: Add methods for FromBytes trait
Message-ID: <D8L494ONWVO6.1V6NNJIPG7UU9@proton.me>
In-Reply-To: <20250320014041.101470-1-christiansantoslima21@gmail.com>
References: <20250320014041.101470-1-christiansantoslima21@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f1776b1ee974b5e000843123a1461454cfe5f998
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 20, 2025 at 2:40 AM CET, Christian S. Lima wrote:
> Methods receive a slice and perform size check to add
> a valid way to make conversion safe.
> In this patch, I use an Option, in error case just
> return `None` instead of an Error and
> removed some commentaries.
>
> The conversion between slices `[T]`
> is separated from others, because I couldn't implement it
> in the same way as the other conversions.

Why is this commit message wrapped like this?

>
> Link: https://github.com/Rust-for-Linux/linux/issues/1119
> Signed-off-by: Christian S. Lima <christiansantoslima21@gmail.com>
> ---
> Changes in v2:
> - Rollback the implementation for the macro in the repository
> and implement methods in trai
> - Link to v2: https://lore.kernel.org/rust-for-linux/20241012193657.290cc=
79c@eugeo/T/#t
>
> Changes in v3:
> - Fix grammar errors
> - Remove repeated tests
> - Fix alignment errors
> - Fix tests not building
> - Link to v3: https://lore.kernel.org/rust-for-linux/20241109055442.85190=
-1-christiansantoslima21@gmail.com/
>
> Changes in v4:
> - Removed core::simd::ToBytes
> - Changed trait and methods to safe
> - Add Result<&Self, Error> in order to make safe methods
> - Link to v4: https://lore.kernel.org/rust-for-linux/20250314034910.13446=
3-1-christiansantoslima21@gmail.com/
>
> - Link to v1: https://lore.kernel.org/rust-for-linux/20241009014810.23279=
-1-christiansantoslima21@gmail.com/

What changed in version 5? Or does "Changes in v4" mean "Changes done to
v4"?

> ---
>  rust/kernel/transmute.rs | 74 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 69 insertions(+), 5 deletions(-)
>
> diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
> index 1c7d43771a37..5f2cf66187ad 100644
> --- a/rust/kernel/transmute.rs
> +++ b/rust/kernel/transmute.rs
> @@ -9,15 +9,53 @@
>  ///
>  /// It's okay for the type to have padding, as initializing those bytes =
has no effect.
>  ///
> +/// # Example
> +/// ```
> +/// let foo =3D &[1, 2, 3, 4];
> +///
> +/// let result =3D u8::from_bytes(foo);
> +///
> +/// assert_eq!(*result, 0x40300201);

AFAIU this relies on the endianess of the architecture, I would check
the endianess in the test and then change the assertion based on that.

> +/// ```
> +///
>  /// # Safety
>  ///
>  /// All bit-patterns must be valid for this type. This type must not hav=
e interior mutability.
> -pub unsafe trait FromBytes {}
> +pub unsafe trait FromBytes {
> +    /// Receives a slice of bytes and converts to a valid reference of S=
elf when it's possible.

/// Converts a slice of bytes to a reference to `Self` when possible.

> +    fn from_bytes(bytes: &[u8]) -> Option<&Self>;
> +
> +    /// Receives a mutable slice of bytes and converts to a valid refere=
nce of Self when it's possible.

Similarly here.

> +    fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut Self>
> +    where
> +        Self: AsBytes;
> +}
> =20
>  macro_rules! impl_frombytes {
>      ($($({$($generics:tt)*})? $t:ty, )*) =3D> {
>          // SAFETY: Safety comments written in the macro invocation.
> -        $(unsafe impl$($($generics)*)? FromBytes for $t {})*
> +        $(unsafe impl$($($generics)*)? FromBytes for $t {
> +            fn from_bytes(bytes: &[u8]) -> Option<&$t> {
> +                if bytes.len() =3D=3D core::mem::size_of::<$t>() {
> +                    let slice_ptr =3D bytes.as_ptr() as *const $t;

Please use `.cast::<$t>()` instead of `as`.

> +                    unsafe { Some(&*slice_ptr) }

Missing safety comment.

> +                } else {
> +                    None
> +                }
> +            }
> +
> +            fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut $t>
> +            where
> +                Self: AsBytes,
> +            {
> +                if bytes.len() =3D=3D core::mem::size_of::<$t>() {
> +                    let slice_ptr =3D bytes.as_mut_ptr() as *mut $t;

Please use `cast`.

> +                    unsafe { Some(&mut *slice_ptr) }

Missing safety comment.

> +                } else {
> +                    None
> +                }
> +            }
> +        })*
>      };
>  }
> =20
> @@ -26,12 +64,38 @@ macro_rules! impl_frombytes {
>      u8, u16, u32, u64, usize,
>      i8, i16, i32, i64, isize,
> =20
> -    // SAFETY: If all bit patterns are acceptable for individual values =
in an array, then all bit
> -    // patterns are also acceptable for arrays of that type.
> -    {<T: FromBytes>} [T],
>      {<T: FromBytes, const N: usize>} [T; N],

Missing SAFETY comment (the one that you remove above should still be
there).

>  }
> =20
> +unsafe impl<T: FromBytes> FromBytes for [T] {

Missing SAFETY comment, you should copy the one from above.

> +    fn from_bytes(bytes: &[u8]) -> Option<&Self> {
> +        let slice_ptr =3D bytes.as_ptr() as *const T;
> +        if bytes.len() % core::mem::size_of::<T>() =3D=3D 0 {
> +            let slice_len =3D bytes.len() / core::mem::size_of::<T>();
> +            // SAFETY: If all bit patterns are acceptable for individual=
 values in an array, then all bit
> +            // patterns are also acceptable for arrays of that type.

This safety comment doesn't match the called function below.

> +            unsafe { Some(core::slice::from_raw_parts(slice_ptr, slice_l=
en)) }
> +        } else {
> +            None
> +        }
> +    }
> +
> +    fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut Self>
> +    where
> +        Self: AsBytes,
> +    {
> +        let slice_ptr =3D bytes.as_mut_ptr() as *mut T;
> +        if bytes.len() % core::mem::size_of::<T>() =3D=3D 0 {
> +            let slice_len =3D bytes.len() / core::mem::size_of::<T>();
> +            // SAFETY: If all bit patterns are acceptable for individual=
 values in an array, then all bit
> +            // patterns are also acceptable for arrays of that type.

Ditto.

---
Cheers,
Benno

> +            unsafe { Some(core::slice::from_raw_parts_mut(slice_ptr, sli=
ce_len)) }
> +        } else {
> +            None
> +        }
> +    }
> +}
> +
>  /// Types that can be viewed as an immutable slice of initialized bytes.
>  ///
>  /// If a struct implements this trait, then it is okay to copy it byte-f=
or-byte to userspace. This



