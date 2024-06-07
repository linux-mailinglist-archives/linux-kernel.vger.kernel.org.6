Return-Path: <linux-kernel+bounces-205296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C95B8FFA7F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 932001C236AD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A24D145B1A;
	Fri,  7 Jun 2024 04:26:56 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C84E1C696
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734415; cv=none; b=IECFP95j0FTR0+B4UX6qRifTNna8V2kxWBcIUe3Z53TkHEn3Y+Ks1J5bv9PABv2Cd0Vj0qIKEG5jcoSOjR/xusVH/5Ak46FIZ+K6ToGn2fsD0sOYrKlH0W1hX0qTa7DsrBXh/+XoFC2dYXNqRdoOAdLRP7H1lUTXlUWhUMG5DBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734415; c=relaxed/simple;
	bh=iAEPiS3GJJvi1tloxr0JfZFhHNa6BbDrKk/62wDMx7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IftsEnHNnYr0YQSMozfuXifnoeZLNMVbVb8OdeY3EpLYFAeLX+oTu8yXDTSTxz0y49f5/aIcuuPBVneNN4QzSiTfR1EfjI+H0/myWY8G5uIInUqQRO1FYzSWr3Gd30YfpqYufirBCCcppHjOTax7h26og9djkYGXM7F34CvzdW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VwSkB6y2JzPpnS;
	Fri,  7 Jun 2024 12:23:30 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 4644C1400D5;
	Fri,  7 Jun 2024 12:26:50 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:33 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 010/110] mkfs.ubifs: Close libubi in error handling paths
Date: Fri, 7 Jun 2024 12:24:35 +0800
Message-ID: <20240607042615.2069840-11-chengzhihao1@huawei.com>
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

The libubi could be opened in get_options(), don't forget to close it
in error handling paths in main(). Also close libubi in error handling
paths in open_ubi(). To implement that, extract libubi_close() into a
new helper function close_ubi().
Besides, invoke crypto_cleanup() in error handling paths in main().

Fixes: a48340c335dab ("mkfs.ubifs: use libubi to format UBI volume")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/mkfs.ubifs/mkfs.ubifs.c | 38 ++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
index 25c49967..6a4a4588 100644
--- a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
+++ b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
@@ -521,11 +521,21 @@ static long long get_bytes(const char *str)
 
 	return bytes;
 }
+
+static void close_ubi(void)
+{
+	if (ubi) {
+		libubi_close(ubi);
+		ubi = NULL;
+	}
+}
+
 /**
- * open_ubi - open the UBI volume.
+ * open_ubi - open the libubi.
  * @node: name of the UBI volume character device to fetch information about
  *
- * Returns %0 in case of success and %-1 in case of failure
+ * This function opens libubi, and initialize device & volume information
+ * according to @node. Returns %0 in case of success and %-1 in case of failure.
  */
 static int open_ubi(const char *node)
 {
@@ -537,10 +547,14 @@ static int open_ubi(const char *node)
 	ubi = libubi_open();
 	if (!ubi)
 		return -1;
-	if (ubi_get_vol_info(ubi, node, &c->vi))
+	if (ubi_get_vol_info(ubi, node, &c->vi)) {
+		close_ubi();
 		return -1;
-	if (ubi_get_dev_info1(ubi, c->vi.dev_num, &c->di))
+	}
+	if (ubi_get_dev_info1(ubi, c->vi.dev_num, &c->di)) {
+		close_ubi();
 		return -1;
+	}
 	return 0;
 }
 
@@ -2880,8 +2894,6 @@ static int close_target(void)
 		if (close(out_fd) == -1)
 			return sys_errmsg("cannot close the target '%s'", output);
 	}
-	if (ubi)
-		libubi_close(ubi);
 	if (output)
 		free(output);
 	return 0;
@@ -3062,25 +3074,25 @@ int main(int argc, char *argv[])
 
 	err = get_options(argc, argv);
 	if (err)
-		return err;
+		goto out;
 
 	err = open_target();
 	if (err)
-		return err;
+		goto out;
 
 	err = mkfs();
 	if (err) {
 		close_target();
-		return err;
+		goto out;
 	}
 
 	err = close_target();
-	if (err)
-		return err;
 
-	if (verbose)
+	if (verbose && !err)
 		printf("Success!\n");
 
+out:
+	close_ubi();
 	crypto_cleanup();
-	return 0;
+	return err;
 }
-- 
2.13.6


