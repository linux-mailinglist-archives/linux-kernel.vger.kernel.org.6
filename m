Return-Path: <linux-kernel+bounces-551211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC34A56965
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F354A176C5B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1BF21B8F8;
	Fri,  7 Mar 2025 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bWKpYtaL"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ACC21ADC5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355470; cv=none; b=aWfVVOFDZ6zAbonLcgdpLo6WxlzINyTNTRS/5SkEbXb0RLEWZtP5yuFiga4iViebhkivct3n9mToKJDz58aXIzWziUC4hqG580kA35DsjxlPJXvqFuj/VFYP4fvG3UrwDkZEeiwn+h3YQTGC7VWL5ubNDZ3D+EZnl/VY7mt6aCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355470; c=relaxed/simple;
	bh=yvJGPy1VFx0K6jKPXutCOnVSEUIflxIglSHngdnZmic=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWK5zuzFTZ/3J21vtVqOsfZYVQQVJp1KdVuDuByJT7CcL3Uba9Kx4ajQdrJDS2wOpE3ccl0kKE6dT/Cf4Xnvg8OttaZMPXF5axeQ1yRuSICTUdz0yfBkUxjVdCPeyCGjt52gpJnjg5459gbMj9ytKw096ThoOEFfU5Uh2Sb++yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bWKpYtaL; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ng65oqhcvbczrlbale3hstnoua.protonmail; t=1741355466; x=1741614666;
	bh=tElGIhgf67HZvxIrD/1jG0VGn45wzGBOfP+OypacSoI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=bWKpYtaLOS0cuUusKzEF0DYrNOt3VY7fPZC96UtaMNUh6X/NjaTtCGum/W7TPV2CN
	 w1pO3DASrvTDy/7l8488XC4Wa8radCDXOB1cpV3TDSDiZH+HMUVF9SSQXSUsRRi62P
	 n1L9UHc/2tcW3d5cMJa/N/2orJNr1RsABZP1YBYxGu78UpEYdISS7aSMtCD58AMSSk
	 rSbrKd9Jltp/UYNO1znSoBlf8MrVwbC3syTjRhccw2hK7nx/wc4qWp4a9geWtvr15X
	 hJbEtvBNf887EEf4AtekdvTiTfwEkFZSIBQNuZ0jhkJHCUkpwBNldM0SuFIbvbwjae
	 QgmS4mRa7Ra5Q==
Date: Fri, 07 Mar 2025 13:51:01 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 07/13] rust: hrtimer: implement `UnsafeHrTimerPointer` for `Pin<&T>`
Message-ID: <D8A2ZPH3TSGK.IZ41SSRCL37@proton.me>
In-Reply-To: <87msdx3qsg.fsf@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org> <20250307-hrtimer-v3-v6-12-rc2-v10-7-0cf7e9491da4@kernel.org> <6-QyjoxR_6TYuJVEXwdFAZrhFz52ZDU_4-r64epTLFpOAMc3jM_REWS-v_7TzdcgYmq1j74UmTnhYW5HdT98bQ==@protonmail.internalid> <D8A25UNDIJHK.216EX6YG4EJ6E@proton.me> <87msdx3qsg.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 97d428098d5b074b9a1647e0d6fec250d09e913c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 2:37 PM CET, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>> On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
>>> +impl<'a, T> RawHrTimerCallback for Pin<&'a T>
>>> +where
>>> +    T: HasHrTimer<T>,
>>> +    T: HrTimerCallback<Pointer<'a> =3D Self>,
>>> +{
>>> +    type CallbackTarget<'b> =3D Self;
>>> +
>>> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings:=
:hrtimer_restart {
>>> +        // `HrTimer` is `repr(C)`
>>> +        let timer_ptr =3D ptr as *mut HrTimer<T>;
>>> +
>>> +        // SAFETY: By the safety requirement of this function, `timer_=
ptr`
>>> +        // points to a `HrTimer<T>` contained in an `T`.
>>> +        let receiver_ptr =3D unsafe { T::timer_container_of(timer_ptr)=
 };
>>> +
>>> +        // SAFETY: By the safety requirement of this function, `timer_=
ptr`
>>> +        // points to a `HrTimer<T>` contained in an `T`.
>>
>> This justification seems wrong it talks about `HrTimer<T>`, but here we
>> have a `*const T`... Also see [1] (I am mainly interested in your
>> justification for the lifetime).
>>
>> [1]: https://doc.rust-lang.org/std/ptr/index.html#pointer-to-reference-c=
onversion
>
> How is this:
>
>         // SAFETY:
>         //  - By the safety requirement of this function, `timer_ptr`
>         //    points to a `HrTimer<T>` contained in an `T`.
>         //  - The `PinHrTimerHandle` associated with this timer is guaran=
teed to
>         //    be alive until this method returns. As the handle borrows f=
rom
>         //    `T`, `T` is also guaranteed to be alive for the duration of=
 this
>         //    function.

Sounds good, if you can also explain (probably somewhere else, as every
`RawHrTimerCallback` implementer will rely on this) why the handle lives
for the duration of the callback.

---
Cheers,
Benno


