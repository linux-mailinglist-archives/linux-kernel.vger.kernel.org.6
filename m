Return-Path: <linux-kernel+bounces-360606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A28A2999D24
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E20C1F2500E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C90620A5C8;
	Fri, 11 Oct 2024 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzgCpQEW"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404D6209F2E;
	Fri, 11 Oct 2024 06:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629510; cv=none; b=kByQTzSvdnUW4cl4vBy549SFisH4qlWVdtCT8Pf9HechxKonB+VNkyTA2naqSPamtqgHJeKv6/Qjz/qUArU0FpPjIsLV/naUIloR6czSyH4s5XE62Bid2oVtid2gl6aKH289EQbKsXBLG2hM9y0DKXM+vW8pdHHrMSIFqrJG2u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629510; c=relaxed/simple;
	bh=mveF5OFUCCMuTMM+EMAHhBrzvd7W8z0qKBuM6cDQ4Og=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FyWG8b7e0ZBRBGh80iqmPYLnKTuBEISW5+7CByWIhUVeNWwho2hK7yovwv4vxYTyevKDKtsfcj7XHmR/q77SeqS7UEZsJAOCQsaVK6P2Um7ZplpySrcoGTArCv5H9p1C5lXwMlzEg8GeawobfygjCK93CTjHhbg1MnAtGww/5Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzgCpQEW; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e18b65fbeso82518b3a.1;
        Thu, 10 Oct 2024 23:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728629508; x=1729234308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vUd+ptjyv9QJ5lB7HGC0V0YSPXyHnn+kNuvjqh6RNSw=;
        b=dzgCpQEWDv3Ke0gDb80yYyBF5fuuebEHBJNpeIucFFV30QX9yE9fodhW/UPqkgqZXz
         tqoYjYS4wHVzYhcDApeMFzUc/SQcBBnOGL1BD3Oj+EcQN3BTtxBxE63Sa5js1UoYFrKn
         OhuHGMCwAAukmiuL3IL0WSo4f3lmsO2KDgdWNxwpwtpYrycfOeRop0XU3KmzAMyr0YgE
         AqoIm2T93JTpwOHBdOIDY9IF5RvRbErUCOmnzbm0nv6ocQOTpu3n6xubvcg/Uatm081d
         2pa0mmhzH05SpHhI2U2JTPGY/XiFZplFJgf/QfSozHtDwsukwyixO4m05WJ53iY7x7+J
         9jQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728629508; x=1729234308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUd+ptjyv9QJ5lB7HGC0V0YSPXyHnn+kNuvjqh6RNSw=;
        b=WBkox58er3zPwTSZw9fNIpETq7SbJuIw8M6iDTS87nTU8VKnQSLV7bZfF80ehAu40E
         +/FFKzXBLr2i3Uv9pQ1vlSIgimsFNGa6lIHYSClhgctkhOVnL43EY6PdpeoenSHXuDjd
         gbKSjgzR47D/7/KP4VRSLzm9tb2zNrGzGcNimxnQBcbYole761qvLGqO2pyEmDpnC7tA
         iA4GqUHDWt1bHHX2FLa2vQajyEqqiuJvzetNewlDZDskcBMbbMiu6OpML3Ce6c5qws8u
         dgc6rISSnhW1O3OArGNia7FnBflhboOvDu8YkbVNKFzaYZIBYWFYCFIUn1Jfn9FA/XRM
         x5KA==
X-Forwarded-Encrypted: i=1; AJvYcCUiUvtE07MBPr7sEAsVa45LueXnpSKa+gwGBoX3XD56AFAK0E8AlGDe+I+/j2iwCALI/mGWdZ/23mY1FhFU@vger.kernel.org, AJvYcCXnCE2BcMTUKnVX+TVg5xhz9kLdLhccS8qW4H2Oo+ElC9Y/cHJlBEpc6kvqORTqLc0uKPsjeiVnU3V5@vger.kernel.org
X-Gm-Message-State: AOJu0YySN7iEZLDMX+l9cR0AhUE27vgfoVwK0lrupkc2xG4JTqqwgAVa
	rujQRp3gYyzXvRH5afMvk8GjoqySkfikDV1YebS/TYm92Ks0KYTm
X-Google-Smtp-Source: AGHT+IHjExOTWS+ut51FciTmYkVQWJwbGbZ+dp9P/ObMFftp08A8WqGSO9KFwxV+tjO4x0yePjh8LQ==
X-Received: by 2002:a05:6a00:8594:b0:718:e49f:4185 with SMTP id d2e1a72fcca58-71e38126090mr1026885b3a.7.1728629508440;
        Thu, 10 Oct 2024 23:51:48 -0700 (PDT)
Received: from localhost.localdomain ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2ab109e4sm2036099b3a.206.2024.10.10.23.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 23:51:48 -0700 (PDT)
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
Subject: [PATCH v5 1/3] phy: rockchip: inno-usb2: convert clock management to bulk
Date: Fri, 11 Oct 2024 14:51:38 +0800
Message-Id: <20241011065140.19999-1-frawang.cn@gmail.com>
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
---
Changelog:
V5:
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
2.45.2


