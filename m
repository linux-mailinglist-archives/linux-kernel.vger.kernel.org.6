Return-Path: <linux-kernel+bounces-514745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2717EA35B00
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BA2C7A4EE6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE7C25A627;
	Fri, 14 Feb 2025 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="o6xcTAiq"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43C824BBF6
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739527086; cv=none; b=uHgpToRxdD9h5dLnlIDeXg9RNkUVjy9L/wnGlWPkCRq3E4ql/GFiUW6ZUk8SrdiGwzFvapwvDq5+6rZk77XblZciTkxEIHPpoA+K9Pt4w7TkeBDppG4zxaK6ZlMUkdN7UOV9jb0tYXL6MspIQFlL4jN2ZvAFGuX68h3AuW11RBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739527086; c=relaxed/simple;
	bh=47WKjJcwQWvsK1nkHibsYhis9CdASrT+Q8dQk4j5ZuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RldKQ2iqTmqP7/IyHuc3lVK9qhaaDVX9XvnedMaHHQAySeDWw31htoIrmHd+p6nv0SRL2uPJV7r5qRU+HumZyw3rEP7JltkTliYozFmA5sS8IiTrbGIuihDHVs2UyykEMKSBHvAuHrzEhASSS0mL0/+Y+a8SEc2jvVyGXR8hDbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=o6xcTAiq; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=YsVVftDpo1mgprsCaOUgA8Avd4mgoql5Qv3tMRR7rsM=; b=o6xcTAiqHiV2pPP/dgrmWTXin5
	emYU8O2LedoV9llc3HVQt3seMZ34n9KdYN2ld1wRi2OQqUzx4+YbJhZ6qxVn2x+Vj5jorEqSaUbvq
	yGw0phEnSveIAJrltzRj6u4EoGi1F6SlHzfNk2FoJ7B3SrDQ7de+qoaxV4PrnRF1ox4RrbgiLsDyv
	2yPs/Vrd+k2PUynumDJjrhSZbZXeXb/NNVnV9brPHePnueAJtgGDX70I6CRY/1yTSHVt+FSzLGPzm
	CZ3iZdydMSDC/LuwyzVMH1PtgkX43+2/tXFZX1o8S/3t9l0mkYciOWrRc8a9lioUWyWdpPjVkDKT5
	lrVIfQfw==;
Received: from [58.29.143.236] (helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tisS8-00HNmX-9y; Fri, 14 Feb 2025 10:57:50 +0100
From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com
Cc: kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH v2] sched_ext: Provides a sysfs 'events' to expose core event counters
Date: Fri, 14 Feb 2025 18:57:36 +0900
Message-ID: <20250214095736.76693-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a sysfs entry at /sys/kernel/sched_ext/root/events to expose core
event counters through the files system interface. Each line of the file
shows the event name and its counter value.

In addition, the format of scx_dump_event() is adjusted as the event name
gets longer.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---

ChangeLog v1 -> v2:
  - Change the format of the output to the simpler form, "%s %llu\n".

  - Move the 'events' under the root/ subdir following the lifecycle of
    an scx scheduler.

 kernel/sched/ext.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0c5120c6381c..4f88b782886e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1576,7 +1576,7 @@ static DEFINE_PER_CPU(struct scx_event_stats, event_stats_cpu);
  * @kind: a kind of event to dump
  */
 #define scx_dump_event(s, events, kind) do {					\
-	dump_line(&(s), "%30s: %16llu", #kind, (events)->kind);			\
+	dump_line(&(s), "%40s: %16llu", #kind, (events)->kind);			\
 } while (0)
 
 
@@ -4383,8 +4383,33 @@ static ssize_t scx_attr_ops_show(struct kobject *kobj,
 }
 SCX_ATTR(ops);
 
+#define scx_attr_event_show(buf, at, events, kind) ({				\
+	sysfs_emit_at(buf, at, "%s %llu\n", #kind, (events)->kind);		\
+})
+
+static ssize_t scx_attr_events_show(struct kobject *kobj,
+				    struct kobj_attribute *ka, char *buf)
+{
+	struct scx_event_stats events;
+	int at = 0;
+
+	scx_bpf_events(&events, sizeof(events));
+	at += scx_attr_event_show(buf, at, &events, SCX_EV_SELECT_CPU_FALLBACK);
+	at += scx_attr_event_show(buf, at, &events, SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE);
+	at += scx_attr_event_show(buf, at, &events, SCX_EV_DISPATCH_KEEP_LAST);
+	at += scx_attr_event_show(buf, at, &events, SCX_EV_ENQ_SKIP_EXITING);
+	at += scx_attr_event_show(buf, at, &events, SCX_EV_ENQ_SKIP_MIGRATION_DISABLED);
+	at += scx_attr_event_show(buf, at, &events, SCX_EV_ENQ_SLICE_DFL);
+	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_DURATION);
+	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_DISPATCH);
+	at += scx_attr_event_show(buf, at, &events, SCX_EV_BYPASS_ACTIVATE);
+	return at;
+}
+SCX_ATTR(events);
+
 static struct attribute *scx_sched_attrs[] = {
 	&scx_attr_ops.attr,
+	&scx_attr_events.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(scx_sched);
-- 
2.48.1


