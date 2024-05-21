Return-Path: <linux-kernel+bounces-184871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBDD8CAD42
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5571C1F21F27
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A24878C7F;
	Tue, 21 May 2024 11:20:36 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8594678C67
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716290435; cv=none; b=Mv6fkKNdWEYRdV8HzAnOq/++Vpglx9tEDj05fwIFUgYvmgRzfVcq1PdoLkRlFqvk6e0MjOJCuRnPUMuf9RenA/3mYgXQQAcz8q9NsuUOMWKadERdCcv1f9nhV29pmc6dtHTakkkpaFQn3pQWiaL9ipkKmzUvHcxGX6TGc7ZXj7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716290435; c=relaxed/simple;
	bh=8lYHnsMFuEvO0YAar7Oo2oDy2DPlSdSaiTfcv4MAvko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CJxFCGrrgMgPPoXzqpi1LeWT345h/pM6ew61Ip2o3usopnM4wVqJGCcfiYlZnTO+G9pvScN9yCteo90a0BeNFUwWwNQp1Q9eBu4I6qe1HqtvRD9cz1oVMZPEQqhdc/LwpI79YXgpbCec0I0T/57zAM8BRTbss1zAIZE1YO+ixRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VkBn33Y30z4f3kpq
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 19:20:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 431E11A0E65
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 19:20:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBF6g0xmG_0XNQ--.40701S6;
	Tue, 21 May 2024 19:20:29 +0800 (CST)
From: linan666@huaweicloud.com
To: richard@nod.at,
	miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	axboe@kernel.dk,
	chaitanya.kulkarni@wdc.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	chengzhihao1@huawei.com,
	linan666@huaweicloud.com,
	yukuai3@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v2 2/2] ubi: block: improve error log before setting dev_name in ubiblock_create()
Date: Wed, 22 May 2024 03:13:47 +0800
Message-Id: <20240521191347.413578-3-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240521191347.413578-1-linan666@huaweicloud.com>
References: <20240521191347.413578-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBF6g0xmG_0XNQ--.40701S6
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyDKw48Ar4xJw4xGFWrGrg_yoW8Ar45pa
	yqgayYv3ykGFyqgan8X3WkCF1rX3W8tw45CFW2yw4FvryfXFySkFs0qrs8Xr4FyF97JanI
	qFnrWrW8AF18J37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_Jryl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
	z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082
	IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv
	7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4
	x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07xG64k0
	F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRueHDUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/

From: Li Nan <linan122@huawei.com>

dev_err() outputs dev_name using 'kobject_name(&dev->kobj)' to notify
users about the device encountering an error. However, before initializing
device name, it will print error message with 'null' instead of the actual
device name, like this:
  block (null): ...
        ~~~~~~

This log is not clear enough to provide the necessary context for
identifying the device. Therefore, in the error handling path of
blk_mq_alloc_tag_set() and idr_alloc(), where device name has not been
init yet, using pr_err() instead of dev_err() to print more details.
The improved error log is:
  ubiblock0_0: ...

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/mtd/ubi/block.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 3b61196d387b..bf7308e8ec2f 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -390,7 +390,8 @@ int ubiblock_create(struct ubi_volume_info *vi)
 
 	ret = blk_mq_alloc_tag_set(&dev->tag_set);
 	if (ret) {
-		dev_err(disk_to_dev(gd), "blk_mq_alloc_tag_set failed");
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


