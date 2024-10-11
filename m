Return-Path: <linux-kernel+bounces-360608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C64C999D28
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE701C21982
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C55F20A5E9;
	Fri, 11 Oct 2024 06:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azQUAexh"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B1720ADD4;
	Fri, 11 Oct 2024 06:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629519; cv=none; b=gjlWLcr8XUT33LCKVuFbvQHJGo/DPMwScjIdcdkpKIiY5l/Csek8bugRmGuFst9s1SMu1XbS//IQN7mzJzaUXNBeaWwJFhPTPhLA0Z5DMAx4FUmQWR6TYYgFXLyPLPi9QU9HZbHj7NHAODIKyVYa1Q/QeSXH5nnVfg39o4r3aXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629519; c=relaxed/simple;
	bh=zUzz5FMZgllG1DiUJqa8A07/Ko9fX/OQfwhwMPLWmC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZsBcqjp3r4oUv81Fm+7zR8fJFBjBDjVPpzc49aiNsto61OcaF6+7XfWqoLXOwDFvyx9KRv2C7wF4KNt3Ebafu7XxP7bMYnqFqMPRRlS6OXnOfOakb/nkQJoh8qiwm3yY4VMX7yUbxxD74yFbhakCP8ywwDV00hRfwDrjwYGwbI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azQUAexh; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-717839f9eb6so142219b3a.3;
        Thu, 10 Oct 2024 23:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728629517; x=1729234317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoXrcFLiduR8K9NPSxdvgXuql0UA1hd/Qh6Orl6Z1QI=;
        b=azQUAexh43Thv8B698VpC0ZpUHLij3hm6Py7fnzfSkdCBX3PD9ujn6up1kI2BLG4o/
         IMCRUl+d7viGaEQOSdlTR+Ly14hOeAc0jfw38x42//pOkREUfjg8FmTO5gf9R9uWrOi3
         cPoucKkbKLOzzaKr3JKYjZQq5B0RSPw8NiNl7Cim9faoRrHq74BHUbpVqJTFwhCBJTPW
         a0QTixQ9rINCTSKHrKxwSMd1StA/N8eaHNTU6ib6+DNWMl5X6tn0yw5++Wkudlwvkfpr
         USosirxgM/O7TjVVvo+jKOksl0DBuplhfHIHkfMkbRojVwRfe1p/JNeCQUajIfa9T6Oq
         UD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728629517; x=1729234317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoXrcFLiduR8K9NPSxdvgXuql0UA1hd/Qh6Orl6Z1QI=;
        b=nlH853UW1EynB7vxgH41Cs1yzsiUkD5ON0yKM/w1N+sNc1cETu90my1PGFTLwP2RWa
         j4iYeHAXwymJbprdQ6iExJN3VTg8Vp5GZ36CQK0kPqea8mr1KYuZVxubiTFORwxQRHdn
         hjgzVOmWuleHdQs2lGDjZrmh9uVmcsO22fuOhquXVpvFIOC3DGM/ON73umJoPmC5XDSn
         3gvQ+72vVrpDFnP/xN6X1alun8rUtpcZM7fTJb7SuTKvbmieEo8x6byPHm98BboevkdM
         kLO0X6q2TKaua9752W6qSe/v3gioBU38sp3INVDCNpsv61ncKsZcZIuFkCPu8ts35LDT
         MdpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2fmN1v9BuG/Yxa9WjXJT7sclq26ZooeQS3Teh2SpOEugJvQciohL2epsfKKCm7P4ZntrjIxWJS7L2UJYh@vger.kernel.org, AJvYcCWbjVww4KUyxw1RjUdVR9exMdQDVcQc8nM4luvwH7BZnp3QW7MBk2Q6qDxdzFCIYSvxaumcYG4dNX4q@vger.kernel.org
X-Gm-Message-State: AOJu0YwSyMBp/ImQ5OX4mXs+jARNeFZtL8n38SMk2MME2grc26M0rIqg
	I80GSVjfbjBC/PZQiJ13yNNifGSWLGFZdTmYhdeVVABQkuwORFRX
X-Google-Smtp-Source: AGHT+IE0a4raEMb1CKHZOr3RN/vfXnIURFS+NIbfrAYdekgJC1BrJeUqK/aGlnsCilzTxJ63p8IKRQ==
X-Received: by 2002:a05:6a00:9453:b0:71d:f2d9:bd5d with SMTP id d2e1a72fcca58-71e380c5a41mr1100111b3a.7.1728629516958;
        Thu, 10 Oct 2024 23:51:56 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2ab109e4sm2036099b3a.206.2024.10.10.23.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 23:51:56 -0700 (PDT)
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
Subject: [PATCH v5 3/3] phy: rockchip: inno-usb2: Add usb2 phys support for rk3576
Date: Fri, 11 Oct 2024 14:51:40 +0800
Message-Id: <20241011065140.19999-3-frawang.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241011065140.19999-1-frawang.cn@gmail.com>
References: <20241011065140.19999-1-frawang.cn@gmail.com>
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
2.45.2


