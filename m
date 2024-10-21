Return-Path: <linux-kernel+bounces-374198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E10009A66AC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4330BB24808
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E50A1E9065;
	Mon, 21 Oct 2024 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="H7b6tf67";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="W/mZABEX"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598C21E7C18
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729510506; cv=none; b=Ry9YL/FtVH65QUCOxnFQiEccjjfNp/FcekUoweI0HdkdvQt3tNtHkY8s0fQXG8yVpht+/Xieep4I3fFLgvWweeNuLucYG25nQ1YCWgg3vnGnMFS2Ac0P7oOoFzFEVVe9IxhnJjyXNohZlI/j+/OzkX29IBvz6KiH4Lycn3sLmi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729510506; c=relaxed/simple;
	bh=u3MRpfsBNrYEXrrDZiUvwzrIQ0Qj5UhCoBgsuhERX7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQzOsyLMVQRV+JGImxqsDMe1jBfUcdL2yMXda7OXO4U331qAZDVF0sgaSZm7yZdNmyqoEslQIjQoBZNBgpDM1IlIwknJ2EH8nMD0NtZM+M27+0ZC0h0oYHxKNK2s18AZuaTw3b5mJ685gfHrvtow9FoJcOiAdjAuKNL+CYHRZ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=H7b6tf67; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=W/mZABEX reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1729510503; x=1761046503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KgACnBmebNMiSOX9BB+1c3iZLWhclN2SNaXkWrwesu4=;
  b=H7b6tf67wWNROlhWxU8I9v26oTIUqWU0TikXjFbqKBzKyXwsKOVvqKZu
   SAVEelooIgtxI6eW+mAVMHRtMORlWxxU8enmXsw45Y+F1Qa1skZ9Nhvfs
   ZUr7yKvBwAkVxTG7NaKSrL1SidWNgpdDdzBykJ3fHoicXrtDpvEVvKdrv
   b+3vKkPtfMwbuFak0bgTRPxK8O26FcxMiFXkiM/tGrdpCAsgOB2Z+gKTY
   gvcePZvjVE5e2tsdOSwvX8yVP40GOeByrLv9B4zjaccLCd3nMZxh3+qfq
   cR6xCFyJuppAtsk+izadc1Js1a8hPLuYuV3drJcrTaK0e8aBScFVMV+mq
   w==;
X-CSE-ConnectionGUID: tjhLVjZ2QQehU8+7qKnpCw==
X-CSE-MsgGUID: l5a61T0eS56v/FBbBnJ9aw==
X-IronPort-AV: E=Sophos;i="6.11,220,1725314400"; 
   d="scan'208";a="39572174"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 21 Oct 2024 13:35:02 +0200
X-CheckPoint: {67163C66-5-236878CD-F32272AF}
X-MAIL-CPID: 5C26BF51197334E733BC197B0C0ECC93_2
X-Control-Analysis: str=0001.0A682F22.67163C66.0043,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A176116B31E;
	Mon, 21 Oct 2024 13:34:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1729510497;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KgACnBmebNMiSOX9BB+1c3iZLWhclN2SNaXkWrwesu4=;
	b=W/mZABEX33Kbwo4ePm5+xRaEYXiEjxAC6M62o1l5L8t+JFZDFPOgGWLaGfpqPEv1m/EG8Z
	MKgs21krhhxsbt7ju92xrBZc5p2E4Yuw4OkyzJb9cs1fvOvNeRiQZhbDO6Vq6gjnMfmcxi
	VyNDecwMgxSelpZied9EbH3ur0iX5X+EJJX6d98jAWnL8Ho2V9Yd7lneEq+CNpNvhtCgWQ
	+EDtsXG9d1BOhsQFsDpLZHcKZJl1Fm2Zrxntyk5o3f8Agn0zsvemgfMWrvw0VG/wJAMAUI
	VzVlQqA1+/1GCdkWEO0QhSJEm9sEhXwNlkkF47cbCEmybgrWpEBzzIfduP5pZQ==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Gregor Herburger <gregor.herburger@tq-group.com>
Subject: [PATCH v5 3/5] mfd: tqmx86: refactor GPIO IRQ setup
Date: Mon, 21 Oct 2024 13:34:25 +0200
Message-ID: <a57c06afc7de9dfc199a0626df40396d471d2233.1729509613.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729509613.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1729509613.git.matthias.schiffer@ew.tq-group.com>
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

