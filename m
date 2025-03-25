Return-Path: <linux-kernel+bounces-576089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4820A70ACA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2773C7A18C2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842BF1FF608;
	Tue, 25 Mar 2025 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HqwSW89I"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2C31FF1CC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 19:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742932368; cv=none; b=e+Ox67f8nl8lro7Bgx8BcvBoU2c5Y1gloSyubncNF6B7Xr2OTou6oSz0LOOyFaSOOb8rH+vL4JeHAVCH5MLEwhF1tuZ+sSgaamlgr8FE4Ix+g541Dvxhovj2oi4t9F4lHRbUZ2x35R7BSUtcQbjH4QfSmt0t3BoqSNC9+KHQA8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742932368; c=relaxed/simple;
	bh=1l10TXdWxQh4ybcZeiX+X3wl7dSZj2jWjpXUjB8Oi+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DeZRW4nKizvp6tpgq+UJOMXbjGaBMMB8YhSpRli7JATMv1HsptdKzyvC6Uu8HkLgDgXpEdDjHDDYFEa0zatRnvZjCUImN78Cxdg6rQyqo4ZXtl6CPzaJCirMmH/G9b3cYD1YFeJQdfUcDyLbZ4IDMYNqUvrYSUUVgRdh9qL1MNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HqwSW89I; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PCSRTw013344;
	Tue, 25 Mar 2025 19:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1fD5lu
	9c7lyAz9tSaxFJaDV2Rn1QfmgXRyQ8neen5aw=; b=HqwSW89ImMtRN0ytfGqT+L
	8/WDqRSTHVcSkir2/8W+On07D61an2TqBJD4ZTwXDC1ZY1o8XLtDHtPiuqKqE4qJ
	HOyG8RfJF8RjDOGnqdRAjyNGCMoA6qZLvm1y86X4Udk7bvjoPK7MqneWtpyOpF4O
	Jlk/UnKOOd0pmyXWTii3on7+MVvuA3e3E9xbR/+A9YjmQC3x0mJP91kMGwbldBLm
	pFm5x2FnklHBOvamt86tGWrLMlE5LRXh+uXHbajBZtvsknxfJn/O9nCQYmgHc5++
	PQtV/VXlsmjloKuahS6jV4jUDkbd0dYBRqysqAxBLivNh7JSyDal3Rlw/0SLRGPw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kvh32e3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 19:52:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52PGxmZ3012262;
	Tue, 25 Mar 2025 19:52:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j91m514y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 19:52:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52PJqPhH47251908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 19:52:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E1A220040;
	Tue, 25 Mar 2025 19:52:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40E532004E;
	Tue, 25 Mar 2025 19:52:21 +0000 (GMT)
Received: from [9.67.11.207] (unknown [9.67.11.207])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Mar 2025 19:52:20 +0000 (GMT)
Message-ID: <fc3a6902-a845-4b11-ace8-514f10194288@linux.ibm.com>
Date: Wed, 26 Mar 2025 01:22:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 20/21] futex: Implement FUTEX2_NUMA
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <20250312151634.2183278-21-bigeasy@linutronix.de>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250312151634.2183278-21-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5uuU8wCTStLDy4pk068LxfnymFyhJQdq
X-Proofpoint-GUID: 5uuU8wCTStLDy4pk068LxfnymFyhJQdq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_08,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999 mlxscore=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250131



On 3/12/25 20:46, Sebastian Andrzej Siewior wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Extend the futex2 interface to be numa aware.
> 
> When FUTEX2_NUMA is specified for a futex, the user value is extended
> to two words (of the same size). The first is the user value we all
> know, the second one will be the node to place this futex on.
> 
>    struct futex_numa_32 {
> 	u32 val;
> 	u32 node;
>    };
> 
> When node is set to ~0, WAIT will set it to the current node_id such
> that WAKE knows where to find it. If userspace corrupts the node value
> between WAIT and WAKE, the futex will not be found and no wakeup will
> happen.
> 
> When FUTEX2_NUMA is not set, the node is simply an extention of the
> hash, such that traditional futexes are still interleaved over the
> nodes.
> 
> This is done to avoid having to have a separate !numa hash-table.
> 
> [bigeasy: ensure to have at least hashsize of 4 in futex_init(), add
> pr_info() for size and allocation information.]
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   include/linux/futex.h      |   3 ++
>   include/uapi/linux/futex.h |   8 +++
>   kernel/futex/core.c        | 100 ++++++++++++++++++++++++++++++-------
>   kernel/futex/futex.h       |  33 ++++++++++--
>   4 files changed, 124 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/futex.h b/include/linux/futex.h
> index 7e14d2e9162d2..19c37afa0432a 100644
> --- a/include/linux/futex.h
> +++ b/include/linux/futex.h
> @@ -34,6 +34,7 @@ union futex_key {
>   		u64 i_seq;
>   		unsigned long pgoff;
>   		unsigned int offset;
> +		/* unsigned int node; */
>   	} shared;
>   	struct {
>   		union {
> @@ -42,11 +43,13 @@ union futex_key {
>   		};
>   		unsigned long address;
>   		unsigned int offset;
> +		/* unsigned int node; */
>   	} private;
>   	struct {
>   		u64 ptr;
>   		unsigned long word;
>   		unsigned int offset;
> +		unsigned int node;	/* NOT hashed! */
>   	} both;
>   };
>   
> diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
> index d2ee625ea1890..0435025beaae8 100644
> --- a/include/uapi/linux/futex.h
> +++ b/include/uapi/linux/futex.h
> @@ -74,6 +74,14 @@
>   /* do not use */
>   #define FUTEX_32		FUTEX2_SIZE_U32 /* historical accident :-( */
>   
> +
> +/*
> + * When FUTEX2_NUMA doubles the futex word, the second word is a node value.
> + * The special value -1 indicates no-node. This is the same value as
> + * NUMA_NO_NODE, except that value is not ABI, this is.
> + */
> +#define FUTEX_NO_NODE		(-1)
> +
>   /*
>    * Max numbers of elements in a futex_waitv array
>    */
> diff --git a/kernel/futex/core.c b/kernel/futex/core.c
> index bc7451287b2ce..b9da7dc6a900a 100644
> --- a/kernel/futex/core.c
> +++ b/kernel/futex/core.c
> @@ -36,6 +36,8 @@
>   #include <linux/pagemap.h>
>   #include <linux/debugfs.h>
>   #include <linux/plist.h>
> +#include <linux/gfp.h>
> +#include <linux/vmalloc.h>
>   #include <linux/memblock.h>
>   #include <linux/fault-inject.h>
>   #include <linux/slab.h>
> @@ -51,11 +53,14 @@
>    * reside in the same cacheline.
>    */
>   static struct {
> -	struct futex_hash_bucket *queues;
>   	unsigned long            hashmask;
> +	unsigned int		 hashshift;
> +	struct futex_hash_bucket *queues[MAX_NUMNODES];
>   } __futex_data __read_mostly __aligned(2*sizeof(long));
> -#define futex_queues   (__futex_data.queues)
> -#define futex_hashmask (__futex_data.hashmask)
> +
> +#define futex_hashmask	(__futex_data.hashmask)
> +#define futex_hashshift	(__futex_data.hashshift)
> +#define futex_queues	(__futex_data.queues)
>   
>   struct futex_private_hash {
>   	rcuref_t	users;
> @@ -326,15 +331,35 @@ __futex_hash(union futex_key *key, struct futex_private_hash *fph)
>   {
>   	struct futex_hash_bucket *hb;
>   	u32 hash;
> +	int node;
>   
>   	hb = __futex_hash_private(key, fph);
>   	if (hb)
>   		return hb;
>   
>   	hash = jhash2((u32 *)key,
> -		      offsetof(typeof(*key), both.offset) / 4,
> +		      offsetof(typeof(*key), both.offset) / sizeof(u32),
>   		      key->both.offset);
> -	return &futex_queues[hash & futex_hashmask];
> +	node = key->both.node;
> +
> +	if (node == FUTEX_NO_NODE) {
> +		/*
> +		 * In case of !FLAGS_NUMA, use some unused hash bits to pick a
> +		 * node -- this ensures regular futexes are interleaved across
> +		 * the nodes and avoids having to allocate multiple
> +		 * hash-tables.
> +		 *
> +		 * NOTE: this isn't perfectly uniform, but it is fast and
> +		 * handles sparse node masks.
> +		 */
> +		node = (hash >> futex_hashshift) % nr_node_ids;
> +		if (!node_possible(node)) {
> +			node = find_next_bit_wrap(node_possible_map.bits,
> +						  nr_node_ids, node);
> +		}
> +	}
> +
> +	return &futex_queues[node][hash & futex_hashmask];

IIUC, when one specifies the numa node it can't be private futex anymore?


>   }
>   
>   /**
> @@ -441,25 +466,49 @@ int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
>   	struct page *page;
>   	struct folio *folio;
>   	struct address_space *mapping;
> -	int err, ro = 0;
> +	int node, err, size, ro = 0;
>   	bool fshared;
>   
>   	fshared = flags & FLAGS_SHARED;
> +	size = futex_size(flags);
> +	if (flags & FLAGS_NUMA)
> +		size *= 2;
>   
>   	/*
>   	 * The futex address must be "naturally" aligned.
>   	 */
>   	key->both.offset = address % PAGE_SIZE;
> -	if (unlikely((address % sizeof(u32)) != 0))
> +	if (unlikely((address % size) != 0))
>   		return -EINVAL;
>   	address -= key->both.offset;
>   
> -	if (unlikely(!access_ok(uaddr, sizeof(u32))))
> +	if (unlikely(!access_ok(uaddr, size)))
>   		return -EFAULT;
>   
>   	if (unlikely(should_fail_futex(fshared)))
>   		return -EFAULT;
>   
> +	if (flags & FLAGS_NUMA) {
> +		u32 __user *naddr = uaddr + size / 2;
> +
> +		if (futex_get_value(&node, naddr))
> +			return -EFAULT;
> +
> +		if (node == FUTEX_NO_NODE) {
> +			node = numa_node_id();
> +			if (futex_put_value(node, naddr))
> +				return -EFAULT;
> +
> +		} else if (node >= MAX_NUMNODES || !node_possible(node)) {
> +			return -EINVAL;
> +		}
> +
> +		key->both.node = node;
> +
> +	} else {
> +		key->both.node = FUTEX_NO_NODE;
> +	}
> +
>   	/*
>   	 * PROCESS_PRIVATE futexes are fast.
>   	 * As the mm cannot disappear under us and the 'key' only needs
> @@ -1597,24 +1646,41 @@ int futex_hash_prctl(unsigned long arg2, unsigned long arg3)
>   static int __init futex_init(void)
>   {
>   	unsigned long hashsize, i;
> -	unsigned int futex_shift;
> +	unsigned int order, n;
> +	unsigned long size;
>   
>   #ifdef CONFIG_BASE_SMALL
>   	hashsize = 16;
>   #else
> -	hashsize = roundup_pow_of_two(256 * num_possible_cpus());
> +	hashsize = 256 * num_possible_cpus();
> +	hashsize /= num_possible_nodes();

Wouldn't it be better to use num_online_nodes? each node may get a bigger
hash bucket which means less collision no?


> +	hashsize = max(4, hashsize);
> +	hashsize = roundup_pow_of_two(hashsize);
>   #endif
> +	futex_hashshift = ilog2(hashsize);
> +	size = sizeof(struct futex_hash_bucket) * hashsize;
> +	order = get_order(size);
>   
> -	futex_queues = alloc_large_system_hash("futex", sizeof(*futex_queues),
> -					       hashsize, 0, 0,
> -					       &futex_shift, NULL,
> -					       hashsize, hashsize);
> -	hashsize = 1UL << futex_shift;
> +	for_each_node(n) {
> +		struct futex_hash_bucket *table;
>   
> -	for (i = 0; i < hashsize; i++)
> -		futex_hash_bucket_init(&futex_queues[i], NULL);
> +		if (order > MAX_PAGE_ORDER)
> +			table = vmalloc_huge_node(size, GFP_KERNEL, n);
> +		else
> +			table = alloc_pages_exact_nid(n, size, GFP_KERNEL);
> +
> +		BUG_ON(!table);
> +
> +		for (i = 0; i < hashsize; i++)
> +			futex_hash_bucket_init(&table[i], NULL);
> +
> +		futex_queues[n] = table;
> +	}
>   
>   	futex_hashmask = hashsize - 1;
> +	pr_info("futex hash table entries: %lu (%lu bytes on %d NUMA nodes, total %lu KiB, %s).\n",
> +		hashsize, size, num_possible_nodes(), size * num_possible_nodes() / 1024,
> +		order > MAX_PAGE_ORDER ? "vmalloc" : "linear");
>   	return 0;
>   }
>   core_initcall(futex_init);
> diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
> index 8eba9982bcae1..11c870a92b5d0 100644
> --- a/kernel/futex/futex.h
> +++ b/kernel/futex/futex.h
> @@ -54,7 +54,7 @@ static inline unsigned int futex_to_flags(unsigned int op)
>   	return flags;
>   }
>   
> -#define FUTEX2_VALID_MASK (FUTEX2_SIZE_MASK | FUTEX2_PRIVATE)
> +#define FUTEX2_VALID_MASK (FUTEX2_SIZE_MASK | FUTEX2_NUMA | FUTEX2_PRIVATE)
>   
>   /* FUTEX2_ to FLAGS_ */
>   static inline unsigned int futex2_to_flags(unsigned int flags2)
> @@ -87,6 +87,19 @@ static inline bool futex_flags_valid(unsigned int flags)
>   	if ((flags & FLAGS_SIZE_MASK) != FLAGS_SIZE_32)
>   		return false;
>   
> +	/*
> +	 * Must be able to represent both FUTEX_NO_NODE and every valid nodeid
> +	 * in a futex word.
> +	 */
> +	if (flags & FLAGS_NUMA) {
> +		int bits = 8 * futex_size(flags);
> +		u64 max = ~0ULL;
> +
> +		max >>= 64 - bits;
> +		if (nr_node_ids >= max)
> +			return false;
> +	}
> +
>   	return true;
>   }
>   
> @@ -290,7 +303,7 @@ static inline int futex_cmpxchg_value_locked(u32 *curval, u32 __user *uaddr, u32
>    * This looks a bit overkill, but generally just results in a couple
>    * of instructions.
>    */
> -static __always_inline int futex_read_inatomic(u32 *dest, u32 __user *from)
> +static __always_inline int futex_get_value(u32 *dest, u32 __user *from)
>   {
>   	u32 val;
>   
> @@ -307,12 +320,26 @@ static __always_inline int futex_read_inatomic(u32 *dest, u32 __user *from)
>   	return -EFAULT;
>   }
>   
> +static __always_inline int futex_put_value(u32 val, u32 __user *to)
> +{
> +	if (can_do_masked_user_access())
> +		to = masked_user_access_begin(to);
> +	else if (!user_read_access_begin(to, sizeof(*to)))
> +		return -EFAULT;
> +	unsafe_put_user(val, to, Efault);
> +	user_read_access_end();
> +	return 0;
> +Efault:
> +	user_read_access_end();
> +	return -EFAULT;
> +}
> +
>   static inline int futex_get_value_locked(u32 *dest, u32 __user *from)
>   {
>   	int ret;
>   
>   	pagefault_disable();
> -	ret = futex_read_inatomic(dest, from);
> +	ret = futex_get_value(dest, from);
>   	pagefault_enable();
>   
>   	return ret;


