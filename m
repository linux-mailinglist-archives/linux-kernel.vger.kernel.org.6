Return-Path: <linux-kernel+bounces-324051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FBC97474D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 02:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4FB1F26EEF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 00:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC21B665;
	Wed, 11 Sep 2024 00:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAJYtQne"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C20F6FD5;
	Wed, 11 Sep 2024 00:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726014146; cv=none; b=oEU4YCdJqP/55Au0k1ZTowQ1W/fY2Vkf+c60OeDUXgtG9oJREKhawBreHQu5X9tRIS5bwn1+Bk7coLxcqZV4Nov+Xd4W6sh7o8YRGx4L86MP/oceE3GrOGvVPF/x35ENig0EX47meShL3R5UIZxyjn02Bis0urSr5MBVR+6nwkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726014146; c=relaxed/simple;
	bh=+LNBlMyxvbRaAdNBPQigbMl3HJSQC/MdjwNU5oKAVHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlRXU2BLvFpI1KbNPmW8nilt9sfrr/0zTmbRzawcs8xlBmCKwYr1h6rDy1HoorekiGl3m1S2pmWuyZsU+zWjudwcN6t27QiBC27+Bgw3EobtsKyjLW+nPsIBfw+sJDWVu6dJPx5B2wXfe797zP/it4FJxP9WNF/WAjr8YX1/bYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAJYtQne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5253FC4CEC3;
	Wed, 11 Sep 2024 00:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726014146;
	bh=+LNBlMyxvbRaAdNBPQigbMl3HJSQC/MdjwNU5oKAVHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hAJYtQneMjP2OTggHTC04Y8ifcN8qpmSKrlfbNZBRBUS1YOLFp6Tw0Pg2M5ofNBON
	 rgYZ3fTXmv6FWzOWn4J9+dHgLT1vyLVm558Q707l+6gTid+GW9xud7siZbunA3quaq
	 4z2wymSbLAj9BrDwnxvuOinbbeY7gKYJigBbt3h+xqNP6CyEqwp8OmRBplnS8oBKLs
	 iwOFz7AgmitwtSxMfd7S7YmGEkrQ2ZrJPxbdSFEVUF5R/6XMWhOEqF7hqdHO7RwLky
	 2E7FnESyKsFOP9CC6nECWz1y7RiZs8dqbw3x9oKnKp05Fxc0W8rM4kx6vih2sF6O6F
	 +yKnC5/hNir4w==
Date: Wed, 11 Sep 2024 02:22:18 +0200
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
Subject: Re: [PATCH v6 15/26] rust: alloc: implement `collect` for `IntoIter`
Message-ID: <ZuDiurdQfvmewzDh@pollux>
References: <20240816001216.26575-1-dakr@kernel.org>
 <20240816001216.26575-16-dakr@kernel.org>
 <747b8c1c-cb7b-422e-b6a0-ea863cc37f0a@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <747b8c1c-cb7b-422e-b6a0-ea863cc37f0a@proton.me>

On Tue, Sep 10, 2024 at 08:12:24PM +0000, Benno Lossin wrote:
> On 16.08.24 02:10, Danilo Krummrich wrote:
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
> > ---
> >  rust/kernel/alloc/kvec.rs | 78 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 78 insertions(+)
> > 
> > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> > index 3b79f977b65e..ad96f4c3af9e 100644
> > --- a/rust/kernel/alloc/kvec.rs
> > +++ b/rust/kernel/alloc/kvec.rs
> > @@ -681,6 +681,84 @@ impl<T, A> IntoIter<T, A>
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
> 
> I think it's great that you include this in the code, but I don't think
> that it should be visible in the documentation,

Why not? I think this information is valuable for users of this API.

> can you move it under
> the `Examples` section and turn it into normal comments?
> 
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
> > +    /// let v = it.collect(GFP_KERNEL);
> > +    /// assert_eq!(v, [2, 3]);
> > +    ///
> > +    /// # Ok::<(), Error>(())
> > +    /// ```
> > +    pub fn collect(self, flags: Flags) -> Vec<T, A> {
> > +        let (mut ptr, buf, len, mut cap) = self.into_raw_parts();
> > +        let has_advanced = ptr != buf.as_ptr();
> > +
> > +        if has_advanced {
> > +            // SAFETY: Copy the contents we have advanced to at the beginning of the buffer.
> 
> This first sentence should not be part of the SAFETY comment.
> 
> > +            // `ptr` is guaranteed to be between `buf` and `buf.add(cap)` and `ptr.add(len)` is
> > +            // guaranteed to be smaller than `buf.add(cap)`.
> 
> This doesn't justify all the requirements documented in [1].
> 
> [1]: https://doc.rust-lang.org/core/ptr/fn.copy.html#safety
> 
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
> > +        ptr = match unsafe { A::realloc(Some(buf.cast()), layout, flags) } {
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
> 
> Turn this into bullet points please.
> 
> ---
> Cheers,
> Benno
> 
> > +        unsafe { Vec::from_raw_parts(ptr, len, cap) }
> > +    }
> >  }
> > 
> >  impl<T, A> Iterator for IntoIter<T, A>
> > --
> > 2.46.0
> > 
> 

