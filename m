Return-Path: <linux-kernel+bounces-423659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD3A9DAB03
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1149B21210
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA30200117;
	Wed, 27 Nov 2024 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="DrsNEaPa"
Received: from mail-m12799.qiye.163.com (mail-m12799.qiye.163.com [115.236.127.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9361FF7B6;
	Wed, 27 Nov 2024 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732722566; cv=none; b=Tbgd/56VQKInSBVCJ2qlI3fIhTRA5yt4Sr+rfm4wVewaEO/22Dt+INeILp0DNQGospg9ddqpXKTS044aMKR+FbW2Yb6zbibVj/scsMlYUPlO+Ta0gCC4Y3ewK4+3nbIA9KPIH1ScPOuQcaWYkJCaNtfSsSIsXuoUOMojKctN/+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732722566; c=relaxed/simple;
	bh=DIxUbJfodRePu5Sh4n+JF6byg4rZzzvKjhIGfa5pCuU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a6iHg/e5WbEX/FdGI+TpRRZfYNW1YtFnBwY8s08BYJg6g717DQefPRxuRmE4EV3Em+ZhaUo0pXLbWBbqP6ftPfm3EcN4BOrjWS3J721osjn+p+5XkpdbBVvJ7dNOR4G7M4JckXCL119Q2Xx+UX3nGS3NGqbbWmYzVgDagNauSTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=DrsNEaPa; arc=none smtp.client-ip=115.236.127.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3f86cd6b;
	Wed, 27 Nov 2024 15:52:49 +0800 (GMT+08:00)
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
Subject: [PATCH v1 00/10] Add eDP support for RK3588
Date: Wed, 27 Nov 2024 15:51:47 +0800
Message-Id: <20241127075157.856029-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh5LQ1ZKGhoaQkkeSR5NTRpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a936c9bcbb803a3kunm3f86cd6b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M0k6Qxw6STIjCS9CLwJLTR0d
	SAkwCUhVSlVKTEhJTUJIQkxKTUhPVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQkpPNwY+
DKIM-Signature:a=rsa-sha256;
	b=DrsNEaPaYgr1HW/MTl00CQnNBm8VDBvfgHCJv8Usqq45qIkkCQPPbJdAgVdC3OwVHMFyy6bTBM4aVqtVHhD8YzpqJQ7tbXqGdR9DlEt25/ZaoFudD2b33/lpP59HkUKUfcVZVA18V+IHcDnh2w65XXDbDcRbzT+I8cphm7wytjQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=CcgRIo+XJmQI6DQwJ0KECoH/PzQlSX6iB9aios6JJS0=;
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

Damon Ding (10):
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
  arch64: dts: rockchip: Enable eDP0 display on RK3588S EVB1 board

 .../rockchip/rockchip,analogix-dp.yaml        |   1 +
 .../rockchip/rockchip,rk3588-dw-hdmi-qp.yaml  |   2 +-
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |  33 +-
 .../dts/rockchip/rk3588-coolpi-cm5-evb.dts    |   2 +-
 .../rockchip/rk3588-coolpi-cm5-genbook.dts    |   2 +-
 .../boot/dts/rockchip/rk3588-evb1-v10.dts     |   2 +-
 .../rk3588-friendlyelec-cm3588-nas.dts        |   2 +-
 .../arm64/boot/dts/rockchip/rk3588-jaguar.dts |   2 +-
 .../boot/dts/rockchip/rk3588-nanopc-t6.dtsi   |   2 +-
 .../dts/rockchip/rk3588-orangepi-5-plus.dts   |   2 +-
 .../boot/dts/rockchip/rk3588-rock-5b.dts      |   2 +-
 .../boot/dts/rockchip/rk3588-tiger-haikou.dts |   2 +-
 .../boot/dts/rockchip/rk3588s-coolpi-4b.dts   |   2 +-
 .../boot/dts/rockchip/rk3588s-evb1-v10.dts    |  84 ++
 .../dts/rockchip/rk3588s-indiedroid-nova.dts  |   2 +-
 .../boot/dts/rockchip/rk3588s-nanopi-r6.dtsi  |   2 +-
 .../boot/dts/rockchip/rk3588s-odroid-m2.dts   |   2 +-
 .../boot/dts/rockchip/rk3588s-orangepi-5.dtsi |   2 +-
 .../boot/dts/rockchip/rk3588s-rock-5a.dts     |   2 +-
 .../boot/dts/rockchip/rk3588s-rock-5c.dts     |   2 +-
 .../drm/bridge/analogix/analogix_dp_core.c    |   8 +-
 .../drm/bridge/analogix/analogix_dp_core.h    |   2 +
 .../gpu/drm/bridge/analogix/analogix_dp_reg.c |  90 ++
 .../gpu/drm/rockchip/analogix_dp-rockchip.c   | 112 ++-
 .../phy/rockchip/phy-rockchip-samsung-hdptx.c | 936 +++++++++++++++++-
 include/drm/bridge/analogix_dp.h              |   3 +-
 26 files changed, 1206 insertions(+), 97 deletions(-)

-- 
2.34.1


