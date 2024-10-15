Return-Path: <linux-kernel+bounces-365031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4485299DC75
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 04:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 987C8B21FA6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F360A16D9BF;
	Tue, 15 Oct 2024 02:54:08 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7630716BE0B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 02:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728960848; cv=none; b=NWhTxpOnf8iFZcGLABz8QcAKqiqy+dJufmmnEvj+88/aU8iRYrMqFLCz6FkjhxbUy4ZqD6M2Qptl3yPqiUVXBt5e5pWxNoBSagApXvO07XbvjuWNc6LHQ4z6Ti5Jty7MgnXf+GtlArHIPW7Dw1gkhjvXB6iLWBCPhH/tTJ9IdRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728960848; c=relaxed/simple;
	bh=0v38X+P0bkrXw5mBZzXsi+J2x6dVtZM3Gva1z9FdAaQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=n5yN3Mu3sWTdzqR/BuRKHd2j0Ej9Tg5t86sfBi68QYaLfucdLUi3vxv8poRBja8nbGYirLN5ctXaPWDwHINPuu5NIiFSjuahEhaVab221DDKjzp028u26kNbx3lRVkIzjzDAofsg94uec0znWwYD/+y76pQI79KWFMjUyekCCWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxholE2Q1nj4kcAA--.41130S3;
	Tue, 15 Oct 2024 10:53:56 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMAxSeZB2Q1nClAqAA--.8242S3;
	Tue, 15 Oct 2024 10:53:56 +0800 (CST)
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
From: maobibo <maobibo@loongson.cn>
Message-ID: <e7c06bf4-897a-7060-61f9-97435d2af16e@loongson.cn>
Date: Tue, 15 Oct 2024 10:53:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6nkiw_eOS3jFdojJsCJOA2yiprQmaT5c=SnPhJTOyKkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxSeZB2Q1nClAqAA--.8242S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXw1ktw1kAFykJrWfWw15GFX_yoWrXF1Dpr
	W2kas8Krs7WF4fXw1jvr13Wr1kX3srWF18Jw1FvryDCwsrXFy29ryxWrW8Wry3Xa4rJa1x
	Cw4UKw15WFWUXFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFApnUUU
	UU=



On 2024/10/14 下午2:31, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Mon, Oct 14, 2024 at 11:59 AM Bibo Mao <maobibo@loongson.cn> wrote:
>>
>> It is possible to return a spurious fault if memory is accessed
>> right after the pte is set. For user address space, pte is set
>> in kernel space and memory is accessed in user space, there is
>> long time for synchronization, no barrier needed. However for
>> kernel address space, it is possible that memory is accessed
>> right after the pte is set.
>>
>> Here flush_cache_vmap/flush_cache_vmap_early is used for
>> synchronization.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/cacheflush.h | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/loongarch/include/asm/cacheflush.h b/arch/loongarch/include/asm/cacheflush.h
>> index f8754d08a31a..53be231319ef 100644
>> --- a/arch/loongarch/include/asm/cacheflush.h
>> +++ b/arch/loongarch/include/asm/cacheflush.h
>> @@ -42,12 +42,24 @@ void local_flush_icache_range(unsigned long start, unsigned long end);
>>   #define flush_cache_dup_mm(mm)                         do { } while (0)
>>   #define flush_cache_range(vma, start, end)             do { } while (0)
>>   #define flush_cache_page(vma, vmaddr, pfn)             do { } while (0)
>> -#define flush_cache_vmap(start, end)                   do { } while (0)
>>   #define flush_cache_vunmap(start, end)                 do { } while (0)
>>   #define flush_icache_user_page(vma, page, addr, len)   do { } while (0)
>>   #define flush_dcache_mmap_lock(mapping)                        do { } while (0)
>>   #define flush_dcache_mmap_unlock(mapping)              do { } while (0)
>>
>> +/*
>> + * It is possible for a kernel virtual mapping access to return a spurious
>> + * fault if it's accessed right after the pte is set. The page fault handler
>> + * does not expect this type of fault. flush_cache_vmap is not exactly the
>> + * right place to put this, but it seems to work well enough.
>> + */
>> +static inline void flush_cache_vmap(unsigned long start, unsigned long end)
>> +{
>> +       smp_mb();
>> +}
>> +#define flush_cache_vmap flush_cache_vmap
>> +#define flush_cache_vmap_early flush_cache_vmap
>  From the history of flush_cache_vmap_early(), It seems only archs with
> "virtual cache" (VIVT or VIPT) need this API, so LoongArch can be a
> no-op here.

Here is usage about flush_cache_vmap_early in file linux/mm/percpu.c,
map the page and access it immediately. Do you think it should be noop 
on LoongArch.

rc = __pcpu_map_pages(unit_addr, &pages[unit * unit_pages],
                                      unit_pages);
if (rc < 0)
     panic("failed to map percpu area, err=%d\n", rc);
     flush_cache_vmap_early(unit_addr, unit_addr + ai->unit_size);
     /* copy static data */
     memcpy((void *)unit_addr, __per_cpu_load, ai->static_size);
}


> 
> And I still think flush_cache_vunmap() should be a smp_mb(). A
> smp_mb() in flush_cache_vmap() prevents subsequent accesses be
> reordered before pte_set(), and a smp_mb() in flush_cache_vunmap()
smp_mb() in flush_cache_vmap() does not prevent reorder. It is to flush 
pipeline and let page table walker HW sync with data cache.

For the following example.
   rb = vmap(pages, nr_meta_pages + 2 * nr_data_pages,
                   VM_MAP | VM_USERMAP, PAGE_KERNEL);
   if (rb) {
<<<<<<<<<<< * the sentence if (rb) can prevent reorder. Otherwise with 
any API kmalloc/vmap/vmalloc and subsequent memory access, there will be 
reorder issu. *
       kmemleak_not_leak(pages);
       rb->pages = pages;
       rb->nr_pages = nr_pages;
       return rb;
   }

> prevents preceding accesses be reordered after pte_clear(). This
Can you give an example about such usage about flush_cache_vunmap()? and 
we can continue to talk about it, else it is just guessing.

Regards
Bibo Mao
> potential problem may not be seen from experiment, but it is needed in
> theory.
> 
> Huacai
> 
>> +
>>   #define cache_op(op, addr)                                             \
>>          __asm__ __volatile__(                                           \
>>          "       cacop   %0, %1                                  \n"     \
>> --
>> 2.39.3
>>
>>


