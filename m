Return-Path: <linux-kernel+bounces-254821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92859933820
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159581F242CE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C6C1CFA9;
	Wed, 17 Jul 2024 07:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="CxJpjL3R"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168FD22611
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721201888; cv=none; b=LGBihnC39NSyDOaAj3ZoxsCfHUEmiu1SD9xwpwuVSQjf8JES2OaIEeIOPl9i6Cv5xkCBTtHoyI6sM+Zw2wY2DKjOUvgfslUUP29rOa8aqy0KLoeuQz+Ls8R4VxqlnejpS/KmgBAsp4wvym5UvsBZ4+GCTBv41fExIFxSQf/6Kz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721201888; c=relaxed/simple;
	bh=NfW9E+9udbaFW0Xfzeu1jNi/c5H6HNfBcCDZsH32cc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LS6lrUTigTqIdXbcjD+JavrEuX8FeS2YlCCZ0IpHol5FnGTH/w4PPojrvIpUAurn6KgOAm8BUolAl6rV/19/zMboyjmQaYWfWXjy95vMDMPxmsboYP/mCMzGe1zRX8WVNm3V3SFlKxVIM0WRy4G+s/LQGYZ0l86F+7ntQssiBzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=CxJpjL3R; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1721201542; bh=NfW9E+9udbaFW0Xfzeu1jNi/c5H6HNfBcCDZsH32cc8=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=CxJpjL3RBYLQrit/gdkd/mGQ2YLevo5vqyYlVW5ukJT3htQV5LK+ZC4FPJqlaIH1z
	 0G/gM5CaqS7oyDMwsP5DV0K7MN2LPV7lvErkXBxpdZJPRBFajE4OKFHwCg7X0AyA15
	 w0PG8ya3rfX9PWHqrxGiROQ5CojTiFNhUuXHYhvo=
Date: Wed, 17 Jul 2024 09:32:20 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org, 
	heiko@sntech.de, hjc@rock-chips.com, andy.yan@rock-chips.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: dsi: Reset ISP1 DPHY before powering it on
Message-ID: <pb477qi34clwdvrdrdparff5jvl6emdje3aswpylovejh2wx3q@vzwju366kkji>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, heiko@sntech.de, hjc@rock-chips.com, andy.yan@rock-chips.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <6e0ce232acfe952970e9b37402fe08a3678aa43a.1721196758.git.dsimic@manjaro.org>
 <e79cbc94804e93464be62e7731def4fa@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4uwqjbpmf6525br4"
Content-Disposition: inline
In-Reply-To: <e79cbc94804e93464be62e7731def4fa@manjaro.org>


--4uwqjbpmf6525br4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 17, 2024 at 08:48:29AM GMT, Dragan Simic wrote:
> Hello all,
> 
> On 2024-07-17 08:29, Dragan Simic wrote:
> > From: Ondrej Jirman <megi@xff.cz>
> > 
> > After a suspend and resume cycle, ISP1 stops receiving data, as observed
> > on the Pine64 PinePhone Pro, which is based on the Rockchip RK3399 SoC.
> > Re-initializing DPHY during the PHY power-on, if the SoC variant
> > supports
> > initialization, fixes this issue.
> > 
> > [ dsimic: Added more details to the commit summary and description ]
> > 
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> > ---
> >  drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> > b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> > index 4cc8ed8f4fbd..9ad48c6dfac3 100644
> > --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> > +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> > @@ -1240,6 +1240,14 @@ static int dw_mipi_dsi_dphy_power_on(struct phy
> > *phy)
> >  		goto err_phy_cfg_clk;
> >  	}
> > 
> > +	if (dsi->cdata->dphy_rx_init) {
> > +		ret = dsi->cdata->dphy_rx_init(phy);
> > +		if (ret < 0) {
> > +			DRM_DEV_ERROR(dsi->dev, "hardware-specific phy init failed: %d\n",
> > ret);
> > +			goto err_pwr_on;
> > +		}
> > +	}
> > +
> >  	/* do soc-variant specific init */
> >  	if (dsi->cdata->dphy_rx_power_on) {
> >  		ret = dsi->cdata->dphy_rx_power_on(phy);
> 
> After thinking a bit more about this patch in its original form [1]
> that's preserved above, I think it would be better to move the
> additional DPHY initialization to dw_mipi_dsi_rockchip_resume(),
> because that function seems to be the right place for such fixes.
> 
> Please, let me know your thoughts.

That also works (see attachment) to fix the original issue in the commit
message, but if you keep the stream on across suspend/resume it does halt so
it's not a complete solution either.

Kind regards,
	o.

> [1] https://megous.com/git/linux/commit/?h=orange-pi-6.9&id=ed7992f668a1e529719ee6847ca114f9b67efacb

--4uwqjbpmf6525br4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-drm-rockchip-dw-mipi-dsi-rockchip-Restore-DPHY-confi.patch"

From 4db7a9a913bb4b78094d7845295d2c3306513c56 Mon Sep 17 00:00:00 2001
From: Ondrej Jirman <megi@xff.cz>
Date: Wed, 17 Jul 2024 09:30:39 +0200
Subject: [PATCH] drm: rockchip: dw-mipi-dsi-rockchip: Restore DPHY config on
 resume

After a suspend and resume cycle, ISP1 stops receiving data, as observed on the
Pine64 PinePhone Pro, which is based on the Rockchip RK3399 SoC. Re-initializing
DPHY during resume, if the SoC variant supports initialization, fixes this
issue.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 51 ++++++++++++-------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 364b738b6935..c2b58e545080 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -1118,6 +1118,31 @@ static const struct component_ops dw_mipi_dsi_rockchip_dphy_ops = {
 	.unbind	= dw_mipi_dsi_rockchip_dphy_unbind,
 };
 
+static int dw_mipi_dsi_dphy_rx_init(struct dw_mipi_dsi_rockchip *dsi)
+{
+	int ret;
+
+	if (dsi->cdata->dphy_rx_init) {
+		ret = clk_prepare_enable(dsi->pclk);
+		if (ret < 0)
+			return ret;
+
+		ret = clk_prepare_enable(dsi->grf_clk);
+		if (ret) {
+			clk_disable_unprepare(dsi->pclk);
+			return ret;
+		}
+
+		ret = dsi->cdata->dphy_rx_init(dsi->dphy);
+		clk_disable_unprepare(dsi->grf_clk);
+		clk_disable_unprepare(dsi->pclk);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int dw_mipi_dsi_dphy_init(struct phy *phy)
 {
 	struct dw_mipi_dsi_rockchip *dsi = phy_get_drvdata(phy);
@@ -1138,23 +1163,9 @@ static int dw_mipi_dsi_dphy_init(struct phy *phy)
 	if (ret < 0)
 		goto err_graph;
 
-	if (dsi->cdata->dphy_rx_init) {
-		ret = clk_prepare_enable(dsi->pclk);
-		if (ret < 0)
-			goto err_init;
-
-		ret = clk_prepare_enable(dsi->grf_clk);
-		if (ret) {
-			clk_disable_unprepare(dsi->pclk);
-			goto err_init;
-		}
-
-		ret = dsi->cdata->dphy_rx_init(phy);
-		clk_disable_unprepare(dsi->grf_clk);
-		clk_disable_unprepare(dsi->pclk);
-		if (ret < 0)
-			goto err_init;
-	}
+	ret = dw_mipi_dsi_dphy_rx_init(dsi);
+	if (ret < 0)
+		goto err_init;
 
 	return 0;
 
@@ -1337,6 +1348,12 @@ static int __maybe_unused dw_mipi_dsi_rockchip_resume(struct device *dev)
 			dw_mipi_dsi_rockchip_config(dsi->slave);
 
 		clk_disable_unprepare(dsi->grf_clk);
+	} else if (dsi->usage_mode == DW_DSI_USAGE_PHY) {
+		ret = dw_mipi_dsi_dphy_rx_init(dsi);
+		if (ret < 0) {
+			DRM_DEV_ERROR(dsi->dev, "hardware-specific phy init failed: %d\n", ret);
+			return ret;
+		}
 	}
 
 	return 0;
-- 
2.45.2


--4uwqjbpmf6525br4--

