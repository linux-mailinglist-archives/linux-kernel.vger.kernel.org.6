Return-Path: <linux-kernel+bounces-387099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2589B4BEC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14C01C22343
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB34206E9D;
	Tue, 29 Oct 2024 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fOJsXV3K"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E75D205155
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730211407; cv=none; b=hd0m15Ei8Im9LRElyq9x8p4hYrjaMgXQwA3cN51Q6KGMVOagCwDrbAgnPCi/nTWn8+P4M5RMVCJXUjOScNC6NAKW2tllxgHA1ZfvTbDMk+mnNzPvuOcgCjsAiYpE7cqHyExfaXrajasJ1yotVANjk2DeFQP+U5mb80i0JYFiFOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730211407; c=relaxed/simple;
	bh=UQEvXpB+gCYw5ekhyUv+qz++Xa7jR5ixcUi6qSQssUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3gMnrjKWfhZJyAYtqseBDlcW+ZznGd3V5g/Xsk6rSp33SFdwuNv3RZC3AKm3vHeKm5aQTI1+4lFeIATVIRMo1A4ZK0ZqzT3jPm8GcA1yj1i+/o23FUPBfne1Bj1s2JOuLsbhMHRnfpFEOgUcSn124fVKYXy2RK5MdRjot9ciw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fOJsXV3K; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d41894a32so4148108f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 07:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730211402; x=1730816202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EF49F4TL2bGDfzZ1W3gqbFJy0q9VsnFcF7FddQtLUFA=;
        b=fOJsXV3KiV1EQWRPkZtRhli4B3eylGwjYL+PHeY6CSQq0rV39F9PMMjuopYHC8B4yM
         vDX5BDsSIuUcN7mHl1KbKm8CQQ2y2dWtwdcfZCuCccDDudFYwawpkN+hWxP48i0g2Qw7
         k97qGcgdZCjqcHZf00Y7mYKaprLwpLoiJS9vi0BVZ65iGyz/h6oRdc15VL8nBmqDkUgx
         XTV3HyvK2dMpqtB0qKUOQ1AysZH02w0RCo0nn2BweuPjDZYafugp6zDbWyoj7wXbAvde
         VfUIsvu7x/okB/JQ2yxNj2IS0HqgeIg0USXnkhYTbB9LYuH2ArRqtmkIKGjlfrd5ULjN
         M5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730211402; x=1730816202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EF49F4TL2bGDfzZ1W3gqbFJy0q9VsnFcF7FddQtLUFA=;
        b=a62auswD0tidb+Q67Ye2DbWrMGIrL978IZ4SJ6cudh7+PlZYRyKvKetkm3Zzyqdc2u
         LHO/5CdPiMl1NxOQok8lJoT7PJLAJdVu/lXyyUG8f4za+MZ/pjOOQ6oks7peM2xqH2J7
         ozk7sRLQFz2yWnOfQinPr0I+nYxyoJXoVWx1LWQMRRcSdSVOSn7R21B0bzOyJ4JlNft6
         71+xizIlcidcEv26HX9A3t2BnsFAYBlH+n/FyWt3Iczx+y8FlZwGS4bhGFW6FvKcn8dl
         sNkBvTPncy7IzS4/jjYkbVGA3bTFr/NvIhTCH2+DqcQ6acmr1H9/AqtdFtlcKaWGhm+b
         /HoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpMq+EdGUgAdfHfG/Vw9XaBw6HXDfFZV2ZUL+mvp69p6h4rHf9K1JnOahaq2EJlKxXy1PHAcwk0I/6tJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw5IaAV9JmIyMAQcn1zbqbLq3mSIHowzWpJq/DuHWgIaamTENs
	bcqClZYwJBHlY4ZqKRMzzmKdjGKVA7QXrrwaBTCa65NlrbGQqwR633fiAy4rfxrx79qSXWSHhRz
	fH8rDoZeUssQSx0vLl9BtSTO0u3so6sPdJzwo
X-Google-Smtp-Source: AGHT+IEfbXY1+De9GOc7DR30d21LlHb1sNgtBauu2PL1dMzu0MewQT6NNFZLprHgHhJf205GTElgQn6gFzczzSX0Ak4=
X-Received: by 2002:a05:6000:acb:b0:37d:3b31:7a9d with SMTP id
 ffacd0b85a97d-38162909bdcmr2015705f8f.23.1730211402215; Tue, 29 Oct 2024
 07:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org> <20241025-rust-platform-dev-v1-2-0df8dcf7c20b@kernel.org>
In-Reply-To: <20241025-rust-platform-dev-v1-2-0df8dcf7c20b@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 29 Oct 2024 15:16:29 +0100
Message-ID: <CAH5fLgjhiLUYPgTt_Ks+L-zhWaQG5-Yjm-Y3tfh2b2+PzT=bLg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] rust: Add bindings for device properties
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Dirk Behme <dirk.behme@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 11:06=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org=
> wrote:
>
> The device property API is a firmware agnostic API for reading
> properties from firmware (DT/ACPI) devices nodes and swnodes.
>
> While the C API takes a pointer to a caller allocated variable/buffer,
> the rust API is designed to return a value and can be used in struct
> initialization. Rust generics are also utilized to support different
> sizes of properties (e.g. u8, u16, u32).
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> Not sure if we need the KVec variant, but I kept it as that was my first
> pass attempt. Most callers are filling in some value in a driver data
> struct. Sometimes the number of elements is not known, so the caller
> calls to get the array size, allocs the correct size buffer, and then
> reads the property again to fill in the buffer.
>
> I have not implemented a wrapper for device_property_read_string(_array)
> because that API is problematic for dynamic DT nodes. The API just
> returns pointer(s) into the raw DT data. We probably need to return a
> copy of the string(s) instead for rust.
>
> After property accessors, next up is child node accessors/iterators.
> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/kernel/device.rs           | 145 ++++++++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 145 insertions(+), 1 deletion(-)
>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 217c776615b9..65717cc20a23 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -19,6 +19,7 @@
>  #include <linux/pci.h>
>  #include <linux/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/refcount.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 0c28b1e6b004..bb66a28df890 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -5,10 +5,14 @@
>  //! C header: [`include/linux/device.h`](srctree/include/linux/device.h)
>
>  use crate::{
> +    alloc::KVec,
>      bindings,
> +    error::{to_result, Result},
> +    prelude::*,
> +    str::CStr,
>      types::{ARef, Opaque},
>  };
> -use core::{fmt, ptr};
> +use core::{fmt, mem::size_of, ptr};
>
>  #[cfg(CONFIG_PRINTK)]
>  use crate::c_str;
> @@ -189,6 +193,145 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::Ar=
guments<'_>) {
>              )
>          };
>      }
> +
> +    /// Returns if a firmware property `name` is true or false
> +    pub fn property_read_bool(&self, name: &CStr) -> bool {
> +        unsafe { bindings::device_property_present(self.as_raw(), name.a=
s_ptr() as *const i8) }
> +    }
> +
> +    /// Returns if a firmware string property `name` has match for `matc=
h_str`
> +    pub fn property_match_string(&self, name: &CStr, match_str: &CStr) -=
> Result<usize> {
> +        let ret =3D unsafe {
> +            bindings::device_property_match_string(
> +                self.as_raw(),
> +                name.as_ptr() as *const i8,
> +                match_str.as_ptr() as *const i8,
> +            )
> +        };
> +        to_result(ret)?;
> +        Ok(ret as usize)
> +    }
> +
> +    /// Returns firmware property `name` scalar value
> +    ///
> +    /// Valid types are i8, u8, i16, u16, i32, u32, i64, u64
> +    pub fn property_read<T: Copy>(&self, name: &CStr) -> Result<T> {
> +        let mut val: [T; 1] =3D unsafe { core::mem::zeroed() };
> +
> +        Self::_property_read_array(&self, name, &mut val)?;
> +        Ok(val[0])
> +    }
> +
> +    /// Returns firmware property `name` array values
> +    ///
> +    /// Valid types are i8, u8, i16, u16, i32, u32, i64, u64
> +    pub fn property_read_array<T, const N: usize>(&self, name: &CStr) ->=
 Result<[T; N]> {
> +        let mut val: [T; N] =3D unsafe { core::mem::zeroed() };
> +
> +        Self::_property_read_array(self, name, &mut val)?;
> +        Ok(val)
> +    }
> +
> +    fn _property_read_array<T>(&self, name: &CStr, val: &mut [T]) -> Res=
ult {
> +        match size_of::<T>() {
> +            1 =3D> to_result(unsafe {
> +                bindings::device_property_read_u8_array(
> +                    self.as_raw(),
> +                    name.as_ptr() as *const i8,
> +                    val.as_ptr() as *mut u8,
> +                    val.len(),
> +                )
> +            })?,
> +            2 =3D> to_result(unsafe {
> +                bindings::device_property_read_u16_array(
> +                    self.as_raw(),
> +                    name.as_ptr() as *const i8,
> +                    val.as_ptr() as *mut u16,
> +                    val.len(),
> +                )
> +            })?,
> +            4 =3D> to_result(unsafe {
> +                bindings::device_property_read_u32_array(
> +                    self.as_raw(),
> +                    name.as_ptr() as *const i8,
> +                    val.as_ptr() as *mut u32,
> +                    val.len(),
> +                )
> +            })?,
> +            8 =3D> to_result(unsafe {
> +                bindings::device_property_read_u64_array(
> +                    self.as_raw(),
> +                    name.as_ptr() as *const i8,
> +                    val.as_ptr() as *mut u64,
> +                    val.len(),
> +                )
> +            })?,
> +            _ =3D> return Err(EINVAL),
> +        }
> +        Ok(())
> +    }
> +
> +    pub fn property_read_array_vec<T>(&self, name: &CStr, len: usize) ->=
 Result<KVec<T>> {
> +        let mut val: KVec<T> =3D KVec::with_capacity(len, GFP_KERNEL)?;
> +
> +        // SAFETY: len always matches capacity
> +        unsafe { val.set_len(len) }
> +        Self::_property_read_array::<T>(&self, name, val.as_mut_slice())=
?;
> +        Ok(val)
> +    }
> +
> +    /// Returns array length for firmware property `name`
> +    ///
> +    /// Valid types are i8, u8, i16, u16, i32, u32, i64, u64
> +    pub fn property_count_elem<T>(&self, name: &CStr) -> Result<usize> {

This always returns usize? I'm a bit confused ...

> +        match size_of::<T>() {
> +            1 =3D> {
> +                ret =3D unsafe {
> +                    bindings::device_property_read_u8_array(
> +                        self.as_raw(),
> +                        name.as_ptr() as *const i8,
> +                        ptr::null_mut(),
> +                        0,
> +                    )
> +                }
> +            }
> +            2 =3D> {
> +                ret =3D unsafe {
> +                    bindings::device_property_read_u16_array(
> +                        self.as_raw(),
> +                        name.as_ptr() as *const i8,
> +                        ptr::null_mut(),
> +                        0,
> +                    )
> +                }
> +            }
> +            4 =3D> {
> +                ret =3D unsafe {
> +                    bindings::device_property_read_u32_array(
> +                        self.as_raw(),
> +                        name.as_ptr() as *const i8,
> +                        ptr::null_mut(),
> +                        0,
> +                    )
> +                }
> +            }
> +            8 =3D> {
> +                ret =3D unsafe {
> +                    bindings::device_property_read_u64_array(
> +                        self.as_raw(),
> +                        name.as_ptr() as *const i8,
> +                        ptr::null_mut(),
> +                        0,
> +                    )
> +                }
> +            }
> +            _ =3D> return Err(EINVAL),

You can use `kernel::build_error!` here to trigger a build failure if
the size is wrong.

Alice

