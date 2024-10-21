Return-Path: <linux-kernel+bounces-375134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B14F89A9165
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 22:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B36281D54
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451D21FDFB1;
	Mon, 21 Oct 2024 20:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PildYvcD"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92149450FE
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 20:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543361; cv=none; b=dtdEH1hCk7wvN0DEFGEB9th4JoCRTZPsPRDQYeHIzIyI6zIC/WRSA8z2C5dsf6aq8JgVEuI3MPEA4FP/nMFsy4BfsxfkJcPDa5d+2jsi3NEDqttJlx2kpF1oz0YNxIKTOdccABJdWOeiNv2N/dhiTRRZZbaZ+vHdoQEucU9SiH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543361; c=relaxed/simple;
	bh=FlfHFEpiKl/eo/M1G5qu9CJxMH3eIsBpsh0CyCZc33k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=db3aftVCL71Js94HuQFZp7+ImYJCf1HtGyBuHycxeXda+FsCUfd/CTAMMcEIFYtreuepybt539UqfjqBdUlyyL/lA9IfrOAeHsA+LrjkVs+MDIpFzQ+s523EAPkXImXvMAL0u83t1E24U/9TwgpH0/5USvojnb6kDjj59I7bzOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PildYvcD; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OjpDPjobq3y3KgLgLuumT/YAePFr6I2rjrFt7+aP6Fw=; b=PildYvcD47PKbUkSvAgI3UHfMW
	nOH3qr2+yTBQA/n5jM5P7HwTLlxGPhmK0xnAI4k03VGk14+Hz2ZXLtylqcQeCbPy3A+5FdUHQ4Ez/
	7sqjPpcTpAd8zzvRhqaYONz2/ya6fxji0DOwi774WEyuCKoJApSZwE95jzWFD3jbrW1LGeQTnmFeb
	yGn1YOzILh/eljXA8upgHKRXck8AyTowImkcSf3oXdHYpOYU22U2p6hTVRbKVeyWxeoLui7VwBT1v
	vhfN0l5gmD0UIF39kVc8piepW4BVSKwFbZj1QtpOUKAXEye0Igm9hbqCYR2sO2cUc4RL1FTVS46Gh
	u/u32dBA==;
Received: from [191.204.195.205] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t2zEM-00DIQq-9y; Mon, 21 Oct 2024 22:42:22 +0200
Message-ID: <c6899aa3-84cc-4288-866d-533dcb478b4c@igalia.com>
Date: Mon, 21 Oct 2024 17:42:16 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/v3d: Add DRM_IOCTL_V3D_PERFMON_SET_GLOBAL
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Melissa Wen <mwen@igalia.com>, David Airlie <airlied@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Christian Gmeiner <cgmeiner@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>
References: <20241020204156.113853-1-christian.gmeiner@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20241020204156.113853-1-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Christian!

Em 20/10/2024 17:41, Christian Gmeiner escreveu:
> From: Christian Gmeiner <cgmeiner@igalia.com>
> 
> This patch adds a new ioctl, DRM_IOCTL_V3D_PERFMON_SET_GLOBAL, which
> allows the configuration of a global performance monitor (perfmon).
> The global perfmon is used for all jobs, ensuring consistent performance
> tracking across submissions.

Usually we write in the imperative form:

Add a new ioctl, ...

> 
> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
> ---
>   drivers/gpu/drm/v3d/v3d_drv.c                 |  3 ++
>   drivers/gpu/drm/v3d/v3d_drv.h                 | 10 ++++
>   drivers/gpu/drm/v3d/v3d_perfmon.c             | 49 +++++++++++++++++++
>   .../gpu/drm/v3d/v3d_performance_counters.h    |  6 +++
>   drivers/gpu/drm/v3d/v3d_sched.c               | 10 +++-
>   include/uapi/drm/v3d_drm.h                    | 15 ++++++
>   6 files changed, 91 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
> index d7ff1f5fa481..f1753ee2af25 100644
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
> @@ -350,6 +351,8 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto drm_unregister;
>   
> +	atomic_set(&v3d->num_perfmon, 0);
> +
>   	return 0;
>   
>   drm_unregister:
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
> index cf4b23369dc4..9491d730d99f 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.h
> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> @@ -61,6 +61,8 @@ struct v3d_queue_state {
>   	struct v3d_stats stats;
>   };
>   
> +struct v3d_dev;
> +

Forward declarations go in the beginning of the file, along with the 
other ones:

struct clk;
struct platform_device;
struct reset_control;
+struct v3d_dev;

>   /* Performance monitor object. The perform lifetime is controlled by userspace
>    * using perfmon related ioctls. A perfmon can be attached to a submit_cl
>    * request, and when this is the case, HW perf counters will be activated just
> @@ -68,6 +70,9 @@ struct v3d_queue_state {
>    * done. This way, only events related to a specific job will be counted.
>    */
>   struct v3d_perfmon {
> +	/* Pointer back to v3d instance this perfmon belongs. */
> +	struct v3d_dev *v3d;
> +
>   	/* Tracks the number of users of the perfmon, when this counter reaches
>   	 * zero the perfmon is destroyed.
>   	 */
> @@ -179,6 +184,9 @@ struct v3d_dev {
>   		u32 num_allocated;
>   		u32 pages_allocated;
>   	} bo_stats;
> +
> +	/* Keep track of current number of allocated perfmons. */
> +	atomic_t num_perfmon;
>   };
>   
>   static inline struct v3d_dev *
> @@ -584,6 +592,8 @@ int v3d_perfmon_get_values_ioctl(struct drm_device *dev, void *data,
>   				 struct drm_file *file_priv);
>   int v3d_perfmon_get_counter_ioctl(struct drm_device *dev, void *data,
>   				  struct drm_file *file_priv);
> +int v3d_perfmon_set_global_ioctl(struct drm_device *dev, void *data,
> +				 struct drm_file *file_priv);
>   
>   /* v3d_sysfs.c */
>   int v3d_sysfs_init(struct device *dev);

[...]

> diff --git a/include/uapi/drm/v3d_drm.h b/include/uapi/drm/v3d_drm.h
> index 87fc5bb0a61e..960d392d75a3 100644
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
> +/**

Using /** means that you are writting a kernel-doc comment [1], so make 
sure to describe each struct member, otherwise it's going to generate 
build warnings with W=1.

> + * struct drm_v3d_perfmon_set_global - ioctl to define a
> + * global performance counter that is used if a job has
> + * not assigned one on its own.
> + */
> +
> +#define DRM_V3D_PERFMON_CLEAR_GLOBAL    0x0001

I would keep this define above the struct comment.

> +struct drm_v3d_perfmon_set_global {
> +	__u32 flags;
> +	__u32 id;
> +};
> +
>   #if defined(__cplusplus)
>   }
>   #endif

[1] https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html


