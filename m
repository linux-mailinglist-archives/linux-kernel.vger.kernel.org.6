Return-Path: <linux-kernel+bounces-217292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C233D90ADE1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BE91F22760
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9745195F1A;
	Mon, 17 Jun 2024 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="p8UtMbM4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="hQjC8wI5"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8307195F13
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718627058; cv=none; b=sam+6Z7Jz/z69MAKJuzvJoadyrYQYfQQBdwWvu1JFSaNLeCjYtXk6UeTBQRVCaUHXC3v4l3kKj6+NY9/7qSPMdkJ9QCDpifpmwSPngRvA3DCu0wpEdl+Z2ukuSjEmN7kssPPHnAJrWYwOYBm6nNVBQnrGrvOni75QlIqVCcv4N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718627058; c=relaxed/simple;
	bh=QTEKVH8V6pUgNYJW1mLsKpSOI9Y59pl4lBPhSf/EQsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HCsKE0wlNZLguN3yM/LJyLKE06SOfyH5eJNv/Mk0OkqEMCnYrOH6uIEDC7qgf6VWW80OgfFp/r7jY5Zq5ehl7eoql0ghue0PFJlV9C5Z6WFhMMiEcPDpX9TjPG/llVXxtj/udBogGtJqOjMpcv/TXSlN8WbYlAiGp02P+XxnRew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=p8UtMbM4; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=hQjC8wI5 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718627057; x=1750163057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NbCdLsmW8Eg9TMc5xLyqdOHFeANU2e7q5Z0rnhqLNDE=;
  b=p8UtMbM4mqDl4dWbbWz86mQOqorNpU2OzPjFfATr2OQw5n1gEPe8vbQg
   GqiP2NXoGqRC5FJljKmW+u55Wv7bPhkfFOvCnhxaueKoC7DGsDhGCeTK+
   Hc+waXu0QWYfDhkkzsnIPHfEHG/NG4/5Hkqg+rI6yb6+TPATEJ6hA1VWv
   OpoP5esSnm13bp4urT+g1sN23wzosIEy4pZL9mC84v4JZXAJwIEcjf98f
   lr3M4X3LiCIHG8r+U6Ot8NicIaUlOjtB6Wt9orlfklbgvE0VDzOqvsklG
   i9/x55RRFEAO6Odh/HqKr+7yc3DinTE9liTFkgIQmPVfz0l0wReOR79TJ
   A==;
X-CSE-ConnectionGUID: +EHDVoTKSQ69sANdr/uGjg==
X-CSE-MsgGUID: dFpdUzQeTheWAJehqBbXrw==
X-IronPort-AV: E=Sophos;i="6.08,244,1712613600"; 
   d="scan'208";a="37427054"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 17 Jun 2024 14:24:14 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7B9AE165844;
	Mon, 17 Jun 2024 14:24:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718627050;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NbCdLsmW8Eg9TMc5xLyqdOHFeANU2e7q5Z0rnhqLNDE=;
	b=hQjC8wI5i0gJZjc0KTAJhLUesRsasNyI4Xg9LRbJokAicPipwHVej5UJxh/K6OTAGjGxib
	hMhaY/M2PtiIXBScK+iu97Bwvcuh+031viISuxWbeX4L8lc0u/yuiSsBYk9YOpjpZJ0DsI
	hWP6nQnVHm2d06cHMpLDptNMecOqS4wolNepwxQOmJMDmNn7jhQw1yq6kW8EUPB6XRK3wf
	29pa8e6zhxe0icqN0FDchJGuSx64EReXuZjflsfEjUZ/GHTgmQ37ow0l8T38E4+k1Aidvh
	EUFqDdRaDxQkU7Zjr4EdGBtTgEv3OSygrC+7k+DjtXA1VXazD1nzpOvQsN8Fvw==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 3/5] mfd: tqmx86: refactor GPIO IRQ setup
Date: Mon, 17 Jun 2024 14:23:00 +0200
Message-ID: <69fbb0980f8c7158bf9ea48d0bd9869a606f126a.1718626665.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718626665.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1718626665.git.matthias.schiffer@ew.tq-group.com>
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

 drivers/mfd/tqmx86.c | 72 +++++++++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 27 deletions(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 7b2f9490a9af5..5aa51ead00a28 100644
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


