Return-Path: <linux-kernel+bounces-362173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5799299B1CD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0CCFB2263B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB10813DDA7;
	Sat, 12 Oct 2024 07:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gju6jWV+"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E3B12C52E;
	Sat, 12 Oct 2024 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728719406; cv=none; b=Q5+faOkUc90nKAUzgYLKyEUBYtRz6C9Y/+rlKl+4kGaJ9QBhtGcyuHcQMsIWRBFG0bbetOCSaEA6rAlF1lEdS9RMguXfDIWohiB6K5s2GBa0yxPFTu88reV8VpTV7557+Uq3Qz6LHflasXtq6YqyPixSEuWrfTCDSQ4pmUYlQ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728719406; c=relaxed/simple;
	bh=m0RK2Y63Fik4pTT6QRSuvf56olSTgwIsAOwFKfFYoxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ThAh0lO5P/3vo0u1Ggc3MqJfSvg+fUJoy5yRcmx/C7YWf1g40cLKxEpHl+JQ2XXds1IEvNz5+20uVu2EXCODxAAvXU4A4ZC2+x6NZ0GK5GDrtBUw+xla8UUq3Dd9xEd1YJtoSd0BTcZ27V+L4UD+v0jSZVnkJ09Dr6Pp45cIQ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gju6jWV+; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso12636566b.3;
        Sat, 12 Oct 2024 00:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728719402; x=1729324202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W8n++CZRas/ALKX4dUuYD9pZqtX4XFmzN1y6WQvxpNg=;
        b=gju6jWV+7NgENv8HweM/lKZUoddWb0zeIbq23k1here1f+RoJI97uF9LWi9DLFS7WN
         ZEWGNygKvt3u1Y2OMPZG73Vd4AtML3GZkqzBXp6+DFTR5cjSO3ire0k+O9xiPpQrcu8U
         rbZh7P7k9C6BluLu8YWCoYCa4kbVoRACTad326QW3mCJo4fJnlCcywBYq3/l/6ADCoeu
         tnKia+gNIhi6ECtKi6/7k10WmH7h/Ub3PteHUonpOLX+dLQG1r3JGgvNOg9h/Mrt5CM9
         NTY6PcW9bQ8yzEa5uOti9pjrGYAqBT1r3uzoaAJfVOtx+ctuxj7EzGz1o5A5kwvchbDB
         nopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728719402; x=1729324202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W8n++CZRas/ALKX4dUuYD9pZqtX4XFmzN1y6WQvxpNg=;
        b=FIbYkdrskRYJ63PEhHosZ3C+Id8VV8J/bfh6ITHNXoiNLqx+icjo3fhpNnAB1sKeJo
         2PNMHQjnf/CcoW/9CLBaXIdVbnD38aqs2YSFqp0NTIZBcgc32JMPAdQaWrbCKQmx3mTr
         uPzGV6IBja2NwB5hIHqrMaxUi4sIqi+b2zbAY0WAOqQnxITSWMSdXhIs1eV/LRQee7zK
         T8ksaD3BFWlest+2D8xDAFJlWZmjMMJH2c4D66BZrCzlIu+mhUKCA4eXbIxb4YPVCXQI
         h9tLNInmmO3AqBB4CFGiHc2/uBKy6wkAL1fLyzn1DrAKIxuBnsjc4yuaesILZuzKnzHj
         8d1A==
X-Forwarded-Encrypted: i=1; AJvYcCUoGbe1zM3nxnYo2/PV2INtKYWqCZ5rm66bTxWmY7INLi0mhqqDwYBWnnFWaykb1DbFw+OK7iBYpFyscpy3oo4=@vger.kernel.org, AJvYcCX6CQWL7BOCGCyuQb6wcTt6XMCZ2OzRqNA9iKff+wHJdJHxsot3LRYYqPKSB1IQ1+GUDwkIlVYLgHv/PAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YztSq4cz3RW7RpcOVj/Wk9vXIPivmUgMSOk1XXhvDUFY6brW6rT
	30PCk53VeCqpNDVboZqs7RTBiaESVwspf4/b1arPm+abyF/hRsZx
X-Google-Smtp-Source: AGHT+IGeP3q3kDeOHeyOFTlCwmKmtvmNxJmHZ/n8C56BSOIZNUMjAwxpGLOnW26zz3n0D4oK1JU7+A==
X-Received: by 2002:a17:907:6ea2:b0:a99:e600:7e06 with SMTP id a640c23a62f3a-a99e6007f6amr143531966b.51.1728719402097;
        Sat, 12 Oct 2024 00:50:02 -0700 (PDT)
Received: from ?IPV6:2003:df:bf0d:b400:7350:36ae:6e0c:c598? (p200300dfbf0db400735036ae6e0cc598.dip0.t-ipconnect.de. [2003:df:bf0d:b400:7350:36ae:6e0c:c598])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99f3ed51e8sm15282566b.30.2024.10.12.00.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 00:50:01 -0700 (PDT)
Message-ID: <4dd93603-04fa-4da4-b867-bd12ece4b391@gmail.com>
Date: Sat, 12 Oct 2024 09:50:00 +0200
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
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <ZwooHrqIiirl1so7@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.10.24 09:41, Boqun Feng wrote:
> On Sat, Oct 12, 2024 at 07:19:41AM +0200, Dirk Behme wrote:
>> On 12.10.24 01:21, Boqun Feng wrote:
>>> On Fri, Oct 11, 2024 at 05:43:57PM +0200, Dirk Behme wrote:
>>>> Hi Andreas,
>>>>
>>>> Am 11.10.24 um 16:52 schrieb Andreas Hindborg:
>>>>>
>>>>> Dirk, thanks for reporting!
>>>>
>>>> :)
>>>>
>>>>> Boqun Feng <boqun.feng@gmail.com> writes:
>>>>>
>>>>>> On Tue, Oct 01, 2024 at 02:37:46PM +0200, Dirk Behme wrote:
>>>>>>> On 18.09.2024 00:27, Andreas Hindborg wrote:
>>>>>>>> Hi!
>>>>>>>>
>>>>>>>> This series adds support for using the `hrtimer` subsystem from Rust code.
>>>>>>>>
>>>>>>>> I tried breaking up the code in some smaller patches, hopefully that will
>>>>>>>> ease the review process a bit.
>>>>>>>
>>>>>>> Just fyi, having all 14 patches applied I get [1] on the first (doctest)
>>>>>>> Example from hrtimer.rs.
>>>>>>>
>>>>>>> This is from lockdep:
>>>>>>>
>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/locking/lockdep.c#n4785
>>>>>>>
>>>>>>> Having just a quick look I'm not sure what the root cause is. Maybe mutex in
>>>>>>> interrupt context? Or a more subtle one?
>>>>>>
>>>>>> I think it's calling mutex inside an interrupt context as shown by the
>>>>>> callstack:
>>>>>>
>>>>>> ]  __mutex_lock+0xa0/0xa4
>>>>>> ] ...
>>>>>> ]  hrtimer_interrupt+0x1d4/0x2ac
>>>>>>
>>>>>> , it is because:
>>>>>>
>>>>>> +//! struct ArcIntrusiveTimer {
>>>>>> +//!     #[pin]
>>>>>> +//!     timer: Timer<Self>,
>>>>>> +//!     #[pin]
>>>>>> +//!     flag: Mutex<bool>,
>>>>>> +//!     #[pin]
>>>>>> +//!     cond: CondVar,
>>>>>> +//! }
>>>>>>
>>>>>> has a Mutex<bool>, which actually should be a SpinLockIrq [1]. Note that
>>>>>> irq-off is needed for the lock, because otherwise we will hit a self
>>>>>> deadlock due to interrupts:
>>>>>>
>>>>>> 	spin_lock(&a);
>>>>>> 	> timer interrupt
>>>>>> 	  spin_lock(&a);
>>>>>>
>>>>>> Also notice that the IrqDisabled<'_> token can be simply created by
>>>>>> ::new(), because irq contexts should guarantee interrupt disabled (i.e.
>>>>>> we don't support nested interrupts*).
>>>>>
>>>>> I updated the example based on the work in [1]. I think we need to
>>>>> update `CondVar::wait` to support waiting with irq disabled.
>>>>
>>>> Yes, I agree. This answers one of the open questions I had in the discussion
>>>> with Boqun :)
>>>>
>>>> What do you think regarding the other open question: In this *special* case
>>>> here, what do you think to go *without* any lock? I mean the 'while *guard
>>>> != 5' loop in the main thread is read only regarding guard. So it doesn't
>>>> matter if it *reads* the old or the new value. And the read/modify/write of
>>>> guard in the callback is done with interrupts disabled anyhow as it runs in
>>>> interrupt context. And with this can't be interrupted (excluding nested
>>>> interrupts). So this modification of guard doesn't need to be protected from
>>>> being interrupted by a lock if there is no modifcation of guard "outside"
>>>> the interupt locked context.
>>>>
>>>> What do you think?
>>>>
>>>
>>> Reading while there is another CPU is writing is data-race, which is UB.
>>
>> Could you help to understand where exactly you see UB in Andreas' 'while
>> *guard != 5' loop in case no locking is used? As mentioned I'm under the
> 
> Sure, but could you provide the code of what you mean exactly, if you
> don't use a lock here, you cannot have a guard. I need to the exact code
> to point out where the compiler may "mis-compile" (a result of being
> UB).


I thought we are talking about anything like

#[pin_data]
struct ArcIntrusiveTimer {
       #[pin]
       timer: Timer<Self>,
       #[pin]
-      flag: SpinLockIrq<u64>,
+      flag: u64,
       #[pin]
       cond: CondVar,
}

?

Best regards

Dirk

>> impression that it doesn't matter if the old or new guard value is read in
>> this special case.
>>
> 
> For one thing, if the compiler believes no one is accessing the value
> because the code uses an immutable reference, it can "optimize" the loop
> away:
> 
> 	while *var != 5 {
> 	    do_something();
> 	}
> 
> into
> 	
> 	if *var != 5 {
> 	    loop { do_something(); }
> 	}
> 
> But as I said, I need to see the exact code to suggest a relevant
> mis-compile, and note that sometimes, even mis-compile seems impossible
> at the moment, a UB is a UB, compilers are free to do anything they
> want (or don't want). So "mis-compile" is only helping we understand the
> potential result of a UB.
> 
> Regards,
> Boqun
> 
>> Best regards
>>
>> Dirk
>>
>>
>>> Regards,
>>> Boqun
>>>
>>>> Thanks
>>>>
>>>> Dirk
>>>>
>>>>
>>>>> Without
>>>>> this, when we get back from `bindings::schedule_timeout` in
>>>>> `CondVar::wait_internal`, interrupts are enabled:
>>>>>
>>>>> ```rust
>>>>> use kernel::{
>>>>>        hrtimer::{Timer, TimerCallback, TimerPointer, TimerRestart},
>>>>>        impl_has_timer, new_condvar, new_spinlock, new_spinlock_irq,
>>>>>        irq::IrqDisabled,
>>>>>        prelude::*,
>>>>>        sync::{Arc, ArcBorrow, CondVar, SpinLock, SpinLockIrq},
>>>>>        time::Ktime,
>>>>> };
>>>>>
>>>>> #[pin_data]
>>>>> struct ArcIntrusiveTimer {
>>>>>        #[pin]
>>>>>        timer: Timer<Self>,
>>>>>        #[pin]
>>>>>        flag: SpinLockIrq<u64>,
>>>>>        #[pin]
>>>>>        cond: CondVar,
>>>>> }
>>>>>
>>>>> impl ArcIntrusiveTimer {
>>>>>        fn new() -> impl PinInit<Self, kernel::error::Error> {
>>>>>            try_pin_init!(Self {
>>>>>                timer <- Timer::new(),
>>>>>                flag <- new_spinlock_irq!(0),
>>>>>                cond <- new_condvar!(),
>>>>>            })
>>>>>        }
>>>>> }
>>>>>
>>>>> impl TimerCallback for ArcIntrusiveTimer {
>>>>>        type CallbackTarget<'a> = Arc<Self>;
>>>>>        type CallbackTargetParameter<'a> = ArcBorrow<'a, Self>;
>>>>>
>>>>>        fn run(this: Self::CallbackTargetParameter<'_>, irq: IrqDisabled<'_>) -> TimerRestart {
>>>>>            pr_info!("Timer called\n");
>>>>>            let mut guard = this.flag.lock_with(irq);
>>>>>            *guard += 1;
>>>>>            this.cond.notify_all();
>>>>>            if *guard == 5 {
>>>>>                TimerRestart::NoRestart
>>>>>            }
>>>>>            else {
>>>>>                TimerRestart::Restart
>>>>>
>>>>>            }
>>>>>        }
>>>>> }
>>>>>
>>>>> impl_has_timer! {
>>>>>        impl HasTimer<Self> for ArcIntrusiveTimer { self.timer }
>>>>> }
>>>>>
>>>>>
>>>>> let has_timer = Arc::pin_init(ArcIntrusiveTimer::new(), GFP_KERNEL)?;
>>>>> let _handle = has_timer.clone().schedule(Ktime::from_ns(200_000_000));
>>>>>
>>>>> kernel::irq::with_irqs_disabled(|irq| {
>>>>>      let mut guard = has_timer.flag.lock_with(irq);
>>>>>
>>>>>      while *guard != 5 {
>>>>>          pr_info!("Not 5 yet, waiting\n");
>>>>>          has_timer.cond.wait(&mut guard); // <-- we arrive back here with interrupts enabled!
>>>>>      }
>>>>> });
>>>>> ```
>>>>>
>>>>> I think an update of `CondVar::wait` should be part of the patch set [1].
>>>>>
>>>>>
>>>>> Best regards,
>>>>> Andreas
>>>>>
>>>>>
>>>>> [1] https://lore.kernel.org/rust-for-linux/20240916213025.477225-1-lyude@redhat.com/
>>>>>
>>>>>
>>>>
>>


