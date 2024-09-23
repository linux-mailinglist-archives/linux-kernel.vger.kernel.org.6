Return-Path: <linux-kernel+bounces-335686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A170597E916
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5807D281982
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A11194A7C;
	Mon, 23 Sep 2024 09:51:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F4A8479
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727085114; cv=none; b=dHlWIaTH5nzjBfcgpOUKG5C4C0Cz1dl8WZ/RWFSgtTRVXbmNfzDRzgEtgcZr28c7ofOBAdhD3J6r1gGwjjk8uILccO/meRVzq79cJdSg16+6s6sgVooKpvLd7LaQh9OHDijgChX7TgPwSkvoTO/QY9oiXXwjwYCRx+O+pbVyLyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727085114; c=relaxed/simple;
	bh=Rr/xW5dRuasZnCpXbaMdA/oXrqPt/xkDnG+ySkx36OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPP5z+C12YKjXiIJf9VIW0eIiQIDGYNjBNqNyFvSUDe5dF/3tLxj5SgpMwDZpT0gmZrPV/MFm99fPXz07KHIEVZb0uitqSTowD8JTRKQWn/2ph/KdJ7xE+MsXDTEq9+NvfETingVVSknqauqWYk1okJSMMEceqMKzW4Z9eTPFqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5338EFEC;
	Mon, 23 Sep 2024 02:52:21 -0700 (PDT)
Received: from [10.57.79.18] (unknown [10.57.79.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FED43F71A;
	Mon, 23 Sep 2024 02:51:49 -0700 (PDT)
Message-ID: <e39f64ee-077e-4e0e-87f5-fb03e765380e@arm.com>
Date: Mon, 23 Sep 2024 10:51:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/panthor: Expose scheduler groups info in debugfs
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
 <20240918085056.24422-4-mary.guillemard@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20240918085056.24422-4-mary.guillemard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/09/2024 09:50, Mary Guillemard wrote:
> This adds a new debugfs file named "sched_groups" allowing a user to
> query information about all userspace clients scheduler groups.
> 
> As we uses drm_device.filelist to achieve it, we also expose the
> client_id with the task information to differentiate one client
> from another inside the same task.
> 
> Signed-off-by: Mary Guillemard <mary.guillemard@collabora.com>

Can you explain a bit more why you want this? I'm not against the idea
but I'm wary of adding 'debugging features' because often they fall into
one of two camps:

 * Genuinely useful features that shouldn't be in debugfs because people
want a stable API.

 * Niche features that take maintainance effort despite not being
particularly useful.

> ---
>  drivers/gpu/drm/panthor/panthor_drv.c   |   1 +
>  drivers/gpu/drm/panthor/panthor_sched.c | 127 ++++++++++++++++++++++++
>  drivers/gpu/drm/panthor/panthor_sched.h |   4 +
>  3 files changed, 132 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 0d825d63d712..aa390597d355 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1450,6 +1450,7 @@ static const struct file_operations panthor_drm_driver_fops = {
>  static void panthor_debugfs_init(struct drm_minor *minor)
>  {
>  	panthor_mmu_debugfs_init(minor);
> +	panthor_sched_debugfs_init(minor);
>  }
>  #endif
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index f15abeef4ece..0c1ddbfbe164 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0 or MIT
>  /* Copyright 2023 Collabora ltd. */
>  
> +#include <drm/drm_debugfs.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_exec.h>
>  #include <drm/drm_gem_shmem_helper.h>
> @@ -3581,3 +3582,129 @@ int panthor_sched_init(struct panthor_device *ptdev)
>  	ptdev->scheduler = sched;
>  	return 0;
>  }
> +
> +#ifdef CONFIG_DEBUG_FS
> +static const char *panthor_csg_priority_names[PANTHOR_CSG_PRIORITY_COUNT] = {
> +	"LOW",
> +	"MEDIUM",
> +	"HIGH",
> +	"REALTIME"
> +};
> +
> +static const char *panthor_group_state_names[PANTHOR_CS_GROUP_UNKNOWN_STATE] = {
> +	"CREATED",
> +	"ACTIVE",
> +	"SUSPENDED",
> +	"TERMINATED"
> +};
> +
> +static void show_panthor_queue(const struct panthor_queue *queue,
> +			       u32 queue_index,
> +			       struct seq_file *m)
> +{
> +	seq_printf(m, "queue %u:", queue_index);
> +	seq_printf(m, " priority %u", queue->priority);
> +	seq_printf(m, " doorbell_id %d", queue->doorbell_id);
> +	seq_puts(m, "\n");
> +}
> +
> +static void show_panthor_group(struct panthor_group *group,
> +			       u32 group_handle,
> +			       struct seq_file *m)
> +{
> +	u32 i;
> +
> +	group_get(group);

This looks wrong - this function relies on group not becoming invalid
before the call, so we'd better be holding a sufficient lock/reference
on the group before show_panthor_group() is called otherwise we've got a
race before the group_get() call.

Although I can see this bug is present elsewhere in panthor_sched.c now
I look...

> +
> +	seq_printf(m, "group %u:", group_handle);
> +	seq_printf(m, " priority %s", group->priority < PANTHOR_CSG_PRIORITY_COUNT ?
> +		   panthor_csg_priority_names[group->priority] : "UNKNOWN");
> +	seq_printf(m, " state %s", group->state < PANTHOR_CS_GROUP_UNKNOWN_STATE ?
> +		   panthor_group_state_names[group->state] : "UNKNOWN");
> +	seq_printf(m, " csg_id %d", group->csg_id);
> +	seq_printf(m, " csg_priority %d", group->csg_priority);
> +	seq_printf(m, " compute_core_mask 0x%016llx", group->compute_core_mask);
> +	seq_printf(m, " fragment_core_mask 0x%016llx", group->fragment_core_mask);
> +	seq_printf(m, " tiler_core_mask 0x%016llx", group->tiler_core_mask);
> +	seq_printf(m, " max_compute_cores %d", group->max_compute_cores);
> +	seq_printf(m, " max_fragment_cores %d", group->max_fragment_cores);
> +	seq_printf(m, " max_tiler_cores %d", group->max_tiler_cores);
> +	seq_puts(m, "\n");
> +
> +	for (i = 0; i < group->queue_count; i++)
> +		show_panthor_queue(group->queues[i], i, m);
> +
> +	group_put(group);
> +}
> +
> +static int show_file_group_pool(const struct panthor_file *pfile, struct seq_file *m)
> +{
> +	struct panthor_group_pool *gpool = pfile->groups;
> +	struct panthor_group *group;
> +	unsigned long i;
> +
> +	if (IS_ERR_OR_NULL(gpool))
> +		return 0;
> +
> +	xa_for_each(&gpool->xa, i, group)
> +		show_panthor_group(group, i, m);

Here I see no protection against a racing call to PANTHOR_GROUP_DESTROY,
so group could become invalid between xa_for_each returning it and the
call to show_panthor_group().

Steve

> +
> +	return 0;
> +}
> +
> +static int show_each_file(struct seq_file *m, void *arg)
> +{
> +	struct drm_info_node *node = (struct drm_info_node *)m->private;
> +	struct drm_device *ddev = node->minor->dev;
> +	int (*show)(const struct panthor_file *, struct seq_file *) = node->info_ent->data;
> +	struct drm_file *file;
> +	int ret;
> +
> +	ret = mutex_lock_interruptible(&ddev->filelist_mutex);
> +	if (ret)
> +		return ret;
> +
> +	list_for_each_entry(file, &ddev->filelist, lhead) {
> +		struct task_struct *task;
> +		struct panthor_file *pfile = file->driver_priv;
> +		struct pid *pid;
> +
> +		/*
> +		 * Although we have a valid reference on file->pid, that does
> +		 * not guarantee that the task_struct who called get_pid() is
> +		 * still alive (e.g. get_pid(current) => fork() => exit()).
> +		 * Therefore, we need to protect this ->comm access using RCU.
> +		 */
> +		rcu_read_lock();
> +		pid = rcu_dereference(file->pid);
> +		task = pid_task(pid, PIDTYPE_TGID);
> +		seq_printf(m, "client_id %8llu pid %8d command %s:\n", file->client_id,
> +			   pid_nr(pid), task ? task->comm : "<unknown>");
> +		rcu_read_unlock();
> +
> +		ret = show(pfile, m);
> +		if (ret < 0)
> +			break;
> +
> +		seq_puts(m, "\n");
> +	}
> +
> +	mutex_unlock(&ddev->filelist_mutex);
> +	return ret;
> +}
> +
> +static struct drm_info_list panthor_sched_debugfs_list[] = {
> +	{ "sched_groups", show_each_file, 0, show_file_group_pool },
> +};
> +
> +/**
> + * panthor_sched_debugfs_init() - Initialize scheduler debugfs entries
> + * @minor: Minor.
> + */
> +void panthor_sched_debugfs_init(struct drm_minor *minor)
> +{
> +	drm_debugfs_create_files(panthor_sched_debugfs_list,
> +				 ARRAY_SIZE(panthor_sched_debugfs_list),
> +				 minor->debugfs_root, minor);
> +}
> +#endif /* CONFIG_DEBUG_FS */
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.h b/drivers/gpu/drm/panthor/panthor_sched.h
> index 3a30d2328b30..577239aa66bf 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.h
> +++ b/drivers/gpu/drm/panthor/panthor_sched.h
> @@ -47,4 +47,8 @@ void panthor_sched_resume(struct panthor_device *ptdev);
>  void panthor_sched_report_mmu_fault(struct panthor_device *ptdev);
>  void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events);
>  
> +#ifdef CONFIG_DEBUG_FS
> +void panthor_sched_debugfs_init(struct drm_minor *minor);
> +#endif
> +
>  #endif


