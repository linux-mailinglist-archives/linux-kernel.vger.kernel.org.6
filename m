Return-Path: <linux-kernel+bounces-527068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25B2A406FA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 10:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512BA425C84
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69992066C6;
	Sat, 22 Feb 2025 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FTgUbEL2"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F177420766A
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740216877; cv=none; b=do7ok+6Ke1nTO+Px+aamnqx+2SDHyfgNLeUQ/r0LuuP6wCtWea010JCib1NL7Dotz0Ue5tqZIrcVhHKegTb97+l4gjQzBRZLOEuZRk97rJwndU/2FrUHczT2pgRLoUMZck9172jqGJn3xNIIfqBXDxvijR0aZrneXyT2NUA8RTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740216877; c=relaxed/simple;
	bh=CwANs9YY78ymGn+sKefGYOoQ37cQb0yCalp/EVd8Jwg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOUc/J+4cn44QPn8crIv1Ck4syyUddp23Bp4yqu+D02xkY13LKskW1HBUtuCLRnT2s7l776bsYJ2jhejHWMbeQcfrIOct6r+mTgkZjLEmwiLynK6gROCP+wsng/9+GxkkmGkaW7uZjliqebn6BTnxackbmvWwgl2TsqCaYoqUiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=FTgUbEL2; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1740216872; x=1740476072;
	bh=81wCAGdGDWABM9NB8Pe5SGShGnERYX8IHDQ9bHUHuqw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=FTgUbEL2etV5pq0ZSQvfUW4bRqYez1ee0PpNGKElj/hjz671XK6VsZb+CO3Jbg5lm
	 1fH4McklYlzSDDMVONqTUxfYec3sY8aR33SPefSTHo9ArJJ2tT94EeQLCf0EBNC4d1
	 WrmppAardBmrgOIvAKwL35WwvqFjY+LXjEuqsRBY/C3KTYsbKg07Pip0WeQo9bBAqT
	 rka2ImHcLYz94wsz7wrz8b7gsKq9iIjwbU1d2YYBfDGCcovzFeSsnQ3OYY/329yCXy
	 SMMJgYrXT7DRrlAXCI87rLWAEcDdGe0QVP27rWtwLr3Ge+tRcPXuK7wtKK9nmhrjz3
	 Lve12i9DqQXhw==
Date: Sat, 22 Feb 2025 09:34:25 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, "Timothy G." <c6qchwbke@relay.firefox.com>
Subject: Re: [PATCH v8 12/14] rust: hrtimer: add `HrTimerMode`
Message-ID: <c750f04e-1b0b-4818-8554-c30fc535d07d@proton.me>
In-Reply-To: <87zfifedc4.fsf@kernel.org>
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org> <20250218-hrtimer-v3-v6-12-rc2-v8-12-48dedb015eb3@kernel.org> <ysjzL6zVfMAm7OLlJMCtBkEnfdFAS2VeO4PYUFzUxcRZvKNxuRlLWPA29gJQOWa8QaH-S5K1WElhtuwWMBF4EA==@protonmail.internalid> <a87ef54e-9a09-4cf6-bfe8-4bb98850cdda@proton.me> <87mseffyh7.fsf@kernel.org> <Qc288_gOFSgerx6GNw2kPqnwcTqQzGUTOlONfJMr2mOAsOQ7j5V5zr_lT2v5GLGN7s7HFl0_WkJD3VRgwJBNOg==@protonmail.internalid> <59728663-3baf-449a-b0af-931e9490db19@proton.me> <87zfifedc4.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a44164e348d626570252e11a161392298cab2ca3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.02.25 12:39, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>=20
>> On 21.02.25 10:17, Andreas Hindborg wrote:
>>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>>
>>>> On 18.02.25 14:27, Andreas Hindborg wrote:
>>>>> +/// Operational mode of [`HrTimer`].
>>>>> +#[derive(Clone, Copy)]
>>>>> +pub enum HrTimerMode {
>>>>> +    /// Timer expires at the given expiration time.
>>>>> +    Absolute,
>>>>> +    /// Timer expires after the given expiration time interpreted as=
 a duration from now.
>>>>> +    Relative,
>>>>> +    /// Timer does not move between CPU cores.
>>>>> +    Pinned,
>>>>> +    /// Timer handler is executed in soft irq context.
>>>>> +    Soft,
>>>>> +    /// Timer handler is executed in hard irq context.
>>>>> +    Hard,
>>>>> +    /// Timer expires at the given expiration time.
>>>>> +    /// Timer does not move between CPU cores.
>>>>> +    AbsolutePinned,
>>>>> +    /// Timer expires after the given expiration time interpreted as=
 a duration from now.
>>>>> +    /// Timer does not move between CPU cores.
>>>>> +    RelativePinned,
>>>>> +    /// Timer expires at the given expiration time.
>>>>> +    /// Timer handler is executed in soft irq context.
>>>>> +    AbsoluteSoft,
>>>>> +    /// Timer expires after the given expiration time interpreted as=
 a duration from now.
>>>>> +    /// Timer handler is executed in soft irq context.
>>>>> +    RelativeSoft,
>>>>> +    /// Timer expires at the given expiration time.
>>>>> +    /// Timer does not move between CPU cores.
>>>>> +    /// Timer handler is executed in soft irq context.
>>>>> +    AbsolutePinnedSoft,
>>>>> +    /// Timer expires after the given expiration time interpreted as=
 a duration from now.
>>>>> +    /// Timer does not move between CPU cores.
>>>>> +    /// Timer handler is executed in soft irq context.
>>>>> +    RelativePinnedSoft,
>>>>> +    /// Timer expires at the given expiration time.
>>>>> +    /// Timer handler is executed in hard irq context.
>>>>> +    AbsoluteHard,
>>>>> +    /// Timer expires after the given expiration time interpreted as=
 a duration from now.
>>>>> +    /// Timer handler is executed in hard irq context.
>>>>> +    RelativeHard,
>>>>> +    /// Timer expires at the given expiration time.
>>>>> +    /// Timer does not move between CPU cores.
>>>>> +    /// Timer handler is executed in hard irq context.
>>>>> +    AbsolutePinnedHard,
>>>>> +    /// Timer expires after the given expiration time interpreted as=
 a duration from now.
>>>>> +    /// Timer does not move between CPU cores.
>>>>> +    /// Timer handler is executed in hard irq context.
>>>>> +    RelativePinnedHard,
>>>>> +}
>>>>
>>>> At some point we probably want to move this to bitfields, or do you
>>>> think it's better to keep it like this?
>>>
>>> Yes, eventually the would transition. The main difficulty is that not
>>> all flag combinations are legal, and the zero value is also a flag.
>>> There was some promising work being shared on Zulip for this [1], but I
>>> don't think it is completed yet. Added Timothy to CC.
>>>
>>> [1] https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/to=
pic/Best.20way.20to.20handle.20enum.2Fflags.20situation
>>
>> Ah yeah I remember that. And also the complication about certain
>> combinations not being allowed.
>>
>>>>> +
>>>>> +impl From<HrTimerMode> for bindings::hrtimer_mode {
>>>>> +    fn from(value: HrTimerMode) -> Self {
>>>>> +        use bindings::*;
>>>>> +        match value {
>>>>> +            HrTimerMode::Absolute =3D> hrtimer_mode_HRTIMER_MODE_ABS=
,
>>>>> +            HrTimerMode::Relative =3D> hrtimer_mode_HRTIMER_MODE_REL=
,
>>>>> +            HrTimerMode::Pinned =3D> hrtimer_mode_HRTIMER_MODE_PINNE=
D,
>>>>> +            HrTimerMode::Soft =3D> hrtimer_mode_HRTIMER_MODE_SOFT,
>>>>> +            HrTimerMode::Hard =3D> hrtimer_mode_HRTIMER_MODE_HARD,
>>>>> +            HrTimerMode::AbsolutePinned =3D> hrtimer_mode_HRTIMER_MO=
DE_ABS_PINNED,
>>>>> +            HrTimerMode::RelativePinned =3D> hrtimer_mode_HRTIMER_MO=
DE_REL_PINNED,
>>>>> +            HrTimerMode::AbsoluteSoft =3D> hrtimer_mode_HRTIMER_MODE=
_ABS_SOFT,
>>>>> +            HrTimerMode::RelativeSoft =3D> hrtimer_mode_HRTIMER_MODE=
_REL_SOFT,
>>>>> +            HrTimerMode::AbsolutePinnedSoft =3D> hrtimer_mode_HRTIME=
R_MODE_ABS_PINNED_SOFT,
>>>>> +            HrTimerMode::RelativePinnedSoft =3D> hrtimer_mode_HRTIME=
R_MODE_REL_PINNED_SOFT,
>>>>> +            HrTimerMode::AbsoluteHard =3D> hrtimer_mode_HRTIMER_MODE=
_ABS_HARD,
>>>>> +            HrTimerMode::RelativeHard =3D> hrtimer_mode_HRTIMER_MODE=
_REL_HARD,
>>>>> +            HrTimerMode::AbsolutePinnedHard =3D> hrtimer_mode_HRTIME=
R_MODE_ABS_PINNED_HARD,
>>>>> +            HrTimerMode::RelativePinnedHard =3D> hrtimer_mode_HRTIME=
R_MODE_REL_PINNED_HARD,
>>>>> +        }
>>>>> +    }
>>>>> +}
>>>>> +
>>>>> +impl From<HrTimerMode> for u64 {
>>>>> +    fn from(value: HrTimerMode) -> Self {
>>>>> +        Into::<bindings::hrtimer_mode>::into(value) as u64
>>>>> +    }
>>>>> +}
>>>>
>>>> Hmm do drivers really need these impls? If not, then you could also ju=
st
>>>> have a private function that does the conversion and use it only in th=
e
>>>> abstraction layer.
>>>
>>> Similar to the other impls you commented on, I can move them private. I
>>> would prefer using `From` rather than some other function.
>>
>> What's the reason for you preferring `From`? I don't think it's
>> important to forbid access from the drivers, but if it's unnecessary,
>> why would we give them access in the first place?
>=20
> TIL trait implementations cannot be hidden.

Yeah trait impls are always public.

> I like `From` because every single rust developer seeing a `From`
> implementation will immediately know what it does. It is more
> idiomatic in that way than having another conversion function. I think
> using existing traits with well defined semantics is preferable to a
> local function.

Well yes, but that only holds if other people need to use it.

> But since driver implementer do not need it, I'm undecided. If you want
> them converted to a private function I can do that, for all the ones you
> called out. But I am also OK with keeping as is. You decide.

I think it's better to keep these enums somewhat opaque.

---
Cheers,
Benno


