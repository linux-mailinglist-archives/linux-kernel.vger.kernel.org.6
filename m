Return-Path: <linux-kernel+bounces-447320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F7D9F307F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9572E1646CA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86B52054F0;
	Mon, 16 Dec 2024 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D10R068g"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC518204F98
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734351878; cv=none; b=ZJtZySHjaHR5LqhC4rSe9LIqMiM2DJ/EvXH9SDWgIaN1glnx734vD73nNitUCwo87zXpU+cnCPTt8dd+n7twJNF18FDehugDISMgonqGIrnTZlj7P7xFE8bJD796P7r1E9FcDZNBCkqQGjJKXMoLEkY/oPq2xFJHdaCsgtXEUlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734351878; c=relaxed/simple;
	bh=04lNmsNySnVFo9f3O4o4cKfbKTj9UhtSwAYs8oiNvOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qdXmm7XYDoIgu7EtZROWoiN5ZVrsKZdOylZbLxKxKNR4l9Lbtl3v6xM7ddPLSy6g9a3Ai6gjSKah/bYfPn2ezl/X/kihOtWAl1Mfk/l6yj25JF42LqS3UFuaIds+m9DKL9XuNVWhwdHnGcA8e2xU2duXswnrAo+k+r5hwRvGJbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D10R068g; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21619108a6bso29043775ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 04:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734351876; x=1734956676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUMl/jt9UeNbHuZ/o30GHqr3MzCzR59KrfQ73K3Jzow=;
        b=D10R068gv7RaeELxZORqHJgaZ7fJ/PAZqRgOR5rgGlDRDPgt6iY+03hvyb0BoWxe5V
         /goTQ9fdoABtcH0TPVUMc68i4IqISZhkE54BpRbVW4oYsXL+nAG8kcO9+m8xT/Xr8Vp5
         tuoQI98k0k95tNC9J0UWUQLIYIEIwkUtj/qWEBiMt3rYQ53ivBW1hFIzKM0XZ1pMq97J
         vUUEqenHYUPXSa4GNVCMmUVJ7pMbpcLZDIaWtDW0pIgDUC3fxvLAuehHbkQcuN9XTytY
         d4Fd0FjFpuUvrriBFVx+iR9B7yPJZzcVuaK+6YxKJimy9Otw3EnDQYutDBkah8FsTZlo
         QRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734351876; x=1734956676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUMl/jt9UeNbHuZ/o30GHqr3MzCzR59KrfQ73K3Jzow=;
        b=eZ4yMi7NEvLfdHEN+hloydzeOafYw021zo+XZw0wIX5EO8KBoJDeufd10WJOQp8Yp3
         1ja5ug+0xUQP1Aa+ofkhuUaLZKHlreDAbjyL2H3ZtPUwjUU6J/QzbW8Ov2uxkwnASLu/
         USNjXV5sxoMLdUaNzL7ybOViar4OqUKWX21gez2BP0XyEgs89DvG991Ag5DeTrrw0C4D
         w6JgH2u3pqwdFkta7H+wC43zHzB9Y9/yGgFufrBitsE/VVXZRcImWjvzNeKKCGR7PJEm
         PYgLTqKLrHe9e6nm9USdgMO0nBD8xuO/l6R0NXdtrDK9xJwSBg3n3ZObyyMST9UBQzdX
         db+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPjsJWMuq0OPDdqoolQfTSTH+P6UrLxmMiKgelWphFL5kIzR1+ukqvcFV472SzcljifR/HYQb4fHxyrU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI86tT50ATTGwggbqRSa23mG3VKGmF8poKBNLyRDDRV4RVZt1k
	kk+tbGZ7lvZOlp5aa5AEvnw4Zd8mzSdNQa400+Gr+25nT/rZvIUbBs/KV7rz2ac=
X-Gm-Gg: ASbGncsSxNLspTxbEhPxYiN1gE93UCPXFx/1E5qk0bgyhVXl8YjIfEyPWJuuvTHR2Rj
	XeNcjQVNefB6G6bPJPgVpSX8C1gszWtnY2m7p6RpgYaeo8om2RSscnu0lLw09l4aFwnAvZRmOIi
	gJ9gqtzrrzQlcPZIBmmvH4azFmVzwqUv6Q5DQeHbKQSWdnJ4nGEtdpI0JBa7MXXn5VHw4sppl6l
	fGrHeJ0rsQLH4qD6zlm/JAQRhYfENRtUNMJmzuFfMz5kD8HbvMPw3AXXz+LjfxvDboYgERe+gtN
X-Google-Smtp-Source: AGHT+IGrGYtkFHnh0/1zDqJPaBCc+RrmUHzU5l6zwacst6iIHDvQtru++yFv6KVXYyXl8wycolmHUA==
X-Received: by 2002:a17:902:ebce:b0:215:9d29:b440 with SMTP id d9443c01a7336-218929a2156mr160268035ad.17.1734351876254;
        Mon, 16 Dec 2024 04:24:36 -0800 (PST)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e6d0e4sm41501555ad.261.2024.12.16.04.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 04:24:36 -0800 (PST)
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
Subject: [PATCH 3/3] sched/fair: Ensure select housekeeping cpus in task_numa_find_cpu
Date: Mon, 16 Dec 2024 20:23:57 +0800
Message-Id: <20241216122357.1276382-4-zhouchuyi@bytedance.com>
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

Now in task_numa_find_cpu(), we only skip CPUs that are not in the task's
cpumask, which could result in migrating the task to an isolated domain if
the task's cpumask includes isolated CPUs. This is because cpuset
configured partitions are always reflected in each member task's cpumask.
However, for isolcpus= kernel command line option, the isolated CPUs are
simply omitted from sched_domains without further restrictions on tasks'
cpumasks.

This change replaces the set of CPUs allowed to migrate the task from
p->cpus_ptr by the intersection of p->cpus_ptr and
housekeeping_cpumask(HK_TYPE_DOMAIN).

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 kernel/sched/fair.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a0139659fe7a..05782b563609 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2081,6 +2081,12 @@ numa_type numa_classify(unsigned int imbalance_pct,
 	return node_fully_busy;
 }
 
+static inline bool numa_migrate_test_cpu(struct task_struct *p, int cpu)
+{
+	return cpumask_test_cpu(cpu, p->cpus_ptr) &&
+			housekeeping_cpu(cpu, HK_TYPE_DOMAIN);
+}
+
 #ifdef CONFIG_SCHED_SMT
 /* Forward declarations of select_idle_sibling helpers */
 static inline bool test_idle_cores(int cpu);
@@ -2168,7 +2174,7 @@ static void task_numa_assign(struct task_numa_env *env,
 		/* Find alternative idle CPU. */
 		for_each_cpu_wrap(cpu, cpumask_of_node(env->dst_nid), start + 1) {
 			if (cpu == env->best_cpu || !idle_cpu(cpu) ||
-			    !cpumask_test_cpu(cpu, env->p->cpus_ptr)) {
+			    !numa_migrate_test_cpu(env->p, cpu)) {
 				continue;
 			}
 
@@ -2480,7 +2486,7 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 
 	for_each_cpu(cpu, cpumask_of_node(env->dst_nid)) {
 		/* Skip this CPU if the source task cannot migrate */
-		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
+		if (!numa_migrate_test_cpu(env->p, cpu))
 			continue;
 
 		env->dst_cpu = cpu;
-- 
2.20.1


