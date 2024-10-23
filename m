Return-Path: <linux-kernel+bounces-377714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0D89AC2C6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2608283F6F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFA519ABDC;
	Wed, 23 Oct 2024 09:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ak2xgudQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881461974EA;
	Wed, 23 Oct 2024 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674238; cv=none; b=vCANMK28kf7WAHqnNmnCvTJftvDxEEuRfKAfkJF8DNx866fSNnqwt77aN8waXyHVcl05RYeWd+9bCgGSFH/uxvdf7yKWcFmfCKTLRUFDzWVoZJfORIjxEWSjxbcngIDMldnZtCAfrutSzVQte/X9VDuXYgaquh5Prrsof8v093w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674238; c=relaxed/simple;
	bh=f0UzGxPpvQRIc0duiwaTg8kcu39teOFFoiLzFqYgr1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTlYH8GNse0dLD0YKkgNWoWQeCq3rEUnWl7ojsfjLKVNVYbxGWTDXt/OAQrXcM0DKZJNCnpKjYylg9eEh7lzgi67SR/JPOF/RT4/S8zxUIsRxDVuSialkUk2d+Z9hvswwt734ZxMv7/NJ66CRvEHLnWzTLop6uYEHKJdvEYAzCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ak2xgudQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CECEC4CEC6;
	Wed, 23 Oct 2024 09:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729674238;
	bh=f0UzGxPpvQRIc0duiwaTg8kcu39teOFFoiLzFqYgr1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ak2xgudQPR3NhfLpGJYAoAQ6kEMyN0lnhznv2GoL/Ps7GpITepP7qqVV9KVz7JeDp
	 oxT8lxh8BL26kbexAHZtA2nSCiDIUsjWfqp3hquk+NNrGzo2uhW2QCbHwbKpFxi3ZL
	 Ko+UCa8ZW430pESJm4kyCp4wub8ZV3RuH2xyBzvZ0Ak/5cvGe83b6aUUpyk7/84RDa
	 r5xm1k2E4B9QLy1Ay5vsbeLpR+eSnQeH+zGFhcO96MuD2qF0vyKfmTXZ9Y+BqXjQE8
	 rLgEDu4txy2UFnRvyan4IxLODifAwVzYq7tRn5BIR7qEc5qXwBFypiYroz1kPfvqcn
	 Ys/ANwrlQqNUg==
Date: Wed, 23 Oct 2024 11:03:52 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, aliceryhl@google.com, dakr@redhat.com,
	linux-kernel@vger.kernel.org, airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com, boqun.feng@gmail.com
Subject: Re: [PATCH v2 3/5] rust: page: Extend support to vmalloc_to_page
Message-ID: <Zxi7-Gaf0U3xRdQt@pollux>
References: <20241022224832.1505432-1-abdiel.janulgue@gmail.com>
 <20241022224832.1505432-4-abdiel.janulgue@gmail.com>
 <Zxi287W_MJcMB4YO@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxi287W_MJcMB4YO@pollux>

On Wed, Oct 23, 2024 at 10:42:27AM +0200, Danilo Krummrich wrote:
> On Wed, Oct 23, 2024 at 01:44:47AM +0300, Abdiel Janulgue wrote:
> > Extend Page to support pages that are not allocated by the constructor, for
> > example, those returned by vmalloc_to_page(). Since we don't own those pages
> > we shouldn't Drop them either. Hence we take advantage of the switch to Opaque
> > so we can cast to a Page pointer from a struct page pointer and be able to
> > retrieve the reference on an existing struct page mapping. In this case
> > no destructor will be called since we are not instantiating a new Page instance.
> > 
> > Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> > ---
> >  rust/kernel/page.rs | 32 ++++++++++++++++++++++++++++++--
> >  1 file changed, 30 insertions(+), 2 deletions(-)
> > 
> > diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> > index a8288c15b860..465928986f4b 100644
> > --- a/rust/kernel/page.rs
> > +++ b/rust/kernel/page.rs
> > @@ -31,11 +31,12 @@ pub const fn page_align(addr: usize) -> usize {
> >      (addr + (PAGE_SIZE - 1)) & PAGE_MASK
> >  }
> >  
> > -/// A pointer to a page that owns the page allocation.
> > +/// A pointer to a page that may own the page allocation.
> >  ///
> >  /// # Invariants
> >  ///
> > -/// The pointer is valid, and has ownership over the page.
> > +/// The pointer is valid, and has ownership over the page if the page is allocated by this
> > +/// abstraction.
> >  #[repr(transparent)]
> >  pub struct Page {
> >      page: Opaque<bindings::page>,
> > @@ -88,6 +89,33 @@ pub fn alloc_page(flags: Flags) -> Result<Owned<Self>, AllocError> {
> >          Ok(unsafe { Owned::to_owned(ptr) })
> >      }
> >  
> > +    /// This is just a wrapper to vmalloc_to_page which returns an existing page mapping, hence
> 
> In documentation, try to avoid filler words, such as "just". Better say
> something like:
> 
> "This is an abstraction around the C `vmalloc_to_page()` function. Note that by
> a call to this function the caller doesn't take ownership of the returned `Page`
> [...]."
> 
> > +    /// we don't take ownership of the page. Returns an error if the pointer is null or if it
> > +    /// is not returned by vmalloc().
> > +    pub fn vmalloc_to_page<'a>(
> > +        cpu_addr: *const core::ffi::c_void
> 
> When you have a raw pointer argument in your function it becomes unsafe by
> definition.

Actually, this was phrased badly, the pointer must also be dereferenced by the
function in some way to become unsafe (which `vmalloc_to_page` does).

> 
> I also think it would also be better to pass a `NonNull<u8>` instead.
> 
> > +    ) -> Result<&'a Self, AllocError>
> 
> Please don't use `AllocError`. We're not allocating anything here.
> 
> Anyway, do we need this as a separate function at all?
> 
> > +    {
> > +        if cpu_addr.is_null() {
> > +            return Err(AllocError);
> > +        }
> > +        // SAFETY: We've checked that the pointer is not null, so it is safe to call this method.
> > +        if unsafe { !bindings::is_vmalloc_addr(cpu_addr) } {
> > +            return Err(AllocError);
> > +        }
> > +        // SAFETY: We've initially ensured the pointer argument to this function is not null and
> > +        // checked for the requirement the the buffer passed to it should be allocated by vmalloc,
> > +        // so it is safe to call this method.

More specifically, `is_vmalloc_addr()` only checks that the address is between
`VMALLOC_START` and `VMALLOC_END`, but not whether it's pointing to a valid
allocation.

So, this isn't safe unless you make it a safety requirement of your function.

> > +        let page = unsafe { bindings::vmalloc_to_page(cpu_addr) };
> > +        if page.is_null() {
> > +            return Err(AllocError);
> > +        }
> 
> I think those should all return `EINVAL` instead.
> 
> > +        // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::page`.
> > +        // SAFETY: We just successfully allocated a page, therefore dereferencing
> > +        // the page pointer is valid.
> > +        Ok(unsafe { &*page.cast() })
> > +    }
> > +
> >      /// Returns a raw pointer to the page.
> >      pub fn as_ptr(&self) -> *mut bindings::page {
> >          self.page.get()
> > -- 
> > 2.43.0
> > 
> 

