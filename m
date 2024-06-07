Return-Path: <linux-kernel+bounces-205282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266088FFA6C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D1B1F252E3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799E21B7F4;
	Fri,  7 Jun 2024 04:26:33 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790DC17582
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734393; cv=none; b=jdMgxsXquNj8iK2PR/oZhNxE4ExLGdLGH80a9knoO603buN6o1NjazJx+z9Fj2bTQG1v8a2CH322hWRmtshWCDmYICFSkkkKKgidATH7EWqEWODgm8ytIIZKe3QRBBPz/cz2m/vU0Y0iIHlmSEtZXtWq4XPEzEIcuHI6oyXwZ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734393; c=relaxed/simple;
	bh=jHtc/cF/ktkWBpBjDLIG23QKwR+A0mue9P5rqRX3Q20=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unfyNE9Z2jqvq97192IHmT8G6aNevXodbORVtRDXyoixGbCMEif8JugbXOmq5Y5lwAjPLONrfPauzAAAh7R3AGs//wvjNDaRom7NLVkf8W87iIgPJoXnQVOyHYQf7LYUtdFeNtRpHvuHtlmdA9X0oWhettYEp4JuxpTku6lhlfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VwSj0733yzwSCp;
	Fri,  7 Jun 2024 12:22:28 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id DE32418007B;
	Fri,  7 Jun 2024 12:26:27 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:27 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 001/110] mkfs.ubifs: Clear direct_write property when closing target
Date: Fri, 7 Jun 2024 12:24:26 +0800
Message-ID: <20240607042615.2069840-2-chengzhihao1@huawei.com>
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

Direct writing is not allowd on an UBI volume, unless the volume is set
with direct_write property. The open_target sets direct_write property,
don't forget to clear direct_write property for UBI volume when closing
target.

Fixes: a48340c335dab ("mkfs.ubifs: use libubi to format UBI volume")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/mkfs.ubifs/mkfs.ubifs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
index 42a47f83..5ca01512 100644
--- a/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
+++ b/ubifs-utils/mkfs.ubifs/mkfs.ubifs.c
@@ -2832,7 +2832,7 @@ static int open_target(void)
 			return sys_err_msg("cannot open the UBI volume '%s'",
 					   output);
 		if (ubi_set_property(out_fd, UBI_VOL_PROP_DIRECT_WRITE, 1))
-			return sys_err_msg("ubi_set_property failed");
+			return sys_err_msg("ubi_set_property(set direct_write) failed");
 
 		if (!yes && check_volume_empty()) {
 			if (!prompt("UBI volume is not empty.  Format anyways?", false))
@@ -2859,10 +2859,14 @@ static int open_target(void)
  */
 static int close_target(void)
 {
+	if (out_fd >= 0) {
+		if (ubi && ubi_set_property(out_fd, UBI_VOL_PROP_DIRECT_WRITE, 0))
+			return sys_err_msg("ubi_set_property(clear direct_write) failed");
+		if (close(out_fd) == -1)
+			return sys_err_msg("cannot close the target '%s'", output);
+	}
 	if (ubi)
 		libubi_close(ubi);
-	if (out_fd >= 0 && close(out_fd) == -1)
-		return sys_err_msg("cannot close the target '%s'", output);
 	if (output)
 		free(output);
 	return 0;
-- 
2.13.6


