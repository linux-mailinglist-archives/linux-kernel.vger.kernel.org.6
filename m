Return-Path: <linux-kernel+bounces-365103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0E599DD89
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231811C21830
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 05:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6719176227;
	Tue, 15 Oct 2024 05:34:17 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3921684A1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728970457; cv=none; b=n/5QzMlHG2mu3O6lPC1asNd754fA79x5S+oBKBHmYc0pMWZNKzthNFemfrbL6I9i3mOYRwm//7yNa+4gLxChM5we0eXJgNDu8hb7BpJ2Mcc2x/07RaMw3UBhICeHUcntLqAw4eab8H24DZKW7F2cU4Atl1nJab1cM0YuzhiXCe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728970457; c=relaxed/simple;
	bh=FmlK0HMqmmvLXSbBJfw5vApljF4hO647iRg6Ztk0VHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fq3OFjAxR3+W8v5yO1LxY0N2opO9bgfZn4fR7NCcO9ks1NnJJNq4DPhs5F7U2RouEFwZfkG94ehELUw6qiNLXJp1xubr1XsVwUJ5z2XP7CT5VFuuNYDixLHKIqEQyoN9UIErn1YbwbZGLQ+OrjQkbKv72FGFFX9MCkAvd+kDk+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9F7D61C0002;
	Tue, 15 Oct 2024 05:34:08 +0000 (UTC)
Message-ID: <dbc33dea-6b6b-4b6b-88af-c6662004e909@ghiti.fr>
Date: Tue, 15 Oct 2024 07:34:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip/riscv-intc: Fix no-SMP boot with ACPI
Content-Language: en-US
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sunil V L <sunilvl@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Anup Patel <anup@brainfault.org>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20241014065739.656959-1-sunilvl@ventanamicro.com>
 <87cyk2zpgt.fsf@all.your.base.are.belong.to.us>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <87cyk2zpgt.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Sunil,

On 14/10/2024 17:14, Björn Töpel wrote:
> Thanks for fixing this, Sunil!
>
> Sunil V L <sunilvl@ventanamicro.com> writes:
>
>> When CONFIG_SMP is disabled, the static array rintc_acpi_data with size
>> NR_CPUS will not be sufficient to hold all RINTC structures passed from
>> the firmware. All RINTC structures are required to configure
>> IMSIC/APLIC/PLIC properly irrespective of SMP in the OS. So, allocate
>> dynamic memory based on the number of RINTC structures in MADT to fix
>> this issue.
> To clarify; QEMU is constructing an ACPI table for multiple harts
> (multiple RINTC), but the kernel build is NO_SMP.
>
>> Fixes: f8619b66bdb1 ("irqchip/riscv-intc: Add ACPI support for AIA")
>> Reported-by: Björn Töpel <bjorn@kernel.org>
>> Closes: https://github.com/linux-riscv/linux-riscv/actions/runs/11280997511/job/31375229012
>> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
>> ---
>>   drivers/irqchip/irq-riscv-intc.c | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
>> index 8c5411386220..f653c13de62b 100644
>> --- a/drivers/irqchip/irq-riscv-intc.c
>> +++ b/drivers/irqchip/irq-riscv-intc.c
>> @@ -265,7 +265,7 @@ struct rintc_data {
>>   };
>>   
>>   static u32 nr_rintc;
>> -static struct rintc_data *rintc_acpi_data[NR_CPUS];
>> +static struct rintc_data **rintc_acpi_data;
>>   
>>   #define for_each_matching_plic(_plic_id)				\
>>   	unsigned int _plic;						\
>> @@ -329,13 +329,30 @@ int acpi_rintc_get_imsic_mmio_info(u32 index, struct resource *res)
>>   	return 0;
>>   }
>>   
>> +static int __init riscv_intc_acpi_match(union acpi_subtable_headers *header,
>> +					const unsigned long end)
>> +{
>> +	return 0;
>> +}
>> +
>>   static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
>>   				       const unsigned long end)
>>   {
>>   	struct acpi_madt_rintc *rintc;
>>   	struct fwnode_handle *fn;
>> +	int count;
>>   	int rc;
>>   
>> +	if (!rintc_acpi_data) {
>> +		count = acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, riscv_intc_acpi_match, 0);
>> +		if (count <= 0)
>> +			return -EINVAL;
>> +
>> +		rintc_acpi_data = kcalloc(count, sizeof(*rintc_acpi_data), GFP_KERNEL);
>> +		if (!rintc_acpi_data)
>> +			return -ENOMEM;
>> +	}
>> +
>>   	rintc = (struct acpi_madt_rintc *)header;
>>   	rintc_acpi_data[nr_rintc] = kzalloc(sizeof(*rintc_acpi_data[0]), GFP_KERNEL);
>>   	if (!rintc_acpi_data[nr_rintc])
>> -- 
>> 2.43.0
> For context, this is the splat:
>
>    | Unable to handle kernel paging request at virtual address ff6000000000000c
>    | Oops [#1]
>    | Modules linked in:
>    | CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.12.0-rc2-g2255fe696ded #1
>    | epc : acpi_rintc_index_to_hartid+0x2c/0x3c
>    |  ra : imsic_get_parent_hartid+0x54/0xb6
>    | epc : ffffffff8046b788 ra : ffffffff80a1fe74 sp : ffffffff81403af0
>    |  gp : ffffffff815181b8 tp : ffffffff8140c780 t0 : ffffffff81403b58
>    |  t1 : 00000000000003ff t2 : 0000000000000004 s0 : ffffffff81403b90
>    |  s1 : ff60000080057060 a0 : 0000000000000008 a1 : 0000000000000000
>    |  a2 : 0000000000000000 a3 : ffffffff81403b58 a4 : ffffffff80e0dd80
>    |  a5 : ff60000000000004 a6 : 0000000000000001 a7 : 0000000000000400
>    |  s2 : ffffffff81403bb0 s3 : 0000000000000001 s4 : ff1bfffffea790e8
>    |  s5 : ffffffff81403da0 s6 : 0000000000000000 s7 : ffffffff8151c9e8
>    |  s8 : 0000000000000001 s9 : 0000000000000003 s10: 0000000000000000
>    |  s11: ffffffff81403da0 t3 : 0000000000000400 t4 : 0000000000000401
>    |  t5 : 0000000000000001 t6 : 0000000000000400
>    | status: 0000000200000100 badaddr: ff6000000000000c cause: 000000000000000d
>    | [<ffffffff8046b788>] acpi_rintc_index_to_hartid+0x2c/0x3c
>    | [<ffffffff80a20008>] imsic_setup_state+0xe8/0x83a
>    | [<ffffffff80a208f8>] imsic_early_acpi_init+0x50/0xd2
>    | [<ffffffff80a23536>] acpi_match_madt+0x2e/0x5a
>    | [<ffffffff80a1f5f4>] acpi_parse_entries_array+0x164/0x230
>    | [<ffffffff80a222ba>] acpi_table_parse_entries_array+0x86/0xc2
>    | [<ffffffff80a2234a>] acpi_table_parse_entries+0x54/0x7c
>    | [<ffffffff80a22410>] acpi_table_parse_madt+0x22/0x2a
>    | [<ffffffff80a2389c>] __acpi_probe_device_table+0x78/0xc8
>    | [<ffffffff80a1f98a>] irqchip_init+0x36/0x3e
>    | [<ffffffff80a03d2e>] init_IRQ+0x30/0x52
>    | [<ffffffff80a00c08>] start_kernel+0x4b4/0x800
>    | Code: d513 01d7 1797 010b 8793 2507 97aa 639c 60a2 6402 (6788) 0141
>    | ---[ end trace 0000000000000000 ]---
>
> (Alex just kicked a build w/ this patch)


The tests ran here 
https://github.com/linux-riscv/linux-riscv/actions/runs/11330279867/job/31507748208?pr=1587 
and there were no "nosmp" failures compared to without this patch, so 
you can add:

Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


>
>
> Björn
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

