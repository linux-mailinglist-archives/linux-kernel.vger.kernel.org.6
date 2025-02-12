Return-Path: <linux-kernel+bounces-510369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B769AA31BD1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA283A7C92
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E47378F4E;
	Wed, 12 Feb 2025 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/G6JujY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9507EBE67
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739326743; cv=none; b=sFCRD3lyc5CP9TYZ5M0MaX3jlFGnXKA9Kuq56YKY5md9Zva8Wz+8yjstd8k1F0YS3A7HPrg0DvyS6ufj+9QEbxHW6r/Mm9+1DzNjn8IUGYlsYT24+mWnhrY155FXAF+caWnYwzhqamGb15q+cD8ryJyGwOaIMXjd2fiUmut0XAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739326743; c=relaxed/simple;
	bh=Yr8B08gYfR9i4nQK2LVucwUuTPio3sDhuVae49mSMg0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TKm1ZhDu7DnXsIX2tKL882BD19vUo25irCuzLCDYHTuYqRtnAznHKoXGNhNP2PzcwJGppO6UfjkENFrWJeEqi3D7n7Ibqqruw8uL8b/Q0L7hlYYg9zyURoeqgMwQgylqyvyths/KtZ9K3qH2e7BctY9TrJsgUPb9SU8S4psJC74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/G6JujY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739326740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BijPBE/lLXc2Nrbv1MD/7JA4iiEj2qkFePESZIV1PxQ=;
	b=R/G6JujYG5nL7sVGi/LAHITt2621U8G/lIMm9StPflrWa1LwbDtBHLiJX4p7UxnJaJK84W
	foHb9hy79eliGQ8azGQmKE8bS9UfDqwGLH681xiSGCxLROwVOhw9gY+xWwy+8ZbuFktCPY
	GXfDxvmqqe0Nwa4E/cABQ+Jf2Qts1zE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-xpbq-Y12O8Gd4fZfJ0JnxA-1; Tue, 11 Feb 2025 21:18:59 -0500
X-MC-Unique: xpbq-Y12O8Gd4fZfJ0JnxA-1
X-Mimecast-MFC-AGG-ID: xpbq-Y12O8Gd4fZfJ0JnxA
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c057eae956so795491985a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 18:18:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739326738; x=1739931538;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BijPBE/lLXc2Nrbv1MD/7JA4iiEj2qkFePESZIV1PxQ=;
        b=T0UCVdgnVMvot2Vbud9wFE0fKZLoVGQG9VtUjL1fLE21n9ckcf2qFtiroqYCter4mP
         ZhAE9RCWI2gnaHe+RjDBO8zXIifRgOeTpKUAwz/rHwyYeXGqd39rnHXG2ThkxZMhW3Mv
         leBn+dCfnV+tlhHdVbt6qZt53jXxuY1L9dG0ptYqPS4SouV/KSGCKbK/NSXNyXvJeYm4
         DeqjgkCc2QENCTLn9NRXO0EtK0N2k969w4vhiRkYhKyZieLjsaryW5wIROrd7gStl2rU
         YVI2z6nHQqpxt+20VusSGUpbLoS79GvhBgTi6RFjtPS6IS2TpYXepGoCedVLvkLjoSVK
         cA2w==
X-Gm-Message-State: AOJu0YxdteV5cE8v5+xRphCW+cmQByiDYkTn2Je2QX2oxdVRk2Fmhdo/
	G0laIp0yBPGtITdhJgAldFJy+iizO9pKJpvA86wR4wktUGAFGwDeJReA6UtoUfdo+nGNF6qhQ7e
	lw+Wpu/qw+0EzaZ+l7IrvNvNmA4MdinLwBujE6oVzKmUXbQKJMwLNWx8v0oF+gA==
X-Gm-Gg: ASbGnctFSda3eh/T2zO5TcUth7P/y+30Y/W8YQK2ZHML0Qhi1CkKHJpVze664phPVFL
	te7XUSQG1ivM33EQMZWQ2pnR2VWmLTdXR8tlO0lQHnQkrxx/BDQlSOCCxfNeOXTyEchT32OKXjQ
	Af9SE88JEEGLrd/U2EnPqVrMAZFCwwejQA9+WM3emZLH222te/4NYSMMMT4dffoCX7B4iNUrX7P
	RqC9gSYv3hk07r6u0pEAJ1wsd6sdtFfm65q9s53aI/2jARUmiw6rQRguBxhiN8RrjVEbb62pe+O
	4+dvykEEtXl8RrAs6DolKDN6aVgU/WUVnspqjTP9XB1NfMfd
X-Received: by 2002:a05:620a:2783:b0:7c0:69f6:fcda with SMTP id af79cd13be357-7c06fc578f6mr275176085a.5.1739326738614;
        Tue, 11 Feb 2025 18:18:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFirlxaw37COcnOIfyDj+oypXdUmIIAMjaZilLKPrTziSFNd/fZoq7TLJd5HjkNGaKtdpjeSQ==
X-Received: by 2002:a05:620a:2783:b0:7c0:69f6:fcda with SMTP id af79cd13be357-7c06fc578f6mr275173785a.5.1739326738182;
        Tue, 11 Feb 2025 18:18:58 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e44f4835e6sm54620516d6.111.2025.02.11.18.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 18:18:57 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3e45144d-d147-4431-91be-63d0817fa2ce@redhat.com>
Date: Tue, 11 Feb 2025 21:18:56 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] locking/semaphore: Use wake_q to wake up processes
 outside lock critical section
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org
References: <20250127013127.3913153-1-longman@redhat.com>
Content-Language: en-US
In-Reply-To: <20250127013127.3913153-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/26/25 8:31 PM, Waiman Long wrote:
> A circular lock dependency splat has been seen involving down_trylock().
>
> [ 4011.795602] ======================================================
> [ 4011.795603] WARNING: possible circular locking dependency detected
> [ 4011.795607] 6.12.0-41.el10.s390x+debug
> [ 4011.795612] ------------------------------------------------------
> [ 4011.795613] dd/32479 is trying to acquire lock:
> [ 4011.795617] 0015a20accd0d4f8 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0x26/0x90
> [ 4011.795636]
> [ 4011.795636] but task is already holding lock:
> [ 4011.795637] 000000017e461698 (&zone->lock){-.-.}-{2:2}, at: rmqueue_bulk+0xac/0x8f0
>
>    the existing dependency chain (in reverse order) is:
>    -> #4 (&zone->lock){-.-.}-{2:2}:
>    -> #3 (hrtimer_bases.lock){-.-.}-{2:2}:
>    -> #2 (&rq->__lock){-.-.}-{2:2}:
>    -> #1 (&p->pi_lock){-.-.}-{2:2}:
>    -> #0 ((console_sem).lock){-.-.}-{2:2}:
>
> The console_sem -> pi_lock dependency is due to calling try_to_wake_up()
> while holding the console.sem raw_spinlock. This dependency can be broken
> by using wake_q to do the wakeup instead of calling try_to_wake_up()
> under the console_sem lock. This will also make the semaphore's
> raw_spinlock become a terminal lock without taking any further locks
> underneath it.
>
> The hrtimer_bases.lock is a raw_spinlock while zone->lock is a
> spinlock. The hrtimer_bases.lock -> zone->lock dependency happens via
> the debug_objects_fill_pool() helper function in the debugobjects code.
>
> [ 4011.795646] -> #4 (&zone->lock){-.-.}-{2:2}:
> [ 4011.795650]        __lock_acquire+0xe86/0x1cc0
> [ 4011.795655]        lock_acquire.part.0+0x258/0x630
> [ 4011.795657]        lock_acquire+0xb8/0xe0
> [ 4011.795659]        _raw_spin_lock_irqsave+0xb4/0x120
> [ 4011.795663]        rmqueue_bulk+0xac/0x8f0
> [ 4011.795665]        __rmqueue_pcplist+0x580/0x830
> [ 4011.795667]        rmqueue_pcplist+0xfc/0x470
> [ 4011.795669]        rmqueue.isra.0+0xdec/0x11b0
> [ 4011.795671]        get_page_from_freelist+0x2ee/0xeb0
> [ 4011.795673]        __alloc_pages_noprof+0x2c2/0x520
> [ 4011.795676]        alloc_pages_mpol_noprof+0x1fc/0x4d0
> [ 4011.795681]        alloc_pages_noprof+0x8c/0xe0
> [ 4011.795684]        allocate_slab+0x320/0x460
> [ 4011.795686]        ___slab_alloc+0xa58/0x12b0
> [ 4011.795688]        __slab_alloc.isra.0+0x42/0x60
> [ 4011.795690]        kmem_cache_alloc_noprof+0x304/0x350
> [ 4011.795692]        fill_pool+0xf6/0x450
> [ 4011.795697]        debug_object_activate+0xfe/0x360
> [ 4011.795700]        enqueue_hrtimer+0x34/0x190
> [ 4011.795703]        __run_hrtimer+0x3c8/0x4c0
> [ 4011.795705]        __hrtimer_run_queues+0x1b2/0x260
> [ 4011.795707]        hrtimer_interrupt+0x316/0x760
> [ 4011.795709]        do_IRQ+0x9a/0xe0
> [ 4011.795712]        do_irq_async+0xf6/0x160
>
> Normally raw_spinlock to spinlock dependency is not legit
> and will be warned if PROVE_RAW_LOCK_NESTING is enabled,
> but debug_objects_fill_pool() is an exception as it explicitly
> allows this dependency for non-PREEMPT_RT kernel without causing
> PROVE_RAW_LOCK_NESTING lockdep splat. As a result, this dependency is
> legit and not a bug.
>
> Anyway, semaphore is the only locking primitive left that is still
> using try_to_wake_up() to do wakeup inside critical section, all the
> other locking primitives had been migrated to use wake_q to do wakeup
> outside of the critical section. It is also possible that there are
> other circular locking dependencies involving printk/console_sem or
> other existing/new semaphores lurking somewhere which may show up in
> the future. Let just do the migration now to wake_q to avoid headache
> like this.

I can also add the following as another instance where deadlock can happen.

Reported-by:syzbot+ed801a886dfdbfe7136d@syzkaller.appspotmail.com

Cheers,
Longman

> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/locking/semaphore.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
> index 34bfae72f295..de9117c0e671 100644
> --- a/kernel/locking/semaphore.c
> +++ b/kernel/locking/semaphore.c
> @@ -29,6 +29,7 @@
>   #include <linux/export.h>
>   #include <linux/sched.h>
>   #include <linux/sched/debug.h>
> +#include <linux/sched/wake_q.h>
>   #include <linux/semaphore.h>
>   #include <linux/spinlock.h>
>   #include <linux/ftrace.h>
> @@ -38,7 +39,7 @@ static noinline void __down(struct semaphore *sem);
>   static noinline int __down_interruptible(struct semaphore *sem);
>   static noinline int __down_killable(struct semaphore *sem);
>   static noinline int __down_timeout(struct semaphore *sem, long timeout);
> -static noinline void __up(struct semaphore *sem);
> +static noinline void __up(struct semaphore *sem, struct wake_q_head *wake_q);
>   
>   /**
>    * down - acquire the semaphore
> @@ -183,13 +184,16 @@ EXPORT_SYMBOL(down_timeout);
>   void __sched up(struct semaphore *sem)
>   {
>   	unsigned long flags;
> +	DEFINE_WAKE_Q(wake_q);
>   
>   	raw_spin_lock_irqsave(&sem->lock, flags);
>   	if (likely(list_empty(&sem->wait_list)))
>   		sem->count++;
>   	else
> -		__up(sem);
> +		__up(sem, &wake_q);
>   	raw_spin_unlock_irqrestore(&sem->lock, flags);
> +	if (!wake_q_empty(&wake_q))
> +		wake_up_q(&wake_q);
>   }
>   EXPORT_SYMBOL(up);
>   
> @@ -269,11 +273,12 @@ static noinline int __sched __down_timeout(struct semaphore *sem, long timeout)
>   	return __down_common(sem, TASK_UNINTERRUPTIBLE, timeout);
>   }
>   
> -static noinline void __sched __up(struct semaphore *sem)
> +static noinline void __sched __up(struct semaphore *sem,
> +				  struct wake_q_head *wake_q)
>   {
>   	struct semaphore_waiter *waiter = list_first_entry(&sem->wait_list,
>   						struct semaphore_waiter, list);
>   	list_del(&waiter->list);
>   	waiter->up = true;
> -	wake_up_process(waiter->task);
> +	wake_q_add(wake_q, waiter->task);
>   }


