Return-Path: <linux-kernel+bounces-215951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7380909928
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 19:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978FD1F22174
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 17:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEF8604BB;
	Sat, 15 Jun 2024 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="KSzzbqLZ"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A12C5A4FD
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718471166; cv=none; b=fNR4QaKgapw/QQNm3+UekdpJW9HJT/oxTzrs+0heG1CtxazI1HfeP3A7ZYgKjB8cQRosQZY9OARztQ3TTJp23qkkZcyEkZSI7y1cdreSzmz6rg86M3iJYi2G41Nh876qzFDoBBsSJ4I9s9WibceQS+wrrcDgYYlHoDqzJd9QBb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718471166; c=relaxed/simple;
	bh=9oUGBUIaW9FqYQAvbPURPNjhkhReskknSJGuaEpUksw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kC6TOXD87GzXfeH4LZbkTzGo0rvGhR1OmyheQjnFrm8pEao/dp8L/304QubgjLh53ohVBlkWpyQcPrcrwUs1g4nQOxI8VxGEhHH5K9K4B0pxIe6wOsWcyfsSngEC+blRZaqyKnp6aLnGdjS5rMg+UvqZvAu3WKNv0Qv9Ti5pVt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=KSzzbqLZ; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1718471125; bh=oBgtjth5/yflr6ntPsYuZ+MVQpYpZchrByL3dEYZAxA=;
 b=KSzzbqLZDYXyMEIMCHItVvD8iJWM/iEpDjZdWDhMvr4saTi0blstbTcM8liBum4xVw5aQyxWB
 hiAfooaqmiOBMjewaaKfz5ehZGBkFeZTMXYsv4jIIs5ymW55CT8XS/no7CfgxdRzUTg3KJ49RaE
 dbVYnBQq6ZQBDR83iTgHRu9slIEWu1RpvbXzyEh26Ep4ArEUfibDZzJLbDY0m8mJOmiZcqMG+XB
 bH/NuXxAfGlHyNCRbUJM2b7n+kW8LayieeUoKjb0RCNBwgRyVUbuMYl6Y1mplLIfjda9JmpBcpN
 /xehR3UYnY1z4Ig0MneUK3y7CNAHmAAwcjpvCh8lj85w==
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
Subject: [PATCH 12/13] drm/rockchip: dw_hdmi: Enable 4K@60Hz mode on RK3399 and RK356x
Date: Sat, 15 Jun 2024 17:04:03 +0000
Message-ID: <20240615170417.3134517-13-jonas@kwiboo.se>
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
 167.172.40.54
X-ForwardEmail-ID: 666dc9cf24e0254b398040ab

Use a maximum TMDS clock rate limit of 594MHz to enable use of HDMI2.0
modes, e.g. 4K@60Hz, on RK3399 and RK3568.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index d9886b1c299c..b255b8ceedb7 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -493,7 +493,7 @@ static struct rockchip_hdmi_chip_data rk3399_chip_data = {
 	.lcdsel_grf_reg = RK3399_GRF_SOC_CON20,
 	.lcdsel_big = HIWORD_UPDATE(0, RK3399_HDMI_LCDC_SEL),
 	.lcdsel_lit = HIWORD_UPDATE(RK3399_HDMI_LCDC_SEL, RK3399_HDMI_LCDC_SEL),
-	.max_tmds_clock = 340000,
+	.max_tmds_clock = 594000,
 };
 
 static const struct dw_hdmi_plat_data rk3399_hdmi_drv_data = {
@@ -507,7 +507,7 @@ static const struct dw_hdmi_plat_data rk3399_hdmi_drv_data = {
 
 static struct rockchip_hdmi_chip_data rk3568_chip_data = {
 	.lcdsel_grf_reg = -1,
-	.max_tmds_clock = 340000,
+	.max_tmds_clock = 594000,
 };
 
 static const struct dw_hdmi_plat_data rk3568_hdmi_drv_data = {
-- 
2.45.2


