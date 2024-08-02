Return-Path: <linux-kernel+bounces-273145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA749464EE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25251F22526
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863D26E5ED;
	Fri,  2 Aug 2024 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I57acPQM"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C767132116
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633543; cv=none; b=Pnf/sbXuT3tYJI/9JNF29iDdCljH4XitkxqdAR/Xm75uMQBcCwEi12vnoJIoIJzW1uCflI/HRdBqmIFgEKQ3rvGANG9jRtiWf+paiLOmhSHxc+o1RCw15W24hPuYkFFK+Bxt74wJf9E/GR+Z6Cd7Fpx1k3s0IPXwwkqTyslBswM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633543; c=relaxed/simple;
	bh=Q1Cq9rby3Qie3uLz1baJC5juiWsqgF+5yH4MWYUJ8sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHgLgsXllGznIguGENmOnxvq1JIL1ivywtKOHcPGJ5zjUSnlY9mmhbbZLkMEpiVclEeus9XD0/H7k1hfPQV4yEvTVtGelXzSOkea6TvBkqxv1S99EL0JrE0VKoFnNSh70n32qgb7qj1Sz0ErHRSTSd1xDAmfi77dztMdd12wNzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I57acPQM; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cfec641429so1568898a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 14:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722633541; x=1723238341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KydXdWp03ywEf6YPJHVTOhIz/2JRVaxRSFjdQ41v1QE=;
        b=I57acPQMCadu1Tnn8TXFL6rVwabGQP1Jha1r5NiORv2UToBJgH/ciShwPc7tpSb7/4
         dYFVQbJ7kOv+uAdi3zgvqUN1tl3h2pZB95l2o/PNL4e3b44BIusOz6toEGt6P6iUS/Zj
         Cj8roxkfQZP+a3hGCEpiZgzSuPMGO3qTqUDaW4WUgvAMCyz14tSdjAA+G0QC55W1/aUa
         upiMeH7YT7WIVUDGFTfJ6bDDRsqEMVkhA4KIZPGN4uIsB3kWnV/1/4rk6IySGWJULlEU
         i/UltNsWvJhpneytCFaVmpiOYl7mMp3I2tZN+cZdpbN58yaxeV3JDCO1zO9shhzZSVrG
         vpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722633541; x=1723238341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KydXdWp03ywEf6YPJHVTOhIz/2JRVaxRSFjdQ41v1QE=;
        b=cNyC6LMwge5Q9Uq7LOgYDLjNA+JLbzS7I9WzjSRI3iCENySTLUMwfJuDnB/Qq9Ii29
         RKBWnI1p3ycTa2p+Bc839MsQBFOiDq51fRKvS45IZg8uuxzysjJWqFHfSQllUEOPD1uK
         3IjiVH8jGlseVWlWyCVZy0gHN64CnfXk7Lrfq9An6SmlyGaxpY3iCSm3OPYDTFjE4C1q
         pzyL7P/WK/caDm9YpfCTEkU7oHUVhn/H2d8uOpw1dvP++v3ekO2kXmZPyxJDdNJ7ipmK
         6mIpjgB8l0OlAyQAuovHZvb0nx7KUwUXejcyE3Ksb5OOUFmFgf/XE7TdYi3bnDAjtobd
         vgag==
X-Gm-Message-State: AOJu0YzO/9x0g5pEXVsHDX90XInAwCFppOURvoHPX1tL+36+XGDOeEdi
	zXExZGXAQ8ruLocmaV7mg8Z9wMQ0oMEMwCEjHQy164tBn5y1a1mDGgjJKg==
X-Google-Smtp-Source: AGHT+IEPI1NINr5dZ/PAj5uBjssze7mZrbVed54y7OqcHL8HhHA4QY/Cgps490FoTQRWJfxxRN6xzQ==
X-Received: by 2002:a17:90a:fa11:b0:2c8:538d:95b7 with SMTP id 98e67ed59e1d1-2cff9547cb3mr5559611a91.32.1722633541367;
        Fri, 02 Aug 2024 14:19:01 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc45b3f0sm5672670a91.26.2024.08.02.14.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 14:19:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/4] workqueue: Make unbound pwq updates from CPU hotplug path asynchronous
Date: Fri,  2 Aug 2024 11:18:20 -1000
Message-ID: <20240802211850.1211737-5-tj@kernel.org>
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

84193c07105c ("workqueue: Generalize unbound CPU pods") and associated
commits added generalized affinity scope support. In the process, it added
synchronous calls to update_unbound_pwqs() from CPU hotplug path. When a CPU
comes online in an otherwise empty pod, this can lead to creation of a new
worker_pool involving creating new workers. Workqueues work correctly
without synchronous updates and there's no need to add additional fork
dependency to hotplug path. Make unbound pwq updates asynchronous.

This makes update_unbound_pwqs() called on all CPUs instead of the pod's
CPUs. However, when no-op, the call is pretty cheap and the additional calls
shouldn't be noticeable.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 72 ++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 37 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0f593f2884e0..33c6635bcb87 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6544,6 +6544,39 @@ static void restore_unbound_workers_cpumask(struct worker_pool *pool, int cpu)
 		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, &cpumask) < 0);
 }
 
+static void hotplug_update_unbound_pwqs_workfn(struct work_struct *work)
+{
+	struct workqueue_struct *wq;
+
+	mutex_lock(&wq_pool_mutex);
+
+	/*
+	 * CPUs have gone online or offline. Update the pod affinities of all
+	 * unbound workqueues. While not optimal, workqueues operate correctly
+	 * without these updates, so this can be done asynchronously, which
+	 * avoids adding fork dependency from CPU hotplug path.
+	 */
+	list_for_each_entry(wq, &workqueues, list) {
+		struct workqueue_attrs *attrs = wq->unbound_attrs;
+
+		if (attrs) {
+			int cpu;
+
+			for_each_possible_cpu(cpu)
+				update_unbound_pwqs(wq, cpu);
+
+			mutex_lock(&wq->mutex);
+			wq_update_node_max_active(wq);
+			mutex_unlock(&wq->mutex);
+		}
+	}
+
+	mutex_unlock(&wq_pool_mutex);
+}
+
+static DECLARE_WORK(hotplug_update_unbound_pwqs_work,
+		    hotplug_update_unbound_pwqs_workfn);
+
 int workqueue_prepare_cpu(unsigned int cpu)
 {
 	struct worker_pool *pool;
@@ -6560,7 +6593,6 @@ int workqueue_prepare_cpu(unsigned int cpu)
 int workqueue_online_cpu(unsigned int cpu)
 {
 	struct worker_pool *pool;
-	struct workqueue_struct *wq;
 	int pi;
 
 	mutex_lock(&wq_pool_mutex);
@@ -6580,22 +6612,7 @@ int workqueue_online_cpu(unsigned int cpu)
 		mutex_unlock(&wq_pool_attach_mutex);
 	}
 
-	/* update pod affinity of unbound workqueues */
-	list_for_each_entry(wq, &workqueues, list) {
-		struct workqueue_attrs *attrs = wq->unbound_attrs;
-
-		if (attrs) {
-			const struct wq_pod_type *pt = wqattrs_pod_type(attrs);
-			int tcpu;
-
-			for_each_cpu(tcpu, pt->pod_cpus[pt->cpu_pod[cpu]])
-				update_unbound_pwqs(wq, tcpu);
-
-			mutex_lock(&wq->mutex);
-			wq_update_node_max_active(wq);
-			mutex_unlock(&wq->mutex);
-		}
-	}
+	schedule_work(&hotplug_update_unbound_pwqs_work);
 
 	mutex_unlock(&wq_pool_mutex);
 	return 0;
@@ -6603,34 +6620,15 @@ int workqueue_online_cpu(unsigned int cpu)
 
 int workqueue_offline_cpu(unsigned int cpu)
 {
-	struct workqueue_struct *wq;
-
 	/* unbinding per-cpu workers should happen on the local CPU */
 	if (WARN_ON(cpu != smp_processor_id()))
 		return -1;
 
 	unbind_workers(cpu);
 
-	/* update pod affinity of unbound workqueues */
 	mutex_lock(&wq_pool_mutex);
-
 	cpumask_clear_cpu(cpu, wq_online_cpumask);
-
-	list_for_each_entry(wq, &workqueues, list) {
-		struct workqueue_attrs *attrs = wq->unbound_attrs;
-
-		if (attrs) {
-			const struct wq_pod_type *pt = wqattrs_pod_type(attrs);
-			int tcpu;
-
-			for_each_cpu(tcpu, pt->pod_cpus[pt->cpu_pod[cpu]])
-				update_unbound_pwqs(wq, tcpu);
-
-			mutex_lock(&wq->mutex);
-			wq_update_node_max_active(wq);
-			mutex_unlock(&wq->mutex);
-		}
-	}
+	schedule_work(&hotplug_update_unbound_pwqs_work);
 	mutex_unlock(&wq_pool_mutex);
 
 	return 0;
-- 
2.45.2


