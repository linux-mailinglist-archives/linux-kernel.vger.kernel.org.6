Return-Path: <linux-kernel+bounces-323820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B7A9743DD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A367028B2B4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177B317DFE1;
	Tue, 10 Sep 2024 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kZrlA4dD"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF451A4F1C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 20:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725998683; cv=none; b=dIR4MT5h4kh8sOnm4+fCUUF0ITOJH5TD7H8xpvFO1LYYd3+bDPro/55gGtJM5Ut5a41HS8SKoZfFLsNUrWFdFa3qi5gQqEw932DJ21LIF4GfmUrUAmpbaXLPOWdDn6aEGC4BwcB1y3t92JvncznykLRjRQZWRdezkwd6KdYG5BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725998683; c=relaxed/simple;
	bh=3hegu0TOF7TyWA0Uq6Ws9wifFyVa8Lv1RflAAfIFZ4I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/SYtRPmfOH58KoFg4tYWisEVUCmDa8RYDllNARGWiVmPRLduuMz1uP6WcDSH/CV4/+m7oLYl3QPS0p0W0JLaSeWTXvCvel8+R2fdGNdjfzZfuYR3cYh8yXC7d6Ghgk0JnQnrRnFBJYYZUzhkn6yg5vsG37Azqd7vYVxukHMoFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=kZrlA4dD; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725998673; x=1726257873;
	bh=ENz53fEk86BgBhfUiQ+jlgzdiXHlf5LBcT9PrqrkEE8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kZrlA4dDTD9K96RQAJnWasRA4TqPHYTJJBgohjGmxTDKmwXjJCUqIsC8feIpjhf2b
	 1zKz176HFHKBA+tv2y46nn9ZSrS6eOfIHZPAMk/LXGJDKhlZIrBrrFT4GT7NPLABRt
	 bWYKKZk173BEGJbgrNGUqPPD6Ur8HyacnzHrUStTdlPpEzDi9RegfR8D8Uqch1tCg4
	 sDzxtf/d5dAT9AAqlBMdWn8AYutAsYBicT13lfO8ucZl8n1a7zba+fGRrKE5Zub7ws
	 cZieS9v+ScvmbCbMCeXkxiB92rqiBvjoRbhsZ5fH/yr18sgvK73qPwvHHIzdchc89K
	 u4tepUaUbftgg==
Date: Tue, 10 Sep 2024 20:04:27 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 14/26] rust: alloc: implement `IntoIterator` for `Vec`
Message-ID: <308d40dd-105b-4ebf-ba70-585a97d66928@proton.me>
In-Reply-To: <20240816001216.26575-15-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-15-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d3f8bbb264eaf1b88a2abc6facc9fa1fcfeaab7a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.08.24 02:10, Danilo Krummrich wrote:
> Implement `IntoIterator` for `Vec`, `Vec`'s `IntoIter` type, as well as
> `Iterator` for `IntoIter`.
>=20
> `Vec::into_iter` disassembles the `Vec` into its raw parts; additionally,
> `IntoIter` keeps track of a separate pointer, which is incremented
> correspondingsly as the iterator advances, while the length, or the count
> of elements, is decremented.
>=20
> This also means that `IntoIter` takes the ownership of the backing
> buffer and is responsible to drop the remaining elements and free the
> backing buffer, if it's dropped.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc.rs      |   1 +
>  rust/kernel/alloc/kvec.rs | 184 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 185 insertions(+)
>=20
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index e88c7e10ee9b..4ff4df4597a3 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -19,6 +19,7 @@
>  pub use self::kbox::KVBox;
>  pub use self::kbox::VBox;
>=20
> +pub use self::kvec::IntoIter;
>  pub use self::kvec::KVVec;
>  pub use self::kvec::KVec;
>  pub use self::kvec::VVec;
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index 89afc0f25bd4..3b79f977b65e 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -11,6 +11,7 @@
>      ops::DerefMut,
>      ops::Index,
>      ops::IndexMut,
> +    ptr,
>      ptr::NonNull,
>      slice,
>      slice::SliceIndex,
> @@ -627,3 +628,186 @@ fn eq(&self, other: &$rhs) -> bool { self[..] =3D=
=3D other[..] }
>  __impl_slice_eq! { [A: Allocator] [T], Vec<U, A> }
>  __impl_slice_eq! { [A: Allocator, const N: usize] Vec<T, A>, [U; N] }
>  __impl_slice_eq! { [A: Allocator, const N: usize] Vec<T, A>, &[U; N] }
> +
> +impl<'a, T, A> IntoIterator for &'a Vec<T, A>
> +where
> +    A: Allocator,
> +{
> +    type Item =3D &'a T;
> +    type IntoIter =3D slice::Iter<'a, T>;
> +
> +    fn into_iter(self) -> Self::IntoIter {
> +        self.iter()
> +    }
> +}
> +
> +impl<'a, T, A: Allocator> IntoIterator for &'a mut Vec<T, A>
> +where
> +    A: Allocator,
> +{
> +    type Item =3D &'a mut T;
> +    type IntoIter =3D slice::IterMut<'a, T>;
> +
> +    fn into_iter(self) -> Self::IntoIter {
> +        self.iter_mut()
> +    }
> +}
> +
> +/// An `Iterator` implementation for `Vec<T,A>` that moves elements out =
of a vector.

Please make both links.

> +///
> +/// This structure is created by the `Vec::into_iter` method on [`Vec`] =
(provided by the

Ditto.

> +/// [`IntoIterator`] trait).
> +///
> +/// # Examples
> +///
> +/// ```
> +/// let v =3D kernel::kvec![0, 1, 2]?;
> +/// let iter =3D v.into_iter();
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +pub struct IntoIter<T, A: Allocator> {
> +    ptr: *mut T,
> +    buf: NonNull<T>,

No invariants for these two fields?

> +    len: usize,
> +    cap: usize,
> +    _p: PhantomData<A>,
> +}
> +
> +impl<T, A> IntoIter<T, A>
> +where
> +    A: Allocator,
> +{
> +    fn as_raw_mut_slice(&mut self) -> *mut [T] {
> +        ptr::slice_from_raw_parts_mut(self.ptr, self.len)
> +    }
> +}
> +
> +impl<T, A> Iterator for IntoIter<T, A>
> +where
> +    A: Allocator,
> +{
> +    type Item =3D T;
> +
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let v =3D kernel::kvec![1, 2, 3]?;
> +    /// let mut it =3D v.into_iter();
> +    ///
> +    /// assert_eq!(it.next(), Some(1));
> +    /// assert_eq!(it.next(), Some(2));
> +    /// assert_eq!(it.next(), Some(3));
> +    /// assert_eq!(it.next(), None);
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```

AFAIK documentation on functions in trait implementations won't show up
in rustdoc (I just checked this). So I would remove it.

> +    fn next(&mut self) -> Option<T> {
> +        if self.len =3D=3D 0 {
> +            return None;
> +        }
> +
> +        let ptr =3D self.ptr;
> +        if !Vec::<T, A>::is_zst() {
> +            // SAFETY: We can't overflow; `end` is guaranteed to mark th=
e end of the buffer.
> +            unsafe { self.ptr =3D self.ptr.add(1) };
> +        } else {
> +            // For ZST `ptr` has to stay where it is to remain aligned, =
so we just reduce `self.len`
> +            // by 1.

Note that `<*mut T>::add` advances the pointer by `size_of::<T>()`
bytes. So in the case that `T` is a ZST, it won't be advanced.
So you could remove this `if`.

> +        }
> +        self.len -=3D 1;
> +
> +        // SAFETY: `ptr` is guaranteed to point at a valid element withi=
n the buffer.
> +        Some(unsafe { ptr.read() })
> +    }
> +
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let v: KVec<u32> =3D kernel::kvec![1, 2, 3]?;
> +    /// let mut iter =3D v.into_iter();
> +    /// let size =3D iter.size_hint().0;
> +    ///
> +    /// iter.next();
> +    /// assert_eq!(iter.size_hint().0, size - 1);
> +    ///
> +    /// iter.next();
> +    /// assert_eq!(iter.size_hint().0, size - 2);
> +    ///
> +    /// iter.next();
> +    /// assert_eq!(iter.size_hint().0, size - 3);
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    fn size_hint(&self) -> (usize, Option<usize>) {
> +        (self.len, Some(self.len))
> +    }
> +}
> +
> +impl<T, A> Drop for IntoIter<T, A>
> +where
> +    A: Allocator,
> +{
> +    fn drop(&mut self) {
> +        // SAFETY: Drop the remaining vector's elements in place, before=
 we free the backing
> +        // memory.

This comment explains why you are doing it, not why it's ok to do it.

> +        unsafe { ptr::drop_in_place(self.as_raw_mut_slice()) };
> +
> +        // If `cap =3D=3D 0` we never allocated any memory in the first =
place.
> +        if self.cap !=3D 0 {
> +            // SAFETY: `self.buf` was previously allocated with `A`.
> +            unsafe { A::free(self.buf.cast()) };
> +        }
> +    }
> +}
> +
> +impl<T, A> IntoIterator for Vec<T, A>
> +where
> +    A: Allocator,
> +{
> +    type Item =3D T;
> +    type IntoIter =3D IntoIter<T, A>;
> +
> +    /// Consumes the `Vec<T, A>` and creates an `Iterator`, which moves =
each value out of the
> +    /// vector (from start to end).
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let v =3D kernel::kvec![1, 2]?;
> +    /// let mut v_iter =3D v.into_iter();
> +    ///
> +    /// let first_element: Option<u32> =3D v_iter.next();
> +    ///
> +    /// assert_eq!(first_element, Some(1));
> +    /// assert_eq!(v_iter.next(), Some(2));
> +    /// assert_eq!(v_iter.next(), None);
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    ///
> +    /// ```
> +    /// let v =3D kernel::kvec![];
> +    /// let mut v_iter =3D v.into_iter();
> +    ///
> +    /// let first_element: Option<u32> =3D v_iter.next();
> +    ///
> +    /// assert_eq!(first_element, None);
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```

I feel a bit bad that you wrote all of this nice documentation for
functions that receive their documentation from the trait...

---
Cheers,
Benno

> +    #[inline]
> +    fn into_iter(self) -> Self::IntoIter {
> +        let (ptr, len, cap) =3D self.into_raw_parts();
> +
> +        IntoIter {
> +            ptr,
> +            // SAFETY: `ptr` is either a dangling pointer or a pointer t=
o a valid memory
> +            // allocation, allocated with `A`.
> +            buf: unsafe { NonNull::new_unchecked(ptr) },
> +            len,
> +            cap,
> +            _p: PhantomData::<A>,
> +        }
> +    }
> +}
> --
> 2.46.0
>=20


