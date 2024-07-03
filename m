Return-Path: <linux-kernel+bounces-239264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB7192589D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 194ABB294FE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2131741C0;
	Wed,  3 Jul 2024 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="u0dJ5i4p"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D020516F0E6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002528; cv=none; b=RaQyDKqNEFSn6rFnDo92CKUamBfh3RQ2suSoeN63J+qhtUx/GDCEkVmFNf5iLpwVfaf/xW8du/pqfOER+WMBJFSX+Qmqcf1AQz2CIoyOpVAZfxituLH85O10lL96kP2h4pPKuOCVRjrXEEc9FvpxLztUELjil/xZy3ZAi5Nfunw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002528; c=relaxed/simple;
	bh=XD4Q7cZLicWEz0JXcKOPLuwfCe9wBLZj9EmkWqD4OZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqJzb59ldRLL4tw7x2/q5oOFZDYXJhiuONtJJYd1zyDdH5awpebhxEBA+KKaTNWcGueYyQ9vw4N8kuPxHmu3V31aYW3FMDjHUJjhJ/AtzLFM07f0kpEwP6ocvnEmB9ngBHxECwUIPlCs/qQuNCiAaq3yq0QN6L7DtuVvF0Xv6UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=u0dJ5i4p; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720002527; x=1751538527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XD4Q7cZLicWEz0JXcKOPLuwfCe9wBLZj9EmkWqD4OZA=;
  b=u0dJ5i4p8XG+fWIOUjdio20VhQEDvSge1zInwGxZmuoBTbGV2qggMnTY
   rVGTtlIU6O+Isc2LcjJ7jprxLE3wR/HGjNHNKBCMMfc11rluJ3vdVCJqY
   DBm4gkcrGKnlXMbAxpZ3/IQJpfS1k7AXwcJco9TNBLi9oW3J7WriSsmMA
   NzzdB1KRFuJOrHA/qGoFkiPV/1yXEZmOKATYrn57tO6dEroiExPf0Wzym
   qDrmT+iGdONsZc+1SvhzPbCNObLWkVPdmGK7qvUhdnpAyAYUY5dYjWuVO
   SQoSYdSqKA+KpA/Qp+Exqf9HwxhIBm6uLLybmBxzEAyxHrvjK0qdKDZbF
   Q==;
X-CSE-ConnectionGUID: ywlN1IFORca1IOesWlMguw==
X-CSE-MsgGUID: PL6zp7yMQlaYofmNGkNlPA==
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="28804768"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 03:28:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 03:28:28 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jul 2024 03:28:25 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <tglx@linutronix.de>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v5 16/27] irqchip/atmel-aic5: Add support to get nr_irqs from DT for sam9x60 & sam9x7
Date: Wed, 3 Jul 2024 15:58:21 +0530
Message-ID: <20240703102821.196112-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703102011.193343-1-varshini.rajendran@microchip.com>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support to get number of IRQs from the respective DT node for sam9x60
and sam9x7 devices. Since only this factor differs between the two SoCs,
this patch adds support for the same. The macro is still used as a
fallback for the sake of old sam9x60 DTs to work so that there is no ABI
breakage. The property is a enforced as a requirement for sam9x7 alone.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
Changes in v5:
- Changed the ABI breaking code.
- Added sam9x60 NR_IRQ as fallback for older DTS to work.
---
 drivers/irqchip/irq-atmel-aic5.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index 145535bd7560..164b5a9b0f9b 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -403,6 +403,12 @@ IRQCHIP_DECLARE(sama5d4_aic5, "atmel,sama5d4-aic", sama5d4_aic5_of_init);
 static int __init sam9x60_aic5_of_init(struct device_node *node,
 				       struct device_node *parent)
 {
-	return aic5_of_init(node, parent, NR_SAM9X60_IRQS);
+	int ret, nr_irqs;
+
+	ret = of_property_read_u32(node, "microchip,nr-irqs", &nr_irqs);
+	if (ret)
+		return aic5_of_init(node, parent, NR_SAM9X60_IRQS);
+
+	return aic5_of_init(node, parent, nr_irqs);
 }
 IRQCHIP_DECLARE(sam9x60_aic5, "microchip,sam9x60-aic", sam9x60_aic5_of_init);
-- 
2.25.1


