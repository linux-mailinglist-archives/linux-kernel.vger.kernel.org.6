Return-Path: <linux-kernel+bounces-444411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BEB9F065B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8201887A27
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A0E1A8F87;
	Fri, 13 Dec 2024 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNk8HE/5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23441A2645
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734078664; cv=none; b=l/wDcAK1FYaDr8qSZTAydvFbcL8yIHl7XWIINESxG6ccAZ8IzXKV5dwpWbj1Mjc3qwb4oKY/8ffZFr9GlPc9kfXRgvv2kThBTKy9MBs/QjdQaIIX5ehlmt1ejUFF0dWHhkxTa598acDFGWLDUFezXuBf7WDHfBgVNp4F7IHvRoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734078664; c=relaxed/simple;
	bh=OmnbKPvHVM7MdfRx5FYkdNzBzuqOqnCvvH25yQuyNBA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pFNSl0hEkEP99UcU/8G5cC1njKGEgGg5o0W1GA8vrvvZ+8NV85yNVC7/V99It6qADYDnnXyqTSHM8DvUnZWaw+yfhDB5VWrNR3pTiUKHQi6eyNpQteL98nz0Z/jDXjiWhITBHdueSQqbPprs7rcLHKhC12BuGLwuk5MWPSZB2OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNk8HE/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8982FC4CED0;
	Fri, 13 Dec 2024 08:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734078663;
	bh=OmnbKPvHVM7MdfRx5FYkdNzBzuqOqnCvvH25yQuyNBA=;
	h=From:To:Cc:Subject:Date:From;
	b=VNk8HE/5qYbZuBa988qzCP0ljdU8d8JT1z7lwgU/ujrmlqidCLhSdNvcuNPKF8uI5
	 EKWmpL9T5FLfBvMoOi213/5kdb/id+Y9DkDKlLpxzsFlttMq9OMJnHm0OaovoooBC9
	 QyxzZ8gW4dlEW4i3CJzv5xQcz+Gs4kXEDxa6KKxgSPyJPfrIDgh7pu8R9D86wcKOT+
	 IgqsZjlQ2GoEEijNseArr7zADkeSQkp93wtce8Xl2xcBKQyCEHPN69rjQH1muW5PBg
	 c8OReZ8kuGiSmWUDwTUH3DY6rnqwxq7nkl1ERJYxFQ0qsyRpdBLkk0PCRCCa5aR/Tz
	 Quc23IjDMmUJA==
From: Arnd Bergmann <arnd@kernel.org>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Phi-bang Nguyen <pnguyen@baylibre.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] phy: mediatek: phy-mtk-hdmi: add regulator dependency
Date: Fri, 13 Dec 2024 09:30:51 +0100
Message-Id: <20241213083056.2596499-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The driver no longer builds when regulator support is unavailable:

arm-linux-gnueabi-ld: drivers/phy/mediatek/phy-mtk-hdmi.o: in function `mtk_hdmi_phy_register_regulators':
phy-mtk-hdmi.c:(.text.unlikely+0x3e): undefined reference to `devm_regulator_register'
arm-linux-gnueabi-ld: drivers/phy/mediatek/phy-mtk-hdmi-mt8195.o: in function `mtk_hdmi_phy_pwr5v_is_enabled':
phy-mtk-hdmi-mt8195.c:(.text+0x326): undefined reference to `rdev_get_drvdata'
arm-linux-gnueabi-ld: drivers/phy/mediatek/phy-mtk-hdmi-mt8195.o: in function `mtk_hdmi_phy_pwr5v_disable':
phy-mtk-hdmi-mt8195.c:(.text+0x346): undefined reference to `rdev_get_drvdata'
arm-linux-gnueabi-ld: drivers/phy/mediatek/phy-mtk-hdmi-mt8195.o: in function `mtk_hdmi_phy_pwr5v_enable':

Fixes: 49393b2da1cd ("phy: mediatek: phy-mtk-hdmi: Register PHY provided regulator")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/phy/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
index 60e00057e8bc..ba6461350951 100644
--- a/drivers/phy/mediatek/Kconfig
+++ b/drivers/phy/mediatek/Kconfig
@@ -65,6 +65,7 @@ config PHY_MTK_HDMI
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on COMMON_CLK
 	depends on OF
+	depends on REGULATOR
 	select GENERIC_PHY
 	help
 	  Support HDMI PHY for Mediatek SoCs.
-- 
2.39.5


