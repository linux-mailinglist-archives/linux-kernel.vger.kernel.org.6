Return-Path: <linux-kernel+bounces-411488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB629CFAD5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099112837F1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 23:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F64192D65;
	Fri, 15 Nov 2024 23:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbpOA4J6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646D67346D;
	Fri, 15 Nov 2024 23:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731711962; cv=none; b=Zt5EgP+P8LLQ6KkbB97EIjI0QsZD1kn9RSNJsUknVjk6ov2XKG9Mr7vhkdKprYtaOFmMaQ4DquXM7pxe38H436mo/jzzr8xB6UWRTMyEQt2F5hJa2rYBzPgam4l1QXjiNRn9iTD2evim+dQRB5kOqiQ8D+lVKZq6rdy9GMuBU7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731711962; c=relaxed/simple;
	bh=e/qjcGC/Gz+mw55kmBF1sqB0PcOV6jBJy2tWUAT/rrA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sNGU4sMO1s+SUeTeEyBzfepF8PgLZHqygEhbuzH3Q14X2NLh4kel2kzdqCdMUjsk2sRz61gdnFRlc2sOWUN0ZbTlg/liFBNsydDlP8JF+Ng+pkXunE8VdvLF/5vRc2YAww7fHIZ527Gg8/XPVfG3kTDZjLH6RZ5XkGtqosScjok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbpOA4J6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8F9C4CECF;
	Fri, 15 Nov 2024 23:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731711961;
	bh=e/qjcGC/Gz+mw55kmBF1sqB0PcOV6jBJy2tWUAT/rrA=;
	h=From:To:Cc:Subject:Date:From;
	b=nbpOA4J6ApxLj+x+T5PhlAzZATCwyQyhz9cFaeuFTriSV4jNBgkbcr+YnT33CYU8f
	 eb8CEWGe+UYmE2Z1tYhdoNvTCMqp/8kQiVF+u4FiY0b6NUVDACoDDBTYWU4G2s+c5i
	 4CmvxKD8UuBy1FbWwC/Tr5lR5qYs6ArlnuKhMyv+o9vfI4QT5aAEwNOT9K9xvWwCFC
	 Q6EVTnvXodkHea6AHDiFU8u7n6qvsNnp3gJGfR54eNhE6qBSNIjR2C8nixbI9E1jIc
	 qc2mh+B1ItHKTHebK/Fv2URc/CxqJzilq8FPBpLHWa7fz90Xj/2piDikKkbT4IPave
	 Y30wzoHEagrsg==
From: Arnd Bergmann <arnd@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Peng Fan <peng.fan@nxp.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH] firmware: arm_scmi: fix i.MX build dependency
Date: Sat, 16 Nov 2024 00:05:18 +0100
Message-Id: <20241115230555.2435004-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added SCMI vendor driver references functions in the
protocol driver but needs a Kconfig dependency to ensure it can link,
essentially the Kconfig dependency needs to be reversed to match the
link time dependency:

arm-linux-gnueabi-ld: sound/soc/fsl/fsl_mqs.o: in function `fsl_mqs_sm_write':
fsl_mqs.c:(.text+0x1aa): undefined reference to `scmi_imx_misc_ctrl_set'
arm-linux-gnueabi-ld: sound/soc/fsl/fsl_mqs.o: in function `fsl_mqs_sm_read':
fsl_mqs.c:(.text+0x1ee): undefined reference to `scmi_imx_misc_ctrl_get'

This however only works after changing the dependency in the SND_SOC_FSL_MQS
driver as well, which uses 'select IMX_SCMI_MISC_DRV' to turn on a
driver it depends on. This is generally a bad idea, so the best solution
is to change that into a dependency.

To allow the ASoC driver to keep building with the SCMI support, this
needs to be an optional dependency that enforces the link-time
dependency if IMX_SCMI_MISC_DRV is a loadable module but not
depend on it if that is disabled.

Fixes: 61c9f03e22fc ("firmware: arm_scmi: Add initial support for i.MX MISC protocol")
Fixes: 101c9023594a ("ASoC: fsl_mqs: Support accessing registers by scmi interface")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I'm not sure this is the version we want to go with in the end, without
having read the code in detail, but the version in linux-next is clearly
wrong in multiple ways and this is the best I could come up with so far.

If we can agree on this approach, it needs to go through the ASoC tree
as that contains the 101c9023594a commit at the moment.
---
 drivers/firmware/arm_scmi/vendors/imx/Kconfig | 1 +
 drivers/firmware/imx/Kconfig                  | 1 -
 sound/soc/fsl/Kconfig                         | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/Kconfig b/drivers/firmware/arm_scmi/vendors/imx/Kconfig
index 2883ed24a84d..a01bf5e47301 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/Kconfig
+++ b/drivers/firmware/arm_scmi/vendors/imx/Kconfig
@@ -15,6 +15,7 @@ config IMX_SCMI_BBM_EXT
 config IMX_SCMI_MISC_EXT
 	tristate "i.MX SCMI MISC EXTENSION"
 	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
+	depends on IMX_SCMI_MISC_DRV
 	default y if ARCH_MXC
 	help
 	  This enables i.MX System MISC control logic such as gpio expander
diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
index 477d3f32d99a..907cd149c40a 100644
--- a/drivers/firmware/imx/Kconfig
+++ b/drivers/firmware/imx/Kconfig
@@ -25,7 +25,6 @@ config IMX_SCU
 
 config IMX_SCMI_MISC_DRV
 	tristate "IMX SCMI MISC Protocol driver"
-	depends on IMX_SCMI_MISC_EXT || COMPILE_TEST
 	default y if ARCH_MXC
 	help
 	  The System Controller Management Interface firmware (SCMI FW) is
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 8e88830e8e57..678540b78280 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -29,8 +29,8 @@ config SND_SOC_FSL_SAI
 config SND_SOC_FSL_MQS
 	tristate "Medium Quality Sound (MQS) module support"
 	depends on SND_SOC_FSL_SAI
+	depends on IMX_SCMI_MISC_DRV || !IMX_SCMI_MISC_DRV
 	select REGMAP_MMIO
-	select IMX_SCMI_MISC_DRV if IMX_SCMI_MISC_EXT !=n
 	help
 	  Say Y if you want to add Medium Quality Sound (MQS)
 	  support for the Freescale CPUs.
-- 
2.39.5


