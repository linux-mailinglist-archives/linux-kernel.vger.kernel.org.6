Return-Path: <linux-kernel+bounces-524929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C75DA3E8D4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82BA14229BB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3516F267F4E;
	Thu, 20 Feb 2025 23:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="anElHFl+"
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFDD1EE03D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740095259; cv=none; b=LWnwX4+jwU4UzIsAfoerl+kfYai1Yy0o3YlQIJyNWxuxvO6T151tLhs1sCClf1AJBgvyoF+wDK4iwRLRyClX5vixA9jbcJPq38sTHvaLpmNRsWIZvqYgC6dFjptRBz/TaLSU0njq5jF/eOMv/jCShOTqYc3hUftQmFexNfryb4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740095259; c=relaxed/simple;
	bh=w4T+ah5JQ4iTdSqvx3oac5Qkn0xWU1VeqbTpWFAvsOg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbgcEALFmaTbKmb9agDRad/1r/3cQfeg0AOkANaOOcR2Rf5eFdDtBFULkImatgugXrM6rzgKGAHKMG07plv9uSsXINO4B2srpJbrrglQJ5Wm2oI0/+Q7k4+d6ggYCX2cYeMeWUEBkxUFYTJJBDxqEqTy9PGepbjCU32lywkgQrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=anElHFl+; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=vxt2o2rruvf2dl4kokok72a5ha.protonmail; t=1740095255; x=1740354455;
	bh=j5eID5FuIaYQp8zzP16hSMfM0CmS/MS5iWnefkVTiRU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=anElHFl+SurPlTO0kvSIz0NlSPmGlTo2bxlUJI3w6AclZrCAhW03nO6Q2heuLAEJK
	 yJsCWW3H/g6MExV5WNF6uJk/IQnlhYknqAAdaNxoAT8lxGcwUnlA60Q+j5RuuxL2P6
	 ZcjQ7LW8MOToDgT2C8PtRw8FAJiNIG03SQdFXV8HJabqWvwlrr/aiXADJJ1ybj2qlz
	 G/FDYSqNNhBlkJmyeyD2uRnE4lJWZkz7zqRUzuPPSjh6XSE2ChsTD/N6voYytNg/ln
	 4dLC3ZURK91Zq+RADBydbB3Qxi09DrCWbh4gEEIyMSzb+mOPCDfQte6rQytcK4hPLM
	 NLmpKGZ0uawDA==
Date: Thu, 20 Feb 2025 23:47:30 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 05/14] rust: hrtimer: allow timer restart from timer handler
Message-ID: <8e32c3e1-0b55-4809-92ad-f968252a05f8@proton.me>
In-Reply-To: <20250218-hrtimer-v3-v6-12-rc2-v8-5-48dedb015eb3@kernel.org>
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org> <20250218-hrtimer-v3-v6-12-rc2-v8-5-48dedb015eb3@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 767350196db5980b1a5d90fe6a7915a1a9f9791a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.02.25 14:27, Andreas Hindborg wrote:
> This patch allows timer handlers to report that they want a timer to be
> restarted after the timer handler has finished executing.
>=20
> Also update the `hrtimer` documentation to showcase the new feature.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/time/hrtimer.rs     | 28 +++++++++++++++++++++++++++-
>  rust/kernel/time/hrtimer/arc.rs |  4 +---
>  2 files changed, 28 insertions(+), 4 deletions(-)
>=20
> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> index b2a3130bc21d7..e342193f985eb 100644
> --- a/rust/kernel/time/hrtimer.rs
> +++ b/rust/kernel/time/hrtimer.rs
> @@ -183,7 +183,7 @@ pub trait HrTimerCallback {
>      type CallbackTargetParameter<'a>;
>=20
>      /// Called by the timer logic when the timer fires.
> -    fn run(this: Self::CallbackTargetParameter<'_>)
> +    fn run(this: Self::CallbackTargetParameter<'_>) -> HrTimerRestart
>      where
>          Self: Sized;
>  }
> @@ -278,6 +278,32 @@ unsafe fn start(self_ptr: *const Self, expires: Ktim=
e) {
>      }
>  }
>=20
> +/// Restart policy for timers.
> +pub enum HrTimerRestart {
> +    /// Timer should not be restarted.
> +    NoRestart,
> +    /// Timer should be restarted.
> +    Restart,
> +}
> +
> +impl From<bindings::hrtimer_restart> for HrTimerRestart {
> +    fn from(value: u32) -> Self {
> +        match value {
> +            bindings::hrtimer_restart_HRTIMER_NORESTART =3D> Self::NoRes=
tart,
> +            _ =3D> Self::Restart,
> +        }
> +    }
> +}
> +
> +impl From<HrTimerRestart> for bindings::hrtimer_restart {
> +    fn from(value: HrTimerRestart) -> Self {
> +        match value {
> +            HrTimerRestart::NoRestart =3D> bindings::hrtimer_restart_HRT=
IMER_NORESTART,
> +            HrTimerRestart::Restart =3D> bindings::hrtimer_restart_HRTIM=
ER_RESTART,
> +        }
> +    }
> +}

Do drivers need these impls? If no, I would prefer a private conversion
function just for the abstraction.

---
Cheers,
Benno

> +
>  /// Use to implement the [`HasHrTimer<T>`] trait.
>  ///
>  /// See [`module`] documentation for an example.
> diff --git a/rust/kernel/time/hrtimer/arc.rs b/rust/kernel/time/hrtimer/a=
rc.rs
> index d1c90631d0036..109eded0e73be 100644
> --- a/rust/kernel/time/hrtimer/arc.rs
> +++ b/rust/kernel/time/hrtimer/arc.rs
> @@ -82,8 +82,6 @@ impl<T> RawHrTimerCallback for Arc<T>
>          // timer. This `T` is contained in an `Arc`.
>          let receiver =3D unsafe { ArcBorrow::from_raw(data_ptr) };
>=20
> -        T::run(receiver);
> -
> -        bindings::hrtimer_restart_HRTIMER_NORESTART
> +        T::run(receiver).into()
>      }
>  }
>=20
> --
> 2.47.0
>=20
>=20


