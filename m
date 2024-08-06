Return-Path: <linux-kernel+bounces-276747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E199497E6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CD20B250B6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0C213F45F;
	Tue,  6 Aug 2024 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjQS0Q1t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9D912C499;
	Tue,  6 Aug 2024 18:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722970737; cv=none; b=nVQezG7A8yhHtXI0LK37xFDVC3U4z7JwdabrvNW0zGxraZ5UN4xhOFKHqnGZOXToCm4lfffHoSbiV/VkwT2SXvC6t7nsELsD86GIyvg0v3Al+bcZzZ8jLVRA+MySToVXb3nk1Ibv0r7QZjF/z4ZSv3lNz4daRQh0l6boNOnW0C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722970737; c=relaxed/simple;
	bh=nTZwvoB1swCmSCEA37kLGlL7AFlUVn7ToNTM/uTFB7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCkZ/8Yj7W21qIwJENlN4Fpe8FvEv6xsixN8vgieuP9SuMNCEpvFYx53o8cnud72TyBZdjPDchMK8Z3HQrmIIJzeiR/WZyQSq/ba45cb80meTw+hp4np9XEG2Jd7hyLTYHNoGastskMoYDwnVo+Asx7V/Yx5UOmo/x5AzqG1H+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjQS0Q1t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2852DC32786;
	Tue,  6 Aug 2024 18:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722970737;
	bh=nTZwvoB1swCmSCEA37kLGlL7AFlUVn7ToNTM/uTFB7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PjQS0Q1t36HxAKcFuK/KM7CYWHgFHl/N5ykYt4Eto1ExusMme3pWj14PL33gaZpek
	 nwteGAcCY7TNhwNhw1V+BzNds7ZBpceDpB3bQOhvGBgluacdDbGY5BJlobV81xiuJz
	 Rn52pjVRl379VEclW7Jsn7e+f/hpCaNw+tQvDJXA3LAAZEK+E6uUo6RoOztKpMNpV9
	 8F2OdVnKBdpX26rp68uErbNntQwRJ9Wbne9cP8Q1PJErzjte+IlYpRaTWaXkmEM5yR
	 qkVMXqJnFW88fji6rBey6mGvQrHFa4JJbrwzd0f+4ALe55cT+iN8NCKouEACPPYZEY
	 p2cSkylsNaK2g==
Date: Tue, 6 Aug 2024 20:58:49 +0200
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
Message-ID: <ZrJyaWhXHRciX51o@pollux.localdomain>
References: <20240805152004.5039-1-dakr@kernel.org>
 <20240805152004.5039-6-dakr@kernel.org>
 <7f4b91e6-aae8-4e17-9fcd-4b1d0b2de9a0@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f4b91e6-aae8-4e17-9fcd-4b1d0b2de9a0@proton.me>

On Tue, Aug 06, 2024 at 04:54:10PM +0000, Benno Lossin wrote:
> On 05.08.24 17:19, Danilo Krummrich wrote:
> > `Allocator`s, such as `Kmalloc`, will be used by e.g. `Box` and `Vec` in
> > subsequent patches, and hence this dependency propagates throughout the
> > whole kernel.
> > 
> > Add the `allocator_test` module that provides an empty implementation
> > for all `Allocator`s in the kernel, such that we don't break the
> > `rusttest` make target in subsequent patches.
> 
> This is confusing, since you are talking about both our new `Allocator`
> trait, allocators and the `alloc` crate `Allocator`.

I never mention the `alloc` crate `Allocator` here.

> 
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/alloc.rs                |  9 +++++++--
> >  rust/kernel/alloc/allocator_test.rs | 19 +++++++++++++++++++
> >  2 files changed, 26 insertions(+), 2 deletions(-)
> >  create mode 100644 rust/kernel/alloc/allocator_test.rs
> > 
> > diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> > index bc01a17df5e0..942e2755f217 100644
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
> > +        _flags: Flags,
> > +    ) -> Result<NonNull<[u8]>, AllocError> {
> > +        panic!();
> 
> Does `build_error!()` also work? If yes, then I would prefer that.

Probably, but it also probably doesn't matter too much. A later patch in the
series replaces this with a `Cmalloc` implementation and type aliases all kernel
allocators (e.g. `Kmalloc`) to it.

This allows us to use our kernel `Box` and `Vec` types in userspace tests
(rusttest target).

> 
> ---
> Cheers,
> Benno
> 
> > +    }
> > +}
> > --
> > 2.45.2
> > 
> 

