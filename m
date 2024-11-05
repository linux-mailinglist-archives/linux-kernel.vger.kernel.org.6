Return-Path: <linux-kernel+bounces-395922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8A19BC508
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C189B21263
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2681E32C85;
	Tue,  5 Nov 2024 05:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icvz6Kup"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADBF1B6D04;
	Tue,  5 Nov 2024 05:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786063; cv=none; b=Mh3YvTaFLc0+FJrlbVlewAyBdZ+mQ/ddJFProy0/NAbWNOLwWH2hdo0sCMwqMJhB+xfVZGuX3t6CJKu5UVUG1viLfmtCtVDgTXKbn3posQJiWNMdE9XBGqPvA6Opv8bIE/dA6p+owBvCaF+2rcSlXPvR/2yW6QX6MExCgl32h9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786063; c=relaxed/simple;
	bh=AAFsoxZkL3SXfgoAEng+lChMgSwKkrxJyJmUtXg025I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0WcYJ7cyF0xFtdNWPYxFSlUhkprU72RNZbyskoSbxOcY58zLklXnQVAbdDC2sjYVGOyS/8YEQBiZF8Q79vai7saGUD1HyOA7wnHrBbT6119Klf3yL8PGyPXEm2wXcp+/4ZYzsdbz7OHNDjriLm7ldZ5nT1EWhiMqIi+9LH2pQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icvz6Kup; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e467c3996so4306646b3a.2;
        Mon, 04 Nov 2024 21:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730786059; x=1731390859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4hENOCxGRw0Z314XERAt1An+vdHKR9hZ9CMK+MlZnI=;
        b=icvz6KuprJpmGPCqkkLviFm4QLu0aOojwORhPYpfExttv+AAEzWsxCPJDLWkpxXjZs
         Md+y8y9VyC5jL1hoBX93nGl9MSZM80izSccPfa94E+iKocSt3gpGzKUMHnfbv85QM4PP
         V+CM59beYFckrKbpn+SNVKXiR5xUnd2kl/obTsRdBwpmAqc8t+GpQ5naYZob2HlzcSBw
         hX7G/ChiTGcTh5Osy9de+xygukbEQl3ttMcamnhhoDjI1e/m1Dso5PfmbQdxMGghlmOa
         gvofb5QsJeJAPlAFEnb+He0zseV9C2+ugpT7VkXaHd6EpnWFiZXznQ+ZzGvFmvVArLUH
         Vmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786059; x=1731390859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4hENOCxGRw0Z314XERAt1An+vdHKR9hZ9CMK+MlZnI=;
        b=iA9pBovkWIDELvO3uVtMHLMXFyEgU8n1OL8HThNRPNEtd+VcmqCMRjjW95EQmsfiHt
         YkDgFr4vVC3Sin7D5yncvwJgZiDKdM1yhF6yrFTfLl0VgjU6/qArTyJkoD5VpgjKlg0/
         9g5dJwNCTL7oLSOeQjicz/X63g+2gknSI97CiE/npgVtTJTJT/361OMmzZ/+kqdg1xCH
         L98PF6pjNe9WQVj+OB6yJvbx5A5jI6fdolwA0mMWBzBno4ULmWUSs1+KW5E/dgelZgcR
         UKoQI0dcx01k9bBEPeKxU2KKm5ChG30fHNfDlbJ62LCcGHECEOUVoCDdhS/LZIlsuKbi
         5t8A==
X-Forwarded-Encrypted: i=1; AJvYcCXxBf87RLACBxXHNzR9rg/reHv/8MfMZq42jO0f0TgOKmn5IQzmkAWgtOqm7onfK3mnS2FREVZKTjDf@vger.kernel.org
X-Gm-Message-State: AOJu0YziNY3uDsIOCHtcSCe1gTK3J4PR5++Z4D4d3+v9PPJzsgEN5v2W
	mWgf3FXzVfgH+TP1AcqD5gZuI3noCTqOqq2FGF4hywvOe2LFgVdzCefDC8Fv
X-Google-Smtp-Source: AGHT+IGgOFonaRAD2i25zhedoPYyzQB1PJlKepKARccV5qDew+PniDa3hE7p1DQzZgrFej8aAVlIzA==
X-Received: by 2002:a05:6a21:7888:b0:1db:f0b9:45f2 with SMTP id adf61e73a8af0-1dbf0b94684mr2560586637.38.1730786058945;
        Mon, 04 Nov 2024 21:54:18 -0800 (PST)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:fa8f:7c3e:835f:c642])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa4570fsm10952198a91.30.2024.11.04.21.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 21:54:18 -0800 (PST)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryan Walklin <ryan@testtoast.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: [PATCH 5/7] drm: panel: nv3052c: Add YLM-LBV0345001H-V2 panel
Date: Tue,  5 Nov 2024 14:52:33 +0900
Message-ID: <20241105055239.1577275-6-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105055239.1577275-1-kikuchan98@gmail.com>
References: <20241105055239.1577275-1-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The YLM-LBV0345001H-V2 panel is a display panel used in the recent
revision of Anbernic RG35XX Plus, a handheld gaming device from Anbernic.
It is 3.45 inches in size (diagonally) with a resolution of 640x480.

It has the same interface (pins and connector) as WL-355608-A8, the panel
of the former revision of RG35XX Plus, but they differ on its
init-sequence. So add entry for the new panel.

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 .../gpu/drm/panel/panel-newvision-nv3052c.c   | 177 ++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
index 2f3a8eaade4..57f6d5b1288 100644
--- a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
+++ b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
@@ -629,6 +629,155 @@ static const struct nv3052c_reg wl_355608_a8_panel_regs[] = {
 	{ 0x36, 0x0a }, // bgr = 1, ss = 1, gs = 0
 };
 
+static const struct nv3052c_reg ylm_lbv0345001h_v2_panel_regs[] = {
+	// EXTC Command set enable, select page 1
+	{ 0xff, 0x30 }, { 0xff, 0x52 }, { 0xff, 0x01 },
+	// Mostly unknown registers
+	{ 0xe3, 0x00 },
+	{ 0x0a, 0x01 },
+	{ 0x23, 0xa0 },
+	{ 0x24, 0x10 },
+	{ 0x25, 0x09 },
+	{ 0x28, 0x47 },
+	{ 0x29, 0x01 },
+	{ 0x2a, 0xdf },
+	{ 0x38, 0x9c },
+	{ 0x39, 0xa7 },
+	{ 0x3a, 0x3f },
+	{ 0x91, 0x77 },
+	{ 0x92, 0x77 },
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
+	// Mostly unknown registers
+	{ 0x07, 0x03 },
+	{ 0x08, 0x00 },
+	{ 0x09, 0x01 },
+	{ 0x30, 0x00 },
+	{ 0x31, 0x00 },
+	{ 0x32, 0x00 },
+	{ 0x33, 0x00 },
+	{ 0x34, 0x61 },
+	{ 0x35, 0xd4 },
+	{ 0x36, 0x24 },
+	{ 0x37, 0x03 },
+	{ 0x40, 0x02 },
+	{ 0x41, 0x03 },
+	{ 0x42, 0x04 },
+	{ 0x43, 0x05 },
+	{ 0x44, 0x11 },
+	{ 0x45, 0xe6 },
+	{ 0x46, 0xe7 },
+	{ 0x47, 0x11 },
+	{ 0x48, 0xe8 },
+	{ 0x49, 0xe9 },
+	{ 0x50, 0x06 },
+	{ 0x51, 0x07 },
+	{ 0x52, 0x08 },
+	{ 0x53, 0x09 },
+	{ 0x54, 0x11 },
+	{ 0x55, 0xea },
+	{ 0x56, 0xeb },
+	{ 0x57, 0x11 },
+	{ 0x58, 0xec },
+	{ 0x59, 0xed },
+	{ 0x82, 0x00 },
+	{ 0x83, 0x00 },
+	{ 0x84, 0x02 },
+	{ 0x85, 0x00 },
+	{ 0x86, 0x1f },
+	{ 0x87, 0x00 },
+	{ 0x88, 0x1f },
+	{ 0x89, 0x0e },
+	{ 0x8a, 0x0e },
+	{ 0x8b, 0x10 },
+	{ 0x8c, 0x10 },
+	{ 0x8d, 0x0a },
+	{ 0x8e, 0x0a },
+	{ 0x8f, 0x0c },
+	{ 0x90, 0x0c },
+	{ 0x98, 0x00 },
+	{ 0x99, 0x00 },
+	{ 0x9a, 0x01 },
+	{ 0x9b, 0x00 },
+	{ 0x9c, 0x1f },
+	{ 0x9d, 0x00 },
+	{ 0x9e, 0x1f },
+	{ 0x9f, 0x0d },
+	{ 0xa0, 0x0d },
+	{ 0xa1, 0x0f },
+	{ 0xa2, 0x0f },
+	{ 0xa3, 0x09 },
+	{ 0xa4, 0x09 },
+	{ 0xa5, 0x0b },
+	{ 0xa6, 0x0b },
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
@@ -881,6 +1030,21 @@ static const struct drm_display_mode wl_355608_a8_mode[] = {
 	},
 };
 
+static const struct drm_display_mode ylm_lbv0345001h_v2_mode[] = {
+	{
+		.clock = 24000,
+		.hdisplay = 640,
+		.hsync_start = 640 + 64,
+		.hsync_end = 640 + 64 + 20,
+		.htotal = 640 + 64 + 20 + 46,
+		.vdisplay = 480,
+		.vsync_start = 480 + 21,
+		.vsync_end = 480 + 21 + 4,
+		.vtotal = 480 + 21 + 4 + 15,
+		.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+	},
+};
+
 static const struct nv3052c_panel_info ltk035c5444t_panel_info = {
 	.display_modes = ltk035c5444t_modes,
 	.num_modes = ARRAY_SIZE(ltk035c5444t_modes),
@@ -914,10 +1078,22 @@ static const struct nv3052c_panel_info wl_355608_a8_panel_info = {
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
 	{ "wl-355608-a8", },
+	{ "ylm-lbv0345001h-v2", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, nv3052c_ids);
@@ -926,6 +1102,7 @@ static const struct of_device_id nv3052c_of_match[] = {
 	{ .compatible = "leadtek,ltk035c5444t", .data = &ltk035c5444t_panel_info },
 	{ .compatible = "fascontek,fs035vg158", .data = &fs035vg158_panel_info },
 	{ .compatible = "anbernic,wl-355608-a8", .data = &wl_355608_a8_panel_info },
+	{ .compatible = "anbernic,ylm-lbv0345001h-v2", .data = &ylm_lbv0345001h_v2_panel_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, nv3052c_of_match);
-- 
2.47.0


