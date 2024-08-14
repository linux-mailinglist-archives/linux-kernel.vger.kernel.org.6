Return-Path: <linux-kernel+bounces-286529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42F7951C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0A6282722
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB781B1439;
	Wed, 14 Aug 2024 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=boris.brezillon@collabora.com header.b="a6Ho/yhd"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F651AED35
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723643102; cv=pass; b=u+GUfnbyPjez/gyx/Kr2X5GhinV7PrT+gALgXF/at+HrTGhXFf1Y34G6A1O18ZsMjHjvOJUnYKYCB4GjHIsMLEQRbIZpRWTuoJe4ygCdKXHYH54LqVQM30yXLP3+lJxFXbWpFeZ6ncjJ5DYfGGwfJAnMe7PuweMHm+bwrXwYo44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723643102; c=relaxed/simple;
	bh=pHr85yLbyKcYq8Y1BeGD7wfOGODs0t1A6DiCaYGnpVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mWLSmkQiDv2T6rMVOpAesYhZmBTLbRoyDRgjxmDjpBbRV4yUadY1hRZeWWix7dfjJ48ZdOvFa45FkK9YpGSHU8f4/KGxzcRLZkXXwaFkIyghX/VMIP6RFt3aaBNFlV4SP7B5kTTq+1KipXrsdTNYMvCnowIPixjKAs/oAze6gvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=boris.brezillon@collabora.com header.b=a6Ho/yhd; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: daniel.almeida@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723643096; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jDDeaNNHMNtC4svoXI21jmNenjuJH9t0jfeUDjWi6MAIpCtJXIA+AGd/Qyo82nfoUZE1n+/NPt2fzF8+OQtOIXogoFZfSUexWX5W1w652P2UlUE5HIqSUTFexGfOFPzOUKvPDJPsWIq+2by3PJft4V8u9p/oMSz3WJXbeLfdV9I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723643096; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Yv3YJj9xpDs+4plaIXWsVWhKCVuD+2ctQBFR8T5tnFE=; 
	b=nX3JLK2VjVn8zRh6zzepv1ggSBnX1UzM6y0OSMIFSEvQOt0ktJZ2Hs/nz3uVPT2LX8Tmfsuy90jRuRGd4Nqt9UyhycuTIf3LOo42xk0zju64cijR3mp2hGYs6J1f3jnZ9Zyzr99AfpDPo+eJtfXusnCriWlMcMKWcgqn2kr7SYA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=boris.brezillon@collabora.com;
	dmarc=pass header.from=<boris.brezillon@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723643096;
	s=zohomail; d=collabora.com; i=boris.brezillon@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Yv3YJj9xpDs+4plaIXWsVWhKCVuD+2ctQBFR8T5tnFE=;
	b=a6Ho/yhdVJrmES/uCJCY0l7GR5/d33RDLtedI3p/bXPUjdXk6wHlzq9HGfP3Acrc
	kMRedcKkWCf5+BttALWVKUTtVCeac2tQbGf7vH3XHBbbogllnWq8d2/dQjxmixiqBHx
	gi+TKjdBsIKqrnrglzpW9Y8ClePp4pWhvzd5IKsU=
Received: by mx.zohomail.com with SMTPS id 1723643095113529.3763409592676;
	Wed, 14 Aug 2024 06:44:55 -0700 (PDT)
Date: Wed, 14 Aug 2024 15:44:47 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: liviu.dudau@arm.com, steven.price@arm.com, carsten.haitzler@arm.com,
 robh@kernel.org, faith.ekstrand@collabora.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] drm: panthor: expose some fw information through
 the query ioctl
Message-ID: <20240814153753.58e96597@collabora.com>
In-Reply-To: <20240813210555.607641-3-daniel.almeida@collabora.com>
References: <20240710225011.275153-1-daniel.almeida@collabora.com>
 <20240813210555.607641-1-daniel.almeida@collabora.com>
 <20240813210555.607641-3-daniel.almeida@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On Tue, 13 Aug 2024 18:05:44 -0300
Daniel Almeida <daniel.almeida@collabora.com> wrote:

> This is of interest to userspace, and similar in nature to the GPU
> and CSIF information we already return in the query ioctl.
> 
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
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

nit: I think we shouldn't restrict to global interface information if
we see something in the group/queue that's worth exposing (number of
streams/queues per group, group features, ...), so I would suggest being
less specific in here:

    Structure grouping all queryable information relating to the FW.


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


