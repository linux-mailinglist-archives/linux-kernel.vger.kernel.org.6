Return-Path: <linux-kernel+bounces-534115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C3EA462F7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D225F170999
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1541F221713;
	Wed, 26 Feb 2025 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KPekCYgr"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838A421D3DA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580429; cv=none; b=UvWB2jS6eDpkguhy3VZR4XwaH3rTsjtKq2cx5nTe4pxDoycWnX8rTcrHA7QbxXjoopcMghphPqwly2y31fvFyutC3IgCA/pc8S60S2tt9I+kRiDZoMTRTwqHxtGgiAbNcWEGJudveHWUE/nUqx7cZkoa3Dp1IBmmrUQEgmrNSjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580429; c=relaxed/simple;
	bh=5GfH1Pyu7/D7bl8UcG9xGy8Canfq21C9ulv3DT+imuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hrqIsCeSVbP1JuXcOOoz9OTAHDIPBf7ACxibcjgzPH4bQgNzjbRPq3C/tCjKmmXKoqjgwyI7wEkSLYNc89dnlm+ZTJstsIshTxYXPWRRahzHYp8dGQPuY2VM1L2D0Ewr4ZIE+34PLPO5iT8TEh9vdexQU97mRv3WlGvDo7xBoFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KPekCYgr; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lnfc1mtH9wgPI3DQjb4cWSOpLADJxirWr/7Ukn7eijw=; b=KPekCYgrDJJTZAk7RJL4YPwXo3
	gGJ2CSu2/4uedWsv+qkQ1CkPpmQi1mDAXzpPK4oQ4CvI5TSTPa152OHCRPERByQm2nCP64tQUmp9X
	9Ofd/40C9noe1M/S8qUV4BB3HdRpHIh65Z9v172Pt3+uEp0nn+3v+5NQvGFMjkpSBTlVLCEa0VX/l
	Qa/BBPoANNfFOsGdN48tA9PU2HjvFcYNjJ63TxY8PY8x4M7teMTO/pDzrY5Pqy4jCGYOmHX/WJEQT
	k8Vcw+1mCboW71RZSWaFvJCoHFhHp0clY3q0eKDi51+UPxOi2qzFQdZc2n48hPMgTMlON/Vvpwp+F
	gzy+jWRg==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tnITZ-0010Bb-RU; Wed, 26 Feb 2025 15:33:36 +0100
From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com
Cc: kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH] sched_ext: Add trace point to track sched_ext core events
Date: Wed, 26 Feb 2025 23:33:27 +0900
Message-ID: <20250226143327.231685-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tracing support, which may be useful for debugging sched_ext schedulers
that trigger a certain event.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 include/trace/events/sched_ext.h | 21 +++++++++++++++++++++
 kernel/sched/ext.c               |  4 ++++
 2 files changed, 25 insertions(+)

diff --git a/include/trace/events/sched_ext.h b/include/trace/events/sched_ext.h
index fe19da7315a9..88527b9316de 100644
--- a/include/trace/events/sched_ext.h
+++ b/include/trace/events/sched_ext.h
@@ -26,6 +26,27 @@ TRACE_EVENT(sched_ext_dump,
 	)
 );
 
+TRACE_EVENT(sched_ext_add_event,
+	    TP_PROTO(const char *name, int offset, __u64 added),
+	    TP_ARGS(name, offset, added),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(	int,		offset		)
+		__field(	__u64,		added		)
+	),
+
+	TP_fast_assign(
+		__assign_str(name);
+		__entry->offset		= offset;
+		__entry->added		= added;
+	),
+
+	TP_printk("name %s offset %d added %llu",
+		  __get_str(name), __entry->offset, __entry->added
+	)
+);
+
 #endif /* _TRACE_SCHED_EXT_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 986b655911df..825e79863057 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1554,6 +1554,8 @@ static DEFINE_PER_CPU(struct scx_event_stats, event_stats_cpu);
  */
 #define scx_add_event(name, cnt) do {						\
 	this_cpu_add(event_stats_cpu.name, cnt);				\
+	trace_sched_ext_add_event(#name,					\
+				  offsetof(struct scx_event_stats, name), cnt);	\
 } while(0)
 
 /**
@@ -1565,6 +1567,8 @@ static DEFINE_PER_CPU(struct scx_event_stats, event_stats_cpu);
  */
 #define __scx_add_event(name, cnt) do {						\
 	__this_cpu_add(event_stats_cpu.name, cnt);				\
+	trace_sched_ext_add_event(#name,					\
+				  offsetof(struct scx_event_stats, name), cnt);	\
 } while(0)
 
 /**
-- 
2.48.1


