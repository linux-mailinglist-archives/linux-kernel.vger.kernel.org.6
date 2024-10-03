Return-Path: <linux-kernel+bounces-348734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3686C98EB2A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6298A1C227C2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9525713A869;
	Thu,  3 Oct 2024 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzB8eMo5"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB8179B8E;
	Thu,  3 Oct 2024 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727943262; cv=none; b=kwdFPkBqmCzeiyfDvc2LCLOYA39BKSIXe2h36ORKlkAvTZSst794uA6v5fc9IBuGsk78bJAS90e3zAkuj7+WFREYZAhd9xnmstBCFjabdw+HoQq78rWd6et2PyqNQDeL6OInWJThV/DmCCeKOGgC1zc2lN+vl108YQTUiceRlpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727943262; c=relaxed/simple;
	bh=MI2C6mIp/cSvQX+odh4VG2PeEwAWjsXXdnMmaR3iYSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L76aQ+OgFIooiGBkRG2MvsrAcq2OgZE67ATVJ9+so1xBCFPcdv93wb+iF/BmYFzmm+qb8v9qx5XoCIVVQisxmJtE/DivDD8XOxsN2muNx2p1z/DuhMbqPHKKJMd9Y9/KwjovMdbXaLD6DQA6jUYXCqb2+dr+prmrUaNQMaRtE88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzB8eMo5; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso89541166b.3;
        Thu, 03 Oct 2024 01:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727943259; x=1728548059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fnG75PdTGr90aZOu/IntPX6a41sRWP19HOmtpdEwRf4=;
        b=MzB8eMo5wL8NuKyfOB0SYeRp1keVkmjYJdpZ4fwCiP9rpF28/Ac3DcVJb3KdolDbIG
         rDoMFT+5D4NfXkDnJEzJreNsegAVeY9O14+wg/R8qqyMNtyhlBTa/QwKWsBxGvn5lnya
         YdT6DoBU+7VYE8w1TcLgx9SJS9bxNC30KsRVoh0Yh9NGdo+o6ZdJ8wpAxx5Ok+Rq40jk
         s95MIp8u8EkefVkjmU6ExcReQIo3kgqT4+Rw7hfOt/Au/+I5FLu4gZKT+tneWrbDAlaT
         PzC7mB+/49fCXva3GzEApCOFUkbsaEGPU19JoML7rJ5xVpFwcQRUXmeGFXUfBRjN4YPj
         adyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727943259; x=1728548059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fnG75PdTGr90aZOu/IntPX6a41sRWP19HOmtpdEwRf4=;
        b=orXKbkaI3XS62KTWhWY0iszC7pcwOnG+KFfrEHUgmpuDh5hOQ1OApgs58m6tcYnUX8
         BI1KbZHIM2D6EKsBgj0iFN/exH55ISsIaU5nqPwReMoZyIRhnjK0W5Lsy8G1avD2eYN7
         U3EAC1bZnMcAQO7Z45VppqGwoRl4+12DGsCtXTQB6ukSbimSfDNsCP02E8kfNHhIVPcu
         rW7rmqGpuiEb0M24XyN1f1kXkegWWNTf/5efYngrBADiowkoR7DC3XqAE13oOQLMz13e
         zMsxp9q/EVrwsarOviLgzM3oieCEZ/CPto717mW2I5LEu4IiBBFiUk6Zu2WAqMfbzKPy
         Quow==
X-Forwarded-Encrypted: i=1; AJvYcCWEDoULSoVAhd9cmc0U1WRPI0lDhrWa9+PqLzaE/G5tcf+GPNm24WT7Y1vIz9dgWW0mkdANXnZYcP8/Ug+ohzU=@vger.kernel.org, AJvYcCXBTskMbBOLkj/+w749yDN5gJhnVyVqtsa5BW9uHNGHQIyEa+cT3tRZ6SnqInAp8mQvX2EW5RROcvuIQxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYsZHIr3NsCYyGMpU1tSTsM36/kCQtvmOLa1I1p3g1poW4omzX
	M/HCQOGfYsa2V4hNMrdisnNWOVELvEsFWFSvzXoIZ0gmLSwxFmbp
X-Google-Smtp-Source: AGHT+IHjCeOxyJl961FXaO56NAFwm1MP+kB2d6LSN3P4OkLrcVwOV+qm9u+CKz9fD7LroT9tFHJGcQ==
X-Received: by 2002:a17:906:99c5:b0:a7a:acae:3415 with SMTP id a640c23a62f3a-a98f82133admr461600966b.10.1727943259158;
        Thu, 03 Oct 2024 01:14:19 -0700 (PDT)
Received: from ?IPV6:2003:df:bf2f:2200:b91b:c640:bc7f:cabd? (p200300dfbf2f2200b91bc640bc7fcabd.dip0.t-ipconnect.de. [2003:df:bf2f:2200:b91b:c640:bc7f:cabd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99102a8e13sm49584966b.90.2024.10.03.01.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 01:14:18 -0700 (PDT)
Message-ID: <b129cddc-862a-472b-b52a-2457b1a02d45@gmail.com>
Date: Thu, 3 Oct 2024 10:14:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] hrtimer Rust API
To: Boqun Feng <boqun.feng@gmail.com>, Dirk Behme <dirk.behme@de.bosch.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
 <e644aec7-02b3-4faf-9a80-629055c5a27a@de.bosch.com>
 <ZvwKTinnLckZm8aQ@boqun-archlinux>
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <ZvwKTinnLckZm8aQ@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 01.10.24 um 16:42 schrieb Boqun Feng:
> On Tue, Oct 01, 2024 at 02:37:46PM +0200, Dirk Behme wrote:
>> On 18.09.2024 00:27, Andreas Hindborg wrote:
>>> Hi!
>>>
>>> This series adds support for using the `hrtimer` subsystem from Rust code.
>>>
>>> I tried breaking up the code in some smaller patches, hopefully that will
>>> ease the review process a bit.
>>
>> Just fyi, having all 14 patches applied I get [1] on the first (doctest)
>> Example from hrtimer.rs.
>>
>> This is from lockdep:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/locking/lockdep.c#n4785
>>
>> Having just a quick look I'm not sure what the root cause is. Maybe mutex in
>> interrupt context? Or a more subtle one?
> 
> I think it's calling mutex inside an interrupt context as shown by the
> callstack:
> 
> ]  __mutex_lock+0xa0/0xa4
> ] ...
> ]  hrtimer_interrupt+0x1d4/0x2ac
> 
> , it is because:
> 
> +//! struct ArcIntrusiveTimer {
> +//!     #[pin]
> +//!     timer: Timer<Self>,
> +//!     #[pin]
> +//!     flag: Mutex<bool>,
> +//!     #[pin]
> +//!     cond: CondVar,
> +//! }
> 
> has a Mutex<bool>, which actually should be a SpinLockIrq [1]. 


Two understanding questions:

1. In the main thread (full example for reference below [2]) where is 
the lock released? After the while loop? I.e. is the lock held until 
guard reaches 5?

let mut guard = has_timer.flag.lock();   // <= lock taken here?

while *guard != 5 {
      has_timer.cond.wait(&mut guard);
}                                                           // <= lock 
released here?

I wonder what this would mean for the interrupt TimerCallback in case 
we would use an irq-off SpinLock instead here?

Or maybe:

2. The only place where the guard is modified (*guard += 1;) is in the 
TimerCallback which runs in interrupt context as we learned. With that 
writing the guard value can't be interrupted. Couldn't we drop the 
whole lock, then?

Best regards

Dirk


[2]

//! #[pin_data]
//! struct ArcIntrusiveTimer {
//!     #[pin]
//!     timer: Timer<Self>,
//!     #[pin]
//!     flag: Mutex<u64>,
//!     #[pin]
//!     cond: CondVar,
//! }
//!
//! impl ArcIntrusiveTimer {
//!     fn new() -> impl PinInit<Self, kernel::error::Error> {
//!         try_pin_init!(Self {
//!             timer <- Timer::new(),
//!             flag <- new_mutex!(0),
//!             cond <- new_condvar!(),
//!         })
//!     }
//! }
//!
//! impl TimerCallback for ArcIntrusiveTimer {
//!     type CallbackTarget<'a> = Arc<Self>;
//!     type CallbackPointer<'a> = Arc<Self>;
//!
//!     fn run(this: Self::CallbackTarget<'_>) -> TimerRestart {
//!         pr_info!("Timer called\n");
//!         let mut guard = this.flag.lock();
//!         *guard += 1;
//!         this.cond.notify_all();
//!         if *guard == 5 {
//!             TimerRestart::NoRestart
//!         }
//!         else {
//!             TimerRestart::Restart
//!
//!         }
//!     }
//! }
//!
//! impl_has_timer! {
//!     impl HasTimer<Self> for ArcIntrusiveTimer { self.timer }
//! }
//!
//!
//! let has_timer = Arc::pin_init(ArcIntrusiveTimer::new(), GFP_KERNEL)?;
//! let _handle = has_timer.clone().schedule(Ktime::from_ns(200_000_000));
//! let mut guard = has_timer.flag.lock();
//!
//! while *guard != 5 {
//!     has_timer.cond.wait(&mut guard);
//! }
//!
//! pr_info!("Counted to 5\n");
//! # Ok::<(), kernel::error::Error>(())




> Note that
> irq-off is needed for the lock, because otherwise we will hit a self
> deadlock due to interrupts:
> 
> 	spin_lock(&a);
> 	> timer interrupt
> 	  spin_lock(&a);
> 
> Also notice that the IrqDisabled<'_> token can be simply created by
> ::new(), because irq contexts should guarantee interrupt disabled (i.e.
> we don't support nested interrupts*).
> 
> [*]: I vaguely remember we still have some driver code for slow devices
> that will enable interrupts during an irq handler, but these are going
> to be gone, we shouldn't really care about this in Rust code.
> 
> Regards,
> Boqun
> 
> [1]: https://lore.kernel.org/rust-for-linux/20240916213025.477225-1-lyude@redhat.com/
> 
> 
>>
>> Best regards
>>
>> Dirk
>>
>> [1]
>>
>>      # rust_doctest_kernel_hrtimer_rs_0.location: rust/kernel/hrtimer.rs:10
>> rust_doctests_kernel: Timer called
>>
>> =============================
>> [ BUG: Invalid wait context ]
>> 6.11.0-rc1-arm64 #28 Tainted: G                 N
>> -----------------------------
>> swapper/5/0 is trying to lock:
>> ffff0004409ab900 (rust/doctests_kernel_generated.rs:1238){+.+.}-{3:3}, at:
>> rust_helper_mutex_lock+0x10/0x18
>> other info that might help us debug this:
>> context-{2:2}
>> no locks held by swapper/5/0.
>> stack backtrace:
>> CPU: 5 UID: 0 PID: 0 Comm: swapper/5 Tainted: G N 6.11.0-rc1-arm64 #28
>> Tainted: [N]=TEST
>> Hardware name: ARM64 based board (DT)
>> Call trace:
>>   $x.11+0x98/0xb4
>>   show_stack+0x14/0x1c
>>   $x.3+0x3c/0x94
>>   dump_stack+0x14/0x1c
>>   $x.205+0x538/0x594
>>   $x.179+0xd0/0x18c
>>   __mutex_lock+0xa0/0xa4
>>   mutex_lock_nested+0x20/0x28
>>   rust_helper_mutex_lock+0x10/0x18
>>
>> _RNvXs_NvNvNvCslTRHJHclVGW_25doctests_kernel_generated32rust_doctest_kernel_hrtimer_rs_04main41__doctest_main_rust_kernel_hrtimer_rs_10_0NtB4_17ArcIntrusiveTimerNtNtCsclYTRz49wqv_6kernel7hrtimer13TimerCallback3run+0x5c/0xd0
>>
>> _RNvXs1_NtNtCsclYTRz49wqv_6kernel7hrtimer3arcINtNtNtB9_4sync3arc3ArcNtNvNvNvCslTRHJHclVGW_25doctests_kernel_generated32rust_doctest_kernel_hrtimer_rs_04main41__doctest_main_rust_kernel_hrtimer_rs_10_017ArcIntrusiveTimerENtB7_16RawTimerCallback3runB1b_+0x20/0x2c
>>   $x.90+0x64/0x70
>>   hrtimer_interrupt+0x1d4/0x2ac
>>   arch_timer_handler_phys+0x34/0x40
>>   $x.62+0x50/0x54
>>   generic_handle_domain_irq+0x28/0x40
>>   $x.154+0x58/0x6c
>>   $x.471+0x10/0x20
>>   el1_interrupt+0x70/0x94
>>   el1h_64_irq_handler+0x14/0x1c
>>   el1h_64_irq+0x64/0x68
>>   arch_local_irq_enable+0x4/0x8
>>   cpuidle_enter+0x34/0x48
>>   $x.37+0x58/0xe4
>>   cpu_startup_entry+0x30/0x34
>>   $x.2+0xf8/0x118
>>   $x.13+0x0/0x4
>> rust_doctests_kernel: Timer called
>> rust_doctests_kernel: Timer called
>> rust_doctests_kernel: Timer called
>> rust_doctests_kernel: Timer called
>> rust_doctests_kernel: Counted to 5
>>      ok 22 rust_doctest_kernel_hrtimer_rs_0
>>      # rust_doctest_kernel_hrtimer_rs_1.location: rust/kernel/hrtimer.rs:137
>> rust_doctests_kernel: Hello from the future
>> rust_doctests_kernel: Flag raised
>>      ok 23 rust_doctest_kernel_hrtimer_rs_1
>>      # rust_doctest_kernel_hrtimer_rs_2.location: rust/kernel/hrtimer.rs:76
>> rust_doctests_kernel: Timer called
>> rust_doctests_kernel: Flag raised
>>      ok 24 rust_doctest_kernel_hrtimer_rs_2
> 


