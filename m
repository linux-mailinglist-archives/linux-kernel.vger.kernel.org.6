Return-Path: <linux-kernel+bounces-271250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D674944BA0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939EA1F22E2E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3691A0721;
	Thu,  1 Aug 2024 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReNm/kjV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB94166305;
	Thu,  1 Aug 2024 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722516347; cv=none; b=XwGRXrjD+DjUXpPbQeyGKtcUBBQ9txOTYKadfYwbUow3TO3sT5tWuRATGwys5nbVdUj5PtFfD9dgRD44maLIUE0L8oA47FRQ5ZRLU77AxADV4OlLIn1qmNAZxaXbigZxzORqEMjJ3ZHm0SNxJ8HDbYR93I9Cu+71wgIkrKjWNaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722516347; c=relaxed/simple;
	bh=uFy9XegXfV2RfEhcBYqHt6jbexjmhCmWnhmt33f0e3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOnPOUmsxJ+mPEHY+QNScRWpbEgZCxNElhhL7mfTOlC+FYq0JaqEdrNhiMpwOWP1RDxs+hVnjnm2nrENAW9mEhgg5jvOVMZjpZqf/htY4YO5Kec2iz1ae3A0Pavo+l5zMh80loCYoeq+ircOeeLyJmsPLTGyQqHm2kmNQoEzSpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReNm/kjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13129C32786;
	Thu,  1 Aug 2024 12:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722516346;
	bh=uFy9XegXfV2RfEhcBYqHt6jbexjmhCmWnhmt33f0e3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ReNm/kjVk52BNkKSLm5Fc+fcd6UmE4GYHHIJAiNCo6ef7gmgAhCN0gHs0w/iAP18/
	 ZU2EDQnPY8dhP9QHKHFmY7sCO+62u76yNrFWO9PQnttSNThf3g3XybQQxWRqLfzF3z
	 UNe9qo5EzNdgfzYSJ5aFlI3+1AYgiBQAbw8zxPD2wG3J+lZG3kLwWM+DmNqZmwf7VN
	 3jUZwY0of5Zmpm/wZt1xJRnse3u3pcZ5OSbOtUlxnHOEwuI5KMtkgLuLueCqRqfy5Y
	 59MXcnzxuDm41p84NBrKSiGSL9R0CbDsy+vPEWKJXRzqsaIFbhCaxZCJnAbGDnCnAR
	 ZSC02tZxY2Tdw==
Date: Thu, 1 Aug 2024 14:45:38 +0200
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
Subject: Re: [PATCH v3 09/25] rust: alloc: implement kernel `Box`
Message-ID: <ZquDcoPg2CzlPbpU@pollux>
References: <20240801000641.1882-1-dakr@kernel.org>
 <20240801000641.1882-10-dakr@kernel.org>
 <CAH5fLggjs8t2c1GVFdQu6gULjG_oYx7299m4NedQFS+hOgFfTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLggjs8t2c1GVFdQu6gULjG_oYx7299m4NedQFS+hOgFfTw@mail.gmail.com>

On Thu, Aug 01, 2024 at 10:55:51AM +0200, Alice Ryhl wrote:
> On Thu, Aug 1, 2024 at 2:07 AM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > `Box` provides the simplest way to allocate memory for a generic type
> > with one of the kernel's allocators, e.g. `Kmalloc`, `Vmalloc` or
> > `KVmalloc`.
> >
> > In contrast to Rust's `Box` type, the kernel `Box` type considers the
> > kernel's GFP flags for all appropriate functions, always reports
> > allocation failures through `Result<_, AllocError>` and remains
> > independent from unstable features.
> >
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> >
> > [...]
> >
> > +    /// Constructs a `Box<T, A>` from a raw pointer.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `raw` must point to valid memory, previously allocated with `A`, and at least the size of
> > +    /// type `T`.
> > +    #[inline]
> > +    pub const unsafe fn from_raw_alloc(raw: *mut T, alloc: PhantomData<A>) -> Self {
> > +        // SAFETY: Safe by the requirements of this function.
> > +        Box(unsafe { Unique::new_unchecked(raw) }, alloc)
> > +    }
> 
> I don't think it makes sense to take the PhantomData as a parameter.
> You can always create a PhantomData value out of thin air.
> 
> Box(unsafe { Unique::new_unchecked(raw) }, PhantomData)
> 
> > +    /// Consumes the `Box<T, A>`, returning a wrapped raw pointer and `PhantomData` of the allocator
> > +    /// it was allocated with.
> > +    pub fn into_raw_alloc(b: Self) -> (*mut T, PhantomData<A>) {
> > +        let b = ManuallyDrop::new(b);
> > +        let alloc = unsafe { ptr::read(&b.1) };
> > +        (b.0.as_ptr(), alloc)
> > +    }
> 
> I don't think there's any need to have this function. The caller can
> always create the PhantomData themselves. I would just keep into_raw
> only.

Agreed, I actually intended to remove this one and the above.

> 
> > +    /// Converts a `Box<T>` into a `Pin<Box<T>>`.
> > +    #[inline]
> > +    pub fn into_pin(b: Self) -> Pin<Self>
> > +    where
> > +        A: 'static,
> > +    {
> > +        // SAFETY: It's not possible to move or replace the insides of a `Pin<Box<T>>` when
> > +        // `T: !Unpin`, so it's safe to pin it directly without any additional requirements.
> > +        unsafe { Pin::new_unchecked(b) }
> > +    }
> 
> In the standard library, this functionality is provided using the From
> trait rather than an inherent method. I think it makes sense to match
> std here.

I already provide `impl<T, A> From<Box<T, A>> for Pin<Box<T, A>>` in this patch,
which just calls `Box::into_pin`.

> 
> > +impl<T, A> Drop for Box<T, A>
> > +where
> > +    T: ?Sized,
> > +    A: Allocator,
> > +{
> > +    fn drop(&mut self) {
> > +        let ptr = self.0.as_ptr();
> > +
> > +        // SAFETY: We need to drop `self.0` in place, before we free the backing memory.
> > +        unsafe { core::ptr::drop_in_place(ptr) };
> > +
> > +        // SAFETY: `ptr` is always properly aligned, dereferenceable and points to an initialized
> > +        // instance of `T`.
> > +        if unsafe { core::mem::size_of_val(&*ptr) } != 0 {
> > +            // SAFETY: `ptr` was previously allocated with `A`.
> > +            unsafe { A::free(self.0.as_non_null().cast()) };
> > +        }
> 
> You just destroyed the value by calling `drop_in_place`, so `ptr` no
> longer points at an initialized instance of `T`. Please compute
> whether the allocation has non-zero size before you call
> `drop_in_place`.

Huh! Good catch. No idea how I missed that.

> 
> Also, in normal Rust this code would leak the allocation on panic in
> the destructor. We may not care, but it's worth taking into account if
> anybody else copies this code to a different project with a different
> panic configuration.

I can add a corresponding note.

> 
> > +impl<T: 'static, A> ForeignOwnable for crate::alloc::Box<T, A>
> > +where
> > +    A: Allocator,
> > +{
> > +    type Borrowed<'a> = &'a T;
> > +
> > +    fn into_foreign(self) -> *const core::ffi::c_void {
> > +        crate::alloc::Box::into_raw(self) as _
> > +    }
> > +
> > +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
> > +        // SAFETY: The safety requirements for this function ensure that the object is still alive,
> > +        // so it is safe to dereference the raw pointer.
> > +        // The safety requirements of `from_foreign` also ensure that the object remains alive for
> > +        // the lifetime of the returned value.
> > +        unsafe { &*ptr.cast() }
> > +    }
> > +
> > +    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
> > +        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
> > +        // call to `Self::into_foreign`.
> > +        unsafe { crate::alloc::Box::from_raw(ptr as _) }
> > +    }
> > +}
> 
> You may want to also implement ForeignOwnable for Pin<Box<T>>. See:
> https://lore.kernel.org/all/20240730-foreign-ownable-pin-box-v1-1-b1d70cdae541@google.com/

Yeah, I think I've also seen another patch that it about to add a function to
convert a `Box` back into uninit state.

Depending how fast you need ForeignOwnable for Pin<Box<T>>, do you prefer to
contribute a corresponding patch to this series?

> 
> Alice
> 

