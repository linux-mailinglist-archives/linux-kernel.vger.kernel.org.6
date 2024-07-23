Return-Path: <linux-kernel+bounces-259956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D29493A078
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B821C21FAB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 12:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5F5152199;
	Tue, 23 Jul 2024 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BEQ70tR7"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DBE152534
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721737224; cv=none; b=sNhK9oGQntaJNZd3fE7lQlS8BWoYiePuv1GU5zdbP+rEz0ac9I+K347A2+AQqom4Pkw8Eh8rBrlKJebhwKgfmog4kSdZjLlbkSgqEJa4weX7L98GdT5m9f6kyOJLZM5u7IeyUngkGiqzTRPKpPqwhR4YAsUTRTKqVniLGMMStm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721737224; c=relaxed/simple;
	bh=SVG+nHT0GykJkz08I12TJTa18ssjQas8y+ttmyu4Fuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ntAdGFx6clq5nGJlZSTpV2QpeiUbOIAs+Ie54vsfatww0TOHiBrL9qk7ivqBV7TYi8chhm+Uj1triEn70uG2b9LOy0llux3LoseM9gJmgpAV2q83sXxrBJ0SwTpff0Gt8CUzaEFHE09BOcsMvIrMBTGnn+MXQPQ8muZtFhyxZDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BEQ70tR7; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3993c6dd822so11958705ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 05:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1721737222; x=1722342022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fG7fNhZ2W+GFDMLYQxfihplUKgf6DBg0yrpROSSaZgc=;
        b=BEQ70tR7aaP9/gs8R+K6zIJu/2x7sRQXE7n7yOU9MVs1zCXqO55huys5qFI8Px7D2x
         ASZVH/EFTJpxREIx+MOh8G6ABWxZmYzHrOjLkYXSByuJz2dj+fWgGmWg+oSkgvL4nDfl
         ueCN2V/+bWg9a7/1XW09gL6v1pMM+9n0lNRyj/jN5PrQivzfbhpB0WaZOdmey6GSbiUE
         8zic5/UjScs6SEB8iR0dVNZMjyeRiBYKXYC1dBksg/x5IhReU/Seq/kx4JckoWUIYTCW
         7MJXXS/1+8ppORA5cKvOD0R6LFi/UoIeOhYqdga5ZzDzrdUs0jk3E7X/IEdP+4KKn6J3
         sUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721737222; x=1722342022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fG7fNhZ2W+GFDMLYQxfihplUKgf6DBg0yrpROSSaZgc=;
        b=lKhT/+ZnDMTfvD+yK8CSnvOrVAufYTF14Eiy1Q3dDOWc681UJb3xJMiUTWANw+cw00
         eGv7gCcLFh5HLeGZevrrcurFC/Nnf1t7PoJh0SinR0uTbex/pmomLi9SLpsxVu5MRNA1
         LdiOsHS/Klf3k8Wepg+kXCV+vAb5ttEKrpMeBadGTBrd1t1kUqk5nNKi2dpSWBUphYJQ
         otRXZ4TopG1BCiEuBH/uPW0gdvTh+DwRbcApq72iH3bdZgyPXqi44iI7fLDywOHpikL1
         fqgVp44Tn7pAxJfqiUuF5fpMlsR9XAMkvNCC70T0qZMpYLorqnde1xXkoBlZBKdjTHDn
         5/iA==
X-Forwarded-Encrypted: i=1; AJvYcCViS5yDoHmv742v6KPd+R1RpjwB4TkVNjS4Vu1VIxjQXFkvYKGjuE+xC9cCjmlajVOSwBIWSVPxEA3ScGk3jRpcr7aHjykLwDTQly7T
X-Gm-Message-State: AOJu0YyV7iPG3/SzSoOt/JKpaDaZIYuKzkbWflYdu2hpyUve8JoGSS6k
	3UXQvRhJU+z5dmfaklTepF/CUbj6aaWk7Q7P1B5SL8ZENSFTmw6/J1feB83mTk0=
X-Google-Smtp-Source: AGHT+IGAEHFUt5M4vKaokd2y7KerpCjO1d0693Y4Eylxu3U9gaMtZAzO72rabliFmbHoDuY5j+VWHA==
X-Received: by 2002:a92:c56b:0:b0:397:a8a2:7c58 with SMTP id e9e14a558f8ab-3993ffd5d0emr103653525ab.3.1721737221710;
        Tue, 23 Jul 2024 05:20:21 -0700 (PDT)
Received: from YGFVJ29LDD.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d2820a945sm3261466b3a.74.2024.07.23.05.20.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Jul 2024 05:20:21 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: chengming.zhou@linux.dev,
	linux-kernel@vger.kernel.org,
	joshdon@google.com,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH v2 1/2] sched/fair: Decrease cfs bandwidth usage in task_group destruction
Date: Tue, 23 Jul 2024 20:20:05 +0800
Message-Id: <20240723122006.47053-2-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20240723122006.47053-1-zhouchuyi@bytedance.com>
References: <20240723122006.47053-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The static key __cfs_bandwidth_used is used to indicate whether bandwidth
control is enabled in the system. Currently, it is only decreased when a
task group disables bandwidth control. This is incorrect because if there
was a task group in the past that enabled bandwidth control, the
__cfs_bandwidth_used will never go to zero, even if there are no task_group
using bandwidth control now.

This patch tries to fix this issue by decrsasing bandwidth usage in
destroy_cfs_bandwidth(). cfs_bandwidth_usage_dec() calls
static_key_slow_dec_cpuslocked which needs to hold hotplug lock, but cfs
bandwidth destroy maybe run in a rcu callback. Move the call to
destroy_cfs_bandwidth() from unregister_fair_sched_group() to
cpu_cgroup_css_free() which runs in process context.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 kernel/sched/core.c  |  2 ++
 kernel/sched/fair.c  | 13 +++++++------
 kernel/sched/sched.h |  2 ++
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6d35c48239be..7720d34bd71b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8816,6 +8816,8 @@ static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
 {
 	struct task_group *tg = css_tg(css);
 
+	destroy_cfs_bandwidth(tg_cfs_bandwidth(tg));
+
 	/*
 	 * Relies on the RCU grace period between css_released() and this.
 	 */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index da3cdd86ab2e..c56b6d5b8ed7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5615,7 +5615,7 @@ void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
 	cfs_b->runtime_snap = cfs_b->runtime;
 }
 
-static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
+struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
 {
 	return &tg->cfs_bandwidth;
 }
@@ -6438,7 +6438,7 @@ void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
 }
 
-static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
+void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 {
 	int __maybe_unused i;
 
@@ -6472,6 +6472,9 @@ static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 		local_irq_restore(flags);
 	}
 #endif
+	guard(cpus_read_lock)();
+	if (cfs_b->quota != RUNTIME_INF)
+		cfs_bandwidth_usage_dec();
 }
 
 /*
@@ -6614,11 +6617,11 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *paren
 static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
 #endif
 
-static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
+struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
 {
 	return NULL;
 }
-static inline void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
+void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
 static inline void update_runtime_enabled(struct rq *rq) {}
 static inline void unthrottle_offline_cfs_rqs(struct rq *rq) {}
 #ifdef CONFIG_CGROUP_SCHED
@@ -12992,8 +12995,6 @@ void unregister_fair_sched_group(struct task_group *tg)
 	struct rq *rq;
 	int cpu;
 
-	destroy_cfs_bandwidth(tg_cfs_bandwidth(tg));
-
 	for_each_possible_cpu(cpu) {
 		if (tg->se[cpu])
 			remove_entity_load_avg(tg->se[cpu]);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8a071022bdec..d251842867ce 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2938,6 +2938,8 @@ extern void init_dl_rq(struct dl_rq *dl_rq);
 extern void cfs_bandwidth_usage_inc(void);
 extern void cfs_bandwidth_usage_dec(void);
 
+extern struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg);
+extern void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
 #ifdef CONFIG_NO_HZ_COMMON
 
 #define NOHZ_BALANCE_KICK_BIT	0
-- 
2.20.1


