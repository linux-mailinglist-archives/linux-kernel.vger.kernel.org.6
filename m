Return-Path: <linux-kernel+bounces-240439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A970926D99
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003C12823CE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 02:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6831CA84;
	Thu,  4 Jul 2024 02:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8nkjMxx"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7491B1C2BE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 02:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720061369; cv=none; b=QsKII6HxWO9Ch6QxWLPRssnPjYMJjYUoeAT2IXjmvfwdhZ/cn4BcR7qabf+RX35PKeHFvVTkp6DtnACjlxVVg/0FS9+/7v5STUuE6vqRV5vHb+j0naLhyPHg6qFvKQ6zxmoD3f9Nae5M5Gby5XrXcUM+lwe+qAuK4ouY+n/jwaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720061369; c=relaxed/simple;
	bh=Kkk9s4sV4Fl34MZU0ILX+Nx23bHRVA/aaklQ+GvytCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RFAdJWZKEjiLaPd7YVUdgbhFnKVJY6DfZLD1DwNpDnFCDl49gruxX12LOTXnkCovk6+r8+82wBGKi1VYhSCOGHtE3cPMVG0mVlcnfCM54NgSr8zUWJy4oabDE1vQ+rjlMzYUZ087++mLK5yr2iDBiE0OjZQDcnB3Q1juWMSoh/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8nkjMxx; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-70df213542bso81666a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 19:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720061368; x=1720666168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAfpWwRhq5J4/h2Gbmc5RAglmxrPuD2qlVHxEogwceo=;
        b=Y8nkjMxxG35VQhjZClPt0552hDmvg5Vqd/GBur/K4uUoW8tb1AHRkmsDnScXlrLCbA
         wwTmYMRP4aqsWiR8en36fbIhk3ZthQ4kmiKiikYua4rCuRiOiY/GK5Ekn1MAyw72Un76
         ReLtZWwQTOzrPLuUOjVLQJiu1R5ovooSi+SNn+92/jfj4D+McUgtUfn6w0bvFc4Gm0qa
         9kKAp5UemaRgRwvMm6I+cY4QPj5DUhIqShnXIJqmbZbgVg7S/7lvJYo+kYnGXFC43Q/E
         8FSw+HTroXWbpyNrGlObWc5CoMF5fvuZoUiy+92Lo++qeWL4EbdnuOq1bvR92u9DPvK2
         S6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720061368; x=1720666168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAfpWwRhq5J4/h2Gbmc5RAglmxrPuD2qlVHxEogwceo=;
        b=YFY5mxRNr/BgVTr7lzRIX12VBoVCVxpEckqvAgXgaAtXO+3n366zBxM1cQslVmpgR7
         qJJGoZBQJLohQQ/+J4BAgxyRCOmJbDoK223zow0hTwXB0aC73WtvfkzEM5yGT5SGKGDp
         CTg+MLzy4axvQRSIw7aYIMejqrVUoniLA7v0COVGX2wXTbHzGKcTY1ldranoCtX63V9O
         WUoNtKQ31Dn6B6m/kwet5N25m/JUhYjTpjTJ8WMzS477rhCSexLXm77tz1fhi/7ZKX3k
         r+uFek0KVXFxQvaGZjJ/7ZodEgjVZS0pVbU0MXmw4qISmH0xnKP7kn1aYky1xchEgp8h
         mqhw==
X-Forwarded-Encrypted: i=1; AJvYcCXgv7Loq47jewEjgWzQ9G3p6ECH0l1jA/UrNofgApeZBV4JHk6j5qgRgyRL8zXFrxDF/iNqUyXZL4R2LrqmB2GRCsXWjsRJV1YuaJHT
X-Gm-Message-State: AOJu0Yy4Dy/ApAPDrpWr6EbS2cHhQsvd1swnniiomObs+/A72XdHz6HZ
	s2pOFHsdC6s4JjdzJbUC0zoiPG9E6edA2EmidqaiULr89zP4KLML
X-Google-Smtp-Source: AGHT+IGRsrTFtYRo7lgWs47AcFAYlAptZJbVJGJcUMQntJmF8LEQXiSTkioAe0gDIfB4Qyx/v7rQ1Q==
X-Received: by 2002:a05:6a20:258f:b0:1be:f783:3d68 with SMTP id adf61e73a8af0-1c0cc75dca4mr260574637.30.1720061367655;
        Wed, 03 Jul 2024 19:49:27 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fad0662e77sm102554605ad.229.2024.07.03.19.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 19:49:27 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id CB24780152;
	Thu,  4 Jul 2024 10:51:32 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com
Cc: richard@nod.at,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v2 2/2] mtd: spinand: macronix: Add support for serial NAND flash
Date: Thu,  4 Jul 2024 10:48:39 +0800
Message-Id: <20240704024839.241101-3-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704024839.241101-1-linchengming884@gmail.com>
References: <20240704024839.241101-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

MX35{U,L}F{2,4}G24AD-Z4I8 are Macronix serial NAND flashes.

Their main difference from MX35{U,L}F{2,4}G24AD lies in
the plane number. The plane number for those with the
postfix Z4I8 is 1.

These flashes have been validated on Xilinx zynq-picozed
board which include Macronix SPI Host.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/nand/spi/macronix.c | 38 +++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index aaf610f5d4a1..3f9e9c572854 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -158,6 +158,15 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+	SPINAND_INFO("MX35LF2G24AD-Z4I8",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x64, 0x03),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
 	SPINAND_INFO("MX35LF4G24AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x35, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 2, 1, 1),
@@ -167,6 +176,15 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+	SPINAND_INFO("MX35LF4G24AD-Z4I8",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x75, 0x03),
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
 	SPINAND_INFO("MX31LF1GE4BC",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x1e),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
@@ -208,6 +226,16 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF4G24AD-Z4I8",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xf5, 0x03),
+		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
 	SPINAND_INFO("MX35UF4GE4AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xb7, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
@@ -238,6 +266,16 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     mx35lf1ge4ab_ecc_get_status)),
+	SPINAND_INFO("MX35UF2G24AD-Z4I8",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xe4, 0x03),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
+				     mx35lf1ge4ab_ecc_get_status)),
 	SPINAND_INFO("MX35UF2GE4AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa6, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
-- 
2.25.1


