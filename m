Return-Path: <linux-kernel+bounces-531925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F4DA446A6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524C81891D56
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC3F1922E0;
	Tue, 25 Feb 2025 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAHGoG5g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B3816C684
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501844; cv=none; b=Vjaz21S+es6Vfh65Q2Hs/SwbXf3e+Hs0tGmRhWvlLuVMzwkxOE6vaWQ2PXHbV+2vZCU9l0MMEdRZtT6ZP4ZEG1grveiB4cBMnkKPFpVu+Bbw0V7hmzjWSkW+WSEU2DjNXDMHk7KXViXtHzY3SltbtjFKyFqOGMbrA9UkbpG1mOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501844; c=relaxed/simple;
	bh=Ql5s9tXR9G/woA8eFE6vmrVxYTCWBGMKz7pHTDWcxpI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FVt8kv7t91mt2q9O4NQydSUnOf5XCqCTyiEpqh/PJuoTX1ADzlSaLhj5Z9GxQE96lWCNOUUls3W8bHApcUftpd4nl/Q/Xr1sRqxhJ2NNGNrZoLnb6Q0/s1Xw9Wb154hzAHyHPzNNOc4A4VS8v14NnrfiPYPLCWwhaw5Ju1xyj7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAHGoG5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA6BC4CEE9;
	Tue, 25 Feb 2025 16:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740501844;
	bh=Ql5s9tXR9G/woA8eFE6vmrVxYTCWBGMKz7pHTDWcxpI=;
	h=From:Subject:Date:To:Cc:From;
	b=TAHGoG5gzY+0pUNA9ggiK+Uf5AaO/NrJ9NrkDzOI3vyjE6pGhlaxfwUNODsWLS2BK
	 ChkCQR6Ii9z68MJ3zo0oxWJ1Ft64lXa17d4bGI2f2ZA98zflo3xLBWmLdhRQ0+QqTk
	 PXO8wippyYAboF48/3io8YykZsDnHXZ8IQCHrs1g/dy31W/OXDrpcjsLXlyimn+41P
	 3PVIOS0wDh4Ij5Gb2nIJkcf/F5BEFz0zJ9Dq451cjFwQPv7OeWQ6dZaXjCq6mfOpJC
	 OxYxgqpS7zWP/jG6nZN3naMKWwHHuYxtlgp5VnH6BMktTLfgDbNnDrR4+m9J5LSy23
	 14peaGo7XrYxw==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v4 00/15] drm/bridge: Various quality of life improvements
Date: Tue, 25 Feb 2025 17:43:48 +0100
Message-Id: <20250225-bridge-connector-v4-0-7ecb07b09cad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAETzvWcC/33NTQ7CIBAF4KsY1mL4bcGV9zAuKgwt0YABQzRN7
 y7tRo2Ny/cy75sRZUgeMtpvRpSg+OxjqEFsN8gMXegBe1szYoRJQqnE5+RtbU0MAcw9Juw0p1o
 Aa1rnUJ3dEjj/WMjjqebB53r2XD4UOrd/sEIxwbpjDoxVqumawwVSgOsuph7NWmFvgRGxIrAqc
 GltYxQXQNSPwD8EylcEXgVoqdTKCW2U+xKmaXoBvf27cDUBAAA=
X-Change-ID: 20250115-bridge-connector-f93194e267ff
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: Herve Codina <herve.codina@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Simona Vetter <simona.vetter@ffwll.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8313; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Ql5s9tXR9G/woA8eFE6vmrVxYTCWBGMKz7pHTDWcxpI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOl7P3u1PeZ13xHU+uXDpQnLI3zdGpSuPr7s7d5xm9d5+
 7HlAYWHO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEZt1jbFiud331jbVln3XT
 3JK7iuKkVt90+NN00j/guqm0xDnuiaqasouzmvUPB/2SOHzpT6fcP8Y6m8Maq4sM1598s07lode
 iec9z5skcS7/6Y2PXxOPZp21vtrzunXj85cnGUl09buEDtcfiAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Hi,

Here's a series of changes after to the KMS helpers and bridge API
following a bunch of reviews I did.

It's mostly centered across providing an easier time to deal with bridge
states, and a somewhat consistent with the other entities API.

It's build tested only, with arm64 allmodconfig.

Maxime

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Changes in v4:
- Rebased on top of drm-misc-next-2025-02-20
- Changed the approach to helpers suggested by Sima, dropped the tags
  affected by the rework
- Drop drm_bridge_state->crtc and connector fields
- Drop drm_bridge->encoder deprecation
- Introduced kunit tests
- Link to v3: https://lore.kernel.org/r/20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org

Changes in v3:
- Add tags
- Fix compilation breakages
- Reword some commit messages
- Create drm_bridge_is_atomic() helper
- Retrieve the CRTC state through drm_atomic_get_new_crtc_state()
  instead of crtc->state in bridges
- Fix ti-sn65dsi86
- Link to v2: https://lore.kernel.org/r/20250204-bridge-connector-v2-0-35dd6c834e08@kernel.org

Changes in v2:
- Pass the full atomic state to bridge atomic hooks
- Make attach take the encoder as a parameter
- Mark bridge->encoder as deprecated
- Rework the logic to detect if a bridge uses a state or not at
  atomic_check time
- Add lockdep assertion to drm_bridge_get_current_state()
- Link to v1: https://lore.kernel.org/r/20250115-bridge-connector-v1-0-9a2fecd886a6@kernel.org

---
Maxime Ripard (15):
      drm/bridge: Add encoder parameter to drm_bridge_funcs.attach
      drm/bridge: Provide a helper to retrieve current bridge state
      drm/tests: Add kunit tests for bridges
      drm/atomic: Introduce helper to lookup connector by encoder
      drm/tests: helpers: Create new helper to enable output
      drm/tests: Create tests for drm_atomic
      drm/bridge: Add helper to reset bridge pipeline
      drm/tests: bridge: Provide tests for drm_bridge_reset_crtc
      drm/bridge: ti-sn65dsi83: Switch to drm_bridge_reset_crtc
      drm/bridge: Introduce drm_bridge_is_atomic() helper
      drm/bridge: cdns-csi: Switch to atomic helpers
      drm/bridge: tc358775: Switch to atomic commit
      drm/bridge: tc358768: Stop disabling when failing to enable
      drm/bridge: tc358768: Convert to atomic helpers
      drm/bridge: ti-sn65dsi86: Use bridge_state crtc pointer

 drivers/gpu/drm/Kconfig                            |   1 +
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |   3 +-
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c |   3 +-
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c |   3 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |   2 +-
 drivers/gpu/drm/bridge/analogix/anx7625.c          |   3 +-
 drivers/gpu/drm/bridge/aux-bridge.c                |   3 +-
 drivers/gpu/drm/bridge/aux-hpd-bridge.c            |   1 +
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c     |  34 +-
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    |   1 +
 drivers/gpu/drm/bridge/chipone-icn6211.c           |   6 +-
 drivers/gpu/drm/bridge/chrontel-ch7033.c           |   5 +-
 drivers/gpu/drm/bridge/display-connector.c         |   1 +
 drivers/gpu/drm/bridge/fsl-ldb.c                   |   3 +-
 drivers/gpu/drm/bridge/imx/imx-ldb-helper.c        |   7 +-
 drivers/gpu/drm/bridge/imx/imx-ldb-helper.h        |   2 +-
 drivers/gpu/drm/bridge/imx/imx-legacy-bridge.c     |   3 +-
 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c       |   3 +-
 .../gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c    |   3 +-
 drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c    |   3 +-
 drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c       |   3 +-
 drivers/gpu/drm/bridge/ite-it6263.c                |   7 +-
 drivers/gpu/drm/bridge/ite-it6505.c                |   1 +
 drivers/gpu/drm/bridge/ite-it66121.c               |   3 +-
 drivers/gpu/drm/bridge/lontium-lt8912b.c           |   3 +-
 drivers/gpu/drm/bridge/lontium-lt9211.c            |   3 +-
 drivers/gpu/drm/bridge/lontium-lt9611.c            |   3 +-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c         |   3 +-
 drivers/gpu/drm/bridge/lvds-codec.c                |   3 +-
 .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |   1 +
 drivers/gpu/drm/bridge/microchip-lvds.c            |   3 +-
 drivers/gpu/drm/bridge/nwl-dsi.c                   |   3 +-
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |   5 +-
 drivers/gpu/drm/bridge/panel.c                     |   3 +-
 drivers/gpu/drm/bridge/parade-ps8622.c             |   1 +
 drivers/gpu/drm/bridge/parade-ps8640.c             |   3 +-
 drivers/gpu/drm/bridge/samsung-dsim.c              |   3 +-
 drivers/gpu/drm/bridge/sii902x.c                   |   5 +-
 drivers/gpu/drm/bridge/sil-sii8620.c               |   1 +
 drivers/gpu/drm/bridge/simple-bridge.c             |   5 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |   3 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |   5 +-
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c     |   5 +-
 drivers/gpu/drm/bridge/tc358762.c                  |   3 +-
 drivers/gpu/drm/bridge/tc358764.c                  |   3 +-
 drivers/gpu/drm/bridge/tc358767.c                  |   2 +
 drivers/gpu/drm/bridge/tc358768.c                  |  41 ++-
 drivers/gpu/drm/bridge/tc358775.c                  |  45 ++-
 drivers/gpu/drm/bridge/tda998x_drv.c               |   1 +
 drivers/gpu/drm/bridge/thc63lvd1024.c              |   3 +-
 drivers/gpu/drm/bridge/ti-dlpc3433.c               |   4 +-
 drivers/gpu/drm/bridge/ti-sn65dsi83.c              |  29 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |  61 ++--
 drivers/gpu/drm/bridge/ti-tdp158.c                 |   6 +-
 drivers/gpu/drm/bridge/ti-tfp410.c                 |   5 +-
 drivers/gpu/drm/bridge/ti-tpd12s015.c              |   3 +-
 drivers/gpu/drm/drm_atomic.c                       |  45 +++
 drivers/gpu/drm/drm_bridge.c                       |  55 ++-
 drivers/gpu/drm/imx/ipuv3/parallel-display.c       |   3 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |   5 +-
 drivers/gpu/drm/mcde/mcde_dsi.c                    |   3 +-
 drivers/gpu/drm/mediatek/mtk_dp.c                  |   3 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c                 |   3 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |   3 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |   3 +-
 drivers/gpu/drm/meson/meson_encoder_cvbs.c         |   3 +-
 drivers/gpu/drm/meson/meson_encoder_dsi.c          |   3 +-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c         |   3 +-
 drivers/gpu/drm/msm/dsi/dsi_manager.c              |   3 +-
 drivers/gpu/drm/omapdrm/dss/dpi.c                  |   3 +-
 drivers/gpu/drm/omapdrm/dss/dsi.c                  |   3 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c                |   3 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5.c                |   3 +-
 drivers/gpu/drm/omapdrm/dss/sdi.c                  |   3 +-
 drivers/gpu/drm/omapdrm/dss/venc.c                 |   3 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c        |   3 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c    |   3 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c     |   3 +-
 drivers/gpu/drm/stm/lvds.c                         |  11 +-
 drivers/gpu/drm/tests/Makefile                     |   2 +
 drivers/gpu/drm/tests/drm_atomic_test.c            | 153 +++++++++
 drivers/gpu/drm/tests/drm_bridge_test.c            | 376 +++++++++++++++++++++
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 151 +++++----
 drivers/gpu/drm/tests/drm_kunit_helpers.c          |  61 ++++
 drivers/gpu/drm/tidss/tidss_encoder.c              |   3 +-
 drivers/gpu/drm/vc4/vc4_dsi.c                      |   3 +-
 drivers/gpu/drm/xlnx/zynqmp_dp.c                   |   3 +-
 drivers/platform/arm64/acer-aspire1-ec.c           |   3 +-
 include/drm/drm_atomic.h                           |   3 +
 include/drm/drm_bridge.h                           |  36 +-
 include/drm/drm_kunit_helpers.h                    |   8 +
 91 files changed, 1107 insertions(+), 239 deletions(-)
---
base-commit: e82e1a0c22d841f379b1c768469dcdaae650e443
change-id: 20250115-bridge-connector-f93194e267ff

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>


