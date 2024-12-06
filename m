Return-Path: <linux-kernel+bounces-434574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7DA9E6879
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49129285307
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7C41DE891;
	Fri,  6 Dec 2024 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fK9nif6s"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62521DDA1B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 08:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733472661; cv=none; b=ZTbIn7xhKWmqBFSIb15mDVZ2VBQaiW+jcr8HL7VoIC3Sd3Xzaaexqv3nvJFRgq3WFX++iTc9pitdtOMQGSmTKyMK65C/e2VjQVi2TxDvTIMmuSTPJI6u0PFa1QlC+dQPSEuhzFbjgnVMAWGb4ZjtRGxCeAZFjB4TLqnCzLN1XCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733472661; c=relaxed/simple;
	bh=lmFGJd2Xqrs/MH4+do/m1chTI6RYr3jn0im/pd2cJUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abrtOwZAj/EZ7opilxxmPYgwqGpRSDQnADvSFffqlNP9RabvRf0eY7Lu3HNi3WPgWRL+rzaCoSEEzOOUQzrravfAEon+9DMusdSyNH8E8a7Jb2AKyigvPbU9I6nlab8f1+2AXA6bud4Cbw9Ecl1V+j0ReYN3gb2EAekG0b5mvf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fK9nif6s; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso875780f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 00:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733472658; x=1734077458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aad+99YqFvgU4m6vSdZibZAV4sqIGKiKMjv1PgKDzmE=;
        b=fK9nif6sPNMYOIgSvyBqYikLXKSbXs+ofeRdZYaeOvjWlmxYV0WfuSHYq/EEyPLMf+
         OwzmieXD88DmD9eLkwdAF5fHY71p40RAyDfXXMz3B0gqO2zpwM7IKsiuMOjB3JO6phjO
         YnEt2F8TeUsfmoNxMSicNcqJDcMrr//rjkW+vrIm74jXk3CZwPpikMiJR4RMWnZTjnF/
         /zAAq89z3eGt8njvycplhbZon3ilfR+aL6P5f5GhGrnTmAaZu7JPZJ5E4BtW7AB4w0oe
         rFsiBaW/+nhuARz8sr1EbYNpC8B/0UTZbBmC7UjtP3ZQ0bgCQT/NYwe6FsI7/R3PxHgr
         57yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733472658; x=1734077458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aad+99YqFvgU4m6vSdZibZAV4sqIGKiKMjv1PgKDzmE=;
        b=EXkNXFvFLJcm8nTo6xX0BJBkBPce+7HBS++gtJRwHTjII73lc+lvjHxv2+UbGWQnUp
         /P1gvWc8glwHO15Uq461It9T3+BlEfQqFcCfKDrjg5x3KNxEGxMamdUi9uSZV+WDqXmB
         bIAlbcbY74NVGmxI//Sro1q2GhaTGBpNCJJe7sTediP0psWvhbmITeBCe7yiqv0S085s
         BUPjTHhuKXV5aLJ5aeYptKDR8JlM0FgGlTDmw+OjgdqxMaNSSqyldhtSZtRXPghuAfWG
         1cG1NCR+x8AOp7PIejeRkvVAdq52UM89cTwzC/Cz0TbI6ax+yvJ15H0Z3FyKHq/YzjEP
         MvMw==
X-Forwarded-Encrypted: i=1; AJvYcCVp6jbW5UFVWknpKHiMlOFs1GNNrueyzlUTaMytfmpMNNALGMETHjgBzYY3m0szI5QuiOBOx6ZELWeF5VM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYWFjdfi0MdfpFsquFqiZlecX+JllMVr6U3PlqbZvv3u+ZlMbU
	d+kDj1uFu1p0mC6VKYgc5WCFZFvBLC2RgLmqfJMjBp090VzejnZTwd5bn5bFWM0odoHDbULDqL2
	C1zITtMy6thr5+1rQyDRp7x7yRo/K2tNyUeCw
X-Gm-Gg: ASbGncuaTPeYj7SMNO3KYuooN6F9+y9P+yCxG2Q9IFS0Q99tKUOtjkYu5qciWnaG5mi
	75HrjIcw37ybIDCtjkkrCQo3RiY4rmNhf
X-Google-Smtp-Source: AGHT+IHSUNmu0x5twQWzMYE07NjUUK5N7I4JbR57kNLF/pE+2Z4WmMcruwV6xNFlS3jP1u4t7TzGWvXJT/U4DtifFhY=
X-Received: by 2002:a05:6000:789:b0:385:fcfb:8d4f with SMTP id
 ffacd0b85a97d-3862b35fc5fmr1361458f8f.21.1733472657893; Fri, 06 Dec 2024
 00:10:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205162531.1883859-1-lee@kernel.org> <20241205162531.1883859-2-lee@kernel.org>
 <2024120648-finch-shrubbery-c6f5@gregkh> <20241206071646.GE8882@google.com>
 <20241206073309.GG8882@google.com> <2024120616-endanger-strangely-62b4@gregkh>
In-Reply-To: <2024120616-endanger-strangely-62b4@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 6 Dec 2024 09:10:45 +0100
Message-ID: <CAH5fLghxQ724+aZh4B0UJJ40ut7iS1grs2CAkH-wjWVmt0om7w@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] rust: miscdevice: Provide accessor to pull out miscdevice::this_device
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, arnd@arndb.de, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 8:46=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Fri, Dec 06, 2024 at 07:33:09AM +0000, Lee Jones wrote:
> > On Fri, 06 Dec 2024, Lee Jones wrote:
> >
> > > On Fri, 06 Dec 2024, Greg KH wrote:
> > >
> > > > On Thu, Dec 05, 2024 at 04:25:18PM +0000, Lee Jones wrote:
> > > > > There are situations where a pointer to a `struct device` will be=
come
> > > > > necessary (e.g. for calling into dev_*() functions).  This access=
or
> > > > > allows callers to pull this out from the `struct miscdevice`.
> > > > >
> > > > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > > > ---
> > > > >  rust/kernel/miscdevice.rs | 9 +++++++++
> > > > >  1 file changed, 9 insertions(+)
> > > > >
> > > > > diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.r=
s
> > > > > index 7e2a79b3ae26..55340f316006 100644
> > > > > --- a/rust/kernel/miscdevice.rs
> > > > > +++ b/rust/kernel/miscdevice.rs
> > > > > @@ -10,11 +10,13 @@
> > > > >
> > > > >  use crate::{
> > > > >      bindings,
> > > > > +    device::Device,
> > > > >      error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
> > > > >      prelude::*,
> > > > >      str::CStr,
> > > > >      types::{ForeignOwnable, Opaque},
> > > > >  };
> > > > > +
> > > > >  use core::{
> > > > >      ffi::{c_int, c_long, c_uint, c_ulong},
> > > > >      marker::PhantomData,
> > > > > @@ -84,6 +86,13 @@ pub fn register(opts: MiscDeviceOptions) -> im=
pl PinInit<Self, Error> {
> > > > >      pub fn as_raw(&self) -> *mut bindings::miscdevice {
> > > > >          self.inner.get()
> > > > >      }
> > > > > +
> > > > > +    /// Returns a pointer to the current Device
> > > > > +    pub fn device(&self) -> &Device {
> > > > > +        // SAFETY: This is only accessible after a successful re=
gister() which always
> > > > > +        // initialises this_device with a valid device.
> > > > > +        unsafe { Device::as_ref((*self.as_raw()).this_device) }
> > > >
> > > > A "raw" pointer that you can do something with without incrementing=
 the
> > > > reference count of it?  Oh wait, no, it's the rust device structure=
.
> > > > If so, why isn't this calling the get_device() interface instead?  =
That
> > > > way it's properly incremented and decremented when it "leaves the s=
cope"
> > > > right?
> > > >
> > > > Or am I missing something here as to why that wouldn't work and thi=
s is
> > > > the only way to get access to the 'struct device' of this miscdevic=
e?
> > >
> > > Fair point.  I'll speak to Alice.
> >
> > Alice isn't available yet, so I may be talking out of turn at this
> > point, but I just found this is the Device documentation:
> >
> >   /// A `Device` instance represents a valid `struct device` created by=
 the C portion of the kernel.
> >   ///
> >   /// Instances of this type are always reference-counted, that is, a c=
all to `get_device` ensures
> >   /// that the allocation remains valid at least until the matching cal=
l to `put_device`.
> >
> > And:
> >
> >   // SAFETY: Instances of `Device` are always reference-counted.
> >
> > Ready for some analysis from this beginner?
> >
> > Since this impl for Device is AlwaysRefCounted, when any references are
> > taken i.e. in the Device::as_ref line above, inc_ref() is implicitly
> > called to increase the refcount.  The same will be true of dec_ref()
> > once it goes out of scope.
> >
> >   // SAFETY: Instances of `Device` are always reference-counted.
> >   unsafe impl crate::types::AlwaysRefCounted for Device {
> >       fn inc_ref(&self) {
> >           // SAFETY: The existence of a shared reference guarantees tha=
t the refcount is non-zero.
> >           unsafe { bindings::get_device(self.as_raw()) };
> >       }
> >
> >       unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
> >           // SAFETY: The safety requirements guarantee that the refcoun=
t is non-zero.
> >           unsafe { bindings::put_device(obj.cast().as_ptr()) }
> >   }
>
> Ick, really?  So as_ref() implicitly calles inc_ref() and dec_ref()?
> Ah, ok, in digging into AlwaysRefCounted I now see that seems to be
> true.

It doesn't increment the refcount because it uses the reference type
&_ and not the ARef<_> pointer type. References enforce correctness
using the borrow-checker. For example, consider this attempt to UAF:

#[derive(Debug)]
struct Inner {}

struct Outer {
    inner: Inner,
}

impl Outer {
    fn as_ref(&self) -> &Inner {
        &self.inner
    }
}

fn main() {
    let inner;
    {
        let outer =3D Outer { inner: Inner {} };
        inner =3D outer.as_ref();
    }
    println!("{:?}", inner);
}

This fails to compile:

error[E0597]: `outer` does not live long enough
  --> src/main.rs:19:17
   |
18 |         let outer =3D Outer { inner: Inner {} };
   |             ----- binding `outer` declared here
19 |         inner =3D outer.as_ref();
   |                 ^^^^^ borrowed value does not live long enough
20 |     }
   |     - `outer` dropped here while still borrowed
21 |     println!("{:?}", inner);
   |                      ----- borrow later used here

The same logic applies to the device() accessor. That is, it ensures
that you can only use the pointer to access the `struct device` when
the `struct miscdevice` is still valid, which should be okay.

To grab a refcount, you need the ARef<_> pointer type. Callers can do

let device =3D ARef::from(miscdevice.device());

and now device is a value of type ARef<Device> which owns a refcount
and drops it when the destructor runs.

Alice

