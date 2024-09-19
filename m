Return-Path: <linux-kernel+bounces-333373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B76597C78F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A9E1F29D34
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E0019E7E0;
	Thu, 19 Sep 2024 09:49:05 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4383D1A4F3F
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726739342; cv=none; b=dsb0fxkSGugOeTysFPZ6GZXEYwU7TVok0BAdBr+5Ix+RZ7JHPbV5dCVRMTLa39Olf+4ScnEHgizsrOTptCHUPJk4q77DOd5ssyAyoEx3mfC5hhzeK3FrQI8L74IBICN5TZQoPPDfDOvxoV1f1MqSjnKc97qVaBrqAg6o4YbXcGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726739342; c=relaxed/simple;
	bh=UxTxI8xAy8hGALZePbM0oxlxaCLZ8FIgXzTglErXVls=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=ZRXcmZUNubM7iWXOlAkj+V6aONJI8KFt4c8xjjz+lrhHtPtB7cPu/KqWsoU5gzCXVLe2Ds2jbIpZ+V1Nwlzxb4pstFUdSgemUeMVZP+9v1t/uNLxQ5mf0HOBCu5N69MaHagQz6OOrexeFMLFaDGRr2SIMjdhbYr41FprQW9KHhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1726739331-1eb14e31a71112d0001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id 6jxlJAdMy5hq2gTm (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 19 Sep 2024 17:48:51 +0800 (CST)
X-Barracuda-Envelope-From: YongLi-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 17:48:51 +0800
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 17:48:50 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Thu, 19 Sep 2024 17:48:50 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
Received: from [10.29.8.43] (10.29.8.43) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 19 Sep
 2024 17:35:31 +0800
Message-ID: <41806261-1633-4ec6-8cca-fc3d61d5d4bc@zhaoxin.com>
Date: Thu, 19 Sep 2024 17:35:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: yongli-os <yongli-oc@zhaoxin.com>
Subject: Re: [PATCH 3/4] locking/osq_lock: From x_osq_lock/unlock to
 numa-aware lock/unlock.
To: Waiman Long <longman@redhat.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <will@kernel.org>, <boqun.feng@gmail.com>
X-ASG-Orig-Subj: Re: [PATCH 3/4] locking/osq_lock: From x_osq_lock/unlock to
 numa-aware lock/unlock.
CC: <linux-kernel@vger.kernel.org>, <yongli@zhaoxin.com>,
	<louisqi@zhaoxin.com>, <cobechen@zhaoxin.com>, <jiangbowang@zhaoxin.com>
References: <20240914085327.32912-1-yongli-oc@zhaoxin.com>
 <20240914085327.32912-4-yongli-oc@zhaoxin.com>
 <0fd3eede-a782-4e69-ab76-9822ae864dbe@redhat.com>
Content-Language: en-US
In-Reply-To: <0fd3eede-a782-4e69-ab76-9822ae864dbe@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 9/19/2024 5:48:49 PM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1726739331
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 41923
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.130665
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------


On 2024/9/15 01:11, Waiman Long wrote:
>
>
> [=E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E6=9D=A5=E8=87=AA=E5=A4=96=E9=83=A8=
=E5=8F=91=E4=BB=B6=E4=BA=BA =E8=B0=A8=E9=98=B2=E9=A3=8E=E9=99=A9]
>
> On 9/14/24 04:53, yongli-oc wrote:
>> According to the contention level, switches from x_osq_lock to
>> numa-aware osq_lock.
>> The numa-aware lock is a two level osq_lock.
>> The Makefile for dynamic numa-aware osq lock.
>>
>> Signed-off-by: yongli-oc <yongli-oc@zhaoxin.com>
>> ---
>> =C2=A0 kernel/locking/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 1 +
>> =C2=A0 kernel/locking/numa.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 98 ++++++++
>> =C2=A0 kernel/locking/numa_osq.h=C2=A0=C2=A0=C2=A0 |=C2=A0 32 +++
>> =C2=A0 kernel/locking/x_osq_lock.c=C2=A0 | 332 +++++++++++++++++++++++++=
++
>> =C2=A0 kernel/locking/zx_numa_osq.c | 433 ++++++++++++++++++++++++++++++=
+++++
>> =C2=A0 5 files changed, 896 insertions(+)
>> =C2=A0 create mode 100644 kernel/locking/numa.h
>> =C2=A0 create mode 100644 kernel/locking/numa_osq.h
>> =C2=A0 create mode 100644 kernel/locking/x_osq_lock.c
>> =C2=A0 create mode 100644 kernel/locking/zx_numa_osq.c
>>
>> diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
>> index 0db4093d17b8..00c1d5bb6eb9 100644
>> --- a/kernel/locking/Makefile
>> +++ b/kernel/locking/Makefile
>> @@ -22,6 +22,7 @@ obj-$(CONFIG_LOCKDEP) +=3D lockdep_proc.o
>> =C2=A0 endif
>> =C2=A0 obj-$(CONFIG_SMP) +=3D spinlock.o
>> =C2=A0 obj-$(CONFIG_LOCK_SPIN_ON_OWNER) +=3D osq_lock.o
>> +obj-$(CONFIG_LOCK_SPIN_ON_OWNER_NUMA) +=3D x_osq_lock.o zx_numa_osq.o=20
>> zx_numa.o
>> =C2=A0 obj-$(CONFIG_PROVE_LOCKING) +=3D spinlock.o
>> =C2=A0 obj-$(CONFIG_QUEUED_SPINLOCKS) +=3D qspinlock.o
>> =C2=A0 obj-$(CONFIG_RT_MUTEXES) +=3D rtmutex_api.o
>> diff --git a/kernel/locking/numa.h b/kernel/locking/numa.h
>> new file mode 100644
>> index 000000000000..01e5aef3257a
>> --- /dev/null
>> +++ b/kernel/locking/numa.h
>> @@ -0,0 +1,98 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __LINUX_NUMA_LOCK_H
>> +#define __LINUX_NUMA_LOCK_H
>> +#include "mcs_spinlock.h"
>> +
>> +struct optimistic_spin_node {
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct optimistic_spin_node *next, *prev;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int numa;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int locked; /* 1 if lock acquired */
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int cpu; /* encoded CPU # + 1 value */
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u32 serial;
>> +};
>> +
>> +
>> +struct _numa_buf {
>> +=C2=A0=C2=A0=C2=A0=C2=A0 void *numa_ptr;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head list;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u32 lockaddr;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u32 highaddr;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u8 idle;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u8 type;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u16 index;
>> +};
>> +
>> +struct cache_padding {
>> +=C2=A0=C2=A0=C2=A0=C2=A0 char x[0];
>> +} ____cacheline_internodealigned_in_smp;
>> +#define CACHE_PADDING(name)=C2=A0 struct cache_padding name
> We have struct cacheline_padding and CACHELINE_PADDING() in
> include/linux/cache. What is the point of reinventing the same thing=20
> here?
I will include the linux/cache.h header, and delete the definition above.
>> +
>> +struct _numa_lock {
>> +=C2=A0=C2=A0=C2=A0=C2=A0 atomic_t tail ____cacheline_aligned_in_smp;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 atomic_t addr;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u8 shift;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u8 stopping;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u16 numa_nodes;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u32 accessed;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t totalaccessed;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u32 nodeswitched;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 atomic_t initlock;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 atomic_t pending;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 union {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct mcs_spinlock mcs_node;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct optimistic_spin_node osq_node;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 };
>> +=C2=A0=C2=A0=C2=A0=C2=A0 CACHE_PADDING(pad);
>> +};
>> +
>> +struct numa_cpu_info {
>> +=C2=A0=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0 x86_model;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 /* CPU family */
>> +=C2=A0=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0 x86;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 /* CPU vendor */
>> +=C2=A0=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0 x86_vendor;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0 x86_reserved;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u32=C2=A0=C2=A0=C2=A0=C2=A0 feature1;
>> +};
>> +
>> +#define NUMAEXPAND 1
>> +
>> +#define COHORT_START 1
>> +#define ACQUIRE_NUMALOCK (UINT_MAX-1)
>> +#define NODE_WAIT UINT_MAX
>> +#define LOCK_NUMALOCK 1
>> +#define UNLOCK_NUMALOCK 0
>> +
>> +#define NUMALOCKDYNAMIC 0xff
>> +#define TURNTONUMAREADY 0xa5a5
>> +#define NUMATURNBACKREADY 0x5a5a
>> +
>> +#define NUMA_LOCKED_VAL 0xf5efef
> What are these special bit values for?

It is value for NUMA lock state, the value has no special mean,

any value is OK.=C2=A0 I will change it to some ordinary value.


>> +#define NUMA_UNLOCKED_VAL 0
>> +
>> +#define NUMASTEERMASK 0xf0000000
>> +#define HIGH32BITMASK 0xffffffff00000000
>> +#define LOW32MASK 0xffffffff
>> +
>> +extern int NUMASHIFT;
>> +extern int NUMACLUSTERS;
> In the kernel, uppercase names are used for macros. Variables should use
> all lowercase names to avoid confusion.
Yes, I will change to lowercase.
>> +extern int zx_numa_lock_total;
>> +extern struct _numa_buf *zx_numa_entry;
>> +extern atomic_t numa_count;
>> +extern int enable_zx_numa_osq_lock;
>> +extern u32 zx_numa_lock;
>> +extern int dynamic_enable;
>> +extern struct kmem_cache *zx_numa_lock_cachep;
>> +
>> +static inline u32 ptrmask(void *s)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 return (uint64_t)s & LOW32MASK;
>> +}
>> +inline void *get_numa_lock(int index);
>> +
>> +int zx_check_numa_dynamic_locked(u32 lockaddr, struct _numa_lock=20
>> *_numa_lock,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 int t);
>> +int zx_numa_lock_ptr_get(void *p);
>> +void numa_lock_init_data(struct _numa_lock *s, int clusters, u32=20
>> lockval,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 u32 lockaddr);
>> +#endif
>> diff --git a/kernel/locking/numa_osq.h b/kernel/locking/numa_osq.h
>> new file mode 100644
>> index 000000000000..4c99ad60c4e0
>> --- /dev/null
>> +++ b/kernel/locking/numa_osq.h
>> @@ -0,0 +1,32 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __LINUX_NUMA_OSQ_H
>> +#define __LINUX_NUMA_OSQ_H
>> +
>> +#include <linux/osq_lock.h>
>> +#include "mcs_spinlock.h"
>> +
>> +#define OSQLOCKINITED 0
>> +#define OSQTONUMADETECT 0x10
>> +#define OSQLOCKSTOPPING 0xfc
>> +#define OSQ_LOCKED_VAL 0xffff
>> +
>> +extern u16 osq_keep_times;
>> +extern u16 osq_lock_depth;
>> +extern int osq_node_max;
>> +
>> +inline int encode_cpu(int cpu_nr);
>> +inline int node_cpu(struct optimistic_spin_node *node);
>> +inline struct optimistic_spin_node *decode_cpu(int encoded_cpu_val);
>> +
>> +void zx_osq_lock_stopping(struct optimistic_spin_queue *lock);
>> +void zx_osq_numa_start(struct optimistic_spin_queue *lock);
>> +void zx_osq_turn_numa_waiting(struct optimistic_spin_queue *lock);
>> +
>> +bool x_osq_lock(struct optimistic_spin_queue *lock);
>> +void x_osq_unlock(struct optimistic_spin_queue *lock);
>> +bool x_osq_is_locked(struct optimistic_spin_queue *lock);
>> +inline void zx_numa_osq_unlock(struct optimistic_spin_queue *qslock,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct _numa_lock *n);
>> +inline bool zx_numa_osq_lock(struct optimistic_spin_queue *qslock,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct _numa_lock *n);
>> +#endif
>> diff --git a/kernel/locking/x_osq_lock.c b/kernel/locking/x_osq_lock.c
>> new file mode 100644
>> index 000000000000..6da8905ae7d6
>> --- /dev/null
>> +++ b/kernel/locking/x_osq_lock.c
>> @@ -0,0 +1,332 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * crossing from osq_lock to numa-aware lock
>> + */
>> +#include <linux/percpu.h>
>> +#include <linux/sched.h>
>> +#include <linux/osq_lock.h>
>> +#include "numa.h"
>> +#include "numa_osq.h"
>> +
>> +u16 osq_lock_depth =3D 8;
>> +u16 osq_keep_times =3D 32;
>> +
>> +/*
>> + * An MCS like lock especially tailored for optimistic spinning for=20
>> sleeping
>> + * lock implementations (mutex, rwsem, etc).
>> + *
>> + * Using a single mcs node per CPU is safe because sleeping locks=20
>> should not be
>> + * called from interrupt context and we have preemption disabled while
>> + * spinning.
>> + */
>> +DECLARE_PER_CPU_SHARED_ALIGNED(struct optimistic_spin_node, osq_node);
>> +
>> +/*
>> + * Get a stable @node->next pointer, either for unlock() or=20
>> unqueue() purposes.
>> + * Can return NULL in case we were the last queued and we updated=20
>> @lock instead.
>> + *
>> + * If osq_lock() is being cancelled there must be a previous node
>> + * and 'old_cpu' is its CPU #.
>> + * For osq_unlock() there is never a previous node and old_cpu is
>> + * set to OSQ_UNLOCKED_VAL.
>> + */
>> +static inline struct optimistic_spin_node *
>> +osq_wait_next_stop(struct optimistic_spin_queue *lock,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct opt=
imistic_spin_node *node,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int old_cp=
u)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u16 curr =3D encode_cpu(smp_processor_id());
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u16 old =3D old_cpu;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (lock->numa_enable =3D=3D OSQLOCKSTOPPING &=
& old =3D=3D=20
>> OSQ_UNLOCKED_VAL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 old =3D OSQ_LOCKED_VAL;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 for (;;) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (READ_ONCE(lock->tail16) =3D=3D curr &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmpxchg(&lock->tail16, curr, old) =3D=3D curr) =
{
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We were the las=
t queued, we moved @lock=20
>> back. @prev
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * will now observ=
e @lock and will complete its
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * unlock()/unqueu=
e().
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * We must xchg() the @node->next value, because if we=20
>> were to
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * leave it in, a concurrent unlock()/unqueue() from
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * @node->next might complete Step-A and think its=20
>> @prev is
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * still valid.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * If the concurrent unlock()/unqueue() wins the race,=20
>> we'll
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * wait for either @lock to point to us, through its=20
>> Step-B, or
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * wait for a new @node->next from its Step-C.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (node->next) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct optimistic_spin_=
node *next;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next =3D xchg(&node->ne=
xt, NULL);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (next)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return next;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cpu_relax();
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +}
>> +
>> +bool x_osq_lock(struct optimistic_spin_queue *lock)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct optimistic_spin_node *node =3D this_cpu=
_ptr(&osq_node);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct optimistic_spin_node *prev, *next;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int cpu =3D smp_processor_id();
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u16 curr =3D encode_cpu(cpu);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct optimistic_spin_queue tail;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u16 old;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 tail.val =3D READ_ONCE(lock->val);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(tail.numa_enable =3D=3D OSQLOCKST=
OPPING)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 zx_osq_turn_numa_waiting(lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return x_osq_lock(lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(tail.numa_enable =3D=3D NUMALOCKD=
YNAMIC)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct _numa_lock *_numa_lock =3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct _numa_lock *node_lock =3D NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 _numa_lock =3D get_numa_lock(tail.index);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 node_lock =3D (struct _numa_lock *) _numa_lock +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (c=
pu >> NUMASHIFT);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 prefetch(node_lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return zx_numa_osq_lock(lock, _numa_lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 node->locked =3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 node->next =3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 node->cpu =3D curr;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We need both ACQUIRE (pairs with corre=
sponding RELEASE in
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * unlock() uncontended, or fastpath) and=
 RELEASE (to publish
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the node fields we just initialised) s=
emantics when updating
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the lock tail.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (likely(tail.numa_enable >=3D OSQTONUMADETE=
CT)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct optimistic_spin_queue ss;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 while (1) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ss.val =3D atomic_read(=
&lock->tail);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ss.tail16 =3D=3D OS=
Q_LOCKED_VAL) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 zx_osq_turn_numa_waiting(lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return x_osq_lock(lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cmpxchg(&lock->tail=
16, ss.tail16, curr)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D=3D ss.tail16) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 old =3D ss.tail16;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_relax();
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0 } else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 old =3D xchg(&lock->tail16, curr);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (old =3D=3D OSQ_UNLOCKED_VAL) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 node->serial =3D 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return true;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 prev =3D decode_cpu(old);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 node->prev =3D prev;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 node->serial =3D prev->serial + 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * osq_lock()=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 unqueue
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * node->prev =3D prev=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 osq_wait_next()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * WMB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MB
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * prev->next =3D node=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next->prev =3D prev // unq=
ueue-C
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Here 'node->prev' and 'next->prev' are=
 the same variable and=20
>> we need
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * to ensure these stores happen in-order=
 to avoid corrupting=20
>> the list.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0 smp_wmb();
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 WRITE_ONCE(prev->next, node);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Normally @prev is untouchable after th=
e above store; because=20
>> at that
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * moment unlock can proceed and wipe the=
 node element from stack.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * However, since our nodes are static pe=
r-cpu storage, we're
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * guaranteed their existence -- this all=
ows us to apply
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * cmpxchg in an attempt to undo our queu=
eing.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Wait to acquire the lock or cancellati=
on. Note that=20
>> need_resched()
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * will come with an IPI, which will wake=
=20
>> smp_cond_load_relaxed() if it
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * is implemented with a monitor-wait. vc=
pu_is_preempted()=20
>> relies on
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * polling, be careful.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (smp_cond_load_relaxed(&node->locked, VAL |=
| need_resched() ||
>> + vcpu_is_preempted(node_cpu(node->prev))))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return true;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 /* unqueue */
>> +=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Step - A=C2=A0 -- stabilize @prev
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Undo our @prev->next assignment; this =
will make @prev's
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * unlock()/unqueue() wait for a next poi=
nter since @lock=20
>> points to us
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * (or later).
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 for (;;) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * cpu_relax() below implies a compiler barrier which=20
>> would
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * prevent this comparison being optimized away.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (data_race(prev->next) =3D=3D node &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmpxchg(&prev->next, node, NULL) =3D=3D node)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * We can only fail the cmpxchg() racing against an=20
>> unlock(),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * in which case we should observe @node->locked becoming
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * true.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (smp_load_acquire(&node->locked))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cpu_relax();
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * Or we race against a concurrent unqueue()'s step-B,=20
>> in which
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 * case its step-C will write us a new @node->prev=20
>> pointer.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 prev =3D READ_ONCE(node->prev);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Step - B -- stabilize @next
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Similar to unlock(), wait for @node->n=
ext or move @lock from=20
>> @node
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * back to @prev.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 next =3D osq_wait_next_stop(lock, node, prev->=
cpu);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (!next)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return false;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Step - C -- unlink
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * @prev is stable because its still wait=
ing for a new @prev->next
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * pointer, @next is stable because our @=
node->next pointer is=20
>> NULL and
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * it will wait in Step-A.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 WRITE_ONCE(next->prev, prev);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 WRITE_ONCE(prev->next, next);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>> +}
>> +
>> +
>> +
>> +void x_osq_unlock(struct optimistic_spin_queue *lock)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct optimistic_spin_node *node, *next;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int threadshold =3D osq_lock_depth;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int cpu =3D smp_processor_id();
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u16 curr =3D encode_cpu(cpu);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int depth =3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u32 count =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(lock->numa_enable =3D=3D NUMALOCK=
DYNAMIC)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct _numa_lock *_numa_lock =3D=20
>> get_numa_lock(lock->index);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 prefetch((struct _numa_lock *) _numa_lock + (cpu >>=20
>> NUMASHIFT));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return zx_numa_osq_unlock(lock, _numa_lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Fast path for the uncontended case.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(lock->numa_enable =3D=3D OSQTONUM=
ADETECT)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct optimistic_spin_node *node_last =3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 u16 tail =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 tail =3D cmpxchg(&lock->tail16, curr, OSQ_UNLOCKED_VAL);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (tail =3D=3D curr)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 node =3D this_cpu_ptr(&osq_node);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 node_last =3D decode_cpu(tail);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 depth =3D node_last->serial - node->serial;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 count =3D READ_ONCE(node->locked);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (count > osq_keep_times && (dynamic_enable & 0x1))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zx_osq_lock_stopping(lo=
ck);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 } else if (unlikely(lock->numa_enable =3D=3D O=
SQLOCKSTOPPING)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (cmpxchg(&lock->tail16, curr, OSQ_LOCKED_VAL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
=3D=3D curr) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zx_osq_numa_start(lock)=
;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct optimistic_spin_queue t;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 t.val =3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (dynamic_enable & 0x1) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (atomic_read(&numa_c=
ount) < zx_numa_lock_total)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 t.numa_enable =3D OSQTONUMADETECT;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (t.numa_enable =3D=3D OSQTONUMADETECT) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (atomic_cmpxchg_rele=
ase(&lock->tail, curr,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (t.val | OSQ_UNLOCKED_VAL)) =3D=3D curr)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 } else if (cmpxchg(&lock->tail16, curr,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 OSQ_UNLOCKED_VAL) =3D=3D curr)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Second most likely case.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0 node =3D this_cpu_ptr(&osq_node);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 next =3D xchg(&node->next, NULL);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (next) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (depth > threadshold)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WRITE_ONCE(next->locked=
, count + 1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WRITE_ONCE(next->locked=
, 1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 next =3D osq_wait_next_stop(lock, node, OSQ_UN=
LOCKED_VAL);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (next) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (depth > threadshold)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WRITE_ONCE(next->locked=
, count + 1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WRITE_ONCE(next->locked=
, 1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +}
>> +
>> +bool x_osq_is_locked(struct optimistic_spin_queue *lock)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct optimistic_spin_queue val;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 val.val =3D atomic_read(&lock->tail);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (val.tail16 =3D=3D OSQ_UNLOCKED_VAL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return false;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (val.tail16 =3D=3D OSQ_LOCKED_VAL) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (val.numa_enable !=3D NUMALOCKDYNAMIC)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return zx_check_numa_dynamic_locked(ptrmask(lock),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ge=
t_numa_lock(val.index), 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>> +}
> These functions are mostly based on the=C2=A0 osq_* functions with some e=
xtra
> code stuffed in. Common code should be shared instead of duplicated.

It uses 16 bit tail, if merge to the osq_lock, it will make osq_lock=20
changes too much.

>> diff --git a/kernel/locking/zx_numa_osq.c b/kernel/locking/zx_numa_osq.c
>> new file mode 100644
>> index 000000000000..f4c3dba208d3
>> --- /dev/null
>> +++ b/kernel/locking/zx_numa_osq.c
>> @@ -0,0 +1,433 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Dynamic numa-aware osq lock
>> + * Author: LiYong <yongli-oc@zhaoxin.com>
>> + *
>> + */
>> +#include <linux/cpumask.h>
>> +#include <asm/byteorder.h>
>> +#include <linux/percpu.h>
>> +#include <linux/sched.h>
>> +#include <linux/slab.h>
>> +#include <linux/osq_lock.h>
>> +#include "numa.h"
>> +#include "numa_osq.h"
>> +
>> +int osq_node_max =3D 256;
>> +
>> +/*
>> + * The pending bit spinning loop count.
>> + * This heuristic is used to limit the number of lockword accesses
>> + * made by atomic_cond_read_relaxed when waiting for the lock to
>> + * transition out of the "=3D=3D _Q_PENDING_VAL" state. We don't spin
>> + * indefinitely because there's no guarantee that we'll make forward
>> + * progress.
>> + */
>> +
>> +static DEFINE_PER_CPU_SHARED_ALIGNED(struct optimistic_spin_node,=20
>> osq_cpu_node);
>> +
>> +/*
>> + * We use the value 0 to represent "no CPU", thus the encoded value
>> + * will be the CPU number incremented by 1.
>> + */
>> +static inline int decode(int cpu_nr)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 return cpu_nr - 1;
>> +}
>> +
>> +static inline struct optimistic_spin_node *decode_curr(int=20
>> encoded_cpu_val)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int cpu_nr =3D decode(encoded_cpu_val);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 return per_cpu_ptr(&osq_cpu_node, cpu_nr);
>> +}
>> +
>> +static int atomic64_cmpxchg_notequal(void *qslock, atomic_t *tail,=20
>> int curr)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u64 ss =3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u32 addr =3D ptrmask(qslock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u64 addrcurr =3D (((u64)addr) << 32) | curr;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 while (1) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ss =3D atomic64_read((atomic64_t *) tail);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if ((ss >> 32) !=3D addr)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NUMA_LOCKED_VAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if ((ss & LOW32MASK) =3D=3D NUMA_LOCKED_VAL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NUMA_LOCKED_VAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (atomic64_cmpxchg((atomic64_t *) tail, ss, addrcurr)=20
>> =3D=3D ss)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ss & LOW32MASK;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cpu_relax();
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +}
>> +
>> +void zx_osq_lock_stopping(struct optimistic_spin_queue *lock)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int s =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 s =3D zx_numa_lock_ptr_get(lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (s < zx_numa_lock_total) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 numa_lock_init_data(zx_numa_entry[s].numa_ptr,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NUMACLUSTERS, NUMA_UNLO=
CKED_VAL,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptrmask(lock));
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 WRITE_ONCE(lock->index, s);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 zx_numa_entry[s].type =3D 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 smp_mb();/*should set these before enable*/
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 prefetchw(&lock->numa_enable);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 WRITE_ONCE(lock->numa_enable, OSQLOCKSTOPPING);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 prefetchw(&lock->numa_enable);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 WRITE_ONCE(lock->numa_enable, OSQLOCKINITED);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +}
>> +
>> +void zx_osq_numa_start(struct optimistic_spin_queue *lock)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct _numa_lock *_numa_lock =3D get_numa_loc=
k(lock->index);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 prefetchw(&lock->numa_enable);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 WRITE_ONCE(lock->numa_enable, NUMALOCKDYNAMIC)=
;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 smp_mb(); /*should keep lock->numa_enable modi=
fied first*/
>> +=C2=A0=C2=A0=C2=A0=C2=A0 atomic_set(&_numa_lock->initlock, TURNTONUMARE=
ADY);
>> +}
>> +
>> +
>> +void zx_osq_turn_numa_waiting(struct optimistic_spin_queue *lock)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct _numa_lock *_numa_lock =3D get_numa_loc=
k(lock->index);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 atomic_inc(&_numa_lock->pending);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 while (1) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 int s =3D atomic_read(&_numa_lock->initlock);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (s =3D=3D TURNTONUMAREADY)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cpu_relax();
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cpu_relax();
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cpu_relax();
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cpu_relax();
> We don't usually call cpu_relax() multiple times like that as the actual
> delay is CPU dependent and it is hard to get it right for all. Can you
> explain why it is called exactly 4 times here?

The cpu_relax() is REP NOP. Form the intel instruction set,=C2=A0 the REP N=
OP=20
is PAUSE.

The PAUSE instruction can save some power for the processor. So I often=20
write more

 =C2=A0cpu_relax() when busy waiting.

I will change to one cpu_relax(), according to Linux kernel habits.

>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0 atomic_dec(&_numa_lock->pending);
>> +}
>> +
>> +
>> +
>> +
>> +static struct optimistic_spin_node *
>> +zx_numa_osq_wait_next(struct _numa_lock *lock,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct optimistic_spin_node *node,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct optimistic_spin_node *prev, int cpu)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct optimistic_spin_node *next =3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int curr =3D encode_cpu(cpu);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int old;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 old =3D prev ? prev->cpu : OSQ_UNLOCKED_VAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 for (;;) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (atomic_read(&lock->tail) =3D=3D curr &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_cmpxchg_acquire(&lock->tail, curr, old) =
=3D=3D=20
>> curr) {
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (node->next) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next =3D xchg(&node->ne=
xt, NULL);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (next)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cpu_relax();
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0 return next;
>> +}
>> +static void zx_numa_turn_osq_waiting(struct optimistic_spin_queue=20
>> *lock,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct _numa_lock *_num=
a_lock)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct _numa_lock *numa_lock =3D _numa_lock +=
=20
>> _numa_lock->numa_nodes;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int lockaddr =3D ptrmask(lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u64 s =3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct optimistic_spin_queue tail;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 tail.numa_enable =3D NUMALOCKDYNAMIC;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 tail.index =3D lock->index;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 tail.tail16 =3D OSQ_LOCKED_VAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 while (1) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cpu_relax(); cpu_relax(); cpu_relax(); cpu_relax();
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 s =3D atomic64_read((atomic64_t *) &numa_lock->tail);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if ((s >> 32) !=3D lockaddr)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if ((s & LOW32MASK) =3D=3D NUMA_LOCKED_VAL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0 prefetchw(&lock->tail);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (atomic_cmpxchg(&lock->tail, tail.val, OSQ_=
UNLOCKED_VAL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=3D tail.val) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +}
>> +
>> +static int _zx_node_osq_lock_internal(struct optimistic_spin_queue=20
>> *qslock,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct optimistic_spin_node *node, struct opti=
mistic_spin_node=20
>> *prev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct _numa_lock *node_lock, int cpu, int *cu=
r_status)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct optimistic_spin_node *next =3D NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 for (;;) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct optimistic_spin_node *node_prev =3D NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (prev->next =3D=3D node &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmpxchg(&prev->next, node, NULL) =3D=3D node) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /*load locked first each time*/
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *cur_status =3D smp_load_acquire(&node->locked);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (*cur_status !=3D NODE_WAIT)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0; //goto NODE_U=
NLOCK;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cpu_relax();
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 node_prev =3D READ_ONCE(node->prev);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (node_prev !=3D prev)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prev =3D node_prev;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 next =3D zx_numa_osq_wait_next(node_lock, node=
, prev, cpu);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (!next)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return -1;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 WRITE_ONCE(next->prev, prev);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 WRITE_ONCE(prev->next, next);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>> +}
>> +
>> +static int _zx_node_osq_lock(struct optimistic_spin_queue *qslock,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ruct _numa_lock *_numa_lock)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct optimistic_spin_node *node =3D this_cpu=
_ptr(&osq_cpu_node);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct optimistic_spin_node *prev =3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int cpu =3D smp_processor_id();
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int curr =3D encode_cpu(cpu);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int numa =3D cpu >> _numa_lock->shift;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct _numa_lock *node_lock =3D _numa_lock + =
numa;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int cur_status =3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int old =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 node->locked =3D NODE_WAIT;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 node->next =3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 node->cpu =3D curr;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 old =3D atomic64_cmpxchg_notequal(qslock, &nod=
e_lock->tail, curr);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (old =3D=3D NUMA_LOCKED_VAL) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 bool s =3D true;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 zx_numa_turn_osq_waiting(qslock, _numa_lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 s =3D osq_lock(qslock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (s =3D=3D true)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (old =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 node->locked =3D COHORT_START;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ACQUIRE_NUMALOCK;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 prev =3D decode_curr(old);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 node->prev =3D prev;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 smp_mb(); /* make sure node set before set pre=
->next */
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 WRITE_ONCE(prev->next, node);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 while ((cur_status =3D READ_ONCE(node->locked)=
) =3D=3D NODE_WAIT) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (need_resched() ||=20
>> vcpu_is_preempted(node_cpu(node->prev))) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ddd =3D _zx_node_os=
q_lock_internal(qslock,=20
>> node, prev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node_lock, cpu,=20
>> &cur_status);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cur_status !=3D NOD=
E_WAIT)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 goto NODE_UNLOCK;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ddd =3D=3D -1)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cpu_relax();
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +NODE_UNLOCK:
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (cur_status =3D=3D ACQUIRE_NUMALOCK)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 node->locked =3D COHORT_START;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 return cur_status;
>> +}
>> +static int _zx_numa_osq_lock(struct optimistic_spin_queue *qslock,=20
>> int cpu,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct _numa_lock *_numa_lock)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int numacpu =3D cpu >> _numa_lock->shift;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int numacurr =3D encode_cpu(numacpu);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct optimistic_spin_node *node =3D &(_numa_=
lock +=20
>> numacpu)->osq_node;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct _numa_lock *numa_lock =3D _numa_lock +=
=20
>> _numa_lock->numa_nodes;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct optimistic_spin_node *prevnode =3D NULL=
;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int prev =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 node->next =3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 node->locked =3D LOCK_NUMALOCK;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 node->cpu =3D numacurr;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 prev =3D atomic_xchg(&numa_lock->tail, numacur=
r);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (prev =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 node->locked =3D UNLOCK_NUMALOCK;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 prevnode =3D &(_numa_lock + prev - 1)->osq_nod=
e;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 node->prev =3D prevnode;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 smp_mb(); /*node->prev should be set before ne=
xt*/
>> +=C2=A0=C2=A0=C2=A0=C2=A0 WRITE_ONCE(prevnode->next, node);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 while (READ_ONCE(node->locked) =3D=3D LOCK_NUM=
ALOCK) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cpu_relax();
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cpu_relax();
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cpu_relax();
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cpu_relax();
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +inline bool zx_numa_osq_lock(struct optimistic_spin_queue *qslock,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct _numa_lock *_numa_lock)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct _numa_lock *node_lock =3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int cpu =3D smp_processor_id();
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int numa =3D cpu >> _numa_lock->shift;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int status =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 node_lock =3D _numa_lock + numa;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (node_lock->stopping) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 zx_numa_turn_osq_waiting(qslock, _numa_lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return osq_lock(qslock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 status =3D _zx_node_osq_lock(qslock, _numa_loc=
k);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (status =3D=3D ACQUIRE_NUMALOCK)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 status =3D _zx_numa_osq_lock(qslock, smp_processor_id(),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 _numa_lock);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (status =3D=3D -1)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return false;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>> +}
>> +
>> +static int atomic64_checktail_osq(struct optimistic_spin_queue *qslock,
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct _numa_lock *node_lock, int ctail)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u64 addr =3D ((u64)ptrmask(qslock)) << 32;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u64 addrtail =3D addr | ctail;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u64 ss =3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 bool mark;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 ss =3D atomic64_read((atomic64_t *) &node_lock=
->tail);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (node_lock->stopping =3D=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 mark =3D (ss =3D=3D addrtail &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic64_cmpxchg_acquir=
e(
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (atomic64_t *) &node_lock->tail,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 addrtail, addr|NUMA_UNLOCKED_VAL) =3D=3D=20
>> addrtail);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 mark =3D (ss =3D=3D addrtail &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic64_cmpxchg_acquir=
e(
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (atomic64_t *) &node_lock->tail,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 addrtail, NUMA_LOCKED_VAL) =3D=3D addrtail);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 return mark;
>> +}
>> +
>> +static void node_lock_release(struct optimistic_spin_queue *qslock,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct _numa_lock *node_lock, struct=20
>> optimistic_spin_node *node,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 int val, int cpu, int numa_end)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct optimistic_spin_node *next =3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int curr =3D encode_cpu(cpu);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 while (1) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (atomic64_checktail_osq(qslock, node_lock, curr)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (qslock->numa_enable=
 =3D=3D NUMALOCKDYNAMIC) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 int index =3D qslock->index;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (numa_end =3D=3D OSQ_UNLOCKED_VAL &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zx=
_numa_entry[index].idle =3D=3D 0) {
>> + cmpxchg(&zx_numa_entry[index].idle,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0, 1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (node->next) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next =3D xchg(&node->ne=
xt, NULL);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (next) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 WRITE_ONCE(next->locked, val);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cpu_relax();
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +}
>> +
>> +static int numa_lock_release(struct optimistic_spin_queue *qslock,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct _numa_lock *numa_lock,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct optimistic_spin_node *node, int cpu)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct optimistic_spin_node *next =3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int curr =3D cpu >> numa_lock->shift;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int numacurr =3D encode_cpu(curr);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 while (1) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (atomic_read(&numa_lock->tail) =3D=3D numacurr &&
>> + atomic_cmpxchg_acquire(&numa_lock->tail, numacurr,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 OSQ_UNLOCKED_VAL) =3D=3D=20
>> numacurr) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return OSQ_UNLOCKED_VAL=
;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (node->next) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next =3D xchg(&node->ne=
xt, NULL);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (next) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 WRITE_ONCE(next->locked, UNLOCK_NUMALOCK);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cpu_relax();
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +}
>> +
>> +inline void zx_numa_osq_unlock(struct optimistic_spin_queue *qslock,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct _numa_lock *_numa_lock)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 u32 cpu =3D=C2=A0 smp_processor_id();
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct optimistic_spin_node *node =3D this_cpu=
_ptr(&osq_cpu_node);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int numa =3D cpu >> _numa_lock->shift;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct _numa_lock *numa_lock =3D _numa_lock +=
=20
>> _numa_lock->numa_nodes;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct _numa_lock *node_lock =3D _numa_lock + =
numa;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct optimistic_spin_node *numa_node =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &(_numa_lock +=20
>> numa)->osq_node;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 struct optimistic_spin_node *next =3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int cur_count =3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int numa_end =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 cur_count =3D READ_ONCE(node->locked);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (cur_count >=3D osq_node_max - 1) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 numa_end =3D numa_lock_release(qslock,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 numa_lock, numa_node, cpu);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 node_lock_release(qslock, node_lock, node,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ACQUIRE_NUMALOCK, cpu, numa_end);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 next =3D xchg(&node->next, NULL);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (next) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 WRITE_ONCE(next->locked, cur_count + 1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 numa_end =3D numa_lock_release(qslock, numa_lo=
ck, numa_node, cpu);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 node_lock_release(qslock, node_lock, node, ACQ=
UIRE_NUMALOCK,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu, numa_end);
>> +}
>
> Overall speaking, there are not enough comments to explain exactly what
> are you trying to achieve with these new functions. It makes them hard
> to review.
>
Apologies for so less comments. I will write more in next commit.
> Cheers,
> Longman
>

