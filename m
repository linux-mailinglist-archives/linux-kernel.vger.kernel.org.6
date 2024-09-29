Return-Path: <linux-kernel+bounces-342815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD18E98933C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 08:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F8E28312C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 06:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ACA13D8A0;
	Sun, 29 Sep 2024 06:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xqhqkg7F"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BEF13AA36;
	Sun, 29 Sep 2024 06:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727590245; cv=none; b=cq4YqrkyejYoiqygWqPacd3hbBBn1d7LENhGBEEFULNk7VsG/r6ZXcweT60p+NoLszUhnSCaDr1x8kNh3/CNycUvevmdxqS23L8V0PZyBs33Xi6voH2woyvlV4drrldUILHDp3oPMAUktB7moBZdLkKkd+LWNnW2+UwOsDzaNvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727590245; c=relaxed/simple;
	bh=7kMMcUkhN5lcXSz/DWQSnram/1C4vZdGAbV480sstWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnLb5w52C2FMcDW8gqRc3xS7jG14+uK8hpZqUBmHC7dggUFD94B0/MqtnIFFsKwtuOD4M8irN0xaTiGWdhI/wnvVEpAS4Fmh+9+jURgBNvyg6rxZTehN6D/qCJvXwHobNcy5EA3G4c6K55o4KjGd4CdnOl7rdFup/mB1hUNVmoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xqhqkg7F; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71829963767so280609b3a.1;
        Sat, 28 Sep 2024 23:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727590243; x=1728195043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Akpn0thmbgIzVjfPV0oA4PJDLdf9K15fHM30omhDao=;
        b=Xqhqkg7FK36SKL0F4lwqPxYYe4ILK6/6RJMQtRwUAGmr90EizFcD8hppYCR9jcghdU
         /9p9mAjKiBavPA7eShK55qnL+zmBczEZQL4oVm05+y4ar11zBUEJed5UQOLiL1Bcx9WS
         H+49o+JKse9Zzpj7MwFpTE7k6CxhEQGv4e5T1p7wEajoiJdLDTc9Oglcd4tNjPau5/lG
         4iA1EZBlLYPg2T1dvBeVQmfphMTsbfdZn2dtTeFyiL6r9Q/ruSPhmTJxXSapW3sLfu03
         Zj2aDZFyCrjEhFQ4r7KzdTOQkfVMx6ALhar2zblXp+m4SEMnewIAEq8RUJThB7MZgOKj
         F2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727590243; x=1728195043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Akpn0thmbgIzVjfPV0oA4PJDLdf9K15fHM30omhDao=;
        b=fptOMqdmw8GmUh2p8oz0D4QxvrMs/Qjbysm9rxfMtO5DO5b8orkhiX/13wspBjoWfr
         Xdd/2anEHYtuM7nM+rw+C4zwft4s3MNIMIBjoSQdKghZJ2M7VvnqprpZY/IeUnJ0Ub5K
         YOQ3xY/BfNR3bPRGlvAwU+VJ7Gyec+MvRoA1p7KS/6/FdmjrQA0dGin73UNpUGm/yJe7
         QcywcJbLvtN0RKUdwsgCAnFyCeqN7WBKLKQB+EVj3uF9KYanxel+7seSdz7TQZQAl545
         eOOzvPiFnBP4mhEStm7rTzy/n8KMYcDzdkPimqJwiqDFc/VDDQ6bHp8NRk71rzdvXutY
         kd0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUK6QqVVQk1dIdrh+F49YsFm0OZQUamITLfGoQjXJkdf3ffkKv3a3mmNj+q4DYfuBRZ1um0w7/Q9FbX@vger.kernel.org, AJvYcCXKV86X27qPQCKYWvIHoD3YNNMk1+LojTGMAKehy5i9R1YrPdEIIQ7xF/Pc0b9NS5a95f8kqqJ9gcY9MDdz@vger.kernel.org
X-Gm-Message-State: AOJu0YwjNUYYiS+hujeK867TUZpBpbHp0i7urQVs8/BA+wYy8osbXjFf
	I6guJxxa18WT9eNRAzO4YRTcUBDaRLIq5LapbtZsoHmaACEeYNyO
X-Google-Smtp-Source: AGHT+IF2iogTKpcc4OC3wX2AKFC19wwkglyqmU4gozQpOj4E0scTjZJgjLmWS2b6wIO27RM0B0DA3Q==
X-Received: by 2002:a05:6a00:1990:b0:717:8b4e:98ad with SMTP id d2e1a72fcca58-71c6352f3demr2763841b3a.0.1727590243221;
        Sat, 28 Sep 2024 23:10:43 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2b974bsm4269584a12.34.2024.09.28.23.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 23:10:42 -0700 (PDT)
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
	frank.wang@rock-chips.com
Subject: [PATCH v4 3/3] phy: rockchip: inno-usb2: Add usb2 phys support for rk3576
Date: Sun, 29 Sep 2024 14:10:25 +0800
Message-ID: <20240929061025.3704-3-frawang.cn@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240929061025.3704-1-frawang.cn@gmail.com>
References: <20240929061025.3704-1-frawang.cn@gmail.com>
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
---
Changelog:
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
index ad3e65dc6aa4..629f71e7cd1b 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1524,6 +1524,30 @@ static int rk3128_usb2phy_tuning(struct rockchip_usb2phy *rphy)
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
@@ -1952,6 +1976,84 @@ static const struct rockchip_usb2phy_cfg rk3568_phy_cfgs[] = {
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
@@ -2123,6 +2225,7 @@ static const struct of_device_id rockchip_usb2phy_dt_match[] = {
 	{ .compatible = "rockchip,rk3366-usb2phy", .data = &rk3366_phy_cfgs },
 	{ .compatible = "rockchip,rk3399-usb2phy", .data = &rk3399_phy_cfgs },
 	{ .compatible = "rockchip,rk3568-usb2phy", .data = &rk3568_phy_cfgs },
+	{ .compatible = "rockchip,rk3576-usb2phy", .data = &rk3576_phy_cfgs },
 	{ .compatible = "rockchip,rk3588-usb2phy", .data = &rk3588_phy_cfgs },
 	{ .compatible = "rockchip,rv1108-usb2phy", .data = &rv1108_phy_cfgs },
 	{}
-- 
2.34.1


