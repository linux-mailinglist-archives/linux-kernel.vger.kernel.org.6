Return-Path: <linux-kernel+bounces-340507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2919F98745E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C5B7B25413
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5355C3B7A8;
	Thu, 26 Sep 2024 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="UN616mV9"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B59156CA
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727357034; cv=none; b=Q2PLhlKYsU3n7MY8Qhu/Qmn4bliGNzGlObiqk/pyakM2C1KR/3L1pYDpfa1P5P5wxR1mRT5+6xorytnzGJEgcj9FiTI50XRci0f4jPuosq85asxRWBZ1qtJzCCORNV92DB601BwqFqrCRyNiQi4IWxCQgB9nLaeJo2YPeWK3AdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727357034; c=relaxed/simple;
	bh=OCn1dTyhnGPT5aF53r21mHi2JRcXPsAcCX+1vopBdXA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mRIy5IF7894m3u3FRALbqKbVEPjA16gCPMlKV54mh+ppu99/dl5bgA/2yn9O3BoPw9EneTWhEs7lYeLpWB5m9RmhAFWTAZuv53sv8aCRsuttpEPGnjrueq+rq5Vnp8lVrmXBxXaEQlK2yHpTZ1NPkNjzOEPLOeVrCi9v4KDujus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=UN616mV9; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1727357025; x=1727616225;
	bh=b2AdEwZAwPPn/bQlFLfOgNyL9LMv1IU2cwYbMyiznM0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UN616mV9EHLs1CQBf5swLLETNgp4zuShZZ4Qw0sRysxv0hPWSjUfKJJ/3sobP5IOZ
	 92qvOt8eCPBiiX9DwySAdWBThv7wI1Rin7yhQmqhM9vISo/g1Gfa96PzGYHW5FxYo9
	 NkMBHQd87979d86XJd0A0qH6e78kn6fMgHP8X3eM1Dkf2snCpwgwHci87zdp0qkP7Q
	 cQnCaUqia2fSTVqlhT0Y3QkDUkIXpdUiwuibFWaK3XetS3rhW+3j7bOPD6s89FP0nC
	 0KM39NnstKwGaBTwWdDag5Bxl+3sNIQlDF+F0vcemBM3oZYyA7hR9QMSsLZV4ZkXEm
	 Do8xKJF2xKq3Q==
Date: Thu, 26 Sep 2024 13:23:37 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 09/26] rust: alloc: implement kernel `Box`
Message-ID: <49531204-b320-4652-90d5-d070a67260d2@proton.me>
In-Reply-To: <20240911225449.152928-10-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org> <20240911225449.152928-10-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 7a78d9617d9c55fc053ae27092fce77109763177
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.09.24 00:52, Danilo Krummrich wrote:
> `Box` provides the simplest way to allocate memory for a generic type
> with one of the kernel's allocators, e.g. `Kmalloc`, `Vmalloc` or
> `KVmalloc`.
>=20
> In contrast to Rust's `Box` type, the kernel `Box` type considers the
> kernel's GFP flags for all appropriate functions, always reports
> allocation failures through `Result<_, AllocError>` and remains
> independent from unstable features.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc.rs      |   6 +
>  rust/kernel/alloc/kbox.rs | 465 ++++++++++++++++++++++++++++++++++++++
>  rust/kernel/prelude.rs    |   2 +-
>  3 files changed, 472 insertions(+), 1 deletion(-)
>  create mode 100644 rust/kernel/alloc/kbox.rs

I have two nits below. I think the safety documentation can be improved
later, when we have decided on a better approach (I have to to spend a
significant amount of time coming up with a suggestion and even then I
am not satisfied with it). So

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> +impl<T, A> Box<T, A>
> +where
> +    T: ?Sized,
> +    A: Allocator,
> +{
> +    /// Creates a new `Box<T, A>` from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// For non-ZSTs, `raw` must point at an allocation allocated with `=
A`that is sufficiently

Missing space after "with `A`".

> +    /// aligned for and holds a valid `T`. The caller passes ownership o=
f the allocation to the
> +    /// `Box`.
> +    ///
> +    /// For ZSTs, `raw` must be a dangling, well aligned pointer.
> +    #[inline]
> +    pub const unsafe fn from_raw(raw: *mut T) -> Self {
> +        // INVARIANT: Validity of `raw` is guaranteed by the safety prec=
onditions of this function.
> +        // SAFETY: By the safety preconditions of this function, `raw` i=
s not a NULL pointer.
> +        Self(unsafe { NonNull::new_unchecked(raw) }, PhantomData::<A>)
> +    }
> +
> +    /// Consumes the `Box<T, A>` and returns a raw pointer.
> +    ///
> +    /// This will not run the destructor of `T` and for non-ZSTs the all=
ocation will stay alive
> +    /// indefinitely. Use [`Box::from_raw`] to recover the [`Box`], drop=
 the value and free the
> +    /// allocation, if any.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let x =3D KBox::new(24, GFP_KERNEL)?;
> +    /// let ptr =3D KBox::into_raw(x);
> +    /// let x =3D unsafe { KBox::from_raw(ptr) };
> +    ///
> +    /// assert_eq!(*x, 24);
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    #[inline]
> +    pub fn into_raw(b: Self) -> *mut T {
> +        let b =3D ManuallyDrop::new(b);
> +
> +        b.0.as_ptr()

Why not a single line `ManuallyDrop::new().0.as_ptr()`?

> +    }
> +
> +    /// Consumes and leaks the `Box<T, A>` and returns a mutable referen=
ce.
> +    ///
> +    /// See [Box::into_raw] for more details.
> +    #[inline]
> +    pub fn leak<'a>(b: Self) -> &'a mut T {
> +        // SAFETY: `Box::into_raw` always returns a properly aligned and=
 dereferenceable pointer
> +        // which points to an initialized instance of `T`.
> +        unsafe { &mut *Box::into_raw(b) }
> +    }
> +}


