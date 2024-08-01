Return-Path: <linux-kernel+bounces-271477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 074E4944EC5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A511F2312C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B7C130A47;
	Thu,  1 Aug 2024 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="buznPNIW"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5B513BC18
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524885; cv=none; b=ndfHzLZXYLxQSfFoTyepyb9Mc/VMyRp4IPyiqmo/jsDYbv5L0licCF9FvyIjY2kGuMcdke2/HH7tS/RlYV3ONPCi81X11b+wZe5hmaFqd1w88YEJ5eewJNCFwT3T8Nf47i0JcDF5yYuCS4P4X3Bx0iHK4pDlhGJz4c+cUr0ZXds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524885; c=relaxed/simple;
	bh=7l5ryP81WmdmQU5h7NBARJhqI2TPusday5skBA5TABY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UFSpdohhclvudNbtzcWMpIAXyBZ/fKy+1bu7seDAt1A3/q7gNxqbf5D+mEm7ZDgSQ1eOttGrNb4rPokksf2r/2k2uT34Jj0oi1puIDfrSNH8Ky5x5pS7U1782fJKHJxhvBvKIkuH5Nvy+0qq4r6rnbaTjs4cY8QrgdtaJcOAPlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=buznPNIW; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-368313809a4so1334823f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 08:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722524881; x=1723129681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vizYiMazlQtEmYAHeE5sxQujP9cdybZTZcyos4O6/34=;
        b=buznPNIWsRNzUmsq1DIDLcsG0f2XV0WmOKv19hmqxtYIBh8IbUV1AT5+NmxLanmYsC
         Sx25JJcEIA0aXfMJZuTzAJmFQM7xdrDHToGJxpE2flpz17A+NFNne4togSz7Xi4E3YOL
         EDdMBfUbXJLZJNeSeIVswV3SZ/Yv7IY8jbW3Z6aku3K9CdHdpwhbZjyUBluy2ueOpaCh
         O+PfXC+y6390GbpPOigB3ILprAc2wd+HrPbq7GYZH390jBUK2HKAUsSN/GIvvacyi/us
         K14UFZDOVfC1Z5FmbwBGXLsauI20CaVPGWbKZrU5OaIfoubL8c4sBfJvzOD1RKlU2bsg
         jbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722524881; x=1723129681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vizYiMazlQtEmYAHeE5sxQujP9cdybZTZcyos4O6/34=;
        b=OBjRkXAOiGdpYNP3JYsmJunE8UA1o4XZPQgoQGwTQ5g49zB1N7akF12V1pCVHb2HKJ
         SP5L/xLWJcSRxlKZ2LpoRI5vAtHrV5OD6h4PLGGSNnRVAr5/3BCnF/ojhLY4LcYVZJl6
         xWRnX4J3usHLVZ8rdPBHQ1xDMkYPEziO12npyKVR1LbHQb9n4Xe1UReVYfw+7aWFX1Nb
         EURZIKO9MXY1Am5g5bK8GtO5+l48NfDlYKTgcDzrqfrJAZvynv0ZWMSMbzBdsrTOkmgK
         mtig6Wd5qY0Xlqxycw8cLL5F7vuOcjYz6Yz+POtC42dZTeO+4Nd4456gv5PdG142a6qA
         +YgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBsEvPMBeeH6eDPC+Jbld0xmNgZZfrReovlG1VcXp3S5blunbtdRocAhg3iHI5Db3qIeZHHEsyzU84bRkFUyKSOP6S7aRl5fimwuE5
X-Gm-Message-State: AOJu0Yw++cdIOCn520QgmRwYnR3LOjoMlRtuNEnwugOdmPqk5Wwqctg9
	2eIJlj+QDngiaZTBm6TuewBCYMKSA4fe+WdQZwS0YHTaOrmqcIHwgobjt3KFVucMNcP6mB6SkY2
	/nU7jcw/a4SsL0ftNTv4av08CPWiHWWe0dngO
X-Google-Smtp-Source: AGHT+IHFQ6rW6WpmdZpV3rx5JcfrGd60MukV3jEmR+h3sIwd7AxVnACcQa0y7IQKDQ2ho1ntU6252CFAQl1Q56G+/Dg=
X-Received: by 2002:a05:6000:156e:b0:360:8c88:ab82 with SMTP id
 ffacd0b85a97d-36bbbeefe27mr317933f8f.30.1722524881255; Thu, 01 Aug 2024
 08:08:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801000641.1882-1-dakr@kernel.org> <20240801000641.1882-17-dakr@kernel.org>
In-Reply-To: <20240801000641.1882-17-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 17:07:48 +0200
Message-ID: <CAH5fLgg+_8dpDh8A+0gW=rxXyhEF1b9za5tNapbODkKW=hjhKQ@mail.gmail.com>
Subject: Re: [PATCH v3 16/25] rust: alloc: implement `IntoIterator` for `Vec`
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, 
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 2:08=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> Implement `IntoIterator` for `Vec`, `Vec`'s `IntoIter` type, as well as
> `Iterator` for `IntoIter`.
>
> `Vec::into_iter` disassembles the `Vec` into its raw parts; additionally,
> `IntoIter` keeps track of a separate pointer, which is incremented
> correspondingsly as the iterator advances, while the length, or the count
> of elements, is decremented.
>
> This also means that `IntoIter` takes the ownership of the backing
> buffer and is responsible to drop the remaining elements and free the
> backing buffer, if it's dropped.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc.rs      |   1 +
>  rust/kernel/alloc/kvec.rs | 186 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 187 insertions(+)
>
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index bd93140f3094..f2998ad57456 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -19,6 +19,7 @@
>  pub use self::kbox::KVBox;
>  pub use self::kbox::VBox;
>
> +pub use self::kvec::IntoIter;
>  pub use self::kvec::KVVec;
>  pub use self::kvec::KVec;
>  pub use self::kvec::VVec;
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index 04cc85f7d92c..50e7705e5686 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -12,6 +12,8 @@
>      ops::DerefMut,
>      ops::Index,
>      ops::IndexMut,
> +    ptr,
> +    ptr::NonNull,
>      slice,
>      slice::SliceIndex,
>  };
> @@ -581,3 +583,187 @@ fn eq(&self, other: &$rhs) -> bool { self[..] =3D=
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
> +/// An iterator that moves out of a vector.
> +///
> +/// This `struct` is created by the `into_iter` method on [`Vec`] (provi=
ded by the [`IntoIterator`]
> +/// trait).
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
> +        unsafe { ptr::drop_in_place(self.as_raw_mut_slice()) };
> +
> +        // If `cap =3D=3D 0` we never allocated any memory in the first =
place.
> +        if self.cap !=3D 0 {
> +            // SAFETY: `self.buf` was previously allocated with `A`.
> +            unsafe { A::free(self.buf.cast()) };
> +        }

Is this ok for ZST?

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
> +    /// Creates a consuming iterator, that is, one that moves each value=
 out of
> +    /// the vector (from start to end). The vector cannot be used after =
calling
> +    /// this.
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
> 2.45.2
>

