Return-Path: <linux-kernel+bounces-362097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5625E99B10E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B97F9B225BB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 05:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9B3136E0E;
	Sat, 12 Oct 2024 05:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMdNUd9f"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF2118E0E;
	Sat, 12 Oct 2024 05:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728710386; cv=none; b=CYQWgDNNLSz0QLsZuft3ndt/NYUA/a0TFOHATe9VCO2+EbycPUJ1GQMucoHSpSWsk3e0taissX1tigALr/xeWIPs0A/vlaFSXjsIa9+pHE3ea0ZBmVi3QLvRzvk+geubOMul05bxY/lgn5uKuF/SsW5wzQ+HS4P/ro46E7Q/wrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728710386; c=relaxed/simple;
	bh=kUHQwroq/snC6ThTHXwFoppK3Mmm9bxAiXqHFdRSqUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqAFWsCAUEfQYgSJbiEbIrNmF2xrfnK0TfgQhNHhcmPbCzFCo61vyI/U1nEIrxuaa4GwZdmS533l1iyhMuECMFX+Qis5VMKUMqkScO07fYOL3jVC6wH4FcJ+HhyuWhHJdL/V4GcJJEaAzlkj/nZnd/hgWY95ptkc9NqQs/jqFw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMdNUd9f; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9968114422so383556366b.2;
        Fri, 11 Oct 2024 22:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728710383; x=1729315183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pxmMStYCBYwAl7LNeZl4VWQYQ7PRcYg5jNsV5Cp3jKg=;
        b=mMdNUd9fPteGidbzxfeHahXEJwCngTfdD9PMLEhtdGAMzaYngYTc2VUjie3x2G7OII
         eXZoDv8yh4NWE7Ec9R3cbSFA/OrOZN/zMTbIINgOdFa+Clch0Y+YUyoVTytifCzmwBG4
         seXcWmjsFHlWPHtLmG9mVGzqovjp5jM0SqKNz1za/Xc0D9TnwpEFFB4tnFQCCUrJ36vo
         btZpQkfs807slnjHG+5MCdciaEv6ixgi6LW1MW5e4VzMOvvQmOhI85KIo35cuaDPtYED
         utCv6OiqkCWQy1BvN1Ln0T+QzOgeQeE8dMOonBIOiRoUAhBcFw+k9K+/EM4KgDl4Denh
         etZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728710383; x=1729315183;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxmMStYCBYwAl7LNeZl4VWQYQ7PRcYg5jNsV5Cp3jKg=;
        b=uu9FC/140DRHSYyOLmxLHQdvoXVtqiga1Txw9fdK+VemUe9JcfJLDHEFtaVH4jqQ2y
         FW/7xm6G7nTg1e1NutYdnPiA7Jgk8xegufGRdsujw7q0GEbCv+Y+mDr78KOy1ZXcXNjr
         IPFUpMksGlMEiOsnfr//kJoWDZsO+ToAuAKRtYJMgNbC+6znRvJeNw6ZFqn0opL+lLVn
         JTFAQjsJludhC7/GxnQ9FGFnaQmxBVTT/Pehk/2UAowdY94DxwIzj0wPmNLW/Zluj0dJ
         xgHoQ8hYlW2YakdMqoQrFPml4+0Qyz7zsLiNSK+t0u/jzsxFRUOUrabpQwOHXn11WUbM
         02tg==
X-Forwarded-Encrypted: i=1; AJvYcCUhnst8Mu3vuYQR2ncr9mX5A+qylXcHz5JVRlbGunOhiSKrxOFw1h4QOL4j+U0qdzKMFk5I5XCyihMSE9e/qGE=@vger.kernel.org, AJvYcCVHplGTvS9YUD91Ce4B40Zae/vhliYwmgfyIYvkIJYzDdJNuP6IKzC4zMBymXRUlmpnIdnVIy/HsbyVl3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2W4sKCASmP46fsVYDSGUZWoOqaQMH7LnuFDv28BNLkgc90wWl
	bmXHzaZ4GKUF5I6Zx6Z/RVrxsy8lj2RI4Aexjz/LRCeDSEYLj4HW
X-Google-Smtp-Source: AGHT+IEhdoBjlBK1FLRy0wx6nyRWPilntgKu1aMmLxEKZeK4mKtZpIO9gJjJEj7Bcu6+olB7lyVWnw==
X-Received: by 2002:a17:907:d2a:b0:a99:442e:34ac with SMTP id a640c23a62f3a-a99b95bc0c6mr466624266b.40.1728710383070;
        Fri, 11 Oct 2024 22:19:43 -0700 (PDT)
Received: from ?IPV6:2003:df:bf0d:b400:7350:36ae:6e0c:c598? (p200300dfbf0db400735036ae6e0cc598.dip0.t-ipconnect.de. [2003:df:bf0d:b400:7350:36ae:6e0c:c598])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80dcf0dsm286570666b.175.2024.10.11.22.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 22:19:42 -0700 (PDT)
Message-ID: <d2ce38a3-9a32-4f4c-88f2-22864b66afe5@gmail.com>
Date: Sat, 12 Oct 2024 07:19:41 +0200
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
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <Zwmy-2Yc7vGboYvl@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.10.24 01:21, Boqun Feng wrote:
> On Fri, Oct 11, 2024 at 05:43:57PM +0200, Dirk Behme wrote:
>> Hi Andreas,
>>
>> Am 11.10.24 um 16:52 schrieb Andreas Hindborg:
>>>
>>> Dirk, thanks for reporting!
>>
>> :)
>>
>>> Boqun Feng <boqun.feng@gmail.com> writes:
>>>
>>>> On Tue, Oct 01, 2024 at 02:37:46PM +0200, Dirk Behme wrote:
>>>>> On 18.09.2024 00:27, Andreas Hindborg wrote:
>>>>>> Hi!
>>>>>>
>>>>>> This series adds support for using the `hrtimer` subsystem from Rust code.
>>>>>>
>>>>>> I tried breaking up the code in some smaller patches, hopefully that will
>>>>>> ease the review process a bit.
>>>>>
>>>>> Just fyi, having all 14 patches applied I get [1] on the first (doctest)
>>>>> Example from hrtimer.rs.
>>>>>
>>>>> This is from lockdep:
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/locking/lockdep.c#n4785
>>>>>
>>>>> Having just a quick look I'm not sure what the root cause is. Maybe mutex in
>>>>> interrupt context? Or a more subtle one?
>>>>
>>>> I think it's calling mutex inside an interrupt context as shown by the
>>>> callstack:
>>>>
>>>> ]  __mutex_lock+0xa0/0xa4
>>>> ] ...
>>>> ]  hrtimer_interrupt+0x1d4/0x2ac
>>>>
>>>> , it is because:
>>>>
>>>> +//! struct ArcIntrusiveTimer {
>>>> +//!     #[pin]
>>>> +//!     timer: Timer<Self>,
>>>> +//!     #[pin]
>>>> +//!     flag: Mutex<bool>,
>>>> +//!     #[pin]
>>>> +//!     cond: CondVar,
>>>> +//! }
>>>>
>>>> has a Mutex<bool>, which actually should be a SpinLockIrq [1]. Note that
>>>> irq-off is needed for the lock, because otherwise we will hit a self
>>>> deadlock due to interrupts:
>>>>
>>>> 	spin_lock(&a);
>>>> 	> timer interrupt
>>>> 	  spin_lock(&a);
>>>>
>>>> Also notice that the IrqDisabled<'_> token can be simply created by
>>>> ::new(), because irq contexts should guarantee interrupt disabled (i.e.
>>>> we don't support nested interrupts*).
>>>
>>> I updated the example based on the work in [1]. I think we need to
>>> update `CondVar::wait` to support waiting with irq disabled.
>>
>> Yes, I agree. This answers one of the open questions I had in the discussion
>> with Boqun :)
>>
>> What do you think regarding the other open question: In this *special* case
>> here, what do you think to go *without* any lock? I mean the 'while *guard
>> != 5' loop in the main thread is read only regarding guard. So it doesn't
>> matter if it *reads* the old or the new value. And the read/modify/write of
>> guard in the callback is done with interrupts disabled anyhow as it runs in
>> interrupt context. And with this can't be interrupted (excluding nested
>> interrupts). So this modification of guard doesn't need to be protected from
>> being interrupted by a lock if there is no modifcation of guard "outside"
>> the interupt locked context.
>>
>> What do you think?
>>
> 
> Reading while there is another CPU is writing is data-race, which is UB.

Could you help to understand where exactly you see UB in Andreas' 
'while *guard != 5' loop in case no locking is used? As mentioned I'm 
under the impression that it doesn't matter if the old or new guard 
value is read in this special case.

Best regards

Dirk


> Regards,
> Boqun
> 
>> Thanks
>>
>> Dirk
>>
>>
>>> Without
>>> this, when we get back from `bindings::schedule_timeout` in
>>> `CondVar::wait_internal`, interrupts are enabled:
>>>
>>> ```rust
>>> use kernel::{
>>>       hrtimer::{Timer, TimerCallback, TimerPointer, TimerRestart},
>>>       impl_has_timer, new_condvar, new_spinlock, new_spinlock_irq,
>>>       irq::IrqDisabled,
>>>       prelude::*,
>>>       sync::{Arc, ArcBorrow, CondVar, SpinLock, SpinLockIrq},
>>>       time::Ktime,
>>> };
>>>
>>> #[pin_data]
>>> struct ArcIntrusiveTimer {
>>>       #[pin]
>>>       timer: Timer<Self>,
>>>       #[pin]
>>>       flag: SpinLockIrq<u64>,
>>>       #[pin]
>>>       cond: CondVar,
>>> }
>>>
>>> impl ArcIntrusiveTimer {
>>>       fn new() -> impl PinInit<Self, kernel::error::Error> {
>>>           try_pin_init!(Self {
>>>               timer <- Timer::new(),
>>>               flag <- new_spinlock_irq!(0),
>>>               cond <- new_condvar!(),
>>>           })
>>>       }
>>> }
>>>
>>> impl TimerCallback for ArcIntrusiveTimer {
>>>       type CallbackTarget<'a> = Arc<Self>;
>>>       type CallbackTargetParameter<'a> = ArcBorrow<'a, Self>;
>>>
>>>       fn run(this: Self::CallbackTargetParameter<'_>, irq: IrqDisabled<'_>) -> TimerRestart {
>>>           pr_info!("Timer called\n");
>>>           let mut guard = this.flag.lock_with(irq);
>>>           *guard += 1;
>>>           this.cond.notify_all();
>>>           if *guard == 5 {
>>>               TimerRestart::NoRestart
>>>           }
>>>           else {
>>>               TimerRestart::Restart
>>>
>>>           }
>>>       }
>>> }
>>>
>>> impl_has_timer! {
>>>       impl HasTimer<Self> for ArcIntrusiveTimer { self.timer }
>>> }
>>>
>>>
>>> let has_timer = Arc::pin_init(ArcIntrusiveTimer::new(), GFP_KERNEL)?;
>>> let _handle = has_timer.clone().schedule(Ktime::from_ns(200_000_000));
>>>
>>> kernel::irq::with_irqs_disabled(|irq| {
>>>     let mut guard = has_timer.flag.lock_with(irq);
>>>
>>>     while *guard != 5 {
>>>         pr_info!("Not 5 yet, waiting\n");
>>>         has_timer.cond.wait(&mut guard); // <-- we arrive back here with interrupts enabled!
>>>     }
>>> });
>>> ```
>>>
>>> I think an update of `CondVar::wait` should be part of the patch set [1].
>>>
>>>
>>> Best regards,
>>> Andreas
>>>
>>>
>>> [1] https://lore.kernel.org/rust-for-linux/20240916213025.477225-1-lyude@redhat.com/
>>>
>>>
>>


