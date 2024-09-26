Return-Path: <linux-kernel+bounces-340256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E37D5987091
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1ACB2834A8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1861AB6D1;
	Thu, 26 Sep 2024 09:46:38 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A7A482EB
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343997; cv=none; b=cowlGBSHrlTCLxrpGf7dL3OKfQyamauMJvkGKGGBEJWi353rBP9Qcw5vcvTeoEAkpjRbUhSZPxbaMqtDKD/cIkoMvm+EkiwV4D9/8vlh5Ges6gwY3zlb4GyZ1m4/bcwq8cpLSTYUN9skPsJnXZz82WyFwH7bbkLCVdWvF6M8Odw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343997; c=relaxed/simple;
	bh=qst+tRrrtn4PCi5ytOiP0aJKdDNCwj0//5CGGMhUGbE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KvWSeTqnoJbscjTTeeMSiCPAhX0oi78/N0SQPCBd6G5truszSOFWlvUSptBJ/JzPmiB4m7iLoB7KZ9QdNFHPGQ2vyETvMChx8Z8kDU8gUdJUW5Qu7itRRJPVQmC1jvPt8uer2ztIREEwC0tp+WR7EQjGo10HQ9+cpjKPkqOhT78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from unicom145.biz-email.net
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id XKU00015;
        Thu, 26 Sep 2024 17:45:15 +0800
Received: from localhost.localdomain (10.94.6.214) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2507.39; Thu, 26 Sep 2024 17:45:14 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <Asmaa@mellanox.com>, <minyard@acm.org>, <vadimp@mellanox.com>
CC: <openipmi-developer@lists.sourceforge.net>,
	<linux-kernel@vger.kernel.org>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] ipmi: ipmb: Add check devm_kasprintf() returned value
Date: Thu, 26 Sep 2024 17:44:19 +0800
Message-ID: <20240926094419.25900-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20249261745154c75b75870e7b94b0946c571db19850f
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

devm_kasprintf() can return a NULL pointer on failure but this
returned value is not checked.

Fixes: 51bd6f291583 ("Add support for IPMB driver")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/char/ipmi/ipmb_dev_int.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
index 7296127181ec..8a14fd0291d8 100644
--- a/drivers/char/ipmi/ipmb_dev_int.c
+++ b/drivers/char/ipmi/ipmb_dev_int.c
@@ -321,6 +321,9 @@ static int ipmb_probe(struct i2c_client *client)
 	ipmb_dev->miscdev.name = devm_kasprintf(&client->dev, GFP_KERNEL,
 						"%s%d", "ipmb-",
 						client->adapter->nr);
+	if (!ipmb_dev->miscdev.name)
+		return -ENOMEM;
+
 	ipmb_dev->miscdev.fops = &ipmb_fops;
 	ipmb_dev->miscdev.parent = &client->dev;
 	ret = misc_register(&ipmb_dev->miscdev);
-- 
2.31.1


