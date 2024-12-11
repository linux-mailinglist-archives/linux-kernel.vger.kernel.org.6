Return-Path: <linux-kernel+bounces-441349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2BB9ECD23
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E41168053
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB3022C342;
	Wed, 11 Dec 2024 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wseuXqiS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DAA23FD06;
	Wed, 11 Dec 2024 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733923614; cv=none; b=Dwzd6NLYVO7pCvOjXFovuv7s+tL+rkE2X9DbQLMtBGOJ/Q50jBuNHYysBwoMk18k7rttEugq1zkvwb1CMPUv+DAm+CCJp0ksFWry9462ina1lV6pojeRN2UK26yjP6X6t8wc0rt5CpEEV+LcniODqjahO49Qw0zfMWR0Qobdwxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733923614; c=relaxed/simple;
	bh=sbT5XiICCaJErHxTy5wJDIbqGAdc4J9cPkwtd5/ew50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wvz6IXHvNun/PQaQCbuPjkZfOSole83hldzzBest126ynKqvGppX5EbdbPK1eoRywjGpRTOmqW6/cLKKV8dTUwYivghWK9LRZdfaDpX+UneWc4gm5F/sk0QaWFZgFxXfc1WjcdAYFsJShQqcHJMveh6fL7ivomAepI5N/gdbn4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wseuXqiS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B825C4CED2;
	Wed, 11 Dec 2024 13:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733923614;
	bh=sbT5XiICCaJErHxTy5wJDIbqGAdc4J9cPkwtd5/ew50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wseuXqiS6+zVJBnRLVzeXIztPDzwLeXQaIqGnhxC4jCasKP0nk2fNsl9xkzlCjq5n
	 MOLstikFmYWZjNOs2qkeHjo3wqL3uwda8qam/WnlwHSDWZnXVaT7QYiSFZGNORy+Dv
	 9ez3F7AfZwfwb/PqoHu/HzguMWTHerTtBAC+Gsaw=
Date: Wed, 11 Dec 2024 14:26:16 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guangbo Cui <2407018371@qq.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Add UIO (Userspace I/O) device rust abstraction
Message-ID: <2024121150-stretch-password-2179@gregkh>
References: <tencent_6FBA3773CF74B276166B63D292CB2E8D3D07@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_6FBA3773CF74B276166B63D292CB2E8D3D07@qq.com>

On Wed, Dec 11, 2024 at 08:43:36PM +0800, Guangbo Cui wrote:
> This patch implements the necessary Rust abstractions to implement
> UIO device in Rust.
> 
> I am preparing to refactor our company’s UIO driver in Rust, targeting
> both user space and kernel space. As the first step, I plan to focus on
> implementing the UIO device abstraction as foundational infrastructure and
> eager to explore potential improvements and suggestions from the
> community.

Very cool!  But can we also see this with a "real" UIO driver as well?
Heck, even a conversion of something "simple" like the uio_dfl.c or
uio_cif.c would be nice to see (you have to do this on top of the
platform or pci rust bindings, see the list for the most recent round of
them).  Seeing how this will be used is kind of key to ensure that we
know the bindings work properly.

Or better yet, submit your uio driver at the same time so that _you_
know the bindings work for you, I'll gladly take both of them at the
same time.

thanks,

greg k-h


> 
> Signed-off-by: Guangbo Cui <2407018371@qq.com>
> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/kernel/lib.rs              |   2 +
>  rust/kernel/uio.rs              | 420 ++++++++++++++++++++++++++++++++
>  3 files changed, 423 insertions(+)
>  create mode 100644 rust/kernel/uio.rs
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index e9fdceb568..0d9abe7853 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -31,6 +31,7 @@
>  #include <linux/security.h>
>  #include <linux/slab.h>
>  #include <linux/tracepoint.h>
> +#include <linux/uio_driver.h>
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
>  #include <trace/events/rust_sample.h>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 1b4b533b38..03f95edaab 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -79,6 +79,8 @@
>  pub mod transmute;
>  pub mod types;
>  pub mod uaccess;
> +#[cfg(CONFIG_UIO)]
> +pub mod uio;
>  pub mod workqueue;
>  
>  #[doc(hidden)]
> diff --git a/rust/kernel/uio.rs b/rust/kernel/uio.rs
> new file mode 100644
> index 0000000000..2c868d1c13
> --- /dev/null
> +++ b/rust/kernel/uio.rs
> @@ -0,0 +1,420 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Abstractions for the uio driver.
> +//!
> +//! C header: [`include/linux/uio_driver.h`](srctree/include/linux/uio_driver.h)
> +
> +use core::{marker::PhantomData, mem::MaybeUninit, slice};
> +
> +use crate::{
> +    device,
> +    error::{to_result, Result, VTABLE_DEFAULT_ERROR},
> +    ffi,
> +    mm::virt::VmAreaNew,
> +    prelude::*,
> +    types::{ARef, ForeignOwnable, Opaque},
> +};
> +
> +/// Maximum number of memory maps supported by UIO.
> +pub const MAX_UIO_MAPS: usize = bindings::MAX_UIO_MAPS as _;
> +
> +/// Options for configuring a UIO (Userspace I/O) device.
> +///
> +/// This struct provides the necessary configuration to register a UIO device,
> +/// including its name, version, interrupt settings, and memory maps.
> +pub struct UioDeviceOptions {
> +    /// device name
> +    pub name: &'static CStr,
> +    /// device version
> +    pub version: &'static CStr,
> +    /// interrupt
> +    pub irq: u32,
> +    /// uio memory maps
> +    pub mem: [UioDeviceMemOptions; MAX_UIO_MAPS],
> +}
> +
> +impl UioDeviceOptions {
> +    /// create a default uio device options
> +    pub const fn new(name: &'static CStr, version: &'static CStr) -> Self {
> +        Self {
> +            name,
> +            version,
> +            irq: irq::UIO_IRQ_NONE,
> +            mem: [const { UioDeviceMemOptions::new() }; MAX_UIO_MAPS],
> +        }
> +    }
> +
> +    /// Converts the `UioDeviceOptions` into a kernel-compatible `struct uio_info`.
> +    ///
> +    /// This method transforms the Rust representation of UIO device options into the
> +    /// kernel's `uio_info` structure. It also registers the relevant callbacks for
> +    /// device operations such as `open`, `release`, `mmap`, `handler`, and `irqcontrol`.
> +    pub fn into_raw_info<T: UioDevice>(self) -> bindings::uio_info {
> +        const fn maybe_fn<T: Copy>(check: bool, func: T) -> Option<T> {
> +            if check {
> +                Some(func)
> +            } else {
> +                None
> +            }
> +        }
> +
> +        // SAFETY: zero initialize, valid
> +        let mut result: bindings::uio_info = unsafe { MaybeUninit::zeroed().assume_init() };
> +        result.name = self.name.as_char_ptr();
> +        result.version = self.version.as_char_ptr();
> +        result.irq = self.irq as i32 as _;
> +
> +        // SAFETY: kernel `struct uio_mem` and `UioDeviceMemmap` has same memory layout
> +        result.mem.copy_from_slice(unsafe {
> +            slice::from_raw_parts(self.mem.as_ptr().cast(), MAX_UIO_MAPS)
> +        });
> +        result.open = Some(uio_open::<T>);
> +        result.release = Some(uio_release::<T>);
> +        result.mmap = maybe_fn(T::HAS_MMAP, uio_mmap::<T>);
> +        result.handler = maybe_fn(T::HAS_HANDLER, uio_handler::<T>);
> +        result.irqcontrol = maybe_fn(T::HAS_IRQCONTROL, uio_irqcontrol::<T>);
> +
> +        result
> +    }
> +}
> +
> +/// Options for configuring a UIO (Userspace I/O) device memory.
> +#[repr(transparent)]
> +pub struct UioDeviceMemOptions(bindings::uio_mem);
> +
> +impl UioDeviceMemOptions {
> +    /// Creates a new, zero-initialized `UioDeviceMemmap`.
> +    pub const fn new() -> Self {
> +        // SAFETY: `MaybeUninit::zeroed()` ensures the memory is initialized to zero,
> +        // which is a valid initial state for `uio_mem`.
> +        unsafe { MaybeUninit::zeroed().assume_init() }
> +    }
> +
> +    /// Sets the name of the memory region.
> +    ///
> +    /// This method assigns a name to the memory region, which can be used to
> +    /// identify it in user space.
> +    pub fn set_name(&mut self, name: &CStr) {
> +        self.0.name = name.as_char_ptr();
> +    }
> +
> +    /// Sets the address of the memory region.
> +    ///
> +    /// This method specifies the physical or virtual address of the memory region.
> +    pub fn set_addr(&mut self, addr: usize) {
> +        self.0.addr = addr as _;
> +    }
> +
> +    /// Sets the memory type for the region.
> +    ///
> +    /// The memory type determines how the memory region is mapped or accessed.
> +    pub fn set_type(&mut self, ty: MemType) {
> +        self.0.memtype = ty as _;
> +    }
> +
> +    /// Sets the size of the memory region.
> +    ///
> +    /// This method specifies the size of the memory region in bytes.
> +    pub fn set_size(&mut self, size: usize) {
> +        self.0.size = size as _;
> +    }
> +}
> +
> +/// uio registration
> +#[pin_data(PinnedDrop)]
> +pub struct Registration<T> {
> +    #[pin]
> +    uio_info: Opaque<bindings::uio_info>,
> +    _phantom: PhantomData<T>,
> +}
> +
> +// SAFETY: It is allowed to call `__uio_register_device` on a different thread from where you called
> +// `__uio_register_device`.
> +unsafe impl<T> Send for Registration<T> {}
> +// SAFETY: It is safe to call them in parallel.
> +unsafe impl<T> Sync for Registration<T> {}
> +
> +impl<T: UioDevice> Registration<T> {
> +    /// register an uio driver
> +    pub fn register<'a>(
> +        module: &'static ThisModule,
> +        dev: &'a device::Device,
> +        options: UioDeviceOptions,
> +    ) -> impl PinInit<Self, Error> + use<'a, T> {
> +        try_pin_init!(Self {
> +            uio_info <- Opaque::try_ffi_init(move |slot: *mut bindings::uio_info| {
> +                // SAFETY: The initializer can write to the provided `slot`.
> +                unsafe { slot.write(options.into_raw_info::<T>()) };
> +
> +                // SAFETY: We just wrote the uio device options to the slot. The uio device will
> +                // get unregistered before `slot` is deallocated because the memory is pinned and
> +                // the destructor of this type deallocates the memory.
> +                // INVARIANT: If this returns `Ok(())`, then the `slot` will contain a registered
> +                // uio device.
> +                to_result(unsafe {
> +                    bindings::__uio_register_device(module.as_ptr(), dev.as_raw(), slot)
> +                })
> +            }),
> +            _phantom: PhantomData,
> +        })
> +    }
> +
> +    /// get the uio driver info
> +    pub fn info(&self) -> &Info {
> +        // SAFETY: self.uio_info is valid.
> +        unsafe { &*self.uio_info.get().cast() }
> +    }
> +}
> +
> +#[pinned_drop]
> +impl<T> PinnedDrop for Registration<T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        // SAFETY: We know that the device is registered by the type invariants.
> +        unsafe {
> +            bindings::uio_unregister_device(self.uio_info.get());
> +        };
> +    }
> +}
> +
> +/// A trait representing a UIO (Userspace I/O) device.
> +///
> +/// This trait provides an interface for implementing UIO device behavior in Rust.
> +/// It defines methods for handling device lifecycle events (`open`, `release`) and
> +/// optional functionalities such as interrupt handling and memory mapping. Implementors
> +/// can customize these methods to suit the specific requirements of their device.
> +#[vtable]
> +pub trait UioDevice {
> +    /// The type of pointer used to wrap `Self`.
> +    type Ptr: ForeignOwnable + Send + Sync;
> +
> +    /// Called when the UIO device is opened.
> +    fn open(_info: &Info) -> Result<Self::Ptr>;
> +
> +    /// Called when the UIO device is released.
> +    fn release(device: Self::Ptr, _info: &Info) {
> +        drop(device);
> +    }
> +
> +    /// Called to control device interrupts.
> +    fn irqcontrol(
> +        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
> +        _info: &Info,
> +        _irq_on: i32,
> +    ) -> Result<()> {
> +        kernel::build_error(VTABLE_DEFAULT_ERROR)
> +    }
> +
> +    /// Called to handle an interrupt for the UIO device.
> +    fn handler(
> +        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
> +        _info: &Info,
> +        _irq: ffi::c_int,
> +    ) -> bindings::irqreturn_t {
> +        kernel::build_error(VTABLE_DEFAULT_ERROR)
> +    }
> +
> +    /// Called to handle memory mapping for the UIO device.
> +    fn mmap(
> +        _device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
> +        _info: &Info,
> +        _vma: &VmAreaNew,
> +    ) -> Result<()> {
> +        kernel::build_error(VTABLE_DEFAULT_ERROR)
> +    }
> +}
> +
> +/// # Safety
> +///
> +/// `info` must be a valid `struct uio_info` that is associated with `T`.
> +/// `inode` must be the inode for a file that is being released.
> +unsafe extern "C" fn uio_open<T: UioDevice>(
> +    info: *mut bindings::uio_info,
> +    _inode: *mut bindings::inode,
> +) -> ffi::c_int {
> +    // SAFETY: The caller provides a info that is valid.
> +    let ptr = match T::open(unsafe { Info::from_raw(info) }) {
> +        Ok(ptr) => ptr,
> +        Err(err) => return err.to_errno(),
> +    };
> +
> +    // SAFETY: The `T::open` implementation guarantees that the returned pointer is valid.
> +    // We safely store it in the `priv_` field of the `uio_info` structure.
> +    unsafe {
> +        (*info).priv_ = ptr.into_foreign().cast_mut();
> +    }
> +
> +    0
> +}
> +
> +/// # Safety
> +///
> +/// `info` must be a valid `struct uio_info` that is associated with `T`.
> +/// `inode` must be the inode for a file that is undergoing initialization.
> +unsafe extern "C" fn uio_release<T: UioDevice>(
> +    info: *mut bindings::uio_info,
> +    _inode: *mut bindings::inode,
> +) -> ffi::c_int {
> +    // SAFETY: The caller guarantees that `info` is a valid pointer to a `struct uio_info`.
> +    let private = unsafe { (*info).priv_ };
> +    // SAFETY: The `priv_` field is expected to point to a valid instance of the type managed
> +    // by `ForeignOwnable` for `T::Ptr`. The caller must ensure this invariant.
> +    let ptr = unsafe { <T::Ptr as ForeignOwnable>::from_foreign(private) };
> +    // SAFETY: The caller provides a info that is valid.
> +    let info = unsafe { Info::from_raw(info) };
> +
> +    T::release(ptr, info);
> +
> +    0
> +}
> +
> +/// # Safety
> +///
> +/// `info` must be a valid `struct uio_info` that is associated with `T`.
> +unsafe extern "C" fn uio_irqcontrol<T: UioDevice>(
> +    info: *mut bindings::uio_info,
> +    irq_on: ffi::c_int,
> +) -> ffi::c_int {
> +    // SAFETY: The caller guarantees that `info` is a valid pointer to a `struct uio_info`.
> +    let private = unsafe { (*info).priv_ };
> +    // SAFETY: The `priv_` field is expected to point to a valid instance of the type
> +    // managed by `ForeignOwnable` for `T::Ptr`. The caller must ensure this invariant.
> +    let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
> +    // SAFETY: The caller provides a info that is valid.
> +    let info = unsafe { Info::from_raw(info) };
> +
> +    match T::irqcontrol(device, info, irq_on as _) {
> +        Ok(()) => 0,
> +        Err(err) => err.to_errno(),
> +    }
> +}
> +
> +/// # Safety
> +///
> +/// `info` must be a valid `struct uio_info` that is associated with `T`.
> +unsafe extern "C" fn uio_handler<T: UioDevice>(
> +    irq: ffi::c_int,
> +    dev_info: *mut bindings::uio_info,
> +) -> bindings::irqreturn_t {
> +    // SAFETY: The caller guarantees that `info` is a valid pointer to a `struct uio_info`.
> +    let private = unsafe { (*dev_info).priv_ };
> +    // SAFETY: The `priv_` field is expected to point to a valid instance of the type
> +    // managed by `ForeignOwnable` for `T::Ptr`. The caller must ensure this invariant.
> +    let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
> +    // SAFETY: The caller provides a info that is valid.
> +    let info = unsafe { Info::from_raw(dev_info) };
> +
> +    T::handler(device, info, irq)
> +}
> +
> +/// # Safety
> +///
> +/// `info` must be a valid `struct uio_info` that is associated with `T`.
> +/// `vma` must be a vma that is currently being mmap'ed with this file.
> +unsafe extern "C" fn uio_mmap<T: UioDevice>(
> +    info: *mut bindings::uio_info,
> +    vma: *mut bindings::vm_area_struct,
> +) -> ffi::c_int {
> +    // SAFETY: The caller guarantees that `info` is a valid pointer to a `struct uio_info`.
> +    let private = unsafe { (*info).priv_ };
> +    // SAFETY: The `priv_` field is expected to point to a valid instance of the type
> +    // managed by `ForeignOwnable` for `T::Ptr`. The caller must ensure this invariant.
> +    let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
> +    // SAFETY: The caller provides a vma that is undergoing initial VMA setup.
> +    let area = unsafe { VmAreaNew::from_raw(vma) };
> +    // SAFETY: The caller provides a info that is valid.
> +    let info = unsafe { Info::from_raw(info) };
> +
> +    match T::mmap(device, info, area) {
> +        Ok(()) => 0,
> +        Err(err) => err.to_errno(),
> +    }
> +}
> +
> +/// Wrapper for the kernel's `struct uio_info`.
> +#[repr(transparent)]
> +pub struct Info {
> +    inner: Opaque<bindings::uio_info>,
> +}
> +
> +impl Info {
> +    /// Gets a raw pointer to the underlying `struct uio_info`.
> +    #[inline]
> +    pub fn as_raw(&self) -> *mut bindings::uio_info {
> +        self.inner.get()
> +    }
> +
> +    /// Creates a reference to `Info` from a raw pointer to `struct uio_info`.
> +    ///
> +    /// # Safety
> +    /// - Callers must ensure that `ptr` is valid for the duration of 'a
> +    /// - Callers must ensure that `ptr` point to a valid `struct uio_info`, which
> +    ///   initialize by `__uio_register_device`
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(ptr: *mut bindings::uio_info) -> &'a Self {
> +        // SAFETY: The caller ensures that the invariants are satisfied for the duration of 'a.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// Notifies the kernel that an event has occurred on the UIO device.
> +    pub fn notify(&self) {
> +        // SAFETY: Only from `Info::from_raw`, which guarantee that `inner` is valid.
> +        unsafe {
> +            bindings::uio_event_notify(self.inner.get());
> +        }
> +    }
> +
> +    /// Return `Device` associated with this `Info`
> +    pub fn get_device(&self) -> Device {
> +        // SAFETY: Only from `Info::from_raw`, which guarantee that `inner` is valid.
> +        let udev = unsafe { (*self.inner.get()).uio_dev };
> +        // SAFETY: `(*udev).dev` is a valid device.
> +        let dev = unsafe { device::Device::get_device(&mut (*udev).dev) };
> +        // SAFETY: `dev` is from `uio_device`.
> +        unsafe { Device::from_dev(dev) }
> +    }
> +}
> +
> +/// IRQ (Interrupt Request) types for UIO.
> +pub mod irq {
> +    /// A custom IRQ type defined by the driver.
> +    /// Used when the interrupt mechanism does not conform to standard types.
> +    pub const UIO_IRQ_CUSTOM: u32 = bindings::UIO_IRQ_CUSTOM as _;
> +    /// No interrupt is used. The driver does not signal the user-space application via IRQs.
> +    pub const UIO_IRQ_NONE: u32 = bindings::UIO_IRQ_NONE as _;
> +}
> +
> +/// Types of memory address mapping for UIO devices.
> +pub enum MemType {
> +    /// No memory is mapped.
> +    None = bindings::UIO_MEM_NONE as _,
> +    /// Physical memory address mapping.
> +    Physical = bindings::UIO_MEM_PHYS as _,
> +    /// Logical memory address mapping.
> +    Logical = bindings::UIO_MEM_LOGICAL as _,
> +    /// Virtual memory address mapping.
> +    Virtual = bindings::UIO_MEM_VIRTUAL as _,
> +    /// IO virtual address (IOVA) mapping.
> +    IoVirtual = bindings::UIO_MEM_IOVA as _,
> +}
> +
> +/// kernel's `struct uio_device`
> +#[derive(Clone)]
> +pub struct Device(ARef<device::Device>);
> +
> +impl Device {
> +    /// Convert a raw kernel device into a `Device`
> +    ///
> +    /// # Safety
> +    ///
> +    /// `dev` must be an `Aref<device::Device>` whose underlying `bindings::device` is a member of a
> +    /// `bindings::uio_device`.
> +    pub unsafe fn from_dev(dev: ARef<device::Device>) -> Self {
> +        Self(dev)
> +    }
> +}
> +
> +impl AsRef<device::Device> for Device {
> +    fn as_ref(&self) -> &device::Device {
> +        &self.0
> +    }
> +}
> -- 
> 2.34.1
> 

