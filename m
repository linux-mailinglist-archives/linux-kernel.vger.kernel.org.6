Return-Path: <linux-kernel+bounces-203472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A28B8FDBB8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A0428640F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D64415491;
	Thu,  6 Jun 2024 00:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4OZXTJG8"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703C7E567
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 00:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717635279; cv=none; b=Htb8BfIMxWFxNIgUxXym/VcY2Ql5eUFXRk8n383tG8c5gNenO1rd67wd1K5zyE4Vqvw+3d3+T5R6DUonBCO4f09hrNpzfEyxWfzGWwdF0CVC+2mJdKj6gfzq3s9U30jIVVEj/NC83WFc7zLiHYvZz12BL1oDcYqYTA7mDuX9Q+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717635279; c=relaxed/simple;
	bh=h4yIICZo18L59W4sFqllXduxAeJwBgRiZERL4Gid1Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0Q1gULHuPUPlGMnF4whEyJLU3zZINd8+sGbJbn4aRzkDwOhn/cWYj4CxAMTzXeArm2E3jGL+GBnjJ8Fk/XOkdPbagnfTFM0NXyR9+M6e2e0EUrws5mV5IwnroSHwK9Y5XHNsCKccAENMemI/CmttET++UR05W4Xyn5ZTItvWCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4OZXTJG8; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717635275;
	bh=h4yIICZo18L59W4sFqllXduxAeJwBgRiZERL4Gid1Ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=4OZXTJG8ZCfaw8BuBSyAAgG8Yu5yiKls4VeJLghWrV/rp2FjtO2KzUYmPlLXWN1ri
	 taZqke9KhbfvzbGfZ+DZ6SROWgl/FZremVJTfqvaFmjyHwdB7JWTLhNu+mW4/0EEJC
	 elLW+MKiREjKEwYfo8tEZpAfhoNCeAo9guDzLfGFdvs0sUGp1quAkQoY+eiJ3qCd1V
	 38u0c6ktwlNmDJO0Jr4d2YvH0gX3/Vd32ZcdaTbDKKtQ2SzA+8qHwLvWq6lGW2yUGQ
	 VvD3zAVeHYpv1oFl4U0IEhAir8UVeDLIHXxvzWo0RsOYlxV0F9DFYTvcxZUOAc9UvW
	 G0iMFTS+T9huQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2A2D637821CC;
	Thu,  6 Jun 2024 00:54:35 +0000 (UTC)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] drm/panthor: add DRM fdinfo support
Date: Thu,  6 Jun 2024 01:49:54 +0100
Message-ID: <20240606005416.1172431-3-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240606005416.1172431-1-adrian.larumbe@collabora.com>
References: <20240606005416.1172431-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Drawing from the FW-calculated values in the previous commit, we can
increase the numbers for an open file by collecting them from finished jobs
when updating their group synchronisation objects.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_devfreq.c | 10 +++++
 drivers/gpu/drm/panthor/panthor_device.h  | 11 ++++++
 drivers/gpu/drm/panthor/panthor_drv.c     | 31 +++++++++++++++
 drivers/gpu/drm/panthor/panthor_sched.c   | 46 +++++++++++++++++++++++
 4 files changed, 98 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
index c6d3c327cc24..5eededaeade7 100644
--- a/drivers/gpu/drm/panthor/panthor_devfreq.c
+++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
@@ -91,6 +91,7 @@ static int panthor_devfreq_get_dev_status(struct device *dev,
 	spin_lock_irqsave(&pdevfreq->lock, irqflags);
 
 	panthor_devfreq_update_utilization(pdevfreq);
+	ptdev->current_frequency = status->current_frequency;
 
 	status->total_time = ktime_to_ns(ktime_add(pdevfreq->busy_time,
 						   pdevfreq->idle_time));
@@ -130,6 +131,7 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
 	struct panthor_devfreq *pdevfreq;
 	struct dev_pm_opp *opp;
 	unsigned long cur_freq;
+	unsigned long freq = ULONG_MAX;
 	int ret;
 
 	pdevfreq = drmm_kzalloc(&ptdev->base, sizeof(*ptdev->devfreq), GFP_KERNEL);
@@ -204,6 +206,14 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
 
 	dev_pm_opp_put(opp);
 
+	/* Find the fastest defined rate  */
+	opp = dev_pm_opp_find_freq_floor(dev, &freq);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+	ptdev->fast_rate = freq;
+
+	dev_pm_opp_put(opp);
+
 	/*
 	 * Setup default thresholds for the simple_ondemand governor.
 	 * The values are chosen based on experiments.
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index e388c0472ba7..8a0260a7b90a 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -162,6 +162,14 @@ struct panthor_device {
 		 */
 		struct page *dummy_latest_flush;
 	} pm;
+
+	unsigned long current_frequency;
+	unsigned long fast_rate;
+};
+
+struct panthor_gpu_usage {
+	u64 time;
+	u64 cycles;
 };
 
 /**
@@ -176,6 +184,9 @@ struct panthor_file {
 
 	/** @groups: Scheduling group pool attached to this file. */
 	struct panthor_group_pool *groups;
+
+	/** @stats: cycle and timestamp measures for job execution. */
+	struct panthor_gpu_usage stats;
 };
 
 int panthor_device_init(struct panthor_device *ptdev);
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index b8a84f26b3ef..6d25385e02a1 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -3,12 +3,17 @@
 /* Copyright 2019 Linaro, Ltd., Rob Herring <robh@kernel.org> */
 /* Copyright 2019 Collabora ltd. */
 
+#ifdef CONFIG_ARM_ARCH_TIMER
+#include <asm/arch_timer.h>
+#endif
+
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/time64.h>
 
 #include <drm/drm_debugfs.h>
 #include <drm/drm_drv.h>
@@ -1351,6 +1356,30 @@ static int panthor_mmap(struct file *filp, struct vm_area_struct *vma)
 	return ret;
 }
 
+static void panthor_gpu_show_fdinfo(struct panthor_device *ptdev,
+				    struct panthor_file *pfile,
+				    struct drm_printer *p)
+{
+#ifdef CONFIG_ARM_ARCH_TIMER
+	drm_printf(p, "drm-engine-panthor:\t%llu ns\n",
+		   DIV_ROUND_UP_ULL((pfile->stats.time * NSEC_PER_SEC),
+				    arch_timer_get_cntfrq()));
+#endif
+	drm_printf(p, "drm-cycles-panthor:\t%llu\n", pfile->stats.cycles);
+	drm_printf(p, "drm-maxfreq-panthor:\t%lu Hz\n", ptdev->fast_rate);
+	drm_printf(p, "drm-curfreq-panthor:\t%lu Hz\n", ptdev->current_frequency);
+}
+
+static void panthor_show_fdinfo(struct drm_printer *p, struct drm_file *file)
+{
+	struct drm_device *dev = file->minor->dev;
+	struct panthor_device *ptdev = container_of(dev, struct panthor_device, base);
+
+	panthor_gpu_show_fdinfo(ptdev, file->driver_priv, p);
+
+	drm_show_memory_stats(p, file);
+}
+
 static const struct file_operations panthor_drm_driver_fops = {
 	.open = drm_open,
 	.release = drm_release,
@@ -1360,6 +1389,7 @@ static const struct file_operations panthor_drm_driver_fops = {
 	.read = drm_read,
 	.llseek = noop_llseek,
 	.mmap = panthor_mmap,
+	.show_fdinfo = drm_show_fdinfo,
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -1378,6 +1408,7 @@ static const struct drm_driver panthor_drm_driver = {
 			   DRIVER_SYNCOBJ_TIMELINE | DRIVER_GEM_GPUVA,
 	.open = panthor_open,
 	.postclose = panthor_postclose,
+	.show_fdinfo = panthor_show_fdinfo,
 	.ioctls = panthor_drm_driver_ioctls,
 	.num_ioctls = ARRAY_SIZE(panthor_drm_driver_ioctls),
 	.fops = &panthor_drm_driver_fops,
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 62a67d6bd37a..bbd20db40e7b 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -610,6 +610,18 @@ struct panthor_group {
 		size_t job_times_offset;
 	} syncobjs;
 
+	/** @fdinfo: Per-file total cycle and timestamp values reference. */
+	struct {
+		/** @data: Pointer to actual per-file sample data. */
+		struct panthor_gpu_usage *data;
+
+		/**
+		 * @lock: Mutex to govern concurrent access from drm file's fdinfo callback
+		 * and job post-completion processing function
+		 */
+		struct mutex lock;
+	} fdinfo;
+
 	/** @state: Group state. */
 	enum panthor_group_state state;
 
@@ -870,6 +882,8 @@ static void group_release_work(struct work_struct *work)
 						   release_work);
 	u32 i;
 
+	mutex_destroy(&group->fdinfo.lock);
+
 	for (i = 0; i < group->queue_count; i++)
 		group_free_queue(group, group->queues[i]);
 
@@ -2792,6 +2806,30 @@ void panthor_sched_post_reset(struct panthor_device *ptdev, bool reset_failed)
 	}
 }
 
+static void update_fdinfo_stats(struct panthor_job *job)
+{
+	struct panthor_group *group = job->group;
+	struct panthor_queue *queue = group->queues[job->queue_idx];
+	struct panthor_device *ptdev = group->ptdev;
+	struct panthor_gpu_usage *fdinfo;
+	struct panthor_job_times *times;
+
+	drm_WARN_ON(&ptdev->base, job->ringbuf_idx >=
+		    panthor_kernel_bo_size(queue->ringbuf) / (SLOTSIZE));
+
+	times = (struct panthor_job_times *)
+		((unsigned long)group->syncobjs.bo->kmap + queue->time_offset +
+		 (job->ringbuf_idx * sizeof(struct panthor_job_times)));
+
+	mutex_lock(&group->fdinfo.lock);
+	if ((group->fdinfo.data)) {
+		fdinfo = group->fdinfo.data;
+		fdinfo->cycles += times->cycles.after - times->cycles.before;
+		fdinfo->time += times->time.after - times->time.before;
+	}
+	mutex_unlock(&group->fdinfo.lock);
+}
+
 static void group_sync_upd_work(struct work_struct *work)
 {
 	struct panthor_group *group =
@@ -2827,6 +2865,7 @@ static void group_sync_upd_work(struct work_struct *work)
 	dma_fence_end_signalling(cookie);
 
 	list_for_each_entry_safe(job, job_tmp, &done_jobs, node) {
+		update_fdinfo_stats(job);
 		list_del_init(&job->node);
 		panthor_job_put(&job->base);
 	}
@@ -3289,6 +3328,9 @@ int panthor_group_create(struct panthor_file *pfile,
 	}
 	mutex_unlock(&sched->reset.lock);
 
+	group->fdinfo.data = &pfile->stats;
+	mutex_init(&group->fdinfo.lock);
+
 	return gid;
 
 err_put_group:
@@ -3328,6 +3370,10 @@ int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle)
 	mutex_unlock(&sched->lock);
 	mutex_unlock(&sched->reset.lock);
 
+	mutex_lock(&group->fdinfo.lock);
+	group->fdinfo.data = NULL;
+	mutex_unlock(&group->fdinfo.lock);
+
 	group_put(group);
 	return 0;
 }
-- 
2.45.1


