Return-Path: <linux-kernel+bounces-571033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EB9A6B81B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C651671B0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF951F1531;
	Fri, 21 Mar 2025 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TqLDz2Mi"
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E76D1F0E49
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550794; cv=none; b=Jj00wbEv7erPP6B6q0GZPFTEAxzgztshAP1hb5i2Oh/SbFXXnIEc2d/LmSR8YVXqL6kj+F8diVWaaEkkM/Od4mffTQGBGQ+u3vkvUVvKn6IUYVzFYyqTn1x846PzZymfmwol+4bNvMk22ITteNbkyDFCxO3hfU6sZ4r7dblNCQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550794; c=relaxed/simple;
	bh=5Im9IdCl7YiD0KWmf7lGvMRlv2304gqk4UuGySAGLSc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=S9Ccju208VQUhCIjldMJIC9UavfGtBKwr73Hwt0ZlN78ZgURU9dWUPOdzsLDGh61ZM+rrcbd9vg31RdonEGwqt/eq3y5lk91PHQg7NBkD17PcLSx1R+xpk45+CHqh48fZGP2pDyW22Z84ryInnepenZ17nBRIU3mr5meHavLKjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=TqLDz2Mi; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742550790; x=1742809990;
	bh=I4TVp+R/gMvKYp2i0f/Fdu7so8nZdZGLamlBgKUs7ZY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=TqLDz2Mi9ffQCdYfdhVoRsQwM5/4cD5HMZl01YlJpO2k+VsBCau+qbeXp7SUqKMd4
	 iSD4owrN9+hu3apEVdq0W/HNLCpF2RABcSfxYbukP+xqI+fCm9DRy+u6SGYlADbsLL
	 GgUyFePvA3u8hKku5uMyAinilOVflEdIWLXGU87p3WpsgHrL6A/7/qg0o0VLxE6EWS
	 UgV9oCh6blPOODJCb/7P7kj7aIi0egbtFqXO5PHgc00eI5xSQoQKYVHr67k9mMG1Ug
	 E9yp4hncNk4cZda7EBldlQA3IhDBYuZhlUI17Lh3RLNYvJoWfxY474UKnmsjS/myml
	 bsc2Yig+ju2lQ==
Date: Fri, 21 Mar 2025 09:53:05 +0000
To: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] rust: alloc: add Vec::drain_all
Message-ID: <D8LUP60BDG4Q.30CV18D1VGPOT@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 4257044b71fba1f6d8c1da86c645afe308b3023d
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
>
> Implementing `DrainAll` in terms of `slice::IterMut` lets us reuse some
> nice optimizations in core for the case where T is a ZST.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
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

With this changed to `set_len` (or `dec_len` if only that is available):

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

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


