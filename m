Return-Path: <linux-kernel+bounces-258752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0273E938C62
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B68BB21D38
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE9116F82C;
	Mon, 22 Jul 2024 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="FbS9DoRP"
Received: from smtpout149.security-mail.net (smtpout149.security-mail.net [85.31.212.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462CD16C847
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641434; cv=none; b=oY2i+2UjeoPyZjkrfb4TT+Qu23+h9djnY9J3RjC6HxA9HzGYgEALdbncTfqMv0U6h0yBIndLOZtGaM6yUdAb1R0K5AbAvcYizB7Xh/Q1GevQbY7fi3hWb7icn5sZ8dAkxMDr5ZejczPRMz4FZYVRN5hbGhqnDE5yTsidItbzqWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641434; c=relaxed/simple;
	bh=MWUsgTr5EuOubB9gzKhFGSdMC/v2HrUmZunk2jYGDNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AWn060bojLF/zaEriUJnxQkarrQx28j4j831hdMt52/iYw+2INsfdkV6KAshBh4fdgdbIVHXa70ATTxbe8GdoLFs3+LZK0QMnaeOiV5YZ0IKZdfttnDyUQB6v4utxJ5XemBt1Lc0IswACs5B8TVKBGmuQCmdM49H8NxMmi5xhwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=FbS9DoRP; arc=none smtp.client-ip=85.31.212.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx409.security-mail.net [127.0.0.1])
	by fx409.security-mail.net (Postfix) with ESMTP id DF42534971F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641430;
	bh=MWUsgTr5EuOubB9gzKhFGSdMC/v2HrUmZunk2jYGDNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FbS9DoRPlyPcACDgyYXadIgMZDJ3zelKPoHC/1nZtPbYGKc2z7BPTRFqu5Z7cTP+Q
	 +HVMky8cZD946R2UEE+4vRAHOMcAOmJ5lTJehMbKoesQnIJgyWaUOhXHa8zxE6f4ul
	 mEarlDlGH8AdAg+m59C/xS0/sRg9c2qtI3ZRFjKg=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 9E309349696; Mon, 22 Jul
 2024 11:43:50 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx409.security-mail.net (Postfix) with ESMTPS id A90A4349619; Mon, 22 Jul
 2024 11:43:49 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id 7AEB640317; Mon, 22 Jul
 2024 11:43:49 +0200 (CEST)
X-Secumail-id: <53b3.669e29d5.a537a.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Ashley
 Lesdalons <alesdalons@kalrayinc.com>, Benjamin Mugnier
 <mugnier.benjamin@gmail.com>, Clement Leger <clement@clement-leger.fr>,
 Guillaume Thouvenin <thouveng@gmail.com>, Jules Maselbas
 <jmaselbas@zdiv.net>, Samuel Jones <sjones@kalrayinc.com>, Thomas Costis
 <thcostis@gmail.com>, Vincent Chardon <vincent.chardon@elsys-design.com>
Subject: [RFC PATCH v3 31/37] kvx: Add kvx default config file
Date: Mon, 22 Jul 2024 11:41:42 +0200
Message-ID: <20240722094226.21602-32-ysionneau@kalrayinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722094226.21602-1-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

From: Yann Sionneau <ysionneau@kalrayinc.com>

Add a default config file for kvx based Coolidge SoC.

Co-developed-by: Ashley Lesdalons <alesdalons@kalrayinc.com>
Signed-off-by: Ashley Lesdalons <alesdalons@kalrayinc.com>
Co-developed-by: Benjamin Mugnier <mugnier.benjamin@gmail.com>
Signed-off-by: Benjamin Mugnier <mugnier.benjamin@gmail.com>
Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Guillaume Thouvenin <thouveng@gmail.com>
Signed-off-by: Guillaume Thouvenin <thouveng@gmail.com>
Co-developed-by: Jules Maselbas <jmaselbas@zdiv.net>
Signed-off-by: Jules Maselbas <jmaselbas@zdiv.net>
Co-developed-by: Julian Vetter <jvetter@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
Co-developed-by: Samuel Jones <sjones@kalrayinc.com>
Signed-off-by: Samuel Jones <sjones@kalrayinc.com>
Co-developed-by: Thomas Costis <thcostis@gmail.com>
Signed-off-by: Thomas Costis <thcostis@gmail.com>
Co-developed-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Signed-off-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:
V1 -> V2: default_defconfig renamed to defconfig
V2 -> V3: ext4 now builtin, add virtio-blk and devtmpfs
---
 arch/kvx/configs/defconfig | 130 +++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 arch/kvx/configs/defconfig

diff --git a/arch/kvx/configs/defconfig b/arch/kvx/configs/defconfig
new file mode 100644
index 0000000000000..9d7a37801c028
--- /dev/null
+++ b/arch/kvx/configs/defconfig
@@ -0,0 +1,130 @@
+CONFIG_DEFAULT_HOSTNAME="KVXlinux"
+CONFIG_SERIAL_KVX_SCALL_COMM=y
+CONFIG_CONFIGFS_FS=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_DWARF4=y
+CONFIG_PRINTK_TIME=y
+CONFIG_CONSOLE_LOGLEVEL_DEFAULT=15
+CONFIG_MESSAGE_LOGLEVEL_DEFAULT=7
+CONFIG_PANIC_TIMEOUT=-1
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_GDB_SCRIPTS=y
+CONFIG_FRAME_POINTER=y
+CONFIG_HZ_100=y
+CONFIG_SERIAL_EARLYCON=y
+CONFIG_HOTPLUG_PCI_PCIE=y
+CONFIG_PCIEAER=y
+CONFIG_PCIE_DPC=y
+CONFIG_HOTPLUG_PCI=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_DW=y
+CONFIG_SERIAL_8250_NR_UARTS=8
+CONFIG_SERIAL_8250_RUNTIME_UARTS=8
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_SINGLE=y
+CONFIG_POWER_RESET_KVX_SCALL_POWEROFF=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCIE_KVX_NWL=y
+CONFIG_PCIEPORTBUS=y
+# CONFIG_PCIEASPM is not set
+CONFIG_PCIEAER_INJECT=y
+CONFIG_TMPFS=y
+CONFIG_DMADEVICES=y
+CONFIG_KVX_DMA_NOC=m
+CONFIG_KVX_IOMMU=y
+CONFIG_KVX_OTP_NV=y
+CONFIG_PACKET=y
+CONFIG_NET=y
+# CONFIG_WLAN is not set
+CONFIG_INET=y
+CONFIG_IPV6=y
+CONFIG_NETDEVICES=y
+CONFIG_NET_CORE=y
+CONFIG_E1000E=y
+CONFIG_BLK_DEV_NVME=y
+CONFIG_VFAT_FS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_WATCHDOG=y
+CONFIG_KVX_WATCHDOG=y
+CONFIG_HUGETLBFS=y
+CONFIG_MAILBOX=y
+CONFIG_KVX_MBOX=y
+CONFIG_REMOTEPROC=y
+CONFIG_KVX_REMOTEPROC=y
+CONFIG_VIRTIO_NET=y
+CONFIG_VIRTIO_MMIO=y
+CONFIG_RPMSG_VIRTIO=y
+CONFIG_RPMSG_CHAR=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+CONFIG_BLK_DEV=y
+CONFIG_BLK_DEV_LOOP=m
+CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_USE_FOR_EXT2=y
+CONFIG_SYSVIPC=y
+CONFIG_UNIX=y
+CONFIG_NET_VENDOR_KALRAY=y
+CONFIG_NET_KVX_SOC=m
+CONFIG_STACKPROTECTOR=y
+CONFIG_GPIO_DWAPB=y
+CONFIG_I2C=y
+CONFIG_I2C_SLAVE=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_DESIGNWARE_PLATFORM=y
+CONFIG_I2C_DESIGNWARE_CORE=y
+CONFIG_I2C_DESIGNWARE_SLAVE=y
+CONFIG_I2C_SLAVE_USPACE=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SYSCON=y
+CONFIG_SPI=y
+CONFIG_SPI_DESIGNWARE=y
+CONFIG_SPI_DW_MMIO=y
+CONFIG_SPI_DW_KVX=y
+CONFIG_MTD=y
+CONFIG_MTD_SPI_NOR=y
+# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
+CONFIG_SQUASHFS=m
+CONFIG_USB=y
+CONFIG_USB_CONFIGFS=m
+CONFIG_USB_CONFIGFS_ACM=y
+CONFIG_USB_CONFIGFS_ECM=y
+CONFIG_USB_DWC2=y
+CONFIG_USB_DWC2_DUAL_ROLE=y
+CONFIG_USB_GADGET=y
+CONFIG_U_SERIAL_CONSOLE=y
+CONFIG_USB_USBNET=m
+CONFIG_USB_NET_SMSC95XX=m
+# CONFIG_NOP_USB_XCEIV is not set
+CONFIG_USB_PHY=y
+CONFIG_GENERIC_PHY=y
+CONFIG_GENERIC_PHY_USB=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_OF_DWCMSHC=y
+CONFIG_MDIO_BITBANG=m
+CONFIG_MDIO_GPIO=m
+CONFIG_MARVELL_PHY=m
+CONFIG_GPIO_PCA953X=y
+CONFIG_NETFILTER=y
+CONFIG_NF_CONNTRACK=m
+CONFIG_NF_NAT=m
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_NAT=m
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_NETDEV=y
+CONFIG_LEDS_TRIGGER_PATTERN=y
+CONFIG_DCB=y
+CONFIG_VIRTIO_BLK=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
-- 
2.45.2






