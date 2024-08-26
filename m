Return-Path: <linux-kernel+bounces-301046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2557295EBD2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40871F22D57
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD24016F82E;
	Mon, 26 Aug 2024 08:21:05 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFC514386B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660465; cv=none; b=LcnkJBUKcKEuagNM5NShDLFgKNM7KfbJjnm2WGQbLnqNtzJoWhUXrXHCCRhepZYxvchjaDFyFoRkYadLij7RvlaehvB/VJHu36G1v2AmRQuzyQtEHKFdibsDDqXyLAHXGYaheyGAs/WlT0TpinmmnxU4/Ggx5LQG6dRNXwFQCeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660465; c=relaxed/simple;
	bh=Bna+vE5Iar1jNNPPNrHpaEB+yTpBYOu6fQ9VwwXdTRk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JrCWUD34b9Vf4rs9Z64jS3HyBB0dDrCcXlkAWgNL6jhopkC8VuuTrG2uvBGy4TVW61W4FcZJSS1WVzZM6t1yELQM9xmK8QGAEXFCJGHfOzT4Ti77X3N1hLIQa6Xz3r19Mefc4mo8pydcQshqN+3773TDlclsIFVt7c/2iQFvyWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WskC90MS7z1j7Gg;
	Mon, 26 Aug 2024 16:20:53 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 742A8140135;
	Mon, 26 Aug 2024 16:21:01 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 16:21:00 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <lee@kernel.org>, <linux-kernel@vger.kernel.org>, <krzk@kernel.org>,
	<jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 07/12] mtd: rawnand: rockchip: Use for_each_child_of_node_scoped()
Date: Mon, 26 Aug 2024 16:28:42 +0800
Message-ID: <20240826082847.2591036-8-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826082847.2591036-1-ruanjinjie@huawei.com>
References: <20240826082847.2591036-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Avoids the need for manual cleanup of_node_put() in early exits
from the loop.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/mtd/nand/raw/rockchip-nand-controller.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
index 55580447633b..51c9cf9013dc 100644
--- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
+++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
@@ -1211,7 +1211,7 @@ static void rk_nfc_chips_cleanup(struct rk_nfc *nfc)
 
 static int rk_nfc_nand_chips_init(struct device *dev, struct rk_nfc *nfc)
 {
-	struct device_node *np = dev->of_node, *nand_np;
+	struct device_node *np = dev->of_node;
 	int nchips = of_get_child_count(np);
 	int ret;
 
@@ -1221,10 +1221,9 @@ static int rk_nfc_nand_chips_init(struct device *dev, struct rk_nfc *nfc)
 		return -EINVAL;
 	}
 
-	for_each_child_of_node(np, nand_np) {
+	for_each_child_of_node_scoped(np, nand_np) {
 		ret = rk_nfc_nand_chip_init(dev, nfc, nand_np);
 		if (ret) {
-			of_node_put(nand_np);
 			rk_nfc_chips_cleanup(nfc);
 			return ret;
 		}
-- 
2.34.1


