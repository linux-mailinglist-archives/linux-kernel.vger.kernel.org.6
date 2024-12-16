Return-Path: <linux-kernel+bounces-448068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FEA9F3A98
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56969164165
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2FC1D8E18;
	Mon, 16 Dec 2024 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CWeZVFj5"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203E61D6188
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734380003; cv=none; b=iC/e7m3t8zIQqM0evk58I2LrXAySSei/3DdVNzHKRAa8zYXJz16n3R05OZRZ3Qm6DyE4wS4WbyPrV5UfFnpTU682LHMSWPVU1PQRbuXFv1hCJuVujK4dNTSupwFHcC0rkNyfuTVnJ0jyjyjtSJjs7EGJYtvbQgctO1dksPA0J0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734380003; c=relaxed/simple;
	bh=BgnE3y0aEkA+6mEwxppauEiIwzvGAc2MheHabRKMMzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZdp5TIOq+XelGhv+GLeFe9CRNUHPbsnrO4IH92TrCZO2BVMZR7qSYWJ6Xhlxh7jhOx4wieR4blh0Gnt9LW7MiLRKTwOmChhu798j0f0kbrMo5yz72Pf7RaPDM9kFfEK40eSDt4gFcSWHVEJLLvPKJmhQ4limN7+cuGb8mD4N/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CWeZVFj5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so192075e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734379999; x=1734984799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+uDEQRPgLnIuRhkfP+uF78Vcg5q4+H6L1oWNhvU8jc=;
        b=CWeZVFj545qKgLqsnPIpmdOJSkO4XpUJygw1kdtE8G7ePbk3/c87SlkGneCVxQQem3
         UhCrZmn+1k0oW3TVE6jiFtsHa8CyUrHLYCCNOz8gUlEKnyNgOtOgPBWiDoSW/A831j/3
         k5orv2kLboI5piGGpjTL7JXmYF7spb8O8KlJ0IsebdJbJ9YV9p9SmRruXs7ry0IZOMnL
         6tHcD0sMY4oqxBNk9/bupIrTiwSSSULSqqW6vzRSG4mMdXTYQMc2yYoyyMuFN1iuwmsJ
         RxI7CMuY0M/nGMYxLLeQ8VZ6AJtFdUkuSDRKxPXdyedkNRhbEuans8hOGLwFPtxIfRpo
         m/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734379999; x=1734984799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+uDEQRPgLnIuRhkfP+uF78Vcg5q4+H6L1oWNhvU8jc=;
        b=M5VbdVh6n4l5Wdcmp3BAi3aUh6y/Vz0uSXorQaTvv5mFdTxtm9HMBfRX75Lv2UYnnK
         kIO0KCdDp3vM/PIdPqGB3fRiNKKwma2kJ0HUiHxEhFHY8CF9uT+6vJDBy0HEP7pPi4J4
         Z3tDGAb/RTZk0RoCakKioATXjSvaRAhAJG9qA12FoVQjcYrgJ0e9cu1wMkWomFxwGXKk
         UHmNMpDLtSAB7XtJbt+Dx1kWN7mQS2rPpia3maozqY0nDWhqiCsEjUmXoY6lX8buNsgi
         Ld8UUUrqPK5ct67w+Lg4RpvxnaAXJFOD3A3GXrA1eJWRv6OGfctLOamIuTZc80Tc0leK
         0EQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6IOyPq0zlmimVBeiRzOhifqXNKZ6M1jOBkLJaIek62rhGykXBoiZAeBKMJAn10745pHgWAZSl28F9qq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLBpZxino9sNj9tLanO3ux7b11Gz9r3ty00r0fDGf5O1udgO0+
	1d1xvOL0RgcbIJ1fpEiOUqMDRsOi/0j0vP9Gi1aQRlbk7TOjWAhIVD90StsdaEY=
X-Gm-Gg: ASbGncsi5qquEwYp4qbn+1MckeWpGVvluFlN8Lk2jouYrYQ7O2ow/HkOAaaTr0GkQRL
	qmF+UH1VIYMCr+oMTDuMzivT2SYP4HMp8BcYmLCYX0BwIinvgkp5hplc2V2aGZpIKT9Qsd1vyI6
	Ird5uJ2YAoJEnEOFh/KsKZ41BpIBiRT/STuLcnJqtdYmtBeKMcPbLyk49UCnF59Ba25qlbS6L0c
	h9472b+5sxpXcasBy6ftUCrh6QsPd3MP1q3CvA0wx8+zcK+pMApGVhIIw==
X-Google-Smtp-Source: AGHT+IE0YPWhe33Skc7Ao7kIv0JHWWBX92wx7RBLT/PPrRR4qswieUBdDloiYM0Sh7mx0mPRokcAOg==
X-Received: by 2002:a05:600c:4e11:b0:434:f804:a9b0 with SMTP id 5b1f17b1804b1-4362aaa49b1mr125287635e9.29.1734379998887;
        Mon, 16 Dec 2024 12:13:18 -0800 (PST)
Received: from blackbook2.suse.cz ([84.19.86.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a379d69sm473715e9.0.2024.12.16.12.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:13:18 -0800 (PST)
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
Subject: [RFC PATCH 7/9] sched: Do not construct nor expose RT_GROUP_SCHED structures if disabled
Date: Mon, 16 Dec 2024 21:13:03 +0100
Message-ID: <20241216201305.19761-8-mkoutny@suse.com>
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

Thanks to kernel cmdline being available early, before any
cgroup hierarchy exists, we can achieve the RT_GROUP_SCHED boottime
disabling goal by simply skipping any creation (and destruction) of
RT_GROUP data and its exposure via RT attributes.

We can do this thanks to previously placed runtime guards that would
redirect all operations to root_task_group's data when RT_GROUP_SCHED
disabled.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/core.c | 36 ++++++++++++++++++++++++------------
 kernel/sched/rt.c   |  9 +++++++++
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6e21e0885557d..300a1a83e1a3c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9819,18 +9819,6 @@ static struct cftype cpu_legacy_files[] = {
 		.seq_show = cpu_cfs_local_stat_show,
 	},
 #endif
-#ifdef CONFIG_RT_GROUP_SCHED
-	{
-		.name = "rt_runtime_us",
-		.read_s64 = cpu_rt_runtime_read,
-		.write_s64 = cpu_rt_runtime_write,
-	},
-	{
-		.name = "rt_period_us",
-		.read_u64 = cpu_rt_period_read_uint,
-		.write_u64 = cpu_rt_period_write_uint,
-	},
-#endif
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 	{
 		.name = "uclamp.min",
@@ -9849,6 +9837,20 @@ static struct cftype cpu_legacy_files[] = {
 };
 
 #ifdef CONFIG_RT_GROUP_SCHED
+static struct cftype rt_group_files[] = {
+	{
+		.name = "rt_runtime_us",
+		.read_s64 = cpu_rt_runtime_read,
+		.write_s64 = cpu_rt_runtime_write,
+	},
+	{
+		.name = "rt_period_us",
+		.read_u64 = cpu_rt_period_read_uint,
+		.write_u64 = cpu_rt_period_write_uint,
+	},
+	{ }	/* Terminate */
+};
+
 # ifdef RT_GROUP_SCHED_DEFAULT_DISABLED
 DEFINE_STATIC_KEY_FALSE(rt_group_sched);
 # else
@@ -9871,6 +9873,16 @@ static int __init setup_rt_group_sched(char *str)
 	return 1;
 }
 __setup("rt_group_sched=", setup_rt_group_sched);
+
+static int __init cpu_rt_group_init(void)
+{
+	if (!rt_group_sched_enabled())
+		return 0;
+
+	WARN_ON(cgroup_add_legacy_cftypes(&cpu_cgrp_subsys, rt_group_files));
+	return 0;
+}
+subsys_initcall(cpu_rt_group_init);
 #endif /* CONFIG_RT_GROUP_SCHED */
 
 static int cpu_extra_stat_show(struct seq_file *sf,
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 161d91f7479b4..db7cdc82003bd 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -195,6 +195,9 @@ static inline struct rq *rq_of_rt_se(struct sched_rt_entity *rt_se)
 
 void unregister_rt_sched_group(struct task_group *tg)
 {
+	if (!rt_group_sched_enabled())
+		return;
+
 	if (tg->rt_se)
 		destroy_rt_bandwidth(&tg->rt_bandwidth);
 }
@@ -203,6 +206,9 @@ void free_rt_sched_group(struct task_group *tg)
 {
 	int i;
 
+	if (!rt_group_sched_enabled())
+		return;
+
 	for_each_possible_cpu(i) {
 		if (tg->rt_rq)
 			kfree(tg->rt_rq[i]);
@@ -247,6 +253,9 @@ int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
 	struct sched_rt_entity *rt_se;
 	int i;
 
+	if (!rt_group_sched_enabled())
+		return 1;
+
 	tg->rt_rq = kcalloc(nr_cpu_ids, sizeof(rt_rq), GFP_KERNEL);
 	if (!tg->rt_rq)
 		goto err;
-- 
2.47.1


