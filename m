Return-Path: <linux-kernel+bounces-312241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230389693F2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C124B21BFA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4382B1D54D0;
	Tue,  3 Sep 2024 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OjBk0Njc"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551231D54C9
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 06:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725345783; cv=none; b=DcyYdZDgLyvTU23AZ9RfTXUQvMhxwmGP5ZR+2AbMF+K9LtUzznyTCIn3LgkE36GPjgrW4JIbDE8t93S6HKTemouTBAeIYj70NYQhM/4tLuPwZ3bCT9OHDcPR4b67/iIqJsv/knXdlaP0YKlbMBEW/rdeoPouI+vUWA11l9sXEaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725345783; c=relaxed/simple;
	bh=gL9dZp5U38zASfkVhT0h6bfIfXahRLMY3SOEI2yl+VY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSu8sWnlZNkCxswg8X1ErG3EpP51q19II+RcNgPrK2tke+Z/1CNF/IKpNneBWiDVXZsLIelLuZ5RAt88PXRG4Yrh48tUm4xpvNnQOBqg/b61mJw0nEdjn2P3b6LRg8bUZJmlSo21LnzV6Ikiv5DTqkvbWEPS4r8wtj/wi0dalFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OjBk0Njc; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725345782; x=1756881782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gL9dZp5U38zASfkVhT0h6bfIfXahRLMY3SOEI2yl+VY=;
  b=OjBk0NjchhVQPm2sj9FALd0p9JUd9Acq1/Gti6OuzJYPsD7VEGH6s8hH
   KuUI94pAh2VQK68RwhkOBeYaNMkTWjIzpUDlmp6jX0v4Jd1KQduRxTtPC
   RmICCylJvyxXU93oXfXh+bC8W5IbUJT3qa+75v3Du0roeYwCBVs4TnIhG
   b1TzdUJAAl0v9Y2fSSVR6bXBh958C+PdZsq1ZbBE4o8a58v8KiJF2lXNs
   9pNviaFG1+FJc7f3yIUT3quyE5WUUKnS70KgPNsvq5RovzGrCEnBu8ESP
   quU77yq64i3e7JxMt8VxB90P8yljU7KiQAeSuYDco6fSMO7L/+XT87Q9i
   Q==;
X-CSE-ConnectionGUID: j0abaAbSTdKNTu62ztN/1Q==
X-CSE-MsgGUID: atbhysjgR6unHOnZQokCPQ==
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="31877353"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 23:43:01 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 23:42:55 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 2 Sep 2024 23:42:52 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <tglx@linutronix.de>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <varshini.rajendran@microchip.com>, Hari Prasath
	<Hari.PrasathGE@microchip.com>
Subject: [PATCH v7 04/12] irqchip/atmel-aic5: Add support for sam9x7 aic
Date: Tue, 3 Sep 2024 12:12:52 +0530
Message-ID: <20240903064252.49530-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240903063913.48307-1-varshini.rajendran@microchip.com>
References: <20240903063913.48307-1-varshini.rajendran@microchip.com>
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
Changes in v7:

- Removed the line break in the function.
---
 drivers/irqchip/irq-atmel-aic5.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index 145535bd7560..f9168efa4160 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -320,6 +320,7 @@ static const struct of_device_id aic5_irq_fixups[] __initconst = {
 	{ .compatible = "atmel,sama5d3", .data = sama5d3_aic_irq_fixup },
 	{ .compatible = "atmel,sama5d4", .data = sama5d3_aic_irq_fixup },
 	{ .compatible = "microchip,sam9x60", .data = sam9x60_aic_irq_fixup },
+	{ .compatible = "microchip,sam9x7", .data = sam9x60_aic_irq_fixup },
 	{ /* sentinel */ },
 };
 
@@ -406,3 +407,11 @@ static int __init sam9x60_aic5_of_init(struct device_node *node,
 	return aic5_of_init(node, parent, NR_SAM9X60_IRQS);
 }
 IRQCHIP_DECLARE(sam9x60_aic5, "microchip,sam9x60-aic", sam9x60_aic5_of_init);
+
+#define NR_SAM9X7_IRQS		70
+
+static int __init sam9x7_aic5_of_init(struct device_node *node, struct device_node *parent)
+{
+	return aic5_of_init(node, parent, NR_SAM9X7_IRQS);
+}
+IRQCHIP_DECLARE(sam9x7_aic5, "microchip,sam9x7-aic", sam9x7_aic5_of_init);
-- 
2.25.1


