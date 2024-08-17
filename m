Return-Path: <linux-kernel+bounces-290723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4209557D9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 14:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3ECAB21F71
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 12:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119BD14EC60;
	Sat, 17 Aug 2024 12:42:24 +0000 (UTC)
Received: from chessie.everett.org (chessie.fmt1.pfcs.com [66.220.13.234])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E058149E09;
	Sat, 17 Aug 2024 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.13.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723898543; cv=none; b=jRXn0roWbRUXA7hrF3aDnEKrA0PizWPXxbJZ2a30N3smOi1CuKVXmceGxrheBqRbmttBooKpWECKNT/I7lFhjESfaPv2tIEIh5QWlhMfn+iXuIj0pAkdnCKHyWTikVm00HwxqWUdTWgwmtrl+HGAO3qoDLygPL1YQGGO39+dWn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723898543; c=relaxed/simple;
	bh=pqeHPSl08rqFIF0/JblPp9uvDV2VXrXy1J5uH3NciOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yy2ReyOGuqaQT+AXAigcbRku+pMb0Ohfg48UTbz4SIQGZbCYSJqzqyzeGdpjgn0DAxTlz1em3qu7t3WEUgMsjw5wg26UH96ATNseW5yB1vsHrvy6cT1twpSA2TCEQAqoAxFVlUoNr/xMiBZ3UTjdngbVFcq6oBkTCUrQv6TkWGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org; spf=pass smtp.mailfrom=nwtime.org; arc=none smtp.client-ip=66.220.13.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nwtime.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwtime.org
Received: from localhost.localdomain (ip1f10f85d.dynamic.kabel-deutschland.de [31.16.248.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by chessie.everett.org (Postfix) with ESMTPSA id 4WmJQq5n3hzMQsP;
	Sat, 17 Aug 2024 12:42:11 +0000 (UTC)
From: Erez Geva <erezgeva@nwtime.org>
To: linux-mtd@lists.infradead.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Erez Geva <ErezGeva2@gmail.com>
Subject: [PATCH v3 1/4] mtd: spi-nor: core: add manufacturer flags
Date: Sat, 17 Aug 2024 14:41:37 +0200
Message-Id: <20240817124140.800637-2-erezgeva@nwtime.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240817124140.800637-1-erezgeva@nwtime.org>
References: <20240817124140.800637-1-erezgeva@nwtime.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Erez Geva <ErezGeva2@gmail.com>

Add flag for always trying reading SFDP:
Some vendors reuse all JEDEC IDs on manufacture table
 with new chips that support SFDP.

Add flag for reading OTP parameters from device tree.
Some vendors reuse JEDEC IDs
 with several chips with different OTP parameters.
Alternatively we read parameters from SFDP.
But the OTP parameters are absent from the SFDP.
So there is not other way but to add the OTP parameters in the device tree.

In this series, we will use the flags with Macronix.

Signed-off-by: Erez Geva <ErezGeva2@gmail.com>
---
 drivers/mtd/spi-nor/core.c    | 36 ++++++++++++++++++++++++++++++-----
 drivers/mtd/spi-nor/core.h    |  7 ++++++-
 drivers/mtd/spi-nor/otp.c     |  6 +++---
 drivers/mtd/spi-nor/winbond.c |  2 +-
 4 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index e0c4efc424f4..af522c426ac9 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2891,10 +2891,11 @@ static void spi_nor_init_params_deprecated(struct spi_nor *nor)
 
 	spi_nor_manufacturer_init_params(nor);
 
-	if (nor->info->no_sfdp_flags & (SPI_NOR_DUAL_READ |
-					SPI_NOR_QUAD_READ |
-					SPI_NOR_OCTAL_READ |
-					SPI_NOR_OCTAL_DTR_READ))
+	if ((nor->info->no_sfdp_flags & (SPI_NOR_DUAL_READ |
+					 SPI_NOR_QUAD_READ |
+					 SPI_NOR_OCTAL_READ |
+					 SPI_NOR_OCTAL_DTR_READ)) ||
+	     nor->manufacturer->flags & SPI_NOR_MANUFACT_TTY_SFDP)
 		spi_nor_sfdp_init_params_deprecated(nor);
 }
 
@@ -2911,7 +2912,32 @@ static void spi_nor_init_default_params(struct spi_nor *nor)
 	struct device_node *np = spi_nor_get_flash_node(nor);
 
 	params->quad_enable = spi_nor_sr2_bit1_quad_enable;
-	params->otp.org = info->otp;
+	memset(&params->otp.org, 0, sizeof(struct spi_nor_otp_organization));
+	if (info->otp) {
+		memcpy(&params->otp.org, info->otp, sizeof(struct spi_nor_otp_organization));
+	} else if (nor->manufacturer->flags & SPI_NOR_MANUFACT_DT_OTP) {
+		/* Check for OTP information on device tree */
+		u32 n_regions, len;
+
+		if (!of_property_read_u32(np, "opt_n_regions", &n_regions) &&
+		   n_regions > 0 &&
+		   !of_property_read_u32(np, "otp_len", &len) &&
+		   len > 0) {
+			u32 base, offset = 0;
+
+			if (n_regions > 1) {
+				/* If offset is not defined use length as offset */
+				if (of_property_read_u32(np, "otp_offset", &offset))
+					offset = len;
+			}
+			if (of_property_read_u32(np, "otp_base", &base))
+				base = 0;
+			params->otp.org.n_regions = n_regions;
+			params->otp.org.offset = offset;
+			params->otp.org.base = base;
+			params->otp.org.len = len;
+		}
+	}
 
 	/* Default to 16-bit Write Status (01h) Command */
 	nor->flags |= SNOR_F_HAS_16BIT_SR;
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 1516b6d0dc37..237196b908dd 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -326,7 +326,7 @@ struct spi_nor_otp_ops {
  * @ops:	OTP access ops
  */
 struct spi_nor_otp {
-	const struct spi_nor_otp_organization *org;
+	struct spi_nor_otp_organization org;
 	const struct spi_nor_otp_ops *ops;
 };
 
@@ -560,12 +560,17 @@ struct flash_info {
  * @parts: array of parts supported by this manufacturer
  * @nparts: number of entries in the parts array
  * @fixups: hooks called at various points in time during spi_nor_scan()
+ * @flags: manufacturer flags
  */
 struct spi_nor_manufacturer {
 	const char *name;
 	const struct flash_info *parts;
 	unsigned int nparts;
 	const struct spi_nor_fixups *fixups;
+
+	u8 flags;
+#define SPI_NOR_MANUFACT_TTY_SFDP	BIT(0)
+#define SPI_NOR_MANUFACT_DT_OTP		BIT(0)
 };
 
 /**
diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
index 9a729aa3452d..ffb7ffeb9030 100644
--- a/drivers/mtd/spi-nor/otp.c
+++ b/drivers/mtd/spi-nor/otp.c
@@ -11,8 +11,8 @@
 
 #include "core.h"
 
-#define spi_nor_otp_region_len(nor) ((nor)->params->otp.org->len)
-#define spi_nor_otp_n_regions(nor) ((nor)->params->otp.org->n_regions)
+#define spi_nor_otp_region_len(nor) ((nor)->params->otp.org.len)
+#define spi_nor_otp_n_regions(nor) ((nor)->params->otp.org.n_regions)
 
 /**
  * spi_nor_otp_read_secr() - read security register
@@ -222,7 +222,7 @@ int spi_nor_otp_is_locked_sr2(struct spi_nor *nor, unsigned int region)
 
 static loff_t spi_nor_otp_region_start(const struct spi_nor *nor, unsigned int region)
 {
-	const struct spi_nor_otp_organization *org = nor->params->otp.org;
+	const struct spi_nor_otp_organization *org = &nor->params->otp.org;
 
 	return org->base + region * org->offset;
 }
diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index e065e4fd42a3..15af62aacc9a 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -307,7 +307,7 @@ static int winbond_nor_late_init(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter *params = nor->params;
 
-	if (params->otp.org)
+	if (params->otp.org.n_regions)
 		params->otp.ops = &winbond_nor_otp_ops;
 
 	/*
-- 
2.39.2


