Return-Path: <linux-kernel+bounces-205353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2255B8FFABB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAAB61F224C3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC63C161319;
	Fri,  7 Jun 2024 04:27:46 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E2860B8A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734464; cv=none; b=dxiCwiLc6rQ69+3lwHcYqijAXPTAPw2x+OiWDrwGRq/YGvzAz7sgS5y8YgZ9YFBK83llMFRjcduZzfvsUg4h9IrlG96vQ++Rk92T36/S++Sh91460aevKvoI+CWdffkXHY1AdR9XNTGj4B/BpF27rKEnIgubM90mkbTKfOFfUaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734464; c=relaxed/simple;
	bh=76w+3CDTfjp/pa3E+o/4BSA/lnfPkin7Nv/v431dY2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4GsUhxM3kahtrdxMvkAlUbWWpV4BXMOZdarmESx1na+T45/EWFPC+aFq6yVyJIkZJTZGYMYamhZWCN+ANEpFRL+FTLlzcM1m0RdMVRXa5I4N3yF/IEkX/Ii7eIB9ACMIIFf4K0MqTLeWt10Fz9oHm3TnCrbVnHF7Uooz+qt+f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VwSkP4dvtz1SB0f;
	Fri,  7 Jun 2024 12:23:41 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 6211B180AA6;
	Fri,  7 Jun 2024 12:27:40 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:21 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 074/110] fsck.ubifs: rebuild_fs: Clean up log and orphan area
Date: Fri, 7 Jun 2024 12:25:39 +0800
Message-ID: <20240607042615.2069840-75-chengzhihao1@huawei.com>
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

This is the 11/12 step of rebuilding. Clean up log and orphan area, all
nodes have been recovered, these two areas should be cleared, otherwise
old content in journal/orphan could be replayed in next mounting.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/rebuild_fs.c | 46 +++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/ubifs-utils/fsck.ubifs/rebuild_fs.c b/ubifs-utils/fsck.ubifs/rebuild_fs.c
index 085df2b9..9ea4c224 100644
--- a/ubifs-utils/fsck.ubifs/rebuild_fs.c
+++ b/ubifs-utils/fsck.ubifs/rebuild_fs.c
@@ -1312,6 +1312,39 @@ static int build_lpt(struct ubifs_info *c)
 }
 
 /**
+ * clean_log - clean up log area.
+ * @c: UBIFS file-system description object
+ *
+ * This function cleans up log area, since there is no need to do recovery
+ * in next mounting.
+ */
+static int clean_log(struct ubifs_info *c)
+{
+	int lnum, err;
+	struct ubifs_cs_node *cs;
+
+	for (lnum = UBIFS_LOG_LNUM; lnum <= c->log_last; lnum++) {
+		err = ubifs_leb_unmap(c, lnum);
+		if (err)
+			return err;
+	}
+
+	cs = kzalloc(ALIGN(UBIFS_CS_NODE_SZ, c->min_io_size), GFP_KERNEL);
+	if (!cs)
+		return -ENOMEM;
+
+	cs->ch.node_type = UBIFS_CS_NODE;
+	cs->cmt_no = cpu_to_le64(0);
+
+	err = ubifs_write_node(c, cs, UBIFS_CS_NODE_SZ, UBIFS_LOG_LNUM, 0);
+	kfree(cs);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+/**
  * ubifs_rebuild_filesystem - Rebuild filesystem.
  * @c: UBIFS file-system description object
  *
@@ -1383,6 +1416,19 @@ int ubifs_rebuild_filesystem(struct ubifs_info *c)
 	/* Step 10. Build LPT. */
 	log_out(c, "Build LPT");
 	err = build_lpt(c);
+	if (err) {
+		exit_code |= FSCK_ERROR;
+		goto out;
+	}
+
+	/* Step 11. Clean up log & orphan. */
+	log_out(c, "Clean up log & orphan");
+	err = clean_log(c);
+	if (err) {
+		exit_code |= FSCK_ERROR;
+		goto out;
+	}
+	err = ubifs_clear_orphans(c);
 	if (err)
 		exit_code |= FSCK_ERROR;
 
-- 
2.13.6


