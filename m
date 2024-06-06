Return-Path: <linux-kernel+bounces-203736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D9D8FDFB9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2911F22916
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8561B13D890;
	Thu,  6 Jun 2024 07:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="q0q9hhYe"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0029B13C813;
	Thu,  6 Jun 2024 07:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658900; cv=none; b=uyVa1DoxfdljNuhzechZaM4HSoqccZlaY53b9L2LmZgl06lTkiSMIV3lyJbQwIu8ntNFNu/aRvES19MFkqWb6NyUGK+EI6FNyQz/v3DcC760KERgxaavVlsaXMgYkWv6+xwG8RIKgZwo8o56TgZ9J42nfx1H1nSRU6Mt76Fyr/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658900; c=relaxed/simple;
	bh=gzpeR/aDKk4/rmSePVOSh2xGINfYTlnwhOYX2fF2xBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RLaLHKwcKZdfPcSnmrS7Ofr1wMl7iBzxeE91+vKQbUftfcju+wAPZirR/jPKmbqWf1g5tq2j1nfNFoVYtR7Bwyri7mBlrORcndZcFilqvKoFm4DpQ6B8+hmwexqZqmOpZdzPW3xCGqBM8+9Ucmp3mzE6ak3r+1IBUCsYPwOla5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=q0q9hhYe; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VTgxacfD7Kv3ubzMVjuHcPh975t61WT/ZaDbjZptY8M=; b=q0q9hhYeMMHhHiwoe9/wYukJSL
	BU7CHHsUtos8ue3pVIX/GMq26RV2PoFx7L7e+RnW/w19WtOeNvKqBV0BeuuMyqa1ndkQ+8dfyBRox
	gV7/tkMieQRuv8w2JWllGes4zuHEzxnvC6JI4usqjKbGsT1wLGKNj43cmbZpao75xOOoRdwJS3SE4
	KO/6WfC1jE4A2l3AWufxuHc2Eesj0x5nTJQya5uWlMZrDIJhR03e4LXSjTv6tbjnW8hL0aRrkrzuU
	hyF3rQsjI1lEppLrlPAWHvqmV33nl9embV0WTJoOh/M4XNC3JPHI7tZKTPHGQc/WfkGRs7LAwwzsX
	HHPSgxXQ==;
Received: from [89.212.21.243] (port=52108 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1sF7Xl-00BQOL-2w;
	Thu, 06 Jun 2024 09:28:17 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: upstream@lists.phytec.de
Subject: [PATCH 3/3] drm/panel: simple: Add PrimeView PM070WL4 support
Date: Thu,  6 Jun 2024 09:28:14 +0200
Message-Id: <20240606072814.3572965-3-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240606072814.3572965-1-primoz.fiser@norik.com>
References: <20240606072814.3572965-1-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Add support for PrimeView PM070WL4 7.0" (800x480) TFT-LCD panel.
Datasheet can be found at [1].

[1] https://www.beyondinfinite.com/lcd/Library/Pvi/PM070WL4-V1.0.pdf

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index dcb6d0b6ced0..ea1a7ba3a5b6 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3513,6 +3513,32 @@ static const struct panel_desc pda_91_00156_a0  = {
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 };
 
+static const struct drm_display_mode primeview_pm070wl4_mode = {
+	.clock = 32000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 42,
+	.hsync_end = 800 + 42 + 128,
+	.htotal = 800 + 42 + 128 + 86,
+	.vdisplay = 480,
+	.vsync_start = 480 + 10,
+	.vsync_end = 480 + 10 + 2,
+	.vtotal = 480 + 10 + 2 + 33,
+	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+};
+
+static const struct panel_desc primeview_pm070wl4 = {
+	.modes = &primeview_pm070wl4_mode,
+	.num_modes = 1,
+	.bpc = 6,
+	.size = {
+		.width = 152,
+		.height = 91,
+	},
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE,
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+};
+
 static const struct drm_display_mode powertip_ph128800t006_zhc01_mode = {
 	.clock = 66500,
 	.hdisplay = 1280,
@@ -4719,6 +4745,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "pda,91-00156-a0",
 		.data = &pda_91_00156_a0,
+	}, {
+		.compatible = "primeview,pm070wl4",
+		.data = &primeview_pm070wl4,
 	}, {
 		.compatible = "powertip,ph128800t006-zhc01",
 		.data = &powertip_ph128800t006_zhc01,
-- 
2.25.1


