Return-Path: <linux-kernel+bounces-527685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB87DA40E30
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 12:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505A53B1B2C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FF9204F79;
	Sun, 23 Feb 2025 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="J/V4EFkj"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77DE28382
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740308549; cv=none; b=cLUqD8yQtR/fobtU0JiphOYz8qqJU6yiU01/cgE1BF6l4HuaOcq4bz2080GVfxaBDO+eaGCIKKGGRBu4I4pkVVTAtpN1v7LKQ7UKYjxvA6i6/amBTmMwar5PHCiKksyn8teggUVKb+8rrgwvrgKFauu+fTZf8KXBVHuZpPAWcuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740308549; c=relaxed/simple;
	bh=ujHLAB81bLDG1rFjYTdk8D4Cj+5uJUkDjmnklWgTiik=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TzY3ye1RcBzPLhKXd7Wg+i5mu6ERL20D9pgeO4m6ZBAiFtDPbF9EQu2y75Vmn9HgVf2MIE0KjRqHzeVYtkr15XY75OIQ0Ju0p8Ooj0GCLH3xZz9N5EspZQC5kmE7XmZUYjfjYgH20/CkZ9rH1mgOj4ksHMyI18A2XL7k+wrCdmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=J/V4EFkj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740308545;
	bh=ujHLAB81bLDG1rFjYTdk8D4Cj+5uJUkDjmnklWgTiik=;
	h=From:Subject:Date:To:Cc:From;
	b=J/V4EFkj7fkhmQYQbOzNAV2yL40vgJCy4A2toGa8Q/dE3HefV2Yyu4ydtHlls222Y
	 3Fs1BNuUnL19atnl1HV96ZSmRtBwCm4v8xGz4eEW848feY5gauMhm1bmTuLlzh4lAs
	 bxair9Nf1NxHuRETdf/bpvRzqVo4mvR95wJElcdU3eshtZ8QQfXirv0vp4eiOg8oXH
	 jtFNoB9X2QyU0nb5AXZKAMIOnjHzSpZ/VzknIdCZsVjtfI888FtZ0w5ah8+VnLxnPd
	 DnyfsxN2+EDTLSrseGM5neMhExRo215BSXqjapmxB1CyA9rk0MGqohrQJ3jlxfiJoO
	 +CFpWGy4TxVEA==
Received: from localhost (unknown [188.27.58.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 8FB6717E0199;
	Sun, 23 Feb 2025 12:02:25 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v3 0/8] phy: rockchip: samsung-hdptx: Support high color
 depth management
Date: Sun, 23 Feb 2025 13:02:07 +0200
Message-Id: <20250223-phy-sam-hdptx-bpc-v3-0-66a5c8e68327@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC8Au2cC/23NUQuDIBDA8a8SPu+GXaVsT/seYw+mNoVK0ZAi+
 u6zYDBG3NP/4H63kqiD1ZHci5UEnWy0bsxRXQoijRjfGqzKTZBiXSJl4M0CUQxglJ9maL2EqqW
 NZMhZpzjJdz7ozs6H+XzlNjZOLizHi1Tu26/GT7RUAgVaSdS1Yorf+EO6vhetC+Iq3UB2MeGPU
 uKZgllpuGYcJc9T/yvbtn0A3SXvX/wAAAA=
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
Changes in v3:
- Rebased series onto next-20250221 and fixed several conflicts due to
  the recently introduced eDP support
- Link to v2: https://lore.kernel.org/r/20241212-phy-sam-hdptx-bpc-v2-0-57e672c7c7c4@collabora.com

Changes in v2:
- Added new patches providing a bug fix and several driver cleanups and
  improvements
- Link to v1: https://lore.kernel.org/r/20241207-phy-sam-hdptx-bpc-v1-0-03c2e4d6d797@collabora.com

---
Cristian Ciocaltea (7):
      phy: hdmi: Add color depth configuration
      phy: rockchip: samsung-hdptx: Fix clock ratio setup
      phy: rockchip: samsung-hdptx: Drop unused lcpll_config
      phy: rockchip: samsung-hdptx: Setup TMDS char rate via phy_configure_opts_hdmi
      phy: rockchip: samsung-hdptx: Add high color depth management
      phy: rockchip: samsung-hdptx: Cleanup internal rate handling
      phy: rockchip: samsung-hdptx: Avoid Hz-hHz unit conversion overhead

Sandor Yu (1):
      phy: Add HDMI configuration options

 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 163 +++++++++++-----------
 include/linux/phy/phy-hdmi.h                      |  21 +++
 include/linux/phy/phy.h                           |   7 +-
 3 files changed, 111 insertions(+), 80 deletions(-)
---
base-commit: d4b0fd87ff0d4338b259dc79b2b3c6f7e70e8afa
change-id: 20241206-phy-sam-hdptx-bpc-3b05c6276fd7


