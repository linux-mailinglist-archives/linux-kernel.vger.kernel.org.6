Return-Path: <linux-kernel+bounces-323826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841059743EA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 22:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EBB9285656
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160BA1A7074;
	Tue, 10 Sep 2024 20:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VS81JBGK"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A33176252
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 20:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725999156; cv=none; b=nnyOqXOBLRNaAwYvjVCrvPPHBukedCS7zPe5gAprev2Cad1ITHsCyZvdBV7TYPfzfkD1KYpHxIzTbqXgXmFyj/hMOGWW3WBhvMCa0eH8Gf/6MSB1PuNYz7zboh2Uy1+hdqYeqES+ciVXDXP6+XoZWogLsIvyXDB1f+0BBBa5IkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725999156; c=relaxed/simple;
	bh=NRiIFH6x4iZlVLGeeia5n6s/WjhrrQtPi9+1G4jqisI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOqzUbZIw/qYJjlteDSl2WnftQItQLb4nHZoqZkJxA13+ro/NaxzYGNekT0seikJ6ZAoGcfhEkPqBKwCprUFLs/RO6P79yPJB7aOw+3didSU5Eob6cV3DnPTNw5OmkKigmxje0sCX4zK9rDIk45CFirSYX+AgtaMWGVLpaHtk20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=VS81JBGK; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725999151; x=1726258351;
	bh=U7TvNmIC8oYr76NVImDfIu1YBXLZLymi+/XLCAXDtOY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VS81JBGKA2mN7j8bQElk8fOfzC9fDcZxlStBjbVZYnxsl7TWbk4PN04noUNPcqMX0
	 FhctSlK3OLOTxPJTb7skC646auw+rjrcD3kPh2+QhTa4O+dkFkxgg6Sy4gnnuSVvMk
	 vG6InoYUBHGGjp6F9pJuV5RV2+xV9G4PfskxW1EQweXYAhncuIIgxjNFfZbKrzryxD
	 oky75NVa1vNDmoevRK7YElABRXvj0bbO/FKHPkl0mBA2POy9GtHU7egizmWkJPPegw
	 yFvI5yiUqgsTi08SaAOAHeMgXYnaG0BWvztDohuk6xtGymJFcTeFi4uoQW4WxNgW1G
	 squtgGPu7zcEg==
Date: Tue, 10 Sep 2024 20:12:24 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 15/26] rust: alloc: implement `collect` for `IntoIter`
Message-ID: <747b8c1c-cb7b-422e-b6a0-ea863cc37f0a@proton.me>
In-Reply-To: <20240816001216.26575-16-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-16-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: db6c5e1305b658d7c7974deb81cc2f1735bd099d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.08.24 02:10, Danilo Krummrich wrote:
> Currently, we can't implement `FromIterator`. There are a couple of
> issues with this trait in the kernel, namely:
>=20
>   - Rust's specialization feature is unstable. This prevents us to
>     optimze for the special case where `I::IntoIter` equals `Vec`'s
>     `IntoIter` type.
>   - We also can't use `I::IntoIter`'s type ID either to work around this,
>     since `FromIterator` doesn't require this type to be `'static`.
>   - `FromIterator::from_iter` does return `Self` instead of
>     `Result<Self, AllocError>`, hence we can't properly handle allocation
>     failures.
>   - Neither `Iterator::collect` nor `FromIterator::from_iter` can handle
>     additional allocation flags.
>=20
> Instead, provide `IntoIter::collect`, such that we can at least convert
> `IntoIter` into a `Vec` again.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc/kvec.rs | 78 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>=20
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index 3b79f977b65e..ad96f4c3af9e 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -681,6 +681,84 @@ impl<T, A> IntoIter<T, A>
>      fn as_raw_mut_slice(&mut self) -> *mut [T] {
>          ptr::slice_from_raw_parts_mut(self.ptr, self.len)
>      }
> +
> +    fn into_raw_parts(self) -> (*mut T, NonNull<T>, usize, usize) {
> +        let me =3D ManuallyDrop::new(self);
> +        let ptr =3D me.ptr;
> +        let buf =3D me.buf;
> +        let len =3D me.len;
> +        let cap =3D me.cap;
> +        (ptr, buf, len, cap)
> +    }
> +
> +    /// Same as `Iterator::collect` but specialized for `Vec`'s `IntoIte=
r`.
> +    ///
> +    /// Currently, we can't implement `FromIterator`. There are a couple=
 of issues with this trait
> +    /// in the kernel, namely:
> +    ///
> +    /// - Rust's specialization feature is unstable. This prevents us to=
 optimze for the special
> +    ///   case where `I::IntoIter` equals `Vec`'s `IntoIter` type.
> +    /// - We also can't use `I::IntoIter`'s type ID either to work aroun=
d this, since `FromIterator`
> +    ///   doesn't require this type to be `'static`.
> +    /// - `FromIterator::from_iter` does return `Self` instead of `Resul=
t<Self, AllocError>`, hence
> +    ///   we can't properly handle allocation failures.
> +    /// - Neither `Iterator::collect` nor `FromIterator::from_iter` can =
handle additional allocation
> +    ///   flags.
> +    ///
> +    /// Instead, provide `IntoIter::collect`, such that we can at least =
convert a `IntoIter` into a
> +    /// `Vec` again.

I think it's great that you include this in the code, but I don't think
that it should be visible in the documentation, can you move it under
the `Examples` section and turn it into normal comments?

> +    ///
> +    /// Note that `IntoIter::collect` doesn't require `Flags`, since it =
re-uses the existing backing
> +    /// buffer. However, this backing buffer may be shrunk to the actual=
 count of elements.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let v =3D kernel::kvec![1, 2, 3]?;
> +    /// let mut it =3D v.into_iter();
> +    ///
> +    /// assert_eq!(it.next(), Some(1));
> +    ///
> +    /// let v =3D it.collect(GFP_KERNEL);
> +    /// assert_eq!(v, [2, 3]);
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn collect(self, flags: Flags) -> Vec<T, A> {
> +        let (mut ptr, buf, len, mut cap) =3D self.into_raw_parts();
> +        let has_advanced =3D ptr !=3D buf.as_ptr();
> +
> +        if has_advanced {
> +            // SAFETY: Copy the contents we have advanced to at the begi=
nning of the buffer.

This first sentence should not be part of the SAFETY comment.

> +            // `ptr` is guaranteed to be between `buf` and `buf.add(cap)=
` and `ptr.add(len)` is
> +            // guaranteed to be smaller than `buf.add(cap)`.

This doesn't justify all the requirements documented in [1].

[1]: https://doc.rust-lang.org/core/ptr/fn.copy.html#safety

> +            unsafe { ptr::copy(ptr, buf.as_ptr(), len) };
> +            ptr =3D buf.as_ptr();
> +        }
> +
> +        // This can never fail, `len` is guaranteed to be smaller than `=
cap`.
> +        let layout =3D core::alloc::Layout::array::<T>(len).unwrap();
> +
> +        // SAFETY: `buf` points to the start of the backing buffer and `=
len` is guaranteed to be
> +        // smaller than `cap`. Depending on `alloc` this operation may s=
hrink the buffer or leaves
> +        // it as it is.
> +        ptr =3D match unsafe { A::realloc(Some(buf.cast()), layout, flag=
s) } {
> +            // If we fail to shrink, which likely can't even happen, con=
tinue with the existing
> +            // buffer.
> +            Err(_) =3D> ptr,
> +            Ok(ptr) =3D> {
> +                cap =3D len;
> +                ptr.as_ptr().cast()
> +            }
> +        };
> +
> +        // SAFETY: If the iterator has been advanced, the advanced eleme=
nts have been copied to
> +        // the beginning of the buffer and `len` has been adjusted accor=
dingly. `ptr` is guaranteed
> +        // to point to the start of the backing buffer. `cap` is either =
the original capacity or,
> +        // after shrinking the buffer, equal to `len`. `alloc` is guaran=
teed to be unchanged since
> +        // `into_iter` has been called on the original `Vec`.

Turn this into bullet points please.

---
Cheers,
Benno

> +        unsafe { Vec::from_raw_parts(ptr, len, cap) }
> +    }
>  }
>=20
>  impl<T, A> Iterator for IntoIter<T, A>
> --
> 2.46.0
>=20


