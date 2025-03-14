Return-Path: <linux-kernel+bounces-561253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA12A60F44
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E8F179F19
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0550E1FCFC2;
	Fri, 14 Mar 2025 10:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bpbhMBIs"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327031779AE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741949145; cv=none; b=sxSaxfPOVPSYZjVJlRZO3xI+yvpUVPurw2V22i00+EFnkOu9W6EOR2nFylV2zDDSAE4uqkrEpENoodZjeucpiH5Bfnq6tW98e8CvHs04qMT1s3x4oiAR995QXPoKXAHHM7Dh819wJUDWcxb+qoV+Bw3es0MZMjj8gzLG1J2kuCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741949145; c=relaxed/simple;
	bh=s83CnFuMUBdRVi85n+DkGZGIIjnbeV1DrV6xyM0fr4U=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPT9ODKaMBX4fA/5b90DaTHlFudWFVYQipXOM64z9HqIHHa3xA4ToLfOXlEO5zb3vjNGDiqVzvmA98b33vcuiF/wd4B2t3FmZLunLCzesMe/kz1YM7l2Y1NO3KQ1hXYU+lKf2JzUYprmv+2ya3JOATtR1ozz+XT/ZHCb0k0RwtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bpbhMBIs; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741949141; x=1742208341;
	bh=w6Ofih28DWAYMNCHiAIhzVUYCxpRvLNfeOqJMrrtf8g=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=bpbhMBIsGK/M8GdCqXPEnHV+sPacDGev6KYF2XnUForqWG95nQ9DxGiky5M004WGw
	 cepX7OceB6Jd6pvFvh3lhsbqWNRD+MukzaJuQmLo42d8qxxrbgXJ+BMn+kzyWIIrWJ
	 QlEpchsUJCfKPVASs+OD+2oW2nFsGb1HvlRkn88XzVGHinzL6k09fx1978lyZ0ZZSv
	 1G9CHmYly0Z+Hu5qXwHLR7QZZWApicA6sU/RotzjUyPenbSxYkg7ENBacISDCM+/Fc
	 V15AxtC5LD5zvK53OOn4P4MJbYiesW/r6CNypgMsfJMx20HPwTKQdTy0CLw+F3bIQ1
	 q9JYlBH+6TSww==
Date: Fri, 14 Mar 2025 10:45:34 +0000
To: christian <christiansantoslima21@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, ~lkcamp/patches@lists.sr.ht, richard120310@gmail.com
From: Benno Lossin <benno.lossin@proton.me>
Subject: Re: [PATCH v4] Add methods for FromBytes trait.
Message-ID: <D8FXFGYZTEXT.24UM4V3HZ5MWH@proton.me>
In-Reply-To: <20250314034910.134463-1-christiansantoslima21@gmail.com>
References: <20250314034910.134463-1-christiansantoslima21@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 6f9e127f71d2089ee0cb96ec705bf43341881ae7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 14, 2025 at 4:49 AM CET, christian wrote:
> Methods receive a slice and perform size check to add
> a valid way to make conversion safe.
> In the invalid case return the EINVAL error.
>
> The conversion between slices ([T])
> is separated from others, because I couldn't implement it
> in the same way as the other conversions.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1119
> Signed-off-by: christian <christiansantoslima21@gmail.com>
> ---

It usually is a good idea to include a changelog and a link to any prior
versions after this `---`. It won't be included in the final commit
message, but help reviewers and others keep track of this series.

>  rust/kernel/transmute.rs | 67 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 64 insertions(+), 3 deletions(-)
>
> diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
> index 1c7d43771a37..5924c0daccfc 100644
> --- a/rust/kernel/transmute.rs
> +++ b/rust/kernel/transmute.rs
> @@ -2,6 +2,8 @@
> =20
>  //! Traits for transmuting types.
> =20
> +use crate::prelude::{Error, EINVAL};
> +
>  /// Types for which any bit pattern is valid.
>  ///
>  /// Not all types are valid for all values. For example, a `bool` must b=
e either zero or one, so
> @@ -12,26 +14,85 @@
>  /// # Safety
>  ///
>  /// All bit-patterns must be valid for this type. This type must not hav=
e interior mutability.
> -pub unsafe trait FromBytes {}
> +///
> +/// # Example

I think this section should go before the `Safety` section.

> +///
> +/// ```
> +/// let foo =3D &[1, 2, 3, 4];
> +///
> +/// let result =3D u8::from_bytes(foo);
> +///
> +/// assert_eq!(*result, 0x40300201);
> +/// ```
> +pub trait FromBytes {

Why is this trait becoming safe?

> +    /// Receives a slice of bytes and converts to a valid reference of S=
elf when it's possible.
> +    fn from_bytes(slice_of_bytes: &[u8]) -> Result<&Self, Error>;

IMO it makes more sense for the return type to be `Option<&Self>`.

> +
> +    /// Receives a mutable slice of bytes and converts to a valid refere=
nce of Self when it's possible.
> +    fn from_bytes_mut(mut_slice_of_bytes: &mut [u8]) -> Result<&mut Self=
, Error>;

This must also require that `Self: AsBytes`, since otherwise the user
could write padding bytes into the original slice.

Also the parameter name `mut_slice_of_bytes` is a bit long, how about
`bytes`?

> +}
> =20
>  macro_rules! impl_frombytes {
>      ($($({$($generics:tt)*})? $t:ty, )*) =3D> {
>          // SAFETY: Safety comments written in the macro invocation.
> -        $(unsafe impl$($($generics)*)? FromBytes for $t {})*
> +        $(impl$($($generics)*)? FromBytes for $t {
> +            fn from_bytes(slice_of_bytes: &[u8]) -> Result<&$t, Error> {
> +                if slice_of_bytes.len() =3D=3D core::mem::size_of::<$t>(=
) {
> +                    let slice_ptr =3D slice_of_bytes.as_ptr() as *const =
$t;
> +                    unsafe { Ok(&*slice_ptr) }
> +                } else {
> +                    Err(EINVAL)
> +                }
> +            }
> +
> +            fn from_bytes_mut(mut_slice_of_bytes: &mut [u8]) -> Result<&=
mut $t, Error> {
> +                if mut_slice_of_bytes.len() =3D=3D core::mem::size_of::<=
$t>() {
> +                    let slice_ptr =3D mut_slice_of_bytes.as_mut_ptr() as=
 *mut $t;
> +                    unsafe { Ok(&mut *slice_ptr) }
> +                } else {
> +                    Err(EINVAL)
> +                }
> +            }
> +        })*
>      };
>  }
> =20
>  impl_frombytes! {
>      // SAFETY: All bit patterns are acceptable values of the types below=
.
> +    // SAFETY: Dereferencing the pointer is safe because slice has the s=
ame size of Self.

What is this safety comment for?

>      u8, u16, u32, u64, usize,
>      i8, i16, i32, i64, isize,
> =20
>      // SAFETY: If all bit patterns are acceptable for individual values =
in an array, then all bit
>      // patterns are also acceptable for arrays of that type.
> -    {<T: FromBytes>} [T],

If you're removing this line, you should also remove its safety comment
above. But since the trait should be `unsafe`, you should move it down
to the impl below.

> +    // SAFETY: Dereferencing the pointer is safe because slice has the s=
ame size of Self.
>      {<T: FromBytes, const N: usize>} [T; N],
>  }
> =20
> +impl<T: FromBytes> FromBytes for [T] {
> +    fn from_bytes(slice_of_bytes: &[u8]) -> Result<&Self, Error> {
> +        let slice_ptr =3D slice_of_bytes.as_ptr() as *const T;
> +        if slice_of_bytes.len() % core::mem::size_of::<T>() =3D=3D 0 {
> +            let slice_len =3D slice_of_bytes.len() / core::mem::size_of:=
:<T>();
> +            // SAFETY: Creating a slice is safe because the slice can be=
 divided into T sized blocks.

You're not justifying why the pointer is valid. Also please avoid
repeating the obvious "Creating a slice is safe".

---
Cheers,
Benno

> +            unsafe { Ok(core::slice::from_raw_parts(slice_ptr, slice_len=
)) }
> +        } else {
> +            Err(EINVAL)
> +        }
> +    }
> +
> +    fn from_bytes_mut(mut_slice_of_bytes: &mut [u8]) -> Result<&mut Self=
, Error> {
> +        let slice_ptr =3D mut_slice_of_bytes.as_mut_ptr() as *mut T;
> +        if mut_slice_of_bytes.len() % core::mem::size_of::<T>() =3D=3D 0=
 {
> +            let slice_len =3D mut_slice_of_bytes.len() / core::mem::size=
_of::<T>();
> +            // SAFETY: Creating a slice is safe because the slice can be=
 divided into T sized blocks.
> +            unsafe { Ok(core::slice::from_raw_parts_mut(slice_ptr, slice=
_len)) }
> +        } else {
> +            Err(EINVAL)
> +        }
> +    }
> +}
> +
>  /// Types that can be viewed as an immutable slice of initialized bytes.
>  ///
>  /// If a struct implements this trait, then it is okay to copy it byte-f=
or-byte to userspace. This



