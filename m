Return-Path: <linux-kernel+bounces-431130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D42CA9E39D3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3C0DB36D97
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F79A1BD014;
	Wed,  4 Dec 2024 11:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WjnHGXgv"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4251B87CB
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733313143; cv=none; b=K0xRAsYwruKDRHtRVK4lc+7TLexvyRfLSp7KzxOcOwDmwwAqf/PVq24El7OOLBocNshmREuNJXCfz/7aBw8v1EA4GdC4th/UedOrFjD1JnXlW0xmr53Rrs+DCsL2OF9nZWDAvgBdnfrYLIvWBCQ0QR1xY6ZamVY6bHpmBDdmM+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733313143; c=relaxed/simple;
	bh=CIofiUsYCGpNa7cWh3pB+qNMgIaoHUpTpJnVFk41bGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EftbPnTK4hQpJIeu30Xwd56O71HcWWVfLUFRnG8MxC7bhgpH/pyKry/Iwknxpry7gkWpw4MkBf2R+4bJ+FSYquJC2uRdaIigfJp1ZPxviPk0wiDfzOPnweKfgxnczu2gGaDCo4amCnEdkH16fSSTtWvNwULlwPvssp4nBdQkKX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WjnHGXgv; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HIbgZ8M4VUwx16Itnl0GWvmhFxKtIaZrdC7iSE7Pb+E=; b=WjnHGXgvwDNmUk+O+kx9qc5z+P
	v7rN+6dzHXsf4A5KV1ORQ+3RzHg0O+Zuur0UKhsUjp0REhm9Csp0g10u5HaJIIxR/NTNLJ0IuiK/h
	HnbyHp9ypqRxHyw8NZKyKol8J4WThHmfvluwIMM15dSY1QNg9kitpJjAPBEqwBtTC38LsFv4mYc3E
	qGLR515j/tQx4fghjbHewanDCzawOxRK7njVu9Tf0UEgaHrcQb8ibhp1xStzhKB5Ww9sqQKqjknfT
	XhjSoZCfGnPD43fHseONa/qA526GVh2JAQCQvszlW9/hKNp6IJ8vBqBzvaRuBWUD+V78+r+Tc6YQ7
	znFQgCrA==;
Received: from [187.36.213.55] (helo=[192.168.1.103])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tInvH-00GUoZ-Uo; Wed, 04 Dec 2024 12:52:04 +0100
Message-ID: <b665c18e-e3df-4d62-9ed5-c923fa6dced4@igalia.com>
Date: Wed, 4 Dec 2024 08:51:57 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/v3d: Add DRM_IOCTL_V3D_PERFMON_SET_GLOBAL
To: Christian Gmeiner <christian.gmeiner@gmail.com>,
 Melissa Wen <mwen@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, Christian Gmeiner <cgmeiner@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241202140615.74802-1-christian.gmeiner@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20241202140615.74802-1-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02/12/24 11:06, Christian Gmeiner wrote:
> From: Christian Gmeiner <cgmeiner@igalia.com>
> 
> Add a new ioctl, DRM_IOCTL_V3D_PERFMON_SET_GLOBAL, to allow
> configuration of a global performance monitor (perfmon).
> Use the global perfmon for all jobs to ensure consistent
> performance tracking across submissions. This feature is
> needed to implement a Perfetto datasources in user-space.
> 
> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>

Applied to misc/kernel.git (drm-misc-next).

I had to make a small adjustment in the UAPI documentation, just to make
it conformant to the kernel-doc rules. Nothing big, so I did the
adjustment before applying it.

Best Regards,
- Maíra

> ---
> Changes in v4:
> - Rebased on drm-misc-next.
> - Factored out a small change as separate patch.
> - Fixed some grammar mistakes: s/job/jobs.
> 
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
>   drivers/gpu/drm/v3d/v3d_drv.c     |  1 +
>   drivers/gpu/drm/v3d/v3d_drv.h     |  8 +++++++
>   drivers/gpu/drm/v3d/v3d_perfmon.c | 37 +++++++++++++++++++++++++++++++
>   drivers/gpu/drm/v3d/v3d_sched.c   | 14 +++++++++---
>   drivers/gpu/drm/v3d/v3d_submit.c  | 10 +++++++++
>   include/uapi/drm/v3d_drm.h        | 15 +++++++++++++
>   6 files changed, 82 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
> index fb35c5c3f1a7..8e5cacfa38d3 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.c
> +++ b/drivers/gpu/drm/v3d/v3d_drv.c
> @@ -224,6 +224,7 @@ static const struct drm_ioctl_desc v3d_drm_ioctls[] = {
>   	DRM_IOCTL_DEF_DRV(V3D_PERFMON_GET_VALUES, v3d_perfmon_get_values_ioctl, DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(V3D_SUBMIT_CPU, v3d_submit_cpu_ioctl, DRM_RENDER_ALLOW | DRM_AUTH),
>   	DRM_IOCTL_DEF_DRV(V3D_PERFMON_GET_COUNTER, v3d_perfmon_get_counter_ioctl, DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(V3D_PERFMON_SET_GLOBAL, v3d_perfmon_set_global_ioctl, DRM_RENDER_ALLOW),
>   };
> 
>   static const struct drm_driver v3d_drm_driver = {
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
> index de73eefff9ac..dc1cfe2e14be 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.h
> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> @@ -183,6 +183,12 @@ struct v3d_dev {
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
> @@ -594,6 +600,8 @@ int v3d_perfmon_get_values_ioctl(struct drm_device *dev, void *data,
>   				 struct drm_file *file_priv);
>   int v3d_perfmon_get_counter_ioctl(struct drm_device *dev, void *data,
>   				  struct drm_file *file_priv);
> +int v3d_perfmon_set_global_ioctl(struct drm_device *dev, void *data,
> +				 struct drm_file *file_priv);
> 
>   /* v3d_sysfs.c */
>   int v3d_sysfs_init(struct device *dev);
> diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
> index b4c3708ea781..a1429b9684e0 100644
> --- a/drivers/gpu/drm/v3d/v3d_perfmon.c
> +++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
> @@ -313,6 +313,9 @@ static int v3d_perfmon_idr_del(int id, void *elem, void *data)
>   	if (perfmon == v3d->active_perfmon)
>   		v3d_perfmon_stop(v3d, perfmon, false);
> 
> +	/* If the global perfmon is being destroyed, set it to NULL */
> +	cmpxchg(&v3d->global_perfmon, perfmon, NULL);
> +
>   	v3d_perfmon_put(perfmon);
> 
>   	return 0;
> @@ -398,6 +401,9 @@ int v3d_perfmon_destroy_ioctl(struct drm_device *dev, void *data,
>   	if (perfmon == v3d->active_perfmon)
>   		v3d_perfmon_stop(v3d, perfmon, false);
> 
> +	/* If the global perfmon is being destroyed, set it to NULL */
> +	cmpxchg(&v3d->global_perfmon, perfmon, NULL);
> +
>   	v3d_perfmon_put(perfmon);
> 
>   	return 0;
> @@ -457,3 +463,34 @@ int v3d_perfmon_get_counter_ioctl(struct drm_device *dev, void *data,
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
> +
> +		return 0;
> +	}
> +
> +	if (cmpxchg(&v3d->global_perfmon, NULL, perfmon))
> +		return -EBUSY;
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
> index 99ac4995b5a1..a6c3760da6ed 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -120,11 +120,19 @@ v3d_cpu_job_free(struct drm_sched_job *sched_job)
>   static void
>   v3d_switch_perfmon(struct v3d_dev *v3d, struct v3d_job *job)
>   {
> -	if (job->perfmon != v3d->active_perfmon)
> +	struct v3d_perfmon *perfmon = v3d->global_perfmon;
> +
> +	if (!perfmon)
> +		perfmon = job->perfmon;
> +
> +	if (perfmon == v3d->active_perfmon)
> +		return;
> +
> +	if (perfmon != v3d->active_perfmon)
>   		v3d_perfmon_stop(v3d, v3d->active_perfmon, true);
> 
> -	if (job->perfmon && v3d->active_perfmon != job->perfmon)
> -		v3d_perfmon_start(v3d, job->perfmon);
> +	if (perfmon && v3d->active_perfmon != perfmon)
> +		v3d_perfmon_start(v3d, perfmon);
>   }
> 
>   static void
> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
> index d607aa9c4ec2..9e439c9f0a93 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -981,6 +981,11 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
>   		goto fail;
> 
>   	if (args->perfmon_id) {
> +		if (v3d->global_perfmon) {
> +			ret = -EAGAIN;
> +			goto fail_perfmon;
> +		}
> +
>   		render->base.perfmon = v3d_perfmon_find(v3d_priv,
>   							args->perfmon_id);
> 
> @@ -1196,6 +1201,11 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
>   		goto fail;
> 
>   	if (args->perfmon_id) {
> +		if (v3d->global_perfmon) {
> +			ret = -EAGAIN;
> +			goto fail_perfmon;
> +		}
> +
>   		job->base.perfmon = v3d_perfmon_find(v3d_priv,
>   						     args->perfmon_id);
>   		if (!job->base.perfmon) {
> diff --git a/include/uapi/drm/v3d_drm.h b/include/uapi/drm/v3d_drm.h
> index 2376c73abca1..97b1faf04fc4 100644
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
> @@ -766,6 +769,18 @@ struct drm_v3d_perfmon_get_counter {
>   	__u8 reserved[7];
>   };
> 
> +#define DRM_V3D_PERFMON_CLEAR_GLOBAL    0x0001
> +
> +/**
> + * struct drm_v3d_perfmon_set_global - ioctl to define a global performance
> + * monitor that is used for all jobs. If a global performance monitor is
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
> --
> 2.47.1
> 


