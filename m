Return-Path: <linux-kernel+bounces-287848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD99F952D27
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DBBD1C23A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D671AC89D;
	Thu, 15 Aug 2024 11:01:46 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C271AC890
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723719706; cv=none; b=kkTdSZgJFuOrqU5GCftO50DPVSPPRWSBbMzopEzQ/PxwC4kfRlwEpvHsCSVr3XHjV0NALYjeCSKXEVI8WVfBDRzv1cCp2+Eb0a1Vc7+DBvTXomaSHJ8G6dxEH9qh0Dt2e8FoMI28S9oxsDeMWY8Gz44yBIvrhuBrGgiUQgLgGJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723719706; c=relaxed/simple;
	bh=WMRMJAWuc0rrjp1JzmdhGRrglJU/0QI3o/yoKIrMi5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YplInKh6TBGltrKOL0nhxrwV2N+u/uKjGcyNcqJEoFz/22fwLJcepOkKSOBOJRB/KGN3fqwHCAgoGwSt8i/k6kmV0Q8gj4g0GkrT8sLco0BM3E5Js0+jH81Pw9Dfd9cg1BQnZ+b50IL5QnHnCyXYD7GejzfUAfUM4BVZORDoYNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 986191C0002;
	Thu, 15 Aug 2024 11:01:38 +0000 (UTC)
Message-ID: <afaa4192-da08-4180-a09b-2b953293ba76@ghiti.fr>
Date: Thu, 15 Aug 2024 13:01:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: add a warning when physical memory address
 overflows
Content-Language: en-US
To: Yunhui Cui <cuiyunhui@bytedance.com>, punit.agrawal@bytedance.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alexghiti@rivosinc.com, chenjiahao16@huawei.com, guoren@kernel.org,
 vishal.moola@gmail.com, stuart.menefy@codasip.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240814062625.19794-1-cuiyunhui@bytedance.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240814062625.19794-1-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Yunhui,

On 14/08/2024 08:26, Yunhui Cui wrote:
> The part of physical memory that exceeds the size of the linear mapping
> will be discarded. When the system starts up normally, a warning message
> will be printed to prevent confusion caused by the mismatch between the
> system memory and the actual physical memory.
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>   arch/riscv/mm/init.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 52290c9bd04bd..c93164dc51658 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -236,8 +236,12 @@ static void __init setup_bootmem(void)
>   	 */
>   	if (IS_ENABLED(CONFIG_64BIT)) {
>   		max_mapped_addr = __pa(PAGE_OFFSET) + KERN_VIRT_SIZE;
> -		memblock_cap_memory_range(phys_ram_base,
> -					  max_mapped_addr - phys_ram_base);
> +		if (memblock_end_of_DRAM() > max_mapped_addr) {
> +			memblock_cap_memory_range(phys_ram_base,
> +						  max_mapped_addr - phys_ram_base);
> +			pr_warn("Physical memory overflows the linear mapping size: region above 0x%llx removed",
> +				max_mapped_addr);
> +		}
>   	}
>   
>   


A bit weird to review and test my own patch, but here it is anyway :)

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


