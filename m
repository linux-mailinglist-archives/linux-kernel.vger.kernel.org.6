Return-Path: <linux-kernel+bounces-562530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E534DA62AAE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 11:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34420178686
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88DF1F4C8C;
	Sat, 15 Mar 2025 10:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Tp+loHx4"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DC618DF73
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742033382; cv=none; b=EzELmcyc4KJQ+1xn8jJpAUYC/l/5mkCKHZ3jNkW711dfKG9JT+Pt6uhynvbLCXDqKZ5FwDzbdYDvguMfwGkp+jeREmee2RuTVhHvA1cBMD76G0JJ/vFKq9EJ4jF75AwHw14bgNlXpzB9dpFjx7O1LwaYgOd/aOMSjGOcAQ/gU8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742033382; c=relaxed/simple;
	bh=8UhodB5lyzuH4a9GCl71ABJ8nhwY+/Eh9Yx2a9wuh/s=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgkwX092Md0gOg6NVCxi41kEtOkKuumYeJ5l1iy1i7+Kn8bSXxscUJ9mi3Fb2LtqOKATnKMgawF6XkrQK6pVciTVsF/IebbIS0ICCmOJcVWBt3j1MoYInsaLND6OwNaWaFKmuTKgf61pEyi7p/ee9uxxbKHA5CNNFAwVzQLS1oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Tp+loHx4; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742033372; x=1742292572;
	bh=OHcE70XPvRML9VaosSBT33NiXD1wPq+xwAXL+OkphTA=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Tp+loHx48iHnl0Mbfw+IQKG0pY7CIKt+S8b5Qp0/uQFjpiVqxywW8bQJ1qjOxzgM3
	 vZCvMH00hXsp4ZHB0GmTvxu/2jse5RgkhYpBzM+Hsn5PGzqPyC770t/HIBAvkQ2D97
	 iTRoGMLHWXkjzR6pzV1/afXKBkftflUctRtFac7nXpyClHlxb5Lm/MLGY3Q8AgrxBp
	 OMcGiqzQmSe8u8kXrlqF5fdpzMu1V3kibmmDoyVHiUuqDYryV6d9Zu2MvR+z0Y1oMF
	 IgIeZoVDz/psd+eQBCBNU93NgINwW23tb+K3uZ48gep/Ytg7DidfZl4kjLPimZc4P5
	 8eSzA3OKeOWKg==
Date: Sat, 15 Mar 2025 10:09:26 +0000
To: Andrew Ballance <andrewjballance@gmail.com>, dakr@kernel.org, airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, acourbot@nvidia.com, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Subject: Re: [PATCH 1/3] rust: alloc: add Vec::truncate method
Message-ID: <D8GRAC8YQIVC.2LS1EIIIRZU3I@proton.me>
In-Reply-To: <20250315024235.5282-2-andrewjballance@gmail.com>
References: <20250315024235.5282-1-andrewjballance@gmail.com> <20250315024235.5282-2-andrewjballance@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f76ad4a7a800f1deeb9c27a5c54e750de1d80a8c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat Mar 15, 2025 at 3:42 AM CET, Andrew Ballance wrote:
> implements the equivalent to the std's Vec::truncate
> on the kernel's Vec type.
>
> Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> ---
>  rust/kernel/alloc/kvec.rs | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index ae9d072741ce..75e9feebb81f 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -452,6 +452,42 @@ pub fn reserve(&mut self, additional: usize, flags: =
Flags) -> Result<(), AllocEr
> =20
>          Ok(())
>      }
> +
> +    /// Shortens the vector, setting the length to `len` and drops the r=
emoved values.
> +    /// If `len` is greater than or equal to the current length, this do=
es nothing.
> +    ///
> +    /// This has no effect on the capacity and will not allocate.
> +    /// # Examples
> +    /// ```
> +    /// let mut v =3D kernel::kvec![1, 2, 3]?;
> +    /// v.truncate(1);
> +    /// assert_eq!(v.len(), 1);
> +    /// assert_eq!(&v, &[1]);
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn truncate(&mut self, len: usize) {
> +        if len >=3D self.len() {
> +            return;
> +        }
> +
> +        // [new_len, len) is guaranteed to be valid because [0, len) is =
guaranteed to be valid
> +        let drop_range =3D len..self.len();
> +
> +        // SAFETY:
> +        // we can safely ignore the bounds check because we already did =
our own check
> +        let ptr: *mut [T] =3D unsafe { self.get_unchecked_mut(drop_range=
) };

What's this `get_unchecked_mut` method, I don't see it in `rust-next` or
`alloc-next`.

> +
> +        // SAFETY:
> +        // it is safe to shrink the length because the new length is
> +        // guaranteed to be less than the old length

Please take a look at the documentation of `set_len`, in the safety
section you'll find what you need to justify here.

> +        unsafe { self.set_len(len) };
> +
> +        // SAFETY:

A couple points missing:
- why is the pointer valid?

> +        // - the dropped values are valid `T`s
> +        // - we are allowed to invalidate [new_len, old_len) because we =
just changed the len

This should justify why the value will never be accessed again.

---
Cheers,
Benno

> +        unsafe { ptr::drop_in_place(ptr) };
> +    }
>  }
> =20
>  impl<T: Clone, A: Allocator> Vec<T, A> {



