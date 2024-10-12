Return-Path: <linux-kernel+bounces-362043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D72499B03C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 04:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307041F232F8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 02:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB4447A73;
	Sat, 12 Oct 2024 02:49:16 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618F74438B
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 02:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728701356; cv=none; b=tdtAeNSJ8oVQan+RrAQDyP2HlGqofpOcWsaAFFI/Ytl+8v8iGBsiqI7vnutx8zfYQ9H1iZXCM6rcn6MpJHNHnzB+MYdJi1mxOSlZ9L3rob6Xdc7li7rF4ZrEIaZXeSZPdSe/DHMdgcmdld13EPxeRvD0SxAbuqnv+iDjMnISlLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728701356; c=relaxed/simple;
	bh=gPHg0/l3WnAGyOd8oGINV/oS8ZKHXrGils67sEDRRS8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=l72bzKAAL8AIS3jD8rkgOYbREq2I84nyWJpQV3xVQPQfhsmqdJX2ye9dEnwF/yNy0nIo2PtW46RdZbX9kwOzhDLJ96EfgNrqfBjUTZ9R/JNQW2+wMiVXvsUYv32aeoiYlGHlzb/xd99D/gR1ZYf0/4rB+Y73sUUMr0fmmlYT+LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxDOuo4wlnNWoUAA--.31403S3;
	Sat, 12 Oct 2024 10:49:12 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMDx_9en4wlnIaAkAA--.51933S3;
	Sat, 12 Oct 2024 10:49:11 +0800 (CST)
Subject: Re: [PATCH 3/4] LoongArch: Add barrier between set_pte and memory
 access
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org
References: <20241010035048.3422527-1-maobibo@loongson.cn>
 <20241010035048.3422527-4-maobibo@loongson.cn>
 <CAAhV-H6OR_HYSF451vSk_qSt1a6froSPZKY-=YSRBQgww5a+0A@mail.gmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <1141ad15-26ae-71a9-9f6f-26671d01a30e@loongson.cn>
Date: Sat, 12 Oct 2024 10:48:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6OR_HYSF451vSk_qSt1a6froSPZKY-=YSRBQgww5a+0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDx_9en4wlnIaAkAA--.51933S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr13WF4fZry7Kr43Wry7twc_yoW5Aw48pr
	y2k3Z8Krs7WF4fJw1jvr1rWr18X39rWF1xK3ySvryUCw1DXF12gryrWws5ury7Xa4rJa1x
	u3yUK345WFWUAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8g6pPUUUU
	U==

Huacai,

On 2024/10/12 上午10:16, Huacai Chen wrote:
> Hi, Bibo,
> 
> On Thu, Oct 10, 2024 at 11:50 AM Bibo Mao <maobibo@loongson.cn> wrote:
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
> I don't know whether this is the best API to do this, and I think
> flush_cache_vunmap() also should be a smp_mb().
I do not know neither -:(, it seems that flush_cache_vmap() is better 
than arch_sync_kernel_mappings(), since function flush_cache_vmap() is 
used in vmalloc/kasan/percpu module, however arch_sync_kernel_mappings
is only used in vmalloc.

For flush_cache_vunmap(), it is used before pte_clear(), here is usage 
example.
void vunmap_range(unsigned long addr, unsigned long end)
{
         flush_cache_vunmap(addr, end);
         vunmap_range_noflush(addr, end);
         flush_tlb_kernel_range(addr, end);
}

So I think it is not necessary to add smp_mb() in flush_cache_vunmap().

Regards
Bibo Mao
> 
> 
> Huacai
> 
>> +#define flush_cache_vmap flush_cache_vmap
>> +#define flush_cache_vmap_early flush_cache_vmap
>> +
>>   #define cache_op(op, addr)                                             \
>>          __asm__ __volatile__(                                           \
>>          "       cacop   %0, %1                                  \n"     \
>> --
>> 2.39.3
>>


