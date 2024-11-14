Return-Path: <linux-kernel+bounces-408594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1959C80DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2254B23F6E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC4E1E766E;
	Thu, 14 Nov 2024 02:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMz5MEpV"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF212F5A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731551787; cv=none; b=bWCJO8cNNbgUDq0yeoC6c/Q0Ld7sGML3MN5Uwf/meG0hg/rFvHKXx0ximzqIN1OykUTKQTyLBuBebYs8GLgdg5iz9TXY581GUYjtjfXHwnZ6EHt7MsEWSb7vI63pfUNsl1pkppOztXXKif6VgB59rPRiNBpHcnYcclNqJ5wL1tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731551787; c=relaxed/simple;
	bh=ik+zy0Kok1tHZog4WqeJ7AjDa4p2b1N0Mnse/n+Lbok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jcTrLA/oeaNrMbTikeIfSrij5KvrNfWCC+SmbadV3QfEWShdx5ZcKQygrAf8nxqppe9GkBtCSYq2bJT0Tny9TZc72UqQDQWOMculhmOlC/D4Fi6ZOOwnJb3gV1Zh8XvqOHXojEVCE0ayVlossPt5tnmXB3LQ+tbAkk54xc5LxTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMz5MEpV; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2d1858cdfso129732a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731551785; x=1732156585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZUHHT1NQG5Uvqfb4hSdJ+6FPn6N2m9pG+Uu3VTVYDw=;
        b=XMz5MEpVJuXJdV7RO7OIP/C5LnnrOJG67I5dZIR/wqjkuWLWL/1Olk0gebgiFjXDke
         rOtyRGgQzrqRCMs5A+I4lnHMNpd0yw9CnSsv4arJ6cIDyvIroPbKijxGcJ268OvR3JCm
         +mO7Z9mpj0pIhujFMu4p4YEEGywZZLq8Q5Nhax06y8OZ5KZYBzrsNZ0qlEkRWORLiE9V
         4dTb82PEm9k7f6rfQkfDZRUr5fcjAHhSeHYZTAp8W6wBXRuJp5126vCltiqwRug3VWSc
         Ww2oGhRZpGzuxZJkvvcg4K+BIzcY16NI0F2ph0e5jbeR42aUOI2HJvWpUfuWuJafAe3Y
         2xaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731551785; x=1732156585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZUHHT1NQG5Uvqfb4hSdJ+6FPn6N2m9pG+Uu3VTVYDw=;
        b=UDmekpt8/KnerYOAfj4J0EO3rBIZjYM/ycnppWW29oJiGsnFwUXM9aZ1jSAwixbzQf
         rXRDEy7y14qOy55oSoMLf2miw7FfRektaMUbQjWLAEEToffK1HGTSo5dtXSqUEqfG9XL
         Y59XiLR4RraiElWYFEuXnUrwXOnNIjCnRxm4ZPz4olWQ/PPw+Ugj3LF2ejNW0cJngxeB
         uGwC7gYYdSTQiWdahVIWwgk0yiPuWjSsqfwnEX1ZvRBVSn5KG20z2xsVgLkx4Rh1N+Bu
         MKLZXvdTtIBqJxJlPLmz2G/FuMIKKFKhMAQ3ay2GNWjMZkPOpgyEY97ZfbkTBtQeZP+S
         1/Nw==
X-Forwarded-Encrypted: i=1; AJvYcCW2yEMGl20OLGlrsY7cTc02KV3tvBhu4fau1rkuLYVZAU3vWCKwmHTX0JHOPgPy74xR8zsFLma96GoAIxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Ehm10oCf6PM/nDrzy9OOvNhlUh2e6oIfZzkt1+K0TyBT9AeZ
	qF8CYnQeTB4GeucpOEsT6yScGYRrOpojTys5aAo4J3aGXo9xzVpS
X-Google-Smtp-Source: AGHT+IFmomoWIK1E10LxkjPxLyAB+RT+I8tMD2yDFYg8SKFZADuzQIR0Sozc6K79hkkKRWRlU74dUg==
X-Received: by 2002:a17:90b:3146:b0:2e2:ad29:11a4 with SMTP id 98e67ed59e1d1-2e9b177fd40mr30185844a91.25.1731551784397;
        Wed, 13 Nov 2024 18:36:24 -0800 (PST)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7c565ccsm532985ad.90.2024.11.13.18.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 18:36:23 -0800 (PST)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 83E428083B;
	Thu, 14 Nov 2024 10:42:49 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v2 1/2] mtd: spi-nand: Add read retry support
Date: Thu, 14 Nov 2024 10:35:27 +0800
Message-Id: <20241114023528.181583-2-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241114023528.181583-1-linchengming884@gmail.com>
References: <20241114023528.181583-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

When the host ECC fails to correct the data error of NAND device,
there's a special read for data recovery method which host setups
for the next read retry mode and may recover the lost data by host
ECC again.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/nand/spi/core.c | 35 +++++++++++++++++++++++++++++++++--
 include/linux/mtd/spinand.h | 14 ++++++++++++++
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 4d76f9f71a0e..bd5339a308aa 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -672,10 +672,14 @@ static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	struct nand_io_iter iter;
+	struct mtd_ecc_stats old_stats;
 	bool disable_ecc = false;
 	bool ecc_failed = false;
+	unsigned int retry_mode = 0;
 	int ret;
 
+	old_stats = mtd->ecc_stats;
+
 	if (ops->mode == MTD_OPS_RAW || !mtd->ooblayout)
 		disable_ecc = true;
 
@@ -687,18 +691,43 @@ static int spinand_mtd_regular_page_read(struct mtd_info *mtd, loff_t from,
 		if (ret)
 			break;
 
+read_retry:
 		ret = spinand_read_page(spinand, &iter.req);
 		if (ret < 0 && ret != -EBADMSG)
 			break;
 
-		if (ret == -EBADMSG)
+		if (ret == -EBADMSG && spinand->set_read_retry) {
+			if (spinand->read_retries && (++retry_mode < spinand->read_retries)) {
+				ret = spinand->set_read_retry(spinand, retry_mode);
+				if (ret < 0) {
+					ecc_failed = true;
+					break;
+				}
+
+				/* Reset ecc_stats; retry */
+				mtd->ecc_stats = old_stats;
+				goto read_retry;
+			} else {
+				/* No more retry modes; real failure */
+				ecc_failed = true;
+			}
+		} else if (ret == -EBADMSG) {
 			ecc_failed = true;
-		else
+		} else {
 			*max_bitflips = max_t(unsigned int, *max_bitflips, ret);
+		}
 
 		ret = 0;
 		ops->retlen += iter.req.datalen;
 		ops->oobretlen += iter.req.ooblen;
+
+		/* Reset to retry mode 0 */
+		if (retry_mode) {
+			retry_mode = 0;
+			ret = spinand->set_read_retry(spinand, retry_mode);
+			if (ret < 0)
+				break;
+		}
 	}
 
 	if (ecc_failed && !ret)
@@ -1268,6 +1297,8 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
 		spinand->set_cont_read = table[i].set_cont_read;
+		spinand->read_retries = table[i].read_retries;
+		spinand->set_read_retry = table[i].set_read_retry;
 
 		op = spinand_select_op_variant(spinand,
 					       info->op_variants.read_cache);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 702e5fb13dae..bbfef90135f5 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -339,6 +339,8 @@ struct spinand_ondie_ecc_conf {
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
  * @set_cont_read: enable/disable continuous cached reads
+ * @read_retries: the number of read retry modes supported
+ * @set_read_retry: enable/disable read retry for data recovery
  *
  * Each SPI NAND manufacturer driver should have a spinand_info table
  * describing all the chips supported by the driver.
@@ -359,6 +361,9 @@ struct spinand_info {
 			     unsigned int target);
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
+	unsigned int read_retries;
+	int (*set_read_retry)(struct spinand_device *spinand,
+			     unsigned int read_retry);
 };
 
 #define SPINAND_ID(__method, ...)					\
@@ -387,6 +392,10 @@ struct spinand_info {
 #define SPINAND_CONT_READ(__set_cont_read)				\
 	.set_cont_read = __set_cont_read,
 
+#define SPINAND_READ_RETRY(__read_retries, __set_read_retry)		\
+	.read_retries = __read_retries,				\
+	.set_read_retry = __set_read_retry,
+
 #define SPINAND_INFO(__model, __id, __memorg, __eccreq, __op_variants,	\
 		     __flags, ...)					\
 	{								\
@@ -436,6 +445,8 @@ struct spinand_dirmap {
  *		A per-transfer check must of course be done to ensure it is
  *		actually relevant to enable this feature.
  * @set_cont_read: Enable/disable the continuous read feature
+ * @read_retries: the number of read retry modes supported
+ * @set_read_retry: Enable/disable the read retry feature
  * @priv: manufacturer private data
  */
 struct spinand_device {
@@ -469,6 +480,9 @@ struct spinand_device {
 	bool cont_read_possible;
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
+	unsigned int read_retries;
+	int (*set_read_retry)(struct spinand_device *spinand,
+			     unsigned int retry_mode);
 };
 
 /**
-- 
2.25.1


