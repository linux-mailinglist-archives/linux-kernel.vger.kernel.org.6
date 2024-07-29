Return-Path: <linux-kernel+bounces-265143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0218593ED4B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E6C1F210E0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1025483A18;
	Mon, 29 Jul 2024 06:17:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE2E2F4A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722233833; cv=none; b=jnEACvQuxm6Qs1g7INv+MSASqKXe2qisRVvUwqOXMz7MUH+OFnN4juaQNW0fz3BF8Mv9iQ6qsILq3X1s3rcWrMiDpnh2JUvZMGWdyg2BdasNOa/qwJIgcLHZKWSvg2kNCPNJbW36k9FAib530JfRKw/r8pon9pA7fXimc0ubwxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722233833; c=relaxed/simple;
	bh=Zw3aUdYF+/zVVfq93wqPUpRyrYcB1UnfEZWiWCiNCeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VV6s2hAapDioFDdIEr8QcGIuqEp9l/0YQFh3QnuUGVZP577PtVJ7p3AwcNe86IIjbJSlEzeWJ4vvbIR1JeQOe/Lo5kdgTjYO7Q0sZfiRbitddVUT9jmrHOyKEGi99Z3YdEZL3LdFNbZfFpFCD4Xhcg7EOAmuXdPaFHPcSvAgV9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E994FEC;
	Sun, 28 Jul 2024 23:17:35 -0700 (PDT)
Received: from [10.162.41.10] (a077893.blr.arm.com [10.162.41.10])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2F7C3F64C;
	Sun, 28 Jul 2024 23:17:03 -0700 (PDT)
Message-ID: <34d81bcd-072b-4299-8791-f97a27872b55@arm.com>
Date: Mon, 29 Jul 2024 11:46:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: NUMA: initialize all values of acpi_early_node_map
 to NUMA_NO_NODE
To: Haibo Xu <haibo1.xu@intel.com>, sunilvl@ventanamicro.com
Cc: xiaobo55x@gmail.com, ajones@ventanamicro.com,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Gavin Shan
 <gshan@redhat.com>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 James Morse <james.morse@arm.com>, Hanjun Guo <guohanjun@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20240729035958.1957185-1-haibo1.xu@intel.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240729035958.1957185-1-haibo1.xu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/29/24 09:29, Haibo Xu wrote:
> Currently, only acpi_early_node_map[0] was initialized to NUMA_NO_NODE.
> To ensure all the values were properly initialized, switch to initialize
> all of them to NUMA_NO_NODE.
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com> (arm64 platform)

> ---
>  arch/arm64/kernel/acpi_numa.c | 2 +-
>  arch/riscv/kernel/acpi_numa.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
> index 0c036a9a3c33..2465f291c7e1 100644
> --- a/arch/arm64/kernel/acpi_numa.c
> +++ b/arch/arm64/kernel/acpi_numa.c
> @@ -27,7 +27,7 @@
>  
>  #include <asm/numa.h>
>  
> -static int acpi_early_node_map[NR_CPUS] __initdata = { NUMA_NO_NODE };
> +static int acpi_early_node_map[NR_CPUS] __initdata = { [0 ... NR_CPUS - 1] = NUMA_NO_NODE };
>  
>  int __init acpi_numa_get_nid(unsigned int cpu)
>  {
> diff --git a/arch/riscv/kernel/acpi_numa.c b/arch/riscv/kernel/acpi_numa.c
> index 0231482d6946..ff95aeebee3e 100644
> --- a/arch/riscv/kernel/acpi_numa.c
> +++ b/arch/riscv/kernel/acpi_numa.c
> @@ -28,7 +28,7 @@
>  
>  #include <asm/numa.h>
>  
> -static int acpi_early_node_map[NR_CPUS] __initdata = { NUMA_NO_NODE };
> +static int acpi_early_node_map[NR_CPUS] __initdata = { [0 ... NR_CPUS - 1] = NUMA_NO_NODE };
>  
>  int __init acpi_numa_get_nid(unsigned int cpu)
>  {

