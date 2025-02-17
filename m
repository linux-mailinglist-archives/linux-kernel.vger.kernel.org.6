Return-Path: <linux-kernel+bounces-518463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40991A38F88
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 00:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F883B3498
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 23:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E0D1B393C;
	Mon, 17 Feb 2025 23:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+kwcMom"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660761ACEDB;
	Mon, 17 Feb 2025 23:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739834291; cv=none; b=c3pnDSifRJqnDrWvrd0U9PdmRSjWeHPmzUWG1sTDOANaL3BJkWzcYxTo79Y+YigETVswjfiC6cAUsi+nM4A6tpObahIbn2WTGalM4wzcD2DWJ89mPZ9v5oGybXslFUA+T9jfgcTGxNgzBVPFDWVTDpCbZEjcX3iV7DATiZi0+K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739834291; c=relaxed/simple;
	bh=sUIu2FaiR2xdtVemSdyik2qyFvzuB7tdiosak35TN5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bC4GUD2hNSdht8bWKf2CxKBIDrwq8WevqT+A31KhE9UJZj13QKWXxBycraFjUT+HQfHXyXq3ZHEm5d7C0LuIOjbMhJFkf59nCcDhjfM83y8whZuB6W6q1UHGEr9bkpgxH4o+TIh8UWhJVH/L7mOlV5wP/feckO6of2laZxepTAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+kwcMom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E308C4CEE4;
	Mon, 17 Feb 2025 23:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739834290;
	bh=sUIu2FaiR2xdtVemSdyik2qyFvzuB7tdiosak35TN5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C+kwcMomu9MCpqiVpjK9KqTAs3ws3UUOyClWn/PfZgAuTwPbiPxmDV0fbP5WTZJ4g
	 9AEIwKt+MdrzOmt7CdEiTTybQZ1++2ILbqeqJT1zprAG16xMH7yeWoNr92uWdqlq1Y
	 QdNDLpeam6VLF+lu7tXCYUvPO5CssLAYUWQqIYRm10BZhdzP/iSCLM1LDEa3nFR3k0
	 CYrgyMZBps8Bq3kI8Xe2XW43dcc2MzNUztb/J8Oy/GGYQ5adTv7++kdN9jETcauAZr
	 solrAS02D0/NgHNwfpS0tbEB/Ml4KgMI7auK5QYvCqMzyN5cQhL0jHxm65Z4om8GF4
	 JA+o9hmrM/wrw==
From: Mario Limonciello <superm1@kernel.org>
To: Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Mark Brown <broonie@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H . Peter Anvin" <hpa@zytor.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-kernel@vger.kernel.org (open list:AMD NODE DRIVER),
	linux-sound@vger.kernel.org (open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...),
	sound-open-firmware@alsa-project.org (moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS)
Subject: [PATCH 4/7] ASoC: amd: acp: acp63: Use AMD_NODE
Date: Mon, 17 Feb 2025 17:17:44 -0600
Message-ID: <20250217231747.1656228-5-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217231747.1656228-1-superm1@kernel.org>
References: <20250217231747.1656228-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

All consumers of SMN in the kernel should be doing it through the
functions provided by AMD_NODE.

Stop using the local SMN read/write symbols and switch to the AMD_NODE
provided ones.

Tested by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 sound/soc/amd/acp/Kconfig     |  1 +
 sound/soc/amd/acp/acp63.c     | 63 +++++++++++++++++++++++------------
 sound/soc/sof/amd/pci-acp63.c |  1 -
 3 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index a649f49864059..157c124570c88 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -69,6 +69,7 @@ config SND_AMD_ASOC_ACP63
 	tristate "AMD ACP ASOC ACP6.3 Support"
 	depends on X86 && PCI
 	depends on ACPI
+	depends on AMD_NODE
 	select SND_SOC_AMD_ACP_PCM
 	select SND_SOC_AMD_ACP_I2S
 	select SND_SOC_AMD_ACP_PDM
diff --git a/sound/soc/amd/acp/acp63.c b/sound/soc/amd/acp/acp63.c
index 81496e713440b..4187a8968de75 100644
--- a/sound/soc/amd/acp/acp63.c
+++ b/sound/soc/amd/acp/acp63.c
@@ -20,6 +20,9 @@
 #include <linux/dma-mapping.h>
 #include <linux/pm_runtime.h>
 #include <linux/pci.h>
+
+#include <asm/amd_node.h>
+
 #include "amd.h"
 #include "acp-mach.h"
 #include "../mach-config.h"
@@ -160,37 +163,53 @@ static struct snd_soc_dai_driver acp63_dai[] = {
 
 static int acp63_i2s_master_clock_generate(struct acp_dev_data *adata)
 {
+	int rc;
 	u32 data;
 	union clk_pll_req_no clk_pll;
-	struct pci_dev *smn_dev;
-
-	smn_dev = pci_get_device(PCI_VENDOR_ID_AMD, 0x14E8, NULL);
-	if (!smn_dev)
-		return -ENODEV;
 
 	/* Clk5 pll register values to get mclk as 196.6MHz*/
 	clk_pll.bits.fb_mult_int = 0x31;
 	clk_pll.bits.pll_spine_div = 0;
 	clk_pll.bits.gb_mult_frac = 0x26E9;
 
-	data = smn_read(smn_dev, CLK_PLL_PWR_REQ_N0);
-	smn_write(smn_dev, CLK_PLL_PWR_REQ_N0, data | PLL_AUTO_STOP_REQ);
-
-	data = smn_read(smn_dev, CLK_SPLL_FIELD_2_N0);
-	if (data & PLL_FRANCE_EN)
-		smn_write(smn_dev, CLK_SPLL_FIELD_2_N0, data | PLL_FRANCE_EN);
-
-	smn_write(smn_dev, CLK_PLL_REQ_N0, clk_pll.clk_pll_req_no_reg);
-
-	data = smn_read(smn_dev, CLK_PLL_PWR_REQ_N0);
-	smn_write(smn_dev, CLK_PLL_PWR_REQ_N0, data | PLL_AUTO_START_REQ);
-
-	data = smn_read(smn_dev, CLK_DFSBYPASS_CONTR);
-	smn_write(smn_dev, CLK_DFSBYPASS_CONTR, data | EXIT_DPF_BYPASS_0);
-	smn_write(smn_dev, CLK_DFSBYPASS_CONTR, data | EXIT_DPF_BYPASS_1);
+	rc = amd_smn_read(0, CLK_PLL_PWR_REQ_N0, &data);
+	if (rc)
+		return rc;
+	rc = amd_smn_write(0, CLK_PLL_PWR_REQ_N0, data | PLL_AUTO_STOP_REQ);
+	if (rc)
+		return rc;
+
+	rc = amd_smn_read(0, CLK_SPLL_FIELD_2_N0, &data);
+	if (rc)
+		return rc;
+	if (data & PLL_FRANCE_EN) {
+		rc = amd_smn_write(0, CLK_SPLL_FIELD_2_N0, data | PLL_FRANCE_EN);
+		if (rc)
+			return rc;
+	}
 
-	smn_write(smn_dev, CLK_DFS_CNTL_N0, CLK0_DIVIDER);
-	return 0;
+	rc = amd_smn_write(0, CLK_PLL_REQ_N0, clk_pll.clk_pll_req_no_reg);
+	if (rc)
+		return rc;
+
+	rc = amd_smn_read(0, CLK_PLL_PWR_REQ_N0, &data);
+	if (rc)
+		return rc;
+	rc = amd_smn_write(0, CLK_PLL_PWR_REQ_N0, data | PLL_AUTO_START_REQ);
+	if (rc)
+		return rc;
+
+	rc = amd_smn_read(0, CLK_DFSBYPASS_CONTR, &data);
+	if (rc)
+		return rc;
+	rc = amd_smn_write(0, CLK_DFSBYPASS_CONTR, data | EXIT_DPF_BYPASS_0);
+	if (rc)
+		return rc;
+	rc = amd_smn_write(0, CLK_DFSBYPASS_CONTR, data | EXIT_DPF_BYPASS_1);
+	if (rc)
+		return rc;
+
+	return amd_smn_write(0, CLK_DFS_CNTL_N0, CLK0_DIVIDER);
 }
 
 static int acp63_audio_probe(struct platform_device *pdev)
diff --git a/sound/soc/sof/amd/pci-acp63.c b/sound/soc/sof/amd/pci-acp63.c
index ffe7c755d655e..13aa87cdeeac3 100644
--- a/sound/soc/sof/amd/pci-acp63.c
+++ b/sound/soc/sof/amd/pci-acp63.c
@@ -28,7 +28,6 @@
 #define ACP6x_REG_END			0x125C000
 
 static const struct sof_amd_acp_desc acp63_chip_info = {
-	.host_bridge_id = HOST_BRIDGE_ACP63,
 	.pgfsm_base	= ACP6X_PGFSM_BASE,
 	.ext_intr_enb = ACP6X_EXTERNAL_INTR_ENB,
 	.ext_intr_cntl = ACP6X_EXTERNAL_INTR_CNTL,
-- 
2.43.0


