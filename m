Return-Path: <linux-kernel+bounces-274132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5C89473C8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 05:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258B61F21366
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 03:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF3413C9DE;
	Mon,  5 Aug 2024 03:20:27 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06A73BBF7
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 03:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722828027; cv=none; b=FbPzaEFJ0DMiFaOJLcN5GcKukOvIy4577FQ+nHWnFpsjNiqDrtU5Vq6NDgCRJpi1KC16usFMTy1M8pldqLsBlrqR2AK/sUzbQs0svC99XQs0WpOvmmOmwXmlWs6Yjvo/rC7uTH3SM5AF/wCRdJRh7k35WpjtOj8aonThcss36jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722828027; c=relaxed/simple;
	bh=utF80G3TQdp31/NWubfrBi58GIbVMPsAEeFy1sAfwUU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=X14FoMLwfHUZuFidcW2Th6FvuuiLnaI+sEeqyRZ3lPRPG2TnP0zMflaRYVvZFOlam/wicqoaheMtTnx0iI8aSlNviJj5vsczlrwF+JVu54I+d8o30nVwvquZ5RgbEXHYJbjp3FC9G7rc1AjCfDboYHO+PMtCELt2CIHSXJOcI0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WchTv2lFJzfZhN;
	Mon,  5 Aug 2024 11:18:27 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 24DD6180106;
	Mon,  5 Aug 2024 11:20:20 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 5 Aug 2024 11:20:19 +0800
Subject: Re: [PATCH v2 1/2] RISC-V: ACPI: NUMA: initialize all values of
 acpi_early_node_map to NUMA_NO_NODE
To: Haibo Xu <haibo1.xu@intel.com>, <ajones@ventanamicro.com>,
	<sunilvl@ventanamicro.com>
CC: <xiaobo55x@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Gavin Shan <gshan@redhat.com>, James Morse
	<james.morse@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <0d362a8ae50558b95685da4c821b2ae9e8cf78be.1722828421.git.haibo1.xu@intel.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <73d444ef-5367-da03-0e4a-e8116fdee604@huawei.com>
Date: Mon, 5 Aug 2024 11:20:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0d362a8ae50558b95685da4c821b2ae9e8cf78be.1722828421.git.haibo1.xu@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/8/5 11:30, Haibo Xu wrote:
> Currently, only acpi_early_node_map[0] was initialized to NUMA_NO_NODE.
> To ensure all the values were properly initialized, switch to initialize
> all of them to NUMA_NO_NODE.
> 
> Fixes: eabd9db64ea8 ("ACPI: RISCV: Add NUMA support based on SRAT and SLIT")
> Reported-by: Andrew Jones <ajones@ventanamicro.com>
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>   arch/riscv/kernel/acpi_numa.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/acpi_numa.c b/arch/riscv/kernel/acpi_numa.c
> index 0231482d6946..ff95aeebee3e 100644
> --- a/arch/riscv/kernel/acpi_numa.c
> +++ b/arch/riscv/kernel/acpi_numa.c
> @@ -28,7 +28,7 @@
>   
>   #include <asm/numa.h>
>   
> -static int acpi_early_node_map[NR_CPUS] __initdata = { NUMA_NO_NODE };
> +static int acpi_early_node_map[NR_CPUS] __initdata = { [0 ... NR_CPUS - 1] = NUMA_NO_NODE };
>   
>   int __init acpi_numa_get_nid(unsigned int cpu)
>   {

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

