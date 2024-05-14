Return-Path: <linux-kernel+bounces-178802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 376A08C57DD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B4471C21D49
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DB4144D34;
	Tue, 14 May 2024 14:25:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07278144D0B
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715696727; cv=none; b=f+cKdDWYDmF3xcWZTbYWdQGUbfH6wEWgbX1rVnLa7SxPzmGL+S7DRFi6FVrfOXAT0yb3pVEwOOUT0DjYLbkHPJpb25WTs3RWRrzngr+V3Bjh8ZRsbcNDIxJimNA74CI1K9WOl9Aj0BxIKfSqJYdGTXbJvcE4de356XBFmISccNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715696727; c=relaxed/simple;
	bh=fFUDAF5lVPhHSvNzxUUCBmqbwiK0hi2y6kNbxl0InYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=abRwIhAa2Tnh8y7Snq4AVkdHCZeJ1XUsj68d12dUMBXljM2BoG1hgD5tagr6ZGgF8ENctIuTTh9lyDa/3TLWRy5GX9Vn4/jVdC7WmyEmsU2OiFG52t673BlaIkkDItiLPpuSxtUouJf5ZugXdG0jue9rYALe+ivSo+3qvhj20Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1s6t5m-00044O-7m; Tue, 14 May 2024 16:25:22 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1s6t5l-001N6X-6h; Tue, 14 May 2024 16:25:21 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1s6t5l-004mXh-0Q;
	Tue, 14 May 2024 16:25:21 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 14 May 2024 16:25:19 +0200
Subject: [PATCH v3 3/3] mtd: nand: mxc_nand: support software ECC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240514-mtd-nand-mxc-nand-exec-op-v3-3-3e6f45fd3d82@pengutronix.de>
References: <20240514-mtd-nand-mxc-nand-exec-op-v3-0-3e6f45fd3d82@pengutronix.de>
In-Reply-To: <20240514-mtd-nand-mxc-nand-exec-op-v3-0-3e6f45fd3d82@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715696721; l=5082;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=fFUDAF5lVPhHSvNzxUUCBmqbwiK0hi2y6kNbxl0InYA=;
 b=tj+4TIwISXBORWmh2MPTpURPBXKBF+9LJxh4lMhXFqbOwW+GbhgFW330wF+Nw7AwulilNg3xE
 GJVIJBKANLCBa9lJ/4sDYhcTtPGghY2dTCeqAy1aoVLkgpKM+QG8l28
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

With these changes the driver can be used with software BCH ECC which
is useful for NAND chips that require a stronger ECC than the i.MX
hardware supports.

The controller normally interleaves user data with OOB data when
accessing the NAND chip. With Software BCH ECC we write the data
to the NAND in a way that the raw data on the NAND chip matches the
way the NAND layer sees it. This way commands like NAND_CMD_RNDOUT
work as expected.

This was tested on i.MX27 but should work on the other SoCs supported
by this driver as well.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mtd/nand/raw/mxc_nand.c | 73 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 6f8b8f4b118ec..ae4cff2584a2d 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -1404,10 +1404,10 @@ static int mxcnd_attach_chip(struct nand_chip *chip)
 	chip->ecc.bytes = host->devtype_data->eccbytes;
 	host->eccsize = host->devtype_data->eccsize;
 	chip->ecc.size = 512;
-	mtd_set_ooblayout(mtd, host->devtype_data->ooblayout);
 
 	switch (chip->ecc.engine_type) {
 	case NAND_ECC_ENGINE_TYPE_ON_HOST:
+		mtd_set_ooblayout(mtd, host->devtype_data->ooblayout);
 		chip->ecc.read_page = mxc_nand_read_page;
 		chip->ecc.read_page_raw = mxc_nand_read_page_raw;
 		chip->ecc.read_oob = mxc_nand_read_oob;
@@ -1417,6 +1417,8 @@ static int mxcnd_attach_chip(struct nand_chip *chip)
 		break;
 
 	case NAND_ECC_ENGINE_TYPE_SOFT:
+		chip->ecc.write_page_raw = nand_monolithic_write_page_raw;
+		chip->ecc.read_page_raw = nand_monolithic_read_page_raw;
 		break;
 
 	default:
@@ -1472,6 +1474,59 @@ static int mxcnd_setup_interface(struct nand_chip *chip, int chipnr,
 	return host->devtype_data->setup_interface(chip, chipnr, conf);
 }
 
+static void copy_page_to_sram(struct mtd_info *mtd, const void *buf, int buf_len)
+{
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct mxc_nand_host *host = nand_get_controller_data(this);
+	unsigned int no_subpages = mtd->writesize / 512;
+	int oob_per_subpage, i;
+
+	oob_per_subpage = (mtd->oobsize / no_subpages) & ~1;
+
+	/*
+	 * During a page write the i.MX NAND controller will read 512b from
+	 * main_area0 SRAM, then oob_per_subpage bytes from spare0 SRAM, then
+	 * 512b from main_area1 SRAM and so on until the full page is written.
+	 * For software ECC we want to have a 1:1 mapping between the raw page
+	 * data on the NAND chip and the view of the NAND core. This is
+	 * necessary to make the NAND_CMD_RNDOUT read the data it expects.
+	 * To accomplish this we have to write the data in the order the controller
+	 * reads it. This is reversed in copy_page_from_sram() below.
+	 */
+	for (i = 0; i < no_subpages; i++) {
+		memcpy16_toio(host->main_area0 + i * 512, buf, 512);
+		buf += 512;
+
+		memcpy16_toio(host->spare0 + i * host->devtype_data->spare_len, buf,
+			      oob_per_subpage);
+		buf += oob_per_subpage;
+	}
+}
+
+static void copy_page_from_sram(struct mtd_info *mtd)
+{
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct mxc_nand_host *host = nand_get_controller_data(this);
+	void *buf = host->data_buf;
+	unsigned int no_subpages = mtd->writesize / 512;
+	int oob_per_subpage, i;
+
+	/* mtd->writesize is not set during ident scanning */
+	if (!no_subpages)
+		no_subpages = 1;
+
+	oob_per_subpage = (mtd->oobsize / no_subpages) & ~1;
+
+	for (i = 0; i < no_subpages; i++) {
+		memcpy16_fromio(buf, host->main_area0 + i * 512, 512);
+		buf += 512;
+
+		memcpy16_fromio(buf, host->spare0 + i * host->devtype_data->spare_len,
+				oob_per_subpage);
+		buf += oob_per_subpage;
+	}
+}
+
 static int mxcnd_do_exec_op(struct nand_chip *chip,
 			    const struct nand_subop *op)
 {
@@ -1510,7 +1565,10 @@ static int mxcnd_do_exec_op(struct nand_chip *chip,
 			buf_write = instr->ctx.data.buf.out;
 			buf_len = instr->ctx.data.len;
 
-			memcpy32_toio(host->main_area0, buf_write, buf_len);
+			if (chip->ecc.engine_type == NAND_ECC_ENGINE_TYPE_ON_HOST)
+				memcpy32_toio(host->main_area0, buf_write, buf_len);
+			else
+				copy_page_to_sram(mtd, buf_write, buf_len);
 
 			host->devtype_data->send_page(mtd, NFC_INPUT);
 
@@ -1545,10 +1603,15 @@ static int mxcnd_do_exec_op(struct nand_chip *chip,
 
 			host->devtype_data->read_page(chip);
 
-			if (IS_ALIGNED(buf_len, 4)) {
-				memcpy32_fromio(buf_read, host->main_area0, buf_len);
+			if (chip->ecc.engine_type == NAND_ECC_ENGINE_TYPE_ON_HOST) {
+				if (IS_ALIGNED(buf_len, 4)) {
+					memcpy32_fromio(buf_read, host->main_area0, buf_len);
+				} else {
+					memcpy32_fromio(host->data_buf, host->main_area0, mtd->writesize);
+					memcpy(buf_read, host->data_buf, buf_len);
+				}
 			} else {
-				memcpy32_fromio(host->data_buf, host->main_area0, mtd->writesize);
+				copy_page_from_sram(mtd);
 				memcpy(buf_read, host->data_buf, buf_len);
 			}
 

-- 
2.39.2


