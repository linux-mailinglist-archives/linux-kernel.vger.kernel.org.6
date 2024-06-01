Return-Path: <linux-kernel+bounces-197859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 024B68D701D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FAA7B222A3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 13:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03D5154440;
	Sat,  1 Jun 2024 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IIy+T7m5"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AF11534FB;
	Sat,  1 Jun 2024 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717247595; cv=none; b=EzDQGEYlT2lUvbtJV7hQbemspTcxDgOvjmOoauxnh+yFo8z1maO/16jCehttumPP/oo+sE3Tged27Bk0tuQRK9U6HQ1WZixj91UNt9Awf0AOEhb/xpldBXJonX40VHh3lv8UbI0kdCasNpph3Kp2FPauuqu/aED2Ggx+EItoSEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717247595; c=relaxed/simple;
	bh=d5X/8LXvanfZpU40XKa3+2Yctw0Lkl4wDDDRx6WrtBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fh2mXwEivvnvlaTBVWXIQdS2KHOt1u7u/lgAgECKYBOTsujeDjv2CCOtMkLNT7a86xi9+tZuYG/o44bq43yw9ljtGC0mMboiKkwlJ23jQL6Toi6QaeI6rnHHynPgBftOBgqy5zjGAgJBDmfDzUNeZhq0LJBpkVslHDJxkTQreKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IIy+T7m5; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717247592;
	bh=d5X/8LXvanfZpU40XKa3+2Yctw0Lkl4wDDDRx6WrtBs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IIy+T7m5Qb+LrE2Ao6FFImU62A+YOJp0DV6h8zy4f5XvJs1nF8Y2glvsEzNhmmh23
	 gEDJWrn+NTWR1+mD9CQcoVZS8SQYzHrkOkIhpdw5jur0BujwRL2MljjKsvsxtCgOWz
	 wNVlWT2W30i02Rx4e8SDx1+0vZ3eDwdQtjS3Oyy4UszibXm8FNUpTQEbYD3F+dP1uy
	 ILQTocAnjSLSs+mwmCWknleJQjHqcIZN2Fpd9H5nLg4L5P4AWffWHjP9rYB/+mwHJ6
	 USfDd4xp8Z7NPst6srWfWhasfLupoVNtMmpY0TZQcxubuusGy2s4B5zEyI1WVUGxEz
	 FZytqcn4UJxAw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F2F2837821F3;
	Sat,  1 Jun 2024 13:13:11 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 01 Jun 2024 16:12:33 +0300
Subject: [PATCH 11/14] drm/rockchip: dw_hdmi: Drop superfluous assignments
 of mpll_cfg, cur_ctr and phy_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240601-b4-rk3588-bridge-upstream-v1-11-f6203753232b@collabora.com>
References: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
In-Reply-To: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>
X-Mailer: b4 0.14-dev-f7c49

The mpll_cfg, cur_ctr and phy_config members in struct dw_hdmi_plat_data
are only used to configure the Synopsys PHYs supported internally by DW
HDMI transmitter driver (gpu/drm/bridge/synopsys/dw-hdmi.c), via
hdmi_phy_configure_dwc_hdmi_3d_tx(), which is further invoked from
dw_hdmi_phy_init().  This is part of the internal
dw_hdmi_synopsys_phy_ops struct, managed within dw_hdmi_detect_phy().

To handle vendor PHYs, DW HDMI driver doesn't make use of the internal
PHY ops and, instead, relies on the glue layer to provide the phy_ops
and phy_name members of struct dw_hdmi_plat_data.

Drop the unnecessary assignments of DW internal PHY related members from
structs rk3228_hdmi_drv_data and rk3328_hdmi_drv_data, since both set
the phy_force_vendor flag and correctly provide the expected vendor PHY
data.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index edfd877c98fc..ca6728a43159 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -444,9 +444,6 @@ static struct rockchip_hdmi_chip_data rk3228_chip_data = {
 
 static const struct dw_hdmi_plat_data rk3228_hdmi_drv_data = {
 	.mode_valid = dw_hdmi_rockchip_mode_valid,
-	.mpll_cfg = rockchip_mpll_cfg,
-	.cur_ctr = rockchip_cur_ctr,
-	.phy_config = rockchip_phy_config,
 	.phy_data = &rk3228_chip_data,
 	.phy_ops = &rk3228_hdmi_phy_ops,
 	.phy_name = "inno_dw_hdmi_phy2",
@@ -481,9 +478,6 @@ static struct rockchip_hdmi_chip_data rk3328_chip_data = {
 
 static const struct dw_hdmi_plat_data rk3328_hdmi_drv_data = {
 	.mode_valid = dw_hdmi_rockchip_mode_valid,
-	.mpll_cfg = rockchip_mpll_cfg,
-	.cur_ctr = rockchip_cur_ctr,
-	.phy_config = rockchip_phy_config,
 	.phy_data = &rk3328_chip_data,
 	.phy_ops = &rk3328_hdmi_phy_ops,
 	.phy_name = "inno_dw_hdmi_phy2",

-- 
2.45.0


