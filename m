Return-Path: <linux-kernel+bounces-543065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F22DDA4D123
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CE897A7769
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB0B13B5A0;
	Tue,  4 Mar 2025 01:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S58iApqS"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8DD86328
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 01:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052666; cv=none; b=Wb8UFZ461SVKlax+AM19v/Z/Gufd69meNzb+1di1rhVHr2hYHwaOLzJHAmA+AbEIMaZRSyjCjlPOobwsZzmMpoX8S3fXXFjmuqnP4RvgZ7WgifHZdmLy8ReGnWVo9mrP38M5CLnVzcafg5APs4O0501mOf2texzzc7BS2+41buk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052666; c=relaxed/simple;
	bh=LBjWJrMp2bknkYtBu/515aGST55w/wc355zwRJ0QyN4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CJzFHbHTUsuszJ8luVd1K9Gx7qcxHZZ5nykqMDvN1C64SXzeRgdB6KG704luHkRa/zxeXxbthRvHzA4ElYOIYAsOszNml3OnpmgeIPmVNkCnnQvj7lh2RfKErSm27Gc4FDhko4UNqMR4WEDlpaLMNEREvxRhyHCGKIfyQunSPio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S58iApqS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741052657;
	bh=LBjWJrMp2bknkYtBu/515aGST55w/wc355zwRJ0QyN4=;
	h=From:Subject:Date:To:Cc:From;
	b=S58iApqS3FFyg+uA6r/pTZJsDth6HISAI3/sq9P9XzeqZbXRsrUeLTB+9764EDmtT
	 tkfB6Fl+SxR5iblOwj4xFGPzP1uhJ0S+WERSAkcwR75jZT+FXZ/3r0ryk95DeUdjks
	 2cUnmlZuC2lz0M17d1iqkxOdYFt+L3Hdetd5n49aAY3W4EJnQXXNnT65ZRSl2Udd6H
	 nTOwsyRqKUE+J1P6zkT6ZJHLJ/XXJvDvSF1OIdyaHPKKG0fJNIKj7zEEEIhIBNQ1Pa
	 IYN4qLfjKIbyUSWpOHFNTicR9cgJb9z/8lGytHSSkukkM3MBt6+1FhIcLb0jHgLuu4
	 GQ1BdFn81Eg1A==
Received: from localhost (unknown [188.27.58.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 3D0BE17E0B71;
	Tue,  4 Mar 2025 02:44:17 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v4 00/12] phy: rockchip: samsung-hdptx: Support high color
 depth management
Date: Tue, 04 Mar 2025 03:43:59 +0200
Message-Id: <20250304-phy-sam-hdptx-bpc-v4-0-8657847c13f7@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN9axmcC/23O0QqDIBQG4FcZXs9hR9O2q73H2IWpLaFSNKKI3
 n0WBIPJufoP/N85K4omWBPR47KiYCYbrRtSYNcLUq0cPgZbnTICAqwAwrFvFxxlj1vtxxnXXmF
 ak1JxELzRAqWeD6ax82G+3im3No4uLMeJqdi3pyYy2lRggglVYJjmWtzFU7muk7UL8qZcj3Zxg
 h+lgJwCSSmF4QKUSMNyCj2VkgDQnEKTwrksVWV4ReHvl23bvnPGvoBCAQAA
X-Change-ID: 20241206-phy-sam-hdptx-bpc-3b05c6276fd7
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

This series relies on the new HDMI PHY configuration options [1] (patch
included here for convenience) to provide high color depth management
for rockchip-samsung-hdptx, and to introduce a proper solution to setup
the TMDS character rate on this PHY.

[1] https://lore.kernel.org/lkml/d1cff6c03ec3732d2244022029245ab2d954d997.1734340233.git.Sandor.yu@nxp.com/

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v4:
- Added patches to drop unnecessary phy_cfg & cfgs driver data
- Embedded struct phy_configure_opts_hdmi in driver data (Dmitry)
- Added new patch to provide config params validation support
- Provided a patch to restrict altering TMDS char rate via CCF (Dmitry)
- Made a bunch of small tweaks here and there
- Link to v3: https://lore.kernel.org/r/20250223-phy-sam-hdptx-bpc-v3-0-66a5c8e68327@collabora.com

Changes in v3:
- Rebased series onto next-20250221 and fixed several conflicts due to
  the recently introduced eDP support
- Link to v2: https://lore.kernel.org/r/20241212-phy-sam-hdptx-bpc-v2-0-57e672c7c7c4@collabora.com

Changes in v2:
- Added new patches providing a bug fix and several driver cleanups and
  improvements
- Link to v1: https://lore.kernel.org/r/20241207-phy-sam-hdptx-bpc-v1-0-03c2e4d6d797@collabora.com

---
Cristian Ciocaltea (11):
      phy: hdmi: Add color depth configuration
      phy: rockchip: samsung-hdptx: Fix clock ratio setup
      phy: rockchip: samsung-hdptx: Drop unused struct lcpll_config
      phy: rockchip: samsung-hdptx: Drop unused phy_cfg driver data
      phy: rockchip: samsung-hdptx: Drop superfluous cfgs driver data
      phy: rockchip: samsung-hdptx: Setup TMDS char rate via phy_configure_opts_hdmi
      phy: rockchip: samsung-hdptx: Provide config params validation support
      phy: rockchip: samsung-hdptx: Restrict altering TMDS char rate via CCF
      phy: rockchip: samsung-hdptx: Add high color depth management
      phy: rockchip: samsung-hdptx: Optimize internal rate handling
      phy: rockchip: samsung-hdptx: Avoid Hz-hHz unit conversion overhead

Sandor Yu (1):
      phy: Add HDMI configuration options

 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 289 +++++++++++++---------
 include/linux/phy/phy-hdmi.h                      |  21 ++
 include/linux/phy/phy.h                           |   7 +-
 3 files changed, 200 insertions(+), 117 deletions(-)
---
base-commit: cd3215bbcb9d4321def93fea6cfad4d5b42b9d1d
change-id: 20241206-phy-sam-hdptx-bpc-3b05c6276fd7


