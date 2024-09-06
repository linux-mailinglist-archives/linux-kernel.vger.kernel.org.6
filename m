Return-Path: <linux-kernel+bounces-318197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B8296E9CB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0ECEB23099
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F2213C8F0;
	Fri,  6 Sep 2024 06:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PeBgyloQ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175E73B1A2
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 06:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725603158; cv=none; b=et5SslFYG8tsIxOSWPYHt695r+NLEcQhI70zXcgVLKRylkH2vQJIWLrcKaiX+nUI3JUCDlG0M1L8Vw+F1OLDuXixRueWL8hyYRe7qsTFJef8VJFIGL2gvLQQpBABybB0P9CPl4SUXUlt7TuRqWC/ZbYipr0ki1ILgutkw44LpA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725603158; c=relaxed/simple;
	bh=UO6g/Ji12/elGfRu9ibvIc94caMDiFjVz4JJvAVD5ww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/F0vtdZHnPlpwN0o8aKpYLAefTun5HQfEDwEiH+fruGLX6SVy0lcOiiaAXi9pE8j22uRHnb0+yxiF2f5DWRlBNTW5dhhXwu3dwNjE+Kk9ZQ4wr2SOZd0tUabnJWbqPwThPciNmRDPSuiXqC/fTTSX59ipo6z7J2/miXPeWWkSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PeBgyloQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725603153;
	bh=UO6g/Ji12/elGfRu9ibvIc94caMDiFjVz4JJvAVD5ww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PeBgyloQf+iOZduma14RhPQXlURwqT5Ja6ymAKQnuUDH8ts92Fio0hw3LM+hnZT9h
	 gF2sAcX4kCqe/2D1UcmZroZva5wESi4Vrmai/51/3z/ugCYMXPFWxfzbvvmEJVPLHb
	 IjH+OCmMKJ3AeN+MAlvGaqX+Ey+Y/eTDY3BIv4pDm/WbVEAngWyyO1IzGrNQDz3a52
	 HQ5SMzBD/zwbxIvK6qZntwjEukKMMQQjmIVXpKO1jUn1vfx+sTxpnrvU+lxe/GbNIg
	 IxkKOIhZcSTDG+bB2LLujdMDO49sSgSe6D5UlwN2/VSxmWDE/wja/dPg6HHIt69XMF
	 1pN7MSVc9ZeAA==
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6D7AA17E0F87;
	Fri,  6 Sep 2024 08:12:33 +0200 (CEST)
Date: Fri, 6 Sep 2024 08:12:29 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Mary Guillemard <mary.guillemard@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Christopher Healy <healych@amazon.com>, kernel@collabora.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 2/2] drm/panthor: Add DEV_QUERY_GROUP_PRIORITIES_INFO
 dev query
Message-ID: <20240906081229.776899b7@collabora.com>
In-Reply-To: <20240905173222.252641-4-mary.guillemard@collabora.com>
References: <20240905173222.252641-2-mary.guillemard@collabora.com>
	<20240905173222.252641-4-mary.guillemard@collabora.com>
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

On Thu,  5 Sep 2024 19:32:23 +0200
Mary Guillemard <mary.guillemard@collabora.com> wrote:

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

nit: we have a BIT() macro for that ;-). Other than that, it looks good
to me.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

