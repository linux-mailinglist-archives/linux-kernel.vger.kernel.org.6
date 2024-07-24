Return-Path: <linux-kernel+bounces-261096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDE693B2C8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1570C283DB5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1AB15A4B0;
	Wed, 24 Jul 2024 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="x1n1V5JF"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA002D030
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831764; cv=none; b=P6wg7e1+d5E2XYkEBMJZ2Q1ZVh53hRoXQMocEmn57LUXOXX2pROUg18x4yy7D3M9ELjLemnU1HsK3mbNFOccJvvFTt+8QPveqPGxuwYgbHTfiMNvu9h8HVx85+3goMpX8sU66N7yMLLZ+4sBeHwNa7Qo1C6MPnDGofREafZ43H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831764; c=relaxed/simple;
	bh=RfaAEUH7ysoqbZT+t5+w57ZhJTTy47wghqq5biYEfwA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5mg9k8AYZXcHLsFhFWqjcCwVhdgic6iiRHrqIsIOir6cIu7PQ9VG++nuCK46iGqyQeforj7Pf9Isg/I9G+jQrKywq+zIW9hLgYPeV0uq29utdxAsLlgEFmX/MY3MiHaZvZ5nZAewvAmbSPFM3zNQK0muVF8nN79XJOQYRZka+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=x1n1V5JF; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1721831753; x=1722090953;
	bh=G5JBK4hg6swPkj4jaEo2fVZzCn/NvlSPZRnie21RW3k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=x1n1V5JFnjmkg7piqrTjbZBtHJBx0u3Y9tj1peU5X9/UGkXBURstrTd62rOv2MwPc
	 JiUQwOrxG0OXkhX1jqY2vK0w/loO9wwyScG2NUWsk5orVPe4gQAnuOLTRkeR7G2ZYr
	 zXyvfk9PK9nywKzesIgS0lcYDX+PM13tuVLjeew2Ah6ZyXydLJ+T0GA8vNWHamhaXi
	 Zq37MRWTuD0UdGIYHm7mVk7bap8x0ZoSmwbbDKRNaEYusblxDsyf5m0x3vjvzAte1E
	 zeUrI3WigVFigOyvQz3Z225ToLeVm/IYYVuxR69i5/sPv9vzj2bhETRdPPRLdXj20r
	 sA9khH+gFUGuA==
Date: Wed, 24 Jul 2024 14:35:46 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Heghedus Razvan <heghedus.razvan@protonmail.com>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 16/23] rust: alloc: implement `collect` for `IntoIter`
Message-ID: <D2XUESJWJNIY.3HP9IDB0NKFYI@protonmail.com>
In-Reply-To: <20240723181024.21168-17-dakr@kernel.org>
References: <20240723181024.21168-1-dakr@kernel.org> <20240723181024.21168-17-dakr@kernel.org>
Feedback-ID: 1233518:user:proton
X-Pm-Message-ID: 34d1f58a09b4a2bc6f6f2c4b80d22796d51431a5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Jul 23, 2024 at 9:10 PM EEST, Danilo Krummrich wrote:
> Currently, we can't implement `FromIterator`. There are a couple of
> issues with this trait in the kernel, namely:
>
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
Well that's a shame, so I guess collecting a Filter or Map is not possible.

>
> Instead, provide `IntoIter::collect`, such that we can at least convert
> `IntoIter` into a `Vec` again.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc/kvec.rs | 80 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 79 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index fbfb755b252d..5c317931e14c 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -2,7 +2,7 @@
>
>  //! Implementation of [`Vec`].
>
> -use super::{AllocError, Allocator, Flags};
> +use super::{flags::*, AllocError, Allocator, Flags};
>  use crate::types::Unique;
>  use core::{
>      fmt,
> @@ -633,6 +633,84 @@ impl<T, A> IntoIter<T, A>
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
> +    /// let v =3D it.collect();
> +    /// assert_eq!(v, [2, 3]);
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn collect(self) -> Vec<T, A> {
> +        let (mut ptr, buf, len, mut cap) =3D self.into_raw_parts();
> +        let has_advanced =3D ptr !=3D buf.as_ptr();
> +
> +        if has_advanced {
> +            // SAFETY: Copy the contents we have advanced to at the begi=
nning of the buffer.
> +            // `ptr` is guaranteed to be between `buf` and `buf.add(cap)=
` and `ptr.add(len)` is
> +            // guaranteed to be smaller than `buf.add(cap)`.
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
> +        ptr =3D match unsafe { A::realloc(Some(buf.cast()), layout, GFP_=
KERNEL) } {
Here you use `GFP_KERNEL` flag directly. Shouldn't this be an argument of `=
collect` function?=20

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
> +        unsafe { Vec::from_raw_parts(ptr, len, cap) }
> +    }
>  }
>
>  impl<T, A> Iterator for IntoIter<T, A>
> --
> 2.45.2



