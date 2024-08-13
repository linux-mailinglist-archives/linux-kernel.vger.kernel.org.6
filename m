Return-Path: <linux-kernel+bounces-284787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E2895051F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4268AB292A3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E36E19CD05;
	Tue, 13 Aug 2024 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTGVZdeT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DAA186E33;
	Tue, 13 Aug 2024 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552460; cv=none; b=SgF9XmHz8kI7/Ge3+CG2jKZoxWlEGxCvDcnRu2yBPmjWBGQ2B8/fEVj0gCvpXwQVXcx83TZFWQb/k+W3xtjSmBs5cuLBy50JzG/BQANMaPVVHfvDAsZZ9/pyu9wtCvLYhRzfV5RMi9f1W9ScMvYqSo/jtcw6CPiDNqwMj7s0uV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552460; c=relaxed/simple;
	bh=bW0pd426CfLUr0gi+Md4bSFtw6NDJFfo3qyLIOLPANA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJw3yMAoV3q0t8F3kCQWCdn3DPze3mcAODEKbIe4RQgu4Pr82MvGv9vcHrzxT3K2t5JuOf38q0UvXvHFajMYECBm1KokRbR/fxFLBiAJdbhJXONdisdOHQMPaw7ht38IT1c177JsxB+MsMo1ur4PIqfbsrdqXSyMaxfAplIFDzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTGVZdeT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3248C4AF09;
	Tue, 13 Aug 2024 12:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723552459;
	bh=bW0pd426CfLUr0gi+Md4bSFtw6NDJFfo3qyLIOLPANA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JTGVZdeT5cNJ+af6GmRV2AXhB2H9XutFlGPOCxHJytWGs+RH7Li8s2BHhpU6zUrQE
	 PtMnCkSYVEONS9ZWQRbRqD4frk0zOMQtORoXiPhKLnlBGIAtexPUbGmr3Hb3iI1U+Q
	 ri4HQB9cNi4BP/ROjk3C58RvOT+JJt0AiYdmOYQ/n7rPfSrs4XXXrvzq5aE2R9EHfG
	 2VyNNVoczd38f0aRzb98on10qn8IXzHJS+CzmL+lEV26V+4nMOZNI9wdKSQSZRLLlw
	 kNMO2ZpKd07SOkUi7QSIaClnOxKBiFOBqW5Ubr6YX0ayH5rGfKcAYf+K5jt79km/8j
	 lBa/GS6XDzlGw==
Date: Tue, 13 Aug 2024 14:34:11 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Heghedus Razvan <heghedus.razvan@protonmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, akpm@linux-foundation.org,
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com, lina@asahilina.net,
	mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 22/26] rust: alloc: implement `Cmalloc` in module
 allocator_test
Message-ID: <ZrtSw7Dzopc5f8G1@pollux>
References: <20240812182355.11641-1-dakr@kernel.org>
 <20240812182355.11641-23-dakr@kernel.org>
 <D3ELEO3QFEZQ.2X1WF8Y3IVNQ0@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D3ELEO3QFEZQ.2X1WF8Y3IVNQ0@protonmail.com>

On Tue, Aug 13, 2024 at 07:07:46AM +0000, Heghedus Razvan wrote:
> On Mon Aug 12, 2024 at 9:23 PM EEST, Danilo Krummrich wrote:
> > So far the kernel's `Box` and `Vec` types can't be used by userspace
> > test cases, since all users of those types (e.g. `CString`) use kernel
> > allocators for instantiation.
> >
> > In order to allow userspace test cases to make use of such types as
> > well, implement the `Cmalloc` allocator within the allocator_test module
> > and type alias all kernel allocators to `Cmalloc`. The `Cmalloc`
> > allocator uses libc's realloc() function as allocator backend.
> >
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> > I know, having an `old_size` parameter would indeed help implementing `Cmalloc`.
> >
> > However, I really don't want test infrastructure to influence the design of
> > kernel internal APIs.
> >
> > It's on the test infrastructure to find a way to deal with it, even if it's more
> > complicated.
> > ---
> >  rust/kernel/alloc/allocator_test.rs | 175 ++++++++++++++++++++++++++--
> >  1 file changed, 168 insertions(+), 7 deletions(-)
> >
> > diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
> > index 1b2642c547ec..7a20e64431ea 100644
> > --- a/rust/kernel/alloc/allocator_test.rs
> > +++ b/rust/kernel/alloc/allocator_test.rs
> > @@ -2,20 +2,181 @@
> >
> >  #![allow(missing_docs)]
> >
> > -use super::{AllocError, Allocator, Flags};
> > +use super::{flags::*, AllocError, Allocator, Flags};
> >  use core::alloc::Layout;
> > +use core::cmp;
> > +use core::mem;
> > +use core::ptr;
> >  use core::ptr::NonNull;
> >
> > -pub struct Kmalloc;
> > +pub struct Cmalloc;
> > +pub type Kmalloc = Cmalloc;
> >  pub type Vmalloc = Kmalloc;
> >  pub type KVmalloc = Kmalloc;
> >
> > -unsafe impl Allocator for Kmalloc {
> > +extern "C" {
> > +    #[link_name = "aligned_alloc"]
> > +    fn libc_aligned_alloc(align: usize, size: usize) -> *mut core::ffi::c_void;
> > +
> > +    #[link_name = "free"]
> > +    fn libc_free(ptr: *mut core::ffi::c_void);
> > +}
> > +
> > +struct CmallocData {
> > +    // The actual size as requested through `Cmalloc::alloc` or `Cmalloc::realloc`.
> > +    size: usize,
> > +    // The offset from the pointer returned to the caller of `Cmalloc::alloc` or `Cmalloc::realloc`
> > +    // to the actual base address of the allocation.
> > +    offset: usize,
> > +}
> > +
> > +impl Cmalloc {
> > +    /// Adjust the size and alignment such that we can additionally store `CmallocData` right
> > +    /// before the actual data described by `layout`.
> > +    ///
> > +    /// Example:
> > +    ///
> > +    /// For `CmallocData` assume an alignment of 8 and a size of 16.
> > +    /// For `layout` assume and alignment of 16 and a size of 64.
> > +    ///
> > +    /// 0                16               32                                               96
> > +    /// |----------------|----------------|------------------------------------------------|
> > +    ///        empty         CmallocData                         data
> > +    ///
> > +    /// For this example the returned `Layout` has an alignment of 32 and a size of 96.
> > +    fn layout_adjust(layout: Layout) -> Result<Layout, AllocError> {
> > +        let layout = layout.pad_to_align();
> > +
> > +        // Ensure that `CmallocData` fits into half the alignment. Additionally, this guarantees
> > +        // that advancing a pointer aligned to `align` by `align / 2` we still satisfy or exceed
> > +        // the alignment requested through `layout`.
> > +        let align = cmp::max(
> > +            layout.align(),
> > +            mem::size_of::<CmallocData>().next_power_of_two(),
> > +        ) * 2;
> > +
> > +        // Add the additional space required for `CmallocData`.
> > +        let size = layout.size() + mem::size_of::<CmallocData>();
> > +
> > +        Ok(Layout::from_size_align(size, align)
> > +            .map_err(|_| AllocError)?
> > +            .pad_to_align())
> > +    }
> > +
> > +    fn alloc_store_data(layout: Layout) -> Result<NonNull<u8>, AllocError> {
> > +        let requested_size = layout.size();
> > +
> > +        let layout = Self::layout_adjust(layout)?;
> > +        let min_align = layout.align() / 2;
> > +
> > +        // SAFETY: Returns either NULL or a pointer to a memory allocation that satisfies or
> > +        // exceeds the given size and alignment requirements.
> > +        let raw_ptr = unsafe { libc_aligned_alloc(layout.align(), layout.size()) } as *mut u8;
> > +
> > +        let priv_ptr = NonNull::new(raw_ptr).ok_or(AllocError)?;
> > +
> > +        // SAFETY: Advance the pointer by `min_align`. The adjustments from `Self::layout_adjust`
> > +        // ensure that after this operation the original size and alignment requirements are still
> > +        // satisfied or exceeded.
> > +        let ptr = unsafe { priv_ptr.as_ptr().add(min_align) };
> > +
> > +        // SAFETY: `min_align` is greater than or equal to the size of `CmallocData`, hence we
> > +        // don't exceed the allocation boundaries.
> > +        let data_ptr: *mut CmallocData = unsafe { ptr.sub(mem::size_of::<CmallocData>()) }.cast();
> > +
> > +        let data = CmallocData {
> > +            size: requested_size,
> > +            offset: min_align,
> > +        };
> > +
> > +        // SAFETY: `data_ptr` is properly aligned and within the allocation boundaries reserved for
> > +        // `CmallocData`.
> > +        unsafe { data_ptr.write(data) };
> > +
> > +        NonNull::new(ptr).ok_or(AllocError)
> > +    }
> > +
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must have been previously allocated with `Self::alloc_store_data`.
> > +    unsafe fn data<'a>(ptr: NonNull<u8>) -> &'a CmallocData {
> > +        // SAFETY: `Self::alloc_store_data` stores the `CmallocData` right before the address
> > +        // returned to callers of `Self::alloc_store_data`.
> > +        let data_ptr: *mut CmallocData =
> > +            unsafe { ptr.as_ptr().sub(mem::size_of::<CmallocData>()) }.cast();
> > +
> > +        // SAFETY: The `CmallocData` has been previously stored at this offset with
> > +        // `Self::alloc_store_data`.
> > +        unsafe { &*data_ptr }
> > +    }
> > +
> > +    /// # Safety
> > +    ///
> > +    /// This function must not be called more than once for the same allocation.
> > +    ///
> > +    /// `ptr` must have been previously allocated with `Self::alloc_store_data`.
> > +    unsafe fn free_read_data(ptr: NonNull<u8>) {
> > +        // SAFETY: `ptr` has been created by `Self::alloc_store_data`.
> > +        let data = unsafe { Self::data(ptr) };
> > +
> > +        // SAFETY: `ptr` has been created by `Self::alloc_store_data`.
> > +        let priv_ptr = unsafe { ptr.as_ptr().sub(data.offset) };
> > +
> > +        // SAFETY: `priv_ptr` has previously been allocatored with this `Allocator`.
> > +        unsafe { libc_free(priv_ptr.cast()) };
> > +    }
> > +}
> > +
> > +unsafe impl Allocator for Cmalloc {
> > +    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, AllocError> {
> > +        if layout.size() == 0 {
> > +            return Ok(NonNull::slice_from_raw_parts(NonNull::dangling(), 0));
> > +        }
> > +
> > +        let ptr = Self::alloc_store_data(layout)?;
> > +
> > +        if flags.contains(__GFP_ZERO) {
> > +            // SAFETY: `Self::alloc_store_data` guarantees that `ptr` points to memory of at least
> > +            // `layout.size()` bytes.
> > +            unsafe { ptr.as_ptr().write_bytes(0, layout.size()) };
> > +        }
> > +
> > +        Ok(NonNull::slice_from_raw_parts(ptr, layout.size()))
> > +    }
> > +
> >      unsafe fn realloc(
> > -        _ptr: Option<NonNull<u8>>,
> > -        _layout: Layout,
> > -        _flags: Flags,
> > +        ptr: Option<NonNull<u8>>,
> > +        layout: Layout,
> > +        flags: Flags,
> >      ) -> Result<NonNull<[u8]>, AllocError> {
> > -        panic!();
> > +        let src: NonNull<u8> = if let Some(src) = ptr {
> > +            src.cast()
> > +        } else {
> > +            return Self::alloc(layout, flags);
> > +        };
> > +
> > +        if layout.size() == 0 {
> > +            // SAFETY: `src` has been created by `Self::alloc_store_data`.
> > +            unsafe { Self::free_read_data(src) };
> > +
> > +            return Ok(NonNull::slice_from_raw_parts(NonNull::dangling(), 0));
> > +        }
> > +
> > +        let dst = Self::alloc(layout, flags)?;
> > +
> > +        // SAFETY: `src` has been created by `Self::alloc_store_data`.
> > +        let data = unsafe { Self::data(src) };
> > +
> > +        // SAFETY: `src` has previously been allocated with this `Allocator`; `dst` has just been
> > +        // newly allocated. Copy up to the smaller of both sizes.
> > +        unsafe {
> > +            ptr::copy_nonoverlapping(
> > +                src.as_ptr(),
> > +                dst.as_ptr().cast(),
> > +                cmp::min(layout.size(), data.size),
> > +            )
> > +        };
> > +
> At this point should we free the src? Or is the original pointer expected to remain valid?

Yes, we're indeed missing `Self::free_read_data(src)` here.

> 
> > +        Ok(dst)
> >      }
> >  }
> > --
> > 2.45.2
> 
> 

