Return-Path: <linux-kernel+bounces-361952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DA899AF4D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAB5AB2248B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BF41D175D;
	Fri, 11 Oct 2024 23:22:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE261CFEA9
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 23:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728688940; cv=none; b=HEeklfbWGtZWobwAcOLXdFgOwZUxFpmOHbHa7OKiPcCgNTrH2hUskXNXfy6beCLvxr7zDqeARScwMSxIr1Wsn0MEDBcVSA0MZ2s/ck1573kOAVxwyjF3f3vdvxixzJ+h9pWyx8OS4fwJu9owwmT4ZFGKrm7xrB6XqeDbjzoVNrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728688940; c=relaxed/simple;
	bh=q1qRl3Lu9gRubFlLRwRT72y+msREMQp3E4p8xQT84Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnEsVSJ3w1JpjYkK1kxCRYTdCDJnGl2EfSKcausQI//wtsj9pskU6VwYVdjINGSVXZBYaEqrhRTG9C0PvStgwMlw2tkZrWSwEk3PG1vrsY3YrzwDW6Zs6dJM655+EyymKx2RUATrrnEL1MBi1AkvSa6TmP+xCwUtxhgryB2wFXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A1DCDA7
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:22:46 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CD1483F5A1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:22:16 -0700 (PDT)
Date: Sat, 12 Oct 2024 00:22:06 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	kernel@collabora.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/panthor: Fix runtime suspend sequence after OPP
 transition error
Message-ID: <ZwmzHj1CJMQVAyun@e110455-lin.cambridge.arm.com>
References: <20241011225906.3789965-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241011225906.3789965-1-adrian.larumbe@collabora.com>

On Fri, Oct 11, 2024 at 11:56:59PM +0100, Adrián Larumbe wrote:
> In case an OPP transition to a suspension state fails during the runtime
> PM suspend call, if the driver's subsystems were successfully resumed,
> we should return -EAGAIN so that the device's runtime PM status remains
> 'active'.
> 
> If FW reload failed, then we should fall through, so that the PM core
> can flag the device as having suffered a runtime error.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com> for this patch. For the other two
I would like first if we try to understand why the suspend does not happen
quick enough (or at all).

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_device.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index 4082c8f2951d..cedd3cbcb47d 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -528,8 +528,13 @@ int panthor_device_suspend(struct device *dev)
>  		    drm_dev_enter(&ptdev->base, &cookie)) {
>  			panthor_gpu_resume(ptdev);
>  			panthor_mmu_resume(ptdev);
> -			drm_WARN_ON(&ptdev->base, panthor_fw_resume(ptdev));
> -			panthor_sched_resume(ptdev);
> +			ret = panthor_fw_resume(ptdev);
> +			if (!ret) {
> +				panthor_sched_resume(ptdev);
> +				ret = -EAGAIN;
> +			} else {
> +				drm_err(&ptdev->base, "FW resume failed at runtime suspend: %d\n", ret);
> +			}
>  			drm_dev_exit(cookie);
>  		}
>  
> -- 
> 2.46.2
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

