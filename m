Return-Path: <linux-kernel+bounces-570432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AF3A6B044
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE8E189F2C2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 22:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7A42222DD;
	Thu, 20 Mar 2025 22:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QGoU8YQa"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DEC22256C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 22:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742508392; cv=none; b=RL4WkMi88m5zLyzWpeRDkic9CfAS8bpP29aVsBiPHgeI8pPXnWN2RYON1n/JdLctkBgeVrdDVeU12DUkxgZ8HR+DvAlsOBgMZaQM4/ZJ445smvS1KWex1a2U5Ppg6UuDYn+dqBc1DlmTb1FVrvatBcueZ5USwOA2Sp6SaBjvLIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742508392; c=relaxed/simple;
	bh=lwhRW9LZfC6DDfNgBikPXiasdzWyMPP7AL4zVb4J/i0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BtO1VLaU79yBp5HRmIs7lG5azL/Gul1hPH0l7J1eV/egbLlBp44DQ+vleSN+VtW7mHPnohkLxg86x2GUEVihGKU/XgkbWYBiqB1r8btK3kR9WZqYfq1KCthyrsDdiadb/zPqJebmFAEdoJ9ljeipAvRmWkeguifgKwPWmZy823I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QGoU8YQa; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=7kezcdiusrdpdbs7lcg6czolh4.protonmail; t=1742508382; x=1742767582;
	bh=L9EFWfM29ztfK7aUGDd3jp1hf7p6SmSSDAbBTO0mD9Y=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=QGoU8YQaw5n2OFiD6TyAqSwJQx858n8VIpZkaEmso53mroIF8U6m6b3O2oK9HfWcB
	 gecEGbhjl2uf6kCt4D8XmCa6lD7L6iNp/JHa12PbqiYXPD8blt6hlEotDhTpG68Db0
	 YnsGf9iUE6NNi1CBZ0J+S2NqrQUc04Mwza48Mbt4i/GX16LOiuLLK/sIGs+K+JENnM
	 /3VANvme743vLkgQIABwh/8UQHx/+TcgP7cZ9Wx29rBVUu4Ua9x7R++ydHXbcI340P
	 jq0d07+pHLizVby2lKJ/O9c01iiR8u1ytEHU5u1apSXDJlS1I04FfHjpoNNuOeZW/X
	 sY8YHCfN0CcyQ==
Date: Thu, 20 Mar 2025 22:06:18 +0000
To: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] rust: alloc: add Vec::drain_all
Message-ID: <D8LFO0LQOPQJ.30AC77E0BOH3@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f2678cb660883584f780a54e3b83c4de3f123652
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 20, 2025 at 2:52 PM CET, Alice Ryhl wrote:
> This is like the stdlib method drain, except that it's hard-coded to use
> the entire vector's range. Rust Binder uses it in the range allocator to
> take ownership of everything in a vector in a case where reusing the
> vector is desirable.

Is the reason for not implementing `drain` complexity?

> Implementing `DrainAll` in terms of `slice::IterMut` lets us reuse some
> nice optimizations in core for the case where T is a ZST.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

The code is good, but I'd like to know the answer to the above question
before giving my RB.

> ---
>  rust/kernel/alloc/kvec.rs | 57 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 57 insertions(+)
>
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index df930ff0d0b85b8b03c9b7932a2b31dfb62612ed..303198509885f5e24b74da5a9=
2382b518de3e1c0 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -564,6 +564,30 @@ pub fn truncate(&mut self, len: usize) {
>          //   len, therefore we have exclusive access to [`new_len`, `old=
_len`)
>          unsafe { ptr::drop_in_place(ptr) };
>      }
> +
> +    /// Takes ownership of all items in this vector without consuming th=
e allocation.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let mut v =3D kernel::kvec![0, 1, 2, 3]?;
> +    ///
> +    /// for (i, j) in v.drain_all().enumerate() {
> +    ///     assert_eq!(i, j);
> +    /// }
> +    ///
> +    /// assert!(v.capacity() >=3D 4);
> +    /// ```
> +    pub fn drain_all(&mut self) -> DrainAll<'_, T> {
> +        let len =3D self.len();
> +        // INVARIANT: The first 0 elements are valid.
> +        self.len =3D 0;

Why not `set_len`?

> +        // INVARIANT: The first `len` elements of the spare capacity are=
 valid values, and as we
> +        // just set the length to zero, we may transfer ownership to the=
 `DrainAll` object.
> +        DrainAll {
> +            elements: self.spare_capacity_mut()[..len].iter_mut(),
> +        }
> +    }
>  }
> =20
>  impl<T: Clone, A: Allocator> Vec<T, A> {
> @@ -1049,3 +1073,36 @@ fn into_iter(self) -> Self::IntoIter {
>          }
>      }
>  }
> +
> +/// An iterator that owns all items in a vector, but does not own its al=
location.
> +///
> +/// # Invariants
> +///
> +/// Every `&mut MaybeUninit<T>` returned by the iterator contains a vali=
d `T` owned by this
> +/// `DrainAll`.
> +pub struct DrainAll<'vec, T> {
> +    elements: slice::IterMut<'vec, MaybeUninit<T>>,
> +}
> +
> +impl<'vec, T> Iterator for DrainAll<'vec, T> {
> +    type Item =3D T;
> +
> +    fn next(&mut self) -> Option<T> {
> +        let elem =3D self.elements.next()?;
> +        // SAFETY: By the type invariants, we may take ownership of the =
value in this
> +        // `MaybeUninit<T>`.
> +        Some(unsafe { elem.assume_init_read() })
> +    }
> +
> +    fn size_hint(&self) -> (usize, Option<usize>) {
> +        self.elements.size_hint()
> +    }
> +}
> +
> +impl<'vec, T> Drop for DrainAll<'vec, T> {
> +    fn drop(&mut self) {
> +        if core::mem::needs_drop::<T>() {

This is neat!

---
Cheers,
Benno

> +            while self.next().is_some() {}
> +        }
> +    }
> +}



