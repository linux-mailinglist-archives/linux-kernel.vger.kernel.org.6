Return-Path: <linux-kernel+bounces-552460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BDCA57A16
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 13:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A4F67A7EF8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13341B6CEC;
	Sat,  8 Mar 2025 12:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OijMBpaJ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380EA634
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741436494; cv=none; b=TOENiHagU2rfO1jGeTQF+MWGFgPq30bG/8visLIs9bv4niYiMDPLRH/euskdL0J6YBUlkohag37d17zZiJkO6GbjzB10Fzoi/Cz1pAfg9ZdpgTpoI/YTw0iNDqPOLOqXUnaQtdDOT9L99cOy0qLNvxvbsEwmwZnFP52HvJy4xEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741436494; c=relaxed/simple;
	bh=A5jKN2t63kBzSii3RgaD0GHXG1gs1uhvXpjEMzL5JxY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NCvGmpgmbQAH5KOvRH66/zMEFiOixVv85hJJHXJCgshVsL7m3rRXfFdg8ePGLFqcjbvMb4yaM2L38zPU5O0E0yTEHlo+G7drQfLOX6kHyOiO52rIBXHyvd5KFB213aNu9WZS40SjN4NqhRHMLDgm+zItJN5wdPcLACC06zczAqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OijMBpaJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741436490;
	bh=A5jKN2t63kBzSii3RgaD0GHXG1gs1uhvXpjEMzL5JxY=;
	h=From:Subject:Date:To:Cc:From;
	b=OijMBpaJj4tCrq8BIoIvxgO1c1OCZo69jGlgYq2CBgXI8qPjdyKO+Pf8kSuxGmEHc
	 zUvm2/TYDK181ZI+HJecCgUg3rtB/iXV3h6UFyqk8QJFMlaezsQau2keYvRZ2Os+Au
	 RWyYRYJIV/6N/ONaGIuL2nilAEOa67mRaspLStz/+gxSFIErsLALASIaz4Y42KBCsk
	 2QyRH9XujlI9SL4lMnzCKIl97FgzmAhn57ay46B49mCN0hwwc/aEa3oIwXilbdg3uu
	 Tt5hm1OqLPMduYX2N2A2dfHBvdf5mn36qdkD1Owrzwo3SVtCkcNp4q3xIX2YRU15kN
	 LsYYPMr6ADZUg==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 150AB17E0657;
	Sat,  8 Mar 2025 13:21:30 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v5 00/12] phy: rockchip: samsung-hdptx: Support high color
 depth management
Date: Sat, 08 Mar 2025 14:21:09 +0200
Message-Id: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADU2zGcC/23OwWoDIRAG4FcJnmvRUWe2PfU9Sg/u6HaFJC4al
 oSw7x4TCClU5vQP/N/MVdRYUqzic3cVJa6ppnxswb3tBM/++BtlCi0LUGA1KJTLfJHVH+QcltN
 ZjgtLMyrHCIRTINF6S4lTOj/M75+W51RPuVweJ1Z93z416mirlkoqwxBtwEAf9MV5v/djLv6d8
 0HcxRX+KBp6CjTFUUQCpja2p5in4hSA6SmmKYje8RBxMND9xb4Uo2xPsU0Z0NFgibWZ/inbtt0
 AByYU1ogBAAA=
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
Cristian Ciocaltea (11):
      phy: hdmi: Add color depth configuration
      phy: rockchip: samsung-hdptx: Fix clock ratio setup
      phy: rockchip: samsung-hdptx: Drop unused struct lcpll_config
      phy: rockchip: samsung-hdptx: Drop unused phy_cfg driver data
      phy: rockchip: samsung-hdptx: Drop superfluous cfgs driver data
      phy: rockchip: samsung-hdptx: Avoid Hz<->hHz unit conversion overhead
      phy: rockchip: samsung-hdptx: Setup TMDS char rate via phy_configure_opts_hdmi
      phy: rockchip: samsung-hdptx: Provide config params validation support
      phy: rockchip: samsung-hdptx: Restrict altering TMDS char rate via CCF
      phy: rockchip: samsung-hdptx: Optimize internal rate handling
      phy: rockchip: samsung-hdptx: Add high color depth management

Sandor Yu (1):
      phy: Add HDMI configuration options

 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 292 +++++++++++++---------
 include/linux/phy/phy-hdmi.h                      |  21 ++
 include/linux/phy/phy.h                           |   7 +-
 3 files changed, 202 insertions(+), 118 deletions(-)
---
base-commit: cd3215bbcb9d4321def93fea6cfad4d5b42b9d1d
change-id: 20241206-phy-sam-hdptx-bpc-3b05c6276fd7


