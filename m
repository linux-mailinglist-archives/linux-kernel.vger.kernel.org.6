Return-Path: <linux-kernel+bounces-273837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2A4946EB8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 14:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877FA1F21ADF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 12:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BBF39FDD;
	Sun,  4 Aug 2024 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmMd/l8I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7FB1173F;
	Sun,  4 Aug 2024 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722775287; cv=none; b=VnbDxyqINF98NAKqkwZwdQk8bHCpqwUUnNp98Y2whZ/1e8VEErT2oa2KCUbmaHvSDMhoMgo9wiX30S5nCybZYOb6mIMQip08WFFTr68fmgNkOTU1DCUTwMpQUIe1AsS/a/QZhxtp5DlWP88Y4uTH7EtYgEKvnbpc8Zl/4YFWq0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722775287; c=relaxed/simple;
	bh=hkFT8J4L9Om4+1HcbHi/qiwu8V1ZSM/CvwWOwoQr0e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9caRLR3gGP/3ny8F2i3YfxJxWElvIG1PLIIQu3X9uhakdvimd1PEb9Y1OR4OmYOBuaOhn6ghLX/IAsn0LHCFsRZUM+0Ylozlf8KX+N1/HPrIAs1d8aGqBA3x7dAjI+udP/Gi+AU7PDhDW/MiZHP6INJ8+9cpCC3rlPsmhv2/QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmMd/l8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F91C32786;
	Sun,  4 Aug 2024 12:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722775286;
	bh=hkFT8J4L9Om4+1HcbHi/qiwu8V1ZSM/CvwWOwoQr0e8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmMd/l8It6O1W9JfjmfFDGfYINuZODnSID4KpxkP0NtekvoU6YrUG6NYN4ZH/9pHI
	 xKxZvIrMwrj8q4i7KrWJT39S04ic5s9qQq7iFy/UELIirE1HrUGviqhr7huOBefZDx
	 /yU+RSogpIaiWwH7soxSXz7rXVLSDE4WwG/KUA0PPvIT2IjS/g3PnZO8JlZGwNYmMr
	 sZeSuD9DO2pZ3clQWq/zqoF59jPhJFhfEnz3zu0JG6Fmz93XkNcfySbnV8BdDEb+0r
	 1vvYtJq4IXoyO9u8xoCthfh9FBWYztH89C1NqUAEVzHIV34jE+2xwOqGTJh82rYVfD
	 Jifkz6piRomIg==
Date: Sun, 4 Aug 2024 14:41:18 +0200
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
	linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3 06/25] rust: alloc: implement `Vmalloc` allocator
Message-ID: <Zq927hO2fcV5LJME@pollux>
References: <20240801000641.1882-1-dakr@kernel.org>
 <20240801000641.1882-7-dakr@kernel.org>
 <Zq8jamaDSKWmj_-4@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zq8jamaDSKWmj_-4@boqun-archlinux>

On Sat, Aug 03, 2024 at 11:44:58PM -0700, Boqun Feng wrote:
> On Thu, Aug 01, 2024 at 02:02:05AM +0200, Danilo Krummrich wrote:
> > Implement `Allocator` for `Vmalloc`, the kernel's virtually contiguous
> > allocator, typically used for larger objects, (much) larger than page
> > size.
> > 
> > All memory allocations made with `Vmalloc` end up in `vrealloc()`.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/helpers.c                      |  8 ++++++++
> >  rust/kernel/alloc/allocator.rs      | 24 ++++++++++++++++++++++++
> >  rust/kernel/alloc/allocator_test.rs |  1 +
> >  3 files changed, 33 insertions(+)
> > 
> > diff --git a/rust/helpers.c b/rust/helpers.c
> > index 92d3c03ae1bd..4c628986f0c9 100644
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
> > @@ -200,6 +201,13 @@ rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
> >  }
> >  EXPORT_SYMBOL_GPL(rust_helper_krealloc);
> >  
> > +void * __must_check __realloc_size(2)
> > +rust_helper_vrealloc(const void *p, size_t size, gfp_t flags)
> > +{
> > +	return vrealloc(p, size, flags);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_vrealloc);
> > +
> >  /*
> >   * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
> >   * use it in contexts where Rust expects a `usize` like slice (array) indices.
> > diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
> > index 397ae5bcc043..e9a3d0694f41 100644
> > --- a/rust/kernel/alloc/allocator.rs
> > +++ b/rust/kernel/alloc/allocator.rs
> > @@ -16,6 +16,12 @@
> >  /// `bindings::krealloc`.
> >  pub struct Kmalloc;
> >  
> > +/// The virtually contiguous kernel allocator.
> > +///
> > +/// The vmalloc allocator allocates pages from the page level allocator and maps them into the
> > +/// contiguous kernel virtual space.
> > +pub struct Vmalloc;
> > +
> >  /// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
> >  fn aligned_size(new_layout: Layout) -> usize {
> >      // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
> > @@ -58,6 +64,10 @@ fn krealloc() -> Self {
> >          Self(bindings::krealloc)
> >      }
> >  
> > +    fn vrealloc() -> Self {
> > +        Self(bindings::vrealloc)
> > +    }
> > +
> >      // SAFETY: `call` has the exact same safety requirements as `Allocator::realloc`.
> >      unsafe fn call(
> >          &self,
> > @@ -136,6 +146,20 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
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
> 
> IIUC, vrealloc() calls __vmalloc_noprof() in allocation case, that is
> calling __vmalloc_node_noprof() with align=1. In such a case, how would
> vmalloc() guarantee the allocated memory is aligned to layout.align()?

True, good catch. I thought of this a while ago and then forgot to fix it.

> 
> [Cc Vlastimil]
> 
> Regards,
> Boqun
> 
> > +        // SAFETY: If not `None`, `ptr` is guaranteed to point to valid memory, which was previously
> > +        // allocated with this `Allocator`.
> > +        unsafe { realloc.call(ptr, layout, flags) }
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

