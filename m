Return-Path: <linux-kernel+bounces-524882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D81A9A3E857
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC6A19C340D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902542676C9;
	Thu, 20 Feb 2025 23:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="LWF3CWre"
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32999266F12
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740093843; cv=none; b=YngkqBWkgsF3ZQsMGAU+qFrphogey5uMwodfmpGmLDCbWfrVwoDSUjgRBfwuyzno93lT+GQH0nubaRrb9UEU4aYqPNGJtpEsCGu+bH26/ER6RyeG9j2x3pGWUHLfdgaTeMS+tSLpClsW3NLf7IO5ZIqjXTYjxtS75CsM3veQuj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740093843; c=relaxed/simple;
	bh=9r+GJSoEWo1NygtNH5sWVD+8rSaSXrR4wvY6HM2CdWM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AiMdeI4ijsFs5dLAo55kdIwAB9/7hRElaVILnu0fAp/RWric1WdcsNURAFa+PtL99mhSF0zqHDEUXFkHfsBezwuoCfnIDG50/RsQhf2d1HAQsYlkNTuI9/3aZC5yAOkEjpwKSrziaqyo8kZEKZM6CeCtpIufml8qU0IXj2TWdpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=LWF3CWre; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1740093839; x=1740353039;
	bh=k/x6d3aG4wvMP5h3x1mb4eQTp8161mwc0KD7+Kg8E3U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=LWF3CWreCURvDXkxqR8BolJG8OHmVNM/NwiQaCUy/UZ1ZC4Izb9Ixw+27oOzGK0dd
	 62G3mkmZTzOqIvH2M64ys6RakNgSmK7zNk7D+kODcZvt49ybLuwc18TV2Vy0xOEhFO
	 8fGQX6fSxwC/93zJyFGamsEDpMRPOHFohrhnfWL2PnR9JL63fEx9wUEXT6PNm0rO2l
	 niodYglIek9mdaf4Y21BcQGtbubHRddbgdwfCoqbv8PnoLCkHrMDfLdpo62kzx/WC2
	 CikMVn02P1S43d2HqPZuREZSvk5AXgam+fcWSI9yoZHZFzqM8ZILSPZt3BR7RxMEVB
	 Im9FAew4pFr3A==
Date: Thu, 20 Feb 2025 23:23:55 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 12/14] rust: hrtimer: add `HrTimerMode`
Message-ID: <a87ef54e-9a09-4cf6-bfe8-4bb98850cdda@proton.me>
In-Reply-To: <20250218-hrtimer-v3-v6-12-rc2-v8-12-48dedb015eb3@kernel.org>
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org> <20250218-hrtimer-v3-v6-12-rc2-v8-12-48dedb015eb3@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 76d0decffa575b48e0c67a84ddebfec468ef9669
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.02.25 14:27, Andreas Hindborg wrote:
> +/// Operational mode of [`HrTimer`].
> +#[derive(Clone, Copy)]
> +pub enum HrTimerMode {
> +    /// Timer expires at the given expiration time.
> +    Absolute,
> +    /// Timer expires after the given expiration time interpreted as a d=
uration from now.
> +    Relative,
> +    /// Timer does not move between CPU cores.
> +    Pinned,
> +    /// Timer handler is executed in soft irq context.
> +    Soft,
> +    /// Timer handler is executed in hard irq context.
> +    Hard,
> +    /// Timer expires at the given expiration time.
> +    /// Timer does not move between CPU cores.
> +    AbsolutePinned,
> +    /// Timer expires after the given expiration time interpreted as a d=
uration from now.
> +    /// Timer does not move between CPU cores.
> +    RelativePinned,
> +    /// Timer expires at the given expiration time.
> +    /// Timer handler is executed in soft irq context.
> +    AbsoluteSoft,
> +    /// Timer expires after the given expiration time interpreted as a d=
uration from now.
> +    /// Timer handler is executed in soft irq context.
> +    RelativeSoft,
> +    /// Timer expires at the given expiration time.
> +    /// Timer does not move between CPU cores.
> +    /// Timer handler is executed in soft irq context.
> +    AbsolutePinnedSoft,
> +    /// Timer expires after the given expiration time interpreted as a d=
uration from now.
> +    /// Timer does not move between CPU cores.
> +    /// Timer handler is executed in soft irq context.
> +    RelativePinnedSoft,
> +    /// Timer expires at the given expiration time.
> +    /// Timer handler is executed in hard irq context.
> +    AbsoluteHard,
> +    /// Timer expires after the given expiration time interpreted as a d=
uration from now.
> +    /// Timer handler is executed in hard irq context.
> +    RelativeHard,
> +    /// Timer expires at the given expiration time.
> +    /// Timer does not move between CPU cores.
> +    /// Timer handler is executed in hard irq context.
> +    AbsolutePinnedHard,
> +    /// Timer expires after the given expiration time interpreted as a d=
uration from now.
> +    /// Timer does not move between CPU cores.
> +    /// Timer handler is executed in hard irq context.
> +    RelativePinnedHard,
> +}

At some point we probably want to move this to bitfields, or do you
think it's better to keep it like this?

> +
> +impl From<HrTimerMode> for bindings::hrtimer_mode {
> +    fn from(value: HrTimerMode) -> Self {
> +        use bindings::*;
> +        match value {
> +            HrTimerMode::Absolute =3D> hrtimer_mode_HRTIMER_MODE_ABS,
> +            HrTimerMode::Relative =3D> hrtimer_mode_HRTIMER_MODE_REL,
> +            HrTimerMode::Pinned =3D> hrtimer_mode_HRTIMER_MODE_PINNED,
> +            HrTimerMode::Soft =3D> hrtimer_mode_HRTIMER_MODE_SOFT,
> +            HrTimerMode::Hard =3D> hrtimer_mode_HRTIMER_MODE_HARD,
> +            HrTimerMode::AbsolutePinned =3D> hrtimer_mode_HRTIMER_MODE_A=
BS_PINNED,
> +            HrTimerMode::RelativePinned =3D> hrtimer_mode_HRTIMER_MODE_R=
EL_PINNED,
> +            HrTimerMode::AbsoluteSoft =3D> hrtimer_mode_HRTIMER_MODE_ABS=
_SOFT,
> +            HrTimerMode::RelativeSoft =3D> hrtimer_mode_HRTIMER_MODE_REL=
_SOFT,
> +            HrTimerMode::AbsolutePinnedSoft =3D> hrtimer_mode_HRTIMER_MO=
DE_ABS_PINNED_SOFT,
> +            HrTimerMode::RelativePinnedSoft =3D> hrtimer_mode_HRTIMER_MO=
DE_REL_PINNED_SOFT,
> +            HrTimerMode::AbsoluteHard =3D> hrtimer_mode_HRTIMER_MODE_ABS=
_HARD,
> +            HrTimerMode::RelativeHard =3D> hrtimer_mode_HRTIMER_MODE_REL=
_HARD,
> +            HrTimerMode::AbsolutePinnedHard =3D> hrtimer_mode_HRTIMER_MO=
DE_ABS_PINNED_HARD,
> +            HrTimerMode::RelativePinnedHard =3D> hrtimer_mode_HRTIMER_MO=
DE_REL_PINNED_HARD,
> +        }
> +    }
> +}
> +
> +impl From<HrTimerMode> for u64 {
> +    fn from(value: HrTimerMode) -> Self {
> +        Into::<bindings::hrtimer_mode>::into(value) as u64
> +    }
> +}

Hmm do drivers really need these impls? If not, then you could also just
have a private function that does the conversion and use it only in the
abstraction layer.

---
Cheers,
Benno

> +
>  /// Use to implement the [`HasHrTimer<T>`] trait.
>  ///
>  /// See [`module`] documentation for an example.
>=20
> --
> 2.47.0
>=20
>=20


