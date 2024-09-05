Return-Path: <linux-kernel+bounces-316384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF3096CECA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2AE288D07
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3376318991C;
	Thu,  5 Sep 2024 05:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mbvay8xy"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B12189522
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 05:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725515748; cv=none; b=MPOuxXAulvMoa0fFc+CPd3wV03ZJWhKxl773BwYx1jW3ih/8fYDSdQONHkinnuad9gBJffoJIoPtBtcp4CECmTQembvC+rqxg8tAoU9FxRLwonsJEy0G7KI4nzxshz0RSiw8URE/Le43YD7njSnyEZLuyRTbQJ0KrxuvBwcxUoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725515748; c=relaxed/simple;
	bh=AWYQUr3DCoiXJbOYByTNbeOkZCrDzPXNfCGw2wMAjbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lRZaO/i/h2d1AOe5/Zy8SbMVwVgrPuUBCFePnIL45zyp4X1JLp9PKiGXNdA/XdrteIV7o5+ktfxtqRHOqX81xAFp34oPFSRreFTMkL0TNh4NSZ0iI5NDEo8kGSzURwevRuOz5p7SvdrBR2GrPwzGAY3NBMxUr0ouV4jj1KKXbQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mbvay8xy; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-70f794cd240so206983a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 22:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725515745; x=1726120545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XH6YLbkS9yYOura/T7tK4lXbNY0uW3EvYxuH2OQdie8=;
        b=Mbvay8xyT1rR0Nt+2i+te/68TJHPlj65+eA7DdzN3gtwACK/GFbYfjusmPU2ep7rio
         VG3CeGAKbrEd+NSMqSVsJqFd8n+pUvruofy7PeQf95R2f69QVvXe4+EYHBgYtCXaL4y1
         jDzdNQ/mxBvLZmg+qIiSAhU96QvKPo3/3r5bElSQekXWiotHKAunjwyKwQSmBOhuUo0X
         0IfTbseq318FtP12yFCAkdkp7W3P4A8HSDkS0GptC5ZwruqdYmJFJfFQh9iGCdIzZ080
         TLiRcbhBpFttWiIlPuJxRv8sHOOjjovQAV89x8LSg5M/CCSblIY9ivDhYAHCPTrrcVIJ
         jSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725515745; x=1726120545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XH6YLbkS9yYOura/T7tK4lXbNY0uW3EvYxuH2OQdie8=;
        b=Y2egXKOvS5zsfw9Gcj7LWqsaCGJXOOpMagNayKs7mYxFngBfAA+Ae/D9YcY5psfh6f
         saI73lIptYdNb+LVhSovPYRq0Q4fQCpjIkAmk96YFmmKtTfrl9Z0XCfcrfNRI90ne01v
         Kensf5c33cekQJ4yOYHbaLIHu+VmjY4rwQwxw0PlcpLIoVmJXJaTPrZc0KTo075Xmskc
         HfkyHDlZOo2Wdqymuxad6BiiTHoFxUR+0NIlY91UBl2ajmGJscFbY06Xn6vc16WILgFE
         9bNEEfrpMu5gkKoCxKMXqMt1ylIM1Yk7ZyzViGdtivG5JE8wofSNHxT6p6eQSeGRhqx1
         7sDA==
X-Forwarded-Encrypted: i=1; AJvYcCV/aIfz3l5o/rNSt4fhfoK9ZaHvFz25D+71e9j1fCICqDGyNCEpk50aCmyKs0/k+iGN8gyGyW4ZcTOBPTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXtcV4nVU2KIwJTqjxGXNBjYEDI8fUDnEilSobjRaTb91W3ZDb
	BWc5Oq6KAZlp9NOUjhphK+O7aiE/d4nP7eOGtlS8CwEo/t0sUnzd
X-Google-Smtp-Source: AGHT+IHPNsq3i9MCEnlzMdi1Q56a2E5K6Aect9b4PFcZ6Bm1W37DmOaRxJkgaJT0SFQkRn2xSq+qow==
X-Received: by 2002:a05:6359:284:b0:1b8:1131:d116 with SMTP id e5c5f4694b2df-1b81131d349mr885094455d.21.1725515745468;
        Wed, 04 Sep 2024 22:55:45 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7177858922fsm2487508b3a.104.2024.09.04.22.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 22:55:44 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 32016801EE;
	Thu,  5 Sep 2024 14:04:09 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH 1/2] mtd: spi-nand: Add fixups for read retry
Date: Thu,  5 Sep 2024 13:53:32 +0800
Message-Id: <20240905055333.2363358-2-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240905055333.2363358-1-linchengming884@gmail.com>
References: <20240905055333.2363358-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

Add fixups for support read retry:
- Initialize the NAND device maximum retry mode.
- Set feature on Special Read for Data Recovery register.

The Special Read for Data Recovery operation is enabled by Set Feature
function.

There are 5 modes for the user to recover the lost data.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/nand/spi/macronix.c | 79 ++++++++++++++++++++++++++-------
 include/linux/mtd/spinand.h     | 17 +++++++
 2 files changed, 81 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 3f9e9c572854..baca67ff1cd6 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -9,6 +9,8 @@
 #include <linux/kernel.h>
 #include <linux/mtd/spinand.h>
 
+#define MACRONIX_NUM_READ_RETRY_MODES 6
+#define MACRONIX_FEATURE_ADDR_READ_RETRY 0x70
 #define SPINAND_MFR_MACRONIX		0xC2
 #define MACRONIX_ECCSR_MASK		0x0F
 
@@ -100,6 +102,38 @@ static int mx35lf1ge4ab_ecc_get_status(struct spinand_device *spinand,
 	return -EINVAL;
 }
 
+/**
+ * macronix_spinand_init_read_retry - Initialize read_retries
+ * @spinand: SPI NAND device
+ *
+ * Return: the number of read retry modes
+ */
+static int macronix_spinand_init_read_retry(struct spinand_device *spinand)
+{
+	return MACRONIX_NUM_READ_RETRY_MODES;
+}
+
+/**
+ * macronix_spinand_setup_read_retry - Set the retry mode
+ * @spinand: SPI NAND device
+ * @retry_mode: Specify which retry mode to set
+ *
+ * Return: 0 on success, -error otherwise
+ */
+static int macronix_spinand_setup_read_retry(struct spinand_device *spinand, u8 retry_mode)
+{
+	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(MACRONIX_FEATURE_ADDR_READ_RETRY,
+						      spinand->scratchbuf);
+
+	*spinand->scratchbuf = retry_mode;
+	return spi_mem_exec_op(spinand->spimem, &op);
+}
+
+static const struct spi_nand_fixups read_retry_fixups = {
+	.init_read_retry = macronix_spinand_init_read_retry,
+	.setup_read_retry = macronix_spinand_setup_read_retry,
+};
+
 static const struct spinand_info macronix_spinand_table[] = {
 	SPINAND_INFO("MX35LF1GE4AB",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x12),
@@ -129,7 +163,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     mx35lf1ge4ab_ecc_get_status),
+		     SPINAND_FIXUPS(&read_retry_fixups)),
 	SPINAND_INFO("MX35LF4GE4AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x37, 0x03),
 		     NAND_MEMORG(1, 4096, 128, 64, 2048, 40, 1, 1, 1),
@@ -139,7 +174,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     mx35lf1ge4ab_ecc_get_status),
+		     SPINAND_FIXUPS(&read_retry_fixups)),
 	SPINAND_INFO("MX35LF1G24AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x14, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
@@ -148,7 +184,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
-		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
+		     SPINAND_FIXUPS(&read_retry_fixups)),
 	SPINAND_INFO("MX35LF2G24AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x24, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
@@ -157,7 +194,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
-		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
+		     SPINAND_FIXUPS(&read_retry_fixups)),
 	SPINAND_INFO("MX35LF2G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x64, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
@@ -166,7 +204,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
-		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
+		     SPINAND_FIXUPS(&read_retry_fixups)),
 	SPINAND_INFO("MX35LF4G24AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x35, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 2, 1, 1),
@@ -175,7 +214,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
-		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
+		     SPINAND_FIXUPS(&read_retry_fixups)),
 	SPINAND_INFO("MX35LF4G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x75, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
@@ -184,7 +224,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
-		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
+		     SPINAND_FIXUPS(&read_retry_fixups)),
 	SPINAND_INFO("MX31LF1GE4BC",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x1e),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
@@ -225,7 +266,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     mx35lf1ge4ab_ecc_get_status),
+		     SPINAND_FIXUPS(&read_retry_fixups)),
 	SPINAND_INFO("MX35UF4G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xf5, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
@@ -235,7 +277,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     mx35lf1ge4ab_ecc_get_status),
+		     SPINAND_FIXUPS(&read_retry_fixups)),
 	SPINAND_INFO("MX35UF4GE4AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xb7, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
@@ -245,7 +288,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     mx35lf1ge4ab_ecc_get_status),
+		     SPINAND_FIXUPS(&read_retry_fixups)),
 	SPINAND_INFO("MX35UF2G14AC",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa0),
 		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 2, 1, 1),
@@ -265,7 +309,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     mx35lf1ge4ab_ecc_get_status),
+		     SPINAND_FIXUPS(&read_retry_fixups)),
 	SPINAND_INFO("MX35UF2G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xe4, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
@@ -275,7 +320,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     mx35lf1ge4ab_ecc_get_status),
+		     SPINAND_FIXUPS(&read_retry_fixups)),
 	SPINAND_INFO("MX35UF2GE4AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa6, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
@@ -285,7 +331,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     mx35lf1ge4ab_ecc_get_status),
+		     SPINAND_FIXUPS(&read_retry_fixups)),
 	SPINAND_INFO("MX35UF2GE4AC",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa2, 0x01),
 		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
@@ -315,7 +362,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     mx35lf1ge4ab_ecc_get_status),
+		     SPINAND_FIXUPS(&read_retry_fixups)),
 	SPINAND_INFO("MX35UF1GE4AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x96, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
@@ -325,7 +373,8 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     mx35lf1ge4ab_ecc_get_status)),
+				     mx35lf1ge4ab_ecc_get_status),
+		     SPINAND_FIXUPS(&read_retry_fixups)),
 	SPINAND_INFO("MX35UF1GE4AC",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x92, 0x01),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 5c19ead60499..e567d00a2805 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -354,6 +354,7 @@ struct spinand_info {
 	} op_variants;
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
+	const struct spi_nand_fixups *fixups;
 };
 
 #define SPINAND_ID(__method, ...)					\
@@ -379,6 +380,9 @@ struct spinand_info {
 #define SPINAND_SELECT_TARGET(__func)					\
 	.select_target = __func,
 
+#define SPINAND_FIXUPS(__func)					\
+	.fixups = __func,
+
 #define SPINAND_INFO(__model, __id, __memorg, __eccreq, __op_variants,	\
 		     __flags, ...)					\
 	{								\
@@ -398,6 +402,16 @@ struct spinand_dirmap {
 	struct spi_mem_dirmap_desc *rdesc_ecc;
 };
 
+/**
+ * struct spi_nand_fixups - SPI NAND fixup hooks
+ * @init_read_retry: initialize spinand->read_retries
+ * @setup_read_retry: set the retry mode
+ */
+struct spi_nand_fixups {
+	int (*init_read_retry)(struct spinand_device *spinand);
+	int (*setup_read_retry)(struct spinand_device *spinand, u8 retry_mode);
+};
+
 /**
  * struct spinand_device - SPI NAND device instance
  * @base: NAND device instance
@@ -423,6 +437,7 @@ struct spinand_dirmap {
  *		the stack
  * @manufacturer: SPI NAND manufacturer information
  * @priv: manufacturer private data
+ * @read_retries: the number of read retry modes supported
  */
 struct spinand_device {
 	struct nand_device base;
@@ -449,8 +464,10 @@ struct spinand_device {
 	u8 *databuf;
 	u8 *oobbuf;
 	u8 *scratchbuf;
+	const struct spinand_info *info;
 	const struct spinand_manufacturer *manufacturer;
 	void *priv;
+	int read_retries;
 };
 
 /**
-- 
2.25.1


