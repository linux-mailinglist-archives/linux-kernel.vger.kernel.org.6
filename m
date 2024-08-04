Return-Path: <linux-kernel+bounces-273828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F10946EA6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 14:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12300281530
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 12:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF84F3AC0D;
	Sun,  4 Aug 2024 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhqWbwrC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A2D381BD;
	Sun,  4 Aug 2024 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722774602; cv=none; b=S4zQWYmSQs3FBV12OAC+GNhg/raVP9zOlfB6qKp85B/IyfAVSpyfLyD3UXmGVqg+zgLkI56v4IqPAm4WrbXjW/wYGFtd/1lI6rfqezP+HJOtOYkZ9ERIOnfWbNcZo4VmqIoVeHJGeSRdOaEYz3xGwdkl1UjAu1vSS1e0NlhLjSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722774602; c=relaxed/simple;
	bh=VnyEDyp+Og0b+BRBM/aqZK971zINnbDM9dhZN85qgRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgcAWIevw0zcXV38nPuRGKeFxuaym3CDksZg88SmqAYpw8+ROHEonw6T82LBk6qmVGvYRATTNl+WBTU+gSOwGQ6KhtBMJJ3YdHaT/s0Xjm28vvvh2MmJp75veyS1BlGrwKVrnd1sRvyKArSu8NC3SiJ66yF/ocljbITJfV9mZek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhqWbwrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791D7C32786;
	Sun,  4 Aug 2024 12:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722774601;
	bh=VnyEDyp+Og0b+BRBM/aqZK971zINnbDM9dhZN85qgRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nhqWbwrClYv7Eg7mLZgSuH/101q/4cByDn2FVtT9qBr1sbyUBqlGZPgPV1SVzA5i3
	 7gdXLeS9j+ReHj5PMpmOKvmmtpZ/UTv0xlbFMzn6buKY7C5uWdCSdRlPRm4jjVP6PD
	 qAtYbzcz6TzTJ6odNnPP2uNsqLwX8v5mcqPUBgupd2AX0Ii77Z1lRmPMHv11j2T9HT
	 p8dYLaa6EghMtLxaRsioC7vcof37hnsUcdbEYYYMxZ2Z43Vw2IadpaY5OhFI6OKqDL
	 owPsNR7FjEsXUErQpRI0Cq5v819495VuM5PY765XLKBlKU8XZDImrjiMyf/sKN6bXi
	 2PfCRdiG7bpYA==
Date: Sun, 4 Aug 2024 14:29:53 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com,
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 01/25] rust: alloc: add `Allocator` trait
Message-ID: <Zq90QTKqJQWtCnPn@pollux>
References: <20240801000641.1882-1-dakr@kernel.org>
 <20240801000641.1882-2-dakr@kernel.org>
 <Zq8d4fKUhXchuZBR@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zq8d4fKUhXchuZBR@boqun-archlinux>

On Sat, Aug 03, 2024 at 11:21:21PM -0700, Boqun Feng wrote:
> On Thu, Aug 01, 2024 at 02:02:00AM +0200, Danilo Krummrich wrote:
> [...]
> > +/// The kernel's [`Allocator`] trait.
> > +///
> > +/// An implementation of [`Allocator`] can allocate, re-allocate and free memory buffer described
> > +/// via [`Layout`].
> > +///
> > +/// [`Allocator`] is designed to be implemented as a ZST; [`Allocator`] functions do not operate on
> > +/// an object instance.
> > +///
> > +/// # Safety
> > +///
> > +/// Memory returned from an allocator must point to a valid memory buffer and remain valid until
> > +/// it is explicitly freed.
> > +///
> > +/// Any pointer to a memory buffer which is currently allocated must be valid to be passed to any
> > +/// other [`Allocator`] function. The same applies for a NULL pointer.
> > +///
> 
> Are you saying you could kmalloc() a memory buffer and pass it to a
> vfree()? Or am I missing something here?

I will extend it to:

"valid to be passed to any other [`Allocator`] function" of the same type.

> 
> Regards,
> Boqun
> 
> > +/// If `realloc` is called with:
> > +///   - a size of zero, the given memory allocation, if any, must be freed
> > +///   - a NULL pointer, a new memory allocation must be created
> > +pub unsafe trait Allocator {
> > +    /// Allocate memory based on `layout` and `flags`.
> > +    ///
> > +    /// On success, returns a buffer represented as `NonNull<[u8]>` that satisfies the layout
> > +    /// constraints (i.e. minimum size and alignment as specified by `layout`).
> > +    ///
> > +    /// This function is equivalent to `realloc` when called with a NULL pointer.
> > +    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, AllocError> {
> > +        // SAFETY: Passing a NULL pointer to `realloc` is valid by it's safety requirements and asks
> > +        // for a new memory allocation.
> > +        unsafe { Self::realloc(None, layout, flags) }
> > +    }
> > +
> > +    /// Re-allocate an existing memory allocation to satisfy the requested `layout`. If the
> > +    /// requested size is zero, `realloc` behaves equivalent to `free`.
> > +    ///
> > +    /// If the requested size is larger than the size of the existing allocation, a successful call
> > +    /// to `realloc` guarantees that the new or grown buffer has at least `Layout::size` bytes, but
> > +    /// may also be larger.
> > +    ///
> > +    /// If the requested size is smaller than the size of the existing allocation, `realloc` may or
> > +    /// may not shrink the buffer; this is implementation specific to the allocator.
> > +    ///
> > +    /// On allocation failure, the existing buffer, if any, remains valid.
> > +    ///
> > +    /// The buffer is represented as `NonNull<[u8]>`.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must point to an existing and valid memory allocation created by this allocator
> > +    /// instance.
> > +    ///
> > +    /// Additionally, `ptr` is allowed to be a NULL pointer; in this case a new memory allocation is
> > +    /// created.
> > +    unsafe fn realloc(
> > +        ptr: Option<NonNull<u8>>,
> > +        layout: Layout,
> > +        flags: Flags,
> > +    ) -> Result<NonNull<[u8]>, AllocError>;
> > +
> > +    /// Free an existing memory allocation.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must point to an existing and valid memory allocation created by this `Allocator`
> > +    /// instance.
> > +    unsafe fn free(ptr: NonNull<u8>) {
> > +        // SAFETY: `ptr` is guaranteed to be previously allocated with this `Allocator` or NULL.
> > +        // Calling `realloc` with a buffer size of zero, frees the buffer `ptr` points to.
> > +        let _ = unsafe { Self::realloc(Some(ptr), Layout::new::<()>(), Flags(0)) };
> > +    }
> > +}
> > -- 
> > 2.45.2
> > 
> 

