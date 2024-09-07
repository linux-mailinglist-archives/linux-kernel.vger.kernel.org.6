Return-Path: <linux-kernel+bounces-319662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F64B970043
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 07:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC49F285B5E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 05:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D4E1311B5;
	Sat,  7 Sep 2024 05:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="q3O591lE"
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272F8200CB
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 05:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725688501; cv=none; b=pDSJ4PmjFCAOXwfegFtnDxYLLimK9KpEOJlcwxxfVElgAJ43eXQNv217/exX9fMlmbypOj1FRbBvRF+Tjp1ywmfSXF6Ic+fKaT5HXlLaMJQ46fQmsGLcIs8jpmXon+ycPRovfpvGMulCoyiEhPwLSIgMficycZrkm4E9EV41M3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725688501; c=relaxed/simple;
	bh=easwMnHXgH6K81SUaN+DwxmV9xjcNAXmtB7JfGCCqlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hzjWztDja2QmlgvpAgQrwzsKYssaLjX+04mkwFmMbaxZr66gLASvsrPO26hCDApsGHw5UmVwg3cDWMR4iiUGTzo2Rib/kSEMGyNWhv5uHdT7nvPVGWKdOTyW5sqJfHCtxah+GFbbZ70Rj/vq4a0JCXc2HrLDAwwksv5ZqO9iyCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=q3O591lE; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id AB4DC14C1E1;
	Sat,  7 Sep 2024 07:54:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1725688491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qj67ertlQRTeftmw+g9h4C2AnGK6C33+Vq5AG+IOQ2c=;
	b=q3O591lE2JGBwdtdtSQntarN2ZlH/P1P3gKgDcxSXQEEQc9LNmyKwIaaBIssWoBYPHvTFy
	3zJwvtJFNNpm8t+gcrfv9bnJ7VlXXcHhNL4xSaJX3aIXo+GZhCEj46Ybn5AnamgdC5Evz8
	Y+GiT9apL96eIU0cdS6rvt1A9QmD//UR4hkGY7J1QkmJlDYaRFZnD5VXUj7TFFWbPXx7/t
	1SPqrofM/N9ewj4zWf32a/xf7RctM4cgi8I7/rJPKGwN0eF3yJAxqzDsYp8CR8rjZSey0/
	skv5TflnSFlduQaMa50hrsCiDwEUzkQZA+To0SmhbQw+HrhjBqRfkBpv9sCD+w==
Received: from [127.0.0.1] (localhost.lan [::1])
	by gaia.codewreck.org (OpenSMTPD) with ESMTP id 6cf0701c;
	Sat, 7 Sep 2024 05:54:42 +0000 (UTC)
From: Dominique Martinet <asmadeus@codewreck.org>
Date: Sat, 07 Sep 2024 14:54:33 +0900
Subject: [PATCH v2] drm/bridge: imx8mp-hdmi-tx: allow 0.5% margin with
 selected clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240907-hdmi-tolerance-v2-1-b9d7abd89f5c@codewreck.org>
X-B4-Tracking: v=1; b=H4sIAJjq22YC/zWMwQ7CIBAFf8XsWRqgNFRP/ofpgcAqGwUUsNE0/
 Xexibc3L5lZoGAmLHDcLZBxpkIpNpD7HVhv4hUZucYguVT8wDXzLhCr6Y7ZRItMubHnWhk1CA1
 NemS80HsLnqfGnkpN+bP1Z/F7/ynFx17wvhNy0GrkTDCXAkV6vrALJleKWE+mtnljFa2PqbMpw
 LSu6xdNlPD1tgAAAA==
To: Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Adam Ford <aford173@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dominique Martinet <dominique.martinet@atmark-techno.com>
X-Mailer: b4 0.14-dev-87f09
X-Developer-Signature: v=1; a=openpgp-sha256; l=2120;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=nqr2dM1v6KRqxdCBlCHE8iSEaSRxPOverS1W33lMLzI=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBm2+qiwNG20vIXdu+YEeULa01ttlJy2QSvC7+R+
 q5lR89eNZCJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZtvqogAKCRCrTpvsapjm
 cCf/EAC4hi6ChKZlBaMMneNhA2qE4PdW2Keg3zZYWMKMWodNjPR+YBT6tLWWHh7AanTLVUyRzaV
 RdNbsaIL3GBy3Z7IGQ5lQeESlFZ9A9TMOQf8UxEgNPL4bd/oWyE1toTD8nyRqzjNdqjdfBf+iw1
 zv/TuvyicWWBKTSj9QNmJc7JQD42fbSMmsEhDZ0PSjViXNx7ZW9mqtLv/OkNePmqYqnNzz08T+v
 8V7DxK9Fpf6EH83bJFrJoZ0naeKb5W5UQ9uhCbSsxmYaowdt1ddwLrv+ZuoAvZqumcuEgVbwQYf
 3cZdJ0f+hvRtXzT8K1bLCJnk5yuFYHquQE/B4Jytol6LWsf+4igOtrQh3QW/DP+896lV7roSmHW
 WGBl7yQ1kb63VwlEG6/tvkUYs5z+vKHJpX4VW3GF62qTespjQ9aykP0fUuEKIcockq3jI+WEZev
 F3l2a/WmXIArf1jA/15TkPtc9AaB3zYrrBf2RJ7OGnx2ecX8Hxaao+nBD3KMNwwPi6lgDXwFauB
 pTLGt6Xbr38u3xtGbqjerCN+Ri7B2LQADXd6GYDhTeT5Gy0MUOYvs+ANVaXqSdvlj5d9q1kGKpe
 nuu5hqzt5ZGR7JAm5oHlZi+AwWKlxfqJ165Eg+PtClAPPzxhDXwFTMCKw8/cjMQnhsAU6Mwak1R
 m88KRhuEw3Hjlaw==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A

From: Dominique Martinet <dominique.martinet@atmark-techno.com>

This allows the hdmi driver to pick e.g. 64.8MHz instead of 65Mhz when we
cannot output the exact frequency, enabling the imx8mp HDMI output to
support more modes

Tested-by: Adam Ford <aford173@gmail.com> #imx8mp-beacon
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
Changes in v2:
- Improve comment about the tolerance
- Link to v1: https://lore.kernel.org/r/20240904083103.1257480-1-dominique.martinet@atmark-techno.com
---
 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
index 13bc570c5473..200d65184159 100644
--- a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
+++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
@@ -23,6 +23,7 @@ imx8mp_hdmi_mode_valid(struct dw_hdmi *dw_hdmi, void *data,
 		       const struct drm_display_mode *mode)
 {
 	struct imx8mp_hdmi *hdmi = (struct imx8mp_hdmi *)data;
+	long round_rate;
 
 	if (mode->clock < 13500)
 		return MODE_CLOCK_LOW;
@@ -30,8 +31,14 @@ imx8mp_hdmi_mode_valid(struct dw_hdmi *dw_hdmi, void *data,
 	if (mode->clock > 297000)
 		return MODE_CLOCK_HIGH;
 
-	if (clk_round_rate(hdmi->pixclk, mode->clock * 1000) !=
-	    mode->clock * 1000)
+	round_rate = clk_round_rate(hdmi->pixclk, mode->clock * 1000);
+	/* imx8mp's pixel clock generator (fsl-samsung-hdmi) cannot generate
+	 * all possible frequencies, so allow some tolerance to support more
+	 * modes.
+	 * Allow 0.5% difference allowed in various standards (VESA, CEA861)
+	 * 0.5% = 5/1000 tolerance (mode->clock is 1/1000)
+	 */
+	if (abs(round_rate - mode->clock * 1000) > mode->clock * 5)
 		return MODE_CLOCK_RANGE;
 
 	/* We don't support double-clocked and Interlaced modes */

---
base-commit: 67784a74e258a467225f0e68335df77acd67b7ab
change-id: 20240907-hdmi-tolerance-4d83074a4517

Best regards,
-- 
Dominique Martinet | Asmadeus


