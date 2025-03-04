Return-Path: <linux-kernel+bounces-543035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FD6A4D0C9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DF8817470D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE3F132111;
	Tue,  4 Mar 2025 01:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hidxS7h+"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76635273FD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 01:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051690; cv=none; b=oFXtydQsYPXmxz9ISIcgTkUHuN45UHWubsypxKDxSlp430osBmhUQaA/W6PW5loUevqfUL8GnUubH1szckM6cefa/04Xl/3oT29Cv/f0KAB4dfNi6UUitORmlpSmYV/8+0kwNiiGUpLT8VM1nv2igZ0Byw8XW80UquzZgXRN/Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051690; c=relaxed/simple;
	bh=l9iOVVNLgYNfXAh4nO6CDsbNDWmbRtmzDTNYnXr2cRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f39G367m2mcWRz6wWIS5VDQGzUw5BhhyJ9wYu+H4ih/nN9t9puwCBLMNFDneWm82dpWcyMpFt0lCzsOPiQkNwyRl/AGqDUvhikJ2r7BrGuW3jCdONoXwTLSQONfLajWImxhJRf25qsDBD8Ez/wCMYW9mOWOhTMyz2bCY3aS7OQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=hidxS7h+; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VLzLYngtKKspnDi/wOo+/r3FDbyAZpJFWovD3xrE0yY=; b=hidxS7h+vxvnyM5w2rHvfamqcx
	2WnDOfrZeCZE870NKUCE1hOew/mg0ea+uXFn4CNjuj4hpuZJdQ8xX59wC6jlY8LVDBhSSxquJolBK
	H4V9Y3pD7uiJdmeJpzv7YivnUqj03GzEWqLHTUtP2vVtDj6eA4zyOqdt/gU2ECdJhD4CWyPEFm8Mk
	qkzLKbZa4IacQgQSPbD7juJ+HEpbbdn8ZUk5EjxDwAVmBG+J9MZj7AYmntmsN+zGP1MNp0QuThhm4
	8S+FsgL6W1eCHgdfE3G7DOM6d+VEf1rr6aP8bdELNTWeOOw5X0gxMNpo6dOrxM3gXmUiMfQP0Dpss
	h2tUySfQ==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tpH4c-003VPl-Fv; Tue, 04 Mar 2025 02:28:01 +0100
From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com
Cc: kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH v3 1/2] sched_ext: Change the event type from u64 to s64
Date: Tue,  4 Mar 2025 10:27:39 +0900
Message-ID: <20250304012740.35473-2-changwoo@igalia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304012740.35473-1-changwoo@igalia.com>
References: <20250304012740.35473-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The event count could be negative in the future,
so change the event type from u64 to s64.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/sched/ext.c             | 20 ++++++++++----------
 tools/sched_ext/scx_qmap.bpf.c | 16 ++++++++--------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 986b655911df..686629a860f3 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1489,53 +1489,53 @@ struct scx_event_stats {
 	 * If ops.select_cpu() returns a CPU which can't be used by the task,
 	 * the core scheduler code silently picks a fallback CPU.
 	 */
-	u64		SCX_EV_SELECT_CPU_FALLBACK;
+	s64		SCX_EV_SELECT_CPU_FALLBACK;
 
 	/*
 	 * When dispatching to a local DSQ, the CPU may have gone offline in
 	 * the meantime. In this case, the task is bounced to the global DSQ.
 	 */
-	u64		SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE;
+	s64		SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE;
 
 	/*
 	 * If SCX_OPS_ENQ_LAST is not set, the number of times that a task
 	 * continued to run because there were no other tasks on the CPU.
 	 */
-	u64		SCX_EV_DISPATCH_KEEP_LAST;
+	s64		SCX_EV_DISPATCH_KEEP_LAST;
 
 	/*
 	 * If SCX_OPS_ENQ_EXITING is not set, the number of times that a task
 	 * is dispatched to a local DSQ when exiting.
 	 */
-	u64		SCX_EV_ENQ_SKIP_EXITING;
+	s64		SCX_EV_ENQ_SKIP_EXITING;
 
 	/*
 	 * If SCX_OPS_ENQ_MIGRATION_DISABLED is not set, the number of times a
 	 * migration disabled task skips ops.enqueue() and is dispatched to its
 	 * local DSQ.
 	 */
-	u64		SCX_EV_ENQ_SKIP_MIGRATION_DISABLED;
+	s64		SCX_EV_ENQ_SKIP_MIGRATION_DISABLED;
 
 	/*
 	 * The total number of tasks enqueued (or pick_task-ed) with a
 	 * default time slice (SCX_SLICE_DFL).
 	 */
-	u64		SCX_EV_ENQ_SLICE_DFL;
+	s64		SCX_EV_ENQ_SLICE_DFL;
 
 	/*
 	 * The total duration of bypass modes in nanoseconds.
 	 */
-	u64		SCX_EV_BYPASS_DURATION;
+	s64		SCX_EV_BYPASS_DURATION;
 
 	/*
 	 * The number of tasks dispatched in the bypassing mode.
 	 */
-	u64		SCX_EV_BYPASS_DISPATCH;
+	s64		SCX_EV_BYPASS_DISPATCH;
 
 	/*
 	 * The number of times the bypassing mode has been activated.
 	 */
-	u64		SCX_EV_BYPASS_ACTIVATE;
+	s64		SCX_EV_BYPASS_ACTIVATE;
 };
 
 /*
@@ -1584,7 +1584,7 @@ static DEFINE_PER_CPU(struct scx_event_stats, event_stats_cpu);
  * @kind: a kind of event to dump
  */
 #define scx_dump_event(s, events, kind) do {					\
-	dump_line(&(s), "%40s: %16llu", #kind, (events)->kind);			\
+	dump_line(&(s), "%40s: %16lld", #kind, (events)->kind);			\
 } while (0)
 
 
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 45fd643d2ca0..26c40ca4f36c 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -776,21 +776,21 @@ static int monitor_timerfn(void *map, int *key, struct bpf_timer *timer)
 
 	__COMPAT_scx_bpf_events(&events, sizeof(events));
 
-	bpf_printk("%35s: %llu", "SCX_EV_SELECT_CPU_FALLBACK",
+	bpf_printk("%35s: %lld", "SCX_EV_SELECT_CPU_FALLBACK",
 		   scx_read_event(&events, SCX_EV_SELECT_CPU_FALLBACK));
-	bpf_printk("%35s: %llu", "SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE",
+	bpf_printk("%35s: %lld", "SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE",
 		   scx_read_event(&events, SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE));
-	bpf_printk("%35s: %llu", "SCX_EV_DISPATCH_KEEP_LAST",
+	bpf_printk("%35s: %lld", "SCX_EV_DISPATCH_KEEP_LAST",
 		   scx_read_event(&events, SCX_EV_DISPATCH_KEEP_LAST));
-	bpf_printk("%35s: %llu", "SCX_EV_ENQ_SKIP_EXITING",
+	bpf_printk("%35s: %lld", "SCX_EV_ENQ_SKIP_EXITING",
 		   scx_read_event(&events, SCX_EV_ENQ_SKIP_EXITING));
-	bpf_printk("%35s: %llu", "SCX_EV_ENQ_SLICE_DFL",
+	bpf_printk("%35s: %lld", "SCX_EV_ENQ_SLICE_DFL",
 		   scx_read_event(&events, SCX_EV_ENQ_SLICE_DFL));
-	bpf_printk("%35s: %llu", "SCX_EV_BYPASS_DURATION",
+	bpf_printk("%35s: %lld", "SCX_EV_BYPASS_DURATION",
 		   scx_read_event(&events, SCX_EV_BYPASS_DURATION));
-	bpf_printk("%35s: %llu", "SCX_EV_BYPASS_DISPATCH",
+	bpf_printk("%35s: %lld", "SCX_EV_BYPASS_DISPATCH",
 		   scx_read_event(&events, SCX_EV_BYPASS_DISPATCH));
-	bpf_printk("%35s: %llu", "SCX_EV_BYPASS_ACTIVATE",
+	bpf_printk("%35s: %lld", "SCX_EV_BYPASS_ACTIVATE",
 		   scx_read_event(&events, SCX_EV_BYPASS_ACTIVATE));
 
 	bpf_timer_start(timer, ONE_SEC_IN_NS, 0);
-- 
2.48.1


