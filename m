Return-Path: <linux-kernel+bounces-372007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94B59A4331
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79852284D07
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8061202F67;
	Fri, 18 Oct 2024 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmArXFPd"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE61C200B90;
	Fri, 18 Oct 2024 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267561; cv=none; b=q/CXY/jZA+w1ual+9WGEx7kWdMCQLocB6izLE+GGdV6LLsiwcFCAkkYXBsxF+34U7dawYh5y2imXJxNC0FQFtFtDgFQfqWXbtnrS+t75V62mghpJSwTzmCNSAIsnDvjqqvfNVOUTQmncbL1zjoyH5S1LRYZjZje52hF0ugSFXkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267561; c=relaxed/simple;
	bh=71kHDRmY5IaZeFOC6xypg/vnGBvV16MEqznZY7H/UFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEiEw7pvFkv+PWQ4yeVPHVjXKWEMxGjTC2jesYTvGroJb/JHJiR97yV2rN+c08HNAAr6szhj/k2jxZbhgNdaPrSFeaGWIotIS1b25mPW0HeM/MwAi8HJvKz37U+MAKx86blXNQ7/pugKr3ml2NXWpiOnOLcHdKfNt2d47MC4/No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmArXFPd; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c99be0a4bbso3052190a12.2;
        Fri, 18 Oct 2024 09:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729267557; x=1729872357; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WiEydxIFcGvwbFyNwixtim9OVRuVpyy013HZe8yIIN0=;
        b=DmArXFPdSFZU0ZUglqHQasojlCHCBHa9uE/6Rd+Dl4eVwdl0wRSFXcGjaBBPHX87nu
         agiI7CBkV+B1OS8HtHxGB1CmP5TJsAVpyGJe91jVGzBOWsU3a/1p0MZHt/KXkf0WhZnG
         9Ds1GC0Za5plwSw49OtbjWhwaCEcvYKESfjNkkNZCnFmfaouwVT3lBLFO4DjAYXWUhPd
         mzhzyOeB0aAlsEAX+qaSdQx/uoXxGohzwJltPQAygHRg5Qpi/bytcYBJGRAG6DeEOeFr
         m2oKoSley6XCgHDNxLwfDKEukaM/b2l+kyqRcs221wT5NF6hldoXVtsETxarojpIIffZ
         uv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729267557; x=1729872357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WiEydxIFcGvwbFyNwixtim9OVRuVpyy013HZe8yIIN0=;
        b=IoghL947rsEZ29OODB5IOeoZYdS/4zKpI0d36fFmuROIYQfVw7ZdVfUtXrgmGr6xUv
         QHd/wgTYOXUYfHAmu5yMFYDqyM2c5HeG+bwKNUnx1oxDnYMtKP6M7XC3XhN8szdlyiT6
         jsWClzZGWDK4r5f+6AWZ6kWi3FI9Q+3pqtSUuDXUwNSSByNYDqsAFBlAejGBRHq/qkYk
         2cPn1DOmq9hsgXamWUr0aQImSpoYMKc1ajporDwYXuheeH7t/Qu/KCHHJmTrrvr+n/Ul
         Kc22DQz3ahMQBRkjG5lzmao/C8mq9nHY8IkVddNwDQFY7neOKNsFgdBZNVI/xahovSY6
         wgNg==
X-Forwarded-Encrypted: i=1; AJvYcCUDS/GcwVJ5bKAPLBH6l0xFNTwQNOB88QPH1eMI8lgx0+2SWV6Emik1OhYRUo/ConllVhZbtY4BdG3SYTk=@vger.kernel.org, AJvYcCXLZZLKM8fWwhtRe3H4u+O5RAou3mkTfONthvnGt0i4a5w/HzB71IJOxMRD1TArZXWUUnSkNlIWGCJeKVEs3/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFzqcLm6qpfE6GFX900na8xN9+i8h7p4FSgU3UZhLJNEMl3BR9
	jL/JgwVTqkGGv0nORrVEOOpO8LUBof1PSiLZU/MgC90pWtJT80yM
X-Google-Smtp-Source: AGHT+IEwGs4u56Rz+sF+QLPktBDSfyKwUa62Irwtgie9uNqIqo49O2wSY2s+JkdWJFtSTdSE64OogQ==
X-Received: by 2002:a17:907:703:b0:a9a:1585:dd6a with SMTP id a640c23a62f3a-a9a69baadc6mr297321466b.36.1729267556850;
        Fri, 18 Oct 2024 09:05:56 -0700 (PDT)
Received: from ?IPV6:2003:df:bf0d:b400:af29:c7b3:c678:5c48? (p200300dfbf0db400af29c7b3c6785c48.dip0.t-ipconnect.de. [2003:df:bf0d:b400:af29:c7b3:c678:5c48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68bc49a6sm112817266b.129.2024.10.18.09.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 09:05:56 -0700 (PDT)
Message-ID: <ce05b149-63ca-46c9-8eb3-67ff3dc5b2c5@gmail.com>
Date: Fri, 18 Oct 2024 18:05:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [POC 0/6] Allow SpinLockIrq to use a normal Guard interface
To: Andreas Hindborg <a.hindborg@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Lyude Paul <lyude@redhat.com>,
 rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>,
 airlied@redhat.com, Ingo Molnar <mingo@redhat.com>, will@kernel.org,
 Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, wedsonaf@gmail.com,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, aliceryhl@google.com,
 Trevor Gross <tmgross@umich.edu>
References: <1eaf7f61-4458-4d15-bbe6-7fd2e34723f4@app.fastmail.com>
 <20241018055125.2784186-1-boqun.feng@gmail.com> <87r08dr78k.fsf@kernel.org>
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <87r08dr78k.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.10.24 13:16, Andreas Hindborg wrote:
> Boqun Feng <boqun.feng@gmail.com> writes:
> 
>> Hi Thomas,
>>
>> So this series is what I proposed, previously, because the nested
>> interrupt API in C is local_irq_save() and local_irq_restore(), the
>> following Rust code has the problem of enabling interrupt earlier:
>>
>> 	// l1 and l2 are interrupt disabling locks, their guards (i.e.
>> 	// return of lock()) can be used to track interrupt state.
>>
>> 	// interrupts are enabled in the beginning.
>> 	
>> 	let g1 = l1.lock(); // previous interrupt state is enabled.
>> 	let g2 = l2.lock(); // previous interrupt state is disabled.
>>
>> 	drop(g1); // release l1, if we use g1's state, interrupt will be
>> 		  // enabled. But this is obviously wrong. Because g2
>> 		  // can only exist with interrupt disabled.
>>
>> With the new interrupt disable and enable API, instead of a "unsigned
>> long", a percpu variable is used to track the outermost interrupt state
>> and the nested level, so that "drop(g1);" above won't enable interrupts.
>>
>> Although this requires extra cost, but I think it might be worth paying,
>> because this could make Rust's SpinLockIrq simply use a guard interface
>> as SpinLock.
>>
>> Of course, looking for any comments and suggestions.
>>
>> Boqun Feng (3):
>>   irq & spin_lock: Add counted interrupt disabling/enabling
>>   rust: helper: Add spin_{un,}lock_irq_{enable,disable}() helpers
>>   rust: sync: lock: Add `Backend::BackendInContext`
>>
>> Lyude Paul (3):
>>   rust: Introduce interrupt module
>>   rust: sync: Add SpinLockIrq
>>   rust: sync: Introduce lock::Backend::Context
>>
>>  include/linux/irqflags.h          |  32 +++++++++-
>>  include/linux/irqflags_types.h    |   6 ++
>>  include/linux/spinlock.h          |  13 ++++
>>  include/linux/spinlock_api_smp.h  |  29 +++++++++
>>  include/linux/spinlock_rt.h       |  10 +++
>>  kernel/locking/spinlock.c         |  16 +++++
>>  kernel/softirq.c                  |   3 +
>>  rust/helpers/helpers.c            |   1 +
>>  rust/helpers/interrupt.c          |  18 ++++++
>>  rust/helpers/spinlock.c           |  10 +++
>>  rust/kernel/interrupt.rs          |  64 +++++++++++++++++++
>>  rust/kernel/lib.rs                |   1 +
>>  rust/kernel/sync.rs               |   2 +-
>>  rust/kernel/sync/lock.rs          |  33 +++++++++-
>>  rust/kernel/sync/lock/mutex.rs    |   2 +
>>  rust/kernel/sync/lock/spinlock.rs | 103 ++++++++++++++++++++++++++++++
>>  16 files changed, 340 insertions(+), 3 deletions(-)
>>  create mode 100644 rust/helpers/interrupt.c
>>  create mode 100644 rust/kernel/interrupt.rs
> 
> 
> Tested-by: Andreas Hindborg <a.hindborg@kernel.org>

Yes, it seems to work:

Tested-by: Dirk Behme <dirk.behme@gmail.com>

I used rust-next minus the alloc patches as base. An addional
try_lock() due to

https://github.com/Rust-for-Linux/linux/commit/f4c2c90bb7b4ae1812dbaca15d9637eecaac2c9f

is needed for that. But thats all I noticed so far :)

Many thanks!

Dirk


> I ran the `hrtimer` examples on top of this, and it seems to work [1].
> 
> Best regards,
> Andreas
> 
> 
> [1] git git://git.kernel.org/pub/scm/linux/kernel/git/a.hindborg/linux.git hrtimer-boqun-poc
> 


