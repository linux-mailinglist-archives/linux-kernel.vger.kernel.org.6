Return-Path: <linux-kernel+bounces-332868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 737B297C00B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 20:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A42283291
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0001AD3F9;
	Wed, 18 Sep 2024 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Kj2rwrBl"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9563C17A597
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 18:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726683567; cv=none; b=m29E9Uf7E22RX/8QMecmu7G3Nx4cbDdtid72Vs+jF7KbYEK9SiczzIH/2sheMZ5W4E+PTKi5tg+gyepZg5qzrzT1XSQF0v92Z/YxFPTqDd8+3Xuac3vI3yNAa7kxChGCgGDcsrG2XNPyOw/ZnggLwROp4TdvnBh5NTcG84FTcsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726683567; c=relaxed/simple;
	bh=XVZ7VYwBlv5nPP/bJyxUbTPyMyoWmI0zjbyYxj/RILs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2jc6tCswIvVatLUEcCC1BOR/eAhU4wvpdoyVY5MDv7rD4ZTvh+U5WcCU0yFDuCR5srRwTJTzCPefPY+DKav1HstRVVn215Ld9VSd637O3+ZI4d4tXm4WPR85nkVEhA5t3VYYE+shtqoaooOLhXhoAqflsGrNORnxBm9Y/SVwT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Kj2rwrBl; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726683563; x=1726942763;
	bh=wLZV/gnSfV/A4fyJGr4Mr1SzPLUYLQ1npnxEQgsttm0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Kj2rwrBltrZNYApXPfoG9NI5Xlh9MKP3DTEbxELpFyJf/SCj9uJD2g5PLx2Rk1y+0
	 jbY28fpLOugIWkDxs7cNczH0AjelkHMhiKfJRSfrOd28G1uT99IaxHHw5heADdr57+
	 ABMGF9q+7uZHMI0hGtnbgm+hFQ7oZAQesUpv1QiChmQnB5RUpUHS9MTLIxu+wI2hiB
	 bFiWbw64apDQ7K0k5jFSI2x+zR+Jj+YJ4ZdF8XWzp3+i8uZzvIRw3Inl4nsTMOXvV0
	 tCFHsJF2qCDxEgbSxI2b7hMeCex3u1EWTXkXy0A/tfEbsq83ylkwhuDpGk05EYisq0
	 R5Np+mOqTetJQ==
Date: Wed, 18 Sep 2024 18:19:20 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/14] rust: sync: add `Arc::clone_from_raw`
Message-ID: <43b9bc9b-f64c-4421-8cf2-795f1f0ec94a@proton.me>
In-Reply-To: <20240917222739.1298275-5-a.hindborg@kernel.org>
References: <20240917222739.1298275-1-a.hindborg@kernel.org> <20240917222739.1298275-5-a.hindborg@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 25fee8e9590c313862054cf735b75b803e6c9664
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.09.24 00:27, Andreas Hindborg wrote:
> Add a method to clone an arc from a pointer to the data managed by the
> `Arc`.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/sync/arc.rs | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index a57ea3e2b44c..2c95712d12a2 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -282,6 +282,26 @@ pub unsafe fn from_raw(ptr: *const T) -> Self {
>          unsafe { Self::from_inner(ptr) }
>      }
>=20
> +    /// Clones an [`Arc`] instance from a pointer to the contained data.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must point to an allocation that is contained within a liv=
e [`Arc<T>`].
> +    pub unsafe fn clone_from_raw(ptr: *const T) -> Self {
> +        // SAFETY: The caller promises that this pointer points to data
> +        // contained in an `Arc` that is still valid.
> +        let inner =3D unsafe { ArcInner::container_of(ptr).as_ref() };
> +
> +        // INVARIANT: C `refcount_inc` saturates the refcount, so it can=
not
> +        // overflow to zero. SAFETY: By the function safety requirement,=
 there
> +        // is necessarily a reference to the object, so it is safe to in=
crement
> +        // the refcount.
> +        unsafe { bindings::refcount_inc(inner.refcount.get()) };
> +
> +        // SAFETY: We just incremented the refcount. This increment is n=
ow owned by the new `Arc`.
> +        unsafe { Self::from_inner(inner.into()) }

The implementation of this function looks a bit strange to me, how about
this?:

    // SAFETY: this function has the same safety requirements as `from_raw`=
.
    let arc =3D unsafe { Self::from_raw(ptr) };
    let clone =3D arc.clone();
    // Prevent decrementing the refcount.
    mem::forget(arc);
    clone

(of course you would need to change the safety requirements of
`clone_from_raw` to point to `from_raw`)

---
Cheers,
Benno

> +    }
> +
>      /// Returns an [`ArcBorrow`] from the given [`Arc`].
>      ///
>      /// This is useful when the argument of a function call is an [`ArcB=
orrow`] (e.g., in a method
> --
> 2.46.0
>=20
>=20


