Return-Path: <linux-kernel+bounces-251296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DE5930317
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 03:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6D41C218E0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2406E125B9;
	Sat, 13 Jul 2024 01:43:55 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E85FC0B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 01:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720835034; cv=none; b=CFkl6HcL6ynPHAeR0avWSnzJ1harpM+Tl5SWlfGXzHu3hh5jTcBYaMiLTPDwvTXngoIjGJMl5OCAqhPyT/SGx/7iIM3KJr7duBYcBqDmugeId7YbiTfjeURzXefMf9hKxqbWsCG/B5vApMYSX1d9/iQjEzp7RtYRMFoEjzQbuKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720835034; c=relaxed/simple;
	bh=ISwiJPVCxvbdYzs4oGfD2daRWqN7S7C3RXi/AzXw9OM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lbyt4R2WsjeZkGvEDp3DmP8TpiW+6hMp7N88HoVMpc2fShn8VWiXhd0oJURyIUqrqFmqErdzyN7ToNyZUyJ01cA22qkLGp3ZI45IzWFR4pbHGP21znnKgXeOGKR/+LFHilTB1BY3D4GQjVZFDH72Q+GBu21kDhMZ+PGFgS4GZws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WLWRF1vLyzdh41;
	Sat, 13 Jul 2024 09:42:01 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id E7236180087;
	Sat, 13 Jul 2024 09:43:42 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 13 Jul
 2024 09:43:42 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <bhe@redhat.com>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<austindh.kim@gmail.com>, <rmk+kernel@armlinux.org.uk>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2] crash: Fix x86_32 and arm32 memory reserve bug
Date: Sat, 13 Jul 2024 09:48:08 +0800
Message-ID: <20240713014808.1689915-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi100008.china.huawei.com (7.221.188.57)

On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=4G" is ok
as below:
	crashkernel reserved: 0x0000000020000000 - 0x0000000120000000 (4096 MB)

And on Qemu vexpress-a9 with 1GB memory, the crash kernel "crashkernel=4G"
is also ok as below:
	Reserving 4096MB of memory at 2432MB for crashkernel (System RAM: 1024MB)

The cause is that the crash_size is parsed and printed with "unsigned long
long" data type which is 8 bytes but allocated used with "phys_addr_t"
which is 4 bytes in memblock_phys_alloc_range().

Fix it by limiting the "crash_size" to phys_addr_t and bypass the invalid
input size.

After this patch, it fail as expected and no above confusing reserve
success info.

Fixes: 9d17f3372306 ("ARM: 9190/1: kdump: add invalid input check for 'crashkernel=0'")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Also fix for x86_32.
- Update the fix method.
- Peel off the other two patches.
- Update the commit message.
---
 kernel/crash_reserve.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5073ae205f79..5c2148d89da6 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -314,7 +314,7 @@ int __init parse_crashkernel(char *cmdline,
 	if (high && ret == -ENOENT) {
 		ret = __parse_crashkernel(cmdline, 0, crash_size,
 				crash_base, suffix_tbl[SUFFIX_HIGH]);
-		if (ret || !*crash_size)
+		if (ret || !(phys_addr_t)*crash_size)
 			return -EINVAL;
 
 		/*
@@ -333,7 +333,7 @@ int __init parse_crashkernel(char *cmdline,
 		*high = true;
 	}
 #endif
-	if (!*crash_size)
+	if (!(phys_addr_t)*crash_size)
 		ret = -EINVAL;
 
 	return ret;
-- 
2.34.1


