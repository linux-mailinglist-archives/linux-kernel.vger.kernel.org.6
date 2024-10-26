Return-Path: <linux-kernel+bounces-383259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE739B191A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 17:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67C0DB2165C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 15:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA46134CF5;
	Sat, 26 Oct 2024 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="P5lX5iOV"
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F09A2CCB4
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729956602; cv=none; b=oP8U36cpNtaD/CMnOnkwECpBfPrr1AMtfdQKV+51w23enKaxwYXe4roiuHzsehxbP1Oxr89PABtgxd708ydyD7QBAJpoID30S6DwN0H+qen4y1utSDNZSUuqcyRX8Gl8DzcZfjNbBm2KmNkNXDGI+asAI0WtswkuHOIblvxS7Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729956602; c=relaxed/simple;
	bh=pYluJ3omqwxgqFAuDuVyD/Sd6a9hO2GIbBm03evzMkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJv9qYuEYHtp1wEfY9ujQ0R51MERHjVVo/CgNYtB12mT/Cyx3O5N3GSUpDlyHtRquyP6ZahER2RmY5Vo+x1Ma8xA8weGo4xpxsE9laMGiO9DRZUey7JRLZoeYYQdEvZFleDbw+UoLsJ/UC7nMeXRTO4nUWeOhswS8EtxaBszxLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=P5lX5iOV; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4XbNr73dW2z9sds;
	Sat, 26 Oct 2024 15:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1729956599; bh=pYluJ3omqwxgqFAuDuVyD/Sd6a9hO2GIbBm03evzMkM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P5lX5iOV60zHPz2UpbtBKNNqnm9m47Z0j/IF7cS5n8e7uOuH0eFUOL6Fc2y9Zk38J
	 8BbulnkN0hTOF+TsT5p7myVKy3LVo9Zy+ilYlE7gbHQ/z6eAODxgPHgVZ9gHo3Ky9Y
	 fHIQ6GOdoU9MeQGX3mfZbFQ+WRzhp3NfGWUvtyR4=
X-Riseup-User-ID: FFBD87AD2E51267661257BB3EE0703F461EECA8382EB83FB8428AA0B3FB6850F
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4XbNqn6JlszFqLF;
	Sat, 26 Oct 2024 15:29:41 +0000 (UTC)
Message-ID: <575323aa-d322-4d03-8343-15aaaa955437@riseup.net>
Date: Sat, 26 Oct 2024 12:29:39 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/5] drm/vkms: Switch to managed for connector
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
 seanpaul@google.com, nicolejadeyee@google.com,
 20241010-vkms-remove-index-v2-1-6b8d6cfd5a15@bootlin.com
References: <20241010-google-vkms-managed-v4-0-ed04a62ad2e3@bootlin.com>
 <20241010-google-vkms-managed-v4-1-ed04a62ad2e3@bootlin.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20241010-google-vkms-managed-v4-1-ed04a62ad2e3@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Louis,

On 10/10/24 14:39, Louis Chauvet wrote:
> The current VKMS driver uses non-managed function to create connectors. It
> is not an issue yet, but in order to support multiple devices easily,
> convert this code to use drm and device managed helpers.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>   drivers/gpu/drm/vkms/vkms_output.c | 19 +++++++------------
>   1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 5128aa3b2eb6..8f7a05b73e1d 100644
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
> @@ -70,17 +70,17 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>   			if (IS_ERR(overlay)) {
>   				DRM_DEV_ERROR(dev->dev, "Failed to init vkms plane\n");
>   				ret = PTR_ERR(overlay);
> -				goto err_crtc;
> +				goto err_connector;

Why did you renamed err_crtc to err_connector? I think err_crtc looks
correct.

Best Regards,
- Maíra

>   			}
>   			overlay->base.possible_crtcs = drm_crtc_mask(crtc);
>   		}
>   	}
>   
> -	ret = drm_connector_init(dev, connector, &vkms_connector_funcs,
> -				 DRM_MODE_CONNECTOR_VIRTUAL);
> +	ret = drmm_connector_init(dev, connector, &vkms_connector_funcs,
> +				  DRM_MODE_CONNECTOR_VIRTUAL, NULL);
>   	if (ret) {
>   		DRM_ERROR("Failed to init connector\n");
> -		goto err_crtc;
> +		goto err_connector;
>   	}
>   
>   	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
> @@ -89,7 +89,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>   			       DRM_MODE_ENCODER_VIRTUAL, NULL);
>   	if (ret) {
>   		DRM_ERROR("Failed to init encoder\n");
> -		goto err_encoder;
> +		return ret;
>   	}
>   	encoder->possible_crtcs = drm_crtc_mask(crtc);
>   
> @@ -111,12 +111,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>   
>   err_attach:
>   	drm_encoder_cleanup(encoder);
> -
> -err_encoder:
> -	drm_connector_cleanup(connector);
> -
> -err_crtc:
> +err_connector:
>   	drm_crtc_cleanup(crtc);
> -
>   	return ret;
>   }
> 

