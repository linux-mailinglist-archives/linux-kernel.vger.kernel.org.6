Return-Path: <linux-kernel+bounces-385975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940EA9B3DB2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010302818A3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCEB1EE034;
	Mon, 28 Oct 2024 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUJNzU98"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5A42E414;
	Mon, 28 Oct 2024 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730154264; cv=none; b=T2+fZYt3SevpQ+HgH2hCYsIjrBmPIfCKyXKIKkWO1n1h5OIaCq287AgzFY05fLfdsR+JSx3bMmocr7i7YdPiOtTFr2xMV7wwxA56CsSgX9xW4DLpyDH6LDLwfb4V8W3BCSxew5bmhnSig3GICA3cMXzyXJcX3Fa99otx+yFPCV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730154264; c=relaxed/simple;
	bh=utzRzWn2WgVfj5Awm5sHq2hFk9MdCUocVEwrk6a3Cf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T603dppMAoeg1H+ZS3ug1C/Ys8tOMuxm6S6+u3yJ+sSsFu8MKioXonF4FktKlqsV7iTpXF5E+6Mx9my4pasTDeNlE2I4xSJPcXANkWWMCNZidxuyOQGHY/VpuryotlQTlI5O4jZC1+mOdRZHg/fVB6tmHwKcn16t45L7u3dodus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUJNzU98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E376C4CEE9;
	Mon, 28 Oct 2024 22:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730154264;
	bh=utzRzWn2WgVfj5Awm5sHq2hFk9MdCUocVEwrk6a3Cf8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hUJNzU985L4AU4CjwZtTv3dNXMiNod+1oI+SYTvzfQ57U9bxhqmNqPBhj+zl4E9YJ
	 sk6u3jHtjXOipRJxandHioOfGoM527siAa1RX4Wk3R0o7PSMAPEzU79ZEwvA2I/kz4
	 I+elprpyW25fTm9g/GZdSo9RBopOI7PFL1STzHl5fk6ZexEFPARA05iPPiY7Ls2DOu
	 76r3klcDjJlME57jjnyMIuk2YakDA5ngpZlhpilAcftBh7NrUoZaVPzGcir3tbvbgi
	 EhLt7zg/N+bct58Wi5A+Y7oSLX6hx1EMM0n55RQXkgfKEc7J/CD48kiCNu0jpfJriK
	 gK5cvLHqlLU/g==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e8607c2aso4949251e87.3;
        Mon, 28 Oct 2024 15:24:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzHXC6FMdLPPVYL14YNZIr4w257ag11qwM1Mbm6/pCvzA2mr2rFgu2KCVniKQeb33AGBfdsuqZFl4nePGH@vger.kernel.org, AJvYcCX0WyhiXfODj0izt13IXV8aUsZHOphcP5NPqhCOVyyTJeBA9wX3ArpwXanAxJQHmlmkwEy5evwFI4mJ@vger.kernel.org, AJvYcCXPaxXKa88aacTs4A/tBHsnl8zpSTvcrXP+m4zkFw3NyXdsf6iN3AigMDBmcFZPjpu5SNIhf70255o6bCTMzv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwDbPXyMncjec39NoIU3PhbZBljsTEapZfme9xYm5dHKCxOH7f
	TBM4QMuEZjP2RpR06EhFiTH67Ck4k5er1AWWcwiacpYmLVUdHkE+nb70DgeskrrTsw57Hr2BlK8
	7GrEjHjsjYINjRXd3xIxsk22NSw==
X-Google-Smtp-Source: AGHT+IE3MvKjtwnN0E1z+stXGG7L2reCi29C8P66XqcQR5Sj+SPtsxowZHkbeS+IBi+G7QFS27w/i1TDE/R6kPFZv4c=
X-Received: by 2002:a05:6512:4020:b0:52f:d0f0:e37e with SMTP id
 2adb3069b0e04-53b3491ac48mr3760256e87.42.1730154262507; Mon, 28 Oct 2024
 15:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org>
 <20241025-rust-platform-dev-v1-2-0df8dcf7c20b@kernel.org> <CAFRnB2WPEQaa6X6LqMk+JTxprguakNqFXvjaUGQ0QazxKH=z4Q@mail.gmail.com>
In-Reply-To: <CAFRnB2WPEQaa6X6LqMk+JTxprguakNqFXvjaUGQ0QazxKH=z4Q@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 28 Oct 2024 17:24:09 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+nqFgK4D6ua+Kx8SiqCZFYaD-nse7vjPLqOLvP0hfo7A@mail.gmail.com>
Message-ID: <CAL_Jsq+nqFgK4D6ua+Kx8SiqCZFYaD-nse7vjPLqOLvP0hfo7A@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] rust: Add bindings for device properties
To: Alex Gaynor <alex.gaynor@gmail.com>
Cc: Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Dirk Behme <dirk.behme@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 4:12=E2=80=AFPM Alex Gaynor <alex.gaynor@gmail.com>=
 wrote:
>
> On Fri, Oct 25, 2024 at 5:06=E2=80=AFPM Rob Herring (Arm) <robh@kernel.or=
g> wrote:
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
>
> This, and several of the other methods are unsound, because they can
> be used to construct arbitrary types for which may not allow all bit
> patterns. You can use:
> https://rust.docs.kernel.org/kernel/types/trait.FromBytes.html as the
> bound to ensure only valid types are used.
>
> Also, instead of using mem::zeroed(), you should use MaybeUnininit
> (https://doc.rust-lang.org/stable/core/mem/union.MaybeUninit.html)
> which allows you to avoid needing to zero initialize.

Something like this what you had in mind?:

pub fn property_read_array<T, const N: usize>(&self, name: &CStr) ->
Result<[T; N]> {
    let mut val: [MaybeUninit<T>; N] =3D [const { MaybeUninit::uninit() }; =
N];

    Self::_property_read_array(self, name, &mut val)?;

    // SAFETY: On success, _property_read_array has filled in the array
    let val =3D unsafe { mem::transmute_copy(&val) };
    Ok(val)
}

