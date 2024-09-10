Return-Path: <linux-kernel+bounces-323161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE799738BE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838B41F2526F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D481E493;
	Tue, 10 Sep 2024 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VP/EsPIS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4392E191F7A;
	Tue, 10 Sep 2024 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725975459; cv=none; b=L5kZFHeSWG3LlLOp9QpZA4c/ep4awUQnUoerGkjJr1XN8HasH38UgibJCSurPWYgXNTpGjeoqjPMVLyrdrfwv3wuuxI/KQ9VoblWlj006dyXo2oLhoMNCyIhsXG2xgOjIPnUGblIYEcRMY/cOetJhNpJeBUAg4xlwFjg1yx58PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725975459; c=relaxed/simple;
	bh=Se+W8OcRyLSrvG4BhUjXy8p/mtKVHPYpyHMz8zbIRu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNzTxTg0CnBZC+sQakXkJlEfdaqB6pPy57DPVvb2mNfQsH/7cYpe5kyE6rKHGNRKIP8IDm92U1GVmgA8fcdgEmOnS6zRkEmQmA93gGcnyHHdI0BWws/D/rkwAhAjzYMlaLCG6GnFJ8YZEEmsu8PzoJ6cYD0bOpvuEDvzZinDrFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VP/EsPIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C83FC4CEC3;
	Tue, 10 Sep 2024 13:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725975458;
	bh=Se+W8OcRyLSrvG4BhUjXy8p/mtKVHPYpyHMz8zbIRu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VP/EsPISBklzTFrhM0yz3nCyD4ILK+N8tLa7h/lMCe6M48kvfbA+L8hjWoTXWiW7q
	 8qM9QBMTa2BLaay2FbFV751C1EI9S6l4oh9y2bs7+23iFodYLdA2pWLk1vaGLxEepq
	 QIWoKJv7tT4eFiXJJOt1MjgjK+S4rSllTKc8Q7c6PPxhDGosfSfGsWPWjxyJN4NFrf
	 MlOmJgrK574xhJoPK58UgTAWkocwGtn0Fa0jbAgxL/Ja5scJTz095zNcwckvOkpC+5
	 m7r1YoNX7P1Eai2BKuOttp+rDZavotmYNv6PoLMfeWtEhf5C+hwll5/flwLDBkxUo8
	 5eZ/9zxOLCFQw==
Date: Tue, 10 Sep 2024 15:37:31 +0200
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
Subject: Re: [PATCH v6 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <ZuBLmwpwurxFwYG_@cassiopeiae>
References: <20240816001216.26575-1-dakr@kernel.org>
 <20240816001216.26575-5-dakr@kernel.org>
 <2dd02834-b2b6-4ff6-9e29-43c9d77b69e2@proton.me>
 <ZtDwduKjIEZ3RQtk@pollux.localdomain>
 <962b7014-4f8b-4abe-8774-636b612a051c@proton.me>
 <Ztb3eOoiHs2rLCoH@pollux>
 <c1b5a3bf-b11c-4c33-9519-c93649860a9a@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1b5a3bf-b11c-4c33-9519-c93649860a9a@proton.me>

On Tue, Sep 10, 2024 at 01:11:35PM +0000, Benno Lossin wrote:
> On 03.09.24 13:48, Danilo Krummrich wrote:
> > On Fri, Aug 30, 2024 at 02:45:35PM +0000, Benno Lossin wrote:
> >> On 30.08.24 00:04, Danilo Krummrich wrote:
> >>> On Thu, Aug 29, 2024 at 06:32:42PM +0000, Benno Lossin wrote:
> >>>> On 16.08.24 02:10, Danilo Krummrich wrote:
> >>>>> +///
> >>>>> +/// For more details see [self].
> >>>>> +pub struct Kmalloc;
> >>>>>
> >>>>>  /// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
> >>>>>  fn aligned_size(new_layout: Layout) -> usize {
> >>>>> @@ -36,6 +52,60 @@ pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: F
> >>>>>      unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, size, flags.0) as *mut u8 }
> >>>>>  }
> >>>>>
> >>>>> +/// # Invariants
> >>>>> +///
> >>>>> +/// One of the following `krealloc`, `vrealloc`, `kvrealloc`.
> >>>>> +struct ReallocFunc(
> >>>>> +    unsafe extern "C" fn(*const core::ffi::c_void, usize, u32) -> *mut core::ffi::c_void,
> >>>>> +);
> >>>>> +
> >>>>> +impl ReallocFunc {
> >>>>> +    // INVARIANT: `krealloc` satisfies the type invariants.
> >>>>> +    const KREALLOC: Self = Self(bindings::krealloc);
> >>>>> +
> >>>>> +    /// # Safety
> >>>>> +    ///
> >>>>> +    /// This method has the same safety requirements as [`Allocator::realloc`].
> >>>>> +    unsafe fn call(
> >>>>> +        &self,
> >>>>> +        ptr: Option<NonNull<u8>>,
> >>>>> +        layout: Layout,
> >>>>> +        flags: Flags,
> >>>>> +    ) -> Result<NonNull<[u8]>, AllocError> {
> >>>>> +        let size = aligned_size(layout);
> >>>>> +        let ptr = match ptr {
> >>>>> +            Some(ptr) => ptr.as_ptr(),
> >>>>> +            None => ptr::null(),
> >>>>> +        };
> >>>>> +
> >>>>> +        // SAFETY: `ptr` is either NULL or valid by the safety requirements of this function.
> >>>>
> >>>> You need some justification as to why calling the three allowed
> >>>> functions here.
> >>>
> >>> What kind of justification do I need? Can you please share some more details on
> >>> what you think is missing here?
> >>
> >> So, you are calling a function pointer to an `unsafe` function. This
> >> means that through some invariant you have to know what the safety
> >> requirements are (otherwise how can you guarantee that this is OK?). You
> >> have the invariant that the pointer points at one of the three functions
> >> mentioned above. What are the safety requirements of those functions? I
> >> would assume that the only one is that `ptr` is valid. So you can use:
> >>
> >>     // SAFETY:
> >>     // - `self.0` is one of `krealloc`, `vrealloc`, `kvrealloc` and thus only requires that `ptr` is
> >>     //   NULL or valid.
> > 
> > I'm fine adding it, but I'd like to understand why you think it's required in
> > the safety comment here? Isn't this implicit by being the type invariant?
> 
> You are calling a function pointer to an `unsafe` function that takes a
> raw pointer. Without this comment it is not clear what the function
> pointer's safety requirements are for the raw pointer parameter.

That's my point, isn't this implicitly clear by the type invariant? If needed,
shouldn't it be:

// INVARIANT:
// - `self.0` is one of [...]
//
// SAFETY:
// - `ptr` is either NULL or [...]

> 
> >>     // - `ptr` is either NULL or valid by the safety requirements of this function.
> > 
> > This is the part I already have.
> 
> I kept it to ensure that you also keep it.
> 
> >>>>> +        let raw_ptr = unsafe {
> >>>>> +            // If `size == 0` and `ptr != NULL` the memory behind the pointer is freed.
> >>>>> +            self.0(ptr.cast(), size, flags.0).cast()
> >>>>> +        };
> >>>>> +
> >>>>> +        let ptr = if size == 0 {
> >>>>> +            NonNull::dangling()
> >>>>> +        } else {
> >>>>> +            NonNull::new(raw_ptr).ok_or(AllocError)?
> >>>>> +        };
> >>>>> +
> >>>>> +        Ok(NonNull::slice_from_raw_parts(ptr, size))
> >>>>> +    }
> >>>>> +}
> >>>>> +
> >>>>> +unsafe impl Allocator for Kmalloc {
> >>>>
> >>>> Missing SAFETY comment.
> >>>
> >>> Yeah, I think we came across this in an earlier version of the series. I asked
> >>> you about the content and usefulness of a comment here, since I'd just end up
> >>> re-iterating what the `Allocator` trait documentation says.
> >>>
> >>> IIRC, you replied that you want to think of something that'd make sense to add
> >>> here.
> >>
> >> Oh yeah, sorry I forgot about that.
> >>
> >>> What do you think should be written here?
> >>
> >> I think the best way to do it, would be to push this question down into
> >> `ReallocFunc::call`. So we would put this on the trait:
> >>
> >>     // SAFETY: `realloc` delegates to `ReallocFunc::call`, which guarantees that
> >>     // - memory remains valid until it is explicitly freed,
> >>     // - passing a pointer to a vaild memory allocation is OK,
> >>     // - `realloc` satisfies the guarantees, since `ReallocFunc::call` has the same.
> > 
> > So, we'd also need the same for:
> >   - `unsafe impl Allocator for Vmalloc`
> >   - `unsafe impl Allocator for KVmalloc`
> 
> Yes.
> 
> >> We then need to put this on `ReallocFunc::call`:
> >>
> >>     /// # Guarantees
> >>     ///
> >>     /// This method has the same guarantees as `Allocator::realloc`. Additionally
> >>     /// - it accepts any pointer to a valid memory allocation allocated by this function.
> > 
> > You propose this, since for `Allocator::realloc` memory allocated with
> > `Allocator::alloc` would be fine too I guess.
> > 
> > But if e.g. `Kmalloc` wouldn't use the default `Allocator::alloc`, this would be
> > valid too.
> 
> So if `Kmalloc` were to implement `alloc` by not calling
> `ReallocFun::call`, then we couldn't use this comment. Do you think that
> such a change might be required at some point?

I don't think so, this was purely hypothetical. Let's stick to your proposal.

> 
> > We could instead write something like:
> > 
> > "it accepts any pointer to a valid memory allocation allocated with the same
> > kernel allocator."
> 
> It would be better, if we can keep it simpler (ie only `realloc` is
> implemented).
> 
> >>     /// - memory allocated by this function remains valid until it is passed to this function.
> > 
> > Same here, `Kmalloc` could implement its own `Allocator::free`.
> > 
> > Maybe just "...until it is explicitly freed.".
> 
> I don't really like that, since by that any other function could be
> meant. Do you need to override the `free` function? If not then it would
> be better.
> 
> > Anyway, I'm fine with both, since non of the kernel allocators uses anything
> > else than `ReallocFunc::call` to allocate and free memory.
> > 
> >>
> >> Finally, we need a `GUARANTEE` comment (just above the return [^1]
> >> value) that establishes these guarantees:
> >>
> >>     // GUARANTEE: Since we called `self.0` with `size` above and by the type invariants of `Self`,
> >>     // `self.0` is one of `krealloc`, `vrealloc`, `kvrealloc`. Those functions provide the guarantees of
> >>     // this function.
> >>
> >> I am not really happy with the last sentence, but I also don't think
> >> that there is value in listing out all the guarantees, only to then say
> >> "all of this is guaranteed by us calling one of these three functions.
> >>
> >>
> >> [^1]: I am not sure that there is the right place. If you have any
> >>       suggestions, feel free to share them.
> > 
> > Either way, I'm fine with this proposal.
> > 
> >>
> >>
> >>>>> +    #[inline]
> >>>>> +    unsafe fn realloc(
> >>>>> +        ptr: Option<NonNull<u8>>,
> >>>>> +        layout: Layout,
> >>>>> +        flags: Flags,
> >>>>> +    ) -> Result<NonNull<[u8]>, AllocError> {
> >>>>> +        // SAFETY: `ReallocFunc::call` has the same safety requirements as `Allocator::realloc`.
> >>>>> +        unsafe { ReallocFunc::KREALLOC.call(ptr, layout, flags) }
> >>>>> +    }
> >>>>> +}
> >>
> >> Oh one more thing, I know that you already have a lot of patches in this
> >> series, but could you split this one into two? So the first one should
> >> introduce `ReallocFunc` and the second one add the impl for `Kmalloc`?
> >> I managed to confuse me twice because of that :)
> > 
> > Generally, I'm fine with that, but I'm not sure if I can avoid an intermediate
> > compiler warning about unused code doing that.
> 
> You can just use `#[expect(dead_code)]` for that in the intermediate
> patches.

I usually try to avoid that, because it can be misleading when bisecting things.

If the temporarily unused code contains a bug, your bisection doesn't end up at
this patch, but some other patch that starts using it.

> 
> ---
> Cheers,
> Benno
> 

