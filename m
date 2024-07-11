Return-Path: <linux-kernel+bounces-249224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9603392E8AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96AB1C22310
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305E015F40A;
	Thu, 11 Jul 2024 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="oj2PWEA3"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9B415ECDF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702831; cv=none; b=jnGtXVm+s8ZcpW/y4ch7x/vN8drmMS2m1WJE4xXolltUzwEfjYJM31nGYJKD9vcPp60konr05TtYmi6XxIew5k6qOKD4uHB0VlY4eO+Zx4YTjEnSbTdjbegg6kufONSfbocRmXPwHPfaGBwRZbCvdXlos1JHK37Li4tY8iYKAJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702831; c=relaxed/simple;
	bh=WHJBUERZdI5anYsL4qiSt3EgClUaLQjxdDb2lFpx5J4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GfJaQJAif2DGO+QXpZ/S/N276VmnLM/u8WVg/oJ6gmd+0buEJ2rGnZ/5OgUg16LFN62HuH9HKKZXnsU7nllELVXcz2Ey1BH4RGVJ6lcp/Bb1zfXMnEd3zHAcbXZZB28aZYLi04hQTX20RB3t9r0qH+xn1uiB8hX7vB/cYgWa1Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=oj2PWEA3; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=pxA3/BuB6HUs2tgm/oJDzWCo9cDxy9kfseU0w3KrlBM=; b=oj2PWEA3AHARezlANl6lNDnw3f
	DvU0ld7f7gMyTCCX+XqI8sRYOGGAYOMJJpthQAdWjFiXWr1cAZ/STJF+cORLJiTwDpA26BJZXTVxo
	jRIU5rSUyaBOCGp1ykEb1/YoFRaUVUlLHOSkWgHvspJvDRzM7pDI18ZPEQhg9SpTosyurS1DlwZNI
	XF06pNTYOCpQITU3znkVgtuP4IozyRVUJlV/bDMeWhJnGvkNvftx9dHMPPE7gE4oRo/FeM9T+4FFu
	vIEOcUzf/UZqEFVPFWJ9H/UJh1+6Bz03hnj3ENbWp8W3kc9nZi1reKPe6NwAYGQSkPPeJzWqtfkFP
	RqWluiTQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sRtPF-000BRh-6r; Thu, 11 Jul 2024 15:00:17 +0200
Received: from [87.49.147.209] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sRtPF-000325-05;
	Thu, 11 Jul 2024 15:00:16 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Thu, 11 Jul 2024 15:00:01 +0200
Subject: [PATCH v3 01/15] mtd: spi-nor: core: add flag for doing optional
 SFDP parsing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-macronix-mx25l3205d-fixups-v3-1-99353461dd2d@geanix.com>
References: <20240711-macronix-mx25l3205d-fixups-v3-0-99353461dd2d@geanix.com>
In-Reply-To: <20240711-macronix-mx25l3205d-fixups-v3-0-99353461dd2d@geanix.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 linux-arm-kernel@lists.infradead.org, Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720702815; l=7503;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=WHJBUERZdI5anYsL4qiSt3EgClUaLQjxdDb2lFpx5J4=;
 b=aPo3kjmNJg4ZG/Jk8HSE8b2OJJtk00MAsuWZNutgFfPkLAhHZ8msjdGZnka1BMxpq5bmZ47GR
 3xzfEdOiyJ/DQsOR5bAp9sTfDtPhmBbCyPvZWxPLJeqT63Yb09IbR/m
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27333/Thu Jul 11 10:35:59 2024)

This is the first step in replacing the old deprecated mechanism for
initializing flash parameters and settings based on SFDP, with fallback to
static parameters from struct flash_info.

A dedicated SPI_NOR_TRY_SFDP flag is used to request this handling, where
as the deprecated mechanism relies on the setting of either of the
SPI_NOR_DUAL_READ, SPI_NOR_QUAD_READ, SPI_NOR_OCTAL_READ or
SPI_NOR_OCTAL_DTR_READ bits.

Compared to the deprecated mechanism, SPI_NOR_TRY_SFDP flags allow optional
SFDP parsing for flashes where the fallback does not include
dual/quad/octal read.

This kind of mechanism is needed for flashes that reuses flash id from old
non-SFDP flashes for newer flashes with SFDP, with different parameters and
settings required. Macronix is known to reuse flash ids for replacement
parts, so for those lines where the initial part did not have SFDP, this
mechanism is needed.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/mtd/spi-nor/core.c | 49 ++++++++++++++--------------------------------
 drivers/mtd/spi-nor/core.h | 35 ++++++++++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 35 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 3e1f1913536b..39b28700ce28 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2717,11 +2717,10 @@ static void spi_nor_manufacturer_init_params(struct spi_nor *nor)
 
 /**
  * spi_nor_no_sfdp_init_params() - Initialize the flash's parameters and
- * settings based on nor->info->sfdp_flags. This method should be called only by
- * flashes that do not define SFDP tables. If the flash supports SFDP but the
- * information is wrong and the settings from this function can not be retrieved
- * by parsing SFDP, one should instead use the fixup hooks and update the wrong
- * bits.
+ * settings based on nor->info->sfdp_flags. This method is for flashes that do
+ * not define SFDP tables. If the flash supports SFDP but the information is
+ * wrong and the settings from this function can not be retrieved by parsing
+ * SFDP, one should instead use the fixup hooks and update the wrong bits.
  * @nor:	pointer to a 'struct spi_nor'.
  */
 static void spi_nor_no_sfdp_init_params(struct spi_nor *nor)
@@ -2899,14 +2898,15 @@ static int spi_nor_late_init_params(struct spi_nor *nor)
 }
 
 /**
- * spi_nor_sfdp_init_params_deprecated() - Deprecated way of initializing flash
- * parameters and settings based on JESD216 SFDP standard.
+ * spi_nor_try_sfdp_init_params() - Try to initialize flash parameters and
+ * settings based on JESD216 SFDP standard, with fallback to pre-initialized
+ * flash parameters and settings if SFP parsing fails.
  * @nor:	pointer to a 'struct spi_nor'.
  *
  * The method has a roll-back mechanism: in case the SFDP parsing fails, the
  * legacy flash parameters and settings will be restored.
  */
-static void spi_nor_sfdp_init_params_deprecated(struct spi_nor *nor)
+static void spi_nor_try_sfdp_init_params(struct spi_nor *nor)
 {
 	struct spi_nor_flash_parameter sfdp_params;
 
@@ -2918,28 +2918,6 @@ static void spi_nor_sfdp_init_params_deprecated(struct spi_nor *nor)
 	}
 }
 
-/**
- * spi_nor_init_params_deprecated() - Deprecated way of initializing flash
- * parameters and settings.
- * @nor:	pointer to a 'struct spi_nor'.
- *
- * The method assumes that flash doesn't support SFDP so it initializes flash
- * parameters in spi_nor_no_sfdp_init_params() which later on can be overwritten
- * when parsing SFDP, if supported.
- */
-static void spi_nor_init_params_deprecated(struct spi_nor *nor)
-{
-	spi_nor_no_sfdp_init_params(nor);
-
-	spi_nor_manufacturer_init_params(nor);
-
-	if (nor->info->no_sfdp_flags & (SPI_NOR_DUAL_READ |
-					SPI_NOR_QUAD_READ |
-					SPI_NOR_OCTAL_READ |
-					SPI_NOR_OCTAL_DTR_READ))
-		spi_nor_sfdp_init_params_deprecated(nor);
-}
-
 /**
  * spi_nor_init_default_params() - Default initialization of flash parameters
  * and settings. Done for all flashes, regardless is they define SFDP tables
@@ -3046,13 +3024,16 @@ static int spi_nor_init_params(struct spi_nor *nor)
 	if (spi_nor_needs_sfdp(nor)) {
 		ret = spi_nor_parse_sfdp(nor);
 		if (ret) {
-			dev_err(nor->dev, "BFPT parsing failed. Please consider using SPI_NOR_SKIP_SFDP when declaring the flash\n");
+			dev_err(nor->dev, "BFPT parsing failed. Please consider using SPI_NOR_SKIP_SFDP or SPI_NOR_TRY_SFDP when declaring the flash\n");
 			return ret;
 		}
-	} else if (nor->info->no_sfdp_flags & SPI_NOR_SKIP_SFDP) {
-		spi_nor_no_sfdp_init_params(nor);
 	} else {
-		spi_nor_init_params_deprecated(nor);
+		spi_nor_no_sfdp_init_params(nor);
+		if (!(nor->info->no_sfdp_flags & SPI_NOR_SKIP_SFDP))
+			spi_nor_manufacturer_init_params(nor);
+
+		if (spi_nor_try_sfdp(nor))
+			spi_nor_try_sfdp_init_params(nor);
 	}
 
 	return spi_nor_late_init_params(nor);
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 442786685515..dfc81716e068 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -485,9 +485,12 @@ struct spi_nor_id {
  *
  * @no_sfdp_flags:  flags that indicate support that can be discovered via SFDP.
  *                  Used when SFDP tables are not defined in the flash. These
- *                  flags are used together with the SPI_NOR_SKIP_SFDP flag.
+ *                  flags are used together with the SPI_NOR_SKIP_SFDP or
+ *                  SPI_NOR_TRY_SFDP flag.
  *   SPI_NOR_SKIP_SFDP:       skip parsing of SFDP tables.
  *   SECT_4K:                 SPINOR_OP_BE_4K works uniformly.
+ *   SPI_NOR_TRY_SFDP:        try parsing SFDP tables before using the
+ *                            parameters specified in this struct.
  *   SPI_NOR_DUAL_READ:       flash supports Dual Read.
  *   SPI_NOR_QUAD_READ:       flash supports Quad Read.
  *   SPI_NOR_OCTAL_READ:      flash supports Octal Read.
@@ -535,6 +538,7 @@ struct flash_info {
 	u8 no_sfdp_flags;
 #define SPI_NOR_SKIP_SFDP		BIT(0)
 #define SECT_4K				BIT(1)
+#define SPI_NOR_TRY_SFDP		BIT(2)
 #define SPI_NOR_DUAL_READ		BIT(3)
 #define SPI_NOR_QUAD_READ		BIT(4)
 #define SPI_NOR_OCTAL_READ		BIT(5)
@@ -706,6 +710,35 @@ static inline bool spi_nor_needs_sfdp(const struct spi_nor *nor)
 	return !nor->info->size;
 }
 
+/**
+ * spi_nor_try_sfdp() - returns true if optional SFDP parsing should be tried
+ * for this flash, with fallback to static parameters and settings based on
+ * flash ID if SFDP parsing fails.
+ *
+ * Return: true if optional SFDP parsing should be tried
+ */
+static inline bool spi_nor_try_sfdp(const struct spi_nor *nor)
+{
+	if (nor->info->no_sfdp_flags & SPI_NOR_SKIP_SFDP)
+		return false;
+	if (nor->info->no_sfdp_flags & SPI_NOR_TRY_SFDP)
+		return true;
+
+	/* Deprecated/legacy way for triggering optional SFDP parsing.
+	 * If one of the no_sfdp_flags indicating dual, quad or octal read is
+	 * set, SFDP parsing will be tried.
+	 * When all drivers have been converted to set SPI_NOR_TRY_SFDP where
+	 * needed, this deprecated mechanism can be removed.
+	 */
+	if (nor->info->no_sfdp_flags & (SPI_NOR_DUAL_READ |
+					SPI_NOR_QUAD_READ |
+					SPI_NOR_OCTAL_READ |
+					SPI_NOR_OCTAL_DTR_READ))
+		return true;
+
+	return false;
+}
+
 #ifdef CONFIG_DEBUG_FS
 void spi_nor_debugfs_register(struct spi_nor *nor);
 void spi_nor_debugfs_shutdown(void);

-- 
2.45.2


