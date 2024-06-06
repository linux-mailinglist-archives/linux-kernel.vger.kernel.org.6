Return-Path: <linux-kernel+bounces-203782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54368FE071
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E94AA1C2425A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB2A13D2A9;
	Thu,  6 Jun 2024 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="SXN9Ece0"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2016813CF82;
	Thu,  6 Jun 2024 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660874; cv=none; b=Rfb9xDE+9s7mAsx9QoIi72BmsTWOVwBoE3TOpEey+uUpf1gF4KqDVogbwhjnS6ujw9PuzFvj7NZWu6x3Um3eb/EswVUoMCrnQzKAJAI+LerhaULTXCQLrN7EmL7gB26jePaka6DRnmaurQyAOeLBPvviMQno0HpyZQlrBl0aVio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660874; c=relaxed/simple;
	bh=UBkmGFtCTxUF1BotRo1j71xajS9LSy/3e74VtwfFhYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=arRh6ileZZQvz4skQHF6VyGvrydsNRZ1ImQHAjpdzLZDYqxDCxcaAvvc2Y0JA3vox3JSFM0FjcZyZ702pshBzZohO7qtUW9IbFwmjOLlA54rUkRAHJgcAjDSqEZLxEV34VYv3N+K+jtob/KKmY2Ov+pw8bHMKIh+Q6EU/oBWJfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=SXN9Ece0; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WWms8HVZIOvAc05XHHH+pWslve4mOHOukt9ISJZLU5w=; b=SXN9Ece0ZBT0vNsILoNPj6JQHO
	Y5yWIwU3/j32mSRdN3IxiFvFhphFWyfyUYx4uvAsu26Xnfs5eezFvuPHUVDPKPSyBUKSdQ540GCcT
	4UQBF3ht2HlRALgHG6Z3AnDTX+J0VmrjyKjHEEnBYbq6GMqZgTzLZAhSBBfdIcxiy1VHh8ZYQ75iL
	wNqbeZw2S0vLc+VtngOuFnkq1xP/e4alDIH+kl0z/Yv/OWjCf1fflnqiBo6uWQe3LYlTbBcWfpTlP
	9JINjK7wHWdd7JHdMsl3NyCFEDV8c95v3ladhVphWsk8ZSMga0R3hLGfAH5QwQ+/+VDu/QOtZdQQ7
	Eqc8XHVQ==;
Received: from [89.212.21.243] (port=51044 helo=localhost.localdomain)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1sF83c-00BWkF-0M;
	Thu, 06 Jun 2024 10:01:11 +0200
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
Subject: [PATCH v2 3/3] drm/panel: simple: Add PrimeView PM070WL4 support
Date: Thu,  6 Jun 2024 10:01:04 +0200
Message-Id: <20240606080104.3663355-3-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240606080104.3663355-1-primoz.fiser@norik.com>
References: <20240606080104.3663355-1-primoz.fiser@norik.com>
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
Changes in v2:
- sort alphabetically

 drivers/gpu/drm/panel/panel-simple.c | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index dcb6d0b6ced0..80cca841db15 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3567,6 +3567,32 @@ static const struct panel_desc powertip_ph800480t013_idf02  = {
 	.connector_type = DRM_MODE_CONNECTOR_DPI,
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
 static const struct drm_display_mode qd43003c0_40_mode = {
 	.clock = 9000,
 	.hdisplay = 480,
@@ -4725,6 +4751,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "powertip,ph800480t013-idf02",
 		.data = &powertip_ph800480t013_idf02,
+	}, {
+		.compatible = "primeview,pm070wl4",
+		.data = &primeview_pm070wl4,
 	}, {
 		.compatible = "qiaodian,qd43003c0-40",
 		.data = &qd43003c0_40,
-- 
2.25.1


