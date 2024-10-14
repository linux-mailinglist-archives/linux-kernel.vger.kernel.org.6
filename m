Return-Path: <linux-kernel+bounces-363991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB39399C975
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2051C21CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ACC19EEA1;
	Mon, 14 Oct 2024 11:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aw1P352F"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF3219E806;
	Mon, 14 Oct 2024 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906817; cv=none; b=Kw6DQVtGOr3QKoM1dEZdAG27qfNoRo8r5cdqzXERVat+BBbToaOVsb5HNoYu8MvGXm8O5dK3rdwTLujafrk3rWY4IM78XAu2PhqilOXoxEcp1wjQYxodj1niRXEYqv2vbbOr+9I5PLTC9zyhanRONyLxYu266JewVkdKV+Rva0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906817; c=relaxed/simple;
	bh=XR7qESGBDVrIA8Lm7xS+8qBFf7QOWkf492mCWX4sivo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HA0lVxQN3lyth0DKbtGxDMsFfUdmcgALz2BpYL4vKcBWPSlDTiHW+VrVyJISKpGDrGAm47s3DrsAY3cEtLXcOspDfQjnIeMk91/lwO3LliKqc6geH0e5C1kGUwIC9W6bVy9d0rxw/SOS+pU3GUiIYuyVpvuZ1kGRTzGWnT9/7rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aw1P352F; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c97cc83832so1146240a12.0;
        Mon, 14 Oct 2024 04:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728906813; x=1729511613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AQACUneLJanBOpgsyQp5cZKq6oerX9zh3i2MmY0+vYw=;
        b=aw1P352FK+ExKjOQvhm10G+JVEnnYRdoUNIOT3OJxbNGzFojj/ah/o7pMfqqUcjAzT
         uKCgmT4nduKDFG0369m6SyNBCLtfrtzjTPUgriDSTkktvGj/0pqkRSLMyNez05bzq1Iz
         Wb7zM599WnzBzvOoodxGZKynGQ50YuOJmk9odIpsuPqAar60vvRjGGXDnhyf9hjqIQfm
         O9Mv2kuOtgcUvQL+/qKxDls4Q5l+RiLlL+WPTDOxvBuUU3f1GGKcnJRlBbVYff6sRMd+
         oAUUyAPRnQYLtZH16ntw6Ac8U1xSu4Vb4zSiTvbYXHUZvOC61LqboO72qvvfrtMn85a8
         esGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728906813; x=1729511613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQACUneLJanBOpgsyQp5cZKq6oerX9zh3i2MmY0+vYw=;
        b=vKbKQ2cqA7dNPkMGOlSJPQSNbmAXu37h07IPdp/qMbYItuG9OPmbXOAXrD4HLyCuhT
         rTMr8V60TRxIKrGYaRjZIYwto+Rf0gq6iQOZa9aJI8unINV6e1bdM8oQoaJahQUVVBBm
         kwpwXdc2oLwCkG2r51fBcXoq9u8aS0A+lx8gdcnbQ78FG2L+ixqNklhZr/6yWRMi9HTB
         mmAJcJ+3jrEZNAl4ggrWCb7aye9x34KO08XC1ZYeVTAfDWyQb6KFsgGTtA3toSWEt7yu
         MPMg9ae2PDxq1ik92k/71zC0cH/FQFgnsPTlnsG/JxFZBZYCtK48jftF5/hUjlXIfeY2
         TExg==
X-Forwarded-Encrypted: i=1; AJvYcCUPlagMOJ0ecAtH8PO8yxsKK7KmGwqFsn596wx9hC9WvczXpQzqEIT+dy0j5wKBAxFWiYNOh+ZYGlhHap/kA2Y=@vger.kernel.org, AJvYcCUrrGB2CsPEeHc33Kxeb1ET/ivNZiNQT1BCbCDV9r93J1B5CoagHnctLQLA874c0vKG5JpfnxRKcb+lw28=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuIpXyGoNfvb5j1ocSSkoxGOYK1srcCRtOCIi2ajj2arRA5DiF
	r3CaA/dQc9xlSwSMJ/ByWPxqyFfpJjQdVsLH29FuDXlB0ctZTsCX
X-Google-Smtp-Source: AGHT+IEi++ZJ/Q8U9n/3NqbDajtk5rfnQNqxvZqqQuneSfwVU7JwsXy2ZSbLiJu8Z8YDWxHwbrfACQ==
X-Received: by 2002:a05:6402:26cf:b0:5c5:c059:63c6 with SMTP id 4fb4d7f45d1cf-5c948c88336mr8909519a12.2.1728906813215;
        Mon, 14 Oct 2024 04:53:33 -0700 (PDT)
Received: from ?IPV6:2003:df:bf0d:b400:2fe4:847b:4ba1:cae7? (p200300dfbf0db4002fe4847b4ba1cae7.dip0.t-ipconnect.de. [2003:df:bf0d:b400:2fe4:847b:4ba1:cae7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c93711ab3asm4920283a12.30.2024.10.14.04.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 04:53:32 -0700 (PDT)
Message-ID: <2c895c91-1309-4727-9d70-2a7d49d2dfb7@gmail.com>
Date: Mon, 14 Oct 2024 13:53:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] hrtimer Rust API
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Dirk Behme <dirk.behme@de.bosch.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <e644aec7-02b3-4faf-9a80-629055c5a27a@de.bosch.com>
 <ZvwKTinnLckZm8aQ@boqun-archlinux> <87a5falmjy.fsf@kernel.org>
 <dae08234-c9ba-472d-b769-1d07e579a8ac@gmail.com>
 <Zwmy-2Yc7vGboYvl@boqun-archlinux>
 <d2ce38a3-9a32-4f4c-88f2-22864b66afe5@gmail.com>
 <ZwooHrqIiirl1so7@boqun-archlinux>
 <4dd93603-04fa-4da4-b867-bd12ece4b391@gmail.com>
 <Zwr3i4x7J5qyjFog@Boquns-Mac-mini.local>
 <c19edf2d-2b53-403f-abcc-a5e81e7613f8@gmail.com>
 <Zww2Vhsl9sutNm0s@Boquns-Mac-mini.local>
 <9eb1504a-b306-4332-99ce-739bc016622e@gmail.com>
 <CAH5fLgierGcZ7SycTspdOrFofWGmM_UOKHUmfNQ0VjSzMtMB5g@mail.gmail.com>
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <CAH5fLgierGcZ7SycTspdOrFofWGmM_UOKHUmfNQ0VjSzMtMB5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alice,

On 14.10.24 11:38, Alice Ryhl wrote:
> On Mon, Oct 14, 2024 at 8:58 AM Dirk Behme <dirk.behme@gmail.com> wrote:
>>
>> On 13.10.24 23:06, Boqun Feng wrote:
>>> On Sun, Oct 13, 2024 at 07:39:29PM +0200, Dirk Behme wrote:
>>>> On 13.10.24 00:26, Boqun Feng wrote:
>>>>> On Sat, Oct 12, 2024 at 09:50:00AM +0200, Dirk Behme wrote:
>>>>>> On 12.10.24 09:41, Boqun Feng wrote:
>>>>>>> On Sat, Oct 12, 2024 at 07:19:41AM +0200, Dirk Behme wrote:
>>>>>>>> On 12.10.24 01:21, Boqun Feng wrote:
>>>>>>>>> On Fri, Oct 11, 2024 at 05:43:57PM +0200, Dirk Behme wrote:
>>>>>>>>>> Hi Andreas,
>>>>>>>>>>
>>>>>>>>>> Am 11.10.24 um 16:52 schrieb Andreas Hindborg:
>>>>>>>>>>>
>>>>>>>>>>> Dirk, thanks for reporting!
>>>>>>>>>>
>>>>>>>>>> :)
>>>>>>>>>>
>>>>>>>>>>> Boqun Feng <boqun.feng@gmail.com> writes:
>>>>>>>>>>>
>>>>>>>>>>>> On Tue, Oct 01, 2024 at 02:37:46PM +0200, Dirk Behme wrote:
>>>>>>>>>>>>> On 18.09.2024 00:27, Andreas Hindborg wrote:
>>>>>>>>>>>>>> Hi!
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> This series adds support for using the `hrtimer` subsystem from Rust code.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I tried breaking up the code in some smaller patches, hopefully that will
>>>>>>>>>>>>>> ease the review process a bit.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Just fyi, having all 14 patches applied I get [1] on the first (doctest)
>>>>>>>>>>>>> Example from hrtimer.rs.
>>>>>>>>>>>>>
>>>>>>>>>>>>> This is from lockdep:
>>>>>>>>>>>>>
>>>>>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/locking/lockdep.c#n4785
>>>>>>>>>>>>>
>>>>>>>>>>>>> Having just a quick look I'm not sure what the root cause is. Maybe mutex in
>>>>>>>>>>>>> interrupt context? Or a more subtle one?
>>>>>>>>>>>>
>>>>>>>>>>>> I think it's calling mutex inside an interrupt context as shown by the
>>>>>>>>>>>> callstack:
>>>>>>>>>>>>
>>>>>>>>>>>> ]  __mutex_lock+0xa0/0xa4
>>>>>>>>>>>> ] ...
>>>>>>>>>>>> ]  hrtimer_interrupt+0x1d4/0x2ac
>>>>>>>>>>>>
>>>>>>>>>>>> , it is because:
>>>>>>>>>>>>
>>>>>>>>>>>> +//! struct ArcIntrusiveTimer {
>>>>>>>>>>>> +//!     #[pin]
>>>>>>>>>>>> +//!     timer: Timer<Self>,
>>>>>>>>>>>> +//!     #[pin]
>>>>>>>>>>>> +//!     flag: Mutex<bool>,
>>>>>>>>>>>> +//!     #[pin]
>>>>>>>>>>>> +//!     cond: CondVar,
>>>>>>>>>>>> +//! }
>>>>>>>>>>>>
>>>>>>>>>>>> has a Mutex<bool>, which actually should be a SpinLockIrq [1]. Note that
>>>>>>>>>>>> irq-off is needed for the lock, because otherwise we will hit a self
>>>>>>>>>>>> deadlock due to interrupts:
>>>>>>>>>>>>
>>>>>>>>>>>>       spin_lock(&a);
>>>>>>>>>>>>       > timer interrupt
>>>>>>>>>>>>         spin_lock(&a);
>>>>>>>>>>>>
>>>>>>>>>>>> Also notice that the IrqDisabled<'_> token can be simply created by
>>>>>>>>>>>> ::new(), because irq contexts should guarantee interrupt disabled (i.e.
>>>>>>>>>>>> we don't support nested interrupts*).
>>>>>>>>>>>
>>>>>>>>>>> I updated the example based on the work in [1]. I think we need to
>>>>>>>>>>> update `CondVar::wait` to support waiting with irq disabled.
>>>>>>>>>>
>>>>>>>>>> Yes, I agree. This answers one of the open questions I had in the discussion
>>>>>>>>>> with Boqun :)
>>>>>>>>>>
>>>>>>>>>> What do you think regarding the other open question: In this *special* case
>>>>>>>>>> here, what do you think to go *without* any lock? I mean the 'while *guard
>>>>>>>>>> != 5' loop in the main thread is read only regarding guard. So it doesn't
>>>>>>>>>> matter if it *reads* the old or the new value. And the read/modify/write of
>>>>>>>>>> guard in the callback is done with interrupts disabled anyhow as it runs in
>>>>>>>>>> interrupt context. And with this can't be interrupted (excluding nested
>>>>>>>>>> interrupts). So this modification of guard doesn't need to be protected from
>>>>>>>>>> being interrupted by a lock if there is no modifcation of guard "outside"
>>>>>>>>>> the interupt locked context.
>>>>>>>>>>
>>>>>>>>>> What do you think?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Reading while there is another CPU is writing is data-race, which is UB.
>>>>>>>>
>>>>>>>> Could you help to understand where exactly you see UB in Andreas' 'while
>>>>>>>> *guard != 5' loop in case no locking is used? As mentioned I'm under the
>>>>>>>
>>>>>>> Sure, but could you provide the code of what you mean exactly, if you
>>>>>>> don't use a lock here, you cannot have a guard. I need to the exact code
>>>>>>> to point out where the compiler may "mis-compile" (a result of being
>>> [...]
>>>>>> I thought we are talking about anything like
>>>>>>
>>>>>> #[pin_data]
>>>>>> struct ArcIntrusiveTimer {
>>>>>>          #[pin]
>>>>>>          timer: Timer<Self>,
>>>>>>          #[pin]
>>>>>> -      flag: SpinLockIrq<u64>,
>>>>>> +      flag: u64,
>>>>>>          #[pin]
>>>>>>          cond: CondVar,
>>>>>> }
>>>>>>
>>>>>> ?
>>>>>>
>>>>>
>>>>> Yes, but have you tried to actually use that for the example from
>>>>> Andreas? I think you will find that you cannot write to `flag` inside
>>>>> the timer callback, because you only has a `Arc<ArcIntrusiveTimer>`, so
>>>>> not mutable reference for `ArcIntrusiveTimer`. You can of course use
>>>>> unsafe to create a mutable reference to `flag`, but it won't be sound,
>>>>> since you are getting a mutable reference from an immutable reference.
>>>>
>>>> Yes, of course. But, hmm, wouldn't that unsoundness be independent on the
>>>> topic we discuss here? I mean we are talking about getting the compiler to
>>>
>>> What do you mean? If the code is unsound, you won't want to use it in an
>>> example, right?
>>
>> Yes, sure. But ;)
>>
>> In a first step I just wanted to answer the question if we do need a
>> lock at all in this special example. And that we could do even with
>> unsound read/modify/write I would guess. And then, in a second step,
>> if the answer would be "we don't need the lock", then we could think
>> about how to make the flag handling sound. So I'm talking just about
>> answering that question, not about the final example code. Step by step :)
>>
>>
>>>> read/modify/write 'flag' in the TimerCallback. *How* we tell him to do so
>>>> should be independent on the result what we want to look at regarding the
>>>> locking requirements of 'flag'?
>>>>
>>>> Anyhow, my root motivation was to simplify Andreas example to not use a lock
>>>> where not strictly required. And with this make Andreas example independent
>>>
>>> Well, if you don't want to use a lock then you need to use atomics,
>>> otherwise it's likely a UB,
>>
>> And here we are back to the initial question :) Why would it be UB
>> without lock (and atomics)?
>>
>> Some (pseudo) assembly:
>>
>> Lets start with the main thread:
>>
>> ldr x1, [x0]
>> <work with x1>
>>
>> x0 and x1 are registers. x0 contains the address of flag in the main
>> memory. I.e. that instruction reads (ldr == load) the content of that
>> memory location (flag) into x1. x1 then contains flag which can be
>> used then. This is what I mean with "the main thread is read only". If
>> flag, i.e. x1, does contain the old or new flag value doesn't matter.
>> I.e. for the read only operation it doesn't matter if it is protected
>> by a lock as the load (ldr) can't be interrupted.
> 
> If the compiler generates a single load, then sure. 

Yes :)

> But for an
> unsynchronized load, the compiler may generate two separate load
> instructions and assume that both loads read the same value.

Ok, yes, if we get this from the compiler I agree that we need the 
lock, even if its just for the read. If I get the chance the next time 
I will try to have a look to the compiler's result to get a better 
idea of this.

Many thanks

Dirk


