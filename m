Return-Path: <linux-kernel+bounces-404176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788F99C4049
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF412830EB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE551A2541;
	Mon, 11 Nov 2024 14:03:45 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0790019F116
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731333825; cv=none; b=Im6JiSodBjtUKcZ2sfudQ5xe5xvke7AtNKACkKHBSEXeX5gDUtPZTnnPn+mVN3aXZ/CKFW2KNhDWbPBmXZ5ZG86Iamc0dMo8PforObs37zNOn9ZYDLvFRp8q0Wi5wX38urN/+U4LZrJv4QfPBkCN4msdwzQMakf3hc610TFbyaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731333825; c=relaxed/simple;
	bh=L6QNkAQguYbBczWLlOEsvUgTc6ZH8pr0HFmtJJIUWn0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bGBI2agWAfnYcz2VcqVhNAlwSf16c9iC/IHlHTGUv1Hmzn95asyTBdPcqZ55NKVzZsy3nzsDUZZ/iDXZxcCt3tLm9ku6HXjTPhYLmKWNioYfhITZzMMM9wwcNdE4atMuL2hplSur1sQNsChvNAWBOBQJq+hUreG1QgfPDnJLl8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XnB8j6lQvz4f3jsk
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 22:03:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 19F901A018C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 22:03:36 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgBHqOStDjJnXGDsBQ--.26141S2;
	Mon, 11 Nov 2024 22:03:35 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: [PATCH] freezer, sched: report the frozen task stat as 'D'
Date: Mon, 11 Nov 2024 13:54:31 +0000
Message-Id: <20241111135431.1813729-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHqOStDjJnXGDsBQ--.26141S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFy7Zw4UKFy3Zry8ur4rKrg_yoW8Xw1kpF
	Zxur47Ga4IkFyUCr9rA3W7Wa48WanFyr12kFZ0gF47GFy8XF1Y9rn2vry5tr45CrWFyFWU
	Ars8Kr97C39rA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUF1v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Before the commit f5d39b020809 ("freezer,sched: Rewrite core freezer
logic"), the frozen task stat was reported as 'D' in cgroup v1.
However, after rewriting core freezer logic, the frozen task stat is
reported as 'R'. This is confusing, especially when a task with stat of
'S' is frozen.

This can be reproduced as bellow step:
cd /sys/fs/cgroup/freezer/
mkdir test
sleep 1000 &
[1] 739         // task whose stat is 'S'
echo 739 > test/cgroup.procs
echo FROZEN > test/freezer.state
ps -aux | grep 739
root     739  0.1  0.0   8376  1812 pts/0    R    10:56   0:00 sleep 1000

As shown above, a task whose stat is 'S' was changed to 'R' when it was
frozen. To solve this issue, simply maintain the same reported state as
before the rewrite.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 include/linux/sched.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f0f23efdb245..878acce2f8d6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1630,8 +1630,9 @@ static inline unsigned int __task_state_index(unsigned int tsk_state,
 	 * We're lying here, but rather than expose a completely new task state
 	 * to userspace, we can make this appear as if the task has gone through
 	 * a regular rt_mutex_lock() call.
+	 * Report the frozen task uninterruptible.
 	 */
-	if (tsk_state & TASK_RTLOCK_WAIT)
+	if (tsk_state & TASK_RTLOCK_WAIT || tsk_state & TASK_FROZEN)
 		state = TASK_UNINTERRUPTIBLE;
 
 	return fls(state);
-- 
2.34.1


