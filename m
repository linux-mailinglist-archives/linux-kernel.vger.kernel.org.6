Return-Path: <linux-kernel+bounces-525484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CADA3F08A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17504189CE5A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E302046A6;
	Fri, 21 Feb 2025 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLR8cSVc"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AE2204099
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130664; cv=none; b=eONP3krGDkz37X7OEW1mbb300tMl4EwQoSFwlEQXXUDP3coMj8NFjCbbmupv6Kd3PNMzL0+A7fFGYHC7so6fKwXktaJ5JK7gesU6oOorSKzig4oxjh8wE4TAdF5ftoP9iCTDzwBoi/80ONLgCqvY89k3ISUzqQ4aeKeEmMCCIG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130664; c=relaxed/simple;
	bh=3KDAHGo41KC9nS5UOQ2rc+N3/qw4xgauGRWgYb/mxCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hp0jTcdUp7j3uokzVS3pNMsF70kpkRPwUmfTz6Z1tyHWOuFCr5ZovHL5nE63JDncGGg+qY2WREqQVKk9f+DRcy/yhp5pQ+yVjhJjMaLZjeENrMTYDQNZ7Qg64NfOV5dGesmzWCWC5RbuJ8zPOUjDzXgzOEmKbKqxGZjkDt4b1aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLR8cSVc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220bff984a0so36151095ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740130662; x=1740735462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZypDoIb3PvUtYaTIKYKko9b5RY6swPXf9N3dy7NqeI=;
        b=iLR8cSVcKk0EX0jrkyMgAd9r0LolSCW939hMBJK+G+sVGb9zhqWvKIj8mU+SCU5iRT
         0uWxU58McVLvjBKezot2HbeJWBFZ05qIcSELMMUkWUUGCMPt090/q8M2wwwQ6AJRZqJ7
         jT3HqDX+lxf2tupE0S5ppvKPVD0iwWbnTFkPQq0wYJqcq1C5v1rzP+JNvHQaMfZQLeg0
         P0KXMo6SfXW5Ihp0XdUAHLcGUBFk12Ma8BH0KbnHg0Fk2WXYvmCIZBa6CwUk3Zt2f0Ua
         MBMT8oGY7V5ocJUsxaOU7Ki4wLTeWEwPYtbOutcYdcfJ4RLaIe1p5jyfR1zryMufWU4W
         Cczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130662; x=1740735462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZypDoIb3PvUtYaTIKYKko9b5RY6swPXf9N3dy7NqeI=;
        b=ELTTJ7FEeMRhXqG6uBfHnzkNf5FF+4fPfmR4mXm89uwxHH6TJaSJt8tR1S3Wg58tO7
         l+JIjTv4J2a+oC4CKF8nd+Vfk0LNYoWPCA37iXCaLMRmUhdLCGGhst9dEJTFaJgUPBD2
         Q5nulYqRM36J53orrsjreTztCFyImiMIEfe9jTxX70aokGAjxG509SumAhVaayFuVIJR
         AxKYqIdRuPDksZNMgLS0rB6KmFd63lm7yC4Rif+ePv5fRPCYsBbOx6xt/m/L6I8oVy46
         7jj6Tge8gMtOJR2STSin0LWNsqOzPGQbTx5qCZbuwORAvJeTROXG9R48wHGdJ/aaU3kC
         7GCg==
X-Forwarded-Encrypted: i=1; AJvYcCX5Pq6d1tHHA63RQ/Bl8NEm6c4lsPHTwki0MqFtrOk8b1GALu18ymxlumU9kPUNPOVGJ/+3aRXRw2DljxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq2AgHFWhHG0wHi5/q4PKVPLcwprqXjV/aIm2XLK+89lEoHCGD
	m5HS4o3miY/XCEIYXSiMhqI/3usw3GxqYBzEkWPm3pAJQfIUDAMU
X-Gm-Gg: ASbGncsjLU5DGX95pWhUrCsvBuou6mnt/SgrmhDn32kl2bb6MbRXXdVk3CbcpT0o5K1
	uxIfozWrAEfo6DMBbJ3gnmOJ1Urs8J8LGcQr7hfYhQD606EW+0cFMOKq5q5igtSllj0GU4aQswF
	CP2I0zLn1A6d19CW2Y3c7Ob6sVq6TcOp0y+Sp6mlVl4fhaMeoHu7usJ8YwgAICTK/uTr7LJv6Jp
	wlRQOOIvCTZwYdM7+P0be0DImbabQZCy0zA4HMhnKXCP9MEvsKGlC6Z9Ka5UCLYP1vk4E/sYzbt
	Sy9JqCuzR589DUQpjtpGwXhS8pEZvGDS0I3p28lMrbcAlCzCaQ==
X-Google-Smtp-Source: AGHT+IFEjku/zRtoq15yS1odPvTrJ/BSCP3PpqrbP64QU8Alyni1zYmSLsmSQzR7FTprpT8+Qv6DdQ==
X-Received: by 2002:a05:6a21:681:b0:1ee:d515:c6ea with SMTP id adf61e73a8af0-1eef3dea48dmr5522617637.36.1740130661915;
        Fri, 21 Feb 2025 01:37:41 -0800 (PST)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273d9fbsm15699183b3a.102.2025.02.21.01.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:37:41 -0800 (PST)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 526D580A58;
	Fri, 21 Feb 2025 17:47:53 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v4 2/2] mtd: spi-nand: macronix: Add support for read retry
Date: Fri, 21 Feb 2025 17:33:00 +0800
Message-Id: <20250221093300.430994-3-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250221093300.430994-1-linchengming884@gmail.com>
References: <20250221093300.430994-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

Add read retry support.

The Special Read for Data Recovery operation is enabled by
Set Feature function.

There are 5 modes for the user to recover the lost data.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 drivers/mtd/nand/spi/macronix.c | 79 ++++++++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index d277c3220fdc..3562bf585ae9 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -14,6 +14,8 @@
 #define MACRONIX_ECCSR_BF_LAST_PAGE(eccsr) FIELD_GET(GENMASK(3, 0), eccsr)
 #define MACRONIX_ECCSR_BF_ACCUMULATED_PAGES(eccsr) FIELD_GET(GENMASK(7, 4), eccsr)
 #define MACRONIX_CFG_CONT_READ         BIT(2)
+#define MACRONIX_FEATURE_ADDR_READ_RETRY 0x70
+#define MACRONIX_NUM_READ_RETRY_MODES 5
 
 #define STATUS_ECC_HAS_BITFLIPS_THRESHOLD (3 << 4)
 
@@ -136,6 +138,23 @@ static int macronix_set_cont_read(struct spinand_device *spinand, bool enable)
 	return 0;
 }
 
+/**
+ * macronix_set_read_retry - Set the retry mode
+ * @spinand: SPI NAND device
+ * @retry_mode: Specify which retry mode to set
+ *
+ * Return: 0 on success, a negative error code otherwise.
+ */
+static int macronix_set_read_retry(struct spinand_device *spinand,
+					     unsigned int retry_mode)
+{
+	struct spi_mem_op op = SPINAND_SET_FEATURE_OP(MACRONIX_FEATURE_ADDR_READ_RETRY,
+						      spinand->scratchbuf);
+
+	*spinand->scratchbuf = retry_mode;
+	return spi_mem_exec_op(spinand->spimem, &op);
+}
+
 static const struct spinand_info macronix_spinand_table[] = {
 	SPINAND_INFO("MX35LF1GE4AB",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x12),
@@ -168,7 +187,9 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
-		     SPINAND_CONT_READ(macronix_set_cont_read)),
+		     SPINAND_CONT_READ(macronix_set_cont_read),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX35LF4GE4AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x37, 0x03),
 		     NAND_MEMORG(1, 4096, 128, 64, 2048, 40, 1, 1, 1),
@@ -179,7 +200,9 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
-		     SPINAND_CONT_READ(macronix_set_cont_read)),
+		     SPINAND_CONT_READ(macronix_set_cont_read),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX35LF1G24AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x14, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
@@ -188,7 +211,9 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
-		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX35LF2G24AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x24, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
@@ -198,7 +223,9 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT |
 		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
-		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX35LF2G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x64, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
@@ -207,7 +234,9 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
-		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX35LF4G24AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x35, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 2, 1, 1),
@@ -217,7 +246,9 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT |
 		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
-		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX35LF4G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x75, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
@@ -226,7 +257,9 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
-		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX31LF1GE4BC",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x1e),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
@@ -270,7 +303,9 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT |
 		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     macronix_ecc_get_status)),
+				     macronix_ecc_get_status),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX35UF4G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xf5, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
@@ -280,7 +315,9 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     macronix_ecc_get_status)),
+				     macronix_ecc_get_status),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX35UF4GE4AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xb7, 0x03),
 		     NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
@@ -291,7 +328,9 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
-		     SPINAND_CONT_READ(macronix_set_cont_read)),
+		     SPINAND_CONT_READ(macronix_set_cont_read),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX35UF2G14AC",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa0),
 		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 2, 1, 1),
@@ -314,7 +353,9 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT |
 		     SPINAND_HAS_PROG_PLANE_SELECT_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     macronix_ecc_get_status)),
+				     macronix_ecc_get_status),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX35UF2G24AD-Z4I8",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xe4, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
@@ -324,7 +365,9 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     macronix_ecc_get_status)),
+				     macronix_ecc_get_status),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX35UF2GE4AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa6, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
@@ -335,7 +378,9 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
-		     SPINAND_CONT_READ(macronix_set_cont_read)),
+		     SPINAND_CONT_READ(macronix_set_cont_read),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX35UF2GE4AC",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xa2, 0x01),
 		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
@@ -366,7 +411,9 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
-				     macronix_ecc_get_status)),
+				     macronix_ecc_get_status),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX35UF1GE4AD",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x96, 0x03),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
@@ -377,7 +424,9 @@ static const struct spinand_info macronix_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
 				     macronix_ecc_get_status),
-		     SPINAND_CONT_READ(macronix_set_cont_read)),
+		     SPINAND_CONT_READ(macronix_set_cont_read),
+		     SPINAND_READ_RETRY(MACRONIX_NUM_READ_RETRY_MODES,
+					macronix_set_read_retry)),
 	SPINAND_INFO("MX35UF1GE4AC",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x92, 0x01),
 		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
-- 
2.25.1


