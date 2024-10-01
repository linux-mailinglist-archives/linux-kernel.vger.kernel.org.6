Return-Path: <linux-kernel+bounces-346402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AB998C455
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C433E284DB4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512A51CC143;
	Tue,  1 Oct 2024 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPe/yiHx"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D93C1C9DC8;
	Tue,  1 Oct 2024 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803163; cv=none; b=P87EX3pQD9//YuH9mw0nG7QRg6sY7o/RHLs7jhXqusS1sxKIKNAk+nFsYTe7+siKEJypkmhPw6SsWSAsL3LCJltFZYcOS0FxqN/kHeNwB+TlRqPMANOSYW4lPnN2wj7Cp8YPLbw2FD/pwB9ASP9XJN9PCyGwDcuqJFM3glm0FpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803163; c=relaxed/simple;
	bh=WckeSTc2GtkmmnNyx4H25Dpn+QPtXYWjwdtf+rFB9wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPOU/SQnbf740xxzA9eE3SVGumbqk41vaOOu4dUeH19V4XF4D43cv3ZS4HBzBH+q2d9u0/j62SQiLLDQI2OmIVZxOgGZxyWCHBRmZnEgD3SuP/MpxzKBJXo59j1E4NWbV4jxCzlVG9aqaZ/rTLr3BV9oyHFDffQ9i8O1eoYjl7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPe/yiHx; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-458362e898aso44761481cf.0;
        Tue, 01 Oct 2024 10:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727803161; x=1728407961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMphrXM1DWdmIj65+f7tgnWz1K746zVMMI5NZ5twmfg=;
        b=gPe/yiHxpqf8oA3VZYsUMVPCLCZZdAtwfp/bQyrNBogulaBoLBW3QcEM06ecnNcT+m
         FJ2HsSbLCbpl9uRBtM3dv2gSbsEfNN8hIQgKW7/5KPzYQwXQUbBVLQlPp3UuYMUkLs5i
         Vd5jAuTixGLYCrH05R+WE7bx3e+/5PFgnJRosaAL4ox1SgjVcQeQeXIJjBnqn8W5qW2Y
         9mxUN/AHQLB42kugX7zdi1vN3OBk1iJc4yiFU85AeKcRu78HS6eyc+mRcl3ZEdzJeQSL
         cYitsr6IBPppFhG8Y/ldCqFlGddK0qdhMmmHgj3yi/w3iM9oUa8BI2cH/2RIAayGe51f
         a9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727803161; x=1728407961;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMphrXM1DWdmIj65+f7tgnWz1K746zVMMI5NZ5twmfg=;
        b=a5Vn1kqNKd0WrrzxXnKk4FkxqqrOBFWvqdcH7qXxSK5qO0xzDS1BTChYKq6SBT0UzM
         MAgojm1wz80YAguihBf2rnaViW26xVu8aLrYX3Uues1kxMLCZxrBGzZ48nRNdbY1Gn9V
         ibaNHn1R1WhacfQTntMXXDCF+WxU+MVgRR8CufkDT+2F9M5K7B1lPZsLyAqrNQ2MWA40
         rkQbP+rJrsIY+o0Ow82rO/sOJA0EsPJiah8CtGosfUtR54uksOaRnK6JhEQHFx2GV4wV
         DlMbu6BNUKoxwOAmvU3GpwqLDS2QrtRK6RMVCDnsL+BGB94OvI8UtZullX8+517Z7b85
         RYFw==
X-Forwarded-Encrypted: i=1; AJvYcCW+02PKd2/BR3ovyIR80UIntocXY+TqUGFd84z/IT2LD2ngkd5OVe0VhTo64t3zuXcyt/YAuevFKshYTpo=@vger.kernel.org, AJvYcCWYbgf2FbWMukVcgh8nIpqiIJTwIJJQIzQY+4NPY/mgo6KoC8Y835zD5o/jfMNlgOy4Nv6bRNN1RzuXgtwa3YE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfajYdMVO4jpdtOjJgwX7UJ0HABN1H/o9g/8go8y9l+fn1BKmx
	dQlD8wIX8rUlLUk8m2K9sqlEE8EheCNUV5orAk5vk9XVWhuy4jQPazem6e1qa2paZurI0rhwWAl
	3vCudfESaSYVtvcoalvIfdHY3GxA=
X-Google-Smtp-Source: AGHT+IEwA7iCDMGpxdcWhylFrrvWKSnwcHs4I7WJXe7rD6KPbkkqNijTzdoYrhT6PQs/HOYnHyvq5gR7dcHpuHlV68g=
X-Received: by 2002:a05:622a:110a:b0:456:802c:a67f with SMTP id
 d75a77b69052e-45d8049a5d6mr4439241cf.3.1727803161008; Tue, 01 Oct 2024
 10:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001164355.104918-1-trintaeoitogc@gmail.com> <2024100150-panther-human-0a46@gregkh>
In-Reply-To: <2024100150-panther-human-0a46@gregkh>
From: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Date: Tue, 1 Oct 2024 14:18:45 -0300
Message-ID: <CAM_RzfY1-5LYi+G251FrtHRYOwMh52Z8y-a8o2WYRHnjc0tE-w@mail.gmail.com>
Subject: Re: [PATCH v2] rust: device: change the from_raw() function
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, aliceryhl@google.com, mcgrof@kernel.org, 
	russ.weight@linux.dev, dakr@redhat.com, a.hindborg@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Greg KH <gregkh@linuxfoundation.org> writes:
>
> On Tue, Oct 01, 2024 at 01:43:38PM -0300, Guilherme Giacomo Simoes wrote:
> > The function Device::from_raw() increments a refcount by a call to
> > bindings::get_device(ptr). This can be confused because usually
> > from_raw() functions don't increment a refcount.
> > Hence, rename Device::from_raw() to avoid confuion with other "from_raw"
> > semantics.
> >
> > The new name of function should be "get_device" to be consistent with
> > the function get_device() already exist in .c files.
> >
> > This function body also changed, because the `into()` will convert the
> > `&'a Device` into `ARef<Device>` and also call `inc_ref` from the
> > `AlwaysRefCounted` trait implemented for Device.
> >
> > Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
> > ---
> >  rust/kernel/device.rs   | 15 +++------------
> >  rust/kernel/firmware.rs |  2 +-
> >  2 files changed, 4 insertions(+), 13 deletions(-)
> >
> > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > index 851018eef885..c8199ee079ef 100644
> > --- a/rust/kernel/device.rs
> > +++ b/rust/kernel/device.rs
> > @@ -51,18 +51,9 @@ impl Device {
> >      ///
> >      /// It must also be ensured that `bindings::device::release` can be called from any thread.
> >      /// While not officially documented, this should be the case for any `struct device`.
> > -    pub unsafe fn from_raw(ptr: *mut bindings::device) -> ARef<Self> {
> > -        // SAFETY: By the safety requirements, ptr is valid.
> > -        // Initially increase the reference count by one to compensate for the final decrement once
> > -        // this newly created `ARef<Device>` instance is dropped.
> > -        unsafe { bindings::get_device(ptr) };
> > -
> > -        // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::device`.
> > -        let ptr = ptr.cast::<Self>();
> > -
> > -        // SAFETY: `ptr` is valid by the safety requirements of this function. By the above call to
> > -        // `bindings::get_device` we also own a reference to the underlying `struct device`.
> > -        unsafe { ARef::from_raw(ptr::NonNull::new_unchecked(ptr)) }
> > +    pub unsafe fn get_device(ptr: *mut bindings::device) -> ARef<Self> {
> > +        // SAFETY: By the safety requirements ptr is valid
> > +        unsafe { Self::as_ref(ptr) }.into()
> >      }
> >
> >      /// Obtain the raw `struct device *`.
> > diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> > index dee5b4b18aec..13a374a5cdb7 100644
> > --- a/rust/kernel/firmware.rs
> > +++ b/rust/kernel/firmware.rs
> > @@ -44,7 +44,7 @@ fn request_nowarn() -> Self {
> >  ///
> >  /// # fn no_run() -> Result<(), Error> {
> >  /// # // SAFETY: *NOT* safe, just for the example to get an `ARef<Device>` instance
> > -/// # let dev = unsafe { Device::from_raw(core::ptr::null_mut()) };
> > +/// # let dev = unsafe { Device::get_device(core::ptr::null_mut()) };
> >  ///
> >  /// let fw = Firmware::request(c_str!("path/to/firmware.bin"), &dev)?;
> >  /// let blob = fw.data();
> > --
> >
> > differences from v1:
> > - this version don't have 0/1 patch anymore.
> > - this version contains a refactor get_device() function
> >
> > The motivation from this change was will discussion in:
> > https://rust-for-linux.zulipchat.com/#narrow/stream/291566-Library/topic/Inconsistency.20of.20.60from_raw.60.2E
> >
> > I would like to thanks for Greg <gregkh@linuxfoundation.org>, Danilo
> > <dakr@kernel.org> and Alice <aliceryhl@google.com> for help me with this
> > patch.
>
> This information goes below the _first_ --- line, not down here at the
> bottom of the patch.  The documentation should explain all of this, you
> did read that, right?  :)
>
> v3 please?
>
> thanks,
>
> greg k-h

I only edited manually my last patch... I maked mistakes, sorry

