Return-Path: <linux-kernel+bounces-335405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 763CB97E518
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 05:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 227951F21953
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 03:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88699C13D;
	Mon, 23 Sep 2024 03:46:04 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16E93FE4
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 03:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727063164; cv=none; b=gCQLxLCONxevMY4C9QRWCuCNSDEM8YJ8QdC6u4YCz3MYootFmPRO7jbW611+awB6288LBlRr2f4jGSA7GhnTNpQm+1pqtAuGlogstQ3HG+YsMnnnmAr17aqmQhNj/AHQGrCkQWttDygXLIDTBW5cl9eVY8Iz1Ww8Vw0i6VCb39c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727063164; c=relaxed/simple;
	bh=xJDTinMuVgyYBO79TfmFkELLBmH9JUvgEKeHl1+5YJ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uMKOYl9tZPBgDC52pbhVRT2F2ah6Vjb8N5E40loJ+Z7d07Kh0BkKWXH3Z0AO8ijP1G2X9gNzw0rH2u+zI3Ca1KkZQVxjwXopqOzw82leUOeJL3Q63Xp8R6CK9ZbrlpfSpg5dOp6q0e2TndCVeCvN3BZyuwlcEgXqOmHh45CptQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XBplT0Vyhz1T7nw;
	Mon, 23 Sep 2024 11:44:37 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B3EA180087;
	Mon, 23 Sep 2024 11:45:59 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Sep
 2024 11:45:58 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <samu.p.onkalo@nokia.com>,
	<jic23@cam.ac.uk>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] misc: apds990x: Fix missing pm_runtime_disable()
Date: Mon, 23 Sep 2024 11:55:56 +0800
Message-ID: <20240923035556.3009105-1-ruanjinjie@huawei.com>
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
 kwepemh500013.china.huawei.com (7.202.181.146)

The pm_runtime_disable() is missing in probe error path,
so add it to fix it.

Fixes: 92b1f84d46b2 ("drivers/misc: driver for APDS990X ALS and proximity sensors")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/misc/apds990x.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/apds990x.c b/drivers/misc/apds990x.c
index 6d4edd69db12..e7d73c972f65 100644
--- a/drivers/misc/apds990x.c
+++ b/drivers/misc/apds990x.c
@@ -1147,7 +1147,7 @@ static int apds990x_probe(struct i2c_client *client)
 		err = chip->pdata->setup_resources();
 		if (err) {
 			err = -EINVAL;
-			goto fail3;
+			goto fail4;
 		}
 	}
 
@@ -1155,7 +1155,7 @@ static int apds990x_probe(struct i2c_client *client)
 				apds990x_attribute_group);
 	if (err < 0) {
 		dev_err(&chip->client->dev, "Sysfs registration failed\n");
-		goto fail4;
+		goto fail5;
 	}
 
 	err = request_threaded_irq(client->irq, NULL,
@@ -1166,15 +1166,17 @@ static int apds990x_probe(struct i2c_client *client)
 	if (err) {
 		dev_err(&client->dev, "could not get IRQ %d\n",
 			client->irq);
-		goto fail5;
+		goto fail6;
 	}
 	return err;
-fail5:
+fail6:
 	sysfs_remove_group(&chip->client->dev.kobj,
 			&apds990x_attribute_group[0]);
-fail4:
+fail5:
 	if (chip->pdata && chip->pdata->release_resources)
 		chip->pdata->release_resources();
+fail4:
+	pm_runtime_disable(&client->dev);
 fail3:
 	regulator_bulk_disable(ARRAY_SIZE(chip->regs), chip->regs);
 fail2:
-- 
2.34.1


