Return-Path: <linux-kernel+bounces-367467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB229A02B8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED08E287561
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB1F1BB69E;
	Wed, 16 Oct 2024 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThLFZ97n"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C282E433CE;
	Wed, 16 Oct 2024 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064244; cv=none; b=u4gVFmzYtoELGpi4XIphPIc9lFFtcjS8oDvJOYGuZZSoAthn4r5yzAv+yXC6DWTR6lZdUVzqKY+Wld7QnORu1xvo4QlEom94RWR7vHailC90PTKbVWhWGJW1OIX+teNv2eH48J+ly5rK5IHLRfz5ODdxHRHcgt0IpREN/uHrcUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064244; c=relaxed/simple;
	bh=AkU+mwo4PueuXIkywuPtWE6fc5jDfreESswpmpPmqqw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BK0ype8tBPe4L2kpjZ7f10Qyc8gia/lybn6/4JbigjwCC1CylwuyIpdociU3msPFWI65zktcbkuFOmLO1iKQf+eHncHm5d7HVPxMoikLBfx/y7v0Lzh+edJs4YgImZNHljgprfg43q2yi/b7RuAws+OYQXob3SIBTvdj2pCxqr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThLFZ97n; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2d1b7bd57so546511a91.1;
        Wed, 16 Oct 2024 00:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729064242; x=1729669042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tE76eFeF0w5KNSCI8LEUq1pGIui/CIG/PhuBZfyVnmM=;
        b=ThLFZ97nAH5rmyyEA+6cfg/FzZ6DIt5PQpz7uFLid0L4FuMi6BZPsbNlxlzdqXGWls
         Nlxa0hQ+4o2lYNnNJicG083y061RS5YbX+whyjWTT6DGrmx9BSGxbd2AKQOn3sMGhM0w
         rM2RmtN09fuxG5DeIrOp4/l5xACyqO3cUQDHEugT8ENX2VbKnqd9qw8WcXIcAEkyiadA
         ZNZAj1fB8sE7IiNj9+J0dOYsUDPJCXZELkdawFtwLskcbBtSUFS3DIGmb+PHWV1pGkqz
         e88eWMPdWy62N2aLto4mPug3PXWvojciG3e+AFYQvL6ok8Nlh1Xk2v9sbhBqEDpzCfFf
         tYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729064242; x=1729669042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tE76eFeF0w5KNSCI8LEUq1pGIui/CIG/PhuBZfyVnmM=;
        b=kibYnUET6/thxbAodZTjxQcUwty1nlmZR2vkcgzNH252JaJ4k/qgBYfk75ITsoDk8I
         Zq7Rb/8+8M3D//hBNPXsHwPv19Nui2P59MNuYXzg27K8utMBYtBIeAdYPCz8v76EsbI7
         4uCFTSOPDKej8se9qN+lXCINv4iwyX/2tVmytRqOB3AAS2BrWq2wAcmSNu0kGClNgVBv
         s/ey2rAlDaZ4ScjQ2WRzmZsihasBGfChxU0QDhtBgoy16uEer58dTm8rYr8v9bjsJAPw
         5MD9ecYhmNffc0+yhPitrh+f98UrzIclqlrKvzpSMOP3D0CuFIXZ3us/Cs02hs46r2Zn
         6phA==
X-Forwarded-Encrypted: i=1; AJvYcCU7QaTEGTM640MhhRFlSW+3z7NWFI0MSXA20pQxh/e/qOq64XfiV+OL7zgIp0DT5+cX5zxGBcA7rvTGjeUY@vger.kernel.org, AJvYcCXUdJzGn/f20G+7ZtNL/13EkD1l6asJcPjMCd78w8Iduvq9zzNybSSFRdWhUWemWwxna5FqCqmxmEdV@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk1J+HTLqAED8oat2YWBd111w/Hw8X7gNIgf7Gr0EnEW8YwrXh
	e1463klsvwuEUQbkrGwJb8SLcsalB/jc3gVaKyB01o2ahqq9/hQT
X-Google-Smtp-Source: AGHT+IEhzIpQMDtfFdV12qVQsmmk7szjHI+s/s4R35Hmx1nztSoglJmv993u13LVpMZmItO0dLlVng==
X-Received: by 2002:a17:90b:1d01:b0:2e3:1af7:6ead with SMTP id 98e67ed59e1d1-2e31af76f40mr7378844a91.5.1729064241915;
        Wed, 16 Oct 2024 00:37:21 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3b7e6339fsm765471a91.1.2024.10.16.00.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 00:37:21 -0700 (PDT)
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
Subject: [PATCH v6 1/4] phy: rockchip: inno-usb2: convert clock management to bulk
Date: Wed, 16 Oct 2024 15:37:10 +0800
Message-Id: <20241016073713.14133-1-frawang.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
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
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
Changelog:
v6:
 - add Reviewed tag.

v5:
 - use dev_err_probe() in clock enable error path in probe.

v4:
 - a new patch split from the [PATCH v3 2/2], suggestions from Heiko.

v1-v3:
 - none

 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 45 +++++++++++++++----
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 6e5214862b8a3..f71266c27091e 100644
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
@@ -1399,15 +1417,26 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	if (IS_ERR(rphy->phy_reset))
 		return PTR_ERR(rphy->phy_reset);
 
-	rphy->clk = devm_clk_get_optional_enabled(dev, "phyclk");
-	if (IS_ERR(rphy->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(rphy->clk),
-				     "failed to get phyclk\n");
+	ret = devm_clk_bulk_get_all(dev, &rphy->clks);
+	if (ret == -EPROBE_DEFER)
+		return dev_err_probe(&pdev->dev, -EPROBE_DEFER,
+				     "failed to get phy clock\n");
+
+	/* Clocks are optional */
+	rphy->num_clks = ret < 0 ? 0 : ret;
 
 	ret = rockchip_usb2phy_clk480m_register(rphy);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to register 480m output clock\n");
 
+	ret = clk_bulk_prepare_enable(rphy->num_clks, rphy->clks);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable phy clock\n");
+
+	ret = devm_add_action_or_reset(dev, rockchip_usb2phy_clk_bulk_disable, rphy);
+	if (ret)
+		return ret;
+
 	if (rphy->phy_cfg->phy_tuning) {
 		ret = rphy->phy_cfg->phy_tuning(rphy);
 		if (ret)
-- 
2.25.1


