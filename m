Return-Path: <linux-kernel+bounces-362879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC9299BA94
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 19:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A6A281A04
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 17:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B917214883B;
	Sun, 13 Oct 2024 17:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLLtwNG7"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E8B3D6A;
	Sun, 13 Oct 2024 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728841174; cv=none; b=qc67GoWZBpWza0WigTzmPnA2Sy76YV0mq0tgHvTm19pWrf2v31GnwrXazz5HcC01tQ1dergwssfKHP78Hru2rJ/05OiXfxI5qB0u713abwD+Dcsbc1f7Eb2Wsf2apWeYsby2Ubfi4EA+/EG8rdigc1PtQIQh1IhTAj/UbGvlkCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728841174; c=relaxed/simple;
	bh=kteKScfeAWlFugs+4XNhCDAIgIFZB7JzGIqj5pipDRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtk8mIt60wZTk1wk0IKDCjEGXH/DiiL52kLJ7KiEe3zujiVj3ucQSIMDYOHXqc3vIVYfa5dBbOOqjDXnF6eArPhwa4nwcTZraBUbY5pR2a+X5SkCFqO1rFEn/kWmeh19r7Ja2QK0NCWyW4zsqWya4Mzy+IOvbGoyzjMaoTgfgq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLLtwNG7; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4ba20075so2230139f8f.0;
        Sun, 13 Oct 2024 10:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728841171; x=1729445971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LYjm1NvOQAPGCKgpEzX8bKkA1SFC4QEZPasDaoaVX8w=;
        b=NLLtwNG7Mb6t9/dH1HxrQuqEDkSbphfZHila1XIP3aTmWs7/iHbdZJ/kgsYF2XeKgO
         UgwSFGHbaq/F+u9Sh8GI8vGjEds96kan71olY/ur4l9uXmo7rZ4OZXN6yEmgK67uFSS0
         QR+7QeBis5Yo4sXeoY9tVwrpB6G3BvmwgQHskKqm6CF7TJhSnQ3ltpLxzfA47T3AoSBW
         QGZJ6A6jrVJcJMvTyYEQqhguOL4e4PC3QXETogmxCqOMs+OxYJTRx4GYhvlFvmwwXqmK
         MGMktx2RM2zTydf96BEZaDySAASs8kHGFC/HCnpc9cjzZE4COkQSpdqu/dJyqujs0PxX
         l/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728841171; x=1729445971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LYjm1NvOQAPGCKgpEzX8bKkA1SFC4QEZPasDaoaVX8w=;
        b=lUUvJHtg8LzaTwcjJkKQmNNCeP4+JiXhjAi0TzJcUWuYUAtecPKis9rX+APAQX81GO
         Ag7TEMfb5vNasvFWik7PUe2e0Q1+0ZPMhkPzpGTTFgpWn7ik162wvZMup7uP40n2U9yz
         iQeSv7bX/hrxkG1NiwWeYq1/f6Sn3FoHsjU/xvb+SRR4E+Qq/umzWQ4eHWZdYEmP9jId
         mFOeDuTxIa4XIfNSSLm1Nlt4Us+uncOUgeU+UbUfcQAWUa32m9VA4lguBfyn0HzfaCJZ
         78CEOARZF7LW//10/77q7ok176FTda5DPkiO23490Qdd5c34l/ZaEXpaFkSgfb17lD7w
         HlCw==
X-Forwarded-Encrypted: i=1; AJvYcCUW5IjH7IDmM+RqyWhKW+C/r+sD/+NP4kFjCmilbloqRgPOb3W+wwo80f0uVJmo7yKk2jAXS4YJ9r0DQZA=@vger.kernel.org, AJvYcCUsopAGZW/OqfAua+j2IdGGiEdp5cRXB6BaOTLyURQbAJ+IKxkm91OV3TnwsQgz6rgQYbGsYh1eqLtzi1mmmzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw40s6TBm1TAiIt/sw3NDSN/Dlca3o3zcmc2tc2kUvJ7gebqHuA
	TvpjiDjKx1tQX4V6znEHmzsyYWsGz60JBv4qCIVTfHcoOAnJ6594
X-Google-Smtp-Source: AGHT+IGxNe8oHd7KVfRS8ag/HojXyum7ANHOcu2WlJ5zx4L2/jOIsiruO41vLAXhtMZkSIaCJUANAg==
X-Received: by 2002:adf:ea8d:0:b0:37c:d1b6:a261 with SMTP id ffacd0b85a97d-37d55300b05mr6302969f8f.59.1728841170851;
        Sun, 13 Oct 2024 10:39:30 -0700 (PDT)
Received: from ?IPV6:2003:df:bf0d:b400:8929:5548:bc13:fc85? (p200300dfbf0db40089295548bc13fc85.dip0.t-ipconnect.de. [2003:df:bf0d:b400:8929:5548:bc13:fc85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d70b4462sm131574165e9.30.2024.10.13.10.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 10:39:30 -0700 (PDT)
Message-ID: <c19edf2d-2b53-403f-abcc-a5e81e7613f8@gmail.com>
Date: Sun, 13 Oct 2024 19:39:29 +0200
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
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
 <e644aec7-02b3-4faf-9a80-629055c5a27a@de.bosch.com>
 <ZvwKTinnLckZm8aQ@boqun-archlinux> <87a5falmjy.fsf@kernel.org>
 <dae08234-c9ba-472d-b769-1d07e579a8ac@gmail.com>
 <Zwmy-2Yc7vGboYvl@boqun-archlinux>
 <d2ce38a3-9a32-4f4c-88f2-22864b66afe5@gmail.com>
 <ZwooHrqIiirl1so7@boqun-archlinux>
 <4dd93603-04fa-4da4-b867-bd12ece4b391@gmail.com>
 <Zwr3i4x7J5qyjFog@Boquns-Mac-mini.local>
Content-Language: en-US
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <Zwr3i4x7J5qyjFog@Boquns-Mac-mini.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.10.24 00:26, Boqun Feng wrote:
> On Sat, Oct 12, 2024 at 09:50:00AM +0200, Dirk Behme wrote:
>> On 12.10.24 09:41, Boqun Feng wrote:
>>> On Sat, Oct 12, 2024 at 07:19:41AM +0200, Dirk Behme wrote:
>>>> On 12.10.24 01:21, Boqun Feng wrote:
>>>>> On Fri, Oct 11, 2024 at 05:43:57PM +0200, Dirk Behme wrote:
>>>>>> Hi Andreas,
>>>>>>
>>>>>> Am 11.10.24 um 16:52 schrieb Andreas Hindborg:
>>>>>>>
>>>>>>> Dirk, thanks for reporting!
>>>>>>
>>>>>> :)
>>>>>>
>>>>>>> Boqun Feng <boqun.feng@gmail.com> writes:
>>>>>>>
>>>>>>>> On Tue, Oct 01, 2024 at 02:37:46PM +0200, Dirk Behme wrote:
>>>>>>>>> On 18.09.2024 00:27, Andreas Hindborg wrote:
>>>>>>>>>> Hi!
>>>>>>>>>>
>>>>>>>>>> This series adds support for using the `hrtimer` subsystem from Rust code.
>>>>>>>>>>
>>>>>>>>>> I tried breaking up the code in some smaller patches, hopefully that will
>>>>>>>>>> ease the review process a bit.
>>>>>>>>>
>>>>>>>>> Just fyi, having all 14 patches applied I get [1] on the first (doctest)
>>>>>>>>> Example from hrtimer.rs.
>>>>>>>>>
>>>>>>>>> This is from lockdep:
>>>>>>>>>
>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/locking/lockdep.c#n4785
>>>>>>>>>
>>>>>>>>> Having just a quick look I'm not sure what the root cause is. Maybe mutex in
>>>>>>>>> interrupt context? Or a more subtle one?
>>>>>>>>
>>>>>>>> I think it's calling mutex inside an interrupt context as shown by the
>>>>>>>> callstack:
>>>>>>>>
>>>>>>>> ]  __mutex_lock+0xa0/0xa4
>>>>>>>> ] ...
>>>>>>>> ]  hrtimer_interrupt+0x1d4/0x2ac
>>>>>>>>
>>>>>>>> , it is because:
>>>>>>>>
>>>>>>>> +//! struct ArcIntrusiveTimer {
>>>>>>>> +//!     #[pin]
>>>>>>>> +//!     timer: Timer<Self>,
>>>>>>>> +//!     #[pin]
>>>>>>>> +//!     flag: Mutex<bool>,
>>>>>>>> +//!     #[pin]
>>>>>>>> +//!     cond: CondVar,
>>>>>>>> +//! }
>>>>>>>>
>>>>>>>> has a Mutex<bool>, which actually should be a SpinLockIrq [1]. Note that
>>>>>>>> irq-off is needed for the lock, because otherwise we will hit a self
>>>>>>>> deadlock due to interrupts:
>>>>>>>>
>>>>>>>> 	spin_lock(&a);
>>>>>>>> 	> timer interrupt
>>>>>>>> 	  spin_lock(&a);
>>>>>>>>
>>>>>>>> Also notice that the IrqDisabled<'_> token can be simply created by
>>>>>>>> ::new(), because irq contexts should guarantee interrupt disabled (i.e.
>>>>>>>> we don't support nested interrupts*).
>>>>>>>
>>>>>>> I updated the example based on the work in [1]. I think we need to
>>>>>>> update `CondVar::wait` to support waiting with irq disabled.
>>>>>>
>>>>>> Yes, I agree. This answers one of the open questions I had in the discussion
>>>>>> with Boqun :)
>>>>>>
>>>>>> What do you think regarding the other open question: In this *special* case
>>>>>> here, what do you think to go *without* any lock? I mean the 'while *guard
>>>>>> != 5' loop in the main thread is read only regarding guard. So it doesn't
>>>>>> matter if it *reads* the old or the new value. And the read/modify/write of
>>>>>> guard in the callback is done with interrupts disabled anyhow as it runs in
>>>>>> interrupt context. And with this can't be interrupted (excluding nested
>>>>>> interrupts). So this modification of guard doesn't need to be protected from
>>>>>> being interrupted by a lock if there is no modifcation of guard "outside"
>>>>>> the interupt locked context.
>>>>>>
>>>>>> What do you think?
>>>>>>
>>>>>
>>>>> Reading while there is another CPU is writing is data-race, which is UB.
>>>>
>>>> Could you help to understand where exactly you see UB in Andreas' 'while
>>>> *guard != 5' loop in case no locking is used? As mentioned I'm under the
>>>
>>> Sure, but could you provide the code of what you mean exactly, if you
>>> don't use a lock here, you cannot have a guard. I need to the exact code
>>> to point out where the compiler may "mis-compile" (a result of being
>>> UB).
>>
>>
>> I thought we are talking about anything like
>>
>> #[pin_data]
>> struct ArcIntrusiveTimer {
>>        #[pin]
>>        timer: Timer<Self>,
>>        #[pin]
>> -      flag: SpinLockIrq<u64>,
>> +      flag: u64,
>>        #[pin]
>>        cond: CondVar,
>> }
>>
>> ?
>>
> 
> Yes, but have you tried to actually use that for the example from
> Andreas? I think you will find that you cannot write to `flag` inside
> the timer callback, because you only has a `Arc<ArcIntrusiveTimer>`, so
> not mutable reference for `ArcIntrusiveTimer`. You can of course use
> unsafe to create a mutable reference to `flag`, but it won't be sound,
> since you are getting a mutable reference from an immutable reference.

Yes, of course. But, hmm, wouldn't that unsoundness be independent on 
the topic we discuss here? I mean we are talking about getting the 
compiler to read/modify/write 'flag' in the TimerCallback. *How* we 
tell him to do so should be independent on the result what we want to 
look at regarding the locking requirements of 'flag'?

Anyhow, my root motivation was to simplify Andreas example to not use 
a lock where not strictly required. And with this make Andreas example 
independent on mutex lockdep issues, SpinLockIrq changes and possible 
required CondVar updates. But maybe we find an other way to simplify 
it and decrease the dependencies. In the end its just example code ;)

Best regards

Dirk


> Regards,
> Boqun
> 
>> Best regards
>>
>> Dirk
>>
>>>> impression that it doesn't matter if the old or new guard value is read in
>>>> this special case.
>>>>
>>>
>>> For one thing, if the compiler believes no one is accessing the value
>>> because the code uses an immutable reference, it can "optimize" the loop
>>> away:
>>>
>>> 	while *var != 5 {
>>> 	    do_something();
>>> 	}
>>>
>>> into
>>> 	
>>> 	if *var != 5 {
>>> 	    loop { do_something(); }
>>> 	}
>>>
>>> But as I said, I need to see the exact code to suggest a relevant
>>> mis-compile, and note that sometimes, even mis-compile seems impossible
>>> at the moment, a UB is a UB, compilers are free to do anything they
>>> want (or don't want). So "mis-compile" is only helping we understand the
>>> potential result of a UB.
>>>
>>> Regards,
>>> Boqun
>>>
>>>> Best regards
>>>>
>>>> Dirk
>>>>
>>>>
>>>>> Regards,
>>>>> Boqun
>>>>>
>>>>>> Thanks
>>>>>>
>>>>>> Dirk
>>>>>>
>>>>>>
>>>>>>> Without
>>>>>>> this, when we get back from `bindings::schedule_timeout` in
>>>>>>> `CondVar::wait_internal`, interrupts are enabled:
>>>>>>>
>>>>>>> ```rust
>>>>>>> use kernel::{
>>>>>>>         hrtimer::{Timer, TimerCallback, TimerPointer, TimerRestart},
>>>>>>>         impl_has_timer, new_condvar, new_spinlock, new_spinlock_irq,
>>>>>>>         irq::IrqDisabled,
>>>>>>>         prelude::*,
>>>>>>>         sync::{Arc, ArcBorrow, CondVar, SpinLock, SpinLockIrq},
>>>>>>>         time::Ktime,
>>>>>>> };
>>>>>>>
>>>>>>> #[pin_data]
>>>>>>> struct ArcIntrusiveTimer {
>>>>>>>         #[pin]
>>>>>>>         timer: Timer<Self>,
>>>>>>>         #[pin]
>>>>>>>         flag: SpinLockIrq<u64>,
>>>>>>>         #[pin]
>>>>>>>         cond: CondVar,
>>>>>>> }
>>>>>>>
>>>>>>> impl ArcIntrusiveTimer {
>>>>>>>         fn new() -> impl PinInit<Self, kernel::error::Error> {
>>>>>>>             try_pin_init!(Self {
>>>>>>>                 timer <- Timer::new(),
>>>>>>>                 flag <- new_spinlock_irq!(0),
>>>>>>>                 cond <- new_condvar!(),
>>>>>>>             })
>>>>>>>         }
>>>>>>> }
>>>>>>>
>>>>>>> impl TimerCallback for ArcIntrusiveTimer {
>>>>>>>         type CallbackTarget<'a> = Arc<Self>;
>>>>>>>         type CallbackTargetParameter<'a> = ArcBorrow<'a, Self>;
>>>>>>>
>>>>>>>         fn run(this: Self::CallbackTargetParameter<'_>, irq: IrqDisabled<'_>) -> TimerRestart {
>>>>>>>             pr_info!("Timer called\n");
>>>>>>>             let mut guard = this.flag.lock_with(irq);
>>>>>>>             *guard += 1;
>>>>>>>             this.cond.notify_all();
>>>>>>>             if *guard == 5 {
>>>>>>>                 TimerRestart::NoRestart
>>>>>>>             }
>>>>>>>             else {
>>>>>>>                 TimerRestart::Restart
>>>>>>>
>>>>>>>             }
>>>>>>>         }
>>>>>>> }
>>>>>>>
>>>>>>> impl_has_timer! {
>>>>>>>         impl HasTimer<Self> for ArcIntrusiveTimer { self.timer }
>>>>>>> }
>>>>>>>
>>>>>>>
>>>>>>> let has_timer = Arc::pin_init(ArcIntrusiveTimer::new(), GFP_KERNEL)?;
>>>>>>> let _handle = has_timer.clone().schedule(Ktime::from_ns(200_000_000));
>>>>>>>
>>>>>>> kernel::irq::with_irqs_disabled(|irq| {
>>>>>>>       let mut guard = has_timer.flag.lock_with(irq);
>>>>>>>
>>>>>>>       while *guard != 5 {
>>>>>>>           pr_info!("Not 5 yet, waiting\n");
>>>>>>>           has_timer.cond.wait(&mut guard); // <-- we arrive back here with interrupts enabled!
>>>>>>>       }
>>>>>>> });
>>>>>>> ```
>>>>>>>
>>>>>>> I think an update of `CondVar::wait` should be part of the patch set [1].
>>>>>>>
>>>>>>>
>>>>>>> Best regards,
>>>>>>> Andreas
>>>>>>>
>>>>>>>
>>>>>>> [1] https://lore.kernel.org/rust-for-linux/20240916213025.477225-1-lyude@redhat.com/
>>>>>>>
>>>>>>>
>>>>>>
>>>>
>>
>>


