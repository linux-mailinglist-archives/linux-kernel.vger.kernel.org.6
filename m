Return-Path: <linux-kernel+bounces-276749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8D29497EA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9607328286D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5392713A256;
	Tue,  6 Aug 2024 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWsa3t3H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8103C18D62B;
	Tue,  6 Aug 2024 19:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722970927; cv=none; b=GbSkO423UphC0YN7E253jReqS9P76EzZLBL2nfL8V5f1k5QtvPwORGmhUgLrsiUxoj8ZtNgD0K8QvBrFYhRNaVvpPB7v2TZPusC3MM49Oz6gynbmjspg8JpSikjS3XQ4ZVv7zVM04SUcZMeDHv2YwrHdAD22hChBT9TIj68xf4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722970927; c=relaxed/simple;
	bh=TBl8id+DSOkkUFr0wDj1Ebkzy6B9Ng7VWJGI2+jSPAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHn93yFhqcz3FoEq1yqgMVwCdT71J3+RGVOS7ArI8gh3I3necCVuEjXg5M9hbndVupPxUH5sqrWv2WASJmCh0tsV7Ku89U0G52Fk3ni4YBobVw7lKhhPFvgtLgUpQDP20VkYupW6DNLnTFCrOtkqv7SG9a3V5NcnW8u7xTep2jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWsa3t3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F60DC32786;
	Tue,  6 Aug 2024 19:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722970927;
	bh=TBl8id+DSOkkUFr0wDj1Ebkzy6B9Ng7VWJGI2+jSPAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bWsa3t3H+LJHTRg4/sMvFI4eSbmcq92Mm692DtrP1tanquNCtvo8wAAZfsH9z9cSt
	 MHpD3jPGbVBuVSPgC35H6I9Dt22IPhB8/YraUhRAJRaNm8Rcv1DfZlH4IQfFBqKj4o
	 X+EsJv0jmyPCjIcVDy9r2fgUN4rDu4epOFXf4Wi0yGP9MYusXI5uK6LNpfP7Jq1bp3
	 rg+SDW11CiHdjwJErYoVslC5OW5wDnwxDiZow6cWdZMJ1Yu773AVyH4evHwJBwKJv8
	 Dp1rZiraye/rl71jd3LihIWMDeOndgGKc5HNMhKFQi1zxPLPZclIlKTy40myI5i9Tr
	 ORGddREPkUmMQ==
Date: Tue, 6 Aug 2024 21:01:59 +0200
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
Subject: Re: [PATCH v4 06/28] rust: alloc: implement `Vmalloc` allocator
Message-ID: <ZrJzJyj7kej0hA0p@pollux.localdomain>
References: <20240805152004.5039-1-dakr@kernel.org>
 <20240805152004.5039-7-dakr@kernel.org>
 <9c144953-819d-44fa-9bb5-af6fa93a5042@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c144953-819d-44fa-9bb5-af6fa93a5042@proton.me>

On Tue, Aug 06, 2024 at 05:00:24PM +0000, Benno Lossin wrote:
> On 05.08.24 17:19, Danilo Krummrich wrote:
> > Implement `Allocator` for `Vmalloc`, the kernel's virtually contiguous
> > allocator, typically used for larger objects, (much) larger than page
> > size.
> > 
> > All memory allocations made with `Vmalloc` end up in `vrealloc()`.
> > 
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/helpers.c                      |  7 +++++++
> >  rust/kernel/alloc/allocator.rs      | 32 +++++++++++++++++++++++++++++
> >  rust/kernel/alloc/allocator_test.rs |  1 +
> >  3 files changed, 40 insertions(+)
> > 
> > diff --git a/rust/helpers.c b/rust/helpers.c
> > index 9f7275493365..7406943f887d 100644
> > --- a/rust/helpers.c
> > +++ b/rust/helpers.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/sched/signal.h>
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/vmalloc.h>
> >  #include <linux/wait.h>
> >  #include <linux/workqueue.h>
> > 
> > @@ -199,6 +200,12 @@ void *rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
> >  }
> >  EXPORT_SYMBOL_GPL(rust_helper_krealloc);
> > 
> > +void *rust_helper_vrealloc(const void *p, size_t size, gfp_t flags)
> > +{
> > +	return vrealloc(p, size, flags);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_vrealloc);
> > +
> >  /*
> >   * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
> >   * use it in contexts where Rust expects a `usize` like slice (array) indices.
> > diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
> > index c6ad1dd59dd0..bb55895cbd03 100644
> > --- a/rust/kernel/alloc/allocator.rs
> > +++ b/rust/kernel/alloc/allocator.rs
> > @@ -9,6 +9,7 @@
> > 
> >  use crate::alloc::{AllocError, Allocator};
> >  use crate::bindings;
> > +use crate::pr_warn;
> > 
> >  /// The contiguous kernel allocator.
> >  ///
> > @@ -16,6 +17,12 @@
> >  /// `bindings::krealloc`.
> >  pub struct Kmalloc;
> > 
> > +/// The virtually contiguous kernel allocator.
> > +///
> > +/// The vmalloc allocator allocates pages from the page level allocator and maps them into the
> > +/// contiguous kernel virtual space.
> > +pub struct Vmalloc;
> 
> One thing that I should also have mentioned for `Kmalloc`, do we want
> these types to also have values? I don't think that we need them to be,
> so we could declare them as `pub enum Vmalloc {}`.

What the difference? Would `pub enum Vmalloc {}` be better for some reason?

> 
> > +
> >  /// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
> >  fn aligned_size(new_layout: Layout) -> usize {
> >      // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
> > @@ -61,6 +68,11 @@ fn krealloc() -> Self {
> >          Self(bindings::krealloc)
> >      }
> > 
> > +    // INVARIANT: `vrealloc` satisfies the type invariants.
> 
> This should be moved down a line.
> 
> ---
> Cheers,
> Benno
> 
> > +    fn vrealloc() -> Self {
> > +        Self(bindings::vrealloc)
> > +    }
> > +
> >      /// # Safety
> >      ///
> >      /// This method has the exact same safety requirements as `Allocator::realloc`.
> > @@ -141,6 +153,26 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
> >      }
> >  }
> > 
> > +unsafe impl Allocator for Vmalloc {
> > +    unsafe fn realloc(
> > +        ptr: Option<NonNull<u8>>,
> > +        layout: Layout,
> > +        flags: Flags,
> > +    ) -> Result<NonNull<[u8]>, AllocError> {
> > +        let realloc = ReallocFunc::vrealloc();
> > +
> > +        // TODO: Support alignments larger than PAGE_SIZE.
> > +        if layout.align() > bindings::PAGE_SIZE {
> > +            pr_warn!("Vmalloc does not support alignments larger than PAGE_SIZE yet.\n");
> > +            return Err(AllocError);
> > +        }
> > +
> > +        // SAFETY: If not `None`, `ptr` is guaranteed to point to valid memory, which was previously
> > +        // allocated with this `Allocator`.
> > +        unsafe { realloc.call(ptr, layout, flags) }
> 
> I am a bit confused, for `Kmalloc`, you manually returned
> `NonNull::dangling` when allocating a zero-sized allocation, but here
> you don't?
> 

I do, it's the exact same implementation for krealloc(), vrealloc() and
kvrealloc(). That why I added the `ReallocFunc` abstraction.

> ---
> Cheers,
> Benno
> 
> > +    }
> > +}
> > +
> >  #[global_allocator]
> >  static ALLOCATOR: Kmalloc = Kmalloc;
> > 
> > diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
> > index 4785efc474a7..e7bf2982f68f 100644
> > --- a/rust/kernel/alloc/allocator_test.rs
> > +++ b/rust/kernel/alloc/allocator_test.rs
> > @@ -7,6 +7,7 @@
> >  use core::ptr::NonNull;
> > 
> >  pub struct Kmalloc;
> > +pub type Vmalloc = Kmalloc;
> > 
> >  unsafe impl Allocator for Kmalloc {
> >      unsafe fn realloc(
> > --
> > 2.45.2
> > 
> 

