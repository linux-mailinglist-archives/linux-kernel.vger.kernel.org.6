Return-Path: <linux-kernel+bounces-438124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F406E9E9D23
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52458166A55
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E0E14F9E7;
	Mon,  9 Dec 2024 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgZsxXse"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B42233151;
	Mon,  9 Dec 2024 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733765721; cv=none; b=OpSyf5ShVc1xR2qGwr6AcqkJJUaTX2nGBES6E50zKnsmMXn5PecipGin9a067p8JAztPdLyCqyQhI8CMUfKtsC2sKsEhb3zLzEKHGpf4D2i1e77XkVUkctEP5oQkWw4nARwe4AtGKQIRMLl+D7KVYPjF5es+e7QFhayxqxM8odI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733765721; c=relaxed/simple;
	bh=hk/tuNIu80lW1fBPuHozuRYinyIBKtQuclDoIUbZAAU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=ZhBAFSXrn0JV1+8hUaEYU0VvjbyJ4b2708+16OugZ9MTyE6FJ7txrSyxep1JgQUFqDonpeheTlZKGjTc6gQXNZxkeqxrgthMWg5frnEEaHHbyaHNxSltVdfIOQui7jhRVZ4VNGogN5Og61On+TTWaWH257PMpAkilkJlj4tFuYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgZsxXse; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53f22fd6887so2004385e87.2;
        Mon, 09 Dec 2024 09:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733765717; x=1734370517; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yguZJO+vX9RgLRob0a5RLm4qYs5JJ0Cd9U+PZk4K+ZM=;
        b=SgZsxXse0yhbn+tgm/18lnTLDN74RYNahPYGTNkHDWWHrq/MBIoPs7u430RCl4Zpfi
         dEosmZm853Sie7Zg+1GhpKpZrA//kySKazvi7O0Fdms+kSHKyihAdHrMfCbcHSEFLbmG
         TxpcDAr1lTrpy41o7FcskwiOVyntg7wKFv7A/c7MjX0bacTJJdooWtDKjrA6KVZrHbyB
         evDpFMzk6/j1V2En7w+phKxUWORtTuh/38GTiMnEo57LLenKyUmtbmyl/Uv5KvEC1Nql
         8SDqHRyNK0zS99R56hgK0NgWFMW29sbqB0DLroC0D9Ib21GnM/pCD4VMIOtW9oTXx5sG
         W7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733765717; x=1734370517;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yguZJO+vX9RgLRob0a5RLm4qYs5JJ0Cd9U+PZk4K+ZM=;
        b=g76OeaoCiEihAMeOXmpQB9SyYecuS+PGL91wdmb6t2vpaadX+i+w3iwAcpa92PhRjf
         HwJKVJSOD9CWySqO6ty7EJp3ububTPy12Gxlf9XPNaBBrI1oSSzqFeJdwe/h9HJ2od+T
         DAhrqJVu+Du/SklgSByyhWDmSQMoI7ws8FdKN5YkRqHe/lE99MtFWNAlrlJRiAUmf3Tb
         lCoFIiD6DG333q5sZadwK7BaivnUhvzU/Eq4H0vY3q/SkbmJDryl9ekJAZNGiba0cTKm
         Xuv9DaeY5ad1Z5lVKYY2Sbu653UfEPI5lMlq1Lnj52fJSD1AkrG4T/OFAhSygEV0nyFu
         3ukw==
X-Forwarded-Encrypted: i=1; AJvYcCW3jlDOON3VfwoLC0BqZVQUmjK0VdeV932RawEnCPbMQzoucyOScIrDZNR/shDd1VQMUr7AetCQXcw=@vger.kernel.org, AJvYcCWypp/LVXfKaMr/Rh4ymwbStKeUdaozRHqjtt9/Et1+rn1km0/QrY17OGdZP+5tEr0ZCv1RKst2V8PCvgsQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyVP110jm6xZh2CCVq64ejP/YCDtnyML7mHSl1LLbJSyL+zd7d7
	TrwmZyAHV1SCZzBr6JcGC7hu2LrS7v83y+IKus2qt/Z83gZ0JW2c
X-Gm-Gg: ASbGncs8jLLzSjNeKCWTSi5Xi0gDUw0PsbZMeFSKDvaQVK7rIhevWb6hHDv/3iA625u
	aE2yTvO7jKnGRDA7QvLq9wIipIeIzPRSIjKRYTnsRYw3aLvF+xFe8AsmU4QcqfnZGBZgw8u1Ltn
	TIsS5CDYp246K5KXXgXuH7Lrxg+mTnaTTJ3aFfjtcOmfC78hPkqkfit6zq9MxI4dECHdk4byCT2
	vA6CRIbSGsWrJYar5J6s9CGNsFIRGHz5LEhEgITzr/XdbTFFiXzByDPnXdPIBvSCO4ARtRa23xN
	da6xE0QNJoXM2GIrdE7qJRvp9vQRmYRP7xY=
X-Google-Smtp-Source: AGHT+IGaBvqjWNCBq5UKMUUO/ci6FARb/GBIbQp9U8ISlL9GVRkRo7a4XwVvZo4ngVThF2HNFG7nJg==
X-Received: by 2002:a05:6512:3b28:b0:540:2223:9b0b with SMTP id 2adb3069b0e04-54022239c96mr1354117e87.35.1733765716436;
        Mon, 09 Dec 2024 09:35:16 -0800 (PST)
Received: from ?IPV6:2001:678:a5c:1202:4fb5:f16a:579c:6dcb? (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e94f77f3fsm784481e87.217.2024.12.09.09.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 09:35:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------cFFMQsuqNz8ju84FMDmBy5Ja"
Message-ID: <d0ae7609-aca4-4497-9188-bb09e96e7768@gmail.com>
Date: Mon, 9 Dec 2024 18:35:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] mm: make vma cache SLAB_TYPESAFE_BY_RCU
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, liam.howlett@oracle.com, lorenzo.stoakes@oracle.com,
 mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com,
 oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com,
 peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
 brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com,
 minchan@google.com, jannh@google.com, shakeel.butt@linux.dev,
 souravpanda@google.com, pasha.tatashin@soleen.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@android.com
References: <20241206225204.4008261-1-surenb@google.com>
 <20241206225204.4008261-5-surenb@google.com>
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <20241206225204.4008261-5-surenb@google.com>

This is a multi-part message in MIME format.
--------------cFFMQsuqNz8ju84FMDmBy5Ja
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024-12-06 23:52, Suren Baghdasaryan wrote:
> To enable SLAB_TYPESAFE_BY_RCU for vma cache we need to ensure that
> object reuse before RCU grace period is over will be detected inside
> lock_vma_under_rcu().
> lock_vma_under_rcu() enters RCU read section, finds the vma at the
> given address, locks the vma and checks if it got detached or remapped
> to cover a different address range. These last checks are there
> to ensure that the vma was not modified after we found it but before
> locking it.
> vma reuse introduces several new possibilities:
> 1. vma can be reused after it was found but before it is locked;
> 2. vma can be reused and reinitialized (including changing its vm_mm)
> while being locked in vma_start_read();
> 3. vma can be reused and reinitialized after it was found but before
> it is locked, then attached at a new address or to a new mm while
> read-locked;
> For case #1 current checks will help detecting cases when:
> - vma was reused but not yet added into the tree (detached check)
> - vma was reused at a different address range (address check);
> We are missing the check for vm_mm to ensure the reused vma was not
> attached to a different mm. This patch adds the missing check.
> For case #2, we pass mm to vma_start_read() to prevent access to
> unstable vma->vm_mm. This might lead to vma_start_read() returning
> a false locked result but that's not critical if it's rare because
> it will only lead to a retry under mmap_lock.
> For case #3, we ensure the order in which vma->detached flag and
> vm_start/vm_end/vm_mm are set and checked. vma gets attached after
> vm_start/vm_end/vm_mm were set and lock_vma_under_rcu() should check
> vma->detached before checking vm_start/vm_end/vm_mm. This is required
> because attaching vma happens without vma write-lock, as opposed to
> vma detaching, which requires vma write-lock. This patch adds memory
> barriers inside is_vma_detached() and vma_mark_attached() needed to
> order reads and writes to vma->detached vs vm_start/vm_end/vm_mm.
> After these provisions, SLAB_TYPESAFE_BY_RCU is added to vm_area_cachep.
> This will facilitate vm_area_struct reuse and will minimize the number
> of call_rcu() calls.

This patch (85ad413389aec04cfaaba043caa8128b76c6e491 in next-20241209) 
seems to cause an oops on a MIPS board of mine (Cavium Octeon III) 
(abbreviated, full attached):

CPU 2 Unable to handle kernel paging request at virtual address 
0000000000000000, epc == ffffffff813a85a0, ra == ffffffff81390438
Oops[#1]:
CPU: 2 UID: 0 PID: 1 Comm: init Not tainted 
6.13.0-rc1-00162-g85ad413389ae #156
Call Trace:
unlink_anon_vmas (mm/rmap.c:408)
free_pgtables (mm/memory.c:393)
vms_clear_ptes (mm/vma.c:1143)
vms_complete_munmap_vmas (include/linux/mm.h:2737 mm/vma.c:1187)
do_vmi_align_munmap (mm/vma.c:1452)
__vm_munmap (mm/vma.c:2892)
sys_munmap (mm/mmap.c:1053)
syscall_common (arch/mips/kernel/scall64-n64.S:62)

I saw that there's already a report, but maybe another arch can be 
useful for tracking this down.

Please let me know if there's anything else you need.

Regards,
Klara Modin

Link: https://lore.kernel.org/all/202412082208.db1fb2c9-lkp@intel.com

> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>   include/linux/mm.h               |  36 +++++--
>   include/linux/mm_types.h         |  10 +-
>   include/linux/slab.h             |   6 --
>   kernel/fork.c                    | 157 +++++++++++++++++++++++++------
>   mm/memory.c                      |  15 ++-
>   mm/vma.c                         |   2 +-
>   tools/testing/vma/vma_internal.h |   7 +-
>   7 files changed, 179 insertions(+), 54 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 2bf38c1e9cca..3568bcbc7c81 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -257,7 +257,7 @@ struct vm_area_struct *vm_area_alloc(struct mm_struct *);
>   struct vm_area_struct *vm_area_dup(struct vm_area_struct *);
>   void vm_area_free(struct vm_area_struct *);
>   /* Use only if VMA has no other users */
> -void __vm_area_free(struct vm_area_struct *vma);
> +void vm_area_free_unreachable(struct vm_area_struct *vma);
>   
>   #ifndef CONFIG_MMU
>   extern struct rb_root nommu_region_tree;
> @@ -706,8 +706,10 @@ static inline void vma_lock_init(struct vm_area_struct *vma)
>    * Try to read-lock a vma. The function is allowed to occasionally yield false
>    * locked result to avoid performance overhead, in which case we fall back to
>    * using mmap_lock. The function should never yield false unlocked result.
> + * False locked result is possible if mm_lock_seq overflows or if vma gets
> + * reused and attached to a different mm before we lock it.
>    */
> -static inline bool vma_start_read(struct vm_area_struct *vma)
> +static inline bool vma_start_read(struct mm_struct *mm, struct vm_area_struct *vma)
>   {
>   	/*
>   	 * Check before locking. A race might cause false locked result.
> @@ -716,7 +718,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
>   	 * we don't rely on for anything - the mm_lock_seq read against which we
>   	 * need ordering is below.
>   	 */
> -	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq.sequence))
> +	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(mm->mm_lock_seq.sequence))
>   		return false;
>   
>   	if (unlikely(down_read_trylock(&vma->vm_lock.lock) == 0))
> @@ -733,7 +735,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
>   	 * after it has been unlocked.
>   	 * This pairs with RELEASE semantics in vma_end_write_all().
>   	 */
> -	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&vma->vm_mm->mm_lock_seq))) {
> +	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&mm->mm_lock_seq))) {
>   		up_read(&vma->vm_lock.lock);
>   		return false;
>   	}
> @@ -822,7 +824,15 @@ static inline void vma_assert_locked(struct vm_area_struct *vma)
>   
>   static inline void vma_mark_attached(struct vm_area_struct *vma)
>   {
> -	vma->detached = false;
> +	/*
> +	 * This pairs with smp_rmb() inside is_vma_detached().
> +	 * vma is marked attached after all vma modifications are done and it
> +	 * got added into the vma tree. All prior vma modifications should be
> +	 * made visible before marking the vma attached.
> +	 */
> +	smp_wmb();
> +	/* This pairs with READ_ONCE() in is_vma_detached(). */
> +	WRITE_ONCE(vma->detached, false);
>   }
>   
>   static inline void vma_mark_detached(struct vm_area_struct *vma)
> @@ -834,7 +844,18 @@ static inline void vma_mark_detached(struct vm_area_struct *vma)
>   
>   static inline bool is_vma_detached(struct vm_area_struct *vma)
>   {
> -	return vma->detached;
> +	bool detached;
> +
> +	/* This pairs with WRITE_ONCE() in vma_mark_attached(). */
> +	detached = READ_ONCE(vma->detached);
> +	/*
> +	 * This pairs with smp_wmb() inside vma_mark_attached() to ensure
> +	 * vma->detached is read before vma attributes read later inside
> +	 * lock_vma_under_rcu().
> +	 */
> +	smp_rmb();
> +
> +	return detached;
>   }
>   
>   static inline void release_fault_lock(struct vm_fault *vmf)
> @@ -859,7 +880,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>   #else /* CONFIG_PER_VMA_LOCK */
>   
>   static inline void vma_lock_init(struct vm_area_struct *vma) {}
> -static inline bool vma_start_read(struct vm_area_struct *vma)
> +static inline bool vma_start_read(struct mm_struct *mm, struct vm_area_struct *vma)
>   		{ return false; }
>   static inline void vma_end_read(struct vm_area_struct *vma) {}
>   static inline void vma_start_write(struct vm_area_struct *vma) {}
> @@ -893,6 +914,7 @@ static inline void assert_fault_locked(struct vm_fault *vmf)
>   
>   extern const struct vm_operations_struct vma_dummy_vm_ops;
>   
> +/* Use on VMAs not created using vm_area_alloc() */
>   static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>   {
>   	memset(vma, 0, sizeof(*vma));
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index be3551654325..5d8779997266 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -543,6 +543,12 @@ static inline void *folio_get_private(struct folio *folio)
>   
>   typedef unsigned long vm_flags_t;
>   
> +/*
> + * freeptr_t represents a SLUB freelist pointer, which might be encoded
> + * and not dereferenceable if CONFIG_SLAB_FREELIST_HARDENED is enabled.
> + */
> +typedef struct { unsigned long v; } freeptr_t;
> +
>   /*
>    * A region containing a mapping of a non-memory backed file under NOMMU
>    * conditions.  These are held in a global tree and are pinned by the VMAs that
> @@ -657,9 +663,7 @@ struct vm_area_struct {
>   			unsigned long vm_start;
>   			unsigned long vm_end;
>   		};
> -#ifdef CONFIG_PER_VMA_LOCK
> -		struct rcu_head vm_rcu;	/* Used for deferred freeing. */
> -#endif
> +		freeptr_t vm_freeptr; /* Pointer used by SLAB_TYPESAFE_BY_RCU */
>   	};
>   
>   	/*
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 10a971c2bde3..681b685b6c4e 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -234,12 +234,6 @@ enum _slab_flag_bits {
>   #define SLAB_NO_OBJ_EXT		__SLAB_FLAG_UNUSED
>   #endif
>   
> -/*
> - * freeptr_t represents a SLUB freelist pointer, which might be encoded
> - * and not dereferenceable if CONFIG_SLAB_FREELIST_HARDENED is enabled.
> - */
> -typedef struct { unsigned long v; } freeptr_t;
> -
>   /*
>    * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
>    *
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 71990f46aa4e..e7e76a660e4c 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -436,6 +436,98 @@ static struct kmem_cache *vm_area_cachep;
>   /* SLAB cache for mm_struct structures (tsk->mm) */
>   static struct kmem_cache *mm_cachep;
>   
> +static void vm_area_ctor(void *data)
> +{
> +	struct vm_area_struct *vma = (struct vm_area_struct *)data;
> +
> +#ifdef CONFIG_PER_VMA_LOCK
> +	/* vma is not locked, can't use vma_mark_detached() */
> +	vma->detached = true;
> +#endif
> +	INIT_LIST_HEAD(&vma->anon_vma_chain);
> +	vma_lock_init(vma);
> +}
> +
> +#ifdef CONFIG_PER_VMA_LOCK
> +
> +static void vma_clear(struct vm_area_struct *vma, struct mm_struct *mm)
> +{
> +	vma->vm_mm = mm;
> +	vma->vm_ops = &vma_dummy_vm_ops;
> +	vma->vm_start = 0;
> +	vma->vm_end = 0;
> +	vma->anon_vma = NULL;
> +	vma->vm_pgoff = 0;
> +	vma->vm_file = NULL;
> +	vma->vm_private_data = NULL;
> +	vm_flags_init(vma, 0);
> +	memset(&vma->vm_page_prot, 0, sizeof(vma->vm_page_prot));
> +	memset(&vma->shared, 0, sizeof(vma->shared));
> +	memset(&vma->vm_userfaultfd_ctx, 0, sizeof(vma->vm_userfaultfd_ctx));
> +	vma_numab_state_init(vma);
> +#ifdef CONFIG_ANON_VMA_NAME
> +	vma->anon_name = NULL;
> +#endif
> +#ifdef CONFIG_SWAP
> +	memset(&vma->swap_readahead_info, 0, sizeof(vma->swap_readahead_info));
> +#endif
> +#ifndef CONFIG_MMU
> +	vma->vm_region = NULL;
> +#endif
> +#ifdef CONFIG_NUMA
> +	vma->vm_policy = NULL;
> +#endif
> +}
> +
> +static void vma_copy(const struct vm_area_struct *src, struct vm_area_struct *dest)
> +{
> +	dest->vm_mm = src->vm_mm;
> +	dest->vm_ops = src->vm_ops;
> +	dest->vm_start = src->vm_start;
> +	dest->vm_end = src->vm_end;
> +	dest->anon_vma = src->anon_vma;
> +	dest->vm_pgoff = src->vm_pgoff;
> +	dest->vm_file = src->vm_file;
> +	dest->vm_private_data = src->vm_private_data;
> +	vm_flags_init(dest, src->vm_flags);
> +	memcpy(&dest->vm_page_prot, &src->vm_page_prot,
> +	       sizeof(dest->vm_page_prot));
> +	memcpy(&dest->shared, &src->shared, sizeof(dest->shared));
> +	memcpy(&dest->vm_userfaultfd_ctx, &src->vm_userfaultfd_ctx,
> +	       sizeof(dest->vm_userfaultfd_ctx));
> +#ifdef CONFIG_ANON_VMA_NAME
> +	dest->anon_name = src->anon_name;
> +#endif
> +#ifdef CONFIG_SWAP
> +	memcpy(&dest->swap_readahead_info, &src->swap_readahead_info,
> +	       sizeof(dest->swap_readahead_info));
> +#endif
> +#ifndef CONFIG_MMU
> +	dest->vm_region = src->vm_region;
> +#endif
> +#ifdef CONFIG_NUMA
> +	dest->vm_policy = src->vm_policy;
> +#endif
> +}
> +
> +#else /* CONFIG_PER_VMA_LOCK */
> +
> +static void vma_clear(struct vm_area_struct *vma, struct mm_struct *mm)
> +{
> +	vma_init(vma, mm);
> +}
> +
> +static void vma_copy(const struct vm_area_struct *src, struct vm_area_struct *dest)
> +{
> +	/*
> +	 * orig->shared.rb may be modified concurrently, but the clone
> +	 * will be reinitialized.
> +	 */
> +	data_race(memcpy(dest, src, sizeof(*dest)));
> +}
> +
> +#endif /* CONFIG_PER_VMA_LOCK */
> +
>   struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
>   {
>   	struct vm_area_struct *vma;
> @@ -444,7 +536,7 @@ struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
>   	if (!vma)
>   		return NULL;
>   
> -	vma_init(vma, mm);
> +	vma_clear(vma, mm);
>   
>   	return vma;
>   }
> @@ -458,49 +550,46 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
>   
>   	ASSERT_EXCLUSIVE_WRITER(orig->vm_flags);
>   	ASSERT_EXCLUSIVE_WRITER(orig->vm_file);
> -	/*
> -	 * orig->shared.rb may be modified concurrently, but the clone
> -	 * will be reinitialized.
> -	 */
> -	data_race(memcpy(new, orig, sizeof(*new)));
> -	vma_lock_init(new);
> -	INIT_LIST_HEAD(&new->anon_vma_chain);
> -#ifdef CONFIG_PER_VMA_LOCK
> -	/* vma is not locked, can't use vma_mark_detached() */
> -	new->detached = true;
> -#endif
> +	vma_copy(orig, new);
>   	vma_numab_state_init(new);
>   	dup_anon_vma_name(orig, new);
>   
>   	return new;
>   }
>   
> -void __vm_area_free(struct vm_area_struct *vma)
> +static void __vm_area_free(struct vm_area_struct *vma, bool unreachable)
>   {
> +#ifdef CONFIG_PER_VMA_LOCK
> +	/*
> +	 * With SLAB_TYPESAFE_BY_RCU, vma can be reused and we need
> +	 * vma->detached to be set before vma is returned into the cache.
> +	 * This way reused object won't be used by readers until it's
> +	 * initialized and reattached.
> +	 * If vma is unreachable, there can be no other users and we
> +	 * can set vma->detached directly with no risk of a race.
> +	 * If vma is reachable, then it should have been already detached
> +	 * under vma write-lock or it was never attached.
> +	 */
> +	if (unreachable)
> +		vma->detached = true;
> +	else
> +		VM_BUG_ON_VMA(!is_vma_detached(vma), vma);
> +	vma->vm_lock_seq = UINT_MAX;
> +#endif
> +	VM_BUG_ON_VMA(!list_empty(&vma->anon_vma_chain), vma);
>   	vma_numab_state_free(vma);
>   	free_anon_vma_name(vma);
>   	kmem_cache_free(vm_area_cachep, vma);
>   }
>   
> -#ifdef CONFIG_PER_VMA_LOCK
> -static void vm_area_free_rcu_cb(struct rcu_head *head)
> +void vm_area_free(struct vm_area_struct *vma)
>   {
> -	struct vm_area_struct *vma = container_of(head, struct vm_area_struct,
> -						  vm_rcu);
> -
> -	/* The vma should not be locked while being destroyed. */
> -	VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock.lock), vma);
> -	__vm_area_free(vma);
> +	__vm_area_free(vma, false);
>   }
> -#endif
>   
> -void vm_area_free(struct vm_area_struct *vma)
> +void vm_area_free_unreachable(struct vm_area_struct *vma)
>   {
> -#ifdef CONFIG_PER_VMA_LOCK
> -	call_rcu(&vma->vm_rcu, vm_area_free_rcu_cb);
> -#else
> -	__vm_area_free(vma);
> -#endif
> +	__vm_area_free(vma, true);
>   }
>   
>   static void account_kernel_stack(struct task_struct *tsk, int account)
> @@ -3141,6 +3230,12 @@ void __init mm_cache_init(void)
>   
>   void __init proc_caches_init(void)
>   {
> +	struct kmem_cache_args args = {
> +		.use_freeptr_offset = true,
> +		.freeptr_offset = offsetof(struct vm_area_struct, vm_freeptr),
> +		.ctor = vm_area_ctor,
> +	};
> +
>   	sighand_cachep = kmem_cache_create("sighand_cache",
>   			sizeof(struct sighand_struct), 0,
>   			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
> @@ -3157,9 +3252,11 @@ void __init proc_caches_init(void)
>   			sizeof(struct fs_struct), 0,
>   			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
>   			NULL);
> -	vm_area_cachep = KMEM_CACHE(vm_area_struct,
> -			SLAB_HWCACHE_ALIGN|SLAB_NO_MERGE|SLAB_PANIC|
> +	vm_area_cachep = kmem_cache_create("vm_area_struct",
> +			sizeof(struct vm_area_struct), &args,
> +			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
>   			SLAB_ACCOUNT);
> +
>   	mmap_init();
>   	nsproxy_cache_init();
>   }
> diff --git a/mm/memory.c b/mm/memory.c
> index b252f19b28c9..6f4d4d423835 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -6368,10 +6368,16 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>   	if (!vma)
>   		goto inval;
>   
> -	if (!vma_start_read(vma))
> +	if (!vma_start_read(mm, vma))
>   		goto inval;
>   
> -	/* Check if the VMA got isolated after we found it */
> +	/*
> +	 * Check if the VMA got isolated after we found it.
> +	 * Note: vma we found could have been recycled and is being reattached.
> +	 * It's possible to attach a vma while it is read-locked, however a
> +	 * read-locked vma can't be detached (detaching requires write-locking).
> +	 * Therefore if this check passes, we have an attached and stable vma.
> +	 */
>   	if (is_vma_detached(vma)) {
>   		vma_end_read(vma);
>   		count_vm_vma_lock_event(VMA_LOCK_MISS);
> @@ -6385,8 +6391,9 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>   	 * fields are accessible for RCU readers.
>   	 */
>   
> -	/* Check since vm_start/vm_end might change before we lock the VMA */
> -	if (unlikely(address < vma->vm_start || address >= vma->vm_end))
> +	/* Check if the vma we locked is the right one. */
> +	if (unlikely(vma->vm_mm != mm ||
> +		     address < vma->vm_start || address >= vma->vm_end))
>   		goto inval_end_read;
>   
>   	rcu_read_unlock();
> diff --git a/mm/vma.c b/mm/vma.c
> index cdc63728f47f..648784416833 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -414,7 +414,7 @@ void remove_vma(struct vm_area_struct *vma, bool unreachable)
>   		fput(vma->vm_file);
>   	mpol_put(vma_policy(vma));
>   	if (unreachable)
> -		__vm_area_free(vma);
> +		vm_area_free_unreachable(vma);
>   	else
>   		vm_area_free(vma);
>   }
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 0cdc5f8c3d60..3eeb1317cc69 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -685,14 +685,15 @@ static inline void mpol_put(struct mempolicy *)
>   {
>   }
>   
> -static inline void __vm_area_free(struct vm_area_struct *vma)
> +static inline void vm_area_free(struct vm_area_struct *vma)
>   {
>   	free(vma);
>   }
>   
> -static inline void vm_area_free(struct vm_area_struct *vma)
> +static inline void vm_area_free_unreachable(struct vm_area_struct *vma)
>   {
> -	__vm_area_free(vma);
> +	vma->detached = true;
> +	vm_area_free(vma);
>   }
>   
>   static inline void lru_add_drain(void)

--------------cFFMQsuqNz8ju84FMDmBy5Ja
Content-Type: application/gzip; name="config.gz"
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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
r9L/F1YwJXk2jwEA
--------------cFFMQsuqNz8ju84FMDmBy5Ja
Content-Type: text/plain; charset=UTF-8; name="oops-bisect"
Content-Disposition: attachment; filename="oops-bisect"
Content-Transfer-Encoding: base64

IyBiYWQ6IFs3ZTBhNzllYjE2NzRjYmU4OTE2YmJjN2Q3ZjlmNmJmYjQwOWRmYjRjXSBjb21t
aXQgMDc5MDMwM2VjODY5IGxlYWRzIHRvIGNwdSBzdGFsbCB3aXRob3V0IENPTkZJR19GQU5P
VElGWV9BQ0NFU1NfUEVSTUlTU0lPTlM9eQpnaXQgYmlzZWN0IHN0YXJ0ICdIRUFEJwojIHN0
YXR1czogd2FpdGluZyBmb3IgZ29vZCBjb21taXQocyksIGJhZCBjb21taXQga25vd24KIyBn
b29kOiBbZmFjMDRlZmM1Yzc5M2RjY2JkMDdlMmQ1OWFmOWY5MGI3ZmMwZGNhNF0gTGludXgg
Ni4xMy1yYzIKZ2l0IGJpc2VjdCBnb29kIGZhYzA0ZWZjNWM3OTNkY2NiZDA3ZTJkNTlhZjlm
OTBiN2ZjMGRjYTQKIyBiYWQ6IFswNjAzNmE1M2NjYWYyMjc2N2JiZDVjYWE0OTFjNTJiYjY3
MzYwNGU2XSBNZXJnZSBicmFuY2ggJ2Zvci1uZXh0JyBvZiBnaXQ6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYnBmL2JwZi1uZXh0LmdpdApnaXQgYmlzZWN0
IGJhZCAwNjAzNmE1M2NjYWYyMjc2N2JiZDVjYWE0OTFjNTJiYjY3MzYwNGU2CiMgYmFkOiBb
ZGRhYWJlYTllYzQzMjJiN2Q1Y2RkMjAxN2M0Y2M1OWIyOGFkYjhmYl0gTWVyZ2UgYnJhbmNo
ICdsaW51eC1uZXh0JyBvZiBnaXQ6Ly9naXRodWIuY29tL2Mtc2t5L2Nza3ktbGludXguZ2l0
CmdpdCBiaXNlY3QgYmFkIGRkYWFiZWE5ZWM0MzIyYjdkNWNkZDIwMTdjNGNjNTliMjhhZGI4
ZmIKIyBnb29kOiBbNWRlOTU3Mzg0OGFhNTEyYmIwNmU4ODQyZmFmNWRhNjkyNmU2OTNiZF0g
TWVyZ2UgYnJhbmNoICd0aXAvdXJnZW50JyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvdGlwL3RpcC5naXQKZ2l0IGJpc2VjdCBnb29kIDVkZTk1
NzM4NDhhYTUxMmJiMDZlODg0MmZhZjVkYTY5MjZlNjkzYmQKIyBiYWQ6IFs4YmI0MzU3MDdj
MDdmZjc2NTBmZThlZjY5MDcwMDg0NWM3NzJkM2NmXSBNZXJnZSBicmFuY2ggJ2Zvci1uZXh0
JyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYW1s
b2dpYy9saW51eC5naXQKZ2l0IGJpc2VjdCBiYWQgOGJiNDM1NzA3YzA3ZmY3NjUwZmU4ZWY2
OTA3MDA4NDVjNzcyZDNjZgojIGdvb2Q6IFs3ZTI3NGIzNDMwOWJiNzg4NGNhZGU1NWI3Y2Iw
YjBiODcyMmRjZGUyXSBtbTogZG9femFwX3B0ZV9yYW5nZTogcmV0dXJuIGFueV9za2lwcGVk
IGluZm9ybWF0aW9uIHRvIHRoZSBjYWxsZXIKZ2l0IGJpc2VjdCBnb29kIDdlMjc0YjM0MzA5
YmI3ODg0Y2FkZTU1YjdjYjBiMGI4NzIyZGNkZTIKIyBza2lwOiBbNmUxNjVmNTQ0Mzc5MzFm
MzI5ZDA5ZGNhNmMxOWQ5OWFmMDhhMzZlMV0gbW0vcGFnZV9pc29sYXRpb246IGZpeHVwIGlz
b2xhdGVfc2luZ2xlX3BhZ2VibG9jaygpIGNvbW1lbnQgcmVnYXJkaW5nIHNwbGl0dGluZyBm
cmVlIHBhZ2VzCmdpdCBiaXNlY3Qgc2tpcCA2ZTE2NWY1NDQzNzkzMWYzMjlkMDlkY2E2YzE5
ZDk5YWYwOGEzNmUxCiMgZ29vZDogW2M4MWNhZDk5YjBiMTNiMGJiMzM5YThlMzBhYTEzZWJj
MWU1ZGJmZjNdIG1pbm1heC5oOiB1cGRhdGUgc29tZSBjb21tZW50cwpnaXQgYmlzZWN0IGdv
b2QgYzgxY2FkOTliMGIxM2IwYmIzMzlhOGUzMGFhMTNlYmMxZTVkYmZmMwojIGdvb2Q6IFsx
OTE4MTI5Njk4NzFlOWFlNDQ3Y2YzZTc0MjZmYjcyYjM1MWYxMzM2XSBzY3JpcHRzL3NwZWxs
aW5nLnR4dDogYWRkIG1vcmUgc3BlbGxpbmdzIHRvIHNwZWxsaW5nLnR4dApnaXQgYmlzZWN0
IGdvb2QgMTkxODEyOTY5ODcxZTlhZTQ0N2NmM2U3NDI2ZmI3MmIzNTFmMTMzNgojIGdvb2Q6
IFtmNjM1Y2M1MzkxMGQ0YmE3NzI2ZjkyNWU0OWNlNTdjNTMzMmNkNmExXSB1Y291bnRzOiBt
b3ZlIGtmcmVlKCkgb3V0IG9mIGNyaXRpY2FsIHpvbmUgcHJvdGVjdGVkIGJ5IHVjb3VudHNf
bG9jawpnaXQgYmlzZWN0IGdvb2QgZjYzNWNjNTM5MTBkNGJhNzcyNmY5MjVlNDljZTU3YzUz
MzJjZDZhMQojIHNraXA6IFs0ZjNjZTI0MGZkNGJkNzY4MTMzNTIzMWI4Y2YyMWZkYzM3YzRl
ODQ4XSBtbS9wYWdlX2FsbG9jOiBjb25kaXRpb25hbGx5IHNwbGl0ID4gcGFnZWJsb2NrX29y
ZGVyIHBhZ2VzIGluIGZyZWVfb25lX3BhZ2UoKSBhbmQgbW92ZV9mcmVlcGFnZXNfYmxvY2tf
aXNvbGF0ZSgpCmdpdCBiaXNlY3Qgc2tpcCA0ZjNjZTI0MGZkNGJkNzY4MTMzNTIzMWI4Y2Yy
MWZkYzM3YzRlODQ4CiMgYmFkOiBbNTNiMmE0MjhlMTAzNmU0ODFhZjBjN2ZjMzljYjkyMTI4
MzQ0YjY4OV0gTWVyZ2UgYnJhbmNoICdmb3ItbmV4dCcgb2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L21hc2FoaXJveS9saW51eC1rYnVpbGQuZ2l0
CmdpdCBiaXNlY3QgYmFkIDUzYjJhNDI4ZTEwMzZlNDgxYWYwYzdmYzM5Y2I5MjEyODM0NGI2
ODkKIyBnb29kOiBbMTA2MmEyNGQwYTE3ODYyNzM4ZGYwZTYyMDJkNDQ1YmEwYTI2MDA4OF0g
bW06IGludHJvZHVjZSB2bWFfc3RhcnRfcmVhZF9sb2NrZWR7X25lc3RlZH0gaGVscGVycwpn
aXQgYmlzZWN0IGdvb2QgMTA2MmEyNGQwYTE3ODYyNzM4ZGYwZTYyMDJkNDQ1YmEwYTI2MDA4
OAojIGJhZDogW2M2ZmNkODM2NTgyMDBjNzRjODM3YzRhMmUzZjk1ZjdlYjQ4N2RkN2RdIG1z
ZWFsOiByZW1vdmUgY2FuX2RvX21zZWFsKCkKZ2l0IGJpc2VjdCBiYWQgYzZmY2Q4MzY1ODIw
MGM3NGM4MzdjNGEyZTNmOTVmN2ViNDg3ZGQ3ZAojIGJhZDogWzI2ODRhNDI0NGJmZWFjMGMy
NDZhMjYxMDk5N2RhZDc4YjJkYzc4NzddIG1tL3NsYWI6IGFsbG93IGZyZWVwdHJfb2Zmc2V0
IHRvIGJlIHVzZWQgd2l0aCBjdG9yCmdpdCBiaXNlY3QgYmFkIDI2ODRhNDI0NGJmZWFjMGMy
NDZhMjYxMDk5N2RhZDc4YjJkYzc4NzcKIyBnb29kOiBbOThkNWVlZmI5NzVlNDZjMTgyZmMy
ZGU2YTU0M2UzNzU0ODFhZWRhZl0gbW06IG1hcmsgdm1hIGFzIGRldGFjaGVkIHVudGlsIGl0
J3MgYWRkZWQgaW50byB2bWEgdHJlZQpnaXQgYmlzZWN0IGdvb2QgOThkNWVlZmI5NzVlNDZj
MTgyZmMyZGU2YTU0M2UzNzU0ODFhZWRhZgojIGJhZDogWzg1YWQ0MTMzODlhZWMwNGNmYWFi
YTA0M2NhYTgxMjhiNzZjNmU0OTFdIG1tOiBtYWtlIHZtYSBjYWNoZSBTTEFCX1RZUEVTQUZF
X0JZX1JDVQpnaXQgYmlzZWN0IGJhZCA4NWFkNDEzMzg5YWVjMDRjZmFhYmEwNDNjYWE4MTI4
Yjc2YzZlNDkxCiMgZmlyc3QgYmFkIGNvbW1pdDogWzg1YWQ0MTMzODlhZWMwNGNmYWFiYTA0
M2NhYTgxMjhiNzZjNmU0OTFdIG1tOiBtYWtlIHZtYSBjYWNoZSBTTEFCX1RZUEVTQUZFX0JZ
X1JDVQo=
--------------cFFMQsuqNz8ju84FMDmBy5Ja
Content-Type: application/gzip; name="oops-decoded.gz"
Content-Disposition: attachment; filename="oops-decoded.gz"
Content-Transfer-Encoding: base64

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


--------------cFFMQsuqNz8ju84FMDmBy5Ja--

