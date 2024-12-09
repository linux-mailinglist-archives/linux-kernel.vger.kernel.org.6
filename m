Return-Path: <linux-kernel+bounces-438543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF139EA27C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FBAC1664C9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F059019F43A;
	Mon,  9 Dec 2024 23:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="m9Vpyjm4"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A5E19EEB4;
	Mon,  9 Dec 2024 23:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733785874; cv=none; b=XSMReMOAhZDncuxzoYHjT4BE9sg6uN9G2WrMev4XhKiDxm0pISTXeQosa+SxRb2tGfgB5nxmkRSSC/UO8kyysFVTFd/I42ugW8ovPGEptHwX661zGgXCTZ05SqcQ+pysXfr5w9r2uGomEGYuVeUeZAyyT+yeu5A0WWnhygfcaOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733785874; c=relaxed/simple;
	bh=fur/IfXdA0UDSKl37YXOzmS9r/B6EZdOg4tFp1Y9iZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XN4XO51l52dbjl/eZc++3dSt2LH3lgkWK0+IBldAOWIPg4MPX2+fL7YoSEmhyfx6eIPGQK/9Mzwjb0E/yReSCt618ZLBfNSimSvWqmHIuxBd4uE91+FEA+5+jR2L9ap67L1ULmdTP6T+5KEGZwpugsoQM59LAEmYLfJ6WyV83Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=m9Vpyjm4; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8nQmkHAbwxQl1T/Kw4A2hwy2MJmGRj9oZcS+awgb4Gk=; b=m9Vpyjm4A7yCco/EItYeeAYaBS
	KNTUOD7wzwb6HUqPN8C/2AVPT18GyP06DkxOt/V4hhWl7kZKiisskvX5HKb4BIF3LQ5+xsTrhpryu
	PCLSQ4EM93PKTPHOOldWRUygZsfyMf8AdaDM+UB9aaq+J0NiMh5Rbs7v91H5RVMPuH1+gFGJdQ467
	/z4iVammCFdMWBoMhmdfBkox6wcX75y2wTGLHZW77DVJkUN0gJ3Gy8lQr728WZXpbL9DE3IJz3RSB
	A7RrSyfxHyhs03+ZOwpyCO0eRtZoCReirZ4tc7N/3G62NDMC7ypcgp7BxMJ0c5HBK5/vWjenA0sgx
	LpcU6AUg==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tKmtc-0005Ev-0o; Tue, 10 Dec 2024 00:10:32 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de
Subject: [PATCH v4 0/3] drm/rockchip: Add driver for the new DSI2 controller
Date: Tue, 10 Dec 2024 00:10:18 +0100
Message-ID: <20241209231021.2180582-1-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a bridge and glue driver for the DSI2 controller found
in the rk3588 soc from Rockchip, that is based on a Synopsis IP block.

As the manual states:
The Display Serial Interface 2 (DSI-2) is part of a group of communication
protocols defined by the MIPI Alliance. The MIPI DSI-2 Host Controller is
a digital core that implements all protocol functions defined in the
MIPI DSI-2 Specification.


While the driver structure is very similar to the previous DSI controller,
the programming model of the core is quite different, with a completely
new register set.

Another notable difference is that the phy interface is variable now too
in its width and some other settings.

changes in v4:
- Update binding example to use phy-type argument
- Update commit description to use correctly spelled Synopsys
- use devm_pm_runtime_enable()
- drop pclk+sys_clk handling from the Rockchip glue-driver
  (the bridge does that for us already)

changes in v3:
- remove double-empty line in bridge part (Neil)
- add bitfield.h to both bridge and glue for FIELD_PROP
  (reported by kernel test robot)
- add Neil's Reviewed-by to bridge part
- add Rob's Reviewed-by to binding

changes in v2:
- clean up includes (Diederik)
- fix Kconfig description (Diederik)
- constant naming (Diederik)
- binding fixes (paths, sorting, labels) (Rob)
- move to use regmap
- drop custom UPDATE macro and use FIELD_PREP instead
- use dev_err instead of DRM_DEV_ERROR

Heiko Stuebner (3):
  drm/bridge/synopsys: Add MIPI DSI2 host controller bridge
  dt-bindings: display: rockchip: Add schema for RK3588 DW DSI2
    controller
  drm/rockchip: Add MIPI DSI2 glue driver for RK3588

 .../rockchip/rockchip,rk3588-mipi-dsi2.yaml   |  120 ++
 drivers/gpu/drm/bridge/synopsys/Kconfig       |    6 +
 drivers/gpu/drm/bridge/synopsys/Makefile      |    1 +
 .../gpu/drm/bridge/synopsys/dw-mipi-dsi2.c    | 1030 +++++++++++++++++
 drivers/gpu/drm/rockchip/Kconfig              |   10 +
 drivers/gpu/drm/rockchip/Makefile             |    1 +
 .../gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c  |  487 ++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |    2 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h   |    1 +
 include/drm/bridge/dw_mipi_dsi2.h             |   95 ++
 10 files changed, 1753 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-mipi-dsi2.yaml
 create mode 100644 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
 create mode 100644 drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
 create mode 100644 include/drm/bridge/dw_mipi_dsi2.h

-- 
2.45.2


