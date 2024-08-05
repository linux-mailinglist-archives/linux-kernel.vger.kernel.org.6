Return-Path: <linux-kernel+bounces-274148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9D99473F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 05:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593332814C0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 03:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E532313CFB7;
	Mon,  5 Aug 2024 03:40:57 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B24B63A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 03:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722829257; cv=none; b=pvilqJJQrcffRJnlkXQbD76bdf4t+UEjbF0m+5na8e78pxtlMroyU1gRHxxD9swlEjN7QbECzTGt7cATL9yy60sJvEo4+TYTAzpCYrhuzGklZYjDfBzUKP4pH9P8PD5xfpvQu4ha3UyvhWhBU+ZzfAwvUnRjz5o8nem18ou0FvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722829257; c=relaxed/simple;
	bh=VJS3fbcgNhNHcDR2COC7zwKWOdwFoEkld3ARBJcLmfM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eUWILtZ4rFLCkS40eAWnzp59357FFjCPZydkk7cj8xtPzsnQdLdh8aEtQj6PvHC/31QyVtMymvjZ5VVE/Hy6qxA1PJkmK5E+M13/BV1RRsiPzEKcQvL0hdsqYcLhh2ZY+FpSLC+0cBFUO58Sw8btql1fE6FIj3NVu3+v34vAlLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WchRk04Pgz1j6J4;
	Mon,  5 Aug 2024 11:16:34 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id CF17914037F;
	Mon,  5 Aug 2024 11:21:13 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 5 Aug 2024 11:21:13 +0800
Subject: Re: [PATCH v2 2/2] arm64: ACPI: NUMA: initialize all values of
 acpi_early_node_map to NUMA_NO_NODE
To: Haibo Xu <haibo1.xu@intel.com>, <ajones@ventanamicro.com>,
	<sunilvl@ventanamicro.com>
CC: <xiaobo55x@gmail.com>, Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, James Morse <james.morse@arm.com>, "Russell
 King (Oracle)" <rmk+kernel@armlinux.org.uk>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <0d362a8ae50558b95685da4c821b2ae9e8cf78be.1722828421.git.haibo1.xu@intel.com>
 <853d7f74aa243f6f5999e203246f0d1ae92d2b61.1722828421.git.haibo1.xu@intel.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <0cef3770-6196-9984-464a-f1dee1065449@huawei.com>
Date: Mon, 5 Aug 2024 11:21:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <853d7f74aa243f6f5999e203246f0d1ae92d2b61.1722828421.git.haibo1.xu@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/8/5 11:30, Haibo Xu wrote:
> Currently, only acpi_early_node_map[0] was initialized to NUMA_NO_NODE.
> To ensure all the values were properly initialized, switch to initialize
> all of them to NUMA_NO_NODE.
> 
> Fixes: e18962491696 ("arm64: numa: rework ACPI NUMA initialization")
> Reported-by: Andrew Jones <ajones@ventanamicro.com>
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>   arch/arm64/kernel/acpi_numa.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
> index 0c036a9a3c33..2465f291c7e1 100644
> --- a/arch/arm64/kernel/acpi_numa.c
> +++ b/arch/arm64/kernel/acpi_numa.c
> @@ -27,7 +27,7 @@
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

