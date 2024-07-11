Return-Path: <linux-kernel+bounces-248832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33AA92E27E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E6328943E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C35D15B118;
	Thu, 11 Jul 2024 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAR/n9np"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F0D15B0F2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686804; cv=none; b=QgeL/OaozpYnjVkyHH0iip2x+8M2NQ8DsMHTHhayMNBECyQRJhyAYTCIOUjQTz4tAa9qtzEJFZh7E1tz3zcmEpPeDAWOghlbM8GhTyA6phN17AtABCKQcTjrAZr157PCyNpSvfYcG+diRge3ST62OINHqbDjxuJSRvmd1OyrEt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686804; c=relaxed/simple;
	bh=UL9Ym4ghZ4P1hcNZ1sjBqaf439ohb1DqkcuArs85SvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oVvCdGPf56PD2sncgzMFrN48BJP1Q65jpEZNRfqwFwYImyrUdDW5rzL8/q1CQcMSinOu0ehAUAiKpzFsU3Gcjm5tfBYPO2hkvyTK2EH7yvkwv7ShefgE/kzOwrQCxe/yzlbzsVy7sy1byzwV/7OyYpWo6eSD7W52lhmu1QBblK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAR/n9np; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c98b080012so512988a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720686802; x=1721291602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoB9n8vWkkLxgD9IA4qyD2Mvc7kqrqH6g6qZFUEn6Lc=;
        b=NAR/n9np0f8m6KDqIVFJCRpPQ8zjGAiFkgRdqgxPLs9hvy2tzUXmRpRLdx8G+jMjrh
         Lf8d2dRJJksEySBmLcnR6G4Da3Mn4hRmAV4Qfdrk7J4LLOuIVr5cQClBGLB3PnYkIcty
         PuTYKzyXQIFJlLvP0ewkSjeFUk5JU7VD81W2PXC4A1z34vGEZLTq5p6kxA+VRcrgc4SC
         //ph4qnJxFzUIMBmVTTOa3cxSjj0/MOwIa9rW7mkZ4fgw+n0n8omaqx6jytoMW2JECez
         c9F1Ti0qNwhFamJpSs9ed/QII3b1BtosM3WoeMUXo1fNyH+79Zhmgy2OWXR+z2PeprcL
         4b5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720686802; x=1721291602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoB9n8vWkkLxgD9IA4qyD2Mvc7kqrqH6g6qZFUEn6Lc=;
        b=Jj5PQ3cUQU/OItwkNXQc/h96giYvUaNub62z5sdkjRulqnV/kLrwZpqW+ZUkqq4vZi
         jAXHB7j4ni5pM9DUoUznHOCWHdLA4DpT3/zeqVG2m9ofjpIJw7Hh++EI9T5Da+oVtEjE
         VGYL4N0nQ0dpSZ/Uo64KlKu3O16LAcxl0GeB87qk4qHDvjNoLJ+Ylc4YP1JKvTtj4Z7C
         ObB6x+GCCs8hS5qyYYOnPy+nYSnZCZbkI6SKivRkeHUchtZKMyEiFu5LnMc50uTpx0WT
         JXLYKP2Wqb842PAJP1thYwoldauDfe4qy5nFwqZqRPj0QgPhjdUbGd6Xv7VcwbxRA2sa
         JUnQ==
X-Gm-Message-State: AOJu0Ywa6Ue9O4ornaxvMyX0XxUrm5RWn16EJ3ldJlgplDLP3MxBR4e9
	BRXw26w9KcUfdX4NA7UnWi6uQQsBUDcBO3AhnFnv6SzjMldVs1TRNo6MYg==
X-Google-Smtp-Source: AGHT+IE7xvCB435LadnhZhGsV045GEhu8HN53Oi5VkJ2sDh0SmOIv7YsJ//ii+BHlWvAoEL1M6b1hA==
X-Received: by 2002:a17:90a:db58:b0:2c9:8d5d:d175 with SMTP id 98e67ed59e1d1-2ca35d59cedmr5880020a91.48.1720686801934;
        Thu, 11 Jul 2024 01:33:21 -0700 (PDT)
Received: from localhost ([47.254.32.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c9e47983d4sm9165752a91.30.2024.07.11.01.33.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2024 01:33:21 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 7/7] workqueue: Rename wq_update_pod() to unbound_wq_update_pwq()
Date: Thu, 11 Jul 2024 16:35:47 +0800
Message-Id: <20240711083547.3981-8-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240711083547.3981-1-jiangshanlai@gmail.com>
References: <20240711083547.3981-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

What wq_update_pod() does is just to update the pwq of the specific
cpu.  Rename it and update the comments.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
Avoiding to call unbound_wq_update_pwq() in wq_affn_dfl_set() is in my
todo list.  So the comments assuming unbound_wq_update_pwq() only to be
called in cpu hotplug path is unchanged.

 kernel/workqueue.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 21e1c5787ba4..cd6f2950ef6c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -433,7 +433,7 @@ static struct wq_pod_type wq_pod_types[WQ_AFFN_NR_TYPES];
 static enum wq_affn_scope wq_affn_dfl = WQ_AFFN_CACHE;
 
 /* buf for wq_update_unbound_pod_attrs(), protected by CPU hotplug exclusion */
-static struct workqueue_attrs *wq_update_pod_attrs_buf;
+static struct workqueue_attrs *unbound_wq_update_pwq_attrs_buf;
 
 static DEFINE_MUTEX(wq_pool_mutex);	/* protects pools and workqueues list */
 static DEFINE_MUTEX(wq_pool_attach_mutex); /* protects worker attach/detach */
@@ -5351,13 +5351,12 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
 }
 
 /**
- * wq_update_pod - update pod affinity of a wq for CPU hot[un]plug
+ * unbound_wq_update_pwq - update a pwq slot for CPU hot[un]plug
  * @wq: the target workqueue
- * @cpu: the CPU to update pool association for
+ * @cpu: the CPU to update the pwq slot for
  *
  * This function is to be called from %CPU_DOWN_PREPARE, %CPU_ONLINE and
- * %CPU_DOWN_FAILED.  @cpu is being hot[un]plugged, update pod affinity of
- * @wq accordingly.
+ * %CPU_DOWN_FAILED.  @cpu is in the same pod of the CPU being hot[un]plugged.
  *
  *
  * If pod affinity can't be adjusted due to memory allocation failure, it falls
@@ -5370,7 +5369,7 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
  * CPU_DOWN. If a workqueue user wants strict affinity, it's the user's
  * responsibility to flush the work item from CPU_DOWN_PREPARE.
  */
-static void wq_update_pod(struct workqueue_struct *wq, int cpu)
+static void unbound_wq_update_pwq(struct workqueue_struct *wq, int cpu)
 {
 	struct pool_workqueue *old_pwq = NULL, *pwq;
 	struct workqueue_attrs *target_attrs;
@@ -5385,7 +5384,7 @@ static void wq_update_pod(struct workqueue_struct *wq, int cpu)
 	 * Let's use a preallocated one.  The following buf is protected by
 	 * CPU hotplug exclusion.
 	 */
-	target_attrs = wq_update_pod_attrs_buf;
+	target_attrs = unbound_wq_update_pwq_attrs_buf;
 
 	copy_workqueue_attrs(target_attrs, wq->unbound_attrs);
 	wqattrs_actualize_cpumask(target_attrs, wq_unbound_cpumask);
@@ -6590,7 +6589,7 @@ int workqueue_online_cpu(unsigned int cpu)
 			int tcpu;
 
 			for_each_cpu(tcpu, pt->pod_cpus[pt->cpu_pod[cpu]])
-				wq_update_pod(wq, tcpu);
+				unbound_wq_update_pwq(wq, tcpu);
 
 			mutex_lock(&wq->mutex);
 			wq_update_node_max_active(wq, -1);
@@ -6625,7 +6624,7 @@ int workqueue_offline_cpu(unsigned int cpu)
 			int tcpu;
 
 			for_each_cpu(tcpu, pt->pod_cpus[pt->cpu_pod[cpu]])
-				wq_update_pod(wq, tcpu);
+				unbound_wq_update_pwq(wq, tcpu);
 
 			mutex_lock(&wq->mutex);
 			wq_update_node_max_active(wq, cpu);
@@ -6913,9 +6912,8 @@ static int wq_affn_dfl_set(const char *val, const struct kernel_param *kp)
 	wq_affn_dfl = affn;
 
 	list_for_each_entry(wq, &workqueues, list) {
-		for_each_online_cpu(cpu) {
-			wq_update_pod(wq, cpu);
-		}
+		for_each_online_cpu(cpu)
+			unbound_wq_update_pwq(wq, cpu);
 	}
 
 	mutex_unlock(&wq_pool_mutex);
@@ -7654,8 +7652,8 @@ void __init workqueue_init_early(void)
 
 	pwq_cache = KMEM_CACHE(pool_workqueue, SLAB_PANIC);
 
-	wq_update_pod_attrs_buf = alloc_workqueue_attrs();
-	BUG_ON(!wq_update_pod_attrs_buf);
+	unbound_wq_update_pwq_attrs_buf = alloc_workqueue_attrs();
+	BUG_ON(!unbound_wq_update_pwq_attrs_buf);
 
 	/*
 	 * If nohz_full is enabled, set power efficient workqueue as unbound.
@@ -7920,12 +7918,12 @@ void __init workqueue_init_topology(void)
 
 	/*
 	 * Workqueues allocated earlier would have all CPUs sharing the default
-	 * worker pool. Explicitly call wq_update_pod() on all workqueue and CPU
-	 * combinations to apply per-pod sharing.
+	 * worker pool. Explicitly call unbound_wq_update_pwq() on all workqueue
+	 * and CPU combinations to apply per-pod sharing.
 	 */
 	list_for_each_entry(wq, &workqueues, list) {
 		for_each_online_cpu(cpu)
-			wq_update_pod(wq, cpu);
+			unbound_wq_update_pwq(wq, cpu);
 		if (wq->flags & WQ_UNBOUND) {
 			mutex_lock(&wq->mutex);
 			wq_update_node_max_active(wq, -1);
-- 
2.19.1.6.gb485710b


