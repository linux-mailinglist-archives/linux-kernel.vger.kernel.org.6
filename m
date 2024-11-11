Return-Path: <linux-kernel+bounces-404186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BDE9C4066
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07052282087
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1586219EEBD;
	Mon, 11 Nov 2024 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="QNsYumTa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="pt6Xlqe5"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BAA19E994
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334293; cv=none; b=pFtvvLYTphFQOU0y3yyz/5cBSCAmaVaz4OJXzM3nd2anWXxym1hCgyUwIyzYhm9wIcDycJYeUZLrqtUe197MuiVCdrmGpUro1Vyi2oHKFj9p6viyJjekkyZ5/cHnM3q2f64NhqOSN2i8Y5KXiJ4MsRgxtCF7KwH+8tUBmgdnT70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334293; c=relaxed/simple;
	bh=gIh7lYJhjdwEB6o0CMbk7+fNUZDgwxrM0xnBIj2h/yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pa+IPBmuhXLWYqdNnmJJ1gFAKHHTPbpubYmBzhNmvtJK11FLpFTK9TPaGFav4jB+tUsNJZwHH3z0TSnXx7pCcymXqWcDICZMdPU1qa5Dn9YE5o1skZ8QxqRnPMimsfUaVSn+8BCCkmTsjOcJIhLNz/Wve9Jc776dADr/N+iyXec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=QNsYumTa; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=pt6Xlqe5 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1731334291; x=1762870291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dIS1lbG7c6C/vU5J2SbrsblVLx097u4g8m6ETG4O3Fk=;
  b=QNsYumTap3NhAMBOmsJl4XzQRW5jbQ8wjq66thKXb0qgx8pRvU40h3By
   RREdYx8RmuHjdX2vMFlMSzL1VOFXOL+/7M7wIAo5DQpdKraY/XOKhWBPg
   PvA0QXm/AnSK1mWSqjF03y95rhxb+VNPrQ4xxpdpyoJshnVenD2Id/ar7
   gDAnIKx+7u0JTeVjPiVYCLCOhoQx9a3Lq6G6ekieuqtn0LrZnRWydqNHT
   G+OGPW3e2LjWY0i/y3BA7Dvq3J/wdoiJaxFY14qSaOU4OPsVPt4/LXJBz
   Im/pkAll53BCP0KejPkdCArI/NLzSLwfHhYaP72uokOWPzScra78fsXUA
   Q==;
X-CSE-ConnectionGUID: lvkK2jq1TduO/qON9O82dA==
X-CSE-MsgGUID: l1Wq/vY4Q+qAMX/KM4N/Ng==
X-IronPort-AV: E=Sophos;i="6.12,145,1728943200"; 
   d="scan'208";a="39967038"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 11 Nov 2024 15:11:29 +0100
X-CheckPoint: {67321091-6-5736D786-D50827BE}
X-MAIL-CPID: 9B16DB72AA8E0405E61ABB9BCE762DA0_2
X-Control-Analysis: str=0001.0A682F27.67321091.0060,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AAF2A166E0B;
	Mon, 11 Nov 2024 15:11:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1731334284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIS1lbG7c6C/vU5J2SbrsblVLx097u4g8m6ETG4O3Fk=;
	b=pt6Xlqe5NDg1PI/TKe59awBPOkJKybhQc2gFTOCJjIwW8QVTSdVcqmPm/rfxHpbcaMx5GS
	LdVXS+f+9se4B8DgCEqZs+FhjbCGqxl7nFILaFHMcBl253wHXnyEI8Uvk7tOHxQYKQNGZn
	XPNQCbGGxBBkRvIHWnUIg5921I2I4ZpRt5aPQvpnPrrFVbBZKU3s7+6qMzgHtj/5M/R7mG
	iw9RLGaBkR0C6IW+F7fyPlRXLSVL++WN7TZ7kxz4RUYXuyvxgomfOqwy51BHTfEB7fF+iw
	IFRWyj0ac17hNf75LMIWhIh0hYqB0H2cYlzP3Q/d6PSB7Wz+mvRqdztPxsv8fQ==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Gregor Herburger <gregor.herburger@tq-group.com>
Subject: [PATCH v7 3/5] mfd: tqmx86: refactor GPIO IRQ setup
Date: Mon, 11 Nov 2024 15:10:30 +0100
Message-ID: <97f481334f480a113b7076e76f994e0e73ee5aa5.1731325758.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731325758.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1731325758.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Move IRQ setup into a helper function. The string "GPIO" for error
messages is replaced with a label argument to prepare for reusing the
function for the I2C IRQ.

No functional change intended.

Co-developed-by: Gregor Herburger <gregor.herburger@tq-group.com>
Signed-off-by: Gregor Herburger <gregor.herburger@tq-group.com>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/mfd/tqmx86.c | 59 +++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 22 deletions(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 7b2f9490a9af5..8aa448a67c9a5 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -186,33 +186,52 @@ static int tqmx86_board_id_to_clk_rate(struct device *dev, u8 board_id)
 	}
 }
 
-static int tqmx86_probe(struct platform_device *pdev)
+static int tqmx86_setup_irq(struct device *dev, const char *label, u8 irq,
+			    void __iomem *io_base, u8 reg_shift)
 {
-	u8 board_id, sauc, rev, i2c_det, io_ext_int_val;
-	struct device *dev = &pdev->dev;
-	u8 gpio_irq_cfg, readback;
-	const char *board_name;
-	void __iomem *io_base;
-	int err;
+	u8 val, readback;
+	int irq_cfg;
 
-	switch (gpio_irq) {
+	switch (irq) {
 	case 0:
-		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_NONE;
+		irq_cfg = TQMX86_REG_IO_EXT_INT_NONE;
 		break;
 	case 7:
-		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_7;
+		irq_cfg = TQMX86_REG_IO_EXT_INT_7;
 		break;
 	case 9:
-		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_9;
+		irq_cfg = TQMX86_REG_IO_EXT_INT_9;
 		break;
 	case 12:
-		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_12;
+		irq_cfg = TQMX86_REG_IO_EXT_INT_12;
 		break;
 	default:
-		pr_err("tqmx86: Invalid GPIO IRQ (%d)\n", gpio_irq);
+		dev_err(dev, "invalid %s IRQ (%d)\n", label, irq);
 		return -EINVAL;
 	}
 
+	val = ioread8(io_base + TQMX86_REG_IO_EXT_INT);
+	val &= ~(TQMX86_REG_IO_EXT_INT_MASK << reg_shift);
+	val |= (irq_cfg & TQMX86_REG_IO_EXT_INT_MASK) << reg_shift;
+
+	iowrite8(val, io_base + TQMX86_REG_IO_EXT_INT);
+	readback = ioread8(io_base + TQMX86_REG_IO_EXT_INT);
+	if (readback != val) {
+		dev_warn(dev, "%s interrupts not supported\n", label);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int tqmx86_probe(struct platform_device *pdev)
+{
+	u8 board_id, sauc, rev, i2c_det;
+	struct device *dev = &pdev->dev;
+	const char *board_name;
+	void __iomem *io_base;
+	int err;
+
 	io_base = devm_ioport_map(dev, TQMX86_IOBASE, TQMX86_IOSIZE);
 	if (!io_base)
 		return -ENOMEM;
@@ -233,15 +252,11 @@ static int tqmx86_probe(struct platform_device *pdev)
 	 */
 	i2c_det = inb(TQMX86_REG_I2C_DETECT);
 
-	if (gpio_irq_cfg) {
-		io_ext_int_val =
-			gpio_irq_cfg << TQMX86_REG_IO_EXT_INT_GPIO_SHIFT;
-		iowrite8(io_ext_int_val, io_base + TQMX86_REG_IO_EXT_INT);
-		readback = ioread8(io_base + TQMX86_REG_IO_EXT_INT);
-		if (readback != io_ext_int_val) {
-			dev_warn(dev, "GPIO interrupts not supported.\n");
-			return -EINVAL;
-		}
+	if (gpio_irq) {
+		err = tqmx86_setup_irq(dev, "GPIO", gpio_irq, io_base,
+				       TQMX86_REG_IO_EXT_INT_GPIO_SHIFT);
+		if (err)
+			return err;
 
 		/* Assumes the IRQ resource is first. */
 		tqmx_gpio_resources[0].start = gpio_irq;
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


