Return-Path: <linux-kernel+bounces-285512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 642A8950E58
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 855891C23542
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8E01AAE23;
	Tue, 13 Aug 2024 21:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="BXksm/I6"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653961AAE21
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723583212; cv=pass; b=Lxmw1vUlCx2mTpJ7fPH1JpNzuZIFLBxKpk+TjcWyAKuaEnwiiixHJjlsA34sS1chFOSN+8gSYV29OTv8own3UjjVuxZnkXA0JFf/IoSk6l/XS28IA8h1NIS2Cu5MHXLjmtkIfy12N521j9eIs2dp4YFWXCdR9a0MmP6VQ7GEUr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723583212; c=relaxed/simple;
	bh=q0ZyM+pBQV63wqsfPlbOU9SZtLE5DGhEfks5O++htuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksai9lpebAzajRRV+e7xZ64W36jzQ+eXtzftyRwsV/qp9hzm+nwEjD4DjWNfiRdqVnYuA267LkPgkFd31fqgF4FMLA9W4N2A6cbIM7oyIZJb2LlPbY5dd2a638hwk4VWlKDk3PGDEUhN3nDB8vSJshOvFpLaKxam6/FhwmmWcw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=BXksm/I6; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: boris.brezillon@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723583205; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fKUwfpOhvdJtFWG6VHaA1ab+f2vFp0ZWp/zQQIRjvJfIY1cLSLtQBWtuBE701Uql6jLyoBrv0a+daXKWFVjI0BocfiphjYdYMlkxb9Qtr+CVmkU1SfKI7r7JBT+vC7MTHo2GyXD435j++v9V0Iu8MbNTtVK0Zg4jSfevmixeQH0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723583205; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4TyB7ycVJcJFce9wDMid/a6SVoBq2Z6PsVzRbtIMMJU=; 
	b=b1AAbMH1twg3hzWcJMrS14YbfJMP9b8roTcLjw/Qhx0Ezanib8YOdEUL5oaHAv3Cp9gH/OWdfQb+lzZ3V34TwvZ30qLnf9hLoFG7EqfYIbXkB5viVWTyPDdiCGeDBZ/DKz+z+2070Th9Inc4MP+VEmFtmgPqWkfyn9Ebsk8X6IE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723583205;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4TyB7ycVJcJFce9wDMid/a6SVoBq2Z6PsVzRbtIMMJU=;
	b=BXksm/I6lCew9NYUpb+MESfiik/BemGzso6hVxHnQFMAvPGkLQm1IEQVG28H7utx
	yGW1/5r4tEmqsr+OlleIc9887BAjwosQ+3+4dWog+D3rFoIMaopryn8vmZ9B23pb7Iq
	7rmHZxnuHSI+SGip2RczP56E6Oxf0+lT8LR8i26M=
Received: by mx.zohomail.com with SMTPS id 1723583203030109.96859534897851;
	Tue, 13 Aug 2024 14:06:43 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
To: liviu.dudau@arm.com,
	steven.price@arm.com,
	carsten.haitzler@arm.com,
	boris.brezillon@collabora.com,
	robh@kernel.org,
	faith.ekstrand@collabora.com
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] drm: panthor: allow dumping multiple jobs
Date: Tue, 13 Aug 2024 18:05:48 -0300
Message-ID: <20240813210555.607641-7-daniel.almeida@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240813210555.607641-1-daniel.almeida@collabora.com>
References: <20240710225011.275153-1-daniel.almeida@collabora.com>
 <20240813210555.607641-1-daniel.almeida@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

When dumping successful jobs, it's useful to dump a given number of
them if needed. This is blocked by the fact that the devcoredump
mechanism will not create a new dump if an old one has not been read.

In particular, if we're dumping multiple jobs in sequence, there are
sections of the dump that we do not want to include again, since they
would be redundant.

Allow dumping multiple jobs by keeping a counter and a list. The list
gets appended until the counter is zero, at which point, the whole list
is dumped at once, thereby calling into devcoredump also only once.

This counter is controlled through a debugfs file.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_dump.c  | 229 ++++++++++++++++--------
 drivers/gpu/drm/panthor/panthor_dump.h  |  15 ++
 drivers/gpu/drm/panthor/panthor_sched.c |  20 ++-
 3 files changed, 186 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_dump.c b/drivers/gpu/drm/panthor/panthor_dump.c
index 7ec0e21dc7e9..d3b29359e13a 100644
--- a/drivers/gpu/drm/panthor/panthor_dump.c
+++ b/drivers/gpu/drm/panthor/panthor_dump.c
@@ -5,6 +5,7 @@
 #include <linux/iosys-map.h>
 #include <linux/devcoredump.h>
 #include <linux/err.h>
+#include <linux/list.h>
 #include <linux/vmalloc.h>
 #include <linux/types.h>
 #include <uapi/drm/panthor_drm.h>
@@ -152,22 +153,25 @@ static void count_queues(struct queue_count *count,
 }
 
 static int compute_dump_size(struct vm_dump_count *va_count,
-			     struct queue_count *group_and_q_cnt)
+			     struct queue_count *group_and_q_cnt,
+			     bool job_list_is_empty)
 {
 	int size = 0;
 	int i;
 
-	size += sizeof(struct drm_panthor_dump_header);
-	size += sizeof(struct drm_panthor_dump_version);
+	if (job_list_is_empty) {
+		size += sizeof(struct drm_panthor_dump_header);
+		size += sizeof(struct drm_panthor_dump_version);
 
-	size += sizeof(struct drm_panthor_dump_header);
-	size += sizeof(struct drm_panthor_gpu_info);
+		size += sizeof(struct drm_panthor_dump_header);
+		size += sizeof(struct drm_panthor_gpu_info);
 
-	size += sizeof(struct drm_panthor_dump_header);
-	size += sizeof(struct drm_panthor_csif_info);
+		size += sizeof(struct drm_panthor_dump_header);
+		size += sizeof(struct drm_panthor_csif_info);
 
-	size += sizeof(struct drm_panthor_dump_header);
-	size += sizeof(struct drm_panthor_fw_info);
+		size += sizeof(struct drm_panthor_dump_header);
+		size += sizeof(struct drm_panthor_fw_info);
+	}
 
 	for (i = 0; i < va_count->vas; i++) {
 		size += sizeof(struct drm_panthor_dump_header);
@@ -250,6 +254,58 @@ static int dump_group_info(struct dump_group_args *dump_group_args,
 	return ret;
 }
 
+static void clean_job_list(struct list_head *joblist)
+{
+	struct panthor_dump_job_entry *job, *tmp;
+
+	list_for_each_entry_safe(job, tmp, joblist, node) {
+		list_del(&job->node);
+		vfree(job->mem);
+		kfree(job);
+	}
+}
+
+static int append_job(struct panthor_core_dump_args *args, void *mem,
+		      size_t size)
+{
+	struct panthor_dump_job_entry *job;
+
+	job = kzalloc(sizeof(*job), GFP_KERNEL);
+	if (!job)
+		return -ENOMEM;
+
+	job->mem = mem;
+	job->size = size;
+	list_add_tail(&job->node, args->job_list);
+	return 0;
+}
+
+static int copy_from_job_list(struct list_head *job_list, void **out_mem,
+			      u32 *out_size)
+{
+	u32 total_size = 0;
+	u32 offset = 0;
+	struct panthor_dump_job_entry *entry;
+	void *mem;
+
+	list_for_each_entry(entry, job_list, node) {
+		total_size += entry->size;
+	}
+
+	mem = vzalloc(total_size);
+	if (!mem)
+		return -ENOMEM;
+
+	list_for_each_entry(entry, job_list, node) {
+		memcpy(mem + offset, entry->mem, entry->size);
+		offset += entry->size;
+	}
+
+	*out_mem = mem;
+	*out_size = total_size;
+	return 0;
+}
+
 int panthor_core_dump(struct panthor_core_dump_args *args)
 {
 	u8 *mem;
@@ -273,7 +329,8 @@ int panthor_core_dump(struct panthor_core_dump_args *args)
 
 	count_queues(&group_and_q_cnt, &group_info);
 
-	dump_size = compute_dump_size(&va_count, &group_and_q_cnt);
+	dump_size = compute_dump_size(&va_count, &group_and_q_cnt,
+				      list_empty(args->job_list));
 
 	mem = vzalloc(dump_size);
 	if (!mem)
@@ -286,69 +343,73 @@ int panthor_core_dump(struct panthor_core_dump_args *args)
 		.capacity = dump_size,
 	};
 
-	hdr = alloc_header(&alloc, DRM_PANTHOR_DUMP_HEADER_TYPE_VERSION,
-			   sizeof(struct drm_panthor_dump_version));
-	if (IS_ERR(hdr)) {
-		ret = PTR_ERR(hdr);
-		goto free_valloc;
+	if (list_empty(args->job_list)) {
+		hdr = alloc_header(&alloc, DRM_PANTHOR_DUMP_HEADER_TYPE_VERSION,
+				   sizeof(struct drm_panthor_dump_version));
+		if (IS_ERR(hdr)) {
+			ret = PTR_ERR(hdr);
+			goto free_valloc;
+		}
+
+		version = alloc_bytes(&alloc, sizeof(*version));
+		if (IS_ERR(version)) {
+			ret = PTR_ERR(version);
+			goto free_valloc;
+		}
+
+		*version = (struct drm_panthor_dump_version){
+			.major = PANT_DUMP_MAJOR,
+			.minor = PANT_DUMP_MINOR,
+		};
+
+		hdr = alloc_header(&alloc,
+				   DRM_PANTHOR_DUMP_HEADER_TYPE_GPU_INFO,
+				   sizeof(args->ptdev->gpu_info));
+		if (IS_ERR(hdr)) {
+			ret = PTR_ERR(hdr);
+			goto free_valloc;
+		}
+
+		gpu_info = alloc_bytes(&alloc, sizeof(*gpu_info));
+		if (IS_ERR(gpu_info)) {
+			ret = PTR_ERR(gpu_info);
+			goto free_valloc;
+		}
+
+		*gpu_info = args->ptdev->gpu_info;
+
+		hdr = alloc_header(&alloc,
+				   DRM_PANTHOR_DUMP_HEADER_TYPE_CSIF_INFO,
+				   sizeof(args->ptdev->csif_info));
+		if (IS_ERR(hdr)) {
+			ret = PTR_ERR(hdr);
+			goto free_valloc;
+		}
+
+		csif_info = alloc_bytes(&alloc, sizeof(*csif_info));
+		if (IS_ERR(csif_info)) {
+			ret = PTR_ERR(csif_info);
+			goto free_valloc;
+		}
+
+		*csif_info = args->ptdev->csif_info;
+
+		hdr = alloc_header(&alloc, DRM_PANTHOR_DUMP_HEADER_TYPE_FW_INFO,
+				   sizeof(args->ptdev->fw_info));
+		if (IS_ERR(hdr)) {
+			ret = PTR_ERR(hdr);
+			goto free_valloc;
+		}
+
+		fw_info = alloc_bytes(&alloc, sizeof(*fw_info));
+		if (IS_ERR(fw_info)) {
+			ret = PTR_ERR(fw_info);
+			goto free_valloc;
+		}
+
+		*fw_info = args->ptdev->fw_info;
 	}
 
-	version = alloc_bytes(&alloc, sizeof(*version));
-	if (IS_ERR(version)) {
-		ret = PTR_ERR(version);
-		goto free_valloc;
-	}
-
-	*version = (struct drm_panthor_dump_version){
-		.major = PANT_DUMP_MAJOR,
-		.minor = PANT_DUMP_MINOR,
-	};
-
-	hdr = alloc_header(&alloc, DRM_PANTHOR_DUMP_HEADER_TYPE_GPU_INFO,
-			   sizeof(args->ptdev->gpu_info));
-	if (IS_ERR(hdr)) {
-		ret = PTR_ERR(hdr);
-		goto free_valloc;
-	}
-
-	gpu_info = alloc_bytes(&alloc, sizeof(*gpu_info));
-	if (IS_ERR(gpu_info)) {
-		ret = PTR_ERR(gpu_info);
-		goto free_valloc;
-	}
-
-	*gpu_info = args->ptdev->gpu_info;
-
-	hdr = alloc_header(&alloc, DRM_PANTHOR_DUMP_HEADER_TYPE_CSIF_INFO,
-			   sizeof(args->ptdev->csif_info));
-	if (IS_ERR(hdr)) {
-		ret = PTR_ERR(hdr);
-		goto free_valloc;
-	}
-
-	csif_info = alloc_bytes(&alloc, sizeof(*csif_info));
-	if (IS_ERR(csif_info)) {
-		ret = PTR_ERR(csif_info);
-		goto free_valloc;
-	}
-
-	*csif_info = args->ptdev->csif_info;
-
-	hdr = alloc_header(&alloc, DRM_PANTHOR_DUMP_HEADER_TYPE_FW_INFO,
-			   sizeof(args->ptdev->fw_info));
-	if (IS_ERR(hdr)) {
-		ret = PTR_ERR(hdr);
-		goto free_valloc;
-	}
-
-	fw_info = alloc_bytes(&alloc, sizeof(*fw_info));
-	if (IS_ERR(fw_info)) {
-		ret = PTR_ERR(fw_info);
-		goto free_valloc;
-	}
-
-	*fw_info = args->ptdev->fw_info;
-
 	dump_va_args.ptdev = args->ptdev;
 	dump_va_args.alloc = &alloc;
 	ret = panthor_vm_foreach_va(args->group_vm, dump_va_cb, &dump_va_args);
@@ -365,12 +426,34 @@ int panthor_core_dump(struct panthor_core_dump_args *args)
 			 "dump size mismatch: expected %d, got %zu\n",
 			 dump_size, alloc.pos);
 
-	dev_coredumpv(args->ptdev->base.dev, alloc.start, alloc.pos,
-		      GFP_KERNEL);
+	if (args->append) {
+		ret = append_job(args, alloc.start, alloc.pos);
+		if (ret)
+			goto free_valloc;
+	} else if (!list_empty(args->job_list)) {
+		void *mem;
+		u32 size;
+
+		/* append ourselves */
+		append_job(args, alloc.start, alloc.pos);
+		if (ret)
+			goto free_valloc;
+
+		ret = copy_from_job_list(args->job_list, &mem, &size);
+		if (ret)
+			goto free_valloc;
+
+		dev_coredumpv(args->ptdev->base.dev, mem, size, GFP_KERNEL);
+		clean_job_list(args->job_list);
+	} else {
+		dev_coredumpv(args->ptdev->base.dev, alloc.start, alloc.pos,
+			      GFP_KERNEL);
+	}
 
 	return ret;
 
 free_valloc:
+	clean_job_list(args->job_list);
 	vfree(mem);
 	return ret;
 }
diff --git a/drivers/gpu/drm/panthor/panthor_dump.h b/drivers/gpu/drm/panthor/panthor_dump.h
index 2a02943a2dbd..f16051d7da21 100644
--- a/drivers/gpu/drm/panthor/panthor_dump.h
+++ b/drivers/gpu/drm/panthor/panthor_dump.h
@@ -10,10 +10,25 @@
 #include "panthor_device.h"
 #include "panthor_gem.h"
 
+struct panthor_dump_job_entry {
+	void *mem;
+	size_t size;
+	struct list_head node;
+};
+
 struct panthor_core_dump_args {
 	struct panthor_device *ptdev;
 	struct panthor_vm *group_vm;
 	struct panthor_group *group;
+	/** @job_list: used if the dump contains more than one job.
+	 *
+	 * Note that the default devcoredump behavior is to discard dumps when a
+	 * previous dump has not been read yet. There is also a limit on the number
+	 * of dumps that can be stored.
+	 */
+	struct list_head *job_list;
+	/** @append: whether to append the current job dump to job_list */
+	bool append;
 };
 
 int panthor_core_dump(struct panthor_core_dump_args *args);
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index ea2696c1075a..5f31a476866b 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -319,8 +319,10 @@ struct panthor_scheduler {
 		struct list_head stopped_groups;
 	} reset;
 
-	/** @dump_successful_jobs: whether to dump successful jobs through coredumpv */
-	bool dump_successful_jobs;
+	/** @dump_successful_jobs: Whether to dump successful jobs through coredumpv */
+	u32 dump_next_n_successful_jobs;
+	/** @dump_job_list: List containing dump entries if multiple jobs are being dumped */
+	struct list_head dump_job_list;
 };
 
 /**
@@ -2950,11 +2952,15 @@ queue_run_job(struct drm_sched_job *sched_job)
 	queue->iface.input->extract = queue->iface.output->extract;
 	queue->iface.input->insert = job->ringbuf.end;
 
-	if (sched->dump_successful_jobs) {
+	if (sched->dump_next_n_successful_jobs > 0) {
+		sched->dump_next_n_successful_jobs--;
+
 		struct panthor_core_dump_args core_dump_args = {
 			.ptdev = ptdev,
 			.group_vm = job->group->vm,
 			.group = job->group,
+			.job_list = &sched->dump_job_list,
+			.append = !!sched->dump_next_n_successful_jobs,
 		};
 
 		panthor_core_dump(&core_dump_args);
@@ -3014,6 +3020,7 @@ queue_timedout_job(struct drm_sched_job *sched_job)
 		.ptdev = ptdev,
 		.group_vm = job->group->vm,
 		.group = job->group,
+		.job_list = &sched->dump_job_list,
 	};
 
 	panthor_core_dump(&core_dump_args);
@@ -3509,6 +3516,7 @@ static void panthor_sched_fini(struct drm_device *ddev, void *res)
 	}
 
 	drm_WARN_ON(ddev, !list_empty(&sched->groups.waiting));
+	drm_WARN_ON(ddev, !list_empty(&sched->dump_job_list));
 }
 
 int panthor_sched_init(struct panthor_device *ptdev)
@@ -3585,6 +3593,7 @@ int panthor_sched_init(struct panthor_device *ptdev)
 		return ret;
 
 	INIT_LIST_HEAD(&sched->reset.stopped_groups);
+	INIT_LIST_HEAD(&sched->dump_job_list);
 
 	/* sched->heap_alloc_wq will be used for heap chunk allocation on
 	 * tiler OOM events, which means we can't use the same workqueue for
@@ -3624,7 +3633,8 @@ void panthor_sched_debugfs_init(struct drm_minor *minor)
 		container_of(minor->dev, struct panthor_device, base);
 	struct panthor_scheduler *sched = ptdev->scheduler;
 
-	debugfs_create_bool("dump_successful_jobs", 0644, minor->debugfs_root,
-			    &sched->dump_successful_jobs);
+	debugfs_create_u32("dump_next_n_successful_jobs", 0644,
+			   minor->debugfs_root,
+			   &sched->dump_next_n_successful_jobs);
 }
 #endif /* CONFIG_DEBUG_FS */
-- 
2.45.2


