Return-Path: <linux-kernel+bounces-312659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDB4969974
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D6AAB20319
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C47819F41B;
	Tue,  3 Sep 2024 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVxfCdX+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C481A0BF0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356793; cv=none; b=mHJP0iJveTUoeeZYycNM6GOoMiUv0zptgX210/S6yhufGitHyLjbiyOMTqsWZkUusTSmlcv45fSuhEd2I1SCihFFygNYGR1F3xDQlnxpZRXmMudONkRFTLh/1mrYGnjYAHVFv+ju1FXvoqtrX2jd3KfqL3ukebehUz9GxDsinKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356793; c=relaxed/simple;
	bh=ibE6VkRF5KFGURbNzkGcxHz/WTilbFlUghoevY67TEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nmmtS5AL2YdZCO1jpy/KfVubb5YUK2O8YqlqGD+Gf5XX8ojJSwrorR5LGzLmI1vGH52ms6MVKIdLbdXQqPdsdk1237gGhGIpzQHItgzna1GzrdPC21eVOsds7snsymY+5KNSZzo6CgsojvXhwc1TswTfHwNtrHSj6PWV2iOE+Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cVxfCdX+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725356789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hfPqtV/kE0emxjHSqrcPT251LjHCu9jPean4uiHZO7k=;
	b=cVxfCdX+qQcQH+ocWfm2XYSZGqhZS6l9DXFm99fJnp9qXrPkGGXfmyLc2WUqF5Cm7JAi2e
	neCwPsDiX7lpBasYd0yMuo3vLfIgkpc+NrIlKsqyftIn12BiYYPNSdHttwg2o8x7+LZ82r
	0ZZ7P3mQd2Pf97OArd/oOSip2IxEaxc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-SiHFH5xtMymXmh8NoWutaw-1; Tue, 03 Sep 2024 05:46:28 -0400
X-MC-Unique: SiHFH5xtMymXmh8NoWutaw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a8110f90ffso654492585a.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 02:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725356788; x=1725961588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hfPqtV/kE0emxjHSqrcPT251LjHCu9jPean4uiHZO7k=;
        b=ITwLZoTrhvAuj5KGiIP5+ls6/VPa+vQLDtw2T4BUlpxlIyMzXwoaRHcz2+c30ZT7sw
         FHYsB75rC8ND1KDYigKQPPBttmpRRvis47kErfjiKUTR5RU6FzlMHQuHFv1nBziZ4Kzr
         y4QJ4tJWS5LUQE4FA/iSVg9c/Nr9aBjCIW7zRFdXP8V0NLmta0NkgxvlYSyecNwRoOfu
         yYMSE5uyN2VGWXYAtGWQ+rcYt2tXf76mw4iE9sRAzegnyytfkryhBvXwYWHhww0jSpdI
         ou+SJIMH38GCpTk8hHOXi9Jsl14EyQMg0Oce8PYZPZU32tbhh4hz9xC+GgwSxx4AhaHW
         6MVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZQAntHaaGK5BxDWsW8CSrtWBTwZwpIhrAcewmdXI4JymBXmXp8RdmBlSdmlrMrgJL9+SdsAG+i17lD7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyORY1ar+FhhvBv001AOu5e7jCOdGHp+uXZBQNglPgNjG96PgC/
	OCfkZHSXwHhD2IO9yP1TsTFH0gNBoAacyKeMKzbiRbVRG0oJ5gvqgS5D4571biXhq8cYGgrsjOn
	in5wxa9+ftssjogWNQWNDFRB7PKf56nXHXR7t0dsoA7e0zCdIAdUuHV1ePoePoA==
X-Received: by 2002:a05:6214:5f0f:b0:6c3:6a89:37e7 with SMTP id 6a1803df08f44-6c3c629bfa5mr26855476d6.22.1725356788144;
        Tue, 03 Sep 2024 02:46:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwf4goexew3ZEXrz2VkLN/ph9GuyXW2mpOFNkkxoudCwNOm9FKDVrNrmCnDDhWa3/jitQzuw==
X-Received: by 2002:a05:6214:5f0f:b0:6c3:6a89:37e7 with SMTP id 6a1803df08f44-6c3c629bfa5mr26855366d6.22.1725356787721;
        Tue, 03 Sep 2024 02:46:27 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c50f78c649sm5978946d6.130.2024.09.03.02.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 02:46:27 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Luben Tuikov <ltuikov89@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>
Subject: [RFC PATCH] drm/sched: Fix teardown leaks with refcounting
Date: Tue,  3 Sep 2024 11:45:32 +0200
Message-ID: <20240903094531.29893-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPU scheduler currently does not ensure that its pending_list is
empty before performing various other teardown tasks in
drm_sched_fini().

If there are still jobs in the pending_list, this is problematic because
after scheduler teardown, no one will call backend_ops.free_job()
anymore. This would, consequently, result in memory leaks.

One way to solves this is to implement reference counting for struct
drm_gpu_scheduler itself. Each job added to the pending_list takes a
reference, each one removed drops a reference.

This approach would keep the scheduler running even after users have
called drm_sched_fini(), and it would ultimately stop after the last job
has been removed from pending_list.

Add reference counting to struct drm_gpu_scheduler. Move the teardown
logic to __drm_sched_fini() and have drm_sched_fini() just also drop a
reference.

Suggested-by: Danilo Krummrich <dakr@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Hi all,

since the scheduler has many stake holders, I want this solution
discussed as an RFC first.

The advantage of this version would be that it does not block
drm_sched_fini(), but the price paid for that is that the scheduler
keeps running until all jobs are gone.

Cheers,
P.
---
 drivers/gpu/drm/scheduler/sched_main.c | 17 ++++++++++++++++-
 include/drm/gpu_scheduler.h            |  5 +++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 7e90c9f95611..62b453c8ed76 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -99,6 +99,8 @@ int drm_sched_policy = DRM_SCHED_POLICY_FIFO;
 MODULE_PARM_DESC(sched_policy, "Specify the scheduling policy for entities on a run-queue, " __stringify(DRM_SCHED_POLICY_RR) " = Round Robin, " __stringify(DRM_SCHED_POLICY_FIFO) " = FIFO (default).");
 module_param_named(sched_policy, drm_sched_policy, int, 0444);
 
+static void __drm_sched_fini(struct kref *jobs_remaining);
+
 static u32 drm_sched_available_credits(struct drm_gpu_scheduler *sched)
 {
 	u32 credits;
@@ -540,6 +542,7 @@ static void drm_sched_job_begin(struct drm_sched_job *s_job)
 
 	spin_lock(&sched->job_list_lock);
 	list_add_tail(&s_job->list, &sched->pending_list);
+	kref_get(&sched->jobs_remaining);
 	drm_sched_start_timeout(sched);
 	spin_unlock(&sched->job_list_lock);
 }
@@ -564,6 +567,7 @@ static void drm_sched_job_timedout(struct work_struct *work)
 		 * is parked at which point it's safe.
 		 */
 		list_del_init(&job->list);
+		kref_put(&sched->jobs_remaining, __drm_sched_fini);
 		spin_unlock(&sched->job_list_lock);
 
 		status = job->sched->ops->timedout_job(job);
@@ -637,6 +641,7 @@ void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad)
 			 */
 			spin_lock(&sched->job_list_lock);
 			list_del_init(&s_job->list);
+			kref_put(&sched->jobs_remaining, __drm_sched_fini);
 			spin_unlock(&sched->job_list_lock);
 
 			/*
@@ -1084,6 +1089,7 @@ drm_sched_get_finished_job(struct drm_gpu_scheduler *sched)
 	if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
 		/* remove job from pending_list */
 		list_del_init(&job->list);
+		kref_put(&sched->jobs_remaining, __drm_sched_fini);
 
 		/* cancel this job's TO timer */
 		cancel_delayed_work(&sched->work_tdr);
@@ -1303,6 +1309,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
 	init_waitqueue_head(&sched->job_scheduled);
 	INIT_LIST_HEAD(&sched->pending_list);
 	spin_lock_init(&sched->job_list_lock);
+	kref_init(&sched->jobs_remaining);
 	atomic_set(&sched->credit_count, 0);
 	INIT_DELAYED_WORK(&sched->work_tdr, drm_sched_job_timedout);
 	INIT_WORK(&sched->work_run_job, drm_sched_run_job_work);
@@ -1334,11 +1341,14 @@ EXPORT_SYMBOL(drm_sched_init);
  *
  * Tears down and cleans up the scheduler.
  */
-void drm_sched_fini(struct drm_gpu_scheduler *sched)
+static void __drm_sched_fini(struct kref *jobs_remaining)
 {
+	struct drm_gpu_scheduler *sched;
 	struct drm_sched_entity *s_entity;
 	int i;
 
+	sched = container_of(jobs_remaining, struct drm_gpu_scheduler, jobs_remaining);
+
 	drm_sched_wqueue_stop(sched);
 
 	for (i = DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++) {
@@ -1368,6 +1378,11 @@ void drm_sched_fini(struct drm_gpu_scheduler *sched)
 	kfree(sched->sched_rq);
 	sched->sched_rq = NULL;
 }
+
+void drm_sched_fini(struct drm_gpu_scheduler *sched)
+{
+	kref_put(&sched->jobs_remaining, __drm_sched_fini);
+}
 EXPORT_SYMBOL(drm_sched_fini);
 
 /**
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 5acc64954a88..b7fad8294861 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -29,6 +29,7 @@
 #include <linux/completion.h>
 #include <linux/xarray.h>
 #include <linux/workqueue.h>
+#include <linux/kref.h>
 
 #define MAX_WAIT_SCHED_ENTITY_Q_EMPTY msecs_to_jiffies(1000)
 
@@ -495,6 +496,9 @@ struct drm_sched_backend_ops {
  *                 waits on this wait queue until all the scheduled jobs are
  *                 finished.
  * @job_id_count: used to assign unique id to the each job.
+ * @jobs_remaining: submitted jobs take a refcount of the scheduler to prevent it
+ *		    from terminating before the last job has been removed from
+ *		    @pending_list.
  * @submit_wq: workqueue used to queue @work_run_job and @work_free_job
  * @timeout_wq: workqueue used to queue @work_tdr
  * @work_run_job: work which calls run_job op of each scheduler.
@@ -525,6 +529,7 @@ struct drm_gpu_scheduler {
 	struct drm_sched_rq             **sched_rq;
 	wait_queue_head_t		job_scheduled;
 	atomic64_t			job_id_count;
+	struct kref			jobs_remaining;
 	struct workqueue_struct		*submit_wq;
 	struct workqueue_struct		*timeout_wq;
 	struct work_struct		work_run_job;
-- 
2.46.0


