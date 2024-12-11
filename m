Return-Path: <linux-kernel+bounces-441550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF299ED010
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF0816ADA4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2291DDC3A;
	Wed, 11 Dec 2024 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKitzywD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472761DDC2C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931659; cv=none; b=VhNuRvGQXU2Wo/Y3LfY4j1vArGHNUvaLORTURL33hC252n6B2n4o3Nb4tnn80VCkrZXuGIzpHb1h7f10geD1LELJyt9tAPrXzTxrVHHCi3DfkcofWzIE8yIoV/kPIOa/1JBqKQPaIqbe3JGWEkt1hJkRS1vp2Hu6eHxR9Xem4aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931659; c=relaxed/simple;
	bh=4bqmk1ZZmgmxj/TbraN0t20xxY3kUbWb7QrpoxYbtKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JR5xFc7RYnN8jvCuCh+PPH56FO7EAs8zkCgcvRZTmA7ZhK5SJJcg9dJyqe34Rlewo1OUqmdmFQBtweuEReHFkOm6CN01vleGuY1zCEDahuLccnKS7ZZg5rVebBAIvEuXLEqdzMG3Kner5e/XqV4DSarEyzchFCSuGbdsQ8cVeRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKitzywD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8422BC4CED4;
	Wed, 11 Dec 2024 15:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931658;
	bh=4bqmk1ZZmgmxj/TbraN0t20xxY3kUbWb7QrpoxYbtKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lKitzywDZ+v+cmijquvl1UD3N4yfyc1uaOkpU9Z7d3NHaNM3fogSiGSuX9WGgsEFd
	 6tGsaIt9XIt/89SDkHJT9MlCyb+mQFiQ7DL/e3AnglhgONC3W9Seysw821MQuDgYzN
	 mgSeeE3kyfUAA4lntca09eQeamNUZKdvkmh8cnSrKY5RjCUTac9GGFXKN/PQmBZ4FG
	 OLr+EpCuXi89/ywbFvXATYz7Im+Im5zJVgQRc4mrxmprzYLl+/7HmjDFoX9yy49YRe
	 J+R8HbUjECos78phhw9ETl2B8rYLnzeVH9ppiGXjdKabluDh9LTPR45Ch7pYnyzGtM
	 Japke0nI9tgsA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Matt Wu <wuqiang.matt@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 08/19] lib: test_objpool: Use kthread_run_on_cpu()
Date: Wed, 11 Dec 2024 16:40:21 +0100
Message-ID: <20241211154035.75565-9-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241211154035.75565-1-frederic@kernel.org>
References: <20241211154035.75565-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the proper API instead of open coding it.

Reviewed-by: Matt Wu <wuqiang.matt@bytedance.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 lib/test_objpool.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/lib/test_objpool.c b/lib/test_objpool.c
index 5a3f6961a70f..896c0131c9a8 100644
--- a/lib/test_objpool.c
+++ b/lib/test_objpool.c
@@ -371,14 +371,10 @@ static int ot_start_sync(struct ot_test *test)
 		if (!cpu_online(cpu))
 			continue;
 
-		work = kthread_create_on_node(ot_thread_worker, item,
-				cpu_to_node(cpu), "ot_worker_%d", cpu);
-		if (IS_ERR(work)) {
+		work = kthread_run_on_cpu(ot_thread_worker, item,
+					  cpu, "ot_worker_%d");
+		if (IS_ERR(work))
 			pr_err("failed to create thread for cpu %d\n", cpu);
-		} else {
-			kthread_bind(work, cpu);
-			wake_up_process(work);
-		}
 	}
 
 	/* wait a while to make sure all threads waiting at start line */
@@ -562,14 +558,9 @@ static int ot_start_async(struct ot_test *test)
 		if (!cpu_online(cpu))
 			continue;
 
-		work = kthread_create_on_node(ot_thread_worker, item,
-				cpu_to_node(cpu), "ot_worker_%d", cpu);
-		if (IS_ERR(work)) {
+		work = kthread_run_on_cpu(ot_thread_worker, item, cpu, "ot_worker_%d");
+		if (IS_ERR(work))
 			pr_err("failed to create thread for cpu %d\n", cpu);
-		} else {
-			kthread_bind(work, cpu);
-			wake_up_process(work);
-		}
 	}
 
 	/* wait a while to make sure all threads waiting at start line */
-- 
2.46.0


