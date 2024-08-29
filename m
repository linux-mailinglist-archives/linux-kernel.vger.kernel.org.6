Return-Path: <linux-kernel+bounces-306079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B24B9638DA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1B68B22667
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FBE43ADE;
	Thu, 29 Aug 2024 03:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RKYCS/bs"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3898200CB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724902763; cv=none; b=rbsTNLC3EbN7IWBHlR8y0sDa6DbzOeAlkDl27w+q+NzLuXeVgN4q2X97/0m4PicjaI590y+L0LVIinx9Ut9MmGhdnca/k1GNpbXlYuL2Tl0ITvjX49VdKnSh7UHWScAVzqhI/kSb/vSaFXHY+7CVA0Iqp9qx/ygSo7IcrY7qGpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724902763; c=relaxed/simple;
	bh=e0t7rx2ij1ewh77y9TTKu2hubA9DyF34wEseYxB+lVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkBtzHalfFXLHdrIPXM5mjxd5sA6CXYqzJf4XKJ7dircC0BWIhup1s35gRQJggW618BU2R28AvpxABCjhdaHK0kZGXFzudILYh4Y5l7i4bFjAH/FvxEKHQaJdKhNLzN3lskYxBe9RtkREFcDBaQhXy8dzECy+MhwmNWeOxjcDrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RKYCS/bs; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7c2237bd-c1eb-4cf6-9135-420a321ebd3b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724902758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+Lh2vHxUB+86yeUS0d5uwMJVWzCawU4cjiNowF9hs4=;
	b=RKYCS/bs9Fuf2a0LIc6oZEc0Qxnsqv4A/6jg2vqw9A1X/vYr6M0gINoQ8cYiZo68t/9AW/
	7hTk0h0Q3vTIPdKJW1u/PDgjvwFtRiTbiKd6SkCPS50ico497y8yK/zh+jlcuEuMRbqZOL
	GN5HEvWBmr2PiMol50Z18Xh9PnBmcMA=
Date: Thu, 29 Aug 2024 11:39:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 02/14] arm: adjust_pte() use pte_offset_map_rw_nolock()
To: David Hildenbrand <david@redhat.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 hughd@google.com, willy@infradead.org, vbabka@kernel.org,
 akpm@linux-foundation.org, rppt@kernel.org, vishal.moola@gmail.com,
 peterx@redhat.com, ryan.roberts@arm.com, christophe.leroy2@cs-soprasteria.com
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
 <7915acf5887e7bf0c5cc71ff30ad2fe8447d005d.1724310149.git.zhengqi.arch@bytedance.com>
 <77f3f5ce-dd12-4ca2-90cd-0f2226fe26ba@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <77f3f5ce-dd12-4ca2-90cd-0f2226fe26ba@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2024/8/26 23:26, David Hildenbrand wrote:
> On 22.08.24 09:13, Qi Zheng wrote:
>> In do_adjust_pte(), we may modify the pte entry. At this time, the write
>> lock of mmap_lock is not held, and the pte_same() check is not performed
>> after the PTL held. The corresponding pmd entry may have been modified
>> concurrently. Therefore, in order to ensure the stability if pmd entry,
>> use pte_offset_map_rw_nolock() to replace pte_offset_map_nolock(), 
>> and do
>> pmd_same() check after holding the PTL.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

>> ---
>>   arch/arm/mm/fault-armv.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
>> index 831793cd6ff94..de6c7d8a2ddfc 100644
>> --- a/arch/arm/mm/fault-armv.c
>> +++ b/arch/arm/mm/fault-armv.c
>> @@ -94,6 +94,7 @@ static int adjust_pte(struct vm_area_struct *vma, 
>> unsigned long address,
>>       pud_t *pud;
>>       pmd_t *pmd;
>>       pte_t *pte;
>> +    pmd_t pmdval;
>>       int ret;
>>         pgd = pgd_offset(vma->vm_mm, address);
>> @@ -112,16 +113,22 @@ static int adjust_pte(struct vm_area_struct 
>> *vma, unsigned long address,
>>       if (pmd_none_or_clear_bad(pmd))
>>           return 0;
>>   +again:
>>       /*
>>        * This is called while another page table is mapped, so we
>>        * must use the nested version.  This also means we need to
>>        * open-code the spin-locking.
>>        */
>> -    pte = pte_offset_map_nolock(vma->vm_mm, pmd, address, &ptl);
>> +    pte = pte_offset_map_rw_nolock(vma->vm_mm, pmd, address, 
>> &pmdval, &ptl);
>>       if (!pte)
>>           return 0;
>>         do_pte_lock(ptl);
>> +    if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
>> +        do_pte_unlock(ptl);
>> +        pte_unmap(pte);
>> +        goto again;
>> +    }
>>         ret = do_adjust_pte(vma, address, pfn, pte);
>
> Looks correct to me, but I wonder why the missing pmd_same check is 
> not an issue so far ... any experts? THP on __LINUX_ARM_ARCH__ < 6 is 
> not really used/possible?

I think it is because it does not support THP.

TRANSPARENT_HUGEPAGE depends on HAVE_ARCH_TRANSPARENT_HUGEPAGE which
depends on ARM_LPAE. However, the Kconfig says ARM_LPAE is only
supported on ARMv7 processor.

config ARM_LPAE
          bool "Support for the Large Physical Address Extension"
          depends on MMU && CPU_32v7 && !CPU_32v6 && !CPU_32v5 && \
                  !CPU_32v4 && !CPU_32v3
          select PHYS_ADDR_T_64BIT
          select SWIOTLB
          help
            Say Y if you have an ARMv7 processor supporting the LPAE page
            table format and you would like to access memory beyond the
            4GB limit. The resulting kernel image will not run on
            processors without the LPA extension.

            If unsure, say N.

Thanks.
>
> Acked-by: David Hildenbrand <david@redhat.com>
>


