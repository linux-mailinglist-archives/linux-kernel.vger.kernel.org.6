Return-Path: <linux-kernel+bounces-570911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57640A6B626
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1101119C41FB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159871EFFA3;
	Fri, 21 Mar 2025 08:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YcCuxvUe"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E7B1E5739
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742546478; cv=none; b=ka7K+TOjLRBYVlmbu+Bbk5mEF5D4dbu7Hp8ROD7gYNBS7yvHO6boQkenqdBRHeh+v/Waeg6zDFTNAoFrJaoa6M3/YmcVdQnhI/nGWByoZNb1ZcKpPpctuMG1tU15JMyUevEZ20sODJNNsroMetk6fzA7PsoFQK9kmLwocVIh42Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742546478; c=relaxed/simple;
	bh=jFD41Ga1a3ERHEQFFB9Ia0CbBpdK6p7SMSxtDffC8Jg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7/Fim65b7yJCuPLPCf4bfZEyYrwNZ9DmeORFPVTTx1mRB+wybQqeIGWNYjt8uX8L6D05kEs0ZOoWz/z5VifTUioUpx57Y0KI8GgufTcAmT0IURBIBIeHJvxz1vaI6bHf08ijPIE896j2HtYQ0J0WStR64BCo8cCB7kv0VMLp54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YcCuxvUe; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742546474;
	bh=jFD41Ga1a3ERHEQFFB9Ia0CbBpdK6p7SMSxtDffC8Jg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YcCuxvUeYG37e/WVjVxRefcNzuE7LGgDwuFD3wUfinmTYt9J7wwIWe2G7wZVSg9uk
	 hOnhtP1A5KE7UsrMd3sbvU0h4/sz1G8hTzkKe5TMhCPOsMO0RusSEM6ydCXSheTrI4
	 HUVFhuJQkYv2ieQrK4+W0jioGtLvao2Pp5yHxqaCbkZqFIa2N7nkJMnwcJDothjTsa
	 chpQNguAREeWsQsog5vntf15iK94niPYrv2Bmc3gyPaDn4aYTs6puRsUsIHJPSOapb
	 QPPwKPrM5c+jaZ9qfD2YxqxwdNNdkUMaw7uNRXY59Xu81AxzfGHKQ0kXTd6cSyCZTr
	 ybXRzop2xgu+g==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 34CF117E0147;
	Fri, 21 Mar 2025 09:41:14 +0100 (CET)
Date: Fri, 21 Mar 2025 09:41:09 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/9] drm/panthor: Support GPU_CONTROL cache flush
 based on feature bit
Message-ID: <20250321094109.116a6915@collabora.com>
In-Reply-To: <20250320111741.1937892-8-karunika.choo@arm.com>
References: <20250320111741.1937892-1-karunika.choo@arm.com>
	<20250320111741.1937892-8-karunika.choo@arm.com>
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

On Thu, 20 Mar 2025 11:17:39 +0000
Karunika Choo <karunika.choo@arm.com> wrote:

> As the FLUSH_MEM and FLUSH_PT commands are deprecated in GPUs from
> Mali-G720 onwards, this patch adds support for performing cache
> maintenance via the FLUSH_CACHES command in GPU_CONTROL, in place of
> FLUSH_MEM and FLUSH_PT based on PANTHOR_HW_FEATURE_GPU_CTRL_CACHE_FLUSH
> feature bit.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_hw.h  |  6 +++++
>  drivers/gpu/drm/panthor/panthor_mmu.c | 35 +++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
> index dfe0f86c5d76..4d67fdfe86f9 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.h
> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
> @@ -16,6 +16,12 @@ struct panthor_device;
>   * New feature flags will be added with support for newer GPU architectures.
>   */
>  enum panthor_hw_feature {
> +	/**
> +	 * @PANTHOR_HW_FEATURE_GPU_CTRL_CACHE_FLUSH: Perform cache maintenance
> +	 * via GPU_CONTROL.
> +	 */
> +	PANTHOR_HW_FEATURE_GPU_CTRL_CACHE_FLUSH,
> +
>  	/** @PANTHOR_HW_FEATURES_END: Must be last. */
>  	PANTHOR_HW_FEATURES_END
>  };
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index a0a79f19bdea..4ac8bf36177e 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -29,7 +29,9 @@
>  
>  #include "panthor_device.h"
>  #include "panthor_gem.h"
> +#include "panthor_gpu.h"
>  #include "panthor_heap.h"
> +#include "panthor_hw.h"
>  #include "panthor_mmu.h"
>  #include "panthor_regs.h"
>  #include "panthor_sched.h"
> @@ -568,6 +570,35 @@ static void lock_region(struct panthor_device *ptdev, u32 as_nr,
>  	write_cmd(ptdev, as_nr, AS_COMMAND_LOCK);
>  }
>  
> +static int mmu_hw_do_flush_on_gpu_ctrl(struct panthor_device *ptdev, int as_nr,
> +				       u32 op)
> +{
> +	const u32 l2_flush_op = CACHE_CLEAN | CACHE_INV;
> +	u32 lsc_flush_op = 0;
> +	int ret;
> +
> +	if (op == AS_COMMAND_FLUSH_MEM)
> +		lsc_flush_op = CACHE_CLEAN | CACHE_INV;
> +
> +	ret = wait_ready(ptdev, as_nr);
> +	if (ret)
> +		return ret;
> +
> +	ret = panthor_gpu_flush_caches(ptdev, l2_flush_op, lsc_flush_op, 0);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Explicitly unlock the region as the AS is not unlocked automatically
> +	 * at the end of the GPU_CONTROL cache flush command, unlike
> +	 * AS_COMMAND_FLUSH_MEM or AS_COMMAND_FLUSH_PT.
> +	 */
> +	write_cmd(ptdev, as_nr, AS_COMMAND_UNLOCK);
> +
> +	/* Wait for the unlock command to complete */
> +	return wait_ready(ptdev, as_nr);
> +}
> +
>  static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, int as_nr,
>  				      u64 iova, u64 size, u32 op)
>  {
> @@ -585,6 +616,10 @@ static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, int as_nr,
>  	if (op != AS_COMMAND_UNLOCK)
>  		lock_region(ptdev, as_nr, iova, size);
>  
> +	if (panthor_hw_supports(ptdev,PANTHOR_HW_FEATURE_GPU_CTRL_CACHE_FLUSH))
> +		if (op == AS_COMMAND_FLUSH_MEM || op == AS_COMMAND_FLUSH_PT)
> +			return mmu_hw_do_flush_on_gpu_ctrl(ptdev, as_nr, op);

Can't we use this sequence on v10 as well? The GPU flush_cache command
exists there, so I'd rather switch all CSF HW to this sequence than
diverge on v11+.

> +
>  	/* Run the MMU operation */
>  	write_cmd(ptdev, as_nr, op);
>  


