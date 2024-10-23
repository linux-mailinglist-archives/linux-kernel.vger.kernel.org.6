Return-Path: <linux-kernel+bounces-378597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C779AD2F0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D405528170E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5464A1CCEE3;
	Wed, 23 Oct 2024 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WXXer3mx"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD9312D758
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704621; cv=none; b=pVvLSTBHk1lzPqFCuswTZjpCbNdcm1AcJnrtzUuqG7z5v42M0dRBLqLVRXafwVFJDUwC4LPy7+pbavU3ChND1hv2yHVF+FsUmnRhHiqbqbfhnNCB2h1RtxrdHUOtUiQ/n8NpwBIvl9rWs13btXPnVerE/ZKc9SdCq92gaupydjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704621; c=relaxed/simple;
	bh=jldwutBZphTyZk0A97ZTFnQDd2dt3KyWgWlWpUn/IUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ShtqGTaJpqxb2hFmkXgNvFCqSAhhgiWPOad1VyTMrenTpEDmoII9zayTDF7pyTKAu1ah3btvJBeeNBAl8MPq3w7jqUWzwK9Vh25FQjYYqCfoNvOR+flcIz0Mv6mvz5ElnlM2IIUzvHRuJzUyVJrEWeXvLK36AlJM/+rNZ3ahCFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WXXer3mx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729704617;
	bh=jldwutBZphTyZk0A97ZTFnQDd2dt3KyWgWlWpUn/IUc=;
	h=From:Date:Subject:To:Cc:From;
	b=WXXer3mxLwPsYMZxNw9mWDbOAg3QNt38De98+ntsBMfnBefHqWHfLAXK7zW/14la6
	 MrHjtgwdSHVqBUo0NddBvx/r+ywiPZr7RYTK2Em55dHjJddihCgqBOiboJpkOev4Bh
	 ayH+RFgwRxaCCvddEBgublFj9w2gvaNFdxHn61/w/jfnbBbpUNaMiTaMtNscUcsZf0
	 RsStV0BFm48EZt4JYZz33YHtJJN4KyWh8/6iWEaquYVUmwdLVrKC1pkrcSyKPkwsjg
	 52pztVODxNSYYudtf+EdKHn/zxQEhA+yKovARBGmZLYPteZrRNDkRhu6Fz877pyCxJ
	 Sgx3LHmqYN/WA==
Received: from localhost (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 98EB517E36A7;
	Wed, 23 Oct 2024 19:30:17 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 23 Oct 2024 20:29:54 +0300
Subject: [PATCH] phy: rockchip: samsung-hdptx: Set drvdata before enabling
 runtime PM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-phy-sam-hdptx-rpm-fix-v1-1-87f4c994e346@collabora.com>
X-B4-Tracking: v=1; b=H4sIAJEyGWcC/x2MSQqAMBDAviJzdqCLuH1FPLiMdg5qaUUqpX+3e
 EwgieDJMXnoiwiOHvZ8nRlkWcBipnMn5DUzKKEqKZRGa17004FmtXdAZw/cOOCsatFVWuhGtpB
 b6yjr/zuMKX3FircFZwAAAA==
X-Change-ID: 20241023-phy-sam-hdptx-rpm-fix-b26094303718
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
X-Mailer: b4 0.14.2

In some cases, rk_hdptx_phy_runtime_resume() may be invoked before
platform_set_drvdata() is executed in ->probe(), leading to a NULL
pointer dereference when using the return of dev_get_drvdata().

Ensure platform_set_drvdata() is called before devm_pm_runtime_enable().

Reported-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Fixes: 553be2830c5f ("phy: rockchip: Add Samsung HDMI/eDP Combo PHY driver")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index ceab9c71d3b53ae0b746a10c081fcfaa7d5c5ae7..0965b9d4f9cf1926ba2aaa54c3d1b105ecd1a5a2 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -1101,6 +1101,8 @@ static int rk_hdptx_phy_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(hdptx->grf),
 				     "Could not get GRF syscon\n");
 
+	platform_set_drvdata(pdev, hdptx);
+
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
@@ -1110,7 +1112,6 @@ static int rk_hdptx_phy_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(hdptx->phy),
 				     "Failed to create HDMI PHY\n");
 
-	platform_set_drvdata(pdev, hdptx);
 	phy_set_drvdata(hdptx->phy, hdptx);
 	phy_set_bus_width(hdptx->phy, 8);
 

---
base-commit: ceab669fdf7b7510b4e4997b33d6f66e433a96db
change-id: 20241023-phy-sam-hdptx-rpm-fix-b26094303718


