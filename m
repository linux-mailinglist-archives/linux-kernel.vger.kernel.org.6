Return-Path: <linux-kernel+bounces-323983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C7D974672
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C199B1F26D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF211AC44E;
	Tue, 10 Sep 2024 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCEKcEF3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F961A76C7;
	Tue, 10 Sep 2024 23:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011603; cv=none; b=Tukc4OP+6pbdKHRQLFJBXS/o1qIP6yiC5vTPL2Hyz1uuWYCYZnidK4oc/pDAJ1RcfWgdIsSX/xrXf+dVOB1d3u54UDfQ+G5337vHn1P3h2VZLaZI6/Jx8ZG8QaSHQOZWT6rTinDZYOOjRZpBxcaLp10I6bBocgvn9BZQScjG2Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011603; c=relaxed/simple;
	bh=NJVGgneIeHeVh/TWM2tmUema/6fUc/+nPEQT0jbcZ6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yol6vnl8M73PRwrgmKLvEAouhbX58uZDYslq4orQVGg604qyS9cZ685Zsn4/itm964KBvSpduhum06rsu8a39DP0EPwN/akc5HpjV0nDjzGFCpNjy6Wxif739EvswrvDRMTY6TR/siE/Ujda8dH4w8JnmxeXTCR3VFf31O7hl54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCEKcEF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A86C4CEC3;
	Tue, 10 Sep 2024 23:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726011602;
	bh=NJVGgneIeHeVh/TWM2tmUema/6fUc/+nPEQT0jbcZ6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UCEKcEF3WIcYpamSJmlIkN9E05ecXJNc4rkPWh0Fw2+nMA8tYBZ09RE+a39ejDogu
	 ANiKrBMTTnPrDh1DCjEGC+UTPIs2ys6gbcfpylsq9zX0nYZln1jBMDw1f6dE9nqEch
	 IyUXyXuqHWure81bwl8Tf6y83R92DFU7ECiOxOmdDB0JoAajRjbjvNKxAM/uwhsUV2
	 Vgndf4lw4zMIms1sD14D21IbdB9+DvQNLdBDFYGAzOGuhymi9G/MXmXTAtrw8HK++D
	 m5rBuAdgv4lOWievxaw8qkmIkj0S4xWHe4XduoAX+HKeVoFDqT0oQtXvbwzv2KuG8k
	 Fi6cSsM7LxiSw==
Date: Wed, 11 Sep 2024 01:39:55 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 14/26] rust: alloc: implement `IntoIterator` for `Vec`
Message-ID: <ZuDYy3HtPwVLgDtS@pollux>
References: <20240816001216.26575-1-dakr@kernel.org>
 <20240816001216.26575-15-dakr@kernel.org>
 <308d40dd-105b-4ebf-ba70-585a97d66928@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <308d40dd-105b-4ebf-ba70-585a97d66928@proton.me>

On Tue, Sep 10, 2024 at 08:04:27PM +0000, Benno Lossin wrote:
> On 16.08.24 02:10, Danilo Krummrich wrote:
> > Implement `IntoIterator` for `Vec`, `Vec`'s `IntoIter` type, as well as
> > `Iterator` for `IntoIter`.
> > 
> > `Vec::into_iter` disassembles the `Vec` into its raw parts; additionally,
> > `IntoIter` keeps track of a separate pointer, which is incremented
> > correspondingsly as the iterator advances, while the length, or the count
> > of elements, is decremented.
> > 
> > This also means that `IntoIter` takes the ownership of the backing
> > buffer and is responsible to drop the remaining elements and free the
> > backing buffer, if it's dropped.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/alloc.rs      |   1 +
> >  rust/kernel/alloc/kvec.rs | 184 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 185 insertions(+)
> > 
> > diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> > index e88c7e10ee9b..4ff4df4597a3 100644
> > --- a/rust/kernel/alloc.rs
> > +++ b/rust/kernel/alloc.rs
> > @@ -19,6 +19,7 @@
> >  pub use self::kbox::KVBox;
> >  pub use self::kbox::VBox;
> > 
> > +pub use self::kvec::IntoIter;
> >  pub use self::kvec::KVVec;
> >  pub use self::kvec::KVec;
> >  pub use self::kvec::VVec;
> > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> > index 89afc0f25bd4..3b79f977b65e 100644
> > --- a/rust/kernel/alloc/kvec.rs
> > +++ b/rust/kernel/alloc/kvec.rs
> > @@ -11,6 +11,7 @@
> >      ops::DerefMut,
> >      ops::Index,
> >      ops::IndexMut,
> > +    ptr,
> >      ptr::NonNull,
> >      slice,
> >      slice::SliceIndex,
> > @@ -627,3 +628,186 @@ fn eq(&self, other: &$rhs) -> bool { self[..] == other[..] }
> >  __impl_slice_eq! { [A: Allocator] [T], Vec<U, A> }
> >  __impl_slice_eq! { [A: Allocator, const N: usize] Vec<T, A>, [U; N] }
> >  __impl_slice_eq! { [A: Allocator, const N: usize] Vec<T, A>, &[U; N] }
> > +
> > +impl<'a, T, A> IntoIterator for &'a Vec<T, A>
> > +where
> > +    A: Allocator,
> > +{
> > +    type Item = &'a T;
> > +    type IntoIter = slice::Iter<'a, T>;
> > +
> > +    fn into_iter(self) -> Self::IntoIter {
> > +        self.iter()
> > +    }
> > +}
> > +
> > +impl<'a, T, A: Allocator> IntoIterator for &'a mut Vec<T, A>
> > +where
> > +    A: Allocator,
> > +{
> > +    type Item = &'a mut T;
> > +    type IntoIter = slice::IterMut<'a, T>;
> > +
> > +    fn into_iter(self) -> Self::IntoIter {
> > +        self.iter_mut()
> > +    }
> > +}
> > +
> > +/// An `Iterator` implementation for `Vec<T,A>` that moves elements out of a vector.
> 
> Please make both links.
> 
> > +///
> > +/// This structure is created by the `Vec::into_iter` method on [`Vec`] (provided by the
> 
> Ditto.
> 
> > +/// [`IntoIterator`] trait).
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// let v = kernel::kvec![0, 1, 2]?;
> > +/// let iter = v.into_iter();
> > +///
> > +/// # Ok::<(), Error>(())
> > +/// ```
> > +pub struct IntoIter<T, A: Allocator> {
> > +    ptr: *mut T,
> > +    buf: NonNull<T>,
> 
> No invariants for these two fields?

Suggestions?

> 
> > +    len: usize,
> > +    cap: usize,
> > +    _p: PhantomData<A>,
> > +}
> > +
> > +impl<T, A> IntoIter<T, A>
> > +where
> > +    A: Allocator,
> > +{
> > +    fn as_raw_mut_slice(&mut self) -> *mut [T] {
> > +        ptr::slice_from_raw_parts_mut(self.ptr, self.len)
> > +    }
> > +}
> > +
> > +impl<T, A> Iterator for IntoIter<T, A>
> > +where
> > +    A: Allocator,
> > +{
> > +    type Item = T;
> > +
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// let v = kernel::kvec![1, 2, 3]?;
> > +    /// let mut it = v.into_iter();
> > +    ///
> > +    /// assert_eq!(it.next(), Some(1));
> > +    /// assert_eq!(it.next(), Some(2));
> > +    /// assert_eq!(it.next(), Some(3));
> > +    /// assert_eq!(it.next(), None);
> > +    ///
> > +    /// # Ok::<(), Error>(())
> > +    /// ```
> 
> AFAIK documentation on functions in trait implementations won't show up
> in rustdoc (I just checked this). So I would remove it.

They don't, but the KUnit tests are still executed. :)

> 
> > +    fn next(&mut self) -> Option<T> {
> > +        if self.len == 0 {
> > +            return None;
> > +        }
> > +
> > +        let ptr = self.ptr;
> > +        if !Vec::<T, A>::is_zst() {
> > +            // SAFETY: We can't overflow; `end` is guaranteed to mark the end of the buffer.
> > +            unsafe { self.ptr = self.ptr.add(1) };
> > +        } else {
> > +            // For ZST `ptr` has to stay where it is to remain aligned, so we just reduce `self.len`
> > +            // by 1.
> 
> Note that `<*mut T>::add` advances the pointer by `size_of::<T>()`
> bytes. So in the case that `T` is a ZST, it won't be advanced.
> So you could remove this `if`.
> 
> > +        }
> > +        self.len -= 1;
> > +
> > +        // SAFETY: `ptr` is guaranteed to point at a valid element within the buffer.
> > +        Some(unsafe { ptr.read() })
> > +    }
> > +
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// let v: KVec<u32> = kernel::kvec![1, 2, 3]?;
> > +    /// let mut iter = v.into_iter();
> > +    /// let size = iter.size_hint().0;
> > +    ///
> > +    /// iter.next();
> > +    /// assert_eq!(iter.size_hint().0, size - 1);
> > +    ///
> > +    /// iter.next();
> > +    /// assert_eq!(iter.size_hint().0, size - 2);
> > +    ///
> > +    /// iter.next();
> > +    /// assert_eq!(iter.size_hint().0, size - 3);
> > +    ///
> > +    /// # Ok::<(), Error>(())
> > +    /// ```
> > +    fn size_hint(&self) -> (usize, Option<usize>) {
> > +        (self.len, Some(self.len))
> > +    }
> > +}
> > +
> > +impl<T, A> Drop for IntoIter<T, A>
> > +where
> > +    A: Allocator,
> > +{
> > +    fn drop(&mut self) {
> > +        // SAFETY: Drop the remaining vector's elements in place, before we free the backing
> > +        // memory.
> 
> This comment explains why you are doing it, not why it's ok to do it.
> 
> > +        unsafe { ptr::drop_in_place(self.as_raw_mut_slice()) };
> > +
> > +        // If `cap == 0` we never allocated any memory in the first place.
> > +        if self.cap != 0 {
> > +            // SAFETY: `self.buf` was previously allocated with `A`.
> > +            unsafe { A::free(self.buf.cast()) };
> > +        }
> > +    }
> > +}
> > +
> > +impl<T, A> IntoIterator for Vec<T, A>
> > +where
> > +    A: Allocator,
> > +{
> > +    type Item = T;
> > +    type IntoIter = IntoIter<T, A>;
> > +
> > +    /// Consumes the `Vec<T, A>` and creates an `Iterator`, which moves each value out of the
> > +    /// vector (from start to end).
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// let v = kernel::kvec![1, 2]?;
> > +    /// let mut v_iter = v.into_iter();
> > +    ///
> > +    /// let first_element: Option<u32> = v_iter.next();
> > +    ///
> > +    /// assert_eq!(first_element, Some(1));
> > +    /// assert_eq!(v_iter.next(), Some(2));
> > +    /// assert_eq!(v_iter.next(), None);
> > +    ///
> > +    /// # Ok::<(), Error>(())
> > +    /// ```
> > +    ///
> > +    /// ```
> > +    /// let v = kernel::kvec![];
> > +    /// let mut v_iter = v.into_iter();
> > +    ///
> > +    /// let first_element: Option<u32> = v_iter.next();
> > +    ///
> > +    /// assert_eq!(first_element, None);
> > +    ///
> > +    /// # Ok::<(), Error>(())
> > +    /// ```
> 
> I feel a bit bad that you wrote all of this nice documentation for
> functions that receive their documentation from the trait...

No worries, I really only added them for the KUnit tests.

> 
> ---
> Cheers,
> Benno
> 
> > +    #[inline]
> > +    fn into_iter(self) -> Self::IntoIter {
> > +        let (ptr, len, cap) = self.into_raw_parts();
> > +
> > +        IntoIter {
> > +            ptr,
> > +            // SAFETY: `ptr` is either a dangling pointer or a pointer to a valid memory
> > +            // allocation, allocated with `A`.
> > +            buf: unsafe { NonNull::new_unchecked(ptr) },
> > +            len,
> > +            cap,
> > +            _p: PhantomData::<A>,
> > +        }
> > +    }
> > +}
> > --
> > 2.46.0
> > 
> 

