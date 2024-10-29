Return-Path: <linux-kernel+bounces-386443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F159B438E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94F51C21FB8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB79202F6E;
	Tue, 29 Oct 2024 07:53:05 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED622036EF
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 07:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730188384; cv=none; b=BSgtues/S/jV7DjOKsySdjiD8qHtNS8M49uxDbQ9NFTtT+ISlSpgsPLtf7Q/3FJcnHEzYntO4UmLWjbBvFtNc4VkRVX4bLfxM8kZxjyaWQolq2OnN65mGXSdeKyoAENMFL/h+6XjbC9X1hsX7TNO07XbYYhMS8Z/h30U319TLSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730188384; c=relaxed/simple;
	bh=BzF6Xg9hzfUjcrlQnCe8ytWzR0FDsoAuMbU5HXDvLUk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=j3uj03y/VrCddYOJcOz4+VPWp2p8czu/eD95BDcWcVhKnOW41+568NlVQLYG3CL2B5r5jzArI72bReOd1Itk0AP9cOsyn5a0irasg9a60LXGW9TMr3AS3Z8OjPfrDOhQh8K+foJdKobCTg4kpyt1tmDIXN0MUz9wCM8un4rdv5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id A3F041C0006;
	Tue, 29 Oct 2024 07:52:57 +0000 (UTC)
Message-ID: <9aa8c627-ad69-43e9-9331-40a5df53de7f@ghiti.fr>
Date: Tue, 29 Oct 2024 08:52:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip/riscv-intc: Fix no-SMP boot with ACPI
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
To: Sunil V L <sunilvl@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20241014065739.656959-1-sunilvl@ventanamicro.com>
 <cbe0831e-706c-465f-b412-fccf26163e9b@ghiti.fr>
In-Reply-To: <cbe0831e-706c-465f-b412-fccf26163e9b@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

On 29/10/2024 08:46, Alexandre Ghiti wrote:
> Hi Thomas,
>
> On 14/10/2024 08:57, Sunil V L wrote:
>> When CONFIG_SMP is disabled, the static array rintc_acpi_data with size
>> NR_CPUS will not be sufficient to hold all RINTC structures passed from
>> the firmware. All RINTC structures are required to configure
>> IMSIC/APLIC/PLIC properly irrespective of SMP in the OS. So, allocate
>> dynamic memory based on the number of RINTC structures in MADT to fix
>> this issue.
>>
>> Fixes: f8619b66bdb1 ("irqchip/riscv-intc: Add ACPI support for AIA")
>> Reported-by: Björn Töpel <bjorn@kernel.org>
>> Closes: 
>> https://github.com/linux-riscv/linux-riscv/actions/runs/11280997511/job/31375229012
>> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
>> ---
>>   drivers/irqchip/irq-riscv-intc.c | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-riscv-intc.c 
>> b/drivers/irqchip/irq-riscv-intc.c
>> index 8c5411386220..f653c13de62b 100644
>> --- a/drivers/irqchip/irq-riscv-intc.c
>> +++ b/drivers/irqchip/irq-riscv-intc.c
>> @@ -265,7 +265,7 @@ struct rintc_data {
>>   };
>>     static u32 nr_rintc;
>> -static struct rintc_data *rintc_acpi_data[NR_CPUS];
>> +static struct rintc_data **rintc_acpi_data;
>>     #define for_each_matching_plic(_plic_id)                \
>>       unsigned int _plic;                        \
>> @@ -329,13 +329,30 @@ int acpi_rintc_get_imsic_mmio_info(u32 index, 
>> struct resource *res)
>>       return 0;
>>   }
>>   +static int __init riscv_intc_acpi_match(union 
>> acpi_subtable_headers *header,
>> +                    const unsigned long end)
>> +{
>> +    return 0;
>> +}
>> +
>>   static int __init riscv_intc_acpi_init(union acpi_subtable_headers 
>> *header,
>>                          const unsigned long end)
>>   {
>>       struct acpi_madt_rintc *rintc;
>>       struct fwnode_handle *fn;
>> +    int count;
>>       int rc;
>>   +    if (!rintc_acpi_data) {
>> +        count = acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, 
>> riscv_intc_acpi_match, 0);
>> +        if (count <= 0)
>> +            return -EINVAL;
>> +
>> +        rintc_acpi_data = kcalloc(count, sizeof(*rintc_acpi_data), 
>> GFP_KERNEL);
>> +        if (!rintc_acpi_data)
>> +            return -ENOMEM;
>> +    }
>> +
>>       rintc = (struct acpi_madt_rintc *)header;
>>       rintc_acpi_data[nr_rintc] = 
>> kzalloc(sizeof(*rintc_acpi_data[0]), GFP_KERNEL);
>>       if (!rintc_acpi_data[nr_rintc])
>
>
> Do you think you can merge this patch for rc6? We still need it to fix 
> our nosmp builds.


Please ignore this message, I found it with a different title.

Thanks,

Alex


>
> Thanks,
>
> Alex
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

