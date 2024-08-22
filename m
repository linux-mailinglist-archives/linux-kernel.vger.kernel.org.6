Return-Path: <linux-kernel+bounces-297251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7C095B4F4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6CC2881EF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0CC1C9447;
	Thu, 22 Aug 2024 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="hpi+34wc"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CD617E00F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 12:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724329595; cv=pass; b=tNr/9Os2FHrKR2G6WAicyrGJhz2mILuUtj+9LViQ7b9svzpwCyd6O3WruDTQ+3f6yqZ1XKu/ZGMIxOvgGR7HVtRUrnGzMnNgpNYnM8fbZCS5oZns1YQx8rFazlnVKBJ25XL+Exe/ayLvlWvmCi+tRhIo1ItLfLWnSO4NR36khvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724329595; c=relaxed/simple;
	bh=6ZE+N434G5UYO8xiY/vnGYGgRSwa2DAbjDl6hXEAwEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApKetNEaHd5bjzsSRtCOKGUnyknGGHW+Nv5MBAtoB5GDFpxEw0YyxRrWVQ+zSyzKfF28I0n5K6JtU4ntzikPbjA+O/wyAwf+4exQLSjLNSZ8EulkvH9u+ROi12i3xN5KNcnhXJapET2I35BxLvm5NqHdrQ6turvoNRdfIClbATc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=hpi+34wc; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: daniel.almeida@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724329589; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=I1AOLA7JXHuh1V+BQT8hB8A9vbZA+FZmy5tzJpGQ3zjYdpNmlN6XcHVNDe5D3mDy7NKsLpFH0RrmwnjGDi1RKSbbvn8NqtAqVYzdZAxs38xjTkAAcXKOSxqDZdiEwdTcVvtKAcHmpTLdRm7ZdYWLZsbQm9xVyqobnyKct8r6BqM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724329589; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MBJdd8KyfyKJ1i4soeI5nN0YXryd/ZxIuVHZOT4Tu+M=; 
	b=DPIniZ5W2KKrxr7uZ9qBEyUR1sYPtmvkY8l0VbDETx7GynkKxX9t6uecq6jJtY/U8pFLRfM9FFJiKtyyZmppCxZYU4L+T6EpBYI9kYLNL6ELN8pXrBIQQt4A7BYjQOLwLSyojkyjVV3rxSh7GUaBzUWkFQLyTUeXfkN1KBGa46M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724329589;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=MBJdd8KyfyKJ1i4soeI5nN0YXryd/ZxIuVHZOT4Tu+M=;
	b=hpi+34wcukYlIqUvTS3DLafW2VEv7RHncaIf5BuoR00FhqiLsZJDuQ5WZGSff3se
	Xtrlfm3gV9aTT1nE5Qjwi2rBDIZyWdHCGkdxxwEiC2INQCZ6f6wcBf1ZC+CsHfHu6Qg
	PsTb6yys0c/FSAefYXdRta1H9i0AWrWUAHC6vSHw=
Received: by mx.zohomail.com with SMTPS id 1724329587572951.0995191883987;
	Thu, 22 Aug 2024 05:26:27 -0700 (PDT)
Date: Thu, 22 Aug 2024 13:26:24 +0100
From: Adrian Larumbe <adrian.larumbe@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: liviu.dudau@arm.com, steven.price@arm.com, carsten.haitzler@arm.com, 
	boris.brezillon@collabora.com, robh@kernel.org, faith.ekstrand@collabora.com, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 RESEND 1/5] drm: panthor: expose some fw information
 through the query ioctl
Message-ID: <474yoitdvq4xdplmm4qlnzcxkhdjo2mltswsdzvedeamz74pi5@tifdq7sgve3d>
References: <20240710225011.275153-1-daniel.almeida@collabora.com>
 <20240821143826.3720-1-daniel.almeida@collabora.com>
 <20240821143826.3720-2-daniel.almeida@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240821143826.3720-2-daniel.almeida@collabora.com>

> On 21.08.2024 11:37, Daniel Almeida wrote:
> This is of interest to userspace, and similar in nature to the GPU
> and CSIF information we already return in the query ioctl.
> 
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Reviewed-by: Adrian Larumbe <adrian.larumbe@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_device.h |  3 +++
>  drivers/gpu/drm/panthor/panthor_drv.c    |  8 ++++++++
>  drivers/gpu/drm/panthor/panthor_sched.c  |  5 +++++
>  include/uapi/drm/panthor_drm.h           | 19 +++++++++++++++++++
>  4 files changed, 35 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index e388c0472ba7..224c53dcfe6d 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -100,6 +100,9 @@ struct panthor_device {
>  	/** @csif_info: Command stream interface information. */
>  	struct drm_panthor_csif_info csif_info;
>  
> +	/** @fw_info: Firmware info for the global interface */
> +	struct drm_panthor_fw_info fw_info;
> +
>  	/** @gpu: GPU management data. */
>  	struct panthor_gpu *gpu;
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index b8a84f26b3ef..fb30e119d9bf 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -164,6 +164,7 @@ panthor_get_uobj_array(const struct drm_panthor_obj_array *in, u32 min_stride,
>  	_Generic(_obj_name, \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_gpu_info, tiler_present), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_csif_info, pad), \
> +		 PANTHOR_UOBJ_DECL(struct drm_panthor_fw_info, instr_features), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_sync_op, timeline_value), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_submit, syncs), \
>  		 PANTHOR_UOBJ_DECL(struct drm_panthor_queue_create, ringbuf_size), \
> @@ -765,6 +766,10 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
>  			args->size = sizeof(ptdev->csif_info);
>  			return 0;
>  
> +		case DRM_PANTHOR_DEV_QUERY_FW_INFO:
> +			args->size = sizeof(ptdev->fw_info);
> +			return 0;
> +
>  		default:
>  			return -EINVAL;
>  		}
> @@ -777,6 +782,9 @@ static int panthor_ioctl_dev_query(struct drm_device *ddev, void *data, struct d
>  	case DRM_PANTHOR_DEV_QUERY_CSIF_INFO:
>  		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->csif_info);
>  
> +	case DRM_PANTHOR_DEV_QUERY_FW_INFO:
> +		return PANTHOR_UOBJ_SET(args->pointer, args->size, ptdev->fw_info);
> +
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 79ffcbc41d78..e0ecc8bcfaae 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -3495,6 +3495,11 @@ int panthor_sched_init(struct panthor_device *ptdev)
>  	ptdev->csif_info.cs_slot_count = sched->cs_slot_count;
>  	ptdev->csif_info.scoreboard_slot_count = sched->sb_slot_count;
>  
> +	ptdev->fw_info.version = glb_iface->control->version;
> +	ptdev->fw_info.features = glb_iface->control->features;
> +	ptdev->fw_info.group_num = glb_iface->control->group_num;
> +	ptdev->fw_info.instr_features = glb_iface->control->instr_features;
> +
>  	sched->last_tick = 0;
>  	sched->resched_target = U64_MAX;
>  	sched->tick_period = msecs_to_jiffies(10);
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> index aaed8e12ad0b..e235cf452460 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -260,6 +260,9 @@ enum drm_panthor_dev_query_type {
>  
>  	/** @DRM_PANTHOR_DEV_QUERY_CSIF_INFO: Query command-stream interface information. */
>  	DRM_PANTHOR_DEV_QUERY_CSIF_INFO,
> +
> +	/** @DRM_PANTHOR_DEV_QUERY_FW_INFO: Query firmware information */
> +	DRM_PANTHOR_DEV_QUERY_FW_INFO,
>  };
>  
>  /**
> @@ -377,6 +380,22 @@ struct drm_panthor_csif_info {
>  	__u32 pad;
>  };
>  
> +/** struct drm_panthor_fw_info - FW information
> + *
> + * Structure grouping all queryable information relating to the global FW interface.
> + */
> +
> +struct drm_panthor_fw_info {
> +	/** @version: Global interface version */
> +	__u32 version;
> +	/** @features: Global interface features */
> +	__u32 features;
> +	/** @group_num: Number of CSG interfaces */
> +	__u32 group_num;
> +	/** @instr_features: Instrumentation features */
> +	__u32 instr_features;
> +};
> +
>  /**
>   * struct drm_panthor_dev_query - Arguments passed to DRM_PANTHOR_IOCTL_DEV_QUERY
>   */
> -- 
> 2.45.2

