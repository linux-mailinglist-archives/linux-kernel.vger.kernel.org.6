Return-Path: <linux-kernel+bounces-341995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26FC988966
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953B2284448
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836A61C1752;
	Fri, 27 Sep 2024 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I07gdutL"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D04171E76
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727456351; cv=none; b=CnFFFZ0IuTT7CGRWCtGdBgS8r/Yzn6PEbDLhMyJJOozT7u8xH9KQzTdnSbl8Oc9795xoAeoU645Epu0XAsnwcI/v7ffuyvBR0a+5ZZh/rs4ao9mMa5bmd4hOwBTzKZQVRafBe2g2nVbPqrwdFe3wHNjXzEXNiNm59QnzFgXTfmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727456351; c=relaxed/simple;
	bh=cFM5z9CHzM4rM+ZCbZ/LBcEHVvMiGfxJM0jkKy/FZ9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OlK9a5cLBcAiBzzwMatTG/M0ml01+nHlsq4FkUwCZl3UISRsZANcsT7MgU99qcXuUFrU8hzKpf62ElMJ+sS4H2imecagCzbkabFoShf9Plh6vqgtVJIUa/V/rJejUUv/LrrQfn6C+cnW8z8bB14bWmdE/2Prr8ib5vIItrHPrvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I07gdutL; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727456346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0YkcnSOftb2eRHl7dqAMSX7ORdPWVg65XcR9QpJBL28=;
	b=I07gdutL5J0coBP7kOoB9nVYxJeU0qoxdQDqenT4rOVhhj7+t8JeGYo1BY++qZA8/Jgda1
	neyJ4h0gTCvJuM1Gpr98mmaLqrcBDeg4kPTYCEUM9vGZ1MU43/nDuBmg9ETMbPtEBuph3N
	0zRzQbPZF9TqSokKmnwxR4r6rq/VdrA=
From: Andrea Righi <andrea.righi@linux.dev>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: Provide a per-scheduler unique sequence counter
Date: Fri, 27 Sep 2024 18:59:01 +0200
Message-ID: <20240927165901.40313-1-andrea.righi@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In commit 431844b65f4c ("sched_ext: Provide a sysfs enable_seq counter")
we introduced a global sequence counter that is incremented every time a
BPF scheduler is used.

This is enough for now to determine if a scheduler has ever been
loaded/changed since boot. However, as we will move towards supporting
stacked schedulers, a single global counter might not be sufficient,
since we may also need to track if a specific scheduler, within a
particular hierarchy, is changed or restarted.

To address this, introduce also a per-scheduler sequence counter, which
will allow monitoring of individual scheduler changes from user space.

This counter is available in /sys/kernel/sched_ext/root/seq for now and
it just mirrors the value reported in /sys/kernel/sched_ext/enable_seq.

Signed-off-by: Andrea Righi <andrea.righi@linux.dev>
---
 kernel/sched/ext.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d6f6bf6caecc..62782a31b316 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -662,6 +662,13 @@ struct sched_ext_ops {
 	 */
 	u64 hotplug_seq;
 
+	/*
+	 * enable_seq - unique per-scheduler counter that can be accessed from
+	 * user-space to determine if a scheduler (within a specific hierarchy)
+	 * has been restarted.
+	 */
+	s64 enable_seq;
+
 	/**
 	 * name - BPF scheduler's name
 	 *
@@ -4210,8 +4217,16 @@ static ssize_t scx_attr_ops_show(struct kobject *kobj,
 }
 SCX_ATTR(ops);
 
+static ssize_t scx_attr_seq_show(struct kobject *kobj,
+				 struct kobj_attribute *ka, char *buf)
+{
+	return sysfs_emit(buf, "%lld\n", scx_ops.enable_seq);
+}
+SCX_ATTR(seq);
+
 static struct attribute *scx_sched_attrs[] = {
 	&scx_attr_ops.attr,
+	&scx_attr_seq.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(scx_sched);
@@ -5237,7 +5252,11 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	kobject_uevent(scx_root_kobj, KOBJ_ADD);
 	mutex_unlock(&scx_ops_enable_mutex);
 
-	atomic_long_inc(&scx_enable_seq);
+	/*
+	 * Update scheduler's sequence counter (add 1 to keep it consistent
+	 * with the global scx_enable_seq counter).
+	 */
+	scx_ops.enable_seq = atomic_long_fetch_inc(&scx_enable_seq) + 1;
 
 	return 0;
 
-- 
2.46.2


