Return-Path: <linux-kernel+bounces-248839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A18C92E28D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DB31F23F1A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5458152E13;
	Thu, 11 Jul 2024 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGJoH+0+"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB501514E0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720687031; cv=none; b=Y0y7Wu2OKvsoBFNIhxrlSSO1ZMF4jpXfG5UwwmSOyZrAvwThM27mvJNyJMVXXmC+ovAubtiIi8p8Ct2grlzODprjjGkWSVM9fFmYLXQ2O1dEgEjbrwXwWVUGSqt4p7SRX/RXk79eo0un1TzOeM4kpLLCx293SKp4emJcIkK7jZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720687031; c=relaxed/simple;
	bh=eRTxtAd+aiBxKhHy1Ms0fpAkVKz89XTsYBJnSiH/vNE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tBD9p+UQTVwo2DiEYI+TXw8/C6hIPPHWol3RsCAo08Dlgzv3zFjThM4IXk7y+/c51XPhvG733WwlzN0BvYrdY9e1+9V1EzsKtvcJ1vsbM8nc5P34Js8YKNmkjy1RFNT+oyMYU+xsMk4G1PU4Rora3GxgX4bmNjdUGC7Fb9w7+QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGJoH+0+; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70b0013cf33so590709b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720687029; x=1721291829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=atTBjk9wptxxVtf7Y3tfuR/uu7YgNKVETKoQtx0qD6Y=;
        b=SGJoH+0+ZY2QD6cm6zXev81p7oML/r0l8OdsYhns+LVIEKnKvhthk/Auy0JMm2ukoU
         AvhG5Hqa2h+7uPxgFJJ7ytnFA3HPEf8/ZtPR2GZV3MOwHjTyNlBUiA8nDxpDvISsnYjO
         JqYfhfdcNNpxJuZuKh62o/7oYDLr/PwarsfHtVJMZCnVxZTDeKodYa9SrKqSsSuWBYPJ
         jV9Svfr/EpiG3UKYE2gndigZTeq7vFwBpwyGgsByig6plhIcZZ+vMxzoc/cBNobUL1aa
         AePgsXEnBw92x2OoBuIMsqYCx4xjKCV2FcB2lqly50cToqwU2zlrO8Usw8aPQ8hJUSXB
         KZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720687029; x=1721291829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=atTBjk9wptxxVtf7Y3tfuR/uu7YgNKVETKoQtx0qD6Y=;
        b=POtMv2PC4n+jfxrybMRYc2YI+NnJ/ryJfVYuIPxyBKPGEhzdxl45EUgYQiHdV4JPqC
         concZUb3dN/zfxUVDUaVscIjUUTMFDw9T0l/anUB8RhlkcnHyV3fwh77uklx+/o+Lbvw
         vysrh07+rttEzbNcZWtHE3r9pnsNgLz3j3XL1Ig+WxcUJR69SIYW5IFaT8zDBq0Oj3yN
         5V9rCFEobHWPWFmaG2EyBK0YwpTChaSqBW8LhbdGeCshiPqGreAoX5723nYjEE+XpBKc
         B1IBG6kJt92CgeA8WEQqyiH4kAZDP9Ue1pJ4PgmfyPsECkQ9gzfgRX8QjeAc2P61zocM
         nVJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXehV8LoC5HibAyTJdGrnBvgCBc4r5/MFQAJJq36HAGxZfTTc9udiEWx3l8gHAnC9vuZdCHZ1sQagi/8oVKD659UIZenmFPeOzWt+9S
X-Gm-Message-State: AOJu0Yz385LXuZxF3nsiaKFCzQJTizMiYsEs4Rs4dCMIPCynVi4b04XY
	tycsllf6VSPgXtcJLvMHjkSnOJq+TuaN2xK+K0HlY1h/x/GXhfj3
X-Google-Smtp-Source: AGHT+IFigDR87HJX5Kkn2JMv3ufTLyQ4WVF4QUdRKgricWGF9fAUSAIYjx5H538G8KVh9siAZ6puwg==
X-Received: by 2002:a05:6a20:729a:b0:1c0:f323:1bd8 with SMTP id adf61e73a8af0-1c29820667cmr8967595637.7.1720687028971;
        Thu, 11 Jul 2024 01:37:08 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ad3837sm45535835ad.300.2024.07.11.01.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 01:37:08 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 913E3805EE;
	Thu, 11 Jul 2024 16:46:31 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] mtd: spinand: macronix: Fixed warning: Function paramteter or member not described
Date: Thu, 11 Jul 2024 16:36:11 +0800
Message-Id: <20240711083611.364431-1-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

Fixed the warnings: Function paramteter or member 'xxx' not described

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407110520.pbPnrOlM-lkp@intel.com/
Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/nand/spi/macronix.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index c61f1ba31f0c..ea956933e8a1 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -101,12 +101,16 @@ static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
 }
 
 /**
+ * write_Plane_Select_bit_in_cadd - Write Plane Select bit to the column address
+ * @spinand: SPI NAND device
+ * @req: NAND I/O request object
+ * @column: the column address
+ *
  * Macronix serial NAND flash with a two-plane structure
- * should insert Plane Select bit to the column address
+ * should insert Plane Select bit into the column address
  * during the write_to_cache operation.
- * Additionally, MX35{U,F}2G14AC also need to insert Plane
- * Select bit to the column address during the read_from_cache
- * operation.
+ *
+ * Return: the column address after insertion of Plane Select bit
  */
 static unsigned int write_Plane_Select_bit_in_cadd(struct spinand_device *spinand,
 			const struct nand_page_io_req *req, unsigned int column)
@@ -116,6 +120,17 @@ static unsigned int write_Plane_Select_bit_in_cadd(struct spinand_device *spinan
 	return column | (req->pos.plane << fls(nanddev_page_size(nand)));
 }
 
+/**
+ * read_Plane_Select_bit_in_cadd - Write Plane Select bit to the column address
+ * @spinand: SPI NAND device
+ * @req: NAND I/O request object
+ * @column: the column address
+ *
+ * MX35{U,F}2G14AC also need to insert Plane Select bit
+ * into the column address during the read_from_cache operation.
+ *
+ * Return: the column address after insertion of Plane Select bit
+ */
 static u16 read_Plane_Select_bit_in_cadd(struct spinand_device *spinand,
 			const struct nand_page_io_req *req, u16 column)
 {

base-commit: 6000ef48e571f49a636b0c51494c1326ff9b7736
prerequisite-patch-id: 5cea93c94f6237a2f8f51397ba76187952ef45b2
-- 
2.25.1


