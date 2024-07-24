Return-Path: <linux-kernel+bounces-261504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C47CA93B80D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526491F21EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F56A132494;
	Wed, 24 Jul 2024 20:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiJ6/9QS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773916A325;
	Wed, 24 Jul 2024 20:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721853171; cv=none; b=GMqouoa+wB14jGYi5lBvplF9Drd8Cntg9XTYViWk4JNl+fvlsI6R42bIsN6JI5i8Ey34Tpt5Qeft95IXW/zg5TBNiSY8WgS1Qy0wNGbcacWFQnnB3PQEFAgMwIKk5L4L2rxXUUZYaWGT2N4ytbuzY9xCc3okSLEgz0AkPpJGxIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721853171; c=relaxed/simple;
	bh=aMn98SjH3IZ9bjl+8IXsiVppV9Tm41peLtZlAfFNBk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTkgYpaC9dt2H14Kth3auMZlmC4BUcGrjtaZXFriYjAQ9rAlmfoTPy7+p0yT9Cg7ryyNcIKP1eVCAqAV/Ahx+G7hvBte6o6/OPnwmv1M6XnhxVPR9dJavRZWvpPi8UzydtZdYD9XhnDBX91QYHBPob/doxNThBN1pRMc5va1Oas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiJ6/9QS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA8AC32781;
	Wed, 24 Jul 2024 20:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721853171;
	bh=aMn98SjH3IZ9bjl+8IXsiVppV9Tm41peLtZlAfFNBk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NiJ6/9QSMaxY8aTVfL+EY8OPRr9GHh5Pq767MwZ9SVpg3YHBkDmGmq2qWrjqEjbjJ
	 70q+61abPXwFFuqsbuW6On8V7ln+4QeqVPz/F71uS+vTq8a111e+5I2AFN8l+atgdA
	 OBZF3Qse3vU5ajFzLJx3U8zIUQqOktqnev5MPaA7YLa21BaW8Ywxi3ZK2MG+rVcvMp
	 j7o6AZPPBX9x4afSw5bpvhevG9Grpin1G6PbII6/W4G7SdCAUvCDaRMtA7cxWCHw5Q
	 XbbynSDoShB2iAqrgu/VSQcemu9RXjAfoeSQG5wM/PcO/XxIl3o6cMIWvecL3l6lWP
	 RAolo696nW11Q==
Date: Wed, 24 Jul 2024 22:32:41 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Heghedus Razvan <heghedus.razvan@protonmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, akpm@linux-foundation.org,
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com, lina@asahilina.net,
	mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 16/23] rust: alloc: implement `collect` for `IntoIter`
Message-ID: <ZqFk6bWrTUCDh3m6@pollux>
References: <20240723181024.21168-1-dakr@kernel.org>
 <20240723181024.21168-17-dakr@kernel.org>
 <D2XUESJWJNIY.3HP9IDB0NKFYI@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D2XUESJWJNIY.3HP9IDB0NKFYI@protonmail.com>

On Wed, Jul 24, 2024 at 02:35:46PM +0000, Heghedus Razvan wrote:
> On Tue Jul 23, 2024 at 9:10 PM EEST, Danilo Krummrich wrote:
> > Currently, we can't implement `FromIterator`. There are a couple of
> > issues with this trait in the kernel, namely:
> >
> >   - Rust's specialization feature is unstable. This prevents us to
> >     optimze for the special case where `I::IntoIter` equals `Vec`'s
> >     `IntoIter` type.
> >   - We also can't use `I::IntoIter`'s type ID either to work around this,
> >     since `FromIterator` doesn't require this type to be `'static`.
> >   - `FromIterator::from_iter` does return `Self` instead of
> >     `Result<Self, AllocError>`, hence we can't properly handle allocation
> >     failures.
> >   - Neither `Iterator::collect` nor `FromIterator::from_iter` can handle
> >     additional allocation flags.
> Well that's a shame, so I guess collecting a Filter or Map is not possible.

Not with the Rust's `FromIterator` trait, unfortunately. However, once we have
other collectable data structures in place, we can come up with a kernel
compatible version of the `FromIterator` trait and implement against it.

> 
> >
> > Instead, provide `IntoIter::collect`, such that we can at least convert
> > `IntoIter` into a `Vec` again.
> >
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/alloc/kvec.rs | 80 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 79 insertions(+), 1 deletion(-)
> >
> > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> > index fbfb755b252d..5c317931e14c 100644
> > --- a/rust/kernel/alloc/kvec.rs
> > +++ b/rust/kernel/alloc/kvec.rs
> > @@ -2,7 +2,7 @@
> >
> >  //! Implementation of [`Vec`].
> >
> > -use super::{AllocError, Allocator, Flags};
> > +use super::{flags::*, AllocError, Allocator, Flags};
> >  use crate::types::Unique;
> >  use core::{
> >      fmt,
> > @@ -633,6 +633,84 @@ impl<T, A> IntoIter<T, A>
> >      fn as_raw_mut_slice(&mut self) -> *mut [T] {
> >          ptr::slice_from_raw_parts_mut(self.ptr, self.len)
> >      }
> > +
> > +    fn into_raw_parts(self) -> (*mut T, NonNull<T>, usize, usize) {
> > +        let me = ManuallyDrop::new(self);
> > +        let ptr = me.ptr;
> > +        let buf = me.buf;
> > +        let len = me.len;
> > +        let cap = me.cap;
> > +        (ptr, buf, len, cap)
> > +    }
> > +
> > +    /// Same as `Iterator::collect` but specialized for `Vec`'s `IntoIter`.
> > +    ///
> > +    /// Currently, we can't implement `FromIterator`. There are a couple of issues with this trait
> > +    /// in the kernel, namely:
> > +    ///
> > +    /// - Rust's specialization feature is unstable. This prevents us to optimze for the special
> > +    ///   case where `I::IntoIter` equals `Vec`'s `IntoIter` type.
> > +    /// - We also can't use `I::IntoIter`'s type ID either to work around this, since `FromIterator`
> > +    ///   doesn't require this type to be `'static`.
> > +    /// - `FromIterator::from_iter` does return `Self` instead of `Result<Self, AllocError>`, hence
> > +    ///   we can't properly handle allocation failures.
> > +    /// - Neither `Iterator::collect` nor `FromIterator::from_iter` can handle additional allocation
> > +    ///   flags.
> > +    ///
> > +    /// Instead, provide `IntoIter::collect`, such that we can at least convert a `IntoIter` into a
> > +    /// `Vec` again.
> > +    ///
> > +    /// Note that `IntoIter::collect` doesn't require `Flags`, since it re-uses the existing backing
> > +    /// buffer. However, this backing buffer may be shrunk to the actual count of elements.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// let v = kernel::kvec![1, 2, 3]?;
> > +    /// let mut it = v.into_iter();
> > +    ///
> > +    /// assert_eq!(it.next(), Some(1));
> > +    ///
> > +    /// let v = it.collect();
> > +    /// assert_eq!(v, [2, 3]);
> > +    ///
> > +    /// # Ok::<(), Error>(())
> > +    /// ```
> > +    pub fn collect(self) -> Vec<T, A> {
> > +        let (mut ptr, buf, len, mut cap) = self.into_raw_parts();
> > +        let has_advanced = ptr != buf.as_ptr();
> > +
> > +        if has_advanced {
> > +            // SAFETY: Copy the contents we have advanced to at the beginning of the buffer.
> > +            // `ptr` is guaranteed to be between `buf` and `buf.add(cap)` and `ptr.add(len)` is
> > +            // guaranteed to be smaller than `buf.add(cap)`.
> > +            unsafe { ptr::copy(ptr, buf.as_ptr(), len) };
> > +            ptr = buf.as_ptr();
> > +        }
> > +
> > +        // This can never fail, `len` is guaranteed to be smaller than `cap`.
> > +        let layout = core::alloc::Layout::array::<T>(len).unwrap();
> > +
> > +        // SAFETY: `buf` points to the start of the backing buffer and `len` is guaranteed to be
> > +        // smaller than `cap`. Depending on `alloc` this operation may shrink the buffer or leaves
> > +        // it as it is.
> > +        ptr = match unsafe { A::realloc(Some(buf.cast()), layout, GFP_KERNEL) } {
> Here you use `GFP_KERNEL` flag directly. Shouldn't this be an argument of `collect` function? 

Even though we only ever ask the allocator to shrink the buffer (or keep it as
it is), it should be, good catch!

> 
> > +            // If we fail to shrink, which likely can't even happen, continue with the existing
> > +            // buffer.
> > +            Err(_) => ptr,
> > +            Ok(ptr) => {
> > +                cap = len;
> > +                ptr.as_ptr().cast()
> > +            }
> > +        };
> > +
> > +        // SAFETY: If the iterator has been advanced, the advanced elements have been copied to
> > +        // the beginning of the buffer and `len` has been adjusted accordingly. `ptr` is guaranteed
> > +        // to point to the start of the backing buffer. `cap` is either the original capacity or,
> > +        // after shrinking the buffer, equal to `len`. `alloc` is guaranteed to be unchanged since
> > +        // `into_iter` has been called on the original `Vec`.
> > +        unsafe { Vec::from_raw_parts(ptr, len, cap) }
> > +    }
> >  }
> >
> >  impl<T, A> Iterator for IntoIter<T, A>
> > --
> > 2.45.2
> 
> 

