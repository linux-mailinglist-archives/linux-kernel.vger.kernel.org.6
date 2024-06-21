Return-Path: <linux-kernel+bounces-224063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FBF911CC7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C9D7B2218D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1223116D303;
	Fri, 21 Jun 2024 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kC84yBZi"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C255616B748
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718954996; cv=none; b=IDRAX8pzo2e9u2ymyKcoVHfcuMLLGtfm6mxh5hwpGjO8TOVf8EYz/uuhGtDWZ4j6dKZmGbTYUeU0ddsNvSIP2B9HHB5f939fyY6FWATmk7Q/VoJF/dOuOPf23jIKxBcphsUHQwBcgBTGtTYycqJ0WeAc9d4hNzxisME56PiCh3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718954996; c=relaxed/simple;
	bh=FZc60W1D4prLgx9i7Jc3Zhf9Nh67kWwv4Lplh2hE0Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d4YazM80S7m0zYmEajlcfQ6LgrlmMdlDYCE9Hi9u588cp6LdfoPrdvbWNY4bEen/T2fW+9naH9ARyH0P6PzGG8D0G5Gj3BZ0BpIgu2qWu9ZgnI+Acpk8SCOUFSlU+J9iIFI6ZcyCZ2ponWnlQO0hpaCX6m6vkqpXp8hOIyPpHc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kC84yBZi; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d4430b8591so892664b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 00:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718954993; x=1719559793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DA4WJliprSRDwpu0SuE5J5N4pXsY0CSpLvln4uW1pg=;
        b=kC84yBZi3BL5SmayDPIADrSROJs3tTshvaRfVTTfLHZZPblWNrPPVSxhpSt47Gp94P
         MksOQo7FP4vMOtAfFTKs1Np5k/5re3Tc0vSLlH7Z7aC2H0g1ec5v8YGe8n5KZGenqtz+
         UDCmJBmHtUPpum6dJuaZOPHRUcqmimX13np4dOH/hvE7PIPS54mRP2SCoaWZqHTeC/IQ
         xtkaVW65V0rj/3R6TakKJO2mJWs4a8DxdC7U9kC1IJ4Hue+tmfhvk6Lvwk9oL5NW+Cmv
         nhJ/utnKXxbiGGGsxUtuQ8ip/ffs+GbQQvZVWwmzYt03gobz0VmXs/Jm9pAv2C6MRTlb
         RNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718954993; x=1719559793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DA4WJliprSRDwpu0SuE5J5N4pXsY0CSpLvln4uW1pg=;
        b=plFtzYASsQftJqa6cu1pjT//Hl82eE0FamGDMnJzURPonONnrio0Hpfl/2XkUU0WPm
         hp+p9Y+AEwry/Kh2Bi6cgeZBqrTz7RdkNsTzi2R99iP3PpUPzXZYIdXJS7PFGPppi5Pf
         65IEPQy8AH0dX3kACvg9G3LM1cG7OoVTVzrvXfJZzXpLVYbUpeP9JTHf/wj9+yYAZJWR
         GSkigwzPtxrBeAI3q0D0ebMTyZtLGOZ/u4qNpMIoH3/c67vY21RIlT+4gH5DPM38rAZ1
         7z0wrNzkG3ORTecJNz3AiY0OwLg+k0EZIdv7m8C2TPqUezedTg2nJGQVVqEN6emazhjY
         1N4g==
X-Gm-Message-State: AOJu0YyPA8OXgbZjsK36ZeVv+mHKTas6+/KAqporaiVWfReaw3510K8m
	gxaVMYfO9hsXSHKgGLcFOQ4Q7kHKruGvyjFWjB9/lS3qNSKdoynMws8dhA==
X-Google-Smtp-Source: AGHT+IEc+rVG2JNPVSkQ2x7EL2wuL8Atz66faM4+WF1ldSAzcZ5e2TaCJ1vindP1viHUywzsKT4AJw==
X-Received: by 2002:a05:6808:13d6:b0:3d2:1c91:86e8 with SMTP id 5614622812f47-3d51baea0c7mr8575872b6e.45.1718954993173;
        Fri, 21 Jun 2024 00:29:53 -0700 (PDT)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706511945f8sm765540b3a.69.2024.06.21.00.29.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2024 00:29:52 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 3/4] workqueue: Detach workers directly in idle_cull_fn()
Date: Fri, 21 Jun 2024 15:32:24 +0800
Message-Id: <20240621073225.3600-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240621073225.3600-1-jiangshanlai@gmail.com>
References: <20240621073225.3600-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

The code to kick off the destruction of workers is now in a process
context (idle_cull_fn()), and the detaching of a worker is not required
to be inside the worker thread now, so just do the detaching directly
in idle_cull_fn().

wake_dying_workers() is renamed to detach_dying_workers() and the unneeded
wakeup in wake_dying_workers() is also removed.

Cc: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 45 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 93b87ca63a7e..e9ca42ef425a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2695,6 +2695,16 @@ static void unbind_worker(struct worker *worker)
 		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
 }
 
+
+static void detach_worker(struct worker *worker)
+{
+	lockdep_assert_held(&wq_pool_attach_mutex);
+
+	unbind_worker(worker);
+	list_del(&worker->node);
+	worker->pool = NULL;
+}
+
 /**
  * worker_detach_from_pool() - detach a worker from its pool
  * @worker: worker which is attached to its pool
@@ -2711,11 +2721,7 @@ static void worker_detach_from_pool(struct worker *worker)
 	WARN_ON_ONCE(pool->flags & POOL_BH);
 
 	mutex_lock(&wq_pool_attach_mutex);
-
-	unbind_worker(worker);
-	list_del(&worker->node);
-	worker->pool = NULL;
-
+	detach_worker(worker);
 	mutex_unlock(&wq_pool_attach_mutex);
 
 	/* clear leftover flags without pool->lock after it is detached */
@@ -2807,24 +2813,12 @@ static struct worker *create_worker(struct worker_pool *pool)
 	return NULL;
 }
 
-static void wake_dying_workers(struct list_head *cull_list)
+static void detach_dying_workers(struct list_head *cull_list)
 {
 	struct worker *worker;
 
-	list_for_each_entry(worker, cull_list, entry) {
-		unbind_worker(worker);
-		/*
-		 * If the worker was somehow already running, then it had to be
-		 * in pool->idle_list when set_worker_dying() happened or we
-		 * wouldn't have gotten here.
-		 *
-		 * Thus, the worker must either have observed the WORKER_DIE
-		 * flag, or have set its state to TASK_IDLE. Either way, the
-		 * below will be observed by the worker and is safe to do
-		 * outside of pool->lock.
-		 */
-		wake_up_process(worker->task);
-	}
+	list_for_each_entry(worker, cull_list, entry)
+		detach_worker(worker);
 }
 
 static void reap_dying_workers(struct list_head *cull_list)
@@ -2930,9 +2924,9 @@ static void idle_cull_fn(struct work_struct *work)
 
 	/*
 	 * Grabbing wq_pool_attach_mutex here ensures an already-running worker
-	 * cannot proceed beyong worker_detach_from_pool() in its self-destruct
-	 * path. This is required as a previously-preempted worker could run after
-	 * set_worker_dying() has happened but before wake_dying_workers() did.
+	 * cannot proceed beyong set_pf_worker() in its self-destruct path.
+	 * This is required as a previously-preempted worker could run after
+	 * set_worker_dying() has happened but before detach_dying_workers() did.
 	 */
 	mutex_lock(&wq_pool_attach_mutex);
 	raw_spin_lock_irq(&pool->lock);
@@ -2953,7 +2947,7 @@ static void idle_cull_fn(struct work_struct *work)
 	}
 
 	raw_spin_unlock_irq(&pool->lock);
-	wake_dying_workers(&cull_list);
+	detach_dying_workers(&cull_list);
 	mutex_unlock(&wq_pool_attach_mutex);
 
 	reap_dying_workers(&cull_list);
@@ -3336,7 +3330,6 @@ static int worker_thread(void *__worker)
 
 		set_task_comm(worker->task, "kworker/dying");
 		ida_free(&pool->worker_ida, worker->id);
-		worker_detach_from_pool(worker);
 		WARN_ON_ONCE(!list_empty(&worker->entry));
 		return 0;
 	}
@@ -4921,7 +4914,7 @@ static void put_unbound_pool(struct worker_pool *pool)
 	WARN_ON(pool->nr_workers || pool->nr_idle);
 	raw_spin_unlock_irq(&pool->lock);
 
-	wake_dying_workers(&cull_list);
+	detach_dying_workers(&cull_list);
 
 	mutex_unlock(&wq_pool_attach_mutex);
 
-- 
2.19.1.6.gb485710b


