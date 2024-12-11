Return-Path: <linux-kernel+bounces-441129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6219ECA11
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3176285362
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6091EC4E6;
	Wed, 11 Dec 2024 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IKrpu1xP"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B03236F84;
	Wed, 11 Dec 2024 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733912131; cv=none; b=EX4U45vpmOeoEcoxsGCNX1dEaYxk3cizHEcvQLdnOn5Lh1chFyWJ13UAEhBAiCLJig60StofnLh7KmhrUznjJ/mFmbeohbrVOGmPBfDt29dxteRoTsOqu6P93+MOhrL+QIv1CX/frW98Gg5gwzbT3rSdlqasC7A7/8+NRlMwlP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733912131; c=relaxed/simple;
	bh=ih7Vsnj9ywdYxh7tR2qjlznCSvRVx5lmggLsQKhoolI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ljRVNKU34qro1+HO+kPgEhdqibN6Wug4tflBwZcp1qW9XCZGbQMG5wyucIuABgcSYZmfLqWwz/AZlJzzjQwrHDIqK2kisfR+tY+X/MoOwtZ1C7TlNQl4JaXxHVCM4HbcIEun/flE3TAkUxlq7w3HAL+jLxSKAATHZMChJM5FoR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IKrpu1xP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733912127;
	bh=ih7Vsnj9ywdYxh7tR2qjlznCSvRVx5lmggLsQKhoolI=;
	h=From:Subject:Date:To:Cc:From;
	b=IKrpu1xPLywnKIeJ53zP0EULAmN3li50hVFXh2h8PoJ56+0TOh8pjicWQRgcPun5N
	 wsAtHooBHZH/JsRTU66C/RcxcdXou1sV95/A46QFVTGcvxEvMFYDgMpqapncJLqpCF
	 qBYgAK47aPvXfAtPYD/9qaGHUjt9c1Q92YrSql5eqyPEHTA5OHoFd9MugDPVtoaNYn
	 5faLjjYOgqmoZcJZwsUEXdAbsoa0v2UG956+pFxY+iGgfhhXffXPa3uunWY8uUh0n/
	 KANbkGeQs9Vty3nV9HyH3t7jYFrBVGQTCYs5n0sChEBqy+F30QRb3YYagWlcMyA4o5
	 p4qxkd88HP24Q==
Received: from localhost (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1888017E35F5;
	Wed, 11 Dec 2024 11:15:27 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v2 0/5] Improve Rockchip VOP2 display modes handling on
 RK3588 HDMI0
Date: Wed, 11 Dec 2024 12:15:04 +0200
Message-Id: <20241211-vop2-hdmi0-disp-modes-v2-0-471cf5001e45@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAChmWWcC/4WNTQ6CMBBGr0Jm7RhaEMGV9zAs+jPIJMCQ1jQaw
 t2tXMDle8n3vg0iBaYIt2KDQIkjy5JBnwpwo1mehOwzgy51rZRqMMmqcfQzl+g5rjiLp4i26qh
 qVHdt2gHydg008PvoPvrMI8eXhM9xk9TP/ismhSVq68xFeVu3XXt3Mk3GSjBnJzP0+75/AXjGU
 P6+AAAA
X-Change-ID: 20241116-vop2-hdmi0-disp-modes-b39e3619768f
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 FUKAUMI Naoki <naoki@radxa.com>
X-Mailer: b4 0.14.2

VOP2 support for RK3588 SoC is currently not capable to handle the full
range of display modes advertised by the connected screens, e.g. it
doesn't cope well with non-integer refresh rates like 59.94, 29.97,
23.98, etc.

There are two HDMI PHYs available on RK3588, each providing a PLL that
can be used by three out of the four VOP2 video ports as an alternative
and more accurate pixel clock source. This is able to correctly handle
all display modes up to 4K@60Hz.

As for the moment HDMI1 output is not supported upstream, the patch
series targets HDMI0 only.

Additionally, note that testing any HDMI 2.0 specific modes, e.g.
4K@60Hz, requires high TMDS clock ratio and scrambling support [1]. The
patch is usable but not yet ready to be submitted - I will handle this
soon.

Thanks,
Cristian

[1] https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/commits/rk3588-hdmi-bridge-next-20241115

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v2:
- Collected Acked-by tag from Rob and Tested-by from Naoki
- Rebased series onto v6.13-rc1
- Link to v1: https://lore.kernel.org/r/20241116-vop2-hdmi0-disp-modes-v1-0-2bca51db4898@collabora.com

---
Cristian Ciocaltea (5):
      dt-bindings: display: vop2: Add optional PLL clock properties
      drm/rockchip: vop2: Drop unnecessary if_pixclk_rate computation
      drm/rockchip: vop2: Improve display modes handling on RK3588 HDMI0
      arm64: dts: rockchip: Enable HDMI0 PHY clk provider on RK3588
      arm64: dts: rockchip: Add HDMI0 PHY PLL clock source to VOP2 on RK3588

 .../bindings/display/rockchip/rockchip-vop2.yaml   |  4 +++
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      |  7 +++--
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       | 36 +++++++++++++++++++++-
 3 files changed, 44 insertions(+), 3 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241116-vop2-hdmi0-disp-modes-b39e3619768f


