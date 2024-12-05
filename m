Return-Path: <linux-kernel+bounces-432897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1199E51AA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A628B16265D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB141D63F6;
	Thu,  5 Dec 2024 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GTkUBY6H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6241D5173;
	Thu,  5 Dec 2024 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733392061; cv=none; b=N08Hi2In+A4nVTlXdgM5JlskHZxUzWhT1lZrPCc6yrTHuysQG3IK9aypsJyqPJguR5voM2JtdY5HARDaL8p2Y1+iNLk1FHLveYrwOH00pULuv8+eWR8nmYaCm3D23ZzqtKOijzNkpTu7G5eYK2Y60IrB/j9DWSrnN/c6MPvFpf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733392061; c=relaxed/simple;
	bh=GYNvFk3PY77psIQGuKrMGsA4D+7kvXV/P4IV+wMPXk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XK0gClAD2OKbc9usYRW6/+Wm5D+/eKrEg8kWvpwxAfSnZMCgs2n3xiiIh6xDPZW5DgwuTobYkAhoFTTdhSLcS5sTXyVQZr6CgbDNSHlWoX5yAg6cDUp8QLvdJOcYmlSprjoJ6qTovEZ8caPy7WWcOwxCBX0sYvwpB2aQ2uw6m/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GTkUBY6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E04C4CED6;
	Thu,  5 Dec 2024 09:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733392057;
	bh=GYNvFk3PY77psIQGuKrMGsA4D+7kvXV/P4IV+wMPXk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GTkUBY6HAEZeuwNlxBB5w4lNe3HHVPxj1dENuZJPzLmbU+y+xy+Hmith3SwPYKACG
	 c5+XkpQZYMgME2EsdwHp2c/O50HfVFC7TGtu21pNKBN/UUeysk+4ig++IKBV6+5xQ2
	 gQo+IY6/uCYQVr7xRSaIj3Y0Axzd9rMN6IzhgcxA=
Date: Thu, 5 Dec 2024 10:47:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] sample: rust_misc_device: Demonstrate additional
 get/set value functionality
Message-ID: <2024120551-sternness-wilder-f417@gregkh>
References: <20241204174627.1151288-1-lee@kernel.org>
 <20241204174627.1151288-2-lee@kernel.org>
 <2024120453-unfunded-oversight-5161@gregkh>
 <20241205083848.GD7451@google.com>
 <2024120517-bright-expire-955e@gregkh>
 <20241205092706.GG7451@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205092706.GG7451@google.com>

On Thu, Dec 05, 2024 at 09:27:06AM +0000, Lee Jones wrote:
> On Thu, 05 Dec 2024, Greg KH wrote:
> 
> > On Thu, Dec 05, 2024 at 08:38:48AM +0000, Lee Jones wrote:
> > > On Wed, 04 Dec 2024, Greg KH wrote:
> > > 
> > > > On Wed, Dec 04, 2024 at 05:46:25PM +0000, Lee Jones wrote:
> > > > > Expand the complexity of the sample driver by providing the ability to
> > > > > get and set an integer.  The value is protected by a mutex.
> > > > > 
> > > > > Here is a simple userspace program that fully exercises the sample
> > > > > driver's capabilities.
> > > > > 
> > > > > int main() {
> > > > >   int value, new_value;
> > > > >   int fd, ret;
> > > > > 
> > > > >   // Open the device file
> > > > >   printf("Opening /dev/rust-misc-device for reading and writing\n");
> > > > >   fd = open("/dev/rust-misc-device", O_RDWR);
> > > > >   if (fd < 0) {
> > > > >     perror("open");
> > > > >     return errno;
> > > > >   }
> > > > > 
> > > > >   // Make call into driver to say "hello"
> > > > >   printf("Calling Hello\n");
> > > > >   ret = ioctl(fd, RUST_MISC_DEV_HELLO, NULL);
> > > > >   if (ret < 0) {
> > > > >     perror("ioctl: Failed to call into Hello");
> > > > >     close(fd);
> > > > >     return errno;
> > > > >   }
> > > > > 
> > > > >   // Get initial value
> > > > >   printf("Fetching initial value\n");
> > > > >   ret = ioctl(fd, RUST_MISC_DEV_GET_VALUE, &value);
> > > > >   if (ret < 0) {
> > > > >     perror("ioctl: Failed to fetch the initial value");
> > > > >     close(fd);
> > > > >     return errno;
> > > > >   }
> > > > > 
> > > > >   value++;
> > > > > 
> > > > >   // Set value to something different
> > > > >   printf("Submitting new value (%d)\n", value);
> > > > >   ret = ioctl(fd, RUST_MISC_DEV_SET_VALUE, &value);
> > > > >   if (ret < 0) {
> > > > >     perror("ioctl: Failed to submit new value");
> > > > >     close(fd);
> > > > >     return errno;
> > > > >   }
> > > > > 
> > > > >   // Ensure new value was applied
> > > > >   printf("Fetching new value\n");
> > > > >   ret = ioctl(fd, RUST_MISC_DEV_GET_VALUE, &new_value);
> > > > >   if (ret < 0) {
> > > > >     perror("ioctl: Failed to fetch the new value");
> > > > >     close(fd);
> > > > >     return errno;
> > > > >   }
> > > > > 
> > > > >   if (value != new_value) {
> > > > >     printf("Failed: Committed and retrieved values are different (%d - %d)\n", value, new_value);
> > > > >     close(fd);
> > > > >     return -1;
> > > > >   }
> > > > > 
> > > > >   // Call the unsuccessful ioctl
> > > > >   printf("Attempting to call in to an non-existent IOCTL\n");
> > > > >   ret = ioctl(fd, RUST_MISC_DEV_FAIL, NULL);
> > > > >   if (ret < 0) {
> > > > >     perror("ioctl: Succeeded to fail - this was expected");
> > > > >   } else {
> > > > >     printf("ioctl: Failed to fail\n");
> > > > >     close(fd);
> > > > >     return -1;
> > > > >   }
> > > > > 
> > > > >   // Close the device file
> > > > >   printf("Closing /dev/rust-misc-device\n");
> > > > >   close(fd);
> > > > > 
> > > > >   printf("Success\n");
> > > > >   return 0;
> > > > > }
> > > > > 
> > > > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > > > ---
> > > > >  samples/rust/rust_misc_device.rs | 82 ++++++++++++++++++++++++--------
> > > > >  1 file changed, 62 insertions(+), 20 deletions(-)
> > > > > 
> > > > > diff --git a/samples/rust/rust_misc_device.rs b/samples/rust/rust_misc_device.rs
> > > > > index 5f1b69569ef7..9c041497d881 100644
> > > > > --- a/samples/rust/rust_misc_device.rs
> > > > > +++ b/samples/rust/rust_misc_device.rs
> > > > > @@ -2,13 +2,20 @@
> > > > >  
> > > > >  //! Rust misc device sample.
> > > > >  
> > > > > +use core::pin::Pin;
> > > > > +
> > > > >  use kernel::{
> > > > >      c_str,
> > > > > -    ioctl::_IO,
> > > > > +    ioctl::{_IO, _IOC_SIZE, _IOR, _IOW},
> > > > >      miscdevice::{MiscDevice, MiscDeviceOptions, MiscDeviceRegistration},
> > > > > +    new_mutex,
> > > > >      prelude::*,
> > > > > +    sync::Mutex,
> > > > > +    uaccess::{UserSlice, UserSliceReader, UserSliceWriter},
> > > > >  };
> > > > >  
> > > > > +const RUST_MISC_DEV_GET_VALUE: u32 = _IOR::<i32>('R' as u32, 7);
> > > > > +const RUST_MISC_DEV_SET_VALUE: u32 = _IOW::<i32>('R' as u32, 8);
> > > > 
> > > > Shouldn't this be 'W'?
> > > 
> > > No, I don't think so.
> > > 
> > > 'W' doesn't mean 'write'.  It's supposed to be a unique identifier:
> > > 
> > > 'W'   00-1F  linux/watchdog.h                                        conflict!
> > > 'W'   00-1F  linux/wanrouter.h                                       conflict! (pre 3.9)
> > > 'W'   00-3F  sound/asound.h                                          conflict!
> > > 'W'   40-5F  drivers/pci/switch/switchtec.c
> > > 'W'   60-61  linux/watch_queue.h
> > > 
> > > 'R' isn't registered for this either:
> > > 
> > > 'R'   00-1F  linux/random.h                                          conflict!
> > > 'R'   01     linux/rfkill.h                                          conflict!
> > > 'R'   20-2F  linux/trace_mmap.h
> > > 'R'   C0-DF  net/bluetooth/rfcomm.h
> > > 'R'   E0     uapi/linux/fsl_mc.h
> > > 
> > > ... but since this is just example code with no real purpose, I'm going
> > > to hold short of registering a unique identifier for it.
> > 
> > Ah, sorry, I missed that this is the ioctl "name".  As the ptrace people
> > will complain, why not use a new one?  Ick, ioctl-number.rst is way out
> > of date, but I guess we should carve out one for "sample drivers, do not
> > use in anything real" use cases like here.
> 
> I can carve one out for Samples.
> 
> > > > > +    fn get_value(&self, mut writer: UserSliceWriter) -> Result<isize> {
> > > > > +        let guard = self.inner.lock();
> > > > > +
> > > > > +        pr_info!("-> Copying data to userspace (value: {})\n", &guard.value);
> > > > > +
> > > > > +        writer.write::<i32>(&guard.value)?;
> > > > 
> > > > What happens if it fails, shouldn't your pr_info() happen after this?
> > > 
> > > If this fails, I need the line in the log to show where it failed.
> > 
> > pr_info() doesn't show file lines from what I remember has that changed?
> > 
> > But wait, this is a misc device, you should be using dev_info() and
> > friends here, no pr_*() stuff please.
> 
> Looks like no other Rust driver does this, so I would be the first.

Yes, because those macros just got added this release cycle :)

Also, moving the existing in-tree drivers to use these macros would be a
good idea.

> I need to figure out how to obtain Device data via these APIs.

You should have access to it from the misc device structure.

> Can I put it on the subsequent work priority list _before_ read/write?

It should be in patch 1 :)

> > > It says "copying" as in "attempting to copy", rather than "copied".
> > 
> > Fair enough, but if the copy fails, nothing gets printed out, right?
> 
> Not from the kernel, but userspace catches it without issue:
> 
>   ioctl: Failed to submit new value: Bad address
> 
> This does not appear to be common practice in kernel Rust.
> 
> The commonly used ? operator seems to just propagate.

Ok, nice!

automatic error handling is going to be one of the killer features here.

greg k-h

