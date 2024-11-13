Return-Path: <linux-kernel+bounces-407330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EA09C6C01
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98EC1F21E5D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8300C1FA275;
	Wed, 13 Nov 2024 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PWh73TkX"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414691F9416
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491390; cv=none; b=R1CLgpG4mQGv3n2w4sg7NbxIW22ZsywFRKw2Cv+2rI9e96z/pqk9/fPhaiZCwW9/Q/UAgUgIqOYDJi7Ja7FKx2i0qcBJ8QSN3yHh7f4gKwHywVUC4NLb0b1Czabtpn2wvEpQG0ql3/sXYPXJZKskhjWQLiuDHNDFq0HUWG0se+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491390; c=relaxed/simple;
	bh=pAsRe15o8KtYw/7E0XKTJksMgDoXXLxLoIwfb4FVUuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O9JAdhkVZvO1W1At+3tHHxbGKtFnP/RTYhk0JVvHwVxMs67K+HbF/J3iWYQ3Tvhp78n/Yq7khyLTFhfkLeHUR2qlI2Qbju584CEqVbQJ6+0MzIxZlnkZFJNZBG/2CxKM6q21pouKhlB9kLKRa/yUZupPJmmTVCy0hi4ksSUXG64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PWh73TkX; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 0841DC0014;
	Wed, 13 Nov 2024 09:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731491386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iaf75RKxvR9hDjbOf8OF/9PhJbQC3X5yKc/JDdimNdQ=;
	b=PWh73TkXzIlF6hnNs1QIev1z5a0k70PCKg8O5rG3fqtH9+kpiqlOIAB3iwJfYrsJSDpAPj
	atjVKpSu9FnR8sIdMYIvgPjDm9/FW5as+VVBp2t66Jz4O4sIiwS958u6qnHhOpSLl5VvJO
	JKRdsNA3p4fQGqiNFt5Hwi8gvJbQZyy/8vyMQwEGIOqzkNtjVB9DuD64DKgw0E0RYqRRiu
	7kU3eBeS7JY88rgxYRdGyCwuZCn7I80hOYwvRfLgiygP5A6QCMvB+Utq+5wQ/sj4tnXLKN
	POX6BnLboUm77Ivequb+dVqdkDZyv07509n0CCrB7FDn5yvpBa2TCf9I+XuzUw==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Santosh Shilimkar <ssantosh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Christopher Cordahi <christophercordahi@nanometrics.ca>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH v3 7/7] mtd: rawnand: davinci: Implement setup_interface() operation
Date: Wed, 13 Nov 2024 10:49:38 +0100
Message-ID: <20241113094938.44817-8-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113094938.44817-1-bastien.curutchet@bootlin.com>
References: <20241113094938.44817-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

The setup_interface() operation isn't implemented. It forces the driver
to use the ONFI mode 0, though it could use more optimal modes.

Implement the setup_interface() operation. It uses the
aemif_set_cs_timings() function from the AEMIF driver to update the
chip select timings. The calculation of the register's contents is
directly extracted from §20.3.2.3 of the DaVinci TRM [1]

MAX_TH_PS and MAX_TSU_PS are the worst case timings based on the
Keystone2 and DaVinci datasheets.

[1] : https://www.ti.com/lit/ug/spruh77c/spruh77c.pdf

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/mtd/nand/raw/davinci_nand.c | 79 +++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 563045c7ce08..00627c2783f8 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
+#include <linux/memory/ti-aemif.h>
 #include <linux/module.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
@@ -44,6 +45,9 @@
 #define	MASK_ALE		0x08
 #define	MASK_CLE		0x10
 
+#define MAX_TSU_PS		3000	/* Input setup time in ps */
+#define MAX_TH_PS		1600	/* Input hold time in ps */
+
 struct davinci_nand_pdata {
 	uint32_t		mask_ale;
 	uint32_t		mask_cle;
@@ -120,6 +124,7 @@ struct davinci_nand_info {
 	uint32_t		core_chipsel;
 
 	struct clk		*clk;
+	struct aemif_device	*aemif;
 };
 
 static DEFINE_SPINLOCK(davinci_nand_lock);
@@ -767,9 +772,82 @@ static int davinci_nand_exec_op(struct nand_chip *chip,
 	return 0;
 }
 
+#define TO_CYCLES(ps, period_ns) (DIV_ROUND_UP((ps) / 1000, (period_ns)))
+
+static int davinci_nand_setup_interface(struct nand_chip *chip, int chipnr,
+					const struct nand_interface_config *conf)
+{
+	struct davinci_nand_info *info = to_davinci_nand(nand_to_mtd(chip));
+	const struct nand_sdr_timings *sdr;
+	struct aemif_cs_timings timings;
+	s32 cfg, min, cyc_ns;
+	int ret;
+
+	cyc_ns = 1000000000 / clk_get_rate(info->clk);
+
+	sdr = nand_get_sdr_timings(conf);
+	if (IS_ERR(sdr))
+		return PTR_ERR(sdr);
+
+	cfg = TO_CYCLES(sdr->tCLR_min, cyc_ns) - 1;
+	timings.rsetup = cfg > 0 ? cfg : 0;
+
+	cfg = max_t(s32, TO_CYCLES(sdr->tREA_max + MAX_TSU_PS, cyc_ns),
+		    TO_CYCLES(sdr->tRP_min, cyc_ns)) - 1;
+	timings.rstrobe = cfg > 0 ? cfg : 0;
+
+	min = TO_CYCLES(sdr->tCEA_max + MAX_TSU_PS, cyc_ns) - 2;
+	while ((s32)(timings.rsetup + timings.rstrobe) < min)
+		timings.rstrobe++;
+
+	cfg = TO_CYCLES((s32)(MAX_TH_PS - sdr->tCHZ_max), cyc_ns) - 1;
+	timings.rhold = cfg > 0 ? cfg : 0;
+
+	min = TO_CYCLES(sdr->tRC_min, cyc_ns) - 3;
+	while ((s32)(timings.rsetup + timings.rstrobe + timings.rhold) < min)
+		timings.rhold++;
+
+	cfg = TO_CYCLES((s32)(sdr->tRHZ_max - (timings.rhold + 1) * cyc_ns * 1000), cyc_ns);
+	cfg = max_t(s32, cfg, TO_CYCLES(sdr->tCHZ_max, cyc_ns)) - 1;
+	timings.ta = cfg > 0 ? cfg : 0;
+
+	cfg = TO_CYCLES(sdr->tWP_min, cyc_ns) - 1;
+	timings.wstrobe = cfg > 0 ? cfg : 0;
+
+	cfg = max_t(s32, TO_CYCLES(sdr->tCLS_min, cyc_ns), TO_CYCLES(sdr->tALS_min, cyc_ns));
+	cfg = max_t(s32, cfg, TO_CYCLES(sdr->tCS_min, cyc_ns)) - 1;
+	timings.wsetup = cfg > 0 ? cfg : 0;
+
+	min = TO_CYCLES(sdr->tDS_min, cyc_ns) - 2;
+	while ((s32)(timings.wsetup + timings.wstrobe) < min)
+		timings.wstrobe++;
+
+	cfg = max_t(s32, TO_CYCLES(sdr->tCLH_min, cyc_ns), TO_CYCLES(sdr->tALH_min, cyc_ns));
+	cfg = max_t(s32, cfg, TO_CYCLES(sdr->tCH_min, cyc_ns));
+	cfg = max_t(s32, cfg, TO_CYCLES(sdr->tDH_min, cyc_ns)) - 1;
+	timings.whold = cfg > 0 ? cfg : 0;
+
+	min = TO_CYCLES(sdr->tWC_min, cyc_ns) - 2;
+	while ((s32)(timings.wsetup + timings.wstrobe + timings.whold) < min)
+		timings.whold++;
+
+	dev_dbg(&info->pdev->dev, "RSETUP %x RSTROBE %x RHOLD %x\n",
+		timings.rsetup, timings.rstrobe, timings.rhold);
+	dev_dbg(&info->pdev->dev, "TA %x\n", timings.ta);
+	dev_dbg(&info->pdev->dev, "WSETUP %x WSTROBE %x WHOLD %x\n",
+		timings.wsetup, timings.wstrobe, timings.whold);
+
+	ret = aemif_check_cs_timings(&timings);
+	if (ret || chipnr == NAND_DATA_IFACE_CHECK_ONLY)
+		return ret;
+
+	return aemif_set_cs_timings(info->aemif, info->core_chipsel, &timings);
+}
+
 static const struct nand_controller_ops davinci_nand_controller_ops = {
 	.attach_chip = davinci_nand_attach_chip,
 	.exec_op = davinci_nand_exec_op,
+	.setup_interface = davinci_nand_setup_interface,
 };
 
 static int nand_davinci_probe(struct platform_device *pdev)
@@ -832,6 +910,7 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	info->pdev		= pdev;
 	info->base		= base;
 	info->vaddr		= vaddr;
+	info->aemif		= dev_get_drvdata(pdev->dev.parent);
 
 	mtd			= nand_to_mtd(&info->chip);
 	mtd->dev.parent		= &pdev->dev;
-- 
2.47.0


