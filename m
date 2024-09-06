Return-Path: <linux-kernel+bounces-318669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD7696F16F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D14BB268A3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029321D1F62;
	Fri,  6 Sep 2024 10:22:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FA71D174E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618159; cv=none; b=ATt/mnEhvYkngfdMP67qvfceRYy0/IDAl2PPNu2XAKQlqbZEnF2JTl1/YTtiynMuJSliHn5RS6Ug3O/fp2TQ99hOU8FqNVs5Cchi6v079m2F4T+DeZ0UjjgzDyhhYiZCJGc4Jzl6wEGn1CE/DLNhlqF4t5+bwqorOBM0FC3iTk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618159; c=relaxed/simple;
	bh=IHmOeR0Pr/t6zbYBG/EsN+tiugC4dmPA5rKEKXszId0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+aVMZWR+vWxE5zu3aX8c24hX48nKuaRkViWNfJbxgfOqBwtZn++WPIaiI4sSC2fok9sv38RkoiO0E3/768k0lVjfHnYndEGxWCnQrXjckDBVgMP9aYj65FifhsgUzkAp4G8z49BSEAEFAg25KEkD+2c3IVt8twQvnBsjJtQMrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53BA4FEC;
	Fri,  6 Sep 2024 03:23:03 -0700 (PDT)
Received: from [10.1.36.22] (e122027.cambridge.arm.com [10.1.36.22])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25A653F73F;
	Fri,  6 Sep 2024 03:22:34 -0700 (PDT)
Message-ID: <b6f822aa-c985-4195-9508-3df67959b662@arm.com>
Date: Fri, 6 Sep 2024 11:22:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/panthor: Add DEV_QUERY_GROUP_PRIORITIES_INFO
 dev query
To: Mary Guillemard <mary.guillemard@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Christopher Healy <healych@amazon.com>, kernel@collabora.com,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20240905173222.252641-2-mary.guillemard@collabora.com>
 <20240905173222.252641-4-mary.guillemard@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20240905173222.252641-4-mary.guillemard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/09/2024 18:32, Mary Guillemard wrote:
> Expose allowed group priorities with a new device query.
> 
> This new uAPI will be used in Mesa to properly report what priorities a
> user can use for EGL_IMG_context_priority.
> 
> Since this extends the uAPI and because userland needs a way to
> advertise priorities accordingly, this also bumps the driver minor
> version.
> 
> v2:
> - Remove drm_panthor_group_allow_priority_flags definition
> - Document that allowed_mask is a bitmask of drm_panthor_group_priority
> 
> Signed-off-by: Mary Guillemard <mary.guillemard@collabora.com>

With Boris' BIT() macro change:

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks,
Steve

> ---
>  drivers/gpu/drm/panthor/panthor_drv.c | 61 ++++++++++++++++++---------
>  include/uapi/drm/panthor_drm.h        | 22 ++++++++++
>  2 files changed, 64 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 7b1db2adcb4c..f85aa2d99f09 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -170,6 +170,7 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_gpu_info, tiler_present), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_csif_info, pad), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_timestamp_info, current_timestamp), \
> +		 PANTHOR_UOBJ_DECL(struct drm_panthor_group_priorities_info, pad), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_sync_op, timeline_value), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_submit, syncs), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_create, ringbuf_size), \
> @@ -777,11 +778,41 @@ static int panthor_query_timestamp_info(struct panthor_device *ptdev,
>  	return 0;
>  }
>  
> +static int group_priority_permit(struct drm_file *file,
> +				 u8 priority)
> +{
> +	/* Ensure that priority is valid */
> +	if (priority > PANTHOR_GROUP_PRIORITY_REALTIME)
> +		return -EINVAL;
> +
> +	/* Medium priority and below are always allowed */
> +	if (priority <= PANTHOR_GROUP_PRIORITY_MEDIUM)
> +		return 0;
> +
> +	/* Higher priorities require CAP_SYS_NICE or DRM_MASTER */
> +	if (capable(CAP_SYS_NICE) || drm_is_current_master(file))
> +		return 0;
> +
> +	return -EACCES;
> +}
> +
> +static void panthor_query_group_priorities_info(struct drm_file *file,
> +						struct drm_panthor_group_priorities_info *arg)
> +{
> +	int prio;
> +
> +	for (prio = PANTHOR_GROUP_PRIORITY_REALTIME; prio >= 0; prio--) {
> +		if (!group_priority_permit(file, prio))
> +			arg->allowed_mask |= 1 << prio;
> +	}
> +}
> +
>  static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct drm_file *file)
>  {
>  	struct panthor_device *ptdev = container_of(ddev, struct panthor_device, base);
>  	struct drm_panthor_dev_query *args = data;
>  	struct drm_panthor_timestamp_info timestamp_info;
> +	struct drm_panthor_group_priorities_info priorities_info;
>  	int ret;
>  
>  	if (!args->pointer) {
> @@ -798,6 +829,10 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
>  			args->size = sizeof(timestamp_info);
>  			return 0;
>  
> +		case DRM_PANTHOR_DEV_QUERY_GROUP_PRIORITIES_INFO:
> +			args->size = sizeof(priorities_info);
> +			return 0;
> +
>  		default:
>  			return -EINVAL;
>  		}
> @@ -818,6 +853,10 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
>  
>  		return PANTHOR_UOBJ_SET(args->pointer, args->size, timestamp_info);
>  
> +	case DRM_PANTHOR_DEV_QUERY_GROUP_PRIORITIES_INFO:
> +		panthor_query_group_priorities_info(file, &priorities_info);
> +		return PANTHOR_UOBJ_SET(args->pointer, args->size, priorities_info);
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1037,24 +1076,6 @@ static int panthor_ioctl_group_destroy(struct drm_device *ddev, void *data,
>  	return panthor_group_destroy(pfile, args->group_handle);
>  }
>  
> -static int group_priority_permit(struct drm_file *file,
> -				 u8 priority)
> -{
> -	/* Ensure that priority is valid */
> -	if (priority > PANTHOR_GROUP_PRIORITY_REALTIME)
> -		return -EINVAL;
> -
> -	/* Medium priority and below are always allowed */
> -	if (priority <= PANTHOR_GROUP_PRIORITY_MEDIUM)
> -		return 0;
> -
> -	/* Higher priorities require CAP_SYS_NICE or DRM_MASTER */
> -	if (capable(CAP_SYS_NICE) || drm_is_current_master(file))
> -		return 0;
> -
> -	return -EACCES;
> -}
> -
>  static int panthor_ioctl_group_create(struct drm_device *ddev, void *data,
>  				      struct drm_file *file)
>  {
> @@ -1436,6 +1457,8 @@ static void panthor_debugfs_init(struct drm_minor *minor)
>   * PanCSF driver version:
>   * - 1.0 - initial interface
>   * - 1.1 - adds DEV_QUERY_TIMESTAMP_INFO query
> + * - 1.2 - adds DEV_QUERY_GROUP_PRIORITIES_INFO query
> + *       - adds PANTHOR_GROUP_PRIORITY_REALTIME priority
>   */
>  static const struct drm_driver panthor_drm_driver = {
>  	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
> @@ -1449,7 +1472,7 @@ static const struct drm_driver panthor_drm_driver = {
>  	.desc = "Panthor DRM driver",
>  	.date = "20230801",
>  	.major = 1,
> -	.minor = 1,
> +	.minor = 2,
>  
>  	.gem_create_object = panthor_gem_create_object,
>  	.gem_prime_import_sg_table = drm_gem_shmem_prime_import_sg_table,
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> index 011a555e4674..87c9cb555dd1 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -263,6 +263,11 @@ enum drm_panthor_dev_query_type {
>  
>  	/** @DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO: Query timestamp information. */
>  	DRM_PANTHOR_DEV_QUERY_TIMESTAMP_INFO,
> +
> +	/**
> +	 * @DRM_PANTHOR_DEV_QUERY_GROUP_PRIORITIES_INFO: Query allowed group priorities information.
> +	 */
> +	DRM_PANTHOR_DEV_QUERY_GROUP_PRIORITIES_INFO,
>  };
>  
>  /**
> @@ -399,6 +404,23 @@ struct drm_panthor_timestamp_info {
>  	__u64 timestamp_offset;
>  };
>  
> +/**
> + * struct drm_panthor_group_priorities_info - Group priorities information
> + *
> + * Structure grouping all queryable information relating to the allowed group priorities.
> + */
> +struct drm_panthor_group_priorities_info {
> +	/**
> +	 * @allowed_mask: Bitmask of the allowed group priorities.
> +	 *
> +	 * Each bit represents a variant of the enum drm_panthor_group_priority.
> +	 */
> +	__u8 allowed_mask;
> +
> +	/** @pad: Padding fields, MBZ. */
> +	__u8 pad[3];
> +};
> +
>  /**
>   * struct drm_panthor_dev_query - Arguments passed to DRM_PANTHOR_IOCTL_DEV_QUERY
>   */


