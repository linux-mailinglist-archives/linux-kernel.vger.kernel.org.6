Return-Path: <linux-kernel+bounces-516876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A204BA37928
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 01:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A24188DA7A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 00:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5886A79D2;
	Mon, 17 Feb 2025 00:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DH769yMn"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150C94A21
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 00:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739751679; cv=none; b=tbiATcORHgGT4CZmiuRNzwQkPr4/uTPSY4Vw7pRFu3LDmBaTkHxTE6Cc8gCA0uJ/TGgQU3LeG4ShJn5V9VMvFNfIK1ZjP61nv9xGMXdoCg4VeQspQ3RfJq1/oCyMeb7R/i4EzftGt9MQ8iNlEQS3Ywxm4nIBquti1CaGzjCCyjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739751679; c=relaxed/simple;
	bh=WCG/lAj06OrR+lKbK3UKi69SncQAWptH7uHVK7VD1bs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=couCTXG1CcwGA7nwxqYVVzHyod5dP2Tdqjx+ocCNh+9vMu4E2ZZ4SUfj8G4I5q/tJAibsGjBMoI8Y8oWGazZxOTex54xDKE44XmfJZAJJYZ9ooTWn/CPT7W34XReSfLUQdxzUo91fegPLU4v/Yct3vHQ1uZW/DOo8z4atAqSTRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DH769yMn; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1739751675; x=1740010875;
	bh=qB3VQYx7RnSiaMOOBLyFE+y1XndT5PX2EloQky+RacA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=DH769yMnTdBBRAP1BY+PfJc8g2dy8E8jKKsw3rAjP4RYBE5vd1EvlWEmWsGoMCvPU
	 /M+ZNORtOX35ABcXki+C/szkSpx69guzVx1y0XGE5i5BnBlEihKF62PmsRCn1GaY7N
	 EZYfg6fIqayYoit3WOftAz+CZ513CFY+WPjXz+S0INwCDV443O7FZajQ4GzoxQdPbq
	 LfeOfyvK5ojHPV1ro+I8a4tHBVrEHfFTMJjj8YdeuWn1vK8dDE0GDoKLnKBCykETVU
	 8XTyiPO1CjjFUeHSVPUavvKgfnqI+yuUKxmzPPPuI037W6GK9jBu98if0sDiW/CPDL
	 TvPufMnEkNiBw==
Date: Mon, 17 Feb 2025 00:21:09 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Fiona Behrens <me@kloenk.dev>, Charalampos Mitrodimas <charmitro@posteo.net>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] rust: sync: change `<Arc<T> as ForeignOwnable>::PointedTo` to `T`
Message-ID: <9f9641de-72ea-4aa1-827c-3bc6c97938b0@proton.me>
In-Reply-To: <20250207-configfs-v2-1-f7a60b24d38e@kernel.org>
References: <20250207-configfs-v2-0-f7a60b24d38e@kernel.org> <20250207-configfs-v2-1-f7a60b24d38e@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a5099023aa2f2ab4d90b3c3db77daaa097752d5b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.02.25 15:41, Andreas Hindborg wrote:
> Using `ArcInner` as `PoinedTo` in the `ForeignOwnable` implementation for
> `Arc` is a bit unfortunate. Using `T` as `PointedTo` does not remove any
> functionality, but allows `ArcInner` to be private. Further, it allows
> downstream users to write code that is generic over `Box` and `Arc`, when
> downstream users need access to `T` after calling `into_foreign`.
>=20
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Two nits below, but this looks good regardless, so:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>=20
> This patch is a dependency for Rust `configfs` abstractions. It allows bo=
th
> `Box` and `Arc` to be used as pointer types in the `configfs` hierarchy.
> ---
>  rust/kernel/sync/arc.rs | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>=20
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index dfe4abf82c25c..503e318b4c4ef 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -143,7 +143,7 @@ pub struct Arc<T: ?Sized> {
>  #[doc(hidden)]
>  #[pin_data]
>  #[repr(C)]
> -pub struct ArcInner<T: ?Sized> {
> +struct ArcInner<T: ?Sized> {
>      refcount: Opaque<bindings::refcount_t>,
>      data: T,
>  }
> @@ -345,18 +345,25 @@ pub fn into_unique_or_drop(self) -> Option<Pin<Uniq=
ueArc<T>>> {
>=20
>  // SAFETY: The `into_foreign` function returns a pointer that is well-al=
igned.
>  unsafe impl<T: 'static> ForeignOwnable for Arc<T> {
> -    type PointedTo =3D ArcInner<T>;
> +    type PointedTo =3D T;
>      type Borrowed<'a> =3D ArcBorrow<'a, T>;
>      type BorrowedMut<'a> =3D Self::Borrowed<'a>;
>=20
>      fn into_foreign(self) -> *mut Self::PointedTo {
> -        ManuallyDrop::new(self).ptr.as_ptr()
> +        let x =3D ManuallyDrop::new(self).ptr.as_ptr();

I would normally name such a variable `this`, but it's fine as-is.

> +        // SAFETY: `x` is a valid pointer to `Self` so the projection be=
low is
> +        // in bounds of the allocation.
> +        unsafe { core::ptr::addr_of_mut!((*x).data) }
>      }
>=20
>      unsafe fn from_foreign(ptr: *mut Self::PointedTo) -> Self {
> +        // SAFETY: We did the reverse offset calculation in `into_foreig=
n`, so
> +        // the offset calculation below is in bounds of the allocation.
> +        let inner_ptr =3D unsafe { kernel::container_of!(ptr, ArcInner<T=
>, data).cast_mut() };
> +
>          // SAFETY: The safety requirements of this function ensure that =
`ptr` comes from a previous
>          // call to `Self::into_foreign`.
> -        let inner =3D unsafe { NonNull::new_unchecked(ptr) };
> +        let inner =3D unsafe { NonNull::new_unchecked(inner_ptr) };
>=20
>          // SAFETY: By the safety requirement of this function, we know t=
hat `ptr` came from
>          // a previous call to `Arc::into_foreign`, which guarantees that=
 `ptr` is valid and
> @@ -365,9 +372,13 @@ unsafe fn from_foreign(ptr: *mut Self::PointedTo) ->=
 Self {
>      }
>=20
>      unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> ArcBorrow<'a, T> =
{
> +        // SAFETY: We did the reverse offset calculation in `into_foreig=
n`, so
> +        // the offset calculation below is in bounds of the allocation.
> +        let inner_ptr =3D unsafe { kernel::container_of!(ptr, ArcInner<T=
>, data).cast_mut() };

You could call this variable `ptr` and avoid the change below, but
either way is fine.

---
Cheers,
Benno

> +
>          // SAFETY: The safety requirements of this function ensure that =
`ptr` comes from a previous
>          // call to `Self::into_foreign`.
> -        let inner =3D unsafe { NonNull::new_unchecked(ptr) };
> +        let inner =3D unsafe { NonNull::new_unchecked(inner_ptr) };
>=20
>          // SAFETY: The safety requirements of `from_foreign` ensure that=
 the object remains alive
>          // for the lifetime of the returned value.
>=20
> --
> 2.47.0
>=20
>=20


