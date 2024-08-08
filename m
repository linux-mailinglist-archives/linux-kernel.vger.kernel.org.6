Return-Path: <linux-kernel+bounces-279236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 802F294BAD1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261D41F219B1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED8818A6CD;
	Thu,  8 Aug 2024 10:24:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6730C189F59
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112640; cv=none; b=StODCZuwHNyMFxpSZ6Yu/ZN8ngD37oqNZNHkaKxfyWb6a9k2+GO9QXTFrfpuYnBgXNsVblvfwmSXcGkOQ8b6s7C3Rjl8iSe3l13mI71k5FzjO6dJ5KF2CbetC5uiCdtSMRD8UefALPKHluKrxBl2YiL2D1fEKj7uFmA+X11QH4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112640; c=relaxed/simple;
	bh=NRpjefoAf0si/NCj5HpnS6xtFy0CHPE/B/N8eLe3Xy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qgjtj41xfBp6rQnG+z3SCyrDR9A3AIRE2E0MBR+yV8PinDfpCDtTKMaVt+2yQccMoI4W/g6vrU0xFdH+poSheXUPYgEZhr6L6z5+lJfj+6oLkQo0FZXMgFaAK8F2AFJQumlWOMq0aA//rYqcJdLhT7s36DlOVdROepT2qMTHJGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B243E1042;
	Thu,  8 Aug 2024 03:24:24 -0700 (PDT)
Received: from [10.1.26.21] (e122027.cambridge.arm.com [10.1.26.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF2323F766;
	Thu,  8 Aug 2024 03:23:56 -0700 (PDT)
Message-ID: <455c684c-7ec2-4588-b028-f59c144c9348@arm.com>
Date: Thu, 8 Aug 2024 11:23:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/panfrost: Add cycle counter job requirement
To: Mary Guillemard <mary.guillemard@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
References: <20240807160900.149154-1-mary.guillemard@collabora.com>
 <20240807160900.149154-3-mary.guillemard@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20240807160900.149154-3-mary.guillemard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/08/2024 17:08, Mary Guillemard wrote:
> Extend the uAPI with a new job requirement flag for cycle
> counters. This requirement is used by userland to indicate that a job
> requires cycle counters or system timestamp to be propagated. (for use
> with write value timestamp jobs)
> 
> We cannot enable cycle counters unconditionally as this would result in
> an increase of GPU power consumption. As a result, they should be left
> off unless required by the application.
> 
> This new uAPI will be used in Mesa to implement timestamp queries and
> VK_KHR_shader_clock.
> 
> Signed-off-by: Mary Guillemard <mary.guillemard@collabora.com>

Makes sense, but I'm not sure why this needs to be it's own patch - I'd
squash this with the next one where it actually gets used.

Steve

> ---
>  include/uapi/drm/panfrost_drm.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_drm.h
> index 52b050e2b660..568724be6628 100644
> --- a/include/uapi/drm/panfrost_drm.h
> +++ b/include/uapi/drm/panfrost_drm.h
> @@ -40,6 +40,7 @@ extern "C" {
>  #define DRM_IOCTL_PANFROST_PERFCNT_DUMP		DRM_IOW(DRM_COMMAND_BASE + DRM_PANFROST_PERFCNT_DUMP, struct drm_panfrost_perfcnt_dump)
>  
>  #define PANFROST_JD_REQ_FS (1 << 0)
> +#define PANFROST_JD_REQ_CYCLE_COUNT (1 << 1)
>  /**
>   * struct drm_panfrost_submit - ioctl argument for submitting commands to the 3D
>   * engine.


