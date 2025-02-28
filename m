Return-Path: <linux-kernel+bounces-538068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C021A4943F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34D3E7A2EC1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C0B1BE23E;
	Fri, 28 Feb 2025 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UKq6HgbR"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D261E255E22
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740733217; cv=none; b=SysON0NzCaVTf/pPZUVRZ0CeHJgsbfYuMvKGjj4IHn7kZCLZiAMcf4DngOSiiSpYvAWcrOiB7Az8kC+F2a0Zlj4Hk6dQ6DPe9nkO5mVhJzilcqAYUCdVOHD86djWSgt0B3BNuM5XDtXXSFMPh1ZOKW9QpU3uYDhhH8xOLhAQIo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740733217; c=relaxed/simple;
	bh=mzc25wq3Csf/EZLN6ZLDiln49xQ+5s7zroBqJBuLEfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RlNcxCo7rjYAHXnCDEgAUb7/O6RpVkGyTtjJXJXxHKuWerzQ+cQh0eo7oOR9uwtdBJX9fucYz1BLBhPEfAh+oFEblBW4J2xHvaBjwdAJcd87Y9rQD0KN33+QGvvMOrvWklellNAniOkCBGIdj8n5woudo4Z86di4KyyadPQfFNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UKq6HgbR; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=SOiQ8tn4AKnAdhAjLocySKLR0p2tLjQ2yrXrzUz5VHw=; b=UKq6HgbRovZZCQLRMyxtLC0X0r
	hwA1Ak+BkM6OcbaSZkpmbbz+onRwtF1hu3t3qbW2TxZMiX9fCy6uI5ajYY3U5pPoThXJhVQyHkTIc
	gX0S4hwoXWw0paRsRiJS43Qnnb4gDCPnolLAA9ODpCBNB70xidCJlezZDDEVxAn260iZENfu6eYFe
	F+2zpDnA1eF2O74IvGYp+RqXsM0z7rPZbP01S4/EuUazqnkeE9tUuKzEujFSrAMcG0ahB06UYgvID
	tmEkSX/UZtGjbLwbM90KC+V+hxPISUFrCzj2dRn8efX/nV4dI5xr0oDP89DD4iTxD+49X6DP5uOEy
	yNCs9eUg==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tnwDn-001xDd-OY; Fri, 28 Feb 2025 09:59:58 +0100
From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com
Cc: kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH v2] sched_ext: Add trace point to track sched_ext core events
Date: Fri, 28 Feb 2025 17:59:44 +0900
Message-ID: <20250228085944.19451-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tracing support to track sched_ext core events
(/sched_ext/sched_ext_event). This may be useful for debugging sched_ext
schedulers that trigger a particular event.

The trace point can be used as other trace points, so it can be used in,
for example, `perf trace` and BPF programs, as follows:

======
$> sudo perf trace -e sched_ext:sched_ext_event --filter 'name == "SCX_EV_ENQ_SLICE_DFL"'
======

======
struct tp_sched_ext_event {
	struct trace_entry ent;
	u32 __data_loc_name;
	u64 delta;
};

SEC("tracepoint/sched_ext/sched_ext_event")
int rtp_add_event(struct tp_sched_ext_event *ctx)
{
	char event_name[128];
	unsigned short offset = ctx->__data_loc_name & 0xFFFF;
        bpf_probe_read_str((void *)event_name, 128, (char *)ctx + offset);

	bpf_printk("name %s   delta %llu", event_name, ctx->delta);
	return 0;
}
======

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---

ChangeLog v1 -> v2:
 - Rename @added field to @delta for clarity.
 - Rename sched_ext_add_event to sched_ext_event.
 - Drop the @offset field to avoid the potential misuse of non-portable numbers.

 include/trace/events/sched_ext.h | 19 +++++++++++++++++++
 kernel/sched/ext.c               |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/include/trace/events/sched_ext.h b/include/trace/events/sched_ext.h
index fe19da7315a9..b73499981682 100644
--- a/include/trace/events/sched_ext.h
+++ b/include/trace/events/sched_ext.h
@@ -26,6 +26,25 @@ TRACE_EVENT(sched_ext_dump,
 	)
 );
 
+TRACE_EVENT(sched_ext_event,
+	    TP_PROTO(const char *name, __u64 delta),
+	    TP_ARGS(name, delta),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(	__u64,		delta		)
+	),
+
+	TP_fast_assign(
+		__assign_str(name);
+		__entry->delta		= delta;
+	),
+
+	TP_printk("name %s delta %llu",
+		  __get_str(name), __entry->delta
+	)
+);
+
 #endif /* _TRACE_SCHED_EXT_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 986b655911df..53729c584b63 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1554,6 +1554,7 @@ static DEFINE_PER_CPU(struct scx_event_stats, event_stats_cpu);
  */
 #define scx_add_event(name, cnt) do {						\
 	this_cpu_add(event_stats_cpu.name, cnt);				\
+	trace_sched_ext_event(#name, cnt);					\
 } while(0)
 
 /**
@@ -1565,6 +1566,7 @@ static DEFINE_PER_CPU(struct scx_event_stats, event_stats_cpu);
  */
 #define __scx_add_event(name, cnt) do {						\
 	__this_cpu_add(event_stats_cpu.name, cnt);				\
+	trace_sched_ext_event(#name, cnt);					\
 } while(0)
 
 /**
-- 
2.48.1


