Return-Path: <linux-kernel+bounces-575454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA58A702F3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0D6881809
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6262561C3;
	Tue, 25 Mar 2025 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlLqryfm"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BE52561DF
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910003; cv=none; b=CnIIeKALoaP+UqVjXJ83nBDTqBvA4fzWcN4wDeJe+N2fgh10OUo78FCnty1b+vc4T2jKV5MGOuvuWY0ILwLnXArns8Kn4nllv4RCedb/NQE+kc1nNfojuxS72ma2RRuCK2x1Bs6lPbwBV0Wv5oQ0NbadAhHsC2PlXMYXfCQ4464=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910003; c=relaxed/simple;
	bh=Y+wkkkI1ImlZcIydvSmVT0/OeD+6AQ2WWZKTRFVLzog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EVf2p7f139BHWVg/ae9/hQHIiEMsw4VFusabmqm4xN7RCfHV1yD76VN68vL7qSM8e2z7Bjm0SrS5XqAj6yG73Hb6OgJoiV1NjRCDik94bhI1ek02phLS1gNb8Rbr/+xdYNfgwVUe2cXuaQtYVLLaqr1HDPtUOPVXE3SnbWAycv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlLqryfm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22438c356c8so112388455ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742910001; x=1743514801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O7KyW+xgbNLxpFA5rGlR0S7Pnfhh1eWTcPlYyA5iw4I=;
        b=SlLqryfmiCbf05yL/VGNt1RoJ6xHJUBNOZVr8pn8i6jVAzIEpUgI6U39OpwVP0IYHM
         NxTVEK0OlGG043WcB2LVKbVmQmJJudtG7TO/lN2uoRbg1wRR3gzXs6ZQhKzxfdDf4bST
         YKNs4bPmbazHLsgdoF6pVTxJW1ZuPb3SHvC1DbjtUDJ1WFdwlzSHGX9PTaAVc9lWyzBg
         jlJagCCzYe0nvgDsrCdru0IbSPPzzy12SyiUp9fvO8c9qgSEGUQcaH4xY+h9sbSrLIwM
         1gPMOuc8IylcEpoP+sUbI/8FD262iifHKKgS0OXffy5U+w/vxFVIC3gQWO1cIZSqd/Kc
         AP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742910001; x=1743514801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7KyW+xgbNLxpFA5rGlR0S7Pnfhh1eWTcPlYyA5iw4I=;
        b=m0vD+WWDAAO3CeShcNdFGVcIv09L5mmnFVz9NPU9zRnKNV/5uHappPSyyJ+qvcNhuY
         Xbg6qmSoVbAOpHtcMYqbS9qeW3tedDOVl0E7yxKVV7NYAM69c+Zk0pg+X0vHRmLr70dH
         w9H2YsYH2pEiZU3SemR+NilVYv77Pe0Qqlh/9f9s47V6Bg+oMh+KZf9uZ2Xh7jtE4/ll
         ouNDB7nlyur2bNqQ5BO72GVuK7/64/fGKwgzOerk2lrOrfTpUzelbJz1AA01Jx21pAWi
         HAQjAxTtjICBPKUyYKQufpvyktB3vGv6JT7sw13EqtCIT24L62pzz7W3wrBynmWd6r2t
         TChQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBCqqwu1tlPBAz7NjjFHgjluOPy/X58QbDqWytlnKM9cEsQne/tKqW2dhVdcPmcOlxBd9goXyLoVG7+Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBbwn/dzoCMMC5x5iierUYxtuKmdkMbxWw91Xb2lcBfSIpk94R
	enY+ZV74sHXM8TX+DxZzPVwLCiQKbcsDYlGlLSDYdL2SZhkAeGuw7zAxdo5N6xU=
X-Gm-Gg: ASbGncvbgpmG5HwphvroJCS/bKYYw1dQbHG7MceWh4EmrPMGDjC/Mcbxf46fXM41mzJ
	5D1hW+1TryuDFHxJ3PlOUKGWfJvnsgMbHy4MuOjBZIYwwX6hWNd7ocGRa32/s8F6Ss/DxQmiBPL
	legEnLaNtqnVuz46vp1pO6/KiGqqkD4WNT7JAlEVM2zmkK0DGqKgnRwhZMbEK/+my22gvZugavo
	RkAp/zvIjOy7m6s/cpH0BbKDYar37PwTRmObQybPnwi48fYa9VB8Re5qSadpIAyNuROx7FoGyc2
	v1JFUeUukbhOFefwFzY0FvKGeZZjXq6DXfnM11ZFmF9U+iq8+gA=
X-Google-Smtp-Source: AGHT+IHvVrvPTJwd0z4OCcD5xwNgUnMEn+Ser2wZNJvtcUuuwq6dAQ+8wvnkPBi/iVdn3KIckQ1WoA==
X-Received: by 2002:a17:903:283:b0:224:1e7a:43fe with SMTP id d9443c01a7336-22780e2a566mr231323245ad.46.1742910000734;
        Tue, 25 Mar 2025 06:40:00 -0700 (PDT)
Received: from localhost ([147.11.105.124])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227e452ec63sm13133435ad.192.2025.03.25.06.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 06:40:00 -0700 (PDT)
From: Liwei Song <liwei.song.lsong@gmail.com>
To: MiquelRaynal <miquel.raynal@bootlin.com>,
	RichardWeinberger <richard@nod.at>,
	VigneshRaghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	liwei.song.lsong@gmail.com
Subject: [PATCH] mtd: core: add sync between read/write and unbind device
Date: Tue, 25 Mar 2025 21:39:52 +0800
Message-ID: <20250325133954.3699535-1-liwei.song.lsong@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When unbinding mtd device or qspi controller with a high frequency
reading to /dev/mtd0 device, there will be Calltrace as below:

$ while true; do cat /dev/mtd0 >/dev/null; done &
$ echo ff8d2000.spi  > /sys/bus/platform/drivers/cadence-qspi/unbind

Internal error: synchronous external abort: 0000000096000210 [#1] PREEMPT SMP
Modules linked in:
CPU: 3 UID: 0 PID: 466 Comm: cat Not tainted 6.14.0-rc7-yocto-standard+ #1
Hardware name: SoCFPGA Stratix 10 SoCDK (DT)
pc : cqspi_indirect_read_execute.isra.0+0x188/0x330
lr : cqspi_indirect_read_execute.isra.0+0x21c/0x330
Call trace:
 cqspi_indirect_read_execute.isra.0+0x188/0x330 (P)
 cqspi_exec_mem_op+0x8bc/0xe40
 spi_mem_exec_op+0x3e0/0x478
 spi_mem_no_dirmap_read+0xa8/0xc8
 spi_mem_dirmap_read+0xdc/0x150
 spi_nor_read_data+0x120/0x198
 spi_nor_read+0xf0/0x280
 mtd_read_oob_std+0x80/0x98
 mtd_read_oob+0x9c/0x168
 mtd_read+0x6c/0xd8
 mtdchar_read+0xdc/0x288
 vfs_read+0xc8/0x2f8
 ksys_read+0x70/0x110
 __arm64_sys_read+0x24/0x38
 invoke_syscall+0x5c/0x130
 el0_svc_common.constprop.0+0x48/0xf8
 do_el0_svc+0x28/0x40
 el0_svc+0x30/0xd0
 el0t_64_sync_handler+0x144/0x168
 el0t_64_sync+0x198/0x1a0
Code: 927e7442 aa1a03e0 8b020342 d503201f (b9400321)
---[ end trace 0000000000000000 ]---

Or:
$ while true; do cat /dev/mtd0 >/dev/null; done &
$ echo spi0.0 > /sys/class/mtd/mtd0/device/driver/unbind

Unable to handle kernel paging request at virtual address 00000000000012e8
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 2 UID: 0 PID: 459 Comm: cat Not tainted 6.14.0-rc7-yocto-standard+ #1
Hardware name: SoCFPGA Stratix 10 SoCDK (DT)
pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : spi_mem_exec_op+0x3e8/0x478
lr : spi_mem_exec_op+0x3e0/0x478
Call trace:
 spi_mem_exec_op+0x3e8/0x478 (P)
 spi_mem_no_dirmap_read+0xa8/0xc8
 spi_mem_dirmap_read+0xdc/0x150
 spi_nor_read_data+0x120/0x198
 spi_nor_read+0xf0/0x280
 mtd_read_oob_std+0x80/0x98
 mtd_read_oob+0x9c/0x168
 mtd_read+0x6c/0xd8
 mtdchar_read+0xdc/0x288
 vfs_read+0xc8/0x2f8
 ksys_read+0x70/0x110
 __arm64_sys_read+0x24/0x38
 invoke_syscall+0x5c/0x130
 el0_svc_common.constprop.0+0x48/0xf8
 do_el0_svc+0x28/0x40
 el0_svc+0x30/0xd0
 el0t_64_sync_handler+0x144/0x168
 el0t_64_sync+0x198/0x1a0
Code: f9400842 d63f0040 2a0003f4 f94002a1 (f9417437)
---[ end trace 0000000000000000 ]---

when unbind is running, the memory allocated to qspi controller and
mtd device is freed during unbinding, but open/close and reading device
are still running, if the reading process get read lock and start
excuting, there will be above illegal memory access. This issue also
can be repruduced on many other platforms like ls1046 and nxpimx8 which
have qspi flash.

In this patch, register a spi bus notifier which will called before
unbind process free device memory, and add a new member mtd_event_remove
to block mtd open/read, then wait for the running task to be finished,
then free memory is safe to be run.

Signed-off-by: Liwei Song <liwei.song.lsong@gmail.com>
---
 drivers/mtd/mtdcore.c   | 57 +++++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/mtd.h |  2 ++
 2 files changed, 59 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 724f917f91ba..d35c2ecd5d11 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -34,6 +34,10 @@
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+#include <linux/mtd/spi-nor.h>
+#include <linux/delay.h>
 
 #include "mtdcore.h"
 
@@ -422,6 +426,48 @@ static int mtd_reboot_notifier(struct notifier_block *n, unsigned long state,
 	return NOTIFY_DONE;
 }
 
+static int mtd_remove_notifier_call(struct notifier_block *nb,
+				    unsigned long event, void *data)
+{
+	struct device *dev = data;
+	struct spi_device *spi = to_spi_device(dev);
+	struct spi_mem *mem = spi_get_drvdata(spi);
+	struct spi_nor *nor = mem->drvpriv;
+	struct mtd_info *master = &nor->mtd;
+	struct mtd_info *child, *next;
+	int ret;
+	bool removed;
+
+	switch (event) {
+	case BUS_NOTIFY_BOUND_DRIVER:
+		master->mtd_event_remove = false;
+		break;
+	case BUS_NOTIFY_DEL_DEVICE:
+	case BUS_NOTIFY_UNBIND_DRIVER:
+		mutex_lock(&mtd_table_mutex);
+		master->mtd_event_remove = true;
+		mutex_unlock(&mtd_table_mutex);
+
+		while (1) {
+			removed = true;
+			list_for_each_entry_safe(child, next, &master->partitions, part.node) {
+				mutex_lock(&mtd_table_mutex);
+				ret = kref_read(&child->refcnt);
+				if (ret > 1)
+					removed = false;
+				mutex_unlock(&mtd_table_mutex);
+			}
+			msleep(500);
+			if (removed)
+				break;
+		}
+
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
 /**
  * mtd_wunit_to_pairing_info - get pairing information of a wunit
  * @mtd: pointer to new MTD device info structure
@@ -1099,6 +1145,11 @@ int mtd_device_parse_register(struct mtd_info *mtd, const char * const *types,
 		register_reboot_notifier(&mtd->reboot_notifier);
 	}
 
+	if (!mtd->mtd_remove_nb.notifier_call) {
+		mtd->mtd_remove_nb.notifier_call = mtd_remove_notifier_call;
+		bus_register_notifier(&spi_bus_type, &mtd->mtd_remove_nb);
+	}
+
 out:
 	if (ret) {
 		nvmem_unregister(mtd->otp_user_nvmem);
@@ -1127,6 +1178,9 @@ int mtd_device_unregister(struct mtd_info *master)
 		memset(&master->reboot_notifier, 0, sizeof(master->reboot_notifier));
 	}
 
+	bus_unregister_notifier(&spi_bus_type, &master->mtd_remove_nb);
+	memset(&master->mtd_remove_nb, 0, sizeof(master->mtd_remove_nb));
+
 	nvmem_unregister(master->otp_user_nvmem);
 	nvmem_unregister(master->otp_factory_nvmem);
 
@@ -1243,6 +1297,9 @@ int __get_mtd_device(struct mtd_info *mtd)
 	struct mtd_info *master = mtd_get_master(mtd);
 	int err;
 
+	if (master->mtd_event_remove)
+		return -ENODEV;
+
 	if (master->_get_device) {
 		err = master->_get_device(mtd);
 		if (err)
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 8d10d9d2e830..74a17eb207ad 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -290,6 +290,7 @@ struct mtd_info {
 	/* Kernel-only stuff starts here. */
 	const char *name;
 	int index;
+	bool mtd_event_remove;
 
 	/* OOB layout description */
 	const struct mtd_ooblayout_ops *ooblayout;
@@ -369,6 +370,7 @@ struct mtd_info {
 	bool oops_panic_write;
 
 	struct notifier_block reboot_notifier;  /* default mode before reboot */
+	struct notifier_block mtd_remove_nb;
 
 	/* ECC status information */
 	struct mtd_ecc_stats ecc_stats;
-- 
2.40.0


