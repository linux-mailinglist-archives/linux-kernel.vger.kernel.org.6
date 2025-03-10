Return-Path: <linux-kernel+bounces-554753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FCFA59BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB8F23A642B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DEA23535A;
	Mon, 10 Mar 2025 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="La9SvrDz"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6699223236E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626307; cv=none; b=CCsaMSrgim0akUJUzEu1dJ5INU+GeWDlbYcK7pZhqB8DjgjjfW2KkbsDDxMU9qWsmWllxeAXKD/ZsGgm7O1KxoS1TCdcXMx//iQ/XtkZImVj0XidXDT4ceMDmo5VKJeoij3OzS20dQCHGtLrb3SQtTJ/qaNUDOX8NKCqtOcbGJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626307; c=relaxed/simple;
	bh=NEXQa8SMxoUZIhEM2LZtR5hPu3GN/muNBmbxrg6/Pks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qjfhNlO927ujsJSFXPzfUMaqDFATKDre7UJZdi1zqsztWEwNKqbJOth/mWUWvYLXPEttESeI7eyaAFQfchR6M8rdsynI1b/xXjmrOK1ImKUCd7GhiQqa2GTXvi819B7BHLbckIb4yIG+GVsDZ1IA4eGY0soBQyJyOMx3bdLno9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=La9SvrDz; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3913d45a148so1527571f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741626304; x=1742231104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcDctnJZ8SS/Sh/C+IjYe92Zf0/KDo0yTr6Uc7WvnrA=;
        b=La9SvrDzYVLL6AmRR+fYNY4z573h3sZ81a5nPhoIEoQQS3snWF84EuyMv/XOtPuoN+
         Ajyz2qo+PnXbq14ydw5G5y4fKf3pb/h+2knumZeJu1OobYpoaXyvnSGKWswcauGZhlJO
         +uhCIvRerTZToU7l33fsyGZof1Nz7O/6LC6smWgMceP/ZibQ1Lck3yAmqvmbJFFd/SPB
         nMm+m4CiIYqnUHVWu68P2r3vp8ZaaPnEdfQ7y3V8QoyiSyT0hLkjfv6qiKZX6NB2pyVx
         KUIFX/LuEVZX5uSDX1cEtPu35ud9FfWydwrLoqQs2TVZgOWgZQxJnTAbQt5zOFOpOUti
         NJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741626304; x=1742231104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcDctnJZ8SS/Sh/C+IjYe92Zf0/KDo0yTr6Uc7WvnrA=;
        b=VuNdU/B6oAdqTAtsue99Q5VcV6pEU3cJZk1e40UCHnTteXsVZsrB6AEQLRqXwTpsql
         i+3Mx4PIXi8iVT4NWUPxuji5u4ckTxE1dqDIY3iFFbGQsutDJ+csGCfhBL5bpLRTdODB
         pVC6uXoCgyXL/Fn19J3jFrK8+xeWvntwBXkegGpqozL76WMI1IiNhJOUN4mgAEAbRhb9
         W2MW1FJ7ZKTMkhBW5ect4yMZPbzRpO7FNsZCr7roGUf6Dnr5y/p8p3oblY8PypjbwDM/
         uOpJiyzPUBv6CZu8cy2JS6Rvoh0BF9hBa93gHzpV0vButmVGNPrQhjmgEJQXQQdwHuvC
         i9aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqzcLbSVuk0jhzSaP9cd4aIYWD9rRFGT8DMG+4cZQ+oNECfYaA+hFPKeSHsNzTZLRmBh0GT544yMcG9zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqQ6AMxfhkuQWW8Oksvy5D+vKIQcCWGwUwnZWS51Ucy6qGUCoF
	QTGtjS4RGnSHSMGSy2l4Wj0N/r1fZiiARvvZlokUZpPBek1mGgTSZIsrMRGeYNM=
X-Gm-Gg: ASbGnctUSbBTea6m7DFTEPO1kgiTdqD+OJm2YMED213tbGoBjhM2nunwxmmur2bbGEZ
	jLGFlZonhLcpBQqjYYC9sxW1CVD1GEJStLb+ekYqr/76kQiPxxmHE+uTnabBhoVBcW/QPiDBd6T
	95SveU4nEgqhu4OrKReuU90B9PzD4SAvpMG5XzHBO5Y+ngVrf1SYd5ME45f8tcmZYvAGiRTgQxN
	BqItyZGGgJ/aqCAmGxF2bDmRKEg1ldly61jpDS3a76SOC2YS83YSy10MeWQWattnHe2DoQItTPs
	PMylciqUNeez5ZemaJEVs5vNe4a1zxaMmBv3MN67zKFe9Js=
X-Google-Smtp-Source: AGHT+IG6kTPO393G97E2Dsk2pny69eK7SIEG7dbAP9YioBNWsi6aOdQGFnTshbQQIrgdWs6vNe8r3w==
X-Received: by 2002:a5d:47cc:0:b0:38d:bccf:f342 with SMTP id ffacd0b85a97d-39132db8b3cmr11627840f8f.43.1741626303548;
        Mon, 10 Mar 2025 10:05:03 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba679sm15302514f8f.8.2025.03.10.10.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:05:03 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: Peter Zijlstra <peterz@infradead.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH v2 06/10] sched: Bypass bandwitdh checks with runtime disabled RT_GROUP_SCHED
Date: Mon, 10 Mar 2025 18:04:38 +0100
Message-ID: <20250310170442.504716-7-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170442.504716-1-mkoutny@suse.com>
References: <20250310170442.504716-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When RT_GROUPs are compiled but not exposed, their bandwidth cannot
be configured (and it is not initialized for non-root task_groups neither).
Therefore bypass any checks of task vs task_group bandwidth.

This will achieve behavior very similar to setups that have
!CONFIG_RT_GROUP_SCHED and attach cpu controller to cgroup v2 hierarchy.
(On a related note, this may allow having RT tasks with
CONFIG_RT_GROUP_SCHED and cgroup v2 hierarchy.)

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/core.c     | 6 +++++-
 kernel/sched/rt.c       | 2 +-
 kernel/sched/syscalls.c | 3 ++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5b67b4704a5ed..a418e7bc6a123 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9166,11 +9166,15 @@ static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 	struct task_struct *task;
 	struct cgroup_subsys_state *css;
 
+	if (!rt_group_sched_enabled())
+		goto scx_check;
+
 	cgroup_taskset_for_each(task, css, tset) {
 		if (!sched_rt_can_attach(css_tg(css), task))
 			return -EINVAL;
 	}
-#endif
+scx_check:
+#endif /* CONFIG_RT_GROUP_SCHED */
 	return scx_cgroup_can_attach(tset);
 }
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a427c3f560b71..f25fe2862a7df 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2866,7 +2866,7 @@ static int sched_rt_global_constraints(void)
 int sched_rt_can_attach(struct task_group *tg, struct task_struct *tsk)
 {
 	/* Don't accept real-time tasks when there is no way for them to run */
-	if (rt_task(tsk) && tg->rt_bandwidth.rt_runtime == 0)
+	if (rt_group_sched_enabled() && rt_task(tsk) && tg->rt_bandwidth.rt_runtime == 0)
 		return 0;
 
 	return 1;
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 8629a87628ebf..7b1689af9ff1e 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -634,7 +634,8 @@ int __sched_setscheduler(struct task_struct *p,
 		 * Do not allow real-time tasks into groups that have no runtime
 		 * assigned.
 		 */
-		if (rt_bandwidth_enabled() && rt_policy(policy) &&
+		if (rt_group_sched_enabled() &&
+				rt_bandwidth_enabled() && rt_policy(policy) &&
 				task_group(p)->rt_bandwidth.rt_runtime == 0 &&
 				!task_group_is_autogroup(task_group(p))) {
 			retval = -EPERM;
-- 
2.48.1


