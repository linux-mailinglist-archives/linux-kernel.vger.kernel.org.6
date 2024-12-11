Return-Path: <linux-kernel+bounces-441839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3EC9ED4C3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41EB81670F5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DF9207A18;
	Wed, 11 Dec 2024 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTbQMN57"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ED71FF1CD;
	Wed, 11 Dec 2024 18:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733942199; cv=none; b=Ng4RbpK245TcjJw9F7Yw8uJQlAsyx1rG8HQUZS15axMkAjzDQm3ki1QRiJegSr/qjKEiObbAlBhWxXEhhQSX6f7u/xbVCGEKk8pfZD5WgOv8Q+gtQ+iEJpgjujs10+vxzYVnCzN/O/mDgwGjEYACGktZjDmeraqnMwbd5ILaNTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733942199; c=relaxed/simple;
	bh=LuWmLcx5vq5WvlLXI5ObCsjhMC9aP3LnKptYLgR/QjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpAukjtZPUDqiM2/OU2xAX0IEmlatjM0OEZSy4iGBQkv+Qz/aRFiKvTa9EoS0fN6s609HaXq/o/ppS4KB7n/KjTFEWki9yP+8PhxxC9foYURDW5tHJmn5j9IIq8+3Jv8iHn/TpaURXZn2aGKh4y3iEHamzHhk9KkjMeU/wI6yHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTbQMN57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A908AC4CED4;
	Wed, 11 Dec 2024 18:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733942198;
	bh=LuWmLcx5vq5WvlLXI5ObCsjhMC9aP3LnKptYLgR/QjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UTbQMN57eM9jPLK5WxX/DenyV7BnYSaVUJM1OwuyKX/M59g2plJ3cftFpOkj2bx9c
	 y6NxnXQDwRa8Nmp7NvZQurr7QBfRGH/kbhLSUxP2MZcjQPIuQu7NvjvUoFh+mBPcZD
	 JNSiH5qtA3PkkhM2qQHNaKA6Pv7PABfpXPpXlxli7XBK75KokzCr0A+t4n+5o8TU59
	 IrrRAVCj/PLvRux0CL9o42bLd6QdtQZBy4k5ToLMOIxqZZrFMPGPT9lgULhGPTegWz
	 PRslDFKFU/M66B7sx335ocxZRHUVazNK3hdYQJ+giTW/aLY5qIjeDQBiI6LEtWs/kd
	 HSTwwp/pLdb4A==
Date: Wed, 11 Dec 2024 19:36:32 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rust: platform: add Io support
Message-ID: <Z1nbsNyOBvFTL1-6@pollux.localdomain>
References: <20241211-topic-panthor-rs-platform_io_support-v3-1-08ba707e5e3b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211-topic-panthor-rs-platform_io_support-v3-1-08ba707e5e3b@collabora.com>

On Wed, Dec 11, 2024 at 02:51:56PM -0300, Daniel Almeida wrote:
> Add support for iomem regions by providing a struct IoMem abstraction
> for the platform bus. This will request a memory region and remap it
> into a kernel virtual address using ioremap(). The underlying reads and
> writes are performed by struct Io, which can be derived from the IoRaw
> embedded in platform::IoMem.
> 
> This is the equivalent of pci::Bar for the platform bus.
> 
> Memory-mapped I/O devices are common, and this patch offers a way to
> program them in Rust, usually by reading and writing to their
> memory-mapped register set.
> 
> Both sized and unsized versions are exposed. Sized allocations use
> `ioremap_resource_sized` and specify their size at compile time. Reading
> and writing to IoMem is infallible in this case and no extra runtime
> checks are performed. Unsized allocations have to check the offset
> against the regions's max length at runtime and so return Result.
> 
> Lastly, like pci::Bar, platform::IoMem uses the Devres abstraction to
> revoke access to the region if the device is unbound or the underlying
> resource goes out of scope.
> 
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> ---
> The PCI/Platform abstractions are in-flight and can be found at:
> 
> https://lore.kernel.org/rust-for-linux/20241210224947.23804-1-dakr@kernel.org/
> ---
> Changes in v3:
> - Rebased on top of v5 for the PCI/Platform abstractions
> - platform_get_resource is now called only once when calling ioremap
> - Introduced a platform::Resource type, which is bound to the lifetime of the
>   platform Device 
> - Allow retrieving resources from the platform device either by index or
>   name
> - Make request_mem_region() optional
> - Use resource.name() in request_mem_region
> - Reword the example to remove an unaligned, out-of-bounds offset
> - Update the safety requirements of platform::IoMem
> 
> Changes in v2:
> - reworked the commit message
> - added missing request_mem_region call (Thanks Alice, Danilo)
> - IoMem::new() now takes the platform::Device, the resource number and
>   the name, instead of an address and a size (thanks, Danilo)
> - Added a new example for both sized and unsized versions of IoMem.
> - Compiled the examples using kunit.py (thanks for the tip, Alice!)
> - Removed instances of `foo as _`. All `as` casts now spell out the actual
>   type.
> - Now compiling with CLIPPY=1 (I realized I had forgotten, sorry)
> - Rebased on top of rust-next to check for any warnings given the new
>   unsafe lints.
> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/io.c               |  17 ++++
>  rust/kernel/platform.rs         | 209 +++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 226 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 43f5c381aab0e71051402188ee001aac087dbbca..dd272a8e940a72036b0bf0602e090b3ff9c6baf1 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -21,6 +21,7 @@
>  #include <linux/file.h>
>  #include <linux/firmware.h>
>  #include <linux/fs.h>
> +#include <linux/ioport.h>
>  #include <linux/jiffies.h>
>  #include <linux/jump_label.h>
>  #include <linux/mdio.h>
> diff --git a/rust/helpers/io.c b/rust/helpers/io.c
> index 1dde6374c0e24f87a73de7b9543bbea8082e22a7..776c71439998119d8c9d14652d070b71a902151f 100644
> --- a/rust/helpers/io.c
> +++ b/rust/helpers/io.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
>  #include <linux/io.h>
> +#include <linux/ioport.h>
>  
>  void __iomem *rust_helper_ioremap(phys_addr_t offset, size_t size)
>  {
> @@ -99,3 +100,19 @@ void rust_helper_writeq_relaxed(u64 value, volatile void __iomem *addr)
>  	writeq_relaxed(value, addr);
>  }
>  #endif
> +
> +resource_size_t rust_helper_resource_size(struct resource *res)
> +{
> +	return resource_size(res);
> +}
> +
> +struct resource *rust_helper_request_mem_region(resource_size_t start, resource_size_t n,
> +				    const char *name)
> +{
> +	return request_mem_region(start, n, name);
> +}
> +
> +void rust_helper_release_mem_region(resource_size_t start, resource_size_t n)
> +{
> +	release_mem_region(start, n);
> +}
> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> index a9b7e52591171309c4177bed830fdf2ecf16e518..8fd0a47f097c5822c4e6c40ef75b22c8c60db9c4 100644
> --- a/rust/kernel/platform.rs
> +++ b/rust/kernel/platform.rs
> @@ -4,9 +4,14 @@
>  //!
>  //! C header: [`include/linux/platform_device.h`](srctree/include/linux/platform_device.h)
>  
> +use core::{marker::PhantomData, ops::Deref, ptr::NonNull};
> +
>  use crate::{
> -    bindings, container_of, device, driver,
> +    bindings, container_of, device,
> +    devres::Devres,
> +    driver,
>      error::{to_result, Result},
> +    io::{Io, IoRaw},
>      of,
>      prelude::*,
>      str::CStr,
> @@ -184,6 +189,60 @@ fn as_raw(&self) -> *mut bindings::platform_device {
>          // embedded in `struct platform_device`.
>          unsafe { container_of!(self.0.as_raw(), bindings::platform_device, dev) }.cast_mut()
>      }
> +
> +    /// Maps a platform resource through ioremap() where the size is known at
> +    /// compile time.
> +    pub fn ioremap_resource_sized<const SIZE: usize>(
> +        &self,
> +        resource: &Resource<'_>,
> +        exclusive: bool,
> +    ) -> Result<Devres<IoMem<SIZE>>> {
> +        // SAFETY: We wrap the resulting `IoMem` in a `Devres`.
> +        let io = unsafe { IoMem::new(resource, exclusive) }?;
> +        let devres = Devres::new(self.as_ref(), io, GFP_KERNEL)?;
> +
> +        Ok(devres)
> +    }
> +
> +    /// Maps a platform resource through ioremap().
> +    pub fn ioremap_resource(
> +        &self,
> +        resource: &Resource<'_>,
> +        exclusive: bool,
> +    ) -> Result<Devres<IoMem>> {
> +        self.ioremap_resource_sized::<0>(resource, exclusive)
> +    }
> +
> +    /// Returns the resource at `index`, if any.
> +    pub fn resource(&self, index: u32) -> Option<Resource<'_>> {
> +        // SAFETY: `self.as_raw()` returns a valid pointer to a `struct platform_device`.
> +        let resource = unsafe {
> +            bindings::platform_get_resource(self.as_raw(), bindings::IORESOURCE_MEM, index)
> +        };
> +
> +        Some(Resource {
> +            inner: NonNull::new(resource)?,
> +            _phantom: PhantomData,
> +        })
> +    }
> +
> +    /// Returns the resource with a given `name`, if any.
> +    pub fn resource_by_name(&self, name: &CStr) -> Option<Resource<'_>> {
> +        // SAFETY: `self.as_raw()` returns a valid pointer to a `struct
> +        // platform_device` and `name` points to a valid C string.
> +        let resource = unsafe {
> +            bindings::platform_get_resource_byname(
> +                self.as_raw(),
> +                bindings::IORESOURCE_MEM,
> +                name.as_char_ptr(),
> +            )
> +        };
> +
> +        Some(Resource {
> +            inner: NonNull::new(resource)?,
> +            _phantom: PhantomData,
> +        })
> +    }
>  }
>  
>  impl AsRef<device::Device> for Device {
> @@ -191,3 +250,151 @@ fn as_ref(&self) -> &device::Device {
>          &self.0
>      }
>  }
> +
> +/// A resource associated to a given platform device.
> +///
> +/// # Invariants
> +///
> +/// `inner` is a valid pointer to a `struct resource` retrieved from a `struct
> +/// platform_device`.
> +pub struct Resource<'a> {
> +    inner: NonNull<bindings::resource>,
> +    _phantom: PhantomData<&'a bindings::resource>,
> +}
> +
> +impl<'a> Resource<'a> {
> +    /// Returns the size of the resource.
> +    pub fn size(&self) -> bindings::resource_size_t {
> +        // SAFETY: safe as per the invariants of `Resource`
> +        unsafe { bindings::resource_size(self.inner.as_ptr()) }
> +    }
> +
> +    /// Returns the start address of the resource.
> +    pub fn start(&self) -> u64 {
> +        let inner = self.inner.as_ptr();
> +        // SAFETY: safe as per the invariants of `Resource`
> +        unsafe { *inner }.start
> +    }
> +
> +    /// Returns the name of the resource.
> +    pub fn name(&self) -> &CStr {
> +        let inner = self.inner.as_ptr();
> +        // SAFETY: safe as per the invariants of `Resource`
> +        unsafe { CStr::from_char_ptr((*inner).name) }
> +    }
> +}
> +
> +/// A I/O-mapped memory region for platform devices.
> +///
> +/// See also [`kernel::pci::Bar`].
> +///
> +/// # Examples
> +///
> +/// ```no_run
> +/// # use kernel::{bindings, c_str, platform};
> +///
> +/// fn probe(pdev: &mut platform::Device, /* ... */) -> Result<()> {
> +///     let offset = 0; // Some offset.
> +///
> +///     // If the size is known at compile time, use `ioremap_resource_sized`.
> +///     // No runtime checks will apply when reading and writing.
> +///     let iomem = pdev.ioremap_resource_sized::<42>(0, None)?;

This doesn't seem to match the API introduced by this patch. I assume you forgot
to update the example code?

> +///
> +///     // Read and write a 32-bit value at `offset`. Calling `try_access()` on
> +///     // the `Devres` makes sure that the resource is still valid.
> +///     let data = iomem.try_access().ok_or(ENODEV)?.readl(offset);
> +///
> +///     iomem.try_access().ok_or(ENODEV)?.writel(data, offset);
> +///
> +///     // Unlike `ioremap_resource_sized`, here the size of the memory region
> +///     // is not known at compile time, so only the `try_read*` and `try_write*`
> +///     // family of functions are exposed, leading to runtime checks on every
> +///     // access.
> +///     let iomem = pdev.ioremap_resource(0, None)?;
> +///
> +///     let data = iomem.try_access().ok_or(ENODEV)?.try_readl(offset)?;
> +///
> +///     iomem.try_access().ok_or(ENODEV)?.try_writel(data, offset)?;
> +///
> +///     # Ok::<(), Error>(())
> +/// }
> +/// ```
> +///
> +pub struct IoMem<const SIZE: usize = 0> {
> +    io: IoRaw<SIZE>,
> +    res_start: u64,
> +    exclusive: bool,
> +}

I think both the `Resource` and `IoMem` implementation do not belong into
platform.rs. Neither of those depends on any platform bus structures. They're
only used by platform structures.

I think we should move this into files under rust/kernel/io/ and create separate
commits out of this one.

> +
> +impl<const SIZE: usize> IoMem<SIZE> {
> +    /// Creates a new `IoMem` instance.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `IoMem` does not outlive the device it is
> +    /// associated with, usually by wrapping the `IoMem` in a `Devres`.

More precisely, `Devres` revokes when the device is unbound from the matched
driver, i.e. the driver should not be able to control the device anymore. This
may be much earlier than when the device disappears.

> +    unsafe fn new(resource: &Resource<'_>, exclusive: bool) -> Result<Self> {
> +        let size = resource.size();
> +        if size == 0 {
> +            return Err(ENOMEM);
> +        }
> +
> +        let res_start = resource.start();
> +
> +        // SAFETY:
> +        // - `res_start` and `size` are read from a presumably valid `struct resource`.
> +        // - `size` is known not to be zero at this point.
> +        // - `resource.name()` returns a valid C string.
> +        let mem_region =
> +            unsafe { bindings::request_mem_region(res_start, size, resource.name().as_char_ptr()) };

This should only be called if exclusive == true, right?

Btw. what's the use-case for non-exclusive access? Shouldn't we rather support
partial exclusive mappings?

> +
> +        if mem_region.is_null() {
> +            return Err(EBUSY);
> +        }
> +
> +        // SAFETY:
> +        // - `res_start` and `size` are read from a presumably valid `struct resource`.
> +        // - `size` is known not to be zero at this point.
> +        let addr = unsafe { bindings::ioremap(res_start, size as usize) };
> +        if addr.is_null() {
> +            if exclusive {
> +                // SAFETY:
> +                // - `res_start` and `size` are read from a presumably valid `struct resource`.
> +                // - `size` is the same as the one passed to `request_mem_region`.
> +                unsafe { bindings::release_mem_region(res_start, size) };
> +            }
> +            return Err(ENOMEM);
> +        }
> +
> +        let io = IoRaw::new(addr as usize, size as usize)?;
> +
> +        Ok(IoMem {
> +            io,
> +            res_start,
> +            exclusive,
> +        })
> +    }
> +}
> +
> +impl<const SIZE: usize> Drop for IoMem<SIZE> {
> +    fn drop(&mut self) {
> +        if self.exclusive {
> +            // SAFETY: `res_start` and `io.maxsize()` were the values passed to
> +            // `request_mem_region`.
> +            unsafe { bindings::release_mem_region(self.res_start, self.io.maxsize() as u64) }
> +        }
> +
> +        // SAFETY: Safe as by the invariant of `Io`.
> +        unsafe { bindings::iounmap(self.io.addr() as *mut core::ffi::c_void) }
> +    }
> +}
> +
> +impl<const SIZE: usize> Deref for IoMem<SIZE> {
> +    type Target = Io<SIZE>;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: `addr` is guaranteed to be the start of a valid I/O mapped memory region of
> +        // size `maxsize` given the initialization in `Self::new`.

I think it'd be cleaner to have this as an invariant section in the
documentation of `IoMem` and then refer to that.

> +        unsafe { Io::from_raw(&self.io) }
> +    }
> +}
> 
> ---
> base-commit: 1a4ce3837e321b94db1ac4274160e449c462610b
> change-id: 20241211-topic-panthor-rs-platform_io_support-ae8ac7feca5d
> prerequisite-message-id: <20241210224947.23804-1-dakr@kernel.org>
> prerequisite-patch-id: 9721d6d91aaa327a64db90153ac973c39d328fcf
> prerequisite-patch-id: 678dbd0e4ef70c658ad7d6def3e1fad82ded9657
> prerequisite-patch-id: ea80287941ef43f59fa75a28e6798ff10c8e90c1
> prerequisite-patch-id: e922cfa34c5e15c904fd12a08de5a5897915dc96
> prerequisite-patch-id: cd9756c9586f394e5b39198497979aa1384ad2b8
> prerequisite-patch-id: 313083700e67eab809a6b673d1fd835a6bd18625
> prerequisite-patch-id: d0c7198d84ffa229221bbe06541136c97e8aae4e
> prerequisite-patch-id: 0c4e157879b92f366feca2e89b5719e0a9bfa36a
> prerequisite-patch-id: 515464a50ad216e2e9811043db8ca341262db288
> prerequisite-patch-id: c50da45a4d7e62930f78b854f9afc636120dc255
> prerequisite-patch-id: 5e32316afbfed41fe68cc096bf5a93201d0c65f9
> prerequisite-patch-id: 15b08041af5e8f50619e3098b01ac0c0c0357751
> prerequisite-patch-id: d680798b48f799b02f2a514675133911af7b4228
> prerequisite-patch-id: 833f8f6310401cec79343ad55376e2f00b5105da
> prerequisite-patch-id: c7825a4527d051ac9929fa8e8856ec454cc3f703
> prerequisite-patch-id: ea5c28331c595ad00929291b483c8848f3ff84cf
> 
> Best regards,
> -- 
> Daniel Almeida <daniel.almeida@collabora.com>
> 

