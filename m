Return-Path: <linux-kernel+bounces-254398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 209219332C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FBA81F23B72
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0991A0AE7;
	Tue, 16 Jul 2024 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DTeDaLmN"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86971A0716
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721160798; cv=none; b=doWiMP47+Zmek5Y3vwCFdBsZM1NuRtIcdCOrFOD+tqP/ZkoHqU0rsMCtSpu10qeKqeUUrDWPKYBZ2le8xwhhm4bQqjC4nMq/088yb+mtfHlYXOvs0jZqZzJhCjqEuFadxWzz7kB4AlM3Ao1IJSxxXAiKQjV+gmRQ+tHSpvKIYjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721160798; c=relaxed/simple;
	bh=myyayErUnm5Tyn0ZxKshGF1FA1y5Rl5Bylngi1lyG5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5hYk1N4rw1vg+AT4koUeSOTnLeQBvNieoq7udurWPLzAPdIqHHsc5MsHdngLHbKdQXoLuE5Iz1DV0ToTrd7ABk1806BvEN5QcUOY/KQRuJF51lcug+/kvyFsJCGRRjx21xcE57DP9Kgrd/IVjNIh4UYkXNyPndChVU2wYFY51Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DTeDaLmN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721160795;
	bh=myyayErUnm5Tyn0ZxKshGF1FA1y5Rl5Bylngi1lyG5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DTeDaLmNEMEXW/KK6yPsR1jiXfSUtzAWLABtLF6zdU6URGCEuAenl6ZATK4i1Nfhk
	 zWOdl5YDosIclMl2EQGKPGAw+IpvrRLPfDuLDWR5eNua2Xd2iml+M4hqroyIMw1TSJ
	 AUDUhTUOUekfTbUPEwcGfy6+CnNY3g0FEslhSuibUmZPQvVtr7TrHpQZlkKtSEHpI1
	 HJOlW3DTavTFxgZMeS/6vvkFpBrD5qJ+Ti0tgu9CI4eFaBh2LPG/EZ/7d5VxLrLUWM
	 or36USpm+IAGADIQ1CzBqEOqFBhx7U+oEZbCAXDCYqaa3vfUffM7bUmowf6PgDnZ6o
	 aUn9k0FVW7t0w==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 735E237821DE;
	Tue, 16 Jul 2024 20:13:14 +0000 (UTC)
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
Subject: [PATCH v4 2/4] drm/panthor: add DRM fdinfo support
Date: Tue, 16 Jul 2024 21:11:41 +0100
Message-ID: <20240716201302.2939894-3-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240716201302.2939894-1-adrian.larumbe@collabora.com>
References: <20240716201302.2939894-1-adrian.larumbe@collabora.com>
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

Display of fdinfo key-value pairs is governed by a flag that is by default
disabled in the present commit, and supporting manual toggle of it will be
the matter of a later commit.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_devfreq.c | 18 ++++++++-
 drivers/gpu/drm/panthor/panthor_device.h  | 10 +++++
 drivers/gpu/drm/panthor/panthor_drv.c     | 33 ++++++++++++++++
 drivers/gpu/drm/panthor/panthor_sched.c   | 47 +++++++++++++++++++++++
 4 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
index c6d3c327cc24..9d0f891b9b53 100644
--- a/drivers/gpu/drm/panthor/panthor_devfreq.c
+++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
@@ -62,14 +62,20 @@ static void panthor_devfreq_update_utilization(struct panthor_devfreq *pdevfreq)
 static int panthor_devfreq_target(struct device *dev, unsigned long *freq,
 				  u32 flags)
 {
+	struct panthor_device *ptdev = dev_get_drvdata(dev);
 	struct dev_pm_opp *opp;
+	int err;
 
 	opp = devfreq_recommended_opp(dev, freq, flags);
 	if (IS_ERR(opp))
 		return PTR_ERR(opp);
 	dev_pm_opp_put(opp);
 
-	return dev_pm_opp_set_rate(dev, *freq);
+	err = dev_pm_opp_set_rate(dev, *freq);
+	if (!err)
+		ptdev->current_frequency = *freq;
+
+	return err;
 }
 
 static void panthor_devfreq_reset(struct panthor_devfreq *pdevfreq)
@@ -130,6 +136,7 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
 	struct panthor_devfreq *pdevfreq;
 	struct dev_pm_opp *opp;
 	unsigned long cur_freq;
+	unsigned long freq = ULONG_MAX;
 	int ret;
 
 	pdevfreq = drmm_kzalloc(&ptdev->base, sizeof(*ptdev->devfreq), GFP_KERNEL);
@@ -161,6 +168,7 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
 		return PTR_ERR(opp);
 
 	panthor_devfreq_profile.initial_freq = cur_freq;
+	ptdev->current_frequency = cur_freq;
 
 	/* Regulator coupling only takes care of synchronizing/balancing voltage
 	 * updates, but the coupled regulator needs to be enabled manually.
@@ -204,6 +212,14 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
 
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
index 3ede2f80df73..4536fbf43a4e 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -163,9 +163,16 @@ struct panthor_device {
 		struct page *dummy_latest_flush;
 	} pm;
 
+	unsigned long current_frequency;
+	unsigned long fast_rate;
 	bool profile_mode;
 };
 
+struct panthor_gpu_usage {
+	u64 time;
+	u64 cycles;
+};
+
 /**
  * struct panthor_file - Panthor file
  */
@@ -178,6 +185,9 @@ struct panthor_file {
 
 	/** @groups: Scheduling group pool attached to this file. */
 	struct panthor_group_pool *groups;
+
+	/** @stats: cycle and timestamp measures for job execution. */
+	struct panthor_gpu_usage stats;
 };
 
 int panthor_device_init(struct panthor_device *ptdev);
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index b8a84f26b3ef..6a0c1a06a709 100644
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
@@ -1351,6 +1356,32 @@ static int panthor_mmap(struct file *filp, struct vm_area_struct *vma)
 	return ret;
 }
 
+static void panthor_gpu_show_fdinfo(struct panthor_device *ptdev,
+				    struct panthor_file *pfile,
+				    struct drm_printer *p)
+{
+	if (ptdev->profile_mode) {
+#ifdef CONFIG_ARM_ARCH_TIMER
+		drm_printf(p, "drm-engine-panthor:\t%llu ns\n",
+			   DIV_ROUND_UP_ULL((pfile->stats.time * NSEC_PER_SEC),
+					    arch_timer_get_cntfrq()));
+#endif
+		drm_printf(p, "drm-cycles-panthor:\t%llu\n", pfile->stats.cycles);
+	}
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
@@ -1360,6 +1391,7 @@ static const struct file_operations panthor_drm_driver_fops = {
 	.read = drm_read,
 	.llseek = noop_llseek,
 	.mmap = panthor_mmap,
+	.show_fdinfo = drm_show_fdinfo,
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -1378,6 +1410,7 @@ static const struct drm_driver panthor_drm_driver = {
 			   DRIVER_SYNCOBJ_TIMELINE | DRIVER_GEM_GPUVA,
 	.open = panthor_open,
 	.postclose = panthor_postclose,
+	.show_fdinfo = panthor_show_fdinfo,
 	.ioctls = panthor_drm_driver_ioctls,
 	.num_ioctls = ARRAY_SIZE(panthor_drm_driver_ioctls),
 	.fops = &panthor_drm_driver_fops,
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 6438e5ea1f2b..4fb6fc5c2314 100644
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
 
@@ -873,6 +885,8 @@ static void group_release_work(struct work_struct *work)
 						   release_work);
 	u32 i;
 
+	mutex_destroy(&group->fdinfo.lock);
+
 	for (i = 0; i < group->queue_count; i++)
 		group_free_queue(group, group->queues[i]);
 
@@ -2795,6 +2809,30 @@ void panthor_sched_post_reset(struct panthor_device *ptdev, bool reset_failed)
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
@@ -2830,6 +2868,8 @@ static void group_sync_upd_work(struct work_struct *work)
 	dma_fence_end_signalling(cookie);
 
 	list_for_each_entry_safe(job, job_tmp, &done_jobs, node) {
+		if (job->is_profiled)
+			update_fdinfo_stats(job);
 		list_del_init(&job->node);
 		panthor_job_put(&job->base);
 	}
@@ -3362,6 +3402,9 @@ int panthor_group_create(struct panthor_file *pfile,
 	}
 	mutex_unlock(&sched->reset.lock);
 
+	group->fdinfo.data = &pfile->stats;
+	mutex_init(&group->fdinfo.lock);
+
 	return gid;
 
 err_put_group:
@@ -3401,6 +3444,10 @@ int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle)
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


