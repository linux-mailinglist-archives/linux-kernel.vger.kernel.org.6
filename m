Return-Path: <linux-kernel+bounces-301051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2B995EBD9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48F69B239BA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3265517BED8;
	Mon, 26 Aug 2024 08:21:07 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16EB155CBA
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660466; cv=none; b=VHg2A0CaxbVduatdfZ5h/CWfJFb+FfnS3VJA92QbeNdEw3xAJdKvxHr0SiJyqhzKu+xNNtVp5RwesZ3zVe8fBGBrSIafTLT318Z++xapISokma46HDwuf9ALkrJOBYP1y478IxktRm+vUVAPWUYrdmM4UraQrIfIsU9yZvE+r68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660466; c=relaxed/simple;
	bh=0fEzRVJBNer7g/5p8A4HmoX7GUhsiSUN3gks6XZ4zaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hH+idb57GvD6Dxu6cwbKUVLHD2AmC6wJPgUeCPG+OGgJqUFL/2pXJ9OLvDG3ZH2edtWoxZOCXGlSFiq2WMixLKcUxdbiaciEkx+xW6ML/6bzA8lXXdONboyAdPh07/JFL7bBqH2AoUR27hHmC0ZK79WI0/i/XZ+54IkUBtxG8e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WskC947Kfz1S8qt;
	Mon, 26 Aug 2024 16:20:53 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id BD3D81A0188;
	Mon, 26 Aug 2024 16:21:02 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 16:21:02 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <lee@kernel.org>, <linux-kernel@vger.kernel.org>, <krzk@kernel.org>,
	<jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 11/12] mtd: rawnand: stm32_fmc2: Use for_each_child_of_node_scoped()
Date: Mon, 26 Aug 2024 16:28:46 +0800
Message-ID: <20240826082847.2591036-12-ruanjinjie@huawei.com>
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
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index 264556939a00..0f67e96cc240 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -1851,7 +1851,6 @@ static int stm32_fmc2_nfc_parse_child(struct stm32_fmc2_nfc *nfc,
 static int stm32_fmc2_nfc_parse_dt(struct stm32_fmc2_nfc *nfc)
 {
 	struct device_node *dn = nfc->dev->of_node;
-	struct device_node *child;
 	int nchips = of_get_child_count(dn);
 	int ret = 0;
 
@@ -1865,12 +1864,10 @@ static int stm32_fmc2_nfc_parse_dt(struct stm32_fmc2_nfc *nfc)
 		return -EINVAL;
 	}
 
-	for_each_child_of_node(dn, child) {
+	for_each_child_of_node_scoped(dn, child) {
 		ret = stm32_fmc2_nfc_parse_child(nfc, child);
-		if (ret < 0) {
-			of_node_put(child);
+		if (ret < 0)
 			return ret;
-		}
 	}
 
 	return ret;
-- 
2.34.1


