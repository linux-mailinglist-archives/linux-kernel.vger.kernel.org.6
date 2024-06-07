Return-Path: <linux-kernel+bounces-205354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9F38FFAC0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 420261F221B7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96041667C5;
	Fri,  7 Jun 2024 04:27:48 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA7E15F302
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734464; cv=none; b=mXhrRah4pxwzBhJYIFw5TiMoWkcum5A83MsXeLiMEMVwvxGnatxyQ425YbMdKKK0toKb/XXvlEQ8EO5MjmO8RhXhn7AaJo/WZpmp/wNQZJBz5AOsh+0fSM6DlIAR1OZ/VUw7iWTkS7gOrIbck0/95JYRQf1XjGHGGACZM5Mrv1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734464; c=relaxed/simple;
	bh=ca9Mj0VjlKUxE1VlovKla9D2pagfoemMx8OuQSrBYVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JiWJpJG1UhfhqfYGENcCR8Iote6EtLIusPvjRgbwxWZ080QW6cYQNHPTBusUcUSmld/zaexTGIioBKRZCkRXO4gIKPSlc6qBzncGEthm+kwWkHZqqGFCo7nTTL5BE6m2TbtdzfWDXU6tsjVpmmPmLi6SyF5x8/E3waWE+13vAGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VwSkP5qSzzwSCp;
	Fri,  7 Jun 2024 12:23:41 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id B33D0180085;
	Fri,  7 Jun 2024 12:27:40 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:25 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 079/110] fsck.ubifs: Consolidate log
Date: Fri, 7 Jun 2024 12:25:44 +0800
Message-ID: <20240607042615.2069840-80-chengzhihao1@huawei.com>
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

This is the 4/18 step of fsck. Consolidate log to ensure enough space
in log area. There could be following possible errors:
 1. corrupted scanning data in log area: danger mode with rebuild_fs and
    normal mode with 'yes' answer will turn to rebuild filesystem, other
    modes will exit.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/fsck.ubifs.c |  1 +
 ubifs-utils/fsck.ubifs/load_fs.c    | 26 ++++++++++++++++++++++++++
 ubifs-utils/libubifs/log.c          |  1 +
 3 files changed, 28 insertions(+)

diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.c b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
index 4d5296d7..9d69a4fd 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.c
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
@@ -433,6 +433,7 @@ int main(int argc, char *argv[])
 	 * Step 1: Read master & init lpt
 	 * Step 2: Replay journal
 	 * Step 3: Handle orphan nodes
+	 * Step 4: Consolidate log
 	 */
 	err = ubifs_load_filesystem(c);
 	if (err) {
diff --git a/ubifs-utils/fsck.ubifs/load_fs.c b/ubifs-utils/fsck.ubifs/load_fs.c
index f376383c..42b1afaa 100644
--- a/ubifs-utils/fsck.ubifs/load_fs.c
+++ b/ubifs-utils/fsck.ubifs/load_fs.c
@@ -199,6 +199,32 @@ int ubifs_load_filesystem(struct ubifs_info *c)
 		goto out_orphans;
 	}
 
+	if (!c->ro_mount) {
+		int lnum;
+
+		/* Check for enough log space */
+		lnum = c->lhead_lnum + 1;
+		if (lnum >= UBIFS_LOG_LNUM + c->log_lebs)
+			lnum = UBIFS_LOG_LNUM;
+		if (lnum == c->ltail_lnum) {
+			log_out(c, "Consolidate log");
+			err = ubifs_consolidate_log(c);
+			if (err) {
+				unsigned int reason = get_failure_reason_callback(c);
+
+				clear_failure_reason_callback(c);
+				if (reason & FR_DATA_CORRUPTED) {
+					if (fix_problem(c, LOG_CORRUPTED, NULL))
+						FSCK(c)->try_rebuild = true;
+				} else {
+					ubifs_assert(c, reason == 0);
+					exit_code |= FSCK_ERROR;
+				}
+				goto out_orphans;
+			}
+		}
+	}
+
 	c->mounting = 0;
 
 	return 0;
diff --git a/ubifs-utils/libubifs/log.c b/ubifs-utils/libubifs/log.c
index 0d459261..c3dfd98e 100644
--- a/ubifs-utils/libubifs/log.c
+++ b/ubifs-utils/libubifs/log.c
@@ -711,6 +711,7 @@ int ubifs_consolidate_log(struct ubifs_info *c)
 	destroy_done_tree(&done_tree);
 	vfree(buf);
 	if (write_lnum == c->lhead_lnum) {
+		set_failure_reason_callback(c, FR_DATA_CORRUPTED);
 		ubifs_err(c, "log is too full");
 		return -EINVAL;
 	}
-- 
2.13.6


