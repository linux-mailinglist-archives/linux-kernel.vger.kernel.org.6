Return-Path: <linux-kernel+bounces-412832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A6D9D0FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57BFCB29E2D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC261991DD;
	Mon, 18 Nov 2024 11:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="E4eB7DU2"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB901991A1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731929384; cv=none; b=GGwzlWuFqbKM8+bPhDXllHaWURWPZypAuM5a0AYkekNwIJG9a0kwTkRtowQqSjuUBF2nXXm8BFy9Wem53ZSJdcA1qfFe5mmzxt4ohp5yCrgwPMzFaPIxyOhCwHCWbE+fQ+KuRc+dMWCAyKQ0wegexYltgI29eMXutwMHb0pEa8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731929384; c=relaxed/simple;
	bh=zSaK742BAiSZjlDFPoqUoycpPBD4VlOnT8q2bySgbXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0nSBfVEh2d156v33n2OL0hrnhWkg5e369gmZTqDadzAnep/EYBneuSN4UOOd4LcZ0G+SrSQO96RrQOFJvG8Kjan0kcc9AOFQhnKGWrMy1a5bkpDY8lMSiCAJb3mHYl5Jg2tOf9QFu6xosTyEyNmc/azx8QyT1lEyLOiiN9aNRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=E4eB7DU2; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9P8xPxcg1J9Buv3Jwpn68RNa1OCmGSVC4fQcvu/hqKo=; b=E4eB7DU28U1J9RHCgDmsBdgRuC
	6YTqLk8DtcXksqh8//R5tyoYs5CTk1jRJIEhG9HnAe/fS5fooTjUZkPLLLYL383z3g2cXad5vSEYV
	8EkgEfqiuXPD4NyTIe+m7qURi3lPij6FqmYXQBdl8Hon5hUrG+4LlgwhvDgF/jOnYiMIdgNNAIqGB
	IZ90GJqf796ESOcpR2z8evklTog2BB2qMkC8n0MSUu1/dvZnimJUTfrMqbzaCqOowqATFWZlBi+ca
	1CtLEzB72X3YISGEG+NW/z3r+g4wlWscQROfDjlCvVt0xaDu3uq7aJ7pC+N/T6d5JoP5piNbksyhD
	ee50kMZw==;
Received: from [187.36.213.55] (helo=[192.168.1.103])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tCzwa-008TGU-8W; Mon, 18 Nov 2024 12:29:24 +0100
Message-ID: <9980c54b-a3ba-4396-ac83-37e14a81f74a@igalia.com>
Date: Mon, 18 Nov 2024 08:29:17 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/v3d: Add DRM_IOCTL_V3D_PERFMON_SET_GLOBAL
To: Christian Gmeiner <christian.gmeiner@gmail.com>,
 Melissa Wen <mwen@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, Christian Gmeiner <cgmeiner@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241117214110.162547-1-christian.gmeiner@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20241117214110.162547-1-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christian,

The patch overall LGTM, I just have one small nit.

On 17/11/24 18:41, Christian Gmeiner wrote:
> From: Christian Gmeiner <cgmeiner@igalia.com>
> 
> Add a new ioctl, DRM_IOCTL_V3D_PERFMON_SET_GLOBAL, to allow
> configuration of a global performance monitor (perfmon).
> Use the global perfmon for all jobs to ensure consistent
> performance tracking across submissions. This feature is
> needed to implement a Perfetto datasources in user-space.
> 
> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
> ---
> Changes in v3:
> - Reworked commit message.
> - Refined some code comments.
> - Added missing v3d_perfmon_stop(..) call to v3d_perfmon_destroy_ioctl(..).
> 
> Changes in v2:
> - Reworked commit message.
> - Removed num_perfmon counter for tracking perfmon allocations.
> - Allowing allocation of perfmons when the global perfmon is active.
> - Return -EAGAIN for submissions with a per job perfmon if the global perfmon is active.
> ---
> 
> ---
>   drivers/gpu/drm/v3d/v3d_drv.c     |  1 +
>   drivers/gpu/drm/v3d/v3d_drv.h     |  8 ++++++
>   drivers/gpu/drm/v3d/v3d_perfmon.c | 42 +++++++++++++++++++++++++++++++
>   drivers/gpu/drm/v3d/v3d_sched.c   | 14 ++++++++---
>   drivers/gpu/drm/v3d/v3d_submit.c  | 10 ++++++++
>   include/uapi/drm/v3d_drm.h        | 15 +++++++++++
>   6 files changed, 87 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
> index d7ff1f5fa481..3c89f0daa5b8 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.c
> +++ b/drivers/gpu/drm/v3d/v3d_drv.c
> @@ -214,6 +214,7 @@ static const struct drm_ioctl_desc v3d_drm_ioctls[] = {
>   	DRM_IOCTL_DEF_DRV(V3D_PERFMON_GET_VALUES, v3d_perfmon_get_values_ioctl, DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(V3D_SUBMIT_CPU, v3d_submit_cpu_ioctl, DRM_RENDER_ALLOW | DRM_AUTH),
>   	DRM_IOCTL_DEF_DRV(V3D_PERFMON_GET_COUNTER, v3d_perfmon_get_counter_ioctl, DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(V3D_PERFMON_SET_GLOBAL, v3d_perfmon_set_global_ioctl, DRM_RENDER_ALLOW),
>   };
>   
>   static const struct drm_driver v3d_drm_driver = {
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
> index cf4b23369dc4..a0d920ec2b1d 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.h
> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> @@ -179,6 +179,12 @@ struct v3d_dev {
>   		u32 num_allocated;
>   		u32 pages_allocated;
>   	} bo_stats;
> +
> +	/* To support a performance analysis tool in user space, we require
> +	 * a single, globally configured performance monitor (perfmon) for
> +	 * all jobs.
> +	 */
> +	struct v3d_perfmon *global_perfmon;
>   };
>   
>   static inline struct v3d_dev *
> @@ -584,6 +590,8 @@ int v3d_perfmon_get_values_ioctl(struct drm_device *dev, void *data,
>   				 struct drm_file *file_priv);
>   int v3d_perfmon_get_counter_ioctl(struct drm_device *dev, void *data,
>   				  struct drm_file *file_priv);
> +int v3d_perfmon_set_global_ioctl(struct drm_device *dev, void *data,
> +				 struct drm_file *file_priv);
>   
>   /* v3d_sysfs.c */
>   int v3d_sysfs_init(struct device *dev);
> diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
> index 156be13ab2ef..df72171d8c80 100644
> --- a/drivers/gpu/drm/v3d/v3d_perfmon.c
> +++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
> @@ -312,6 +312,9 @@ static int v3d_perfmon_idr_del(int id, void *elem, void *data)
>   	if (perfmon == v3d->active_perfmon)
>   		v3d_perfmon_stop(v3d, perfmon, false);
>   
> +	/* If the global perfmon is being destroyed, set it to NULL */
> +	cmpxchg(&v3d->global_perfmon, perfmon, NULL);
> +
>   	v3d_perfmon_put(perfmon);
>   
>   	return 0;
> @@ -383,6 +386,7 @@ int v3d_perfmon_destroy_ioctl(struct drm_device *dev, void *data,
>   {
>   	struct v3d_file_priv *v3d_priv = file_priv->driver_priv;
>   	struct drm_v3d_perfmon_destroy *req = data;
> +	struct v3d_dev *v3d = v3d_priv->v3d;
>   	struct v3d_perfmon *perfmon;
>   
>   	mutex_lock(&v3d_priv->perfmon.lock);
> @@ -392,6 +396,13 @@ int v3d_perfmon_destroy_ioctl(struct drm_device *dev, void *data,
>   	if (!perfmon)
>   		return -EINVAL;
>   
> +	/* If the active perfmon is being destroyed, stop it first */
> +	if (perfmon == v3d->active_perfmon)
> +		v3d_perfmon_stop(v3d, perfmon, false);

Could you please move this snippet to different patch? This snippet is a
global fix as it can prevent NULL pointer dereferences triggered by the
user-space. I would like to push this snippet to drm-misc-fixes.

> +
> +	/* If the global perfmon is being destroyed, set it to NULL */
> +	cmpxchg(&v3d->global_perfmon, perfmon, NULL);
> +
>   	v3d_perfmon_put(perfmon);
>   
>   	return 0;
> @@ -451,3 +462,34 @@ int v3d_perfmon_get_counter_ioctl(struct drm_device *dev, void *data,
>   
>   	return 0;
>   }
> +
> +int v3d_perfmon_set_global_ioctl(struct drm_device *dev, void *data,
> +				 struct drm_file *file_priv)
> +{
> +	struct v3d_file_priv *v3d_priv = file_priv->driver_priv;
> +	struct drm_v3d_perfmon_set_global *req = data;
> +	struct v3d_dev *v3d = to_v3d_dev(dev);
> +	struct v3d_perfmon *perfmon;
> +
> +	if (req->flags & ~DRM_V3D_PERFMON_CLEAR_GLOBAL)
> +		return -EINVAL;
> +
> +	perfmon = v3d_perfmon_find(v3d_priv, req->id);
> +	if (!perfmon)
> +		return -EINVAL;
> +
> +	/* If the request is to clear the global performance monitor */
> +	if (req->flags & DRM_V3D_PERFMON_CLEAR_GLOBAL) {
> +		if (!v3d->global_perfmon)
> +			return -EINVAL;
> +
> +		xchg(&v3d->global_perfmon, NULL);

What if v3d->global_perfmon is running?

> +
> +		return 0;
> +	}
> +
> +	if (cmpxchg(&v3d->global_perfmon, NULL, perfmon))
> +		return -EBUSY;
> +
> +	return 0;
> +}

[...]

> diff --git a/include/uapi/drm/v3d_drm.h b/include/uapi/drm/v3d_drm.h
> index 87fc5bb0a61e..7c2ad9d0270d 100644
> --- a/include/uapi/drm/v3d_drm.h
> +++ b/include/uapi/drm/v3d_drm.h
> @@ -43,6 +43,7 @@ extern "C" {
>   #define DRM_V3D_PERFMON_GET_VALUES                0x0a
>   #define DRM_V3D_SUBMIT_CPU                        0x0b
>   #define DRM_V3D_PERFMON_GET_COUNTER               0x0c
> +#define DRM_V3D_PERFMON_SET_GLOBAL                0x0d
>   
>   #define DRM_IOCTL_V3D_SUBMIT_CL           DRM_IOWR(DRM_COMMAND_BASE + DRM_V3D_SUBMIT_CL, struct drm_v3d_submit_cl)
>   #define DRM_IOCTL_V3D_WAIT_BO             DRM_IOWR(DRM_COMMAND_BASE + DRM_V3D_WAIT_BO, struct drm_v3d_wait_bo)
> @@ -61,6 +62,8 @@ extern "C" {
>   #define DRM_IOCTL_V3D_SUBMIT_CPU          DRM_IOW(DRM_COMMAND_BASE + DRM_V3D_SUBMIT_CPU, struct drm_v3d_submit_cpu)
>   #define DRM_IOCTL_V3D_PERFMON_GET_COUNTER DRM_IOWR(DRM_COMMAND_BASE + DRM_V3D_PERFMON_GET_COUNTER, \
>   						   struct drm_v3d_perfmon_get_counter)
> +#define DRM_IOCTL_V3D_PERFMON_SET_GLOBAL  DRM_IOW(DRM_COMMAND_BASE + DRM_V3D_PERFMON_SET_GLOBAL, \
> +						   struct drm_v3d_perfmon_set_global)
>   
>   #define DRM_V3D_SUBMIT_CL_FLUSH_CACHE             0x01
>   #define DRM_V3D_SUBMIT_EXTENSION		  0x02
> @@ -765,6 +768,18 @@ struct drm_v3d_perfmon_get_counter {
>   	__u8 reserved[7];
>   };
>   
> +#define DRM_V3D_PERFMON_CLEAR_GLOBAL    0x0001
> +
> +/**
> + * struct drm_v3d_perfmon_set_global - ioctl to define a global performance
> + * monitor that is used for all job. If a global performance monitor is

s/job/jobs

Best Regards,
- Maíra

> + * defined, jobs with a self-defined performance monitor are not allowed.
> + */
> +struct drm_v3d_perfmon_set_global {
> +	__u32 flags;
> +	__u32 id;
> +};
> +
>   #if defined(__cplusplus)
>   }
>   #endif


