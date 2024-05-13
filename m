Return-Path: <linux-kernel+bounces-177118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8422D8C3A5C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 05:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43081C20BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 03:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B4B145B1A;
	Mon, 13 May 2024 03:07:16 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7A017550
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 03:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715569636; cv=none; b=M1Vwjfj8fu/9VcweZZeDZfJyAp4WvEGKsfDNZwoJgYDbBs6THuJrWSRa3XLqowRPuRPgz8EYW4D4a5+xCYL0AO27/fuiHUy3h4kIwCYmfz9jdGzwZCOEWx+mC6WpzK6LmjU3h8uE1uwZWvkP3A63l2OkaFS3xG2jY640c0083kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715569636; c=relaxed/simple;
	bh=WIi2mTkxrFyXaEO9TW4GQt+gruKYfGyeIlyjdMs0hxY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cAMqCkOuDUBFmBfGld09guDkuuc8MSJTBvEhkZrOmtVqTGcP3lAAyyWd8/OuR+Qwx9wGM03lzSVSmzQhpwWH0CRx2zQftUzswsdihBBFFPA40m3yMvayMTWtJml/lSaMV87qD7h5TEZzH+17aD++xHufk217JqLkj63ZaO8jzQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Vd4B65DCxzch2H;
	Mon, 13 May 2024 11:05:50 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (unknown [7.193.23.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 8665C180064;
	Mon, 13 May 2024 11:07:01 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 13 May 2024 11:07:00 +0800
From: Wenchao Hao <haowenchao2@huawei.com>
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Aaron
 Tomlin <atomlin@atomlin.com>, <linux-kernel@vger.kernel.org>
CC: Wenchao Hao <haowenchao22@gmail.com>, Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH] workqueue: Fix rescuer task's name truncated
Date: Mon, 13 May 2024 11:06:39 +0800
Message-ID: <20240513030639.3772468-1-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600012.china.huawei.com (7.193.23.74)

Task comm of task is limitted to 16, prefix "kworker/R-" is added for
rescuer worker's task, which cause most task name is truncated as
following:

root   81  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-xprti]
root   82  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-cfg80]
root   85  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-nfsio]
root   86  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-xfsal]
root   87  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-xfs_m]
root   88  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-acpi_]
root   93  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-iscsi]
root   95  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-scsi_]
root   97  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-scsi_]
root   99  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-scsi_]

Fix this issue by split rescuer name to 2 part like other kworker,
the normal part is "kworker/R" which is set to task_struct's comm,
another part is wq->name which is added to kworker's desc. These 2 parts
would be merged in wq_worker_comm().

Fixes: b6a46f7263bd ("workqueue: Rename rescuer kworker")

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

---
 kernel/workqueue.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index d2dbe099286b..07c077a53f93 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5443,7 +5443,7 @@ static int init_rescuer(struct workqueue_struct *wq)
 	}
 
 	rescuer->rescue_wq = wq;
-	rescuer->task = kthread_create(rescuer_thread, rescuer, "kworker/R-%s", wq->name);
+	rescuer->task = kthread_create(rescuer_thread, rescuer, "kworker/R");
 	if (IS_ERR(rescuer->task)) {
 		ret = PTR_ERR(rescuer->task);
 		pr_err("workqueue: Failed to create a rescuer kthread for wq \"%s\": %pe",
@@ -5452,6 +5452,8 @@ static int init_rescuer(struct workqueue_struct *wq)
 		return ret;
 	}
 
+	snprintf(rescuer->desc, sizeof(rescuer->desc), "%s", wq->name);
+
 	wq->rescuer = rescuer;
 	if (wq->flags & WQ_UNBOUND)
 		kthread_bind_mask(rescuer->task, wq_unbound_cpumask);
@@ -6302,6 +6304,8 @@ void wq_worker_comm(char *buf, size_t size, struct task_struct *task)
 						  worker->desc);
 			}
 			raw_spin_unlock_irq(&pool->lock);
+		} else if (worker->desc[0] != '\0') {
+			scnprintf(buf + off, size - off, "-%s", worker->desc);
 		}
 	}
 
-- 
2.32.0


