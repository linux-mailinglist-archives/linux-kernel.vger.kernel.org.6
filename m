Return-Path: <linux-kernel+bounces-443866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60D79EFCF0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A7916BB9B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EED1CEAAC;
	Thu, 12 Dec 2024 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PbZpRZva"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1571AF0B4
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734033847; cv=none; b=QeHqNSICYelSiwVNw8+itwoWVh0CA1U1jPZDUQJpOm8xJYNXsb5EYU+lfFKSwhO0uPKx/S4gKf86+VUNNJxEhzWFRmBDMjs3mNlud3eLKT+Gtd6TRTjcTPB4cg5l5grjpPQkwTuAtWbmmN16M28NPR2L+y86BILH2BdoDijaZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734033847; c=relaxed/simple;
	bh=eiLyDs1Cws2RP0BvIrC5NeMzsZe0Xq5QuroNohKca7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nmueejJTrrVwOWVWiQbJ7Xl6p8JCoZQ5ucYvvGyrYEobb2rahitfj9auyhpBlzSEK0lAfTExlm18ba/delT+vlCL8bahXMvwR17LwcR4mbrcFXJjMJy6kPz416U41X/5HE+5pDvZUzo1gIrFUMcFbYuR2Tuz4dtswrcQceTIVbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PbZpRZva; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734033837;
	bh=eiLyDs1Cws2RP0BvIrC5NeMzsZe0Xq5QuroNohKca7k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PbZpRZvabpKyLpLmRzTdR8g+xlmXqZ0aPx8YxEiPiyUqcSPAlP6vYho0arRoHO5Fn
	 5ykW/33O8xfx8VT/4x9NMUuJkEkAGCJoexyrDjdcHncOauGlcfuo+ppGrDovhji+T3
	 5CtMXeR2vpSPkMpEsbMvoM6J8WCJ6t6A20r/nyZN4Dtt27omD7n6k4U/0MIVjMc+ri
	 J1yQuPTa9HYS0LbJ2YnNXfy3mEHvPzjmDG1/D9aRjUh3jNDcxi55uZeP7pMgfIYfsf
	 MNml8FlDNTWwHskURiypNL2LeeRzG3IjreFPO7uiU2IkuIUmnQfjl9V90+LaYRiOWL
	 13dDDSf1/JymQ==
Received: from localhost (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A9FBC17E3800;
	Thu, 12 Dec 2024 21:03:57 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 12 Dec 2024 22:03:35 +0200
Subject: [PATCH v2 4/8] phy: rockchip: samsung-hdptx: Drop unused
 lcpll_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-phy-sam-hdptx-bpc-v2-4-57e672c7c7c4@collabora.com>
References: <20241212-phy-sam-hdptx-bpc-v2-0-57e672c7c7c4@collabora.com>
In-Reply-To: <20241212-phy-sam-hdptx-bpc-v2-0-57e672c7c7c4@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

This is just a leftover from downstream support for HDMI 2.1.
Remove the unused struct for now.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 31 -----------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 089020df5b4b8f9b44d272fa87a66e0f2c8ccaba..1f5b7ffc0c5c47def33c93736bb1bd1491cd59d0 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -195,37 +195,6 @@
 #define HDMI14_MAX_RATE			340000000
 #define HDMI20_MAX_RATE			600000000
 
-struct lcpll_config {
-	u32 bit_rate;
-	u8 lcvco_mode_en;
-	u8 pi_en;
-	u8 clk_en_100m;
-	u8 pms_mdiv;
-	u8 pms_mdiv_afc;
-	u8 pms_pdiv;
-	u8 pms_refdiv;
-	u8 pms_sdiv;
-	u8 pi_cdiv_rstn;
-	u8 pi_cdiv_sel;
-	u8 sdm_en;
-	u8 sdm_rstn;
-	u8 sdc_frac_en;
-	u8 sdc_rstn;
-	u8 sdm_deno;
-	u8 sdm_num_sign;
-	u8 sdm_num;
-	u8 sdc_n;
-	u8 sdc_n2;
-	u8 sdc_num;
-	u8 sdc_deno;
-	u8 sdc_ndiv_rstn;
-	u8 ssc_en;
-	u8 ssc_fm_dev;
-	u8 ssc_fm_freq;
-	u8 ssc_clk_div_sel;
-	u8 cd_tx_ser_rate_sel;
-};
-
 struct ropll_config {
 	u32 bit_rate;
 	u8 pms_mdiv;

-- 
2.47.0


