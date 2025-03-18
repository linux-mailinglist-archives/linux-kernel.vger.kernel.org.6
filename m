Return-Path: <linux-kernel+bounces-566160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F292A67404
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526C53B2EC3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A061720DD4B;
	Tue, 18 Mar 2025 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="m6EzrwZ9"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3E520A5E4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301428; cv=none; b=uLjJk2nIHQ7yOX/EKCK2yyIL+U8glABTvzMVJLNzAnFECs2q3xV4GHTQP8dvAuKBvX0OaXgL8Npn+q8i1MFTxdnRTEz7cWdmYvd0Zds7cUdWeM4yq3mpPRpV5SvLtXZKiYnOMLb3cq44h4bP74lPmBRX8IYjx3SMp/TubE20+ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301428; c=relaxed/simple;
	bh=SWYqymPKeDTlu6phGSOFR4MJR0iXqjVq5q8eAzMWs68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TnQKXtlmP1pcVj/SeLj+epfBe3ogyC+/oJyCiuK1Edq3eh22Yn8S2/GFrIH7RITyzLOCcR+Lnfq+8WEwNJ2W71al82Oxz4hQZ3OGDmcskc3gEYmVVnBBNvWabJtUY6ejZYrmzhgE+6r8Y3jqWao+m7zfDNlN3kqOwnOHtZ1sELw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=m6EzrwZ9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742301424;
	bh=SWYqymPKeDTlu6phGSOFR4MJR0iXqjVq5q8eAzMWs68=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m6EzrwZ9QIIF0/PfoITwAfzJx4Cwo/3/5uFym2zqeBuXfn73+U+PdrjQsHLsjq3EL
	 f7JrWSx7lLBcUwrtL6uuKJIsiLiiTmSppeCGOkf9M5cXaFjSklqAOU/ncGvXiEH+hG
	 0L7RbFnqxSrzORPV0La9S2DooT6hwZu9q5LyHCwNTGyywDWlYu/97+7LALBAyDX7SQ
	 b0ZWmDdXPcKRs+aXzrUS7zg4dzygDbhkYXIWABTELBOwbWdd3Z7FOU4cFTNm1NIjpS
	 fCztkenhHS5gjix62RU2AFSt7YSSeDjr5XPfdt6O+ZtcXyHqSgjnlUBISb1s15E5dh
	 gZdVav8KA2cSw==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 903B317E1067;
	Tue, 18 Mar 2025 13:37:04 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 18 Mar 2025 14:35:41 +0200
Subject: [PATCH v6 07/14] phy: rockchip: samsung-hdptx: Drop superfluous
 cfgs driver data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-phy-sam-hdptx-bpc-v6-7-8cb1678e7663@collabora.com>
References: <20250318-phy-sam-hdptx-bpc-v6-0-8cb1678e7663@collabora.com>
In-Reply-To: <20250318-phy-sam-hdptx-bpc-v6-0-8cb1678e7663@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2

The ->cfgs member has been introduced via commit f08d1c085638 ("phy:
phy-rockchip-samsung-hdptx: Don't use dt aliases to determine phy-id"),
but it is only used during probe() in order to setup ->phy_id.

Use a probe() local variable to store device match data and remove the
now unnecessary member from struct rk_hdptx_phy.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index c9f79c4e698cef405dd2b6a8c1071e296464c36e..2c0ae2442842fe84a86eba6815125be9d31cc41e 100644
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
@@ -1894,6 +1891,7 @@ static int rk_hdptx_phy_runtime_resume(struct device *dev)
 
 static int rk_hdptx_phy_probe(struct platform_device *pdev)
 {
+	const struct rk_hdptx_phy_cfg *cfgs;
 	struct phy_provider *phy_provider;
 	struct device *dev = &pdev->dev;
 	struct rk_hdptx_phy *hdptx;
@@ -1912,14 +1910,14 @@ static int rk_hdptx_phy_probe(struct platform_device *pdev)
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


