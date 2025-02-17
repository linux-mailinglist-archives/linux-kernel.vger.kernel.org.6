Return-Path: <linux-kernel+bounces-518464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2F5A38F89
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 00:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD71B3B394E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 23:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711A41B415E;
	Mon, 17 Feb 2025 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ht4rA+oO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E3E1B4121;
	Mon, 17 Feb 2025 23:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739834293; cv=none; b=ehrZ0f17oFW9+SklS3ak+g7u0RAV9jPGNIALv1NKN4mGMPH2qs3jWYznioFPc/zEc93jMh6N3H7eMJ/0KlE9thQX7qZCQZmtoNBAWOuKjdEi+bRCVhxt9JRF0McOpnhDcE2/ratg0IZe9qDuVQ4olvIZ3QYcmjnfAJo84gQVyds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739834293; c=relaxed/simple;
	bh=hf3KmRzay8I25VUNi5mF4wnWXDOqaDqXyiDeTP4rF3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubf5BFVRCTQXQc4yDqpotmnJn3CcNBnSFtjqFMu1NSoyyVWLp5XPnrZyFLlGACf1LShAzm3ozXDHJ9lI9b4EWrok07RDdJYUUJ62BvXgOL9TPyKgEnHhu+44GFSh4NnMxifEGXw8Q5qTQUWaUZ9sDxWy70hmwAc1CxqCnhz09p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ht4rA+oO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9E2C4CEE7;
	Mon, 17 Feb 2025 23:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739834293;
	bh=hf3KmRzay8I25VUNi5mF4wnWXDOqaDqXyiDeTP4rF3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ht4rA+oOF4hiM0AMblWvwR+3DJZcYEwnr02ht2XC3QX/QHe6KEe2ZlTtIBSdj3Tal
	 MI4ecPkv27vASX/2G/qzRBOwjrT/fqwcpY4iqlqh4sbI5ig4zGEZL+WRySS9QulwAZ
	 FsvfO0DD3kfkONfWjDYblvkzcvDLuu1DwDo7We7p2OivK3chHIIk5sdJO0n/NKZ3iG
	 jztKYA8BC/JKA/+mwcf8ViL/5PfBdIfE+veCydDbvFeDZHHXbaCPN3BPSgnQjhLspL
	 dGM4xZ/uSF1c6HdV6/yE/OltiSNx48Hm+n/Lagd2n76EfeD9VLv5GhAQ9UN+lmDo8d
	 KK4wMTPb3Em6Q==
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
Subject: [PATCH 5/7] ASoC: SOF: amd: Use AMD_NODE
Date: Mon, 17 Feb 2025 17:17:45 -0600
Message-ID: <20250217231747.1656228-6-superm1@kernel.org>
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
 sound/soc/sof/amd/Kconfig       |  1 +
 sound/soc/sof/amd/acp.c         | 56 ++++++++++-----------------------
 sound/soc/sof/amd/acp.h         |  1 -
 sound/soc/sof/amd/pci-rmb.c     |  1 -
 sound/soc/sof/amd/pci-rn.c      |  1 -
 sound/soc/sof/amd/pci-vangogh.c |  1 -
 6 files changed, 17 insertions(+), 44 deletions(-)

diff --git a/sound/soc/sof/amd/Kconfig b/sound/soc/sof/amd/Kconfig
index f4cafe8010178..28216c8c1cf97 100644
--- a/sound/soc/sof/amd/Kconfig
+++ b/sound/soc/sof/amd/Kconfig
@@ -25,6 +25,7 @@ config SND_SOC_SOF_AMD_COMMON
 	select SND_SOC_SOF_ACP_PROBES
 	select SND_SOC_ACPI_AMD_MATCH
 	select SND_SOC_ACPI if ACPI
+	depends on AMD_NODE
 	help
 	  This option is not user-selectable but automatically handled by
 	  'select' statements at a higher level
diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 9e13c96528be3..7c6d647fa253b 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -16,6 +16,8 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 
+#include <asm/amd_node.h>
+
 #include "../ops.h"
 #include "acp.h"
 #include "acp-dsp-offset.h"
@@ -43,24 +45,6 @@ const struct dmi_system_id acp_sof_quirk_table[] = {
 };
 EXPORT_SYMBOL_GPL(acp_sof_quirk_table);
 
-static int smn_write(struct pci_dev *dev, u32 smn_addr, u32 data)
-{
-	pci_write_config_dword(dev, 0x60, smn_addr);
-	pci_write_config_dword(dev, 0x64, data);
-
-	return 0;
-}
-
-static int smn_read(struct pci_dev *dev, u32 smn_addr)
-{
-	u32 data = 0;
-
-	pci_write_config_dword(dev, 0x60, smn_addr);
-	pci_read_config_dword(dev, 0x64, &data);
-
-	return data;
-}
-
 static void init_dma_descriptor(struct acp_dev_data *adata)
 {
 	struct snd_sof_dev *sdev = adata->dev;
@@ -209,11 +193,11 @@ int configure_and_run_dma(struct acp_dev_data *adata, unsigned int src_addr,
 static int psp_mbox_ready(struct acp_dev_data *adata, bool ack)
 {
 	struct snd_sof_dev *sdev = adata->dev;
-	int ret;
-	u32 data;
+	int ret, data;
+
+	ret = read_poll_timeout(smn_read_register, data, data > 0 && data & MBOX_READY_MASK,
+				MBOX_DELAY_US, ACP_PSP_TIMEOUT_US, false, MP0_C2PMSG_114_REG);
 
-	ret = read_poll_timeout(smn_read, data, data & MBOX_READY_MASK, MBOX_DELAY_US,
-				ACP_PSP_TIMEOUT_US, false, adata->smn_dev, MP0_C2PMSG_114_REG);
 	if (!ret)
 		return 0;
 
@@ -241,8 +225,8 @@ static int psp_send_cmd(struct acp_dev_data *adata, int cmd)
 		return -EINVAL;
 
 	/* Get a non-zero Doorbell value from PSP */
-	ret = read_poll_timeout(smn_read, data, data, MBOX_DELAY_US, ACP_PSP_TIMEOUT_US, false,
-				adata->smn_dev, MP0_C2PMSG_73_REG);
+	ret = read_poll_timeout(smn_read_register, data, data > 0, MBOX_DELAY_US,
+				ACP_PSP_TIMEOUT_US, false, MP0_C2PMSG_73_REG);
 
 	if (ret) {
 		dev_err(sdev->dev, "Failed to get Doorbell from MBOX %x\n", MP0_C2PMSG_73_REG);
@@ -254,10 +238,14 @@ static int psp_send_cmd(struct acp_dev_data *adata, int cmd)
 	if (ret)
 		return ret;
 
-	smn_write(adata->smn_dev, MP0_C2PMSG_114_REG, cmd);
+	ret = amd_smn_write(0, MP0_C2PMSG_114_REG, cmd);
+	if (ret)
+		return ret;
 
 	/* Ring the Doorbell for PSP */
-	smn_write(adata->smn_dev, MP0_C2PMSG_73_REG, data);
+	ret = amd_smn_write(0, MP0_C2PMSG_73_REG, data);
+	if (ret)
+		return ret;
 
 	/* Check MBOX ready as PSP ack */
 	ret = psp_mbox_ready(adata, 1);
@@ -771,16 +759,10 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	adata->pci_rev = pci->revision;
 	mutex_init(&adata->acp_lock);
 	sdev->pdata->hw_pdata = adata;
-	adata->smn_dev = pci_get_device(PCI_VENDOR_ID_AMD, chip->host_bridge_id, NULL);
-	if (!adata->smn_dev) {
-		dev_err(sdev->dev, "Failed to get host bridge device\n");
-		ret = -ENODEV;
-		goto unregister_dev;
-	}
 
 	ret = acp_init(sdev);
 	if (ret < 0)
-		goto free_smn_dev;
+		goto unregister_dev;
 
 	sdev->ipc_irq = pci->irq;
 	ret = request_threaded_irq(sdev->ipc_irq, acp_irq_handler, acp_irq_thread,
@@ -788,7 +770,7 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	if (ret < 0) {
 		dev_err(sdev->dev, "failed to register IRQ %d\n",
 			sdev->ipc_irq);
-		goto free_smn_dev;
+		goto unregister_dev;
 	}
 
 	/* scan SoundWire capabilities exposed by DSDT */
@@ -801,7 +783,6 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	if (ret < 0) {
 		dev_err(sdev->dev, "error: SoundWire probe error\n");
 		free_irq(sdev->ipc_irq, sdev);
-		pci_dev_put(adata->smn_dev);
 		return ret;
 	}
 
@@ -847,8 +828,6 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 
 free_ipc_irq:
 	free_irq(sdev->ipc_irq, sdev);
-free_smn_dev:
-	pci_dev_put(adata->smn_dev);
 unregister_dev:
 	platform_device_unregister(adata->dmic_dev);
 	return ret;
@@ -859,9 +838,6 @@ void amd_sof_acp_remove(struct snd_sof_dev *sdev)
 {
 	struct acp_dev_data *adata = sdev->pdata->hw_pdata;
 
-	if (adata->smn_dev)
-		pci_dev_put(adata->smn_dev);
-
 	if (adata->sdw)
 		amd_sof_sdw_exit(sdev);
 
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 2a19d82d62002..4bfb05d93b25a 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -256,7 +256,6 @@ struct acp_dev_data {
 	struct dma_descriptor dscr_info[ACP_MAX_DESC];
 	struct acp_dsp_stream stream_buf[ACP_MAX_STREAM];
 	struct acp_dsp_stream *dtrace_stream;
-	struct pci_dev *smn_dev;
 	struct acp_dsp_stream *probe_stream;
 	bool enable_fw_debug;
 	bool is_dram_in_use;
diff --git a/sound/soc/sof/amd/pci-rmb.c b/sound/soc/sof/amd/pci-rmb.c
index cbb4d52826644..0233b6ba2d2e2 100644
--- a/sound/soc/sof/amd/pci-rmb.c
+++ b/sound/soc/sof/amd/pci-rmb.c
@@ -28,7 +28,6 @@
 #define ACP6X_FUTURE_REG_ACLK_0	0x1854
 
 static const struct sof_amd_acp_desc rembrandt_chip_info = {
-	.host_bridge_id = HOST_BRIDGE_RMB,
 	.pgfsm_base	= ACP6X_PGFSM_BASE,
 	.ext_intr_stat	= ACP6X_EXT_INTR_STAT,
 	.dsp_intr_base	= ACP6X_DSP_SW_INTR_BASE,
diff --git a/sound/soc/sof/amd/pci-rn.c b/sound/soc/sof/amd/pci-rn.c
index b7d558cb1fd7a..4a36029a00dec 100644
--- a/sound/soc/sof/amd/pci-rn.c
+++ b/sound/soc/sof/amd/pci-rn.c
@@ -28,7 +28,6 @@
 #define ACP3X_FUTURE_REG_ACLK_0	0x1860
 
 static const struct sof_amd_acp_desc renoir_chip_info = {
-	.host_bridge_id = HOST_BRIDGE_CZN,
 	.pgfsm_base	= ACP3X_PGFSM_BASE,
 	.ext_intr_stat	= ACP3X_EXT_INTR_STAT,
 	.dsp_intr_base	= ACP3X_DSP_SW_INTR_BASE,
diff --git a/sound/soc/sof/amd/pci-vangogh.c b/sound/soc/sof/amd/pci-vangogh.c
index 28f2d4050a676..caf9e2b2e4638 100644
--- a/sound/soc/sof/amd/pci-vangogh.c
+++ b/sound/soc/sof/amd/pci-vangogh.c
@@ -25,7 +25,6 @@
 
 static const struct sof_amd_acp_desc vangogh_chip_info = {
 	.name		= "vangogh",
-	.host_bridge_id = HOST_BRIDGE_VGH,
 	.pgfsm_base	= ACP5X_PGFSM_BASE,
 	.ext_intr_stat	= ACP5X_EXT_INTR_STAT,
 	.dsp_intr_base	= ACP5X_DSP_SW_INTR_BASE,
-- 
2.43.0


