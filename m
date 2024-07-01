Return-Path: <linux-kernel+bounces-236386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5901391E16B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2EE1F249BC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D36615FA8D;
	Mon,  1 Jul 2024 13:54:21 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C21166306
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842060; cv=none; b=JjiphtdtiAwb4n6O3Gh1Hf5fkkSuigdKFETFi0DAvPhokAeCb/C0pa7QWIevnTCxhRkuhroYOO1ddqTmqk4LvUTVYuEMdc9e7WInkikZUHHw2kSP0hvetTvAmg7gQUpDhzxNkZOBEhc5OeEBkFOqRlKJpAwoUnRCI6mjo/M5cy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842060; c=relaxed/simple;
	bh=eGXy1OFvj3SosF7bnlGCLhzounuJ5ghZkNJ65LsPcFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DuaaTO1SXyRwyGuvMzSUDE8NqBYUpUKTfDfMGdkMWSxObnMkKvhfCWPrhIxYb4cqtjUXUlAyu/42kkJzilJcFnfrc+48Nv7DYXSpL0KVRnBuy/+/c1wrpi8L9x+ghO5LdEYuvIXct3UjGd6NG+Ie1s7uC+7qHeeRGBaFHevtPxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1sOHTX-0001LY-MS; Mon, 01 Jul 2024 15:53:47 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Mon, 01 Jul 2024 15:53:45 +0200
Subject: [PATCH 6/9] powerpc: convert to MTD_EEPROM_AT24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-b4-v6-10-topic-usbc-tcpci-v1-6-3fd5f4a193cc@pengutronix.de>
References: <20240701-b4-v6-10-topic-usbc-tcpci-v1-0-3fd5f4a193cc@pengutronix.de>
In-Reply-To: <20240701-b4-v6-10-topic-usbc-tcpci-v1-0-3fd5f4a193cc@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Russell King <linux@armlinux.org.uk>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, 
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Tony Lindgren <tony@atomide.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, imx@lists.linux.dev, 
 linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-tegra@vger.kernel.org, openbmc@lists.ozlabs.org, 
 linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, 
 loongarch@lists.linux.dev, Marco Felsch <m.felsch@pengutronix.de>
X-Mailer: b4 0.15-dev
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The EEPROM_AT24 Kconfig symbol is marked as deprecated. Make use of the
new Kconfig symbol to select the I2C EEPROM driver support.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/powerpc/configs/44x/warp_defconfig | 2 +-
 arch/powerpc/configs/mpc512x_defconfig  | 2 +-
 arch/powerpc/configs/mpc5200_defconfig  | 2 +-
 arch/powerpc/configs/ppc6xx_defconfig   | 2 +-
 arch/powerpc/configs/skiroot_defconfig  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/configs/44x/warp_defconfig b/arch/powerpc/configs/44x/warp_defconfig
index 20891c413149..d8cab860c9d9 100644
--- a/arch/powerpc/configs/44x/warp_defconfig
+++ b/arch/powerpc/configs/44x/warp_defconfig
@@ -36,7 +36,7 @@ CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_NDFC=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_RAM=y
-CONFIG_EEPROM_AT24=y
+CONFIG_MTD_EEPROM_AT24=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_SPI_ATTRS=y
diff --git a/arch/powerpc/configs/mpc512x_defconfig b/arch/powerpc/configs/mpc512x_defconfig
index d24457bc5791..0a919a76cfb8 100644
--- a/arch/powerpc/configs/mpc512x_defconfig
+++ b/arch/powerpc/configs/mpc512x_defconfig
@@ -46,7 +46,7 @@ CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=1
 CONFIG_BLK_DEV_RAM_SIZE=8192
-CONFIG_EEPROM_AT24=y
+CONFIG_MTD_EEPROM_AT24=y
 CONFIG_EEPROM_AT25=y
 CONFIG_SCSI=y
 # CONFIG_SCSI_PROC_FS is not set
diff --git a/arch/powerpc/configs/mpc5200_defconfig b/arch/powerpc/configs/mpc5200_defconfig
index c0fe5e76604a..8142836ef61a 100644
--- a/arch/powerpc/configs/mpc5200_defconfig
+++ b/arch/powerpc/configs/mpc5200_defconfig
@@ -38,7 +38,7 @@ CONFIG_MTD_UBI=m
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=32768
-CONFIG_EEPROM_AT24=y
+CONFIG_MTD_EEPROM_AT24=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_SG=y
 CONFIG_ATA=y
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 66c7b28d7450..5bca729a57c2 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -318,7 +318,7 @@ CONFIG_CDROM_PKTCDVD=m
 CONFIG_VIRTIO_BLK=m
 CONFIG_ENCLOSURE_SERVICES=m
 CONFIG_SENSORS_TSL2550=m
-CONFIG_EEPROM_AT24=m
+CONFIG_MTD_EEPROM_AT24=m
 CONFIG_EEPROM_LEGACY=m
 CONFIG_EEPROM_MAX6875=m
 CONFIG_EEPROM_93CX6=m
diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
index 9d44e6630908..e9be7f217cea 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -77,7 +77,7 @@ CONFIG_BLK_DEV_RAM_SIZE=65536
 CONFIG_VIRTIO_BLK=m
 CONFIG_BLK_DEV_NVME=m
 CONFIG_NVME_MULTIPATH=y
-CONFIG_EEPROM_AT24=m
+CONFIG_MTD_EEPROM_AT24=m
 # CONFIG_CXL is not set
 # CONFIG_OCXL is not set
 CONFIG_BLK_DEV_SD=m

-- 
2.39.2


