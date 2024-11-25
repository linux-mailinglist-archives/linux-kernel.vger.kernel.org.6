Return-Path: <linux-kernel+bounces-421700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C62F9D8EAF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 23:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319E5284C45
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 22:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F7B1C1F20;
	Mon, 25 Nov 2024 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QdbKn0WM"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7C316EB4C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 22:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732574903; cv=none; b=IBIgu+pacOIek1D5iIhjhfYVbuAj0s38qkY3fm4Txu58IiTJGh/k8fZPxOViJ+6X0Hi18hS0STPFTIwTM2a178OXgqzvItHGzeLKjZojHOoyPKCC8mvL9PA+ikwzxDIpG6qxqe3JxYRb5FdwOxJ1SdiSf5DRZ7rtaxiEdXAfFFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732574903; c=relaxed/simple;
	bh=ZkUASPgJWubPmc+jsWfT0D6LschnMjCKGsoziZSeaCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEsAAOYnREnKttiGeml/EKsikERNVCJQO94VQ7ZQhgANltcbE17TUOFdiRhQo6g+7sQy0l4oJmyPyhHCctswhnhcuBWi7APreXAw8SPaKjxuw/KnbGRwSZx2U9s1GGB1HeCRLhUnGg0vZhXzxcy2VOHqjgtk3QdbEoG65lwsMFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=QdbKn0WM; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TqVNrxG3v2f+O0cNNwlQZrO9juHOFBUp1hcXjRuvHaY=; b=QdbKn0WMKRfwHuuwzSIQW3F1hf
	Ly32WYxQnhQafH2zt6wIHzwfQILizvdZdG0AEVlgK30YU6dZMWCioFDfGEa9GsbBhIDtOVDAgfwBt
	ySaluIETsPDVLXz9Eio52POfA+M0GAg1dhtW+0ZoEtWaHYFqNYPZJ80/tp7SkdRsL085Kd5Knh1PW
	9Kje4pH4eGNdBvdH5hABI37Tdgyt4CXUpO/wzQ2iYD04lxZhddn4fXA0o2+dGKIg1FSoUUU5BejcF
	n3CwKzMSyXxmdt0JrlXhgTCTm3KlNjN0aPj3xZT+hyKb1F1J1ksanxFaChuiCZouxm9/4NRAdk15M
	Ew3INqtA==;
Received: from [187.36.213.55] (helo=[192.168.1.103])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tFhcY-00CspU-GB; Mon, 25 Nov 2024 23:31:54 +0100
Message-ID: <81d53fbc-966e-4e7e-a89e-541bb61f3431@igalia.com>
Date: Mon, 25 Nov 2024 19:31:46 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] drm/vkms: Switch to managed for connector
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net,
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 seanpaul@google.com, nicolejadeyee@google.com
References: <20241122-google-vkms-managed-v5-0-1ab60403e960@bootlin.com>
 <20241122-google-vkms-managed-v5-1-1ab60403e960@bootlin.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20241122-google-vkms-managed-v5-1-1ab60403e960@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Louis,

On 22/11/24 13:27, Louis Chauvet wrote:
> The current VKMS driver uses non-managed function to create connectors. It
> is not an issue yet, but in order to support multiple devices easily,
> convert this code to use drm and device managed helpers.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra

> ---
>   drivers/gpu/drm/vkms/vkms_output.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 8f4bd5aef087b459d37d0cbbf90fe0145090917a..570823ecb28f589e6323036590ec05a2f633bc9b 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -3,11 +3,11 @@
>   #include "vkms_drv.h"
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_edid.h>
> +#include <drm/drm_managed.h>
>   #include <drm/drm_probe_helper.h>
>   
>   static const struct drm_connector_funcs vkms_connector_funcs = {
>   	.fill_modes = drm_helper_probe_single_connector_modes,
> -	.destroy = drm_connector_cleanup,
>   	.reset = drm_atomic_helper_connector_reset,
>   	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>   	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> @@ -75,8 +75,8 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>   		}
>   	}
>   
> -	ret = drm_connector_init(dev, connector, &vkms_connector_funcs,
> -				 DRM_MODE_CONNECTOR_VIRTUAL);
> +	ret = drmm_connector_init(dev, connector, &vkms_connector_funcs,
> +				  DRM_MODE_CONNECTOR_VIRTUAL, NULL);
>   	if (ret) {
>   		DRM_ERROR("Failed to init connector\n");
>   		return ret;
> @@ -88,7 +88,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>   			       DRM_MODE_ENCODER_VIRTUAL, NULL);
>   	if (ret) {
>   		DRM_ERROR("Failed to init encoder\n");
> -		goto err_encoder;
> +		return ret;
>   	}
>   	encoder->possible_crtcs = drm_crtc_mask(crtc);
>   
> @@ -110,9 +110,5 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>   
>   err_attach:
>   	drm_encoder_cleanup(encoder);
> -
> -err_encoder:
> -	drm_connector_cleanup(connector);
> -
>   	return ret;
>   }
> 


