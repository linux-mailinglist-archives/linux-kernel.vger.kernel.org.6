Return-Path: <linux-kernel+bounces-325895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5B9975F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 05:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613901C21C9A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 03:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96107603A;
	Thu, 12 Sep 2024 03:06:28 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE174524D7
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 03:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726110388; cv=none; b=W6U+u/j7nNb5p0Ep8xu6XZ2bgx168mKBcsbUGj5a+IegatBBchIWnslp3jGkIDDcUGINxWi6Jq7aQop6eYwIyA3wEVyrNealWLJ4zclKHDn7I/lfG1d83d6LOamBSZoEmxjfVRuE8IjQ3areGWgUeFSQ4p46D17Eav3nUAmybfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726110388; c=relaxed/simple;
	bh=l50N5g30YnYxmlWjSukQqML5PdxqqXKS8Tzk0WIqWls=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pfkmJsMgyct5BY5O+NfgFGQRbZWXz5ertRmuOMGLZtcdl3imvfW3mKZ2TT3mAcLitTd2lKW7fWWLOtxieWQWSFSP6/oXKxqcMpwUCJ7EArHW8uEgzq4Gykhwzi6QvOv3mXsubpUPiOtQUXkrJ/zeM78ie/PUTisU7r6vwLJP91Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4X42P71Fypz1P9W0;
	Thu, 12 Sep 2024 11:05:15 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id A08031800D3;
	Thu, 12 Sep 2024 11:06:22 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 12 Sep
 2024 11:06:22 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <lee@kernel.org>, <david-b@pacbell.net>, <gregkh@suse.de>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] mfd: tps65010: Use IRQF_NO_AUTOEN flag in request_irq() to fix race
Date: Thu, 12 Sep 2024 11:15:30 +0800
Message-ID: <20240912031530.2211654-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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

As the comment said, disable_irq() after request_irq() still has a
time gap in which interrupts can come. request_irq() with IRQF_NO_AUTOEN
flag will disable IRQ auto-enable when request IRQ.

Fixes: 72cd799544f2 ("[PATCH] I2C: add i2c driver for TPS6501x")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/mfd/tps65010.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/tps65010.c b/drivers/mfd/tps65010.c
index 2b9105295f30..710364435b6b 100644
--- a/drivers/mfd/tps65010.c
+++ b/drivers/mfd/tps65010.c
@@ -544,17 +544,13 @@ static int tps65010_probe(struct i2c_client *client)
 	 */
 	if (client->irq > 0) {
 		status = request_irq(client->irq, tps65010_irq,
-				     IRQF_TRIGGER_FALLING, DRIVER_NAME, tps);
+				     IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN,
+				     DRIVER_NAME, tps);
 		if (status < 0) {
 			dev_dbg(&client->dev, "can't get IRQ %d, err %d\n",
 					client->irq, status);
 			return status;
 		}
-		/* annoying race here, ideally we'd have an option
-		 * to claim the irq now and enable it later.
-		 * FIXME genirq IRQF_NOAUTOEN now solves that ...
-		 */
-		disable_irq(client->irq);
 		set_bit(FLAG_IRQ_ENABLE, &tps->flags);
 	} else
 		dev_warn(&client->dev, "IRQ not configured!\n");
-- 
2.34.1


