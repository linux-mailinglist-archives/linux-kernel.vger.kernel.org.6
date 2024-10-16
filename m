Return-Path: <linux-kernel+bounces-367335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CFF9A011A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65BA51F2559B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FAF18C915;
	Wed, 16 Oct 2024 06:09:33 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A16F18C330
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729058972; cv=none; b=lmMmxeT84PkhJk/RpbNouEIk87d8BiMF/7DYC8wHNTJwyRUbrVGghdh/leJB9L6G2i5HqtmfpHYHvjtfqHLjPNAWE2bKo2OEwuFvLTTM8Uftf7dZKX17dXhB55u3OSPK4nLo4vCNCyTHFufu8rkgwckZ2HTX6LxztUK5OMB7Qrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729058972; c=relaxed/simple;
	bh=/CSTsnT9W3/UIbPx7DWIMWaLqoM2COYD2RmSYfkGTBc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iYYrbPh+vP1wQ5Yrx1ZR+ZPaPUKhC/WqlA/+vPUD0KTLiUkZAXxUb4rWOgWyBMw3Mpb4JB8sy7X9tQpKHMX6O9wMCB63/tCjQbwnRg4BskMj+jQO4riZLN6j1QVCseLBAguWZxn6+0CgmcCfXDAjGN7oJQsMcUSkP4H6iGf7z2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8DxeYqTWA9nVIYfAA--.45332S3;
	Wed, 16 Oct 2024 14:09:23 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMDx_9ePWA9nMj8sAA--.15772S3;
	Wed, 16 Oct 2024 14:09:21 +0800 (CST)
Subject: Re: [PATCH v2 2/3] LoongArch: Add barrier between set_pte and memory
 access
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org
References: <20241014035855.1119220-1-maobibo@loongson.cn>
 <20241014035855.1119220-3-maobibo@loongson.cn>
 <CAAhV-H6nkiw_eOS3jFdojJsCJOA2yiprQmaT5c=SnPhJTOyKkQ@mail.gmail.com>
 <e7c06bf4-897a-7060-61f9-97435d2af16e@loongson.cn>
 <CAAhV-H6H=Q=1KN5q8kR3j55Ky--FRNifCT93axhqE=vNMArDaQ@mail.gmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <1b4070c9-921e-65e3-c2a7-dab486d4f17f@loongson.cn>
Date: Wed, 16 Oct 2024 14:09:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6H=Q=1KN5q8kR3j55Ky--FRNifCT93axhqE=vNMArDaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDx_9ePWA9nMj8sAA--.15772S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtr18CF4xtw18JF45Ww48AFc_yoW7AFW5pr
	W2k3Z8Kr4kXF1Fvw12vw1fWr1ft39rWFy8Xw1FqryDCw1qqFy29ry8WrW8uryxXa4rJa1x
	uw4Utr13WFWUJagCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4BHqDU
	UUU



On 2024/10/15 下午8:27, Huacai Chen wrote:
> On Tue, Oct 15, 2024 at 10:54 AM maobibo <maobibo@loongson.cn> wrote:
>>
>>
>>
>> On 2024/10/14 下午2:31, Huacai Chen wrote:
>>> Hi, Bibo,
>>>
>>> On Mon, Oct 14, 2024 at 11:59 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>>>
>>>> It is possible to return a spurious fault if memory is accessed
>>>> right after the pte is set. For user address space, pte is set
>>>> in kernel space and memory is accessed in user space, there is
>>>> long time for synchronization, no barrier needed. However for
>>>> kernel address space, it is possible that memory is accessed
>>>> right after the pte is set.
>>>>
>>>> Here flush_cache_vmap/flush_cache_vmap_early is used for
>>>> synchronization.
>>>>
>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>> ---
>>>>    arch/loongarch/include/asm/cacheflush.h | 14 +++++++++++++-
>>>>    1 file changed, 13 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/loongarch/include/asm/cacheflush.h b/arch/loongarch/include/asm/cacheflush.h
>>>> index f8754d08a31a..53be231319ef 100644
>>>> --- a/arch/loongarch/include/asm/cacheflush.h
>>>> +++ b/arch/loongarch/include/asm/cacheflush.h
>>>> @@ -42,12 +42,24 @@ void local_flush_icache_range(unsigned long start, unsigned long end);
>>>>    #define flush_cache_dup_mm(mm)                         do { } while (0)
>>>>    #define flush_cache_range(vma, start, end)             do { } while (0)
>>>>    #define flush_cache_page(vma, vmaddr, pfn)             do { } while (0)
>>>> -#define flush_cache_vmap(start, end)                   do { } while (0)
>>>>    #define flush_cache_vunmap(start, end)                 do { } while (0)
>>>>    #define flush_icache_user_page(vma, page, addr, len)   do { } while (0)
>>>>    #define flush_dcache_mmap_lock(mapping)                        do { } while (0)
>>>>    #define flush_dcache_mmap_unlock(mapping)              do { } while (0)
>>>>
>>>> +/*
>>>> + * It is possible for a kernel virtual mapping access to return a spurious
>>>> + * fault if it's accessed right after the pte is set. The page fault handler
>>>> + * does not expect this type of fault. flush_cache_vmap is not exactly the
>>>> + * right place to put this, but it seems to work well enough.
>>>> + */
>>>> +static inline void flush_cache_vmap(unsigned long start, unsigned long end)
>>>> +{
>>>> +       smp_mb();
>>>> +}
>>>> +#define flush_cache_vmap flush_cache_vmap
>>>> +#define flush_cache_vmap_early flush_cache_vmap
>>>   From the history of flush_cache_vmap_early(), It seems only archs with
>>> "virtual cache" (VIVT or VIPT) need this API, so LoongArch can be a
>>> no-op here.
> OK,  flush_cache_vmap_early() also needs smp_mb().
> 
>>
>> Here is usage about flush_cache_vmap_early in file linux/mm/percpu.c,
>> map the page and access it immediately. Do you think it should be noop
>> on LoongArch.
>>
>> rc = __pcpu_map_pages(unit_addr, &pages[unit * unit_pages],
>>                                        unit_pages);
>> if (rc < 0)
>>       panic("failed to map percpu area, err=%d\n", rc);
>>       flush_cache_vmap_early(unit_addr, unit_addr + ai->unit_size);
>>       /* copy static data */
>>       memcpy((void *)unit_addr, __per_cpu_load, ai->static_size);
>> }
>>
>>
>>>
>>> And I still think flush_cache_vunmap() should be a smp_mb(). A
>>> smp_mb() in flush_cache_vmap() prevents subsequent accesses be
>>> reordered before pte_set(), and a smp_mb() in flush_cache_vunmap()
>> smp_mb() in flush_cache_vmap() does not prevent reorder. It is to flush
>> pipeline and let page table walker HW sync with data cache.
>>
>> For the following example.
>>     rb = vmap(pages, nr_meta_pages + 2 * nr_data_pages,
>>                     VM_MAP | VM_USERMAP, PAGE_KERNEL);
>>     if (rb) {
>> <<<<<<<<<<< * the sentence if (rb) can prevent reorder. Otherwise with
>> any API kmalloc/vmap/vmalloc and subsequent memory access, there will be
>> reorder issu. *
>>         kmemleak_not_leak(pages);
>>         rb->pages = pages;
>>         rb->nr_pages = nr_pages;
>>         return rb;
>>     }
>>
>>> prevents preceding accesses be reordered after pte_clear(). This
>> Can you give an example about such usage about flush_cache_vunmap()? and
>> we can continue to talk about it, else it is just guessing.
> Since we cannot reach a consensus, and the flush_cache_* API look very
> strange for this purpose (Yes, I know PowerPC does it like this, but
> ARM64 doesn't). I prefer to still use the ARM64 method which means add
> a dbar in set_pte(). Of course the performance will be a little worse,
> but still better than the old version, and it is more robust.
> 
> I know you are very busy, so if you have no time you don't need to
> send V3, I can just do a small modification on the 3rd patch.
No, I will send V3 by myself. And I will drop the this patch in this 
patchset since by actual test vmalloc_test works well even without this
patch on 3C5000 Dual-way, also weak function kernel_pte_init will be 
replaced with inline function rebased on
 
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-define-general-function-pxd_init.patch

I dislike the copy-paste method without further understanding :(, 
although I also copy and paste code, but as least I try best to 
understand it.

Regards
Bibo Mao
> 
> 
> Huacai
> 
>>
>> Regards
>> Bibo Mao
>>> potential problem may not be seen from experiment, but it is needed in
>>> theory.
>>>
>>> Huacai
>>>
>>>> +
>>>>    #define cache_op(op, addr)                                             \
>>>>           __asm__ __volatile__(                                           \
>>>>           "       cacop   %0, %1                                  \n"     \
>>>> --
>>>> 2.39.3
>>>>
>>>>
>>
>>


