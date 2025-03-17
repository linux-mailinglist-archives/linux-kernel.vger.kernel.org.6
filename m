Return-Path: <linux-kernel+bounces-563930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 664D6A64A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430E618846FA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CEC21C166;
	Mon, 17 Mar 2025 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I99BOsmO"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A823E2236FD
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208189; cv=none; b=SxPBECLCY7A+B30sVNEpAY3SzdHN8TLgfNcBfYxm20G238hfd6aWDL3XPGF+Arh15rV6pqNRCjfFOccLZdoLuHKaLo381x/afivw3/QK4NpgOxuBb+v7tegEhQqfELP+ZmBZeedYlrjU6mu1kpfvXIwGh9K+S5DYI1DSEkymTno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208189; c=relaxed/simple;
	bh=opa6lPKdZ9aCTVZgV6zn8piU1lOjxjwhDcQrQFFAyoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B29cK2l83oohvuqqKSoSAVUuznoNSU/vNmBeQZgsyzqoiY0ZUYVgVlJ8MrUcq0PxEnPqc2mETVwB6ISdWYPmvOq6qJ2Dh9gWL4ktRQ7B56YQxYwgETtRW2UGiQZ1o76Vht/5geIJf9JP1kEEioBKtSJ6Ki2Ps65kjzOlXqcyLEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I99BOsmO; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3965c995151so2851858f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742208186; x=1742812986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bx1q2HBp4vh5xTWwllug152my5AslkI00+Q5AQBDivo=;
        b=I99BOsmOGUFEJCD6BbeKq8EMREYV9WBZjSbANNk8233+dA0odDrRRQruK43pHG4AwS
         iIynKqZSwbo/lUCtgnOWwvob4wmMfZ51t4o+2M5f+FhnDnUj1HrnlEpS6/Avz6nhfPE6
         fnxO1Nx5EYmdbuFkzCY2U59ReTjYxQZa8+9PTrETbvE561/qdt+UE0pY25Jmjyb5DNFq
         RZn8JJ13Zn5a1MkT30gyXUUDdXUDBB7j8iGMOzxz7FcsZJqEtbm0wmiofj9jlytVOdMX
         caP8pq/3mLViQgf+QsWDLH7IrKTw0eM2GVGH9IjZooK+bdjIREeR7mbXmQjw2G2d3yV6
         V+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742208186; x=1742812986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bx1q2HBp4vh5xTWwllug152my5AslkI00+Q5AQBDivo=;
        b=TwoQQO2KUE50T9pPBkJUrhyCoUp4vwGLGsOw+//C2naQV2isMNgZR3BZtN3ADzVoap
         +RUWQis3ZL4a5WUgQh2tNElCwDjmgFsDqT3KdZS77Bq/t+HcLdbzOo+dGPr9hzb5Iurc
         V7tO3hBd/HTBHOIJIrGIAccflHzz4IDFOpdcjTg2H4SsD43qZzA7wbS+cSUEo5GyX9nu
         AdMDGCaPJPUMjFR0EbGxl7vNL+8Qt4vvhnnICS//63L4RLjpjMH9py6TcdPvGfQoIgFZ
         TfPUPS3igVtc2I4P7CORRC/u49Tld/mCQGfDcfnvNiX7maPnhdCo2ZNFxirbsbQWt5qd
         Snxw==
X-Gm-Message-State: AOJu0YyE+Kg/4c3UaGX/Y6/24EXyJfZbBQBJQ+rBmSQ0GBGSVVFODl17
	en8m3jgtyrD5DmG2vBuKWdcNfyrWS+X0Acqum+RyecNRBjbkXJtLlatHB9gx
X-Gm-Gg: ASbGncvmO1mH/nRlDr1z6+fHkX0K89GUku6PIhmc6raBXyh0RxlvnqcgtTAWt2XYb44
	ZSLlc0z89kVY07YQExDoLIXC6E+HsP+DMGJ9SE1PIHxlUQNOt/aWUq7kMNjpqbAWXP+T6bI4UW5
	K3t/3hTXSwdMDiztGU/67jX/A9wIhXqzfbiGHnkVCP2BqOPmUrKHGHyDBrZlEUpfQeR/r8EvC18
	VAUmUNljLskvUsPnzqqSFRJIM9wMXo3E1/vgQ3+VaKDqaSK2KkhmiJ2CtK5CePRRhrVjnw3wQud
	yK45Ai5UzoDtsJopMY7SRIV8lJs14NmLpmAXkikZsxHZjmc23mVAYO9F3IPE0MYHsQ==
X-Google-Smtp-Source: AGHT+IH7lnASCC5nMhjvu4cRSqg+zrHC47rzZUzSuJK4VlEY/7mlEeEyJv4uw8sdZKH52wIArQKeJQ==
X-Received: by 2002:a5d:598d:0:b0:391:441b:baac with SMTP id ffacd0b85a97d-3971ef3e4bfmr13565999f8f.50.1742208185753;
        Mon, 17 Mar 2025 03:43:05 -0700 (PDT)
Received: from starship.. (1F2EF046.nat.pool.telekom.hu. [31.46.240.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb3189absm14807262f8f.71.2025.03.17.03.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 03:43:05 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/5] sched/debug: Make 'const_debug' tunables unconditional __read_mostly
Date: Mon, 17 Mar 2025 11:42:53 +0100
Message-ID: <20250317104257.3496611-3-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250317104257.3496611-1-mingo@kernel.org>
References: <20250317104257.3496611-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_SCHED_DEBUG becoming unconditional, remove the
extra 'const_debug' indirection towards __read_mostly.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c  |  4 ++--
 kernel/sched/fair.c  |  2 +-
 kernel/sched/sched.h | 15 +++++----------
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2da197b2968b..d6833a85e561 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -128,7 +128,7 @@ DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
  */
 #define SCHED_FEAT(name, enabled)	\
 	(1UL << __SCHED_FEAT_##name) * enabled |
-const_debug unsigned int sysctl_sched_features =
+__read_mostly unsigned int sysctl_sched_features =
 #include "features.h"
 	0;
 #undef SCHED_FEAT
@@ -148,7 +148,7 @@ __read_mostly int sysctl_resched_latency_warn_once = 1;
  * Number of tasks to iterate in a single balance run.
  * Limited because this is done with IRQs disabled.
  */
-const_debug unsigned int sysctl_sched_nr_migrate = SCHED_NR_MIGRATE_BREAK;
+__read_mostly unsigned int sysctl_sched_nr_migrate = SCHED_NR_MIGRATE_BREAK;
 
 __read_mostly int scheduler_running;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 89609ebd4904..35ee8d9d78d5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -79,7 +79,7 @@ unsigned int sysctl_sched_tunable_scaling = SCHED_TUNABLESCALING_LOG;
 unsigned int sysctl_sched_base_slice			= 700000ULL;
 static unsigned int normalized_sysctl_sched_base_slice	= 700000ULL;
 
-const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
+__read_mostly unsigned int sysctl_sched_migration_cost	= 500000UL;
 
 static int __init setup_sched_thermal_decay_shift(char *str)
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 189f7b033dab..187a22800577 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2194,13 +2194,8 @@ static inline void __set_task_cpu(struct task_struct *p, unsigned int cpu)
 }
 
 /*
- * Tunables that become constants when CONFIG_SCHED_DEBUG is off:
+ * Tunables:
  */
-#ifdef CONFIG_SCHED_DEBUG
-# define const_debug __read_mostly
-#else
-# define const_debug const
-#endif
 
 #define SCHED_FEAT(name, enabled)	\
 	__SCHED_FEAT_##name ,
@@ -2218,7 +2213,7 @@ enum {
  * To support run-time toggling of sched features, all the translation units
  * (but core.c) reference the sysctl_sched_features defined in core.c.
  */
-extern const_debug unsigned int sysctl_sched_features;
+extern __read_mostly unsigned int sysctl_sched_features;
 
 #ifdef CONFIG_JUMP_LABEL
 
@@ -2249,7 +2244,7 @@ extern struct static_key sched_feat_keys[__SCHED_FEAT_NR];
  */
 #define SCHED_FEAT(name, enabled)	\
 	(1UL << __SCHED_FEAT_##name) * enabled |
-static const_debug __maybe_unused unsigned int sysctl_sched_features =
+static __read_mostly __maybe_unused unsigned int sysctl_sched_features =
 #include "features.h"
 	0;
 #undef SCHED_FEAT
@@ -2837,8 +2832,8 @@ extern void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags);
 # define SCHED_NR_MIGRATE_BREAK 32
 #endif
 
-extern const_debug unsigned int sysctl_sched_nr_migrate;
-extern const_debug unsigned int sysctl_sched_migration_cost;
+extern __read_mostly unsigned int sysctl_sched_nr_migrate;
+extern __read_mostly unsigned int sysctl_sched_migration_cost;
 
 extern unsigned int sysctl_sched_base_slice;
 
-- 
2.45.2


