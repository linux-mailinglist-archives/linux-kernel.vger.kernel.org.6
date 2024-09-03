Return-Path: <linux-kernel+bounces-312572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1BA96984F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 280A5B27325
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA21319F10D;
	Tue,  3 Sep 2024 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="GiDljZqd"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED121C7668
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354501; cv=none; b=Xz+i4CGqB6NryeMYvQXZDnPkyrjeMjt7V/Ldi92RYx2o+BIMQBTGVSj4ijCEwkWR2m8/4RQL7CHi8+Bq7nAPLv0VGhbZzTE+8wLPCRTgcH2tGegaf+HoOfbUArz6YD6Sy8p73Xcw1PE9hFSvYh6tDODS/EXzMy7N4Btt8ul42Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354501; c=relaxed/simple;
	bh=IFJ5ZXaI4Bkt22Gxzv+vxJLScPFE1KSMbZZsFfqSKdo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uUQe96mSxSl8oQyd3coXV+32I/io02sOOiBULXdS9EVNPAP0SXXcdyHoXMZ5tYpDbiICGLksaj1NToCxI0yfz+kYm1gq1NVfSmHvFd8qnJ5EYd0uvdwfac+FW5EfqqhIyQE/U5sNENuQtrmOoO/zyTP9z/kC/sco/75jqt6DoWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=GiDljZqd; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4838EA8h018130;
	Tue, 3 Sep 2024 11:07:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=Kpv58EzaKKQwQnX2LCjT5u
	kS+64CJPv5DaZnaL6cqLg=; b=GiDljZqd1MHEjJF3yKArsY9OyxMayfZh74YT9X
	aLynn8FeKh03autMUAjBtkIVPfecK0+nsYRfw6sH3HpprGltUHFV3XQLcXOpoeLZ
	XtyoB2MLnkSwW57UPXffE3C5TtJ2YhTK3L+PDAdyIHeMP2oRLHjUe8FYbPvio9vC
	nwySaOATkLUjxXN6imkn8xlqdyTPmruUDppiKccw6x1hgC3X7dISptLEG8L+j4oz
	uviYo6UuFPnGurjfbXh/6wX2LiBbBMDeAOpmyM9GLZMdzNTIH2V0mvoY50oA624L
	pv+MKXM3TceMVcvUx339PetIxMV2264ozNYSwJefiW7igPUA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41cuq1y32v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 11:07:56 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 28D794002D;
	Tue,  3 Sep 2024 11:07:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1B48A23BDFB;
	Tue,  3 Sep 2024 11:07:32 +0200 (CEST)
Received: from localhost (10.48.86.225) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 3 Sep
 2024 11:07:31 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
Subject: [PATCH] bus: rifsc: add debugfs entry to dump the firewall configuration
Date: Tue, 3 Sep 2024 11:07:22 +0200
Message-ID: <20240903090722.89300-1-gatien.chevallier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-02_06,2024-09-03_01,2024-09-02_01

RIFSC configuration can be difficult to debug. Add a debugfs entry
that dumps the configuration of the RISUPs and the RIMUs.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 drivers/bus/stm32_rifsc.c | 302 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 302 insertions(+)

diff --git a/drivers/bus/stm32_rifsc.c b/drivers/bus/stm32_rifsc.c
index 4cf1b60014b7..c0004e07179b 100644
--- a/drivers/bus/stm32_rifsc.c
+++ b/drivers/bus/stm32_rifsc.c
@@ -5,6 +5,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -70,6 +71,303 @@
 #define RIF_CID0			0x0
 #define RIF_CID1			0x1
 
+#if defined(CONFIG_DEBUG_FS)
+#define STM32MP25_RIFSC_DEVICE_ENTRIES		128
+#define STM32MP25_RIFSC_INITIATOR_ENTRIES	16
+
+#define RIFSC_RIMC_ATTR0		0xC10
+
+#define RIFSC_RIMC_CIDSEL		BIT(2)
+#define RIFSC_RIMC_MCID_MASK		GENMASK(6, 4)
+#define RIFSC_RIMC_MSEC			BIT(8)
+#define RIFSC_RIMC_MPRIV		BIT(9)
+
+static const char *stm32mp25_rifsc_initiators_names[STM32MP25_RIFSC_INITIATOR_ENTRIES] = {
+	"ETR",
+	"SDMMC1",
+	"SDMMC2",
+	"SDMMC3",
+	"USB3DR",
+	"USBH",
+	"ETH1",
+	"ETH2",
+	"PCIE",
+	"GPU",
+	"DMCIPP",
+	"LTDC_L0/L1",
+	"LTDC_L2",
+	"LTDC_ROT",
+	"VDEC",
+	"VENC"
+};
+
+static const char *stm32mp25_rifsc_dev_names[STM32MP25_RIFSC_DEVICE_ENTRIES] = {
+	"TIM1",
+	"TIM2",
+	"TIM3",
+	"TIM4",
+	"TIM5",
+	"TIM6",
+	"TIM7",
+	"TIM8",
+	"TIM10",
+	"TIM11",
+	"TIM12",
+	"TIM13",
+	"TIM14",
+	"TIM15",
+	"TIM16",
+	"TIM17",
+	"TIM20",
+	"LPTIM1",
+	"LPTIM2",
+	"LPTIM3",
+	"LPTIM4",
+	"LPTIM5",
+	"SPI1",
+	"SPI2",
+	"SPI3",
+	"SPI4",
+	"SPI5",
+	"SPI6",
+	"SPI7",
+	"SPI8",
+	"SPDIFRX",
+	"USART1",
+	"USART2",
+	"USART3",
+	"UART4",
+	"UART5",
+	"USART6",
+	"UART7",
+	"UART8",
+	"UART9",
+	"LPUART1",
+	"I2C1",
+	"I2C2",
+	"I2C3",
+	"I2C4",
+	"I2C5",
+	"I2C6",
+	"I2C7",
+	"I2C8",
+	"SAI1",
+	"SAI2",
+	"SAI3",
+	"SAI4",
+	"RESERVED",
+	"MDF1",
+	"ADF1",
+	"FDCAN",
+	"HDP",
+	"ADC12",
+	"ADC3",
+	"ETH1",
+	"ETH2",
+	"RESERVED",
+	"USBH",
+	"RESERVED",
+	"RESERVED",
+	"USB3DR",
+	"COMBOPHY",
+	"PCIE",
+	"UCPD1",
+	"ETHSW_DEIP",
+	"ETHSW_ACM_CF",
+	"ETHSW_ACM_MSGBU",
+	"STGEN",
+	"OCTOSPI1",
+	"OCTOSPI2",
+	"SDMMC1",
+	"SDMMC2",
+	"SDMMC3",
+	"GPU",
+	"LTDC_CMN",
+	"DSI_CMN",
+	"RESERVED",
+	"RESERVED",
+	"LVDS",
+	"RESERVED",
+	"CSI",
+	"DCMIPP",
+	"DCMI_PSSI",
+	"VDEC",
+	"VENC",
+	"RESERVED",
+	"RNG",
+	"PKA",
+	"SAES",
+	"HASH",
+	"CRYP1",
+	"CRYP2",
+	"IWDG1",
+	"IWDG2",
+	"IWDG3",
+	"IWDG4",
+	"IWDG5",
+	"WWDG1",
+	"WWDG2",
+	"RESERVED",
+	"VREFBUF",
+	"DTS",
+	"RAMCFG",
+	"CRC",
+	"SERC",
+	"OCTOSPIM",
+	"GICV2M",
+	"RESERVED",
+	"I3C1",
+	"I3C2",
+	"I3C3",
+	"I3C4",
+	"ICACHE_DCACHE",
+	"LTDC_L0L1",
+	"LTDC_L2",
+	"LTDC_ROT",
+	"DSI_TRIG",
+	"DSI_RDFIFO",
+	"RESERVED",
+	"OTFDEC1",
+	"OTFDEC2",
+	"IAC",
+};
+
+struct rifsc_risup_debug_data {
+	char dev_name[15];
+	u8 dev_cid;
+	u8 dev_sem_cids;
+	u8 dev_id;
+	bool dev_cid_filt_en;
+	bool dev_sem_en;
+	bool dev_priv;
+	bool dev_sec;
+};
+
+struct rifsc_rimu_debug_data {
+	char m_name[11];
+	u8 m_cid;
+	bool cidsel;
+	bool m_sec;
+	bool m_priv;
+};
+
+static void stm32_rifsc_fill_rimu_dbg_entry(struct stm32_firewall_controller *rifsc,
+					    struct rifsc_rimu_debug_data *dbg_entry, int i)
+{
+	u32 rimc_attr = readl_relaxed(rifsc->mmio + RIFSC_RIMC_ATTR0 + 0x4 * i);
+
+	snprintf(dbg_entry->m_name, sizeof(dbg_entry->m_name), "%s",
+		 stm32mp25_rifsc_initiators_names[i]);
+	dbg_entry->m_cid = FIELD_GET(RIFSC_RIMC_MCID_MASK, rimc_attr);
+	dbg_entry->cidsel = rimc_attr & RIFSC_RIMC_CIDSEL;
+	dbg_entry->m_sec = rimc_attr & RIFSC_RIMC_MSEC;
+	dbg_entry->m_priv = rimc_attr & RIFSC_RIMC_MPRIV;
+}
+
+static void stm32_rifsc_fill_dev_dbg_entry(struct stm32_firewall_controller *rifsc,
+					   struct rifsc_risup_debug_data *dbg_entry, int i)
+{
+	u32 cid_cfgr, sec_cfgr, priv_cfgr;
+	u8 reg_id = i / IDS_PER_RISC_SEC_PRIV_REGS;
+	u8 reg_offset = i % IDS_PER_RISC_SEC_PRIV_REGS;
+
+	cid_cfgr = readl_relaxed(rifsc->mmio + RIFSC_RISC_PER0_CIDCFGR + 0x8 * i);
+	sec_cfgr = readl_relaxed(rifsc->mmio + RIFSC_RISC_SECCFGR0 + 0x4 * reg_id);
+	priv_cfgr = readl_relaxed(rifsc->mmio + RIFSC_RISC_PRIVCFGR0 + 0x4 * reg_id);
+
+	snprintf(dbg_entry->dev_name, sizeof(dbg_entry->dev_name), "%s",
+		 stm32mp25_rifsc_dev_names[i]);
+	dbg_entry->dev_id = i;
+	dbg_entry->dev_cid_filt_en = cid_cfgr & CIDCFGR_CFEN;
+	dbg_entry->dev_sem_en = cid_cfgr & CIDCFGR_SEMEN;
+	dbg_entry->dev_cid = FIELD_GET(RIFSC_RISC_SCID_MASK, cid_cfgr);
+	dbg_entry->dev_sem_cids = FIELD_GET(RIFSC_RISC_SEMWL_MASK, cid_cfgr);
+	dbg_entry->dev_sec = sec_cfgr & BIT(reg_offset) ?  true : false;
+	dbg_entry->dev_priv = priv_cfgr & BIT(reg_offset) ?  true : false;
+}
+
+static int stm32_rifsc_conf_dump_show(struct seq_file *s, void *data)
+{
+	struct stm32_firewall_controller *rifsc = (struct stm32_firewall_controller *)s->private;
+	int i;
+
+	seq_puts(s, "\n=============================================\n");
+	seq_puts(s, "                 RIFSC dump\n");
+	seq_puts(s, "=============================================\n\n");
+
+	seq_puts(s, "\n=============================================\n");
+	seq_puts(s, "                 RISUP dump\n");
+	seq_puts(s, "=============================================\n");
+
+	seq_printf(s, "\n| %-15s |", "Peripheral name");
+	seq_puts(s, "| Firewall ID |");
+	seq_puts(s, "| N/SECURE |");
+	seq_puts(s, "| N/PRIVILEGED |");
+	seq_puts(s, "| CID filtering |");
+	seq_puts(s, "| Semaphore mode |");
+	seq_puts(s, "| SCID |");
+	seq_printf(s, "| %7s |\n", "SEMWL");
+
+	for (i = 0; i < STM32MP25_RIFSC_DEVICE_ENTRIES; i++) {
+		struct rifsc_risup_debug_data d_dbg_entry;
+
+		stm32_rifsc_fill_dev_dbg_entry(rifsc, &d_dbg_entry, i);
+
+		seq_printf(s, "| %-15s |", d_dbg_entry.dev_name);
+		seq_printf(s, "| %-11d |", d_dbg_entry.dev_id);
+		seq_printf(s, "| %-8s |", d_dbg_entry.dev_sec ? "SEC" : "NSEC");
+		seq_printf(s, "| %-12s |", d_dbg_entry.dev_priv ? "PRIV" : "NPRIV");
+		seq_printf(s, "| %-13s |",
+			   d_dbg_entry.dev_cid_filt_en ? "enabled" : "disabled");
+		seq_printf(s, "| %-14s |",
+			   d_dbg_entry.dev_sem_en ? "enabled" : "disabled");
+		seq_printf(s, "| %-4d |", d_dbg_entry.dev_cid);
+		seq_printf(s, "| %#-7x |\n", d_dbg_entry.dev_sem_cids);
+	}
+
+	seq_puts(s, "\n=============================================\n");
+	seq_puts(s, "                  RIMU dump\n");
+	seq_puts(s, "=============================================\n");
+
+	seq_puts(s, "| RIMU's name |");
+	seq_puts(s, "| CIDSEL |");
+	seq_puts(s, "| MCID |");
+	seq_puts(s, "| N/SECURE |");
+	seq_puts(s, "| N/PRIVILEGED |\n");
+
+	for (i = 0; i < STM32MP25_RIFSC_INITIATOR_ENTRIES; i++) {
+		struct rifsc_rimu_debug_data m_dbg_entry;
+
+		stm32_rifsc_fill_rimu_dbg_entry(rifsc, &m_dbg_entry, i);
+
+		seq_printf(s, "| %-11s |", m_dbg_entry.m_name);
+		seq_printf(s, "| %-6s |", m_dbg_entry.cidsel ? "CIDSEL" : "");
+		seq_printf(s, "| %-4d |", m_dbg_entry.m_cid);
+		seq_printf(s, "| %-8s |", m_dbg_entry.m_sec ? "SEC" : "NSEC");
+		seq_printf(s, "| %-12s |\n", m_dbg_entry.m_priv ? "PRIV" : "NPRIV");
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(stm32_rifsc_conf_dump);
+
+static int stm32_rifsc_register_debugfs(struct stm32_firewall_controller *controller)
+{
+	struct dentry *root = NULL;
+
+	root = debugfs_lookup("stm32_firewall", NULL);
+	if (!root)
+		root = debugfs_create_dir("stm32_firewall", NULL);
+
+	if (IS_ERR(root))
+		return PTR_ERR(root);
+
+	debugfs_create_file("rifsc", 0444, root, controller, &stm32_rifsc_conf_dump_fops);
+
+	return 0;
+}
+#endif /* defined(CONFIG_DEBUG_FS) */
+
 static bool stm32_rifsc_is_semaphore_available(void __iomem *addr)
 {
 	return !(readl(addr) & SEMCR_MUTEX);
@@ -228,6 +526,10 @@ static int stm32_rifsc_probe(struct platform_device *pdev)
 		return rc;
 	}
 
+#if defined(CONFIG_DEBUG_FS)
+	stm32_rifsc_register_debugfs(rifsc_controller);
+#endif
+
 	/* Populate all allowed nodes */
 	return of_platform_populate(np, NULL, NULL, &pdev->dev);
 }
-- 
2.25.1


