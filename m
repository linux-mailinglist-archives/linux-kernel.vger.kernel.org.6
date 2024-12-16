Return-Path: <linux-kernel+bounces-447318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 640B19F307C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A3A1884F77
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A347204C3C;
	Mon, 16 Dec 2024 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="C0zf8WuF"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293A12046B2
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734351865; cv=none; b=WkH59q2RN9VUwWnkE3fw0JVMU9F18XhV+EfdSvzsanoscE3Z9ws5JzsBrIwLPltgx5xO0C7R+hnc9Vc0/ZOeHytkAUq71rMt0hCDjj+MJqoPJSTPsV+k4I90nlrPfrw0njAJYsYLDVCUWzHVpo1nF+Q0vpVsG7htRGC9U3RMtcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734351865; c=relaxed/simple;
	bh=7uodcHImsvmbWdzwGJxC39y0Z4LO/fg82j5/Ac+9irA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xr2gbXOIFgxUqqadR8WukM9ZvKqnFO2uBd5DmMovkXp9SIQ7tCOKoKPn0ZvLKzfPW34oAA3j8Q86Nj2tgG6bhAEzcots6fkNvsycBmj+gCwelY51A95hLComPJ/xiBF/jPmIuwF08w8/xpiOuDL/RRWtT5iPTF7exDcdna8InIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=C0zf8WuF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2162c0f6a39so44053955ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 04:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734351863; x=1734956663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phtcloGBPxbo3bGe+fbvNysMDOLgdZmP6FtnIiSbizc=;
        b=C0zf8WuFXWYP5Lhxo0p+CcUPiQeaQ/XKpXs8vyT6xukH8UWpadVMh1zMWCzH/J/l+c
         SAJlZQiAdEupzhVKZwpAR932xbCYew6E29itLck5e1r0A58EGXHIkDWqFfDND4ymlXZL
         LqpI3haltAQF/du2Yl/6kuHv1wfvozs38CcH9JTL6LGcUQJIi9K1mVHnpXUN9z10y7uO
         7AlguRR/tb5GlwsxwBapo3lK5IHyexELdsBsdP18wOGuK9lGg7Pj3loyqj6ijvTUMpR2
         Y205v2vBXnOLZreVgIu7DzCN3/P1hjfmXGrcoUNO40z3zMq/UdSgsr7jYIqEYmkyeFxm
         GXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734351863; x=1734956663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phtcloGBPxbo3bGe+fbvNysMDOLgdZmP6FtnIiSbizc=;
        b=CWAkabwTb/TsKbpTN2tdimLxDP4FTw8Gw4WlTo0tPMYhlr1ixMdBax5fOMrt7NFbPD
         96jwGF96BkyC/I//yCc6hk859xQnNWLG+xNQcVDEVuQBRtl+Y+N9TDeYCxvoAGV1XmzL
         vqMNEf8FznGEH7ep+9p2f6hzQUWVEcFk4o6xmCn2oAExLrVpNUIOLdxKCgBTWbytDMXV
         0L6MU+xwY4edNE2wl/nhFdpSRxxEAGR2Gpg6ALYfASulUtt/4MaFQhxyhxiSuG+C/7o/
         46d0V2CP/dT9KkFwM3Oohhh2IA2piS7plAPkYKW0OEvwJt4MXsC5ahg+GlRodekERZQV
         S67g==
X-Forwarded-Encrypted: i=1; AJvYcCWNN6K6/8Y8/jcltJVMbOA//70H6wdpaAi0xvi9PM/f824YVuWvT/FllRJRYmIitOF55ZmTlQzpglc17U4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAFpKglGtHayTyJwWP03jIohNriVU27p+H1aOPGx+j4M9cVhA0
	5+CTj/RILIqJKuMCiZ4gRoA9uIaw7Lw7e4jr1DtrlFbWHuM2PEgAAozYIVWS2yQ=
X-Gm-Gg: ASbGncscfIooRxV76Ic3+KDFi7gqfNyAS2EbL1L974nqjIFQq6qbZu0Za0yUb5q0s7U
	hDQH6ZTBzVjv0mwpA+9PKfyTHzCDLY1jo99qiA3kMnoplQCMLwKTVn5cHucTFCgsVUH1zfs2QFB
	vs8NtLaaQGo0I9a31zhdSEBDN9k14bVmtOoe2o2z2MtS4vWNka3zP8rbIem59fTG4ezWIuYqkPP
	MYUBSoQ/ZHCYCPuwlUBWqNX70uuneJQZzn8Y9x+bZNaP6TuviOq4mM8C99kswiNEcYpQOaGE1tg
X-Google-Smtp-Source: AGHT+IFlbd/fyubQoVxVPUqZLEyg8lZJk176wd7Gvn9IXFj09lK1ksv+/9kyQeDjNjF0XPDerLMtqw==
X-Received: by 2002:a17:903:184:b0:216:59f1:c7d9 with SMTP id d9443c01a7336-218941e89efmr159696435ad.19.1734351863429;
        Mon, 16 Dec 2024 04:24:23 -0800 (PST)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e6d0e4sm41501555ad.261.2024.12.16.04.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 04:24:23 -0800 (PST)
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
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH 1/3] sched/fair: Remove unused task_numa_migrate return value
Date: Mon, 16 Dec 2024 20:23:55 +0800
Message-Id: <20241216122357.1276382-2-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241216122357.1276382-1-zhouchuyi@bytedance.com>
References: <20241216122357.1276382-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value of task_numa_migrate is unused, remove it.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 kernel/sched/fair.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d5127d9beaea..f544012b9320 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2486,7 +2486,7 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 	}
 }
 
-static int task_numa_migrate(struct task_struct *p)
+static void task_numa_migrate(struct task_struct *p)
 {
 	struct task_numa_env env = {
 		.p = p,
@@ -2531,7 +2531,7 @@ static int task_numa_migrate(struct task_struct *p)
 	 */
 	if (unlikely(!sd)) {
 		sched_setnuma(p, task_node(p));
-		return -EINVAL;
+		return;
 	}
 
 	env.dst_nid = p->numa_preferred_nid;
@@ -2600,7 +2600,7 @@ static int task_numa_migrate(struct task_struct *p)
 	/* No better CPU than the current one was found. */
 	if (env.best_cpu == -1) {
 		trace_sched_stick_numa(p, env.src_cpu, NULL, -1);
-		return -EAGAIN;
+		return;
 	}
 
 	best_rq = cpu_rq(env.best_cpu);
@@ -2609,7 +2609,7 @@ static int task_numa_migrate(struct task_struct *p)
 		WRITE_ONCE(best_rq->numa_migrate_on, 0);
 		if (ret != 0)
 			trace_sched_stick_numa(p, env.src_cpu, NULL, env.best_cpu);
-		return ret;
+		return;
 	}
 
 	ret = migrate_swap(p, env.best_task, env.best_cpu, env.src_cpu);
@@ -2618,7 +2618,6 @@ static int task_numa_migrate(struct task_struct *p)
 	if (ret != 0)
 		trace_sched_stick_numa(p, env.src_cpu, env.best_task, env.best_cpu);
 	put_task_struct(env.best_task);
-	return ret;
 }
 
 /* Attempt to migrate a task to a CPU on the preferred node. */
-- 
2.20.1


