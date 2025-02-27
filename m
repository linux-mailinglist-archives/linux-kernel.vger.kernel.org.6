Return-Path: <linux-kernel+bounces-535819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FCCA4779D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28BE0162649
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411B41E5721;
	Thu, 27 Feb 2025 08:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VrHzvZqp"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3740FA59
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644470; cv=none; b=Cac9I5zSyvO2FOEb5P/zhK/lD9my/x7ZcizCYJg8tUUjz9ySJGMHh7y0QaA67I1XdtX6UMxWhZP/qLHPksoNa4DmXkRJ0rsd2fiXngGLTDEs5UExGuSg8EfLgh5d4Zg3AVcyWZU5ARGWlm8DUsUAbkpGEATgnXkrjIEpFSUBqD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644470; c=relaxed/simple;
	bh=tKJ+yth8ev19KlGJZ3+pzqr1l9cZRFzf8DLc14xlgJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOdX/3k5lGPSXYz4rAStqszcAVr6cfAfDrKdFsi6ETF7dgGJM6DHqyR8RzYVMnOkNDtbarpGR3z49Ld4eDEbD/T/z9BJp62yD+cyP4gneIpqpLUZuft10UDqtuqH7ISz+GYW7O6toyuq+SqatPICcDIJbNWAEY8EE++bTlf5R84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VrHzvZqp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740644465;
	bh=tKJ+yth8ev19KlGJZ3+pzqr1l9cZRFzf8DLc14xlgJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VrHzvZqpiKxDs8wkCmp53jU7ntvOlrol9fnucm/GnSGSZwdJmccY8Ml+ltBwnKmSE
	 fiQx918TruV7AWqfiiODKtaten/2SVvmqnto8lBZkGLSqqdcBPbHTc/acuVu+mqj58
	 PqMvaWUSBkqusWqwlwiLYgTvRoT9n0/Rd2sm+YB865Xey7mP7AwBpmB29KeUIb2f/L
	 DU/OTmgJmnXt0RfxqA10y8g9Gq+4GmsSGOLi3tFvyJFfZIhphUI27j5R99eG+O39vQ
	 Y/ISAV38gxFCqKfFJj7wT7WembEaetVaHk8qrBgDN2D1PtUTm19alNuxNwh8t/PgZH
	 efJ9WSLlNlzPw==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BDAFE17E0605;
	Thu, 27 Feb 2025 09:21:04 +0100 (CET)
Date: Thu, 27 Feb 2025 09:21:00 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, steven.price@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Subject: Re: [RFC PATCH 1/4] drm/panfrost: Use
 GPU_MMU_FEATURES_VA_BITS/PA_BITS macros
Message-ID: <20250227092100.7e9dfca1@collabora.com>
In-Reply-To: <20250226183043.140773-2-ariel.dalessandro@collabora.com>
References: <20250226183043.140773-1-ariel.dalessandro@collabora.com>
	<20250226183043.140773-2-ariel.dalessandro@collabora.com>
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

On Wed, 26 Feb 2025 15:30:40 -0300
Ariel D'Alessandro <ariel.dalessandro@collabora.com> wrote:

> As done in panthor, define and use these GPU_MMU_FEATURES_* macros,
> which makes code easier to read and reuse.
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_mmu.c  | 6 ++++--
>  drivers/gpu/drm/panfrost/panfrost_regs.h | 2 ++
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> index b91019cd5acb..7df2c8d5b0ae 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -615,6 +615,8 @@ static void panfrost_drm_mm_color_adjust(const struct drm_mm_node *node,
>  
>  struct panfrost_mmu *panfrost_mmu_ctx_create(struct panfrost_device *pfdev)
>  {
> +	u32 va_bits = GPU_MMU_FEATURES_VA_BITS(pfdev->features.mmu_features);
> +	u32 pa_bits = GPU_MMU_FEATURES_PA_BITS(pfdev->features.mmu_features);
>  	struct panfrost_mmu *mmu;
>  
>  	mmu = kzalloc(sizeof(*mmu), GFP_KERNEL);
> @@ -633,8 +635,8 @@ struct panfrost_mmu *panfrost_mmu_ctx_create(struct panfrost_device *pfdev)
>  
>  	mmu->pgtbl_cfg = (struct io_pgtable_cfg) {
>  		.pgsize_bitmap	= SZ_4K | SZ_2M,
> -		.ias		= FIELD_GET(0xff, pfdev->features.mmu_features),
> -		.oas		= FIELD_GET(0xff00, pfdev->features.mmu_features),
> +		.ias		= va_bits,
> +		.oas		= pa_bits,
>  		.coherent_walk	= pfdev->coherent,
>  		.tlb		= &mmu_tlb_ops,
>  		.iommu_dev	= pfdev->dev,
> diff --git a/drivers/gpu/drm/panfrost/panfrost_regs.h b/drivers/gpu/drm/panfrost/panfrost_regs.h
> index c7bba476ab3f..b5f279a19a08 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_regs.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_regs.h
> @@ -16,6 +16,8 @@
>  #define   GROUPS_L2_COHERENT		BIT(0)	/* Cores groups are l2 coherent */
>  
>  #define GPU_MMU_FEATURES		0x014	/* (RO) MMU features */
> +#define  GPU_MMU_FEATURES_VA_BITS(x)	((x) & GENMASK(7, 0))
> +#define  GPU_MMU_FEATURES_PA_BITS(x)	(((x) >> 8) & GENMASK(7, 0))
>  #define GPU_AS_PRESENT			0x018	/* (RO) Address space slots present */
>  #define GPU_JS_PRESENT			0x01C	/* (RO) Job slots present */
>  


