Return-Path: <linux-kernel+bounces-279210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D5194BA83
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55574B2161E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7993E189F4B;
	Thu,  8 Aug 2024 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwmJ5Eqx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AF913D61D;
	Thu,  8 Aug 2024 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723111676; cv=none; b=clEmT31ogbP5t2K+0bVLU3a/Vu8/lSjU6GjQNnA6NCBOJpbfwtmvoyozkiyu/7sPjoZSfcDCdiqeR3JtB31N+/FTH4s59rmkrOB7J/eQOM4/sXKchKjPX4FKwvH6vmEq34LmIIDapBBmjLfgfLBETD3Z3nvcJn3UcH1mc2pZ6xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723111676; c=relaxed/simple;
	bh=Z+730wdykgDL37zu2DW7NoDiCuHq6W2AiZCHoRLEZqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQk0l62Srv7LGl3VAupqMG1TUdWSExHhR+mV3SZtMaBJ1EhvKm7Mm2NvwyNL4qayU09+rx4u8jEGJdp4DRU5A9PssDQ9aZ0h+6zBfKLMQaEPZB0/V2z91IwqEjkLwqGm3xqr8d04C50PxVfl/rS/0ANc6SI9CSZTEhK7SBuubls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwmJ5Eqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C160C32782;
	Thu,  8 Aug 2024 10:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723111676;
	bh=Z+730wdykgDL37zu2DW7NoDiCuHq6W2AiZCHoRLEZqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JwmJ5EqxR2+5nZsc8J2ITqAp+c84P9wmWOqHbtVQmXYDpigys7RJu0fprpFnekTIk
	 I2hOtXdwcZIL/MHEFL3sep8UIdvmN4kVgALNiOpd2rrPrBYvpSGe2nnXz8jzuwz2Y1
	 HjEMZXCIHCS4dyHi5qfRW3YqhbV3OOrWCzzgtz9+pYeVb/ykj4Xv4eJROFQAI5rbTI
	 kBgggxRh33MSFiyxwQEEr1Rqs1/ntBQbnSoNPQRUdc2CN7RWUsUFXNonm7Rg4ZZGe5
	 zFjso8EH7LUwCRRmv7XG5MXmWfqhKqjytATHP4RBBW8FR+tb+UdsLlxge0ml+jWBFW
	 A2AB2+RBtsxGw==
Date: Thu, 8 Aug 2024 12:07:48 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com,
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 25/28] rust: alloc: implement `Cmalloc` in module
 allocator_test
Message-ID: <ZrSY9DZuDu7lY-1Q@pollux>
References: <20240805152004.5039-1-dakr@kernel.org>
 <20240805152004.5039-26-dakr@kernel.org>
 <dcf75b19-9900-4aaa-8ff7-36b08baa18f2@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcf75b19-9900-4aaa-8ff7-36b08baa18f2@proton.me>

On Thu, Aug 08, 2024 at 09:35:47AM +0000, Benno Lossin wrote:
> On 05.08.24 17:19, Danilo Krummrich wrote:
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
> > Besides that, adding the `old_size` parameter would have the consequence that
> > we'd either need to honor it for kernel allocators too (which adds another
> > source of potential failure) or ignore it for all kernel allocators (which
> > potentially tricks people into taking wrong assumptions on how the API works).
> > ---
> >  rust/kernel/alloc/allocator_test.rs | 91 ++++++++++++++++++++++++++---
> >  1 file changed, 84 insertions(+), 7 deletions(-)
> > 
> > diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
> > index 1b2642c547ec..05fd75b89238 100644
> > --- a/rust/kernel/alloc/allocator_test.rs
> > +++ b/rust/kernel/alloc/allocator_test.rs
> > @@ -2,20 +2,97 @@
> > 
> >  #![allow(missing_docs)]
> > 
> > -use super::{AllocError, Allocator, Flags};
> > +use super::{flags::*, AllocError, Allocator, Flags};
> >  use core::alloc::Layout;
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
> > +
> > +    // Do not use this function for production code! For test cases only it's
> > +    // probably fine if used with care.
> > +    #[link_name = "malloc_usable_size"]
> > +    fn libc_malloc_usable_size(ptr: *mut core::ffi::c_void) -> usize;
> > +}
> > +
> > +unsafe impl Allocator for Cmalloc {
> > +    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, AllocError> {
> > +        let layout = layout.pad_to_align();
> > +
> > +        // SAFETY: Returns either NULL or a pointer to a memory allocation that satisfies or
> > +        // exceeds the given size and alignment requirements.
> > +        let raw_ptr = unsafe { libc_aligned_alloc(layout.align(), layout.size()) } as *mut u8;
> > +
> > +        if flags.contains(__GFP_ZERO) && !raw_ptr.is_null() {
> > +            // SAFETY: `raw_ptr` points to memory successfully allocated with `libc_aligned_alloc`.
> > +            let size = unsafe { libc_malloc_usable_size(raw_ptr.cast()) };
> > +
> > +            // SAFETY: `raw_ptr` points to memory successfully allocated with `libc_aligned_alloc`
> > +            // of at least `size` bytes.
> > +            unsafe { core::ptr::write_bytes(raw_ptr, 0, size) };
> > +        }
> > +
> > +        let ptr = if layout.size() == 0 {
> > +            NonNull::dangling()
> 
> Why do you call `libc_aligned_alloc` when you return `dangling()`
> anyways when size is zero? I would move this check upwards.
> 
> > +        } else {
> > +            NonNull::new(raw_ptr).ok_or(AllocError)?
> 
> Would also make sense to do this above the null check.
> 
> > +        };
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
> > +        let layout = layout.pad_to_align();
> > +        let src: *mut u8 = if let Some(src) = ptr {
> > +            src.as_ptr().cast()
> > +        } else {
> > +            ptr::null_mut()
> > +        };
> > +
> > +        if layout.size() == 0 {
> > +            // SAFETY: `src` is either NULL or has previously been allocatored with this
> > +            // `Allocator`.
> > +            unsafe { libc_free(src.cast()) };
> > +
> > +            return Ok(NonNull::slice_from_raw_parts(NonNull::dangling(), 0));
> > +        }
> > +
> > +        let dst = Self::alloc(layout, flags)?;
> > +
> > +        if src.is_null() {
> > +            return Ok(dst);
> > +        }
> > +
> > +        // SAFETY: `src` is either NULL or has previously been allocatored with this `Allocator`.
> > +        let old_size = unsafe { libc_malloc_usable_size(src.cast()) };
> 
> Citing man malloc_usable_size(3):
> 
>     CAVEATS
>         The value returned by malloc_usable_size() may be greater than
>         the requested size of the allocation because of various internal
>         implementation details, none of which the programmer should rely
>         on.  This function is intended to only be used for diagnostics
>         and statistics; writing to the excess memory without first
>         calling realloc(3) to resize the allocation is not supported.
>         The returned value is only valid at the time of the call.
> 
> While you don't write, you might read below, which might not be OK?

That is very interesting, the man page entry I looked at said:

       The  value  returned by malloc_usable_size() may be greater than the requested size of the
       allocation because of alignment and minimum size constraints.  Although the  excess  bytes
       can  be  overwritten  by the application without ill effects, this is not good programming
       practice: the  number  of  excess  bytes  in  an  allocation  depends  on  the  underlying
       implementation.

This was changed in [1] and it looks like "can be overwritten by the application
without ill effects" just isn't true any more, too bad.

I have to think about it a bit, what we could do instead. I also don't really
want to have an old size parameter for `realloc` only because it's needed by
test infrastructure.

[1] https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=015464751006a964ff401f1eb5945ca28c4448a7

> 
> ---
> Cheers,
> Benno
> 
> > +
> > +        // SAFETY: `src` has previously been allocated with this `Allocator`; `dst` has just been
> > +        // newly allocated. Taking the minimum of their sizes guarantees that we do not exceed
> > +        // either bounds.
> > +        unsafe {
> > +            // Always copy -- do not rely on potential spare memory reported by
> > +            // malloc_usable_size() which technically may still be sufficient.
> > +            ptr::copy_nonoverlapping(
> > +                src,
> > +                dst.as_ptr().cast(),
> > +                core::cmp::min(layout.size(), old_size),
> > +            )
> > +        };
> > +
> > +        Ok(dst)
> >      }
> >  }
> > --
> > 2.45.2
> > 
> 

