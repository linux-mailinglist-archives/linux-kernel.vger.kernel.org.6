Return-Path: <linux-kernel+bounces-518465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F89A38F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 00:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F791726F4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 23:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA8E1B4251;
	Mon, 17 Feb 2025 23:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6Rf3UHu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2031B423E;
	Mon, 17 Feb 2025 23:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739834296; cv=none; b=nnPyqtrQaht+acm1cpi1cLyH3YjiFR0VG5rEUt+8e+DtFvr144iTvg15e67cunvP2ghKwdvZH+xTUuu7PwVa7RaBW8SVPVaHL9WqIpVRyFVhru7Rc0PrhnIPKsfAtPIdx4aUsOojKhovOL1jCSkNAvN/I/tf5Pozf/VHXR1bWKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739834296; c=relaxed/simple;
	bh=5beDSDABhZK7GZ0ae4q5aJKX12z6pf18bP43T+D8VzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vp9XfsRFdjW67AsHC1DIhJujJDPhp0j2M05AmEK/Xz6NtjKpufrE6Sa/2yMXeM5fGPdoICw0MsI/1FAycSLnmMRJJcu/1xTRiVF/m1NRRoqlK9JW5jU2IaDwOXuEjxMICzTbG5tQ2jIEO3QmP9reKYCzK+dAiEdWp+7gE5vjrNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6Rf3UHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAA3C4CEEA;
	Mon, 17 Feb 2025 23:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739834296;
	bh=5beDSDABhZK7GZ0ae4q5aJKX12z6pf18bP43T+D8VzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C6Rf3UHu4j49MCKYR5IQXc7YsRmbdw1a0dQQbOATteYf84tgiSGqEQhjm0nJFG419
	 sIWsiLxyw7kYrj6bvtQB4hrz/VcY5cB6etodAXv3hWJaSzfLtuUVFXcc9BMs7Pb1cn
	 SvPjEAhi8Sk0Ku0PEfpeQfHSshK0fZv9vw9B0u0qNdo81COV7K9d6yNmdyg3WqElAv
	 nuRxGcqedv+9Hvekeowl6hI/5o07Wbc53c68UZHR/HEY/oPXW6sJN4h1ekuz5xOP+G
	 Pak4VP1tLyd5wGYlnjg5RXVFgsL4rlzr0gUdpNWU1xPUAsVeIQeoVQj5ZDi00FJBNO
	 WTXVFVYfHsj2w==
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
Subject: [PATCH 6/7] ASoC: amd: acp: Drop local symbols for smn read/write
Date: Mon, 17 Feb 2025 17:17:46 -0600
Message-ID: <20250217231747.1656228-7-superm1@kernel.org>
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

As the ACP drivers use the AMD_NODE provided symbols, the local
ones are no longer necessary.

Tested by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 sound/soc/amd/acp/acp-legacy-common.c | 18 ------------------
 sound/soc/amd/acp/amd.h               |  3 ---
 2 files changed, 21 deletions(-)

diff --git a/sound/soc/amd/acp/acp-legacy-common.c b/sound/soc/amd/acp/acp-legacy-common.c
index 7acc7ed2e8cc9..89f5cda18a23e 100644
--- a/sound/soc/amd/acp/acp-legacy-common.c
+++ b/sound/soc/amd/acp/acp-legacy-common.c
@@ -345,24 +345,6 @@ int acp_deinit(struct acp_chip_info *chip)
 }
 EXPORT_SYMBOL_NS_GPL(acp_deinit, "SND_SOC_ACP_COMMON");
 
-int smn_write(struct pci_dev *dev, u32 smn_addr, u32 data)
-{
-	pci_write_config_dword(dev, 0x60, smn_addr);
-	pci_write_config_dword(dev, 0x64, data);
-	return 0;
-}
-EXPORT_SYMBOL_NS_GPL(smn_write, "SND_SOC_ACP_COMMON");
-
-int smn_read(struct pci_dev *dev, u32 smn_addr)
-{
-	u32 data;
-
-	pci_write_config_dword(dev, 0x60, smn_addr);
-	pci_read_config_dword(dev, 0x64, &data);
-	return data;
-}
-EXPORT_SYMBOL_NS_GPL(smn_read, "SND_SOC_ACP_COMMON");
-
 static void check_acp3x_config(struct acp_chip_info *chip)
 {
 	u32 val;
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index ee69dfb10cb86..c921bcabbcec6 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -235,9 +235,6 @@ int acp_platform_unregister(struct device *dev);
 
 int acp_machine_select(struct acp_dev_data *adata);
 
-int smn_read(struct pci_dev *dev, u32 smn_addr);
-int smn_write(struct pci_dev *dev, u32 smn_addr, u32 data);
-
 int acp_init(struct acp_chip_info *chip);
 int acp_deinit(struct acp_chip_info *chip);
 void acp_enable_interrupts(struct acp_dev_data *adata);
-- 
2.43.0


