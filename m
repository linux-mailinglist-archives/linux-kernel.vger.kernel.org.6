Return-Path: <linux-kernel+bounces-385053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D53A9B31CE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291212847E5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AD41DBB2C;
	Mon, 28 Oct 2024 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E244CvMN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1E0191F82;
	Mon, 28 Oct 2024 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122631; cv=none; b=dnQsyk1UaX9wmVBhYiv7JZdJ+xHtg22v/M+H6+5w583S3wHJ6pygfOY6id/rNhIStdVaAE+ioEdL0kqFUM1MgKk2QUeaUqcObjOy+b8z03rdFfnfc564O5vUQJ0Dw+2/bANPdiB3qkjsVhA8uPbDVSL+rVMxe9Y7FYVX8Z06BsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122631; c=relaxed/simple;
	bh=aHES0ByIrFPPx+zTxjezPtrFGuM9d9BX9c2dVH0/IAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkFprT22v5KOJi68hr077yv270l/DeKaLodpJMEDxkJWK/Q/s38IchVeGUNno23n+465xYgH5QwqBAJHiuFUhgjC8/uzYwKvSifW5A97u1qUEU6Ifx88T5MxkTZc+GYAMQk07FMjcLeEvuFG7++HKP5dOd1bwzzYurG+pZVWyEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E244CvMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F06C4CEC3;
	Mon, 28 Oct 2024 13:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730122631;
	bh=aHES0ByIrFPPx+zTxjezPtrFGuM9d9BX9c2dVH0/IAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E244CvMNjpxFFkEcJHnV2nu520yuB6IKfxcs1t5UMYbzWYJrZMZkjmr6jI8QHM1yr
	 zOc9JxV+lnaq+IDJM+m08Em0n4vqDtPZ0AhogP/2s8pHVWKk2xu5faBFiE+guOcW29
	 EVInUdPHYaRIimP+ezj4GK84w0OqbdApIhwz49el4I8gxOQWCrKLySu00Aat2pTq2t
	 IzCceeZuEI+c/8ze05c5bKrSJdczBwdSpF9HpfqPjp1mDI9D+/ndea7zMtojs484vb
	 zMBZeoPgbSxY2A/1SyyiCePxMi9Fm0tMwBFNbzfX7+5bbtDpVMD2t77vwD6sms9hVS
	 3lNO1EZcAERhg==
Date: Mon, 28 Oct 2024 14:37:06 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	rust-for-linux@vger.kernel.org, aliceryhl@google.com,
	dakr@redhat.com, linux-kernel@vger.kernel.org, airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH v2 5/5] rust: firmware: implement `Ownable` for Firmware
Message-ID: <Zx-Tgm9CJO-Myrgv@pollux>
References: <20241022224832.1505432-1-abdiel.janulgue@gmail.com>
 <20241022224832.1505432-6-abdiel.janulgue@gmail.com>
 <ZxjDUxUiKfE_7tvq@pollux>
 <Zx68k94GrHb3Kz3-@Boquns-Mac-mini.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zx68k94GrHb3Kz3-@Boquns-Mac-mini.local>

On Sun, Oct 27, 2024 at 03:20:03PM -0700, Boqun Feng wrote:
> On Wed, Oct 23, 2024 at 11:35:15AM +0200, Danilo Krummrich wrote:
> > On Wed, Oct 23, 2024 at 01:44:49AM +0300, Abdiel Janulgue wrote:
> > > For consistency, wrap the firmware as an `Owned` smart pointer in the
> > > constructor.
> > > 
> > > Cc: Danilo Krummrich <dakr@redhat.com>
> > > Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> > > Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> > > ---
> > >  rust/kernel/firmware.rs | 31 ++++++++++++++++++-------------
> > >  1 file changed, 18 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> > > index dee5b4b18aec..6da834b37455 100644
> > > --- a/rust/kernel/firmware.rs
> > > +++ b/rust/kernel/firmware.rs
> > > @@ -4,8 +4,8 @@
> > >  //!
> > >  //! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h)
> > >  
> > > -use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
> > > -use core::ptr::NonNull;
> > > +use crate::{bindings, device::Device, error::Error, error::Result, str::CStr,
> > > +            types::{Opaque, Owned, Ownable}};
> > >  
> > >  /// # Invariants
> > >  ///
> > > @@ -52,10 +52,11 @@ fn request_nowarn() -> Self {
> > >  /// # Ok(())
> > >  /// # }
> > >  /// ```
> > > -pub struct Firmware(NonNull<bindings::firmware>);
> > > + #[repr(transparent)]
> > > +pub struct Firmware(Opaque<bindings::firmware>);
> > >  
> > >  impl Firmware {
> > > -    fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
> > > +    fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Owned<Self>> {
> > 
> > I think it's fine to implement this for consistency, but I'm not sure I like
> > that drivers have to refer to it as `Owned<Firmware>`.
> > 
> 
> May I ask why not? ;-)

I think it's because with this an instance of `Firmware` is never a valid thing
to have, which is a bit weird at a first glance.

But I fully agree with the existance of the `Owned` type and the rationale
below.

> 
> Ideally, we should not wrap a pointer to particular type, instead we
> should wrap the type and then combine it with a meaningful pointer type,
> e.g. Box<>, ARef<>, Owned<> ... in this way, we de-couple how the
> lifetime of object is maintained (described by the pointer type) and
> what operations are available on the object (described by the wrapper
> type).
> 
> If later on, a firmware object creation is doable in pure Rust code for
> some condition, we can then have a function that returns a
> `KBox<Firmware>` (assume using kmalloc for the object), and it will just
> work (tm).
> 
> Regards,
> Boqun
> 
> > Anyway, if we keep it this way the patch also needs the following change.
> > 
> > diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> > index 6da834b37455..1db854eb2422 100644
> > --- a/rust/kernel/firmware.rs
> > +++ b/rust/kernel/firmware.rs
> > @@ -115,8 +115,8 @@ unsafe fn ptr_drop(ptr: *mut Self) {
> > 
> >  // SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, which is safe to be used from
> >  // any thread.
> > -unsafe impl Send for Firmware {}
> > +unsafe impl Send for Owned<Firmware> {}
> > 
> >  // SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, references to which are safe to
> >  // be used from any thread.
> > -unsafe impl Sync for Firmware {}
> > +unsafe impl Sync for Owned<Firmware> {}
> > 
> > >          let mut fw: *mut bindings::firmware = core::ptr::null_mut();
> > >          let pfw: *mut *mut bindings::firmware = &mut fw;
> > >  
> > > @@ -65,25 +66,26 @@ fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
> > >          if ret != 0 {
> > >              return Err(Error::from_errno(ret));
> > >          }
> > > -
> > > +        // CAST: Self` is a `repr(transparent)` wrapper around `bindings::firmware`.
> > > +        let ptr = fw.cast::<Self>();
> > >          // SAFETY: `func` not bailing out with a non-zero error code, guarantees that `fw` is a
> > >          // valid pointer to `bindings::firmware`.
> > > -        Ok(Firmware(unsafe { NonNull::new_unchecked(fw) }))
> > > +        Ok(unsafe { Owned::to_owned(ptr) })
> > >      }
> > >  
> > >      /// Send a firmware request and wait for it. See also `bindings::request_firmware`.
> > > -    pub fn request(name: &CStr, dev: &Device) -> Result<Self> {
> > > +    pub fn request(name: &CStr, dev: &Device) -> Result<Owned<Self>> {
> > >          Self::request_internal(name, dev, FwFunc::request())
> > >      }
> > >  
> > >      /// Send a request for an optional firmware module. See also
> > >      /// `bindings::firmware_request_nowarn`.
> > > -    pub fn request_nowarn(name: &CStr, dev: &Device) -> Result<Self> {
> > > +    pub fn request_nowarn(name: &CStr, dev: &Device) -> Result<Owned<Self>> {
> > >          Self::request_internal(name, dev, FwFunc::request_nowarn())
> > >      }
> > >  
> > >      fn as_raw(&self) -> *mut bindings::firmware {
> > > -        self.0.as_ptr()
> > > +        self.0.get()
> > >      }
> > >  
> > >      /// Returns the size of the requested firmware in bytes.
> > > @@ -101,10 +103,13 @@ pub fn data(&self) -> &[u8] {
> > >      }
> > >  }
> > >  
> > > -impl Drop for Firmware {
> > > -    fn drop(&mut self) {
> > > -        // SAFETY: `self.as_raw()` is valid by the type invariant.
> > > -        unsafe { bindings::release_firmware(self.as_raw()) };
> > > +unsafe impl Ownable for Firmware {
> > > +    unsafe fn ptr_drop(ptr: *mut Self) {
> > > +        // SAFETY:
> > > +        // - By the type invariants, we have ownership of the ptr and can free it.
> > > +        // - Per function safety, this is called in Owned::drop(), so `ptr` is a
> > > +        //   unique pointer to object, it's safe to release the firmware.
> > > +        unsafe { bindings::release_firmware(ptr.cast()) };
> > >      }
> > >  }
> > >  
> > > -- 
> > > 2.43.0
> > > 
> > 
> 

