Return-Path: <linux-kernel+bounces-576296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B57A70D94
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D222189B75D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA662269D17;
	Tue, 25 Mar 2025 23:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgkD1e1W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280711E1E05
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 23:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742944853; cv=none; b=CeDTAtxXyzBa2vOqL/itwjYkaVJ5QXzeKEFuFJ2pkocu5QhNrrnK5A6JiREMAKwPb5VCPUTMp8fzUytHkZjrY9HusRqImj5e5kJI+uoNYszeNZFVdKWF+kPlI0Q2YdEDDO8ry4SbbVnPmipZ495ehkYvpJjX75ccYZukwDxSpPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742944853; c=relaxed/simple;
	bh=ymF+DBjX1Ntj4AGqCYRztfRNIVbY8WI0vk/v+a2ofGc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XYbjheGFdVOZtwHXD2j/+brnUJllqXOH9UMOf+6S2N4P/UNKKPFNUvtolWokhoyyiQHM6eBXDF6YLLedGS1ZMGukysHhf+kqLcqEMVpYdTAcHYnnkrMRCzuPp/wJBLA4FVF3bqimrpZAdhg8tq5+9vhHjncmDTgNrpe/mRRmi+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgkD1e1W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742944850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nvW5VV3nmN14DPddDzYSNR5UKcaGOIMslphcY6nVDjo=;
	b=HgkD1e1WdZd0PYqh6q0riIpheMFB5htPRFaYdzQr77o9hDAwT0f+A8Ns9QaRtrjV05bByO
	EA49PBCDsMZ3zDy/8NJqyfArfryCBsAoFvL1UwdTk2DL3YEPI6YBf/V3pITBHnS0sXpWJX
	aFl2f2WGmhtEC+KxsY6troId5slYVSk=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-LguifXhzPtWt8H6jO1qHGA-1; Tue, 25 Mar 2025 19:20:48 -0400
X-MC-Unique: LguifXhzPtWt8H6jO1qHGA-1
X-Mimecast-MFC-AGG-ID: LguifXhzPtWt8H6jO1qHGA_1742944847
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85dad593342so567925639f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 16:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742944847; x=1743549647;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nvW5VV3nmN14DPddDzYSNR5UKcaGOIMslphcY6nVDjo=;
        b=ZLSJat/4h09k9QfQ4dBzxrl/LN5JzAD9GC238c5C//F7GmZcjXSIRyN+Xi3ua80tkt
         yvaAhF3yaeKsFCDPJuf2fZnnjUtHBLbjZGTaQ2jCkYPWDWnLil+bP5tzVbvuHMcJDz3d
         KDMAL89Dnuus6WTqg4t+ehufdjYImF/P81NBiboH7MNZ9VQwfE8cQQsafq5XZ1+Oi+0Q
         xCFDgvNblSIb41FfLDwmjUs7o/8i2NU6THHLZLIWbxeTpv9Lh70EbdOuMj9d870Mpld1
         5zBDmYV2luf0mOx2ZFrdgq+E7cjLpzve6QpWoOYZGoU2NLFl+PhB4aY22iREANgbxS9m
         Wpsw==
X-Forwarded-Encrypted: i=1; AJvYcCUbboN12gfy1Cp0THrQDPFP1dSEsDE6VOM+gyPcSJIKexvtX47kQxKoohLPVV0y0WHIXR4evc2MOf8hI3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIxgkFZ50yNirhrVpjxekSiuUYFRm+STVVL2SSssSH71AMPpVn
	WwLaWdgk/6px77Bmi9/oK+hoXT34cMyQfM6OFac3VFa3mW75T3P+8oKJkGaKDlhk9DYNZK2Klmh
	G02E+gbI3jJ8kUtPaiN8cxup2/k7k975+GJLUIMdebMQAyOQaaHpayLSB4IHNSw==
X-Gm-Gg: ASbGnctjJ6zkouqfC5KzXi4k4i4BuO2AOJKDVVEBEuDAxx/tWXydYNIXJZnBoL67R+o
	vUQguD06qFz1URD17bQuexgP75y8MEa1HREbnNZBuR7cYVS3OkGFcJvR7j8rfKghJYPEKGMSW3C
	Dvv64Ev2tFVtp1s6/jfdQRM1Zc36QTk8CNnaRBS/Gvw3zHr8irH0K0BQ8TbHnP10+gJ3JpGQLWu
	ax8c77djZMtt5r5m4wmzejPufYvAp52Epgb4FBqe3TgcSdw8fvuRiUO3CNDsfAtzyHJ1YMnIfsw
	aWwM6AhFGdH1dj/FY4xD24eUQeh5brLE022RUfR+6USinzseuK0GzzH3BS6gkA==
X-Received: by 2002:a05:6602:360b:b0:85b:538e:1fad with SMTP id ca18e2360f4ac-85e2ca335ffmr2554780339f.6.1742944847148;
        Tue, 25 Mar 2025 16:20:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxHhsz8OSs7tW61u7BkBttr8YQ4kP/KVm/bE+dTWGHNfzA5hgOj3kWDZ2+1dxeXruI5WOyow==
X-Received: by 2002:a05:6602:360b:b0:85b:538e:1fad with SMTP id ca18e2360f4ac-85e2ca335ffmr2554776839f.6.1742944846604;
        Tue, 25 Mar 2025 16:20:46 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85e2bc281e5sm238946939f.20.2025.03.25.16.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 16:20:46 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <1e4c0df6-cb4d-462c-9019-100044ea8016@redhat.com>
Date: Tue, 25 Mar 2025 19:20:44 -0400
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
References: <20250324121202.GG14944@noisy.programming.kicks-ass.net>
 <CANn89iKykrnUVUsqML7dqMuHx6OuGnKWg-xRUV4ch4vGJtUTeg@mail.gmail.com>
 <67e1b0a6.050a0220.91d85.6caf@mx.google.com>
 <67e1b2c4.050a0220.353291.663c@mx.google.com>
 <67e1fd15.050a0220.bc49a.766e@mx.google.com>
 <c0a9a0d5-400b-4238-9242-bf21f875d419@redhat.com> <Z-Il69LWz6sIand0@Mac.home>
 <934d794b-7ebc-422c-b4fe-3e658a2e5e7a@redhat.com>
 <Z-L5ttC9qllTAEbO@boqun-archlinux>
 <f1ae824f-f506-49f7-8864-1adc0f7cbee6@redhat.com>
 <Z-MHHFTS3kcfWIlL@boqun-archlinux>
Content-Language: en-US
In-Reply-To: <Z-MHHFTS3kcfWIlL@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/25/25 3:42 PM, Boqun Feng wrote:
> On Tue, Mar 25, 2025 at 03:23:30PM -0400, Waiman Long wrote:
> [...]
>>>>> That commit seemed fixing a race between disabling lockdep and
>>>>> unregistering key, and most importantly, call zap_class() for the
>>>>> unregistered key even if lockdep is disabled (debug_locks = 0). It might
>>>>> be related, but I'm not sure that's the reason of putting
>>>>> synchronize_rcu() there. Say you want to synchronize between
>>>>> /proc/lockdep and lockdep_unregister_key(), and you have
>>>>> synchronize_rcu() in lockdep_unregister_key(), what's the RCU read-side
>>>>> critical section at /proc/lockdep?
>>>> I agree that the commit that I mentioned is not relevant to the current
>>>> case. You are right that is_dynamic_key() is the only function that is
>>>> problematic, the other two are protected by the lockdep_lock. So they are
>>>> safe. Anyway, I believe that the actual race happens in the iteration of the
>>>> hashed list in is_dynamic_key(). The key that you save in the
>>>> lockdep_key_hazptr in your proposed patch should never be the key (dead_key)
>>> The key stored in lockdep_key_hazptr is the one that the rest of the
>>> function will use after is_dynamic_key() return true. That is,
>>>
>>> 	CPU 0				CPU 1
>>> 	=====				=====
>>> 	WRITE_ONCE(*lockdep_key_hazptr, key);
>>> 	smp_mb();
>>>
>>> 	is_dynamic_key():
>>> 	  hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
>>> 	    if (k == key) {
>>> 	      found = true;
>>> 	      break;
>>> 	    }
>>> 	  }
>>> 	  				lockdep_unregister_key():
>>> 					  hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
>>> 					    if (k == key) {
>>> 					      hlist_del_rcu(&k->hash_entry);
>>> 				              found = true;
>>> 				              break;
>>> 					    }
>>> 					  }
>>>
>>> 				        smp_mb();
>>>
>>> 					synchronize_lockdep_key_hazptr():
>>> 					  for_each_possible_cpu(cpu) {
>>> 					    <wait for the hazptr slot on
>>> 					    that CPU to be not equal to
>>> 					    the removed key>
>>> 					  }
>>>
>>>
>>> , so that if is_dynamic_key() finds a key was in the hash, even though
>>> later on the key would be removed by lockdep_unregister_key(), the
>>> hazard pointers guarantee lockdep_unregister_key() would wait for the
>>> hazard pointer to release.
>>>
>>>> that is passed to lockdep_unregister_key(). In is_dynamic_key():
>>>>
>>>>       hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
>>>>                   if (k == key) {
>>>>                           found = true;
>>>>                           break;
>>>>                   }
>>>>           }
>>>>
>>>> key != k (dead_key), but before accessing its content to get to hash_entry,
>>> It is the dead_key.
>>>
>>>> an interrupt/NMI can happen. In the mean time, the structure holding the key
>>>> is freed and its content can be overwritten with some garbage. When
>>>> interrupt/NMI returns, hash_entry can point to anything leading to crash or
>>>> an infinite loop.  Perhaps we can use some kind of synchronization mechanism
>>> No, hash_entry cannot be freed or overwritten because the user has
>>> protect the key with hazard pointers, only when the user reset the
>>> hazard pointer to NULL, lockdep_unregister_key() can then return and the
>>> key can be freed.
>>>
>>>> between is_dynamic_key() and lockdep_unregister_key() to prevent this kind
>>>> of racing. For example, we can have an atomic counter associated with each
>>> The hazard pointer I proposed provides the exact synchronization ;-)
>> What I am saying is that register_lock_class() is trying to find a newkey
>> while lockdep_unregister_key() is trying to take out an oldkey (newkey !=
>> oldkey). If they happens in the same hash list, register_lock_class() will
>> put newkey into the hazard pointer, but synchronize_lockdep_key_hazptr()
>> call from lockdep_unregister_key() is checking for oldkey which is not the
>> one saved in the hazard pointer. So lockdep_unregister_key() will return and
>> the key will be freed and reused while is_dynamic_key() may just have a
>> reference to the oldkey and trying to access its content which is invalid. I
>> think this is a possible scenario.
>>
> Oh, I see. And yes, the hazard pointers I proposed cannot prevent this
> race unfortunately. (Well, technically we can still use an extra slot to
> hold the key in the hash list iteration, but that would generates a lot
> of stores, so it won't be ideal). But...
>
> [...]
>>>> head of the hashed table. is_dynamic_key() can increment the counter if it
>>>> is not zero to proceed and lockdep_unregister_key() have to make sure it can
>>>> safely decrement the counter to 0 before going ahead. Just a thought!
>>>>
> Your idea inspires another solution with hazard pointers, we can
> put the pointer of the hash_head into the hazard pointer slot ;-)
>
> in register_lock_class():
>
> 		/* hazptr: protect the key */
> 		WRITE_ONCE(*key_hazptr, keyhashentry(lock->key));
>
> 		/* Synchronizes with the smp_mb() in synchronize_lockdep_key_hazptr() */
> 		smp_mb();
>
> 		if (!static_obj(lock->key) && !is_dynamic_key(lock->key)) {
> 			return NULL;
> 		}
>
> in lockdep_unregister_key():
>
> 	/* Wait until register_lock_class() has finished accessing k->hash_entry. */
> 	synchronize_lockdep_key_hazptr(keyhashentry(key));
>
>
> which is more space efficient than per hash list atomic or lock unless
> you have 1024 or more CPUs.

It looks like you are trying hard to find a use case for hazard pointer 
in the kernel :-)

Anyway, that may work. The only problem that I see is the issue of 
nesting of an interrupt context on top of a task context. It is possible 
that the first use of a raw_spinlock may happen in an interrupt context. 
If the interrupt happens when the task has set the hazard pointer and 
iterating the hash list, the value of the hazard pointer may be 
overwritten. Alternatively we could have multiple slots for the hazard 
pointer, but that will make the code more complicated. Or we could 
disable interrupt before setting the hazard pointer.

The solution that I am thinking about is to have a simple unfair rwlock 
to protect just the hash list iteration. lockdep_unregister_key() and 
lockdep_register_key() take the write lock with interrupt disabled. 
While is_dynamic_key() takes the read lock. Nesting in this case isn't a 
problem and we don't need RCU to protect the iteration process and so 
the last synchronize_rcu() call isn't needed. The level of contention 
should be low enough that live lock isn't an issue.

Cheers,
Longman



