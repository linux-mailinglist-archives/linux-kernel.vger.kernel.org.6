Return-Path: <linux-kernel+bounces-301045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C68B95EBD1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1A971F22CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B50816F0EC;
	Mon, 26 Aug 2024 08:21:05 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAB813E3E1
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660465; cv=none; b=dAo6wLDR6sYwsmrR+r7mU3Fwb+qLwi/PwR0i+qQB3DX96bDVYFNwpW4h1LHy1v2CoU6CUKEGtZ6u7odiSAbbQyxh4Esoz85hzyrXOU6ShZM0CZkFUsw4i/j9QFtR8hzJgE0nW4O7EPwA0AOComAT51kPdaQRXTAL3Z05urIlzbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660465; c=relaxed/simple;
	bh=uRAT0GszZ+0lWEUNjajcbWLsbtL+79a2PZ6UcNhAviw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TG+h/OK29G+nWZKXJIhAj2xu+bHViPmDtWoolI3Wo7FDri3JLa1j6qWUbKnkdm+dHdoUaUrlIcD7kJB1MGKkyiCvYHjAyKYMDPRk+IjQScdYt5qyvFzfpdhLBPN8YeSk7i6DOHRCPjCoO1gWkx4WjIYPmAAf4mPNuhgyfmlXSAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WskC74Zc2z1S8wS;
	Mon, 26 Aug 2024 16:20:51 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id CCF72140135;
	Mon, 26 Aug 2024 16:21:00 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 16:21:00 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <lee@kernel.org>, <linux-kernel@vger.kernel.org>, <krzk@kernel.org>,
	<jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 05/12] mtd: rawnand: pl353: Use for_each_child_of_node_scoped()
Date: Mon, 26 Aug 2024 16:28:40 +0800
Message-ID: <20240826082847.2591036-6-ruanjinjie@huawei.com>
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
from the loop by using for_each_child_of_node_scoped().

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/mtd/nand/raw/pl35x-nand-controller.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/pl35x-nand-controller.c b/drivers/mtd/nand/raw/pl35x-nand-controller.c
index 1c76ee98efb7..2570fd0beea0 100644
--- a/drivers/mtd/nand/raw/pl35x-nand-controller.c
+++ b/drivers/mtd/nand/raw/pl35x-nand-controller.c
@@ -1111,7 +1111,7 @@ static void pl35x_nand_chips_cleanup(struct pl35x_nandc *nfc)
 
 static int pl35x_nand_chips_init(struct pl35x_nandc *nfc)
 {
-	struct device_node *np = nfc->dev->of_node, *nand_np;
+	struct device_node *np = nfc->dev->of_node;
 	int nchips = of_get_child_count(np);
 	int ret;
 
@@ -1121,10 +1121,9 @@ static int pl35x_nand_chips_init(struct pl35x_nandc *nfc)
 		return -EINVAL;
 	}
 
-	for_each_child_of_node(np, nand_np) {
+	for_each_child_of_node_scoped(np, nand_np) {
 		ret = pl35x_nand_chip_init(nfc, nand_np);
 		if (ret) {
-			of_node_put(nand_np);
 			pl35x_nand_chips_cleanup(nfc);
 			break;
 		}
-- 
2.34.1


