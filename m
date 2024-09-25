Return-Path: <linux-kernel+bounces-337819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8194E984F55
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24081C22B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDFF1BC59;
	Wed, 25 Sep 2024 00:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzaHijSh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539EF18C1F
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727222791; cv=none; b=Vl1n7yjSM/yXoePsMCDSXkcl2ofEu20Tq1YYFO9T3OhkWuGr+l8EyDUziKx0MG+kELy9D6HBBepyNFbS2Rs/dzuUezm/iOj7cT02riGDogf+YDc9WBgxyCzWkqSXtHLz8Bq1ZtWI6SvKDrR4b/oCE5xMheg6LWMzS57gOtCJrII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727222791; c=relaxed/simple;
	bh=i2pzXtc4C144qi9MagxUe3zu+6AwIz6/m6cnhn2h1Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rq338xuit9yT9CRJ6O6W5xVy6TEgopito7Bgr2MF5PkLlD7VJM4OgXVW5lK3aFagp6H2+9lzjJjjAuSdczHke9P7E5wGmc9eqbxDuBwd+f5lYS+yCwH4wOv4vzwMRhyfAGGCuorI0cLWzxPdyDKGOLLeqY2Pa5V/iUuiVoIHCss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzaHijSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F239C4CED3;
	Wed, 25 Sep 2024 00:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727222791;
	bh=i2pzXtc4C144qi9MagxUe3zu+6AwIz6/m6cnhn2h1Zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kzaHijSh+ji5da/9S8oXX2WXOmRfUMa2Jj9pjpH/a4UgHTcd6gEs3MEkmLTsKEh6n
	 JqBK+YB3eK5/1IsmaglIaATNxycI/MKEJhfJ2WoPUMc88bGgv+ywA/LrWpPFXhB+hR
	 k/lvn8zCETuPEtCNsXHyLZ0+ZszO6URbFYlQL+XRzqvQ6uF30mVo/RyPjhFrzZXASs
	 AC5/UREGkv5WVxX2vg5k8tn8Upn6P+Ey4JQprC/b5+RZWQMoDWRG2OyD0qYqkFuIpJ
	 zcHowrRBP0nbBtNC7dn18dPd2/7evhtiZbWP+dFaieRJLr97gQQQTd9crPMxadg2Hj
	 5vQ/U5D/r/NCA==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/5] sched_ext: Use shorter slice while bypassing
Date: Tue, 24 Sep 2024 14:06:07 -1000
Message-ID: <20240925000622.1972325-6-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240925000622.1972325-1-tj@kernel.org>
References: <20240925000622.1972325-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While bypassing, tasks are scheduled in FIFO order which favors tasks that
hog CPUs. This can slow down e.g. unloading of the BPF scheduler. While
bypassing, guaranteeing timely forward progress is the main goal. There's no
point in giving long slices. Shorten the time slice used while bypassing
from 20ms to 5ms.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 949a3c43000a..d6f6bf6caecc 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -9,6 +9,7 @@
 #define SCX_OP_IDX(op)		(offsetof(struct sched_ext_ops, op) / sizeof(void (*)(void)))
 
 enum scx_consts {
+	SCX_SLICE_BYPASS		= SCX_SLICE_DFL / 4,
 	SCX_DSP_DFL_MAX_BATCH		= 32,
 	SCX_DSP_MAX_LOOPS		= 32,
 	SCX_WATCHDOG_MAX_TIMEOUT	= 30 * HZ,
@@ -1944,6 +1945,7 @@ static bool scx_rq_online(struct rq *rq)
 static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 			    int sticky_cpu)
 {
+	bool bypassing = scx_rq_bypassing(rq);
 	struct task_struct **ddsp_taskp;
 	unsigned long qseq;
 
@@ -1961,7 +1963,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	if (!scx_rq_online(rq))
 		goto local;
 
-	if (scx_rq_bypassing(rq))
+	if (bypassing)
 		goto global;
 
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
@@ -2016,7 +2018,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 
 global:
 	touch_core_sched(rq, p);	/* see the comment in local: */
-	p->scx.slice = SCX_SLICE_DFL;
+	p->scx.slice = bypassing ? SCX_SLICE_BYPASS : SCX_SLICE_DFL;
 	dispatch_enqueue(find_global_dsq(p), p, enq_flags);
 }
 
-- 
2.46.0


