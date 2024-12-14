Return-Path: <linux-kernel+bounces-445988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFAD9F1E36
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 12:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC334188A77C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 11:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F010818FC83;
	Sat, 14 Dec 2024 11:05:01 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488A97E1
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734174301; cv=none; b=Nv/5j52FotGRna1QaJgsCw3j0scgP0AosLcHFgULTDObylvsWp2GQe22P300wPRyR/CJ8bP0TsDUm5VQXw6kHLx0cM2vOOSnq7ie2UjoMEPBkRgATrJTAEF/AqxBqqMKfG/3+GTBeEnqw+EX9gIL3e1u207D4cOpZH1OwAzdTPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734174301; c=relaxed/simple;
	bh=UiHixJW1c6gEPNYTuuZRGtF3cZWDELUUGrW3KXpK8Ag=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a2BR7ByIMnvxXeLfuaUgk/mobMcIqCzRhxlo8FqBvwfV5jyaLWIhPqZgKXcyC7cylspvLrPR0+7O3qzWvcM+TAFxhcgBPyRD0ftYCRYdhbajF4uyqMZ2vxTzpk6EW3V28g6WEywX+ZMATesOk3tNLMzMUaHMiKEKFCE3HJ9epd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Y9NZn5Cb5z2DhMh;
	Sat, 14 Dec 2024 19:02:25 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D2EF1401DC;
	Sat, 14 Dec 2024 19:04:55 +0800 (CST)
Received: from huawei.com (10.175.112.188) by kwepemk500005.china.huawei.com
 (7.202.194.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 14 Dec
 2024 19:04:54 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <dennis.lamerice@gmail.com>, <vigneshr@ti.com>,
	<marten.lindahl@axis.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<chengzhihao1@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] ubi: Revert "ubi: wl: Close down wear-leveling before nand is suspended"
Date: Sat, 14 Dec 2024 19:01:53 +0800
Message-ID: <20241214110153.684919-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk500005.china.huawei.com (7.202.194.90)

Commit 5580cdae05ae ("ubi: wl: Close down wear-leveling before nand is
suspended") added a reboot notification in UBI layer to shutdown the
wear-leveling subsystem, which imported an UAF problem[1]. Besides that,
the method also brings other potential UAF problems, for example:
       reboot             kworker
 ubi_wl_reboot_notifier
  ubi_wl_close
   ubi_fastmap_close
    kfree(ubi->fm)
                     update_fastmap_work_fn
		      ubi_update_fastmap
		       old_fm = ubi->fm
		       if (old_fm && old_fm->e[i]) // UAF!

Actually, the problem fixed by commit 5580cdae05ae ("ubi: wl: Close down
wear-leveling before nand is suspended") has been solved by commit
8cba323437a4 ("mtd: rawnand: protect access to rawnand devices while in
suspend"), which was discussed in [2]. So we can revert the commit
5580cdae05ae ("ubi: wl: Close down wear-leveling before nand is
suspended") directly.

[1] https://lore.kernel.org/linux-mtd/20241208175211.9406-2-dennis.lamerice@gmail.com/
[2] https://lore.kernel.org/all/9bf76f5d-12a4-46ff-90d4-4a7f0f47c381@axis.com/

Fixes: 5580cdae05ae ("ubi: wl: Close down wear-leveling before nand is suspended")
Reported-by: Dennis Lam <dennis.lamerice@gmail.com>
Closes: https://lore.kernel.org/linux-mtd/20241208175211.9406-2-dennis.lamerice@gmail.com/
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mtd/ubi/ubi.h |  2 --
 drivers/mtd/ubi/wl.c  | 21 ---------------------
 2 files changed, 23 deletions(-)

diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index 26cc53ad34ec..c792b9bcab9b 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -549,7 +549,6 @@ struct ubi_debug_info {
  * @peb_buf: a buffer of PEB size used for different purposes
  * @buf_mutex: protects @peb_buf
  * @ckvol_mutex: serializes static volume checking when opening
- * @wl_reboot_notifier: close all wear-leveling work before reboot
  *
  * @dbg: debugging information for this UBI device
  */
@@ -652,7 +651,6 @@ struct ubi_device {
 	void *peb_buf;
 	struct mutex buf_mutex;
 	struct mutex ckvol_mutex;
-	struct notifier_block wl_reboot_notifier;
 
 	struct ubi_debug_info dbg;
 };
diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index 4f6f339d8fb8..fbd399cf6503 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -89,7 +89,6 @@
 #include <linux/crc32.h>
 #include <linux/freezer.h>
 #include <linux/kthread.h>
-#include <linux/reboot.h>
 #include "ubi.h"
 #include "wl.h"
 
@@ -128,8 +127,6 @@ static int self_check_in_wl_tree(const struct ubi_device *ubi,
 				 struct ubi_wl_entry *e, struct rb_root *root);
 static int self_check_in_pq(const struct ubi_device *ubi,
 			    struct ubi_wl_entry *e);
-static int ubi_wl_reboot_notifier(struct notifier_block *n,
-				  unsigned long state, void *cmd);
 
 /**
  * wl_tree_add - add a wear-leveling entry to a WL RB-tree.
@@ -1953,13 +1950,6 @@ int ubi_wl_init(struct ubi_device *ubi, struct ubi_attach_info *ai)
 	if (!ubi->ro_mode && !ubi->fm_disabled)
 		ubi_ensure_anchor_pebs(ubi);
 #endif
-
-	if (!ubi->wl_reboot_notifier.notifier_call) {
-		ubi->wl_reboot_notifier.notifier_call = ubi_wl_reboot_notifier;
-		ubi->wl_reboot_notifier.priority = 1; /* Higher than MTD */
-		register_reboot_notifier(&ubi->wl_reboot_notifier);
-	}
-
 	return 0;
 
 out_free:
@@ -2005,17 +1995,6 @@ void ubi_wl_close(struct ubi_device *ubi)
 	kfree(ubi->lookuptbl);
 }
 
-static int ubi_wl_reboot_notifier(struct notifier_block *n,
-				  unsigned long state, void *cmd)
-{
-	struct ubi_device *ubi;
-
-	ubi = container_of(n, struct ubi_device, wl_reboot_notifier);
-	ubi_wl_close(ubi);
-
-	return NOTIFY_DONE;
-}
-
 /**
  * self_check_ec - make sure that the erase counter of a PEB is correct.
  * @ubi: UBI device description object
-- 
2.46.1


