Return-Path: <linux-kernel+bounces-294036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF600958803
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9963F281813
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B6C190678;
	Tue, 20 Aug 2024 13:34:34 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DFC1AACB
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160873; cv=none; b=YuCpMfWVN8ZlEl8Np4wHa5P1RRFlT1/5wmLPga37rFEePbq6FJgzNNta9RNg9IVkDR56HFW8rJqumu6P86Bqw6YQm+HwaWlQbnf7kLLsp7A7vvA7H4niX4TcK2yibZazDcmLMUMjaR+RHhtNNC7ajSsBxS6+3FyScwvQbGcbpN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160873; c=relaxed/simple;
	bh=O2NOpGQWWYh9Na312uSX64vYWwmMSR2G+nIvSFYk4dM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LpSi1TLog7yAubmzwL6/ZNm0QCCbsmtxFivox2atNVgN1yKymRh3g00X2SGg/Erdt3HLwujtb6hiJ3mWDp+pMSnJfx0mNKgJeVe9nSdEKgfmWOORusavpelK53cvefQ4lqqj/E+9b/tIX/e45BvDmJxgBMSwS1yN+RLyS9EVxr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wp9RM1qfrzyRCS;
	Tue, 20 Aug 2024 21:34:07 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id E0DE41800C4;
	Tue, 20 Aug 2024 21:34:28 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 20 Aug
 2024 21:34:28 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <jiangshanlai@gmail.com>, <matthew.brost@intel.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] workqueue: correct input of __alloc_workqueue
Date: Tue, 20 Aug 2024 13:26:50 +0000
Message-ID: <20240820132650.361160-1-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100013.china.huawei.com (7.221.188.163)

When I boot on qemu, it failed like that:
 sysfs: cannot create duplicate filename '/devices/virtual/workqueue/scsi_tmf_80560'
 CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc1-00003-gb188c57af2b5-dirty #95
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x83/0xa0
  sysfs_warn_dup+0x5b/0x70
  sysfs_create_dir_ns+0xbe/0xd0
  kobject_add_internal+0x9e/0x270
  kobject_add+0x7e/0xf0
  ? get_device_parent+0x108/0x1d0
  device_add+0x113/0x810
  ? __init_waitqueue_head+0x4e/0x70
  workqueue_sysfs_register+0x8d/0x140
  __alloc_workqueue+0x6a0/0x800
  ? local_clock_noinstr+0x41/0xc0
  alloc_workqueue+0x53/0x100
  ? try_to_wake_up+0x25e/0x890
  scsi_host_alloc+0x3b6/0x4b0

This is also reported at [1].
The commit b188c57af2b5 ("workqueue: Split alloc_workqueue into internal
function and lockdep init") split internal __alloc_workqueue into function.
The variable inputs to __alloc_workqueue is incorrect, which leads to args
in __alloc_workqueue being indeterminate.
To fix this issue, change __alloc_workqueue‘s '...' to 'va_list args'.

[1] https://lore.kernel.org/all/202408161132.7c52d91a-oliver.sang@intel.com/

Fixes: b188c57af2b5 ("workqueue: Split alloc_workqueue into internal function and lockdep init")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/workqueue.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bfeeefeee332..58b5d25dbf6f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5623,12 +5623,10 @@ static void wq_adjust_max_active(struct workqueue_struct *wq)
 	} while (activated);
 }
 
-__printf(1, 4)
 static struct workqueue_struct *__alloc_workqueue(const char *fmt,
 						  unsigned int flags,
-						  int max_active, ...)
+						  int max_active, va_list args)
 {
-	va_list args;
 	struct workqueue_struct *wq;
 	size_t wq_size;
 	int name_len;
@@ -5660,9 +5658,7 @@ static struct workqueue_struct *__alloc_workqueue(const char *fmt,
 			goto err_free_wq;
 	}
 
-	va_start(args, max_active);
 	name_len = vsnprintf(wq->name, sizeof(wq->name), fmt, args);
-	va_end(args);
 
 	if (name_len >= WQ_NAME_LEN)
 		pr_warn_once("workqueue: name exceeds WQ_NAME_LEN. Truncating to: %s\n",
@@ -5718,7 +5714,6 @@ static struct workqueue_struct *__alloc_workqueue(const char *fmt,
 		goto err_unlock_destroy;
 
 	apply_wqattrs_unlock();
-
 	if ((wq->flags & WQ_SYSFS) && workqueue_sysfs_register(wq))
 		goto err_destroy;
 
-- 
2.34.1


