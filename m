Return-Path: <linux-kernel+bounces-528382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6F1A41722
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 186257A4D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF1D1547E3;
	Mon, 24 Feb 2025 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Hvi2x/xI"
Received: from mail-m1973187.qiye.163.com (mail-m1973187.qiye.163.com [220.197.31.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ABF11187;
	Mon, 24 Feb 2025 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740385151; cv=none; b=NMf7Yz3R6S7qJCaI2YG6r8JQvy/UXWd+x+IauckW0V1M9Rx7LeEGCe9jkxV8YkT47k2Rob9PDIFE2FItxeyinvi+lNTYnw8ttZ7UEfip3/lRVZfpxN28CW4Cqycuxk5uq6iIzWCeG0Qjsx//cjopRbFRK0zZgcChXd7oqUOe3MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740385151; c=relaxed/simple;
	bh=zLuZ+z8Aa4U8goIl5hZ8lIxIcB/+zP1h1wQw5Xfgd7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nWm48YL7JiKImzSWlWqnnQafPjSQaFJnW4KcI91JBoEK1IZzNr2SnpkLBxUnma9DOaygXeBxS1GBta/CFCRQ056OFsQsNF8e0EtK58g+YSVst53PbfVdToBP4mHwPKiZk2r+ovJP+IiSQ+JCMm1cd9qwrZx7y1twOuDI4JdX468=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Hvi2x/xI; arc=none smtp.client-ip=220.197.31.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id bfd28778;
	Mon, 24 Feb 2025 16:13:54 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: heiko@sntech.de
Cc: andy.yan@rock-chips.com,
	hjc@rock-chips.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	dmitry.baryshkov@linaro.org,
	dianders@chromium.org,
	sebastian.reichel@collabora.com,
	cristian.ciocaltea@collabora.com,
	boris.brezillon@collabora.com,
	l.stach@pengutronix.de,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v7 00/15] Add eDP support for RK3588
Date: Mon, 24 Feb 2025 16:13:10 +0800
Message-Id: <20250224081325.96724-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU0dHlZMHkNPGkpNGUpKQktWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a95370514af03a3kunmbfd28778
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORA6Mhw5FTIXHRMWGDwtETBR
	HhgaCglVSlVKTE9LSENPQ0hNTEtNVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJT09JNwY+
DKIM-Signature:a=rsa-sha256;
	b=Hvi2x/xIm/hiJkL1YeZk7qEBq3qJjxVlm2s6qU+dKNb18pWP/cGH9a5fsw9coIF3IfFeTc+WQar86Ck13J06Xxs4jMdIKCRZLr4OwZFiKqE+FlXEQtgetapjDUaWEuT57H/dLzU8SKZom/UTyokevARgSmIC+6Geh1sjoWmJq5s=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=owN4Uvb9g/wwDNXDyBtx8Lfi2w2RRbPY42uBD7u7orc=;
	h=date:mime-version:subject:message-id:from;

Picked from:
https://patchwork.kernel.org/project/linux-rockchip/list/?series=927765

These patchs have been tested with a 1536x2048p60 eDP panel on
RK3588S EVB1 board, and HDMI 1080P/4K display also has been verified
on RK3588 EVB1 board. Furthermore, the eDP display has been rechecked
on RK3399 sapphire excavator board.

Patch 1~6   are preparations for the RK3588 eDP support on both Analogix
            side and Rockchip side.
Patch 7~10  are to support to get panel from the DP AUX bus.
Patch 11~13 are the RK3588 Analogix DP driver support.
Patch 14    is the addition of RK3588 eDP0 node.
Patch 15    is to enable the eDP0 display on RK3588S EVB1 board.

Damon Ding (15):
  drm/rockchip: analogix_dp: Use formalized struct definition for grf
    field
  drm/rockchip: analogix_dp: Expand device data to support multiple edp
    display
  drm/bridge: analogix_dp: Add irq flag IRQF_NO_AUTOEN instead of
    calling disable_irq()
  drm/bridge: analogix_dp: Remove the unnecessary calls to
    clk_disable_unprepare() during probing
  drm/bridge: analogix_dp: Remove CONFIG_PM related check in
    analogix_dp_bind()/analogix_dp_unbind()
  drm/bridge: analogix_dp: Add support for phy configuration.
  dt-bindings: display: rockchip: analogix-dp: Add support to get panel
    from the DP AUX bus
  drm/bridge: analogix_dp: Support to get &analogix_dp_device.plat_data
    and &analogix_dp_device.aux
  drm/bridge: analogix_dp: Add support to get panel from the DP AUX bus
  drm/rockchip: analogix_dp: Add support to get panel from the DP AUX
    bus
  dt-bindings: display: rockchip: analogix-dp: Add support for RK3588
  drm/bridge: analogix_dp: Add support for RK3588
  drm/rockchip: analogix_dp: Add support for RK3588
  arm64: dts: rockchip: Add eDP0 node for RK3588
  arm64: dts: rockchip: Enable eDP0 display on RK3588S EVB1 board

 .../rockchip/rockchip,analogix-dp.yaml        |  25 ++-
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |  28 +++
 .../boot/dts/rockchip/rk3588s-evb1-v10.dts    |  55 +++++
 .../drm/bridge/analogix/analogix_dp_core.c    |  99 +++++----
 .../gpu/drm/bridge/analogix/analogix_dp_reg.c |  52 +++++
 drivers/gpu/drm/rockchip/Kconfig              |   1 +
 .../gpu/drm/rockchip/analogix_dp-rockchip.c   | 206 ++++++++++++++----
 include/drm/bridge/analogix_dp.h              |   7 +-
 8 files changed, 380 insertions(+), 93 deletions(-)

-- 
2.34.1


