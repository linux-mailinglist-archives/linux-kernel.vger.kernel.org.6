Return-Path: <linux-kernel+bounces-551166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CAAA568E7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1111895621
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B42219EA5;
	Fri,  7 Mar 2025 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guCNpJzf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9792022EE5;
	Fri,  7 Mar 2025 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354057; cv=none; b=QOQg8WoR13KznI6XROFVMrklU5EWJ2dOZ7muF1wFof5l4E94Q3vbQ4yEGtSlM1XD/twgbKtEVsNA2AyRuu3CcacrWrI9nCuowV9eNBgWQZWVYqPUYQzOm5DmbN0v0xAP7Pv90qgn/TM3ptG3ZAgg9N4aFDf5ldGzInIHDVf4d+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354057; c=relaxed/simple;
	bh=+1BxnVPnlbnWFOP/941TLdbyOO8GpUZPJukzn1Ej/VE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sNlmMLjPkF7T9WvDAlCSIwiHc8Jp7jrfZhB3KRRCb7eCs73eugGERaCaIY1cINADTxslYs0BqCbSXMsDbV/4fBbeAIN3bliJAybsl2AgkY9EyNc/syfEefWsHy8OiVtgWHbYeG5Uworb/cR5a/wV2bjhVJdeK8qBsAzu6ZedkqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guCNpJzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B792CC4CED1;
	Fri,  7 Mar 2025 13:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741354057;
	bh=+1BxnVPnlbnWFOP/941TLdbyOO8GpUZPJukzn1Ej/VE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=guCNpJzfg3ekr8SJ9IRY8SoonhzlS6nHWYm278SjVHI51tLfCrFUXaNYMYnX79jbf
	 uzG6vDkvKKilibUoGHGDRV/q2XCpg27O5QAjwAy6dHR/4EF2QWaMOpKa3C0Jn77c9H
	 k5qv8JfwgX+7xFAeeAkSz266ROI1HdmckM392j4bZRF46smEwGreMpI2QeMdp0lh+m
	 d92q8VErSQUhJYXk104FeRLhAcv/qclUuelYdK6TbUdaCRBgMWzWdViAFLGQXvNIpS
	 LuW7BpjbGfOHDStUlGxkaPMVTE20NEF3Wjqhyh/3lcuEgFo2zLN5LEZTCI9PKEIIKB
	 3JRvJ0OkdITGg==
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
Subject: Re: [PATCH v10 03/13] rust: hrtimer: implement `HrTimerPointer` for
 `Arc`
In-Reply-To: <D8A1Z043VPGR.2OBGSBH1ALUL6@proton.me> (Benno Lossin's message of
	"Fri, 07 Mar 2025 13:03:06 +0000")
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org>
	<20250307-hrtimer-v3-v6-12-rc2-v10-3-0cf7e9491da4@kernel.org>
	<b-T-Yv_oexMXaKG9kNNfbYz-Qaw1XhJw-VHerSPFp_sIMoztNyAj94_rH-uNYeG-Hc5WANUivDJW9WLmfZZHwA==@protonmail.internalid>
	<D8A1Z043VPGR.2OBGSBH1ALUL6@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 07 Mar 2025 14:27:28 +0100
Message-ID: <87senp3r9b.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
>> +impl<T> HrTimerPointer for Arc<T>
>> +where
>> +    T: 'static,
>> +    T: Send + Sync,
>> +    T: HasHrTimer<T>,
>> +    T: for<'a> HrTimerCallback<Pointer<'a> = Self>,
>> +    Arc<T>: for<'a> RawHrTimerCallback<CallbackTarget<'a> = ArcBorrow<'a, T>>,
>
> I don't understand why you need this bound here.

This impl is applicable only when `Arc<T> has an implementation of
`RawTimerCallback` where CallbackTarget<'a> = ArcBorrow<'a, T>. I don't
want the impl to be available if that is not the case.

It's just an additional check.

>
>> +{
>> +    type TimerHandle = ArcHrTimerHandle<T>;
>> +
>> +    fn start(self, expires: Ktime) -> ArcHrTimerHandle<T> {
>> +        // SAFETY:
>> +        //  - We keep `self` alive by wrapping it in a handle below.
>> +        //  - Since we generate the pointer passed to `start` from a valid
>> +        //    reference, it is a valid pointer.
>> +        unsafe { T::start(Arc::as_ptr(&self), expires) };
>> +        ArcHrTimerHandle { inner: self }
>> +    }
>> +}
>> +
>> +impl<T> RawHrTimerCallback for Arc<T>
>> +where
>> +    T: 'static,
>> +    T: HasHrTimer<T>,
>> +    T: for<'a> HrTimerCallback<Pointer<'a> = Self>,
>> +{
>> +    type CallbackTarget<'a> = ArcBorrow<'a, T>;
>> +
>> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
>> +        // `HrTimer` is `repr(C)`
>> +        let timer_ptr = ptr.cast::<super::HrTimer<T>>();
>> +
>> +        // SAFETY: By C API contract `ptr` is the pointer we passed when
>> +        // queuing the timer, so it is a `HrTimer<T>` embedded in a `T`.
>> +        let data_ptr = unsafe { T::timer_container_of(timer_ptr) };
>> +
>> +        // SAFETY: `data_ptr` points to the `T` that was used to queue the
>> +        // timer. This `T` is contained in an `Arc`.
>
> You're not justifying all safety requirements of `ArcBorrow::from_raw`.

How is this:

        // SAFETY:
        //  - `data_ptr` is derived form the pointer to the `T` that was used to
        //    queue the timer.
        //  - The `ArcTimerHandle` associated with this timer is guaranteed to
        //    be alive for the duration of the lifetime of `receiver`, so the
        //    refcount of the underlying `Arc` is guaranteed to be nonzero for
        //    the duration.
        //  - We own one refcount in the `ArcTimerHandle` associted with this
        //    timer, so it is not possible to get a `UniqueArc` to this
        //    allocation from other `Arc` clones.


Best regards,
Andreas Hindborg



