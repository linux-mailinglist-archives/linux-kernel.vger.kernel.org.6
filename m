Return-Path: <linux-kernel+bounces-259690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 306AD939BA2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A67B2262C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7079614B96F;
	Tue, 23 Jul 2024 07:18:07 +0000 (UTC)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676EB14B959
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721719087; cv=none; b=GrWUQqeES9VRGFTqVc2HAKQYlhsh+Qq1D2h+EXOOJIXirr9z65xYtvXftvj36oGpN57czy9P44tJSdH+egSPWaOPl0nVlLxS/YQadcWHmfXX2J1LT1mSAyXeMBkSIntJOfAXkyIOWtasgkA1zZxgwzJAQtk4tlLG6MxX0hgJGhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721719087; c=relaxed/simple;
	bh=lUmDhhBFgOlmC3KHBWrbukY2lKUZRRGXxlrQk3Miv6A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NpSdS88n7SRIVhUjjwPQqN514wNFkGbruuDFpST5CGcgNCnbvYnIQVhHG2hf/7pVGP96muH7EYpC5Z+znU4m7YuwzhVf3TbQ6UHahuIRLZWX0iBbCujpOTxeUiKUoO2lcrjqosMo3F9QeJq9CyRcf5nqM+yvLB5DqQNYTdGzr2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:173b:9414:53f5:de4c])
	by xavier.telenet-ops.be with bizsmtp
	id qvHx2C00P1wvoRx01vHxRr; Tue, 23 Jul 2024 09:17:59 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sW9mD-0037vJ-UH;
	Tue, 23 Jul 2024 09:17:57 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sW9mX-003HDj-DG;
	Tue, 23 Jul 2024 09:17:57 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] irqchip: LAN966X_OIC should depend on SOC_LAN966 || MFD_LAN966X_PCI
Date: Tue, 23 Jul 2024 09:17:53 +0200
Message-Id: <578dafcbdf8287e73dd30e96e23814b8c029ea96.1721719060.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Microchip LAN966x outband interrupt controller is only present on
Microchip LAN966x SoCs.  However, when used as a PCI endpoint, all
peripherals of the LAN966x SoC can be accessed by the PCI host.  Hence
add dependencies on SOC_LAN966 and MFD_LAN966X_PCI, to prevent asking
the user about this driver when configuring a kernel without Microchip
LAN966x SoC and PCIe support.

Fixes: 3e3a7b35332924c8 ("irqchip: Add support for LAN966x OIC")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
The patch defining MFD_LAN966X_PCI has not been accepted yet.
Hence my initial thought was to add a dependency on PCI instead, but
that wouldn't make much sense, as the OIC driver cannot be used without
the MFD driver anyway.  Alternatively, the MFD_LAN966X_PCI dependency
could be dropped for now, requiring a follow-up patch later.

"[PATCH v2 18/19] mfd: Add support for LAN966x PCI device"
https://lore.kernel.org/all/20240527161450.326615-19-herve.codina@bootlin.com/
---
 drivers/irqchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index bac1f0cb26e67a2b..b8d5ca3183824c93 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -171,6 +171,7 @@ config IXP4XX_IRQ
 
 config LAN966X_OIC
 	tristate "Microchip LAN966x OIC Support"
+	depends on SOC_LAN966 || MFD_LAN966X_PCI || COMPILE_TEST
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	help
-- 
2.34.1


