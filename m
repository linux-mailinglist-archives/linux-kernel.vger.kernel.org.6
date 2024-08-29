Return-Path: <linux-kernel+bounces-306284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75712963CA1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A920F1C23D9E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4107516D306;
	Thu, 29 Aug 2024 07:21:04 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206201537D8
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724916063; cv=none; b=JKu8zoaMrQelLqeb50vs0x5sNAYh/y8xq/lyoxYTmVfQ7f6HAfaesgGcxntDzn0Pw1xI2ZEBRlAg2ZP3hwKL90g6R2r1F1xqPgWlMGV9pQslVY7+RlHpw4QIS50SRV2rgFtk7ikcjMX/4ysDWvFelT/neTVxb3HaOdGGB94K2uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724916063; c=relaxed/simple;
	bh=F6ixXcWm1B5CRF3PDXJ+Oi92nsM7xHKJShplgRVMaoI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qTAgEJS/oLEGKuWsN3D6sXVTN7M3m2Tz2HWjjHE1KUO5kMBwcsM2KoNfXhKncpspsBhkCVxm7SzjaJZsEaOOuEzSTMq76c2EY5w2NNzmeLy8oKgsSCTc9gZuOqMo9XLHpAqQD64Mj1BTLE5G7zJfDFebSY9bzEBbOwvhoGHXaRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WvXjZ0D3kz147Hx;
	Thu, 29 Aug 2024 15:20:02 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 571DF14035F;
	Thu, 29 Aug 2024 15:20:51 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 29 Aug
 2024 15:20:51 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: <kabel@kernel.org>, <liaochen4@huawei.com>
Subject: [PATCH -next] platform: cznic: turris-omnia-mcu: enable module autoloading
Date: Thu, 29 Aug 2024 07:12:35 +0000
Message-ID: <20240829071235.524082-1-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500020.china.huawei.com (7.185.36.49)

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
---
 drivers/platform/cznic/turris-omnia-mcu-base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/cznic/turris-omnia-mcu-base.c b/drivers/platform/cznic/turris-omnia-mcu-base.c
index 58f9afae2867..d6a84dce0fef 100644
--- a/drivers/platform/cznic/turris-omnia-mcu-base.c
+++ b/drivers/platform/cznic/turris-omnia-mcu-base.c
@@ -396,6 +396,7 @@ static const struct of_device_id of_omnia_mcu_match[] = {
 	{ .compatible = "cznic,turris-omnia-mcu" },
 	{}
 };
+MODULE_DEVICE_TABLE(of, of_omnia_mcu_match);
 
 static struct i2c_driver omnia_mcu_driver = {
 	.probe		= omnia_mcu_probe,
-- 
2.34.1


