Return-Path: <linux-kernel+bounces-340509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E6E987461
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0CE1F2108B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6599B3B1A2;
	Thu, 26 Sep 2024 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cg1USL/m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C134819BBC;
	Thu, 26 Sep 2024 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727357085; cv=none; b=lYO+SniutfgEMA9aB9ApNnuCwFAaz9ZxFv2VvFwm9pYqYVnhvvVh+klcCB37MBPYr79ZWbV90SVOr6aBXmFZSTQighsTJKcvUOxu6azILJZBNvcGCxgBqSfwPidjGVBD6qJCWM9GyH3zhJWTuKmFEAMwLYaTjPynikwF80et6R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727357085; c=relaxed/simple;
	bh=Ev17E6HPXrIHJ7KiVzlg4fQjIPKFzPlo86lB1LBlExk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpIKSBcgOXypr6NN+4u+0GCBQDjcuhyVZfHaJLeSLEm2o/LsXKiHB+ejTnxjkvxiFJjj27txx7DCyA0ij6BBln5xoyMP6IgKHBjkUUw8EuAXvzLsUYHo6pYTE297KjVv4ZMoM3t5bKq+prnfrTdo7qRJUTKIvRKBbHUsp2wp1Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cg1USL/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F14C4CEC5;
	Thu, 26 Sep 2024 13:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727357085;
	bh=Ev17E6HPXrIHJ7KiVzlg4fQjIPKFzPlo86lB1LBlExk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cg1USL/mXifPqA4Z1NOvsq+zHXfVpI2bTeRIDkUWo2bABYniXHcmWIUt9ViZCHysJ
	 DxFBnIXXo9OuWcRNmcSlp7YGQFemv2X5g3k72HpE9i8uKNXAzmRthE9eeu3JAhHX//
	 aOPtGZ7vxPtoTgC5sxiXml54vy8MuMx/6SPPqUYM2kupjT+7ta1NcsaXdbtZOQ/sW+
	 TkW/tB7jhX2Q1mCWVL4c9I4P7tvMGcwz6VlVK1B/oyGxAaP8oMgkIoLMmd3/xkZP9Q
	 2jPmsE0J+pkjLrMx/4/+AVP77eBj4d/p10+60+wQpPGZDRXD8F/x0W1/ZAKy8NGOcn
	 aMGI/5y2gYzHQ==
Date: Thu, 26 Sep 2024 15:24:26 +0200
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
Subject: Re: [PATCH v7 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <ZvVgimoQPoL1trmJ@cassiopeiae>
References: <20240911225449.152928-1-dakr@kernel.org>
 <20240911225449.152928-5-dakr@kernel.org>
 <15f42ddd-b011-4136-b2e4-bc266fab25b6@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15f42ddd-b011-4136-b2e4-bc266fab25b6@proton.me>

On Thu, Sep 26, 2024 at 01:00:58PM +0000, Benno Lossin wrote:
> On 12.09.24 00:52, Danilo Krummrich wrote:
> > +/// # Invariants
> > +///
> > +/// One of the following `krealloc`, `vrealloc`, `kvrealloc`.
> > +struct ReallocFunc(
> > +    unsafe extern "C" fn(*const core::ffi::c_void, usize, u32) -> *mut core::ffi::c_void,
> > +);
> > +
> > +impl ReallocFunc {
> > +    // INVARIANT: `krealloc` satisfies the type invariants.
> > +    const KREALLOC: Self = Self(bindings::krealloc);
> > +
> > +    /// # Safety
> > +    ///
> > +    /// This method has the same safety requirements as [`Allocator::realloc`].
> > +    ///
> > +    /// # Guarantees
> > +    ///
> > +    /// This method has the same guarantees as `Allocator::realloc`. Additionally
> > +    /// - it accepts any pointer to a valid memory allocation allocated by this function.
> > +    /// - memory allocated by this function remains valid until it is passed to this function.
> > +    unsafe fn call(
> > +        &self,
> > +        ptr: Option<NonNull<u8>>,
> > +        layout: Layout,
> > +        flags: Flags,
> > +    ) -> Result<NonNull<[u8]>, AllocError> {
> > +        let size = aligned_size(layout);
> > +        let ptr = match ptr {
> > +            Some(ptr) => ptr.as_ptr(),
> > +            None => ptr::null(),
> > +        };
> > +
> > +        // SAFETY:
> > +        // - `self.0` is one of `krealloc`, `vrealloc`, `kvrealloc` and thus only requires that
> > +        //   `ptr` is NULL or valid.
> > +        // - `ptr` is either NULL or valid by the safety requirements of this function.
> > +        //
> > +        // GUARANTEE:
> > +        // - `self.0` is one of `krealloc`, `vrealloc`, `kvrealloc`.
> > +        // - Those functions provide the guarantees of this function.
> > +        let raw_ptr = unsafe {
> > +            // If `size == 0` and `ptr != NULL` the memory behind the pointer is freed.
> > +            self.0(ptr.cast(), size, flags.0).cast()
> > +        };
> > +
> > +        let ptr = if size == 0 {
> > +            NonNull::dangling()
> > +        } else {
> > +            NonNull::new(raw_ptr).ok_or(AllocError)?
> > +        };
> > +
> > +        Ok(NonNull::slice_from_raw_parts(ptr, size))
> > +    }
> > +}
> 
> I remember asking you to split this into a different commit. I think you
> argued that it would be better to keep it in the same commit when
> bisecting. I don't think that applies in this case, are there any other
> disadvantages?

I don't really like the intermediate `#[expect(dead_code)]`, plus it's
additional work you didn't really give me a motivation for, i.e. you did not
mention what would be the advantage.

But sure, I will change it for the next version.

> 
> ---
> Cheers,
> Benno
> 
> > +
> > +// SAFETY: `realloc` delegates to `ReallocFunc::call`, which guarantees that
> > +// - memory remains valid until it is explicitly freed,
> > +// - passing a pointer to a valid memory allocation is OK,
> > +// - `realloc` satisfies the guarantees, since `ReallocFunc::call` has the same.
> > +unsafe impl Allocator for Kmalloc {
> > +    #[inline]
> > +    unsafe fn realloc(
> > +        ptr: Option<NonNull<u8>>,
> > +        layout: Layout,
> > +        flags: Flags,
> > +    ) -> Result<NonNull<[u8]>, AllocError> {
> > +        // SAFETY: `ReallocFunc::call` has the same safety requirements as `Allocator::realloc`.
> > +        unsafe { ReallocFunc::KREALLOC.call(ptr, layout, flags) }
> > +    }
> > +}
> 
> 
> > +
> >  unsafe impl GlobalAlloc for Kmalloc {
> >      unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
> >          // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
> > --
> > 2.46.0
> > 
> 

