Return-Path: <linux-kernel+bounces-553663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FDFA58D20
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F6177A2F54
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712C4221F1D;
	Mon, 10 Mar 2025 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="htLYctvP"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CDE221DBC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592496; cv=none; b=pUJ8tztf2LdQlcnXYxPVb7+li0wp3256QQNysorMdWJwfpQEUFQ9AbCJIyz3Q2xjr9+m/vTVQc1CDj+KXxI6pmBTvaa9LMAkKWGgmVSff41/irtkVgtWxso7CBtsyopwy5c0ENjFd4Xiw0kQrZRxhhHgyXFRCwygyHex58+aL+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592496; c=relaxed/simple;
	bh=iHXz0DVtpBqp6Ds8dXd/ivCMUoYnqXfBxxSXb0EUHJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CWF9AByydAjpY5QVMNuw1YXB11SR9fIuRwbrj9L06Wxek8Y+RMYYEmmiFZ7AisEs6FTA/84hgIJB1BZPeJv0pFhw5c3o6Ktw26JacuHy/TpuljAHJV8vYqMMaS9CBhsMlbxI/YPDc2KNgBGP+RCj9lgf1u6YPl3MHrlZojKi68g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=htLYctvP; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2240ff0bd6eso7813795ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 00:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741592494; x=1742197294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfBrsfHwmmyQzbY8YS0Qe2jQHHDpz5P2nyRxc/932w4=;
        b=htLYctvPPjv51Xf9X9XJtUShN54cbEx5PJa/xc63tyu3sBeDgM2+079rBxxD29+vJZ
         fWlHnVMJPnxsU4d00NfKnkEIFgeCuVgkjmTtU3kKKjHfrYeSsps3s9Z3XjY9VG7Yfj3C
         +GROo0tVWPxVwM37wMH+/GsjhI+wX0ENhY3Zime3U9p6GlI1Md5ryqla44Bsz+50LpzJ
         VwukA3BH9+GqjsOENMKktiCSvhO1DqFr7fBGNuGpljviZOxEosEBKIAnLw/T0j10UTHR
         020+FNzr9ogNYG58YJpt0KotgpnVUpbljU+GlmmNdOz+8K2Mu7c57s1CwdX5TilmnMPl
         xljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741592494; x=1742197294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfBrsfHwmmyQzbY8YS0Qe2jQHHDpz5P2nyRxc/932w4=;
        b=shlnc8atPWPVm1ScNirYrf7Qtb99HvvDyGYyqMrhi/i03b2SNrSBXmpthd+Si+45ru
         UGL4oRVq7iRCfkyyIpXSAjnEjOj5LB/BZGM+WHG/CCej+ys9yXgo6p7cauFLcbkmVGf0
         VuwFVusOpxXP9k0SdcjHDVCa14NCYjWiSP6NJ1E/RQ94yLTwYhTpVDRNbQipJ3YpcXQr
         xXWJig8fFkC4hsEyUM3xs6JXMxnbX+0yEPFBa5D8iucAoweQuXOOn+MddM3bzCctSPhh
         m7HrZrK/fyIHAWqR0JbDDCCk6CI7eVlhMRpoYMxEYBBXM9lekqcBUjJ3qFKxCUOvrjgt
         ncag==
X-Forwarded-Encrypted: i=1; AJvYcCWgpiJnxq6JIIGATbzE730GpquLcLUWgEVIfC/Qi8FbMF8pm7Cmrk2NjXg6SXzV7yUZsSkHocbAPupe4hQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ASfcJMlgpi9+nf6q4Ze/DKJ3twk4Lw8RowH/6P2y6BepiM34
	eo0gh+TgaaDt1XbqoUJUEHrCEDAGB+uy5MVgTrEXqB/nf3WhMj2YBgCRCVe1o0Y=
X-Gm-Gg: ASbGncvTdfw5KEcLDAi5qTh/B9xNEtrrHRTPbQOh+nE0LZYf8KvlvPxRcCxAOnamJt5
	3tCvlzaD7fFu9AQinofjcZhln+3v0sYIQDOH4VdUDbVCGe43J5EzntGPM2LFDROUsuIJSo/fK6R
	bTRr+5uvyqRXppfloZWy5wfGWqUhVf2+4rHI1uvFl0nhJYxyTFulkETn9vGiVlT43/5KtuDJWSK
	XG0jpnwRlgBm2z5b9jGnzKbVr0AS9X52Nki6LmYPd3r8IF1uNike7bG1Cz+QhVEphdteW1pof9A
	IQeQ75gErAOObfTRSoMIC24tOA3c4tQJSMAYyQOahtNQfExeWV5hICPxFuYS/+eCYNiUyQVLKQ/
	2VK2813r9vyEN
X-Google-Smtp-Source: AGHT+IH5Qdlab5pDp5bpPDrn8zN5TAveEl5YKZ1gCPjzJqhvdVkKTpCkvXPHsdmxIW4JzW/oZyDgzA==
X-Received: by 2002:a17:903:40ce:b0:224:8bf:6d83 with SMTP id d9443c01a7336-22541efbc49mr48486015ad.8.1741592494126;
        Mon, 10 Mar 2025 00:41:34 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f8b6sm70965225ad.136.2025.03.10.00.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 00:41:33 -0700 (PDT)
From: Abel Wu <wuyun.abel@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Josh Don <joshdon@google.com>,
	Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>,
	linux-kernel@vger.kernel.org (open list:SCHEDULER)
Subject: [RFC PATCH 2/2] sched/fair: Do not specialcase SCHED_IDLE cpus in select slowpath
Date: Mon, 10 Mar 2025 15:40:42 +0800
Message-Id: <20250310074044.3656-3-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250310074044.3656-1-wuyun.abel@bytedance.com>
References: <20250310074044.3656-1-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SCHED_IDLE cgroups whose cpu.idle equals to 1, only mean something
to their siblings due to cgroup hierarchical behavior. So a SCHED_IDLE
cpu does NOT necessarily implies any of the following:

 - It is a less loaded cpu (since the parent of its topmost idle
   ancestor could be a 'giant' entity with large cpu.weight).

 - It can be expected to be preempted by a newly woken task soon
   enough (which actually depends on their ancestors who have
   common parent).

As a less loaded cpu probably has better ability to serve the newly
woken task, which also applies to the SCHED_IDLE cpus that less loaded
SCHED_IDLE cpu might be easier and faster preempted, let's not special
case SCHED_IDLE cpus at least in slowpath when selecting.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/sched/fair.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 379764bd2795..769505cf519b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7446,7 +7446,7 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
 	unsigned int min_exit_latency = UINT_MAX;
 	u64 latest_idle_timestamp = 0;
 	int least_loaded_cpu = this_cpu;
-	int shallowest_idle_cpu = -1, si_cpu = -1;
+	int shallowest_idle_cpu = -1;
 	int i;
 
 	/* Check if we have any choice: */
@@ -7481,12 +7481,13 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
 				latest_idle_timestamp = rq->idle_stamp;
 				shallowest_idle_cpu = i;
 			}
-		} else if (shallowest_idle_cpu == -1 && si_cpu == -1) {
-			if (sched_idle_cpu(i)) {
-				si_cpu = i;
-				continue;
-			}
-
+		} else if (shallowest_idle_cpu == -1) {
+			/*
+			 * The SCHED_IDLE cpus do not necessarily means anything
+			 * to @p due to the cgroup hierarchical behavior. But it
+			 * is almost certain that the wakee will get better served
+			 * if the cpu is less loaded.
+			 */
 			load = cpu_load(cpu_rq(i));
 			if (load < min_load) {
 				min_load = load;
@@ -7495,11 +7496,7 @@ sched_balance_find_dst_group_cpu(struct sched_group *group, struct task_struct *
 		}
 	}
 
-	if (shallowest_idle_cpu != -1)
-		return shallowest_idle_cpu;
-	if (si_cpu != -1)
-		return si_cpu;
-	return least_loaded_cpu;
+	return shallowest_idle_cpu != -1 ? shallowest_idle_cpu : least_loaded_cpu;
 }
 
 static inline int sched_balance_find_dst_cpu(struct sched_domain *sd, struct task_struct *p,
-- 
2.37.3


