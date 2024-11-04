Return-Path: <linux-kernel+bounces-394712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7999BB318
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12317B23F3E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABAE1D5AD8;
	Mon,  4 Nov 2024 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="aQrSioLm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Ds17FoDA"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1028A1D5ADC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718859; cv=none; b=oJzNyJYoU9vbvcWaQb84N8NfBTNCgvseVdnThPzt3jvw1KUZ9r6K3bDLO/smK7ZLVLL/tUZY6aJSbdzU/izgXPRo9kZaSo8PUChY6yt7vcU+cPuLRJr/zzNuuxdCZrq4TUAyUoC9lDZiUK6vNsHIQImVNozEwhfFkDiZ3wbj2BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718859; c=relaxed/simple;
	bh=rw5E1JB4nC83lqxQB5uqt2dDZtOE0yVDEk+EO/U051k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5cqqsKxbzC79qgv33wZAs8aqXAbQ2w48S/CUXu9VEl6yiAOCOYIHf3VoAMJOFcZFEIUQvhC+WX7GAbpOgfalBVyz3Mtaf7aiG8av9WJvl7VIdyANkPnfckwOxGm6xYRSRHAhu6r86JXw06w73lUfechK6p1bGpFHH/GPe3UJEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=aQrSioLm; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Ds17FoDA reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1730718857; x=1762254857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JRajhXc19FFguiO/eykwy5/WHEj90rgmbEAe6gvC+/s=;
  b=aQrSioLmjX3PngJk0ibj8/L+bdHvk5jlkxRPli0c4nyWfImDSQ55qdGi
   shKsFHDijC8B8SsLLz10e4mI4yp2MwR3MNJhbdvJGY9rn1r1whaNmNqqA
   gnBPG2p+9Phu+hF7sNbUrXLKQ6lTS9vZuLqdxFz9GV5MuncInmZX3iAks
   iI8OkmtmVg9sv8nlWPr5hVc0RsgoD0i4Y3Eg3xHW8IQMFN4jnRtKaDVFj
   lUkTHDGOGh7FE+lLVUvZiLrS9Wxu7OknN8nub0YA+FnN7EDkWJs9o5vDx
   0bLU32r55HC3G5YkQAztzj7Fm2pghdv/m95JfvRWft3bQIFngH023Yuqy
   Q==;
X-CSE-ConnectionGUID: CjdqhJBJTe2trBruytQheQ==
X-CSE-MsgGUID: yrlXdFzwTI+corC2gxcDyg==
X-IronPort-AV: E=Sophos;i="6.11,256,1725314400"; 
   d="scan'208";a="39829945"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Nov 2024 12:14:14 +0100
X-CheckPoint: {6728AC86-2C-90CD5875-E0265C0B}
X-MAIL-CPID: 294B8A3FFA2196C0A0CC6B23B8CE5514_3
X-Control-Analysis: str=0001.0A682F1C.6728AC87.00D2,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4762416A004;
	Mon,  4 Nov 2024 12:14:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1730718850;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JRajhXc19FFguiO/eykwy5/WHEj90rgmbEAe6gvC+/s=;
	b=Ds17FoDAy4UWrRM3aUODvZCcM6ce0A/nmynr4keKlnVjj1U1+GbXT0a0Htm/fu9N+q40jh
	Lze2xw+IC/owofoIPxeP5aHVnKGt/ISIcHekCzl4rPXHa+kS6cpfqfL/2JNhZeYHl3ySKp
	5yJmK8aiqrk03LCLsGe/J67btdQV0oGSxCQmb1K+BbjI256odtGdWqhXjXFrllRiTo6FDX
	3WkKNFdsAv85hpe0Dk616dwy4/ADaH7248fz7SiW09xKmAW63OHwikrHi6ugBHsrqmVzYu
	YdYBtCPqihmu3mbv0fgLkP97jk/Z3MWCNlimta+Lk88VwFWJiujB9VtiMJWLmw==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Gregor Herburger <gregor.herburger@tq-group.com>
Subject: [PATCH v6 3/5] mfd: tqmx86: refactor GPIO IRQ setup
Date: Mon,  4 Nov 2024 12:13:31 +0100
Message-ID: <97f481334f480a113b7076e76f994e0e73ee5aa5.1730717841.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730717841.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1730717841.git.matthias.schiffer@ew.tq-group.com>
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

v2: no changes (was patch 2/4)
v3: no changes
v4: drop tqmx86_irq_to_irq_cfg() function, handle IRQ-to-register-value
    mapping in tqmx86_setup_irq() instead
v5: no changes
v6: no changes

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


