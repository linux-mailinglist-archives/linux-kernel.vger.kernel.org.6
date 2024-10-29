Return-Path: <linux-kernel+bounces-386184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC2E9B4024
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4E41F23384
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F99415D5D9;
	Tue, 29 Oct 2024 02:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdohM4aS"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33F31863F;
	Tue, 29 Oct 2024 02:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730167741; cv=none; b=P1R/gkKUgCeV9EBKdbj5n1K6do0ev4ZStXu71cF6BQ+AVOAYSEPxZ/63anorjFYprwWq1y1xzAlphGfU+4HjPcJjwkcvWmNnbthaTLCmvJbC8JoZtdk8FpvFX03AXgSSAlYsA3rGiHJQApP7O4NAjFKZb5im6nBe8ZfC1u9ZbUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730167741; c=relaxed/simple;
	bh=LKgbyEk4LMPGGHytb6lDuy0msQtdn+V7JOF1z1aqpzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jezFoc+j8DgeNYA6w2jstv+ozmS63DgLm2L2H7PNn7zk4NhjJlcDtMFYFkDVCFtcSZR+bPWeS/CHULtB0Z/xDFM49CMP8aD3X/M+/i1oPiVbbsCxN7wGxP6oBN20fqnKuc0nZZH37wu0VnoQq3wXeqDauPf02xWHbLYzpsWLzjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdohM4aS; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e8063533b5so48780027b3.1;
        Mon, 28 Oct 2024 19:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730167739; x=1730772539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POAC9Eq7jdy/DJpHixlYJQgZCur0l0rG31IXlnXpLtM=;
        b=bdohM4aSnftZhPNW8958CWRKuS0w0dkOz8rDh+a25HY6wKfLqiFxBr8AD2MZWjf5V2
         DSls6RDOitd5PPf9ugHFdFyqBtC58n/KTgkQ7anqd/Lzfazfb8ResQK7bijY9VfkD85a
         TDyrYI8TXcjA9eagHoSknO1YCrCwm6Z50Szd6V6y9xUHAlWczDFNtHWm7PcYEIHF6HZ8
         SWsyKwU7SmjJ8wzUcQ8F5qdASh82dI891Pj+XWnXU74ZtzXQQWHtHPPwcJLMIQQ/o4t+
         zkSJPF78srDjXKdZEP372EgYAxXJQ5g67NSamZ4aNHWYvkhYQ0qkPBRV2piFP5EwGUXt
         fULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730167739; x=1730772539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POAC9Eq7jdy/DJpHixlYJQgZCur0l0rG31IXlnXpLtM=;
        b=IEBTuGZmjtuvSEv9BSEt8sqOy3QqISf9HgTyLaC9VeV+CYTdmwewVsAKBKooXtnHN5
         r6sesuXI4CNZ1mhTRw2XtyFDVlKve+DVl7nbTn+spBaDBGoglA1PnCHUwrs8wRvxjWrB
         u8byKJZz7DIOilj3h24jzq08PjAgUcoQBz5ebQBF1asbx32C6kNsMDevIISZIeAnIHc7
         hi/HG3xGfvSbsw2O8L1/YkevCiOxbFHGQdi/wdo19teaTN0dnThGMRgUi+wCybLWzj7Z
         xTbJlQHTAghWsYsleyf48pDu3V9titSYvTqct3PaJLgye51FNut8IXIprH5sl9KRU/EH
         EMqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuuwowntkDWY7AnwfwVcee1KQNK/wsTk6lTsQ+Qw8lODcdbVMM4DSJmUN0PvhLv+s791x8YwvJjvw4@vger.kernel.org, AJvYcCXRCcClk2IzQeLkm1R1LfxAUjgjZY9GUOFlYl3HaocF2rZxr/2Kzfg2P97SXIIQuc79dEPkY8OMlvIQ6Htqdns=@vger.kernel.org, AJvYcCXtKzncY1SVNDHNWXw0L5WsZgWwd1c3KAx5QjhS1D9Hkc//3XRgkQdFHdxykTW5Rq4AysCz70k1uaiz+7O8@vger.kernel.org
X-Gm-Message-State: AOJu0YzKnP+rUqRHJlALKuZh5kwb87+l4wABSjKbLnmIsZACsp5uIAdA
	IclXVq1WisjcxOZKY8W6grbPNiIStSFKJ6x3npkmrFWb1GicOC8r5LxglFJtuhNBP8uO5J7QYaJ
	Fa1UfDYS20Qe0262LWunzHJSt0S8=
X-Google-Smtp-Source: AGHT+IH3AL1fkYF6LSyP8vCdNdSLgOV4hnxcwTXlF52COLGQOKSPrf1hHMCfLjfbbEolB8g5RoeGTXXIJbBX5v0jH9s=
X-Received: by 2002:a05:690c:4b93:b0:6e3:2630:2a0c with SMTP id
 00721157ae682-6e9d8a6ffe0mr111101187b3.26.1730167738560; Mon, 28 Oct 2024
 19:08:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org>
 <20241025-rust-platform-dev-v1-2-0df8dcf7c20b@kernel.org> <CAFRnB2WPEQaa6X6LqMk+JTxprguakNqFXvjaUGQ0QazxKH=z4Q@mail.gmail.com>
 <CAL_Jsq+nqFgK4D6ua+Kx8SiqCZFYaD-nse7vjPLqOLvP0hfo7A@mail.gmail.com>
In-Reply-To: <CAL_Jsq+nqFgK4D6ua+Kx8SiqCZFYaD-nse7vjPLqOLvP0hfo7A@mail.gmail.com>
From: Alex Gaynor <alex.gaynor@gmail.com>
Date: Mon, 28 Oct 2024 22:08:46 -0400
Message-ID: <CAFRnB2XO4hS7RTeNCzxXc4cSNF-XGsUy4yZuYWjKJ1MSvd0gHw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] rust: Add bindings for device properties
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Dirk Behme <dirk.behme@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 6:24=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Fri, Oct 25, 2024 at 4:12=E2=80=AFPM Alex Gaynor <alex.gaynor@gmail.co=
m> wrote:
> >
> > On Fri, Oct 25, 2024 at 5:06=E2=80=AFPM Rob Herring (Arm) <robh@kernel.=
org> wrote:
> > >
> > > The device property API is a firmware agnostic API for reading
> > > properties from firmware (DT/ACPI) devices nodes and swnodes.
> > >
> > > While the C API takes a pointer to a caller allocated variable/buffer=
,
> > > the rust API is designed to return a value and can be used in struct
> > > initialization. Rust generics are also utilized to support different
> > > sizes of properties (e.g. u8, u16, u32).
> > >
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > ---
> > > Not sure if we need the KVec variant, but I kept it as that was my fi=
rst
> > > pass attempt. Most callers are filling in some value in a driver data
> > > struct. Sometimes the number of elements is not known, so the caller
> > > calls to get the array size, allocs the correct size buffer, and then
> > > reads the property again to fill in the buffer.
> > >
> > > I have not implemented a wrapper for device_property_read_string(_arr=
ay)
> > > because that API is problematic for dynamic DT nodes. The API just
> > > returns pointer(s) into the raw DT data. We probably need to return a
> > > copy of the string(s) instead for rust.
> > >
> > > After property accessors, next up is child node accessors/iterators.
> > > ---
> > >  rust/bindings/bindings_helper.h |   1 +
> > >  rust/kernel/device.rs           | 145 ++++++++++++++++++++++++++++++=
+++++++++-
> > >  2 files changed, 145 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings=
_helper.h
> > > index 217c776615b9..65717cc20a23 100644
> > > --- a/rust/bindings/bindings_helper.h
> > > +++ b/rust/bindings/bindings_helper.h
> > > @@ -19,6 +19,7 @@
> > >  #include <linux/pci.h>
> > >  #include <linux/phy.h>
> > >  #include <linux/platform_device.h>
> > > +#include <linux/property.h>
> > >  #include <linux/refcount.h>
> > >  #include <linux/sched.h>
> > >  #include <linux/slab.h>
> > > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > > index 0c28b1e6b004..bb66a28df890 100644
> > > --- a/rust/kernel/device.rs
> > > +++ b/rust/kernel/device.rs
> > > @@ -5,10 +5,14 @@
> > >  //! C header: [`include/linux/device.h`](srctree/include/linux/devic=
e.h)
> > >
> > >  use crate::{
> > > +    alloc::KVec,
> > >      bindings,
> > > +    error::{to_result, Result},
> > > +    prelude::*,
> > > +    str::CStr,
> > >      types::{ARef, Opaque},
> > >  };
> > > -use core::{fmt, ptr};
> > > +use core::{fmt, mem::size_of, ptr};
> > >
> > >  #[cfg(CONFIG_PRINTK)]
> > >  use crate::c_str;
> > > @@ -189,6 +193,145 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt=
::Arguments<'_>) {
> > >              )
> > >          };
> > >      }
> > > +
> > > +    /// Returns if a firmware property `name` is true or false
> > > +    pub fn property_read_bool(&self, name: &CStr) -> bool {
> > > +        unsafe { bindings::device_property_present(self.as_raw(), na=
me.as_ptr() as *const i8) }
> > > +    }
> > > +
> > > +    /// Returns if a firmware string property `name` has match for `=
match_str`
> > > +    pub fn property_match_string(&self, name: &CStr, match_str: &CSt=
r) -> Result<usize> {
> > > +        let ret =3D unsafe {
> > > +            bindings::device_property_match_string(
> > > +                self.as_raw(),
> > > +                name.as_ptr() as *const i8,
> > > +                match_str.as_ptr() as *const i8,
> > > +            )
> > > +        };
> > > +        to_result(ret)?;
> > > +        Ok(ret as usize)
> > > +    }
> > > +
> > > +    /// Returns firmware property `name` scalar value
> > > +    ///
> > > +    /// Valid types are i8, u8, i16, u16, i32, u32, i64, u64
> > > +    pub fn property_read<T: Copy>(&self, name: &CStr) -> Result<T> {
> > > +        let mut val: [T; 1] =3D unsafe { core::mem::zeroed() };
> > > +
> > > +        Self::_property_read_array(&self, name, &mut val)?;
> > > +        Ok(val[0])
> > > +    }
> > > +
> >
> > This, and several of the other methods are unsound, because they can
> > be used to construct arbitrary types for which may not allow all bit
> > patterns. You can use:
> > https://rust.docs.kernel.org/kernel/types/trait.FromBytes.html as the
> > bound to ensure only valid types are used.
> >
> > Also, instead of using mem::zeroed(), you should use MaybeUnininit
> > (https://doc.rust-lang.org/stable/core/mem/union.MaybeUninit.html)
> > which allows you to avoid needing to zero initialize.
>
> Something like this what you had in mind?:
>
> pub fn property_read_array<T, const N: usize>(&self, name: &CStr) ->
> Result<[T; N]> {
>     let mut val: [MaybeUninit<T>; N] =3D [const { MaybeUninit::uninit() }=
; N];
>
>     Self::_property_read_array(self, name, &mut val)?;
>
>     // SAFETY: On success, _property_read_array has filled in the array
>     let val =3D unsafe { mem::transmute_copy(&val) };
>     Ok(val)
> }

Yes, that's right. Ideally you could use
https://doc.rust-lang.org/stable/core/mem/union.MaybeUninit.html#method.arr=
ay_assume_init
instead of transmute, but it's not yet stable.

Alex

--=20
All that is necessary for evil to succeed is for good people to do nothing.

