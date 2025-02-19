Return-Path: <linux-kernel+bounces-521458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE0AA3BD94
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19AB162820
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C1C1DFE34;
	Wed, 19 Feb 2025 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="l9XZjGoK"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3AB1DFE16
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739966302; cv=none; b=ThUIurD4tteA7qHB3UJlrVFfW3bGvTuL/2voXM5Z8/4cJRZ+W6i91mKPFTehFLOtNB8rwZU1zCUAUVQzCffxVKSK0BS06+66obciKf4+qULtzf/2tpmWJOyO+jFDY2C48DR8Ib64FG61Ymyds4YB58HHVmMfg9vcFMK6e0iEKJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739966302; c=relaxed/simple;
	bh=IQwB3NFG8/IhCwRhCtQX9kYWbIOJ6ONhh9w6/Sqv+yM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=euIBlJJKfH7H02P2BDRnOQeSwQ1ZvYbZIAB4P4X92s98DcljYgBprBRUthsfOH6l+699miPOrXGgbE0FGuRnQeeg+jhfxXWuN/zsgCtCRvpHXoZoHT7DCxIr0UWFaVbfn2r5p1NbBtalVxG9cQNKE0yG3mClekMHJHkVG2JFIwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=l9XZjGoK; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1739966297; x=1740225497;
	bh=1yjPbPUkyS2rXPiH+2wA1L6mLSmah2RfaLYZpwcCsXs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=l9XZjGoKFBcUwlPCk+rTDU+AsAOQO8vTEBzcOLWwuyaqckUcQpdAREHDpd/pAOz15
	 rcXhaVq3u1ekNK4R/bJ6MTuB0gJ1iUbbxAWJz9fhNXVHtdiSqi1PSpOKb9yw7nVgL5
	 gtbkr1BxgvXq4+Ie8yxCgw6twpVg4squfulBavusGIN2oz9llaxligHRITcUkGibDm
	 wNNCZfLggrtrnPO1OL1dVkFuHkUGnfvRucsBquV1ugAoAh7m6suiH3bs426vHqzSPi
	 ntvkGXJWhHyRcEbiLCdMGzi3TgeuqgxJuwcCocUnafqGJw+R5IjAAMlwwuSp8RUvhN
	 o+Ac7F/Q0eAkA==
Date: Wed, 19 Feb 2025 11:58:11 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 01/14] rust: time: Add Ktime::from_ns()
Message-ID: <693e39f6-70ac-4752-b371-74a3bd1fcf16@proton.me>
In-Reply-To: <20250218-hrtimer-v3-v6-12-rc2-v8-1-48dedb015eb3@kernel.org>
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org> <20250218-hrtimer-v3-v6-12-rc2-v8-1-48dedb015eb3@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 32e962c8e2da76ac38d1e5ab0428cf13ed85b6af
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.02.25 14:27, Andreas Hindborg wrote:
> From: Lyude Paul <lyude@redhat.com>
>=20
> A simple function to turn the provided value in nanoseconds into a Ktime
> value. We allow any type which implements Into<bindings::ktime_t>, which
> resolves to Into<i64>.
>=20
> This is useful for some of the older DRM APIs that never got moved to
> Ktime.

Are these older DRM APIs on the C side, or on the Rust side? If they are
on the Rust side, we should just move them to Ktime, no?

> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Lyude Paul <lyude@redhat.com>

This seems wrong considering the `From Lyude Paul` line above :) (or is
it possible to review your own patch?)

The patch itself looks good, so iff the above question is answered with
"the older DRM APIs are on the C side" then:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/time.rs | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 379c0f5772e57..87e47f2f5618d 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -8,6 +8,8 @@
>  //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.=
h).
>  //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
>=20
> +use core::convert::Into;
> +
>  /// The number of nanoseconds per millisecond.
>  pub const NSEC_PER_MSEC: i64 =3D bindings::NSEC_PER_MSEC as i64;
>=20
> @@ -63,6 +65,12 @@ pub fn to_ns(self) -> i64 {
>      pub fn to_ms(self) -> i64 {
>          self.divns_constant::<NSEC_PER_MSEC>()
>      }
> +
> +    /// Creates a new Ktime from the given duration in nanoseconds.
> +    #[inline]
> +    pub fn from_nanos(ns: impl Into<bindings::ktime_t>) -> Self {
> +        Self { inner: ns.into() }
> +    }
>  }
>=20
>  /// Returns the number of milliseconds between two ktimes.
>=20
> --
> 2.47.0
>=20
>=20


