Return-Path: <linux-kernel+bounces-308240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC8E965923
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB42284369
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEB915B116;
	Fri, 30 Aug 2024 07:55:05 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211001531FC
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725004505; cv=none; b=hg5N0ZoODOY7PCytlTzsZk1AHe0lJp7IuYfN1icQR+MacX0PTf9gJnPs4lUENYDKueXskna/j+YWqFBQmM5BeU6t46QkbOL20Cms79ilfrLMdwSXCMQamgqC/uhxGXczmNdLbAebwuKFAUN4P02a1MuFo6kqOPfabsmn+k1nvOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725004505; c=relaxed/simple;
	bh=JxCPuRtixmLT6gi4Aw78MmLsimuRvoe1edzq+TSd/EI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LKb33o/QkD9iOqLBZ+T4Z+tEdVvhJ74r5qis9asjypC1o9LL1pECSc2uD8OC94KIo2vF6XdvU6bY59wk7bgdyVMUUTsdx4R1m/rg3olwiYLkPDTayVs4W/iUrdLVYuT1yD/iTKL14Rd0dN+zkg5wQBqHFmBB2Eg78Rj1P1s0/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ww9MZ5m0bz1HHmh;
	Fri, 30 Aug 2024 15:51:38 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id A2F931A0188;
	Fri, 30 Aug 2024 15:55:00 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 Aug
 2024 15:55:00 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC: <lihongbo22@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] misc: tsl2550: replace simple_strtoul to kstrtoul
Date: Fri, 30 Aug 2024 16:03:11 +0800
Message-ID: <20240830080311.3545307-1-lihongbo22@huawei.com>
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
 dggpeml500022.china.huawei.com (7.185.36.66)

The function simple_strtoul performs no error checking
in scenarios where the input value overflows the intended
output variable.

We can replace the use of the simple_strtoul with the safer
alternatives kstrtoul.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/misc/tsl2550.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/tsl2550.c b/drivers/misc/tsl2550.c
index 2ad4387c9837..1a7796ab3fad 100644
--- a/drivers/misc/tsl2550.c
+++ b/drivers/misc/tsl2550.c
@@ -185,10 +185,10 @@ static ssize_t tsl2550_store_power_state(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct tsl2550_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
 	int ret;
 
-	if (val > 1)
+	if (kstrtoul(buf, 10, &val) || val > 1)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
@@ -217,10 +217,10 @@ static ssize_t tsl2550_store_operating_mode(struct device *dev,
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct tsl2550_data *data = i2c_get_clientdata(client);
-	unsigned long val = simple_strtoul(buf, NULL, 10);
+	unsigned long val;
 	int ret;
 
-	if (val > 1)
+	if (kstrtoul(buf, 10, &val) || val > 1)
 		return -EINVAL;
 
 	if (data->power_state == 0)
-- 
2.34.1


