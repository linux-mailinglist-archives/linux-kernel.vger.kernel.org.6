Return-Path: <linux-kernel+bounces-419375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B989D6D16
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 09:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2892281597
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 08:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC3A1531C1;
	Sun, 24 Nov 2024 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIRLfXdl"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A7A1885A0;
	Sun, 24 Nov 2024 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732435409; cv=none; b=rGx90k36zz3YCI5lBpaWjgRq3mHw8Tz1xtd46bk7N7r67EdPWD5k7oJ+gZysYmmqb2gBDc2uwW/qZr3++dRO6vkSEMcC2A7JXyvdpsBcgBm5K+5LjXL8vErMYPcxXdyFv9o7FatzgrOwHKdvEe70/g9rNZyoKC9gb5d7lfTDmzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732435409; c=relaxed/simple;
	bh=DBmLFY0sxryRon9gwVbpvN9e66kEu7OwWDFLjtHT7Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8lfdK9hjjQ12xPIIfhYCqyJB5595r+zLzRYiumapcV0fQzvFa+H3ctCOyyd+yrLWvsz1aAYOn67CAk+rTb3WurIJ2bfyYqDKRdYgoymDdSSUuTLSAUv3BK00cokgdORX8lpzvAaZmsSRvv6fFO1RimtqMNRQKG/VB/2MdA2ABY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIRLfXdl; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2eb1433958dso1563893a91.2;
        Sun, 24 Nov 2024 00:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732435405; x=1733040205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxPBOBd+6Ed9xkatjMkJJQxFqeLTkfs9bcOKmm2N2Vs=;
        b=AIRLfXdl/xPcocC4PUmPYLK9nqLGIibz61eHryJkGQ1WcJRaYdeRRkEAWM6U0spyBp
         pdf0jKCDwjGhWpoeYISHqKfwZGzB2giTAiD3oFf5owf4MmNMPOPXseA9qRIinJ80OyK0
         ryQMq9CPrKz84fAnPU81Zn1FkZMc5N9X8GVSbz0CFOuH3IbSBkysX4Ice5Gm2+DHdSpt
         abxGCRaRqNq9vRty6ZS6qRyqX+4soIXpmkA3POTFS1/x74+RYish0+uTEBO2DlD2OS/f
         49FazwXrDFaue8tFZFMA8ZsWUlLfx3CWvx55oKYHfUuC9yptpuTMQjvdIo0yKn2vnzbV
         nT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732435405; x=1733040205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxPBOBd+6Ed9xkatjMkJJQxFqeLTkfs9bcOKmm2N2Vs=;
        b=OMr5AKWV+xv/CpWpcOcqQ2EfMBfUhU4853HC5luqo1ucksVow3y5VSMYJ4P3Xi4b1M
         L1o1pV2U3vUbWgL19IvL/mOnLRz465EFCEMR1+OG/nRgMc4p22w8Sw/e+zqyMyK5GsQA
         H9C++27V8e39gTDrELiutVlqV+NQSWFXp2tR2fkcXlECmP3DW56r9KsZqUYdevApN/QN
         AjjGBhXYIhPndmtiExTpmSkSOsY7sZx7tmNJcS/HelPPhqwTYyHUZafvoQeUPoMNQuoA
         dR8u5MmyGaPylEh4A1sMaRjVqS8LWZqldt9erE/hqnvNwPJjYEC+Uzs3Lj3Pnu6ZoxbN
         vu6w==
X-Forwarded-Encrypted: i=1; AJvYcCWO8bNearrvakkgesE93iWTyVOegmf4lCuGRj5UmzWxovcQIikmziP1DzL90l2UZIH8EJ8zW1N/HRTg@vger.kernel.org
X-Gm-Message-State: AOJu0YyEQUtC/YZhnNUUrxuFmjH/8hxL1+1oKjAoLN5N1Yyuxa8rlKPU
	djJBZQ8D9roWY4dbthKuucu51ibqCEEphYSe+7ROPAcLAnwAEb2p7cRRG7pLoGg=
X-Gm-Gg: ASbGncudNcCZlDuyhiRbPyr1Gr8+YSEKB0KKnkUGHmzGk0wBNe7uW3yGwt59iyuVl3v
	yBQQjgTQaAUEQABo8HIm3aQRn6bJKDivwH4/eem+XgyBSE/+oNG5tMwV3MphTpAfQnos9TySlDH
	BmtU9FbTTvxtJSLQJIxVsvagqACXqTGRkamCPfyvu5WBnFClmtx0wDIgXV0kpGR+yEosyA4+U0m
	VbuuBReNZdASzYPwPIQCEDKPfdG+mUY/j1CaKKnUySir4rx7QGoEKtasoZ+DaU=
X-Google-Smtp-Source: AGHT+IFe3GZWneGawX4l12Zavw69tECcDmSfwFVctb4X1ic+vmFklHYNFAP8pxdvBF7i0bBGfsfO7g==
X-Received: by 2002:a17:90b:3881:b0:2ea:a737:60ab with SMTP id 98e67ed59e1d1-2eb0e234ccbmr13443895a91.12.1732435405454;
        Sun, 24 Nov 2024 00:03:25 -0800 (PST)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:fa8f:7c3e:835f:c642])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead03de6f6sm7956708a91.34.2024.11.24.00.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 00:03:25 -0800 (PST)
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
Subject: [PATCH 6/6] drm: panel: nv3052c: Add a panel for RG CubeXX
Date: Sun, 24 Nov 2024 17:02:17 +0900
Message-ID: <20241124080220.1657238-7-kikuchan98@gmail.com>
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

This is a display panel used in the Anbernic RG CubeXX, a handheld
gaming device from Anbernic. It is 3.95 inches in size (diagonally)
with a resolution of 720x720.

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 .../gpu/drm/panel/panel-newvision-nv3052c.c   | 198 ++++++++++++++++++
 1 file changed, 198 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
index 5a7cf6cb8be..bd5be0b5e93 100644
--- a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
+++ b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
@@ -963,6 +963,176 @@ static const struct nv3052c_reg ylm_lbv0400001x_v1_panel_regs[] = {
 	{ 0x36, 0x0a }, // bgr = 1, ss = 1, gs = 0
 };
 
+static const struct nv3052c_reg ylm_lbn0395004h_v1_panel_regs[] = {
+	// EXTC Command set enable, select page 1
+	{ 0xff, 0x30 }, { 0xff, 0x52 }, { 0xff, 0x01 },
+	// Mostly unknown registers
+	{ 0xe3, 0x00 },
+	{ 0x0a, 0x01 }, // WRMADC_EN
+	{ 0x23, 0x00 }, // RGB interface control: DE+SYNC MODE PCLK-N
+	{ 0x25, 0x14 },
+	{ 0x29, 0x02 },
+	{ 0x2a, 0xcf },
+	{ 0x38, 0x9c }, // VCOM_ADJ1
+	{ 0x39, 0xa7 }, // VCOM_ADJ2
+	{ 0x3a, 0x5f }, // VCOM_ADJ3
+	{ 0x91, 0x77 }, // EXTPW_CTRL2
+	{ 0x92, 0x77 }, // EXTPW_CTRL3
+	{ 0x99, 0x52 }, // PUMP_CTRL2
+	{ 0x9b, 0x5b }, // PUMP_CTRL4
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
+	{ 0xb1, 0x11 }, // PGAMVR1
+	{ 0xb2, 0x12 }, // PGAMVR2
+	{ 0xb3, 0x2e }, // PGAMVR3
+	{ 0xb4, 0x30 }, // PGAMVR4
+	{ 0xb5, 0x37 }, // PGAMVR5
+	{ 0xb6, 0x1c }, // PGAMPR0
+	{ 0xb7, 0x39 }, // PGAMPR1
+	{ 0xb8, 0x08 }, // PGAMPK0
+	{ 0xb9, 0x00 }, // PGAMPK1
+	{ 0xba, 0x12 }, // PGAMPK2
+	{ 0xbb, 0x12 }, // PGAMPK3
+	{ 0xbc, 0x14 }, // PGAMPK4
+	{ 0xbd, 0x15 }, // PGAMPK5
+	{ 0xbe, 0x16 }, // PGAMPK6
+	{ 0xbf, 0x0d }, // PGAMPK7
+	{ 0xc0, 0x15 }, // PGAMPK8
+	{ 0xc1, 0x04 }, // PGAMPK9
+	{ 0xd0, 0x05 }, // NGAMVR0
+	{ 0xd1, 0x07 }, // NGAMVR0
+	{ 0xd2, 0x08 }, // NGAMVR1
+	{ 0xd3, 0x30 }, // NGAMVR2
+	{ 0xd4, 0x2e }, // NGAMVR3
+	{ 0xd5, 0x32 }, // NGAMVR4
+	{ 0xd6, 0x1c }, // NGAMPR0
+	{ 0xd7, 0x3b }, // NGAMPR1
+	{ 0xd8, 0x10 }, // NGAMPK0
+	{ 0xd9, 0x06 }, // NGAMPK1
+	{ 0xda, 0x12 }, // NGAMPK2
+	{ 0xdb, 0x12 }, // NGAMPK3
+	{ 0xdc, 0x14 }, // NGAMPK4
+	{ 0xdd, 0x15 }, // NGAMPK5
+	{ 0xde, 0x18 }, // NGAMPK6
+	{ 0xdf, 0x0f }, // NGAMPK7
+	{ 0xe0, 0x17 }, // NGAMPK8
+	{ 0xe1, 0x0a }, // NGAMPK9
+	// EXTC Command set enable, select page 3
+	{ 0xff, 0x30 }, { 0xff, 0x52 }, { 0xff, 0x03 },
+	// Set various timing settings
+	{ 0x08, 0x09 }, // GIP_VST_9
+	{ 0x09, 0x0a }, // GIP_VST_10
+	{ 0x0a, 0x0b }, // GIP_VST_11
+	{ 0x0b, 0x0c }, // GIP_VST_12
+	{ 0x28, 0x22 }, // GIP_VEND_9
+	{ 0x2a, 0xec }, // GIP_VEND_11
+	{ 0x2b, 0xec }, // GIP_VEND_12
+	{ 0x30, 0x00 }, // GIP_CLK_1
+	{ 0x31, 0x00 }, // GIP_CLK_2
+	{ 0x32, 0x00 }, // GIP_CLK_3
+	{ 0x33, 0x00 }, // GIP_CLK_4
+	{ 0x34, 0x61 }, // GIP_CLK_5
+	{ 0x35, 0xd4 }, // GIP_CLK_6
+	{ 0x36, 0x24 }, // GIP_CLK_7
+	{ 0x37, 0x03 }, // GIP_CLK_8
+	{ 0x40, 0x0d }, // GIP_CLKA_1
+	{ 0x41, 0x0e }, // GIP_CLKA_2
+	{ 0x42, 0x0f }, // GIP_CLKA_3
+	{ 0x43, 0x10 }, // GIP_CLKA_4
+	{ 0x44, 0x22 }, // GIP_CLKA_5
+	{ 0x45, 0xe1 }, // GIP_CLKA_6
+	{ 0x46, 0xe2 }, // GIP_CLKA_7
+	{ 0x47, 0x22 }, // GIP_CLKA_8
+	{ 0x48, 0xe3 }, // GIP_CLKA_9
+	{ 0x49, 0xe4 }, // GIP_CLKA_10
+	{ 0x50, 0x11 }, // GIP_CLKB_1
+	{ 0x51, 0x12 }, // GIP_CLKB_2
+	{ 0x52, 0x13 }, // GIP_CLKB_3
+	{ 0x53, 0x14 }, // GIP_CLKB_4
+	{ 0x54, 0x22 }, // GIP_CLKB_5
+	{ 0x55, 0xe5 }, // GIP_CLKB_6
+	{ 0x56, 0xe6 }, // GIP_CLKB_7
+	{ 0x57, 0x22 }, // GIP_CLKB_8
+	{ 0x58, 0xe7 }, // GIP_CLKB_9
+	{ 0x59, 0xe8 }, // GIP_CLKB_10
+	// Map internal GOA signals to GOA output pad
+	{ 0x80, 0x05 }, // PANELU2D1
+	{ 0x81, 0x1e }, // PANELU2D2
+	{ 0x82, 0x02 }, // PANELU2D3
+	{ 0x83, 0x04 }, // PANELU2D4
+	{ 0x84, 0x1e }, // PANELU2D5
+	{ 0x85, 0x1e }, // PANELU2D6
+	{ 0x86, 0x1f }, // PANELU2D7
+	{ 0x87, 0x1f }, // PANELU2D8
+	{ 0x88, 0x0e }, // PANELU2D9
+	{ 0x89, 0x10 }, // PANELU2D10
+	{ 0x8a, 0x0a }, // PANELU2D11
+	{ 0x8b, 0x0c }, // PANELU2D12
+	{ 0x96, 0x05 }, // PANELU2D23
+	{ 0x97, 0x1e }, // PANELU2D24
+	{ 0x98, 0x01 }, // PANELU2D25
+	{ 0x99, 0x03 }, // PANELU2D26
+	{ 0x9a, 0x1e }, // PANELU2D27
+	{ 0x9b, 0x1e }, // PANELU2D28
+	{ 0x9c, 0x1f }, // PANELU2D29
+	{ 0x9d, 0x1f }, // PANELU2D30
+	{ 0x9e, 0x0d }, // PANELU2D31
+	{ 0x9f, 0x0f }, // PANELU2D32
+	{ 0xa0, 0x09 }, // PANELU2D33
+	{ 0xa1, 0x0b }, // PANELU2D34
+	{ 0xb0, 0x05 }, // PANELD2U1
+	{ 0xb1, 0x1f }, // PANELD2U2
+	{ 0xb2, 0x03 }, // PANELD2U3
+	{ 0xb3, 0x01 }, // PANELD2U4
+	{ 0xb4, 0x1e }, // PANELD2U5
+	{ 0xb5, 0x1e }, // PANELD2U6
+	{ 0xb6, 0x1f }, // PANELD2U7
+	{ 0xb7, 0x1e }, // PANELD2U8
+	{ 0xb8, 0x0b }, // PANELD2U9
+	{ 0xb9, 0x09 }, // PANELD2U10
+	{ 0xba, 0x0f }, // PANELD2U11
+	{ 0xbb, 0x0d }, // PANELD2U12
+	{ 0xc6, 0x05 }, // PANELD2U23
+	{ 0xc7, 0x1f }, // PANELD2U24
+	{ 0xc8, 0x04 }, // PANELD2U25
+	{ 0xc9, 0x02 }, // PANELD2U26
+	{ 0xca, 0x1e }, // PANELD2U27
+	{ 0xcb, 0x1e }, // PANELD2U28
+	{ 0xcc, 0x1f }, // PANELD2U29
+	{ 0xcd, 0x1e }, // PANELD2U30
+	{ 0xce, 0x0c }, // PANELD2U31
+	{ 0xcf, 0x0a }, // PANELD2U32
+	{ 0xd0, 0x10 }, // PANELD2U33
+	{ 0xd1, 0x0e }, // PANELD2U34
+	// EXTC Command set enable, select page 0
+	{ 0xff, 0x30 }, { 0xff, 0x52 }, { 0xff, 0x00 },
+	// Display Access Control
+	{ 0x36, 0x0a }, // bgr = 1, ss = 1, gs = 0
+};
+
 static inline struct nv3052c *to_nv3052c(struct drm_panel *panel)
 {
 	return container_of(panel, struct nv3052c, panel);
@@ -1245,6 +1415,21 @@ static const struct drm_display_mode ylm_lbv0400001x_v1_mode[] = {
 	},
 };
 
+static const struct drm_display_mode ylm_lbn0395004h_v1_mode[] = {
+	{
+		.clock = 36000,
+		.hdisplay = 720,
+		.hsync_start = 720 + 28,
+		.hsync_end = 720 + 28 + 4,
+		.htotal = 720 + 28 + 4 + 42,
+		.vdisplay = 720,
+		.vsync_start = 720 + 16,
+		.vsync_end = 720 + 16 + 4,
+		.vtotal = 720 + 16 + 4 + 16,
+		.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+	},
+};
+
 static const struct nv3052c_panel_info ltk035c5444t_panel_info = {
 	.display_modes = ltk035c5444t_modes,
 	.num_modes = ARRAY_SIZE(ltk035c5444t_modes),
@@ -1300,12 +1485,24 @@ static const struct nv3052c_panel_info ylm_lbv0400001x_v1_panel_info = {
 	.panel_regs_len = ARRAY_SIZE(ylm_lbv0400001x_v1_panel_regs),
 };
 
+static const struct nv3052c_panel_info ylm_lbn0395004h_v1_panel_info = {
+	.display_modes = ylm_lbn0395004h_v1_mode,
+	.num_modes = ARRAY_SIZE(ylm_lbn0395004h_v1_mode),
+	.width_mm = 71,
+	.height_mm = 71,
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE,
+	.panel_regs = ylm_lbn0395004h_v1_panel_regs,
+	.panel_regs_len = ARRAY_SIZE(ylm_lbn0395004h_v1_panel_regs),
+};
+
 static const struct spi_device_id nv3052c_ids[] = {
 	{ "ltk035c5444t", },
 	{ "fs035vg158", },
 	{ "rg35xx-plus-panel", },
 	{ "rg35xx-plus-rev6-panel", },
 	{ "rg40xx-panel", },
+	{ "rgcubexx-panel", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, nv3052c_ids);
@@ -1316,6 +1513,7 @@ static const struct of_device_id nv3052c_of_match[] = {
 	{ .compatible = "anbernic,rg35xx-plus-panel", .data = &wl_355608_a8_panel_info },
 	{ .compatible = "anbernic,rg35xx-plus-rev6-panel", .data = &ylm_lbv0345001h_v2_panel_info },
 	{ .compatible = "anbernic,rg40xx-panel", .data = &ylm_lbv0400001x_v1_panel_info },
+	{ .compatible = "anbernic,rgcubexx-panel", .data = &ylm_lbn0395004h_v1_panel_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, nv3052c_of_match);
-- 
2.47.0


