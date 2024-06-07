Return-Path: <linux-kernel+bounces-205360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7628FFAC6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233CE1F2603B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0B0160784;
	Fri,  7 Jun 2024 04:27:50 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D20B61FF8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734468; cv=none; b=T0XVPv1kcxAMAYiRnW/X60d9Lc1khkjcamiYFxCogH1vUJc6iW/p67Od9l+kouwT1v1HYJJ22HVP+psauuLQqPBtVA0T/ya6sfthTqrYdqYqyr8dk0usGldeXZJgpN3XqB5xb9EUczYMsZC6ljKDIH6IKWiqH/G2Zo8VzAoeBew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734468; c=relaxed/simple;
	bh=54o2RRAK0N4BrSnmCPVoGtJc3UdcM0DKk7wqujxnxUI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DB9aZyqkNrhodLrm7YUXuGp1Gh+BR3XiPhoYFSnC5tE4tkv7jOZdEZPwAaGTE7YmXEkalijOIXADs/jL+zuXl/FCvxs/BGfIgucaAnE0DVTGS0ADVXkFNz96YImIJpg+WANvhk6KAvZJoIeRkBzAY7hCxWEZOkvADFl81YiKZkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VwSkQ6H1vzsTT0;
	Fri,  7 Jun 2024 12:23:42 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 86AA5180085;
	Fri,  7 Jun 2024 12:27:41 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:27:34 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 091/110] fsck.ubifs: Commit problem fixing modifications to disk
Date: Fri, 7 Jun 2024 12:25:56 +0800
Message-ID: <20240607042615.2069840-92-chengzhihao1@huawei.com>
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

This is the 13/18 step of fsck. Commit problem fixing modifications
(which are generated from the previous steps) to disk.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/fsck.ubifs/fsck.ubifs.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/ubifs-utils/fsck.ubifs/fsck.ubifs.c b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
index 436831cb..66b9c578 100644
--- a/ubifs-utils/fsck.ubifs/fsck.ubifs.c
+++ b/ubifs-utils/fsck.ubifs/fsck.ubifs.c
@@ -432,6 +432,33 @@ void handle_error(const struct ubifs_info *c, int reason_set)
 		exit_code |= FSCK_ERROR;
 }
 
+static int commit_fix_modifications(struct ubifs_info *c)
+{
+	int err;
+
+	if (exit_code & FSCK_NONDESTRUCT) {
+		log_out(c, "Commit problem fixing modifications");
+
+		/*
+		 * Force UBIFS to do commit by setting @c->mounting if changes
+		 * happen on disk. Committing is required once before allocating
+		 * new space(subsequent steps may need), because building lpt
+		 * could mark LEB(which holds stale data nodes) as unused, if
+		 * the LEB is overwritten by new data, old data won't be found
+		 * in next fsck run(assume that first fsck run is interrupted by
+		 * the powercut), which could affect the correctness of LEB
+		 * properties after replaying journal in the second fsck run.
+		 */
+		c->mounting = 1;
+	}
+	err = ubifs_run_commit(c);
+
+	if (exit_code & FSCK_NONDESTRUCT)
+		c->mounting = 0;
+
+	return err;
+}
+
 /*
  * do_fsck - Check & repair the filesystem.
  */
@@ -479,9 +506,16 @@ static int do_fsck(void)
 	err = check_and_correct_space(c);
 	kfree(FSCK(c)->used_lebs);
 	destroy_file_tree(c, &FSCK(c)->scanned_files);
+	if (err) {
+		exit_code |= FSCK_ERROR;
+		goto free_disconnected_files_2;
+	}
+
+	err = commit_fix_modifications(c);
 	if (err)
 		exit_code |= FSCK_ERROR;
 
+free_disconnected_files_2:
 	destroy_file_list(c, &FSCK(c)->disconnected_files);
 	return err;
 
@@ -532,6 +566,7 @@ int main(int argc, char *argv[])
 	 * Step 10: Check and correct files
 	 * Step 11: Check whether the TNC is empty
 	 * Step 12: Check and correct the space statistics
+	 * Step 13: Commit problem fixing modifications
 	 */
 	err = do_fsck();
 	if (err && FSCK(c)->try_rebuild) {
-- 
2.13.6


