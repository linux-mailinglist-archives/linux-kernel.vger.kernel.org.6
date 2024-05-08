Return-Path: <linux-kernel+bounces-173106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC81A8BFB9A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6101C21235
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EF081ABA;
	Wed,  8 May 2024 11:08:56 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E5181749
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166536; cv=none; b=Tr+1LCKivmMYborq8trTXhbpBx40CtF09dmBmdwgiEWsJpe0cbfQY4iO6mzG7g0yZA8hAv3RLszRquAjaB0vnSo6urKDLlppj12O9GdHwgrQmKnyihhDD0NiZYM8RosjsgWh7LPKkS5wPUKCXXXJCGGGY+rLh1UwnPNEdGrfq04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166536; c=relaxed/simple;
	bh=/VEH8HbAUQ9vRq1WUQ5QTlx2rcRXtWl9g9yWb1j/h/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jzUCVe2mPHs4CbaGqUkc2NndtAcbXm4zSCJCSxwS3fErnqMyi9M6Qw9bx7HCFr1zldI+cpTSJQ2sZ6BlBhhkEc9YIqz3a8FFQrwp8FjvZ6XzoxjABP+tZmNzw/LSZ9dtLFgnsOCSxU+SqQtmirH9Z8WBdUmVFb2ZBWUpjbzz5DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1s4fAA-0001iq-NQ; Wed, 08 May 2024 13:08:42 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1s4fA9-000GOC-FN; Wed, 08 May 2024 13:08:41 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1s4fA9-000NrM-1B;
	Wed, 08 May 2024 13:08:41 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 08 May 2024 13:08:29 +0200
Subject: [PATCH v2 3/3] mtd: nand: mxc_nand: support software ECC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240508-mtd-nand-mxc-nand-exec-op-v2-3-6b7366b7831f@pengutronix.de>
References: <20240508-mtd-nand-mxc-nand-exec-op-v2-0-6b7366b7831f@pengutronix.de>
In-Reply-To: <20240508-mtd-nand-mxc-nand-exec-op-v2-0-6b7366b7831f@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715166521; l=5562;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=/VEH8HbAUQ9vRq1WUQ5QTlx2rcRXtWl9g9yWb1j/h/A=;
 b=9e3+uvrm0Hv+rOQCGeL/ysM5mV0yTHEE6utD6QipEFWa/qtp47wqMmRquhU1/zJCCpP2A2Iq+
 36uyRsfVo5FDjZHjzQhuvMF1yUAivaeKjnYKu4qCxOhXWPDWk/A0srW
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
 drivers/mtd/nand/raw/mxc_nand.c | 84 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 75 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 1e8b4553e03ba..7004fd57c80f7 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -178,6 +178,7 @@ struct mxc_nand_host {
 	int			used_oobsize;
 	int			active_cs;
 	unsigned int		ecc_stats_v1;
+	unsigned int		column;
 
 	struct completion	op_completion;
 
@@ -1397,10 +1398,10 @@ static int mxcnd_attach_chip(struct nand_chip *chip)
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
@@ -1465,6 +1466,54 @@ static int mxcnd_setup_interface(struct nand_chip *chip, int chipnr,
 	return host->devtype_data->setup_interface(chip, chipnr, conf);
 }
 
+static void copy_page_to_sram(struct mtd_info *mtd)
+{
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct mxc_nand_host *host = nand_get_controller_data(this);
+	void *buf = host->data_buf;
+	unsigned int n_subpages = mtd->writesize / 512;
+	int oob_per_subpage, i;
+
+	/* mtd->writesize is not set during ident scanning */
+	if (!n_subpages)
+		n_subpages = 1;
+
+	oob_per_subpage = (mtd->oobsize / n_subpages) & ~1;
+
+	for (i = 0; i < n_subpages; i++) {
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
+	unsigned int n_subpages = mtd->writesize / 512;
+	int oob_per_subpage, i;
+
+	/* mtd->writesize is not set during ident scanning */
+	if (!n_subpages)
+		n_subpages = 1;
+
+	oob_per_subpage = (mtd->oobsize / n_subpages) & ~1;
+
+	for (i = 0; i < n_subpages; i++) {
+		memcpy16_fromio(buf, host->main_area0 + i * 512, 512);
+		buf += 512;
+
+		memcpy16_fromio(buf, host->spare0 + i * host->devtype_data->spare_len,
+				oob_per_subpage);
+		buf += oob_per_subpage;
+	}
+}
+
 static int mxcnd_exec_op(struct nand_chip *chip,
 			 const struct nand_operation *op,
 			 bool check_only)
@@ -1496,8 +1545,11 @@ static int mxcnd_exec_op(struct nand_chip *chip,
 			 */
 			break;
 		case NAND_OP_CMD_INSTR:
-			if (instr->ctx.cmd.opcode == NAND_CMD_PAGEPROG)
+			if (instr->ctx.cmd.opcode == NAND_CMD_PAGEPROG) {
+				if (chip->ecc.engine_type != NAND_ECC_ENGINE_TYPE_ON_HOST)
+					copy_page_to_sram(mtd);
 				host->devtype_data->send_page(mtd, NFC_INPUT);
+			}
 
 			host->devtype_data->send_cmd(host, instr->ctx.cmd.opcode, true);
 
@@ -1506,6 +1558,8 @@ static int mxcnd_exec_op(struct nand_chip *chip,
 			if (instr->ctx.cmd.opcode == NAND_CMD_STATUS)
 				statusreq = true;
 
+			host->column = 0;
+
 			break;
 		case NAND_OP_ADDR_INSTR:
 			for (j = 0; j < instr->ctx.addr.naddrs; j++) {
@@ -1517,9 +1571,14 @@ static int mxcnd_exec_op(struct nand_chip *chip,
 			buf_write = instr->ctx.data.buf.out;
 			buf_len = instr->ctx.data.len;
 
-			memcpy32_toio(host->main_area0, buf_write, buf_len);
-			if (chip->oob_poi)
-				copy_spare(mtd, false, chip->oob_poi);
+			if (chip->ecc.engine_type == NAND_ECC_ENGINE_TYPE_ON_HOST) {
+				memcpy32_toio(host->main_area0, buf_write, buf_len);
+				if (chip->oob_poi)
+					copy_spare(mtd, false, chip->oob_poi);
+			} else {
+				memcpy(host->data_buf + host->column, buf_write, buf_len);
+				host->column += buf_len;
+			}
 
 			break;
 		case NAND_OP_DATA_IN_INSTR:
@@ -1552,11 +1611,18 @@ static int mxcnd_exec_op(struct nand_chip *chip,
 
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
-				memcpy(buf_read, host->data_buf, buf_len);
+				if (!host->column)
+					copy_page_from_sram(mtd);
+				memcpy(buf_read, host->data_buf + host->column, buf_len);
+				host->column += buf_len;
 			}
 
 			break;

-- 
2.39.2


