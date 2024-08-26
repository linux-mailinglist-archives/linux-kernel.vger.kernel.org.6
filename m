Return-Path: <linux-kernel+bounces-301519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9F895F209
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71772B22AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64881865F4;
	Mon, 26 Aug 2024 12:48:13 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51F0155727
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676493; cv=none; b=oxAg58ufZ6MmZvC7Zd77D4WZv4U/jRqOVe38mSGpRGvW46/q2kh8ra6TXIuxkO25e5BuHNbVHZb7YhBFsGUGAIBnZFIYQ/EaQK1Gae9ROTWP7uxpCWpNY52TntZ25sXC1euOEfBkU2V44n7UK30EVgxFeTFj0LwgqJwPglkjNRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676493; c=relaxed/simple;
	bh=JlgAcrWR1oGvDy/0k+MyPgn6az2qovMb9XJOvrn+bNk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VsfguG9CFS7qQd2oIc4LSHFPYLdNSLSijtPXJmxFKwnJIAvV18+sHhUwSK1pm0vQSGxNx+kAPl18l3qCwvjkibAbTb+6687uT087QYqf+30d+4UQM159Gz2Lb2aT200XG7vtIsc5QaqecYxS+t2fYMk4S+zSt62VOUPxoWLL4xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wsr6g3pk6z14J95;
	Mon, 26 Aug 2024 20:47:23 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 30DBE14037E;
	Mon, 26 Aug 2024 20:48:09 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 26 Aug
 2024 20:48:08 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <pgaj@cadence.com>, <alexandre.belloni@bootlin.com>
Subject: [PATCH -next] i3c: master: cdns: fix module autoloading
Date: Mon, 26 Aug 2024 12:39:57 +0000
Message-ID: <20240826123957.379212-1-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500020.china.huawei.com (7.185.36.49)

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
---
 drivers/i3c/master/i3c-master-cdns.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index c1627f3552ce..ee555255f1a2 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -1562,6 +1562,7 @@ static const struct of_device_id cdns_i3c_master_of_ids[] = {
 	{ .compatible = "cdns,i3c-master", .data = &cdns_i3c_devdata },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, cdns_i3c_master_of_ids);
 
 static int cdns_i3c_master_probe(struct platform_device *pdev)
 {
-- 
2.34.1


