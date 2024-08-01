Return-Path: <linux-kernel+bounces-271227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E1A944B4C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39AF1C23FC5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB3F1A00FF;
	Thu,  1 Aug 2024 12:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHSKZqva"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3F318A6AC;
	Thu,  1 Aug 2024 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515410; cv=none; b=rdNuP3sK3B2bYVMnJGxj3r+GaQrj1sIarygJbex2itFh3l2taZeF2rhub/KL4DHkJ0ix3PG/fMXh097IIYfm2iHR+6DTo9tiH0R62H2c7NGDaI6XtZsRFm5ormps7EqlsGyb01XqwP234T47tS5d6GiWith0g1OSX/jm+U5Stfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515410; c=relaxed/simple;
	bh=6p5xxN4jqmS6heldWZ6mqD4FJ8Kzrt2Vjy/8twVNGdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmcAzkYPZE6WgsUTGNV5ZFqP0FmUM46XTYdFWzH/OG5nILtSySGLF6H86GxRuS6+O1pkYizlTnR63aZmq6ILXcRVzqdkuS+0F9jHcD7thL9ZA0s93xC4HdzTS2SMC5CyKRq82MDtyE8cW1jmbOuiBDcdmkXgIGNV2klR73+3nRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHSKZqva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91E0C32786;
	Thu,  1 Aug 2024 12:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722515409;
	bh=6p5xxN4jqmS6heldWZ6mqD4FJ8Kzrt2Vjy/8twVNGdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tHSKZqvaSaU/vZsgYgrYCkHt+Lf3VicjqVa4khmV29VPQk4fd5sIe9q6y59MoApQ/
	 YwTIGM/aecr8uXmAk55C5qqzbkbQxzyhE0kFNNyNGI4sPelUtV61VWAXmbCB4erhG5
	 O2CfvfsDHXqs7LNdSEDoFSfzNlVysZkUMcbkuFk5XMy96q0wJXs3KTJ+1teVadVkai
	 qoBhK1Wtf8kmlz+rzp6q6sk1iCb1PkvFKlxBqvhrhpaoN0j97m0/+2qrbkjSmkSpjK
	 7xOaHyG9dcvHz6HGDNAkPuwXj4pIzkImpozSauhuVhldZ7bYmQWxrDt+yvG8Z9es50
	 MB/Uf/7bzuS3Q==
Date: Thu, 1 Aug 2024 14:30:01 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com,
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 04/25] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <Zqt_yeGPTIYjgCK8@pollux>
References: <20240801000641.1882-1-dakr@kernel.org>
 <20240801000641.1882-5-dakr@kernel.org>
 <CAH5fLggM5X7M9fTJE7C2afSHehK8b72XGKAgsEcn3Xm632s_Gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLggM5X7M9fTJE7C2afSHehK8b72XGKAgsEcn3Xm632s_Gg@mail.gmail.com>

On Thu, Aug 01, 2024 at 10:28:09AM +0200, Alice Ryhl wrote:
> On Thu, Aug 1, 2024 at 2:07 AM Danilo Krummrich <dakr@kernel.org> wrote:
> > +/// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
> >  fn aligned_size(new_layout: Layout) -> usize {
> 
> This comment could potentially be moved to the previous patch that
> defined the function.
> 
> > +struct ReallocFunc(
> > +    // INVARIANT: One of the following `krealloc`, `vrealloc`, `kvrealloc`.
> > +    unsafe extern "C" fn(*const core::ffi::c_void, usize, u32) -> *mut core::ffi::c_void,
> > +);
> 
> In this case, the comment would usually be formatted with markdown.
> 
> /// # Invariants
> ///
> /// Must contain one of the following: `krealloc`, `vrealloc`, `kvrealloc`.
> 
> The // INVARIANT: syntax is used when constructing an instance to
> argue why the documentented invariants are satisfied.
> 
> > +impl ReallocFunc {
> > +    fn krealloc() -> Self {
> > +        Self(bindings::krealloc)
> > +    }
> 
> Technically this should have an // INVARIANT: explaining why the
> invariants are satisfied by this new value.
> 
> > +
> > +    // SAFETY: `call` has the exact same safety requirements as `Allocator::realloc`.
> > +    unsafe fn call(
> 
> Similarly to the above, the // SAFETY: syntax is used when arguing why
> the preconditions are satisfied, but when explaining what the
> preconditions are, we usually use this syntax instead:
> 
> /// # Safety
> ///
> /// This method has the same safety requirements as `Allocator::realloc`.

Agreed, I will change this one and the above.

> 
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
> > +        // SAFETY: `ptr` is valid by the safety requirements of this function.
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
> > +
> > +unsafe impl Allocator for Kmalloc {
> > +    unsafe fn realloc(
> > +        ptr: Option<NonNull<u8>>,
> > +        layout: Layout,
> > +        flags: Flags,
> > +    ) -> Result<NonNull<[u8]>, AllocError> {
> > +        let realloc = ReallocFunc::krealloc();
> > +
> > +        // SAFETY: If not `None`, `ptr` is guaranteed to point to valid memory, which was previously
> > +        // allocated with this `Allocator`.
> > +        unsafe { realloc.call(ptr, layout, flags) }
> > +    }
> > +}
> > +
> >  unsafe impl GlobalAlloc for Kmalloc {
> >      unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
> >          // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
> > --
> > 2.45.2
> >
> 

