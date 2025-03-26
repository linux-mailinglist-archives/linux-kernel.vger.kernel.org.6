Return-Path: <linux-kernel+bounces-577355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB6BA71C03
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D34189874A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841EE1F4629;
	Wed, 26 Mar 2025 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2DzpdCU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C541311185
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007267; cv=none; b=CLFaaJYqBbHoQ2LQYJgPC3YVSPoPFIZLzYUbCdKl2DpsNaPb32x+pEM8YdP5Xd8qH1Q0XqMOB9l/VIb2HCU0Ik+koQ8CxaX0AUqgpNc1NCty2ZrfMKX5yj8FQ/M7pzzf0P82b20H8m3LzHkOLRGSlDE7qOaykVQTfbfilCaoRmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007267; c=relaxed/simple;
	bh=RLhqAyhYeXRbvNukMia3rEah0rth3XKhMGOugwiu7bI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=I6wQ3LVMiIc/tSFJIiwDa0NVtKhckDkauLjdtzhsZGKoE18YpyoFoonDnYdkFcCpVeoFZkyp3esOatj/pQPU5M8xj6cN7FIPbEbh1epkBKCoOSSlEGENUWDHn6CExyIzCwmE5yOCiHGN1VXKFIdRTY8wq4zcFncV2NesxWaIUow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F2DzpdCU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743007264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=prPqXmv3MvlSz5eyOiIz+dUsJW9wnXJo+KXxYDUpt6Q=;
	b=F2DzpdCUTSPNnigWuoqyGZF0ELQ/UAxQ1rM22hFhzNHB1XZwoBTotZkhmS+mR0QzwB331v
	DkpKfE1hAWlPVpVl9XqWhMMF5vlP/zcpFyyFFbog4uTLOUz0EAIhHSLHEWN6h4AiEmwG/c
	8kXQy6PfNU2Vaeu2AiSFVTJOlHZQSLw=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-RpQNMnTqPHulVQuAMhoefg-1; Wed, 26 Mar 2025 12:41:03 -0400
X-MC-Unique: RpQNMnTqPHulVQuAMhoefg-1
X-Mimecast-MFC-AGG-ID: RpQNMnTqPHulVQuAMhoefg_1743007262
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85b5878a66cso13612539f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743007262; x=1743612062;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=prPqXmv3MvlSz5eyOiIz+dUsJW9wnXJo+KXxYDUpt6Q=;
        b=iv5W5m2zyEsnMkxyojTfQ7VUiqKJ6kZ71cfPhfGmrm1caWumquE5UnXNIiw92qFh/o
         1sbkBRU2/hb4XQFMzZEJFphFzvAF4ixb6QuBv8DCnDn5ZcG9Ob3Zsb8aWWlag69IrW7I
         BqBnURVdFXMd5a8LJBh38AD4xwXVTTdBrVUf1BUdUwZXVD/Vm8pI9pXAwv+t4FFiAtTA
         RrbXdNW9WsFa5MWtnDhvnrQp1yxoEvOpoK0LxwXGf111oRCBsiKPVsg4eRLpFtaz9MUX
         2KpAhnLWiis+X8MyvjtJHtE6fXkVWB+Q4YdEL/2q1qERTg5jKoU5mCADX0CxNGzlSH92
         Hycw==
X-Forwarded-Encrypted: i=1; AJvYcCWTvTkbk2N2SUDpHWU6BzkJXEUM7Uewz+muvItHo8UFyAp8rDO5sNBCk+B4Fv7yVnW16YEIOZSG3kRSUuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YydkvnQ4fS3lpWhBNfzaylp8zDMCSnYoftPrAQ2/GJ+KUAcz4dc
	0kT/rqmA+Ecj3N7vc0QUDxjvSjWXOlohY3iABdGVORunVYjp/4rYetPAKn6dvm3mVJJ9GHAes3y
	ZA/G01jtG30SMncPX910VIwYTBYobsdTPxIpv/Q7i7jGbEzjQdmKz7STeKkjvwA==
X-Gm-Gg: ASbGnct6QGO6kw2wI4m5MZwEPSSjf9g1T6AVHB2D48T7dLTRUTAA0ypxJUbepqz9lRO
	UPE41p5fhryBvwDUK/KWCvgbuoF8kHP/blFzcu8yZy8Dy96rQVkUVhmAsYeUNdFH7PuIapr10nM
	BtzyANE0TeTgCk8Ekahe0KJgUQlWzTgLtSGzCbdU8Cm1ZEnGLQ4rixzSSQooyzgZoGHtVpayxSk
	1sSp7xahIYHhFLttR6/AvKz4Dq+VrnXi/niIEZCUCDNtgaIYi7+kDXF+QodjQRQfZfPCq6d8CLh
	y3gKqAbMm54+YYE7pvCclP/8kORhIs8hWUxs2/U+KKHVlyqRBDln6NcIVMc1Kw==
X-Received: by 2002:a05:6602:6a88:b0:85b:48e7:14fd with SMTP id ca18e2360f4ac-85e82197d29mr66265239f.14.1743007262473;
        Wed, 26 Mar 2025 09:41:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR0FuVdln5+3KEEsrHMRovEFMxjY8m2mx7hohi1mp0b3BdUjHFU/zPvyYRWht1eOolplbsQg==
X-Received: by 2002:a05:6602:6a88:b0:85b:48e7:14fd with SMTP id ca18e2360f4ac-85e82197d29mr66260939f.14.1743007262037;
        Wed, 26 Mar 2025 09:41:02 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbed2504sm2919913173.145.2025.03.26.09.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 09:41:01 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <37bbf28f-911a-4fea-b531-b43cdee72915@redhat.com>
Date: Wed, 26 Mar 2025 12:40:59 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with expedited
 RCU synchronization
To: Waiman Long <llong@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Breno Leitao <leitao@debian.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, aeh@meta.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jhs@mojatatu.com,
 kernel-team@meta.com, Erik Lundgren <elundgren@meta.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <67e1b0a6.050a0220.91d85.6caf@mx.google.com>
 <67e1b2c4.050a0220.353291.663c@mx.google.com>
 <67e1fd15.050a0220.bc49a.766e@mx.google.com>
 <c0a9a0d5-400b-4238-9242-bf21f875d419@redhat.com> <Z-Il69LWz6sIand0@Mac.home>
 <934d794b-7ebc-422c-b4fe-3e658a2e5e7a@redhat.com>
 <Z-L5ttC9qllTAEbO@boqun-archlinux>
 <f1ae824f-f506-49f7-8864-1adc0f7cbee6@redhat.com>
 <Z-MHHFTS3kcfWIlL@boqun-archlinux>
 <1e4c0df6-cb4d-462c-9019-100044ea8016@redhat.com> <Z-OPya5HoqbKmMGj@Mac.home>
 <df237702-55c3-466b-b51e-f3fe46ae03ba@redhat.com>
Content-Language: en-US
In-Reply-To: <df237702-55c3-466b-b51e-f3fe46ae03ba@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/26/25 11:39 AM, Waiman Long wrote:
> On 3/26/25 1:25 AM, Boqun Feng wrote:
>>> It looks like you are trying hard to find a use case for hazard pointer in
>>> the kernel 🙂
>>>
>> Well, if it does the job, why not use it 😉 Also this shows how
>> flexible hazard pointers can be.
>>
>> At least when using hazard pointers, the reader side of the hash list
>> iteration is still lockless. Plus, since the synchronization part
>> doesn't need to wait for the RCU readers in the whole system, it will be
>> faster (I tried with the protecting-the-whole-hash-list approach as
>> well, it's the same result on the tc command). This is why I choose to
>> look into hazard pointers. Another mechanism can achieve the similar
>> behavior is SRCU, but SRCU is slightly heavier compared to hazard
>> pointers in this case (of course SRCU has more functionalities).
>>
>> We can provide a lockdep_unregister_key_nosync() without the
>> synchronize_rcu() in it and let users do the synchronization, but it's
>> going to be hard to enforce and review, especially when someone
>> refactors the code and move the free code to somewhere else.
> Providing a second API and ask callers to do the right thing is 
> probably not a good idea and mistake is going to be made sooner or later.
>>> Anyway, that may work. The only problem that I see is the issue of nesting
>>> of an interrupt context on top of a task context. It is possible that the
>>> first use of a raw_spinlock may happen in an interrupt context. If the
>>> interrupt happens when the task has set the hazard pointer and iterating the
>>> hash list, the value of the hazard pointer may be overwritten. Alternatively
>>> we could have multiple slots for the hazard pointer, but that will make the
>>> code more complicated. Or we could disable interrupt before setting the
>>> hazard pointer.
>> Or we can use lockdep_recursion:
>>
>> 	preempt_disable();
>> 	lockdep_recursion_inc();
>> 	barrier();
>>
>> 	WRITE_ONCE(*hazptr, ...);
>>
>> , it should prevent the re-entrant of lockdep in irq.
> That will probably work. Or we can disable irq. I am fine with both.
>>> The solution that I am thinking about is to have a simple unfair rwlock to
>>> protect just the hash list iteration. lockdep_unregister_key() and
>>> lockdep_register_key() take the write lock with interrupt disabled. While
>>> is_dynamic_key() takes the read lock. Nesting in this case isn't a problem
>>> and we don't need RCU to protect the iteration process and so the last
>>> synchronize_rcu() call isn't needed. The level of contention should be low
>>> enough that live lock isn't an issue.
>>>
>> This could work, one thing though is that locks don't compose. Using a
>> hash write_lock in lockdep_unregister_key() will create a lockdep_lock()
>> -> "hash write_lock" dependency, and that means you cannot
>> lockdep_lock() while you're holding a hash read_lock, although it's
>> not the case today, but it certainly complicates the locking design
>> inside lockdep where there's no lockdep to help 😉
>
> Thinking about it more, doing it in a lockless way is probably a good 
> idea.
>
If we are using hazard pointer for synchronization, should we also take 
off "_rcu" from the list iteration/insertion/deletion macros to avoid 
the confusion that RCU is being used?

Cheers,
Longman


