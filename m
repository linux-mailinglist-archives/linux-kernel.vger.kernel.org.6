Return-Path: <linux-kernel+bounces-307778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 581259652E0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 00:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9562850D3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A331BE243;
	Thu, 29 Aug 2024 22:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtuPO+67"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E62B1BE22F;
	Thu, 29 Aug 2024 22:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724970327; cv=none; b=Zq6Xp/WpaDshJ7/U+6HkYywOn9mXWhrnapZlMV87j8OkCzQyBSzBUoFieipOK59lD5aZoaf8aL18wc7NuMYa6C6VGdoYi2bEisLwnl/HiYkQwjSjLRONo/zMvXCx9ddhGvlwnqH+KrkK2daCVugvZypJQrdoDVkHVW+G8BWsUmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724970327; c=relaxed/simple;
	bh=9QL5tYH2tIhzGwNe5gZfGSxX1emUw9NxqJ0jPSVxO7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjRA21bxppMpYYcSER4DnpK/LycplfA983SKcMgIx4D5rdeyvuyEQ4vgrPv3Qe6541FlSQNFbAj41ndtTAxE31jeBjqzsdrymjPf/pu0bp+m4iURRZcXJCp3BIYXaFUXMNDcO9AiS/1eBmDKxw2kkdnyjxPg8Yjahsfm6QOTXdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtuPO+67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B050C4CEC1;
	Thu, 29 Aug 2024 22:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724970326;
	bh=9QL5tYH2tIhzGwNe5gZfGSxX1emUw9NxqJ0jPSVxO7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GtuPO+67i2pbCILo9/yvl0O1IcwnF5psrFDSu6i7vpGbGfiFJWK/hCzVSF5NQgusX
	 1hkosOoEtrakTA6EwwDmKLwXlChRqzlI8G46GPB/pUdGVBJrKomGRlWI4Qthoe9qVg
	 Pj/eegAHDRvoBTyDm3Qzao0TIlxKMYqw1zqB4sPMAFvYUrj9xi3EQbLtOXmAaOJ3vy
	 QpEs2HSTWkYjulZl+OtwtbH3aFAjcqcHnaytrxrbXYKslkDHvLajcVWYBzb9Ib3Ri4
	 cFE2yDxI9tpvXtaw4jXhwJNaSeBtBvcDNxCKPCd9z9wcWdjDbU7rFfhzBWxZa7AvWc
	 iu3x42vWOlOdw==
Date: Fri, 30 Aug 2024 00:25:18 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 22/26] rust: alloc: implement `Cmalloc` in module
 allocator_test
Message-ID: <ZtD1TsGm0swi7gyv@pollux.localdomain>
References: <20240816001216.26575-1-dakr@kernel.org>
 <20240816001216.26575-23-dakr@kernel.org>
 <e3ccbf52-224e-4869-992b-4fcaa0ec3410@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3ccbf52-224e-4869-992b-4fcaa0ec3410@proton.me>

On Thu, Aug 29, 2024 at 07:14:18PM +0000, Benno Lossin wrote:
> On 16.08.24 02:11, Danilo Krummrich wrote:
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
> >  rust/kernel/alloc/allocator_test.rs | 178 ++++++++++++++++++++++++++--
> >  1 file changed, 171 insertions(+), 7 deletions(-)
> > 
> > diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
> > index 1b2642c547ec..7fff308d02dc 100644
> > --- a/rust/kernel/alloc/allocator_test.rs
> > +++ b/rust/kernel/alloc/allocator_test.rs
> > @@ -2,20 +2,184 @@
> > 
> 
> Could add a short paragraph as the module description why this module
> exists? Would probably be enough to paste the commit message.

Yes, sounds good.

> 
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
> 
> This looks like you want it rendered as bulletpoints (but it won't).

Actually, that wasn't my intention, but I'm fine changing that.

> 
> > +    ///
> > +    /// 0                16               32                                               96
> > +    /// |----------------|----------------|------------------------------------------------|
> > +    ///        empty         CmallocData                         data
> 
> Can you put this inside of '```'? Then it will render nicely in markdown
> (don't forget to specify the type 'text')

Sure.

> 
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
> 
> This SAFETY comment should address why it's OK to call `add`. You
> justify something different, namely why the allocation still satisfies
> the requirements of `layout`. That is something that this function
> should probably guarantee.

So, I guess you're arguing that instead I should say that, we're still within
the bounds of the same allocated object and don't exceed `isize`?

> 
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
> 
> You additionally need that you have shared access to the pointee.
> 
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
> 
> You additionally need that you have exclusive access to the pointee.
> 
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
> 
> This makes me wonder, what other flags should we handle for this
> allocator?

I don't think there are any other flags that we can handle. The only other one
that'd make sense is __GFP_NOFAIL, but we can't guarantee that.

If any specific gfp flags are needed, I think it's simply not a candidate for a
userspace test.

If we really want to do something here, we could whitelist the flags we ignore,
since they do not matter (such as __GFP_NOWARN) and panic() for everything else.

But I don't think that's really needed.

> 
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
> 
> Why the cast?

Probably a copy-paste mistake.

> 
> > +        } else {
> > +            return Self::alloc(layout, flags);
> > +        };
> 
> You should be able to write this instead:
> 
>     let Some(src) = ptr else {
>         return Self::alloc(layout, flags);
>     };

Yes, indeed.

> 
> > +
> > +        if layout.size() == 0 {
> > +            // SAFETY: `src` has been created by `Self::alloc_store_data`.
> 
> This is not true, consider:
> 
>     let ptr = alloc(size = 0);
>     free(ptr)
> 
> Alloc will return a dangling pointer due to the first if statement and
> then this function will pass it to `free_read_data`, even though it
> wasn't created by `alloc_store_data`.
> This isn't forbidden by the `Allocator` trait function's safety
> requirements.
> 
> > +            unsafe { Self::free_read_data(src) };
> > +
> > +            return Ok(NonNull::slice_from_raw_parts(NonNull::dangling(), 0));
> > +        }
> > +
> > +        let dst = Self::alloc(layout, flags)?;
> > +
> > +        // SAFETY: `src` has been created by `Self::alloc_store_data`.
> > +        let data = unsafe { Self::data(src) };
> 
> Same issue here, if the allocation passed in is zero size. I think you
> have no other choice than to allocate even for zero size requests...
> Otherwise how would you know that they are zero-sized.

Good catch - gonna fix it.

> 
> ---
> Cheers,
> Benno
> 
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
> > +        // SAFETY: `src` has been created by `Self::alloc_store_data`.
> > +        unsafe { Self::free_read_data(src) };
> > +
> > +        Ok(dst)
> >      }
> >  }
> > --
> > 2.46.0
> > 
> 

