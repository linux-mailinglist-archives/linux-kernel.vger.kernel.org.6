Return-Path: <linux-kernel+bounces-368202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5900C9A0C8A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B40E0B291D4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C35209690;
	Wed, 16 Oct 2024 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Spkcdxyb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2C71422DD
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088601; cv=none; b=TzqM6ZK/h7gQQMXjx2HPEUDK8Aey5uTeO1LWR1i/uDxvFQzbulB2W9S1RQpZTVGDWgJVnPBtX7RjwEl0augYhSjwcdCH+Kps9kN4Pfq9JbV+GnUziytzvXTzYXsnnwHYi7JM7qMnA1TrTCHSBM1TEKyAoVpjbEm73m6Btrzocp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088601; c=relaxed/simple;
	bh=dCqLV0KeLQh0el4YRKcSIbmce5c8HKKiys28RGREd/g=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=n2bU5ivh6daqU6vzKSTB3oJO1sMMOu9klDzOZU0EYNM1e1O08V/A0ruFVfKWE5CsLk2oTe/jXgcozCqmaQ8Vv9gVsZWKfQvgEOujHmE6pmBm/GyA7MfABHUM6qL7joDKeNCcBDiQMSpN+tnsWhJUKruJR6J7/ZhuqBmcsrlJls0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Spkcdxyb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729088598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/KW/XoaEe9YPin6L1l6dmEf2XR0ptPwsvepwftJ/SU=;
	b=SpkcdxybYgujutRrD/aCq4mLTFZZBikZjTiskp5jE9YLpGqhsDqVsWW+pk2v9SvSVAUUaj
	OWZbVVKXlKJlfF+klRH0VzWnI+PeN4Q3MW07K1cGJfezima8/jb7St+/FPvvWZFvZbrb9l
	eTbpG3+Ih3vzRFtgs/V6dtzqXmZDdws=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-3eutnRxSPhayrhfp-Ls0Sg-1; Wed, 16 Oct 2024 10:23:17 -0400
X-MC-Unique: 3eutnRxSPhayrhfp-Ls0Sg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbd3754f4fso94212666d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729088596; x=1729693396;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/KW/XoaEe9YPin6L1l6dmEf2XR0ptPwsvepwftJ/SU=;
        b=VWMZws4aLv5LXQRT5GbVbDFZEB01N2yW6Q9KEyj+JN/BK3osXmcVuKsW11zqF9cbHL
         euM4gKLKGyUuAtI/+jxQfwBN1gAq/5c3S8XzvCfUFMLG1AfPdzhS2KghcyznfmhQV5q6
         CT08qIzUQ1hbHamJOfB3cu9iW4EnMJWeoKjqPTQhbKpNXl/ygsJKRGr1d6TJrylCgOeY
         n93A+nrCfkmVw2kLwx7I3NuHPBlRXwJ8PjtWcB2Hp56mDQMydaO8OiY4lE7sloT2ZaxH
         q55VwzKeT9RBeSNYVONPr1HzaMHekngdqljmnAhksuVLWGmIGqdnrPd6D2QlrNce+upx
         QPLQ==
X-Gm-Message-State: AOJu0Yzmo6aVD8831xl2nPEMg7xPxuTom2EEOLVQ5FLL/N7f3j5azNao
	uRTB0F5s8preqwvj1ISfYjby0qsLohT20BCPpw65Pi2ChdggoqTU/suYOncgrrqIYb3jqk6sr+u
	d5oAc1GDvEJOmyZq9qmA5RD0Did0yZzCbBAJRtes9z2yS7gZKZit7Z7A02JNyf87fZIuoVAs3
X-Received: by 2002:a05:6214:2f10:b0:6c3:5496:3e06 with SMTP id 6a1803df08f44-6cbefffdfe6mr302613966d6.10.1729088595817;
        Wed, 16 Oct 2024 07:23:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlmSxZTKIDajxln309baSOeFhzJ8LjphoJlbw+lLiJL6M7eRNZKov97jwPhJoCscR7o086vw==
X-Received: by 2002:a05:6214:2f10:b0:6c3:5496:3e06 with SMTP id 6a1803df08f44-6cbefffdfe6mr302613556d6.10.1729088595418;
        Wed, 16 Oct 2024 07:23:15 -0700 (PDT)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc2295b8fbsm18467386d6.75.2024.10.16.07.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 07:23:14 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <7f7b277a-7019-4bf4-b100-0505c6ce9737@redhat.com>
Date: Wed, 16 Oct 2024 10:23:14 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] rwsem: introduce upgrade_read interface
To: lizhe.67@bytedance.com, peterz@infradead.org, mingo@redhat.com,
 will@kernel.org, boqun.feng@gmail.com, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20241016043600.35139-1-lizhe.67@bytedance.com>
 <20241016043600.35139-2-lizhe.67@bytedance.com>
Content-Language: en-US
In-Reply-To: <20241016043600.35139-2-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/16/24 12:35 AM, lizhe.67@bytedance.com wrote:
> From: Li Zhe <lizhe.67@bytedance.com>
>
> Introduce a new rwsem interface upgrade_read(). We can call it
> to upgrade the lock into write rwsem lock after we get read lock.
> This interface will wait for all readers to exit before obtaining
> the write lock. In addition, this interface has a higher priority
> than any process waiting for the write lock and subsequent threads
> that want to obtain the read lock.
>
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> ---
>   include/linux/rwsem.h  |  1 +
>   kernel/locking/rwsem.c | 87 ++++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 85 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
> index c8b543d428b0..90183ab5ea79 100644
> --- a/include/linux/rwsem.h
> +++ b/include/linux/rwsem.h
> @@ -249,6 +249,7 @@ DEFINE_GUARD_COND(rwsem_write, _try, down_write_trylock(_T))
>    * downgrade write lock to read lock
>    */
>   extern void downgrade_write(struct rw_semaphore *sem);
> +extern int upgrade_read(struct rw_semaphore *sem);
>   
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   /*
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 2bbb6eca5144..0583e1be3dbf 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -37,6 +37,7 @@
>    * meanings when set.
>    *  - Bit 0: RWSEM_READER_OWNED - rwsem may be owned by readers (just a hint)
>    *  - Bit 1: RWSEM_NONSPINNABLE - Cannot spin on a reader-owned lock
> + *  - Bit 2: RWSEM_UPGRADING    - doing upgrade read process
>    *
>    * When the rwsem is reader-owned and a spinning writer has timed out,
>    * the nonspinnable bit will be set to disable optimistic spinning.
> @@ -62,7 +63,8 @@
>    */
>   #define RWSEM_READER_OWNED	(1UL << 0)
>   #define RWSEM_NONSPINNABLE	(1UL << 1)
> -#define RWSEM_OWNER_FLAGS_MASK	(RWSEM_READER_OWNED | RWSEM_NONSPINNABLE)
> +#define RWSEM_UPGRADING		(1UL << 2)
> +#define RWSEM_OWNER_FLAGS_MASK	(RWSEM_READER_OWNED | RWSEM_NONSPINNABLE | RWSEM_UPGRADING)
>   
>   #ifdef CONFIG_DEBUG_RWSEMS
>   # define DEBUG_RWSEMS_WARN_ON(c, sem)	do {			\
> @@ -93,7 +95,8 @@
>    * Bit  0    - writer locked bit
>    * Bit  1    - waiters present bit
>    * Bit  2    - lock handoff bit
> - * Bits 3-7  - reserved
> + * Bit  3    - upgrade read bit
> + * Bits 4-7  - reserved
>    * Bits 8-30 - 23-bit reader count
>    * Bit  31   - read fail bit
>    *
> @@ -117,6 +120,7 @@
>   #define RWSEM_WRITER_LOCKED	(1UL << 0)
>   #define RWSEM_FLAG_WAITERS	(1UL << 1)
>   #define RWSEM_FLAG_HANDOFF	(1UL << 2)
> +#define RWSEM_FLAG_UPGRADE_READ	(1UL << 3)
>   #define RWSEM_FLAG_READFAIL	(1UL << (BITS_PER_LONG - 1))
>   
>   #define RWSEM_READER_SHIFT	8
> @@ -143,6 +147,13 @@ static inline void rwsem_set_owner(struct rw_semaphore *sem)
>   	atomic_long_set(&sem->owner, (long)current);
>   }
>   
> +static inline void rwsem_set_owner_upgrade(struct rw_semaphore *sem)
> +{
> +	lockdep_assert_preemption_disabled();
> +	atomic_long_set(&sem->owner, (long)current | RWSEM_UPGRADING |
> +			RWSEM_READER_OWNED | RWSEM_NONSPINNABLE);
> +}

Because of possible  racing between 2 competing upgraders, read lock 
owner setting has to be atomic to avoid one overwriting the others.


> +
>   static inline void rwsem_clear_owner(struct rw_semaphore *sem)
>   {
>   	lockdep_assert_preemption_disabled();
> @@ -201,7 +212,7 @@ static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
>   	 */
>   	long count = atomic_long_read(&sem->count);
>   
> -	if (count & RWSEM_WRITER_MASK)
> +	if ((count & RWSEM_WRITER_MASK) && !(count & RWSEM_FLAG_UPGRADE_READ))
>   		return false;
>   	return rwsem_test_oflags(sem, RWSEM_READER_OWNED);
>   }
> @@ -1336,6 +1347,8 @@ static inline int __down_write_trylock(struct rw_semaphore *sem)
>   static inline void __up_read(struct rw_semaphore *sem)
>   {
>   	long tmp;
> +	unsigned long flags;
> +	struct task_struct *owner;
>   
>   	DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
>   	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
> @@ -1349,6 +1362,9 @@ static inline void __up_read(struct rw_semaphore *sem)
>   		clear_nonspinnable(sem);
>   		rwsem_wake(sem);
>   	}
> +	owner = rwsem_owner_flags(sem, &flags);
> +	if (unlikely(!(tmp & RWSEM_READER_MASK) && (flags & RWSEM_UPGRADING)))
> +		wake_up_process(owner);
>   	preempt_enable();
>   }
>   
> @@ -1641,6 +1657,71 @@ void downgrade_write(struct rw_semaphore *sem)
>   }
>   EXPORT_SYMBOL(downgrade_write);
>   
> +static inline void rwsem_clear_upgrade_flag(struct rw_semaphore *sem)
> +{
> +	atomic_long_andnot(RWSEM_FLAG_UPGRADE_READ, &sem->count);
> +}
> +
> +/*
> + * upgrade read lock to write lock
> + */
> +static inline int __upgrade_read(struct rw_semaphore *sem)
> +{
> +	long tmp;
> +
> +	preempt_disable();
> +
> +	tmp = atomic_long_read(&sem->count);
> +	do {
> +		if (tmp & (RWSEM_WRITER_MASK | RWSEM_FLAG_UPGRADE_READ)) {
> +			preempt_enable();
> +			return -EBUSY;
> +		}
> +	} while (!atomic_long_try_cmpxchg(&sem->count, &tmp,
> +		tmp + RWSEM_FLAG_UPGRADE_READ + RWSEM_WRITER_LOCKED - RWSEM_READER_BIAS));
> +
> +	if ((tmp & RWSEM_READER_MASK) == RWSEM_READER_BIAS) {
> +		/* fast path */
> +		DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
> +		rwsem_clear_upgrade_flag(sem);
> +		rwsem_set_owner(sem);
> +		preempt_enable();
> +		return 0;
> +	}
> +	/* slow path */
> +	raw_spin_lock_irq(&sem->wait_lock);
> +	rwsem_set_owner_upgrade(sem);
> +
> +	set_current_state(TASK_UNINTERRUPTIBLE);
> +
> +	for (;;) {
> +		if (!(atomic_long_read(&sem->count) & RWSEM_READER_MASK))
> +			break;
> +		raw_spin_unlock_irq(&sem->wait_lock);
> +		schedule_preempt_disabled();
> +		set_current_state(TASK_UNINTERRUPTIBLE);
> +		raw_spin_lock_irq(&sem->wait_lock);
> +	}
> +
> +	rwsem_clear_upgrade_flag(sem);
> +	rwsem_set_owner(sem);
> +	__set_current_state(TASK_RUNNING);
> +	raw_spin_unlock_irq(&sem->wait_lock);
> +	preempt_enable();
> +	return 0;
> +}
> +
> +/*
> + * upgrade read lock to write lock
> + *
> + * Return: 0 on success, error code on failure
> + */
> +int upgrade_read(struct rw_semaphore *sem)
> +{
> +	return __upgrade_read(sem);
> +}
> +EXPORT_SYMBOL(upgrade_read);

This new interface should have an API similar to a trylock. True if 
successful, false otherwise. I like the read_try_upgrade() name.

Another alternative that I have been thinking about is a down_read() 
variant with intention to upgrade later. This will ensure that only one 
active reader is allowed to upgrade later. With this, upgrade_read() 
will always succeed, maybe with some sleeping, as long as the correct 
down_read() is used.

Cheers,
Longman


