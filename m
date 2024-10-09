Return-Path: <linux-kernel+bounces-356219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 384F6995E0F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 05:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5911F25E1F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 03:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4DD7710C;
	Wed,  9 Oct 2024 03:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="aMWB2wGI"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05202119
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 03:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728444152; cv=none; b=RxAdm/yi6kjwEtP2j9I9qzObIJmdJhEqdzTstCBFlnDwYP7WDYpR7nWY3Et2oKBMecfg/StoeSZNUzzIUHNvRbuQLS7/ho4YMAlhShCUf8aGss65k6W+/tagssUU+dFqHfECCRRIC+LxH4tfQgRJ6Z8fb+mc99/RgDSdLNQnEuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728444152; c=relaxed/simple;
	bh=ne2vG0lzwjw3A2n699Ng8QR7idSNMEE1E94mN4iggdM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uc54K7SNs9E57ZdlKUTsKhrPWZSHcwz+DD8Reyqm4nSdNDRXYcnIQ/cBV1VbrkF6Ke2JBOD1n0YKCLFMpbxvafulBifEl6gblbHzc/99l7MimRx6BnrwB4o34StA9Lbomt7QuMaCl6O2kZ67aMUmMlMNljIlaTPUyKaKQ6IhbVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=aMWB2wGI; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=VrcZs
	cTFVxAO8tOIyWbnY5qEVuRcbcsDJrvOfmHRL/M=; b=aMWB2wGIQ+Ld3fjl54YRf
	HciYjed5VlM5U1oHQ2ztEd2ynMEwECTDEpfUyfk9m7+/+JC8pIlQwdeaFmz6bL2I
	BWIVBHgq2xgFHBlcxRAdw/4oQYOUh4kLlXm1zz2alhYyTB4RKZf8gQSmGlAIu3Xx
	pwHaAQUxIK1B1Q0bQrt81E=
Received: from localhost.localdomain (unknown [111.204.182.99])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD332Eb8wVno6LjAQ--.8709S2;
	Wed, 09 Oct 2024 11:06:04 +0800 (CST)
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
Subject: [PATCH] sched_ext: use correct function name in pick_task_scx() warning message
Date: Wed,  9 Oct 2024 11:06:02 +0800
Message-Id: <20241009030602.91216-1-jameshongleiwang@126.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD332Eb8wVno6LjAQ--.8709S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWxWrWfGw48tFyfAw18Zrb_yoWfurcEka
	43WrZ2kryjvF97Za1UGanayryfKayaqF1rA3ZFkrZ7ArWkAFsrtryvyFykJrykXF92gFnr
	Cr4qgF95CrsYgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbtC7UUUUUU==
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbi2wlzrWcF6v2B0wAAsr

pick_next_task_scx() was turned into pick_task_scx() since
commit 753e2836d139 ("sched_ext: Unify regular and core-sched pick
task paths"). Update the outdated message.

Signed-off-by: Honglei Wang <jameshongleiwang@126.com>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 410a4df8a121..22e18aec4ee1 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2958,7 +2958,7 @@ static struct task_struct *pick_task_scx(struct rq *rq)
 
 		if (unlikely(!p->scx.slice)) {
 			if (!scx_rq_bypassing(rq) && !scx_warned_zero_slice) {
-				printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in pick_next_task_scx()\n",
+				printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in pick_task_scx()\n",
 						p->comm, p->pid);
 				scx_warned_zero_slice = true;
 			}
-- 
2.24.3 (Apple Git-128)


