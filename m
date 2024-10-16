Return-Path: <linux-kernel+bounces-367470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8A99A02BE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B061F26828
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249CD1CEADB;
	Wed, 16 Oct 2024 07:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sx6A48gh"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0112F1C07E7;
	Wed, 16 Oct 2024 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064257; cv=none; b=ZOKn7XH3XlkOBQbN36PMMvAtYstROzagYSnEZUa1XRZJkqqS1jaBB326CCAOvnVKoq91uFoSKLnuXKmasi1/Jji28HK0d9rL/jvMJ/bU/ZUrt0yt0YPWVEVkypZjxMQfgfnxad5x/vC3kwfaWFa1gbcb4GvOPNLLd5ytmE6PD6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064257; c=relaxed/simple;
	bh=EFCV+SNQZpcBAmn0X7T77pL2Roo/9hr04qUNlNDyoAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZmNLAORkL6dUSs2FltIe2M3Jm6h/hblvgQ0XVHDqr3YDCp0MLJTvxueS+JBPS3IQ6VgbWZjfxNIwNDWoCr5tsA+WDgM3iiQgR+1naA0c6dCmJIk0s+w0IWhnecu4Duddjrc8sXypii6Md2lyneVdUnn6Z9F48tfBqK6/9Kv0erE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sx6A48gh; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2a96b242cso1138149a91.3;
        Wed, 16 Oct 2024 00:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729064255; x=1729669055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9C+E1L253WMVxfeelIFI5Qx/2DDRuIfxkrOoa5l+CjA=;
        b=Sx6A48gh34LvFfr6DWesTCvQLFxbGFn/hmLCB+YonR3eIlrWTa5Qvy3Wjh8wdlS3G+
         c6GP0tR51i/UPqlqX1IM42FxobGdoPRr9yaH9DM+qMCcCrc8Ny6RS9ea7vpxYFSGxdP6
         kO0Mz+lArBJ28D4fIv70/j1JQeNSfLwtZ1TvjsoJzjPS8JLc2YM/6LH0pps0tcE2Spm0
         0fM7+bm6bF3vMwzqHMweYLxDZRrTO2zCrO4757u/lOfQ04iOoblKJE8O4cekc0T78OW0
         Y9FKv7i4ByVIyiZ0agY8RabHJKqoitJocEGtzTWZvb0SjXspLi1Hz1wBWhCAaVj5NmFd
         4zDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729064255; x=1729669055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9C+E1L253WMVxfeelIFI5Qx/2DDRuIfxkrOoa5l+CjA=;
        b=amtEYxfCGgw+Flg0DuQ1DAqIAQU5wj1xl6NiYP9qDCtj/2XLMV31euSbpa+2WBGH7l
         HBW6CCBDYXGVJdwg93lHhyeq2dDFzRx1aa773pwd18WdLUjd2N9U5Iq2w4va/FlkFX3M
         PAj8Wuxqqd2h/NAnYFDv6PzhJ5gXA38reXb2vU9e38IBmdzNU2CA+zxvFtkkBxVOSrfW
         TvWB6+lSiibBxa4uZqaaB/MBZQtppW8AWbSpx2IrXqARcjCXQ0vgpVKVnoc38qq/+gf5
         70Ok2sGENjj9CtYjvp1fipYV+xVrc2iIExEqwTKPav71EfeHyGpe7sCXakT0LgFUaBWA
         BwFA==
X-Forwarded-Encrypted: i=1; AJvYcCV7hijkrMsh4BWjhjH7d6g9Y+dz0ZG1xJQUzC7rt7s2c299WIpZi9HWmA3xZ7yrRkNrd7dDkLicJGo3@vger.kernel.org, AJvYcCW5w3AHtKszhr2uzxVcyKkrz0ZtpWdWSkeFe2Km1mJ6wKwtphCDYuuf9vx3BSWo1y2joJY4LMV0qmyDe5a6@vger.kernel.org
X-Gm-Message-State: AOJu0YzByC3jERvi8Q4YI15n98XDBFjUnSgK1DC459MISq9RRuLv7ZC+
	bZF+YoHNQDMlJB8CgsDPg1PTZ/EtBq1PeQAeHFpBHyqoh1vsOLNMcKEzfQ==
X-Google-Smtp-Source: AGHT+IHXcrmycBW/mhxkk7pwUeMRxrs83n43VhXPHi3ArbQCgQM01RLXKXNpfnb6PobTpa0PowneLg==
X-Received: by 2002:a17:90b:a16:b0:2e2:d1c0:758a with SMTP id 98e67ed59e1d1-2e2f0db90f3mr8554413a91.8.1729064255233;
        Wed, 16 Oct 2024 00:37:35 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3b7e6339fsm765471a91.1.2024.10.16.00.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 00:37:34 -0700 (PDT)
From: Frank Wang <frawang.cn@gmail.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	william.wu@rock-chips.com,
	tim.chen@rock-chips.com,
	Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH v6 4/4] phy: rockchip: inno-usb2: Add usb2 phys support for rk3576
Date: Wed, 16 Oct 2024 15:37:13 +0800
Message-Id: <20241016073713.14133-4-frawang.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241016073713.14133-1-frawang.cn@gmail.com>
References: <20241016073713.14133-1-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: William Wu <william.wu@rock-chips.com>

The RK3576 SoC has two independent USB2.0 PHYs, and each PHY has
one port. This adds device specific data for it.

Signed-off-by: William Wu <william.wu@rock-chips.com>
Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
Changelog:
v6:
 - add Reviewed tag.

v5:
 - no changes.

v4:
 - split the bulk clock management as a new patch, and this just leave
   adding rk3576-specific data.

v3:
 - amend the commit log adds clocks converting.
 - retrieve the clock by "clks.id" in *_clk480m_register() function.

v2:
 - no changes.

v1:
 - https://patchwork.kernel.org/project/linux-phy/patch/20240923025326.10467-2-frank.wang@rock-chips.com/

 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index f71266c27091e..96f3d868a526f 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1510,6 +1510,30 @@ static int rk3128_usb2phy_tuning(struct rockchip_usb2phy *rphy)
 				BIT(2) << BIT_WRITEABLE_SHIFT | 0);
 }
 
+static int rk3576_usb2phy_tuning(struct rockchip_usb2phy *rphy)
+{
+	int ret;
+	u32 reg = rphy->phy_cfg->reg;
+
+	/* Deassert SIDDQ to power on analog block */
+	ret = regmap_write(rphy->grf, reg + 0x0010, GENMASK(29, 29) | 0x0000);
+	if (ret)
+		return ret;
+
+	/* Do reset after exit IDDQ mode */
+	ret = rockchip_usb2phy_reset(rphy);
+	if (ret)
+		return ret;
+
+	/* HS DC Voltage Level Adjustment 4'b1001 : +5.89% */
+	ret |= regmap_write(rphy->grf, reg + 0x000c, GENMASK(27, 24) | 0x0900);
+
+	/* HS Transmitter Pre-Emphasis Current Control 2'b10 : 2x */
+	ret |= regmap_write(rphy->grf, reg + 0x0010, GENMASK(20, 19) | 0x0010);
+
+	return ret;
+}
+
 static int rk3588_usb2phy_tuning(struct rockchip_usb2phy *rphy)
 {
 	int ret;
@@ -1938,6 +1962,84 @@ static const struct rockchip_usb2phy_cfg rk3568_phy_cfgs[] = {
 	{ /* sentinel */ }
 };
 
+static const struct rockchip_usb2phy_cfg rk3576_phy_cfgs[] = {
+	{
+		.reg = 0x0,
+		.num_ports	= 1,
+		.phy_tuning	= rk3576_usb2phy_tuning,
+		.clkout_ctl	= { 0x0008, 0, 0, 1, 0 },
+		.port_cfgs	= {
+			[USB2PHY_PORT_OTG] = {
+				.phy_sus	= { 0x0000, 8, 0, 0, 0x1d1 },
+				.bvalid_det_en	= { 0x00c0, 1, 1, 0, 1 },
+				.bvalid_det_st	= { 0x00c4, 1, 1, 0, 1 },
+				.bvalid_det_clr = { 0x00c8, 1, 1, 0, 1 },
+				.ls_det_en	= { 0x00c0, 0, 0, 0, 1 },
+				.ls_det_st	= { 0x00c4, 0, 0, 0, 1 },
+				.ls_det_clr	= { 0x00c8, 0, 0, 0, 1 },
+				.disfall_en	= { 0x00c0, 6, 6, 0, 1 },
+				.disfall_st	= { 0x00c4, 6, 6, 0, 1 },
+				.disfall_clr	= { 0x00c8, 6, 6, 0, 1 },
+				.disrise_en	= { 0x00c0, 5, 5, 0, 1 },
+				.disrise_st	= { 0x00c4, 5, 5, 0, 1 },
+				.disrise_clr	= { 0x00c8, 5, 5, 0, 1 },
+				.utmi_avalid	= { 0x0080, 1, 1, 0, 1 },
+				.utmi_bvalid	= { 0x0080, 0, 0, 0, 1 },
+				.utmi_ls	= { 0x0080, 5, 4, 0, 1 },
+			}
+		},
+		.chg_det = {
+			.cp_det		= { 0x0080, 8, 8, 0, 1 },
+			.dcp_det	= { 0x0080, 8, 8, 0, 1 },
+			.dp_det		= { 0x0080, 9, 9, 1, 0 },
+			.idm_sink_en	= { 0x0010, 5, 5, 1, 0 },
+			.idp_sink_en	= { 0x0010, 5, 5, 0, 1 },
+			.idp_src_en	= { 0x0010, 14, 14, 0, 1 },
+			.rdm_pdwn_en	= { 0x0010, 14, 14, 0, 1 },
+			.vdm_src_en	= { 0x0010, 7, 6, 0, 3 },
+			.vdp_src_en	= { 0x0010, 7, 6, 0, 3 },
+		},
+	},
+	{
+		.reg = 0x2000,
+		.num_ports	= 1,
+		.phy_tuning	= rk3576_usb2phy_tuning,
+		.clkout_ctl	= { 0x2008, 0, 0, 1, 0 },
+		.port_cfgs	= {
+			[USB2PHY_PORT_OTG] = {
+				.phy_sus	= { 0x2000, 8, 0, 0, 0x1d1 },
+				.bvalid_det_en	= { 0x20c0, 1, 1, 0, 1 },
+				.bvalid_det_st	= { 0x20c4, 1, 1, 0, 1 },
+				.bvalid_det_clr = { 0x20c8, 1, 1, 0, 1 },
+				.ls_det_en	= { 0x20c0, 0, 0, 0, 1 },
+				.ls_det_st	= { 0x20c4, 0, 0, 0, 1 },
+				.ls_det_clr	= { 0x20c8, 0, 0, 0, 1 },
+				.disfall_en	= { 0x20c0, 6, 6, 0, 1 },
+				.disfall_st	= { 0x20c4, 6, 6, 0, 1 },
+				.disfall_clr	= { 0x20c8, 6, 6, 0, 1 },
+				.disrise_en	= { 0x20c0, 5, 5, 0, 1 },
+				.disrise_st	= { 0x20c4, 5, 5, 0, 1 },
+				.disrise_clr	= { 0x20c8, 5, 5, 0, 1 },
+				.utmi_avalid	= { 0x2080, 1, 1, 0, 1 },
+				.utmi_bvalid	= { 0x2080, 0, 0, 0, 1 },
+				.utmi_ls	= { 0x2080, 5, 4, 0, 1 },
+			}
+		},
+		.chg_det = {
+			.cp_det		= { 0x2080, 8, 8, 0, 1 },
+			.dcp_det	= { 0x2080, 8, 8, 0, 1 },
+			.dp_det		= { 0x2080, 9, 9, 1, 0 },
+			.idm_sink_en	= { 0x2010, 5, 5, 1, 0 },
+			.idp_sink_en	= { 0x2010, 5, 5, 0, 1 },
+			.idp_src_en	= { 0x2010, 14, 14, 0, 1 },
+			.rdm_pdwn_en	= { 0x2010, 14, 14, 0, 1 },
+			.vdm_src_en	= { 0x2010, 7, 6, 0, 3 },
+			.vdp_src_en	= { 0x2010, 7, 6, 0, 3 },
+		},
+	},
+	{ /* sentinel */ }
+};
+
 static const struct rockchip_usb2phy_cfg rk3588_phy_cfgs[] = {
 	{
 		.reg = 0x0000,
@@ -2109,6 +2211,7 @@ static const struct of_device_id rockchip_usb2phy_dt_match[] = {
 	{ .compatible = "rockchip,rk3366-usb2phy", .data = &rk3366_phy_cfgs },
 	{ .compatible = "rockchip,rk3399-usb2phy", .data = &rk3399_phy_cfgs },
 	{ .compatible = "rockchip,rk3568-usb2phy", .data = &rk3568_phy_cfgs },
+	{ .compatible = "rockchip,rk3576-usb2phy", .data = &rk3576_phy_cfgs },
 	{ .compatible = "rockchip,rk3588-usb2phy", .data = &rk3588_phy_cfgs },
 	{ .compatible = "rockchip,rv1108-usb2phy", .data = &rv1108_phy_cfgs },
 	{}
-- 
2.25.1


