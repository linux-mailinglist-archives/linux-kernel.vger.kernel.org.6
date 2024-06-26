Return-Path: <linux-kernel+bounces-230237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B8B917A35
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D436CB24DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4609E15DBB9;
	Wed, 26 Jun 2024 07:54:30 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626301FBB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719388469; cv=none; b=ikUSkxOjw+S9f2/Ng3BBKEMTqcKV2Yj+0LngByVZWN/vYh9J+XQYeiPRMCBi6MXDOeCm3k5/25/VIMsUQD5iDMJ+8qIRA/vxAStbIa5FF7rjcR22OwrltteaFscxgEbdQuJeHqWmE74Qhp6Zi9LpPg+5TtEPe6XMEYmNGjJUi3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719388469; c=relaxed/simple;
	bh=EFOBD7xfrRqM6vAsz5NH/d8ew5lyS91mRYOPvjRTcjY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=j4LIx0ekYoPXSSdRzgnxR5XelKc/i4ZHxs+AyQTd6klhh1glJ8j8zcFLD+XBqbgF7/D1bKKCE2CBH5HM6Od/nog2rllHw2Oc66WceFaX2tHdu1tDYsgioTqa8WiOTdkFJSbOgf5tY19LIBUPVs2+x7FiYTmoY9BHjpPVmOmrZuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W8DPm00DSzxTqM;
	Wed, 26 Jun 2024 15:50:03 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id A77FD14011D;
	Wed, 26 Jun 2024 15:54:23 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 26 Jun 2024 15:54:23 +0800
Subject: Re: [PATCH v4] ACPI: Add acpi=nospcr to disable ACPI SPCR as default
 console on ARM64
To: Liu Wei <liuwei09@cestc.cn>, <will@kernel.org>
CC: <catalin.marinas@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <prarit@redhat.com>, Andrew Lunn
	<andrew@lunn.ch>
References: <20240530015332.7305-1-liuwei09@cestc.cn>
 <20240625030504.58025-1-liuwei09@cestc.cn>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <f0313116-f36d-ed0b-cdfa-c5e31d4e8752@huawei.com>
Date: Wed, 26 Jun 2024 15:54:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240625030504.58025-1-liuwei09@cestc.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/6/25 11:05, Liu Wei wrote:
> For varying privacy and security reasons, sometimes we would like to
> completely silence the _serial_ console, and only enable it when needed.
> 
> But there are many existing systems that depend on this _serial_ console,
> so add acpi=nospcr to disable console in ACPI SPCR table as default
> _serial_ console.

I think this is reasonable, with ACPI SPCR on in default is compatible
with old systems.

> 
> Signed-off-by: Liu Wei <liuwei09@cestc.cn>
> Suggested-by: Prarit Bhargava <prarit@redhat.com>
> Suggested-by: Will Deacon <will@kernel.org>
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> ---
> 
> v2: Add a config option suggested by Prarit
> 
> v3: Use cmdline acpi=nospcr instead of config
> 
> v4: Some description in comment or document
> ---
>   .../admin-guide/kernel-parameters.txt          | 10 +++++++---
>   arch/arm64/kernel/acpi.c                       | 18 +++++++++++++++++-
>   2 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 11e57ba2985c..6814ff7ae446 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -12,7 +12,7 @@
>   	acpi=		[HW,ACPI,X86,ARM64,RISCV64,EARLY]
>   			Advanced Configuration and Power Interface
>   			Format: { force | on | off | strict | noirq | rsdt |
> -				  copy_dsdt }
> +				  copy_dsdt | nospcr }
>   			force -- enable ACPI if default was off
>   			on -- enable ACPI but allow fallback to DT [arm64,riscv64]
>   			off -- disable ACPI if default was on
> @@ -21,8 +21,12 @@
>   				strictly ACPI specification compliant.
>   			rsdt -- prefer RSDT over (default) XSDT
>   			copy_dsdt -- copy DSDT to memory
> -			For ARM64 and RISCV64, ONLY "acpi=off", "acpi=on" or
> -			"acpi=force" are available
> +			nospcr -- disable console in ACPI SPCR table as
> +				default _serial_ console on ARM64
> +			For ARM64, ONLY "acpi=off", "acpi=on", "acpi=force" or
> +			"acpi=nospcr" are available
> +			For RISCV64, ONLY "acpi=off", "acpi=on" or "acpi=force"
> +			are available
>   
>   			See also Documentation/power/runtime_pm.rst, pci=noacpi
>   
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index e0e7b93c16cc..55757d8884d4 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -45,6 +45,7 @@ EXPORT_SYMBOL(acpi_pci_disabled);
>   static bool param_acpi_off __initdata;
>   static bool param_acpi_on __initdata;
>   static bool param_acpi_force __initdata;
> +static bool param_acpi_nospcr __initdata;
>   
>   static int __init parse_acpi(char *arg)
>   {
> @@ -58,6 +59,8 @@ static int __init parse_acpi(char *arg)
>   		param_acpi_on = true;
>   	else if (strcmp(arg, "force") == 0) /* force ACPI to be enabled */
>   		param_acpi_force = true;
> +	else if (strcmp(arg, "nospcr") == 0) /* disable SPCR as default console */
> +		param_acpi_nospcr = true;
>   	else
>   		return -EINVAL;	/* Core will print when we return error */
>   
> @@ -237,7 +240,20 @@ void __init acpi_boot_table_init(void)
>   			acpi_put_table(facs);
>   		}
>   #endif
> -		acpi_parse_spcr(earlycon_acpi_spcr_enable, true);
> +
> +		/*
> +		 * For varying privacy and security reasons, sometimes need
> +		 * to completely silence the serial console output, and only
> +		 * enable it when needed.
> +		 * But there are many existing systems that depend on this
> +		 * behavior, use acpi=nospcr to disable console in ACPI SPCR

Nit: s/behavior/behaviour

> +		 * table as default serial console.
> +		 */
> +		acpi_parse_spcr(earlycon_acpi_spcr_enable,
> +			!param_acpi_nospcr);
> +		pr_info("Use ACPI SPCR as default console: %s\n",
> +				param_acpi_nospcr ? "No" : "Yes");
> +
>   		if (IS_ENABLED(CONFIG_ACPI_BGRT))
>   			acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
>   	}

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

