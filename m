Return-Path: <linux-kernel+bounces-577418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8F5A71CC1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00C6816F435
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE471FAC4D;
	Wed, 26 Mar 2025 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tevs6xPA"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B1B1FA164;
	Wed, 26 Mar 2025 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009197; cv=none; b=dAJn+Hewe3XWa8VTRU5wrVCCWK24w37nhKL3DDBV/FOhBTHjup5iCwX6WvMU1ywS+0F7ufY34alQEg82ZpspDk6MLbkw5bNPw9F10VxqOj0KDMQm6Y/yPGhOmH/x0bPPAmPjj/L0swnNSEnz08RKxqi06TXF737BjNH50UKfOjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009197; c=relaxed/simple;
	bh=SJQZvtTgdJKskCStI02l1U/vGQD2WnA3AdgZFUp51ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uhmlea9ODLFbpA1zyDE9qnuwyErE++dtoxhOYqATNAEB93I9kkuOr0MAcAQqXgy0csbdIEm7mJ06MWvHz0Ud1UGysibrS3ZTVmY7vpvY9Ku/Z/MXFrre9NrAW2fq8Rg/NpKDN37M/7jP7CsY7tB+UFy3/mLoJinQ1Z5tsiek80o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tevs6xPA; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3913958ebf2so5755509f8f.3;
        Wed, 26 Mar 2025 10:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743009193; x=1743613993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GtJfHAqIrf0tmW6pGHYaGsbHQhJJ95x4qtQyEirDDbw=;
        b=Tevs6xPAuQaQLbDmjUEidaYHN8Na9hv/JoiPneQvkJwhIZoAgGF1dEGU5hy1zTMg6u
         7ixSDOuId0F/mnZ5oyaLjH21qWvoHzrKdD9WyeSiMXzB2+KSyOF95qlJuKpUdSMmnWZl
         8SKno3HLvxtoL8/tFL6gyYQ8iXXKQERXv0SlNE9P5h4TXZPe8DMLdY+Uq8p6xVnWzyFG
         21ANt9H73IJk2JBiP1t8KuvfUZBT81IT3LpLGRNEKcqm8UasGpRd8sBNaQ6n0G2Y7L0r
         FD4GE3n2R2zv52aY5LykSWtMzkKFO8bKxCuqlqeIelF9xqj49/3xTyGdUtbjopjhe5+H
         TAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743009193; x=1743613993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtJfHAqIrf0tmW6pGHYaGsbHQhJJ95x4qtQyEirDDbw=;
        b=OFbxHPoaF3/yxBanpZxuwjH7DFawQQ+LgbNy30TgIqN/uynelPi+UoqTSsF5dELfx9
         SInuV0PlAbDh3/dyNgFRX7s3QsJZoaCu6o4hMs9i/uHO714eLivrP683eu+JoXFXippE
         XRg0bKV4g/mgkAx97MWLuzF/UwsTkLghoEVWjYpVlnWZ84uQ+0PVohlo1TMvYap1Fg8V
         Wq+Es2rtFDkD6KylJ2obJXws69h1CdoJ2aGV2dz+wkIhHnnZQmyVqKMZ+Pujont3/Qh4
         5qdEQL0j2jOzNnpHN+8guD2dQkOVk8K6yCJQskk1UjzA/BlZ8WeHCEf/UejM9a+/laW4
         aICw==
X-Forwarded-Encrypted: i=1; AJvYcCU2WU7otQax4ty3NvLtqDznM5f9lTuN4ujupZj+jRPu4ksbguWIy7i59t96MEQA0Nr3ZYgc7v8DbnXUYoY=@vger.kernel.org, AJvYcCV7VzPjXQme7D1G81WE6ykP5hjGRScOW+NiThI6qwy4f/rSilu8xLMqtOJawMhijbjpfd1cHq/KW2sQ+h+Jp7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+4wv4WWd9sU+H9xEVyyo6wERgreNEyh0jEjHdo3h6gyVw+Efc
	gNQo/+U7lnndBrGFxpbvSNsVJfXxWOl0KWQusYEWKVdLZdTJFSBZ
X-Gm-Gg: ASbGnct10j2rqcsXC6X3ZWpZpR8b3CH95QH7SDPKBIvd0k02AaUTWV3M9xBiv67UwCX
	nv1SAXUn+T3rsTq7y4TsXa8iF3BvpuypjSeZxryHMBWz9kTFI1G6P7wd+d7hvE06MdtM6/Af4uD
	zcpfl29gzC90JLASRIyLZX+ibQvL+SxRqEFmDv+6/PLaLGch+1OjeiSxhP+emWYg1xtc45K69u+
	PFWcvIVt9CSUpI6m/m+fNtuOnoAeN9P0RlwO5wrLDGEtexIDG64cpap3FTce1HoXCWBHug++1N3
	5t5oY0NEne6Sh64jxKHpE4EbuI5+mfxL+yJH8LpgSS7/DIdAXT12kyZlHk1r8Ne+jWBMtlgtpZf
	sq3rBPmzp
X-Google-Smtp-Source: AGHT+IES84MAr3U6c2mA1k7oT3HKN/0OPo/aOG+Tpfb/MWjS1YI0LksmvIu1gdYyE3ccxKYBUEJKhA==
X-Received: by 2002:a05:6000:1f8f:b0:391:3207:2e75 with SMTP id ffacd0b85a97d-39ad1743b3emr212770f8f.18.1743009193211;
        Wed, 26 Mar 2025 10:13:13 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b5193sm17689828f8f.55.2025.03.26.10.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 10:13:12 -0700 (PDT)
Date: Wed, 26 Mar 2025 17:13:11 +0000
From: Stafford Horne <shorne@gmail.com>
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	sahilcdq@proton.me, linux-openrisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] openrisc: Add cacheinfo support
Message-ID: <Z-Q1p4eMUC4PZ8bB@antec>
References: <20250323195544.152948-1-sahilcdq@proton.me>
 <20250323195544.152948-4-sahilcdq@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323195544.152948-4-sahilcdq@proton.me>

On Mon, Mar 24, 2025 at 01:25:44AM +0530, Sahil Siddiq wrote:
> Add cacheinfo support for OpenRISC.
> 
> Currently, a few CPU cache attributes pertaining to OpenRISC processors
> are exposed along with other unrelated CPU attributes in the procfs file
> system (/proc/cpuinfo). However, a few cache attributes remain unexposed.
> 
> Provide a mechanism that the generic cacheinfo infrastructure can employ
> to expose these attributes via the sysfs file system. These attributes
> can then be exposed in /sys/devices/system/cpu/cpuX/cache/indexN. Move
> the implementation to pull cache attributes from the processor's
> registers from arch/openrisc/kernel/setup.c with a few modifications.
> 
> This implementation is based on similar work done for MIPS and LoongArch.
> 
> Link: https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.4-rev0.pdf
> 
> Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>

Other than the test robot's complaint about the unused variable this looks ok to
me.

-Stafford

> ---
> Changes from v2 -> v3:
> - arch/openrisc/kernel/cacheinfo.c:
>   1. Use new functions introduced in patch #2.
>   2. Address review comments regarding coding style.
> - arch/openrisc/kernel/setup.c:
>   (print_cpuinfo): Don't remove detection of UPR register.
> 
>  arch/openrisc/kernel/Makefile    |   2 +-
>  arch/openrisc/kernel/cacheinfo.c | 104 +++++++++++++++++++++++++++++++
>  arch/openrisc/kernel/setup.c     |  38 -----------
>  3 files changed, 105 insertions(+), 39 deletions(-)
>  create mode 100644 arch/openrisc/kernel/cacheinfo.c
> 
> diff --git a/arch/openrisc/kernel/Makefile b/arch/openrisc/kernel/Makefile
> index 79129161f3e0..e4c7d9bdd598 100644
> --- a/arch/openrisc/kernel/Makefile
> +++ b/arch/openrisc/kernel/Makefile
> @@ -7,7 +7,7 @@ extra-y	:= vmlinux.lds
>  
>  obj-y	:= head.o setup.o or32_ksyms.o process.o dma.o \
>  	   traps.o time.o irq.o entry.o ptrace.o signal.o \
> -	   sys_call_table.o unwinder.o
> +	   sys_call_table.o unwinder.o cacheinfo.o
>  
>  obj-$(CONFIG_SMP)		+= smp.o sync-timer.o
>  obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
> diff --git a/arch/openrisc/kernel/cacheinfo.c b/arch/openrisc/kernel/cacheinfo.c
> new file mode 100644
> index 000000000000..61230545e4ff
> --- /dev/null
> +++ b/arch/openrisc/kernel/cacheinfo.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * OpenRISC cacheinfo support
> + *
> + * Based on work done for MIPS and LoongArch. All original copyrights
> + * apply as per the original source declaration.
> + *
> + * OpenRISC implementation:
> + * Copyright (C) 2025 Sahil Siddiq <sahilcdq@proton.me>
> + */
> +
> +#include <linux/cacheinfo.h>
> +#include <asm/cpuinfo.h>
> +#include <asm/spr.h>
> +#include <asm/spr_defs.h>
> +
> +static inline void ci_leaf_init(struct cacheinfo *this_leaf, enum cache_type type,
> +				unsigned int level, struct cache_desc *cache, int cpu)
> +{
> +	this_leaf->type = type;
> +	this_leaf->level = level;
> +	this_leaf->coherency_line_size = cache->block_size;
> +	this_leaf->number_of_sets = cache->sets;
> +	this_leaf->ways_of_associativity = cache->ways;
> +	this_leaf->size = cache->size;
> +	cpumask_set_cpu(cpu, &this_leaf->shared_cpu_map);
> +}
> +
> +int init_cache_level(unsigned int cpu)
> +{
> +	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
> +	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> +	int leaves = 0, levels = 0;
> +	unsigned long upr = mfspr(SPR_UPR);
> +	unsigned long iccfgr, dccfgr;
> +
> +	if (!(upr & SPR_UPR_UP)) {
> +		printk(KERN_INFO
> +		       "-- no UPR register... unable to detect configuration\n");
> +		return -ENOENT;
> +	}
> +
> +	if (cpu_cache_is_present(SPR_UPR_DCP)) {
> +		dccfgr = mfspr(SPR_DCCFGR);
> +		cpuinfo->dcache.ways = 1 << (dccfgr & SPR_DCCFGR_NCW);
> +		cpuinfo->dcache.sets = 1 << ((dccfgr & SPR_DCCFGR_NCS) >> 3);
> +		cpuinfo->dcache.block_size = 16 << ((dccfgr & SPR_DCCFGR_CBS) >> 7);
> +		cpuinfo->dcache.size =
> +		    cpuinfo->dcache.sets * cpuinfo->dcache.ways * cpuinfo->dcache.block_size;
> +		leaves += 1;
> +		printk(KERN_INFO
> +		       "-- dcache: %d bytes total, %d bytes/line, %d set(s), %d way(s)\n",
> +		       cpuinfo->dcache.size, cpuinfo->dcache.block_size,
> +		       cpuinfo->dcache.sets, cpuinfo->dcache.ways);
> +	} else
> +		printk(KERN_INFO "-- dcache disabled\n");
> +
> +	if (cpu_cache_is_present(SPR_UPR_ICP)) {
> +		iccfgr = mfspr(SPR_ICCFGR);
> +		cpuinfo->icache.ways = 1 << (iccfgr & SPR_ICCFGR_NCW);
> +		cpuinfo->icache.sets = 1 << ((iccfgr & SPR_ICCFGR_NCS) >> 3);
> +		cpuinfo->icache.block_size = 16 << ((iccfgr & SPR_ICCFGR_CBS) >> 7);
> +		cpuinfo->icache.size =
> +		    cpuinfo->icache.sets * cpuinfo->icache.ways * cpuinfo->icache.block_size;
> +		leaves += 1;
> +		printk(KERN_INFO
> +		       "-- icache: %d bytes total, %d bytes/line, %d set(s), %d way(s)\n",
> +		       cpuinfo->icache.size, cpuinfo->icache.block_size,
> +		       cpuinfo->icache.sets, cpuinfo->icache.ways);
> +	} else
> +		printk(KERN_INFO "-- icache disabled\n");
> +
> +	if (!leaves)
> +		return -ENOENT;
> +
> +	levels = 1;
> +
> +	this_cpu_ci->num_leaves = leaves;
> +	this_cpu_ci->num_levels = levels;
> +
> +	return 0;
> +}
> +
> +int populate_cache_leaves(unsigned int cpu)
> +{
> +	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[smp_processor_id()];
> +	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> +	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
> +	int level = 1;
> +
> +	if (cpu_cache_is_present(SPR_UPR_DCP)) {
> +		ci_leaf_init(this_leaf, CACHE_TYPE_DATA, level, &cpuinfo->dcache, cpu);
> +		this_leaf->attributes = ((mfspr(SPR_DCCFGR) & SPR_DCCFGR_CWS) >> 8) ?
> +					CACHE_WRITE_BACK : CACHE_WRITE_THROUGH;
> +		this_leaf++;
> +	}
> +
> +	if (cpu_cache_is_present(SPR_UPR_ICP))
> +		ci_leaf_init(this_leaf, CACHE_TYPE_INST, level, &cpuinfo->icache, cpu);
> +
> +	this_cpu_ci->cpu_map_populated = true;
> +
> +	return 0;
> +}
> diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> index 66207cd7bb9e..caac492d045e 100644
> --- a/arch/openrisc/kernel/setup.c
> +++ b/arch/openrisc/kernel/setup.c
> @@ -113,21 +113,6 @@ static void print_cpuinfo(void)
>  		return;
>  	}
>  
> -	if (upr & SPR_UPR_DCP)
> -		printk(KERN_INFO
> -		       "-- dcache: %4d bytes total, %2d bytes/line, %d set(s), %d way(s)\n",
> -		       cpuinfo->dcache.size, cpuinfo->dcache.block_size,
> -		       cpuinfo->dcache.sets, cpuinfo->dcache.ways);
> -	else
> -		printk(KERN_INFO "-- dcache disabled\n");
> -	if (upr & SPR_UPR_ICP)
> -		printk(KERN_INFO
> -		       "-- icache: %4d bytes total, %2d bytes/line, %d set(s), %d way(s)\n",
> -		       cpuinfo->icache.size, cpuinfo->icache.block_size,
> -		       cpuinfo->icache.sets, cpuinfo->icache.ways);
> -	else
> -		printk(KERN_INFO "-- icache disabled\n");
> -
>  	if (upr & SPR_UPR_DMP)
>  		printk(KERN_INFO "-- dmmu: %4d entries, %lu way(s)\n",
>  		       1 << ((mfspr(SPR_DMMUCFGR) & SPR_DMMUCFGR_NTS) >> 2),
> @@ -155,7 +140,6 @@ static void print_cpuinfo(void)
>  void __init setup_cpuinfo(void)
>  {
>  	struct device_node *cpu;
> -	unsigned long iccfgr, dccfgr;
>  	int cpu_id = smp_processor_id();
>  	struct cpuinfo_or1k *cpuinfo = &cpuinfo_or1k[cpu_id];
>  
> @@ -163,20 +147,6 @@ void __init setup_cpuinfo(void)
>  	if (!cpu)
>  		panic("Couldn't find CPU%d in device tree...\n", cpu_id);
>  
> -	iccfgr = mfspr(SPR_ICCFGR);
> -	cpuinfo->icache.ways = 1 << (iccfgr & SPR_ICCFGR_NCW);
> -	cpuinfo->icache.sets = 1 << ((iccfgr & SPR_ICCFGR_NCS) >> 3);
> -	cpuinfo->icache.block_size = 16 << ((iccfgr & SPR_ICCFGR_CBS) >> 7);
> -	cpuinfo->icache.size =
> -	    cpuinfo->icache.sets * cpuinfo->icache.ways * cpuinfo->icache.block_size;
> -
> -	dccfgr = mfspr(SPR_DCCFGR);
> -	cpuinfo->dcache.ways = 1 << (dccfgr & SPR_DCCFGR_NCW);
> -	cpuinfo->dcache.sets = 1 << ((dccfgr & SPR_DCCFGR_NCS) >> 3);
> -	cpuinfo->dcache.block_size = 16 << ((dccfgr & SPR_DCCFGR_CBS) >> 7);
> -	cpuinfo->dcache.size =
> -	    cpuinfo->dcache.sets * cpuinfo->dcache.ways * cpuinfo->dcache.block_size;
> -
>  	if (of_property_read_u32(cpu, "clock-frequency",
>  				 &cpuinfo->clock_frequency)) {
>  		printk(KERN_WARNING
> @@ -319,14 +289,6 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  		seq_printf(m, "revision\t\t: %d\n", vr & SPR_VR_REV);
>  	}
>  	seq_printf(m, "frequency\t\t: %ld\n", loops_per_jiffy * HZ);
> -	seq_printf(m, "dcache size\t\t: %d bytes\n", cpuinfo->dcache.size);
> -	seq_printf(m, "dcache block size\t: %d bytes\n",
> -		   cpuinfo->dcache.block_size);
> -	seq_printf(m, "dcache ways\t\t: %d\n", cpuinfo->dcache.ways);
> -	seq_printf(m, "icache size\t\t: %d bytes\n", cpuinfo->icache.size);
> -	seq_printf(m, "icache block size\t: %d bytes\n",
> -		   cpuinfo->icache.block_size);
> -	seq_printf(m, "icache ways\t\t: %d\n", cpuinfo->icache.ways);
>  	seq_printf(m, "immu\t\t\t: %d entries, %lu ways\n",
>  		   1 << ((mfspr(SPR_DMMUCFGR) & SPR_DMMUCFGR_NTS) >> 2),
>  		   1 + (mfspr(SPR_DMMUCFGR) & SPR_DMMUCFGR_NTW));
> -- 
> 2.48.1
> 

