Return-Path: <linux-kernel+bounces-217913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AA090B6C8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47812B2DC7D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8861A17C68;
	Mon, 17 Jun 2024 16:16:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD02579E5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718640987; cv=none; b=ros+6fOM20W0oXBw0VtBJ/xh+XvJcG7sEXgzhFzXMDqIkFzrKJhU+m3b9APklQy+h6U7pfGU6mhgy3/QdagS7u4+Bnn9evAShPMxUdF1C/TNW8ft6VurrGJbF4x9kAithg3GO0E/DFLo97pQE0LDCrnqFTJmmwlecPjOp4sC33Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718640987; c=relaxed/simple;
	bh=JrtpPYVIbnFOKuBv+qAfdsjZN0xFqynHmVM9CHaos8I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lGip/S6uu4lUwAi+mpL/0bZkocCanaYiurwx//LgkNqPludNcU2vmGoZEX+Yqj6Zy7QFa1yZTgqe0Cx9UjY0gJbzQkHiq4Foda/NjbCIHBOhEpXFp72qcEYFufoqB9PY+DI8INTFQExIBiIhDPlSxB+r5vX4awKAY9LOmpXyRvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 456DFDA7;
	Mon, 17 Jun 2024 09:16:47 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.33.10])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 48D813F64C;
	Mon, 17 Jun 2024 09:16:21 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: linux-kernel@vger.kernel.org,
	anna-maria@linutronix.de
Cc: frederic@kernel.org,
	tglx@linutronix.de,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] tick: Remove unnused tick_nohz_get_idle_calls()
Date: Mon, 17 Jun 2024 17:16:15 +0100
Message-Id: <20240617161615.49309-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function returns the idle calls counter for the current cpu and
therefore usually isn't what the caller wants. It is unnused since
commit 466a2b42d676 ("cpufreq: schedutil: Use idle_calls counter of the
remote CPU")

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 include/linux/tick.h     |  1 -
 kernel/time/tick-sched.c | 14 --------------
 2 files changed, 15 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 4924a33700b7..72744638c5b0 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -139,7 +139,6 @@ extern void tick_nohz_irq_exit(void);
 extern bool tick_nohz_idle_got_tick(void);
 extern ktime_t tick_nohz_get_next_hrtimer(void);
 extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
-extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 71a792cd8936..43a6370a2ebc 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1385,20 +1385,6 @@ unsigned long tick_nohz_get_idle_calls_cpu(int cpu)
 	return ts->idle_calls;
 }
 
-/**
- * tick_nohz_get_idle_calls - return the current idle calls counter value
- *
- * Called from the schedutil frequency scaling governor in scheduler context.
- *
- * Return: the current idle calls counter value for the current CPU
- */
-unsigned long tick_nohz_get_idle_calls(void)
-{
-	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
-
-	return ts->idle_calls;
-}
-
 static void tick_nohz_account_idle_time(struct tick_sched *ts,
 					ktime_t now)
 {
-- 
2.34.1


