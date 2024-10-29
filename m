Return-Path: <linux-kernel+bounces-387448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3B39B5174
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC8728303B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117DE1DD539;
	Tue, 29 Oct 2024 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahA57cS7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372FC19A298;
	Tue, 29 Oct 2024 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730224689; cv=none; b=hXhCBevG/EuqD5JaZJ0FByX8eEiXW0VeqfYn2CPc1SpPVD6X26E/N5OCM49RvzkqKIbqdF16pJvhsGRVUcJ8D0H7MGpIe7lF/bOTNauNI1ya2EbbmEsXakWl4mVKamPYLUJoGjH3S1rB7TOVewTxhlkkhqIGfnzAozFaQQC59As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730224689; c=relaxed/simple;
	bh=FPDxeLe4JaaLb+HIRdyNzCgnenNG860ENQPe0grj9Rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQkLEhAPz9lemQTlBggT1LmvE3qG26H6/rk8X7oLoyGDteX+P4noFGdkgBRK8ILwfMx88BE8ZZ2n6WnzBkX2TH/1Cr/hDzJxSZYf1xcMT6qf9LTfGo027cDVA1XV1x8/38uOThjFmYI5nr78+TMgSfK+dx8bii9gBUuSlSf2urc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahA57cS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC45C4CEEB;
	Tue, 29 Oct 2024 17:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730224688;
	bh=FPDxeLe4JaaLb+HIRdyNzCgnenNG860ENQPe0grj9Rk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ahA57cS7nneGtTneCZbhxQP4ct/T28YRkAkVekmOA6zzwLKhnk6slUk+Ms7ozbfb1
	 oNpab7jmQjID36i/EFZmSzXwngRINayIvYJOZigkaNPEJxhSD8vNUACVqhzc5ZlK89
	 9VfglZdYNltLEaIvQEk2SBkeuh1xy+Az27UWzxkgjwfilYJztE6hGklybREekBmb9c
	 LMyPpMvmqAFzu9f8vmKQW4GYvfhAWMogIl1S3vcPeiwCzEAOtqFzbsEivJo8IbS5uk
	 NtAg9iHlfPC1EuZWDrpGOII6GeA4kIgJfiTObBjY+/kbVDC300JVLZwgv2DSiGMOUP
	 Ppth6h+DoYN5A==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so7550369e87.1;
        Tue, 29 Oct 2024 10:58:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjQy7GfNbxlN9cDqe8r8RkgGbOhfv5+NliW74kd/bOPCXmVc763gfxzM+JKSdM8Z9spi51asK9LpdsMUYUylo=@vger.kernel.org, AJvYcCWp4wn3pi63l/RReviqtr5iBLpxfbNL+FcWglJAAaLAYXCxOTML8WdkVysmtQHQCAiis2L6nhtRWXLL6P4s@vger.kernel.org, AJvYcCXvmT1rz8tZgRyJ+RfAhAEPDppTctnnSEtGA8feuFKQ55UocGyPHEMYCQWh/XEDHmB95ANMsCCuhF/y@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3sCisG2NXJE2scOVOCPrnw50m/9SD/M1oiNiyttVw+rw4DbU/
	JHS6rssGZr4h2Bs1Xxb7sNiIlNBcr/mGkFLPxlu6yg119FBT9MqHfMViJp9SrqQjMYWibnrzEqU
	yB6qMSHexrgF685uPIUA8PcXDGQ==
X-Google-Smtp-Source: AGHT+IHg25TDFYt6OEynRIkQQ43FelFAD0Wdd033FZRak63+Mubc9FOluOHqGWY4csHjtryvOUM8L9d7dl8lvFhZZ/4=
X-Received: by 2002:a05:6512:1304:b0:53b:1f77:e95e with SMTP id
 2adb3069b0e04-53b34c5f595mr5799901e87.44.1730224686962; Tue, 29 Oct 2024
 10:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org>
 <20241025-rust-platform-dev-v1-2-0df8dcf7c20b@kernel.org> <CAH5fLgjhiLUYPgTt_Ks+L-zhWaQG5-Yjm-Y3tfh2b2+PzT=bLg@mail.gmail.com>
In-Reply-To: <CAH5fLgjhiLUYPgTt_Ks+L-zhWaQG5-Yjm-Y3tfh2b2+PzT=bLg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 29 Oct 2024 12:57:53 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJWPR-Q=vsxSvD7V9_v=+om5mRuW9yYNqfavVRUwH9JFw@mail.gmail.com>
Message-ID: <CAL_JsqJWPR-Q=vsxSvD7V9_v=+om5mRuW9yYNqfavVRUwH9JFw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] rust: Add bindings for device properties
To: Alice Ryhl <aliceryhl@google.com>
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

On Tue, Oct 29, 2024 at 9:16=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Fri, Oct 25, 2024 at 11:06=E2=80=AFPM Rob Herring (Arm) <robh@kernel.o=
rg> wrote:
> >
> > The device property API is a firmware agnostic API for reading
> > properties from firmware (DT/ACPI) devices nodes and swnodes.
> >
> > While the C API takes a pointer to a caller allocated variable/buffer,
> > the rust API is designed to return a value and can be used in struct
> > initialization. Rust generics are also utilized to support different
> > sizes of properties (e.g. u8, u16, u32).
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> > Not sure if we need the KVec variant, but I kept it as that was my firs=
t
> > pass attempt. Most callers are filling in some value in a driver data
> > struct. Sometimes the number of elements is not known, so the caller
> > calls to get the array size, allocs the correct size buffer, and then
> > reads the property again to fill in the buffer.
> >
> > I have not implemented a wrapper for device_property_read_string(_array=
)
> > because that API is problematic for dynamic DT nodes. The API just
> > returns pointer(s) into the raw DT data. We probably need to return a
> > copy of the string(s) instead for rust.
> >
> > After property accessors, next up is child node accessors/iterators.
> > ---
> >  rust/bindings/bindings_helper.h |   1 +
> >  rust/kernel/device.rs           | 145 ++++++++++++++++++++++++++++++++=
+++++++-
> >  2 files changed, 145 insertions(+), 1 deletion(-)
> >
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_h=
elper.h
> > index 217c776615b9..65717cc20a23 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -19,6 +19,7 @@
> >  #include <linux/pci.h>
> >  #include <linux/phy.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/property.h>
> >  #include <linux/refcount.h>
> >  #include <linux/sched.h>
> >  #include <linux/slab.h>
> > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > index 0c28b1e6b004..bb66a28df890 100644
> > --- a/rust/kernel/device.rs
> > +++ b/rust/kernel/device.rs
> > @@ -5,10 +5,14 @@
> >  //! C header: [`include/linux/device.h`](srctree/include/linux/device.=
h)
> >
> >  use crate::{
> > +    alloc::KVec,
> >      bindings,
> > +    error::{to_result, Result},
> > +    prelude::*,
> > +    str::CStr,
> >      types::{ARef, Opaque},
> >  };
> > -use core::{fmt, ptr};
> > +use core::{fmt, mem::size_of, ptr};
> >
> >  #[cfg(CONFIG_PRINTK)]
> >  use crate::c_str;
> > @@ -189,6 +193,145 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::=
Arguments<'_>) {
> >              )
> >          };
> >      }
> > +
> > +    /// Returns if a firmware property `name` is true or false
> > +    pub fn property_read_bool(&self, name: &CStr) -> bool {
> > +        unsafe { bindings::device_property_present(self.as_raw(), name=
.as_ptr() as *const i8) }
> > +    }
> > +
> > +    /// Returns if a firmware string property `name` has match for `ma=
tch_str`
> > +    pub fn property_match_string(&self, name: &CStr, match_str: &CStr)=
 -> Result<usize> {
> > +        let ret =3D unsafe {
> > +            bindings::device_property_match_string(
> > +                self.as_raw(),
> > +                name.as_ptr() as *const i8,
> > +                match_str.as_ptr() as *const i8,
> > +            )
> > +        };
> > +        to_result(ret)?;
> > +        Ok(ret as usize)
> > +    }
> > +
> > +    /// Returns firmware property `name` scalar value
> > +    ///
> > +    /// Valid types are i8, u8, i16, u16, i32, u32, i64, u64
> > +    pub fn property_read<T: Copy>(&self, name: &CStr) -> Result<T> {
> > +        let mut val: [T; 1] =3D unsafe { core::mem::zeroed() };
> > +
> > +        Self::_property_read_array(&self, name, &mut val)?;
> > +        Ok(val[0])
> > +    }
> > +
> > +    /// Returns firmware property `name` array values
> > +    ///
> > +    /// Valid types are i8, u8, i16, u16, i32, u32, i64, u64
> > +    pub fn property_read_array<T, const N: usize>(&self, name: &CStr) =
-> Result<[T; N]> {
> > +        let mut val: [T; N] =3D unsafe { core::mem::zeroed() };
> > +
> > +        Self::_property_read_array(self, name, &mut val)?;
> > +        Ok(val)
> > +    }
> > +
> > +    fn _property_read_array<T>(&self, name: &CStr, val: &mut [T]) -> R=
esult {
> > +        match size_of::<T>() {
> > +            1 =3D> to_result(unsafe {
> > +                bindings::device_property_read_u8_array(
> > +                    self.as_raw(),
> > +                    name.as_ptr() as *const i8,
> > +                    val.as_ptr() as *mut u8,
> > +                    val.len(),
> > +                )
> > +            })?,
> > +            2 =3D> to_result(unsafe {
> > +                bindings::device_property_read_u16_array(
> > +                    self.as_raw(),
> > +                    name.as_ptr() as *const i8,
> > +                    val.as_ptr() as *mut u16,
> > +                    val.len(),
> > +                )
> > +            })?,
> > +            4 =3D> to_result(unsafe {
> > +                bindings::device_property_read_u32_array(
> > +                    self.as_raw(),
> > +                    name.as_ptr() as *const i8,
> > +                    val.as_ptr() as *mut u32,
> > +                    val.len(),
> > +                )
> > +            })?,
> > +            8 =3D> to_result(unsafe {
> > +                bindings::device_property_read_u64_array(
> > +                    self.as_raw(),
> > +                    name.as_ptr() as *const i8,
> > +                    val.as_ptr() as *mut u64,
> > +                    val.len(),
> > +                )
> > +            })?,
> > +            _ =3D> return Err(EINVAL),
> > +        }
> > +        Ok(())
> > +    }
> > +
> > +    pub fn property_read_array_vec<T>(&self, name: &CStr, len: usize) =
-> Result<KVec<T>> {
> > +        let mut val: KVec<T> =3D KVec::with_capacity(len, GFP_KERNEL)?=
;
> > +
> > +        // SAFETY: len always matches capacity
> > +        unsafe { val.set_len(len) }
> > +        Self::_property_read_array::<T>(&self, name, val.as_mut_slice(=
))?;
> > +        Ok(val)
> > +    }
> > +
> > +    /// Returns array length for firmware property `name`
> > +    ///
> > +    /// Valid types are i8, u8, i16, u16, i32, u32, i64, u64
> > +    pub fn property_count_elem<T>(&self, name: &CStr) -> Result<usize>=
 {
>
> This always returns usize? I'm a bit confused ...

The C version returned an int so we could return an errno or positive
count. With Result, we don't need negative values and isn't usize
generally used for counts of things like size_t in C?


> > +        match size_of::<T>() {
> > +            1 =3D> {
> > +                ret =3D unsafe {
> > +                    bindings::device_property_read_u8_array(
> > +                        self.as_raw(),
> > +                        name.as_ptr() as *const i8,
> > +                        ptr::null_mut(),
> > +                        0,
> > +                    )
> > +                }
> > +            }
> > +            2 =3D> {
> > +                ret =3D unsafe {
> > +                    bindings::device_property_read_u16_array(
> > +                        self.as_raw(),
> > +                        name.as_ptr() as *const i8,
> > +                        ptr::null_mut(),
> > +                        0,
> > +                    )
> > +                }
> > +            }
> > +            4 =3D> {
> > +                ret =3D unsafe {
> > +                    bindings::device_property_read_u32_array(
> > +                        self.as_raw(),
> > +                        name.as_ptr() as *const i8,
> > +                        ptr::null_mut(),
> > +                        0,
> > +                    )
> > +                }
> > +            }
> > +            8 =3D> {
> > +                ret =3D unsafe {
> > +                    bindings::device_property_read_u64_array(
> > +                        self.as_raw(),
> > +                        name.as_ptr() as *const i8,
> > +                        ptr::null_mut(),
> > +                        0,
> > +                    )
> > +                }
> > +            }
> > +            _ =3D> return Err(EINVAL),
>
> You can use `kernel::build_error!` here to trigger a build failure if
> the size is wrong.

I really want a build error if the type is wrong, then the _ case
would be unreachable. No way to do that?

Rob

