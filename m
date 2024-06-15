Return-Path: <linux-kernel+bounces-215943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EA890991F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 19:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8921F2212B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 17:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6557C5A4FD;
	Sat, 15 Jun 2024 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="b2iV5b79"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3C34D584
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718471110; cv=none; b=T5hlmquhzghDvL5BGIOrWkEHiWENbB8Ua6VWUcojhlE5gg5QJamEPrvNEWfYZfm4L2SsZDIDRaFlGmEJSmTvpYHJOiD29oP4LvgR7fLW5BbwcU93xTByNPe5l+f6gvh44BQ/9kiXueyOvm4OCcT2dOIAJYenwqakJSinqq8J5k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718471110; c=relaxed/simple;
	bh=QBifK6M0l9aE0r87cBAzqr57WDVsLSszt4v4WQtYxL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MI14M3FoiyCHZdWzLqL7gigLAaN61LfUlqHoB1kSgHaaidfTYI592XFBGWXx3bQ3QOwQvPXqJVwodPgIVxElBPIkQ3LwbcnKwjlGsSTE8/BkxpWBZlC7gC6ydrEX92IunvZ6M8OiXhchMc3VW5NSiomD56IwNhD/EpnetT4C2+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=b2iV5b79; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1718471093; bh=BeNUhMeywog7bd6GhDGutHucpUbeatl4//PsQAMTER0=;
 b=b2iV5b79YLwntOIIK9dwVOGQX4dlmrqiQjTDw/2pvxEPm/2Mmb19Tb1mrjMXD5RdKrB6JNpB/
 0G/+edN4yucHSvXyVvLxqlg5NuNhANTil12MwFco0xgZJG4HGxDBWDQl5Zzz4tsZw/fZJ7Y3GF3
 00eb3bhkSNC5+nxUKJizpKPGEHpZ6Hs7uq157jtLGughoEyCP2vvKLkTWJ7xKA7QG0/9jD32CCt
 4XlAAv4G/mh95xpwaZLFUNA5Ets5GcMS5IzdV0oLQsZyUW4yYYrTFcGQc0eNBPZxIESncktva+8
 KE949JhftNNmU+601kcJ73MO09rsRDk/AehrOmxYpT9A==
From: Jonas Karlman <jonas@kwiboo.se>
To: dri-devel@lists.freedesktop.org, Sandy Huang <hjc@rock-chips.com>,
 "=?UTF-8?q?Heiko=20St=C3=BCbner?=" <heiko@sntech.de>, Andy Yan
 <andy.yan@rock-chips.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH 06/13] drm/rockchip: dw_hdmi: Add max_tmds_clock validation
Date: Sat, 15 Jun 2024 17:03:57 +0000
Message-ID: <20240615170417.3134517-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240615170417.3134517-1-jonas@kwiboo.se>
References: <20240615170417.3134517-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 666dc9b324e0254b3980403f

Add max_tmds_clock validation to prepare for additions and changes to
the MPLL config table. Use the same rate restrictions that is currently
applied.

The rate limit for RK3288, RK3399 and RK3568 is based on current mpll
table. The rate limit for RK3228 and RK3228 is based on the
inno-hdmi-phy pre-pll table.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 5df9c9a0d369..75b5d63ec570 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -61,11 +61,13 @@
  * @lcdsel_grf_reg: grf register offset of lcdc select
  * @lcdsel_big: reg value of selecting vop big for HDMI
  * @lcdsel_lit: reg value of selecting vop little for HDMI
+ * @max_tmds_clock: maximum TMDS clock rate supported
  */
 struct rockchip_hdmi_chip_data {
 	int	lcdsel_grf_reg;
 	u32	lcdsel_big;
 	u32	lcdsel_lit;
+	int	max_tmds_clock;
 };
 
 struct rockchip_hdmi {
@@ -259,6 +261,10 @@ dw_hdmi_rockchip_mode_valid(struct dw_hdmi *dw_hdmi, void *data,
 	bool exact_match = hdmi->plat_data->phy_force_vendor;
 	int i;
 
+	if (hdmi->chip_data->max_tmds_clock &&
+	    mode->clock > hdmi->chip_data->max_tmds_clock)
+		return MODE_CLOCK_HIGH;
+
 	if (hdmi->ref_clk) {
 		int rpclk = clk_round_rate(hdmi->ref_clk, pclk);
 
@@ -450,6 +456,7 @@ static const struct dw_hdmi_phy_ops rk3228_hdmi_phy_ops = {
 
 static struct rockchip_hdmi_chip_data rk3228_chip_data = {
 	.lcdsel_grf_reg = -1,
+	.max_tmds_clock = 594000,
 };
 
 static const struct dw_hdmi_plat_data rk3228_hdmi_drv_data = {
@@ -467,6 +474,7 @@ static struct rockchip_hdmi_chip_data rk3288_chip_data = {
 	.lcdsel_grf_reg = RK3288_GRF_SOC_CON6,
 	.lcdsel_big = HIWORD_UPDATE(0, RK3288_HDMI_LCDC_SEL),
 	.lcdsel_lit = HIWORD_UPDATE(RK3288_HDMI_LCDC_SEL, RK3288_HDMI_LCDC_SEL),
+	.max_tmds_clock = 340000,
 };
 
 static const struct dw_hdmi_plat_data rk3288_hdmi_drv_data = {
@@ -487,6 +495,7 @@ static const struct dw_hdmi_phy_ops rk3328_hdmi_phy_ops = {
 
 static struct rockchip_hdmi_chip_data rk3328_chip_data = {
 	.lcdsel_grf_reg = -1,
+	.max_tmds_clock = 594000,
 };
 
 static const struct dw_hdmi_plat_data rk3328_hdmi_drv_data = {
@@ -505,6 +514,7 @@ static struct rockchip_hdmi_chip_data rk3399_chip_data = {
 	.lcdsel_grf_reg = RK3399_GRF_SOC_CON20,
 	.lcdsel_big = HIWORD_UPDATE(0, RK3399_HDMI_LCDC_SEL),
 	.lcdsel_lit = HIWORD_UPDATE(RK3399_HDMI_LCDC_SEL, RK3399_HDMI_LCDC_SEL),
+	.max_tmds_clock = 340000,
 };
 
 static const struct dw_hdmi_plat_data rk3399_hdmi_drv_data = {
@@ -518,6 +528,7 @@ static const struct dw_hdmi_plat_data rk3399_hdmi_drv_data = {
 
 static struct rockchip_hdmi_chip_data rk3568_chip_data = {
 	.lcdsel_grf_reg = -1,
+	.max_tmds_clock = 340000,
 };
 
 static const struct dw_hdmi_plat_data rk3568_hdmi_drv_data = {
-- 
2.45.2


