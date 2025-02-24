Return-Path: <linux-kernel+bounces-528293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4DCA415F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 250B47A3E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8105F23F262;
	Mon, 24 Feb 2025 07:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqJGlLzV"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DAF23A990
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380893; cv=none; b=Bl3XQIZlN41O1eoL0VtuQIW5hcpxaEghPzDpyadPB7NUYluKqulAfSJk98m6o3LFnZyeKw+uzl+vB09B6k7I+eUX4606L+9G6BpqHIycgtpKZLzw+Cyax/JvGePKsliv4k0k4j5eKoJTQ1AFha8doKH15A3jsQMs+gcZqDPnGfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380893; c=relaxed/simple;
	bh=ccs5KxPYeFLieKvJ7FDXVStz4gHQqg+xqogF8gSelnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CJjxT0YJm5rzVzZxiwT8uAULFvHwvhBEeTNFYyGY4zazM3U5ltTIVRJ7tfFsLmGE+URmeJUvq34YQjstihujxMl3T/L5V3Vkol7EtAQvtWmygSjmNpa2XuCrONHwcF19x1a9DSwLEl0e7Ls9NUgpBUX+jldkWcR8eNfB8uV54yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqJGlLzV; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fbffe0254fso8258814a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 23:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740380891; x=1740985691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5FYO4MnEgAdczm5bGqfGwTqr6ni+nm2y6p6XaFQ6qU=;
        b=CqJGlLzV2kLjLCC/KTGjvfsEwwptDOfzFcBrU0Egethor5Vt06yYW4DRSTRsMuQocm
         ZFPITB5mjAVbTDcO68O7JOUeiD5+rM5hL+G9BgWh/1Z/+o9J9TN0DTzEl2hTb4eUAW3U
         +h3LggDiq2ilCQVTO6jIpbWWlGCJ9KG0f3IV532qZzpVjpMP6duLoMj/EdM8n2ed7gcY
         tClg/zhI9HewRCuONwL6bcPRo3woVn9DCNMLGsmomM67QwU67bDOxTlMzczgOlaFcuDt
         dPnz8VOtOYjJyBQUQ/rdZ8Ha48+0dcfQOHJ6Hqmq9ihpQqyXOrDDuzmhPUnxatEgdsRn
         PymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740380891; x=1740985691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5FYO4MnEgAdczm5bGqfGwTqr6ni+nm2y6p6XaFQ6qU=;
        b=WVtPGeAyEvAcnKXATBGMpu81X43GKiW+Z6temrKffDCCdtkIcZpCL5HbBPm505eTVH
         7frt4ma5LcCoxqQM9T9NgnW+wf7buTqLt7zaBwD3znbsX1Vbmae7R2GzbEykJPB+MEMB
         XL36uOj+zacW61p8QXNB9bGgk1e76hc1RcYMx2BiyC5NAgL5/akd34An1QICUFpB8kvy
         3zjaCOpt6Ls4YhALTmOJZsC8SDL2y1A8Wll6zXH9Z3/rECjvdX+708B1vSCYc7iT1aZC
         Z0naWr2Qg8690ASc75hsAIavgJ/XghZ8/45Ea9PM+Aacw/Ew0DIzX+kAAyyc805ZXOfm
         6rJA==
X-Forwarded-Encrypted: i=1; AJvYcCXymimPAMSHv0U3Z5t9QzjNvBhStLd0PTAjkZNkU++d7G1pfzQL0R7Qp/kHU+Ea8v0wDV9rDJnwnDqw0i0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7OAbrO38iKhlxmR3IemZTnk8mXtQ51ddXjIVKUyqwBO7pZLcx
	izIjsY/zF9Rsf6D26j9bu9mnKImkXXEp2suRSaVX4tHzAobixvhz
X-Gm-Gg: ASbGncvap69BdMRYF4zXBoH/rdBSEwEqIDqsGwLvySJ1Uqu+lemFVUKhLpyZ5QgDuUB
	K5jPe4vjTlDkrC7n+yE1KU5OyPSlCawPsADo6ncVcleTqVhu9E3FfWPrF0VSN3ibg3VDH/BE5u8
	exUkkcABo18Y93F6EUDbREw0QCNeAXGJyRBF2WDNGA+Tcl5KvAREipkR4veDhAiDBNtDN940J7c
	GFfBK1vTqCRMlbGBIBgFqFzOen+gtLIM6Cy9KrMecxD7veyFBiYLdZzmVum4Rq+TnsGm5SybMFn
	xdJt0OtAQO3Td7mvZl3ts7pq0f9tn3gRSlIaxT0LNppLGjiKSQ==
X-Google-Smtp-Source: AGHT+IF6iAQd9FN+K1KtbbQ8XBRW1HmHqrKJdn+kn4HBTAB2ab+Tb0lVQnMh83irHuxnku8oYwIZoA==
X-Received: by 2002:a05:6a21:6b01:b0:1ee:d418:f756 with SMTP id adf61e73a8af0-1eef3dd06fbmr22565387637.38.1740380891163;
        Sun, 23 Feb 2025 23:08:11 -0800 (PST)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73284a7401dsm13214597b3a.134.2025.02.23.23.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 23:08:10 -0800 (PST)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id B38B780733;
	Mon, 24 Feb 2025 15:18:18 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: richard@nod.at,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v5 2/2] mtd: spi-nand: macronix: Add support for read retry
Date: Mon, 24 Feb 2025 15:03:49 +0800
Message-Id: <20250224070349.446739-3-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250224070349.446739-1-linchengming884@gmail.com>
References: <20250224070349.446739-1-linchengming884@gmail.com>
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
index 3dc4d63d6832..1ef08ad850a2 100644
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


