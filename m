Return-Path: <linux-kernel+bounces-525592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5134A3F1D0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC973BEC39
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5F7204C0F;
	Fri, 21 Feb 2025 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nwtsvjlw"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B80A20102C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740133183; cv=none; b=GmPczkwBd9PG14yWPqw2gHHKDOAxe3mRTj+8qFoLWO9neOR0jA6D8NtE5R5+5hLnrnv8EtDn2JbYZ9UJ5PXNlMUlQFPdJh/qROf3sj7uKIqXzTGn8GJIoaxBo0z0kqQlvopJlxNMNpZI2c3tA1Rcy8k6Y/4F9LV4FqW2rhnIAB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740133183; c=relaxed/simple;
	bh=g0Sk/QrxwpF69dyrv1JuM8BhT+7G1NCMXiAoHgNZkOY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4M6Gf2P1R9IsaTaLkyCn5R/Ii6SIHRL47zf8SDEmAivMNvSgqNfWfBk426bFSzv2f6H/9mZrSZd3N9DpgNojYaaGOcRuVsAaMLXSHjRbfrIl2qUvzKOH2hNICtzkbmTzWBbDdQ2M4oLUlJd4mzaXpULLEa7Pg4QZB8ANKOs46s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nwtsvjlw; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1740133178; x=1740392378;
	bh=O0Dk15RNp3yHIefmio/QAeO68s9O9AgRtxMCfnwCnso=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=nwtsvjlwq8p/oGmrvjl36/A0o7U4Up2P6R98vho/z1vOVod7I+fR9hgFPwxq91nVR
	 npfIB1n5mk/RlmSzG0P1c/H4Q0ka81F1erTfOIROovE0v1tZyk9nycRbmIhTL437q7
	 YZwV5ppbLflvmXP8FitRiZGqXAzsfc7QeKISAjtEKEEcEXr43kVxWe/g5divL15ENI
	 hV/J9eX8zLHY4vZmDmF1VQ6zbJPHFuTbXRzKBhiBacSMx5pJfTMMGrRVMcqidUqAmq
	 3ywsCxjwN2D7J07wivcg1KNnIEW9F2aFr/D6q4Ef5nCU5yyOTXuStd5i5CaRs6lt83
	 M++titB5Dvu9A==
Date: Fri, 21 Feb 2025 10:19:34 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, "Timothy G." <c6qchwbke@relay.firefox.com>
Subject: Re: [PATCH v8 12/14] rust: hrtimer: add `HrTimerMode`
Message-ID: <59728663-3baf-449a-b0af-931e9490db19@proton.me>
In-Reply-To: <87mseffyh7.fsf@kernel.org>
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org> <20250218-hrtimer-v3-v6-12-rc2-v8-12-48dedb015eb3@kernel.org> <ysjzL6zVfMAm7OLlJMCtBkEnfdFAS2VeO4PYUFzUxcRZvKNxuRlLWPA29gJQOWa8QaH-S5K1WElhtuwWMBF4EA==@protonmail.internalid> <a87ef54e-9a09-4cf6-bfe8-4bb98850cdda@proton.me> <87mseffyh7.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: fcfc052e860013fcab2644172ebcefdcb935d6d8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.02.25 10:17, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>=20
>> On 18.02.25 14:27, Andreas Hindborg wrote:
>>> +/// Operational mode of [`HrTimer`].
>>> +#[derive(Clone, Copy)]
>>> +pub enum HrTimerMode {
>>> +    /// Timer expires at the given expiration time.
>>> +    Absolute,
>>> +    /// Timer expires after the given expiration time interpreted as a=
 duration from now.
>>> +    Relative,
>>> +    /// Timer does not move between CPU cores.
>>> +    Pinned,
>>> +    /// Timer handler is executed in soft irq context.
>>> +    Soft,
>>> +    /// Timer handler is executed in hard irq context.
>>> +    Hard,
>>> +    /// Timer expires at the given expiration time.
>>> +    /// Timer does not move between CPU cores.
>>> +    AbsolutePinned,
>>> +    /// Timer expires after the given expiration time interpreted as a=
 duration from now.
>>> +    /// Timer does not move between CPU cores.
>>> +    RelativePinned,
>>> +    /// Timer expires at the given expiration time.
>>> +    /// Timer handler is executed in soft irq context.
>>> +    AbsoluteSoft,
>>> +    /// Timer expires after the given expiration time interpreted as a=
 duration from now.
>>> +    /// Timer handler is executed in soft irq context.
>>> +    RelativeSoft,
>>> +    /// Timer expires at the given expiration time.
>>> +    /// Timer does not move between CPU cores.
>>> +    /// Timer handler is executed in soft irq context.
>>> +    AbsolutePinnedSoft,
>>> +    /// Timer expires after the given expiration time interpreted as a=
 duration from now.
>>> +    /// Timer does not move between CPU cores.
>>> +    /// Timer handler is executed in soft irq context.
>>> +    RelativePinnedSoft,
>>> +    /// Timer expires at the given expiration time.
>>> +    /// Timer handler is executed in hard irq context.
>>> +    AbsoluteHard,
>>> +    /// Timer expires after the given expiration time interpreted as a=
 duration from now.
>>> +    /// Timer handler is executed in hard irq context.
>>> +    RelativeHard,
>>> +    /// Timer expires at the given expiration time.
>>> +    /// Timer does not move between CPU cores.
>>> +    /// Timer handler is executed in hard irq context.
>>> +    AbsolutePinnedHard,
>>> +    /// Timer expires after the given expiration time interpreted as a=
 duration from now.
>>> +    /// Timer does not move between CPU cores.
>>> +    /// Timer handler is executed in hard irq context.
>>> +    RelativePinnedHard,
>>> +}
>>
>> At some point we probably want to move this to bitfields, or do you
>> think it's better to keep it like this?
>=20
> Yes, eventually the would transition. The main difficulty is that not
> all flag combinations are legal, and the zero value is also a flag.
> There was some promising work being shared on Zulip for this [1], but I
> don't think it is completed yet. Added Timothy to CC.
>=20
> [1] https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/topi=
c/Best.20way.20to.20handle.20enum.2Fflags.20situation

Ah yeah I remember that. And also the complication about certain
combinations not being allowed.

>>> +
>>> +impl From<HrTimerMode> for bindings::hrtimer_mode {
>>> +    fn from(value: HrTimerMode) -> Self {
>>> +        use bindings::*;
>>> +        match value {
>>> +            HrTimerMode::Absolute =3D> hrtimer_mode_HRTIMER_MODE_ABS,
>>> +            HrTimerMode::Relative =3D> hrtimer_mode_HRTIMER_MODE_REL,
>>> +            HrTimerMode::Pinned =3D> hrtimer_mode_HRTIMER_MODE_PINNED,
>>> +            HrTimerMode::Soft =3D> hrtimer_mode_HRTIMER_MODE_SOFT,
>>> +            HrTimerMode::Hard =3D> hrtimer_mode_HRTIMER_MODE_HARD,
>>> +            HrTimerMode::AbsolutePinned =3D> hrtimer_mode_HRTIMER_MODE=
_ABS_PINNED,
>>> +            HrTimerMode::RelativePinned =3D> hrtimer_mode_HRTIMER_MODE=
_REL_PINNED,
>>> +            HrTimerMode::AbsoluteSoft =3D> hrtimer_mode_HRTIMER_MODE_A=
BS_SOFT,
>>> +            HrTimerMode::RelativeSoft =3D> hrtimer_mode_HRTIMER_MODE_R=
EL_SOFT,
>>> +            HrTimerMode::AbsolutePinnedSoft =3D> hrtimer_mode_HRTIMER_=
MODE_ABS_PINNED_SOFT,
>>> +            HrTimerMode::RelativePinnedSoft =3D> hrtimer_mode_HRTIMER_=
MODE_REL_PINNED_SOFT,
>>> +            HrTimerMode::AbsoluteHard =3D> hrtimer_mode_HRTIMER_MODE_A=
BS_HARD,
>>> +            HrTimerMode::RelativeHard =3D> hrtimer_mode_HRTIMER_MODE_R=
EL_HARD,
>>> +            HrTimerMode::AbsolutePinnedHard =3D> hrtimer_mode_HRTIMER_=
MODE_ABS_PINNED_HARD,
>>> +            HrTimerMode::RelativePinnedHard =3D> hrtimer_mode_HRTIMER_=
MODE_REL_PINNED_HARD,
>>> +        }
>>> +    }
>>> +}
>>> +
>>> +impl From<HrTimerMode> for u64 {
>>> +    fn from(value: HrTimerMode) -> Self {
>>> +        Into::<bindings::hrtimer_mode>::into(value) as u64
>>> +    }
>>> +}
>>
>> Hmm do drivers really need these impls? If not, then you could also just
>> have a private function that does the conversion and use it only in the
>> abstraction layer.
>=20
> Similar to the other impls you commented on, I can move them private. I
> would prefer using `From` rather than some other function.

What's the reason for you preferring `From`? I don't think it's
important to forbid access from the drivers, but if it's unnecessary,
why would we give them access in the first place?

---
Cheers,
Benno


