Return-Path: <linux-kernel+bounces-224979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D2A912982
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FED92824F0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865E26FE16;
	Fri, 21 Jun 2024 15:23:53 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D208847A66
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718983433; cv=none; b=C18ZrPvKz7UNfFWmdV+CZLh2Euzql6NFF/sAiysFfRC68mM3qhsAcl30LmOhnNiosecd1QsUEfiLUAKon+mK47865u/rZ9djoG0fYv5hmHQws1Ajpce66ZP2mGG1cnYlq5tyvqnXDJXYuK3DcWyBu4PoQ0Qij5psvwlXEsh0Yf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718983433; c=relaxed/simple;
	bh=GbxrimKpnCu8pEGr/Ptk8gaTnt5JFxC58RLlMvrs9bQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4GRwfOYehzEQ0KThtfnzcw7Hu4lIpP3E87tMV37EK+8ZUu15+dbzpuJquLzv5ulMflPXTCCeWDWWTrFtdnHTJQFr2apb64LG5kf2qKw1dkOBWczfneHGaA7ELVqXwJQxfXM6qkp1P2B3b4fia4p+G5pz1IlkngOfCb1SMlRHaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 770D660008;
	Fri, 21 Jun 2024 15:23:39 +0000 (UTC)
Message-ID: <caaeb1d1-12c5-4d07-b299-34734f0099ab@ghiti.fr>
Date: Fri, 21 Jun 2024 17:23:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] riscv: mm: Add support for Svinval extension
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Samuel Holland <samuel.holland@sifive.com>
References: <20240609112103.285190-1-mchitale@ventanamicro.com>
 <20240609112103.285190-2-mchitale@ventanamicro.com>
 <20240621-469a3d5eb7bb2c0cc8ae0611@orel>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240621-469a3d5eb7bb2c0cc8ae0611@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Mayuresh, Andrew,

On 21/06/2024 11:15, Andrew Jones wrote:
> On Sun, Jun 09, 2024 at 04:51:03PM GMT, Mayuresh Chitale wrote:
>> The Svinval extension splits SFENCE.VMA instruction into finer-grained
>> invalidation and ordering operations and is mandatory for RVA23S64 profile.
>> When Svinval is enabled the local_flush_tlb_range_threshold_asid function
>> should use the following sequence to optimize the tlb flushes instead of
>> a simple sfence.vma:
>>
>> sfence.w.inval
>> svinval.vma
>>    .
>>    .
>> svinval.vma
>> sfence.inval.ir
>>
>> The maximum number of consecutive svinval.vma instructions that
>> can be executed in local_flush_tlb_range_threshold_asid function
>> is limited to 64. This is required to avoid soft lockups and the
>> approach is similar to that used in arm64.
>>
>> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
>> ---
>>   arch/riscv/mm/tlbflush.c | 58 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>
>> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
>> index 9b6e86ce3867..49d7978ac8d3 100644
>> --- a/arch/riscv/mm/tlbflush.c
>> +++ b/arch/riscv/mm/tlbflush.c
>> @@ -6,6 +6,54 @@
>>   #include <linux/hugetlb.h>
>>   #include <asm/sbi.h>
>>   #include <asm/mmu_context.h>
>> +#include <asm/cpufeature.h>
>> +
>> +#define has_svinval()	riscv_has_extension_unlikely(RISCV_ISA_EXT_SVINVAL)
>> +
>> +static inline void local_sfence_inval_ir(void)
>> +{
>> +	/*
>> +	 * SFENCE.INVAL.IR
>> +	 * 0001100 00001 00000 000 00000 1110011
>> +	 */
>> +	__asm__ __volatile__ (".word 0x18100073" ::: "memory");
>> +}
>> +
>> +static inline void local_sfence_w_inval(void)
>> +{
>> +	/*
>> +	 * SFENCE.W.INVAL
>> +	 * 0001100 00000 00000 000 00000 1110011
>> +	 */
>> +	__asm__ __volatile__ (".word 0x18000073" ::: "memory");
>> +}
>> +
>> +static inline void local_sinval_vma_asid(unsigned long vma, unsigned long asid)
> Please name this to
>
>    void local_sinval_vma(unsigned long vaddr, unsigned long asid)
>
> to match the spec's naming. But, if we want the arguments in the name,
> then it should be something like
>
>    void local_sinval_vma_addr_asid(unsigned long vaddr, unsigned long asid)
>
> but I think that's unnecessary.
>
>> +{
>> +	if (asid != FLUSH_TLB_NO_ASID) {
>> +		/*
>> +		 * rs1 = a0 (VMA)
>> +		 * rs2 = a1 (asid)
>> +		 * SINVAL.VMA a0, a1
>> +		 * 0001011 01011 01010 000 00000 1110011
>> +		 */
>> +		__asm__ __volatile__ ("add a0, %0, zero\n"
>> +					"add a1, %1, zero\n"
>> +					".word 0x16B50073\n"
>> +					:: "r" (vma), "r" (asid)
>> +					: "a0", "a1", "memory");
>> +	} else {
>> +		/*
>> +		 * rs1 = a0 (VMA)
>> +		 * rs2 = 0
>> +		 * SINVAL.VMA a0
>> +		 * 0001011 00000 01010 000 00000 1110011
>> +		 */
>> +		__asm__ __volatile__ ("add a0, %0, zero\n"
>> +					".word 0x16050073\n"
>> +					:: "r" (vma) : "a0", "memory");
>> +	}
> Please create an SINVAL_VMA instruction in insn-def.h to allow the
> compiler to choose which registers will be used for asid and vaddr. And,
> since SINVAL_VMA will be in insn-def.h, then we might as well add
> SFENCE_INVAL_IR and SFENCE_W_INVAL there too for consistency, even though
> they don't have operands. We should still create the three static inline
> wrapper functions here though.
>
>> +}
>>   
>>   /*
>>    * Flush entire TLB if number of entries to be flushed is greater
>> @@ -26,6 +74,16 @@ static void local_flush_tlb_range_threshold_asid(unsigned long start,
>>   		return;
>>   	}
>>   
>> +	if (has_svinval()) {
>> +		local_sfence_w_inval();
>> +		for (i = 0; i < nr_ptes_in_range; ++i) {
> Where do we limit this to 64 as the commit message states it does?


If the number of ptes to flush is greater than tlb_flush_all_threshold 
(= 64), we don't get there so this is indeed limited to 64 entries max.

I think this limit should be different when using svinval, but we can do 
that later and the goal is to allow the vendors to come with their own 
threshold anyway.

Thanks for reviving this Mayuresh, I'll add my RB in the next version 
when you fix Andrew's comments.

Alex


>
>> +			local_sinval_vma_asid(start, asid);
>> +			start += stride;
>> +		}
>> +		local_sfence_inval_ir();
>> +		return;
>> +	}
>> +
>>   	for (i = 0; i < nr_ptes_in_range; ++i) {
>>   		local_flush_tlb_page_asid(start, asid);
>>   		start += stride;
>> -- 
>> 2.34.1
>>
> Thanks,
> drew
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

