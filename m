Return-Path: <linux-kernel+bounces-566154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525ABA673FC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D7F3BE4A9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E6320C46B;
	Tue, 18 Mar 2025 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JSY35S6C"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72E81714B2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301421; cv=none; b=RSyE8Q1aQsHwCUo40K2/zyj+nOTr7sSUOWV9CJWU8uMYbT1m5gYt5tjc94vU+mehvdsl8KNeyNwe8xAHHWmSG/Z5b5epuU6WgrueCqwWFUmJ10sVRP1UZ/F1589AQzisL19QxTPkH7I63el8eOALTAA53yBH8Q5eJBpQq37iiJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301421; c=relaxed/simple;
	bh=1EPLFHDewAN8/i4J9+X/KTzzwHH36Tm6ALls+862c64=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ONYIyq991UPRPbz9YD25/3Hw90RLjH1w0qyuIWjljgwpQNeffP+KD5AMwDtinCkTm+TQ3q8Qm+A1HULlePqC4pWdFPw1dnKZISvoXjuKIekF4Fweh/rx8HymxWS9vbWmnodQkD4VxUaMAcdU9JvCAt4TqeBfTw7cgEXOpo3KTS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JSY35S6C; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742301416;
	bh=1EPLFHDewAN8/i4J9+X/KTzzwHH36Tm6ALls+862c64=;
	h=From:Subject:Date:To:Cc:From;
	b=JSY35S6CrgfDm8T6OIWNI8SqPLbGQslb2/CiagAlH3SfZtGgcLlQLsyfqfrMYpHYS
	 NyZSJsB1JXaDD1zKxfHOAEE163b8FTSkewAUrOyU7ybxGOYJa0aPFUq5E/GpsoIum9
	 HpGDEtCPspOhkkSzsQU2dFSaQ53sOaSZ+12kHBkfZzuWlGrF6rH3nWALdZrR7g25eC
	 rddwaZpD/tk9jpFIHlvPKZ6tfmb+zNGwpbGhpdNG7ERVPlNIMi7M417jcsOW6z6TpO
	 43AR56/50lXq9DigW3Cn6Tl/PXoMQJh+6j9XnTLG85+co8YYNjAFjujJADFI714qei
	 qdN9bYkduteWA==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 83E9317E0673;
	Tue, 18 Mar 2025 13:36:56 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v6 00/14] phy: rockchip: samsung-hdptx: Support high color
 depth management
Date: Tue, 18 Mar 2025 14:35:34 +0200
Message-Id: <20250318-phy-sam-hdptx-bpc-v6-0-8cb1678e7663@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJZo2WcC/23OwYoDIQwG4FcpnmvRqInd077HsgdHnY7Q1kHL0
 FLm3dcWypYiOf2B/0vurMaSYmVfmzsrcUk15XMLuN0wP7nzIfIUWmYgQEsQyOfpxqs78SnMlys
 fZs/VIIxHIBwDsdabSxzT9Wn+/LY8pXrJ5fY8scjH9qVRR1skF1woD1EHDLSnb5+PRzfk4nY+n
 9hDXOBNkdBToCmGIhJ4aqN7inopRgConqKaguiMtxGtgu4v+l9RQvcU3RSLhqwmL9XYVcy7Ynu
 KaYoywhJYGvdBfirruv4BxfK80s4BAAA=
X-Change-ID: 20241206-phy-sam-hdptx-bpc-3b05c6276fd7
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2

This series relies on the new HDMI PHY configuration options [1] (patch
included here for convenience) to provide high color depth management
for rockchip-samsung-hdptx, and to introduce a proper solution to setup
the TMDS character rate on this PHY.

[1] https://lore.kernel.org/lkml/d1cff6c03ec3732d2244022029245ab2d954d997.1734340233.git.Sandor.yu@nxp.com/

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v6:
- Collected R-b tags from Dmitry
- Updated commit description for "phy: rockchip: samsung-hdptx: Fix
  clock ratio setup"
- Added new patch "phy: rockchip: samsung-hdptx: Do no set
  rk_hdptx_phy->rate in case of errors"
- Replaced some "unsigned long" and "u32" types with "unsigned long
  long" in "phy: rockchip: samsung-hdptx: Avoid Hz<->hHz unit conversion
  overhead" to match the tmds_char_rate type (Dmitry)
- Added new patch "phy: rockchip: samsung-hdptx: Rename ambiguous
  rk_hdptx_phy->rate", originally part of "phy: rockchip: samsung-hdptx:
  Optimize internal rate handling" (Dmitry)
- Rebased series onto next-20250317
- Link to v5: https://lore.kernel.org/r/20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com

Changes in v5:
- Moved the patch eliminating the unnecessary and rather confusing
  Hz<->hHz unit conversion before all the others adding new content
- Moved the patch adding high color depth management to the last
  position, so that it follows the internal rate handling optimization
- Amended description for a few patches to improve clarity
- Performed some trivial refactoring in some cases while dealing with
  rebase conflicts
- Link to v4: https://lore.kernel.org/r/20250304-phy-sam-hdptx-bpc-v4-0-8657847c13f7@collabora.com

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
Cristian Ciocaltea (13):
      phy: hdmi: Add color depth configuration
      phy: rockchip: samsung-hdptx: Fix clock ratio setup
      phy: rockchip: samsung-hdptx: Do no set rk_hdptx_phy->rate in case of errors
      phy: rockchip: samsung-hdptx: Drop unused struct lcpll_config
      phy: rockchip: samsung-hdptx: Drop unused phy_cfg driver data
      phy: rockchip: samsung-hdptx: Drop superfluous cfgs driver data
      phy: rockchip: samsung-hdptx: Avoid Hz<->hHz unit conversion overhead
      phy: rockchip: samsung-hdptx: Setup TMDS char rate via phy_configure_opts_hdmi
      phy: rockchip: samsung-hdptx: Provide config params validation support
      phy: rockchip: samsung-hdptx: Restrict altering TMDS char rate via CCF
      phy: rockchip: samsung-hdptx: Rename ambiguous rk_hdptx_phy->rate
      phy: rockchip: samsung-hdptx: Optimize internal rate handling
      phy: rockchip: samsung-hdptx: Add high color depth management

Sandor Yu (1):
      phy: Add HDMI configuration options

 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 292 +++++++++++++---------
 include/linux/phy/phy-hdmi.h                      |  21 ++
 include/linux/phy/phy.h                           |   7 +-
 3 files changed, 202 insertions(+), 118 deletions(-)
---
base-commit: e94bd4ec45ac156616da285a0bf03056cd7430fc
change-id: 20241206-phy-sam-hdptx-bpc-3b05c6276fd7


