Return-Path: <linux-kernel+bounces-430893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 194BA9E36E2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBBDE28585D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683A21B395C;
	Wed,  4 Dec 2024 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DzYtog0b"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A32A1AF0DB
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733305412; cv=none; b=qWHgtc/PkWdCRUnoimdzuga4vigzqWHWj6nEQot3mzpSMxGIZH83GQijn6uos51lekn8LFYgbjrVJQ2eDjDvaIXP7CJpDo0PuXBmUY4qvlX/q7qcxWQmZlQqpKrY/njGnTQya8YqDRxta0uvTickGPuYXdPobnV/I4czkv6V2nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733305412; c=relaxed/simple;
	bh=OwZHJITJWKF1GqDDdybsKjjC7vHVm5QA33jv8WUR7xU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrVAkt/hXsS6lOZmJzpwjonu7t8YwXC3u2R/i23gssKVYFZehx5Dy6HY2hjQR77kJdd9y2oMUtSsOxb9XDTpPibnUVWqi25jtekgnp+U+v2/6CEK5IcSUWPqj+7g+Hj5MYDUDg+C6IQ2qn7XUcqYnZodKq8NHVt9ANSPtqIHy6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DzYtog0b; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 64FF560015;
	Wed,  4 Dec 2024 09:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733305409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MxgwQZm4INWNx3/RR7QESwiQmqttZVbjI7EwJ1ZjPKA=;
	b=DzYtog0bueaVgZZ0doooO5zlK8cTc+Lsf0GBQ+Hx4VC24h9s0DGz1DFtDT8VFYqMHLLsMt
	5aDhV0pMVYZ537JsFzaHeqizlffjXt6w76WEySENLV+Wf1LADuvxI2zig2ty9qFH0zomhV
	q4DWBY5dqRqQmek2grrmcd19D01qLXFcymKB85hN/KbN+BgtVN8+wgAlMTziOPsmXtwVGs
	PhC4FxN01/f1EYNUGolMjEBXVJydGRgmPt8jt18uR2AJpH+nDZON35pHCuMp1ny9xSqEbI
	5xvMMuT2WNYR8qniJ07e24zuLAHyzGwegjbA4NTV2rPcqfSCj53eeaCIrX7QMw==
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
Subject: [PATCH v5 9/9] mtd: rawnand: davinci: Implement setup_interface() operation
Date: Wed,  4 Dec 2024 10:43:19 +0100
Message-ID: <20241204094319.1050826-10-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204094319.1050826-1-bastien.curutchet@bootlin.com>
References: <20241204094319.1050826-1-bastien.curutchet@bootlin.com>
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
index 4fb5c2623f5a..2a1b3cd49415 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
+#include <linux/memory/ti-aemif.h>
 #include <linux/module.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/rawnand.h>
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


