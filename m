Return-Path: <linux-kernel+bounces-447203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A85729F2EDA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFEF41646AB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8412C20409D;
	Mon, 16 Dec 2024 11:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZhzC6qHG"
Received: from mail-m127216.xmail.ntesmail.com (mail-m127216.xmail.ntesmail.com [115.236.127.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB93A937;
	Mon, 16 Dec 2024 11:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734347365; cv=none; b=Nn/vU4ZSNPqu28E3+1AG9a7mqJ1F8Ryi3eThF8iNu4rS0bCAGfgFvTf5Q1tTLu2Fi9zaq6s46ZUygq6Ed/NKl1o7RnuWSIjUOJNYSbuIes5hF6G33H5F7zPuxEaq8b7R2jx41iYhud3F90lz0ceUAd2mqAycL6F3Ef8KKawpyJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734347365; c=relaxed/simple;
	bh=ODKfcwmfkvNLixN1R9MjPgEQxl8cWfkw8euVtvBwgts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o4FZaVPToXbt1dmLdk/SWBI1+Fn9Tqn+uwAcRJYIfjS5f/muXQf0MiuWARu6/TePj/w5TDx/cvhAjcuCecVtl7FhR1fLvo6yX9kiFezeqQwni5gmG4WYNARj7mL9MCoJ06ig+oKgJEZzq6C+j6C7BfsG1YsWsU+5J5R2w9SLZI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ZhzC6qHG; arc=none smtp.client-ip=115.236.127.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5cf798e4;
	Mon, 16 Dec 2024 11:12:49 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rfoss@kernel.org,
	vkoul@kernel.org,
	sebastian.reichel@collabora.com,
	cristian.ciocaltea@collabora.com,
	l.stach@pengutronix.de,
	andy.yan@rock-chips.com,
	hjc@rock-chips.com,
	algea.cao@rock-chips.com,
	kever.yang@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v2 00/11] Add eDP support for RK3588
Date: Mon, 16 Dec 2024 11:12:14 +0800
Message-Id: <20241216031225.3746-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkpIQlYZTh0aT0pNTU9KTx5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a93cd74447103a3kunm5cf798e4
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MjY6KCo*ETIOOiE3IkkuOkJC
	EDgKCz5VSlVKTEhPSEpDTExLQklCVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIS0hPNwY+
DKIM-Signature:a=rsa-sha256;
	b=ZhzC6qHGZugNVUqcivPYv1YqhzbM3UCNRCCZsz4iWDUnQg5Kts3lzwPuEzxroF5EBXOlp8Zv7WdpQFcRiFlt5Wm0JVN2EVDvLyjohIAI6Fpr/lJyqcLeUN9pOwkIGunY1rel+58GqOZg472n84C7hXumEyd8fX3uNGD0N/T2MSk=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=rUCWRvoR1sxRJW3v0+Hu9l9AL/ZRjPragwtHsxtbGkA=;
	h=date:mime-version:subject:message-id:from;

These patchs have been tested with a 1536x2048p60 eDP panel on
RK3588S EVB1 board, and HDMI 1080P/4K display also has been verified
on RK3588 EVB1 board.

Patch 1~3 are the RK3588 eDP support of Rockchip analogix_dp driver.
Patch 4   is the eDP mode support of samsung hdptx phy driver.
Patch 5~6 are the Rk3588 eDP support of Aanalogix DP driver. Add phy
          interfaces is to configure the HDMI/eDP TX Combo PHY.
Patch 7~8 are the renaming of hdptxphy node. It is not only used by
          HDMI display but also for the eDP display.
Patch 9   is the addition of RK3588 eDP0 node.
Patch 10  is to enable the eDP0 display on RK3588S EVB1 board.
Patch 11  is to add the eDP1 related nodes for RK3588 SoC.

Damon Ding (11):
  drm/rockchip: analogix_dp: Use formalized struct definition for grf
    field
  dt-bindings: display: rockchip: analogix-dp: Add support for RK3588
  drm/rockchip: analogix_dp: Add support for RK3588
  phy: phy-rockchip-samsung-hdptx: Add support for eDP mode
  drm/bridge: analogix_dp: add support for RK3588
  drm/bridge: analogix_dp: Add support for phy configuration.
  dt-bindings: display: rockchip: Fix label name of hdptxphy for RK3588
    HDMI TX Controller
  arm64: dts: rockchip: Fix label name of hdptxphy for RK3588
  arm64: dts: rockchip: Add eDP0 node for RK3588
  arm64: dts: rockchip: Enable eDP0 display on RK3588S EVB1 board
  arm64: dts: rockchip: Add nodes related to eDP1 for RK3588

 .../rockchip/rockchip,analogix-dp.yaml        |   1 +
 .../rockchip/rockchip,rk3588-dw-hdmi-qp.yaml  |   2 +-
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |  33 +-
 .../dts/rockchip/rk3588-coolpi-cm5-evb.dts    |   2 +-
 .../rockchip/rk3588-coolpi-cm5-genbook.dts    |   2 +-
 .../boot/dts/rockchip/rk3588-evb1-v10.dts     |   2 +-
 .../arm64/boot/dts/rockchip/rk3588-extra.dtsi |  55 +
 .../rk3588-friendlyelec-cm3588-nas.dts        |   2 +-
 .../arm64/boot/dts/rockchip/rk3588-jaguar.dts |   2 +-
 .../boot/dts/rockchip/rk3588-nanopc-t6.dtsi   |   2 +-
 .../dts/rockchip/rk3588-orangepi-5-plus.dts   |   2 +-
 .../boot/dts/rockchip/rk3588-rock-5b.dts      |   2 +-
 .../boot/dts/rockchip/rk3588-tiger-haikou.dts |   2 +-
 .../boot/dts/rockchip/rk3588s-coolpi-4b.dts   |   2 +-
 .../boot/dts/rockchip/rk3588s-evb1-v10.dts    |  50 +
 .../dts/rockchip/rk3588s-indiedroid-nova.dts  |   2 +-
 .../boot/dts/rockchip/rk3588s-nanopi-r6.dtsi  |   2 +-
 .../boot/dts/rockchip/rk3588s-odroid-m2.dts   |   2 +-
 .../boot/dts/rockchip/rk3588s-orangepi-5.dtsi |   2 +-
 .../boot/dts/rockchip/rk3588s-rock-5a.dts     |   2 +-
 .../boot/dts/rockchip/rk3588s-rock-5c.dts     |   2 +-
 .../drm/bridge/analogix/analogix_dp_core.c    |   5 +
 .../gpu/drm/bridge/analogix/analogix_dp_reg.c |  56 ++
 .../gpu/drm/rockchip/analogix_dp-rockchip.c   | 149 ++-
 .../phy/rockchip/phy-rockchip-samsung-hdptx.c | 937 +++++++++++++++++-
 include/drm/bridge/analogix_dp.h              |   3 +-
 26 files changed, 1223 insertions(+), 100 deletions(-)

-- 
2.34.1


