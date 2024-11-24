Return-Path: <linux-kernel+bounces-419373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEE49D6D12
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 09:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29C3281363
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 08:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC5D189B8D;
	Sun, 24 Nov 2024 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9XJGios"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C003418732E;
	Sun, 24 Nov 2024 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732435399; cv=none; b=vCy/QWgd9T8t/v6svajjVwEDw4un7nRjk+hX+xbkbv3jjoB9iZxUjMTG48HfZD/EUZJ7ZGXns+fj5vRHw96KTE22c9qe5UmoDZVY6uTgtj9qDYL065xaKVnJH4FZnvgVDwjePKb8scyqIWEjWOcdoClTCqxlbXoI9G/uI0tg/gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732435399; c=relaxed/simple;
	bh=jqUeFYM4lIY+HssR2JBhXWL6AVcxjsMraK+hTjf5vTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QLMinJ/VKnKhwYGUVFdev4miX3UlBW6J0cqyo/k2syuoGPXwK1ahEVMiK3n7/7jR6mbOgSTrBnQjKHAzkDJKQseTD3HBO/WTLU0iCsC4Lre7KK3UoxiHP5SiXv1CEEqf8+fZUJqGTOVoXRzFO+uAvgvWJ5zw090ppcMetAy5XIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9XJGios; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7fbce800ee5so1794766a12.2;
        Sun, 24 Nov 2024 00:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732435397; x=1733040197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6C0VSpqHJ4qDm/QynyM6hHlMGBr/aZVtEWrJLfbsX/Y=;
        b=b9XJGiosCOgnMseCZ/I3ORGkI3gfqw6I0iyTjDZGwS0IXtNOa4iecmqkbxfMUhN4FW
         hAQYZ9nuYIveEZy0iBD4Fqua8akqRnpdlAbIG0kaixDqJ4QG6SUiyfC9rvL/KxQHniAb
         80CrMSKjjS8NqfO5esteVRfVyRQA1pkv8xJOqY483nTphEUT+q7SuDU9T+5+EgX8h5MX
         v7kYJBamaKAJKuodqqL4jt+PMXdGQsLkMBxwCypG4J9hd2t4q2aYR4YRJ3udepwgAL2D
         20tZrTi643nIpYvkwgWGUkfh/siZMcaHBNrEIq3nHHgObNuT8Mc9lOmM+jdC9wH7HtbS
         wk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732435397; x=1733040197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6C0VSpqHJ4qDm/QynyM6hHlMGBr/aZVtEWrJLfbsX/Y=;
        b=xCD8cF+MPX4w6CwIXe5D026XnoXDgwrRN4zpNsy+lqgH2PWaC14Ajfx0SbbgZERY+6
         Nz+/FdJ2wAfOLHzSQE1qmn7tAFu3oph0e6FwcsMgpi1RBXRFhwjvi8QpvDtLg13SUjRu
         f1RvrhUzi43xZt9Fvai4+X3Tmw0ra988JfL5Bs8vjUTZrPP7yUaIFkzatq5MT4rFeoAD
         fR3bi3IXViKwfwpu0hQrnqY9mnpxA9RmjBAuUoeuLCb9sptpQ+8ur2kSoBdOoDO7wXLw
         pR+estOaMFiTcwF8sqFLoBZjquKzPIlQz0QAwZ6/5wPQuDuJZ4eJidQSTkIhdrfx7u4F
         E+eA==
X-Forwarded-Encrypted: i=1; AJvYcCWY91Xa11mLhE2MyG7iQn5B6CHKiYWx0AIJ6GIY77t21VjUAudUBBjjblZb4f0ocMnZovycXF+6XB09@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+LJVT3umQ03V4BysxcdoiyvShfamoRdP85yavGMhEK47PyzMi
	ZB6ts9hpGGiUqRnOnpBsbhJ5C9UkovvNCtpADfTkHq/cNjt2fKoSPA549+RDTPI=
X-Gm-Gg: ASbGncvJMaDqnKuaRPdKn0LHERZHWpLIhRBl4v2Q/MmbJH4rA3+RCleWqNluPeG8Tv7
	/M16bgipwPfe+EPlENqO9TzO8YipqABXCPT8AQ4DxyGHPqgeL/WaJhv4j8E5MgZiaZT2/YPct6C
	nzsXDeQZPfPbD7JYv4uCdKGo2GhjMNwOAPBkbzhQJQFQYJgGPoB8aOHsc5fuyo0GON8TAeJO0Ik
	KnUJ3lauDLZxwEZ2iHu72yNUSDe+k3oaQjnuH8Myo/YniLo714uMMf/lQSjmnU=
X-Google-Smtp-Source: AGHT+IGe+c7w0mSssm11jhSDpPDgnKc+pnCl/8Vm/OFco3CDhxyb5AnDciU1Nf0Hh76biUY15o0iFQ==
X-Received: by 2002:a17:90b:2e44:b0:2ea:a565:18b1 with SMTP id 98e67ed59e1d1-2eb0e02b6d6mr12150652a91.8.1732435397178;
        Sun, 24 Nov 2024 00:03:17 -0800 (PST)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:fa8f:7c3e:835f:c642])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead03de6f6sm7956708a91.34.2024.11.24.00.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 00:03:16 -0800 (PST)
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
Subject: [PATCH 4/6] drm: panel: nv3052c: Add a panel for RG40XX series
Date: Sun, 24 Nov 2024 17:02:15 +0900
Message-ID: <20241124080220.1657238-5-kikuchan98@gmail.com>
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

This is a display panel used in the Anbernic RG40XX series (H and V),
a handheld gaming device from Anbernic. It is 4.00 inches in size
(diagonally) with a resolution of 640x480.

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 .../gpu/drm/panel/panel-newvision-nv3052c.c   | 212 ++++++++++++++++++
 1 file changed, 212 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
index 166393ccfed..5a7cf6cb8be 100644
--- a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
+++ b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
@@ -779,6 +779,190 @@ static const struct nv3052c_reg ylm_lbv0345001h_v2_panel_regs[] = {
 	{ 0x36, 0x0a }, // bgr = 1, ss = 1, gs = 0
 };
 
+static const struct nv3052c_reg ylm_lbv0400001x_v1_panel_regs[] = {
+	// EXTC Command set enable, select page 1
+	{ 0xff, 0x30 }, { 0xff, 0x52 }, { 0xff, 0x01 },
+	// Mostly unknown registers
+	{ 0xe3, 0x00 },
+	{ 0x0a, 0x01 }, // WRMADC_EN
+	{ 0x23, 0x00 }, // RGB interface control: DE+SYNC MODE PCLK-N
+	{ 0x25, 0x14 },
+	{ 0x28, 0x47 },
+	{ 0x29, 0x01 },
+	{ 0x2a, 0xdf },
+	{ 0x38, 0x9c }, // VCOM_ADJ1
+	{ 0x39, 0xa7 }, // VCOM_ADJ2
+	{ 0x3a, 0x47 }, // VCOM_ADJ3
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
+	// Set various timing settings
+	{ 0x08, 0x0a }, // GIP_VST_9
+	{ 0x09, 0x0b }, // GIP_VST_10
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
+	{ 0x44, 0x11 }, // GIP_CLKA_5
+	{ 0x45, 0xf4 }, // GIP_CLKA_6
+	{ 0x46, 0xf5 }, // GIP_CLKA_7
+	{ 0x47, 0x11 }, // GIP_CLKA_8
+	{ 0x48, 0xf6 }, // GIP_CLKA_9
+	{ 0x49, 0xf7 }, // GIP_CLKA_10
+	{ 0x50, 0x11 }, // GIP_CLKB_1
+	{ 0x51, 0x12 }, // GIP_CLKB_2
+	{ 0x52, 0x13 }, // GIP_CLKB_3
+	{ 0x53, 0x14 }, // GIP_CLKB_4
+	{ 0x54, 0x11 }, // GIP_CLKB_5
+	{ 0x55, 0xf8 }, // GIP_CLKB_6
+	{ 0x56, 0xf9 }, // GIP_CLKB_7
+	{ 0x57, 0x11 }, // GIP_CLKB_8
+	{ 0x58, 0xfa }, // GIP_CLKB_9
+	{ 0x59, 0xfb }, // GIP_CLKB_10
+	{ 0x60, 0x05 }, // GIP_CLKC_1
+	{ 0x61, 0x05 }, // GIP_CLKC_2
+	{ 0x65, 0x0a }, // GIP_CLKC_6
+	{ 0x66, 0x0a }, // GIP_CLKC_7
+	// Map internal GOA signals to GOA output pad
+	{ 0x82, 0x1e }, // PANELU2D3
+	{ 0x83, 0x1f }, // PANELU2D4
+	{ 0x84, 0x11 }, // PANELU2D5
+	{ 0x85, 0x02 }, // PANELU2D6
+	{ 0x86, 0x1e }, // PANELU2D7
+	{ 0x87, 0x1e }, // PANELU2D8
+	{ 0x88, 0x1f }, // PANELU2D9
+	{ 0x89, 0x0e }, // PANELU2D10
+	{ 0x8a, 0x0e }, // PANELU2D11
+	{ 0x8b, 0x10 }, // PANELU2D12
+	{ 0x8c, 0x10 }, // PANELU2D13
+	{ 0x8d, 0x0a }, // PANELU2D14
+	{ 0x8e, 0x0a }, // PANELU2D15
+	{ 0x8f, 0x0c }, // PANELU2D16
+	{ 0x90, 0x0c }, // PANELU2D17
+	{ 0x98, 0x1e }, // PANELU2D25
+	{ 0x99, 0x1f }, // PANELU2D26
+	{ 0x9a, 0x11 }, // PANELU2D27
+	{ 0x9b, 0x01 }, // PANELU2D28
+	{ 0x9c, 0x1e }, // PANELU2D29
+	{ 0x9d, 0x1e }, // PANELU2D30
+	{ 0x9e, 0x1f }, // PANELU2D31
+	{ 0x9f, 0x0d }, // PANELU2D32
+	{ 0xa0, 0x0d }, // PANELU2D33
+	{ 0xa1, 0x0f }, // PANELU2D34
+	{ 0xa2, 0x0f }, // PANELU2D35
+	{ 0xa3, 0x09 }, // PANELU2D36
+	{ 0xa4, 0x09 }, // PANELU2D37
+	{ 0xa5, 0x0b }, // PANELU2D38
+	{ 0xa6, 0x0b }, // PANELU2D39
+	{ 0xb2, 0x1f }, // PANELD2U3
+	{ 0xb3, 0x1e }, // PANELD2U4
+	{ 0xb4, 0x11 }, // PANELD2U5
+	{ 0xb5, 0x01 }, // PANELD2U6
+	{ 0xb6, 0x1e }, // PANELD2U7
+	{ 0xb7, 0x1e }, // PANELD2U8
+	{ 0xb8, 0x1f }, // PANELD2U9
+	{ 0xb9, 0x0b }, // PANELD2U10
+	{ 0xba, 0x0b }, // PANELD2U11
+	{ 0xbb, 0x09 }, // PANELD2U12
+	{ 0xbc, 0x09 }, // PANELD2U13
+	{ 0xbd, 0x0f }, // PANELD2U14
+	{ 0xbe, 0x0f }, // PANELD2U15
+	{ 0xbf, 0x0d }, // PANELD2U16
+	{ 0xc0, 0x0d }, // PANELD2U17
+	{ 0xc8, 0x1f }, // PANELD2U25
+	{ 0xc9, 0x1e }, // PANELD2U26
+	{ 0xca, 0x11 }, // PANELD2U27
+	{ 0xcb, 0x02 }, // PANELD2U28
+	{ 0xcc, 0x1e }, // PANELD2U29
+	{ 0xcd, 0x1e }, // PANELD2U30
+	{ 0xce, 0x1f }, // PANELD2U31
+	{ 0xcf, 0x0c }, // PANELD2U32
+	{ 0xd0, 0x0c }, // PANELD2U33
+	{ 0xd1, 0x0a }, // PANELD2U34
+	{ 0xd2, 0x0a }, // PANELD2U35
+	{ 0xd3, 0x10 }, // PANELD2U36
+	{ 0xd4, 0x10 }, // PANELD2U37
+	{ 0xd5, 0x0e }, // PANELD2U38
+	{ 0xd6, 0x0e }, // PANELD2U39
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
@@ -1046,6 +1230,21 @@ static const struct drm_display_mode ylm_lbv0345001h_v2_mode[] = {
 	},
 };
 
+static const struct drm_display_mode ylm_lbv0400001x_v1_mode[] = {
+	{
+		.clock = 24000,
+		.hdisplay = 640,
+		.hsync_start = 640 + 84,
+		.hsync_end = 640 + 84 + 20,
+		.htotal = 640 + 84 + 20 + 26,
+		.vdisplay = 480,
+		.vsync_start = 480 + 20,
+		.vsync_end = 480 + 20 + 4,
+		.vtotal = 480 + 20 + 4 + 16,
+		.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+	},
+};
+
 static const struct nv3052c_panel_info ltk035c5444t_panel_info = {
 	.display_modes = ltk035c5444t_modes,
 	.num_modes = ARRAY_SIZE(ltk035c5444t_modes),
@@ -1090,11 +1289,23 @@ static const struct nv3052c_panel_info ylm_lbv0345001h_v2_panel_info = {
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
 	{ "rg35xx-plus-panel", },
 	{ "rg35xx-plus-rev6-panel", },
+	{ "rg40xx-panel", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, nv3052c_ids);
@@ -1104,6 +1315,7 @@ static const struct of_device_id nv3052c_of_match[] = {
 	{ .compatible = "fascontek,fs035vg158", .data = &fs035vg158_panel_info },
 	{ .compatible = "anbernic,rg35xx-plus-panel", .data = &wl_355608_a8_panel_info },
 	{ .compatible = "anbernic,rg35xx-plus-rev6-panel", .data = &ylm_lbv0345001h_v2_panel_info },
+	{ .compatible = "anbernic,rg40xx-panel", .data = &ylm_lbv0400001x_v1_panel_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, nv3052c_of_match);
-- 
2.47.0


