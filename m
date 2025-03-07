Return-Path: <linux-kernel+bounces-551256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 536CEA56A24
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F8B3B5257
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA8E21B909;
	Fri,  7 Mar 2025 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuyNw9Az"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC3320764E;
	Fri,  7 Mar 2025 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356987; cv=none; b=NC6Nh0Qv1TV3iQo+UhRMSbPxiCWsIroIND35TeKjld59WEmo6qCOpAGC5KZZjaEq7D5fl5/NVhopta19+UJnwiZP1VEvQWb2oEYGYHPIqKgOj7IkGxdmOaT+QTEO2W8Aa3JS7vikcqo97zAgv96kRnrL/XynfPCGY3A4kkkyF+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356987; c=relaxed/simple;
	bh=9nPYAopKUDopExhS9FexREvh1Zfilf564Y8JKtrhzVk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XhCss+Qc/gCRJKOfdBRj2Dh6jHJJKKXgi/s9Z6+xSitOYQ2Wux/wtTXmow33uDJzJbsrNjcT5DhlmXDUinO8v6iJdC4HBqY/qdyI2lhN9HsaruRJEwovu5MI04tHOR5iFTMWw5+TbzL9b43ET/UMXbuL2YAzyw2bk8RCJs+YTk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuyNw9Az; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33F4C4CED1;
	Fri,  7 Mar 2025 14:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741356987;
	bh=9nPYAopKUDopExhS9FexREvh1Zfilf564Y8JKtrhzVk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XuyNw9AzfsHk7mcWis/HZ/USWfLUAsByjkW6/vdkoH9Rj5rUDSFTnJXxwvcFxtdwK
	 s7lP5BRophmZTNMky2TyqhnT6zdPv2bLd0I7JCq3txvgEG4Av9T66Fy9mom1Gf0taB
	 S1FXz4d9+gnb06X4JUSQ/63+wExusNQf7Rx5Z8RhU7eJ72vpwB7anOgxZX4aF6xatf
	 ffZbxiaIYiK/amFoolb1VSwp9sGTKgAoWyg4KgwIjPI7y28suZSFkDOkzbEg1Rm9pH
	 5ZtRpYRdCxLQGyCjO3FtN+yqmo8mncOoKgFJxyjhuRnJwehhJr1WW5wCCx4ZcnxmUA
	 UWpBFjLV5GqFg==
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
In-Reply-To: <D8A2O5QBXCRI.18W3W0EDI3UXZ@proton.me> (Benno Lossin's message of
	"Fri, 07 Mar 2025 13:36:00 +0000")
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org>
	<20250307-hrtimer-v3-v6-12-rc2-v10-3-0cf7e9491da4@kernel.org>
	<b-T-Yv_oexMXaKG9kNNfbYz-Qaw1XhJw-VHerSPFp_sIMoztNyAj94_rH-uNYeG-Hc5WANUivDJW9WLmfZZHwA==@protonmail.internalid>
	<D8A1Z043VPGR.2OBGSBH1ALUL6@proton.me> <87senp3r9b.fsf@kernel.org>
	<4ZAkOKT4__IQstGGnVAvkCTx_eb_sQwehN8od8rozgp_hijMhU83a7AOm9PD2WV8AuamjQxz_U1abZVWKY-zDA==@protonmail.internalid>
	<D8A2O5QBXCRI.18W3W0EDI3UXZ@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 07 Mar 2025 15:16:17 +0100
Message-ID: <87zfhx2afi.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On Fri Mar 7, 2025 at 2:27 PM CET, Andreas Hindborg wrote:
>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>
>>> On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
>>>> +impl<T> HrTimerPointer for Arc<T>
>>>> +where
>>>> +    T: 'static,
>>>> +    T: Send + Sync,
>>>> +    T: HasHrTimer<T>,
>>>> +    T: for<'a> HrTimerCallback<Pointer<'a> = Self>,
>>>> +    Arc<T>: for<'a> RawHrTimerCallback<CallbackTarget<'a> = ArcBorrow<'a, T>>,
>>>
>>> I don't understand why you need this bound here.
>>
>> This impl is applicable only when `Arc<T> has an implementation of
>> `RawTimerCallback` where CallbackTarget<'a> = ArcBorrow<'a, T>. I don't
>> want the impl to be available if that is not the case.
>
> The impl below has less strict other bounds than this one, so this bound
> doesn't change anything.
>
>> It's just an additional check.
>
> To me it's just additional noise.

I'll drop it then.

>
>>>> +{
>>>> +    type TimerHandle = ArcHrTimerHandle<T>;
>>>> +
>>>> +    fn start(self, expires: Ktime) -> ArcHrTimerHandle<T> {
>>>> +        // SAFETY:
>>>> +        //  - We keep `self` alive by wrapping it in a handle below.
>>>> +        //  - Since we generate the pointer passed to `start` from a valid
>>>> +        //    reference, it is a valid pointer.
>>>> +        unsafe { T::start(Arc::as_ptr(&self), expires) };
>>>> +        ArcHrTimerHandle { inner: self }
>>>> +    }
>>>> +}
>>>> +
>>>> +impl<T> RawHrTimerCallback for Arc<T>
>>>> +where
>>>> +    T: 'static,
>>>> +    T: HasHrTimer<T>,
>>>> +    T: for<'a> HrTimerCallback<Pointer<'a> = Self>,
>>>> +{
>>>> +    type CallbackTarget<'a> = ArcBorrow<'a, T>;
>>>> +
>>>> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
>>>> +        // `HrTimer` is `repr(C)`
>>>> +        let timer_ptr = ptr.cast::<super::HrTimer<T>>();
>>>> +
>>>> +        // SAFETY: By C API contract `ptr` is the pointer we passed when
>>>> +        // queuing the timer, so it is a `HrTimer<T>` embedded in a `T`.
>>>> +        let data_ptr = unsafe { T::timer_container_of(timer_ptr) };
>>>> +
>>>> +        // SAFETY: `data_ptr` points to the `T` that was used to queue the
>>>> +        // timer. This `T` is contained in an `Arc`.
>>>
>>> You're not justifying all safety requirements of `ArcBorrow::from_raw`.
>>
>> How is this:
>>
>>         // SAFETY:
>>         //  - `data_ptr` is derived form the pointer to the `T` that was used to
>>         //    queue the timer.
>>         //  - The `ArcTimerHandle` associated with this timer is guaranteed to
>>         //    be alive for the duration of the lifetime of `receiver`, so the
>
> There is no `receiver` in this context?

It's the value returned from the call, same line.

>
> Is the reason for the handle staying alive that when it is dropped, it
> calls `cancel` and that waits until the callback finishes? If so, did
> you write that down somewhere here?

Yes, it is in the safety requirement of the `HrTimerHandle` trait.
Should I add that? It becomes quite a story.

>
>>         //    refcount of the underlying `Arc` is guaranteed to be nonzero for
>>         //    the duration.
>>         //  - We own one refcount in the `ArcTimerHandle` associted with this
>>         //    timer, so it is not possible to get a `UniqueArc` to this
>>         //    allocation from other `Arc` clones.
>
> Otherwise this sounds good.

Cool.


Best regards,
Andreas Hindborg



