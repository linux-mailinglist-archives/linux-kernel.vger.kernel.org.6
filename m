Return-Path: <linux-kernel+bounces-320278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BA4970848
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52EA8283C47
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92DF171671;
	Sun,  8 Sep 2024 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="ZWFw9OF1"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DF5175D27
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725807369; cv=none; b=kVBCD61AZY0omSx/t80rIDnl9oxAC9QY7ezm8boLbg1GVvZGwPghbxCmV9v/oJAMcvYkNR/81WVQ9eE/45xmzLudS+O/r5fbIcTGnWPg+zsIJcW9h80MxidCtBd1dQH249r3UtzBmDxS5E9FvaZ8GZeAKvd0kpzQWinKNKT9rJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725807369; c=relaxed/simple;
	bh=A2AxR9xSRjg/K7y3Z60Yb5AJMbrkD6IZDJS9jfCAxSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKnTU/SmrhMhdNf6rOxX8ZY70gA/vtaVihg/mocYv7Or8kCQ47YX0QoTJ61D33wF3ygzrXrepFf+mnWJZHBv2FvD7NtKXF2NV8BTewpMKMB2L7xDVO1wR2O7vOoyBicetFITXRqtVCvrUXR1QP1uXZliu5shflTPv+nWcdnl4gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=ZWFw9OF1; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1725807347; bh=Z2Cb05mWFWfLkKZu5GopUYFl3Iafbmet5hEZs8+nUeA=;
 b=ZWFw9OF16J2MAEap+3I5h+/az2xi/wHRm7DllMZjY0aQd7sjFlUhM/H+FinAB7Km48FhKRnqw
 IGE8v5JowRdcX9XWgyYCHMbu//+nXvqEh035H/W5T2z9N//axANOb9VN93Ed53+TKtEUOOGepKe
 Jq8Glb3tWa4tZ95gXSAxiXbnj71SFioMLm1QpXPlOZDkaH9UjMa8sdik2yQYEkPDS9NDi2cx9zn
 wuj0njHuyUpbrrybPmuLJty8WSJK8htzDrI+/xG/jAm9oweo6QjhwyI5s70HEkfRik5epconors
 yF/T92FDl+eRPSSIQs4EoKjzkcDyB9ueUgUvHqcjtwdg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Sandy Huang <hjc@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Diederik de Haas <didi.debian@cknow.org>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 6/7] drm/rockchip: dw_hdmi: Enable 4K@60Hz mode on RK3399 and RK356x
Date: Sun,  8 Sep 2024 14:55:03 +0000
Message-ID: <20240908145511.3331451-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240908145511.3331451-1-jonas@kwiboo.se>
References: <20240908145511.3331451-1-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 66ddbaf13c9877b459588eff

Use a maximum TMDS clock rate limit of 594MHz to enable use of HDMI2.0
modes, e.g. 4K@60Hz, on RK3399 and RK3568.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Diederik de Haas <didi.debian@cknow.org> # Quartz64 Model B
---
v2: Collect t-b tag
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 090d8c0f306f..96e1097f993d 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -481,7 +481,7 @@ static struct rockchip_hdmi_chip_data rk3399_chip_data = {
 	.lcdsel_grf_reg = RK3399_GRF_SOC_CON20,
 	.lcdsel_big = HIWORD_UPDATE(0, RK3399_HDMI_LCDC_SEL),
 	.lcdsel_lit = HIWORD_UPDATE(RK3399_HDMI_LCDC_SEL, RK3399_HDMI_LCDC_SEL),
-	.max_tmds_clock = 340000,
+	.max_tmds_clock = 594000,
 };
 
 static const struct dw_hdmi_plat_data rk3399_hdmi_drv_data = {
@@ -495,7 +495,7 @@ static const struct dw_hdmi_plat_data rk3399_hdmi_drv_data = {
 
 static struct rockchip_hdmi_chip_data rk3568_chip_data = {
 	.lcdsel_grf_reg = -1,
-	.max_tmds_clock = 340000,
+	.max_tmds_clock = 594000,
 };
 
 static const struct dw_hdmi_plat_data rk3568_hdmi_drv_data = {
-- 
2.46.0


