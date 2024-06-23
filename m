Return-Path: <linux-kernel+bounces-225906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E549D913742
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 03:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741DE1F22603
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 01:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0527A14A90;
	Sun, 23 Jun 2024 01:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1Ka8dZQ"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7E6323D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 01:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719107469; cv=none; b=tF4WZxez3PUhb0m87SWy0s5ppFZz3kH7F7I6YBOeDLjGx9+zO0uM0FlrjuCqd0nBvj/fTJL3RJMtgOrDAMxEdxR/2mHbpBnrk8mBaBozZFHP200zziGaA01mnNOKUuerBrO09eBMy6XkiNmpqA0+29wqxeMFTPEuFxRa9JI/4Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719107469; c=relaxed/simple;
	bh=jUZxIj8dJm5RyGB2UntzQjQoBl1r5Rp9lNEvexYXqE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vy7L9SPZJrakfQxDlhoH2djrVKcnSzNssunXJwfBsmavncV1ILg4WMYPNLpRwoiF/hYzsqRVnbTF8grbUrOOJlNFHXuJ4Vl5m5fldqIMImUpalde66APvsqKzk9s78xuUQQ2c3pj8VpcxmanGaF1/NizPg42Km0idme8EPAsRkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1Ka8dZQ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70109d34a16so2810164b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 18:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719107467; x=1719712267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvKFCHc7kcAE1LbSDkpiYTqH7yRracz5vCGrpUE6A7A=;
        b=T1Ka8dZQ4ulX/CV2x5yE7jQox3QnLiA1QMI0olL15DORSGq/Jsub6UbEsVRid3bkqr
         v+QSQ+suIbNYJdLDs0J77mdw7hJwYrC4EOobGaZrzliPOqVOlwGONDslWO+kI7gWc8wb
         WZb0H2LRYTuM737z/jzpFfOKM6d9BNG6wTIJv5nEacaF/0Kp1r7+bV7cEPH3MxI7t+Rz
         dDTf3lFIleZvlKzPQfF/eTCN86wfeSdUyFnt84cMRiXlg86nBkVNfl9LUgx2vcEvAa0W
         aSx5eBdaEjZe4MDER+yyeEbKrfKsqTPVqLo10xzeWDmIPndsHYOcPM2ywlgc+VtIIYPS
         TrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719107467; x=1719712267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zvKFCHc7kcAE1LbSDkpiYTqH7yRracz5vCGrpUE6A7A=;
        b=VBzdaNVVrAG0eqRykXhXBW3HrR3jxHENBCH122a5GOfe9BDBEgCRDTlCSbf/G2Rh9i
         5tNENE0/H+lQVorPRvfJxrMZANu784/YXgfzuvkFQ8tc0LUGt82DcCWD41fwsOmvN1rX
         vBctjeAuNeDr4z9criY4MNgGt8cG8RyDc7b92kcAPMrztAKi2CAtfbtOYl8qWqqXryyY
         h0HXEePRD2ukH4uhx7sqN8v/QDuL1n0ODBub6FkeIlIUr4pWBlTkscD9XbbJT3JjuPZK
         Lb/hCI1n3NNny1jnR8F+5RPRRy91MYLWnfz4PLNBz80s007c6wFbLPUoVLr4z5SE4HjS
         P2rg==
X-Forwarded-Encrypted: i=1; AJvYcCWd7mnbBGCV9VxdTnLX4KEjF3nCTyxD2wO7wYDzqYekj84RhhMC8lWiEk+EmHpMberMDjLdcc8Bc7+0lBsmCfgHwOXFMbancoF5BlqD
X-Gm-Message-State: AOJu0YyQxfRnryoWrUYnchBDD4OtoTMulBmj8iI/iEXmB5tB4Pmx7X8h
	9VeyxWAjn4ziCuEHmI05Q3TSEE/MTLsYCXk3tsLoQm3GeG3MYNbN
X-Google-Smtp-Source: AGHT+IHoOH/URAE8ULH2oVihuGZi9XtwVOPN1b6laqUu224BXYFJvYkli9JZCLmEmX4LY7vai0NicA==
X-Received: by 2002:a05:6a00:1e12:b0:706:2a61:ba8b with SMTP id d2e1a72fcca58-706745938f8mr1546932b3a.6.1719107466809;
        Sat, 22 Jun 2024 18:51:06 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651311293sm3711162b3a.213.2024.06.22.18.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 18:51:06 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org
Cc: void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/3] sched, sched_ext: Move some declarations from kernel/sched/ext.h to sched.h
Date: Sat, 22 Jun 2024 15:50:22 -1000
Message-ID: <20240623015057.3383223-4-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240623015057.3383223-1-tj@kernel.org>
References: <20240623015057.3383223-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While sched_ext was out of tree, everything sched_ext specific which can be
put in kernel/sched/ext.h was put there to ease forward porting. However,
kernel/sched/sched.h is the better location for some of them. Relocate.

- struct sched_enq_and_set_ctx, sched_deq_and_put_task() and
  sched_enq_and_set_task().

- scx_enabled() and scx_switched_all().

- for_active_class_range() and for_each_active_class(). sched_class
  declarations are moved above the class iterators for this.

No functional changes intended.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Vernet <void@manifault.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/ext.h   | 39 --------------------------
 kernel/sched/sched.h | 65 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 59 insertions(+), 45 deletions(-)

diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 1d7837bdfaba..32d3a51f591a 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -8,24 +8,6 @@
  */
 #ifdef CONFIG_SCHED_CLASS_EXT
 
-struct sched_enq_and_set_ctx {
-	struct task_struct	*p;
-	int			queue_flags;
-	bool			queued;
-	bool			running;
-};
-
-void sched_deq_and_put_task(struct task_struct *p, int queue_flags,
-			    struct sched_enq_and_set_ctx *ctx);
-void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx);
-
-extern const struct sched_class ext_sched_class;
-
-DECLARE_STATIC_KEY_FALSE(__scx_ops_enabled);
-DECLARE_STATIC_KEY_FALSE(__scx_switched_all);
-#define scx_enabled()		static_branch_unlikely(&__scx_ops_enabled)
-#define scx_switched_all()	static_branch_unlikely(&__scx_switched_all)
-
 void scx_tick(struct rq *rq);
 void init_scx_entity(struct sched_ext_entity *scx);
 void scx_pre_fork(struct task_struct *p);
@@ -52,22 +34,6 @@ static inline bool task_on_scx(const struct task_struct *p)
 	return scx_enabled() && p->sched_class == &ext_sched_class;
 }
 
-static inline const struct sched_class *next_active_class(const struct sched_class *class)
-{
-	class++;
-	if (scx_switched_all() && class == &fair_sched_class)
-		class++;
-	if (!scx_enabled() && class == &ext_sched_class)
-		class++;
-	return class;
-}
-
-#define for_active_class_range(class, _from, _to)				\
-	for (class = (_from); class != (_to); class = next_active_class(class))
-
-#define for_each_active_class(class)						\
-	for_active_class_range(class, __sched_class_highest, __sched_class_lowest)
-
 #ifdef CONFIG_SCHED_CORE
 bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 		   bool in_fi);
@@ -75,9 +41,6 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 
 #else	/* CONFIG_SCHED_CLASS_EXT */
 
-#define scx_enabled()		false
-#define scx_switched_all()	false
-
 static inline void scx_tick(struct rq *rq) {}
 static inline void scx_pre_fork(struct task_struct *p) {}
 static inline int scx_fork(struct task_struct *p) { return 0; }
@@ -91,8 +54,6 @@ static inline int scx_check_setscheduler(struct task_struct *p, int policy) { re
 static inline bool task_on_scx(const struct task_struct *p) { return false; }
 static inline void init_sched_ext_class(void) {}
 
-#define for_each_active_class		for_each_class
-
 #endif	/* CONFIG_SCHED_CLASS_EXT */
 
 #if defined(CONFIG_SCHED_CLASS_EXT) && defined(CONFIG_SMP)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 963a2fa180ad..2a433f760813 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2438,19 +2438,54 @@ const struct sched_class name##_sched_class \
 extern struct sched_class __sched_class_highest[];
 extern struct sched_class __sched_class_lowest[];
 
+extern const struct sched_class stop_sched_class;
+extern const struct sched_class dl_sched_class;
+extern const struct sched_class rt_sched_class;
+extern const struct sched_class fair_sched_class;
+extern const struct sched_class idle_sched_class;
+
+#ifdef CONFIG_SCHED_CLASS_EXT
+extern const struct sched_class ext_sched_class;
+
+DECLARE_STATIC_KEY_FALSE(__scx_ops_enabled);	/* SCX BPF scheduler loaded */
+DECLARE_STATIC_KEY_FALSE(__scx_switched_all);	/* all fair class tasks on SCX */
+
+#define scx_enabled()		static_branch_unlikely(&__scx_ops_enabled)
+#define scx_switched_all()	static_branch_unlikely(&__scx_switched_all)
+#else /* !CONFIG_SCHED_CLASS_EXT */
+#define scx_enabled()		false
+#define scx_switched_all()	false
+#endif /* !CONFIG_SCHED_CLASS_EXT */
+
+/*
+ * Iterate only active classes. SCX can take over all fair tasks or be
+ * completely disabled. If the former, skip fair. If the latter, skip SCX.
+ */
+static inline const struct sched_class *next_active_class(const struct sched_class *class)
+{
+	class++;
+#ifdef CONFIG_SCHED_CLASS_EXT
+	if (scx_switched_all() && class == &fair_sched_class)
+		class++;
+	if (!scx_enabled() && class == &ext_sched_class)
+		class++;
+#endif
+	return class;
+}
+
 #define for_class_range(class, _from, _to) \
 	for (class = (_from); class < (_to); class++)
 
 #define for_each_class(class) \
 	for_class_range(class, __sched_class_highest, __sched_class_lowest)
 
-#define sched_class_above(_a, _b)	((_a) < (_b))
+#define for_active_class_range(class, _from, _to)				\
+	for (class = (_from); class != (_to); class = next_active_class(class))
 
-extern const struct sched_class stop_sched_class;
-extern const struct sched_class dl_sched_class;
-extern const struct sched_class rt_sched_class;
-extern const struct sched_class fair_sched_class;
-extern const struct sched_class idle_sched_class;
+#define for_each_active_class(class)						\
+	for_active_class_range(class, __sched_class_highest, __sched_class_lowest)
+
+#define sched_class_above(_a, _b)	((_a) < (_b))
 
 static inline bool sched_stop_runnable(struct rq *rq)
 {
@@ -3698,6 +3733,24 @@ static inline void balance_callbacks(struct rq *rq, struct balance_callback *hea
 
 #endif
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+/*
+ * Used by SCX in the enable/disable paths to move tasks between sched_classes
+ * and establish invariants.
+ */
+struct sched_enq_and_set_ctx {
+	struct task_struct	*p;
+	int			queue_flags;
+	bool			queued;
+	bool			running;
+};
+
+void sched_deq_and_put_task(struct task_struct *p, int queue_flags,
+			    struct sched_enq_and_set_ctx *ctx);
+void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx);
+
+#endif /* CONFIG_SCHED_CLASS_EXT */
+
 #include "ext.h"
 
 #endif /* _KERNEL_SCHED_SCHED_H */
-- 
2.45.2


