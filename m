Return-Path: <linux-kernel+bounces-205379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961648FFAE2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381FF289BB3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE8D1C290;
	Fri,  7 Jun 2024 04:29:07 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95741BC4B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734547; cv=none; b=nK93AOMqMBQk7GdSV0Sb7zZv74+EfEInoiJQ0xmYpwnlWGgmgrJZXlDo9+OF9rVY4PcBHfM8Bd4OQXa9u1a7fpCnA2379mde+Rb1+W+zGJ5gYHZNlf8d5P44H5MXwLxH664FBlGB+Zh9DBKljMfAsaSPEq/l+Z3W9lRZH2ou4Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734547; c=relaxed/simple;
	bh=P7iFWOkyemRtKjMLJp0jNDGMIjALdjeOj1XL3Zl9uTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kunqg3EQ6wffavsgurEsC/6e0Tu5/wRUG6oaismca48Jb+S2VQ5xtXkYf7ifT7+HWMkbGAaYEpDRkySOfGhbZLHuBSgNLX0SPRzHpyIJKHwVGUetK+jmbUd0ukSp1bn9WoOHbCCGW06qzLRvXzbtjLauxSQxoVhBM8rXXfAEqJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VwSm11spzzwS3r;
	Fri,  7 Jun 2024 12:25:05 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 30CDD140336;
	Fri,  7 Jun 2024 12:28:49 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:38 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 097/110] fsck.ubifs: Do final committing
Date: Fri, 7 Jun 2024 12:26:02 +0800
Message-ID: <20240607042615.2069840-98-chengzhihao1@huawei.com>
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

This is the 18/18 step of fsck. Do final committing, commit problem
fixing modifications(which are generated since step 14) to disk, and
clear %UBIFS_MST_DIRTY flag for master node.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/fsck.ubifs.c | 46 ++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.c b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
index 831a13db..b1b56194 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.c
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
@@ -432,28 +432,25 @@ void handle_error(const struct ubifs_info *c, int reason_set)
 		exit_code |= FSCK_ERROR;
 }
 
-static int commit_fix_modifications(struct ubifs_info *c)
+static int commit_fix_modifications(struct ubifs_info *c, bool final_commit)
 {
 	int err;
 
-	if (exit_code & FSCK_NONDESTRUCT) {
+	if (final_commit) {
+		log_out(c, "Final committing");
+		c->mst_node->flags &= ~cpu_to_le32(UBIFS_MST_DIRTY);
+		c->mst_node->gc_lnum = cpu_to_le32(c->gc_lnum);
+		/* Force UBIFS to do commit by setting @c->mounting. */
+		c->mounting = 1;
+	} else if (exit_code & FSCK_NONDESTRUCT) {
 		log_out(c, "Commit problem fixing modifications");
-
-		/*
-		 * Force UBIFS to do commit by setting @c->mounting if changes
-		 * happen on disk. Committing is required once before allocating
-		 * new space(subsequent steps may need), because building lpt
-		 * could mark LEB(which holds stale data nodes) as unused, if
-		 * the LEB is overwritten by new data, old data won't be found
-		 * in next fsck run(assume that first fsck run is interrupted by
-		 * the powercut), which could affect the correctness of LEB
-		 * properties after replaying journal in the second fsck run.
-		 */
+		/* Force UBIFS to do commit by setting @c->mounting. */
 		c->mounting = 1;
 	}
+
 	err = ubifs_run_commit(c);
 
-	if (exit_code & FSCK_NONDESTRUCT)
+	if (c->mounting)
 		c->mounting = 0;
 
 	return err;
@@ -511,7 +508,16 @@ static int do_fsck(void)
 		goto free_disconnected_files_2;
 	}
 
-	err = commit_fix_modifications(c);
+	/*
+	 * Committing is required once before allocating new space(subsequent
+	 * steps may need), because building lpt could mark LEB(which holds
+	 * stale data nodes) as unused, if the LEB is overwritten by new data,
+	 * old data won't be found in the next fsck run(assume that first fsck
+	 * run is interrupted by the powercut), which could affect the
+	 * correctness of LEB properties after replaying journal in the second
+	 * fsck run.
+	 */
+	err = commit_fix_modifications(c, false);
 	if (err) {
 		exit_code |= FSCK_ERROR;
 		goto free_disconnected_files_2;
@@ -532,7 +538,7 @@ static int do_fsck(void)
 	}
 
 	if (list_empty(&FSCK(c)->disconnected_files))
-		return err;
+		goto final_commit;
 
 	log_out(c, "Check and create lost+found");
 	err = check_and_create_lost_found(c);
@@ -548,6 +554,13 @@ static int do_fsck(void)
 		goto free_disconnected_files_2;
 	}
 
+final_commit:
+	err = commit_fix_modifications(c, true);
+	if (err)
+		exit_code |= FSCK_ERROR;
+
+	return err;
+
 free_disconnected_files_2:
 	destroy_file_list(c, &FSCK(c)->disconnected_files);
 	return err;
@@ -604,6 +617,7 @@ int main(int argc, char *argv[])
 	 * Step 15: Check and create root dir
 	 * Step 16: Check and create lost+found
 	 * Step 17: Handle disconnected files
+	 * Step 18: Do final committing
 	 */
 	err = do_fsck();
 	if (err && FSCK(c)->try_rebuild) {
-- 
2.13.6


