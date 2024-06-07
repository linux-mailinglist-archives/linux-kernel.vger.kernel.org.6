Return-Path: <linux-kernel+bounces-205311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE688FFA8F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B2828AF95
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B22F15574B;
	Fri,  7 Jun 2024 04:27:15 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018BC364BE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734433; cv=none; b=vEaq4vZJByHoWZP0pQTZrfa0PrCL6e3DzetCZ0l/RKj/AvMm5z5IdOTT92CqKlDmrnmimbcAZvwxtb9HYyTnf4bFISbFlPhouwWn+1bAJV+UXur/5cqRZaOdtnkLvTI8mbEzNdxt1myLJG8gfHUx7aJ5VJTeUyYEqvxtCUDpQRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734433; c=relaxed/simple;
	bh=geSrxoa/Xad+0u5yy0YRf5R2AsyaBF4+2AerW6xMcGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LpvBcXGfFhf0NyO82eYVEHFWymaL57y59v6rRM+6un3Bpg0xC0iFEUnTeqPCIuaSrO7FWbW1hf49rZ9V5cCmCtlmJ2fmtHsmhsF4kugUIlUwTSivBdaSF6F9F5cFmUHo5GX3aa+TdXOqND2Ah+4MQ+nMZ3qNl88wq+Iwomaueyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VwSjq4B38z1S94s;
	Fri,  7 Jun 2024 12:23:11 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 50EE818007E;
	Fri,  7 Jun 2024 12:27:10 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:49 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 031/110] libubi: Add new interface ubi_leb_map()
Date: Fri, 7 Jun 2024 12:24:56 +0800
Message-ID: <20240607042615.2069840-32-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607042615.2069840-1-chengzhihao1@huawei.com>
References: <20240607042615.2069840-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

Add ubi_leb_map() implementation, it is used in UBIFS linux kernel libs.

This is a preparation for replacing implementation of UBIFS utils with
linux kernel libs.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 include/libubi.h | 15 +++++++++++++++
 lib/libubi.c     | 10 ++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/libubi.h b/include/libubi.h
index e1e234e1..213948d5 100644
--- a/include/libubi.h
+++ b/include/libubi.h
@@ -487,6 +487,21 @@ int ubi_leb_unmap(int fd, int lnum);
  */
 int ubi_is_mapped(int fd, int lnum);
 
+/**
+ * ubi_leb_map - map logical eraseblock to a physical eraseblock.
+ * @fd: volume character device file descriptor
+ * @lnum: logical eraseblock number
+ *
+ * This function maps an un-mapped logical eraseblock @lnum to a physical
+ * eraseblock. This means, that after a successful invocation of this
+ * function the logical eraseblock @lnum will be empty (contain only %0xFF
+ * bytes) and be mapped to a physical eraseblock, even if an unclean reboot
+ * happens.
+ *
+ * This function returns zero in case of success, %-1 in case of failures.
+ */
+int ubi_leb_map(int fd, int lnum);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/libubi.c b/lib/libubi.c
index 6b57e50d..86736dd5 100644
--- a/lib/libubi.c
+++ b/lib/libubi.c
@@ -1364,3 +1364,13 @@ int ubi_is_mapped(int fd, int lnum)
 {
 	return ioctl(fd, UBI_IOCEBISMAP, &lnum);
 }
+
+int ubi_leb_map(int fd, int lnum)
+{
+	struct ubi_map_req r;
+
+	memset(&r, 0, sizeof(struct ubi_map_req));
+	r.lnum = lnum;
+
+	return ioctl(fd, UBI_IOCEBMAP, &r);
+}
-- 
2.13.6


