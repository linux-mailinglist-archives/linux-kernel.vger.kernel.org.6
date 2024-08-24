Return-Path: <linux-kernel+bounces-300171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C405E95DFCE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 21:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E890C1F21A37
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 19:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F250768E1;
	Sat, 24 Aug 2024 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmamWSUb"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7082AE97
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724528009; cv=none; b=ef8WT9vpgg7BrjIzvA2hgwz2rwMqFwiNdtCFKrZ+ZKF3x19rkFO+7+U5EY2y3xbpgaVKKYF7e+mmUb+gBbE/wGeMI4LZlMnUhPfzq5WQm73QLGaNDGk7AD/Le+7BV9ECbqQKPRtjT7+5w5GUGZN8W7JiQ2UadjZFOWWWcNrtMU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724528009; c=relaxed/simple;
	bh=UrsrTfkR5KwMJIV9SUPInKX/BgKuG0SUpUsdaykmmtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ny0RX8AjW8Ij6wyuA/4FL0kkLZVpW1AcmpgnzonERrL9W6ONcoQhhFtdkB63umK6n95as8BufAogrezoVHHZ7kXyY20KaBHkebY/OAjFgiAYev3w2gNMxfnzjB41tsjq4wqWuVF8uXeEZndxREbO7XjMZIt4dyHoafpKKkIHWRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmamWSUb; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so24010515e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 12:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724528006; x=1725132806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jXWVbBm2YGflm2QAsnwv8TFXxPetn70j5XC6l6mW/uI=;
        b=HmamWSUbV6p+J/SysqPG+SCaHhuOD6ek11TI2r4TB3xHTpU4qFI78qTPLyEF7kgikm
         8R1dZUKeb80AQOccycn8Wn8WkvVjcRCzPSzbgc2+hceM4sPnFrhbK67HfjA/dHGnr8el
         6/QcW5etS4MgtEd/t9nwM941yr0s7IGBBV9OqT2Ggv/lryBAtmbxoszJHn7IUvpiGCeb
         3fz6zU8hXVYOxV+ZWm8ZcTHVVGY13/XFIwJxKyDoEmp/56dLI/9xOqzk3Q9LnmRcHQlK
         SgSlakfe9KoVLO3lG1kiD2OZZdu0fh30Hgplsg9UiECaRF8MRFluwlZ+xrcqldzBPo+w
         UwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724528006; x=1725132806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXWVbBm2YGflm2QAsnwv8TFXxPetn70j5XC6l6mW/uI=;
        b=W/P82E1ym0UIt/uRUxuaaEq2W7Cozk51bfJsxmQIb8oN58BcmG/vpA+wMVMADEsGX3
         H/I/6RrCSLWFwg48SQrASAdfBdVqLnVUiUgTG6Zls0El3WoN4pSPE1o7clLBDZB7F5Cl
         AgnVMl/t8u2utvAOTlBpHYcXJi7wFjZf4uq8qPerMIr7FM05WiaBqg2ew/YpR8+TWPHS
         3KKz3fJJdBMHUURFC6TE9PtY+Zubc80r+YSoqFcWdVlbfivB0bitwC75aU73DlZ+kBiL
         X2wLMpws1ZBB0pgCEiH7HQifKdskjatgJZac034ClVbpoGhx/qBzG8kOmBaug6RpkzVY
         o4Eg==
X-Gm-Message-State: AOJu0YyrTQ1GFXSazT03WFVbunfEm6w3flZHHBGCycaaQxY8FP8FcI7b
	0L9Ik13M1ETHeXDn+7JSYDkc/106ZLDFUfZ43mw17EjnGvC5FkdfHhw/BneK+z4=
X-Google-Smtp-Source: AGHT+IHDhrwrtvMjHgyDaao+xJsyjyyNVaarUe1ry0M+ESCuF1DnDIuJz2el8LQOfiYNFl+u1otDJw==
X-Received: by 2002:a05:6000:18e:b0:366:f041:935d with SMTP id ffacd0b85a97d-373118ef46bmr3668768f8f.60.1724528005278;
        Sat, 24 Aug 2024 12:33:25 -0700 (PDT)
Received: from localhost.localdomain ([156.197.22.60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308157c55sm7155197f8f.46.2024.08.24.12.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 12:33:24 -0700 (PDT)
From: Ahmed Ehab <bottaawesome633@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] Refactor switch_mm_cid() to avoid unnecessary checks
Date: Sun, 25 Aug 2024 01:31:32 +0300
Message-ID: <20240824223132.11925-1-bottaawesome633@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue is that we are checking if we are switching from {kerel,user}
to {kernel, user} multiple times unnecessarily.

To fix this, refactor switch_mm_cid() and break it into multiple methods
to hand the cases of switching from {kernel,user} to {kernel, user}.
Hence, we avoid any redundant checks.

Signed-off-by: Ahmed Ehab <bottaawesome633@gmail.com>
---
 kernel/sched/core.c  | 15 +++++---
 kernel/sched/sched.h | 86 ++++++++++++++++++++++++++------------------
 2 files changed, 62 insertions(+), 39 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f3951e4a55e5..abfa73f9c845 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5155,9 +5155,15 @@ context_switch(struct rq *rq, struct task_struct *prev,
 		enter_lazy_tlb(prev->active_mm, next);
 
 		next->active_mm = prev->active_mm;
-		if (prev->mm)                           // from user
+		if (prev->mm) {                           // from user
 			mmgrab_lazy_tlb(prev->active_mm);
+			switch_mm_cid_from_user_to_kernel(rq, prev, next);
+		}
 		else
+			/*
+			 * kernel -> kernel transition does not change rq->curr->mm
+			 * state. It stays NULL.
+			 */
 			prev->active_mm = NULL;
 	} else {                                        // to user
 		membarrier_switch_mm(rq, prev->active_mm, next->mm);
@@ -5176,12 +5182,11 @@ context_switch(struct rq *rq, struct task_struct *prev,
 			/* will mmdrop_lazy_tlb() in finish_task_switch(). */
 			rq->prev_mm = prev->active_mm;
 			prev->active_mm = NULL;
-		}
+			switch_mm_cid_from_kernel_to_user(rq, prev, next);
+		} else
+			switch_mm_cid_from_user_to_user(rq, prev, next);
 	}
 
-	/* switch_mm_cid() requires the memory barriers above. */
-	switch_mm_cid(rq, prev, next);
-
 	prepare_lock_switch(rq, next, rf);
 
 	/* Here we just switch the register state and the stack. */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4c36cc680361..27fa050b81f5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -5,6 +5,7 @@
 #ifndef _KERNEL_SCHED_SCHED_H
 #define _KERNEL_SCHED_SCHED_H
 
+#include "asm-generic/barrier.h"
 #include <linux/sched/affinity.h>
 #include <linux/sched/autogroup.h>
 #include <linux/sched/cpufreq.h>
@@ -3515,8 +3516,8 @@ static inline int mm_cid_get(struct rq *rq, struct mm_struct *mm)
 }
 
 static inline void switch_mm_cid(struct rq *rq,
-				 struct task_struct *prev,
-				 struct task_struct *next)
+		struct task_struct *prev,
+		struct task_struct *next)
 {
 	/*
 	 * Provide a memory barrier between rq->curr store and load of
@@ -3524,38 +3525,6 @@ static inline void switch_mm_cid(struct rq *rq,
 	 *
 	 * Should be adapted if context_switch() is modified.
 	 */
-	if (!next->mm) {                                // to kernel
-		/*
-		 * user -> kernel transition does not guarantee a barrier, but
-		 * we can use the fact that it performs an atomic operation in
-		 * mmgrab().
-		 */
-		if (prev->mm)                           // from user
-			smp_mb__after_mmgrab();
-		/*
-		 * kernel -> kernel transition does not change rq->curr->mm
-		 * state. It stays NULL.
-		 */
-	} else {                                        // to user
-		/*
-		 * kernel -> user transition does not provide a barrier
-		 * between rq->curr store and load of {prev,next}->mm->pcpu_cid[cpu].
-		 * Provide it here.
-		 */
-		if (!prev->mm) {                        // from kernel
-			smp_mb();
-		} else {				// from user
-			/*
-			 * user->user transition relies on an implicit
-			 * memory barrier in switch_mm() when
-			 * current->mm changes. If the architecture
-			 * switch_mm() does not have an implicit memory
-			 * barrier, it is emitted here.  If current->mm
-			 * is unchanged, no barrier is needed.
-			 */
-			smp_mb__after_switch_mm();
-		}
-	}
 	if (prev->mm_cid_active) {
 		mm_cid_snapshot_time(rq, prev->mm);
 		mm_cid_put_lazy(prev);
@@ -3565,6 +3534,55 @@ static inline void switch_mm_cid(struct rq *rq,
 		next->last_mm_cid = next->mm_cid = mm_cid_get(rq, next->mm);
 }
 
+static inline void switch_mm_cid_from_user_to_kernel(struct rq *rq,
+		struct task_struct *prev,
+		struct task_struct *next)
+
+{
+	/**
+	 * user -> kernel transition does not guarantee a barrier, but
+	 * we can use the fact that it performs an atomic operation in
+	 * mmgrab().
+	 */
+	smp_mb__after_mmgrab();
+	switch_mm_cid(rq, prev, next);
+
+}
+
+static inline void switch_mm_cid_from_kernel_to_user(struct rq *rq,
+		struct task_struct *prev,
+		struct task_struct *next)
+
+{
+	/*
+	 * kernel -> user transition does not provide a barrier
+	 * between rq->curr store and load of {prev,next}->mm->pcpu_cid[cpu].
+	 * Provide it here.
+	 */
+	smp_mb();
+	switch_mm_cid(rq, prev, next);
+
+}
+
+
+static inline void switch_mm_cid_from_user_to_user(struct rq *rq,
+		struct task_struct *prev,
+		struct task_struct *next)
+
+{
+	/*
+	 * user->user transition relies on an implicit
+	 * memory barrier in switch_mm() when
+	 * current->mm changes. If the architecture
+	 * switch_mm() does not have an implicit memory
+	 * barrier, it is emitted here.  If current->mm
+	 * is unchanged, no barrier is needed.
+	 */
+	smp_mb__after_switch_mm();
+	switch_mm_cid(rq, prev, next);
+
+}
+
 #else /* !CONFIG_SCHED_MM_CID: */
 static inline void switch_mm_cid(struct rq *rq, struct task_struct *prev, struct task_struct *next) { }
 static inline void sched_mm_cid_migrate_from(struct task_struct *t) { }
-- 
2.46.0


