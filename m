Return-Path: <linux-kernel+bounces-543071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDDDA4D12B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CE547A7669
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006D218DF62;
	Tue,  4 Mar 2025 01:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gr18z2ak"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DAC14900B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052670; cv=none; b=Ayp7IHPKILiNT9+IxizjYPsh4Tx3dE9m91IOGjZo55c5ryHF2VHpHc3i8yyiE06ttsOsaD68nGGw+1G1ymNGUk3S5saD4L9pMSNB842lhPYR8In97vxaDeWnjBA4bE2SoOedodx8dCUKT1rHvEGnY7IO7wjUIUSN4knGu55piCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052670; c=relaxed/simple;
	bh=MrgqgIZ157jsElaeg3dFAoESeyFXV9vNfZmK9cHxL2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RnRgvwwcPu9cUAOmVj0lTh7j8L8L8Ni7upIlv2zZs6WZp0ZmG29HzmNm1qefnd/4IfPD8Kd0ifjwNIJWLgITp8L1263BOwWDaeZjo6YNSrc1P4HmDz6J2arJ54XJT8cyNuIHgsNPXD1yFJXRYYpGsYgkaP2ytd+HO+AbanZc2fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gr18z2ak; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741052662;
	bh=MrgqgIZ157jsElaeg3dFAoESeyFXV9vNfZmK9cHxL2A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gr18z2akC5QqEA8/nx/lgtd8EIXDSnfG18I2aWVHmKMAu2lyj1uFiqgYS/QDGlg0q
	 BrIvwe6XjarK2xyHiAyEA6tDcnlEDkofwmrWASsLqDGPORaZYGxHh7fn6u201rhBdT
	 fgBQYRPXDZDf7L49jvhX64PA2SfkhZKVl0plq7iW4VNs4Km7Zh/mwUOJ0IN4MmebOF
	 rBw99m649HdFxnCwqrMRjzC76ugXu563LUwTz57oD3jMH1+gxSHp3ye7t8WvE+5RBv
	 PxCLAk8BxtjCiZyxVIxW8taIz4RlLs3YrLJ4jFsIeJTs4BaUO8gMEQq6Cv4c8gYKCm
	 6hUxT98KMsKdw==
Received: from localhost (unknown [188.27.58.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 8F23717E1016;
	Tue,  4 Mar 2025 02:44:22 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 04 Mar 2025 03:44:05 +0200
Subject: [PATCH v4 06/12] phy: rockchip: samsung-hdptx: Drop superfluous
 cfgs driver data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-phy-sam-hdptx-bpc-v4-6-8657847c13f7@collabora.com>
References: <20250304-phy-sam-hdptx-bpc-v4-0-8657847c13f7@collabora.com>
In-Reply-To: <20250304-phy-sam-hdptx-bpc-v4-0-8657847c13f7@collabora.com>
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


