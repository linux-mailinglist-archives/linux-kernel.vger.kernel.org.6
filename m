Return-Path: <linux-kernel+bounces-205292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A3F8FFA7B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A138B23511
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFC413F458;
	Fri,  7 Jun 2024 04:26:55 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FED013E04F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734414; cv=none; b=UUzeuBjHdLCApjRj8qXP3pgA38Pw71lCST+HTGO0DxXMV61KixT7StCRPCrf2OmoNxVXB1RRLti3Wx3bf1MIwMVThFVXwfqY3NyEm2H5oYpKPz7qNYANlIIwXhvt22FYmzcjIiKXq+Fv215HgZ8r/1eTay8TgHF3jDT+eA/C0TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734414; c=relaxed/simple;
	bh=1irDstytzNPyT8cxCLPG0N57rj/rgKgKzkw2iReGzUk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOy7av5qKwb77gx3epSowyh6vbdxT6i2aKIhvkGL8Qmq5TFGYXjv0+2Xak0HrT+wjcT9/5WpUF+F/vi8nnRxfo6wm+7zDFL83skkJzqnXtAKCV2UH6qWOzJze5aG3aSoeOMud+JV+zwJHD6zs/6dHMIIgA5o9ZOUydhNgKyfB9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VwSjR4D24z1SB5B;
	Fri,  7 Jun 2024 12:22:51 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 543FA14038F;
	Fri,  7 Jun 2024 12:26:50 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:34 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 011/110] mkfs.ubifs: Fix missed closing out_fd
Date: Fri, 7 Jun 2024 12:24:36 +0800
Message-ID: <20240607042615.2069840-12-chengzhihao1@huawei.com>
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

Closing 'out_fd' is missed in handling paths in open_target(), fix it
by adding closing operations before returning.

Fixes: a48340c335dab ("mkfs.ubifs: use libubi to format UBI volume")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/mkfs.ubifs/mkfs.ubifs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
index 6a4a4588..949187ea 100644
--- a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
+++ b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
@@ -2860,12 +2860,16 @@ static int open_target(void)
 		if (out_fd == -1)
 			return sys_errmsg("cannot open the UBI volume '%s'",
 					   output);
-		if (ubi_set_property(out_fd, UBI_VOL_PROP_DIRECT_WRITE, 1))
+		if (ubi_set_property(out_fd, UBI_VOL_PROP_DIRECT_WRITE, 1)) {
+			close(out_fd);
 			return sys_errmsg("ubi_set_property(set direct_write) failed");
+		}
 
 		if (!yes && check_volume_empty()) {
-			if (!prompt("UBI volume is not empty.  Format anyways?", false))
+			if (!prompt("UBI volume is not empty.  Format anyways?", false)) {
+				close(out_fd);
 				return errmsg("UBI volume is not empty");
+			}
 		}
 	} else {
 		out_fd = open(output, O_CREAT | O_RDWR | O_TRUNC,
-- 
2.13.6


