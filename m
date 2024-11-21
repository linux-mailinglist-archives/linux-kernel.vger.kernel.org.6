Return-Path: <linux-kernel+bounces-416784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 466019D4A30
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77C41F21ECE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68106175562;
	Thu, 21 Nov 2024 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gMn7qclb"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E979514037F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732182443; cv=none; b=I9i9yNMZjFk2xROYu3irqBUmwRZ5CY4UtHeKCag2cVqGOp+yZqjnrZXSmA6PyIRIrzi4zRTbrD8Trd02lnq2iwaO6ONr4vSa1mOQBglxq3EoRdU71qgdyqHn2+N2nArOOqxX78kKjEIvkY1lN48ze0ejnmgcdsdSlGgeq7zn684=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732182443; c=relaxed/simple;
	bh=Gpje52MeQkC2HWbcecyTdgd/XV/yeZ7raSsN+rV5p1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VNhR3Dm2Qp2KPUUVQYvltDpCUnZc/UE3d3KzxeYOyggO9cYdeFcrBNlWEk0wj8sDyXo2Te16Pj3qlFFynT4tbBWDyAzYmd7bCr/d/gzoq9WVxySZ/Hj2x3QZ8f4ioD7+EEuibKMpkFiF6t2PY3oPEuSDMZglEIWsyZvoQyvTVNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gMn7qclb; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+f/DS4eIhc6HJDHU7gW/93mS9sHoEQHIU8oWWCmNg0E=; b=gMn7qclbdFVAnDNBlsZg1SpwQ7
	9fka/v6UnK16oqpjoopcr6QWnUO26WS2iYyjYzCeqHZNASqkztfzzLz+wxOXc4JMxfhAvnAz4gdTP
	4+WKXe2aNEgfaaxXwe5EaAkb9AuqzdDNdV4IgPv9lo9ZV5jSZ5QYSa/CjTZbrPje5XAcfTH2I/unt
	8Nlr8+GBB1WG7hDtYRz/nVvOQ4uWphsu817xDAmK0JbBeR2rrMzBo9x773/UiUzrsee+K9tSMULKl
	NKORwsi2b751DJD36z6fiMXJ7G0KSBj7zKoAzRJZsGSXjN+skHxz41viDlsnoTVoYkoAb2/7XTryg
	pjREgyTg==;
Received: from [90.241.98.187] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tE3mG-00ALcg-8Q; Thu, 21 Nov 2024 10:47:08 +0100
Message-ID: <d0c0802f-6fce-4112-a228-e484cebff383@igalia.com>
Date: Thu, 21 Nov 2024 09:47:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/etnaviv: Add fdinfo support for memory stats
To: Christian Gmeiner <christian.gmeiner@gmail.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, tursulin@igalia.com,
 Christian Gmeiner <cgmeiner@igalia.com>, etnaviv@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241121092409.3859592-1-christian.gmeiner@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20241121092409.3859592-1-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 21/11/2024 09:24, Christian Gmeiner wrote:
> From: Christian Gmeiner <cgmeiner@igalia.com>
> 
> Use the new helper to export stats about memory usage.
> 
> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
> ---
>   drivers/gpu/drm/etnaviv/etnaviv_drv.c | 12 +++++++++++-
>   drivers/gpu/drm/etnaviv/etnaviv_gem.c | 12 ++++++++++++
>   2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index 6500f3999c5f..35f47dd6367f 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -488,7 +488,16 @@ static const struct drm_ioctl_desc etnaviv_ioctls[] = {
>   	ETNA_IOCTL(PM_QUERY_SIG, pm_query_sig, DRM_RENDER_ALLOW),
>   };
>   
> -DEFINE_DRM_GEM_FOPS(fops);
> +static void etnaviv_show_fdinfo(struct drm_printer *p, struct drm_file *file)
> +{
> +	drm_show_memory_stats(p, file);
> +}
> +
> +static const struct file_operations fops = {
> +	.owner = THIS_MODULE,
> +	DRM_GEM_FOPS,
> +	.show_fdinfo = drm_show_fdinfo,
> +};
>   
>   static const struct drm_driver etnaviv_drm_driver = {
>   	.driver_features    = DRIVER_GEM | DRIVER_RENDER,
> @@ -498,6 +507,7 @@ static const struct drm_driver etnaviv_drm_driver = {
>   #ifdef CONFIG_DEBUG_FS
>   	.debugfs_init       = etnaviv_debugfs_init,
>   #endif
> +	.show_fdinfo        = etnaviv_show_fdinfo,
>   	.ioctls             = etnaviv_ioctls,
>   	.num_ioctls         = DRM_ETNAVIV_NUM_IOCTLS,
>   	.fops               = &fops,
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> index 5c0c9d4e3be1..e81c261b0017 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -527,6 +527,17 @@ void etnaviv_gem_obj_add(struct drm_device *dev, struct drm_gem_object *obj)
>   	mutex_unlock(&priv->gem_lock);
>   }
>   
> +static enum drm_gem_object_status etnaviv_gem_status(struct drm_gem_object *obj)
> +{
> +	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
> +	enum drm_gem_object_status status = 0;
> +
> +	if (etnaviv_obj->pages)
> +		status |= DRM_GEM_OBJECT_RESIDENT;
> +
> +	return status;

Or just:

return etnaviv_obj->pages ? DRM_GEM_OBJECT_RESIDENT : 0;

But it is inconsequential, or maybe even you plan to add purgeable at 
some point.

> +}
> +
>   static const struct vm_operations_struct vm_ops = {
>   	.fault = etnaviv_gem_fault,
>   	.open = drm_gem_vm_open,
> @@ -540,6 +551,7 @@ static const struct drm_gem_object_funcs etnaviv_gem_object_funcs = {
>   	.get_sg_table = etnaviv_gem_prime_get_sg_table,
>   	.vmap = etnaviv_gem_prime_vmap,
>   	.mmap = etnaviv_gem_mmap,
> +	.status = etnaviv_gem_status,
>   	.vm_ops = &vm_ops,
>   };
>  
Either way LGTM.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

