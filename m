Return-Path: <linux-kernel+bounces-201833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD7A8FC415
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE3A3B28CCD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE27418C35C;
	Wed,  5 Jun 2024 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="lOgiiA5s";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ivHTQ/oa"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D332E18C320
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571080; cv=none; b=sz4EcUs5rsHJZ33Y0TpWn5bztIV7mflaJCQYqcz6Z7QuxBqLOwAnMB5Dw4f2S4IgM0SUvF0VnADlhyUTHlhOFDcPXYgust7OgU9uHNYJ5EC+83WFr0li5QSwEw2o1P6xp8ZkUpvTGWuvplqTTqowY8UcyaAXPKHdkC96mNqyAao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571080; c=relaxed/simple;
	bh=MSYbOF+Kb4SwnQBv7PGPK+r/ASIbMqS8+0z+eTOLlcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTGOhBjlM3fiiH624W0mpH4kO2g+vA8tmsOclLXM8RdZxuMJb2vElfN81L048aNrGg4KE0Gcy7AN5QqLoInmfgO7FCrxpU/CaFm0YZQy5wPMSVunXmx2NT5+9YlyedkShJH7mXw6j+XbwjV0GLyWVc13oJr2cEaWbKloUwJaWWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=lOgiiA5s; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ivHTQ/oa reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1717571078; x=1749107078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4N4IDJ4Wvs5Fx3WM40i/FR7jIIsQ+8SGLATcwB8Pa1Q=;
  b=lOgiiA5s0QS0+AyEQwBW5h4WQf5EImOTk9Lzz6nisqZHblGysFpXvswX
   ib1rW385rm22Ur0ZQy+QuAxVJgNdwPF+Wn0wS42lzD7jjQDQFsOgkJtaV
   zuIB5szHHI/NVe7fZ/1hzXDWyAFoWNEQFwnfVg4erNQ3z9Em0JoIVN/sd
   w1EznihvdMCSqWqX+weSCLu39CHLEX9XCuSB7I2gyPYK8UUUGLlpVNURC
   xIE73iHzGMLTu5rrq07kZjigbDBQqyBi0ekoSGqNiOLRZHnhfOCxS86BN
   zfN264Vu258CmDorsKUirDhFRS9zqRfqFzRwURWB2Y7hqY4lGGbR6PaY1
   g==;
X-CSE-ConnectionGUID: BnsGwRZvR0qxfw2OiSRwbQ==
X-CSE-MsgGUID: 8Ckq79dVTOiz9wJPUYZNaQ==
X-IronPort-AV: E=Sophos;i="6.08,215,1712613600"; 
   d="scan'208";a="37226796"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 05 Jun 2024 09:04:37 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 40B371731CE;
	Wed,  5 Jun 2024 09:04:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1717571073;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4N4IDJ4Wvs5Fx3WM40i/FR7jIIsQ+8SGLATcwB8Pa1Q=;
	b=ivHTQ/oa06X3Ftoxbug7xmF231Q20RsgXCLgkjsm78oKoJVetY7FPLIYWvb8bbSvqFgnfT
	qHbHPsM4nefie6BZYPWlAFqqx+DhLWhk5vYk3n4Ybe2YjFroBJTs4fuZbLCayb10iATlKs
	ovoQugH2e+pnhCb/DHbzYxJwPVtpiYIlpnIyDSUwBoPBW1abTfotwxGWcsPQfSQmwbVBI5
	+2xyx5KUqTkeDKUJ1djmxV/mNciPsjJVuwW4ZihHONBiuiF/inuSC8FaVcSosJTTOOMO6+
	qvhJTDLxWSIswlvoDSqUZpM0ZzeWFPa1cqYMsx9KBKiOxBfJGbLQRwTNjwZiEA==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 2/4] mfd: tqmx86: refactor GPIO IRQ setup
Date: Wed,  5 Jun 2024 09:04:01 +0200
Message-ID: <a92645664f0906965031a2cad5ff2ed017b4e542.1717499766.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1717499766.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1717499766.git.matthias.schiffer@ew.tq-group.com>
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
 drivers/mfd/tqmx86.c | 72 +++++++++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 27 deletions(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index e15b9be98c2db..2a4ce114d5905 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -186,32 +186,54 @@ static int tqmx86_board_id_to_clk_rate(struct device *dev, u8 board_id)
 	}
 }
 
-static int tqmx86_probe(struct platform_device *pdev)
+static int tqmx86_irq_to_irq_cfg(struct device *dev, const char *label, u8 irq)
 {
-	u8 board_id, sauc, rev, i2c_det, io_ext_int_val;
-	struct device *dev = &pdev->dev;
-	u8 gpio_irq_cfg, readback;
-	const char *board_name;
-	void __iomem *io_base;
-	int err;
-
-	switch (gpio_irq) {
+	switch (irq) {
 	case 0:
-		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_NONE;
-		break;
+		return TQMX86_REG_IO_EXT_INT_NONE;
 	case 7:
-		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_7;
-		break;
+		return TQMX86_REG_IO_EXT_INT_7;
 	case 9:
-		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_9;
-		break;
+		return TQMX86_REG_IO_EXT_INT_9;
 	case 12:
-		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_12;
-		break;
+		return TQMX86_REG_IO_EXT_INT_12;
 	default:
-		pr_err("tqmx86: Invalid GPIO IRQ (%d)\n", gpio_irq);
+		dev_err(dev, "invalid %s IRQ (%d)\n", label, irq);
 		return -EINVAL;
 	}
+}
+
+static int tqmx86_setup_irq(struct device *dev, const char *label, u8 irq,
+			    void __iomem *io_base, u8 reg_shift)
+{
+	u8 val, readback;
+	int irq_cfg;
+
+	irq_cfg = tqmx86_irq_to_irq_cfg(dev, label, irq);
+	if (irq_cfg < 0)
+		return irq_cfg;
+
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
 
 	io_base = devm_ioport_map(dev, TQMX86_IOBASE, TQMX86_IOSIZE);
 	if (!io_base)
@@ -233,15 +255,11 @@ static int tqmx86_probe(struct platform_device *pdev)
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


