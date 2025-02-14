Return-Path: <linux-kernel+bounces-515639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5E3A3672E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09423AD164
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 21:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DE91AAE17;
	Fri, 14 Feb 2025 21:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="E5WKFmUI"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB1417E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 21:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739566843; cv=pass; b=TOD78yl5ZK+kEnXegfyiy0VhEQespe5G/W2UeREPC3r12753EDG8rEUcC5wy/UK/BpwfSLANfNs+FHttqbEhyiFvPaz8XybpHJhWReDg8cBnJhB9JVUa5L+crRbwoLN5cF//wtWPpAzW1NB2mWt56I8iqSU0JEYi+06HvXQlww0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739566843; c=relaxed/simple;
	bh=DE5nfokGRGuknbIzkCBHpqHkDz/5OfERZLI5l8zDe48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b7f6dwMDhtRJIyAuVVL1FVSqZ+CXCt5w/pYixOsP4eb6jPUsIwJF3kE160b6+S1dagy3YoxYUpupBMqirRmS1iH6BUDMvW092nOTKAhVB17W158M35lMc9GgrIwn/TJd82yNbXw2z1u0QbXRN80dRyyd5JIPX3OBiC8xsnn6bnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=E5WKFmUI; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739566822; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TTH20RyKACG3RKP2ks2FvVdL1gk9qJMPOFAVzmfxi6fuFO04Rmtb7FGFsbtLBiHAwmmZeP/u1Dvmj3PKrdSilsZH0dwpvtqBUin6HiKlMVQjC6wBKTqaRbaZMMLB62S5PDvwGOMpKSt01teIaMRFpWtRY9NX8ZM+kv8Y6yuoDJQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739566822; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pGxqVtiyhh2WTau1AC7TbQOOxWOmbP85rJg2FnEKnpc=; 
	b=Vxd5PowxPM6V0Z/Mf/0XzKLdpe+Q+7VXrvQVC6zc/aNXduF7qC9RHJguhs6eCiaHRR3HEKv7RYV9F4NTSYV7+RS3eFhg8wL1/wexkoB5/xwF4K9Eo1iW3VNZFTve+Vu7KsxmLCVtiqXSQmsXvtJnHjBIX2CilwN7OXJzM/SFXjM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739566822;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=pGxqVtiyhh2WTau1AC7TbQOOxWOmbP85rJg2FnEKnpc=;
	b=E5WKFmUIEx3ndoXt0EX9dNciuLtGlBvTw+n2Hu3jQg3uhzyPqUfORLj5AyQnmwYC
	k13V1YpZqV8Og+S4Y6hf/kUsBawQqn7WQasmrwMMC7avWu+opJ6zgCVQ4tkeHGYFz2m
	h5uu/HIQ6ymqX4czr7SyI0p9u0QeaqqHvLVZ90UI=
Received: by mx.zohomail.com with SMTPS id 1739566819232123.35089074976884;
	Fri, 14 Feb 2025 13:00:19 -0800 (PST)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drm/panthor: Replace sleep locks with spinlocks in fdinfo path
Date: Fri, 14 Feb 2025 20:55:20 +0000
Message-ID: <20250214210009.1994543-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 0590c94c3596 ("drm/panthor: Fix race condition when gathering fdinfo
group samples") introduced an xarray lock to deal with potential
use-after-free errors when accessing groups fdinfo figures. However, this
toggles the kernel's atomic context status, so the next nested mutex lock
will raise a warning when the kernel is compiled with mutex debug options:

CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_MUTEXES=y

Replace Panthor's group fdinfo data mutex with a guarded spinlock.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
0590c94c3596 ("drm/panthor: Fix race condition when gathering fdinfo group samples")
---
 drivers/gpu/drm/panthor/panthor_sched.c | 26 ++++++++++++-------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 1a276db095ff..4d31d1967716 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -9,6 +9,7 @@
 #include <drm/panthor_drm.h>
 
 #include <linux/build_bug.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
@@ -631,10 +632,10 @@ struct panthor_group {
 		struct panthor_gpu_usage data;
 
 		/**
-		 * @lock: Mutex to govern concurrent access from drm file's fdinfo callback
-		 * and job post-completion processing function
+		 * @fdinfo.lock: Spinlock to govern concurrent access from drm file's fdinfo
+		 * callback and job post-completion processing function
 		 */
-		struct mutex lock;
+		spinlock_t lock;
 
 		/** @fdinfo.kbo_sizes: Aggregate size of private kernel BO's held by the group. */
 		size_t kbo_sizes;
@@ -910,8 +911,6 @@ static void group_release_work(struct work_struct *work)
 						   release_work);
 	u32 i;
 
-	mutex_destroy(&group->fdinfo.lock);
-
 	for (i = 0; i < group->queue_count; i++)
 		group_free_queue(group, group->queues[i]);
 
@@ -2861,12 +2860,12 @@ static void update_fdinfo_stats(struct panthor_job *job)
 	struct panthor_job_profiling_data *slots = queue->profiling.slots->kmap;
 	struct panthor_job_profiling_data *data = &slots[job->profiling.slot];
 
-	mutex_lock(&group->fdinfo.lock);
-	if (job->profiling.mask & PANTHOR_DEVICE_PROFILING_CYCLES)
-		fdinfo->cycles += data->cycles.after - data->cycles.before;
-	if (job->profiling.mask & PANTHOR_DEVICE_PROFILING_TIMESTAMP)
-		fdinfo->time += data->time.after - data->time.before;
-	mutex_unlock(&group->fdinfo.lock);
+	scoped_guard(spinlock, &group->fdinfo.lock) {
+		if (job->profiling.mask & PANTHOR_DEVICE_PROFILING_CYCLES)
+			fdinfo->cycles += data->cycles.after - data->cycles.before;
+		if (job->profiling.mask & PANTHOR_DEVICE_PROFILING_TIMESTAMP)
+			fdinfo->time += data->time.after - data->time.before;
+	}
 }
 
 void panthor_fdinfo_gather_group_samples(struct panthor_file *pfile)
@@ -2880,12 +2879,11 @@ void panthor_fdinfo_gather_group_samples(struct panthor_file *pfile)
 
 	xa_lock(&gpool->xa);
 	xa_for_each(&gpool->xa, i, group) {
-		mutex_lock(&group->fdinfo.lock);
+		guard(spinlock)(&group->fdinfo.lock);
 		pfile->stats.cycles += group->fdinfo.data.cycles;
 		pfile->stats.time += group->fdinfo.data.time;
 		group->fdinfo.data.cycles = 0;
 		group->fdinfo.data.time = 0;
-		mutex_unlock(&group->fdinfo.lock);
 	}
 	xa_unlock(&gpool->xa);
 }
@@ -3537,7 +3535,7 @@ int panthor_group_create(struct panthor_file *pfile,
 	mutex_unlock(&sched->reset.lock);
 
 	add_group_kbo_sizes(group->ptdev, group);
-	mutex_init(&group->fdinfo.lock);
+	spin_lock_init(&group->fdinfo.lock);
 
 	return gid;
 
-- 
2.47.1


