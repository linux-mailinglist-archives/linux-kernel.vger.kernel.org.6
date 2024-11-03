Return-Path: <linux-kernel+bounces-393977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 229059BA82B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 22:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52AF281C23
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 21:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD891885BB;
	Sun,  3 Nov 2024 21:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CoFK6cJs"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADFE155392
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 21:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730667725; cv=none; b=EvA6IibvibheQDH/ExFBrw9bE2bmKRiNsWqrk5t1Qh6RwDJZVT+pas4QIJxuQ4oMiUbaVCQ5QQBzQZD/cM1qajQQ1hOtw0i6ujx/E91c8OO7Uh0KTE/QENhkiqkK/ISykQ0EccoXflEonpY1Zyd02LG5o0POh8hqXy8yLWuzj+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730667725; c=relaxed/simple;
	bh=NQ+erUgYTxtczsxjbUlmiDcbdK+5XN3DS5SyLimQJoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V47P8j1/oGUG+sfxfepJq99yYdYywRwuaIDjg7LepIsjjKy58Vtvqo2oVpQbm0lrKF3+lp34OjqmDC7JCy1QDdTJLKHJJ33MfzXLERA5r5vImrjKZOeVG5R2pFWEUo1WOclU6dVF9WNtQ4DQDwTEhzoJWxajc0VRtuqKneqjzaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CoFK6cJs; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MY+Vc7uFmphCkUSkAjhdUC6MhY/i+58M2HkZTuvQH8s=; b=CoFK6cJsv4jz92+bCg9TbUpClB
	FWKzN2As31bSm2sx9Vs1Wd1UVbeWkySW6Ayh044Db+c3zG7CozQAJBJvuEgYuHSnfAJsg9nw2pPQD
	yoQhJDMMtbl8Cjzit/GjVDeQXF/C6YarwVnywO+Tb7ZyfHizuNk4aRu6QVt5HcqpjsgwNimxma/OC
	K8ImYiZ9gaWqNeEFan9tTHXzo2OG5dLbqEyB7Cf7blL4dnrxYQjHwMI7uSZDm6PZsW1+o1lz0VAfR
	I1bXiXvzacHnEr/2ao+Iww2JBEyLSWDd0rNoeDkPIOZ2G9EiCkPqe6zAxmz9BIk00dw0+OfBTnGdQ
	Ne4bnK2A==;
Received: from [187.36.213.55] (helo=[192.168.1.103])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t7hjH-001KBv-0u; Sun, 03 Nov 2024 22:01:48 +0100
Message-ID: <fe4056fd-6bb5-435f-aef3-176e301824ef@igalia.com>
Date: Sun, 3 Nov 2024 18:01:38 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/v3d: Add DRM_IOCTL_V3D_PERFMON_SET_GLOBAL
To: Christian Gmeiner <christian.gmeiner@gmail.com>,
 Melissa Wen <mwen@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, Christian Gmeiner <cgmeiner@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241031205140.541907-1-christian.gmeiner@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20241031205140.541907-1-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christian,

On 31/10/24 17:51, Christian Gmeiner wrote:
> From: Christian Gmeiner <cgmeiner@igalia.com>
> 
> Add a new ioctl, DRM_IOCTL_V3D_PERFMON_SET_GLOBAL, to allow
> configuration of a global performance monitor (perfmon).
> Use the global perfmon for all jobs to ensure consistent
> performance tracking across submissions.
> 
> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
> 
> ---
> Changes in v2:
> - Reworked commit message.
> - Removed num_perfmon counter for tracking perfmon allocations.
> - Allowing allocation of perfmons when the global perfmon is active.
> - Return -EAGAIN for submissions with a per job perfmon if the global perfmon is active.
> ---
>   drivers/gpu/drm/v3d/v3d_drv.c     |  1 +
>   drivers/gpu/drm/v3d/v3d_drv.h     |  8 ++++++++
>   drivers/gpu/drm/v3d/v3d_perfmon.c | 34 +++++++++++++++++++++++++++++++
>   drivers/gpu/drm/v3d/v3d_sched.c   | 14 ++++++++++---
>   drivers/gpu/drm/v3d/v3d_submit.c  | 10 +++++++++
>   include/uapi/drm/v3d_drm.h        | 15 ++++++++++++++
>   6 files changed, 79 insertions(+), 3 deletions(-)
> 

[...]

> diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
> index 156be13ab2ef..bf42303c292b 100644
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
> @@ -451,3 +454,34 @@ int v3d_perfmon_get_counter_ioctl(struct drm_device *dev, void *data,
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

I'm reading the userspace code now and I think you need to call
`v3d_perfmon_stop` here to make sure that the active perfmon is no
longer the global perfmon.

Best Regards,
- Maíra

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
> index 08d2a2739582..38690740f593 100644
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
> index 87fc5bb0a61e..709724fe28e6 100644
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
> +/*
> + * struct drm_v3d_perfmon_set_global - ioctl to define a
> + * global performance counter that is used if a job has
> + * not assigned one on its own.
> + */
> +struct drm_v3d_perfmon_set_global {
> +	__u32 flags;
> +	__u32 id;
> +};
> +
>   #if defined(__cplusplus)
>   }
>   #endif


