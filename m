Return-Path: <linux-kernel+bounces-273143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C8A9464EC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462151F224F1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A275A130E27;
	Fri,  2 Aug 2024 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SK4G3o5m"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643EB7EF09
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633539; cv=none; b=VX4t8HVAsrG76BKm+4JiBBcsZ/h4OnTvNyhpkSoXTIgOcaewOOQZI5JS8xSv9Ab8KY8dPP70B2V+D2qM+EeFlXgCiOQVdA5ct2yG5NaEf4ZLBAmdHrHWGBhYPLY0iFSjvKAOmis9WSD9SbElsMmp2okGZxiHyi62R/+1cjY7oxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633539; c=relaxed/simple;
	bh=55UvKXOUNfD2P55pFZCBCvLEWMn0LNnKd6QpKTWroTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdZ0+nlXIOjcKLocACu7RTF17Fxg3a4c1Yhj65ltfOPb0TuUMh5356cVHTWcfAR3e1psrIXufYob7Ay68HuVlPS4EbrsUfCgG3OqD18QBV5KKg/tm9Cn7xGigG/tUTOpM0j9RLsv5hiSTDO6F0/XdK2RmYVeaiqp//b8nXU3mzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SK4G3o5m; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cb510cd097so6415579a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 14:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722633538; x=1723238338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1Ad27KRscKd9GPHyW1kSMPNQ2qL2zXe6HWVoUPyJA8=;
        b=SK4G3o5mN77sJl+utWKZe4EGz+RoA4EVHVm/EwxiZRnw53xn4WW1kFq0VFZ8r9RPxP
         vZ7HEXs6HOjZK0U59MG/cE/e6yGjXKX2RnDrNxUhi+djhSy+UHD7VgB0ClPcibnprwpa
         bmi9bxUUopuQbW0TJNLlAoPmb1BIVx7bvAI5I5wQCjdsmqK3RiLvrYWaxzgGbykkEtuw
         yrNR2+76nI1FjFLRwp85YVQsGl0pHkNo76wOgW07xESAQ9PZCgATg50boMmgRe35wcig
         fQRLs8WXZUKJoruSFYXTF06f+WXnB/2rQg26lhVFbaNeK82VRAuXt2PvTgtRbXeTQScq
         1rPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722633538; x=1723238338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N1Ad27KRscKd9GPHyW1kSMPNQ2qL2zXe6HWVoUPyJA8=;
        b=BaqyzrGEQLDIL7T/M+nVnd/ti8ZuIbHhKxzTkY+9hrJje/A/YUn5eDItpOhZcLoYX9
         SfH/aYlrI4S/WvK0/tBDgxe2KvvGAPkrsJxZ6Xpqobty7+G475+f+brkxo86syJvuf2c
         f1ZRJhG88JwYkMr1Kuy3gUwZ/8DVHp6Zf4+/LNHxPZGB9gqFZeSVkf8MMMIJv5QKcLOe
         3UaOhaS89Ke0hA1U2jB6XFOETg7ML4NdX3rZXXgZpL2OE7wBLAdO7QLRUypSWMNr8B2/
         uwDWjs75ysostKGjRLxP7b8Tt/k38tTOoB9/c+X/rtx/36a4ioSHHBOyTPQAuqVmoHYh
         pDtQ==
X-Gm-Message-State: AOJu0YxN7+o0UtiGhX865WMiFw85j3xhuI2UTAID55Is/3aT1LtRjIVA
	NTxuscDIVxfuaHPW9Q9FG8hkQegUwaPjAKJQkJSfqGmr6YY6yWob
X-Google-Smtp-Source: AGHT+IHMowt+j+sRtMYguluy6AHxPXLOI4wSkrPzmG5Zu/eKrpDVSs+1i+1QktV1qhbGFYTc9pvTHA==
X-Received: by 2002:a17:90a:77ca:b0:2ca:4fca:2892 with SMTP id 98e67ed59e1d1-2cff93d4772mr5860997a91.7.1722633537625;
        Fri, 02 Aug 2024 14:18:57 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffb0c67c1sm2230578a91.31.2024.08.02.14.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 14:18:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/4] workqueue: Make wq_update_node_max_active() use wq_online_cpumask
Date: Fri,  2 Aug 2024 11:18:18 -1000
Message-ID: <20240802211850.1211737-3-tj@kernel.org>
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

As, while a CPU is going down, wq_update_node_max_active() is called with
the CPU still online, it takes @off_cpu so that the CPU can be treated as
offline. This is cumbersome and no longer necessary with the recently added
wq_online_cpumask which is cleared before wq_update_node_max_active() is
called.

Make wq_update_node_max_active() use wq_online_cpumask and drop @off_cpu.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 6571e1f3c835..bb96414f68b8 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1566,13 +1566,12 @@ static struct wq_node_nr_active *wq_node_nr_active(struct workqueue_struct *wq,
 /**
  * wq_update_node_max_active - Update per-node max_actives to use
  * @wq: workqueue to update
- * @off_cpu: CPU that's going down, -1 if a CPU is not going down
  *
  * Update @wq->node_nr_active[]->max. @wq must be unbound. max_active is
  * distributed among nodes according to the proportions of numbers of online
  * cpus. The result is always between @wq->min_active and max_active.
  */
-static void wq_update_node_max_active(struct workqueue_struct *wq, int off_cpu)
+static void wq_update_node_max_active(struct workqueue_struct *wq)
 {
 	struct cpumask *effective = unbound_effective_cpumask(wq);
 	int min_active = READ_ONCE(wq->min_active);
@@ -1584,12 +1583,7 @@ static void wq_update_node_max_active(struct workqueue_struct *wq, int off_cpu)
 	if (!wq_topo_initialized)
 		return;
 
-	if (off_cpu >= 0 && !cpumask_test_cpu(off_cpu, effective))
-		off_cpu = -1;
-
-	total_cpus = cpumask_weight_and(effective, cpu_online_mask);
-	if (off_cpu >= 0)
-		total_cpus--;
+	total_cpus = cpumask_weight_and(effective, wq_online_cpumask);
 
 	/* If all CPUs of the wq get offline, use the default values */
 	if (unlikely(!total_cpus)) {
@@ -1601,11 +1595,12 @@ static void wq_update_node_max_active(struct workqueue_struct *wq, int off_cpu)
 	}
 
 	for_each_node(node) {
-		int node_cpus;
+		int cpu, node_cpus = 0;
 
-		node_cpus = cpumask_weight_and(effective, cpumask_of_node(node));
-		if (off_cpu >= 0 && cpu_to_node(off_cpu) == node)
-			node_cpus--;
+		/* count the number of effective online CPUs in the node */
+		for_each_cpu_and(cpu, effective, cpumask_of_node(node))
+			if (cpumask_test_cpu(cpu, wq_online_cpumask))
+				node_cpus++;
 
 		wq_node_nr_active(wq, node)->max =
 			clamp(DIV_ROUND_UP(max_active * node_cpus, total_cpus),
@@ -5298,7 +5293,7 @@ static void apply_wqattrs_commit(struct apply_wqattrs_ctx *ctx)
 	ctx->dfl_pwq = install_unbound_pwq(ctx->wq, -1, ctx->dfl_pwq);
 
 	/* update node_nr_active->max */
-	wq_update_node_max_active(ctx->wq, -1);
+	wq_update_node_max_active(ctx->wq);
 
 	/* rescuer needs to respect wq cpumask changes */
 	if (ctx->wq->rescuer)
@@ -5583,7 +5578,7 @@ static void wq_adjust_max_active(struct workqueue_struct *wq)
 	WRITE_ONCE(wq->min_active, new_min);
 
 	if (wq->flags & WQ_UNBOUND)
-		wq_update_node_max_active(wq, -1);
+		wq_update_node_max_active(wq);
 
 	if (new_max == 0)
 		return;
@@ -6597,7 +6592,7 @@ int workqueue_online_cpu(unsigned int cpu)
 				unbound_wq_update_pwq(wq, tcpu);
 
 			mutex_lock(&wq->mutex);
-			wq_update_node_max_active(wq, -1);
+			wq_update_node_max_active(wq);
 			mutex_unlock(&wq->mutex);
 		}
 	}
@@ -6632,7 +6627,7 @@ int workqueue_offline_cpu(unsigned int cpu)
 				unbound_wq_update_pwq(wq, tcpu);
 
 			mutex_lock(&wq->mutex);
-			wq_update_node_max_active(wq, cpu);
+			wq_update_node_max_active(wq);
 			mutex_unlock(&wq->mutex);
 		}
 	}
@@ -7935,7 +7930,7 @@ void __init workqueue_init_topology(void)
 			unbound_wq_update_pwq(wq, cpu);
 		if (wq->flags & WQ_UNBOUND) {
 			mutex_lock(&wq->mutex);
-			wq_update_node_max_active(wq, -1);
+			wq_update_node_max_active(wq);
 			mutex_unlock(&wq->mutex);
 		}
 	}
-- 
2.45.2


