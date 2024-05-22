Return-Path: <linux-kernel+bounces-185975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF308CBD96
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04795282389
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC0B80028;
	Wed, 22 May 2024 09:17:27 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2D4282E2
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716369446; cv=none; b=tBZ/RqOnrr/9rG7syKwH4SAQOhVT/uRF49MMyn5rNnS6xRxy4SCo/obZBBLpYSI8MnP9B+OPU/YR8U59bSdU+RKMtneNqOHrsX9T2nDyYE+wKYnP0m+s8xEDHzIR2vU1Xi8YNET9FlBt2VT5A/c2BVAVvg7Pg6nqpztFYDX0Zug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716369446; c=relaxed/simple;
	bh=a9rZwqydI1aQAaaRK5TAty9KhRdJBcpy2zVgXfiWn90=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AjzpGkJNlTLhez2UjwpD0ycvjnqieUQ8gTpnKLEVTewwwkg7cKb0YlDPMi+nqJFhi9OZdDHZEmpVjf6Z7b3ewDpb216MDwwWVX6mtJo3rzOj4zLYKvj2P4sTx64bvB+UWbLfu2c+XV7d9q+LgwuadGsIp0nnC2ABNUmuew54+T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vkm0V2ghZz4f3jkd
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 17:17:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2CAD51A017F
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 17:17:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxAeuE1mwmtsNQ--.57500S4;
	Wed, 22 May 2024 17:17:19 +0800 (CST)
From: linan666@huaweicloud.com
To: richard@nod.at,
	miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	chaitanya.kulkarni@wdc.com,
	axboe@kernel.dk
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	chengzhihao1@huawei.com,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v3] ubi: block: fix null-pointer-dereference in ubiblock_create()
Date: Thu, 23 May 2024 01:10:35 +0800
Message-Id: <20240522171035.3776026-1-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxAeuE1mwmtsNQ--.57500S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJr18uw48Gr4kWrW7Kr18uFg_yoW8ZFW3pa
	yvg3yYy3ykGFyqgF4DXa1kCFy5Xw18W34rGF47uw4SvryrJryIkrs0qry5JF4IyF97JanI
	qFn5GFW8C3WxC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY
	6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr
	0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0E
	wIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2
	x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7s
	REiiSDUUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

Similar to commit adbf4c4954e3 ("ubi: block: fix memleak in
ubiblock_create()"), 'dev->gd' is not assigned but dereferenced if
blk_mq_alloc_tag_set() fails, and leading to a null-pointer-dereference.
Fix it by using pr_err() and variable 'dev' to print error log.

Additionally, the log in the error handle path of idr_alloc() has
been improved by using pr_err(), too. Before initializing device
name, using dev_err() will print error log with 'null' instead of
the actual device name, like this:
  block (null): ...
        ~~~~~~
It is unclear. Using pr_err() can print more details of the device.
The improved log is:
  ubiblock0_0: ...

Fixes: 77567b25ab9f ("ubi: use blk_mq_alloc_disk and blk_cleanup_disk")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Li Nan <linan122@huawei.com>
---
v3: spliting this patch into two in v2 is not a good idea. This version
is consistent with v1, but only optimizes the commit message.

 drivers/mtd/ubi/block.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index f82e3423acb9..bf7308e8ec2f 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -390,7 +390,8 @@ int ubiblock_create(struct ubi_volume_info *vi)
 
 	ret = blk_mq_alloc_tag_set(&dev->tag_set);
 	if (ret) {
-		dev_err(disk_to_dev(dev->gd), "blk_mq_alloc_tag_set failed");
+		pr_err("ubiblock%d_%d: blk_mq_alloc_tag_set failed\n",
+			dev->ubi_num, dev->vol_id);
 		goto out_free_dev;
 	}
 
@@ -407,8 +408,8 @@ int ubiblock_create(struct ubi_volume_info *vi)
 	gd->minors = 1;
 	gd->first_minor = idr_alloc(&ubiblock_minor_idr, dev, 0, 0, GFP_KERNEL);
 	if (gd->first_minor < 0) {
-		dev_err(disk_to_dev(gd),
-			"block: dynamic minor allocation failed");
+		pr_err("ubiblock%d_%d: block: dynamic minor allocation failed\n",
+			dev->ubi_num, dev->vol_id);
 		ret = -ENODEV;
 		goto out_cleanup_disk;
 	}
-- 
2.39.2


