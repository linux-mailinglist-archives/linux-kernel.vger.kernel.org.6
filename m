Return-Path: <linux-kernel+bounces-273913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4C4946F8E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 17:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021641C20A38
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C2F73459;
	Sun,  4 Aug 2024 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srl0srfE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6406541A8E;
	Sun,  4 Aug 2024 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722784609; cv=none; b=DtNURkSDSCN4ikIKlQ7A+zuO/mwsMHmy7vj8Lq5tmoXqrqOK1VzaLiVBol37DDwbqmN/hnUFic51ujQvp4aYjF7SLoIBbSki1o4KuIgMeL9tPTl9UznPUbiyEWoxyA6NysmNVpn8DaYBFYBSUcRrDT12uCh0BQN/+YHP8DfC5mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722784609; c=relaxed/simple;
	bh=PbZnK4gedPAzrBqyHpMY0nfx8YVLLtIZRcC5H3Bjs1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIZtCJ6TeU6w7qDF5m7vD+FEJF/tWDzmI7JSsDGuIrEZwfVxl7tgTn2DjLtMZ7DTSZ98nc2BYyJrwzR4unbRf3u4dg0sck63CWt8BHCjX6sl00sq1mBUQsOYwYXPSP3bSkVtKYxPcHcsfP/Y49mN5K40H4GlLmqDSkGAAMnq3h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srl0srfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0708C32786;
	Sun,  4 Aug 2024 15:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722784609;
	bh=PbZnK4gedPAzrBqyHpMY0nfx8YVLLtIZRcC5H3Bjs1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=srl0srfEMJcvmRAqdIpwre+Yi3D6o4YrHiWRuL9HMSi+MuiYU3pMzcgeJ7JOyVUPi
	 a7YJ0JVEftlsn46+su5RAYHi1Z0kZxi6vxakb/AjB8x9wBX6dl42AxcdD2mIHmmw7I
	 tMnuHtaKEjP/Yh9n04vsrBbWgdiw3FNUqs+R+RSm8pPEvP2L90NnFnUQKL471ESl6y
	 bWK/2YiidFSbeA05NSl2FQ0qWwOhHk3O5xvh1izP/Br+Nj74JzVYO+aAGsiSlQjdp/
	 QJSQJOUqV05g+5chIOQZlJL+8Od5tr8k9VrR4SLKkUAS8t8NJsLPKGo/qgaltFB+CU
	 mUi5O0eQVly3A==
Date: Sun, 4 Aug 2024 17:16:40 +0200
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
Message-ID: <Zq-bWJFwtWG23O-L@pollux>
References: <20240801000641.1882-1-dakr@kernel.org>
 <20240801000641.1882-7-dakr@kernel.org>
 <Zq8jamaDSKWmj_-4@boqun-archlinux>
 <Zq927hO2fcV5LJME@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zq927hO2fcV5LJME@pollux>

On Sun, Aug 04, 2024 at 02:41:26PM +0200, Danilo Krummrich wrote:
> On Sat, Aug 03, 2024 at 11:44:58PM -0700, Boqun Feng wrote:
> > On Thu, Aug 01, 2024 at 02:02:05AM +0200, Danilo Krummrich wrote:
> > > Implement `Allocator` for `Vmalloc`, the kernel's virtually contiguous
> > > allocator, typically used for larger objects, (much) larger than page
> > > size.
> > > 
> > > All memory allocations made with `Vmalloc` end up in `vrealloc()`.
> > > 
> > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > ---
> > >  rust/helpers.c                      |  8 ++++++++
> > >  rust/kernel/alloc/allocator.rs      | 24 ++++++++++++++++++++++++
> > >  rust/kernel/alloc/allocator_test.rs |  1 +
> > >  3 files changed, 33 insertions(+)
> > > 
> > > diff --git a/rust/helpers.c b/rust/helpers.c
> > > index 92d3c03ae1bd..4c628986f0c9 100644
> > > --- a/rust/helpers.c
> > > +++ b/rust/helpers.c
> > > @@ -33,6 +33,7 @@
> > >  #include <linux/sched/signal.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/spinlock.h>
> > > +#include <linux/vmalloc.h>
> > >  #include <linux/wait.h>
> > >  #include <linux/workqueue.h>
> > >  
> > > @@ -200,6 +201,13 @@ rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
> > >  }
> > >  EXPORT_SYMBOL_GPL(rust_helper_krealloc);
> > >  
> > > +void * __must_check __realloc_size(2)
> > > +rust_helper_vrealloc(const void *p, size_t size, gfp_t flags)
> > > +{
> > > +	return vrealloc(p, size, flags);
> > > +}
> > > +EXPORT_SYMBOL_GPL(rust_helper_vrealloc);
> > > +
> > >  /*
> > >   * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
> > >   * use it in contexts where Rust expects a `usize` like slice (array) indices.
> > > diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
> > > index 397ae5bcc043..e9a3d0694f41 100644
> > > --- a/rust/kernel/alloc/allocator.rs
> > > +++ b/rust/kernel/alloc/allocator.rs
> > > @@ -16,6 +16,12 @@
> > >  /// `bindings::krealloc`.
> > >  pub struct Kmalloc;
> > >  
> > > +/// The virtually contiguous kernel allocator.
> > > +///
> > > +/// The vmalloc allocator allocates pages from the page level allocator and maps them into the
> > > +/// contiguous kernel virtual space.
> > > +pub struct Vmalloc;
> > > +
> > >  /// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
> > >  fn aligned_size(new_layout: Layout) -> usize {
> > >      // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
> > > @@ -58,6 +64,10 @@ fn krealloc() -> Self {
> > >          Self(bindings::krealloc)
> > >      }
> > >  
> > > +    fn vrealloc() -> Self {
> > > +        Self(bindings::vrealloc)
> > > +    }
> > > +
> > >      // SAFETY: `call` has the exact same safety requirements as `Allocator::realloc`.
> > >      unsafe fn call(
> > >          &self,
> > > @@ -136,6 +146,20 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
> > >      }
> > >  }
> > >  
> > > +unsafe impl Allocator for Vmalloc {
> > > +    unsafe fn realloc(
> > > +        ptr: Option<NonNull<u8>>,
> > > +        layout: Layout,
> > > +        flags: Flags,
> > > +    ) -> Result<NonNull<[u8]>, AllocError> {
> > > +        let realloc = ReallocFunc::vrealloc();
> > > +
> > 
> > IIUC, vrealloc() calls __vmalloc_noprof() in allocation case, that is
> > calling __vmalloc_node_noprof() with align=1. In such a case, how would
> > vmalloc() guarantee the allocated memory is aligned to layout.align()?
> 
> True, good catch. I thought of this a while ago and then forgot to fix it.

Just for clarification, we're always PAGE_SIZE aligned (guaranteed by
__alloc_vmap_area()), which probably would always be sufficient. That's why I
didn't gave it too much attention in the first place and then forgot about it.

However, we indeed do not honor layout.align() if it's larger than PAGE_SIZE.

> 
> > 
> > [Cc Vlastimil]
> > 
> > Regards,
> > Boqun
> > 
> > > +        // SAFETY: If not `None`, `ptr` is guaranteed to point to valid memory, which was previously
> > > +        // allocated with this `Allocator`.
> > > +        unsafe { realloc.call(ptr, layout, flags) }
> > > +    }
> > > +}
> > > +
> > >  #[global_allocator]
> > >  static ALLOCATOR: Kmalloc = Kmalloc;
> > >  
> > > diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
> > > index 4785efc474a7..e7bf2982f68f 100644
> > > --- a/rust/kernel/alloc/allocator_test.rs
> > > +++ b/rust/kernel/alloc/allocator_test.rs
> > > @@ -7,6 +7,7 @@
> > >  use core::ptr::NonNull;
> > >  
> > >  pub struct Kmalloc;
> > > +pub type Vmalloc = Kmalloc;
> > >  
> > >  unsafe impl Allocator for Kmalloc {
> > >      unsafe fn realloc(
> > > -- 
> > > 2.45.2
> > > 
> > 

