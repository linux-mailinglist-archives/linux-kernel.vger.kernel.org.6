Return-Path: <linux-kernel+bounces-355402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989F09951B7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01FD282D00
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3951DFE3F;
	Tue,  8 Oct 2024 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Swn+8EiC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B47E1DFE01;
	Tue,  8 Oct 2024 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397727; cv=none; b=I41ZKelonFQ38X5Tj397SeTZxnsDLMt1h9WF0rja59NPI2WpO6vglf/OuWtyhp1N6wj/fyOxBhr8Jpd++ASbs9V82LpowxydxbEvMvl1r5rDm/CTiW7biHLZMT/sz9fqFj9TmXSwqlVJYdOvRWOVUhdGWBiH7bHftNou4maS/qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397727; c=relaxed/simple;
	bh=BtF+69VuIRUK1uTxBr4lzaNIIAyljbKUCyvoyJAl0BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYKuJb5u9n8uwk2zwXpIx43kt784xT9udWcND5cqNekwl80ibJlHVAkpEOyO6cO8daJCWtcyFG0w7/UtS7KOzzmqTL/x8w7OIvE3PiwlFu2ja3QMfKS08EJJlCOgC2l9o8Hz/8OqrbdTCPofMaZ4ymUOHN/1oL20B/fFdWJ2oko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Swn+8EiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F499C4CEC7;
	Tue,  8 Oct 2024 14:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728397727;
	bh=BtF+69VuIRUK1uTxBr4lzaNIIAyljbKUCyvoyJAl0BU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Swn+8EiCXtFOKeIG+2gplGfRpU2qKSBgOMOi1MaAoqX/MYCsE2fKRSTcv+GvnX+zo
	 wXnDUPnv7ND9HtZcfUc4T36rZGIq++EjaIUcWOlN22eIgyhybOZ67fEwrurw4PEPl6
	 Av+owJjgIGE/JuxPYxGnxcFgq+mY5Z7kBwWDYHfthDh0cbIcmrqrYn9HBrr/mjsvdH
	 M7Ckaso6eaenNnSBFZHD6HiL0tO4z9VGpiAnKXg30tfD1kZZB9WHTxauGiUepvQKGq
	 EzIJ4ZILwvioZ4E47z3YwcR3ZcIgjMrhkfCABJWOfSuc/hogPGliPs1ClQ1ZzC2R/Z
	 lMhUC1HgVSgWw==
Date: Tue, 8 Oct 2024 16:28:38 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v9 07/29] rust: alloc: add module `allocator_test`
Message-ID: <ZwVBliUmvM_1P4a2@cassiopeiae>
References: <20241004154149.93856-1-dakr@kernel.org>
 <20241004154149.93856-8-dakr@kernel.org>
 <ZwUvT4Zsg-1Dww8b@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwUvT4Zsg-1Dww8b@boqun-archlinux>

On Tue, Oct 08, 2024 at 06:10:39AM -0700, Boqun Feng wrote:
> On Fri, Oct 04, 2024 at 05:41:11PM +0200, Danilo Krummrich wrote:
> > `Allocator`s, such as `Kmalloc`, will be used by e.g. `Box` and `Vec` in
> > subsequent patches, and hence this dependency propagates throughout the
> > whole kernel.
> > 
> > Add the `allocator_test` module that provides an empty implementation
> > for all `Allocator`s in the kernel, such that we don't break the
> > `rusttest` make target in subsequent patches.
> > 
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > Reviewed-by: Gary Guo <gary@garyguo.net>
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/alloc.rs                |  9 +++++++--
> >  rust/kernel/alloc/allocator_test.rs | 19 +++++++++++++++++++
> >  2 files changed, 26 insertions(+), 2 deletions(-)
> >  create mode 100644 rust/kernel/alloc/allocator_test.rs
> > 
> > diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> > index 91b2a26faf3d..f8ddc8d96da9 100644
> > --- a/rust/kernel/alloc.rs
> > +++ b/rust/kernel/alloc.rs
> > @@ -2,12 +2,17 @@
> >  
> >  //! Extensions to the [`alloc`] crate.
> >  
> > -#[cfg(not(test))]
> > -#[cfg(not(testlib))]
> > +#[cfg(not(any(test, testlib)))]
> >  pub mod allocator;
> >  pub mod box_ext;
> >  pub mod vec_ext;
> >  
> > +#[cfg(any(test, testlib))]
> > +pub mod allocator_test;
> > +
> > +#[cfg(any(test, testlib))]
> > +pub use self::allocator_test as allocator;
> > +
> >  /// Indicates an allocation error.
> >  #[derive(Copy, Clone, PartialEq, Eq, Debug)]
> >  pub struct AllocError;
> > diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
> > new file mode 100644
> > index 000000000000..4785efc474a7
> > --- /dev/null
> > +++ b/rust/kernel/alloc/allocator_test.rs
> > @@ -0,0 +1,19 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#![allow(missing_docs)]
> > +
> > +use super::{AllocError, Allocator, Flags};
> > +use core::alloc::Layout;
> > +use core::ptr::NonNull;
> > +
> > +pub struct Kmalloc;
> > +
> > +unsafe impl Allocator for Kmalloc {
> > +    unsafe fn realloc(
> > +        _ptr: Option<NonNull<u8>>,
> > +        _layout: Layout,
> 
> The `old_layout` parameter is missing here.

Thanks, good catch.

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index f8ddc8d96da9..28281d600492 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -193,6 +193,7 @@ unsafe fn free(ptr: NonNull<u8>, layout: Layout) {
     }
 }

+#[allow(dead_code)]
 /// Returns a properly aligned dangling pointer from the given `layout`.
 pub(crate) fn dangling_from_layout(layout: Layout) -> NonNull<u8> {
     let ptr = layout.align() as *mut u8;
diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
index 4785efc474a7..c5d325506f0c 100644
--- a/rust/kernel/alloc/allocator_test.rs
+++ b/rust/kernel/alloc/allocator_test.rs
@@ -12,6 +12,7 @@ unsafe impl Allocator for Kmalloc {
     unsafe fn realloc(
         _ptr: Option<NonNull<u8>>,
         _layout: Layout,
+        _old_layout: Layout,
         _flags: Flags,
     ) -> Result<NonNull<[u8]>, AllocError> {
         panic!();

We also have to fix an intermediate dead code warning for `dangling_from_layout`
in the `rusttest` target, until we start using it when we implement `Cmalloc`
in this module.

