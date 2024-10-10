Return-Path: <linux-kernel+bounces-358201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370C9997B59
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFA36B229C4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55F2191F81;
	Thu, 10 Oct 2024 03:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ffOGxovQ"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2984229CEC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 03:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728531410; cv=none; b=XFtKsfZeD8AOLauMu48Ig/gcyAYH+9rLL0W7apMH91HHUnFRehVLrhdHLCPFYcaTQxNoT0nrvDiaTIyr24o3RvQVdz1wlsCkYX5wIaNmJAG5Bvor1+sQEBsnCwfOKje7vN4E7Pi/rqshwR0hNybQkH1IVkyiKkV9ABoqQS8jiZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728531410; c=relaxed/simple;
	bh=h8L1VIWsVrx8AgqznXh+8HVtniozkY43IsZ7/XXIZ4s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uSUnEB0zm49OZugL9F0YLhwZi4LgK/2cbaKfya6UD37DbSrvnsaf5B5HgJ8Fx0YuxeWFS9vG908E2VRwpjV/GykHYOW/aeZO0es/yz3PU9kfUsLCzdVDW2RABW4NxU+JD3GbPuEa8eC/bL60mUllmN3GzsIv4+UAEQexKsRNUUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ffOGxovQ; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vatIf
	tOds7mGJMXYrucjXN8DiSWuey6OgLXf5FxxoRg=; b=ffOGxovQnYNxjHvGk63Kl
	js57FX/keqhqf7hYmNZgOHw3YLfe7vzEtz5RyGdF8JdTZf5Gsv9PvHYvOvIq0lWP
	6ipwCCpvYN7nScPyJZw/0qOSsEVTh4sTqjtI7RG4syf8QjH6F4Vezz0Tc9BTosZ/
	dnIgmR5K3ymntXfYUXmZQg=
Received: from localhost.localdomain (unknown [111.204.182.99])
	by gzsmtp3 (Coremail) with SMTP id pykvCgAnRssvSwdn3THdAw--.58443S2;
	Thu, 10 Oct 2024 11:34:08 +0800 (CST)
From: Honglei Wang <jameshongleiwang@126.com>
To: tj@kernel.org,
	void@manifault.com
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched_ext: use correct function name in pick_task_scx() warning message
Date: Thu, 10 Oct 2024 11:34:05 +0800
Message-Id: <20241010033405.72313-1-jameshongleiwang@126.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:pykvCgAnRssvSwdn3THdAw--.58443S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWxWrWfGw48tFyfAw18Zrb_yoWDKrgEka
	4agrs2kFyq9F1kua1UGan7t3s5Kay2qF1fAw4DKrZ7ArZYkFsxKrykJF98JrWkWF97KFnx
	urs0kFykCrnIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbtC7UUUUUU==
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbiJBl0rWcHQ6B8TwAAsU

pick_next_task_scx() was turned into pick_task_scx() since
commit 753e2836d139 ("sched_ext: Unify regular and core-sched pick
task paths"). Update the outdated message.

Signed-off-by: Honglei Wang <jameshongleiwang@126.com>
---
Changes since v1:
- use __func__ to address the function name base on David's suggestion

 kernel/sched/ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 410a4df8a121..c2596e7581fb 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2958,8 +2958,8 @@ static struct task_struct *pick_task_scx(struct rq *rq)
 
 		if (unlikely(!p->scx.slice)) {
 			if (!scx_rq_bypassing(rq) && !scx_warned_zero_slice) {
-				printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in pick_next_task_scx()\n",
-						p->comm, p->pid);
+				printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in %s()\n",
+						p->comm, p->pid, __func__);
 				scx_warned_zero_slice = true;
 			}
 			p->scx.slice = SCX_SLICE_DFL;
-- 
2.24.3 (Apple Git-128)


