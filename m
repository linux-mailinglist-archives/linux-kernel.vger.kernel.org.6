Return-Path: <linux-kernel+bounces-224062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3125911CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B3C1C21FA0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED2916B723;
	Fri, 21 Jun 2024 07:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qxtwxufi"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3C016B3B4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718954991; cv=none; b=fwqcOFtxfmv8hkyQchEIOSz+zY2gI2yX9VVaW3Kz3FVPKHTBspgBlx3nLTVALTMjz/cmeVpxdZB+Qq6h22U1U13uM9PJWu2fC+ygze4v/f4ZxPWj9WXEB8j9NiTtE15Dl4xbk83oD/QaposVYjX2OVytmlSBPbO1FJRDKvHc4K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718954991; c=relaxed/simple;
	bh=t+o9R0mNnCdZay49vfQTof+RAzBGQx5oc44gyH1HGnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tjD89UmS0IJT3+/tTN4rufmh6WXHpGJDAO3RMN5PZ1UA0LQf3ELCGVlbZmi23ceiEuca4CurXg+91Qh17xeugYpgYGuoUFEgPI7P/Z6RHDg1NxLAnl0oQfBVS24Q/RNDjnTTy2qV4xiMfD7R2vc7hzsK5+9e5kx7/Yju2vcdtxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qxtwxufi; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c5362c7c0bso1336476a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 00:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718954989; x=1719559789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6HUCjy2fc0wQf7MHhi0pPhuuSm7QAtjhyc2K8rqy84=;
        b=QxtwxufiPln94JjFTJgYRN1m0i6FL7MPn+kbyB+6gDg0s0g0aNBJqckmGvFgNYG3Bz
         Pk3zKBnvYsoZu3qCbThbEGHa+yiD7Gm1A7auymkMfOzJi7HpM2FAVh3PJ3pg/nGKr2ej
         ExlcfL/+2AJAr0y4I2TBrogTNF9cy0FLBIpjTtVa/7HEzymKnCs2woKwQ1wPYzixG7KO
         6OEAY18sABpKZfSZnzP8zpCTDFZPdCKoaMUqP8PcDNbjdnsiV0uWF0VgNOkcAEKOk0f0
         D0UOoZ8eG/WDVhDeDc2oHuB6Z8TRuaMgzbSB8PZcOezmi8lEijtJzy72RSbWPio0M6Dr
         e7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718954989; x=1719559789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6HUCjy2fc0wQf7MHhi0pPhuuSm7QAtjhyc2K8rqy84=;
        b=I66q8JCTtWAysnRjK3vKeod8xnsfqGZGpz6KPmaChP+WcILa8GGgP7TZFVlppFwmog
         XB8/9w+pPt9bYR0ejGMxpi8mJzRi5bUYhEb8lRJ6O6SyGUalZXITYnoYA2ZwPgMkre9R
         ffgcT49UCuT0AOZGpGXs5yf1D+55Tt89/voMeYsvUq8ICZJ+XIL7iiknHV48hTLFnfwR
         IK0EUAeBNwXkXZwtmVnLI5EXgo7wrEcUSXDEQXx/wrB1Uv/1MpQpYQKamYiSaxwZaJkA
         yrFtHhjB5BhF3Tc4ZeeWiaeYAdrcr9g7TYZ0EK9uKl/GGaxa3xygBkQfZNwmbie8VQ+M
         wAtg==
X-Gm-Message-State: AOJu0Yy0Ko+MxgcY2LwWxxij2PE4X9C71fyf9uzEvc7++OASykE0pEOS
	8kBt8x6OICUTShU237FvYHS0rS1KvRJkdzjK8SowJZnWSD/LBmmlG6ImlQ==
X-Google-Smtp-Source: AGHT+IHnpvVlCKjRyfRNqPE89ocyzJAtwCyhvKjGEPiIvBrRi8Ab+hy3P0d0WM7BrX5UcnSuBgY6YQ==
X-Received: by 2002:a17:90b:378f:b0:2c2:d0cc:3b9e with SMTP id 98e67ed59e1d1-2c7b5d95a9bmr6929812a91.46.1718954988905;
        Fri, 21 Jun 2024 00:29:48 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819db9506sm885063a91.44.2024.06.21.00.29.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2024 00:29:48 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 2/4] workqueue: Don't bind the rescuer in the last working cpu
Date: Fri, 21 Jun 2024 15:32:23 +0800
Message-Id: <20240621073225.3600-3-jiangshanlai@gmail.com>
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

So that when the rescuer is woken up next time, it will not interrupt
the last working cpu which might be busy on other crucial works but
have nothing to do with the rescuer's incoming works.

Cc: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index a0fb2f60e938..93b87ca63a7e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2684,6 +2684,17 @@ static void worker_attach_to_pool(struct worker *worker,
 	mutex_unlock(&wq_pool_attach_mutex);
 }
 
+static void unbind_worker(struct worker *worker)
+{
+	lockdep_assert_held(&wq_pool_attach_mutex);
+
+	kthread_set_per_cpu(worker->task, -1);
+	if (cpumask_intersects(wq_unbound_cpumask, cpu_active_mask))
+		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
+	else
+		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
+}
+
 /**
  * worker_detach_from_pool() - detach a worker from its pool
  * @worker: worker which is attached to its pool
@@ -2701,7 +2712,7 @@ static void worker_detach_from_pool(struct worker *worker)
 
 	mutex_lock(&wq_pool_attach_mutex);
 
-	kthread_set_per_cpu(worker->task, -1);
+	unbind_worker(worker);
 	list_del(&worker->node);
 	worker->pool = NULL;
 
@@ -2796,17 +2807,6 @@ static struct worker *create_worker(struct worker_pool *pool)
 	return NULL;
 }
 
-static void unbind_worker(struct worker *worker)
-{
-	lockdep_assert_held(&wq_pool_attach_mutex);
-
-	kthread_set_per_cpu(worker->task, -1);
-	if (cpumask_intersects(wq_unbound_cpumask, cpu_active_mask))
-		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
-	else
-		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
-}
-
 static void wake_dying_workers(struct list_head *cull_list)
 {
 	struct worker *worker;
-- 
2.19.1.6.gb485710b


