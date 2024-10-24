Return-Path: <linux-kernel+bounces-380234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 836109AEABC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49E51C22101
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A8D1F12EA;
	Thu, 24 Oct 2024 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZO+qScLF"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA59C1EB9E9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784386; cv=none; b=QWJjAc8roYoYXdEuX6e4QwLTKHlbD6znn1qNgVqQYSLztDKS2oeKlZ76jmEGdhftrHGgTtpce+mChyBSONuCR+v1GNFgnF2+3PUMTm3TUdxasfEkpCLqgYWldGZYE9tKVEu80f1EvR7uQ/Ygth5o0U7s9wGAwFCAon6K6XCndXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784386; c=relaxed/simple;
	bh=rrJb1NqK5b8PbDzY+nU1vuLdPpt7Qi2yFThhEd+tOJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uh1zk8+EKJvTQPCP1HaRA9WYxlc2YfOKKfoqv2Griup2frxaWl+kHOSzHSRyuF30oWSldOdBEhdtVk867q3lE6o11j4f/uuNS+csRgH3zUXNMUnWoYuANorjceKfZlaSzQDHktl6FCYfXzaMZ6/B2u2Oc0mrcjtM4E3jP+MKrfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZO+qScLF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729784381;
	bh=rrJb1NqK5b8PbDzY+nU1vuLdPpt7Qi2yFThhEd+tOJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZO+qScLFjcOazkdNCqnmMUfPryTZa2hazbnX1qTg0qCLFKagn7CwchGBrrE2Syxi0
	 BwQig7yMZ62cV+g/+XCBbWkXtdeEJJH3p+FnHEEvhgmQdKMPMdB6RlNes+fOlV2iC9
	 FNdrFI5Z5N2DHdrVgSJyKsiwlDqQWHQ7vLoB74u8eeYPJbRvVG6zTmghnqZ3eLYKy3
	 Aw4jlT7/P65fdICh0daRi86vMvl3tUpkmUyiLDOGBXuhuWChaARs82Y3LTMfwrAaIf
	 si2LYiNSmKydVyvEyJk5FQY4xDwvfDpETambbYiq8DgmmILhvLVCoRXLtXqj8tKoqb
	 D44A44PbENKGA==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 620C717E3662;
	Thu, 24 Oct 2024 17:39:41 +0200 (CEST)
Date: Thu, 24 Oct 2024 17:39:35 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Akash Goel <akash.goel@arm.com>
Cc: liviu.dudau@arm.com, steven.price@arm.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mihail.atanassov@arm.com, ketil.johnsen@arm.com, florent.tomasin@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
Subject: Re: [PATCH 3/3] drm/panthor: Prevent potential overwrite of buffer
 objects
Message-ID: <20241024173935.6430159e@collabora.com>
In-Reply-To: <20241024145432.934086-4-akash.goel@arm.com>
References: <20241024145432.934086-1-akash.goel@arm.com>
	<20241024145432.934086-4-akash.goel@arm.com>
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

On Thu, 24 Oct 2024 15:54:32 +0100
Akash Goel <akash.goel@arm.com> wrote:

> All CPU mappings are forced as uncached for Panthor buffer objects when
> system(IO) coherency is disabled. Physical backing for Panthor BOs is
> allocated by shmem, which clears the pages also after allocation. But
> there is no explicit cache flush done after the clearing of pages.
> So it could happen that there are dirty cachelines in the CPU cache
> for the BOs, when they are accessed from the CPU side through uncached
> CPU mapping, and the eviction of cachelines overwrites the data of BOs.

Hm, this looks like something that should be handled at the
drm_gem_shmem level when drm_gem_shmem_object::map_wc=true, as I
suspect other drivers can hit the same issue (I'm thinking of panfrost
and lima, but there might be others).

> 
> This commit tries to avoid the potential overwrite scenario.
> 
> Signed-off-by: Akash Goel <akash.goel@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_gem.h | 10 ++++++++++
>  drivers/gpu/drm/panthor/panthor_mmu.c |  5 +++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/panthor/panthor_gem.h
> index e43021cf6d45..4b0f43f1edf1 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.h
> +++ b/drivers/gpu/drm/panthor/panthor_gem.h
> @@ -46,6 +46,16 @@ struct panthor_gem_object {
>  
>  	/** @flags: Combination of drm_panthor_bo_flags flags. */
>  	u32 flags;
> +
> +	/**
> +	 * @cleaned: The buffer object pages have been cleaned.
> +	 *
> +	 * There could be dirty CPU cachelines for the pages of buffer object
> +	 * after allocation, as shmem will zero out the pages. The cachelines
> +	 * need to be cleaned if the pages are going to be accessed with an
> +	 * uncached CPU mapping.
> +	 */
> +	bool cleaned;
>  };
>  
>  /**
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index f522a116c1b1..d8cc9e7d064e 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1249,6 +1249,11 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
>  
>  	op_ctx->map.sgt = sgt;
>  
> +	if (bo->base.map_wc && !bo->cleaned) {
> +		dma_sync_sgtable_for_device(vm->ptdev->base.dev, sgt, DMA_TO_DEVICE);
> +		bo->cleaned = true;
> +	}
> +
>  	preallocated_vm_bo = drm_gpuvm_bo_create(&vm->base, &bo->base.base);
>  	if (!preallocated_vm_bo) {
>  		if (!bo->base.base.import_attach)


