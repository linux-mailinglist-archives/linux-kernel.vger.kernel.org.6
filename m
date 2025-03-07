Return-Path: <linux-kernel+bounces-551264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2156A56A39
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A58218936B6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4666B21B9CE;
	Fri,  7 Mar 2025 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjKCq9u8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E08921B8F5;
	Fri,  7 Mar 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357299; cv=none; b=qRhS3cOsN+qrkxQ7uNRnPe6wx4Dy5uZDuBiuDfPqvBbxG8dzDb8uhLDbomTNiQtWbL6BeOOrNNTeim9tDv7xr/MvPabfYHGxIHoUTHygPve89Xr2eYQ1ieoN+8qHtKeHXVquVR4X1Jzr562u+lbPTeR7hIqL/wFRPJuF93297bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357299; c=relaxed/simple;
	bh=ZOH/UQqsCWGldN/FcM22hIc5UpsP7++UJ+LlHVDdh84=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rGBVOg/uFMjJaG9dY6OzUg1Hp/qxDybgyVAVf8jPZsV3AjYyeOXdSTafHuSyAT4QpWuIF3bA1M7dg+aACLz+Ax1vZB/Mbi/iAy/lZL4x0wPc8JR7OF5XDsbLACcs+reiisL7nTW9ZLnDhUm+cvh4BE+I9NE+6Yy7iaqs6sranKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjKCq9u8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D63C4CED1;
	Fri,  7 Mar 2025 14:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741357299;
	bh=ZOH/UQqsCWGldN/FcM22hIc5UpsP7++UJ+LlHVDdh84=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TjKCq9u8CpdnMTR84V2WKhTuTKhwoERz/DSmHx9cZfEDJTzR+5GJQflc9HELadOuf
	 63WZOgavwoD0V6xWAbGKogb4/3BOetshMpPHZGuNyiyIVXMEL4keD13qYyWaKhZs1N
	 /tX6g4Qa+gn9L7aPHdtdZXHH6+295BjS8vFlzCEiSH5RGMIVcC4ZyHtpzKCaUELaPK
	 lSe8hFN+m3zyviGmVccDrDmIXirhgGbgPvRCL2Uh0+jFljuz80SsYSD3d/K+6iigHn
	 uQKikPDAZcXtpCqVgabnRx60rKdAbn5rXsL3uy09Zt28D10Hc7cTPyNnhckVcyF6bN
	 IqAamvcf+50ew==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Lyude Paul" <lyude@redhat.com>,  "Guangbo
 Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,  "Daniel
 Almeida" <daniel.almeida@collabora.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  "Markus Elfring" <Markus.Elfring@web.de>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 07/13] rust: hrtimer: implement
 `UnsafeHrTimerPointer` for `Pin<&T>`
In-Reply-To: <D8A2ZPH3TSGK.IZ41SSRCL37@proton.me> (Benno Lossin's message of
	"Fri, 07 Mar 2025 13:51:01 +0000")
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org>
	<20250307-hrtimer-v3-v6-12-rc2-v10-7-0cf7e9491da4@kernel.org>
	<6-QyjoxR_6TYuJVEXwdFAZrhFz52ZDU_4-r64epTLFpOAMc3jM_REWS-v_7TzdcgYmq1j74UmTnhYW5HdT98bQ==@protonmail.internalid>
	<D8A25UNDIJHK.216EX6YG4EJ6E@proton.me> <87msdx3qsg.fsf@kernel.org>
	<MAOSH8H2lF5xrSfp-bnsmnF6Cw0BeJaotLwkrEDKvOki2VxkUP4yazYV7vRrxa1DZhg2g_Enxlkb9lF_mC2TiQ==@protonmail.internalid>
	<D8A2ZPH3TSGK.IZ41SSRCL37@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 07 Mar 2025 15:21:31 +0100
Message-ID: <87ikok3or8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On Fri Mar 7, 2025 at 2:37 PM CET, Andreas Hindborg wrote:
>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>> On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
>>>> +impl<'a, T> RawHrTimerCallback for Pin<&'a T>
>>>> +where
>>>> +    T: HasHrTimer<T>,
>>>> +    T: HrTimerCallback<Pointer<'a> = Self>,
>>>> +{
>>>> +    type CallbackTarget<'b> = Self;
>>>> +
>>>> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
>>>> +        // `HrTimer` is `repr(C)`
>>>> +        let timer_ptr = ptr as *mut HrTimer<T>;
>>>> +
>>>> +        // SAFETY: By the safety requirement of this function, `timer_ptr`
>>>> +        // points to a `HrTimer<T>` contained in an `T`.
>>>> +        let receiver_ptr = unsafe { T::timer_container_of(timer_ptr) };
>>>> +
>>>> +        // SAFETY: By the safety requirement of this function, `timer_ptr`
>>>> +        // points to a `HrTimer<T>` contained in an `T`.
>>>
>>> This justification seems wrong it talks about `HrTimer<T>`, but here we
>>> have a `*const T`... Also see [1] (I am mainly interested in your
>>> justification for the lifetime).
>>>
>>> [1]: https://doc.rust-lang.org/std/ptr/index.html#pointer-to-reference-conversion
>>
>> How is this:
>>
>>         // SAFETY:
>>         //  - By the safety requirement of this function, `timer_ptr`
>>         //    points to a `HrTimer<T>` contained in an `T`.
>>         //  - The `PinHrTimerHandle` associated with this timer is guaranteed to
>>         //    be alive until this method returns. As the handle borrows from
>>         //    `T`, `T` is also guaranteed to be alive for the duration of this
>>         //    function.
>
> Sounds good, if you can also explain (probably somewhere else, as every
> `RawHrTimerCallback` implementer will rely on this) why the handle lives
> for the duration of the callback.

It is in the safety requirement for the `HrTimerHandle` trait already.
Should I reference it here?


Best regards,
Andreas Hindborg




