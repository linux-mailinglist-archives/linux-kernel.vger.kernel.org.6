Return-Path: <linux-kernel+bounces-240483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A66AC926E34
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 05:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1B4D1C20EAF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F2F1BDCF;
	Thu,  4 Jul 2024 03:59:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CD41C68D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 03:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720065575; cv=none; b=t0SBp7o6WUGW3HuaojATFQKdVfb2jHzaWCTlclE/ff+phGOjVbVUpmbIwIWGFrC05qkOmYYzUDzPRUEKqL4TjWy2cyaRgc0JgeC8923UiYxnlrp8R3nTDb17SGo04X8nqZXFNZ1CpzCHR3nHXC199avxSH6L+uyjzfpuujcOu6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720065575; c=relaxed/simple;
	bh=X4/2mChvyGkngv6tn5uL3DV+DjND7WG9Adm9vsRVzYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=apdeA3fOgEp6g88YOQvys2PCoyq8DpwsJcONX1APoQufINa0A6niK7XoLL5y9pqvAg0TTtiySj2K7yFUxydaA2wE0p573l559+P4TGRn/HpcF4tA9iEfQcNqE6dErPh6NYNZRVfgRl2tYGCx6AxNoW/J7QNhp9y9JZoRsITDz64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB2E4367;
	Wed,  3 Jul 2024 20:59:56 -0700 (PDT)
Received: from [10.162.40.16] (a077893.blr.arm.com [10.162.40.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3B653F73B;
	Wed,  3 Jul 2024 20:59:29 -0700 (PDT)
Message-ID: <b09ab9be-2f7f-4a2c-9012-5d8d26bba93d@arm.com>
Date: Thu, 4 Jul 2024 09:29:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: tmc: sg: Do not leak sg_table
To: Suzuki K Poulose <suzuki.poulose@arm.com>, coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mike.leach@linaro.org, James Clark <james.clark@arm.com>
References: <20240702132846.1677261-1-suzuki.poulose@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240702132846.1677261-1-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/2/24 18:58, Suzuki K Poulose wrote:
> Running perf with cs_etm on Juno triggers the following kmemleak warning !
> 
> :~# cat /sys/kernel/debug/kmemleak
>  unreferenced object 0xffffff8806b6d720 (size 96):
>  comm "perf", pid 562, jiffies 4297810960
>  hex dump (first 32 bytes):
>  38 d8 13 07 88 ff ff ff 00 d0 9e 85 c0 ff ff ff  8...............
>  00 10 00 88 c0 ff ff ff 00 f0 ff f7 ff 00 00 00  ................
>  backtrace (crc 1dbf6e00):
>  [<ffffffc08107381c>] kmemleak_alloc+0xbc/0xd8
>  [<ffffffc0802f9798>] kmalloc_trace_noprof+0x220/0x2e8
>  [<ffffffc07bb71948>] tmc_alloc_sg_table+0x48/0x208 [coresight_tmc]
>  [<ffffffc07bb71cbc>] tmc_etr_alloc_sg_buf+0xac/0x240 [coresight_tmc]
>  [<ffffffc07bb72538>] tmc_alloc_etr_buf.constprop.0+0x1f0/0x260 [coresight_tmc]
>  [<ffffffc07bb7280c>] alloc_etr_buf.constprop.0.isra.0+0x74/0xa8 [coresight_tmc]
>  [<ffffffc07bb72950>] tmc_alloc_etr_buffer+0x110/0x260 [coresight_tmc]
>  [<ffffffc07bb38afc>] etm_setup_aux+0x204/0x3b0 [coresight]
>  [<ffffffc08025837c>] rb_alloc_aux+0x20c/0x318
>  [<ffffffc08024dd84>] perf_mmap+0x2e4/0x7a0
>  [<ffffffc0802cceb0>] mmap_region+0x3b0/0xa08
>  [<ffffffc0802cd8a8>] do_mmap+0x3a0/0x500
>  [<ffffffc080295328>] vm_mmap_pgoff+0x100/0x1d0
>  [<ffffffc0802cadf8>] ksys_mmap_pgoff+0xb8/0x110
>  [<ffffffc080020688>] __arm64_sys_mmap+0x38/0x58
>  [<ffffffc080028fc0>] invoke_syscall.constprop.0+0x58/0x100
> 
> This due to the fact that we do not free the "sg_table" itself while
> freeing up  the SG table and data pages. Fix this by freeing the sg_table
> in tmc_free_sg_table().
> 
> Fixes: 99443ea19e8b ("coresight: Add generic TMC sg table framework")
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: James Clark <james.clark@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index e75428fa1592..610ad51cda65 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -261,6 +261,7 @@ void tmc_free_sg_table(struct tmc_sg_table *sg_table)
>  {
>  	tmc_free_table_pages(sg_table);
>  	tmc_free_data_pages(sg_table);
> +	kfree(sg_table);
>  }
>  EXPORT_SYMBOL_GPL(tmc_free_sg_table);
>  
> @@ -342,7 +343,6 @@ struct tmc_sg_table *tmc_alloc_sg_table(struct device *dev,
>  		rc = tmc_alloc_table_pages(sg_table);
>  	if (rc) {
>  		tmc_free_sg_table(sg_table);
> -		kfree(sg_table);
>  		return ERR_PTR(rc);
>  	}
>  

