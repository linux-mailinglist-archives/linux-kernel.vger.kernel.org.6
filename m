Return-Path: <linux-kernel+bounces-541963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E591A4C3E4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC2C3A53FC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22472139DC;
	Mon,  3 Mar 2025 14:53:06 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F0F20F07D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741013586; cv=none; b=Vb8Qd1iwsmfMF0Dmk9Qka3Fa9W6qadm/rg9ovuoJBtBeF9SdIEcnJxyXOV8h8xmSKMdLHQD4jUpkdIX+ZOptUEJjRNGOmVBZTF2EoE8GYAwwvtwQvNwDVBByw78ngc19BBmKTBgxr8Fq2oq9f40udUPt6D8B1nvAO15nF86uRiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741013586; c=relaxed/simple;
	bh=8+DxQIirlP9wZUmGmGZnr1teLjfbQWMQ9s8e3+1PQg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kCAcOfVUl2kBkIx0zz7Cw6kYVJQbwKtHR332mZ00twyxCkc13mfdY2KLI+5zPH8BBSrJKKt+RylaWxLo4xalJYQqY+XO5Q8xlbZJqjQ6bChKt9515wLX3aAkGhOl2i48DK4TR66G/L1V0Hc9j/vTiaf/cWc3SE295iD9YKiGDrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowAAHNPs4wsVn3GcUEg--.8516S2;
	Mon, 03 Mar 2025 22:52:41 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] mtd: Fix error handling in mtd_device_parse_register() error path
Date: Mon,  3 Mar 2025 22:52:23 +0800
Message-ID: <20250303145223.1748-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAHNPs4wsVn3GcUEg--.8516S2
X-Coremail-Antispam: 1UD129KBjvJXoW7XFy8ArWUJFyDZF4kJw1fWFg_yoW8Jr1Upw
	45Wayqk3yUKr4j9w4DZrWDCFy5K3s7tw1ruFZrG342grn5t345tFZ8tF1UAw1UKry8Gayj
	qrWSqr4kGa18AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUcBMtUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBg0KA2fFsHQ0fgAAsu

Check and log del_mtd_device() failures. Print an error message
with pr_err() to prevent silent failures, but preserve the original
error code instead of propagating the secondary error since
del_mtd_device() is already in an error handling path.

Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/mtd/mtdcore.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 724f917f91ba..a7b01ed37f42 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1053,7 +1053,7 @@ int mtd_device_parse_register(struct mtd_info *mtd, const char * const *types,
 			      const struct mtd_partition *parts,
 			      int nr_parts)
 {
-	int ret;
+	int ret, err;
 
 	mtd_set_dev_defaults(mtd);
 
@@ -1105,8 +1105,11 @@ int mtd_device_parse_register(struct mtd_info *mtd, const char * const *types,
 		nvmem_unregister(mtd->otp_factory_nvmem);
 	}
 
-	if (ret && device_is_registered(&mtd->dev))
-		del_mtd_device(mtd);
+	if (ret && device_is_registered(&mtd->dev)) {
+		err = del_mtd_device(mtd);
+		if (err)
+			pr_err("Error when deleting MTD device (%d)\n", err);
+	}
 
 	return ret;
 }
-- 
2.42.0.windows.2


