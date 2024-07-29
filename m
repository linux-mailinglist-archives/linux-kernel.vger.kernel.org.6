Return-Path: <linux-kernel+bounces-265222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D820A93EE1A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76EA81F2440D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ED884DEB;
	Mon, 29 Jul 2024 07:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MKZHoo38"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAF982899
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236946; cv=none; b=KUFhFoA4DrzFgGvtq43NgKBTe6qXfGki/HcgcVRyloy78aeF9CRjBkUJo3qDgIYnO1HuaRDlj6de1y+WXMx60n7r3ngfYAoAtrtxBsHg+W2LrhkJt8V/Sylc1MSn1jEL5DIf3ZANcKQa3qwwVAdZ9GbxhLQdotLFAWj/4NWLpTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236946; c=relaxed/simple;
	bh=FVK9wR6Wo6gRh2hzH07gqe36H17j5T1xR0c0wlKxflk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/1jl3QRwYR8mlVEW+9EReg60J37D2sMNmeHxyyLB8+jyonnKJjnnfaxkj1EP4Ky9tFJv+cpu+kbMs7mRdUi3iL2E4gwYWN7M6hBJif8x/xdEHso3+qDbNtZeKsTQyeiI7mtZzOQqxHQAkjZBRH7cmw8Z8rTx+6TgoLYFLK2nI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MKZHoo38; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722236945; x=1753772945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FVK9wR6Wo6gRh2hzH07gqe36H17j5T1xR0c0wlKxflk=;
  b=MKZHoo38i7QvK05Jy7YT3Ow0QzlUwux3Jz4ZOxEzzCpX48dnnRN3W7rS
   3hBse0YrsJMnXWeGbZkSUKLZGhE8BDgu2X4QnQ4MfbF2PTU4a7Js0uIhZ
   b3qIUqZ0SlIaqDS7NRPtuKs6QniQkVkB6IDFL7FmI5ZJxa0BATznwMNgh
   cd+T+HWphigHkAbDUBiGYIrJCRbkjphO12Js1I2ug7rm12SzxQOvvl4ni
   gVipC2pgHAZoBy6vERY46fh9DcslzFJbTa0j7Ap+vjLktpKZvbnyK4QeL
   WE3/EI2lyEPU4kU3bCTKPIwEWfjOdL6is+lU/qbrVfzb0TXB81+3jHG7x
   g==;
X-CSE-ConnectionGUID: /xcbkqlfTo+UjYKU1jzHkw==
X-CSE-MsgGUID: xk0+ohGQRdCqf5XaAZK3lA==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="30454158"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 00:09:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 00:08:36 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 00:08:33 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <tglx@linutronix.de>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <varshini.rajendran@microchip.com>, Hari Prasath
	<Hari.PrasathGE@microchip.com>
Subject: [PATCH v6 17/27] irqchip/atmel-aic5: Add support for sam9x7 aic
Date: Mon, 29 Jul 2024 12:38:29 +0530
Message-ID: <20240729070829.1991064-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Hari Prasath <Hari.PrasathGE@microchip.com>

Add support for the Advanced interrupt controller(AIC) chip in the sam9x7.

Signed-off-by: Hari Prasath <Hari.PrasathGE@microchip.com>
Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
Changes in v6:

 - Reverted back to the patch in version 3 considering the complexity
   involving in using DT match data.
---
 drivers/irqchip/irq-atmel-aic5.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index 145535bd7560..bab11900f3ef 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -320,6 +320,7 @@ static const struct of_device_id aic5_irq_fixups[] __initconst = {
 	{ .compatible = "atmel,sama5d3", .data = sama5d3_aic_irq_fixup },
 	{ .compatible = "atmel,sama5d4", .data = sama5d3_aic_irq_fixup },
 	{ .compatible = "microchip,sam9x60", .data = sam9x60_aic_irq_fixup },
+	{ .compatible = "microchip,sam9x7", .data = sam9x60_aic_irq_fixup },
 	{ /* sentinel */ },
 };
 
@@ -406,3 +407,12 @@ static int __init sam9x60_aic5_of_init(struct device_node *node,
 	return aic5_of_init(node, parent, NR_SAM9X60_IRQS);
 }
 IRQCHIP_DECLARE(sam9x60_aic5, "microchip,sam9x60-aic", sam9x60_aic5_of_init);
+
+#define NR_SAM9X7_IRQS		70
+
+static int __init sam9x7_aic5_of_init(struct device_node *node,
+				      struct device_node *parent)
+{
+	return aic5_of_init(node, parent, NR_SAM9X7_IRQS);
+}
+IRQCHIP_DECLARE(sam9x7_aic5, "microchip,sam9x7-aic", sam9x7_aic5_of_init);
-- 
2.25.1


