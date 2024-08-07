Return-Path: <linux-kernel+bounces-277718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4B394A53C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7845C1F21FFE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76251DD39D;
	Wed,  7 Aug 2024 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYv3NekZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F031C9DC9;
	Wed,  7 Aug 2024 10:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723025828; cv=none; b=eslz3wtJIZwOFvrrj2GJwRKXvp+EopSHhDdCBj0Wth765mFdMbEfRHFJc7/63JtgYwbuvEl7ywVAXefVfo1uzrzxYsRRtotCUfT2zafUh/YjqrEbbGP5laiubqu0DufaX+1kgtUcLP+/O+MDQ/yzXSfwTEr/+rGVHG2NCMzp1VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723025828; c=relaxed/simple;
	bh=Ps0tNdklgBZ8UoW92I7832USgziviwaLCHV/lVDnt7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsqLPyk1Yvlpa5y7fVxUVxBgGrR9eKgDarxy9OzcIbeKThVpnkFZGbUrQen3EvKq7ytsifvU1Y9XtZi5IyQCjcZBj8BF4XyxmgsntSxVfiWOFqfNbhh1WgXt6PBX5ycnH6wgZMbppI6B4xKZeb/DKcFx6hcW4YPTeOqoqmGv9Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYv3NekZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AFFC32782;
	Wed,  7 Aug 2024 10:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723025827;
	bh=Ps0tNdklgBZ8UoW92I7832USgziviwaLCHV/lVDnt7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tYv3NekZVpW4tBlWh124bY1t88ZFswejVkYa9Dvjwp5XoaJtiPVnGlA2KSFsxp4fO
	 Ok9sKS9iytgNeKb/z8pnB3luosur2Y7EhHPoIIrHB29aYyMX9MbKDY3k1XTYd+J8QR
	 SiASLUMrADo/z4To2SGxWsDJnXax9KYLofS+yEW9MkjPby//kzKAQHAa3Iqb+LW3j4
	 /rkbkorgcThYtVJkUfuQagTrl03vira/GHScGpsPQAMWGRmjF+hOcLgeodq6tb1o2f
	 h0Z8nWEOMZm1jY+rloJYm3CNGVnuoKANH8wKc3bZjFURK/eRop81GDRGViP/Kdoypv
	 Z67kqgGie46Zg==
Date: Wed, 7 Aug 2024 12:16:59 +0200
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
Subject: Re: [PATCH v4 05/28] rust: alloc: add module `allocator_test`
Message-ID: <ZrNJmxzN9cmBJtg1@pollux>
References: <20240805152004.5039-1-dakr@kernel.org>
 <20240805152004.5039-6-dakr@kernel.org>
 <7f4b91e6-aae8-4e17-9fcd-4b1d0b2de9a0@proton.me>
 <ZrJyaWhXHRciX51o@pollux.localdomain>
 <6aaf4e2d-7968-4a7c-a522-73e6788ee0ee@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6aaf4e2d-7968-4a7c-a522-73e6788ee0ee@proton.me>

On Wed, Aug 07, 2024 at 07:20:03AM +0000, Benno Lossin wrote:
> On 06.08.24 20:58, Danilo Krummrich wrote:
> > On Tue, Aug 06, 2024 at 04:54:10PM +0000, Benno Lossin wrote:
> >> On 05.08.24 17:19, Danilo Krummrich wrote:
> >>> `Allocator`s, such as `Kmalloc`, will be used by e.g. `Box` and `Vec` in
> >>> subsequent patches, and hence this dependency propagates throughout the
> >>> whole kernel.
> >>>
> >>> Add the `allocator_test` module that provides an empty implementation
> >>> for all `Allocator`s in the kernel, such that we don't break the
> >>> `rusttest` make target in subsequent patches.
> >>
> >> This is confusing, since you are talking about both our new `Allocator`
> >> trait, allocators and the `alloc` crate `Allocator`.
> > 
> > I never mention the `alloc` crate `Allocator` here.
> 
> Seems like I confused myself...
> 
> >>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> >>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> >>> ---
> >>>  rust/kernel/alloc.rs                |  9 +++++++--
> >>>  rust/kernel/alloc/allocator_test.rs | 19 +++++++++++++++++++
> >>>  2 files changed, 26 insertions(+), 2 deletions(-)
> >>>  create mode 100644 rust/kernel/alloc/allocator_test.rs
> >>>
> >>> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> >>> index bc01a17df5e0..942e2755f217 100644
> >>> --- a/rust/kernel/alloc.rs
> >>> +++ b/rust/kernel/alloc.rs
> >>> @@ -2,12 +2,17 @@
> >>>
> >>>  //! Extensions to the [`alloc`] crate.
> >>>
> >>> -#[cfg(not(test))]
> >>> -#[cfg(not(testlib))]
> >>> +#[cfg(not(any(test, testlib)))]
> >>>  pub mod allocator;
> >>>  pub mod box_ext;
> >>>  pub mod vec_ext;
> >>>
> >>> +#[cfg(any(test, testlib))]
> >>> +pub mod allocator_test;
> >>> +
> >>> +#[cfg(any(test, testlib))]
> >>> +pub use self::allocator_test as allocator;
> >>> +
> >>>  /// Indicates an allocation error.
> >>>  #[derive(Copy, Clone, PartialEq, Eq, Debug)]
> >>>  pub struct AllocError;
> >>> diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
> >>> new file mode 100644
> >>> index 000000000000..4785efc474a7
> >>> --- /dev/null
> >>> +++ b/rust/kernel/alloc/allocator_test.rs
> >>> @@ -0,0 +1,19 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +
> >>> +#![allow(missing_docs)]
> >>> +
> >>> +use super::{AllocError, Allocator, Flags};
> >>> +use core::alloc::Layout;
> >>> +use core::ptr::NonNull;
> >>> +
> >>> +pub struct Kmalloc;
> >>> +
> >>> +unsafe impl Allocator for Kmalloc {
> >>> +    unsafe fn realloc(
> >>> +        _ptr: Option<NonNull<u8>>,
> >>> +        _layout: Layout,
> >>> +        _flags: Flags,
> >>> +    ) -> Result<NonNull<[u8]>, AllocError> {
> >>> +        panic!();
> >>
> >> Does `build_error!()` also work? If yes, then I would prefer that.
> > 
> > Probably, but it also probably doesn't matter too much. A later patch in the
> > series replaces this with a `Cmalloc` implementation and type aliases all kernel
> > allocators (e.g. `Kmalloc`) to it.
> 
> What prevents you from doing the `Cmalloc` patch here? `build_error!`
> probably doesn't work, since we probably allocate in rusttest, right?

I think it's better to have the creation of the allocator_test module and the
implementation of `Cmalloc` in separate patches. `Cmalloc` comes later because I
don't need it yet. I need it to get rid of building Rust's `alloc` crate and I
think it's good to have those patches close to each other.

> 
> ---
> Cheers,
> Benno
> 

