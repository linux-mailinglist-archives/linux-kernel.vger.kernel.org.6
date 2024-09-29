Return-Path: <linux-kernel+bounces-342813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 226A4989338
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 08:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C905D2820D7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 06:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2B8136982;
	Sun, 29 Sep 2024 06:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSDD6CM9"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7887513CA93;
	Sun, 29 Sep 2024 06:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727590236; cv=none; b=lbm+DLvTIHryiCr65SIb4CMfkL+SkZVca3hc1uqLp5P3n8KX0chvV2fQYptJXKnZqdXVam2Qst47xkPjxltVMbGFBqUbRVgy8o9ugjUaO1GogZ3p5A1KHJJ0rfAeOot/a08S2OHQWW/HbiKi+QXlkaO74gd0A1U6r+nlnwpZO3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727590236; c=relaxed/simple;
	bh=81vPcrtTlRln51ot+o6oFc1XjmCNjNqxMvPMmKgD3Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o4uMCQINklBZEBwh+h/qngdax92G/5hFtaDsQFQprpb6MrjnihPdifPBX/FiCbIvpqcMC+a/NhxB7lkqQjaGY837ZoZsxGGWWz06RKCEJBMHU1HuPFviVxhav0bDCjl+lM+nO0NMkux2i1uZE/J6I0O2rtQgd9WUMoWaWFCJ4jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSDD6CM9; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e08071fcd9so375481a91.0;
        Sat, 28 Sep 2024 23:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727590234; x=1728195034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xKLiR5gYmZwZmfgs+vGwBtpwK5USPFATr2yD/8gCPKI=;
        b=lSDD6CM9vFyG7aen7cCIBBv/ZnhFNGFQAO3YfUPvLX4xnBySgVdnQU1Ljd0YevuL00
         02j5sKXsDyfMK9ug6N4p4lYWjgySKYY97p/BS8MKFxbH1rczHXVnTiEx7gBpFkHMHcLy
         H7SeseU/EK3Hbz924BhwO1IMXNiU0Nz1K+pE1HxCbxqK5Af3LNRlHvwZfbsBX6281QzY
         RpY1K4yF7LUQNMJ7vBgi2ovARMCUgPhRS38z3zIp64cbqyxnAUiThZG5vQz7mhOdH6X1
         svErGDN648SGdDlydd0/cizoKQ/F4D9c+MDusYZI37ySSc7BV20gnkMA7ITyB4YDowV6
         +X4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727590234; x=1728195034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKLiR5gYmZwZmfgs+vGwBtpwK5USPFATr2yD/8gCPKI=;
        b=prsT1rz9foC5PvJMBd/luAV/mco3IoyzsA1blrk3INN9b8YbYta/o7syPDo4SzPaO4
         fyvG5lZP2LFr72ZX9xWAc4OBMoOOK8uqBS6uRPnsTV/oSMknVhcyKXh/Ut3TQAMvpz8N
         KBjusk5rI8KjV9ULJ45StVbmPvMBmLLPVaycB45xNHnyYOoVjtmeGBPPkbpU54eNd6an
         tJHjX7k14S8drH8O0P7ucBTUHtDk9CCAtyKkXEPJp99yU79u4hxk/ttV7k081QsmtSOF
         zBPLUBTMY/fq8uQrwX8RBXwH0H82A1dzITu4jY05J9F0EhoYn91CqRy8YtmCTOLbtXnR
         iUZg==
X-Forwarded-Encrypted: i=1; AJvYcCV8tnwgfd6RPsy3LC38I+U9nMCQMO+OY1ITg8bLRrZnq1I4R684Ov707YjprjP/YbKKmk+Shb98tcEueAdv@vger.kernel.org, AJvYcCXI488JylrHMTB+2I7++qBwYSCeSnEsbBPVnyc7QgM1Xhr/p4o3fWwbBueThAaJ/HFpHAHMfzohWe0t@vger.kernel.org
X-Gm-Message-State: AOJu0YzrmcqcqBYdy9K6U2oG7sKFGhOWZfFvRd7+TjKB1cg9rohOZLJ6
	LUyF0jjH3Hh4Go4ZXr9ud1FIq53rBAzErNj22QYCi7Fxn3U3CgKlUOZ1/BZ+
X-Google-Smtp-Source: AGHT+IHuhs9Kcf2V+igHziL1L5Hw5uJbO/yqgFJbHygqQCcJ8RtC/6BHGX+4wtceCMUQFmbirgH0Uw==
X-Received: by 2002:a05:6a21:78a1:b0:1cf:5471:bbe1 with SMTP id adf61e73a8af0-1d4fa7adecbmr6059094637.8.1727590233595;
        Sat, 28 Sep 2024 23:10:33 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2b974bsm4269584a12.34.2024.09.28.23.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 23:10:33 -0700 (PDT)
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
Subject: [PATCH v4 1/3] phy: rockchip: inno-usb2: convert clock management to bulk
Date: Sun, 29 Sep 2024 14:10:23 +0800
Message-ID: <20240929061025.3704-1-frawang.cn@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wang <frank.wang@rock-chips.com>

Since some Rockchip SoCs (e.g RK3576) have more than one clock,
this converts the clock management from single to bulk method to
make the driver more flexible.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
Changelog:
v4:
 - a new patch split from the [PATCH v3 2/2], suggestions from Heiko.

v1-v3:
 - none

 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 43 ++++++++++++++++---
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 4f71373ae6e1..ad3e65dc6aa4 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -229,9 +229,10 @@ struct rockchip_usb2phy_port {
  * @dev: pointer to device.
  * @grf: General Register Files regmap.
  * @usbgrf: USB General Register Files regmap.
- * @clk: clock struct of phy input clk.
+ * @clks: array of phy input clocks.
  * @clk480m: clock struct of phy output clk.
  * @clk480m_hw: clock struct of phy output clk management.
+ * @num_clks: number of phy input clocks.
  * @phy_reset: phy reset control.
  * @chg_state: states involved in USB charger detection.
  * @chg_type: USB charger types.
@@ -246,9 +247,10 @@ struct rockchip_usb2phy {
 	struct device	*dev;
 	struct regmap	*grf;
 	struct regmap	*usbgrf;
-	struct clk	*clk;
+	struct clk_bulk_data	*clks;
 	struct clk	*clk480m;
 	struct clk_hw	clk480m_hw;
+	int			num_clks;
 	struct reset_control	*phy_reset;
 	enum usb_chg_state	chg_state;
 	enum power_supply_type	chg_type;
@@ -310,6 +312,13 @@ static int rockchip_usb2phy_reset(struct rockchip_usb2phy *rphy)
 	return 0;
 }
 
+static void rockchip_usb2phy_clk_bulk_disable(void *data)
+{
+	struct rockchip_usb2phy *rphy = data;
+
+	clk_bulk_disable_unprepare(rphy->num_clks, rphy->clks);
+}
+
 static int rockchip_usb2phy_clk480m_prepare(struct clk_hw *hw)
 {
 	struct rockchip_usb2phy *rphy =
@@ -376,7 +385,9 @@ rockchip_usb2phy_clk480m_register(struct rockchip_usb2phy *rphy)
 {
 	struct device_node *node = rphy->dev->of_node;
 	struct clk_init_data init;
+	struct clk *refclk = NULL;
 	const char *clk_name;
+	int i;
 	int ret = 0;
 
 	init.flags = 0;
@@ -386,8 +397,15 @@ rockchip_usb2phy_clk480m_register(struct rockchip_usb2phy *rphy)
 	/* optional override of the clockname */
 	of_property_read_string(node, "clock-output-names", &init.name);
 
-	if (rphy->clk) {
-		clk_name = __clk_get_name(rphy->clk);
+	for (i = 0; i < rphy->num_clks; i++) {
+		if (!strncmp(rphy->clks[i].id, "phyclk", 6)) {
+			refclk = rphy->clks[i].clk;
+			break;
+		}
+	}
+
+	if (!IS_ERR(refclk)) {
+		clk_name = __clk_get_name(refclk);
 		init.parent_names = &clk_name;
 		init.num_parents = 1;
 	} else {
@@ -1406,18 +1424,29 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	if (IS_ERR(rphy->phy_reset))
 		return PTR_ERR(rphy->phy_reset);
 
-	rphy->clk = devm_clk_get_optional_enabled(dev, "phyclk");
-	if (IS_ERR(rphy->clk)) {
-		return dev_err_probe(&pdev->dev, PTR_ERR(rphy->clk),
+	ret = devm_clk_bulk_get_all(dev, &rphy->clks);
+	if (ret == -EPROBE_DEFER) {
+		return dev_err_probe(&pdev->dev, -EPROBE_DEFER,
 				     "failed to get phyclk\n");
 	}
 
+	/* Clocks are optional */
+	rphy->num_clks = ret < 0 ? 0 : ret;
+
 	ret = rockchip_usb2phy_clk480m_register(rphy);
 	if (ret) {
 		dev_err(dev, "failed to register 480m output clock\n");
 		return ret;
 	}
 
+	ret = clk_bulk_prepare_enable(rphy->num_clks, rphy->clks);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, rockchip_usb2phy_clk_bulk_disable, rphy);
+	if (ret)
+		return ret;
+
 	if (rphy->phy_cfg->phy_tuning) {
 		ret = rphy->phy_cfg->phy_tuning(rphy);
 		if (ret)
-- 
2.34.1


