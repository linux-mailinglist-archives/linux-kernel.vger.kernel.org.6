Return-Path: <linux-kernel+bounces-567594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D301A68825
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D58467A64B8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FA4254AE1;
	Wed, 19 Mar 2025 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8Ae0V3H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90882253B44
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376715; cv=none; b=Vn6AMU+qZ5//tPa4+yDt9kio+gqladjItlh+cy4t+Ev76afMo+qF0CsfSJyeoJmz/m4SzKZesYv9C5pjhkH7v9X02cHK6QAGU6BeN2FYbeO8v7x7KN1ZTYxPNNOITDOV2S/QkYUG+5j4ITYWE7mkRDgKpL10eOdXnZab4z67xtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376715; c=relaxed/simple;
	bh=CsUoUjAtSeqwIaBDxuFdA7LOdcVOxayCtGAjKKPUjLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnQ58M1B77afzRnNQMdzBaqf9XQx8B088w+3pypI0zb+ukeKKLxEPBCQ4KDlKsBk4u9eukmhFvy4LFUTVaSSWu1+aJzCgH4x4bHAUyvRAdr3ZwvU0+ZM9CrviOFUZ04oqqihmXIHG2CP/Ur/gdRkKRH28SsNfb/KIGG8NpZJ7YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8Ae0V3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D265C4CEEE;
	Wed, 19 Mar 2025 09:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376715;
	bh=CsUoUjAtSeqwIaBDxuFdA7LOdcVOxayCtGAjKKPUjLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K8Ae0V3HsE43oZULmHxnu25B7Z24+HmV/I1WMaSE4B6hL8X5DjiLdz/yF4zaC0Nzg
	 qqgaJDCC+QuiDpIYL4nZVYj52jDpRwf7h0lE1yni7MSb2tIXs1jcKpNBmA9zj4XlOh
	 eJCzXI+4q5mYOOpsOoXC6fXoKyvYVqA1aPY+O85iACK5KSkzEH6DGi2+WavfeWGPgK
	 sFbx11Wc1sdjQDkcaVKf3miOppSLQ7E+8p1BY/XwUrjt1nwVABUmjE44tjIVbfmX4L
	 rYcAv/f3p4RPz1yDtTGDcWPp41CZbf+4zzWafYuu7b3gXL3GEDfvSjrrHUtzw91jKB
	 lAeVeJ7Vifefg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Talel Shenhar <talel@amazon.com>,
	Antoine Tenart <atenart@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Eddie James <eajames@linux.ibm.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Guo Ren <guoren@kernel.org>,
	Baruch Siach <baruch@tkos.co.il>,
	Miodrag Dinic <miodrag.dinic@mips.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
	Daniel Palmer <daniel@thingy.jp>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Qin Jian <qinjian@cqplus1.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Michal Simek <michal.simek@amd.com>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 21/57] irqdomain: irqchip: Switch to irq_domain_create_*()
Date: Wed, 19 Mar 2025 10:29:14 +0100
Message-ID: <20250319092951.37667-22-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

irq_domain_add_*() interfaces are going away as being obsolete now.
Switch to the preferred irq_domain_create_*() ones. Those differ in the
node parameter: They take more generic struct fwnode_handle instead of
struct device_node. Therefore, of_fwnode_handle() is added around the
original parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Talel Shenhar <talel@amazon.com>
Cc: Antoine Tenart <atenart@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Eddie James <eajames@linux.ibm.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Guo Ren <guoren@kernel.org>
Cc: Baruch Siach <baruch@tkos.co.il>
Cc: Miodrag Dinic <miodrag.dinic@mips.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc: Daniel Palmer <daniel@thingy.jp>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Andreas Kemnade <andreas@kemnade.info>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: "Andreas Färber" <afaerber@suse.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Qin Jian <qinjian@cqplus1.com>
Cc: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <kristo@kernel.org>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: "Jonathan Neuschäfer" <j.neuschaefer@gmx.net>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 drivers/irqchip/exynos-combiner.c          |  2 +-
 drivers/irqchip/irq-al-fic.c               |  2 +-
 drivers/irqchip/irq-alpine-msi.c           |  5 ++---
 drivers/irqchip/irq-armada-370-xp.c        |  4 ++--
 drivers/irqchip/irq-aspeed-i2c-ic.c        |  2 +-
 drivers/irqchip/irq-aspeed-intc.c          |  2 +-
 drivers/irqchip/irq-aspeed-scu-ic.c        |  2 +-
 drivers/irqchip/irq-aspeed-vic.c           |  4 ++--
 drivers/irqchip/irq-ath79-misc.c           |  4 ++--
 drivers/irqchip/irq-atmel-aic-common.c     |  2 +-
 drivers/irqchip/irq-bcm2712-mip.c          |  4 ++--
 drivers/irqchip/irq-bcm2835.c              |  2 +-
 drivers/irqchip/irq-bcm2836.c              |  2 +-
 drivers/irqchip/irq-bcm6345-l1.c           |  2 +-
 drivers/irqchip/irq-bcm7038-l1.c           |  2 +-
 drivers/irqchip/irq-bcm7120-l2.c           |  2 +-
 drivers/irqchip/irq-brcmstb-l2.c           |  2 +-
 drivers/irqchip/irq-clps711x.c             |  4 ++--
 drivers/irqchip/irq-crossbar.c             |  6 ++----
 drivers/irqchip/irq-csky-apb-intc.c        |  2 +-
 drivers/irqchip/irq-csky-mpintc.c          |  2 +-
 drivers/irqchip/irq-davinci-cp-intc.c      |  6 ++++--
 drivers/irqchip/irq-digicolor.c            |  2 +-
 drivers/irqchip/irq-dw-apb-ictl.c          |  2 +-
 drivers/irqchip/irq-ftintc010.c            |  5 +++--
 drivers/irqchip/irq-goldfish-pic.c         |  7 +++----
 drivers/irqchip/irq-hip04.c                |  6 ++----
 drivers/irqchip/irq-i8259.c                |  4 ++--
 drivers/irqchip/irq-idt3243x.c             |  2 +-
 drivers/irqchip/irq-imgpdc.c               |  2 +-
 drivers/irqchip/irq-imx-gpcv2.c            |  4 ++--
 drivers/irqchip/irq-imx-intmux.c           |  2 +-
 drivers/irqchip/irq-imx-irqsteer.c         |  2 +-
 drivers/irqchip/irq-ingenic-tcu.c          |  4 ++--
 drivers/irqchip/irq-ingenic.c              |  4 ++--
 drivers/irqchip/irq-jcore-aic.c            |  5 ++---
 drivers/irqchip/irq-keystone.c             |  4 ++--
 drivers/irqchip/irq-lpc32xx.c              |  4 ++--
 drivers/irqchip/irq-ls-extirq.c            |  4 ++--
 drivers/irqchip/irq-ls-scfg-msi.c          |  8 ++++----
 drivers/irqchip/irq-ls1x.c                 |  4 ++--
 drivers/irqchip/irq-mchp-eic.c             |  5 +++--
 drivers/irqchip/irq-mips-cpu.c             | 13 +++++--------
 drivers/irqchip/irq-mips-gic.c             | 15 ++++++++-------
 drivers/irqchip/irq-mmp.c                  | 12 ++++++------
 drivers/irqchip/irq-mscc-ocelot.c          |  4 ++--
 drivers/irqchip/irq-mst-intc.c             |  4 ++--
 drivers/irqchip/irq-mtk-cirq.c             |  5 ++---
 drivers/irqchip/irq-mtk-sysirq.c           |  4 ++--
 drivers/irqchip/irq-mvebu-pic.c            |  4 ++--
 drivers/irqchip/irq-mxs.c                  |  4 ++--
 drivers/irqchip/irq-nvic.c                 |  2 +-
 drivers/irqchip/irq-omap-intc.c            |  4 ++--
 drivers/irqchip/irq-or1k-pic.c             |  4 ++--
 drivers/irqchip/irq-orion.c                |  6 +++---
 drivers/irqchip/irq-owl-sirq.c             |  4 ++--
 drivers/irqchip/irq-pic32-evic.c           |  6 +++---
 drivers/irqchip/irq-pruss-intc.c           |  4 ++--
 drivers/irqchip/irq-realtek-rtl.c          |  2 +-
 drivers/irqchip/irq-renesas-intc-irqpin.c  |  6 ++++--
 drivers/irqchip/irq-renesas-irqc.c         |  4 ++--
 drivers/irqchip/irq-renesas-rza1.c         |  6 +++---
 drivers/irqchip/irq-renesas-rzg2l.c        |  6 +++---
 drivers/irqchip/irq-renesas-rzv2h.c        |  5 +++--
 drivers/irqchip/irq-sa11x0.c               |  2 +-
 drivers/irqchip/irq-sni-exiu.c             |  4 ++--
 drivers/irqchip/irq-sp7021-intc.c          |  4 ++--
 drivers/irqchip/irq-starfive-jh8100-intc.c |  4 ++--
 drivers/irqchip/irq-stm32-exti.c           |  4 ++--
 drivers/irqchip/irq-stm32mp-exti.c         |  7 +++----
 drivers/irqchip/irq-sun4i.c                |  2 +-
 drivers/irqchip/irq-sun6i-r.c              |  4 ++--
 drivers/irqchip/irq-sunxi-nmi.c            |  2 +-
 drivers/irqchip/irq-tb10x.c                |  8 ++++----
 drivers/irqchip/irq-tegra.c                |  5 ++---
 drivers/irqchip/irq-ti-sci-inta.c          |  6 +++---
 drivers/irqchip/irq-ti-sci-intr.c          |  5 +++--
 drivers/irqchip/irq-ts4800.c               |  2 +-
 drivers/irqchip/irq-versatile-fpga.c       |  4 ++--
 drivers/irqchip/irq-vf610-mscm-ir.c        |  6 +++---
 drivers/irqchip/irq-vic.c                  |  5 +++--
 drivers/irqchip/irq-vt8500.c               |  2 +-
 drivers/irqchip/irq-wpcm450-aic.c          |  2 +-
 drivers/irqchip/irq-xilinx-intc.c          |  4 ++--
 drivers/irqchip/irq-xtensa-mx.c            |  5 ++---
 drivers/irqchip/irq-xtensa-pic.c           |  4 ++--
 drivers/irqchip/irq-zevio.c                |  4 ++--
 drivers/irqchip/spear-shirq.c              |  2 +-
 88 files changed, 181 insertions(+), 185 deletions(-)

diff --git a/drivers/irqchip/exynos-combiner.c b/drivers/irqchip/exynos-combiner.c
index 552aa04ff063..e7dfcf0cda43 100644
--- a/drivers/irqchip/exynos-combiner.c
+++ b/drivers/irqchip/exynos-combiner.c
@@ -180,7 +180,7 @@ static void __init combiner_init(void __iomem *combiner_base,
 	if (!combiner_data)
 		return;
 
-	combiner_irq_domain = irq_domain_add_linear(np, nr_irq,
+	combiner_irq_domain = irq_domain_create_linear(of_fwnode_handle(np), nr_irq,
 				&combiner_irq_domain_ops, combiner_data);
 	if (WARN_ON(!combiner_irq_domain)) {
 		pr_warn("%s: irq domain init failed\n", __func__);
diff --git a/drivers/irqchip/irq-al-fic.c b/drivers/irqchip/irq-al-fic.c
index dfb761e86c9c..c980e822a10a 100644
--- a/drivers/irqchip/irq-al-fic.c
+++ b/drivers/irqchip/irq-al-fic.c
@@ -139,7 +139,7 @@ static int al_fic_register(struct device_node *node,
 	struct irq_chip_generic *gc;
 	int ret;
 
-	fic->domain = irq_domain_add_linear(node,
+	fic->domain = irq_domain_create_linear(of_fwnode_handle(node),
 					    NR_FIC_IRQS,
 					    &irq_generic_chip_ops,
 					    fic);
diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
index 0207d35135da..a5289dc26dca 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -205,9 +205,8 @@ static int alpine_msix_init_domains(struct alpine_msix_data *priv,
 		return -ENXIO;
 	}
 
-	middle_domain = irq_domain_add_hierarchy(gic_domain, 0, 0, NULL,
-						 &alpine_msix_middle_domain_ops,
-						 priv);
+	middle_domain = irq_domain_create_hierarchy(gic_domain, 0, 0, NULL,
+						    &alpine_msix_middle_domain_ops, priv);
 	if (!middle_domain) {
 		pr_err("Failed to create the MSIX middle domain\n");
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index de98d16c1718..e51612992735 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -348,7 +348,7 @@ static int __init mpic_msi_init(struct mpic *mpic, struct device_node *node,
 		mpic->msi_doorbell_mask = PCI_MSI_FULL_DOORBELL_MASK;
 	}
 
-	mpic->msi_inner_domain = irq_domain_add_linear(NULL, mpic->msi_doorbell_size,
+	mpic->msi_inner_domain = irq_domain_create_linear(NULL, mpic->msi_doorbell_size,
 						       &mpic_msi_domain_ops, mpic);
 	if (!mpic->msi_inner_domain)
 		return -ENOMEM;
@@ -861,7 +861,7 @@ static int __init mpic_of_init(struct device_node *node, struct device_node *par
 	if (!mpic_is_ipi_available(mpic))
 		nr_irqs = MPIC_PER_CPU_IRQS_NR;
 
-	mpic->domain = irq_domain_add_linear(node, nr_irqs, &mpic_irq_ops, mpic);
+	mpic->domain = irq_domain_create_linear(of_fwnode_handle(node), nr_irqs, &mpic_irq_ops, mpic);
 	if (!mpic->domain) {
 		pr_err("%pOF: Unable to add IRQ domain\n", node);
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-aspeed-i2c-ic.c b/drivers/irqchip/irq-aspeed-i2c-ic.c
index 9c9fc3e2967e..87c1feb999ff 100644
--- a/drivers/irqchip/irq-aspeed-i2c-ic.c
+++ b/drivers/irqchip/irq-aspeed-i2c-ic.c
@@ -82,7 +82,7 @@ static int __init aspeed_i2c_ic_of_init(struct device_node *node,
 		goto err_iounmap;
 	}
 
-	i2c_ic->irq_domain = irq_domain_add_linear(node, ASPEED_I2C_IC_NUM_BUS,
+	i2c_ic->irq_domain = irq_domain_create_linear(of_fwnode_handle(node), ASPEED_I2C_IC_NUM_BUS,
 						   &aspeed_i2c_ic_irq_domain_ops,
 						   NULL);
 	if (!i2c_ic->irq_domain) {
diff --git a/drivers/irqchip/irq-aspeed-intc.c b/drivers/irqchip/irq-aspeed-intc.c
index bd3b759b4b2c..8330221799a0 100644
--- a/drivers/irqchip/irq-aspeed-intc.c
+++ b/drivers/irqchip/irq-aspeed-intc.c
@@ -102,7 +102,7 @@ static int __init aspeed_intc_ic_of_init(struct device_node *node,
 	writel(0xffffffff, intc_ic->base + INTC_INT_STATUS_REG);
 	writel(0x0, intc_ic->base + INTC_INT_ENABLE_REG);
 
-	intc_ic->irq_domain = irq_domain_add_linear(node, INTC_IRQS_PER_WORD,
+	intc_ic->irq_domain = irq_domain_create_linear(of_fwnode_handle(node), INTC_IRQS_PER_WORD,
 						    &aspeed_intc_ic_irq_domain_ops, intc_ic);
 	if (!intc_ic->irq_domain) {
 		ret = -ENOMEM;
diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
index 94a7223e95df..1c7045467c48 100644
--- a/drivers/irqchip/irq-aspeed-scu-ic.c
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -165,7 +165,7 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_scu_ic *scu_ic,
 		goto err;
 	}
 
-	scu_ic->irq_domain = irq_domain_add_linear(node, scu_ic->num_irqs,
+	scu_ic->irq_domain = irq_domain_create_linear(of_fwnode_handle(node), scu_ic->num_irqs,
 						   &aspeed_scu_ic_domain_ops,
 						   scu_ic);
 	if (!scu_ic->irq_domain) {
diff --git a/drivers/irqchip/irq-aspeed-vic.c b/drivers/irqchip/irq-aspeed-vic.c
index 62ccf2c0c414..9b665b5bb531 100644
--- a/drivers/irqchip/irq-aspeed-vic.c
+++ b/drivers/irqchip/irq-aspeed-vic.c
@@ -211,8 +211,8 @@ static int __init avic_of_init(struct device_node *node,
 	set_handle_irq(avic_handle_irq);
 
 	/* Register our domain */
-	vic->dom = irq_domain_add_simple(node, NUM_IRQS, 0,
-					 &avic_dom_ops, vic);
+	vic->dom = irq_domain_create_simple(of_fwnode_handle(node), NUM_IRQS, 0,
+					    &avic_dom_ops, vic);
 
 	return 0;
 }
diff --git a/drivers/irqchip/irq-ath79-misc.c b/drivers/irqchip/irq-ath79-misc.c
index 92f001a5ff8d..268cc18b781f 100644
--- a/drivers/irqchip/irq-ath79-misc.c
+++ b/drivers/irqchip/irq-ath79-misc.c
@@ -147,7 +147,7 @@ static int __init ath79_misc_intc_of_init(
 		return -ENOMEM;
 	}
 
-	domain = irq_domain_add_linear(node, ATH79_MISC_IRQ_COUNT,
+	domain = irq_domain_create_linear(of_fwnode_handle(node), ATH79_MISC_IRQ_COUNT,
 				&misc_irq_domain_ops, base);
 	if (!domain) {
 		pr_err("Failed to add MISC irqdomain\n");
@@ -188,7 +188,7 @@ void __init ath79_misc_irq_init(void __iomem *regs, int irq,
 	else
 		ath79_misc_irq_chip.irq_ack = ar724x_misc_irq_ack;
 
-	domain = irq_domain_add_legacy(NULL, ATH79_MISC_IRQ_COUNT,
+	domain = irq_domain_create_legacy(NULL, ATH79_MISC_IRQ_COUNT,
 			irq_base, 0, &misc_irq_domain_ops, regs);
 	if (!domain)
 		panic("Failed to create MISC irqdomain");
diff --git a/drivers/irqchip/irq-atmel-aic-common.c b/drivers/irqchip/irq-atmel-aic-common.c
index 4525366d16d6..3cad30a40c19 100644
--- a/drivers/irqchip/irq-atmel-aic-common.c
+++ b/drivers/irqchip/irq-atmel-aic-common.c
@@ -228,7 +228,7 @@ struct irq_domain *__init aic_common_of_init(struct device_node *node,
 		goto err_iounmap;
 	}
 
-	domain = irq_domain_add_linear(node, nchips * 32, ops, aic);
+	domain = irq_domain_create_linear(of_fwnode_handle(node), nchips * 32, ops, aic);
 	if (!domain) {
 		ret = -ENOMEM;
 		goto err_free_aic;
diff --git a/drivers/irqchip/irq-bcm2712-mip.c b/drivers/irqchip/irq-bcm2712-mip.c
index 49a19db2d1e1..c546a063c8d8 100644
--- a/drivers/irqchip/irq-bcm2712-mip.c
+++ b/drivers/irqchip/irq-bcm2712-mip.c
@@ -173,8 +173,8 @@ static int mip_init_domains(struct mip_priv *mip, struct device_node *np)
 {
 	struct irq_domain *middle;
 
-	middle = irq_domain_add_hierarchy(mip->parent, 0, mip->num_msis, np,
-					  &mip_middle_domain_ops, mip);
+	middle = irq_domain_create_hierarchy(mip->parent, 0, mip->num_msis, of_fwnode_handle(np),
+					     &mip_middle_domain_ops, mip);
 	if (!middle)
 		return -ENOMEM;
 
diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index 6c20604c2242..1e384c870350 100644
--- a/drivers/irqchip/irq-bcm2835.c
+++ b/drivers/irqchip/irq-bcm2835.c
@@ -144,7 +144,7 @@ static int __init armctrl_of_init(struct device_node *node,
 	if (!base)
 		panic("%pOF: unable to map IC registers\n", node);
 
-	intc.domain = irq_domain_add_linear(node, MAKE_HWIRQ(NR_BANKS, 0),
+	intc.domain = irq_domain_create_linear(of_fwnode_handle(node), MAKE_HWIRQ(NR_BANKS, 0),
 			&armctrl_ops, NULL);
 	if (!intc.domain)
 		panic("%pOF: unable to create IRQ domain\n", node);
diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index e366257684b5..fafd1f71348e 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -325,7 +325,7 @@ static int __init bcm2836_arm_irqchip_l1_intc_of_init(struct device_node *node,
 
 	bcm2835_init_local_timer_frequency();
 
-	intc.domain = irq_domain_add_linear(node, LAST_IRQ + 1,
+	intc.domain = irq_domain_create_linear(of_fwnode_handle(node), LAST_IRQ + 1,
 					    &bcm2836_arm_irqchip_intc_ops,
 					    NULL);
 	if (!intc.domain)
diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
index 90daa274ef23..ca4e141c5bc2 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -316,7 +316,7 @@ static int __init bcm6345_l1_of_init(struct device_node *dn,
 
 	raw_spin_lock_init(&intc->lock);
 
-	intc->domain = irq_domain_add_linear(dn, IRQS_PER_WORD * intc->n_words,
+	intc->domain = irq_domain_create_linear(of_fwnode_handle(dn), IRQS_PER_WORD * intc->n_words,
 					     &bcm6345_l1_domain_ops,
 					     intc);
 	if (!intc->domain) {
diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index 36e71af054e9..04fac0cc857f 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -416,7 +416,7 @@ static int __init bcm7038_l1_of_init(struct device_node *dn,
 		}
 	}
 
-	intc->domain = irq_domain_add_linear(dn, IRQS_PER_WORD * intc->n_words,
+	intc->domain = irq_domain_create_linear(of_fwnode_handle(dn), IRQS_PER_WORD * intc->n_words,
 					     &bcm7038_l1_domain_ops,
 					     intc);
 	if (!intc->domain) {
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 1e9dab6e0d86..8a7c088d2081 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -264,7 +264,7 @@ static int __init bcm7120_l2_intc_probe(struct device_node *dn,
 			goto out_free_l1_data;
 	}
 
-	data->domain = irq_domain_add_linear(dn, IRQS_PER_WORD * data->n_words,
+	data->domain = irq_domain_create_linear(of_fwnode_handle(dn), IRQS_PER_WORD * data->n_words,
 					     &irq_generic_chip_ops, NULL);
 	if (!data->domain) {
 		ret = -ENOMEM;
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index db4c9721fcf2..d15ca092742c 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -182,7 +182,7 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 		goto out_unmap;
 	}
 
-	data->domain = irq_domain_add_linear(np, 32,
+	data->domain = irq_domain_create_linear(of_fwnode_handle(np), 32,
 				&irq_generic_chip_ops, NULL);
 	if (!data->domain) {
 		ret = -ENOMEM;
diff --git a/drivers/irqchip/irq-clps711x.c b/drivers/irqchip/irq-clps711x.c
index 48c73c948ddf..c4b73ba2323b 100644
--- a/drivers/irqchip/irq-clps711x.c
+++ b/drivers/irqchip/irq-clps711x.c
@@ -184,8 +184,8 @@ static int __init _clps711x_intc_init(struct device_node *np,
 	clps711x_intc->ops.map = clps711x_intc_irq_map;
 	clps711x_intc->ops.xlate = irq_domain_xlate_onecell;
 	clps711x_intc->domain =
-		irq_domain_add_legacy(np, ARRAY_SIZE(clps711x_irqs),
-				      0, 0, &clps711x_intc->ops, NULL);
+		irq_domain_create_legacy(of_fwnode_handle(np), ARRAY_SIZE(clps711x_irqs), 0, 0,
+					 &clps711x_intc->ops, NULL);
 	if (!clps711x_intc->domain) {
 		err = -ENOMEM;
 		goto out_irqfree;
diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index a05a7501e107..66bb39e24a52 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -351,10 +351,8 @@ static int __init irqcrossbar_init(struct device_node *node,
 	if (err)
 		return err;
 
-	domain = irq_domain_add_hierarchy(parent_domain, 0,
-					  cb->max_crossbar_sources,
-					  node, &crossbar_domain_ops,
-					  NULL);
+	domain = irq_domain_create_hierarchy(parent_domain, 0, cb->max_crossbar_sources,
+					     of_fwnode_handle(node), &crossbar_domain_ops, NULL);
 	if (!domain) {
 		pr_err("%pOF: failed to allocated domain\n", node);
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-csky-apb-intc.c b/drivers/irqchip/irq-csky-apb-intc.c
index 6710691e4c25..a970f4806f31 100644
--- a/drivers/irqchip/irq-csky-apb-intc.c
+++ b/drivers/irqchip/irq-csky-apb-intc.c
@@ -114,7 +114,7 @@ ck_intc_init_comm(struct device_node *node, struct device_node *parent)
 		return -EINVAL;
 	}
 
-	root_domain = irq_domain_add_linear(node, nr_irq,
+	root_domain = irq_domain_create_linear(of_fwnode_handle(node), nr_irq,
 					    &irq_generic_chip_ops, NULL);
 	if (!root_domain) {
 		pr_err("C-SKY Intc irq_domain_add failed.\n");
diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
index 4aebd67d4f8f..1d1f5091f26f 100644
--- a/drivers/irqchip/irq-csky-mpintc.c
+++ b/drivers/irqchip/irq-csky-mpintc.c
@@ -255,7 +255,7 @@ csky_mpintc_init(struct device_node *node, struct device_node *parent)
 		writel_relaxed(BIT(0), INTCG_base + INTCG_ICTLR);
 	}
 
-	root_domain = irq_domain_add_linear(node, nr_irq, &csky_irqdomain_ops,
+	root_domain = irq_domain_create_linear(of_fwnode_handle(node), nr_irq, &csky_irqdomain_ops,
 					    NULL);
 	if (!root_domain)
 		return -ENXIO;
diff --git a/drivers/irqchip/irq-davinci-cp-intc.c b/drivers/irqchip/irq-davinci-cp-intc.c
index d7948c55f542..00cdcc90f614 100644
--- a/drivers/irqchip/irq-davinci-cp-intc.c
+++ b/drivers/irqchip/irq-davinci-cp-intc.c
@@ -204,8 +204,10 @@ static int __init davinci_cp_intc_do_init(struct resource *res, unsigned int num
 		return irq_base;
 	}
 
-	davinci_cp_intc_irq_domain = irq_domain_add_legacy(node, num_irqs, irq_base, 0,
-							   &davinci_cp_intc_irq_domain_ops, NULL);
+	davinci_cp_intc_irq_domain = irq_domain_create_legacy(of_fwnode_handle(node), num_irqs,
+							      irq_base, 0,
+							      &davinci_cp_intc_irq_domain_ops,
+							      NULL);
 
 	if (!davinci_cp_intc_irq_domain) {
 		pr_err("%s: unable to create an interrupt domain\n", __func__);
diff --git a/drivers/irqchip/irq-digicolor.c b/drivers/irqchip/irq-digicolor.c
index 3b0d78aac13b..eb5a8de82751 100644
--- a/drivers/irqchip/irq-digicolor.c
+++ b/drivers/irqchip/irq-digicolor.c
@@ -95,7 +95,7 @@ static int __init digicolor_of_init(struct device_node *node,
 	regmap_write(ucregs, UC_IRQ_CONTROL, 1);
 
 	digicolor_irq_domain =
-		irq_domain_add_linear(node, 64, &irq_generic_chip_ops, NULL);
+		irq_domain_create_linear(of_fwnode_handle(node), 64, &irq_generic_chip_ops, NULL);
 	if (!digicolor_irq_domain) {
 		pr_err("%pOF: unable to create IRQ domain\n", node);
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
index d5c1c750c8d2..c8a6d62ccb47 100644
--- a/drivers/irqchip/irq-dw-apb-ictl.c
+++ b/drivers/irqchip/irq-dw-apb-ictl.c
@@ -173,7 +173,7 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 	else
 		nrirqs = fls(readl_relaxed(iobase + APB_INT_ENABLE_L));
 
-	domain = irq_domain_add_linear(np, nrirqs, domain_ops, NULL);
+	domain = irq_domain_create_linear(of_fwnode_handle(np), nrirqs, domain_ops, NULL);
 	if (!domain) {
 		pr_err("%pOF: unable to add irq domain\n", np);
 		ret = -ENOMEM;
diff --git a/drivers/irqchip/irq-ftintc010.c b/drivers/irqchip/irq-ftintc010.c
index b91c358ea6db..a59a66d79da6 100644
--- a/drivers/irqchip/irq-ftintc010.c
+++ b/drivers/irqchip/irq-ftintc010.c
@@ -180,8 +180,9 @@ static int __init ft010_of_init_irq(struct device_node *node,
 	writel(0, FT010_IRQ_MASK(f->base));
 	writel(0, FT010_FIQ_MASK(f->base));
 
-	f->domain = irq_domain_add_simple(node, FT010_NUM_IRQS, 0,
-					  &ft010_irqdomain_ops, f);
+	f->domain = irq_domain_create_simple(of_fwnode_handle(node),
+					     FT010_NUM_IRQS, 0,
+					     &ft010_irqdomain_ops, f);
 	set_handle_irq(ft010_irqchip_handle_irq);
 
 	return 0;
diff --git a/drivers/irqchip/irq-goldfish-pic.c b/drivers/irqchip/irq-goldfish-pic.c
index 513f6edbbe95..a8b23b507ecd 100644
--- a/drivers/irqchip/irq-goldfish-pic.c
+++ b/drivers/irqchip/irq-goldfish-pic.c
@@ -101,10 +101,9 @@ static int __init goldfish_pic_of_init(struct device_node *of_node,
 	irq_setup_generic_chip(gc, IRQ_MSK(GFPIC_NR_IRQS), 0,
 			       IRQ_NOPROBE | IRQ_LEVEL, 0);
 
-	gfpic->irq_domain = irq_domain_add_legacy(of_node, GFPIC_NR_IRQS,
-						  GFPIC_IRQ_BASE, 0,
-						  &goldfish_irq_domain_ops,
-						  NULL);
+	gfpic->irq_domain = irq_domain_create_legacy(of_fwnode_handle(of_node), GFPIC_NR_IRQS,
+						     GFPIC_IRQ_BASE, 0, &goldfish_irq_domain_ops,
+						     NULL);
 	if (!gfpic->irq_domain) {
 		pr_err("Failed to add irqdomain!\n");
 		ret = -ENOMEM;
diff --git a/drivers/irqchip/irq-hip04.c b/drivers/irqchip/irq-hip04.c
index 31c3f70a5d5e..b7958c5a1221 100644
--- a/drivers/irqchip/irq-hip04.c
+++ b/drivers/irqchip/irq-hip04.c
@@ -386,10 +386,8 @@ hip04_of_init(struct device_node *node, struct device_node *parent)
 		return -EINVAL;
 	}
 
-	hip04_data.domain = irq_domain_add_legacy(node, nr_irqs, irq_base,
-						  0,
-						  &hip04_irq_domain_ops,
-						  &hip04_data);
+	hip04_data.domain = irq_domain_create_legacy(of_fwnode_handle(node), nr_irqs, irq_base, 0,
+						     &hip04_irq_domain_ops, &hip04_data);
 	if (WARN_ON(!hip04_data.domain))
 		return -EINVAL;
 
diff --git a/drivers/irqchip/irq-i8259.c b/drivers/irqchip/irq-i8259.c
index 115bdcffab24..91b2f587119c 100644
--- a/drivers/irqchip/irq-i8259.c
+++ b/drivers/irqchip/irq-i8259.c
@@ -313,8 +313,8 @@ struct irq_domain * __init __init_i8259_irqs(struct device_node *node)
 
 	init_8259A(0);
 
-	domain = irq_domain_add_legacy(node, 16, I8259A_IRQ_BASE, 0,
-				       &i8259A_ops, NULL);
+	domain = irq_domain_create_legacy(of_fwnode_handle(node), 16, I8259A_IRQ_BASE, 0,
+					  &i8259A_ops, NULL);
 	if (!domain)
 		panic("Failed to add i8259 IRQ domain");
 
diff --git a/drivers/irqchip/irq-idt3243x.c b/drivers/irqchip/irq-idt3243x.c
index 0732a0e9af62..f8324fb1fe8f 100644
--- a/drivers/irqchip/irq-idt3243x.c
+++ b/drivers/irqchip/irq-idt3243x.c
@@ -72,7 +72,7 @@ static int idt_pic_init(struct device_node *of_node, struct device_node *parent)
 		goto out_unmap_irq;
 	}
 
-	domain = irq_domain_add_linear(of_node, IDT_PIC_NR_IRQS,
+	domain = irq_domain_create_linear(of_fwnode_handle(of_node), IDT_PIC_NR_IRQS,
 				       &irq_generic_chip_ops, NULL);
 	if (!domain) {
 		pr_err("Failed to add irqdomain!\n");
diff --git a/drivers/irqchip/irq-imgpdc.c b/drivers/irqchip/irq-imgpdc.c
index 85f80bac0961..f0410d5d7315 100644
--- a/drivers/irqchip/irq-imgpdc.c
+++ b/drivers/irqchip/irq-imgpdc.c
@@ -372,7 +372,7 @@ static int pdc_intc_probe(struct platform_device *pdev)
 	priv->syswake_irq = irq;
 
 	/* Set up an IRQ domain */
-	priv->domain = irq_domain_add_linear(node, 16, &irq_generic_chip_ops,
+	priv->domain = irq_domain_create_linear(of_fwnode_handle(node), 16, &irq_generic_chip_ops,
 					     priv);
 	if (unlikely(!priv->domain)) {
 		dev_err(&pdev->dev, "cannot add IRQ domain\n");
diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 095ae8e3217e..b91f5c14b405 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -240,8 +240,8 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 		return -ENOMEM;
 	}
 
-	domain = irq_domain_add_hierarchy(parent_domain, 0, GPC_MAX_IRQS,
-				node, &gpcv2_irqchip_data_domain_ops, cd);
+	domain = irq_domain_create_hierarchy(parent_domain, 0, GPC_MAX_IRQS,
+				of_fwnode_handle(node), &gpcv2_irqchip_data_domain_ops, cd);
 	if (!domain) {
 		iounmap(cd->gpc_base);
 		kfree(cd);
diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index 787543d07565..5f9b204d350b 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -254,7 +254,7 @@ static int imx_intmux_probe(struct platform_device *pdev)
 			goto out;
 		}
 
-		domain = irq_domain_add_linear(np, 32, &imx_intmux_domain_ops,
+		domain = irq_domain_create_linear(of_fwnode_handle(np), 32, &imx_intmux_domain_ops,
 					       &data->irqchip_data[i]);
 		if (!domain) {
 			ret = -ENOMEM;
diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index afbfcce3b1e3..6dc9ac48fee5 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -212,7 +212,7 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 	/* steer all IRQs into configured channel */
 	writel_relaxed(BIT(data->channel), data->regs + CHANCTRL);
 
-	data->domain = irq_domain_add_linear(np, data->reg_num * 32,
+	data->domain = irq_domain_create_linear(of_fwnode_handle(np), data->reg_num * 32,
 					     &imx_irqsteer_domain_ops, data);
 	if (!data->domain) {
 		dev_err(&pdev->dev, "failed to create IRQ domain\n");
diff --git a/drivers/irqchip/irq-ingenic-tcu.c b/drivers/irqchip/irq-ingenic-tcu.c
index 3363f83bd7e9..e43ff8935b82 100644
--- a/drivers/irqchip/irq-ingenic-tcu.c
+++ b/drivers/irqchip/irq-ingenic-tcu.c
@@ -114,8 +114,8 @@ static int __init ingenic_tcu_irq_init(struct device_node *np,
 
 	tcu->nb_parent_irqs = irqs;
 
-	tcu->domain = irq_domain_add_linear(np, 32, &irq_generic_chip_ops,
-					    NULL);
+	tcu->domain = irq_domain_create_linear(of_fwnode_handle(np), 32, &irq_generic_chip_ops,
+					       NULL);
 	if (!tcu->domain) {
 		ret = -ENOMEM;
 		goto err_free_tcu;
diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index cee839ca627e..52393724f213 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -90,8 +90,8 @@ static int __init ingenic_intc_of_init(struct device_node *node,
 		goto out_unmap_irq;
 	}
 
-	domain = irq_domain_add_linear(node, num_chips * 32,
-				       &irq_generic_chip_ops, NULL);
+	domain = irq_domain_create_linear(of_fwnode_handle(node), num_chips * 32,
+					  &irq_generic_chip_ops, NULL);
 	if (!domain) {
 		err = -ENOMEM;
 		goto out_unmap_base;
diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-aic.c
index 1f613eb7b7f0..94c05cf974be 100644
--- a/drivers/irqchip/irq-jcore-aic.c
+++ b/drivers/irqchip/irq-jcore-aic.c
@@ -107,9 +107,8 @@ static int __init aic_irq_of_init(struct device_node *node,
 	if (ret < 0)
 		return ret;
 
-	domain = irq_domain_add_legacy(node, dom_sz - min_irq, min_irq, min_irq,
-				       &jcore_aic_irqdomain_ops,
-				       &jcore_aic);
+	domain = irq_domain_create_legacy(of_fwnode_handle(node), dom_sz - min_irq, min_irq,
+					  min_irq, &jcore_aic_irqdomain_ops, &jcore_aic);
 	if (!domain)
 		return -ENOMEM;
 
diff --git a/drivers/irqchip/irq-keystone.c b/drivers/irqchip/irq-keystone.c
index 37e1a03fcbb4..c9e902b7bf48 100644
--- a/drivers/irqchip/irq-keystone.c
+++ b/drivers/irqchip/irq-keystone.c
@@ -157,8 +157,8 @@ static int keystone_irq_probe(struct platform_device *pdev)
 	kirq->chip.irq_mask	= keystone_irq_setmask;
 	kirq->chip.irq_unmask	= keystone_irq_unmask;
 
-	kirq->irqd = irq_domain_add_linear(np, KEYSTONE_N_IRQ,
-					   &keystone_irq_ops, kirq);
+	kirq->irqd = irq_domain_create_linear(of_fwnode_handle(np), KEYSTONE_N_IRQ,
+					      &keystone_irq_ops, kirq);
 	if (!kirq->irqd) {
 		dev_err(dev, "IRQ domain registration failed\n");
 		return -ENODEV;
diff --git a/drivers/irqchip/irq-lpc32xx.c b/drivers/irqchip/irq-lpc32xx.c
index 4d70a857133f..14cca44baa14 100644
--- a/drivers/irqchip/irq-lpc32xx.c
+++ b/drivers/irqchip/irq-lpc32xx.c
@@ -210,8 +210,8 @@ static int __init lpc32xx_of_ic_init(struct device_node *node,
 		return -EINVAL;
 	}
 
-	irqc->domain = irq_domain_add_linear(node, NR_LPC32XX_IC_IRQS,
-					     &lpc32xx_irq_domain_ops, irqc);
+	irqc->domain = irq_domain_create_linear(of_fwnode_handle(node), NR_LPC32XX_IC_IRQS,
+						&lpc32xx_irq_domain_ops, irqc);
 	if (!irqc->domain) {
 		pr_err("unable to add irq domain\n");
 		iounmap(irqc->base);
diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
index 139f26b0a6ef..50a7b38381b9 100644
--- a/drivers/irqchip/irq-ls-extirq.c
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -208,8 +208,8 @@ ls_extirq_of_init(struct device_node *node, struct device_node *parent)
 				      of_device_is_compatible(node, "fsl,ls1043a-extirq");
 	raw_spin_lock_init(&priv->lock);
 
-	domain = irq_domain_add_hierarchy(parent_domain, 0, priv->nirq, node,
-					  &extirq_domain_ops, priv);
+	domain = irq_domain_create_hierarchy(parent_domain, 0, priv->nirq, of_fwnode_handle(node),
+					     &extirq_domain_ops, priv);
 	if (!domain) {
 		ret = -ENOMEM;
 		goto err_add_hierarchy;
diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index cbe11a8afe4f..84bc5e4b47cf 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -215,10 +215,10 @@ static void ls_scfg_msi_irq_handler(struct irq_desc *desc)
 static int ls_scfg_msi_domains_init(struct ls_scfg_msi *msi_data)
 {
 	/* Initialize MSI domain parent */
-	msi_data->parent = irq_domain_add_linear(NULL,
-						 msi_data->irqs_num,
-						 &ls_scfg_msi_domain_ops,
-						 msi_data);
+	msi_data->parent = irq_domain_create_linear(NULL,
+						    msi_data->irqs_num,
+						    &ls_scfg_msi_domain_ops,
+						    msi_data);
 	if (!msi_data->parent) {
 		dev_err(&msi_data->pdev->dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-ls1x.c b/drivers/irqchip/irq-ls1x.c
index 77a3f7dfaaf0..589d32007fca 100644
--- a/drivers/irqchip/irq-ls1x.c
+++ b/drivers/irqchip/irq-ls1x.c
@@ -126,8 +126,8 @@ static int __init ls1x_intc_of_init(struct device_node *node,
 	}
 
 	/* Set up an IRQ domain */
-	priv->domain = irq_domain_add_linear(node, 32, &irq_generic_chip_ops,
-					     NULL);
+	priv->domain = irq_domain_create_linear(of_fwnode_handle(node), 32, &irq_generic_chip_ops,
+						NULL);
 	if (!priv->domain) {
 		pr_err("ls1x-irq: cannot add IRQ domain\n");
 		err = -ENOMEM;
diff --git a/drivers/irqchip/irq-mchp-eic.c b/drivers/irqchip/irq-mchp-eic.c
index 5dcd94c000a2..516a3a0e359c 100644
--- a/drivers/irqchip/irq-mchp-eic.c
+++ b/drivers/irqchip/irq-mchp-eic.c
@@ -248,8 +248,9 @@ static int mchp_eic_init(struct device_node *node, struct device_node *parent)
 		eic->irqs[i] = irq.args[1];
 	}
 
-	eic->domain = irq_domain_add_hierarchy(parent_domain, 0, MCHP_EIC_NIRQ,
-					       node, &mchp_eic_domain_ops, eic);
+	eic->domain = irq_domain_create_hierarchy(parent_domain, 0, MCHP_EIC_NIRQ,
+						  of_fwnode_handle(node), &mchp_eic_domain_ops,
+						  eic);
 	if (!eic->domain) {
 		pr_err("%pOF: Failed to add domain\n", node);
 		ret = -ENODEV;
diff --git a/drivers/irqchip/irq-mips-cpu.c b/drivers/irqchip/irq-mips-cpu.c
index 0c7ae71a0af0..ac784ef3ed4b 100644
--- a/drivers/irqchip/irq-mips-cpu.c
+++ b/drivers/irqchip/irq-mips-cpu.c
@@ -238,11 +238,9 @@ static void mips_cpu_register_ipi_domain(struct device_node *of_node)
 	struct cpu_ipi_domain_state *ipi_domain_state;
 
 	ipi_domain_state = kzalloc(sizeof(*ipi_domain_state), GFP_KERNEL);
-	ipi_domain = irq_domain_add_hierarchy(irq_domain,
-					      IRQ_DOMAIN_FLAG_IPI_SINGLE,
-					      2, of_node,
-					      &mips_cpu_ipi_chip_ops,
-					      ipi_domain_state);
+	ipi_domain = irq_domain_create_hierarchy(irq_domain, IRQ_DOMAIN_FLAG_IPI_SINGLE, 2,
+						 of_fwnode_handle(of_node),
+						 &mips_cpu_ipi_chip_ops, ipi_domain_state);
 	if (!ipi_domain)
 		panic("Failed to add MIPS CPU IPI domain");
 	irq_domain_update_bus_token(ipi_domain, DOMAIN_BUS_IPI);
@@ -260,9 +258,8 @@ static void __init __mips_cpu_irq_init(struct device_node *of_node)
 	clear_c0_status(ST0_IM);
 	clear_c0_cause(CAUSEF_IP);
 
-	irq_domain = irq_domain_add_legacy(of_node, 8, MIPS_CPU_IRQ_BASE, 0,
-					   &mips_cpu_intc_irq_domain_ops,
-					   NULL);
+	irq_domain = irq_domain_create_legacy(of_fwnode_handle(of_node), 8, MIPS_CPU_IRQ_BASE, 0,
+					      &mips_cpu_intc_irq_domain_ops, NULL);
 	if (!irq_domain)
 		panic("Failed to add irqdomain for MIPS CPU");
 
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index bca8053864b2..34e8d09c12a0 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -841,10 +841,10 @@ static int gic_register_ipi_domain(struct device_node *node)
 	struct irq_domain *gic_ipi_domain;
 	unsigned int v[2], num_ipis;
 
-	gic_ipi_domain = irq_domain_add_hierarchy(gic_irq_domain,
-						  IRQ_DOMAIN_FLAG_IPI_PER_CPU,
-						  GIC_NUM_LOCAL_INTRS + gic_shared_intrs,
-						  node, &gic_ipi_domain_ops, NULL);
+	gic_ipi_domain = irq_domain_create_hierarchy(gic_irq_domain, IRQ_DOMAIN_FLAG_IPI_PER_CPU,
+						     GIC_NUM_LOCAL_INTRS + gic_shared_intrs,
+						     of_fwnode_handle(node), &gic_ipi_domain_ops,
+						     NULL);
 	if (!gic_ipi_domain) {
 		pr_err("Failed to add IPI domain");
 		return -ENXIO;
@@ -963,9 +963,10 @@ static int __init gic_of_init(struct device_node *node,
 					gic_irq_dispatch);
 	}
 
-	gic_irq_domain = irq_domain_add_simple(node, GIC_NUM_LOCAL_INTRS +
-					       gic_shared_intrs, 0,
-					       &gic_irq_domain_ops, NULL);
+	gic_irq_domain = irq_domain_create_simple(of_fwnode_handle(node),
+						  GIC_NUM_LOCAL_INTRS +
+						  gic_shared_intrs, 0,
+						  &gic_irq_domain_ops, NULL);
 	if (!gic_irq_domain) {
 		pr_err("Failed to add IRQ domain");
 		return -ENXIO;
diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 25cf4f80e767..09e640430208 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -261,9 +261,9 @@ static int __init mmp_init_bases(struct device_node *node)
 	}
 
 	icu_data[0].virq_base = 0;
-	icu_data[0].domain = irq_domain_add_linear(node, nr_irqs,
-						   &mmp_irq_domain_ops,
-						   &icu_data[0]);
+	icu_data[0].domain = irq_domain_create_linear(of_fwnode_handle(node), nr_irqs,
+						      &mmp_irq_domain_ops,
+						      &icu_data[0]);
 	for (irq = 0; irq < nr_irqs; irq++) {
 		ret = irq_create_mapping(icu_data[0].domain, irq);
 		if (!ret) {
@@ -391,9 +391,9 @@ static int __init mmp2_mux_of_init(struct device_node *node,
 		return -EINVAL;
 
 	icu_data[i].virq_base = 0;
-	icu_data[i].domain = irq_domain_add_linear(node, nr_irqs,
-						   &mmp_irq_domain_ops,
-						   &icu_data[i]);
+	icu_data[i].domain = irq_domain_create_linear(of_fwnode_handle(node), nr_irqs,
+						      &mmp_irq_domain_ops,
+						      &icu_data[i]);
 	for (irq = 0; irq < nr_irqs; irq++) {
 		ret = irq_create_mapping(icu_data[i].domain, irq);
 		if (!ret) {
diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
index 3dc745b14caf..7b3020f480d5 100644
--- a/drivers/irqchip/irq-mscc-ocelot.c
+++ b/drivers/irqchip/irq-mscc-ocelot.c
@@ -132,8 +132,8 @@ static int __init vcoreiii_irq_init(struct device_node *node,
 	if (!parent_irq)
 		return -EINVAL;
 
-	domain = irq_domain_add_linear(node, p->n_irq,
-				       &irq_generic_chip_ops, NULL);
+	domain = irq_domain_create_linear(of_fwnode_handle(node), p->n_irq,
+					  &irq_generic_chip_ops, NULL);
 	if (!domain) {
 		pr_err("%pOFn: unable to add irq domain\n", node);
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-mst-intc.c b/drivers/irqchip/irq-mst-intc.c
index f6133ae28155..9643cc3a77d7 100644
--- a/drivers/irqchip/irq-mst-intc.c
+++ b/drivers/irqchip/irq-mst-intc.c
@@ -273,8 +273,8 @@ static int __init mst_intc_of_init(struct device_node *dn,
 	raw_spin_lock_init(&cd->lock);
 	cd->irq_start = irq_start;
 	cd->nr_irqs = irq_end - irq_start + 1;
-	domain = irq_domain_add_hierarchy(domain_parent, 0, cd->nr_irqs, dn,
-					  &mst_intc_domain_ops, cd);
+	domain = irq_domain_create_hierarchy(domain_parent, 0, cd->nr_irqs, of_fwnode_handle(dn),
+					     &mst_intc_domain_ops, cd);
 	if (!domain) {
 		iounmap(cd->base);
 		kfree(cd);
diff --git a/drivers/irqchip/irq-mtk-cirq.c b/drivers/irqchip/irq-mtk-cirq.c
index 76bc0283e3b9..de481ba340f8 100644
--- a/drivers/irqchip/irq-mtk-cirq.c
+++ b/drivers/irqchip/irq-mtk-cirq.c
@@ -336,9 +336,8 @@ static int __init mtk_cirq_of_init(struct device_node *node,
 	cirq_data->offsets = match->data;
 
 	irq_num = cirq_data->ext_irq_end - cirq_data->ext_irq_start + 1;
-	domain = irq_domain_add_hierarchy(domain_parent, 0,
-					  irq_num, node,
-					  &cirq_domain_ops, cirq_data);
+	domain = irq_domain_create_hierarchy(domain_parent, 0, irq_num, of_fwnode_handle(node),
+					     &cirq_domain_ops, cirq_data);
 	if (!domain) {
 		ret = -ENOMEM;
 		goto out_unmap;
diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
index 586e52d5442b..6895e7096b27 100644
--- a/drivers/irqchip/irq-mtk-sysirq.c
+++ b/drivers/irqchip/irq-mtk-sysirq.c
@@ -207,8 +207,8 @@ static int __init mtk_sysirq_of_init(struct device_node *node,
 		chip_data->which_word[i] = word;
 	}
 
-	domain = irq_domain_add_hierarchy(domain_parent, 0, intpol_num, node,
-					  &sysirq_domain_ops, chip_data);
+	domain = irq_domain_create_hierarchy(domain_parent, 0, intpol_num, of_fwnode_handle(node),
+					     &sysirq_domain_ops, chip_data);
 	if (!domain) {
 		ret = -ENOMEM;
 		goto out_free_which_word;
diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index 3888b7585981..8db638aa21d2 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -150,8 +150,8 @@ static int mvebu_pic_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	pic->domain = irq_domain_add_linear(node, PIC_MAX_IRQS,
-					    &mvebu_pic_domain_ops, pic);
+	pic->domain = irq_domain_create_linear(of_fwnode_handle(node), PIC_MAX_IRQS,
+					       &mvebu_pic_domain_ops, pic);
 	if (!pic->domain) {
 		dev_err(&pdev->dev, "Failed to allocate irq domain\n");
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
index d67b5da38982..0bb423dd5280 100644
--- a/drivers/irqchip/irq-mxs.c
+++ b/drivers/irqchip/irq-mxs.c
@@ -162,8 +162,8 @@ static const struct irq_domain_ops icoll_irq_domain_ops = {
 static void __init icoll_add_domain(struct device_node *np,
 			  int num)
 {
-	icoll_domain = irq_domain_add_linear(np, num,
-					     &icoll_irq_domain_ops, NULL);
+	icoll_domain = irq_domain_create_linear(of_fwnode_handle(np), num,
+						&icoll_irq_domain_ops, NULL);
 
 	if (!icoll_domain)
 		panic("%pOF: unable to create irq domain", np);
diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index ba6332b00a0a..76e11cac9631 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -90,7 +90,7 @@ static int __init nvic_of_init(struct device_node *node,
 		irqs = NVIC_MAX_IRQ;
 
 	nvic_irq_domain =
-		irq_domain_add_linear(node, irqs, &nvic_irq_domain_ops, NULL);
+		irq_domain_create_linear(of_fwnode_handle(node), irqs, &nvic_irq_domain_ops, NULL);
 
 	if (!nvic_irq_domain) {
 		pr_warn("Failed to allocate irq domain\n");
diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-intc.c
index ad84a2f03368..16f00db570e7 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -248,7 +248,7 @@ static int __init omap_init_irq_of(struct device_node *node)
 	if (WARN_ON(!omap_irq_base))
 		return -ENOMEM;
 
-	domain = irq_domain_add_linear(node, omap_nr_irqs,
+	domain = irq_domain_create_linear(of_fwnode_handle(node), omap_nr_irqs,
 			&irq_generic_chip_ops, NULL);
 
 	omap_irq_soft_reset();
@@ -274,7 +274,7 @@ static int __init omap_init_irq_legacy(u32 base, struct device_node *node)
 		irq_base = 0;
 	}
 
-	domain = irq_domain_add_legacy(node, omap_nr_irqs, irq_base, 0,
+	domain = irq_domain_create_legacy(of_fwnode_handle(node), omap_nr_irqs, irq_base, 0,
 			&irq_domain_simple_ops, NULL);
 
 	omap_irq_soft_reset();
diff --git a/drivers/irqchip/irq-or1k-pic.c b/drivers/irqchip/irq-or1k-pic.c
index f289ccd95291..48126067c54b 100644
--- a/drivers/irqchip/irq-or1k-pic.c
+++ b/drivers/irqchip/irq-or1k-pic.c
@@ -144,8 +144,8 @@ static int __init or1k_pic_init(struct device_node *node,
 	/* Disable all interrupts until explicitly requested */
 	mtspr(SPR_PICMR, (0UL));
 
-	root_domain = irq_domain_add_linear(node, 32, &or1k_irq_domain_ops,
-					    pic);
+	root_domain = irq_domain_create_linear(of_fwnode_handle(node), 32, &or1k_irq_domain_ops,
+					       pic);
 
 	set_handle_irq(or1k_pic_handle_irq);
 
diff --git a/drivers/irqchip/irq-orion.c b/drivers/irqchip/irq-orion.c
index 4e4e874e09a8..dddbc05917c0 100644
--- a/drivers/irqchip/irq-orion.c
+++ b/drivers/irqchip/irq-orion.c
@@ -59,7 +59,7 @@ static int __init orion_irq_init(struct device_node *np,
 	/* count number of irq chips by valid reg addresses */
 	num_chips = of_address_count(np);
 
-	orion_irq_domain = irq_domain_add_linear(np,
+	orion_irq_domain = irq_domain_create_linear(of_fwnode_handle(np),
 				num_chips * ORION_IRQS_PER_CHIP,
 				&irq_generic_chip_ops, NULL);
 	if (!orion_irq_domain)
@@ -146,8 +146,8 @@ static int __init orion_bridge_irq_init(struct device_node *np,
 	/* get optional number of interrupts provided */
 	of_property_read_u32(np, "marvell,#interrupts", &nrirqs);
 
-	domain = irq_domain_add_linear(np, nrirqs,
-				       &irq_generic_chip_ops, NULL);
+	domain = irq_domain_create_linear(of_fwnode_handle(np), nrirqs,
+					  &irq_generic_chip_ops, NULL);
 	if (!domain) {
 		pr_err("%pOFn: unable to add irq domain\n", np);
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-owl-sirq.c b/drivers/irqchip/irq-owl-sirq.c
index 6e4127465094..3d93d21f6732 100644
--- a/drivers/irqchip/irq-owl-sirq.c
+++ b/drivers/irqchip/irq-owl-sirq.c
@@ -323,8 +323,8 @@ static int __init owl_sirq_init(const struct owl_sirq_params *params,
 		owl_sirq_clear_set_extctl(chip_data, 0, INTC_EXTCTL_CLK_SEL, i);
 	}
 
-	domain = irq_domain_add_hierarchy(parent_domain, 0, NUM_SIRQ, node,
-					  &owl_sirq_domain_ops, chip_data);
+	domain = irq_domain_create_hierarchy(parent_domain, 0, NUM_SIRQ, of_fwnode_handle(node),
+					     &owl_sirq_domain_ops, chip_data);
 	if (!domain) {
 		pr_err("%pOF: failed to add domain\n", node);
 		ret = -ENOMEM;
diff --git a/drivers/irqchip/irq-pic32-evic.c b/drivers/irqchip/irq-pic32-evic.c
index b546b1036e12..5dfda8e8df10 100644
--- a/drivers/irqchip/irq-pic32-evic.c
+++ b/drivers/irqchip/irq-pic32-evic.c
@@ -227,9 +227,9 @@ static int __init pic32_of_init(struct device_node *node,
 		goto err_iounmap;
 	}
 
-	evic_irq_domain = irq_domain_add_linear(node, nchips * 32,
-						&pic32_irq_domain_ops,
-						priv);
+	evic_irq_domain = irq_domain_create_linear(of_fwnode_handle(node), nchips * 32,
+						   &pic32_irq_domain_ops,
+						   priv);
 	if (!evic_irq_domain) {
 		ret = -ENOMEM;
 		goto err_free_priv;
diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
index bee01980b463..8f7c9dc45953 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -555,8 +555,8 @@ static int pruss_intc_probe(struct platform_device *pdev)
 
 	mutex_init(&intc->lock);
 
-	intc->domain = irq_domain_add_linear(dev->of_node, max_system_events,
-					     &pruss_intc_irq_domain_ops, intc);
+	intc->domain = irq_domain_create_linear(of_fwnode_handle(dev->of_node), max_system_events,
+						&pruss_intc_irq_domain_ops, intc);
 	if (!intc->domain)
 		return -ENOMEM;
 
diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
index 2a349082af81..942c1f8c363d 100644
--- a/drivers/irqchip/irq-realtek-rtl.c
+++ b/drivers/irqchip/irq-realtek-rtl.c
@@ -162,7 +162,7 @@ static int __init realtek_rtl_of_init(struct device_node *node, struct device_no
 	else if (!parent_irq)
 		return -ENODEV;
 
-	domain = irq_domain_add_linear(node, RTL_ICTL_NUM_INPUTS, &irq_domain_ops, NULL);
+	domain = irq_domain_create_linear(of_fwnode_handle(node), RTL_ICTL_NUM_INPUTS, &irq_domain_ops, NULL);
 	if (!domain)
 		return -ENOMEM;
 
diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 954419f2460d..0959ed43b1a9 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -513,8 +513,10 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	irq_chip->irq_set_wake = intc_irqpin_irq_set_wake;
 	irq_chip->flags	= IRQCHIP_MASK_ON_SUSPEND;
 
-	p->irq_domain = irq_domain_add_simple(dev->of_node, nirqs, 0,
-					      &intc_irqpin_irq_domain_ops, p);
+	p->irq_domain = irq_domain_create_simple(of_fwnode_handle(dev->of_node),
+						 nirqs, 0,
+						 &intc_irqpin_irq_domain_ops,
+						 p);
 	if (!p->irq_domain) {
 		ret = -ENXIO;
 		dev_err(dev, "cannot initialize irq domain\n");
diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index cbce8ffc7de4..5c3196e5a437 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -168,8 +168,8 @@ static int irqc_probe(struct platform_device *pdev)
 
 	p->cpu_int_base = p->iomem + IRQC_INT_CPU_BASE(0); /* SYS-SPI */
 
-	p->irq_domain = irq_domain_add_linear(dev->of_node, p->number_of_irqs,
-					      &irq_generic_chip_ops, p);
+	p->irq_domain = irq_domain_create_linear(of_fwnode_handle(dev->of_node), p->number_of_irqs,
+						 &irq_generic_chip_ops, p);
 	if (!p->irq_domain) {
 		ret = -ENXIO;
 		dev_err(dev, "cannot initialize irq domain\n");
diff --git a/drivers/irqchip/irq-renesas-rza1.c b/drivers/irqchip/irq-renesas-rza1.c
index d4e6a68889ec..0a9640ba0adb 100644
--- a/drivers/irqchip/irq-renesas-rza1.c
+++ b/drivers/irqchip/irq-renesas-rza1.c
@@ -231,9 +231,9 @@ static int rza1_irqc_probe(struct platform_device *pdev)
 	priv->chip.irq_set_type = rza1_irqc_set_type;
 	priv->chip.flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE;
 
-	priv->irq_domain = irq_domain_add_hierarchy(parent, 0, IRQC_NUM_IRQ,
-						    np, &rza1_irqc_domain_ops,
-						    priv);
+	priv->irq_domain = irq_domain_create_hierarchy(parent, 0, IRQC_NUM_IRQ,
+						       of_fwnode_handle(np), &rza1_irqc_domain_ops,
+						       priv);
 	if (!priv->irq_domain) {
 		dev_err(dev, "cannot initialize irq domain\n");
 		ret = -ENOMEM;
diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 6a2e41f02446..1e861bd64f97 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -574,9 +574,9 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 
 	raw_spin_lock_init(&rzg2l_irqc_data->lock);
 
-	irq_domain = irq_domain_add_hierarchy(parent_domain, 0, IRQC_NUM_IRQ,
-					      node, &rzg2l_irqc_domain_ops,
-					      rzg2l_irqc_data);
+	irq_domain = irq_domain_create_hierarchy(parent_domain, 0, IRQC_NUM_IRQ,
+						 of_fwnode_handle(node), &rzg2l_irqc_domain_ops,
+						 rzg2l_irqc_data);
 	if (!irq_domain) {
 		pm_runtime_put(dev);
 		return dev_err_probe(dev, -ENOMEM, "failed to add irq domain\n");
diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 3d5b5fdf9bde..7a61d454a1a5 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -514,8 +514,9 @@ static int rzv2h_icu_init_common(struct device_node *node, struct device_node *p
 
 	raw_spin_lock_init(&rzv2h_icu_data->lock);
 
-	irq_domain = irq_domain_add_hierarchy(parent_domain, 0, ICU_NUM_IRQ, node,
-					      &rzv2h_icu_domain_ops, rzv2h_icu_data);
+	irq_domain = irq_domain_create_hierarchy(parent_domain, 0, ICU_NUM_IRQ,
+						 of_fwnode_handle(node), &rzv2h_icu_domain_ops,
+						 rzv2h_icu_data);
 	if (!irq_domain) {
 		dev_err(&pdev->dev, "failed to add irq domain\n");
 		ret = -ENOMEM;
diff --git a/drivers/irqchip/irq-sa11x0.c b/drivers/irqchip/irq-sa11x0.c
index 9d0b80271949..d8d4dff16276 100644
--- a/drivers/irqchip/irq-sa11x0.c
+++ b/drivers/irqchip/irq-sa11x0.c
@@ -162,7 +162,7 @@ void __init sa11x0_init_irq_nodt(int irq_start, resource_size_t io_start)
 	 */
 	writel_relaxed(1, iobase + ICCR);
 
-	sa1100_normal_irqdomain = irq_domain_add_simple(NULL,
+	sa1100_normal_irqdomain = irq_domain_create_simple(NULL,
 			32, irq_start,
 			&sa1100_normal_irqdomain_ops, NULL);
 
diff --git a/drivers/irqchip/irq-sni-exiu.c b/drivers/irqchip/irq-sni-exiu.c
index 7d10bf6e5824..0cad68aa8388 100644
--- a/drivers/irqchip/irq-sni-exiu.c
+++ b/drivers/irqchip/irq-sni-exiu.c
@@ -253,8 +253,8 @@ static int __init exiu_dt_init(struct device_node *node,
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
-	domain = irq_domain_add_hierarchy(parent_domain, 0, NUM_IRQS, node,
-					  &exiu_domain_ops, data);
+	domain = irq_domain_create_hierarchy(parent_domain, 0, NUM_IRQS, of_fwnode_handle(node),
+					     &exiu_domain_ops, data);
 	if (!domain) {
 		pr_err("%pOF: failed to allocate domain\n", node);
 		goto out_unmap;
diff --git a/drivers/irqchip/irq-sp7021-intc.c b/drivers/irqchip/irq-sp7021-intc.c
index bed78d1def3d..2a6eda9ab62e 100644
--- a/drivers/irqchip/irq-sp7021-intc.c
+++ b/drivers/irqchip/irq-sp7021-intc.c
@@ -256,8 +256,8 @@ static int __init sp_intc_init_dt(struct device_node *node, struct device_node *
 		writel_relaxed(~0, REG_INTR_CLEAR + i * 4);
 	}
 
-	sp_intc.domain = irq_domain_add_linear(node, SP_INTC_NR_IRQS,
-					       &sp_intc_dm_ops, &sp_intc);
+	sp_intc.domain = irq_domain_create_linear(of_fwnode_handle(node), SP_INTC_NR_IRQS,
+						  &sp_intc_dm_ops, &sp_intc);
 	if (!sp_intc.domain) {
 		ret = -ENOMEM;
 		goto out_unmap1;
diff --git a/drivers/irqchip/irq-starfive-jh8100-intc.c b/drivers/irqchip/irq-starfive-jh8100-intc.c
index 0f5837176e53..2460798ec158 100644
--- a/drivers/irqchip/irq-starfive-jh8100-intc.c
+++ b/drivers/irqchip/irq-starfive-jh8100-intc.c
@@ -158,8 +158,8 @@ static int __init starfive_intc_init(struct device_node *intc,
 
 	raw_spin_lock_init(&irqc->lock);
 
-	irqc->domain = irq_domain_add_linear(intc, STARFIVE_INTC_SRC_IRQ_NUM,
-					     &starfive_intc_domain_ops, irqc);
+	irqc->domain = irq_domain_create_linear(of_fwnode_handle(intc), STARFIVE_INTC_SRC_IRQ_NUM,
+						&starfive_intc_domain_ops, irqc);
 	if (!irqc->domain) {
 		pr_err("Unable to create IRQ domain\n");
 		ret = -EINVAL;
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 7c6a0080c330..7cd34f9b0269 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -344,8 +344,8 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
 	if (!host_data)
 		return -ENOMEM;
 
-	domain = irq_domain_add_linear(node, drv_data->bank_nr * IRQS_PER_BANK,
-				       &irq_exti_domain_ops, NULL);
+	domain = irq_domain_create_linear(of_fwnode_handle(node), drv_data->bank_nr * IRQS_PER_BANK,
+					  &irq_exti_domain_ops, NULL);
 	if (!domain) {
 		pr_err("%pOFn: Could not register interrupt domain.\n",
 		       node);
diff --git a/drivers/irqchip/irq-stm32mp-exti.c b/drivers/irqchip/irq-stm32mp-exti.c
index 649b84f12efc..c6b4407d05f9 100644
--- a/drivers/irqchip/irq-stm32mp-exti.c
+++ b/drivers/irqchip/irq-stm32mp-exti.c
@@ -682,10 +682,9 @@ static int stm32mp_exti_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	domain = irq_domain_add_hierarchy(parent_domain, 0,
-					  drv_data->bank_nr * IRQS_PER_BANK,
-					  np, &stm32mp_exti_domain_ops,
-					  host_data);
+	domain = irq_domain_create_hierarchy(parent_domain, 0, drv_data->bank_nr * IRQS_PER_BANK,
+					     of_fwnode_handle(np), &stm32mp_exti_domain_ops,
+					     host_data);
 
 	if (!domain) {
 		dev_err(dev, "Could not register exti domain\n");
diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index dd506ebfdacb..9c2c9caeca2a 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -133,7 +133,7 @@ static int __init sun4i_of_init(struct device_node *node,
 	/* Configure the external interrupt source type */
 	writel(0x00, irq_ic_data->irq_base + SUN4I_IRQ_NMI_CTRL_REG);
 
-	irq_ic_data->irq_domain = irq_domain_add_linear(node, 3 * 32,
+	irq_ic_data->irq_domain = irq_domain_create_linear(of_fwnode_handle(node), 3 * 32,
 						 &sun4i_irq_ops, NULL);
 	if (!irq_ic_data->irq_domain)
 		panic("%pOF: unable to create IRQ domain\n", node);
diff --git a/drivers/irqchip/irq-sun6i-r.c b/drivers/irqchip/irq-sun6i-r.c
index 99958d470d62..37d4b29763bc 100644
--- a/drivers/irqchip/irq-sun6i-r.c
+++ b/drivers/irqchip/irq-sun6i-r.c
@@ -338,8 +338,8 @@ static int __init sun6i_r_intc_init(struct device_node *node,
 		return PTR_ERR(base);
 	}
 
-	domain = irq_domain_add_hierarchy(parent_domain, 0, 0, node,
-					  &sun6i_r_intc_domain_ops, NULL);
+	domain = irq_domain_create_hierarchy(parent_domain, 0, 0, of_fwnode_handle(node),
+					     &sun6i_r_intc_domain_ops, NULL);
 	if (!domain) {
 		pr_err("%pOF: Failed to allocate domain\n", node);
 		iounmap(base);
diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index 01b0d8321728..f521341f50d9 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -159,7 +159,7 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
 	struct irq_domain *domain;
 	int ret;
 
-	domain = irq_domain_add_linear(node, 1, &irq_generic_chip_ops, NULL);
+	domain = irq_domain_create_linear(of_fwnode_handle(node), 1, &irq_generic_chip_ops, NULL);
 	if (!domain) {
 		pr_err("Could not register interrupt domain.\n");
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-tb10x.c b/drivers/irqchip/irq-tb10x.c
index d59bfbe8c6d0..733dbda18a82 100644
--- a/drivers/irqchip/irq-tb10x.c
+++ b/drivers/irqchip/irq-tb10x.c
@@ -121,13 +121,13 @@ static int __init of_tb10x_init_irq(struct device_node *ictl,
 		goto ioremap_fail;
 	}
 
-	domain = irq_domain_add_linear(ictl, AB_IRQCTL_MAXIRQ,
-					&irq_generic_chip_ops, NULL);
+	domain = irq_domain_create_linear(of_fwnode_handle(ictl), AB_IRQCTL_MAXIRQ,
+					  &irq_generic_chip_ops, NULL);
 	if (!domain) {
 		ret = -ENOMEM;
 		pr_err("%pOFn: Could not register interrupt domain.\n",
 			ictl);
-		goto irq_domain_add_fail;
+		goto irq_domain_create_fail;
 	}
 
 	ret = irq_alloc_domain_generic_chips(domain, AB_IRQCTL_MAXIRQ,
@@ -174,7 +174,7 @@ static int __init of_tb10x_init_irq(struct device_node *ictl,
 
 gc_alloc_fail:
 	irq_domain_remove(domain);
-irq_domain_add_fail:
+irq_domain_create_fail:
 	iounmap(reg_base);
 ioremap_fail:
 	release_mem_region(mem.start, resource_size(&mem));
diff --git a/drivers/irqchip/irq-tegra.c b/drivers/irqchip/irq-tegra.c
index ad3e2c1b3c87..66cbb9f77ff3 100644
--- a/drivers/irqchip/irq-tegra.c
+++ b/drivers/irqchip/irq-tegra.c
@@ -330,9 +330,8 @@ static int __init tegra_ictlr_init(struct device_node *node,
 	     node, num_ictlrs, soc->num_ictlrs);
 
 
-	domain = irq_domain_add_hierarchy(parent_domain, 0, num_ictlrs * 32,
-					  node, &tegra_ictlr_domain_ops,
-					  lic);
+	domain = irq_domain_create_hierarchy(parent_domain, 0, num_ictlrs * 32,
+					     of_fwnode_handle(node), &tegra_ictlr_domain_ops, lic);
 	if (!domain) {
 		pr_err("%pOF: failed to allocated domain\n", node);
 		err = -ENOMEM;
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index 38dfc1f9a56b..7de59238e6b0 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -701,9 +701,9 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	domain = irq_domain_add_linear(dev_of_node(dev),
-				       ti_sci_get_num_resources(inta->vint),
-				       &ti_sci_inta_irq_domain_ops, inta);
+	domain = irq_domain_create_linear(of_fwnode_handle(dev_of_node(dev)),
+					  ti_sci_get_num_resources(inta->vint),
+					  &ti_sci_inta_irq_domain_ops, inta);
 	if (!domain) {
 		dev_err(dev, "Failed to allocate IRQ domain\n");
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
index 686a8f69fd9c..07fff5ae5ce0 100644
--- a/drivers/irqchip/irq-ti-sci-intr.c
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -274,8 +274,9 @@ static int ti_sci_intr_irq_domain_probe(struct platform_device *pdev)
 		return PTR_ERR(intr->out_irqs);
 	}
 
-	domain = irq_domain_add_hierarchy(parent_domain, 0, 0, dev_of_node(dev),
-					  &ti_sci_intr_irq_domain_ops, intr);
+	domain = irq_domain_create_hierarchy(parent_domain, 0, 0,
+					     of_fwnode_handle(dev_of_node(dev)),
+					     &ti_sci_intr_irq_domain_ops, intr);
 	if (!domain) {
 		dev_err(dev, "Failed to allocate IRQ domain\n");
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index 960c343d5781..e625f4fb2bb8 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -125,7 +125,7 @@ static int ts4800_ic_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	data->domain = irq_domain_add_linear(node, 8, &ts4800_ic_ops, data);
+	data->domain = irq_domain_create_linear(of_fwnode_handle(node), 8, &ts4800_ic_ops, data);
 	if (!data->domain) {
 		dev_err(&pdev->dev, "cannot add IRQ domain\n");
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
index 0abc8934c2ee..034ce6afe170 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -176,8 +176,8 @@ static void __init fpga_irq_init(void __iomem *base, int parent_irq,
 						 f);
 	}
 
-	f->domain = irq_domain_add_linear(node, fls(valid),
-					  &fpga_irqdomain_ops, f);
+	f->domain = irq_domain_create_linear(of_fwnode_handle(node), fls(valid),
+					     &fpga_irqdomain_ops, f);
 
 	/* This will allocate all valid descriptors in the linear case */
 	for (i = 0; i < fls(valid); i++)
diff --git a/drivers/irqchip/irq-vf610-mscm-ir.c b/drivers/irqchip/irq-vf610-mscm-ir.c
index 2b9a8ba58e26..5d9c7503aa7f 100644
--- a/drivers/irqchip/irq-vf610-mscm-ir.c
+++ b/drivers/irqchip/irq-vf610-mscm-ir.c
@@ -209,9 +209,9 @@ static int __init vf610_mscm_ir_of_init(struct device_node *node,
 	regmap_read(mscm_cp_regmap, MSCM_CPxNUM, &cpuid);
 	mscm_ir_data->cpu_mask = 0x1 << cpuid;
 
-	domain = irq_domain_add_hierarchy(domain_parent, 0,
-					  MSCM_IRSPRC_NUM, node,
-					  &mscm_irq_domain_ops, mscm_ir_data);
+	domain = irq_domain_create_hierarchy(domain_parent, 0, MSCM_IRSPRC_NUM,
+					     of_fwnode_handle(node), &mscm_irq_domain_ops,
+					     mscm_ir_data);
 	if (!domain) {
 		ret = -ENOMEM;
 		goto out_unmap;
diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index ea93e7236c4a..2bcdf216a000 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -289,8 +289,9 @@ static void __init vic_register(void __iomem *base, unsigned int parent_irq,
 						 vic_handle_irq_cascaded, v);
 	}
 
-	v->domain = irq_domain_add_simple(node, fls(valid_sources), irq,
-					  &vic_irqdomain_ops, v);
+	v->domain = irq_domain_create_simple(of_fwnode_handle(node),
+					     fls(valid_sources), irq,
+					     &vic_irqdomain_ops, v);
 	/* create an IRQ mapping for each valid IRQ */
 	for (i = 0; i < fls(valid_sources); i++)
 		if (valid_sources & (1 << i))
diff --git a/drivers/irqchip/irq-vt8500.c b/drivers/irqchip/irq-vt8500.c
index e17dd3a8c2d5..55d5cd1211d9 100644
--- a/drivers/irqchip/irq-vt8500.c
+++ b/drivers/irqchip/irq-vt8500.c
@@ -200,7 +200,7 @@ static int __init vt8500_irq_init(struct device_node *node,
 	}
 
 	intc[active_cnt].base = of_iomap(np, 0);
-	intc[active_cnt].domain = irq_domain_add_linear(node, 64,
+	intc[active_cnt].domain = irq_domain_create_linear(of_fwnode_handle(node), 64,
 			&vt8500_irq_domain_ops,	&intc[active_cnt]);
 
 	if (!intc[active_cnt].base) {
diff --git a/drivers/irqchip/irq-wpcm450-aic.c b/drivers/irqchip/irq-wpcm450-aic.c
index 91df62a64cd9..a8ed4894d29e 100644
--- a/drivers/irqchip/irq-wpcm450-aic.c
+++ b/drivers/irqchip/irq-wpcm450-aic.c
@@ -154,7 +154,7 @@ static int __init wpcm450_aic_of_init(struct device_node *node,
 
 	set_handle_irq(wpcm450_aic_handle_irq);
 
-	aic->domain = irq_domain_add_linear(node, AIC_NUM_IRQS, &wpcm450_aic_ops, aic);
+	aic->domain = irq_domain_create_linear(of_fwnode_handle(node), AIC_NUM_IRQS, &wpcm450_aic_ops, aic);
 
 	return 0;
 }
diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 38727e9cc713..92dcb9fdcb25 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -212,8 +212,8 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 		xintc_write(irqc, MER, MER_HIE | MER_ME);
 	}
 
-	irqc->root_domain = irq_domain_add_linear(intc, irqc->nr_irq,
-						  &xintc_irq_domain_ops, irqc);
+	irqc->root_domain = irq_domain_create_linear(of_fwnode_handle(intc), irqc->nr_irq,
+						     &xintc_irq_domain_ops, irqc);
 	if (!irqc->root_domain) {
 		pr_err("irq-xilinx: Unable to create IRQ domain\n");
 		ret = -EINVAL;
diff --git a/drivers/irqchip/irq-xtensa-mx.c b/drivers/irqchip/irq-xtensa-mx.c
index 9b441d180299..9fdacbd89a63 100644
--- a/drivers/irqchip/irq-xtensa-mx.c
+++ b/drivers/irqchip/irq-xtensa-mx.c
@@ -167,8 +167,7 @@ static void __init xtensa_mx_init_common(struct irq_domain *root_domain)
 int __init xtensa_mx_init_legacy(struct device_node *interrupt_parent)
 {
 	struct irq_domain *root_domain =
-		irq_domain_add_legacy(NULL, NR_IRQS - 1, 1, 0,
-				&xtensa_mx_irq_domain_ops,
+		irq_domain_create_legacy(NULL, NR_IRQS - 1, 1, 0, &xtensa_mx_irq_domain_ops,
 				&xtensa_mx_irq_chip);
 	xtensa_mx_init_common(root_domain);
 	return 0;
@@ -178,7 +177,7 @@ static int __init xtensa_mx_init(struct device_node *np,
 		struct device_node *interrupt_parent)
 {
 	struct irq_domain *root_domain =
-		irq_domain_add_linear(np, NR_IRQS, &xtensa_mx_irq_domain_ops,
+		irq_domain_create_linear(of_fwnode_handle(np), NR_IRQS, &xtensa_mx_irq_domain_ops,
 				&xtensa_mx_irq_chip);
 	xtensa_mx_init_common(root_domain);
 	return 0;
diff --git a/drivers/irqchip/irq-xtensa-pic.c b/drivers/irqchip/irq-xtensa-pic.c
index 9be7b7c5cd23..44e7be051a2e 100644
--- a/drivers/irqchip/irq-xtensa-pic.c
+++ b/drivers/irqchip/irq-xtensa-pic.c
@@ -85,7 +85,7 @@ static struct irq_chip xtensa_irq_chip = {
 int __init xtensa_pic_init_legacy(struct device_node *interrupt_parent)
 {
 	struct irq_domain *root_domain =
-		irq_domain_add_legacy(NULL, NR_IRQS - 1, 1, 0,
+		irq_domain_create_legacy(NULL, NR_IRQS - 1, 1, 0,
 				&xtensa_irq_domain_ops, &xtensa_irq_chip);
 	irq_set_default_domain(root_domain);
 	return 0;
@@ -95,7 +95,7 @@ static int __init xtensa_pic_init(struct device_node *np,
 		struct device_node *interrupt_parent)
 {
 	struct irq_domain *root_domain =
-		irq_domain_add_linear(np, NR_IRQS, &xtensa_irq_domain_ops,
+		irq_domain_create_linear(of_fwnode_handle(np), NR_IRQS, &xtensa_irq_domain_ops,
 				&xtensa_irq_chip);
 	irq_set_default_domain(root_domain);
 	return 0;
diff --git a/drivers/irqchip/irq-zevio.c b/drivers/irqchip/irq-zevio.c
index 7a72620fc478..22d46c246594 100644
--- a/drivers/irqchip/irq-zevio.c
+++ b/drivers/irqchip/irq-zevio.c
@@ -92,8 +92,8 @@ static int __init zevio_of_init(struct device_node *node,
 	zevio_init_irq_base(zevio_irq_io + IO_IRQ_BASE);
 	zevio_init_irq_base(zevio_irq_io + IO_FIQ_BASE);
 
-	zevio_irq_domain = irq_domain_add_linear(node, MAX_INTRS,
-						 &irq_generic_chip_ops, NULL);
+	zevio_irq_domain = irq_domain_create_linear(of_fwnode_handle(node), MAX_INTRS,
+						    &irq_generic_chip_ops, NULL);
 	BUG_ON(!zevio_irq_domain);
 
 	ret = irq_alloc_domain_generic_chips(zevio_irq_domain, MAX_INTRS, 1,
diff --git a/drivers/irqchip/spear-shirq.c b/drivers/irqchip/spear-shirq.c
index 7c17a6f643ef..576e55569d77 100644
--- a/drivers/irqchip/spear-shirq.c
+++ b/drivers/irqchip/spear-shirq.c
@@ -239,7 +239,7 @@ static int __init shirq_init(struct spear_shirq **shirq_blocks, int block_nr,
 		goto err_unmap;
 	}
 
-	shirq_domain = irq_domain_add_legacy(np, nr_irqs, virq_base, 0,
+	shirq_domain = irq_domain_create_legacy(of_fwnode_handle(np), nr_irqs, virq_base, 0,
 			&irq_domain_simple_ops, NULL);
 	if (WARN_ON(!shirq_domain)) {
 		pr_warn("%s: irq domain init failed\n", __func__);
-- 
2.49.0


