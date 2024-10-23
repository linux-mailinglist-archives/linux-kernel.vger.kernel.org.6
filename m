Return-Path: <linux-kernel+bounces-377774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 286A49AC6A0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80E7283E99
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF5B15B135;
	Wed, 23 Oct 2024 09:31:42 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127CE7482
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675902; cv=none; b=s3Im+PqwyDFN2yJ9Qwp1OU1mrhO/cvE+EwAerXP6TssVV9itVfkxC3KJ6GcN8ymr0hGAb9724EI0CN1bT+4RPsq5WnoR+zq+p634yKnKTattgfQZr5GaEqTu8XPmRqSRcze2kREgcVWxeA9Ua1TdtxeEso2ytjiCPlKDHcYSrSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675902; c=relaxed/simple;
	bh=oD/hMCulTaUkR1jpm9qbwZ12tPyIL7Lwrg3UZcw9K7g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TG7r9cxsx4DapOcl2vJ7fR0aPeap5jujww5ayKlFjyHLXnT++zN7FCJZpdDDEzN6IgG49nVQY1+KUUTb06O0aOnxv70YJh1I+XA4X9pBzKzKZ2teDshsBeNVSAVM9+jeLJi55QKgWvOvdWoon8VOrggXY3tPj8VgJdvXF+BpmU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XYP0N19kwz1j9mW;
	Wed, 23 Oct 2024 17:30:12 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id 17D4F180019;
	Wed, 23 Oct 2024 17:31:35 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemg100017.china.huawei.com (7.202.181.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Oct 2024 17:31:34 +0800
From: Wupeng Ma <mawupeng1@huawei.com>
To: <akpm@linux-foundation.org>, <tim.c.chen@linux.intel.com>
CC: <jiebin.sun@intel.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipc: fix memleak if msg_init_ns failed in create_ipc_ns
Date: Wed, 23 Oct 2024 17:31:29 +0800
Message-ID: <20241023093129.3074301-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg100017.china.huawei.com (7.202.181.58)

From: Ma Wupeng <mawupeng1@huawei.com>

Percpu memory allocation may failed during create_ipc_ns however this
fail is not handled properly since ipc sysctls and mq sysctls is not
released properly. Fix this by release these two resource when failure.

Here is the kmemleak stack when percpu failed:

unreferenced object 0xffff88819de2a600 (size 512):
  comm "shmem_2nstest", pid 120711, jiffies 4300542254
  hex dump (first 32 bytes):
    60 aa 9d 84 ff ff ff ff fc 18 48 b2 84 88 ff ff  `.........H.....
    04 00 00 00 a4 01 00 00 20 e4 56 81 ff ff ff ff  ........ .V.....
  backtrace (crc be7cba35):
    [<ffffffff81b43f83>] __kmalloc_node_track_caller_noprof+0x333/0x420
    [<ffffffff81a52e56>] kmemdup_noprof+0x26/0x50
    [<ffffffff821b2f37>] setup_mq_sysctls+0x57/0x1d0
    [<ffffffff821b29cc>] copy_ipcs+0x29c/0x3b0
    [<ffffffff815d6a10>] create_new_namespaces+0x1d0/0x920
    [<ffffffff815d7449>] copy_namespaces+0x2e9/0x3e0
    [<ffffffff815458f3>] copy_process+0x29f3/0x7ff0
    [<ffffffff8154b080>] kernel_clone+0xc0/0x650
    [<ffffffff8154b6b1>] __do_sys_clone+0xa1/0xe0
    [<ffffffff843df8ff>] do_syscall_64+0xbf/0x1c0
    [<ffffffff846000b0>] entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: 72d1e611082e ("ipc/msg: mitigate the lock contention with percpu counter")
Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 ipc/namespace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ipc/namespace.c b/ipc/namespace.c
index 6ecc30effd3e..4df91ceeeafe 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -83,13 +83,15 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 
 	err = msg_init_ns(ns);
 	if (err)
-		goto fail_put;
+		goto fail_ipc;
 
 	sem_init_ns(ns);
 	shm_init_ns(ns);
 
 	return ns;
 
+fail_ipc:
+	retire_ipc_sysctls(ns);
 fail_mq:
 	retire_mq_sysctls(ns);
 
-- 
2.25.1


