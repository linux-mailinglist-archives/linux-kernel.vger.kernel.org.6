Return-Path: <linux-kernel+bounces-238746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FF1924F7A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18CD287CFD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB06D4C634;
	Wed,  3 Jul 2024 03:19:51 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293E838FA3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 03:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719976791; cv=none; b=PqSoRr7RA3Itv7TsatxKxx1m1YuBooYq0nugWvBMTCHmr8BaEJcdYYSKl5aSSkdQq5iKSXwinjwqwa75fRT6W+SwzKq6+HrdWepz1RwQi1B79WEQp5Y3EdUGTu07Qx+TVul2W0Ffx4vTSXo9DVu19vxjoCGJnrRrgYZhsugKvLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719976791; c=relaxed/simple;
	bh=JzeJfw8k03ytQxZdnpeoaQlEmZ1W0Ht4tjS6QsNRBvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jpQqnPVkBzWz/8sL8Cb7B07/Eg+A8nPwjGC+TBo1R710nTbVQ/aUsSbM2W7jrhLKiQX7UDbI02bwUPyfFtXeN9vY/kE7wCP/PmOaoFoIMdqiUDa6HRHeYu+5AFhHBw63gSYLwpPN8TJwyBdSyELuOv4+W1zoEN4+PX86ZDyT3IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WDQ4T2vt4z4f3jjn
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 11:19:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BC5E41A0181
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 11:19:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.103.91])
	by APP2 (Coremail) with SMTP id Syh0CgBn0YZHw4Rm+T8VBA--.56302S6;
	Wed, 03 Jul 2024 11:19:44 +0800 (CST)
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
Subject: [PATCH 2/4] sched/smt: fix unbalance sched_smt_present dec/inc
Date: Wed,  3 Jul 2024 11:16:08 +0800
Message-Id: <20240703031610.587047-3-yangyingliang@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgBn0YZHw4Rm+T8VBA--.56302S6
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4fXry3uFyUAryDGw1rJFb_yoW8Wr45pr
	ZrKr4rCr1YgF12y3y5Zw48CrW5XasxJrW7X3y8CF1fCF1j9ws5t3srK3yagr4UWryvyry3
	A3y2g3s2ka4qqFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOE_MDUUUU
X-CM-SenderInfo: 51dqw5xlqjzxhdqjqx5xdzvxpfor3voofrz/

From: Yang Yingliang <yangyingliang@huawei.com>

I got the following warn report while doing stress test:

jump label: negative count!
WARNING: CPU: 3 PID: 38 at kernel/jump_label.c:263 static_key_slow_try_dec+0x9d/0xb0
Call Trace:
 <TASK>
 __static_key_slow_dec_cpuslocked+0x16/0x70
 sched_cpu_deactivate+0x26e/0x2a0
 cpuhp_invoke_callback+0x3ad/0x10d0
 cpuhp_thread_fun+0x3f5/0x680
 smpboot_thread_fn+0x56d/0x8d0
 kthread+0x309/0x400
 ret_from_fork+0x41/0x70
 ret_from_fork_asm+0x1b/0x30
 </TASK>

Because when cpuset_cpu_inactive() fails in sched_cpu_deactivate(),
the cpu offline failed, but sched_smt_present is decremented before
calling sched_cpu_deactivate(), it leads to unbalanced dec/inc, so
fix it by incrementing sched_smt_present in the error path.

Fixes: c5511d03ec09 ("sched/smt: Make sched_smt_present track topology")
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 880c4c03ef8a..5cff01046685 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9768,6 +9768,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 	sched_update_numa(cpu, false);
 	ret = cpuset_cpu_inactive(cpu);
 	if (ret) {
+		sched_smt_present_inc(cpu);
 		balance_push_set(cpu, false);
 		set_cpu_active(cpu, true);
 		sched_update_numa(cpu, true);
-- 
2.25.1


