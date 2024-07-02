Return-Path: <linux-kernel+bounces-237422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23ED291F0DA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24AF285867
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDBD14D716;
	Tue,  2 Jul 2024 08:15:16 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BA314E2C0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719908115; cv=none; b=hZw6qBLec8pIs/RNyO4pplEio00YPkodzltraEYOLWyug4aOZ9D/sSZzvb+M0hPUxOvMFw9ayCaYsk93oS5LmcbmC1mOPf0bcTRPaKI3AbhxhxJbEW7Bs++B7kPlwvajTV7nYvMZwB5ddGbCuYm+4qL+SFmMahQnz0p3tlXAStM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719908115; c=relaxed/simple;
	bh=uGvmmMdTqqVTJrs9JfhqUXV/tMpa1D+Ei3gMtRm7DsI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H56MyjMg6iWBnO0y+Cp38fPGV3sQNdksLYx9BSqdGvVARj8QfRCh09G3+Kugj84qyQ8adBo+Hu73VcxzY9+adxJsPTLtKSj15Qd6eU0uB9Yjel6MRSDmqvsLh3UVB4/og4+703JQI6kyrCErsp4+4tuzYfljMqC780QYu6T07S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WCwgb2y6Fz4f3kvd
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 16:14:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id D6D4D1A016E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 16:15:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.103.91])
	by APP2 (Coremail) with SMTP id Syh0CgAn3oP8toNmlg7JAw--.42288S4;
	Tue, 02 Jul 2024 16:15:03 +0800 (CST)
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
Subject: [PATCH resend] sched/smt: fix unbalance sched_smt_present dec/inc
Date: Tue,  2 Jul 2024 16:11:28 +0800
Message-Id: <20240702081128.4008011-1-yangyingliang@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgAn3oP8toNmlg7JAw--.42288S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4fXry3uFyUAryDGw1rJFb_yoW8Ar4Upr
	WDWrWrCr1YgF1jyay5Zw48CryYgasxJ39rXayfCF1fuF17u395t34DKryagrWUWryvyry3
	Z3y2ga92yayqqFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
	IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7cTmDUUUU
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
 kernel/sched/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bcf2c4cc0522..5ab6717b57e0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9756,6 +9756,10 @@ int sched_cpu_deactivate(unsigned int cpu)
 	sched_update_numa(cpu, false);
 	ret = cpuset_cpu_inactive(cpu);
 	if (ret) {
+#ifdef CONFIG_SCHED_SMT
+		if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
+			static_branch_inc_cpuslocked(&sched_smt_present);
+#endif
 		balance_push_set(cpu, false);
 		set_cpu_active(cpu, true);
 		sched_update_numa(cpu, true);
-- 
2.25.1


