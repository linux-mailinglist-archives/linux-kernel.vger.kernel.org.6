Return-Path: <linux-kernel+bounces-552469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CCAA57A22
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 13:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D9DA7A33AF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BC61DE3DE;
	Sat,  8 Mar 2025 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YsAF97MA"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6111DD886
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741436504; cv=none; b=kZnQnbnH5mpDA/NjSJb8GXY3rLRoGGqqHQWA87zQh1jsTArK6nxw/21/awHA+Sz1Q3kIHB+skflJtr/F9C7r9QdCqS3fZvd/V4bc4yVmx0Qe6BGuwxY8gEEdjceiIAKm+sf/LXRD/fyurdnKc8rVfP22KOWUG0h77pSh3nGOibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741436504; c=relaxed/simple;
	bh=0FuXuMBDjykjoq5VV54ZEwRLpazRtku0RrRekgTkR+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BEcp8rSlq32C4vCpFbW/TDJHZPTTjO4OOo/Eif1xBoOvIyUNKKrRjLKRbSg8Z3YS7OyoNvesjetljjz5fyYRbrHNubD/pmEJrxROQ9pxa+4ksEIVDDgAsBMeiOGjjPvLSyThT+OKBihwaC04MTOKitmOIl1cA2I5QkXarH/X62U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YsAF97MA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741436500;
	bh=0FuXuMBDjykjoq5VV54ZEwRLpazRtku0RrRekgTkR+c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YsAF97MABdtkSsi63QVC4BRWfWMDB4Ra8ztxKhfWN9T6fbVZ0DttqDUVVgby/EEEi
	 TzTRrOrgqQJ/tDnTQNMV/3JCaojWrRNSa1V0x1JgBjHx01DGjC1SJGnSOqRqT4DI+6
	 GtpG+tv85SJ3m5wXbA3/4+LEbFc4QKq0og75N8iHcBZ2v70BK13jYXYh/dVmhhD027
	 udUKjRGxK6wBjqeyJg/jpCU6+i5Cir2W4cJLXdOSglXkhp8GO63rrwOIvPD49FbleY
	 mY5iQid1KSYEVe4fT9iua1VFdS6/QJ8CW/jR0a3UzXsGU9JKjHVJ7SDffRL1vpGdkf
	 q/tuz9kL7C1/w==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id B776417E0B12;
	Sat,  8 Mar 2025 13:21:40 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 08 Mar 2025 14:21:18 +0200
Subject: [PATCH v5 09/12] phy: rockchip: samsung-hdptx: Provide config
 params validation support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-phy-sam-hdptx-bpc-v5-9-35087287f9d1@collabora.com>
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

Implement the phy_ops.validate() callback to allow checking the PHY
configuration parameters without actually applying them.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 04c344394cbea89150bc4432cf26530fa9d71678..0e1391b4c8bdb9cd0facfc80999929700579d667 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -1797,10 +1797,22 @@ static int rk_hdptx_phy_configure(struct phy *phy, union phy_configure_opts *opt
 	return 0;
 }
 
+static int rk_hdptx_phy_validate(struct phy *phy, enum phy_mode mode,
+				 int submode, union phy_configure_opts *opts)
+{
+	struct rk_hdptx_phy *hdptx = phy_get_drvdata(phy);
+
+	if (mode != PHY_MODE_DP)
+		return rk_hdptx_phy_verify_hdmi_config(hdptx, &opts->hdmi);
+
+	return rk_hdptx_phy_verify_dp_config(hdptx, &opts->dp);
+}
+
 static const struct phy_ops rk_hdptx_phy_ops = {
 	.power_on  = rk_hdptx_phy_power_on,
 	.power_off = rk_hdptx_phy_power_off,
 	.configure = rk_hdptx_phy_configure,
+	.validate  = rk_hdptx_phy_validate,
 	.owner	   = THIS_MODULE,
 };
 

-- 
2.48.1


