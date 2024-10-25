Return-Path: <linux-kernel+bounces-381947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 100E69B068C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4148D1C24599
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8105D21B95A;
	Fri, 25 Oct 2024 14:54:09 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBFB20C8BE
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868049; cv=none; b=DVthdzM2VQD9vjEnQN5E/j05s4S2YlP1/6oQcP/6LHH/rM6r4TmEk2B8rP1a2M12jsqECpIFY1c6XMclsVY41fNKQj/AyLSiEPqN3Cd/FeA6Y5aKzDBIz/2wkSx34lzo420HU8fV0viYgYgQ8hCVpCYObnH/fhy8nc6odL7ZWyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868049; c=relaxed/simple;
	bh=urNkumktNVmm6syNN9c+unPqEtALxCcHqe3MGTLl1nA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rjBlJ8/NjUz5lp0J9X89yfabzaaFMwlu1RanRVYUYhjrSzBd3FNQYcmbaav/zERPoMH77HFQL1NcWvZKxgbc+g8+c8iydybMitcsmEwol180K7Ol6Kkkl8gX5qVDj6TYy352Wda5j41l8VT4W9UQmCTdNUHFzalhM9J8LgeeJOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1t4LhR-0001DH-4n; Fri, 25 Oct 2024 16:54:01 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
	Herve Codina <herve.codina@bootlin.com>,
	Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] misc: Silence warnings when building the LAN966x device tree overlay
Date: Fri, 25 Oct 2024 16:53:53 +0200
Message-Id: <20241025145353.1620806-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Silence the following warnings when building the LAN966x device tree
overlay:

drivers/misc/lan966x_pci.dtso:34.23-40.7: Warning (interrupts_property): /fragment@0/__overlay__/pci-ep-bus@0/oic@e00c0120: Missing interrupt-parent
drivers/misc/lan966x_pci.dtso:42.22-46.7: Warning (simple_bus_reg): /fragment@0/__overlay__/pci-ep-bus@0/cpu_clk: missing or empty reg/ranges property
drivers/misc/lan966x_pci.dtso:48.22-52.7: Warning (simple_bus_reg): /fragment@0/__overlay__/pci-ep-bus@0/ddr_clk: missing or empty reg/ranges property
drivers/misc/lan966x_pci.dtso:54.22-58.7: Warning (simple_bus_reg): /fragment@0/__overlay__/pci-ep-bus@0/sys_clk: missing or empty reg/ranges property
drivers/misc/lan966x_pci.dtso:18.15-165.5: Warning (avoid_unnecessary_addr_size): /fragment@0/__overlay__: unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" property

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20241025110919.64b1cffb@canb.auug.org.au/
Fixes: 185686beb464 ("misc: Add support for LAN966x PCI device")
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
The referenced commit is in the reset tree.
---
 drivers/misc/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 885b22989580..d6d1d3ff4ef1 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
 obj-$(CONFIG_NSM)		+= nsm.o
 obj-$(CONFIG_MARVELL_CN10K_DPI)	+= mrvl_cn10k_dpi.o
 lan966x-pci-objs		:= lan966x_pci.o
+DTC_FLAGS_lan966x_pci		:= -Wno-interrupts_property -Wno-simple_bus_reg -Wno-avoid_unnecessary_addr_size
 lan966x-pci-objs		+= lan966x_pci.dtbo.o
 obj-$(CONFIG_MCHP_LAN966X_PCI)	+= lan966x-pci.o
 obj-y				+= keba/
-- 
2.39.5


