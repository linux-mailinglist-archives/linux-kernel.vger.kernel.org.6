Return-Path: <linux-kernel+bounces-273144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD489464ED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03601C2123B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7447134405;
	Fri,  2 Aug 2024 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/lXm4QQ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A379130A73
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633541; cv=none; b=Zze9uya9f1Ive/NqWM0X/ULsrbmxgxJuXqrT4PnKrfS9IuEzUvrJ8kUpuFowumW3Vvpxog7/9/EscEGtLs/0inB/TjduhNqyrY88xHDIasBiozTruLxYcA+X7Kb7TmciyicXmb2ZSbZZIXOFCieLAIDh5xi9+gkJ7TE+fVQzoeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633541; c=relaxed/simple;
	bh=chtPt3Qd/QCClCJtH9LDOn7fi+EhomKkL1gb4QGtD6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMgs4OklvRMk0mYA4p7yyAshJZ/7xgFScQU6QtmGQky2OHAGXg3p1C8OL0VXf3i9T6gZ7KIURirYrvAYVCiGxiQpo+WHmrjsQYMqdwSWxDhdhqkxLwcjmK7DK0iptp2BQhDBjHfyS+OzwdFnkpwh6CjNqo9NC0+M2lWcqihZVGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/lXm4QQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fed72d23a7so67387465ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 14:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722633540; x=1723238340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eg3Jf7CQlsGVCx0Cv7SMwuoZV0+hIO5F96qP6jZf+T8=;
        b=F/lXm4QQ5hjQYJVF6+Slod0rYAnk2c94kclGKL32Dz4viEv3/A2C2Netz7gDwwcTOJ
         /UJ8h1KsK/mjVgx4JMe/lfmTPQDxaVD6jj4ETZPpnxyLDjxFutYbt0g+nI1TcN5LlXFf
         u0sCEJDPcRaQVb+ko+0zE8GCRI010JaYWn9Uwjomci9Vgcteodut+bsxQtzYixpA1t9r
         Bs3daXAMkwrrmVCITCBWaGD9WsAE0N32lV4jkIY/eJcDS2HnFn8I2iJpSyKcmjX+X2Px
         HCMjhb00y9hDyFFPayj+GaveW+Bf7IkcNTySi5AFvYBgCC5dw/943t+yEBdDFcY4OKds
         C3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722633540; x=1723238340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eg3Jf7CQlsGVCx0Cv7SMwuoZV0+hIO5F96qP6jZf+T8=;
        b=TmVucf3lIHLinomTAiXJWqPAyR5PPDe7R14e7Z24rUMJDXWPycsx5XelhzwMBOYWJy
         ko67sEYDJL2ovh0BdZkXBaGQjeL7XcYfawml23BIKiZpIDTpt6bJ61X4dmrbI+e8p6/O
         VuAIbxdmoVUNCcWivsI5eDIcGuvaMQRvpNZ82MzgfxfgKhVk6BSx6piz029rL11MbBWk
         P0y5fTpvibp0+jrX9ZMtNMYbtLVkwsDmHro3X7V3MuGTJDwoW+359zh/Kbuxw5UfZTtA
         VDIMD54S1/aQ9OCqX9okR77+ZHofnZ8U+emdhyt6EZ/T+F/BeZcsdoCdUqzb5vexbeGa
         8dYA==
X-Gm-Message-State: AOJu0Yxhb6F7VeSWx+jOHmyMF/RiLX8VkPT5VLuID7qHv4NVeAmiyTUT
	8wiID8FlgJ0VcjmirthMvYuGijwF8vvswq4vXcMES45MYVJAqcd0LqJlsQ==
X-Google-Smtp-Source: AGHT+IEUngTQJEAGiDzxLJJbDfwgJQv4rR8InQWO/FUOsrjQ8VzxlRGpWXtNsPrvo35sbZmjvzU1Tg==
X-Received: by 2002:a17:902:e84b:b0:1fb:3474:9527 with SMTP id d9443c01a7336-1ff57294d10mr56840785ad.25.1722633539408;
        Fri, 02 Aug 2024 14:18:59 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5928ec05sm21692725ad.233.2024.08.02.14.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 14:18:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/4] workqueue: s/unbound_wq_update_pwq/update_unbound_pwqs/
Date: Fri,  2 Aug 2024 11:18:19 -1000
Message-ID: <20240802211850.1211737-4-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802211850.1211737-1-tj@kernel.org>
References: <20240802211850.1211737-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

unbound_wq_update_pwq() reads odd and is unwieldy. Rename to
update_unbound_pwqs().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bb96414f68b8..0f593f2884e0 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -433,8 +433,8 @@ static struct kmem_cache *pwq_cache;
 static struct wq_pod_type wq_pod_types[WQ_AFFN_NR_TYPES];
 static enum wq_affn_scope wq_affn_dfl = WQ_AFFN_CACHE;
 
-/* buf for wq_update_unbound_pod_attrs(), protected by CPU hotplug exclusion */
-static struct workqueue_attrs *unbound_wq_update_pwq_attrs_buf;
+/* buf for update_unbound_pwqs_attrs(), protected by CPU hotplug exclusion */
+static struct workqueue_attrs *update_unbound_pwqs_attrs_buf;
 
 static DEFINE_MUTEX(wq_pool_mutex);	/* protects pools and workqueues list */
 static DEFINE_MUTEX(wq_pool_attach_mutex); /* protects worker attach/detach */
@@ -5351,7 +5351,7 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
 }
 
 /**
- * unbound_wq_update_pwq - update a pwq slot for CPU hot[un]plug
+ * update_unbound_pwqs - update a pwq slot for CPU hot[un]plug
  * @wq: the target workqueue
  * @cpu: the CPU to update the pwq slot for
  *
@@ -5369,7 +5369,7 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
  * CPU_DOWN. If a workqueue user wants strict affinity, it's the user's
  * responsibility to flush the work item from CPU_DOWN_PREPARE.
  */
-static void unbound_wq_update_pwq(struct workqueue_struct *wq, int cpu)
+static void update_unbound_pwqs(struct workqueue_struct *wq, int cpu)
 {
 	struct pool_workqueue *old_pwq = NULL, *pwq;
 	struct workqueue_attrs *target_attrs;
@@ -5384,7 +5384,7 @@ static void unbound_wq_update_pwq(struct workqueue_struct *wq, int cpu)
 	 * Let's use a preallocated one.  The following buf is protected by
 	 * CPU hotplug exclusion.
 	 */
-	target_attrs = unbound_wq_update_pwq_attrs_buf;
+	target_attrs = update_unbound_pwqs_attrs_buf;
 
 	copy_workqueue_attrs(target_attrs, wq->unbound_attrs);
 	wqattrs_actualize_cpumask(target_attrs, wq_unbound_cpumask);
@@ -6589,7 +6589,7 @@ int workqueue_online_cpu(unsigned int cpu)
 			int tcpu;
 
 			for_each_cpu(tcpu, pt->pod_cpus[pt->cpu_pod[cpu]])
-				unbound_wq_update_pwq(wq, tcpu);
+				update_unbound_pwqs(wq, tcpu);
 
 			mutex_lock(&wq->mutex);
 			wq_update_node_max_active(wq);
@@ -6624,7 +6624,7 @@ int workqueue_offline_cpu(unsigned int cpu)
 			int tcpu;
 
 			for_each_cpu(tcpu, pt->pod_cpus[pt->cpu_pod[cpu]])
-				unbound_wq_update_pwq(wq, tcpu);
+				update_unbound_pwqs(wq, tcpu);
 
 			mutex_lock(&wq->mutex);
 			wq_update_node_max_active(wq);
@@ -6910,7 +6910,7 @@ static int wq_affn_dfl_set(const char *val, const struct kernel_param *kp)
 
 	list_for_each_entry(wq, &workqueues, list) {
 		for_each_cpu(cpu, wq_online_cpumask)
-			unbound_wq_update_pwq(wq, cpu);
+			update_unbound_pwqs(wq, cpu);
 	}
 
 	mutex_unlock(&wq_pool_mutex);
@@ -7656,8 +7656,8 @@ void __init workqueue_init_early(void)
 
 	pwq_cache = KMEM_CACHE(pool_workqueue, SLAB_PANIC);
 
-	unbound_wq_update_pwq_attrs_buf = alloc_workqueue_attrs();
-	BUG_ON(!unbound_wq_update_pwq_attrs_buf);
+	update_unbound_pwqs_attrs_buf = alloc_workqueue_attrs();
+	BUG_ON(!update_unbound_pwqs_attrs_buf);
 
 	/*
 	 * If nohz_full is enabled, set power efficient workqueue as unbound.
@@ -7922,12 +7922,12 @@ void __init workqueue_init_topology(void)
 
 	/*
 	 * Workqueues allocated earlier would have all CPUs sharing the default
-	 * worker pool. Explicitly call unbound_wq_update_pwq() on all workqueue
+	 * worker pool. Explicitly call update_unbound_pwqs() on all workqueue
 	 * and CPU combinations to apply per-pod sharing.
 	 */
 	list_for_each_entry(wq, &workqueues, list) {
 		for_each_online_cpu(cpu)
-			unbound_wq_update_pwq(wq, cpu);
+			update_unbound_pwqs(wq, cpu);
 		if (wq->flags & WQ_UNBOUND) {
 			mutex_lock(&wq->mutex);
 			wq_update_node_max_active(wq);
-- 
2.45.2


