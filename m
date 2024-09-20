Return-Path: <linux-kernel+bounces-334193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A74EE97D3B9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 11:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D947F1C21EB7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D247136658;
	Fri, 20 Sep 2024 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="p9qtnjco"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9690757F3
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726825030; cv=none; b=jmuN38D4D5IvXoLjr1iVol7VjeO2v+I/NNdh+4uC2uCd27A5zD0yjWV3nOlwRksM2vdeXeljsXuSkUWjpCwB/nyi9824asTxmxgWI5OmGMP044Oc1+6pjo7RH8cD3Chp9cd1XpaHiZSZi3eDWhRVTsaKPUEFdmW+jD5ugMa0um0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726825030; c=relaxed/simple;
	bh=mV/+H1lEiNypRkNS7WbBfGy8Vcp4NzoqAxsA3sdH28A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jVlg147h3kp9NvBVXqRJKa16zGUMcmQYX+/jJjwdcumEa30YIOSN0aadmOECrXJtbegHD0hDgjz8eahtHomA1dFVQyJX9jRlmzEUDODhbsB39Z98qEdUDCOEy8vTbr6cQNdzMGR8fKv/YXqoXWfuMViJncz+BNLsYI4vU+hfQ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=p9qtnjco; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=hgecV
	r+tVurwSxwGSHpG48Xb3t6wVc7vDsaAUV3Jteo=; b=p9qtnjcoi+vM0Tv0vp/Em
	/36FwMP8HaFvSgjTtW5WgN7OnA96dkDRnJtyR99G2H1CW0BsXd/jfpaNnRTIM0Wr
	U7/vMKDcAeNNbIZCPOCfKTJoOzFLH55OSRsZmY4CzTzua9wvIpnrgLdxf0rtYQll
	EiB3i1XFAr2LsQJpkTpxjk=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mta-g3-0 (Coremail) with SMTP id _____wDXH1MfQu1mJ+xaBg--.40480S2;
	Fri, 20 Sep 2024 17:36:34 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: vkoul@kernel.org
Cc: kishon@kernel.org,
	heiko@sntech.de,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	cristian.ciocaltea@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH] phy: phy-rockchip-samsung-hdptx: Don't request RST_PHY/RST_ROPLL/RST_LCPLL
Date: Fri, 20 Sep 2024 17:36:28 +0800
Message-ID: <20240920093629.7410-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXH1MfQu1mJ+xaBg--.40480S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr15JrWDZry3WF13ArykAFb_yoW8tFWfpF
	s3CF47JrWqgFn8Wa1UKFn8CFWxJF9IqF1YqFsxZa4xtr1xArWDuryruF95Xr1DJrW2qayF
	kw4xtFWfu3W2vwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UvAp5UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqQVgXmVODBPGLgAAsO

From: Andy Yan <andy.yan@rock-chips.com>

RST_PHY/RST_ROPLL/RST_LCPLL are used for debug only on rk3588,
and they are not exported on rk3576, no need to request it in
driver.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---
 .../phy/rockchip/phy-rockchip-samsung-hdptx.c   | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 946c01210ac8..f3f03914bf78 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -252,13 +252,10 @@ struct ropll_config {
 };
 
 enum rk_hdptx_reset {
-	RST_PHY = 0,
-	RST_APB,
+	RST_APB = 0,
 	RST_INIT,
 	RST_CMN,
 	RST_LANE,
-	RST_ROPLL,
-	RST_LCPLL,
 	RST_MAX
 };
 
@@ -655,11 +652,6 @@ static void rk_hdptx_phy_disable(struct rk_hdptx_phy *hdptx)
 {
 	u32 val;
 
-	/* reset phy and apb, or phy locked flag may keep 1 */
-	reset_control_assert(hdptx->rsts[RST_PHY].rstc);
-	usleep_range(20, 30);
-	reset_control_deassert(hdptx->rsts[RST_PHY].rstc);
-
 	reset_control_assert(hdptx->rsts[RST_APB].rstc);
 	usleep_range(20, 30);
 	reset_control_deassert(hdptx->rsts[RST_APB].rstc);
@@ -780,10 +772,6 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
 
 	rk_hdptx_pre_power_up(hdptx);
 
-	reset_control_assert(hdptx->rsts[RST_ROPLL].rstc);
-	usleep_range(20, 30);
-	reset_control_deassert(hdptx->rsts[RST_ROPLL].rstc);
-
 	rk_hdptx_multi_reg_write(hdptx, rk_hdtpx_common_cmn_init_seq);
 	rk_hdptx_multi_reg_write(hdptx, rk_hdtpx_tmds_cmn_init_seq);
 
@@ -958,13 +946,10 @@ static int rk_hdptx_phy_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(hdptx->regmap),
 				     "Failed to init regmap\n");
 
-	hdptx->rsts[RST_PHY].id = "phy";
 	hdptx->rsts[RST_APB].id = "apb";
 	hdptx->rsts[RST_INIT].id = "init";
 	hdptx->rsts[RST_CMN].id = "cmn";
 	hdptx->rsts[RST_LANE].id = "lane";
-	hdptx->rsts[RST_ROPLL].id = "ropll";
-	hdptx->rsts[RST_LCPLL].id = "lcpll";
 
 	ret = devm_reset_control_bulk_get_exclusive(dev, RST_MAX, hdptx->rsts);
 	if (ret)
-- 
2.34.1


