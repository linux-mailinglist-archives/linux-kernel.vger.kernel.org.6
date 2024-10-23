Return-Path: <linux-kernel+bounces-377793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6109AC6E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E34AB20E72
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D45319D8BD;
	Wed, 23 Oct 2024 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dW4XRr1+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CA8156F3F;
	Wed, 23 Oct 2024 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676722; cv=none; b=gXYevBUWhQZlAIRc7uFBqXYS9j8qZ4YNJVE8OX+EukzwQim1Op7e89ALg2mzgYnI9a0vRPTR13jJ94LEVKSHcyHkYhNTfmkUMOuR7vKzmHQsQjMCoJW1CxKO5UGkjLiYXhcKX2FGO9rojOLlSlApKJBB7dEKjKHpRdyfztzBrPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676722; c=relaxed/simple;
	bh=ixHXVNpt6gqmo6X2Ag6xammcBB050Tnx5d2c+pVm2ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDBpGkOJRiNPJuMwlO+cPzNIXB4jVYa14tKW9oZ+xShk2320KCSLHQvqDW28Zc99vnvasiuKkO6hMgb9sN8w9vfJH5q3befAqyhh60DavQ1bMrcB4Oepv7YQqpARIMOvhSC7YGIsj3YIr+sUzg8vd7UM9IO64YdNqAEs2HqfMt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dW4XRr1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8DAC4CEC7;
	Wed, 23 Oct 2024 09:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729676722;
	bh=ixHXVNpt6gqmo6X2Ag6xammcBB050Tnx5d2c+pVm2ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dW4XRr1+PhX+c3R6w5K2rllKEyJlCwVmxHP4L9xpB2Ovy2r56ChLX7c+Ol4fQgKK3
	 h/2xzq/sssVOZbzvEdMjD4Qew8UDA90vcHBCfDhW0b1ZxFmtCSFi10/Xywzqie3KcF
	 h1ijXPqGEOtIzK/XXqX5+xJFF9+Hnof3EI1Ijh1uZltggMDqSONQbKZL7+hnx/ggft
	 naBqjUek3w97SxmxJ6G0nvIZoX5/Mdt6/w+dgMqgJlwtl2Q+rmxJ3BMfkeLKW70yfo
	 FgzTn9FsWHUWO+wcBRyAsxmbv+08/S1QgWngsoLZrIvHh6Hh7CM12IimfngvQUsEYo
	 pDCckCFnF7SEQ==
Date: Wed, 23 Oct 2024 11:45:17 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, aliceryhl@google.com, dakr@redhat.com,
	linux-kernel@vger.kernel.org, airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com, boqun.feng@gmail.com
Subject: Re: [PATCH v2 5/5] rust: firmware: implement `Ownable` for Firmware
Message-ID: <ZxjFrUDfOGvhk1sr@pollux>
References: <20241022224832.1505432-1-abdiel.janulgue@gmail.com>
 <20241022224832.1505432-6-abdiel.janulgue@gmail.com>
 <ZxjDUxUiKfE_7tvq@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxjDUxUiKfE_7tvq@pollux>

On Wed, Oct 23, 2024 at 11:35:20AM +0200, Danilo Krummrich wrote:
> On Wed, Oct 23, 2024 at 01:44:49AM +0300, Abdiel Janulgue wrote:
> > For consistency, wrap the firmware as an `Owned` smart pointer in the
> > constructor.
> > 
> > Cc: Danilo Krummrich <dakr@redhat.com>
> > Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> > ---
> >  rust/kernel/firmware.rs | 31 ++++++++++++++++++-------------
> >  1 file changed, 18 insertions(+), 13 deletions(-)
> > 
> > diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> > index dee5b4b18aec..6da834b37455 100644
> > --- a/rust/kernel/firmware.rs
> > +++ b/rust/kernel/firmware.rs
> > @@ -4,8 +4,8 @@
> >  //!
> >  //! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h)
> >  
> > -use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
> > -use core::ptr::NonNull;
> > +use crate::{bindings, device::Device, error::Error, error::Result, str::CStr,
> > +            types::{Opaque, Owned, Ownable}};
> >  
> >  /// # Invariants
> >  ///
> > @@ -52,10 +52,11 @@ fn request_nowarn() -> Self {
> >  /// # Ok(())
> >  /// # }
> >  /// ```
> > -pub struct Firmware(NonNull<bindings::firmware>);
> > + #[repr(transparent)]
> > +pub struct Firmware(Opaque<bindings::firmware>);
> >  
> >  impl Firmware {
> > -    fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
> > +    fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Owned<Self>> {
> 
> I think it's fine to implement this for consistency, but I'm not sure I like
> that drivers have to refer to it as `Owned<Firmware>`.
> 
> Anyway, if we keep it this way the patch also needs the following change.
> 
> diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> index 6da834b37455..1db854eb2422 100644
> --- a/rust/kernel/firmware.rs
> +++ b/rust/kernel/firmware.rs
> @@ -115,8 +115,8 @@ unsafe fn ptr_drop(ptr: *mut Self) {
> 
>  // SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, which is safe to be used from
>  // any thread.
> -unsafe impl Send for Firmware {}
> +unsafe impl Send for Owned<Firmware> {}
> 
>  // SAFETY: `Firmware` only holds a pointer to a C `struct firmware`, references to which are safe to
>  // be used from any thread.
> -unsafe impl Sync for Firmware {}
> +unsafe impl Sync for Owned<Firmware> {}

Actually, I think `Owned` should implement `Send` and `Sync` like this instead.

   unsafe impl<T> Sync for Owned<T> where T: Sync + Ownable {}
   unsafe impl<T> Send for Owned<T> where T: Send + Ownable {}

> 
> >          let mut fw: *mut bindings::firmware = core::ptr::null_mut();
> >          let pfw: *mut *mut bindings::firmware = &mut fw;
> >  
> > @@ -65,25 +66,26 @@ fn request_internal(name: &CStr, dev: &Device, func: FwFunc) -> Result<Self> {
> >          if ret != 0 {
> >              return Err(Error::from_errno(ret));
> >          }
> > -
> > +        // CAST: Self` is a `repr(transparent)` wrapper around `bindings::firmware`.
> > +        let ptr = fw.cast::<Self>();
> >          // SAFETY: `func` not bailing out with a non-zero error code, guarantees that `fw` is a
> >          // valid pointer to `bindings::firmware`.
> > -        Ok(Firmware(unsafe { NonNull::new_unchecked(fw) }))
> > +        Ok(unsafe { Owned::to_owned(ptr) })
> >      }
> >  
> >      /// Send a firmware request and wait for it. See also `bindings::request_firmware`.
> > -    pub fn request(name: &CStr, dev: &Device) -> Result<Self> {
> > +    pub fn request(name: &CStr, dev: &Device) -> Result<Owned<Self>> {
> >          Self::request_internal(name, dev, FwFunc::request())
> >      }
> >  
> >      /// Send a request for an optional firmware module. See also
> >      /// `bindings::firmware_request_nowarn`.
> > -    pub fn request_nowarn(name: &CStr, dev: &Device) -> Result<Self> {
> > +    pub fn request_nowarn(name: &CStr, dev: &Device) -> Result<Owned<Self>> {
> >          Self::request_internal(name, dev, FwFunc::request_nowarn())
> >      }
> >  
> >      fn as_raw(&self) -> *mut bindings::firmware {
> > -        self.0.as_ptr()
> > +        self.0.get()
> >      }
> >  
> >      /// Returns the size of the requested firmware in bytes.
> > @@ -101,10 +103,13 @@ pub fn data(&self) -> &[u8] {
> >      }
> >  }
> >  
> > -impl Drop for Firmware {
> > -    fn drop(&mut self) {
> > -        // SAFETY: `self.as_raw()` is valid by the type invariant.
> > -        unsafe { bindings::release_firmware(self.as_raw()) };
> > +unsafe impl Ownable for Firmware {
> > +    unsafe fn ptr_drop(ptr: *mut Self) {
> > +        // SAFETY:
> > +        // - By the type invariants, we have ownership of the ptr and can free it.
> > +        // - Per function safety, this is called in Owned::drop(), so `ptr` is a
> > +        //   unique pointer to object, it's safe to release the firmware.
> > +        unsafe { bindings::release_firmware(ptr.cast()) };
> >      }
> >  }
> >  
> > -- 
> > 2.43.0
> > 

