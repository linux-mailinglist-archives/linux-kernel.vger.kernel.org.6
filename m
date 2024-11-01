Return-Path: <linux-kernel+bounces-392010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5F99B8E8D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116BA1F22512
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B1E15990C;
	Fri,  1 Nov 2024 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jJpaPK5J"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A7514F9F8
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730455485; cv=none; b=RZvGjAMQOZ/NBWpenVIROH06zSf+/fbg3l8fmXBkwtggUm7i0R/wzCWGueYM95cPm56tn2i5hz1pInlFXocbH4roR0YU/09pWc8o6tDovqKAO2OaAW1w/bLU8iZ/wMpBsZ7dWLxIIDb6rrjiTLhMekA4gOZc79pJwCX9b3zjK0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730455485; c=relaxed/simple;
	bh=+dtoM/M7ODfRLxAyRHALc+6Mx8PUbS19MuVnin/OCkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HYxy0lJGkPj4o+swYldKSFtINL93eA51f0YSyYwa0debW8ipoXvIw4vq60D2GcLW6Zwh3lS4TKslnlcOI9pJXSqGXYNYBdV9EM9pLb1/I6YmcWJUgkyHE+s2OMHo1M/VVkR1loqf6FcszliBzrTUOYOW7kF4TRcLYR99ykjAmFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jJpaPK5J; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KcBKVA3P3us9yCSAuJYdZ3kBwWfL0seMrbogM04O8Bg=; b=jJpaPK5JS4X/e2ThD4y/L/sODr
	vTK/YJ6Q1MnGr1zzKEfLRdtfmxXSYeEzJOFj0andOXWnxjJ7SoUvFA7RwOCIxOpYvB5Pkj6ZZyd0Z
	vOg95kwf0Rf0vzAJekmpddSQbSpmd5idyLqhWMFURUzXmkYcMJ/TiZwLfymk0yauU8HAll0MsOC+k
	HbvsyQ6NJt/+vQp+Kr+exmMwZIFopGky8Bd8itb8oMrIF4T01Um56TrRzH5QAZ3HiXfcZE+FwLh4I
	nvH2ePTExByl3kMY9z7VOPzvnfCjQpHwyM0Ve4jOlVs8S435Lpfk1aH/l548xy2RD1K7cDSVcFEKJ
	qZBaWsIQ==;
Received: from [187.36.213.55] (helo=[192.168.1.103])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t6oVy-000O9S-3P; Fri, 01 Nov 2024 11:04:22 +0100
Message-ID: <3a433ba3-2c61-45ac-9204-62216677c23d@igalia.com>
Date: Fri, 1 Nov 2024 07:04:13 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/vkms: Drop unnecessary call to drm_crtc_cleanup()
To: =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
 louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com, simona@ffwll.ch, melissa.srw@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241031183835.3633-1-jose.exposito89@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20241031183835.3633-1-jose.exposito89@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi José,

On 31/10/24 15:38, José Expósito wrote:
> CRTC creation uses drmm_crtc_init_with_planes(), which automatically
> handles cleanup. However, an unnecessary call to drm_crtc_cleanup() is
> still present in the vkms_output_init() error path.
> 
> Fixes: 99cc528ebe92 ("drm/vkms: Use drmm_crtc_init_with_planes()")
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra

> ---
>   drivers/gpu/drm/vkms/vkms_output.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 0a5a185aa0b0..25a99fde126c 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -92,7 +92,7 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
>   				 DRM_MODE_CONNECTOR_VIRTUAL);
>   	if (ret) {
>   		DRM_ERROR("Failed to init connector\n");
> -		goto err_connector;
> +		return ret;
>   	}
>   
>   	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
> @@ -131,8 +131,5 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
>   err_encoder:
>   	drm_connector_cleanup(connector);
>   
> -err_connector:
> -	drm_crtc_cleanup(crtc);
> -
>   	return ret;
>   }


