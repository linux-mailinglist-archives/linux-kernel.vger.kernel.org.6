Return-Path: <linux-kernel+bounces-552466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F147AA57A1E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 13:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB8217A45B3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE7E1DBB37;
	Sat,  8 Mar 2025 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KBsxvZxe"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65B11D61AC
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741436500; cv=none; b=ZHF5eEA3+Wm6XJ0OJh7PRIFVW68ezrRTCotimYxy3YbxSltfOGvswMs1VT+sKaEzKd7jZAxLgG5ltlr5A/ufpirE5hk7aY5mpK5qIGbWJn1DLjACrbu/YiwTDzbfLaJEkg483bcwL7K8mkNf4TmLoL8wTntLo0Mkkog3NcCLlIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741436500; c=relaxed/simple;
	bh=MrgqgIZ157jsElaeg3dFAoESeyFXV9vNfZmK9cHxL2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Izg+TvVgmm6j6FLsfehdTGVpFufZqbOVG+tFFQw6qfLSl99FDTGVUxARgxB6171eiaCEbqmQrQkvMD3d4Va6PLLchUFyrBJrYdTkEqfga0TtYYycMOx3I35Os5VEhST8RnbS4c5TeB4zAj677fPHoRxye3w9sM82f8mS8BH2hUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KBsxvZxe; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741436497;
	bh=MrgqgIZ157jsElaeg3dFAoESeyFXV9vNfZmK9cHxL2A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KBsxvZxe5BZH0eOrUVtnXUOm9hvk2iQlYpBkJSsUFj0TJYgBQJulDBC7WyX3giykq
	 X72v8nWZRzYdLgaDQ8ZSzOeExhtGfXA+BzZmTDFl/t0epsrR1QxvySR3KeiyVRzook
	 BiwqGzzDpqUGs+Eyn47JjMUMlCsWktH8HzmZ1Pqyaz5F7cm+Wvt7dCtqHofvE9sMgp
	 hRQfLgdlSGzr8EI81Dvu4mtRKtNZIaivo+nlXibOzZpsIH4VgTsHFSqZsFkCjp/+FI
	 3zmzohvHKJZrMCs7zHXkH7ZngHlLnhxj/F9s8biMT1FP6bhKjPzSieSanhTH4a9eJr
	 1doPs+c5MBn/Q==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 128CE17E0657;
	Sat,  8 Mar 2025 13:21:37 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 08 Mar 2025 14:21:15 +0200
Subject: [PATCH v5 06/12] phy: rockchip: samsung-hdptx: Drop superfluous
 cfgs driver data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-phy-sam-hdptx-bpc-v5-6-35087287f9d1@collabora.com>
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com>
In-Reply-To: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

The ->cfgs member has been introduced via commit f08d1c085638 ("phy:
phy-rockchip-samsung-hdptx: Don't use dt aliases to determine phy-id"),
but it is only used during probe() in order to setup ->phy_id.

Use a probe() local variable to store device match data and remove the
now unnecessary member from struct rk_hdptx_phy.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 06644c3d98d3f8b697fc704704df5acdd3c85bad..2bf525514c1991a1299265d12e1e85f66333c604 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -392,10 +392,7 @@ struct rk_hdptx_phy {
 	struct regmap *regmap;
 	struct regmap *grf;
 
-	/* PHY const config */
-	const struct rk_hdptx_phy_cfg *cfgs;
 	int phy_id;
-
 	struct phy *phy;
 	struct clk_bulk_data *clks;
 	int nr_clks;
@@ -1892,6 +1889,7 @@ static int rk_hdptx_phy_runtime_resume(struct device *dev)
 
 static int rk_hdptx_phy_probe(struct platform_device *pdev)
 {
+	const struct rk_hdptx_phy_cfg *cfgs;
 	struct phy_provider *phy_provider;
 	struct device *dev = &pdev->dev;
 	struct rk_hdptx_phy *hdptx;
@@ -1910,14 +1908,14 @@ static int rk_hdptx_phy_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(regs),
 				     "Failed to ioremap resource\n");
 
-	hdptx->cfgs = device_get_match_data(dev);
-	if (!hdptx->cfgs)
+	cfgs = device_get_match_data(dev);
+	if (!cfgs)
 		return dev_err_probe(dev, -EINVAL, "missing match data\n");
 
 	/* find the phy-id from the io address */
 	hdptx->phy_id = -ENODEV;
-	for (id = 0; id < hdptx->cfgs->num_phys; id++) {
-		if (res->start == hdptx->cfgs->phy_ids[id]) {
+	for (id = 0; id < cfgs->num_phys; id++) {
+		if (res->start == cfgs->phy_ids[id]) {
 			hdptx->phy_id = id;
 			break;
 		}

-- 
2.48.1


