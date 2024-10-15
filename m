Return-Path: <linux-kernel+bounces-366180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EB499F1B4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B4E1C220F9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B50A1D5175;
	Tue, 15 Oct 2024 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsRKFXeO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7E31CB9FE
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007056; cv=none; b=UJHid/ep5UsloCcVeYOIlbIMy3/5rq9eAcjPXh3CR9YFuCMXOqhxlvusQfBVU4cE8ReuQK4Q/ds5FwDVAHtXZBKLoQK7UPmp0yOmkSN9fGG6hpzq7HNqDcnN20T0G0rJ0RKVLqDW52JtGhnhKR3rU+7sTebIWO1ByzJZIXUs+jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007056; c=relaxed/simple;
	bh=VFhgk/njsHyjd8aB6tafElwHW+m/T48wZYuky3XTUMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Elpq0WV0nLMa7qJDWJ2aD5/Hf4A1IBySZQzHE8B+dnN/84WHD9ifhMhLgWZ4i3OdtbtsvT0aNztbXVwdsi7WL4APsochInv52BbWZgp0HCbF6aXvXvCWAM7PyzGN6+ZYrpOR14i+dbSp4Y1ot2AfbbqHH/fSQv6QLNNaid9ybws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsRKFXeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10576C4CECF;
	Tue, 15 Oct 2024 15:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729007056;
	bh=VFhgk/njsHyjd8aB6tafElwHW+m/T48wZYuky3XTUMI=;
	h=From:To:Cc:Subject:Date:From;
	b=lsRKFXeOTuNDnd3VUbBC72V86Nc6o9WpbC5TyTl9YT6NcJPKnmIFYvbrNdm7fQi/7
	 tLRXBxUjWLKk1MOtU1F5azvz8teZ1IIOb8/nQ+JeON6ToYeHdr3b70xoQmcVXTXydO
	 tjB3lbRUCB9C4GzbtaGwt2jYLaD8bT3Xs4wUUE5QzzB40WdwGH/zgNF/s/kgFEOyKV
	 8+4HFLwkIIvQpmvaMmyNbeHqKQgXadmE7imimYuRaUckbFAx4h4sGCM/iFZZ7HjCLm
	 ue6NRdM6hevEagOj64SDJMRvRr8YRWNAly6eNIbc33iUDW3c4G6AWpggJl5lG8BHbu
	 sZ11rxEaoAXdw==
From: Arnd Bergmann <arnd@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] drm/panel: s6e3ha8: select CONFIG_DRM_DISPLAY_DSC_HELPER
Date: Tue, 15 Oct 2024 15:34:38 +0000
Message-Id: <20241015153442.3757061-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The new driver needs the dsc helper code to be available:

x86_64-linux-ld: vmlinux.o: in function `s6e3ha8_amb577px01_wqhd_prepare':
panel-samsung-s6e3ha8.c:(.text+0x16b1e65): undefined reference to `drm_dsc_pps_payload_pack'

Select it from Kconfig as we do for other similar drivers.

Fixes: 779679d3c164 ("drm/panel: Add support for S6E3HA8 panel driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: add dependency to the correct driver
---
 drivers/gpu/drm/panel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index ddfaa99ea9dd..128c12e8b84f 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -703,6 +703,7 @@ config DRM_PANEL_SAMSUNG_S6E3HA8
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
+	select DRM_DISPLAY_DSC_HELPER
 	select VIDEOMODE_HELPERS
 
 config DRM_PANEL_SAMSUNG_S6E63J0X03
-- 
2.39.5


