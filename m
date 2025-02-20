Return-Path: <linux-kernel+bounces-524870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0729FA3E83A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D84B167BD3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5F9266192;
	Thu, 20 Feb 2025 23:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="DrIlFi7T"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BA7265CBA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093533; cv=none; b=oCoSwM5ei8HaKymTkUjNn9GXpFsnuPrr17B1CXfZtVpIRLm+k9OPsaqbYaOYLtcSPDntMKybOhJXBeFuNPEtyYehDZ8KFrJA4l7u+OBBotWKro8OLMs0rvjDdfOpIZZZHq9Oh/An+W4Xz+m/QCbdJVKA5tw7hlozGu5G99C6RZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093533; c=relaxed/simple;
	bh=qekYXtKUzur6RQDfjSqpA7I2U8CUtJ0pCQjlkDyL+rk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AVvT3MhhD/+5IPPp5hKvF5LymX1KgxzQ5hintiunr2Ipizl31+QU9M271YNJt45tSd3GHYCH2T7euhSFTsWTTg6E+TYbHMG3lEgcdaXZpr8989QobZknrOZzgi9rW46X0S3BeUsn+4f3WryAORk39pUOcmHnzo3Fup9VSXZkdxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=DrIlFi7T; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=6xsbb6fazjaphi6ls2p4sq5lzq.protonmail; t=1740093523; x=1740352723;
	bh=xBQAiFiI1yIVO0u4bFT+4KE+i0yQ/3TAu9mAqC+PYkY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=DrIlFi7TxaAkgKZLu7kjtdgvh1bQEboPQwtYIZe2nq2ARp3BxZZXJGO1Vo1TPTr5u
	 RAmRbdJidSVqVTd/qrfYtzDHBgXHln5xNmSJrC/umA09qvTa30Q4CcGcEnI7H8vaVo
	 1Pk5CYpQuA4WGuMPT219qFMoEYl3KY/GHaIwfHR9KARZr80cabpAd2sCyUwmuVTff9
	 lrMPN3EPYg0viAm0Uk6Re3ev6W/MUQeFuBVY661cufAdSQJb+eZX//4cCXUUqFmISK
	 d9Wm5vqWfNpPehuzz6v4qI+BKPcOsli031+jhuP/zOxPRGNdE1hUUbqWuEMtrZdx7T
	 21BNUsjGjhh9w==
Date: Thu, 20 Feb 2025 23:18:36 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 03/14] rust: sync: add `Arc::as_ptr`
Message-ID: <59064411-ae6c-4adb-8b3a-186f8004c2a0@proton.me>
In-Reply-To: <20250218-hrtimer-v3-v6-12-rc2-v8-3-48dedb015eb3@kernel.org>
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org> <20250218-hrtimer-v3-v6-12-rc2-v8-3-48dedb015eb3@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 8ef93b80597a1bd31e1f6b807ae9da724a7d71a3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.02.25 14:27, Andreas Hindborg wrote:
> Add a method to get a pointer to the data contained in an `Arc`.
>=20
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

>=20
> This is a dependency for:
>=20
> rust: hrtimer: implement `HrTimerPointer` for `Arc`
> ---
>  rust/kernel/sync/arc.rs | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 3cefda7a43725..1dfa75714f9d6 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -246,6 +246,15 @@ pub fn into_raw(self) -> *const T {
>          unsafe { core::ptr::addr_of!((*ptr).data) }
>      }
>=20
> +    /// Return a raw pointer to the data in this arc.
> +    pub fn as_ptr(this: &Self) -> *const T {
> +        let ptr =3D this.ptr.as_ptr();
> +
> +        // SAFETY: As `ptr` points to a valid allocation of type `ArcInn=
er`,
> +        // field projection to `data`is within bounds of the allocation.
> +        unsafe { core::ptr::addr_of!((*ptr).data) }
> +    }
> +
>      /// Recreates an [`Arc`] instance previously deconstructed via [`Arc=
::into_raw`].
>      ///
>      /// # Safety
> @@ -539,11 +548,11 @@ unsafe fn new(inner: NonNull<ArcInner<T>>) -> Self =
{
>      }
>=20
>      /// Creates an [`ArcBorrow`] to an [`Arc`] that has previously been =
deconstructed with
> -    /// [`Arc::into_raw`].
> +    /// [`Arc::into_raw`] or [`Arc::as_ptr`].
>      ///
>      /// # Safety
>      ///
> -    /// * The provided pointer must originate from a call to [`Arc::into=
_raw`].
> +    /// * The provided pointer must originate from a call to [`Arc::into=
_raw`] or [`Arc::as_ptr`].
>      /// * For the duration of the lifetime annotated on this `ArcBorrow`=
, the reference count must
>      ///   not hit zero.
>      /// * For the duration of the lifetime annotated on this `ArcBorrow`=
, there must not be a
>=20
> --
> 2.47.0
>=20
>=20


