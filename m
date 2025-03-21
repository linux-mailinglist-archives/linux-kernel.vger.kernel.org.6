Return-Path: <linux-kernel+bounces-570862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4595CA6B587
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D301893263
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117D91EDA35;
	Fri, 21 Mar 2025 07:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DdEAIF07"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B306726ACB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742543596; cv=none; b=mwgZFxULxKtuAlSSTXfzQyqlFR6/EfXJYvPlupZkZuhJiskVXu6vJvnHTFrGj6Uz2dKpHvrhLewUGGugvm5cK8NelRAE+shvlSxHuDo/O4PBk0WZF+5CfYc9AuI1xrlUqqQClDmcTaPg02PlLdShUJRYMa7ofenU3J6EbIp3Cxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742543596; c=relaxed/simple;
	bh=enCbel2iRJcTPHtXReynf9C3YSEj7sSO1j/UpMt0lY4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H3wjLueguL3Zz6rEvdMSihNR9W06wWQx8Oe9NL3VfD+wb998AbJ+hYv4feRu+MRvmxX9iqs4ko2vd/xy4jCZgSS0KGzNkPW/db/45gK4mDAdv9lPfoVifc2AaqlRqoW0+40X8HaMKKgwr/AdOaF/C9DM9nthQedXqIAOpvxjdyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DdEAIF07; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742543591;
	bh=enCbel2iRJcTPHtXReynf9C3YSEj7sSO1j/UpMt0lY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DdEAIF07vhWzK5D1yxlN38RFbvZGKx8GRut/0eJ9kr0Rz9aVfacdAa5g+sUHTEzDM
	 PKLkPp8xuBjOOdEnlZ0yIx0PpM2GtBU4JE/RI5vRvqAmObadnsr7RUf6g5fX8Z8MoT
	 3UUdBDi8zDUUjeH/OH929J+zOAFUo/1Wu9Bb+7Ax/2o0/s/lAh7yHpM7pQQ/C6UBl/
	 1TLbkJKfIiehn+hZxzRK9jG4BCFnzeIiW7u7DG+EqgwyIErfAlLI9pjokAsKyWTqd3
	 gq6PHjMXtcOQ5Lm3XItOaskFCDeP7jp55tBncrWGA/RnuICsrJi8INbt+hlefxGUKo
	 EQfY5DK2kCJAQ==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 447FA17E0C38;
	Fri, 21 Mar 2025 08:53:11 +0100 (CET)
Date: Fri, 21 Mar 2025 08:53:06 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/9] drm/panthor: Use 64-bit and poll register
 accessors
Message-ID: <20250321085306.0d79ec5d@collabora.com>
In-Reply-To: <20250320111741.1937892-3-karunika.choo@arm.com>
References: <20250320111741.1937892-1-karunika.choo@arm.com>
	<20250320111741.1937892-3-karunika.choo@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Mar 2025 11:17:34 +0000
Karunika Choo <karunika.choo@arm.com> wrote:

> This patch updates Panthor to use the new 64-bit accessors and poll
> functions.

nit: I don't think it makes sense to dissociate the introduction of the
new helpers and their use. Could we squash this patch into the previous
one?

> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_fw.c  |   9 +-
>  drivers/gpu/drm/panthor/panthor_gpu.c | 142 +++++++-------------------
>  drivers/gpu/drm/panthor/panthor_mmu.c |  34 ++----
>  3 files changed, 53 insertions(+), 132 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 0f52766a3120..ecfbe0456f89 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1059,8 +1059,8 @@ static void panthor_fw_stop(struct panthor_device *ptdev)
>  	u32 status;
>  
>  	gpu_write(ptdev, MCU_CONTROL, MCU_CONTROL_DISABLE);
> -	if (readl_poll_timeout(ptdev->iomem + MCU_STATUS, status,
> -			       status == MCU_STATUS_DISABLED, 10, 100000))
> +	if (gpu_read_poll_timeout(ptdev, MCU_STATUS, status,
> +				  status == MCU_STATUS_DISABLED, 10, 100000))
>  		drm_err(&ptdev->base, "Failed to stop MCU");
>  }
>  
> @@ -1085,8 +1085,9 @@ void panthor_fw_pre_reset(struct panthor_device *ptdev, bool on_hang)
>  
>  		panthor_fw_update_reqs(glb_iface, req, GLB_HALT, GLB_HALT);
>  		gpu_write(ptdev, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
> -		if (!readl_poll_timeout(ptdev->iomem + MCU_STATUS, status,
> -					status == MCU_STATUS_HALT, 10, 100000)) {
> +		if (!gpu_read_poll_timeout(ptdev, MCU_STATUS, status,
> +					   status == MCU_STATUS_HALT, 10,
> +					   100000)) {
>  			ptdev->reset.fast = true;
>  		} else {
>  			drm_warn(&ptdev->base, "Failed to cleanly suspend MCU");
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index 671049020afa..0dee011fe2e9 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -108,14 +108,9 @@ static void panthor_gpu_init_info(struct panthor_device *ptdev)
>  
>  	ptdev->gpu_info.as_present = gpu_read(ptdev, GPU_AS_PRESENT);
>  
> -	ptdev->gpu_info.shader_present = gpu_read(ptdev, GPU_SHADER_PRESENT_LO);
> -	ptdev->gpu_info.shader_present |= (u64)gpu_read(ptdev, GPU_SHADER_PRESENT_HI) << 32;
> -
> -	ptdev->gpu_info.tiler_present = gpu_read(ptdev, GPU_TILER_PRESENT_LO);
> -	ptdev->gpu_info.tiler_present |= (u64)gpu_read(ptdev, GPU_TILER_PRESENT_HI) << 32;
> -
> -	ptdev->gpu_info.l2_present = gpu_read(ptdev, GPU_L2_PRESENT_LO);
> -	ptdev->gpu_info.l2_present |= (u64)gpu_read(ptdev, GPU_L2_PRESENT_HI) << 32;
> +	ptdev->gpu_info.shader_present = gpu_read64(ptdev, GPU_SHADER_PRESENT_LO);
> +	ptdev->gpu_info.tiler_present = gpu_read64(ptdev, GPU_TILER_PRESENT_LO);
> +	ptdev->gpu_info.l2_present = gpu_read64(ptdev, GPU_L2_PRESENT_LO);
>  
>  	arch_major = GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id);
>  	product_major = GPU_PROD_MAJOR(ptdev->gpu_info.gpu_id);
> @@ -152,8 +147,7 @@ static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
>  {
>  	if (status & GPU_IRQ_FAULT) {
>  		u32 fault_status = gpu_read(ptdev, GPU_FAULT_STATUS);
> -		u64 address = ((u64)gpu_read(ptdev, GPU_FAULT_ADDR_HI) << 32) |
> -			      gpu_read(ptdev, GPU_FAULT_ADDR_LO);
> +		u64 address = gpu_read64(ptdev, GPU_FAULT_ADDR_LO);
>  
>  		drm_warn(&ptdev->base, "GPU Fault 0x%08x (%s) at 0x%016llx\n",
>  			 fault_status, panthor_exception_name(ptdev, fault_status & 0xFF),
> @@ -244,45 +238,27 @@ int panthor_gpu_block_power_off(struct panthor_device *ptdev,
>  				u32 pwroff_reg, u32 pwrtrans_reg,
>  				u64 mask, u32 timeout_us)
>  {
> -	u32 val, i;
> +	u32 val;
>  	int ret;
>  
> -	for (i = 0; i < 2; i++) {
> -		u32 mask32 = mask >> (i * 32);
> -
> -		if (!mask32)
> -			continue;
> -
> -		ret = readl_relaxed_poll_timeout(ptdev->iomem + pwrtrans_reg + (i * 4),
> -						 val, !(mask32 & val),
> -						 100, timeout_us);
> -		if (ret) {
> -			drm_err(&ptdev->base, "timeout waiting on %s:%llx power transition",
> -				blk_name, mask);
> -			return ret;
> -		}
> +	ret = gpu_read64_relaxed_poll_timeout(ptdev, pwrtrans_reg, val, !val,
> +					      100, timeout_us);
> +	if (ret) {
> +		drm_err(&ptdev->base,
> +			"timeout waiting on %s:%llx power transition", blk_name,
> +			mask);
> +		return ret;
>  	}
>  
> -	if (mask & GENMASK(31, 0))
> -		gpu_write(ptdev, pwroff_reg, mask);
> -
> -	if (mask >> 32)
> -		gpu_write(ptdev, pwroff_reg + 4, mask >> 32);
> -
> -	for (i = 0; i < 2; i++) {
> -		u32 mask32 = mask >> (i * 32);
> +	gpu_write64(ptdev, pwroff_reg, mask);
>  
> -		if (!mask32)
> -			continue;
> -
> -		ret = readl_relaxed_poll_timeout(ptdev->iomem + pwrtrans_reg + (i * 4),
> -						 val, !(mask32 & val),
> -						 100, timeout_us);
> -		if (ret) {
> -			drm_err(&ptdev->base, "timeout waiting on %s:%llx power transition",
> -				blk_name, mask);
> -			return ret;
> -		}
> +	ret = gpu_read64_relaxed_poll_timeout(ptdev, pwrtrans_reg, val, !val,
> +					      100, timeout_us);
> +	if (ret) {
> +		drm_err(&ptdev->base,
> +			"timeout waiting on %s:%llx power transition", blk_name,
> +			mask);
> +		return ret;
>  	}
>  
>  	return 0;
> @@ -305,45 +281,26 @@ int panthor_gpu_block_power_on(struct panthor_device *ptdev,
>  			       u32 pwron_reg, u32 pwrtrans_reg,
>  			       u32 rdy_reg, u64 mask, u32 timeout_us)
>  {
> -	u32 val, i;
> +	u32 val;
>  	int ret;
>  
> -	for (i = 0; i < 2; i++) {
> -		u32 mask32 = mask >> (i * 32);
> -
> -		if (!mask32)
> -			continue;
> -
> -		ret = readl_relaxed_poll_timeout(ptdev->iomem + pwrtrans_reg + (i * 4),
> -						 val, !(mask32 & val),
> -						 100, timeout_us);
> -		if (ret) {
> -			drm_err(&ptdev->base, "timeout waiting on %s:%llx power transition",
> -				blk_name, mask);
> -			return ret;
> -		}
> +	ret = gpu_read64_relaxed_poll_timeout(ptdev, pwrtrans_reg, val, !val,
> +					      100, timeout_us);
> +	if (ret) {
> +		drm_err(&ptdev->base,
> +			"timeout waiting on %s:%llx power transition", blk_name,
> +			mask);
> +		return ret;
>  	}
>  
> -	if (mask & GENMASK(31, 0))
> -		gpu_write(ptdev, pwron_reg, mask);
> -
> -	if (mask >> 32)
> -		gpu_write(ptdev, pwron_reg + 4, mask >> 32);
> -
> -	for (i = 0; i < 2; i++) {
> -		u32 mask32 = mask >> (i * 32);
> +	gpu_write64(ptdev, pwron_reg, mask);
>  
> -		if (!mask32)
> -			continue;
> -
> -		ret = readl_relaxed_poll_timeout(ptdev->iomem + rdy_reg + (i * 4),
> -						 val, (mask32 & val) == mask32,
> -						 100, timeout_us);
> -		if (ret) {
> -			drm_err(&ptdev->base, "timeout waiting on %s:%llx readiness",
> -				blk_name, mask);
> -			return ret;
> -		}
> +	ret = gpu_read64_relaxed_poll_timeout(ptdev, pwrtrans_reg, val, !val,
> +					      100, timeout_us);
> +	if (ret) {
> +		drm_err(&ptdev->base, "timeout waiting on %s:%llx readiness",
> +			blk_name, mask);
> +		return ret;
>  	}
>  
>  	return 0;
> @@ -492,26 +449,6 @@ void panthor_gpu_resume(struct panthor_device *ptdev)
>  	panthor_gpu_l2_power_on(ptdev);
>  }
>  
> -/**
> - * panthor_gpu_read_64bit_counter() - Read a 64-bit counter at a given offset.
> - * @ptdev: Device.
> - * @reg: The offset of the register to read.
> - *
> - * Return: The counter value.
> - */
> -static u64
> -panthor_gpu_read_64bit_counter(struct panthor_device *ptdev, u32 reg)
> -{
> -	u32 hi, lo;
> -
> -	do {
> -		hi = gpu_read(ptdev, reg + 0x4);
> -		lo = gpu_read(ptdev, reg);
> -	} while (hi != gpu_read(ptdev, reg + 0x4));
> -
> -	return ((u64)hi << 32) | lo;
> -}
> -
>  /**
>   * panthor_gpu_read_timestamp() - Read the timestamp register.
>   * @ptdev: Device.
> @@ -520,7 +457,7 @@ panthor_gpu_read_64bit_counter(struct panthor_device *ptdev, u32 reg)
>   */
>  u64 panthor_gpu_read_timestamp(struct panthor_device *ptdev)
>  {
> -	return panthor_gpu_read_64bit_counter(ptdev, GPU_TIMESTAMP_LO);
> +	return gpu_read64_sync(ptdev, GPU_TIMESTAMP_LO);
>  }
>  
>  /**
> @@ -531,10 +468,5 @@ u64 panthor_gpu_read_timestamp(struct panthor_device *ptdev)
>   */
>  u64 panthor_gpu_read_timestamp_offset(struct panthor_device *ptdev)
>  {
> -	u32 hi, lo;
> -
> -	hi = gpu_read(ptdev, GPU_TIMESTAMP_OFFSET_HI);
> -	lo = gpu_read(ptdev, GPU_TIMESTAMP_OFFSET_LO);
> -
> -	return ((u64)hi << 32) | lo;
> +	return gpu_read64(ptdev, GPU_TIMESTAMP_OFFSET_LO);
>  }
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 12a02e28f50f..a0a79f19bdea 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -510,9 +510,9 @@ static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
>  	/* Wait for the MMU status to indicate there is no active command, in
>  	 * case one is pending.
>  	 */
> -	ret = readl_relaxed_poll_timeout_atomic(ptdev->iomem + AS_STATUS(as_nr),
> -						val, !(val & AS_STATUS_AS_ACTIVE),
> -						10, 100000);
> +	ret = gpu_read_relaxed_poll_timeout_atomic(ptdev, AS_STATUS(as_nr), val,
> +						   !(val & AS_STATUS_AS_ACTIVE),
> +						   10, 100000);
>  
>  	if (ret) {
>  		panthor_device_schedule_reset(ptdev);
> @@ -564,8 +564,7 @@ static void lock_region(struct panthor_device *ptdev, u32 as_nr,
>  	region = region_width | region_start;
>  
>  	/* Lock the region that needs to be updated */
> -	gpu_write(ptdev, AS_LOCKADDR_LO(as_nr), lower_32_bits(region));
> -	gpu_write(ptdev, AS_LOCKADDR_HI(as_nr), upper_32_bits(region));
> +	gpu_write64(ptdev, AS_LOCKADDR_LO(as_nr), region);
>  	write_cmd(ptdev, as_nr, AS_COMMAND_LOCK);
>  }
>  
> @@ -615,14 +614,9 @@ static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
>  	if (ret)
>  		return ret;
>  
> -	gpu_write(ptdev, AS_TRANSTAB_LO(as_nr), lower_32_bits(transtab));
> -	gpu_write(ptdev, AS_TRANSTAB_HI(as_nr), upper_32_bits(transtab));
> -
> -	gpu_write(ptdev, AS_MEMATTR_LO(as_nr), lower_32_bits(memattr));
> -	gpu_write(ptdev, AS_MEMATTR_HI(as_nr), upper_32_bits(memattr));
> -
> -	gpu_write(ptdev, AS_TRANSCFG_LO(as_nr), lower_32_bits(transcfg));
> -	gpu_write(ptdev, AS_TRANSCFG_HI(as_nr), upper_32_bits(transcfg));
> +	gpu_write64(ptdev, AS_TRANSTAB_LO(as_nr), transtab);
> +	gpu_write64(ptdev, AS_MEMATTR_LO(as_nr), memattr);
> +	gpu_write64(ptdev, AS_TRANSCFG_LO(as_nr), transcfg);
>  
>  	return write_cmd(ptdev, as_nr, AS_COMMAND_UPDATE);
>  }
> @@ -635,14 +629,9 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr)
>  	if (ret)
>  		return ret;
>  
> -	gpu_write(ptdev, AS_TRANSTAB_LO(as_nr), 0);
> -	gpu_write(ptdev, AS_TRANSTAB_HI(as_nr), 0);
> -
> -	gpu_write(ptdev, AS_MEMATTR_LO(as_nr), 0);
> -	gpu_write(ptdev, AS_MEMATTR_HI(as_nr), 0);
> -
> -	gpu_write(ptdev, AS_TRANSCFG_LO(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
> -	gpu_write(ptdev, AS_TRANSCFG_HI(as_nr), 0);
> +	gpu_write64(ptdev, AS_TRANSTAB_LO(as_nr), 0);
> +	gpu_write64(ptdev, AS_MEMATTR_LO(as_nr), 0);
> +	gpu_write64(ptdev, AS_TRANSCFG_LO(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
>  
>  	return write_cmd(ptdev, as_nr, AS_COMMAND_UPDATE);
>  }
> @@ -1680,8 +1669,7 @@ static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
>  		u32 source_id;
>  
>  		fault_status = gpu_read(ptdev, AS_FAULTSTATUS(as));
> -		addr = gpu_read(ptdev, AS_FAULTADDRESS_LO(as));
> -		addr |= (u64)gpu_read(ptdev, AS_FAULTADDRESS_HI(as)) << 32;
> +		addr = gpu_read64(ptdev, AS_FAULTADDRESS_LO(as));
>  
>  		/* decode the fault status */
>  		exception_type = fault_status & 0xFF;


