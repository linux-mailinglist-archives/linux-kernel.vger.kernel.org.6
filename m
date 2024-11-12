Return-Path: <linux-kernel+bounces-406025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56EA9C5A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3BC9B3F8F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9CF1FCF63;
	Tue, 12 Nov 2024 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2ckmNhm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F2A1FCF55
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421397; cv=none; b=GNOABPiMiy0+N8N8f/G+KnfCUZeIWbadtR+DLvk65/L1XIGAfCnOkbKv8+KXCMzlxpAhA5MUD2f50wvrE6Ncpwq0otzf0RWuRF2raWteUXOAJV6ltQrsdvBud2stl+I39F7CHRrhsR6tTrFhFkY6sqRawzGbOW9amxVbqNfwYsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421397; c=relaxed/simple;
	bh=4bqmk1ZZmgmxj/TbraN0t20xxY3kUbWb7QrpoxYbtKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XH7pMJsWGhPFHdrKaT7b7n0oSNR7O/ePxR9Pi9zTukVpRdDdwjYfcvdC2x4msMqmzaUHwL0MlFnYoW2U3uV6ze4qVQ29z1tvGmOwG1WQMx2NeDL0hBOn8I87RfHPKp1jTmSJH21pWn5/pLQ2aaQ3giTZ7QD//NEmNkmR69BlRS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2ckmNhm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A620C4CED5;
	Tue, 12 Nov 2024 14:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731421396;
	bh=4bqmk1ZZmgmxj/TbraN0t20xxY3kUbWb7QrpoxYbtKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f2ckmNhmyOuxMjQmw8UUNE1VV1KKip+2RNTXJ4E+QzIhiwal3UW8BaXwdySDsupQ0
	 zlVSdHYjIEBvWyH4d9I4O+lNd0BkONN1zP/UG+b6e/88T4m0CMzGbv8xRpb1spn++O
	 NihHkRjQIH7vm0LA0hRx7ESfSfL+7HnDphYJhFRbv7Zgblcc9D4r/BRo82PSypO1SI
	 qQDRAT05eZpKJYUuPmHJcdltgACepbki4B48j0BDgi4m1WLqpxrnKugXgbODiQKE6B
	 jxA1gJCO6Bc6YmqN08+iZlEEf9P5j5pWHXSOSc5OGfc43+XkNspRYYAFtl3lz4MJq6
	 uJmOBBzKDFL4Q==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Matt Wu <wuqiang.matt@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 09/21] lib: test_objpool: Use kthread_run_on_cpu()
Date: Tue, 12 Nov 2024 15:22:33 +0100
Message-ID: <20241112142248.20503-10-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241112142248.20503-1-frederic@kernel.org>
References: <20241112142248.20503-1-frederic@kernel.org>
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


