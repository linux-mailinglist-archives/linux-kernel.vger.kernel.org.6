Return-Path: <linux-kernel+bounces-304635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5A4962306
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81121F2160A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A30C15EFA0;
	Wed, 28 Aug 2024 09:09:30 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A93158543
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724836169; cv=none; b=c+sxqHJySktrn9dVy99OUr99anISfTO22qwDtQ9PVU0dA5yuoNZ7z5LempNfSQIROdC8q8rw4snQM5J6XJXhS7fe4tK/FdOjWdujeRBSxugXxXyP+7g7e6odMGwTG9z8i2b7iR9plFZ1hWEy7HYZgUT3rdQvYiZagGgoBDng6lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724836169; c=relaxed/simple;
	bh=jHlgbSibpspwnvhi2RnNwX8/TS4firroE5HPfq4ttQg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XT4/xNogwM6k/n/UbSCZiwPHWoJli1yc8QVQsSrc2RERPHWftUlSvfTuQ4iU54TOn09qKxH0D5XpXIPB3fuKsgCTP/TVQJwAJhStX453SRO7WS2aDy7YgZ+cp9/ByIfU87260Io5m7gAXLHCOcU4NsRBNPt0/kg/faJYMPCOr2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wtz9v48vwz4f3jMW
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:09:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2B0E71A018D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:09:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.103.91])
	by APP4 (Coremail) with SMTP id gCh0CgAXPoQs6c5mR0jHCw--.40858S4;
	Wed, 28 Aug 2024 17:09:21 +0800 (CST)
From: Yang Yingliang <yangyingliang@huaweicloud.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	Markus.Elfring@web.de,
	yangyingliang@huawei.com,
	liwei391@huawei.com
Subject: [PATCH -next] sched: Simplify sched_set_rq_online()
Date: Wed, 28 Aug 2024 17:03:36 +0800
Message-Id: <20240828090336.905676-1-yangyingliang@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXPoQs6c5mR0jHCw--.40858S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZFyfWr4kJr1rWr15WF48WFg_yoWDuwb_Ga
	1fXFykWr95CrnYvrs8Gr4Yg34Sv348XFWfC3ySkay7AryUKws7JrZ8tFyDCrn8WFs7WFW7
	AFs8WF4vkr1UGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUrPEfUUUUU
X-CM-SenderInfo: 51dqw5xlqjzxhdqjqx5xdzvxpfor3voofrz/

From: Yang Yingliang <yangyingliang@huawei.com>

Use guards to simplify sched_set_rq_online()

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 kernel/sched/core.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a81b5136d4cb..80848f219260 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7999,26 +7999,20 @@ void set_rq_offline(struct rq *rq)
 
 static inline void sched_set_rq_online(struct rq *rq, int cpu)
 {
-	struct rq_flags rf;
-
-	rq_lock_irqsave(rq, &rf);
+	guard(rq_lock_irqsave)(rq);
 	if (rq->rd) {
 		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
 		set_rq_online(rq);
 	}
-	rq_unlock_irqrestore(rq, &rf);
 }
 
 static inline void sched_set_rq_offline(struct rq *rq, int cpu)
 {
-	struct rq_flags rf;
-
-	rq_lock_irqsave(rq, &rf);
+	guard(rq_lock_irqsave)(rq);
 	if (rq->rd) {
 		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
 		set_rq_offline(rq);
 	}
-	rq_unlock_irqrestore(rq, &rf);
 }
 
 /*
-- 
2.33.0


