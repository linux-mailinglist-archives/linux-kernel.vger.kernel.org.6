Return-Path: <linux-kernel+bounces-335432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D2D97E5AE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 07:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81F31F20FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 05:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D6410A3E;
	Mon, 23 Sep 2024 05:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deepcomputing-io.20200927.dkim.feishu.cn header.i=@deepcomputing-io.20200927.dkim.feishu.cn header.b="WvK9Ywam"
Received: from va-1-15.ptr.blmpb.com (va-1-15.ptr.blmpb.com [209.127.230.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADBB79E1
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 05:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727070066; cv=none; b=FActh5mj7M0xgsDNMXiCDT3h8zjSqWtHKSJk8753yQTN0xABZzzcxfHAhIRRxUexqj+aWZ6vglwbNmcrSdJTXPbMk8hT6agHW1dh4kjF+tJSrxUvzXyQcaWo9dqCrPDk3r8ul3HIicYwHYws/iVyy09LUXsR3fSZmtuSPsJbgSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727070066; c=relaxed/simple;
	bh=UNthkAUAakjUT9JXNYi0I6Kji5qAv3FhL1pkmNEuvzw=;
	h=To:Cc:Content-Type:Subject:Message-Id:From:Date:Mime-Version; b=ppUH3EZmC6SQR7i5d0nfGElB+qxgkfN9bsYF5UcrsEIW8s8IhLlv31nwpk//yN9Pn/lazl2PVVfz5NpWru47hCqP+KfOB2/Kb6sBp+tWDbMM9vR5M0vTzYq99Td/btQJ6d7g6rDPsriLxpdDl+/2xRk/0f1nbpcAxcrSI2fWAKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepcomputing.io; spf=pass smtp.mailfrom=deepcomputing.io; dkim=pass (2048-bit key) header.d=deepcomputing-io.20200927.dkim.feishu.cn header.i=@deepcomputing-io.20200927.dkim.feishu.cn header.b=WvK9Ywam; arc=none smtp.client-ip=209.127.230.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepcomputing.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepcomputing.io
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=deepcomputing-io.20200927.dkim.feishu.cn; t=1727069921;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=rm+jLD7LmwpSNEJzIkH2zPuhNPjw332z9klR4q5Peis=;
 b=WvK9YwamhENJOAv9wEI12+iDQ1UgArwnp5CO04Qt9o6UJsqUi/sNh1nhiKiJ3kN2EpCfgI
 PacPtqloPnQThRSjkRefpPt/p0FeBrU51WNR7fU89GjH9r1flDheeWITpLW6VfK83Ug0DX
 9ruw1Z63Thp8sOb3Na6u1bCgYWMV7ABR//pT765TfIHmwiQNj4K3qkjvH57emWiANeM0q/
 U2lLJAj2D+zHGil8HBHnrH3UfPRz4A6UU5YZPnv4AElxEU671YEzedpa3U3gWu3XgIZavG
 35iouyzQfPMD7FU4l/287gVG1wP4N3kPseFBzwe5zOBXWYgWEL6YorAtMNrKLA==
To: "Emil Renner Berthing" <kernel@esmil.dk>
Cc: "Conor Dooley" <conor@kernel.org>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Paul Walmsley" <paul.walmsley@sifive.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>, 
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Sandie Cao" <sandie.cao@deepcomputing.io>
X-Original-From: Sandie Cao <sandie.cao@deepcomputing.io>
X-Mailer: git-send-email 2.34.1
Received: from roma-MacBookPro.. ([61.141.249.188]) by smtp.feishu.cn with ESMTPS; Mon, 23 Sep 2024 13:38:39 +0800
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 2/2] riscv:configs:starfive:add framework config
Message-Id: <20240923053806.1586080-1-sandie.cao@deepcomputing.io>
Content-Transfer-Encoding: 7bit
From: "Sandie Cao" <sandie.cao@deepcomputing.io>
Date: Mon, 23 Sep 2024 13:38:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+266f0fee0+da99ca+vger.kernel.org+sandie.cao@deepcomputing.io>

Add config to support RISC-V Framework Laptop 13 Mainboard. 

Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>
---
 .../starfive_jh7110_framework_defconfig       | 151 ++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100644 arch/riscv/configs/starfive_jh7110_framework_defconfig

diff --git a/arch/riscv/configs/starfive_jh7110_framework_defconfig b/arch/riscv/configs/starfive_jh7110_framework_defconfig
new file mode 100644
index 000000000000..512ac09184b7
--- /dev/null
+++ b/arch/riscv/configs/starfive_jh7110_framework_defconfig
@@ -0,0 +1,151 @@
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BPF_SYSCALL=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_CGROUPS=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_CFS_BANDWIDTH=y
+CONFIG_CGROUP_BPF=y
+CONFIG_NAMESPACES=y
+CONFIG_USER_NS=y
+CONFIG_CHECKPOINT_RESTORE=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_EXPERT=y
+# CONFIG_SYSFS_SYSCALL is not set
+CONFIG_ARCH_STARFIVE=y
+CONFIG_SOC_STARFIVE=y
+CONFIG_SOC_STARFIVE_JH7110=y
+CONFIG_SMP=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+CONFIG_NETFILTER=y
+CONFIG_NET_9P=y
+CONFIG_NET_9P_VIRTIO=y
+CONFIG_PCI=y
+CONFIG_PCIE_STARFIVE_HOST=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_MTD=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_SPI_NOR=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_VIRTIO_BLK=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_BLK_DEV_SR=y
+CONFIG_SCSI_VIRTIO=y
+CONFIG_ATA=y
+CONFIG_SATA_AHCI=y
+CONFIG_MD=y
+CONFIG_BLK_DEV_DM=m
+CONFIG_NETDEVICES=y
+CONFIG_VIRTIO_NET=y
+CONFIG_R8169=y
+CONFIG_STMMAC_ETH=y
+CONFIG_DWMAC_DWC_QOS_ETH=y
+CONFIG_DWMAC_STARFIVE=y
+CONFIG_MICREL_PHY=y
+CONFIG_MOTORCOMM_PHY=y
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_DW=y
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
+CONFIG_VIRTIO_CONSOLE=y
+CONFIG_HW_RANDOM=y
+CONFIG_HW_RANDOM_JH7110=y
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_DESIGNWARE_PLATFORM=y
+CONFIG_SPI=y
+CONFIG_SPI_PL022=m
+CONFIG_POWER_RESET_GPIO_RESTART=y
+CONFIG_CPU_THERMAL=y
+CONFIG_WATCHDOG=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_AXP20X=y
+CONFIG_REGULATOR_GPIO=y
+CONFIG_FB=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y
+CONFIG_SND_DESIGNWARE_I2S=m
+CONFIG_SND_SOC_STARFIVE=m
+CONFIG_SND_SOC_JH7110_PWMDAC=m
+CONFIG_SND_SOC_JH7110_TDM=m
+CONFIG_SND_SIMPLE_CARD=m
+CONFIG_I2C_HID_OF=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_UAS=y
+CONFIG_USB_CDNS_SUPPORT=y
+CONFIG_USB_CDNS3=y
+CONFIG_USB_CDNS3_GADGET=y
+CONFIG_USB_CDNS3_HOST=y
+CONFIG_USB_CDNS3_STARFIVE=y
+CONFIG_USB_CONFIGFS=y
+CONFIG_USB_CONFIGFS_MASS_STORAGE=y
+CONFIG_USB_CONFIGFS_F_FS=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_OF_DWCMSHC=y
+CONFIG_MMC_SPI=y
+CONFIG_MMC_SDHI=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_STARFIVE=y
+CONFIG_RTC_CLASS=y
+CONFIG_DMADEVICES=y
+CONFIG_DW_AXI_DMAC=y
+CONFIG_RPMSG_CHAR=y
+CONFIG_RPMSG_VIRTIO=y
+CONFIG_JH71XX_PMU=y
+CONFIG_CLK_STARFIVE_JH7110_PLL=y
+CONFIG_CLK_STARFIVE_JH7110_SYS=y
+CONFIG_CLK_STARFIVE_JH7110_AON=y
+CONFIG_CLK_STARFIVE_JH7110_STG=y
+CONFIG_CLK_STARFIVE_JH7110_ISP=y
+CONFIG_CLK_STARFIVE_JH7110_VOUT=y
+CONFIG_PINCTRL_STARFIVE_JH7110_SYS=y
+CONFIG_STARFIVE_WATCHDOG=y
+CONFIG_RESET_STARFIVE_JH7110=y
+CONFIG_STARFIVE_STARLINK_PMU=y
+CONFIG_DWC_PCIE_PMU=y
+CONFIG_IIO=y
+CONFIG_PHY_STARFIVE_JH7110_DPHY_RX=y
+CONFIG_PHY_STARFIVE_JH7110_PCIE=y
+CONFIG_PHY_STARFIVE_JH7110_USB=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_AUTOFS_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_HUGETLBFS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V4=y
+CONFIG_NFS_V4_1=y
+CONFIG_NFS_V4_2=y
+CONFIG_ROOT_NFS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_CRYPTO_USER_API_HASH=y
+CONFIG_CRYPTO_DEV_VIRTIO=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_FS=y
+# CONFIG_RCU_TRACE is not set
+# CONFIG_FTRACE is not set
+# CONFIG_RUNTIME_TESTING_MENU is not set
-- 
2.34.1

