Return-Path: <linux-kernel+bounces-270527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF43F9440F8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 04:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8313F1F28421
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07AF1428E9;
	Thu,  1 Aug 2024 02:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JVXAorcy"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2F014264A;
	Thu,  1 Aug 2024 02:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722477979; cv=none; b=WgUuuwxPWKWpR17J8tnfSg6926wSq88P16Vad2S2+LRM0vKMJ1Mh1uDT/z2ts606m0zB8EDURwojAd7LQ4Sw9CfgmonGxhZsxa11JlUeM8F5WKiLM3uipknfd9WdtvJLkyMnWqDrx0evu6CRKzq8vcj9RVEIIVcP0qo7eLZYyMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722477979; c=relaxed/simple;
	bh=8ac2r6zPKGWSHuh+tztXRaB0ZOzFaDNys78QgSc5GpQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KzH+2IBRcf6xrHOFcXKxeOGMIpIKZ4XMRByMCZqlWgu4Kkw0uJidlkRULwmAaH7Tf4xDgZ39no+l88ocaaJdlg5O4O4LMQVJWsj2Q0XX8Rx3JWcagXwE0TZ4T4OD/XL8LaL1ts+ivlYADDCNM8QWmSH5sZ2a62tdl3tGPcTv1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JVXAorcy; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722477973;
	bh=8ac2r6zPKGWSHuh+tztXRaB0ZOzFaDNys78QgSc5GpQ=;
	h=From:Subject:Date:To:Cc:From;
	b=JVXAorcyrS7ElLGDbx4UY8CBn5IOFXY75Y03rOjYsrxkbEgX5R/5y06idDTEZbrqd
	 myr2PvY8DUVOw+BrDhLveWANdg3ch4nNkRFNldVXviCXB0ZNztQOBGCGd5FK5lRSGn
	 Plcp+yjbouRtQE7oZbfH+8ybOJd1qlS6a3GnGdwkdHzmNMfTC8sUo2B3WcT7xBaSJR
	 H++RhyUvfteit7MSF2DP6Ci8ncvxS/ikbHqQEGBCI27PTvsdSdXG18waE2n7ydNatC
	 9a3YwTTLEd+2CLQQwwW5MztS+ub3s91febTskdQ7kcGMfjHwGzJkHohJQYhg63GLE0
	 4UQoxy+gnIgjA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 06B003780BDB;
	Thu,  1 Aug 2024 02:06:13 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 0/2] Initial support for Synopsys DW HDMI QP TX Controller
Date: Thu, 01 Aug 2024 05:05:13 +0300
Message-Id: <20240801-dw-hdmi-qp-tx-v1-0-148f542de5fd@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFrtqmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCwND3ZRy3YyU3EzdwgLdkgpdSxNjS0sjc2NDU3MDJaCegqLUtMwKsHn
 RsbW1AG+VgSlfAAAA
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Alexandre ARNOUD <aarnoud@me.com>, 
 Luis de Arquer <ldearquer@gmail.com>, Algea Cao <algea.cao@rock-chips.com>
X-Mailer: b4 0.14.1

The Synopsys DesignWare HDMI 2.1 Quad-Pixel (QP) TX Controller IP can
found on the Rockchip RK3588 SoC family and supports the following
features, among others:

* Fixed Rate Link (FRL)
* Display Stream Compression (DSC)
* 4K@120Hz and 8K@60Hz video modes
* Variable Refresh Rate (VRR) including Quick Media Switching (QMS)
* Fast Vactive (FVA)
* Multi-stream audio
* Enhanced Audio Return Channel (EARC)

This patch series provides just the basic support, i.e. RGB output up to
4K@60Hz, without audio, CEC or any HDMI 2.1 related functionality.

Please note it is a reworked version of [1], which relied on a
commonized dw-hdmi approach.  Since the overall consensus was to handle
it as an entirely new IP, I dropped all references and dependencies to
the existing dw-hdmi driver code.

This has been submitted as a separate patchset, as suggested by Neil;
the Rockchip platform specific glue code enabling HDMI output for RK3588
will be send as v2 of the initial patch series [2].

Some additional changes worth mentioning:
* Making use of the new bridge HDMI helpers indicated by Dmitry
* Dropped connector creation to ensure driver does only support
  DRM_BRIDGE_ATTACH_NO_CONNECTOR
* Updated I2C segment handling to properly handle connected DVI displays
  (reported and fixed by Heiko)

[1]: https://lore.kernel.org/lkml/20240601-b4-rk3588-bridge-upstream-v1-13-f6203753232b@collabora.com/
[2]: https://lore.kernel.org/lkml/20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com/

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Cristian Ciocaltea (2):
      dt-bindings: display: bridge: Add schema for Synopsys DW HDMI QP TX IP
      drm/bridge: synopsys: Add DW HDMI QP TX Controller driver

 .../display/bridge/synopsys,dw-hdmi-qp.yaml        |  66 ++
 drivers/gpu/drm/bridge/synopsys/Kconfig            |   8 +
 drivers/gpu/drm/bridge/synopsys/Makefile           |   2 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       | 748 ++++++++++++++++++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h       | 834 +++++++++++++++++++++
 include/drm/bridge/dw_hdmi_qp.h                    |  37 +
 6 files changed, 1695 insertions(+)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240801-dw-hdmi-qp-tx-943992731570


