Return-Path: <linux-kernel+bounces-419371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CC09D6D0E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 09:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E72281328
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 08:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C2018871E;
	Sun, 24 Nov 2024 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJVS0OOP"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A7E4317C;
	Sun, 24 Nov 2024 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732435391; cv=none; b=RuuyvtpFRBzlAKzKvSC/gNqxcOHI2oXa46uQ0MMn/Tyct4TRX0OkYb4MlwvlWNXCtGmb9iv2FcZtV3POez7QTBhQ2jeeVtc/EDMZXg2jhfpHzI6hSVCDvZNzdJ4fH1+Q0dKG5gEPGV9N+DCk6j4SCAOQ3YfgKmVobhqbH5ToUzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732435391; c=relaxed/simple;
	bh=VZ8M1+TiMJv+r8qO3ZAAO8ddmK6rlwYlLANpNDkSBmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgN6hRy3lstHllEkElQd6CgyZBgDoKJPfRkoGGTRnASJbiU7w/FTsWFdVVCXnZh95jX3C/B9Pb7TmULFZNckfiMV4xSybNXvuZFvmEsaIAucXETHIBkfAXTmHcLlXxHzbbCxCu50SOSSMtNrK4gSIhmscoe0qDy6+JW6lV6ohNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJVS0OOP; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ea568d8216so2928777a91.1;
        Sun, 24 Nov 2024 00:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732435389; x=1733040189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJaU43LFRCDyKvRjkCcyaCdSHzxt2a/9xCIi14y8W8A=;
        b=UJVS0OOPqDjobre83J4SaOrhQsfXytv7rrdPYwss8rT4S0RwodCg2QZ04I09pC3dcO
         d4Qi+5Ef1bN2V7WSwp1HXdtNVsWuUOUgYdP/LgH5GjLclJT0INO75ffEIgILLIm9Bdqm
         WwfGGvp3oUDP1Xawc0kqDPEZL6jI4FS1lzXX4oWfA9Pp4iWD4u26YavUF9lMVMMJDHej
         tViJZxbenOWJryTr5wlfgFczX0Pgn9n7NR8fQ/FvaahocCH/WJx30QF0jaDXngoJ3O1F
         ALSaGH89rsG2gztY3Sjrm/fg186tditjAX2BROgfYztZSpZiO5RrCcOmnAHFQDZMT0GM
         6ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732435389; x=1733040189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJaU43LFRCDyKvRjkCcyaCdSHzxt2a/9xCIi14y8W8A=;
        b=NqYyPqCArF8y+Dl8AxLZjxs/D1ZkQFwDHi0vLX7vTz7qy/bd/PX2yU8CMlAq1KPmCy
         iPSEx4zgEt2colFWX5eoUceZQslUZ7qEEnyyDSzFDTpr+pGBUS+h1ZFysf/WRr0I+c7D
         tcfmSoPkUaq43kw2GPCA7NYZLVA4og+a4D62zeG3bQZtjPdSOkZhGvEaVO/hgXsePg/T
         tAxSds+Ijex96A7GEvXCyNEnJcgSjzYsBy+3FLUWD0QhEZwbf+YLzn0AsvjekaqCQFIG
         PxlswSD7wmgRZ4FJJvc4WECLrdWvBFuxoZyiLIf8Ja1+iLUJ7gSMj9YenFSYFv0KW/6j
         Ph1g==
X-Forwarded-Encrypted: i=1; AJvYcCVIqTk7YmZAOWks0dFAdaRm3HVKOCOsnkkTxvWm6uV6mjdRmI9f7Jj335h+XnaLwEP+rFy5NiQ4I3hD@vger.kernel.org
X-Gm-Message-State: AOJu0YyVpl1v1gN7CohBMXhHiimYZMFe1wxhNx+DHpSYYgNd9q/m4QZT
	UdVdAG2XWop9ER7IVy1o22wSlWHPX3XuJcxCP2HsNyNGpjpXcKV+IQMRQCOENFk=
X-Gm-Gg: ASbGncvPEROnuhXPTtF0yNaLSjflpVM0eWMG7d1PEemafrj026VBANzBxIVP5T8tLKA
	Qu57vO48CLb7KewuMgjsD/iVyRdKhSzDo8oi7g11yBs0eab6dyXYojsZqfYtDzmCa4//bU6ZLVt
	qbz1HDd2bO2krC3VWixRGu7dF/9/Cy3XzbQCQ5ACt/rUdqUrBe4Jdtgn9W74ot82923LgCHwsCo
	81AxDrm3xijaIXO4FfjH6KEq0A4vWUraEIBvlgmpJD0laukNz+fg/u87mZk9RQ=
X-Google-Smtp-Source: AGHT+IEO9ptaDWmBRPMLzcmvU4PWU/axbQE1OQ1Sr/gONRNYdOccAQiOB5lc61VPrhdDcwaqGC9e+w==
X-Received: by 2002:a17:90b:4b84:b0:2ea:4578:46de with SMTP id 98e67ed59e1d1-2eb0e52845cmr11193033a91.20.1732435389159;
        Sun, 24 Nov 2024 00:03:09 -0800 (PST)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:fa8f:7c3e:835f:c642])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead03de6f6sm7956708a91.34.2024.11.24.00.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 00:03:08 -0800 (PST)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Christophe Branchereau <cbranchereau@gmail.com>,
	Ryan Walklin <ryan@testtoast.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/6] drm: panel: nv3052c: Add another panel for RG35XX Plus (Rev6)
Date: Sun, 24 Nov 2024 17:02:13 +0900
Message-ID: <20241124080220.1657238-3-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241124080220.1657238-1-kikuchan98@gmail.com>
References: <20241124080220.1657238-1-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a display panel used in the recent revision of the Anbernic
RG35XX Plus, a handheld gaming device from Anbernic.
It is 3.45 inches in size (diagonally) with a resolution of 640x480.

It has the same interface (pins and connector) as the panel of the former
revision of RG35XX Plus, but they differ in their init-sequence. So add
it as a new panel.

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 .../gpu/drm/panel/panel-newvision-nv3052c.c   | 178 ++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
index 06e16a7c14a..166393ccfed 100644
--- a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
+++ b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
@@ -629,6 +629,156 @@ static const struct nv3052c_reg wl_355608_a8_panel_regs[] = {
 	{ 0x36, 0x0a }, // bgr = 1, ss = 1, gs = 0
 };
 
+static const struct nv3052c_reg ylm_lbv0345001h_v2_panel_regs[] = {
+	// EXTC Command set enable, select page 1
+	{ 0xff, 0x30 }, { 0xff, 0x52 }, { 0xff, 0x01 },
+	// Mostly unknown registers
+	{ 0xe3, 0x00 },
+	{ 0x0a, 0x01 },
+	{ 0x23, 0x00 }, // RGB interface control: DE+SYNC MODE PCLK-N
+	{ 0x24, 0x10 },
+	{ 0x25, 0x09 },
+	{ 0x28, 0x47 },
+	{ 0x29, 0x01 },
+	{ 0x2a, 0xdf },
+	{ 0x38, 0x9c }, // VCOM_ADJ1
+	{ 0x39, 0xa7 }, // VCOM_ADJ2
+	{ 0x3a, 0x3f }, // VCOM_ADJ3
+	{ 0x91, 0x77 }, // EXTPW_CTRL2
+	{ 0x92, 0x77 }, // EXTPW_CTRL3
+	{ 0xa0, 0x55 },
+	{ 0xa1, 0x50 },
+	{ 0xa4, 0x9c },
+	{ 0xa7, 0x02 },
+	{ 0xa8, 0x01 },
+	{ 0xa9, 0x01 },
+	{ 0xaa, 0xfc },
+	{ 0xab, 0x28 },
+	{ 0xac, 0x06 },
+	{ 0xad, 0x06 },
+	{ 0xae, 0x06 },
+	{ 0xaf, 0x03 },
+	{ 0xb0, 0x08 },
+	{ 0xb1, 0x26 },
+	{ 0xb2, 0x28 },
+	{ 0xb3, 0x28 },
+	{ 0xb4, 0x03 },
+	{ 0xb5, 0x08 },
+	{ 0xb6, 0x26 },
+	{ 0xb7, 0x08 },
+	{ 0xb8, 0x26 },
+	// EXTC Command set enable, select page 2
+	{ 0xff, 0x30 }, { 0xff, 0x52 }, { 0xff, 0x02 },
+	// Set gray scale voltage to adjust gamma
+	{ 0xb0, 0x02 }, // PGAMVR0
+	{ 0xb1, 0x0f }, // PGAMVR1
+	{ 0xb2, 0x11 }, // PGAMVR2
+	{ 0xb3, 0x32 }, // PGAMVR3
+	{ 0xb4, 0x36 }, // PGAMVR4
+	{ 0xb5, 0x3c }, // PGAMVR5
+	{ 0xb6, 0x20 }, // PGAMPR0
+	{ 0xb7, 0x3e }, // PGAMPR1
+	{ 0xb8, 0x0e }, // PGAMPK0
+	{ 0xb9, 0x05 }, // PGAMPK1
+	{ 0xba, 0x11 }, // PGAMPK2
+	{ 0xbb, 0x11 }, // PGAMPK3
+	{ 0xbc, 0x13 }, // PGAMPK4
+	{ 0xbd, 0x14 }, // PGAMPK5
+	{ 0xbe, 0x16 }, // PGAMPK6
+	{ 0xbf, 0x0e }, // PGAMPK7
+	{ 0xc0, 0x17 }, // PGAMPK8
+	{ 0xc1, 0x07 }, // PGAMPK9
+	{ 0xd0, 0x02 }, // NGAMVR0
+	{ 0xd1, 0x10 }, // NGAMVR0
+	{ 0xd2, 0x12 }, // NGAMVR1
+	{ 0xd3, 0x33 }, // NGAMVR2
+	{ 0xd4, 0x36 }, // NGAMVR3
+	{ 0xd5, 0x3c }, // NGAMVR4
+	{ 0xd6, 0x20 }, // NGAMPR0
+	{ 0xd7, 0x3e }, // NGAMPR1
+	{ 0xd8, 0x0d }, // NGAMPK0
+	{ 0xd9, 0x05 }, // NGAMPK1
+	{ 0xda, 0x12 }, // NGAMPK2
+	{ 0xdb, 0x11 }, // NGAMPK3
+	{ 0xdc, 0x14 }, // NGAMPK4
+	{ 0xdd, 0x14 }, // NGAMPK5
+	{ 0xde, 0x18 }, // NGAMPK6
+	{ 0xdf, 0x0f }, // NGAMPK7
+	{ 0xe0, 0x17 }, // NGAMPK8
+	{ 0xe1, 0x08 }, // NGAMPK9
+	// EXTC Command set enable, select page 3
+	{ 0xff, 0x30 }, { 0xff, 0x52 }, { 0xff, 0x03 },
+	// Set various timing settings
+	{ 0x07, 0x03 }, // GIP_VST_8
+	{ 0x08, 0x00 }, // GIP_VST_9
+	{ 0x09, 0x01 }, // GIP_VST_10
+	{ 0x30, 0x00 }, // GIP_CLK_1
+	{ 0x31, 0x00 }, // GIP_CLK_2
+	{ 0x32, 0x00 }, // GIP_CLK_3
+	{ 0x33, 0x00 }, // GIP_CLK_4
+	{ 0x34, 0x61 }, // GIP_CLK_5
+	{ 0x35, 0xd4 }, // GIP_CLK_6
+	{ 0x36, 0x24 }, // GIP_CLK_7
+	{ 0x37, 0x03 }, // GIP_CLK_8
+	{ 0x40, 0x02 }, // GIP_CLKA_1
+	{ 0x41, 0x03 }, // GIP_CLKA_2
+	{ 0x42, 0x04 }, // GIP_CLKA_3
+	{ 0x43, 0x05 }, // GIP_CLKA_4
+	{ 0x44, 0x11 }, // GIP_CLKA_5
+	{ 0x45, 0xe6 }, // GIP_CLKA_6
+	{ 0x46, 0xe7 }, // GIP_CLKA_7
+	{ 0x47, 0x11 }, // GIP_CLKA_8
+	{ 0x48, 0xe8 }, // GIP_CLKA_9
+	{ 0x49, 0xe9 }, // GIP_CLKA_10
+	{ 0x50, 0x06 }, // GIP_CLKB_1
+	{ 0x51, 0x07 }, // GIP_CLKB_2
+	{ 0x52, 0x08 }, // GIP_CLKB_3
+	{ 0x53, 0x09 }, // GIP_CLKB_4
+	{ 0x54, 0x11 }, // GIP_CLKB_5
+	{ 0x55, 0xea }, // GIP_CLKB_6
+	{ 0x56, 0xeb }, // GIP_CLKB_7
+	{ 0x57, 0x11 }, // GIP_CLKB_8
+	{ 0x58, 0xec }, // GIP_CLKB_9
+	{ 0x59, 0xed }, // GIP_CLKB_10
+	// Map internal GOA signals to GOA output pad
+	{ 0x82, 0x00 }, // PANELU2D3
+	{ 0x83, 0x00 }, // PANELU2D4
+	{ 0x84, 0x02 }, // PANELU2D5
+	{ 0x85, 0x00 }, // PANELU2D6
+	{ 0x86, 0x1f }, // PANELU2D7
+	{ 0x87, 0x00 }, // PANELU2D8
+	{ 0x88, 0x1f }, // PANELU2D9
+	{ 0x89, 0x0e }, // PANELU2D10
+	{ 0x8a, 0x0e }, // PANELU2D11
+	{ 0x8b, 0x10 }, // PANELU2D12
+	{ 0x8c, 0x10 }, // PANELU2D13
+	{ 0x8d, 0x0a }, // PANELU2D14
+	{ 0x8e, 0x0a }, // PANELU2D15
+	{ 0x8f, 0x0c }, // PANELU2D16
+	{ 0x90, 0x0c }, // PANELU2D17
+	{ 0x98, 0x00 }, // PANELU2D25
+	{ 0x99, 0x00 }, // PANELU2D26
+	{ 0x9a, 0x01 }, // PANELU2D27
+	{ 0x9b, 0x00 }, // PANELU2D28
+	{ 0x9c, 0x1f }, // PANELU2D29
+	{ 0x9d, 0x00 }, // PANELU2D30
+	{ 0x9e, 0x1f }, // PANELU2D31
+	{ 0x9f, 0x0d }, // PANELU2D32
+	{ 0xa0, 0x0d }, // PANELU2D33
+	{ 0xa1, 0x0f }, // PANELU2D34
+	{ 0xa2, 0x0f }, // PANELU2D35
+	{ 0xa3, 0x09 }, // PANELU2D36
+	{ 0xa4, 0x09 }, // PANELU2D37
+	{ 0xa5, 0x0b }, // PANELU2D38
+	{ 0xa6, 0x0b }, // PANELU2D39
+	// EXTC Command set enable, select page 0
+	{ 0xff, 0x30 }, { 0xff, 0x52 }, { 0xff, 0x00 },
+	// Interface Pixel Format
+	{ 0x3a, 0x77 },
+	// Display Access Control
+	{ 0x36, 0x0a }, // bgr = 1, ss = 1, gs = 0
+};
+
 static inline struct nv3052c *to_nv3052c(struct drm_panel *panel)
 {
 	return container_of(panel, struct nv3052c, panel);
@@ -881,6 +1031,21 @@ static const struct drm_display_mode wl_355608_a8_mode[] = {
 	},
 };
 
+static const struct drm_display_mode ylm_lbv0345001h_v2_mode[] = {
+	{
+		.clock = 24000,
+		.hdisplay = 640,
+		.hsync_start = 640 + 84,
+		.hsync_end = 640 + 84 + 20,
+		.htotal = 640 + 84 + 20 + 26,
+		.vdisplay = 480,
+		.vsync_start = 480 + 32,
+		.vsync_end = 480 + 32 + 4,
+		.vtotal = 480 + 32 + 4 + 5,
+		.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+	},
+};
+
 static const struct nv3052c_panel_info ltk035c5444t_panel_info = {
 	.display_modes = ltk035c5444t_modes,
 	.num_modes = ARRAY_SIZE(ltk035c5444t_modes),
@@ -914,10 +1079,22 @@ static const struct nv3052c_panel_info wl_355608_a8_panel_info = {
 	.panel_regs_len = ARRAY_SIZE(wl_355608_a8_panel_regs),
 };
 
+static const struct nv3052c_panel_info ylm_lbv0345001h_v2_panel_info = {
+	.display_modes = ylm_lbv0345001h_v2_mode,
+	.num_modes = ARRAY_SIZE(ylm_lbv0345001h_v2_mode),
+	.width_mm = 70,
+	.height_mm = 53,
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE,
+	.panel_regs = ylm_lbv0345001h_v2_panel_regs,
+	.panel_regs_len = ARRAY_SIZE(ylm_lbv0345001h_v2_panel_regs),
+};
+
 static const struct spi_device_id nv3052c_ids[] = {
 	{ "ltk035c5444t", },
 	{ "fs035vg158", },
 	{ "rg35xx-plus-panel", },
+	{ "rg35xx-plus-rev6-panel", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, nv3052c_ids);
@@ -926,6 +1103,7 @@ static const struct of_device_id nv3052c_of_match[] = {
 	{ .compatible = "leadtek,ltk035c5444t", .data = &ltk035c5444t_panel_info },
 	{ .compatible = "fascontek,fs035vg158", .data = &fs035vg158_panel_info },
 	{ .compatible = "anbernic,rg35xx-plus-panel", .data = &wl_355608_a8_panel_info },
+	{ .compatible = "anbernic,rg35xx-plus-rev6-panel", .data = &ylm_lbv0345001h_v2_panel_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, nv3052c_of_match);
-- 
2.47.0


