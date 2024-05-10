Return-Path: <linux-kernel+bounces-175209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D9E8C1C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 04:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49611C20CC3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB8355C35;
	Fri, 10 May 2024 02:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="1oef9RVl"
Received: from out187-15.us.a.mail.aliyun.com (out187-15.us.a.mail.aliyun.com [47.90.187.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B513633EE
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 02:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715307539; cv=none; b=AYyKWXtmIq4uAD03CBvr/2FJeAYbAqFg7i7MPSbiQNSngF7fxewVEuQqUf0PVpLPlcrZoUu6KoU2ZEyAciPu1mUbD/y8+hsRg968r+/SrosjM+opiR/rtVS+2SqxdAv41rRfRgrTYa3A9HZEeXpICzTQszzhIJdGzImf6NAV14Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715307539; c=relaxed/simple;
	bh=Bs/K1/cqrY9IU/a3teHI1MTK7lNsbQvLmxYdI6+My50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uAFDg64/dfGHgnTMylSPNo5KsvZqzi7NXI70b1AQqiegqfN6/33N0X0HRLPFB/XeF/DNfM3EJPWCLi+w5cmIiWqxpGaFcSniy+gSMdsITUAZP00OKd1B00yb3gyj4qPmRjLi6OD2Q690e9bo4f6dFRDtX2KQVl+qcfakV3Lz2Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=1oef9RVl; arc=none smtp.client-ip=47.90.187.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1715307519; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=z3HIGnGQLgftTdCGksj44Ar9SYsXylJNvYIUDPPEOR8=;
	b=1oef9RVl4+N/ZYuO1r199a6Nq3kwuoLZIbNsqS5eAeKrUwDDaUy7KWB/Rlypbubs9gEf2XfB085njZAef06aOsTdB2EJCquUI8JP9TcOTIRQhA72BMBM6Q4qdaLZSQHihol1xFjGr2HsGIEOtzU+btyAdAE7PCEGFyRkuI7exvU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047209;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.XXRy7zj_1715307516;
Received: from 30.230.92.230(mailfrom:libang.li@antgroup.com fp:SMTPD_---.XXRy7zj_1715307516)
          by smtp.aliyun-inc.com;
          Fri, 10 May 2024 10:18:37 +0800
Message-ID: <282a3696-e883-49bb-9bb5-57d4762250cf@antgroup.com>
Date: Fri, 10 May 2024 10:18:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] riscv: Add update_mmu_tlb_range()
To: Alexandre Ghiti <alex@ghiti.fr>, akpm@linux-foundation.org,
 chenhuacai@kernel.org, tsbogend@alpha.franken.de, paul.walmsley@sifive.com,
 palmer@dabbelt.com, chris@zankel.net, jcmvbkbc@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 david@redhat.com, ryan.roberts@arm.com, ioworker0@gmail.com,
 libang.linux@gmail.com
References: <20240506155120.83105-1-libang.li@antgroup.com>
 <20240506155120.83105-4-libang.li@antgroup.com>
 <5a812c84-c3bb-4874-b29c-0816494b77a8@ghiti.fr>
Content-Language: en-US
From: "Bang Li" <libang.li@antgroup.com>
In-Reply-To: <5a812c84-c3bb-4874-b29c-0816494b77a8@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks, Alex!

On 2024/5/7 13:35, Alexandre Ghiti wrote:
> Hi Bang,
> 
> On 06/05/2024 17:51, Bang Li wrote:
>> Added update_mmu_tlb_range function, we can batch update tlb of an
>> address range.
>>
>> Signed-off-by: Bang Li <libang.li@antgroup.com>
>> ---
>>   arch/riscv/include/asm/pgtable.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/pgtable.h 
>> b/arch/riscv/include/asm/pgtable.h
>> index 661b2b4fe758..f784c6dd2c66 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -489,6 +489,10 @@ static inline void update_mmu_cache_range(struct 
>> vm_fault *vmf,
>>   #define __HAVE_ARCH_UPDATE_MMU_TLB
>>   #define update_mmu_tlb update_mmu_cache
>> +#define __HAVE_ARCH_UPDATE_MMU_TLB_RANGE
>> +#define update_mmu_tlb_range(vma, addr, ptep, nr) \
>> +    update_mmu_cache_range(NULL, vma, addr, ptep, nr)
>> +
>>   static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
>>           unsigned long address, pmd_t *pmdp)
>>   {
> 
> 
> You can add:
> 
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> Thanks,
> 
> Alex

