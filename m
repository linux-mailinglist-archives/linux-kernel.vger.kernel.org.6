Return-Path: <linux-kernel+bounces-343034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1425989613
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74271C215CB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 15:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD3017C213;
	Sun, 29 Sep 2024 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcUtCgTO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414E51465B8;
	Sun, 29 Sep 2024 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727622747; cv=none; b=LCdPyI6qP4D0gbamOCO+tSGT8ZJHJz0GgKF5mTLH/9/w9VtXQciYnviUWijNxG/iWl7D0MGG1eXDQ2LRiHQTxJ+OZPw+iND+5la7GzVmIFRrWWBh2lgvyQzHna3Vv1ClmTDY+e9k/iti1LAXyU0CxeLuJ2q43ziG+wMggrkMMgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727622747; c=relaxed/simple;
	bh=8iK+wLu+DSCR1nDTiqALV97qNsthNxMyDvf/+B2qlKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiBM/We1fEfaEKN8eG16suvLHGD8EQmYGLSxq/URZ65iXRgKfkzs43jjNrkGVk2SKZsMjjOKMjgfNnaXSBKMpG9zZjQPJ2kQvVuN+uid/FkEj8qpL3oyRdT6MNXoXzNJATuSkDNQyiXD8fsOu2oKD9FPet4EBWKTJV8l9YKtkUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcUtCgTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF25BC4CEC5;
	Sun, 29 Sep 2024 15:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727622746;
	bh=8iK+wLu+DSCR1nDTiqALV97qNsthNxMyDvf/+B2qlKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YcUtCgTO72dzAyuttuqQtWi9zdBJAWcr3eRvd60dIoNA6FCOtAMXPnlkEb1+lhou1
	 Qq0KSxOJy330zrUcZmKiAwyzEZJMb2kDfwCA35JL14xzgtTiXhFxRsApVHQ9dd7Qr/
	 y264RiKnpKrGjCUlSpmqsGPWj6dse15GQ11ybg8DZVVV/LqnXfBTa8/TEbdAqYxFQk
	 DxmY02iHZmQ2X0BE0s1Qnsy6dC89umYmEA5Z8G8OVzx5ghctwyLQloAiTfvxcYjRmu
	 D7Rw6DsRtOYaaLwSorgAdEcxlHX94/pwrxXyf8ZmhWP1YM3A1E62xth2wPFbPv9SAP
	 3Akn0LafpJ2ZA==
Date: Sun, 29 Sep 2024 17:12:19 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, akpm@linux-foundation.org,
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com, lina@asahilina.net,
	mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 15/26] rust: alloc: implement `collect` for `IntoIter`
Message-ID: <ZvluU69LMB6nuD6r@pollux>
References: <20240911225449.152928-1-dakr@kernel.org>
 <20240911225449.152928-16-dakr@kernel.org>
 <20240928202734.4b518854.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928202734.4b518854.gary@garyguo.net>

On Sat, Sep 28, 2024 at 08:27:34PM +0100, Gary Guo wrote:
> On Thu, 12 Sep 2024 00:52:51 +0200
> Danilo Krummrich <dakr@kernel.org> wrote:
> 
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
> > 
> > Instead, provide `IntoIter::collect`, such that we can at least convert
> > `IntoIter` into a `Vec` again.
> > 
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 
> A question is how useful is this? The way this can be used seems
> fairly limited: you `into_iter`, consume a few elements, and the
> `collect()`?

Well, it allows us to convert back to a `Vec`, which we otherwise can't until we
implement our own `FromIterator` trait.

Also note that we want to have this specialization of `collect` for performance
reasons anyways. The Rust stdlib uses specialization traits (which aren't yet
stable) for this optimization.

> 
> It feels whatever user this serves, it would make more sense for them
> to use a `VecDeque` and just `pop_front()`.

We don't have `VecDeque` (yet).

> 
> Also, inline comments below.
> 
> > ---
> >  rust/kernel/alloc/kvec.rs | 86 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> > 
> > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> > index e91761c5c52d..686e969463f8 100644
> > --- a/rust/kernel/alloc/kvec.rs
> > +++ b/rust/kernel/alloc/kvec.rs
> > @@ -690,6 +690,92 @@ impl<T, A> IntoIter<T, A>
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
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// let v = kernel::kvec![1, 2, 3]?;
> > +    /// let mut it = v.into_iter();
> > +    ///
> > +    /// assert_eq!(it.next(), Some(1));
> > +    ///
> > +    /// let v = it.collect(GFP_KERNEL);
> > +    /// assert_eq!(v, [2, 3]);
> > +    ///
> > +    /// # Ok::<(), Error>(())
> > +    /// ```
> > +    /// # Implementation Details
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
> > +    pub fn collect(self, flags: Flags) -> Vec<T, A> {
> > +        let (mut ptr, buf, len, mut cap) = self.into_raw_parts();
> > +        let has_advanced = ptr != buf.as_ptr();
> > +
> > +        if has_advanced {
> > +            // Copy the contents we have advanced to at the beginning of the buffer.
> > +            //
> > +            // SAFETY:
> > +            // - `ptr` is valid for reads of `len * size_of::<T>()` bytes,
> > +            // - `buf.as_ptr()` is valid for writes of `len * size_of::<T>()` bytes,
> > +            // - `ptr` and `buf.as_ptr()` are not be subject to aliasing restrictions relative to
> > +            //   each other,
> > +            // - both `ptr` and `buf.ptr()` are properly aligned.
> > +            unsafe { ptr::copy(ptr, buf.as_ptr(), len) };
> > +            ptr = buf.as_ptr();
> > +        }
> > +
> > +        // This can never fail, `len` is guaranteed to be smaller than `cap`.
> > +        let layout = core::alloc::Layout::array::<T>(len).unwrap();
> 
> nit: could be `unwrap_unchecked()`. Although feel free to leave it to
> avoid an additional unsafe.

This will be replaced with `ArrayLayout` anyways.

> 
> > +
> > +        // SAFETY: `buf` points to the start of the backing buffer and `len` is guaranteed to be
> > +        // smaller than `cap`. Depending on `alloc` this operation may shrink the buffer or leaves
> > +        // it as it is.
> > +        ptr = match unsafe { A::realloc(Some(buf.cast()), layout, flags) } {
> > +            // If we fail to shrink, which likely can't even happen, continue with the existing
> > +            // buffer.
> > +            Err(_) => ptr,
> > +            Ok(ptr) => {
> > +                cap = len;
> > +                ptr.as_ptr().cast()
> > +            }
> > +        };
> 
> This should be moved to `Vec::shrink_to_fit`. And then this function
> can just `Vec::from_raw_parts(...)` and then `vec.shrink_to_fit`.

I'll put it on my list for a follow up patch, I really think we should focus on
landing the series now.

> 
> But my question would be why this function needs to shrink in the first
> place.

It's meant as an optimization for `Iterator::collect` in the mid / long term. A
user expects that the resulting allocation isn't larger than actually needed for
`Iterator::collect`.

> 
> > +
> > +        // SAFETY: If the iterator has been advanced, the advanced elements have been copied to
> > +        // the beginning of the buffer and `len` has been adjusted accordingly.
> > +        //
> > +        // - `ptr` is guaranteed to point to the start of the backing buffer.
> > +        // - `cap` is either the original capacity or, after shrinking the buffer, equal to `len`.
> > +        // - `alloc` is guaranteed to be unchanged since `into_iter` has been called on the original
> > +        //   `Vec`.
> > +        unsafe { Vec::from_raw_parts(ptr, len, cap) }
> > +    }
> >  }
> >  
> >  impl<T, A> Iterator for IntoIter<T, A>
> 

