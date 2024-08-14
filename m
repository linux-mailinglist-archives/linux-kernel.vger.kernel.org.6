Return-Path: <linux-kernel+bounces-285802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1589512F3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86739283580
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854FC381C6;
	Wed, 14 Aug 2024 03:12:37 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0217221345;
	Wed, 14 Aug 2024 03:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723605157; cv=none; b=Dqj9vrmBmxuwBxGPVjd+2NjBjzDlZZ393ygZ/MU1lZRnXkpGogy0Pqj4OLqRTmg88+ioZoZMQYOoCPlfBdr8mVbvc5D2ZgO9dB0TIEk/bsVqHUOVhn1fMwxZ/QWj9SpEnmih9x9FKR2LlUJF3UGSilgdos6cVREh+BeBSNhqABw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723605157; c=relaxed/simple;
	bh=U/z5yJDz96cMBecny03CriMSgfVrROgaK4JCQOhQzg4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cPIqibD6jMyo87oS3liy0+4ZK4kpBWXnc2ZGQ2OjXXui9U6gZGp2HlRGtCD1igbv0WL1UH2f3U7fvQFzUTJ5fIf4lDfB1lT/73w0H8OXb3o98GmRWvkYrOIjpAAIKoeyZHGmZd9eXovK35MQr4LjjrmcuXfIZ3ulAUDyMUwW22c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WkCqf4hB6z20lV2;
	Wed, 14 Aug 2024 11:07:58 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 477321402CF;
	Wed, 14 Aug 2024 11:12:32 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 14 Aug
 2024 11:12:32 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-usb@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <justin.chen@broadcom.com>,
	<alcooperx@gmail.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<gregkh@linuxfoundation.org>
Subject: [PATCH -next] usb: bdc: fix module autoloading
Date: Wed, 14 Aug 2024 03:04:43 +0000
Message-ID: <20240814030443.3876203-1-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500020.china.huawei.com (7.185.36.49)

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
---
 drivers/usb/gadget/udc/bdc/bdc_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index 35a652807fca..5149e2b7f050 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -639,6 +639,7 @@ static const struct of_device_id bdc_of_match[] = {
 	{ .compatible = "brcm,bdc" },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, bdc_of_match);
 
 static struct platform_driver bdc_driver = {
 	.driver		= {
-- 
2.34.1


