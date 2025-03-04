Return-Path: <linux-kernel+bounces-543036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B06EDA4D0CA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA771892E4A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952BA13AA38;
	Tue,  4 Mar 2025 01:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZKQ4u0u8"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368D4273FD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 01:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051699; cv=none; b=Wv3D7NofyBndqr3ICQ61uXmAoOVqpb7d7hbognzz31BTN9StDlZNo7LbrhCV7rLwO8lMsLKGf916Exc8Xy4pMSmh3jxFVaL/n+9dLpG9oGqYl2u3YL5fdfGbzVIo0lSka3ytdR2vc4CfvuRXO3aKPFOy9WdBdgaQpSHX6UbwMEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051699; c=relaxed/simple;
	bh=wVKPu1/TDuVoF2kUDbsKuZcJYjeaeWVZ5Qj5ArOeupc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qy8cP8ju58TLhjywpqmX0+xoFtOvAJUsyfF4uEKESv+CSzqqp5Enyz4GFkZ+rkY7D/a5U5etcuJJ674/FRNEmFruHD5yYSs+OTqgo6tN5KOrmu59lsJTUatHN1npwvlxx9qzI6khKy7LEYhRVGhyRs9XkrQxm81qeppK7pLsml0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ZKQ4u0u8; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8HX/7PYovNGM5QD3NV52qDB+IT7TlNEfS8CekJi9+5Y=; b=ZKQ4u0u8MDolpvqK7ADx2gxpIx
	IsWV0DHLPcm6Xk4jnUI5FS7nP0sRUCIPrYpOzcOrwtnU9G3JPhyPqD74QkfHUxOGWU5J/gnZzYEQt
	Tfbdjs/fnUjVPAH/p+JCmT6CrutqTfq5ae1oFbj5914Y2RSc+x3MoO8j9fc/YEdq8Gs6lsjPFzX/v
	I6nMaFDRb+iZ025iJwljAfhS1wDci0s8EPrA/wQfes9i1jvGAuFJjU8K+7oogGTyiQdrLshl9U9sl
	q21MMpSwvuxwTvk63cLuBYlX3gaDPP26/xjz8R/kDiXNK8yfr2QMrcibNyRGxA5/9acbyyVRTbeCz
	RsDCgZrw==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tpH4k-003VPw-5J; Tue, 04 Mar 2025 02:28:08 +0100
From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com
Cc: kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH v3 2/2] sched_ext: Add trace point to track sched_ext core events
Date: Tue,  4 Mar 2025 10:27:40 +0900
Message-ID: <20250304012740.35473-3-changwoo@igalia.com>
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
	s64 delta;
};

SEC("tracepoint/sched_ext/sched_ext_event")
int rtp_add_event(struct tp_sched_ext_event *ctx)
{
	char event_name[128];
	unsigned short offset = ctx->__data_loc_name & 0xFFFF;
        bpf_probe_read_str((void *)event_name, 128, (char *)ctx + offset);

	bpf_printk("name %s   delta %lld", event_name, ctx->delta);
	return 0;
}
======

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 include/trace/events/sched_ext.h | 19 +++++++++++++++++++
 kernel/sched/ext.c               |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/include/trace/events/sched_ext.h b/include/trace/events/sched_ext.h
index fe19da7315a9..3d04b9819548 100644
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
+		__field(	__s64,		delta		)
+	),
+
+	TP_fast_assign(
+		__assign_str(name);
+		__entry->delta		= delta;
+	),
+
+	TP_printk("name %s delta %lld",
+		  __get_str(name), __entry->delta
+	)
+);
+
 #endif /* _TRACE_SCHED_EXT_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 686629a860f3..debcd1cf2de9 100644
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


