Return-Path: <linux-kernel+bounces-283803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 526AE94F8D2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9311C21EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9205E194AD7;
	Mon, 12 Aug 2024 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b="YI7Wnarb"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610D618E051
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723497404; cv=pass; b=dv1CgXhkiHnkoyk7aWTwc3HcrITae4fWUt3OpD5X4vO52wsnkbZ3MF0WwRfc2viSrw9reHIbrG8YqqzdisTFDObEtld9I398bdyulYL9WniHp5z87ci/biikPjyjtL9Ymx+r+inZzChWYQWgQ7pteWyri5hs6NeiGN4Qw3g2jk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723497404; c=relaxed/simple;
	bh=Hk1V4sfW0oAAyXBwlBXFbvdY1UybV/+KTk0T/7tf7oc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WyA2x9xyDduncw9WzoLgCD1GC9pD0xQzKkwqLpwXAhS3RQCDnz2RQ6LrJZSO3CTcncYNs3SwClaFPDsnpo/dGqCj7r/yOk7GlCHon+35snfZGqLanHgVvCI4AWzfFh9cf33FcIKpOcNoEXt6xQLYumrMLrEGgOhbidFOjgLZ4as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b=YI7Wnarb; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723497358; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RSgqYHbpvJn5Wr+j9THLyR6jhT2q71jHY2G1g84dWgEuyksCfJSlmACTjFmzwjlg1NNlgnxDVPt91CWFWHwtNGyEgRodleNdY6i/mpoCwkPjiSAtkgQ5w8BwBbamYiM7MrEqvxzaaJpzkPbF5C8qlRels7EfnKowzrflTK4xWrs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723497358; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0I1JLzxrV0gVyw2bF2C9h87qd8Pc9eWrEb9tvdjX5cI=; 
	b=n7TyYd8k3VJU4XZI9I0If5Rjgr09wPlshBiIAVtXAghizbtqMnRNrMHac/BZ+Q5bx/y1+3DuP3VxicdR4dii5je42dhTY2+m7AGyC+oan/psfKV2wI07gwruRtE7/QmBgBwBnm34pOfaYwoCwwZ9Fd2ii/zgHpgRsL6L02fyfe0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=cristian.ciocaltea@collabora.com;
	dmarc=pass header.from=<cristian.ciocaltea@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723497358;
	s=zohomail; d=collabora.com; i=cristian.ciocaltea@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=0I1JLzxrV0gVyw2bF2C9h87qd8Pc9eWrEb9tvdjX5cI=;
	b=YI7Wnarb7Jf1A/cQaxHzhlPU1WxIlqg30fl35glMaLRl/u91qwW2ZfePzP0yG8it
	j5uaqCgPP8hl1i++2+A1UgpMqAyCWoekovvJUwRfNfrDLmwFPCx959IO/qzsOIRyCyN
	LT6Gpt76B19LVEFGAWSyQEENs6DrXzCrAgNsE5Qs=
Received: by mx.zohomail.com with SMTPS id 1723497357461825.5740191228684;
	Mon, 12 Aug 2024 14:15:57 -0700 (PDT)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 13 Aug 2024 00:15:11 +0300
Subject: [PATCH 4/4] drm/rockchip: dw_hdmi: Drop superfluous assignments of
 mpll_cfg, cur_ctr and phy_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-dw-hdmi-rockchip-cleanup-v1-4-b3e73b5f4fd6@collabora.com>
References: <20240813-dw-hdmi-rockchip-cleanup-v1-0-b3e73b5f4fd6@collabora.com>
In-Reply-To: <20240813-dw-hdmi-rockchip-cleanup-v1-0-b3e73b5f4fd6@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-ZohoMailClient: External

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
2.46.0


