Return-Path: <linux-kernel+bounces-518462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8070AA38F87
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 00:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9799172972
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 23:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ED61B0F0A;
	Mon, 17 Feb 2025 23:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCWn+Si1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA6E1AAA1F;
	Mon, 17 Feb 2025 23:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739834288; cv=none; b=T/y4yUB2V4rrUMpyv8F2f9HCEqar99E12cU3KroxybqmpVDkuakhuWcLPqG01bKLsFSa/7lL4DNLeChRD2Wvn6n2aBUg/nx17xJD3X9rYOqhn7SvV/icUJ0NMSvclojqBiPOZy86y09hOuC7HsIWESERSvrJc0+Kgvxbcz8DAVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739834288; c=relaxed/simple;
	bh=WxRSXlQocu9WEzHt6sN6+QF8YyFOo9r+uyTx4yS5Alw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=seL6p2i6Y29K+mp08KoqzWBoRuus8XNfxi01+i0SuKONShMXfkWRzGqaGnfgUsobTq7WEeD2l28fOVRvnGer8bbotnUCMVsfdqxMypQ2wBCUPo9I1oM8nZL27xHvW+3sQFK0qXf7TmjkJox4uYeZRtMw80oqfXh509ERCvQeuro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCWn+Si1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E338CC4CEE7;
	Mon, 17 Feb 2025 23:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739834288;
	bh=WxRSXlQocu9WEzHt6sN6+QF8YyFOo9r+uyTx4yS5Alw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LCWn+Si1DTDRrON1vZbmLnviLwEBMhhyhhsVMLLaRFIWy0QPoljsJqRqcgjZEGPyd
	 LLBh7DtcBHK6A5pRmLj4yO5T9vP1doLWq5bKY22Hfty8selMz5+gFP5EN6xslrAzSL
	 nt52y2PSZ5PCMOJ138kfMwajxECOQCbSnD5u83m42NxiwCFWw2JFI32MpW8oSzRdiA
	 CGFhNTu7qYDUtdc0zhK1preI5f9WNhbFho0oIzpyKd7r9ukuYmLZhoiObbTW5QRnsF
	 1DNbcsWsqTUQjurHPaY1Tdyh1u63BMY4it6+P4c3IXXDJpCLnr2tsOoAS7ZwQ0lPTP
	 5JgTZ0bXyJe+Q==
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
Subject: [PATCH 3/7] ASoC: amd: acp: acp70: Use AMD_NODE
Date: Mon, 17 Feb 2025 17:17:43 -0600
Message-ID: <20250217231747.1656228-4-superm1@kernel.org>
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
 sound/soc/amd/acp/acp70.c     | 28 ++++------------------------
 sound/soc/sof/amd/pci-acp70.c |  1 -
 3 files changed, 5 insertions(+), 25 deletions(-)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index 2bb78a748c79d..a649f49864059 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -82,6 +82,7 @@ config SND_AMD_ASOC_ACP70
 	tristate "AMD ACP ASOC Acp7.0 Support"
 	depends on X86 && PCI
 	depends on ACPI
+	depends on AMD_NODE
 	select SND_SOC_AMD_ACP_PCM
 	select SND_SOC_AMD_ACP_I2S
 	select SND_SOC_AMD_ACP_PDM
diff --git a/sound/soc/amd/acp/acp70.c b/sound/soc/amd/acp/acp70.c
index 9e23729fd1a71..ef3f6504bc7f5 100644
--- a/sound/soc/amd/acp/acp70.c
+++ b/sound/soc/amd/acp/acp70.c
@@ -23,6 +23,8 @@
 #include "amd.h"
 #include "acp-mach.h"
 
+#include <asm/amd_node.h>
+
 #define DRV_NAME "acp_asoc_acp70"
 
 #define CLK7_CLK0_DFS_CNTL_N1		0X0006C1A4
@@ -137,29 +139,6 @@ static struct snd_soc_dai_driver acp70_dai[] = {
 },
 };
 
-static int acp70_i2s_master_clock_generate(struct acp_dev_data *adata)
-{
-	struct pci_dev *smn_dev;
-	u32 device_id;
-
-	if (adata->acp_rev == ACP70_PCI_ID)
-		device_id = 0x1507;
-	else if (adata->acp_rev == ACP71_PCI_ID)
-		device_id = 0x1122;
-	else
-		return -ENODEV;
-
-	smn_dev = pci_get_device(PCI_VENDOR_ID_AMD, device_id, NULL);
-
-	if (!smn_dev)
-		return -ENODEV;
-
-	/* Set clk7 DFS clock divider register value to get mclk as 196.608MHz*/
-	smn_write(smn_dev, CLK7_CLK0_DFS_CNTL_N1, CLK0_DIVIDER);
-
-	return 0;
-}
-
 static int acp_acp70_audio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -215,7 +194,8 @@ static int acp_acp70_audio_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, adata);
 
-	ret = acp70_i2s_master_clock_generate(adata);
+	/* Set clk7 DFS clock divider register value to get mclk as 196.608MHz*/
+	ret = amd_smn_write(0, CLK7_CLK0_DFS_CNTL_N1, CLK0_DIVIDER);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to set I2S master clock as 196.608MHz\n");
 		return ret;
diff --git a/sound/soc/sof/amd/pci-acp70.c b/sound/soc/sof/amd/pci-acp70.c
index 3647ec992e95f..d886bdf3a1128 100644
--- a/sound/soc/sof/amd/pci-acp70.c
+++ b/sound/soc/sof/amd/pci-acp70.c
@@ -28,7 +28,6 @@
 #define ACP70_REG_END			0x125C000
 
 static const struct sof_amd_acp_desc acp70_chip_info = {
-	.host_bridge_id = HOST_BRIDGE_ACP70,
 	.pgfsm_base	= ACP70_PGFSM_BASE,
 	.ext_intr_enb = ACP70_EXTERNAL_INTR_ENB,
 	.ext_intr_cntl = ACP70_EXTERNAL_INTR_CNTL,
-- 
2.43.0


