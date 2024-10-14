Return-Path: <linux-kernel+bounces-363316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BB799C080
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80C6281DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 06:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ACA145B25;
	Mon, 14 Oct 2024 06:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3Nb9yPN"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F133D145346;
	Mon, 14 Oct 2024 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728889085; cv=none; b=r4bypbJnDoDpTqm2FLvGSG98WwfZzZ9A5WpDkfwhsJUVcCsYMPSbHIG/bDx4aqy9wJeLap8GKP3T/QxT7/XPTIB8rWMoHdwJHro4yKRK9c3iB0Hjf0M6+Z9mJVPZeSK7MmE657R4dw5I3i6qox9htd3DKAPcepUTuOm6wEzRYd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728889085; c=relaxed/simple;
	bh=Uol9y/3LMoDv/EFKW5TNIdlJcME3TxMkab0kqRRjiuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eiFmHMZgk781UJ0y3qPqrNSzNap6w6bN6t1f9N3KQIoIoyy6CJuAJ4TPmJY8yq1MfMJkbohCFTOCqyS3UprRofioK8NVbm7xpTi1cwOIRLWOqB9LZnxODitOYnquhYCoSCnm7wm4V1BOf58XfdJGzShdwTw8u8kB+8s1oJ2RQls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3Nb9yPN; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a99650da839so689997666b.2;
        Sun, 13 Oct 2024 23:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728889082; x=1729493882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OqPCjsaPjJ50AmD4VKJMjnNhFs+kU2A2X2fUveI6tCQ=;
        b=m3Nb9yPNHJyumxv2+iJJ3gmUK+7sKZsTjxEO80THY2SBSnTInI6OQI22NQEpLGUpoK
         Ks1qq7eBkcJOqmkWew2uHEZS8t/GQnnu+zTJg3bq0MyynAoSlcmNkACjhNGasZbtPNl5
         0qRL0A6E8WBSHVcfiS0l9KbzCbevinSkI7hyj17QIEOYzgBqrT7zDb8Y0M1+tE2FsDOM
         S8cOO5k+/Wn+SY/pV0WGGDDDP8rpUSUoGnP6Y2kt9/5oBHXgt6+f4QUwvy2Xv8/3bqbe
         CQOb8Jy4JSn2x+HUnmgMb6Cw8KHUk5QMIhbglPEb46xcr01QtX1LEEoe69rHGKMiqggt
         5q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728889082; x=1729493882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OqPCjsaPjJ50AmD4VKJMjnNhFs+kU2A2X2fUveI6tCQ=;
        b=k6RxTngRnM4+ZIx+fJMIPsmZi3kMpd+cSpIZxSK+l/epIZOz1fzh/HwEsyhDXEGrrn
         5UwcamgxKVnNK42NWH1dLzp0gD7O96A6uE6HmQUgmvzpWKEvtBivdutq91WoltoP3xE9
         v8kU92MPsUnAUp/Fu3e73mpaUen9RasazARZYonBPMCazSlxCCafmaHpIJA9z/gIo9sc
         abvAGxu/7Gw/P5rPW41D8fAVSRkzS11dNTLDyrNoorjdpo9M4psUcGX3grtk+nVCt+Er
         D/g/RJf48+gSut0Oq8MvLOjoUnMI0dOOqhPgkvlsLc/6ESalooSOfYIyuu+OIafRII3f
         +DOg==
X-Forwarded-Encrypted: i=1; AJvYcCVuRn7FfGneAsGGvF/tDSw8e7dSLI1JE8nlCjxa/024HeD4HDqU3Bqgvo2jWM7bW1gGPDg0spl2WtAzLKg=@vger.kernel.org, AJvYcCVuoHvnLZiCoyAcrBMiKkwKBc03KWHWK4QTVByd3KViWoeZyxVpK2gk0Z5LOIMZUx21c/KZGTktXUkB06u2aMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeNAi194OZcaR9UWlhjjwPCy5mPOALVPyweQNIhuq1h7T8YLnY
	eCgGQtC55L00Hsc4GEKqqaNpqV0q0fFHiKgCWLU43K7qhvxV8ENC
X-Google-Smtp-Source: AGHT+IHjkwzmeYolNcpCu4kMgihidz35UylOt9qNLPfjiy7JpDl7IioyNAX8HaWuhUesiiLv0eXtYw==
X-Received: by 2002:a17:907:986:b0:a99:89bd:d84a with SMTP id a640c23a62f3a-a99e3b6db69mr691134866b.25.1728889081841;
        Sun, 13 Oct 2024 23:58:01 -0700 (PDT)
Received: from ?IPV6:2003:df:bf0d:b400:2fe4:847b:4ba1:cae7? (p200300dfbf0db4002fe4847b4ba1cae7.dip0.t-ipconnect.de. [2003:df:bf0d:b400:2fe4:847b:4ba1:cae7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c937260082sm4540343a12.60.2024.10.13.23.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 23:58:01 -0700 (PDT)
Message-ID: <9eb1504a-b306-4332-99ce-739bc016622e@gmail.com>
Date: Mon, 14 Oct 2024 08:58:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] hrtimer Rust API
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Dirk Behme <dirk.behme@de.bosch.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
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
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <Zww2Vhsl9sutNm0s@Boquns-Mac-mini.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.10.24 23:06, Boqun Feng wrote:
> On Sun, Oct 13, 2024 at 07:39:29PM +0200, Dirk Behme wrote:
>> On 13.10.24 00:26, Boqun Feng wrote:
>>> On Sat, Oct 12, 2024 at 09:50:00AM +0200, Dirk Behme wrote:
>>>> On 12.10.24 09:41, Boqun Feng wrote:
>>>>> On Sat, Oct 12, 2024 at 07:19:41AM +0200, Dirk Behme wrote:
>>>>>> On 12.10.24 01:21, Boqun Feng wrote:
>>>>>>> On Fri, Oct 11, 2024 at 05:43:57PM +0200, Dirk Behme wrote:
>>>>>>>> Hi Andreas,
>>>>>>>>
>>>>>>>> Am 11.10.24 um 16:52 schrieb Andreas Hindborg:
>>>>>>>>>
>>>>>>>>> Dirk, thanks for reporting!
>>>>>>>>
>>>>>>>> :)
>>>>>>>>
>>>>>>>>> Boqun Feng <boqun.feng@gmail.com> writes:
>>>>>>>>>
>>>>>>>>>> On Tue, Oct 01, 2024 at 02:37:46PM +0200, Dirk Behme wrote:
>>>>>>>>>>> On 18.09.2024 00:27, Andreas Hindborg wrote:
>>>>>>>>>>>> Hi!
>>>>>>>>>>>>
>>>>>>>>>>>> This series adds support for using the `hrtimer` subsystem from Rust code.
>>>>>>>>>>>>
>>>>>>>>>>>> I tried breaking up the code in some smaller patches, hopefully that will
>>>>>>>>>>>> ease the review process a bit.
>>>>>>>>>>>
>>>>>>>>>>> Just fyi, having all 14 patches applied I get [1] on the first (doctest)
>>>>>>>>>>> Example from hrtimer.rs.
>>>>>>>>>>>
>>>>>>>>>>> This is from lockdep:
>>>>>>>>>>>
>>>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/locking/lockdep.c#n4785
>>>>>>>>>>>
>>>>>>>>>>> Having just a quick look I'm not sure what the root cause is. Maybe mutex in
>>>>>>>>>>> interrupt context? Or a more subtle one?
>>>>>>>>>>
>>>>>>>>>> I think it's calling mutex inside an interrupt context as shown by the
>>>>>>>>>> callstack:
>>>>>>>>>>
>>>>>>>>>> ]  __mutex_lock+0xa0/0xa4
>>>>>>>>>> ] ...
>>>>>>>>>> ]  hrtimer_interrupt+0x1d4/0x2ac
>>>>>>>>>>
>>>>>>>>>> , it is because:
>>>>>>>>>>
>>>>>>>>>> +//! struct ArcIntrusiveTimer {
>>>>>>>>>> +//!     #[pin]
>>>>>>>>>> +//!     timer: Timer<Self>,
>>>>>>>>>> +//!     #[pin]
>>>>>>>>>> +//!     flag: Mutex<bool>,
>>>>>>>>>> +//!     #[pin]
>>>>>>>>>> +//!     cond: CondVar,
>>>>>>>>>> +//! }
>>>>>>>>>>
>>>>>>>>>> has a Mutex<bool>, which actually should be a SpinLockIrq [1]. Note that
>>>>>>>>>> irq-off is needed for the lock, because otherwise we will hit a self
>>>>>>>>>> deadlock due to interrupts:
>>>>>>>>>>
>>>>>>>>>> 	spin_lock(&a);
>>>>>>>>>> 	> timer interrupt
>>>>>>>>>> 	  spin_lock(&a);
>>>>>>>>>>
>>>>>>>>>> Also notice that the IrqDisabled<'_> token can be simply created by
>>>>>>>>>> ::new(), because irq contexts should guarantee interrupt disabled (i.e.
>>>>>>>>>> we don't support nested interrupts*).
>>>>>>>>>
>>>>>>>>> I updated the example based on the work in [1]. I think we need to
>>>>>>>>> update `CondVar::wait` to support waiting with irq disabled.
>>>>>>>>
>>>>>>>> Yes, I agree. This answers one of the open questions I had in the discussion
>>>>>>>> with Boqun :)
>>>>>>>>
>>>>>>>> What do you think regarding the other open question: In this *special* case
>>>>>>>> here, what do you think to go *without* any lock? I mean the 'while *guard
>>>>>>>> != 5' loop in the main thread is read only regarding guard. So it doesn't
>>>>>>>> matter if it *reads* the old or the new value. And the read/modify/write of
>>>>>>>> guard in the callback is done with interrupts disabled anyhow as it runs in
>>>>>>>> interrupt context. And with this can't be interrupted (excluding nested
>>>>>>>> interrupts). So this modification of guard doesn't need to be protected from
>>>>>>>> being interrupted by a lock if there is no modifcation of guard "outside"
>>>>>>>> the interupt locked context.
>>>>>>>>
>>>>>>>> What do you think?
>>>>>>>>
>>>>>>>
>>>>>>> Reading while there is another CPU is writing is data-race, which is UB.
>>>>>>
>>>>>> Could you help to understand where exactly you see UB in Andreas' 'while
>>>>>> *guard != 5' loop in case no locking is used? As mentioned I'm under the
>>>>>
>>>>> Sure, but could you provide the code of what you mean exactly, if you
>>>>> don't use a lock here, you cannot have a guard. I need to the exact code
>>>>> to point out where the compiler may "mis-compile" (a result of being
> [...]
>>>> I thought we are talking about anything like
>>>>
>>>> #[pin_data]
>>>> struct ArcIntrusiveTimer {
>>>>         #[pin]
>>>>         timer: Timer<Self>,
>>>>         #[pin]
>>>> -      flag: SpinLockIrq<u64>,
>>>> +      flag: u64,
>>>>         #[pin]
>>>>         cond: CondVar,
>>>> }
>>>>
>>>> ?
>>>>
>>>
>>> Yes, but have you tried to actually use that for the example from
>>> Andreas? I think you will find that you cannot write to `flag` inside
>>> the timer callback, because you only has a `Arc<ArcIntrusiveTimer>`, so
>>> not mutable reference for `ArcIntrusiveTimer`. You can of course use
>>> unsafe to create a mutable reference to `flag`, but it won't be sound,
>>> since you are getting a mutable reference from an immutable reference.
>>
>> Yes, of course. But, hmm, wouldn't that unsoundness be independent on the
>> topic we discuss here? I mean we are talking about getting the compiler to
> 
> What do you mean? If the code is unsound, you won't want to use it in an
> example, right?

Yes, sure. But ;)

In a first step I just wanted to answer the question if we do need a 
lock at all in this special example. And that we could do even with 
unsound read/modify/write I would guess. And then, in a second step, 
if the answer would be "we don't need the lock", then we could think 
about how to make the flag handling sound. So I'm talking just about 
answering that question, not about the final example code. Step by step :)


>> read/modify/write 'flag' in the TimerCallback. *How* we tell him to do so
>> should be independent on the result what we want to look at regarding the
>> locking requirements of 'flag'?
>>
>> Anyhow, my root motivation was to simplify Andreas example to not use a lock
>> where not strictly required. And with this make Andreas example independent
> 
> Well, if you don't want to use a lock then you need to use atomics,
> otherwise it's likely a UB, 

And here we are back to the initial question :) Why would it be UB 
without lock (and atomics)?

Some (pseudo) assembly:

Lets start with the main thread:

ldr x1, [x0]
<work with x1>

x0 and x1 are registers. x0 contains the address of flag in the main 
memory. I.e. that instruction reads (ldr == load) the content of that 
memory location (flag) into x1. x1 then contains flag which can be 
used then. This is what I mean with "the main thread is read only". If 
flag, i.e. x1, does contain the old or new flag value doesn't matter. 
I.e. for the read only operation it doesn't matter if it is protected 
by a lock as the load (ldr) can't be interrupted.

Now to the TimerCallback:

ldr x1, [x0]
add x1, x1, #1
str x1, [x0]

This is what I mean with read/modify/write. And this needs to be 
ensured that it is not interruptable. I.e. that we are scheduled 
between ldr and add or between add and str. Yes, I *totally* agree 
that for this a lock is needed:

<lock>
ldr x1, [x0]
add x1, x1, #1
str x1, [x0]
<unlock>

But:

In this this special example we know that we are executing this code 
in interrupt context. I.e.:

<interrupts are disabled>
ldr x1, [x0]
add x1, x1, #1
str x1, [x0]
<interrupts are still disabled>

So this read/modify/write can't be interrupted because the interrupts 
are off. I.e. the interrupt off prevents the scheduling here. And in 
this sense replaces the lock. And as mentioned, which value is read by 
the main thread doesn't matter.

To summarize: I totally agree that usually a lock would be needed. But 
in this special case with (a) read/modify/write in interrupt context 
*and* (b) read only in main thread I'm unclear.

So with this back to the main question: What is my misunderstanding 
here? I.e. what is UB in this special case? :)

Best regards

Dirk

> but atomics are still WIP, so that why I
> suggested Andreas to use a lock first. But I guess I didn't realise the
> lock needs to be irq-safe when I suggested that.
> 
> Regards,
> Boqun
> 
>> on mutex lockdep issues, SpinLockIrq changes and possible required CondVar
>> updates. But maybe we find an other way to simplify it and decrease the
>> dependencies. In the end its just example code ;)
>>
>> Best regards
>>
>> Dirk
>>
>>
>>> Regards,
>>> Boqun
>>>
> [...]


