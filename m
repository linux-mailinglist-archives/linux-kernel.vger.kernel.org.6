Return-Path: <linux-kernel+bounces-382659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9909B1188
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 23:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E362284F31
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390281FB8AF;
	Fri, 25 Oct 2024 21:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvHAaNM7"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E118A217F52;
	Fri, 25 Oct 2024 21:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890761; cv=none; b=rNUIrfPrBcYpph/0bq58yCRi2Tf5QeByVi8x3+PXPjbREnIMIcDSQAWHPC4B+2x4wMzJ7WvCqALe3RIS8XuVsS8P8hWck9ydM/ZFi7mlW9SwGQ7UgxZ6kq4fKQeYU+dDFcAV5+zR97VzB5JBsSdymcICX0wjifItv0hLlyx+L8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890761; c=relaxed/simple;
	bh=IjlTqsHUhgGQl8xGIVfkPYK5Bm5/5+SHMtnaoOWnxtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBEiBPyVpdjm8OynvQEAaTQBPs4ISSe7w3u4NXs2hjcpbtXaczpXndJhZ3mNedJOdpqVVhQ379rj3CCfcO2Xb9sD/Tn8mOG0Sp+SnUEbqO09GuKWROm4GbhadE9JbY4ysOGL3saNoXDL1h1WaNPN6Ym4vMhbqdMVeRgli3ZOfLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvHAaNM7; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e7e1232648so24879167b3.0;
        Fri, 25 Oct 2024 14:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729890758; x=1730495558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oB6lXwMyCbAAmCk2oZzw/HCk/bTAUS3sM4zrs31ZW/0=;
        b=HvHAaNM7LWj1kJUSIIt0MXiUKWDMdcNXCjc/afEaTqT0/gY6s1GlvKEQ0KrsRqzFqN
         o/+JFHvqfmc5tvDyPaWO65E+9hTg94PgGZtV1nx7wJ7Mkh51Y+CXUvX7joh7fXwoavN2
         k55Sx6q9Lj2SUnlqt/SehlJ22j7Vh9Wq0t/43InspKyGmGC+XoaB8HQQMoFd8qCfUb7F
         BfZCPW+UC4aSOwt6nZmhgIwJJL2zpr36WZzW68hctRytFJFaY5QCAkehwmwpuez9HPtg
         yM5p2LYVEkbuq5zakp1Chw6+k2EpUNrLIHoBRClFGrF3FFxyvi17qFEZa3pPiI/q+Ypw
         PQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729890758; x=1730495558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oB6lXwMyCbAAmCk2oZzw/HCk/bTAUS3sM4zrs31ZW/0=;
        b=ZVOxitAVHsR+4QhOmKNcbSaAOzYrq9h7hMOhj4qvDtBVD+UTSCvV7MoobjtCPn2GAm
         bRFefXdsVamFTgC6KUTSg+usjxuD2bPKnzBbvMw6BhefyoHHYaavK/54jTccZNOfgHpp
         Hkv+JUZSXOdZSjDE2F+R1qwEnwtcIzyyNLNAX+p3KzYl/Po6c0q0Fv2UKIyNX+dJ4vZN
         moBgZFRt+FPPKbN0S97OciCvTQSjBpMEhqWoWDCpyw6jI6WV29iEAJ0h1RmQZPc5sR0g
         nK7quK8mD71laxvC1ekgBU0XH4TAmbsq8Hzo+fCapLQq3mdqIuwq0hLSsd57nKfI4po2
         8Psg==
X-Forwarded-Encrypted: i=1; AJvYcCUZNbPjzrbYk7BdKNvE6/pVjgqSeEBa0qa9VtT4PDa/UszWSe+ew7cdWN3QPF1MW6Ujxo+0ZcQUKQ080svBulw=@vger.kernel.org, AJvYcCW4a+6ZCHc/KsVVJMVX142zMfIh1ETcCSqA5DrbhD1HX10/hKzn2HT5RwjBznHm/rg3277HQERfmmPd@vger.kernel.org, AJvYcCXTEV+Z+ZoUGdP50ete7NCkKU16zYhqaIVQOby70SJR8enqToJWqyNYq0pgh7aFcv6D+bq2Qo0Vr6vVhw3F@vger.kernel.org
X-Gm-Message-State: AOJu0YxJX4z4OStLC9fIIqJpwf9sTwH9hCKCLIDZ65Z0+60OGn+nrvb9
	WxGD/QJYDEdCWC1WRi/5BxOoYJCyamYn7sR9HS79bmlPWZCzhgEkIn6qvu9y3Khw3jqd04ZEf8u
	zem4PEtCQaW0Py5RqPr3MRN1k4tM=
X-Google-Smtp-Source: AGHT+IFhl2DXXYedYolNgqaxt8qLhlSq3KHoxK8qW+TlUw6cyJr6abONpTIbzSI2LM+5sB3IQoPJEUUyWgyYt+4VQNY=
X-Received: by 2002:a05:690c:2a8e:b0:6e6:1018:64c7 with SMTP id
 00721157ae682-6e9d8b8dbadmr9108777b3.41.1729890757618; Fri, 25 Oct 2024
 14:12:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org> <20241025-rust-platform-dev-v1-2-0df8dcf7c20b@kernel.org>
In-Reply-To: <20241025-rust-platform-dev-v1-2-0df8dcf7c20b@kernel.org>
From: Alex Gaynor <alex.gaynor@gmail.com>
Date: Fri, 25 Oct 2024 17:12:26 -0400
Message-ID: <CAFRnB2WPEQaa6X6LqMk+JTxprguakNqFXvjaUGQ0QazxKH=z4Q@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] rust: Add bindings for device properties
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Dirk Behme <dirk.behme@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 5:06=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
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

This, and several of the other methods are unsound, because they can
be used to construct arbitrary types for which may not allow all bit
patterns. You can use:
https://rust.docs.kernel.org/kernel/types/trait.FromBytes.html as the
bound to ensure only valid types are used.

Also, instead of using mem::zeroed(), you should use MaybeUnininit
(https://doc.rust-lang.org/stable/core/mem/union.MaybeUninit.html)
which allows you to avoid needing to zero initialize.

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
> +        let ret;
> +
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
> +        }
> +        to_result(ret)?;
> +        Ok(ret.try_into().unwrap())
> +    }
>  }
>
>  // SAFETY: Instances of `Device` are always reference-counted.
>
> --
> 2.45.2
>


--=20
All that is necessary for evil to succeed is for good people to do nothing.

