Return-Path: <linux-kernel+bounces-524869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E7AA3E839
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2EF8166444
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87238265CC7;
	Thu, 20 Feb 2025 23:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nDY90JqB"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151181E9B01
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093500; cv=none; b=B3MaNOsvYOqLmlCOvLMAIp7DpxCPTHAMxwiBBm8IO6nZ9O+wXRjgzW2PkW/0qGi0u8MTQHNV4CthM/dYfoex/i+bSfblPnXXMrwKnYmxLcXsnk2ApjfD04Ois0pPzLr7QxRkI+fn081JEc25+jC7gt7QseDtffLjhOAXkAU+Zfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093500; c=relaxed/simple;
	bh=ST5U7QVnOkl5OWzRD8d4A0n1T3JArlpyXLEdYbY75DE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yps31ERnbFEIzK9kUziP/jT5bWPV6dC44ZT6o9jwIOLJGawW814iyz20/ZQhiENe8wA3qxm077ah0k1EG6mtLa3mfUciMPfTX4yx1w2IqcVN6k9fAhsvtHzLJNHRizLoKAa7gnEwyJeEcqAxRJ+JCh0YeGHv7w/zDafNjXF2Aes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nDY90JqB; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=3ofknypmdref5pex6ox2hfphjy.protonmail; t=1740093493; x=1740352693;
	bh=bQv18O6BE32RRp46j1r2K56INFBlD0xqJNVS8ByKQ78=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=nDY90JqBTJAvNz+i/JIHbcmdg3S/mqGCHLiqcw1PSx3BokN2gQuAVEut0b6r6w1KJ
	 qRxBnGLowoEN+bsjwiDOTGSvcKpLthNUn+s4R7/NYO+nuWCA/AzRLoraCagBw50ZxI
	 WWaN2hf70JdB5ycDpNEHeMWD3jggZRkwbuu996KRWHPr1vpG56P8kJSHfnGHfU9vel
	 NX8H0OOqW5XBKAOnAJn35gG2+6TSe5+4crQ7+lqSOY5R6+0prEctj4sXQ2/ujhKunB
	 Rs1cH1yDwcd9QV3FWTOlSL2jTP5VOGthCk98cYwbBOpyqj1WzlK+2Lsci0ewYgBcZq
	 LeMeXNjM3ILgg==
Date: Thu, 20 Feb 2025 23:18:07 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 06/14] rust: hrtimer: add `UnsafeHrTimerPointer`
Message-ID: <7c3c758d-658c-4cea-9533-9bbe7b3e285d@proton.me>
In-Reply-To: <20250218-hrtimer-v3-v6-12-rc2-v8-6-48dedb015eb3@kernel.org>
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org> <20250218-hrtimer-v3-v6-12-rc2-v8-6-48dedb015eb3@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: b48ae727e84febc5af3498e06639422415bbf860
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.02.25 14:27, Andreas Hindborg wrote:
> Add a trait to allow unsafely queuing stack allocated timers.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>  rust/kernel/time/hrtimer.rs | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>=20
> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> index e342193f985eb..196794089f033 100644
> --- a/rust/kernel/time/hrtimer.rs
> +++ b/rust/kernel/time/hrtimer.rs
> @@ -157,6 +157,37 @@ pub trait HrTimerPointer: Sync + Sized {
>      fn start(self, expires: Ktime) -> Self::TimerHandle;
>  }
>=20
> +/// Unsafe version of [`HrTimerPointer`] for situations where leaking th=
e
> +/// [`HrTimerHandle`] returned by `start` would be unsound. This is the =
case for
> +/// stack allocated timers.
> +///
> +/// Typical implementers are pinned references such as [`Pin<&T>`].
> +///
> +/// # Safety
> +///
> +/// Implementers of this trait must ensure that instances of types imple=
menting
> +/// [`UnsafeHrTimerPointer`] outlives any associated [`HrTimerPointer::T=
imerHandle`]
> +/// instances.
> +pub unsafe trait UnsafeHrTimerPointer: Sync + Sized {
> +    /// A handle representing a running timer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// If the timer is running, or if the timer callback is executing w=
hen the
> +    /// handle is dropped, the drop method of [`Self::TimerHandle`] must=
 not return
> +    /// until the timer is stopped and the callback has completed.
> +    type TimerHandle: HrTimerHandle;
> +
> +    /// Start the timer after `expires` time units. If the timer was alr=
eady
> +    /// running, it is restarted at the new expiry time.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Caller promises keep the timer structure alive until the timer i=
s dead.
> +    /// Caller can ensure this by not leaking the returned [`Self::Timer=
Handle`].
> +    unsafe fn start(self, expires: Ktime) -> Self::TimerHandle;

I have an interesting idea to make this function safe, but I don't want
to block this series.

How about we have the following signature:

    fn start(self, expires: Ktime) -> impl PinInit<Self::TimerHandle>;

And in the safety requirements of the trait we ask that `TimerHandle` be
`!Unpin`. Then the TimerHandle cannot be forgotten because it is pinned
and pinned values have the drop guarantee [1].

You can then use `stack_pin_init!` to pin the value directly on the
stack (dropping it by leaving its scope will then cancel the timer &
possibly wait for the timer callback to finish running).

[1]: https://doc.rust-lang.org/std/pin/index.html#drop-guarantee

---
Cheers,
Benno

> +}
> +
>  /// Implemented by [`HrTimerPointer`] implementers to give the C timer c=
allback a
>  /// function to call.
>  // This is split from `HrTimerPointer` to make it easier to specify trai=
t bounds.
>=20
> --
> 2.47.0
>=20
>=20


