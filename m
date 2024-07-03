Return-Path: <linux-kernel+bounces-238748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9820924F7C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7462428C142
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40F97E59A;
	Wed,  3 Jul 2024 03:19:56 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A9F61FEB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 03:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719976796; cv=none; b=p867pECSz8AfWv8leNrvRWe2rE2jlMW7sG9+u9sCkwFGmeBCT8f+JUvS+9q5x4GAGTaQA/PewiZC/9SNBv9Po6PVh1P+yAXB9Pnzw6Qfo9WRAg1OtboexYDYEic0cgcopPY/oGDTRWsnPT+vCv9cPbXlimJD1o8lHKNT1MGLP8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719976796; c=relaxed/simple;
	bh=RatMWj2BUFUCGlW5BmkZlB2amBhxKVbF+t41AJ4GYE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BgLoqR2mJTzw6XSSJ9sy9VrwomxlRQY02CoMpsnABJ15cZiuPcY7j2lek4I6P69kyymTzpihOfojBeTa6HauTY62XtXw6XLrOVyKx7tkrDOMnJj/rKEMLxkeNsfovWvLoC9OrZpXfZ7LNp2wwlxyjqWFCqjyU5TQ0Ej4iVh8vic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WDQ4Q5T9Bz4f3jcs
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 11:19:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id F21AB1A0185
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 11:19:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.103.91])
	by APP2 (Coremail) with SMTP id Syh0CgBn0YZHw4Rm+T8VBA--.56302S8;
	Wed, 03 Jul 2024 11:19:45 +0800 (CST)
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
	bristot@redhat.com,
	vschneid@redhat.com,
	tglx@linutronix.de,
	yu.c.chen@intel.com,
	tim.c.chen@linux.intel.com,
	yangyingliang@huawei.com,
	liwei391@huawei.com
Subject: [PATCH 4/4] sched/core: fix unbalance set_rq_online/offline() in sched_cpu_deactivate()
Date: Wed,  3 Jul 2024 11:16:10 +0800
Message-Id: <20240703031610.587047-5-yangyingliang@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703031610.587047-1-yangyingliang@huaweicloud.com>
References: <20240703031610.587047-1-yangyingliang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBn0YZHw4Rm+T8VBA--.56302S8
X-Coremail-Antispam: 1UD129KBjvdXoW7GFyfWw43tw1fXFWrZw4fXwb_yoW3Awc_X3
	W5WF1kJr95A3WI9r9xWF4fWryFva4UuF4FkrW7CFy7AFy5K39rtwn8KFyrurn8Grs3WFy2
	vF1vqa1qvw1DCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbSxYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
	0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUoeOJUUUUU
X-CM-SenderInfo: 51dqw5xlqjzxhdqjqx5xdzvxpfor3voofrz/

From: Yang Yingliang <yangyingliang@huawei.com>

If cpuset_cpu_inactive() fails, set_rq_online() need be called to rollback.

Fixes: 120455c514f7 ("sched: Fix hotplug vs CPU bandwidth control")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2e114bce517a..01172d8bfe02 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9781,6 +9781,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 	ret = cpuset_cpu_inactive(cpu);
 	if (ret) {
 		sched_smt_present_inc(cpu);
+		sched_set_rq_online(rq, cpu);
 		balance_push_set(cpu, false);
 		set_cpu_active(cpu, true);
 		sched_update_numa(cpu, true);
-- 
2.25.1


