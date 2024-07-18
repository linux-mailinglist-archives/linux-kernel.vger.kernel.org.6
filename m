Return-Path: <linux-kernel+bounces-256124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AC9934968
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD8E1F22BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0940C78C9E;
	Thu, 18 Jul 2024 07:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KabJ76vd"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED8574058
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721289315; cv=none; b=HpPeFfCSBHNyLG19ZRIlh6BOjgmyVMc69nznhK6JaAoPx7M9K1Poo7uRjYbx3UQT7PWhIgkd9DZINkrUgWm7hsiZNoEwD21aatQDQx+DQJuYqN0yhDMOz5Kq8NniTzoTgK/8j6PftWv954c+xlwwj6hUXtPJuIeN+5Z77nZr/q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721289315; c=relaxed/simple;
	bh=btcXB6xhtmtaSEPtHfK6I62Am+MN8WgwfAUxgt5rHbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hoMBhwHM6V5RVe9jeVgQMSJ3MPuigPGJbWyGw/FVAtQzcOXuGcRRIQEl2KMncdl0lDvY1sqFZCy2vDuMXBS6WKebXtPcnDAb/mpXnOlQzUpO/WF43/inaz99MAFyUZCQtHZ/OkP6QddO5XLq3Kmrdb3ATEg08/gj7FbaAHtuI+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KabJ76vd; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-70df2135426so302372a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 00:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721289313; x=1721894113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zGrCg8VhTmLD0aLX+w4E73uJbqDmnmbt+ImN796bnI=;
        b=KabJ76vdv95PS406lQAF6iqokw8jEDk3Y3v3vwo+9inMROKTRZWbBWXz5xIoZbJLVc
         nA+YCvWzS/LmmPL4fVARhyDTozy9FfjAZCtN2sN6lf8ZpyXHTB1IvE2swIjB7gMKdc3A
         IsDVSL+Gpn7pPOXN4aGHHy1CeDCQSwx3HniskAp4t9YtIiYDvUW576xBH74vpAL6Yk3O
         eIm1h7TUpSoK8lcRP+z7dJ61IQ1r3n7lmvdlyHb8fix427eO20LwsCG7rMWAWPTppUir
         4LWqrDb6JeSfIScM8Qs9boiNftplbC+ZNTcKSqhgncaoGHz1DE9NzzYFqNLVRVzSCiKE
         q4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721289313; x=1721894113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zGrCg8VhTmLD0aLX+w4E73uJbqDmnmbt+ImN796bnI=;
        b=KR4hPhPlCqWO26GhJOy4ELrm5Ei+cvymm2t5VxMwztDIyabCvwTcbayaSB9emEFbvZ
         Vf5qFA/S9dErWRMvSg08+oPRLo2V4o17j3Lj0R4SWiJmuY6ZUCgw3v7MNCYo5JQklaaP
         +huJAmmUQEThdoMwlLWQqcFzmP6IhhEftSgkseG13R298DyjsAmz5fVFkAAQcVT9zh9a
         FvjFXns0Xh6o9nEHVNWdT0VVkOt75a+SsW3Rljr9m4AgIJWTALWkAhlWMbBG5g9OdmR6
         SNUTtAxfca7JDOEE+YTQf/eZbkm6vTN/byQQq4aSJENq/zZtlgySnr3P5seudjEprW6c
         zUwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyokdNcYSOCJ7zW6uOS0t164zCiTW0izNBq3yoD8/8/j3MQbciJvfFrbMjJkY9Dg9rbRTWQMdvf2239azMoTeYI9m1xopr0TrufUTO
X-Gm-Message-State: AOJu0Yw+3QkKpd34/gT2DmAVf7K/Afg9if+Uli6lEj/Feyy+TdEUcFCu
	i2meKg1mpX5BppXSex73hxASmQmTBFoLP2vaRJJz7W+DBAnBWJXk
X-Google-Smtp-Source: AGHT+IGKgiWigJXzomZvECnUkql5Cf8v2ttJLEsNwindBn7ewU9Bi5f1BD8oLj7r0N9Dmc1mxbR5Ig==
X-Received: by 2002:a05:6a20:841c:b0:1be:d5e9:b444 with SMTP id adf61e73a8af0-1c3fdb0b9d2mr5070964637.0.1721289312888;
        Thu, 18 Jul 2024 00:55:12 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc392a7sm86526905ad.230.2024.07.18.00.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 00:55:12 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id F2151805EF;
	Thu, 18 Jul 2024 16:04:23 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v2 2/2] mtd: spinand: macronix: Fixups for Plane Select bit
Date: Thu, 18 Jul 2024 15:53:56 +0800
Message-Id: <20240718075356.488253-3-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240718075356.488253-1-linchengming884@gmail.com>
References: <20240718075356.488253-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

Macronix serial NAND flash with a two-plane structure
requires insertion of Plane Select bit into the column
address during the write_to_cache operation.

Additionally, for MX35{U,F}2G14AC, insertion of Plane
Select bit into the column address is required during
the read_from_cache operation.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/nand/spi/macronix.c | 66 ++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 3f9e9c572854..eda67091edc0 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -100,6 +100,54 @@ static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
 	return -EINVAL;
 }
 
+/**
+ * write_plane_select_bit_in_cadd - Write Plane Select bit to the column address
+ * @spinand: SPI NAND device
+ * @req: NAND I/O request object
+ * @column: the column address
+ *
+ * Macronix serial NAND flash with a two-plane structure
+ * should insert Plane Select bit into the column address
+ * during the write_to_cache operation.
+ *
+ * Return: the column address after insertion of Plane Select bit
+ */
+static unsigned int write_plane_select_bit_in_cadd(struct spinand_device *spinand,
+			const struct nand_page_io_req *req, unsigned int column)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+
+	return column | (req->pos.plane << fls(nanddev_page_size(nand)));
+}
+
+/**
+ * read_plane_select_bit_in_cadd - Write Plane Select bit to the column address
+ * @spinand: SPI NAND device
+ * @req: NAND I/O request object
+ * @column: the column address
+ *
+ * MX35{U,F}2G14AC also need to insert Plane Select bit
+ * into the column address during the read_from_cache operation.
+ *
+ * Return: the column address after insertion of Plane Select bit
+ */
+static u16 read_plane_select_bit_in_cadd(struct spinand_device *spinand,
+			const struct nand_page_io_req *req, u16 column)
+{
+	struct nand_device *nand = spinand_to_nand(spinand);
+
+	return column | (req->pos.plane << fls(nanddev_page_size(nand)));
+}
+
+static const struct spi_nand_fixups write_fixups = {
+	.write_to_cache = write_plane_select_bit_in_cadd,
+};
+
+static const struct spi_nand_fixups read_and_write_fixups = {
+	.write_to_cache = write_plane_select_bit_in_cadd,
+	.read_from_cache = read_plane_select_bit_in_cadd,
+};
+
 static const struct spinand_info macronix_spinand_table[] = {
 	SPINAND_INFO("MX35LF1GE4AB",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x12),
@@ -157,7 +205,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
-		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
+			 SPINAND_PLANE_SELECT_BIT(&write_fixups)),
 	SPINAND_INFO("MX35LF2G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x64, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
@@ -175,7 +224,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
-		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
+			 SPINAND_PLANE_SELECT_BIT(&write_fixups)),
 	SPINAND_INFO("MX35LF4G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x75, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
@@ -215,7 +265,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     mx35lf1ge4ab_ecc_get_status),
+			 SPINAND_PLANE_SELECT_BIT(&read_and_write_fixups)),
 	SPINAND_INFO("MX35UF4G24AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xb5, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 2, 1, 1),
@@ -225,7 +276,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     mx35lf1ge4ab_ecc_get_status),
+			 SPINAND_PLANE_SELECT_BIT(&write_fixups)),
 	SPINAND_INFO("MX35UF4G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xf5, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
@@ -255,7 +307,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     mx35lf1ge4ab_ecc_get_status),
+			 SPINAND_PLANE_SELECT_BIT(&read_and_write_fixups)),
 	SPINAND_INFO("MX35UF2G24AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa4, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
@@ -265,7 +318,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     mx35lf1ge4ab_ecc_get_status),
+			 SPINAND_PLANE_SELECT_BIT(&write_fixups)),
 	SPINAND_INFO("MX35UF2G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xe4, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
-- 
2.25.1


