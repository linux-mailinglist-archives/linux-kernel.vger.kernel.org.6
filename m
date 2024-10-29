Return-Path: <linux-kernel+bounces-386433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4939B436C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759E4283966
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D5F20125B;
	Tue, 29 Oct 2024 07:46:14 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C0F1DE3C5
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730187973; cv=none; b=I9EOAx3u6OnoCfNmro34nwSa9iY25//w52d8tMjfziac/0QG9X7EoN6vxOcnkunAEDXGmmDkcw7VL3/5Vc1FeY+5ABMNwp8CHpifsibhLuY3IElEd3xzRd/eA1uNpSvYpZZPO21HCukDUL3Pa6m7XfovOerQovQux65LbmNV7RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730187973; c=relaxed/simple;
	bh=5IaN32Dd+S05zfzSJUz0ZFGcZpfQkf//oi84lT8aoBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4qir+Nu5Gl5NWyAQyfcZmHCKGHq/urTq3K/DalV5EqgGVcMowMhSiwuRwUfvGlfO7lkVhoRxUGcW4ot2OZLMYHxmuJQOuP6pbB8r/mlaZhMJx2LOAhg/eKQxj5HkixOyi4p/VW1QXokIa/O892utTus+CS6UsOYvGoOEzzGIqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0370AE0003;
	Tue, 29 Oct 2024 07:46:06 +0000 (UTC)
Message-ID: <cbe0831e-706c-465f-b412-fccf26163e9b@ghiti.fr>
Date: Tue, 29 Oct 2024 08:46:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip/riscv-intc: Fix no-SMP boot with ACPI
Content-Language: en-US
To: Sunil V L <sunilvl@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20241014065739.656959-1-sunilvl@ventanamicro.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20241014065739.656959-1-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Thomas,

On 14/10/2024 08:57, Sunil V L wrote:
> When CONFIG_SMP is disabled, the static array rintc_acpi_data with size
> NR_CPUS will not be sufficient to hold all RINTC structures passed from
> the firmware. All RINTC structures are required to configure
> IMSIC/APLIC/PLIC properly irrespective of SMP in the OS. So, allocate
> dynamic memory based on the number of RINTC structures in MADT to fix
> this issue.
>
> Fixes: f8619b66bdb1 ("irqchip/riscv-intc: Add ACPI support for AIA")
> Reported-by: Björn Töpel <bjorn@kernel.org>
> Closes: https://github.com/linux-riscv/linux-riscv/actions/runs/11280997511/job/31375229012
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>   drivers/irqchip/irq-riscv-intc.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
> index 8c5411386220..f653c13de62b 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -265,7 +265,7 @@ struct rintc_data {
>   };
>   
>   static u32 nr_rintc;
> -static struct rintc_data *rintc_acpi_data[NR_CPUS];
> +static struct rintc_data **rintc_acpi_data;
>   
>   #define for_each_matching_plic(_plic_id)				\
>   	unsigned int _plic;						\
> @@ -329,13 +329,30 @@ int acpi_rintc_get_imsic_mmio_info(u32 index, struct resource *res)
>   	return 0;
>   }
>   
> +static int __init riscv_intc_acpi_match(union acpi_subtable_headers *header,
> +					const unsigned long end)
> +{
> +	return 0;
> +}
> +
>   static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
>   				       const unsigned long end)
>   {
>   	struct acpi_madt_rintc *rintc;
>   	struct fwnode_handle *fn;
> +	int count;
>   	int rc;
>   
> +	if (!rintc_acpi_data) {
> +		count = acpi_table_parse_madt(ACPI_MADT_TYPE_RINTC, riscv_intc_acpi_match, 0);
> +		if (count <= 0)
> +			return -EINVAL;
> +
> +		rintc_acpi_data = kcalloc(count, sizeof(*rintc_acpi_data), GFP_KERNEL);
> +		if (!rintc_acpi_data)
> +			return -ENOMEM;
> +	}
> +
>   	rintc = (struct acpi_madt_rintc *)header;
>   	rintc_acpi_data[nr_rintc] = kzalloc(sizeof(*rintc_acpi_data[0]), GFP_KERNEL);
>   	if (!rintc_acpi_data[nr_rintc])


Do you think you can merge this patch for rc6? We still need it to fix 
our nosmp builds.

Thanks,

Alex


