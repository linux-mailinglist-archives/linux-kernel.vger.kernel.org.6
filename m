Return-Path: <linux-kernel+bounces-257055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FEB937496
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9C0283972
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 07:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4648958AC4;
	Fri, 19 Jul 2024 07:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuAaoJgc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4CD2C80
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721375701; cv=none; b=PEgqWL8bLKSBggbIkq4LSQZWnsYXKQoctGdKnbPe/d/xAEwepHOiZdSsKHrI+ypPetNT4aXgndk1HlpOJr749eNdrHprUvi6nfAXcRITqDhLP95njRutO2owU0cqINrtTG1X0iVDd5V+1wO9CEVyq9J0Ivqm12bBo6OlfWIZ7/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721375701; c=relaxed/simple;
	bh=W8wSaMuFu+gkCLCSzJa/gXpVw17QnJMqwKbE6WN4SoY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pps4i71KRlAnkFS9b4qipXTBkWCBTff8Oh4WfBFR/6avhSjjsT3RWcND7TIOa655Xv7maeJjc1TyKE5Kb9MyNabqEUto/iJnBQMl/FbCfel67yX8XrpuZ9kIZgDT2XY1Nt40N9tmaufgOY+Uwb+SrXxUa4hVaD1ft0wAQUcwr58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuAaoJgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A34C32782;
	Fri, 19 Jul 2024 07:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721375701;
	bh=W8wSaMuFu+gkCLCSzJa/gXpVw17QnJMqwKbE6WN4SoY=;
	h=From:To:Cc:Subject:Date:From;
	b=cuAaoJgcFF7G7yMkmbxqhagURXqIBNBcHzGWT66VKHJQWmeQ3vMSX8E1vKcT0DhTf
	 DiIQb7Kxf75yxPi7oU3rbtqiBD5OIORapwQYl8X+VxT7NyglWrUhTMGpNG/ljvKBKg
	 ztlt80iaOjIoo1pAgnT0PhMKF1riF34/gmkZ6gAEcnX97K4gHpvOYPk/GMFgY5vhMP
	 mAXUWpi6k9AAqfPFVjG3CjGO69OMA7+Pad3m/P8KS1MbllsDijmyxWItjC/BI8aj3V
	 TtHWcwxVQWyTnGw3nb2CTjo4/IlosQSv2nTYmpfAL1DVrOpLIEHZ2FmsU8N3e1d3Bj
	 NxOys413qGOeQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Yannick Fertre <yannick.fertre@foss.st.com>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
	Philippe Cornu <philippe.cornu@foss.st.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/stm: add COMMON_CLK dependency
Date: Fri, 19 Jul 2024 09:54:41 +0200
Message-Id: <20240719075454.3595358-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The added lvds driver and a change in the dsi driver resulted in failed
builds when COMMON_CLK is disabled:

x86_64-linux-ld: drivers/gpu/drm/stm/dw_mipi_dsi-stm.o: in function `dw_mipi_dsi_stm_remove':
dw_mipi_dsi-stm.c:(.text+0x51e): undefined reference to `clk_hw_unregister'

x86_64-linux-ld: drivers/gpu/drm/stm/lvds.o: in function `lvds_remove':
lvds.c:(.text+0xe3): undefined reference to `of_clk_del_provider'
x86_64-linux-ld: lvds.c:(.text+0xec): undefined reference to `clk_hw_unregister'
x86_64-linux-ld: drivers/gpu/drm/stm/lvds.o: in function `lvds_pll_config':
lvds.c:(.text+0xb5d): undefined reference to `clk_hw_get_rate'
x86_64-linux-ld: drivers/gpu/drm/stm/lvds.o: in function `lvds_probe':
lvds.c:(.text+0x1476): undefined reference to `clk_hw_register'
x86_64-linux-ld: lvds.c:(.text+0x148b): undefined reference to `of_clk_hw_simple_get'
x86_64-linux-ld: lvds.c:(.text+0x1493): undefined reference to `of_clk_add_hw_provider'
x86_64-linux-ld: lvds.c:(.text+0x1535): undefined reference to `clk_hw_unregister'

Add this as a dependency for the stm driver itself, since it will be
required in practice anyway.

Fixes: 185f99b61442 ("drm/stm: dsi: expose DSI PHY internal clock")
Fixes: aca1cbc1c986 ("drm/stm: lvds: add new STM32 LVDS Display Interface Transmitter driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/stm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/stm/Kconfig b/drivers/gpu/drm/stm/Kconfig
index 1cc6b6cbdfa9..d7f41a87808e 100644
--- a/drivers/gpu/drm/stm/Kconfig
+++ b/drivers/gpu/drm/stm/Kconfig
@@ -2,6 +2,7 @@
 config DRM_STM
 	tristate "DRM Support for STMicroelectronics SoC Series"
 	depends on DRM && (ARCH_STM32 || COMPILE_TEST)
+	depends on COMMON_CLK
 	select DRM_KMS_HELPER
 	select DRM_GEM_DMA_HELPER
 	select DRM_PANEL_BRIDGE
-- 
2.39.2


