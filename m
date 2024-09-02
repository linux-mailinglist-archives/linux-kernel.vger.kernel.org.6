Return-Path: <linux-kernel+bounces-311304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B801968758
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1101F20F47
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAA119E972;
	Mon,  2 Sep 2024 12:16:16 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E3A19E96A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725279376; cv=none; b=OfvjnwjKFGOG2B8y8K4+rujUdo9Hq+iBmi4JkeH5Xwb7cxoyyX/+PbjV4/KGoxZ5le4ZkM2wWrYK/l0TunDviUJ268Br4M56OF4qab6741UCtN8h2BknkOm5Ak2Rkwo25uOlY+lLZzx4w7Oem/3vTM8NTwC66F0k16r461Sg/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725279376; c=relaxed/simple;
	bh=8z9qtMCKkNSCXXShooC/0XezDXBMBd4UPbbBsBDih6g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h1xLgFzSB66SdnsANREETMJWsI4LswfvWSil+e460Y4jUOH/7CE2rbPGzIiHaemuPJbxbUZuz1j+WmiLyNEXm20CCbnBsagsQjLeYy1l7a1oMRJTlpBKtMSr1cVCXG9KGgTKibC2q2/3XvYjCiK1VLUaanaZsDfHv48tjd9xRsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wy71V44Rpz1HJ2L;
	Mon,  2 Sep 2024 20:12:46 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id E5B511402CC;
	Mon,  2 Sep 2024 20:16:11 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 2 Sep
 2024 20:16:11 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <jens.wiklander@linaro.org>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <lihongbo22@huawei.com>
Subject: [PATCH -next] rpmb: Remove usage of the deprecated ida_simple_xx() API
Date: Mon, 2 Sep 2024 20:24:35 +0800
Message-ID: <20240902122435.2716681-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)

The ida_alloc() and ida_free() should be preferred to the
deprecated ida_simple_get() and ida_simple_remove().

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 drivers/misc/rpmb-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
index c8888267c222..ce45ec968de1 100644
--- a/drivers/misc/rpmb-core.c
+++ b/drivers/misc/rpmb-core.c
@@ -64,7 +64,7 @@ static void rpmb_dev_release(struct device *dev)
 	struct rpmb_dev *rdev = to_rpmb_dev(dev);
 
 	mutex_lock(&rpmb_mutex);
-	ida_simple_remove(&rpmb_ida, rdev->id);
+	ida_free(&rpmb_ida, rdev->id);
 	mutex_unlock(&rpmb_mutex);
 	kfree(rdev->descr.dev_id);
 	kfree(rdev);
@@ -176,7 +176,7 @@ struct rpmb_dev *rpmb_dev_register(struct device *dev,
 	}
 
 	mutex_lock(&rpmb_mutex);
-	ret = ida_simple_get(&rpmb_ida, 0, 0, GFP_KERNEL);
+	ret = ida_alloc(&rpmb_ida, GFP_KERNEL);
 	mutex_unlock(&rpmb_mutex);
 	if (ret < 0)
 		goto err_free_dev_id;
@@ -196,7 +196,7 @@ struct rpmb_dev *rpmb_dev_register(struct device *dev,
 
 err_id_remove:
 	mutex_lock(&rpmb_mutex);
-	ida_simple_remove(&rpmb_ida, rdev->id);
+	ida_free(&rpmb_ida, rdev->id);
 	mutex_unlock(&rpmb_mutex);
 err_free_dev_id:
 	kfree(rdev->descr.dev_id);
-- 
2.34.1


