Return-Path: <linux-kernel+bounces-363073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F206A99BD93
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1D84283106
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4529944C77;
	Mon, 14 Oct 2024 02:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJcB7bWE"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F29F20322;
	Mon, 14 Oct 2024 02:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728871436; cv=none; b=tEpkMKCJT3iOZKla/fET1S6zrtgWqFJxjc36wE8IdyXLtov0CU9aXYsygkCXR4L1d7xTVT7AMhjwfXrviwxeviQe/x5+DvAjTv9I9+RDvy6zH+MAC5R4x5PAJJ0BKkHjjbc7Ho03YxCrqk228e3jmkcZ8Ew0+YC40HjoVuMJ2gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728871436; c=relaxed/simple;
	bh=8Py1PojmnLz8G6PS2RHSmCddHtVEWgrgXrC7J8HP/QA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SuYbVEUknEFiIZdTFoAmrzhdiBZ/eEObI0z8L4b9U1Yr0iqWucu+2dXtz7u/Z+SehyKXLvx8fM585LMiZHygblphutLzkCQq0oMM+lPEZvkUeTA5MQRlCDYg+4EMbKYgjSrRlHxzzJ22m1DvQRIpx9XMwimcqf5iBOnuFmdVArI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJcB7bWE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c53efc14fso1159255ad.0;
        Sun, 13 Oct 2024 19:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728871434; x=1729476234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+2YzuGjZ565Z5EeBQaZ+urP/hWGuLNc2EAXI5cnfwg=;
        b=XJcB7bWEcp4W6ZhCTGt0Jt6iEi8IVto/ytqt9xwFYWm7LNQ98lPSPr+y6s/UR2u0a3
         k+HrvVZ1yOO38fe1DkW2/oJjUt3hMO6MpXjWXckkuX1zz5IDmVLqV9vev5EiBWlccHLN
         2N+JtRhn4lh0EpP0wIryRz9CgB7dO6kmE3c+xDqf2gkIB/+Vzf1fvbtZN3f0TEpqB1jC
         00yJvdTxLwxRhoUNPnszFXdi4UPypRlf4F7qkFcGvv2l9WAa7mIIGAWeQx+EZHxcMxrO
         uvH03bIhbsWy82pWwjLOqKxFHFkJQGd3fwneMgkbGQYWfE7A5hZKOJYUjdpFg+LNax12
         KagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728871434; x=1729476234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+2YzuGjZ565Z5EeBQaZ+urP/hWGuLNc2EAXI5cnfwg=;
        b=CTtEt1bVldrH/paQP3IvsZPKnPMRMxi9xz31Wmktw09MZAIqWZVGV20NbZtiLoYOiG
         7LVbLxbu6HzmgapO76pY+xABUG05ZhJ/9ynsZkQ9eNMRF8uB7irfdQPVTQb31CVU5+MO
         4TVCrwrg6nt1L3lfS5vysxEHLwX8gPeFOfipFMTpcUBGf9mSNcUUi4DhMB1v4PHXKe+d
         hbUuFDRQsWfg10BpG8Y2bPABR+uONbKNEwZL+TcoSEKU5dLruf9FeQJeRc4suvtoMuJO
         oiWXxO5/y48zOxsTq29GSIA40lKghpa30KH5HSZDwTVgY0mQRdmqtt948fbcBRF2wOTp
         FKSg==
X-Forwarded-Encrypted: i=1; AJvYcCXAiUY9zQg69zr6d5EQ9+8c3omH3R4DqOhTqwZI714Mn7PtaWrS6jqubBf48TkBDgdCxN8JB4G+fR1AElhN@vger.kernel.org, AJvYcCXavEmuPb8QYT2v0fCCHVxUb+u2AVlaDo8BvdIa4Ib5CgyYkLLcPu4D1pzLSLTHVsqWSSPNAeNTiagv@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6LsVkauyVLkMC2Ft27yssSqRpeDxnIJo0tPNk8v0i2/3miwd6
	AgyyLeOGy9w7ztgIh+0DvJp1W9iHgmlBBgLisKb2H+StDH/ZUlIA
X-Google-Smtp-Source: AGHT+IE1JknVkl8aB3x0qAHKQ1IbUEKDSAyXDczd7Q2+7yIAncdz3a+o0R1siny/KGDn4RTjKuAIbg==
X-Received: by 2002:a17:902:e845:b0:20c:92ce:35b3 with SMTP id d9443c01a7336-20ca1429fdbmr55505965ad.2.1728871434562;
        Sun, 13 Oct 2024 19:03:54 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc1a59asm55794795ad.113.2024.10.13.19.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 19:03:54 -0700 (PDT)
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
	yubing.zhang@rock-chips.com,
	Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH 2/2] phy: rockchip: usbdp: add rk3576 device match data
Date: Mon, 14 Oct 2024 10:03:42 +0800
Message-Id: <20241014020342.15974-2-frawang.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241014020342.15974-1-frawang.cn@gmail.com>
References: <20241014020342.15974-1-frawang.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wang <frank.wang@rock-chips.com>

This adds RK3576 device match data support.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 drivers/phy/rockchip/phy-rockchip-usbdp.c | 41 +++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
index 2c51e5c62d3e..5b1e8a3806ed 100644
--- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
+++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
@@ -1538,6 +1538,43 @@ static const char * const rk_udphy_rst_list[] = {
 	"init", "cmn", "lane", "pcs_apb", "pma_apb"
 };
 
+static const struct rk_udphy_cfg rk3576_udphy_cfgs = {
+	.num_phys = 1,
+	.phy_ids = { 0x2b010000 },
+	.num_rsts = ARRAY_SIZE(rk_udphy_rst_list),
+	.rst_list = rk_udphy_rst_list,
+	.grfcfg	= {
+		/* u2phy-grf */
+		.bvalid_phy_con		= RK_UDPHY_GEN_GRF_REG(0x0010, 1, 0, 0x2, 0x3),
+		.bvalid_grf_con		= RK_UDPHY_GEN_GRF_REG(0x0000, 15, 14, 0x1, 0x3),
+
+		/* usb-grf */
+		.usb3otg0_cfg		= RK_UDPHY_GEN_GRF_REG(0x0030, 15, 0, 0x1100, 0x0188),
+
+		/* usbdpphy-grf */
+		.low_pwrn		= RK_UDPHY_GEN_GRF_REG(0x0004, 13, 13, 0, 1),
+		.rx_lfps		= RK_UDPHY_GEN_GRF_REG(0x0004, 14, 14, 0, 1),
+	},
+	.vogrfcfg = {
+		{
+			.hpd_trigger	= RK_UDPHY_GEN_GRF_REG(0x0000, 11, 10, 1, 3),
+			.dp_lane_reg    = 0x0000,
+		},
+	},
+	.dp_tx_ctrl_cfg = {
+		rk3588_dp_tx_drv_ctrl_rbr_hbr_typec,
+		rk3588_dp_tx_drv_ctrl_rbr_hbr_typec,
+		rk3588_dp_tx_drv_ctrl_hbr2,
+		rk3588_dp_tx_drv_ctrl_hbr3,
+	},
+	.dp_tx_ctrl_cfg_typec = {
+		rk3588_dp_tx_drv_ctrl_rbr_hbr_typec,
+		rk3588_dp_tx_drv_ctrl_rbr_hbr_typec,
+		rk3588_dp_tx_drv_ctrl_hbr2,
+		rk3588_dp_tx_drv_ctrl_hbr3,
+	},
+};
+
 static const struct rk_udphy_cfg rk3588_udphy_cfgs = {
 	.num_phys = 2,
 	.phy_ids = {
@@ -1584,6 +1621,10 @@ static const struct rk_udphy_cfg rk3588_udphy_cfgs = {
 };
 
 static const struct of_device_id rk_udphy_dt_match[] = {
+	{
+		.compatible = "rockchip,rk3576-usbdp-phy",
+		.data = &rk3576_udphy_cfgs
+	},
 	{
 		.compatible = "rockchip,rk3588-usbdp-phy",
 		.data = &rk3588_udphy_cfgs
-- 
2.34.1


