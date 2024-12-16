Return-Path: <linux-kernel+bounces-448067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EACE49F3A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD47188C50C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00D91D4341;
	Mon, 16 Dec 2024 20:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V9Fg00Dv"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7FC1D434F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734380003; cv=none; b=kcZdxKqJIa55EZygUPONzOjBAB4Z4i/LYDWA/9NRN99jkd0pMeqUcJOiLjltJeDS2W3k5zkxgGAiP8OuA/fw7xe+Q+bkNAZojesN+dgxPBUyx7St6iPoE7JDQZ7cJacKC49LhxoRIprroMSqhkVhfcxoBB5kBUHxVdbAKuxVM+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734380003; c=relaxed/simple;
	bh=8xpukR/cApv4dVgoo08xeVNSIFIEqldxvUynW0kO7ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfjnC1xc+g+weWCSTOjgy4S1T0QGDEJ8sHbqfZ0lBMGSfygjqPN5YaLjtm2BX+B95h8rwqll2JnVT75HFxuotLRSAyhAcMjHdHJQ8Gr/Nyk+hm93DXOmWiUQ3aNzAOhAVJV7Zb0bkzyw/2F4/zE2NlctyH8MndIeP3EbXw3n+Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V9Fg00Dv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43635796b48so16210895e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734379998; x=1734984798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELwtM8rOu6mwy4EhHFHUg+bGTeHEN0nMLysx4xsM2ks=;
        b=V9Fg00Dvp3QdE6Jjo4kIiwISnywXb/0+PSeC75ScaGVp2yfiZaepzl8H3Kv5pWKCtu
         3DwOYsIJPOBiIr81quD/AbB2a9Ih1IY8xs9ktlqPsDotFo6jcQ5finrHEz+Bu2nQk7I7
         jPh466ILR/JGUOKOdala1RtgvXSaJpsosbmCy57zQku2JnsiuZNgI1Y4qdC2xWRBXM1J
         NwYQz1bsIjyPaA2ReYX5OXONa8UOzUzEZnVgJUwXGyM/XwTAQ1gEKIMI9OrjF0i1nJzP
         f0/LK3vuLxpwFsAcKlYRCdjX0yKekgyMNf4tx/LIfe5gnobHf2Zj2rkFoGDY93n64QsN
         Zy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734379998; x=1734984798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELwtM8rOu6mwy4EhHFHUg+bGTeHEN0nMLysx4xsM2ks=;
        b=j2umos3nmMagQfG+lOnvmyO9/2ljvwRFLxx2CefqD4BtEB/ATRFGWu4EU9Wbt0t9xn
         4qloL1nEiDlUyz37C9098GCRovEYGICivPJ5mXehSYQbTsEWicUGQ3vsVg71CjMthJzN
         q75GoOqcS0C7mHGby/ah889KNUNAyGb9eZek9QBeXbPIkhWgO7I+MYesxD88lqAun7Tz
         Vl7EbBkX28xcdLcuj3h1/1KMUNBYsVooLei/qPOaN9shUPGfBR5USpFTfYDXt7nnqIIg
         R2ilTEElgdCs9dcSbB1FLBpdRg8iPC/jujSlxEk8yLmvQAp1fClq4B8mQ7eAg1oJ9xXS
         /dsw==
X-Forwarded-Encrypted: i=1; AJvYcCWpTevi2/4tQ/nuTfDNmSa1SrnyEc9WtW8JmwxkbpBBUU8uqiTE0Kn2RFl0/N7j7gWZ49twUrUpvowad/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPfmHBzvpW0nqPfqe84EKOWRxL1LFTJjr3m7hB6XKXbJW7aHN5
	8KuQ1HMNLvZfKXM+c9SLR3m3EuvFTp/Atp/LMgVGQ9rNjHIULKLlXALv7kaFzIU=
X-Gm-Gg: ASbGncsqmzW0ez8JHMofLNmcNKizU3PV+GH5rB1thSapU10+KcwqSK/X3TCK3JsAywb
	3q8h8ByJoRIl5uzgymW8+VG8cT7Uf1fSCVMtcXNXXZYZloUnzQ/JfBxLfdUsxblkLKexHNaEawZ
	R1AY9C1bjTuTABZsjLhLBzJ4JIOLpvB65Qekz8OR9V3wU4W5p/jB8R/vqcjSF+OkaBO0FmClmVw
	Q/8ggrmfrEBtDAH+RCDGMmtS7rmtv9Z2n8oqc+Ek7nrFgh4O6O4+qdSqA==
X-Google-Smtp-Source: AGHT+IFaU+hTk8Vcu6QoJN6vBQIdWmOKWjm88Qu4m49pXUf0WXbKshK4S50Byug0SSi+sU7UrwZLbA==
X-Received: by 2002:a05:600c:1d25:b0:436:1af3:5b13 with SMTP id 5b1f17b1804b1-436481ebda5mr5845185e9.15.1734379998111;
        Mon, 16 Dec 2024 12:13:18 -0800 (PST)
Received: from blackbook2.suse.cz ([84.19.86.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a379d69sm473715e9.0.2024.12.16.12.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:13:17 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>
Subject: [RFC PATCH 6/9] sched: Bypass bandwitdh checks with runtime disabled RT_GROUP_SCHED
Date: Mon, 16 Dec 2024 21:13:02 +0100
Message-ID: <20241216201305.19761-7-mkoutny@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216201305.19761-1-mkoutny@suse.com>
References: <20241216201305.19761-1-mkoutny@suse.com>
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
index dfd2778622b8b..6e21e0885557d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9158,11 +9158,15 @@ static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
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
index 923ec978ff756..161d91f7479b4 100644
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
index 77d0d4a2b68da..80382f5d53a44 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -644,7 +644,8 @@ int __sched_setscheduler(struct task_struct *p,
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
2.47.1


