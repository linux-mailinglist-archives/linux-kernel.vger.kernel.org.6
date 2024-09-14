Return-Path: <linux-kernel+bounces-329488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AABE9791F5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 18:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5767FB22D7B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 16:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391A51D0950;
	Sat, 14 Sep 2024 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAqbX+yR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F6D1D017F
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726329982; cv=none; b=RjcVu3oCe+bg28Rd6w+3LTsT3xw38/DqNmDZSmD35fpdf6TOUTm0XC2KCiVbcpea9uhUHpEiNvRoR3u9qvRAQqXS/Hng0tpWjDuRmOUfRMjEvZczXdERt6qBZa48xcntY39qauOn9djbb7X6epkDyg4KMXROS/Wg52CcjC9jKWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726329982; c=relaxed/simple;
	bh=TljqEd9yNiLwM0v7ySo15FXq6oVo3z+duYsuQK8tEww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJM2TFUyAVRW6N8EjArOEiBXcjUsRAWKj+RsLzS+pmP6noZR6AYvYrFLz3xP4A4SX/yCSwQ2DeL9pE8BEQ+P1wR3/nZUh446p7+iROk/2F74EIbZEeIeeQRQOllO6YngfAEPs1HfuR6rQUslTBlvXYdBXG+Ph6My7xLqvtFjgpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FAqbX+yR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726329978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fBACIHMdv4gsMIGjVYYeuTIx95kSvZELA78ZIajE/oY=;
	b=FAqbX+yRQcAjn9iH+TKPxp9J2qK0uvQSz79i5rZN2HvolY2LPFDcuWBx93i5BMXcXmEuy4
	dlxZu9J8b84ExAmzSEGFok4JffjieciSdz8oSp7UtAD83ttglPeJNtW9i1g3BKJZUc5KIs
	BFvZJJXQy0d/NRTBqX3epEGjaZRPlVI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-UtIy5d6AMUGn26QG6bOsmg-1; Sat,
 14 Sep 2024 12:06:12 -0400
X-MC-Unique: UtIy5d6AMUGn26QG6bOsmg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A4331944AAB;
	Sat, 14 Sep 2024 16:06:10 +0000 (UTC)
Received: from [10.2.16.15] (unknown [10.2.16.15])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 470C330001AB;
	Sat, 14 Sep 2024 16:06:06 +0000 (UTC)
Message-ID: <74f04210-9f95-483e-a554-460140555cca@redhat.com>
Date: Sat, 14 Sep 2024 12:06:05 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] locking/osq_lock: Turn to dynamic switch function
 from osq_lock/unlock.
To: yongli-oc <yongli-oc@zhaoxin.com>, peterz@infradead.org,
 mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc: linux-kernel@vger.kernel.org, yongli@zhaoxin.com, louisqi@zhaoxin.com,
 cobechen@zhaoxin.com, jiangbowang@zhaoxin.com
References: <20240914085327.32912-1-yongli-oc@zhaoxin.com>
 <20240914085327.32912-3-yongli-oc@zhaoxin.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240914085327.32912-3-yongli-oc@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


On 9/14/24 04:53, yongli-oc wrote:
> To support numa-aware osq lock, the struct optimistic_spin_queue
> is accessed as three members, numa_enable, index, tail16, by union.
> The size of the struct is the same as before.
> If dynamic numa-ware lock enable, turns to the crossing, x_osq_lock to
> check contention level and starts dynamic switch.
>
> Signed-off-by: yongli-oc <yongli-oc@zhaoxin.com>
> ---
>   include/linux/osq_lock.h  | 33 ++++++++++++++++++++-
>   kernel/locking/osq_lock.c | 62 +++++++++++++++++++++++++++++++++++++--
>   2 files changed, 91 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/osq_lock.h b/include/linux/osq_lock.h
> index ea8fb31379e3..37a7bc4ab530 100644
> --- a/include/linux/osq_lock.h
> +++ b/include/linux/osq_lock.h
> @@ -12,14 +12,42 @@ struct optimistic_spin_queue {
>   	 * Stores an encoded value of the CPU # of the tail node in the queue.
>   	 * If the queue is empty, then it's set to OSQ_UNLOCKED_VAL.
>   	 */
> +#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
> +	union {
> +		atomic_t tail;
> +		u32 val;
> +#ifdef __LITTLE_ENDIAN
> +		struct {
> +			u16 tail16;
> +			u8 index;
> +			u8 numa_enable;
> +		};
> +#else
> +		struct {
> +			u8 numa_enable;
> +			u8 index;
> +			u16 tail16;
> +		};
> +#endif
> +	};
> +#else
>   	atomic_t tail;
> +#endif
>   };
>   
>   #define OSQ_UNLOCKED_VAL (0)
>   
>   /* Init macro and function. */
> +#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
> +
> +#define OSQ_LOCK_UNLOCKED { .tail = ATOMIC_INIT(OSQ_UNLOCKED_VAL) }
> +
> +#else
> +
>   #define OSQ_LOCK_UNLOCKED { ATOMIC_INIT(OSQ_UNLOCKED_VAL) }
>   
> +#endif
> +
>   static inline void osq_lock_init(struct optimistic_spin_queue *lock)
>   {
>   	atomic_set(&lock->tail, OSQ_UNLOCKED_VAL);
> @@ -28,9 +56,12 @@ static inline void osq_lock_init(struct optimistic_spin_queue *lock)
>   extern bool osq_lock(struct optimistic_spin_queue *lock);
>   extern void osq_unlock(struct optimistic_spin_queue *lock);
>   
> +#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
> +extern bool osq_is_locked(struct optimistic_spin_queue *lock);
> +#else
>   static inline bool osq_is_locked(struct optimistic_spin_queue *lock)
>   {
>   	return atomic_read(&lock->tail) != OSQ_UNLOCKED_VAL;
>   }
> -
> +#endif
>   #endif
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index 75a6f6133866..a7b516939e00 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -2,7 +2,10 @@
>   #include <linux/percpu.h>
>   #include <linux/sched.h>
>   #include <linux/osq_lock.h>
> -
> +#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
> +#include "numa.h"
> +#include "numa_osq.h"
> +#endif

These header files are defined in patch 3. You need to rethink about 
patch ordering in order not to break bisection.


>   /*
>    * An MCS like lock especially tailored for optimistic spinning for sleeping
>    * lock implementations (mutex, rwsem, etc).
> @@ -12,12 +15,34 @@
>    * spinning.
>    */
>   
> +#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
> +DEFINE_PER_CPU_SHARED_ALIGNED(struct optimistic_spin_node, osq_node);
> +/*
> + * We use the value 0 to represent "no CPU", thus the encoded value
> + * will be the CPU number incremented by 1.
> + */
> +inline int encode_cpu(int cpu_nr)
> +{
> +	return cpu_nr + 1;
> +}
> +
> +inline int node_cpu(struct optimistic_spin_node *node)
> +{
> +	return node->cpu - 1;
> +}
> +
> +inline struct optimistic_spin_node *decode_cpu(int encoded_cpu_val)
> +{
> +	int cpu_nr = encoded_cpu_val - 1;
> +
> +	return per_cpu_ptr(&osq_node, cpu_nr);
> +}
> +#else
>   struct optimistic_spin_node {
>   	struct optimistic_spin_node *next, *prev;
>   	int locked; /* 1 if lock acquired */
>   	int cpu; /* encoded CPU # + 1 value */
>   };
> -
>   static DEFINE_PER_CPU_SHARED_ALIGNED(struct optimistic_spin_node, osq_node);
>   
>   /*
> @@ -40,6 +65,7 @@ static inline struct optimistic_spin_node *decode_cpu(int encoded_cpu_val)
>   
>   	return per_cpu_ptr(&osq_node, cpu_nr);
>   }
> +#endif
>   
>   /*
>    * Get a stable @node->next pointer, either for unlock() or unqueue() purposes.
> @@ -97,6 +123,14 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>   	int curr = encode_cpu(smp_processor_id());
>   	int old;
>   
> +#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
> +	if (unlikely(enable_zx_numa_osq_lock > 1)) {
> +		node->numa = 1;
> +		return x_osq_lock(lock);
> +	}
> +	node->numa = 0;
> +#endif
> +
>   	node->locked = 0;
>   	node->next = NULL;
>   	node->cpu = curr;
> @@ -108,6 +142,11 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>   	 * the lock tail.
>   	 */
>   	old = atomic_xchg(&lock->tail, curr);
> +#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
> +	if (enable_zx_numa_osq_lock > 0)
> +	//enable means all cpu cores are less tan 65534.
> +		old = old & 0xffff;
> +#endif
>   	if (old == OSQ_UNLOCKED_VAL)
>   		return true;
>   
> @@ -212,6 +251,14 @@ void osq_unlock(struct optimistic_spin_queue *lock)
>   	struct optimistic_spin_node *node, *next;
>   	int curr = encode_cpu(smp_processor_id());
>   
> +	node = this_cpu_ptr(&osq_node);
> +
> +#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
> +	if (unlikely(enable_zx_numa_osq_lock > 1 &&
> +		node->numa == 1))
> +		return x_osq_unlock(lock);
> +#endif
> +
>   	/*
>   	 * Fast path for the uncontended case.
>   	 */
> @@ -222,7 +269,6 @@ void osq_unlock(struct optimistic_spin_queue *lock)
>   	/*
>   	 * Second most likely case.
>   	 */
> -	node = this_cpu_ptr(&osq_node);
>   	next = xchg(&node->next, NULL);
>   	if (next) {
>   		WRITE_ONCE(next->locked, 1);
> @@ -233,3 +279,13 @@ void osq_unlock(struct optimistic_spin_queue *lock)
>   	if (next)
>   		WRITE_ONCE(next->locked, 1);
>   }
> +#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
> +bool osq_is_locked(struct optimistic_spin_queue *lock)
> +{
> +	if (unlikely(enable_zx_numa_osq_lock > 1))
> +		return x_osq_is_locked(lock);
> +	return atomic_read(&lock->tail) != OSQ_UNLOCKED_VAL;
> +}
> +#endif
> +
> +


