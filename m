Return-Path: <linux-kernel+bounces-335687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6926397E917
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9423B1C212CE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C8A195B1A;
	Mon, 23 Sep 2024 09:51:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4252F194C6E
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727085117; cv=none; b=M50pFs7ybOBxTtk6Ns+sYbcgofxdgWqOQD8Y7qLhTgacwTHj+gQ4JveUlKpsL5FPhKGxYKfzxmOtqvKyy0tZpB2y7pC8ANV66PP2fP4JKbX6LYF34BenIQ53S5Ny/2Yzte5e8ve8p0V20WbaKLRaysfCFvFbQjOBXQC1Bjl1mHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727085117; c=relaxed/simple;
	bh=HnqNEMgTDhC4A63PO7NQHNPzQIkRJIEvjLK5ysnUM8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhfeveM2cl271G6qA6IrFzYr8j6fChJVXc6VOqU+9cUkXH+bROw2y+dxANXdbFTgLWwVxiUAPRpGKalZcAc8kZbiYRGRRedldCwWqGsiLh85qHov9sup1SHcSyVlhYEp/Dfn1HjGxxWEkYLFruO1hIYeCCDABosykXMar08Z4bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32B90FEC;
	Mon, 23 Sep 2024 02:52:24 -0700 (PDT)
Received: from [10.57.79.18] (unknown [10.57.79.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4391E3F71A;
	Mon, 23 Sep 2024 02:51:52 -0700 (PDT)
Message-ID: <537f5ff6-deb7-404a-8159-e544e5701ff3@arm.com>
Date: Mon, 23 Sep 2024 10:51:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/panthor: Add csg_priority to panthor_group
To: Mary Guillemard <mary.guillemard@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Christopher Healy <healych@amazon.com>, kernel@collabora.com,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20240918085056.24422-2-mary.guillemard@collabora.com>
 <20240918085056.24422-3-mary.guillemard@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20240918085056.24422-3-mary.guillemard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/09/2024 09:50, Mary Guillemard wrote:
> Keep track of the csg priority in panthor_group when the group is
> scheduled/active.
> 
> This is useful to know the actual priority in use in the firmware
> group slot.
> 
> Signed-off-by: Mary Guillemard <mary.guillemard@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 86908ada7335..f15abeef4ece 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -574,6 +574,13 @@ struct panthor_group {
>  	 */
>  	int csg_id;
>  
> +	/**
> +	 * @csg_id: Priority of the FW group slot.

kerneldoc name is wrong: s/csg_id/csg_priority/

Otherwise this looks reasonable, but see my reply to the second patch.

Thanks,
Steve

> +	 *
> +	 * -1 when the group is not scheduled/active.
> +	 */
> +	int csg_priority;
> +
>  	/**
>  	 * @destroyed: True when the group has been destroyed.
>  	 *
> @@ -894,11 +901,12 @@ group_get(struct panthor_group *group)
>   * group_bind_locked() - Bind a group to a group slot
>   * @group: Group.
>   * @csg_id: Slot.
> + * @csg_priority: Priority of the slot.
>   *
>   * Return: 0 on success, a negative error code otherwise.
>   */
>  static int
> -group_bind_locked(struct panthor_group *group, u32 csg_id)
> +group_bind_locked(struct panthor_group *group, u32 csg_id, u32 csg_priority)
>  {
>  	struct panthor_device *ptdev = group->ptdev;
>  	struct panthor_csg_slot *csg_slot;
> @@ -917,6 +925,7 @@ group_bind_locked(struct panthor_group *group, u32 csg_id)
>  	csg_slot = &ptdev->scheduler->csg_slots[csg_id];
>  	group_get(group);
>  	group->csg_id = csg_id;
> +	group->csg_priority = csg_priority;
>  
>  	/* Dummy doorbell allocation: doorbell is assigned to the group and
>  	 * all queues use the same doorbell.
> @@ -956,6 +965,7 @@ group_unbind_locked(struct panthor_group *group)
>  	slot = &ptdev->scheduler->csg_slots[group->csg_id];
>  	panthor_vm_idle(group->vm);
>  	group->csg_id = -1;
> +	group->csg_priority = -1;
>  
>  	/* Tiler OOM events will be re-issued next time the group is scheduled. */
>  	atomic_set(&group->tiler_oom, 0);
> @@ -2193,8 +2203,9 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
>  
>  			csg_iface = panthor_fw_get_csg_iface(ptdev, csg_id);
>  			csg_slot = &sched->csg_slots[csg_id];
> -			group_bind_locked(group, csg_id);
> -			csg_slot_prog_locked(ptdev, csg_id, new_csg_prio--);
> +			group_bind_locked(group, csg_id, new_csg_prio);
> +			csg_slot_prog_locked(ptdev, csg_id, new_csg_prio);
> +			new_csg_prio--;
>  			csgs_upd_ctx_queue_reqs(ptdev, &upd_ctx, csg_id,
>  						group->state == PANTHOR_CS_GROUP_SUSPENDED ?
>  						CSG_STATE_RESUME : CSG_STATE_START,
> @@ -3111,6 +3122,7 @@ int panthor_group_create(struct panthor_file *pfile,
>  	kref_init(&group->refcount);
>  	group->state = PANTHOR_CS_GROUP_CREATED;
>  	group->csg_id = -1;
> +	group->csg_priority = -1;
>  
>  	group->ptdev = ptdev;
>  	group->max_compute_cores = group_args->max_compute_cores;


