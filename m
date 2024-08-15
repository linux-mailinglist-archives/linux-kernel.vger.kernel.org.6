Return-Path: <linux-kernel+bounces-288069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1086E9532CC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F5DFB22E28
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361401A76AE;
	Thu, 15 Aug 2024 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DAfw62Z/"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58AB44376
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730865; cv=none; b=nVXJ4inAlnQHBzkoM1sq6MYYYr1RGKRRmqxV8lUx3hCC5Vxd042VA8lLuhpuXbehI6OeaSP5g2ksOCHuio6/yh8BrGMwpqHNNqTFA4WYkY6tmc2bqlO2SjsmGwrvVdLl11gsflkmQOw2/wjtIFo9VW29cwS9GHCLQNJ9fNJPNq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730865; c=relaxed/simple;
	bh=k70GG4C+xklWNfHBD34LI0TSB31IckyMeKl/JrKJKkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZIn5e0nqQ+v1c3XtDWP7GqgwBR6S3FctCNuU5Cvk5sobDxfNY01xk9MHMc+NTqD+uqP7BAIPEaeEBw/VboWMGGHhW30i99qdKcR+GNpga2mub1norTqfgjTQJZoNlI8E9QHE9aoEhNrXF/uyRnIeWFE6owCL4Tc2o4W2dIWcgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DAfw62Z/; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RJ4T4U8nLMh+ZQ2Vs65FJCDqKIz6KxKL1v8cX4Zy8ss=; b=DAfw62Z/5NObi7T3b4KqBPmFDC
	yL2iKZp33FBa+AYH2012Lf4tYY16mRIh8k7zpcZ3zFL2KemjDyKUrgIt74BFzdhtx7iHqF6sN9fua
	FYOLJnfaAfmgNiB+MLSrZLRC0LYDapFiyVf6aOlo61eWMVr6Ntyanc6vTROugz0n9+SSHrQ0sB0EL
	SK0Y0aF5+NSi5NxQvlGJ6lZ4dQIFJ7H9Wjyf+TKTebG0DGdV5FCKFYda/az37qmVXshS65d/CZ64z
	MznFoaYBVrdmC7D9Tbr0bhmZxDX2nYdh+rC9yFSZwxwCFrcaZSnjJCKdxpZfhyMr4wRt0fCnevL5S
	hxCJGH4w==;
Received: from [187.36.213.55] (helo=[192.168.1.212])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1seb8Y-000dsP-FM; Thu, 15 Aug 2024 16:07:34 +0200
Message-ID: <1205c363-6635-4081-8155-5a8573481f3f@igalia.com>
Date: Thu, 15 Aug 2024 11:07:25 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/vkms: Rename index to possible_crtc
To: Louis Chauvet <louis.chauvet@bootlin.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net,
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
References: <20240814-google-clarifications-v1-0-3ee76d7d0c28@bootlin.com>
 <20240814-google-clarifications-v1-2-3ee76d7d0c28@bootlin.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Autocrypt: addr=mcanal@igalia.com; keydata=
 xjMEZIsaeRYJKwYBBAHaRw8BAQdAGU6aY8oojw61KS5rGGMrlcilFqR6p6ID45IZ6ovX0h3N
 H01haXJhIENhbmFsIDxtY2FuYWxAaWdhbGlhLmNvbT7CjwQTFggANxYhBDMCqFtIvFKVRJZQ
 hDSPnHLaGFVuBQJkixp5BQkFo5qAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQNI+cctoYVW5u
 GAEAwpaC5rI3wD8zqETKwGVoXd6+AbmGfZuVD40xepy7z/8BAM5w95/oyPsHUqOsg/xUTlNp
 rlbhA+WWoaOXA3XgR+wCzjgEZIsaeRIKKwYBBAGXVQEFAQEHQGoOK0jgh0IorMAacx6WUUWb
 s3RLiJYWUU6iNrk5wWUbAwEIB8J+BBgWCAAmFiEEMwKoW0i8UpVEllCENI+cctoYVW4FAmSL
 GnkFCQWjmoACGwwACgkQNI+cctoYVW6cqwD/Q9R98msvkhgRvi18fzUPFDwwogn+F+gQJJ6o
 pwpgFkAA/R2zOfla3IT6G3SBoV5ucdpdCpnIXFpQLbmfHK7dXsAC
In-Reply-To: <20240814-google-clarifications-v1-2-3ee76d7d0c28@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/14/24 05:46, Louis Chauvet wrote:
> The meaning of index was not clear. Replace them with crtc_index to
> clearly indicate its usage.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

IMHO no need for this patch, especially considering that you are going
to change those lines anyway in a future series.

I'd just drop it.

Best Regards,
- Maíra

> ---
>   drivers/gpu/drm/vkms/vkms_drv.h    |  4 ++--
>   drivers/gpu/drm/vkms/vkms_output.c | 13 +++++++------
>   drivers/gpu/drm/vkms/vkms_plane.c  |  4 ++--
>   3 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 526bf5207524..3028678e4f9b 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -222,10 +222,10 @@ struct vkms_device {
>   int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
>   		   struct drm_plane *primary, struct drm_plane *cursor);
>   
> -int vkms_output_init(struct vkms_device *vkmsdev, int index);
> +int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc_index);
>   
>   struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> -				   enum drm_plane_type type, int index);
> +				   enum drm_plane_type type, int possible_crtc_index);
>   
>   /* CRC Support */
>   const char *const *vkms_get_crc_sources(struct drm_crtc *crtc,
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 5ce70dd946aa..d42ca7d10389 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -31,12 +31,12 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
>   	.get_modes    = vkms_conn_get_modes,
>   };
>   
> -static int vkms_add_overlay_plane(struct vkms_device *vkmsdev, int index,
> +static int vkms_add_overlay_plane(struct vkms_device *vkmsdev, int possible_crtc_index,
>   				  struct drm_crtc *crtc)
>   {
>   	struct vkms_plane *overlay;
>   
> -	overlay = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_OVERLAY, index);
> +	overlay = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_OVERLAY, possible_crtc_index);
>   	if (IS_ERR(overlay))
>   		return PTR_ERR(overlay);
>   
> @@ -46,7 +46,7 @@ static int vkms_add_overlay_plane(struct vkms_device *vkmsdev, int index,
>   	return 0;
>   }
>   
> -int vkms_output_init(struct vkms_device *vkmsdev, int index)
> +int vkms_output_init(struct vkms_device *vkmsdev, int possible_crtc_index)
>   {
>   	struct vkms_output *output = &vkmsdev->output;
>   	struct drm_device *dev = &vkmsdev->drm;
> @@ -58,20 +58,21 @@ int vkms_output_init(struct vkms_device *vkmsdev, int index)
>   	int writeback;
>   	unsigned int n;
>   
> -	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, index);
> +	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, possible_crtc_index);
> +
>   	if (IS_ERR(primary))
>   		return PTR_ERR(primary);
>   
>   	if (vkmsdev->config->overlay) {
>   		for (n = 0; n < NUM_OVERLAY_PLANES; n++) {
> -			ret = vkms_add_overlay_plane(vkmsdev, index, crtc);
> +			ret = vkms_add_overlay_plane(vkmsdev, possible_crtc_index, crtc);
>   			if (ret)
>   				return ret;
>   		}
>   	}
>   
>   	if (vkmsdev->config->cursor) {
> -		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR, index);
> +		cursor = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_CURSOR, possible_crtc_index);
>   		if (IS_ERR(cursor))
>   			return PTR_ERR(cursor);
>   	}
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index 03716616f819..9d85464ee0e9 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -219,12 +219,12 @@ static const struct drm_plane_helper_funcs vkms_plane_helper_funcs = {
>   };
>   
>   struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> -				   enum drm_plane_type type, int index)
> +				   enum drm_plane_type type, int possible_crtc_index)
>   {
>   	struct drm_device *dev = &vkmsdev->drm;
>   	struct vkms_plane *plane;
>   
> -	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 1 << index,
> +	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 1 << possible_crtc_index,
>   					   &vkms_plane_funcs,
>   					   vkms_formats, ARRAY_SIZE(vkms_formats),
>   					   NULL, type, NULL);
> 

