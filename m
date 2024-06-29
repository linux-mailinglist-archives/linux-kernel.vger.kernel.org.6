Return-Path: <linux-kernel+bounces-234716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C84E991C9C4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 02:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FA44B22EEA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1072D812;
	Sat, 29 Jun 2024 00:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fEHW/Lp+"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8957F8
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 00:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719620853; cv=none; b=ljcBBnCVi9RV6yRaYA8r8RdxEpRTrYmvU+CZ4d1xZK8pORzPo3JjjCMWDN75vFCW/0tdZ6MWr8xBpowIWLMSA7JpnVjs07Mgt8rMCq1qXa7LW1ukbYix8Pmp7FqHUCdPjPH1Puf9FMOrEa3Jbf1Yd+F2/qn6YYr2XXyJZnVrj5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719620853; c=relaxed/simple;
	bh=eXyQilo90szlOYhUb0U8hcMrE0RKEYfQYYK0EvOt2fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PKz1nEpIwsgSk2FjXfj6jaykL5d4ZmgYKAiUaXDMfP5AcWAgoTn5k1usUos/LaXRrr9Yxy38UgUWLqxG+VjPZ2WgQ5TyP7vbBqiZPAEJXka2+2gNQ1tYFWsCuqCv3h6y2pPG/hL4ZDXB+G4SX/CXzc6gKc6MfhlnFds8FaXKXd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fEHW/Lp+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719620849;
	bh=eXyQilo90szlOYhUb0U8hcMrE0RKEYfQYYK0EvOt2fo=;
	h=From:Date:Subject:To:Cc:From;
	b=fEHW/Lp++jRWGvU4dRooQL8SOAyaWieknB1dPCbIn35MeENIB/33CP4D5GloD8CDV
	 iOmr7UvTlUhjlx+OhllPvG1TGoobdbFJRVhBu3aa/yjcV288Vrg8TmDiBT7UikuNCI
	 ALVP9lkyA1UwMjfVZiz2Bk/EZf4DJSW1Ynj1J4EW78Neo9D67WoYcinuoJDJU9mJc+
	 whMFLq+xk4xj6FnLTGV1OpPJWlip5rifQIrL1Wq01Pg+jlUcKpymuAvtwRvVK0eIvc
	 gZr60dlrIQTyW8sYvAeZtFXrEZYpa+MywNb6y52FVhmdVtol8a4avi9kYuBnp6w/B+
	 5ZV8nxR13w6cA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2737C37821E6;
	Sat, 29 Jun 2024 00:27:29 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 29 Jun 2024 03:26:58 +0300
Subject: [PATCH] phy: phy-rockchip-samsung-hdptx: Select CONFIG_MFD_SYSCON
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240629-rk-hdptx-compile-test-fix-v1-1-c86675ba8070@collabora.com>
X-B4-Tracking: v=1; b=H4sIANFUf2YC/x2MWwqAIBAArxL73YItFdhVoo/MLZdeohJBdPekz
 xmYeSByEI7QFQ8EviTKeWSoygImNx4Lo9jMQIpq1ZLGsKKzPt04nbuXjTFxTDjLjcYoq9tRGaI
 Gcu8DZ/2/++F9P/XpbR1rAAAA
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0

Compile testing configurations without REGMAP support enabled results in
a bunch of errors being reported:

  ../drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c:569:21: error: variable ‘rk_hdptx_phy_regmap_config’ has initializer but incomplete type
    569 | static const struct regmap_config rk_hdptx_phy_regmap_config = {
        |                     ^~~~~~~~~~~~~
  ../drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c:570:10: error: ‘const struct regmap_config’ has no member named ‘reg_bits’
    570 |         .reg_bits = 32,
        |          ^~~~~~~~

Note that selecting REGMAP alone is not enough, because of the following
liker error:

  phy-rockchip-samsung-hdptx.c:(.text+0x10c): undefined reference to `__devm_regmap_init_mmio_clk'

Instead of the obvious fix to enable REGMAP_MMIO, select MFD_SYSCON,
which implicitly enables REGMAP_MMIO as well.  The rationale is that the
driver has been already relying on the syscon functionality.

Moreover, without MFD_SYSCON enabled, the test coverage is reduced,
since the linker might not detect any potential undefined references
following syscon_regmap_lookup_by_phandle() invocation in
rk_hdptx_phy_probe() body.  That is because the function would
unconditionally return -ENOTSUP, hence the compiler is free to optimize
out any unreachable code.

Finally ensure PHY_ROCKCHIP_SAMSUNG_HDPTX depends on HAS_IOMEM, as
required by MFD_SYSCON.

Fixes: 553be2830c5f ("phy: rockchip: Add Samsung HDMI/eDP Combo PHY driver")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
index 08b0f4345760..490263375057 100644
--- a/drivers/phy/rockchip/Kconfig
+++ b/drivers/phy/rockchip/Kconfig
@@ -86,7 +86,9 @@ config PHY_ROCKCHIP_PCIE
 config PHY_ROCKCHIP_SAMSUNG_HDPTX
 	tristate "Rockchip Samsung HDMI/eDP Combo PHY driver"
 	depends on (ARCH_ROCKCHIP || COMPILE_TEST) && OF
+	depends on HAS_IOMEM
 	select GENERIC_PHY
+	select MFD_SYSCON
 	select RATIONAL
 	help
 	  Enable this to support the Rockchip HDMI/eDP Combo PHY

---
base-commit: 1eb586a9782cde8e5091b9de74603e0a8386b09e
change-id: 20240629-rk-hdptx-compile-test-fix-bb0d96a0b225


