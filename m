Return-Path: <linux-kernel+bounces-312658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D97969972
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E76A1C233E6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392D619F42D;
	Tue,  3 Sep 2024 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRqluqFU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC88B1A0BF0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356730; cv=none; b=VCnCntEu1wAfEw5rBJtYsVZrTBrxsG+gTbFueB5l4NrmyZT0clD5R6ci2PjTKk+L3JSy19kIFqnglT03gwd0Byhly31MdF++Jt4T3iMs2zFP3P8BnH3tIPi2Q9SmhkEzav6UScCFBnt6aPnGGP/yLfjK3ov9xRJDdSgWEWDa5uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356730; c=relaxed/simple;
	bh=6BuxvUMrHrx1Ij8CA8rsytPwpW//ly0JiqY2vNwkwVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y02yluo+NhqayaR8WYBtI4pByKVXXwAvPsM47yj214acXrPr58KWzrk9GZyhNRrLaefuG8kgK72JoXomZjCIOGVUAsJ09v9tjpqMpLIMZ3dPiRgRYoTddy7+R96jKt1Mm+pSccmx/zoIqu9GVYs+la3TmeW/A8Dmx+wKzw2dpcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LRqluqFU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725356727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Md4YqyfH6OnnfGUBGnJGP7tmG/KDMn06qYkEJbCOX6E=;
	b=LRqluqFUL6liJ9jakGGkS0rQNV4A6vr1w+qvSy0OLxvH/h8tC7ck957fOsZ/vHXLx6EVnY
	zPJyAJKO51KGrp9p5Ezder1yKY69Wwh9Qvi6fivvBfUcRXrrDkh4nbFJLiDs0T38wrv6BJ
	tfbU+TGBDgDeAE6CiHpIU6FO55AZab4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-uP7NXnQRP1ms9Y_TL2wlJQ-1; Tue, 03 Sep 2024 05:45:26 -0400
X-MC-Unique: uP7NXnQRP1ms9Y_TL2wlJQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42bbad819d0so38057885e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 02:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725356725; x=1725961525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Md4YqyfH6OnnfGUBGnJGP7tmG/KDMn06qYkEJbCOX6E=;
        b=NJtLj4BZyoV7W74An1TxSEU9jMa3t+r0IANO/JwH9DHWhOBm4Kr0UuBSf7+ZdJJUNG
         IhPAbeHcfCopvYObzhVK5rILOY5Lst7mX59pOrKG+9suKSKrTOIdmLogdKolX7m9L4Dq
         2y5u+4+0NIsXG6/IUIE3aesMxHsW3DoAbnph4btnVlqKi3ubKUm8KnG/QXRNpJ8XRSwY
         NCjf76JAJ0MijIEFZk4Re9+FjaPlQrWohrO3ejq5eb9YrHjGNNtcD6igIqxtZvMf2rbF
         nnFFbsmAoC9fQKClOKQuPfluJKla/d7O7SmMZgFpTN0brZt8YJZyVMOm+A3oD4XAiT6t
         W1fA==
X-Forwarded-Encrypted: i=1; AJvYcCUmBb7Qkw2co4QdTG+lviauqcvuph1PnWJNVk9RR23nZV3CtWd48qUng1PGq+8qabOoNP3v2zLvLsoyBYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8c4dY9OeRSAHSbGBKzJeGBw9qKLNqg3516wpfJeUn7jhBVkII
	c0fTxv1/i86t7yaByj31jPXY7ngmFBvDC/xtFfVPw0E+/7FXJbIkJclTzZ7jTKqCZep37E1IhJr
	48vIq6oLhLy226isH+5Wy304wjusLFBBOLvGGDhv2sj1/ef73acH48Rfr2UONVA==
X-Received: by 2002:a05:600c:5006:b0:426:6455:f124 with SMTP id 5b1f17b1804b1-42bbb0a909dmr99081125e9.0.1725356725112;
        Tue, 03 Sep 2024 02:45:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7Ud6fZG99UNyJTjNPp3ey1FIBQb11K+Fj2L2yNLjsGXpWsRIKZUoGIY3LDKfc6dWLuosujg==
X-Received: by 2002:a05:600c:5006:b0:426:6455:f124 with SMTP id 5b1f17b1804b1-42bbb0a909dmr99080645e9.0.1725356724038;
        Tue, 03 Sep 2024 02:45:24 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42c7b628dd4sm100705125e9.11.2024.09.03.02.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 02:45:23 -0700 (PDT)
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
Subject: [RFC PATCH] drm/sched: Fix teardown leaks with waitqueue
Date: Tue,  3 Sep 2024 11:44:47 +0200
Message-ID: <20240903094446.29797-2-pstanner@redhat.com>
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

One way to solves this is to implement a waitqueue that drm_sched_fini()
blocks on until the pending_list has become empty.

Add a waitqueue to struct drm_gpu_scheduler. Wake up waiters once the
pending_list becomes empty. Wait in drm_sched_fini() for that to happen.

Suggested-by: Danilo Krummrich <dakr@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Hi all,

since the scheduler has many stake holders, I want this solution
discussed as an RFC first.

This version here has IMO the advantage (and disadvantage...) that it
blocks infinitly if the driver messed up the clean up, so problems
might become more visible than the refcount solution I proposed in
parallel.

Cheers,
P.
---
 drivers/gpu/drm/scheduler/sched_main.c | 40 ++++++++++++++++++++++++++
 include/drm/gpu_scheduler.h            |  4 +++
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 7e90c9f95611..200fa932f289 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -564,6 +564,13 @@ static void drm_sched_job_timedout(struct work_struct *work)
 		 * is parked at which point it's safe.
 		 */
 		list_del_init(&job->list);
+
+		/*
+		 * Inform tasks blocking in drm_sched_fini() that it's now safe to proceed.
+		 */
+		if (list_empty(&sched->pending_list))
+			wake_up(&sched->job_list_waitque);
+
 		spin_unlock(&sched->job_list_lock);
 
 		status = job->sched->ops->timedout_job(job);
@@ -584,6 +591,15 @@ static void drm_sched_job_timedout(struct work_struct *work)
 		drm_sched_start_timeout_unlocked(sched);
 }
 
+static bool drm_sched_no_jobs_pending(struct drm_gpu_scheduler *sched)
+{
+	/*
+	 * For list_empty() to work without a lock.
+	 */
+	rmb();
+	return list_empty(&sched->pending_list);
+}
+
 /**
  * drm_sched_stop - stop the scheduler
  *
@@ -659,6 +675,12 @@ void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad)
 		}
 	}
 
+	/*
+	 * Inform tasks blocking in drm_sched_fini() that it's now safe to proceed.
+	 */
+	if (drm_sched_no_jobs_pending(sched))
+		wake_up(&sched->job_list_waitque);
+
 	/*
 	 * Stop pending timer in flight as we rearm it in  drm_sched_start. This
 	 * avoids the pending timeout work in progress to fire right away after
@@ -1085,6 +1107,12 @@ drm_sched_get_finished_job(struct drm_gpu_scheduler *sched)
 		/* remove job from pending_list */
 		list_del_init(&job->list);
 
+		/*
+		 * Inform tasks blocking in drm_sched_fini() that it's now safe to proceed.
+		 */
+		if (list_empty(&sched->pending_list))
+			wake_up(&sched->job_list_waitque);
+
 		/* cancel this job's TO timer */
 		cancel_delayed_work(&sched->work_tdr);
 		/* make the scheduled timestamp more accurate */
@@ -1303,6 +1331,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
 	init_waitqueue_head(&sched->job_scheduled);
 	INIT_LIST_HEAD(&sched->pending_list);
 	spin_lock_init(&sched->job_list_lock);
+	init_waitqueue_head(&sched->job_list_waitque);
 	atomic_set(&sched->credit_count, 0);
 	INIT_DELAYED_WORK(&sched->work_tdr, drm_sched_job_timedout);
 	INIT_WORK(&sched->work_run_job, drm_sched_run_job_work);
@@ -1333,12 +1362,23 @@ EXPORT_SYMBOL(drm_sched_init);
  * @sched: scheduler instance
  *
  * Tears down and cleans up the scheduler.
+ *
+ * Note that this function blocks until the fences returned by
+ * backend_ops.run_job() have been signalled.
  */
 void drm_sched_fini(struct drm_gpu_scheduler *sched)
 {
 	struct drm_sched_entity *s_entity;
 	int i;
 
+	/*
+	 * Jobs that have neither been scheduled or which have timed out are
+	 * gone by now, but jobs that have been submitted through
+	 * backend_ops.run_job() and have not yet terminated are still pending.
+	 *
+	 * Wait for the pending_list to become empty to avoid leaking those jobs.
+	 */
+	wait_event(sched->job_list_waitque, drm_sched_no_jobs_pending(sched));
 	drm_sched_wqueue_stop(sched);
 
 	for (i = DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++) {
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 5acc64954a88..bff092784405 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -29,6 +29,7 @@
 #include <linux/completion.h>
 #include <linux/xarray.h>
 #include <linux/workqueue.h>
+#include <linux/wait.h>
 
 #define MAX_WAIT_SCHED_ENTITY_Q_EMPTY msecs_to_jiffies(1000)
 
@@ -503,6 +504,8 @@ struct drm_sched_backend_ops {
  *            timeout interval is over.
  * @pending_list: the list of jobs which are currently in the job queue.
  * @job_list_lock: lock to protect the pending_list.
+ * @job_list_waitque: a waitqueue for drm_sched_fini() to block on until all
+ *		      pending jobs have been finished.
  * @hang_limit: once the hangs by a job crosses this limit then it is marked
  *              guilty and it will no longer be considered for scheduling.
  * @score: score to help loadbalancer pick a idle sched
@@ -532,6 +535,7 @@ struct drm_gpu_scheduler {
 	struct delayed_work		work_tdr;
 	struct list_head		pending_list;
 	spinlock_t			job_list_lock;
+	wait_queue_head_t		job_list_waitque;
 	int				hang_limit;
 	atomic_t                        *score;
 	atomic_t                        _score;
-- 
2.46.0


