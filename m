Return-Path: <linux-kernel+bounces-395924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFDA9BC50F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB77B210B5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD5A1FF7AF;
	Tue,  5 Nov 2024 05:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5dCxsck"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD151FF7A0;
	Tue,  5 Nov 2024 05:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786069; cv=none; b=nL1yramvveZ06jaOp1NeeGRo2imgGX69CSR6BPMBRpTlpxWjZICQPy7fk1ae9rCK/MqRNAusq4hT3mg8uuCMB19Elmn2l+HASu65KsAZR6vWoyhl8nVBtPWwEespiYB+RMOe4oB5qSw4D/rheDVDPpZ77ozu/fOVU1uNG0v/znU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786069; c=relaxed/simple;
	bh=ruIBtGlx2lDKo02YJkAtbOENmC6wv8b7Jm98fk+cQmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEakAzSyvUpY8vjoBuhEC/f2M9tqsTT7Ewt32EsOslwRGExW24Nl1sO2LAV4emYNW2fkrq1fv0YSyij4C2dhIW5aHaJZ2HWFsCg0KJN5Zzztg6IhxA3Fony3JpdN72wLfusHJqLHWHFPPE7HuvJxyf/VCR+fCA0Qv8ZbSiNoxNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5dCxsck; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso3929109b3a.3;
        Mon, 04 Nov 2024 21:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730786067; x=1731390867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h98PpwwioaOsJzAAL5AX0KKiepQQcjl2anZQ/GuvVrw=;
        b=a5dCxsckwgHSLP9kLCWHNTCKqlRnr9xPCZXK+yrPh2h27sZZLKOyIG4YYJX+bOZC6s
         vxbrK8GyAv+4Qeb5iP+tyKddteSiS+vc0MB/91j4I5fRcG+8B4T7mhhNAL8N6UW18p+o
         eUIDA/tdvJjo18v86jDcxbwut8M2tnHVbm+1Z282L2oehlVNlYptIrOLXLbO3gbDXPeJ
         KIxHt+baYZD45pvrbgdnNUGVUsaG8hb67VTq7kuW7JHkzNs2E+kTc5USLPSt4DbkGnbK
         HexwNj7eQCo1QDfL807B19Xhqc7xN9JTKkaMVWiM2Lun86w9cjFOFpCCP5nk/LTN+Nwa
         dC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786067; x=1731390867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h98PpwwioaOsJzAAL5AX0KKiepQQcjl2anZQ/GuvVrw=;
        b=sMMc6T5HcfrBW4C8pxebUWyjzxTUU5Pbh4qRKhcx+ruVFTmyw5ur/YtGExuoyddwgC
         6ap7TTMLtoWRx/BAp/kPEgrtT+2/JAGtRvantsCA1Sw0Qn/HKl97SR9qex2ai8bdpWVM
         V//sGZsu3DrdbsK4M1n8zrvmCMZtjoDLDnNl12co0dBtKBwqmDHONM/QC9519uYa1/uZ
         IPNdVoljoe9dTtY5nINlTYdtvbtVOYQDon9lGOSh/SStuBLlakUO0l0TfxXldS7zwC6S
         FCON9JWC4swmcZGdERrropPR8sZIVcG2osleW2O5rEMUv3ouRYcTU0QzqJSfyVHEOe2f
         1zPw==
X-Forwarded-Encrypted: i=1; AJvYcCUh8Uk+ENSJoqVmFB7pGUoPAqwhThciFgJot75oQNQbk9+hyA+GLrxP2qlG6LKy2UAltFAH5dFCDHIw@vger.kernel.org
X-Gm-Message-State: AOJu0YyuZPgq1BPCJpnJ77sBXjb5wGuJuHB70AyC94MDptvObU2sYf7e
	DsNpdi9EaWL0eaEZGfAFxMegQx8GDRoYY5hZUdI17uvTRea/mcsrCHSMmX18
X-Google-Smtp-Source: AGHT+IGNVJCILktYGSsD2tAIm1icWG7AZ4OJv/mjRii9zkL6vdysjNYyYGX8j3vO3FGfPoS43jO1dw==
X-Received: by 2002:a05:6a21:7886:b0:1db:e177:7737 with SMTP id adf61e73a8af0-1dbe1777839mr7105384637.8.1730786066634;
        Mon, 04 Nov 2024 21:54:26 -0800 (PST)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:fa8f:7c3e:835f:c642])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa4570fsm10952198a91.30.2024.11.04.21.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 21:54:26 -0800 (PST)
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
Subject: [PATCH 7/7] drm: panel: nv3052c: Add YLM-LBV0400001X-V1 panel
Date: Tue,  5 Nov 2024 14:52:35 +0900
Message-ID: <20241105055239.1577275-8-kikuchan98@gmail.com>
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

The YLM-LBV0400001X-V1 panel is a display panel used in the Anbernic
RG40XX series (H and V), a handheld gaming device from Anbernic. It is
4.00 inches in size (diagonally) with a resolution of 640x480.

It's similar to YLM-LBV0345001H-V2, but different in size and its
init-sequence. So add entry for the new panel.

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 .../gpu/drm/panel/panel-newvision-nv3052c.c   | 211 ++++++++++++++++++
 1 file changed, 211 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
index 57f6d5b1288..71f81d21465 100644
--- a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
+++ b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
@@ -778,6 +778,189 @@ static const struct nv3052c_reg ylm_lbv0345001h_v2_panel_regs[] = {
 	{ 0x36, 0x0a }, // bgr = 1, ss = 1, gs = 0
 };
 
+static const struct nv3052c_reg ylm_lbv0400001x_v1_panel_regs[] = {
+	// EXTC Command set enable, select page 1
+	{ 0xff, 0x30 }, { 0xff, 0x52 }, { 0xff, 0x01 },
+	// Mostly unknown registers
+	{ 0xe3, 0x00 },
+	{ 0x0a, 0x01 },
+	{ 0x23, 0xa0 },
+	{ 0x25, 0x14 },
+	{ 0x28, 0x47 },
+	{ 0x29, 0x01 },
+	{ 0x2a, 0xdf },
+	{ 0x38, 0x9c },
+	{ 0x39, 0xa7 },
+	{ 0x3a, 0x47 },
+	{ 0x91, 0x77 },
+	{ 0x92, 0x77 },
+	{ 0x99, 0x52 },
+	{ 0x9b, 0x5b },
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
+	{ 0xb0, 0x05 }, // PGAMVR0
+	{ 0xb1, 0x12 }, // PGAMVR1
+	{ 0xb2, 0x13 }, // PGAMVR2
+	{ 0xb3, 0x2c }, // PGAMVR3
+	{ 0xb4, 0x2a }, // PGAMVR4
+	{ 0xb5, 0x37 }, // PGAMVR5
+	{ 0xb6, 0x27 }, // PGAMPR0
+	{ 0xb7, 0x42 }, // PGAMPR1
+	{ 0xb8, 0x0f }, // PGAMPK0
+	{ 0xb9, 0x06 }, // PGAMPK1
+	{ 0xba, 0x12 }, // PGAMPK2
+	{ 0xbb, 0x12 }, // PGAMPK3
+	{ 0xbc, 0x13 }, // PGAMPK4
+	{ 0xbd, 0x15 }, // PGAMPK5
+	{ 0xbe, 0x1b }, // PGAMPK6
+	{ 0xbf, 0x14 }, // PGAMPK7
+	{ 0xc0, 0x1d }, // PGAMPK8
+	{ 0xc1, 0x09 }, // PGAMPK9
+	{ 0xd0, 0x02 }, // NGAMVR0
+	{ 0xd1, 0x1c }, // NGAMVR0
+	{ 0xd2, 0x1d }, // NGAMVR1
+	{ 0xd3, 0x36 }, // NGAMVR2
+	{ 0xd4, 0x34 }, // NGAMVR3
+	{ 0xd5, 0x32 }, // NGAMVR4
+	{ 0xd6, 0x25 }, // NGAMPR0
+	{ 0xd7, 0x40 }, // NGAMPR1
+	{ 0xd8, 0x0d }, // NGAMPK0
+	{ 0xd9, 0x04 }, // NGAMPK1
+	{ 0xda, 0x12 }, // NGAMPK2
+	{ 0xdb, 0x12 }, // NGAMPK3
+	{ 0xdc, 0x13 }, // NGAMPK4
+	{ 0xdd, 0x15 }, // NGAMPK5
+	{ 0xde, 0x15 }, // NGAMPK6
+	{ 0xdf, 0x0c }, // NGAMPK7
+	{ 0xe0, 0x13 }, // NGAMPK8
+	{ 0xe1, 0x07 }, // NGAMPK9
+	// EXTC Command set enable, select page 3
+	{ 0xff, 0x30 }, { 0xff, 0x52 }, { 0xff, 0x03 },
+	// Mostly unknown registers
+	{ 0x08, 0x0a },
+	{ 0x09, 0x0b },
+	{ 0x30, 0x00 },
+	{ 0x31, 0x00 },
+	{ 0x32, 0x00 },
+	{ 0x33, 0x00 },
+	{ 0x34, 0x61 },
+	{ 0x35, 0xd4 },
+	{ 0x36, 0x24 },
+	{ 0x37, 0x03 },
+	{ 0x40, 0x0d },
+	{ 0x41, 0x0e },
+	{ 0x42, 0x0f },
+	{ 0x43, 0x10 },
+	{ 0x44, 0x11 },
+	{ 0x45, 0xf4 },
+	{ 0x46, 0xf5 },
+	{ 0x47, 0x11 },
+	{ 0x48, 0xf6 },
+	{ 0x49, 0xf7 },
+	{ 0x50, 0x11 },
+	{ 0x51, 0x12 },
+	{ 0x52, 0x13 },
+	{ 0x53, 0x14 },
+	{ 0x54, 0x11 },
+	{ 0x55, 0xf8 },
+	{ 0x56, 0xf9 },
+	{ 0x57, 0x11 },
+	{ 0x58, 0xfa },
+	{ 0x59, 0xfb },
+	{ 0x60, 0x05 },
+	{ 0x61, 0x05 },
+	{ 0x65, 0x0a },
+	{ 0x66, 0x0a },
+	{ 0x82, 0x1e },
+	{ 0x83, 0x1f },
+	{ 0x84, 0x11 },
+	{ 0x85, 0x02 },
+	{ 0x86, 0x1e },
+	{ 0x87, 0x1e },
+	{ 0x88, 0x1f },
+	{ 0x89, 0x0e },
+	{ 0x8a, 0x0e },
+	{ 0x8b, 0x10 },
+	{ 0x8c, 0x10 },
+	{ 0x8d, 0x0a },
+	{ 0x8e, 0x0a },
+	{ 0x8f, 0x0c },
+	{ 0x90, 0x0c },
+	{ 0x98, 0x1e },
+	{ 0x99, 0x1f },
+	{ 0x9a, 0x11 },
+	{ 0x9b, 0x01 },
+	{ 0x9c, 0x1e },
+	{ 0x9d, 0x1e },
+	{ 0x9e, 0x1f },
+	{ 0x9f, 0x0d },
+	{ 0xa0, 0x0d },
+	{ 0xa1, 0x0f },
+	{ 0xa2, 0x0f },
+	{ 0xa3, 0x09 },
+	{ 0xa4, 0x09 },
+	{ 0xa5, 0x0b },
+	{ 0xa6, 0x0b },
+	{ 0xb2, 0x1f },
+	{ 0xb3, 0x1e },
+	{ 0xb4, 0x11 },
+	{ 0xb5, 0x01 },
+	{ 0xb6, 0x1e },
+	{ 0xb7, 0x1e },
+	{ 0xb8, 0x1f },
+	{ 0xb9, 0x0b },
+	{ 0xba, 0x0b },
+	{ 0xbb, 0x09 },
+	{ 0xbc, 0x09 },
+	{ 0xbd, 0x0f },
+	{ 0xbe, 0x0f },
+	{ 0xbf, 0x0d },
+	{ 0xc0, 0x0d },
+	{ 0xc8, 0x1f },
+	{ 0xc9, 0x1e },
+	{ 0xca, 0x11 },
+	{ 0xcb, 0x02 },
+	{ 0xcc, 0x1e },
+	{ 0xcd, 0x1e },
+	{ 0xce, 0x1f },
+	{ 0xcf, 0x0c },
+	{ 0xd0, 0x0c },
+	{ 0xd1, 0x0a },
+	{ 0xd2, 0x0a },
+	{ 0xd3, 0x10 },
+	{ 0xd4, 0x10 },
+	{ 0xd5, 0x0e },
+	{ 0xd6, 0x0e },
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
@@ -1045,6 +1228,21 @@ static const struct drm_display_mode ylm_lbv0345001h_v2_mode[] = {
 	},
 };
 
+static const struct drm_display_mode ylm_lbv0400001x_v1_mode[] = {
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
@@ -1089,11 +1287,23 @@ static const struct nv3052c_panel_info ylm_lbv0345001h_v2_panel_info = {
 	.panel_regs_len = ARRAY_SIZE(ylm_lbv0345001h_v2_panel_regs),
 };
 
+static const struct nv3052c_panel_info ylm_lbv0400001x_v1_panel_info = {
+	.display_modes = ylm_lbv0400001x_v1_mode,
+	.num_modes = ARRAY_SIZE(ylm_lbv0400001x_v1_mode),
+	.width_mm = 81,
+	.height_mm = 61,
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE,
+	.panel_regs = ylm_lbv0400001x_v1_panel_regs,
+	.panel_regs_len = ARRAY_SIZE(ylm_lbv0400001x_v1_panel_regs),
+};
+
 static const struct spi_device_id nv3052c_ids[] = {
 	{ "ltk035c5444t", },
 	{ "fs035vg158", },
 	{ "wl-355608-a8", },
 	{ "ylm-lbv0345001h-v2", },
+	{ "ylm-lbv0400001x-v1", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, nv3052c_ids);
@@ -1103,6 +1313,7 @@ static const struct of_device_id nv3052c_of_match[] = {
 	{ .compatible = "fascontek,fs035vg158", .data = &fs035vg158_panel_info },
 	{ .compatible = "anbernic,wl-355608-a8", .data = &wl_355608_a8_panel_info },
 	{ .compatible = "anbernic,ylm-lbv0345001h-v2", .data = &ylm_lbv0345001h_v2_panel_info },
+	{ .compatible = "anbernic,ylm-lbv0400001x-v1", .data = &ylm_lbv0400001x_v1_panel_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, nv3052c_of_match);
-- 
2.47.0


