Return-Path: <linux-kernel+bounces-527703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43931A40E4F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 12:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2971C3BBF3E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA78206F13;
	Sun, 23 Feb 2025 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JBCxw3IM"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894A1204F6C;
	Sun, 23 Feb 2025 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740310285; cv=none; b=Pzacdr1opljspkxLnHsSuN/PwijMr6trsu0OBC2aWPdJz/HcjRvBa4NWh6f+MPSsX3DEEFWNKVYqXsofwmmbhsmma3miaGnvciHO0PU+L+Kr2P1imG3duB6VJ4HSUzcxMPqCerR9kSiF1UWFPo0AvogFjw4fm284piMvatTNsEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740310285; c=relaxed/simple;
	bh=/LD8G4Ol/NVYWej5Ymg5XYCfSY4cK+1mfFzam5bxKF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hFu5ghzBssPKXCPQ2e4qHaHq14BmOufhT3PB144UHzDtdnju7ZOrqWlQth5PtWGgkGolB44ujB1w7Nh19f6EfBQ4v1QfjRbg50HeEvZ/UM8g9xji6fgKNl+8YUX17MdzV+X6aYyrqzpBN9eYjncgSz813Whv9dw/kSnKW75pUnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JBCxw3IM; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=azLeyf2xC4uh93jZO6CQCigHAVXnNrkCBQPDkD3e1Tg=;
	b=JBCxw3IMHEjmkAbdWSPa6aNuVY073ScWKpqbpR8TjwohgVbhz0Zxfhf8U3pm4t
	NSwYSM8uXgjWinpoyGDZGEwwEy1uhzxAk/oykFm6ZyIMp/m8t6uaMapx9a4BpxWo
	AFJtoKdJqeh1+Gv79a98XsKOMxY4ufPgb+CxxuxkhMR4s=
Received: from ProDesk.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBHWqbdBrtnleHpAg--.47651S2;
	Sun, 23 Feb 2025 19:30:41 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	mripard@kernel.org,
	cristian.ciocaltea@collabora.com,
	neil.armstrong@linaro.org,
	yubing.zhang@rock-chips.com,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org,
	sebastian.reichel@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH 0/6] Add support for RK3588 DisplayPort Controller
Date: Sun, 23 Feb 2025 19:30:23 +0800
Message-ID: <20250223113036.74252-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBHWqbdBrtnleHpAg--.47651S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1fKF18CryfAr17JrW7CFg_yoW8KrWxpa
	nrAFy5try8GFWaqrZ2kF1DCrZ3A3Z2yayrKws7J3sFqrn2kFyDCrnxCFsxXr9rGF17AFyI
	9rsxX34xGr42qF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UvD7-UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBkBD8Xme7AH88NgABsK

From: Andy Yan <andy.yan@rock-chips.com>


There are two DW DPTX based DisplayPort Controller on rk3588 which
are compliant with the DisplayPort Specification Version 1.4 with
the following features:

* DisplayPort 1.4a
* Main Link: 1/2/4 lanes
* Main Link Support 1.62Gbps, 2.7Gbps, 5.4Gbps and 8.1Gbps
* AUX channel 1Mbps
* Single Stream Transport(SST)
* Multistream Transport (MST)
*Type-C support (alternate mode)
* HDCP 2.2, HDCP 1.3
* Supports up to 8/10 bits per color component
* Supports RBG, YCbCr4:4:4, YCbCr4:2:2, YCbCr4:2:0
* Pixel clock up to 594MHz
* I2S, SPDIF audio interface

The current version of this patch series only supports basic display outputs.
I conducted tests in 1080p and 4K@60 YCbCr4:2:0 modes; the ALT/Type-C mode
hasn't been tested yet, but I suspect it will likely work. HDCP and audio
features remain unimplemented. For RK3588, it's only support SST, while in
the upcoming RK3576, it can support MST output.


Andy Yan (6):
  dt-bindings: display: rockchip: Add schema for RK3588 DPTX Controller
  drm/bridge: synopsys: Add DW DPTX Controller support library
  drm/rockchip: Add RK3588 DPTX output support
  arm64: dts: rockchip: Add DP0 for rk3588
  arm64: dts: rockchip: Add DP1 for rk3588
  arm64: dts: rockchip: Enable DisplayPort for rk3588s Cool Pi 4B

 .../display/rockchip/rockchip,dw-dp.yaml      |  150 ++
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |   30 +
 .../arm64/boot/dts/rockchip/rk3588-extra.dtsi |   30 +
 .../boot/dts/rockchip/rk3588s-coolpi-4b.dts   |   37 +
 drivers/gpu/drm/bridge/synopsys/Kconfig       |    7 +
 drivers/gpu/drm/bridge/synopsys/Makefile      |    1 +
 drivers/gpu/drm/bridge/synopsys/dw-dp.c       | 2155 +++++++++++++++++
 drivers/gpu/drm/rockchip/Kconfig              |    7 +
 drivers/gpu/drm/rockchip/Makefile             |    1 +
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c     |  162 ++
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |    1 +
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h   |    1 +
 include/drm/bridge/dw_dp.h                    |   19 +
 13 files changed, 2601 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml
 create mode 100644 drivers/gpu/drm/bridge/synopsys/dw-dp.c
 create mode 100644 drivers/gpu/drm/rockchip/dw_dp-rockchip.c
 create mode 100644 include/drm/bridge/dw_dp.h

-- 
2.34.1


