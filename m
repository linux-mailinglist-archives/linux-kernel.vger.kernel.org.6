Return-Path: <linux-kernel+bounces-333372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2337C97C78D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E6D28A6EA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1B81A0728;
	Thu, 19 Sep 2024 09:48:06 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4B519DF8E
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726739286; cv=none; b=PoKFJcDFdJC6eV5XPnSAvANDFk8K8VRB4Uj5SJ7sjSFlOXQLOMh92rJwD3/zcwrL4YtXh5eHya2KXATKtCw66r/7PBfqTRmtl7Bw/4V4mx+9r1O2WrzqYG9Y6ZAJgrWjn2LV6DGsjdODpr2NRc/cO4DW9IMSGiqp6yND8hyjLGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726739286; c=relaxed/simple;
	bh=qHSesV4vDZ/t08Jp340wHmg+BKlGC2pL81N+3Cv5XDU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=FDX3vc6848b2o5vYa+qwbk7+9WpsQifY4JwlXw9pF5Z+uIhDoDY6nFFGgRl+KQumBKhTqxTSUzdA68wCxJgnl9mS6edtKqshA95XZpGolGzdFIJG4SXroGw0HTArahl/8/Plfbhyx5wgT2/SGLISs/bW835uNRoXFBsUfv94zLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1726739269-1eb14e31a9111430001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id 6dtTAgmk58D2qwhs (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 19 Sep 2024 17:47:49 +0800 (CST)
X-Barracuda-Envelope-From: YongLi-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX02.zhaoxin.com (10.29.252.6) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 17:47:48 +0800
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXBJMBX02.zhaoxin.com
 (10.29.252.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 17:47:48 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d]) by
 ZXSHMBX2.zhaoxin.com ([fe80::d4e0:880a:d21:684d%4]) with mapi id
 15.01.2507.039; Thu, 19 Sep 2024 17:47:47 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.6
Received: from [10.29.8.43] (10.29.8.43) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 19 Sep
 2024 17:32:32 +0800
Message-ID: <c3c6dbab-3bcc-459d-b32c-4d1c432e39f0@zhaoxin.com>
Date: Thu, 19 Sep 2024 17:32:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: yongli-os <yongli-oc@zhaoxin.com>
Subject: Re: [PATCH 2/4] locking/osq_lock: Turn to dynamic switch function
 from osq_lock/unlock.
To: Waiman Long <longman@redhat.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <will@kernel.org>, <boqun.feng@gmail.com>
X-ASG-Orig-Subj: Re: [PATCH 2/4] locking/osq_lock: Turn to dynamic switch function
 from osq_lock/unlock.
CC: <linux-kernel@vger.kernel.org>, <yongli@zhaoxin.com>,
	<louisqi@zhaoxin.com>, <cobechen@zhaoxin.com>, <jiangbowang@zhaoxin.com>
References: <20240914085327.32912-1-yongli-oc@zhaoxin.com>
 <20240914085327.32912-3-yongli-oc@zhaoxin.com>
 <74f04210-9f95-483e-a554-460140555cca@redhat.com>
Content-Language: en-US
In-Reply-To: <74f04210-9f95-483e-a554-460140555cca@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 9/19/2024 5:47:46 PM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1726739269
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 7426
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.130665
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------


On 2024/9/15 00:06, Waiman Long wrote:
>
>
> [=E8=BF=99=E5=B0=81=E9=82=AE=E4=BB=B6=E6=9D=A5=E8=87=AA=E5=A4=96=E9=83=A8=
=E5=8F=91=E4=BB=B6=E4=BA=BA =E8=B0=A8=E9=98=B2=E9=A3=8E=E9=99=A9]
>
> On 9/14/24 04:53, yongli-oc wrote:
>> To support numa-aware osq lock, the struct optimistic_spin_queue
>> is accessed as three members, numa_enable, index, tail16, by union.
>> The size of the struct is the same as before.
>> If dynamic numa-ware lock enable, turns to the crossing, x_osq_lock to
>> check contention level and starts dynamic switch.
>>
>> Signed-off-by: yongli-oc <yongli-oc@zhaoxin.com>
>> ---
>> =C2=A0 include/linux/osq_lock.h=C2=A0 | 33 ++++++++++++++++++++-
>> =C2=A0 kernel/locking/osq_lock.c | 62 ++++++++++++++++++++++++++++++++++=
+++--
>> =C2=A0 2 files changed, 91 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/osq_lock.h b/include/linux/osq_lock.h
>> index ea8fb31379e3..37a7bc4ab530 100644
>> --- a/include/linux/osq_lock.h
>> +++ b/include/linux/osq_lock.h
>> @@ -12,14 +12,42 @@ struct optimistic_spin_queue {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Stores an encoded value of the CP=
U # of the tail node in the=20
>> queue.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If the queue is empty, then it's =
set to OSQ_UNLOCKED_VAL.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
>> +=C2=A0=C2=A0=C2=A0=C2=A0 union {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 atomic_t tail;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 u32 val;
>> +#ifdef __LITTLE_ENDIAN
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 tail16;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 index;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 numa_enable;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 };
>> +#else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 numa_enable;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 index;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 tail16;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 };
>> +#endif
>> +=C2=A0=C2=A0=C2=A0=C2=A0 };
>> +#else
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_t tail;
>> +#endif
>> =C2=A0 };
>>
>> =C2=A0 #define OSQ_UNLOCKED_VAL (0)
>>
>> =C2=A0 /* Init macro and function. */
>> +#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
>> +
>> +#define OSQ_LOCK_UNLOCKED { .tail =3D ATOMIC_INIT(OSQ_UNLOCKED_VAL) }
>> +
>> +#else
>> +
>> =C2=A0 #define OSQ_LOCK_UNLOCKED { ATOMIC_INIT(OSQ_UNLOCKED_VAL) }
>>
>> +#endif
>> +
>> =C2=A0 static inline void osq_lock_init(struct optimistic_spin_queue *lo=
ck)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_set(&lock->tail, OSQ_UNLOCKED_VAL)=
;
>> @@ -28,9 +56,12 @@ static inline void osq_lock_init(struct=20
>> optimistic_spin_queue *lock)
>> =C2=A0 extern bool osq_lock(struct optimistic_spin_queue *lock);
>> =C2=A0 extern void osq_unlock(struct optimistic_spin_queue *lock);
>>
>> +#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
>> +extern bool osq_is_locked(struct optimistic_spin_queue *lock);
>> +#else
>> =C2=A0 static inline bool osq_is_locked(struct optimistic_spin_queue *lo=
ck)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return atomic_read(&lock->tail) !=3D OSQ_=
UNLOCKED_VAL;
>> =C2=A0 }
>> -
>> +#endif
>> =C2=A0 #endif
>> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
>> index 75a6f6133866..a7b516939e00 100644
>> --- a/kernel/locking/osq_lock.c
>> +++ b/kernel/locking/osq_lock.c
>> @@ -2,7 +2,10 @@
>> =C2=A0 #include <linux/percpu.h>
>> =C2=A0 #include <linux/sched.h>
>> =C2=A0 #include <linux/osq_lock.h>
>> -
>> +#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
>> +#include "numa.h"
>> +#include "numa_osq.h"
>> +#endif
>
> These header files are defined in patch 3. You need to rethink about
> patch ordering in order not to break bisection.
I will move it to the patch 2.
>
>> =C2=A0 /*
>> =C2=A0=C2=A0 * An MCS like lock especially tailored for optimistic spinn=
ing for=20
>> sleeping
>> =C2=A0=C2=A0 * lock implementations (mutex, rwsem, etc).
>> @@ -12,12 +15,34 @@
>> =C2=A0=C2=A0 * spinning.
>> =C2=A0=C2=A0 */
>>
>> +#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
>> +DEFINE_PER_CPU_SHARED_ALIGNED(struct optimistic_spin_node, osq_node);
>> +/*
>> + * We use the value 0 to represent "no CPU", thus the encoded value
>> + * will be the CPU number incremented by 1.
>> + */
>> +inline int encode_cpu(int cpu_nr)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 return cpu_nr + 1;
>> +}
>> +
>> +inline int node_cpu(struct optimistic_spin_node *node)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 return node->cpu - 1;
>> +}
>> +
>> +inline struct optimistic_spin_node *decode_cpu(int encoded_cpu_val)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 int cpu_nr =3D encoded_cpu_val - 1;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0 return per_cpu_ptr(&osq_node, cpu_nr);
>> +}
>> +#else
>> =C2=A0 struct optimistic_spin_node {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct optimistic_spin_node *next, *prev;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int locked; /* 1 if lock acquired */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int cpu; /* encoded CPU # + 1 value */
>> =C2=A0 };
>> -
>> =C2=A0 static DEFINE_PER_CPU_SHARED_ALIGNED(struct optimistic_spin_node,=
=20
>> osq_node);
>>
>> =C2=A0 /*
>> @@ -40,6 +65,7 @@ static inline struct optimistic_spin_node=20
>> *decode_cpu(int encoded_cpu_val)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return per_cpu_ptr(&osq_node, cpu_nr);
>> =C2=A0 }
>> +#endif
>>
>> =C2=A0 /*
>> =C2=A0=C2=A0 * Get a stable @node->next pointer, either for unlock() or=
=20
>> unqueue() purposes.
>> @@ -97,6 +123,14 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int curr =3D encode_cpu(smp_processor_id(=
));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int old;
>>
>> +#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(enable_zx_numa_osq_lock > 1)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 node->numa =3D 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return x_osq_lock(lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0 node->numa =3D 0;
>> +#endif
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->locked =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->next =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->cpu =3D curr;
>> @@ -108,6 +142,11 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the lock tail.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 old =3D atomic_xchg(&lock->tail, curr);
>> +#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (enable_zx_numa_osq_lock > 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0 //enable means all cpu cores are less tan 6553=
4.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 old =3D old & 0xffff;
>> +#endif
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (old =3D=3D OSQ_UNLOCKED_VAL)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return true;
>>
>> @@ -212,6 +251,14 @@ void osq_unlock(struct optimistic_spin_queue *lock)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct optimistic_spin_node *node, *next;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int curr =3D encode_cpu(smp_processor_id(=
));
>>
>> +=C2=A0=C2=A0=C2=A0=C2=A0 node =3D this_cpu_ptr(&osq_node);
>> +
>> +#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(enable_zx_numa_osq_lock > 1 &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 node->numa =3D=3D 1))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return x_osq_unlock(lock);
>> +#endif
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Fast path for the uncontended cas=
e.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> @@ -222,7 +269,6 @@ void osq_unlock(struct optimistic_spin_queue *lock)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Second most likely case.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0=C2=A0 node =3D this_cpu_ptr(&osq_node);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next =3D xchg(&node->next, NULL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (next) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 WRITE_ONCE(next->locked, 1);
>> @@ -233,3 +279,13 @@ void osq_unlock(struct optimistic_spin_queue *lock)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (next)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 WRITE_ONCE(next->locked, 1);
>> =C2=A0 }
>> +#ifdef CONFIG_LOCK_SPIN_ON_OWNER_NUMA
>> +bool osq_is_locked(struct optimistic_spin_queue *lock)
>> +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(enable_zx_numa_osq_lock > 1))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return x_osq_is_locked(lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0 return atomic_read(&lock->tail) !=3D OSQ_UNLOC=
KED_VAL;
>> +}
>> +#endif
>> +
>> +
>

