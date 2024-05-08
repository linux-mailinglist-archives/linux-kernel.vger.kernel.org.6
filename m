Return-Path: <linux-kernel+bounces-173108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1F08BFB9C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB968281EBC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F59081ABF;
	Wed,  8 May 2024 11:09:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31412823DC
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166553; cv=none; b=TPH2Q+YEFCGnTmX2ryfij4liO59kS+7NZDFD2+7kQaR8qnJbNq2nZkpEtDjugzOzUxasGrmtCz3WNMaHWUTek85k+tW6udLq1s1KFBDrVQpbDnzXvEVnDzueMsqFMgEJbt7kiAlNYUHEnphFCaOlHTTvHQ10ShlHpFTezsXkJCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166553; c=relaxed/simple;
	bh=7BAnbozBUGliEkFA2yy81ruk4ikDMyqp7A70k41kDBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D1ymIv1/sWRSH+dSVb4mvn3H6BLGeQ6d4DpiQiXQOqcYogq0AW92g0o8OsVFpW894LCqSrNie2Iu/ojTkpDaBXBXPDPl92PWFbPe1EVAybfWG5XinMmYi8LoAXCj/ErJPAapOTkIK/vSZmP6+wl5TDq4TiaM2egDGVUkliDKSMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1s4fAA-0001ir-NP; Wed, 08 May 2024 13:08:42 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1s4fA9-000GOD-F5; Wed, 08 May 2024 13:08:41 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1s4fA9-000NrM-18;
	Wed, 08 May 2024 13:08:41 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 08 May 2024 13:08:27 +0200
Subject: [PATCH v2 1/3] mtd: nand: mxc_nand: separate page read from ecc
 calc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-mtd-nand-mxc-nand-exec-op-v2-1-6b7366b7831f@pengutronix.de>
References: <20240508-mtd-nand-mxc-nand-exec-op-v2-0-6b7366b7831f@pengutronix.de>
In-Reply-To: <20240508-mtd-nand-mxc-nand-exec-op-v2-0-6b7366b7831f@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715166521; l=7729;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=7BAnbozBUGliEkFA2yy81ruk4ikDMyqp7A70k41kDBQ=;
 b=yhAIzWa5qms2dXU4uKUQwYJg+e8o2uH/ni6HwL5eJY7H9BL2xBkG53ZPRBgfqav0uPQlGOgHo
 AXzs3y6qS3ZBcIpDvS0BzqDZOmmyHMeDhJeEgPkgUMw9JOCVUEePNay
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Our read_page hook currently reads out a page and also counts and
returns the number of bitflips. In upcoming exec_op conversion we'll
need to read the page data in exec_op, but the bitflip information
will be needed in mxc_nand_read_page(). To ease exec_op conversion
separate the page read out from the bitflip evaluation.

For the v2/v3 controllers we can leave the bitflip information in the
status register for later evaluation. For the v1 controller this is
not possible, because the status register is overwritten with each
subpage read. We therefore store the bitflip information in the private
data.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mtd/nand/raw/mxc_nand.c | 140 ++++++++++++++++++++++++----------------
 1 file changed, 86 insertions(+), 54 deletions(-)

diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 003008355b3c2..3fe0b471f4a2d 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -20,6 +20,7 @@
 #include <linux/irq.h>
 #include <linux/completion.h>
 #include <linux/of.h>
+#include <linux/bitfield.h>
 
 #define DRIVER_NAME "mxc_nand"
 
@@ -47,6 +48,8 @@
 #define NFC_V1_V2_CONFIG1		(host->regs + 0x1a)
 #define NFC_V1_V2_CONFIG2		(host->regs + 0x1c)
 
+#define NFC_V1_V2_ECC_STATUS_RESULT_ERM GENMASK(3, 2)
+
 #define NFC_V2_CONFIG1_ECC_MODE_4	(1 << 0)
 #define NFC_V1_V2_CONFIG1_SP_EN		(1 << 2)
 #define NFC_V1_V2_CONFIG1_ECC_EN	(1 << 3)
@@ -132,7 +135,7 @@ struct mxc_nand_devtype_data {
 	uint16_t (*get_dev_status)(struct mxc_nand_host *);
 	int (*check_int)(struct mxc_nand_host *);
 	void (*irq_control)(struct mxc_nand_host *, int);
-	u32 (*get_ecc_status)(struct mxc_nand_host *);
+	u32 (*get_ecc_status)(struct nand_chip *);
 	const struct mtd_ooblayout_ops *ooblayout;
 	void (*select_chip)(struct nand_chip *chip, int cs);
 	int (*setup_interface)(struct nand_chip *chip, int csline,
@@ -175,6 +178,7 @@ struct mxc_nand_host {
 	int			eccsize;
 	int			used_oobsize;
 	int			active_cs;
+	unsigned int		ecc_stats_v1;
 
 	struct completion	op_completion;
 
@@ -406,19 +410,81 @@ static void irq_control(struct mxc_nand_host *host, int activate)
 	}
 }
 
-static u32 get_ecc_status_v1(struct mxc_nand_host *host)
+static u32 get_ecc_status_v1(struct nand_chip *chip)
 {
-	return readw(NFC_V1_V2_ECC_STATUS_RESULT);
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct mxc_nand_host *host = nand_get_controller_data(chip);
+	unsigned int ecc_stats, max_bitflips = 0;
+	int no_subpages, i;
+
+	no_subpages = mtd->writesize >> 9;
+
+	ecc_stats = host->ecc_stats_v1;
+
+	for (i = 0; i < no_subpages; i++) {
+		switch (ecc_stats & 0x3) {
+		case 0:
+		default:
+			break;
+		case 1:
+			mtd->ecc_stats.corrected++;
+			max_bitflips = 1;
+			break;
+		case 2:
+			mtd->ecc_stats.failed++;
+			break;
+		}
+
+		ecc_stats >>= 2;
+	}
+
+	return max_bitflips;
 }
 
-static u32 get_ecc_status_v2(struct mxc_nand_host *host)
+static u32 get_ecc_status_v2_v3(struct nand_chip *chip, unsigned int ecc_stat)
 {
-	return readl(NFC_V1_V2_ECC_STATUS_RESULT);
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct mxc_nand_host *host = nand_get_controller_data(chip);
+	u8 ecc_bit_mask, err_limit;
+	unsigned int max_bitflips = 0;
+	int no_subpages, err;
+
+	ecc_bit_mask = (host->eccsize == 4) ? 0x7 : 0xf;
+	err_limit = (host->eccsize == 4) ? 0x4 : 0x8;
+
+	no_subpages = mtd->writesize >> 9;
+
+	do {
+		err = ecc_stat & ecc_bit_mask;
+		if (err > err_limit) {
+			mtd->ecc_stats.failed++;
+		} else {
+			mtd->ecc_stats.corrected += err;
+			max_bitflips = max_t(unsigned int, max_bitflips, err);
+		}
+
+		ecc_stat >>= 4;
+	} while (--no_subpages);
+
+	return max_bitflips;
 }
 
-static u32 get_ecc_status_v3(struct mxc_nand_host *host)
+static u32 get_ecc_status_v2(struct nand_chip *chip)
 {
-	return readl(NFC_V3_ECC_STATUS_RESULT);
+	struct mxc_nand_host *host = nand_get_controller_data(chip);
+
+	u32 ecc_stat = readl(NFC_V1_V2_ECC_STATUS_RESULT);
+
+	return get_ecc_status_v2_v3(chip, ecc_stat);
+}
+
+static u32 get_ecc_status_v3(struct nand_chip *chip)
+{
+	struct mxc_nand_host *host = nand_get_controller_data(chip);
+
+	u32 ecc_stat = readl(NFC_V3_ECC_STATUS_RESULT);
+
+	return get_ecc_status_v2_v3(chip, ecc_stat);
 }
 
 static irqreturn_t mxc_nfc_irq(int irq, void *dev_id)
@@ -712,9 +778,9 @@ static int mxc_nand_read_page_v1(struct nand_chip *chip, void *buf, void *oob,
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct mxc_nand_host *host = nand_get_controller_data(chip);
-	unsigned int bitflips_corrected = 0;
 	int no_subpages;
 	int i;
+	unsigned int ecc_stats = 0;
 
 	host->devtype_data->enable_hwecc(chip, ecc);
 
@@ -727,8 +793,6 @@ static int mxc_nand_read_page_v1(struct nand_chip *chip, void *buf, void *oob,
 	no_subpages = mtd->writesize >> 9;
 
 	for (i = 0; i < no_subpages; i++) {
-		uint16_t ecc_stats;
-
 		/* NANDFC buffer 0 is used for page read/write */
 		writew((host->active_cs << 4) | i, NFC_V1_V2_BUF_ADDR);
 
@@ -737,32 +801,18 @@ static int mxc_nand_read_page_v1(struct nand_chip *chip, void *buf, void *oob,
 		/* Wait for operation to complete */
 		wait_op_done(host, true);
 
-		ecc_stats = get_ecc_status_v1(host);
-
-		ecc_stats >>= 2;
-
-		if (buf && ecc) {
-			switch (ecc_stats & 0x3) {
-			case 0:
-			default:
-				break;
-			case 1:
-				mtd->ecc_stats.corrected++;
-				bitflips_corrected = 1;
-				break;
-			case 2:
-				mtd->ecc_stats.failed++;
-				break;
-			}
-		}
+		ecc_stats |= FIELD_GET(NFC_V1_V2_ECC_STATUS_RESULT_ERM,
+				       readw(NFC_V1_V2_ECC_STATUS_RESULT)) << i * 2;
 	}
 
+	host->ecc_stats_v1 = ecc_stats;
+
 	if (buf)
 		memcpy32_fromio(buf, host->main_area0, mtd->writesize);
 	if (oob)
 		copy_spare(mtd, true, oob);
 
-	return bitflips_corrected;
+	return 0;
 }
 
 static int mxc_nand_read_page_v2_v3(struct nand_chip *chip, void *buf,
@@ -770,10 +820,6 @@ static int mxc_nand_read_page_v2_v3(struct nand_chip *chip, void *buf,
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct mxc_nand_host *host = nand_get_controller_data(chip);
-	unsigned int max_bitflips = 0;
-	u32 ecc_stat, err;
-	int no_subpages;
-	u8 ecc_bit_mask, err_limit;
 
 	host->devtype_data->enable_hwecc(chip, ecc);
 
@@ -791,26 +837,7 @@ static int mxc_nand_read_page_v2_v3(struct nand_chip *chip, void *buf,
 	if (oob)
 		copy_spare(mtd, true, oob);
 
-	ecc_bit_mask = (host->eccsize == 4) ? 0x7 : 0xf;
-	err_limit = (host->eccsize == 4) ? 0x4 : 0x8;
-
-	no_subpages = mtd->writesize >> 9;
-
-	ecc_stat = host->devtype_data->get_ecc_status(host);
-
-	do {
-		err = ecc_stat & ecc_bit_mask;
-		if (err > err_limit) {
-			mtd->ecc_stats.failed++;
-		} else {
-			mtd->ecc_stats.corrected += err;
-			max_bitflips = max_t(unsigned int, max_bitflips, err);
-		}
-
-		ecc_stat >>= 4;
-	} while (--no_subpages);
-
-	return max_bitflips;
+	return 0;
 }
 
 static int mxc_nand_read_page(struct nand_chip *chip, uint8_t *buf,
@@ -818,13 +845,18 @@ static int mxc_nand_read_page(struct nand_chip *chip, uint8_t *buf,
 {
 	struct mxc_nand_host *host = nand_get_controller_data(chip);
 	void *oob_buf;
+	int ret;
 
 	if (oob_required)
 		oob_buf = chip->oob_poi;
 	else
 		oob_buf = NULL;
 
-	return host->devtype_data->read_page(chip, buf, oob_buf, 1, page);
+	ret = host->devtype_data->read_page(chip, buf, oob_buf, 1, page);
+	if (ret)
+		return ret;
+
+	return host->devtype_data->get_ecc_status(chip);
 }
 
 static int mxc_nand_read_page_raw(struct nand_chip *chip, uint8_t *buf,

-- 
2.39.2


