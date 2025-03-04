Return-Path: <linux-kernel+bounces-543911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76638A4DB71
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCC43B425E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC611FF7B0;
	Tue,  4 Mar 2025 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cRxGjEbY"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552D11FF1CE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085370; cv=none; b=iqQW42PNOu3lWt0fC42qygYaTNVBhHl7MW24GivBDepXpe8cmx1uhLGcLeRCPvk9Syx6V8VymvfyeMsjwO075rTqFKxELYFjz2CTlCQVO2wUzxM/47dsyQF3R+9s8O0ls+fqBXUhL4qQOZYCQeLivfGrImV8WFSt4EbZWNw1Rec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085370; c=relaxed/simple;
	bh=l9iOVVNLgYNfXAh4nO6CDsbNDWmbRtmzDTNYnXr2cRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lffBBVaPw0AOXoiqD3JXJpD9z87rzeKloZWkY/2HchMoi2ScyqcQcjYG0BBnl9SAIveBdgPUxIk+nY3OilPmHsjphKD4Ycz/VyWtMmSCbgq/TuVc8QwilvKqJCeKgpkxmn7yG3WT+5exoxBScgSU5n/sHVD53hKrYzBMP//DDyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cRxGjEbY; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VLzLYngtKKspnDi/wOo+/r3FDbyAZpJFWovD3xrE0yY=; b=cRxGjEbYPkBRHUnlJf9CfpNVJj
	z+kkvPCSR0yL4UzkOrHqift05faaUBg6CVHRJf37h3aPYsT2X3bwTyl/8YcmJXHCk83OOwSCHf2RR
	uAxEhdz9htk+aRY9uMGjkJgZ/suGUglJiGtYGE0TbGCPj8U94T/+M0H0UuitY3ICA1DNDr5WAyNHJ
	a+Iz9TiISGae62JuueF7VoLopuGmfBaFpPzjxyssDEs5NeojtFzb1RdTSWbA/ncx5r5LWdOy5zstL
	LTaOBAlDinAKMmXcm7O1wjrs14RszqdCATc5zHNFICZkk7FVoqfYExcaEqFzyRDMorLR1fr7g5exb
	ZhPu7PSA==;
Received: from [175.114.83.198] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tpPpr-003fel-HX; Tue, 04 Mar 2025 11:49:22 +0100
From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com
Cc: kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH v4 1/2] sched_ext: Change the event type from u64 to s64
Date: Tue,  4 Mar 2025 19:48:59 +0900
Message-ID: <20250304104900.154618-2-changwoo@igalia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304104900.154618-1-changwoo@igalia.com>
References: <20250304104900.154618-1-changwoo@igalia.com>
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


