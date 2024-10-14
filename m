Return-Path: <linux-kernel+bounces-363125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C0A99BE34
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 05:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20ADEB225EE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 03:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96263B7A8;
	Mon, 14 Oct 2024 03:32:11 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF50B81741
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 03:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728876731; cv=none; b=uQfsI6+7jkl2nmZYScgo2fnVFO0b4RbsaASU4Gn0w+yet5CRdA57AZX5xHUmgyDyWxL5RFYgG3DxEIpc8iTtMqzNaQUz4n3ZsT4P8JAOCftLX+X3MSy2seaeKl4DlYghiFxKtb6wPGkjGEDMMJGzXKLNYIvNP4AeZTRvhpQuYg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728876731; c=relaxed/simple;
	bh=Qqt6MVqW0mnJrnd0yUo5kogJgXkAXkiWUqc5BqUWam0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m09E6ejeqJCRsbG1N5IxreRVKFbGox8qYwzEHmfX23DpgHFK8Rt1dozPYe5wVsUwoTnSuRMih+H6aorS9h5ubp4HKfVuXNtO6lNsjqGhpPn3e26khCRaUw5M/X8GtpSlCc/xj4rEXV/w81scPlde/Z1cr9d1qBOZaDLAIVVjKzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XRjSz1RPNz4f3jkT
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:31:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2942F1A08DC
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:31:59 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgBnm8emkAxnh_smEA--.18252S2;
	Mon, 14 Oct 2024 11:31:58 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: akpm@linux-foundation.org,
	david@fromorbit.com,
	zhengqi.arch@bytedance.com,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: [PATCH v2] mm: shrinker: avoid memleak in alloc_shrinker_info
Date: Mon, 14 Oct 2024 03:23:36 +0000
Message-Id: <20241014032336.482088-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnm8emkAxnh_smEA--.18252S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF13Cr4rur4Dtr4UGr17Wrg_yoW8Ar13pF
	43GryUGF4rCr15Gr47ta45Xry0qa12ka4xJ393Xry8tw4fW3W5Wr17Ar4UKrWDW3WkAFW7
	tF4DtrWj9345J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

A memleak was found as bellow:

unreferenced object 0xffff8881010d2a80 (size 32):
  comm "mkdir", pid 1559, jiffies 4294932666
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  @...............
  backtrace (crc 2e7ef6fa):
    [<ffffffff81372754>] __kmalloc_node_noprof+0x394/0x470
    [<ffffffff813024ab>] alloc_shrinker_info+0x7b/0x1a0
    [<ffffffff813b526a>] mem_cgroup_css_online+0x11a/0x3b0
    [<ffffffff81198dd9>] online_css+0x29/0xa0
    [<ffffffff811a243d>] cgroup_apply_control_enable+0x20d/0x360
    [<ffffffff811a5728>] cgroup_mkdir+0x168/0x5f0
    [<ffffffff8148543e>] kernfs_iop_mkdir+0x5e/0x90
    [<ffffffff813dbb24>] vfs_mkdir+0x144/0x220
    [<ffffffff813e1c97>] do_mkdirat+0x87/0x130
    [<ffffffff813e1de9>] __x64_sys_mkdir+0x49/0x70
    [<ffffffff81f8c928>] do_syscall_64+0x68/0x140
    [<ffffffff8200012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

In the alloc_shrinker_info function, when shrinker_unit_alloc return
err, the info won't be freed. Just fix it.

Fixes: 307bececcd12 ("mm: shrinker: add a secondary array for shrinker_info::{map, nr_deferred}")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 mm/shrinker.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/shrinker.c b/mm/shrinker.c
index dc5d2a6fcfc4..92270413190d 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -97,6 +97,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
 
 err:
 	mutex_unlock(&shrinker_mutex);
+	kvfree(info);
 	free_shrinker_info(memcg);
 	return -ENOMEM;
 }
-- 
2.34.1


