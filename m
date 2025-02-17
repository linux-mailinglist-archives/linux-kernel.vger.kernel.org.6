Return-Path: <linux-kernel+bounces-518461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B840A38F86
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 00:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A18172769
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 23:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84D71B0421;
	Mon, 17 Feb 2025 23:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vg/kiVR4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3145D1AE01C;
	Mon, 17 Feb 2025 23:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739834287; cv=none; b=UoPzUlrmmF6Iha04kq3GBBJiWg53OWpVZmL7tohIKIh+4uybcMrGlIzrLuPWodqR4nSlpSTCqYBRfBChogfZ9Wy05kUfSOJeRHa/3CgGW6lx1tqTC4C1dvPtHGteWcuwYWsCfrxJLAnk36JqCdUD7nhXFE28SlDMsQ3AKgZHtTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739834287; c=relaxed/simple;
	bh=J4+qBi6Z3BTv/cG5EqfyHKOUwMClU9CQQwCsGOkKg7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRyG2cwtP46yYXaIVpzEkkat0WaJJnO5r0JWly1omYfyab/DmEhFp+x3XOzFn7r1nT53sp9T+BYteSN4XJcJiwyDkG9rkEmlSiCqc55BKNlenwmfj6s85JLh7TZsuqkh9wVEAPcD6xjCAjOUBIV/JXL1skGgJkLphOnL6EgGx+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vg/kiVR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4F5C4CEEA;
	Mon, 17 Feb 2025 23:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739834285;
	bh=J4+qBi6Z3BTv/cG5EqfyHKOUwMClU9CQQwCsGOkKg7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vg/kiVR4cirr0hG5Z3UC/RQmY1oV3otn/8fYbf9TGFiab/sskM5P/hdKn5O373cne
	 c8Tj2iXvteu/upyy8zK3tBZNNwxKMgPow1cwPYdp9P6dRaMMN+2B2cDSXM5UPng1Xp
	 HCVwnOJenm0yIwxwFy5wy9/aELrHhPRiife265IXl5moD6sSx1zYgf8MgKeoWJqHcY
	 wRRYtWMDChGcCX1i4kNTuPjqgP6UT+ablSW5eiUz9hg5c4xmM/cA3EQRs6gXs0QQXz
	 vHpaq1vM4Oy1tX1T5dbJGItS6pWuVred9seoT3UmLAng1CTLMuC2rT0x3UulAje6Dx
	 Z7T3BL7i0BOOg==
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
Subject: [PATCH 2/7] ASoC: amd: acp: rembrandt: Use AMD_NODE
Date: Mon, 17 Feb 2025 17:17:42 -0600
Message-ID: <20250217231747.1656228-3-superm1@kernel.org>
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
 sound/soc/amd/acp/Kconfig         |  1 +
 sound/soc/amd/acp/acp-rembrandt.c | 28 ++++++++++++++--------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index 53793ec7c7b49..2bb78a748c79d 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -58,6 +58,7 @@ config SND_AMD_ASOC_REMBRANDT
 	select SND_SOC_AMD_ACP_I2S
 	select SND_SOC_AMD_ACP_PDM
 	select SND_SOC_AMD_ACP_LEGACY_COMMON
+	depends on AMD_NODE
 	depends on X86 && PCI
 	help
 	  This option enables Rembrandt I2S support on AMD platform.
diff --git a/sound/soc/amd/acp/acp-rembrandt.c b/sound/soc/amd/acp/acp-rembrandt.c
index 2648256fa129c..e727754a8231c 100644
--- a/sound/soc/amd/acp/acp-rembrandt.c
+++ b/sound/soc/amd/acp/acp-rembrandt.c
@@ -22,6 +22,8 @@
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 
+#include <asm/amd_node.h>
+
 #include "amd.h"
 #include "../mach-config.h"
 #include "acp-mach.h"
@@ -31,7 +33,6 @@
 #define MP1_C2PMSG_69 0x3B10A14
 #define MP1_C2PMSG_85 0x3B10A54
 #define MP1_C2PMSG_93 0x3B10A74
-#define HOST_BRIDGE_ID 0x14B5
 
 static struct acp_resource rsrc = {
 	.offset = 0,
@@ -166,21 +167,20 @@ static struct snd_soc_dai_driver acp_rmb_dai[] = {
 
 static int acp6x_master_clock_generate(struct device *dev)
 {
-	int data = 0;
-	struct pci_dev *smn_dev;
+	int data, rc;
 
-	smn_dev = pci_get_device(PCI_VENDOR_ID_AMD, HOST_BRIDGE_ID, NULL);
-	if (!smn_dev) {
-		dev_err(dev, "Failed to get host bridge device\n");
-		return -ENODEV;
-	}
+	rc = amd_smn_write(0, MP1_C2PMSG_93, 0);
+	if (rc)
+		return rc;
+	rc = amd_smn_write(0, MP1_C2PMSG_85, 0xC4);
+	if (rc)
+		return rc;
+	rc = amd_smn_write(0, MP1_C2PMSG_69, 0x4);
+	if (rc)
+		return rc;
 
-	smn_write(smn_dev, MP1_C2PMSG_93, 0);
-	smn_write(smn_dev, MP1_C2PMSG_85, 0xC4);
-	smn_write(smn_dev, MP1_C2PMSG_69, 0x4);
-	read_poll_timeout(smn_read, data, data, DELAY_US,
-			  ACP_TIMEOUT, false, smn_dev, MP1_C2PMSG_93);
-	return 0;
+	return read_poll_timeout(smn_read_register, data, data > 0, DELAY_US,
+				 ACP_TIMEOUT, false, MP1_C2PMSG_93);
 }
 
 static int rembrandt_audio_probe(struct platform_device *pdev)
-- 
2.43.0


