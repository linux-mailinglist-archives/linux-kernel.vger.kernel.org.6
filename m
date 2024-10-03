Return-Path: <linux-kernel+bounces-349307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A40198F41D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1775E1F21D1C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5401A7244;
	Thu,  3 Oct 2024 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezt96Rq0"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582CD19F11F;
	Thu,  3 Oct 2024 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727972320; cv=none; b=YmMI0/bpwoTOxowUhCiG8MCCbwo3gLp7IjqncLzg4XamY4WyXXqnJOP3AHI5njl2M411htPX/J6UsLJfgdJo295OpzDSj+bkKfP3OaK7ni1WgTR+LXnIH6P1Dj5YG2wwXsyKl3IdNKVqpmjmwM/ywp4ITT12y8JuqOIzJC6ECOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727972320; c=relaxed/simple;
	bh=+TW1MQhhi44LlreD/bumvRzSsUzQ+d7UyWIDPpQv/e4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFnGYmrQPP8aVcFKZ/H4XPZsB75ZZXGNE11XTcPaiKTpMSpcbB5gwvcfpurp+kFM2FDTwK1TyKVOuWNyyEARODswaQf9FXyimVOJdt2gL84Hqa1xHaV7lBSgOcZLpC0VZmG/UNABjMrUTO7lftWH/RZQK3vJy/ut7W0fbuIYBsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezt96Rq0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d60e23b33so168113166b.0;
        Thu, 03 Oct 2024 09:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727972317; x=1728577117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AnV/QykSRvodk27nXQlvBUnckGrf7XmSXrVyXXYHZAM=;
        b=ezt96Rq0gqwZlRKuQaPAoU/wZietAJ1amwvl+3j1siSIfsMWvmr5VCdv+Gos86PScX
         5d3WgupjuSsDf6ICyg3xbYJhAoQLrUAFou9NA0lOv4WLeDfheqnKpSMBURJx64YkX1/0
         lUa5qg0KwDKx1lEs/nDepc3e+UugT0T2qcJewzJ4DmsTShoqyKOr4LZykdYgU9vIcJMA
         1rqk3jPKXYXHW5fiMYoJTIVBlWyXT5tgI207pKC60E0t+1WfKWxgyyXwIXebilY5LbwH
         V5SHcIS694wlSyZDMEfABUBF28oLhGtliGbdKbwZt0OvXNgt+8vOpM5RKHBtXIafz2u0
         e3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727972317; x=1728577117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AnV/QykSRvodk27nXQlvBUnckGrf7XmSXrVyXXYHZAM=;
        b=ckC/tkTFu5Gxt78B0lt9niG9QpJe0JnkMX+msaix7zyNjX8AFmOFl2Y3d+DJ8s3PxN
         ZWf8GYf8roSTwuCXvPkPbnZWuXJncXYww1Z5Az0sTMq7kqfmBTYJsmn1hCJ2AWLj5leC
         oAn5NBJY30knMkBfZKzqg7wfGf+OhBxuBZjcPQihStqdFBmE5yxAX2PM/H2j64Fds20O
         jiGg1OJchKnzHuOW8C+7NehxHV1XbUah9CKMGcFPXtkrFNVYON0mVq2z8fthOVAuCGGn
         z5AzcOIIu+1uHgJtolEtDEA+qJom1oGo9wftoMY6CA8CxqdPUAz3NQ1vGRkVeppmvhka
         DvNA==
X-Forwarded-Encrypted: i=1; AJvYcCVxKoIz9SqiLxov+OY3A6VYD97aRl4/ba/QpSzaHpPpwA9kUJvN53tb10Q9saHaFWI+zMQgJs1WauKPA+c6A6Q=@vger.kernel.org, AJvYcCWF3U/HX3gC93lTnW5HQtRQCssVvVVDfQpeNTIrWkhrzZBW0zVoiKu4kRNKoQaKghYZDOPnvp+aXDIS9qU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTnseC4uhHqhdlBNPGImcQC68nTMSRlGrHbX7OZfmoW0DroA0r
	v2r32ZRw+7A3GrCiOv3bataIMQubRqCUilhqqbbqhktUuFZBuqkT
X-Google-Smtp-Source: AGHT+IFKSXV8+4LFh+QnlERd37DUImc0QvUjqHw8FGAFE9drLMWNE1/Co0TrfDVtCJhyHkD8Pct33Q==
X-Received: by 2002:a17:906:f5aa:b0:a8d:42c3:5f68 with SMTP id a640c23a62f3a-a98f823906bmr619891366b.23.1727972316450;
        Thu, 03 Oct 2024 09:18:36 -0700 (PDT)
Received: from ?IPV6:2003:df:bf2f:2200:b91b:c640:bc7f:cabd? (p200300dfbf2f2200b91bc640bc7fcabd.dip0.t-ipconnect.de. [2003:df:bf2f:2200:b91b:c640:bc7f:cabd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a991028581esm103749966b.37.2024.10.03.09.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 09:18:36 -0700 (PDT)
Message-ID: <4f051c35-fb45-4f91-8daf-6ba53c8d4ab9@gmail.com>
Date: Thu, 3 Oct 2024 18:18:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] hrtimer Rust API
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
 <e644aec7-02b3-4faf-9a80-629055c5a27a@de.bosch.com>
 <ZvwKTinnLckZm8aQ@boqun-archlinux>
 <b129cddc-862a-472b-b52a-2457b1a02d45@gmail.com>
 <Zv6WDYZHikCCpUlB@boqun-archlinux>
Content-Language: en-US
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <Zv6WDYZHikCCpUlB@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 03.10.24 um 15:03 schrieb Boqun Feng:
> On Thu, Oct 03, 2024 at 10:14:17AM +0200, Dirk Behme wrote:
>> Am 01.10.24 um 16:42 schrieb Boqun Feng:
>>> On Tue, Oct 01, 2024 at 02:37:46PM +0200, Dirk Behme wrote:
>>>> On 18.09.2024 00:27, Andreas Hindborg wrote:
>>>>> Hi!
>>>>>
>>>>> This series adds support for using the `hrtimer` subsystem from Rust code.
>>>>>
>>>>> I tried breaking up the code in some smaller patches, hopefully that will
>>>>> ease the review process a bit.
>>>>
>>>> Just fyi, having all 14 patches applied I get [1] on the first (doctest)
>>>> Example from hrtimer.rs.
>>>>
>>>> This is from lockdep:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/locking/lockdep.c#n4785
>>>>
>>>> Having just a quick look I'm not sure what the root cause is. Maybe mutex in
>>>> interrupt context? Or a more subtle one?
>>>
>>> I think it's calling mutex inside an interrupt context as shown by the
>>> callstack:
>>>
>>> ]  __mutex_lock+0xa0/0xa4
>>> ] ...
>>> ]  hrtimer_interrupt+0x1d4/0x2ac
>>>
>>> , it is because:
>>>
>>> +//! struct ArcIntrusiveTimer {
>>> +//!     #[pin]
>>> +//!     timer: Timer<Self>,
>>> +//!     #[pin]
>>> +//!     flag: Mutex<bool>,
>>> +//!     #[pin]
>>> +//!     cond: CondVar,
>>> +//! }
>>>
>>> has a Mutex<bool>, which actually should be a SpinLockIrq [1].
>>
>>
>> Two understanding questions:
>>
> 
> Good questions. ;-)

:-)

>> 1. In the main thread (full example for reference below [2]) where is the
>> lock released? After the while loop? I.e. is the lock held until guard
> 
> With the current implementation, there are two places the lock will be
> released: 1) inside CondVar::wait() and


CondVar::wait() releases *and* reaquires, the lock then? So that 
outside of CondVar::wait() but inside the while() loop the lock is 
held until the while loop is exit?

Would that lock handling inside CondVar::wait() handle the irq stuff 
(irq enable and disable) of SpinLockIrq correctly, then?


> 2) after `guard` is eventually
> drop after the loop.
> 
>> reaches 5?
>>
>> let mut guard = has_timer.flag.lock();   // <= lock taken here?
>>
>> while *guard != 5 {
>>       has_timer.cond.wait(&mut guard);
>> }                                                           // <= lock
>> released here?
>>
>> I wonder what this would mean for the interrupt TimerCallback in case we
>> would use an irq-off SpinLock instead here?
>>
>> Or maybe:
>>
>> 2. The only place where the guard is modified (*guard += 1;) is in the
>> TimerCallback which runs in interrupt context as we learned. With that
>> writing the guard value can't be interrupted. Couldn't we drop the whole
>> lock, then?
>>
> 
> No, because the main thread can run on another CPU, so disabling
> interrupts (because of the interrupt handlers) doesn't mean exclusive
> access to value.

Yes. I agree if the main thread would write. But that main thread does 
read-only accesses, only? So it reads either the old or the new value, 
indepenent on the locking? Only the interrupt handler does 
read/modify/write. But thats protected by the interrupt context, already.

Dirk


>> Best regards
>>
>> Dirk
>>
>>
>> [2]
>>
>> //! #[pin_data]
>> //! struct ArcIntrusiveTimer {
>> //!     #[pin]
>> //!     timer: Timer<Self>,
>> //!     #[pin]
>> //!     flag: Mutex<u64>,
>> //!     #[pin]
>> //!     cond: CondVar,
>> //! }
>> //!
>> //! impl ArcIntrusiveTimer {
>> //!     fn new() -> impl PinInit<Self, kernel::error::Error> {
>> //!         try_pin_init!(Self {
>> //!             timer <- Timer::new(),
>> //!             flag <- new_mutex!(0),
>> //!             cond <- new_condvar!(),
>> //!         })
>> //!     }
>> //! }
>> //!
>> //! impl TimerCallback for ArcIntrusiveTimer {
>> //!     type CallbackTarget<'a> = Arc<Self>;
>> //!     type CallbackPointer<'a> = Arc<Self>;
>> //!
>> //!     fn run(this: Self::CallbackTarget<'_>) -> TimerRestart {
>> //!         pr_info!("Timer called\n");
>> //!         let mut guard = this.flag.lock();
>> //!         *guard += 1;
>> //!         this.cond.notify_all();
>> //!         if *guard == 5 {
>> //!             TimerRestart::NoRestart
>> //!         }
>> //!         else {
>> //!             TimerRestart::Restart
>> //!
>> //!         }
>> //!     }
>> //! }
>> //!
>> //! impl_has_timer! {
>> //!     impl HasTimer<Self> for ArcIntrusiveTimer { self.timer }
>> //! }
>> //!
>> //!
>> //! let has_timer = Arc::pin_init(ArcIntrusiveTimer::new(), GFP_KERNEL)?;
>> //! let _handle = has_timer.clone().schedule(Ktime::from_ns(200_000_000));
>> //! let mut guard = has_timer.flag.lock();
>> //!
>> //! while *guard != 5 {
>> //!     has_timer.cond.wait(&mut guard);
>> //! }
>> //!
>> //! pr_info!("Counted to 5\n");
>> //! # Ok::<(), kernel::error::Error>(())
>>
>>
>>
> [...]


