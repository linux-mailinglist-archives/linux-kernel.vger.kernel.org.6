Return-Path: <linux-kernel+bounces-577406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA165A71CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7EB1892765
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333B61F7069;
	Wed, 26 Mar 2025 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfAY5HVI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10FE3BBF0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743008541; cv=none; b=B3PgCzTTyPW+ecXKKFyTpNpXhVGzNZ9J/RKwdCyRdor17qP5Voq0n4UNTNUMyS5d5rqgsXO9iovp8mTDwJXJetiAnGRD0xrQI6gR31OPtaZIImAq7NWm15NpK3H5UaYwKXwGHYxXayCUJ34icElnYAgoiBJNTD+/nAw9fhwIYdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743008541; c=relaxed/simple;
	bh=SVcK5qDO8OKDL6k8KJLfRGQb+scsSXirchR6Hmzhlqw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ev4uH90XUs1OKR4hbrpqxpTOoxR+19KZ6rPF+rMNn6wF/ZTvyKUrNFhw6V8h/5PBy4L141BdIom/zWIt6wtE4vg7RT/lQN/+rUeuMxRXlle0w0CjNJbhGYODu/ZSZiF2JxwfsDaEEZGrwNSjdYZ37+jm/qFHGKqvM5u3MEr1xuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HfAY5HVI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743008538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cecdEeNUHsdke79qU6QCXAz/3V017lm5A4UWs+w2DmQ=;
	b=HfAY5HVIxjloyl2ho7StUwhwE4HRDCcE/0pLr8SDUSpiEHZK68K8enCUq0e2rWxvZvwJoD
	Z6sVDA8zg1nOcujgp1ZE7wGtRIN2UwYZFsBNoi0zRbhgq8gYRDVaJTVUs3nNOaw7Elggfc
	9jz8iWiaFuCx2ssjDVbO8jmLLk6c7d0=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-ckCBZ6qROt-4_YetR1kzVA-1; Wed, 26 Mar 2025 13:02:17 -0400
X-MC-Unique: ckCBZ6qROt-4_YetR1kzVA-1
X-Mimecast-MFC-AGG-ID: ckCBZ6qROt-4_YetR1kzVA_1743008536
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce8dadfb67so458725ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743008536; x=1743613336;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cecdEeNUHsdke79qU6QCXAz/3V017lm5A4UWs+w2DmQ=;
        b=mEF347e/We6V1MtIQ8fUt//qDBmiCPBvgDm49dkGySQuEFjThyeeJU3OzZ5ofKsT+D
         rhtviASYeA4IGwSk0vC3jJGEY7AzmopjurVUV9eT3mH+2u1lrTGsS5VuNTvLTXCQidgS
         qfgOhm7CIB1wqTtdEGFmK3/Q6Ntw56LvxKQE2uw9kp5yE9a5jAxhkqzB1PymhyVCtZz7
         vv68MixB/7dE3E6/tNLOC8H8ekphaIiReQySK857U3+A/JTAnvjtFqbG6Z5LgznUlauV
         0LvoxzLbwba1NOJCNcugAfQz2KWsvOkskYiNrr1RGB1kKJh5qSrUdJ/z3fbxlVO3Ho/7
         bY+A==
X-Forwarded-Encrypted: i=1; AJvYcCU6ocK3k1jRrDXGzjOkQsG7nNPg/nl3zcTSn5FnvtUqg+fR75QRjaH9Rf1Bicf4wn7oT/QvgAUTDGYbWPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSX1psZ+IkZE6an8jn/yeBxbwcrn8WMjCywd1PUMC0XxloBIy4
	iVEtAhazeaDtx1lFKMROwwY6nh1SCPfYCK50nCtRMQfi96r6IkIQOPXj4iwy+slIYFzhmRWC77C
	VgYOOXnAwWJRiYPQrGAMf3d+OkyJZMMjgk8s3eSO/BPrVwuKddinRNdeOF4dExg==
X-Gm-Gg: ASbGncs5F0hfxRxhOwC14enGWyJf62MR2biZFLh4w7AUfwXovYWtKlHxL7P0mlm6ROo
	MqCEIys46IwauGPUdeWxklLUcMbkdxL/8yoBxtyfMZAs1cfiCBA4tNvy9k1h2QK/44haq7MB5Kk
	1CC02sNbyTQHb8JMFFLGWi2+SUcJLGU9PM3hXf6+k7mPIjvsRH3w2fXPgAIo+uzowE9CQOykEko
	RdnP770hjoS9NH6dUtXsXa/LdQ18gghePclc/EOLm6AkvRHSf1YuhQhXG2JfB7gbc9cm90ZS1Y9
	LY0qRl5jTEXcIgAqfj+8SA8KybQ2tpL+mBW3cw+7bJ9t0w0gxBV8od957Cru5Q==
X-Received: by 2002:a05:6e02:1fed:b0:3d3:e2a1:1f23 with SMTP id e9e14a558f8ab-3d5cce28aa9mr4965985ab.20.1743008535856;
        Wed, 26 Mar 2025 10:02:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWUzkcokaEv3SdOtEjPGotLMmy5TGK6nOdTwaMtrqUBUMiTsZpxr31sxrmrG0/Ld101YCpjw==
X-Received: by 2002:a05:6e02:1fed:b0:3d3:e2a1:1f23 with SMTP id e9e14a558f8ab-3d5cce28aa9mr4964685ab.20.1743008534838;
        Wed, 26 Mar 2025 10:02:14 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbeb05f6sm2887501173.109.2025.03.26.10.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 10:02:14 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <712657fb-36bc-40d8-9acc-d19f54586c0c@redhat.com>
Date: Wed, 26 Mar 2025 13:02:12 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with expedited
 RCU synchronization
To: Boqun Feng <boqun.feng@gmail.com>, Waiman Long <llong@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Breno Leitao <leitao@debian.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, aeh@meta.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jhs@mojatatu.com,
 kernel-team@meta.com, Erik Lundgren <elundgren@meta.com>,
 "Paul E. McKenney" <paulmck@kernel.org>
References: <c0a9a0d5-400b-4238-9242-bf21f875d419@redhat.com>
 <Z-Il69LWz6sIand0@Mac.home> <934d794b-7ebc-422c-b4fe-3e658a2e5e7a@redhat.com>
 <Z-L5ttC9qllTAEbO@boqun-archlinux>
 <f1ae824f-f506-49f7-8864-1adc0f7cbee6@redhat.com>
 <Z-MHHFTS3kcfWIlL@boqun-archlinux>
 <1e4c0df6-cb4d-462c-9019-100044ea8016@redhat.com> <Z-OPya5HoqbKmMGj@Mac.home>
 <df237702-55c3-466b-b51e-f3fe46ae03ba@redhat.com>
 <37bbf28f-911a-4fea-b531-b43cdee72915@redhat.com> <Z-QvvzFORBDESCgP@Mac.home>
Content-Language: en-US
In-Reply-To: <Z-QvvzFORBDESCgP@Mac.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/26/25 12:47 PM, Boqun Feng wrote:
> On Wed, Mar 26, 2025 at 12:40:59PM -0400, Waiman Long wrote:
>> On 3/26/25 11:39 AM, Waiman Long wrote:
>>> On 3/26/25 1:25 AM, Boqun Feng wrote:
>>>>> It looks like you are trying hard to find a use case for hazard pointer in
>>>>> the kernel 🙂
>>>>>
>>>> Well, if it does the job, why not use it 😉 Also this shows how
>>>> flexible hazard pointers can be.
>>>>
>>>> At least when using hazard pointers, the reader side of the hash list
>>>> iteration is still lockless. Plus, since the synchronization part
>>>> doesn't need to wait for the RCU readers in the whole system, it will be
>>>> faster (I tried with the protecting-the-whole-hash-list approach as
>>>> well, it's the same result on the tc command). This is why I choose to
>>>> look into hazard pointers. Another mechanism can achieve the similar
>>>> behavior is SRCU, but SRCU is slightly heavier compared to hazard
>>>> pointers in this case (of course SRCU has more functionalities).
>>>>
>>>> We can provide a lockdep_unregister_key_nosync() without the
>>>> synchronize_rcu() in it and let users do the synchronization, but it's
>>>> going to be hard to enforce and review, especially when someone
>>>> refactors the code and move the free code to somewhere else.
>>> Providing a second API and ask callers to do the right thing is probably
>>> not a good idea and mistake is going to be made sooner or later.
>>>>> Anyway, that may work. The only problem that I see is the issue of nesting
>>>>> of an interrupt context on top of a task context. It is possible that the
>>>>> first use of a raw_spinlock may happen in an interrupt context. If the
>>>>> interrupt happens when the task has set the hazard pointer and iterating the
>>>>> hash list, the value of the hazard pointer may be overwritten. Alternatively
>>>>> we could have multiple slots for the hazard pointer, but that will make the
>>>>> code more complicated. Or we could disable interrupt before setting the
>>>>> hazard pointer.
>>>> Or we can use lockdep_recursion:
>>>>
>>>> 	preempt_disable();
>>>> 	lockdep_recursion_inc();
>>>> 	barrier();
>>>>
>>>> 	WRITE_ONCE(*hazptr, ...);
>>>>
>>>> , it should prevent the re-entrant of lockdep in irq.
>>> That will probably work. Or we can disable irq. I am fine with both.
>>>>> The solution that I am thinking about is to have a simple unfair rwlock to
>>>>> protect just the hash list iteration. lockdep_unregister_key() and
>>>>> lockdep_register_key() take the write lock with interrupt disabled. While
>>>>> is_dynamic_key() takes the read lock. Nesting in this case isn't a problem
>>>>> and we don't need RCU to protect the iteration process and so the last
>>>>> synchronize_rcu() call isn't needed. The level of contention should be low
>>>>> enough that live lock isn't an issue.
>>>>>
>>>> This could work, one thing though is that locks don't compose. Using a
>>>> hash write_lock in lockdep_unregister_key() will create a lockdep_lock()
>>>> -> "hash write_lock" dependency, and that means you cannot
>>>> lockdep_lock() while you're holding a hash read_lock, although it's
>>>> not the case today, but it certainly complicates the locking design
>>>> inside lockdep where there's no lockdep to help 😉
>>> Thinking about it more, doing it in a lockless way is probably a good
>>> idea.
>>>
>> If we are using hazard pointer for synchronization, should we also take off
>> "_rcu" from the list iteration/insertion/deletion macros to avoid the
>> confusion that RCU is being used?
>>
> We can, but we probably want to introduce a new set of API with suffix
> "_lockless" or something because they will still need a lockless fashion
> similar to RCU list iteration/insertion/deletion.

The lockless part is just the iteration of the list. Insertion and 
deletion is protected by lockdep_lock().

The current hlist_*_rcu() macros are doing the right things for lockless 
use case too. We can either document that RCU is not being used or have 
some _lockless helpers that just call the _rcu equivalent.

Cheers,
Longman


