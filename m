Return-Path: <linux-kernel+bounces-341092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9192C987B49
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 00:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E3A5B26F19
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 22:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB2D1B1D5C;
	Thu, 26 Sep 2024 22:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqm67Wlf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC6A1B1D48
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 22:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727390976; cv=none; b=ImezHW/MFpv9N5lajqXDUJxkF7A+pxqz4sUwkVDN4aB6nuVGzJHOrpvyfUB+34D0Huw6gI092kd2wYF9FlTE6/evKrgxCe66CYsGIB+6udGdeooenBi8e1xSwNZ3slPd0L03r8Y+iEn/7r0ZkbBnJiK9hU4MEpzuKVAuV1VReDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727390976; c=relaxed/simple;
	bh=4bqmk1ZZmgmxj/TbraN0t20xxY3kUbWb7QrpoxYbtKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WggLMQQstH05zx9VkAhK3xMwEcE/LdgmrfFdbpfrE20jcpeXS7r7FoEnEz4uBmr2DpTd13bbVqbVF/pLkFAnQD73FYHduqFLW/eTAvvXbABQ+ULwvvwJUO2TKKbtDlhyES6t+SB5y+Go3TKvYaYkDD5L3btWBy/2qUv0hcgMmEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqm67Wlf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EC6C4CEC9;
	Thu, 26 Sep 2024 22:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727390976;
	bh=4bqmk1ZZmgmxj/TbraN0t20xxY3kUbWb7QrpoxYbtKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eqm67Wlfpj1a9q4r0rWiUQ6VNI3pdYtXYeZ1kPUWdNeC1J8QYSvzi4AKIm/+BjkEs
	 9yvi726EVpGamoBVIerKWT36P/KWqXGpCBXmSOkQXituuteR4taQOKs+T9CZ+H31jp
	 3kN+t/H3AL+S50VnN5Ir6Ca7E52QJxYCMkUg4qjZoslAldtuXJYDG5dLzpE1kjKSnG
	 RaHtNGDbB9H9Ad9h1fADQUWhIgwwAQSzmzwZiZPwUD63bnWxeRrvj38RfTLr6GG9MW
	 R1sqH4yME6Jt397thewUtldFusSBa7PZ6Ll1JgxtHP20Ti2S55bnKsGs6PVqmOz5im
	 9YX5SpDRPu6FQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Matt Wu <wuqiang.matt@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 09/20] lib: test_objpool: Use kthread_run_on_cpu()
Date: Fri, 27 Sep 2024 00:48:57 +0200
Message-ID: <20240926224910.11106-10-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926224910.11106-1-frederic@kernel.org>
References: <20240926224910.11106-1-frederic@kernel.org>
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


