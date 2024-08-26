Return-Path: <linux-kernel+bounces-301048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2F695EBD4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29781F23201
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ED8179967;
	Mon, 26 Aug 2024 08:21:06 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCE815575E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660466; cv=none; b=dAQGrdOtBvFlmR87oxCTIn6oEXldKNhUgdtN7tNcNgLLmJmNBnE1JVCewHpjZk5C1nuEFlUFxdup/OatOFuV73tU/cHP+gQHARizwqMz4QCLoV0plcVCd0YtFmb1FfsWTwkGUGMGKHRLMBL9Z0kYIcAzwBDq8was13vIoutENr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660466; c=relaxed/simple;
	bh=kaPWioaY10ge/EeuBsJifxGnuaMakkiK/YMcIwPG2Dc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arQ9N5a4kIFSsSGsDw/J9TLH19qvdr1CWXAi4l7WxKh+6lbSEWcHvi6f/s07KxSZ+vhqL5EELbv4RcYFDZfChGzLVxOEOZOcCWoCYsl/WTm3w7vFu0tcDa0E5XdnG0iKssVL6Ih1NQIyMQnizlMMe+FUgi3jQnb88EPRBanq5cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wsk7X71Wcz1HG5S;
	Mon, 26 Aug 2024 16:17:44 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 667531A0188;
	Mon, 26 Aug 2024 16:21:02 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 16:21:01 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <lee@kernel.org>, <linux-kernel@vger.kernel.org>, <krzk@kernel.org>,
	<jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 10/12] mtd: rawnand: renesas: Use for_each_child_of_node_scoped()
Date: Mon, 26 Aug 2024 16:28:45 +0800
Message-ID: <20240826082847.2591036-11-ruanjinjie@huawei.com>
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
 drivers/mtd/nand/raw/renesas-nand-controller.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/renesas-nand-controller.c b/drivers/mtd/nand/raw/renesas-nand-controller.c
index c9a01feff8df..0e92d50c5249 100644
--- a/drivers/mtd/nand/raw/renesas-nand-controller.c
+++ b/drivers/mtd/nand/raw/renesas-nand-controller.c
@@ -1297,23 +1297,17 @@ static void rnandc_chips_cleanup(struct rnandc *rnandc)
 
 static int rnandc_chips_init(struct rnandc *rnandc)
 {
-	struct device_node *np;
 	int ret;
 
-	for_each_child_of_node(rnandc->dev->of_node, np) {
+	for_each_child_of_node_scoped(rnandc->dev->of_node, np) {
 		ret = rnandc_chip_init(rnandc, np);
 		if (ret) {
-			of_node_put(np);
-			goto cleanup_chips;
+			rnandc_chips_cleanup(rnandc);
+			return ret;
 		}
 	}
 
 	return 0;
-
-cleanup_chips:
-	rnandc_chips_cleanup(rnandc);
-
-	return ret;
 }
 
 static int rnandc_probe(struct platform_device *pdev)
-- 
2.34.1


