Return-Path: <linux-kernel+bounces-572738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25909A6CDE9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 06:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9413D7A5626
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 05:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87954200B8A;
	Sun, 23 Mar 2025 05:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnY9YpAH"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CED1F63FE
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 05:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742707820; cv=none; b=Q5rQ4DPKQYAHDMEfac//j+1PdrWgJjCjwJ+k+knIYaNhG41qoTQK33+GqFHcN60lKklqxEn90x9uHsYh99PAQ6QOR+RPmScgZZEFVxrlASoIRDtkxn6MKx4uKDyaqDLZs/jmrBTWgcJ70j1EBHDdL+TNj8FYsdKODZZZC60IaZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742707820; c=relaxed/simple;
	bh=uEn/B2LQBP4zqULxeKkFpqKVw3GmvglrCHe4HZGzJmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fdHP6uj0SrrcXkG/c8TXVvLdNoFInEM/Lkz0Zi222ggVn2n/4Zz/DA1iIEkgyF2KHLYqqL1euTw9XW7/VhwdmE0nwEczX81FCux+AT3+kIIa0xrOCVswF8VT5vOXKE0rbMAKpr/ClEkVxeLpaPpYdjL4u39rnxjD1Nm0QoNbtcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnY9YpAH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-224191d92e4so62353215ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 22:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742707817; x=1743312617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nOpC1gRB1sns5Mk79BIwxZXQ2CiUTiEfp46qEEoRn9w=;
        b=hnY9YpAHNIIZ6mIc5a+8ZDWt7XyRPP4YKf0G35x8dMn2GvV157swBYqeZs/PgdSQhb
         z9/+2OW+dsQLgKcsKHuQboy0laVk0BUEpNLmaftiRck8lTjmoPu5ow8sTIk7Zi8vcPjy
         6G20an3fcRZkn4IZbFTnIDtYBYSEzwQ0XKOXaa6CGWai2YZX9FosmhjQqtjM1GcdKHcz
         IaAxQLLpMkW/ZcK+HX3pd/91ZbyKMf8eQOMkyI6wl5O4W0F0moEvpG4cIz2qer8I0JRf
         QUAqutjxWe71DvZIF+O+ThEeQVfILNZHrL1IJHQTlU+r+6A04h9TrYHKrR3C7IP4qBvv
         wK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742707817; x=1743312617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nOpC1gRB1sns5Mk79BIwxZXQ2CiUTiEfp46qEEoRn9w=;
        b=PX0743d+6XYVYsGrdNqmTd+kWoCCnDCgQ3JyokGFz6Ip6n/HUdJgShlZkU4tJ7cdCg
         gWRArPHjbfRkYNmcdN2Ptx7R5jTR6CzMP9zl14hwEiOT0a87mmRpHEeYuTL+dp34weGC
         D8CatWUkeIztNngQw5JIDelntgE1osYsDVv/n1qY9HL9b/jvJxTCJlC9UUx3w7xHQ0ad
         p9fOpplR1AqdojXOuHeY3oRw2Jq2hHNj6tdu7s8e+fUJFUTPrZNxFuVbVJKZTU7A8IdK
         HGX0fW4Q/Fnf7bwZljOpjWcS3g/MeIUWFHi7jbJ9yzxZzj1U74sFiW/vyB4Q7iIdiE2E
         nQQg==
X-Forwarded-Encrypted: i=1; AJvYcCXq0a2d1bzf29b0ZAc+05Hv2CoDSOZY7UrPzkYZmxD/EUEyaGM8TivNmQFgKPIlGXsg1fomVIbN7I6jV98=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPmu+WG7rycpmKhcycITqAGGEWranGgRO6LnIn1GXLUi80GsMA
	h5lTz1X1sQ/eV8e24gi21XuzktzO4hrNmhqrTCvOWwBoUqmk4bcL
X-Gm-Gg: ASbGncvUa6BTh4Y05TE5DIR4pt6BvQUhtlM01SXgc8VZ+hbZM6IgnUp67v0VvnXSGD+
	dvw2q0QWVX7O+BsJszalwSuh10av+MzlFkPALfLdjbLTywvHwCE+kIlQCLi/gNntuZSd3WGj5xd
	GQrN8Oox9v8PEAXEfS0orbt8zRtx/ZOmGJMiJZRBpWiTuw03xMd/NHS0yRzr00AS51RA6I87VzM
	9mlAA0CQSeV02DqE8915/aGBgz2jJkwc8Xgg4cOnWx92lOFKoUkAjDiIyqb7JlHpDDeizk+sV7P
	OcncGMsa9cp3B3vHkanYnCZ8JDx/vcYi4KqiknmnkEOHGxa48+CSNren5nzGEkk1Po+3TA==
X-Google-Smtp-Source: AGHT+IHQX46VW59wZcknQi1Y8aMqsU4aiMH4qzko/BpE7yjzmA48Cj+8vox4cYapLOdVMO0+pNhYUw==
X-Received: by 2002:a17:903:2343:b0:223:569d:9a8b with SMTP id d9443c01a7336-22780d8cff9mr87687795ad.18.1742707816976;
        Sat, 22 Mar 2025 22:30:16 -0700 (PDT)
Received: from distilledx.SRMIST.EDU.IN ([2401:4900:6291:2315:91d4:5260:dd34:58e7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811fa212sm44717745ad.242.2025.03.22.22.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 22:30:16 -0700 (PDT)
From: Tejas Vipin <tejasvipin76@gmail.com>
To: neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	megi@xff.cz,
	javierm@redhat.com
Cc: quic_jesszhan@quicinc.com,
	dianders@chromium.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	asrivats@redhat.com,
	Tejas Vipin <tejasvipin76@gmail.com>
Subject: [PATCH] drm/panel: himax-hx8394: transition to mipi_dsi wrapped functions
Date: Sun, 23 Mar 2025 11:00:07 +0530
Message-ID: <20250323053007.681346-1-tejasvipin76@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes the himax-hx8394 panel to use multi style functions for
improved error handling.

Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
 drivers/gpu/drm/panel/panel-himax-hx8394.c | 444 ++++++++++-----------
 1 file changed, 210 insertions(+), 234 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx8394.c b/drivers/gpu/drm/panel/panel-himax-hx8394.c
index 92b03a2f65a3..72afba63bee4 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx8394.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx8394.c
@@ -80,7 +80,7 @@ struct hx8394_panel_desc {
 	unsigned int lanes;
 	unsigned long mode_flags;
 	enum mipi_dsi_pixel_format format;
-	int (*init_sequence)(struct hx8394 *ctx);
+	void (*init_sequence)(struct mipi_dsi_multi_context *dsi_ctx);
 };
 
 static inline struct hx8394 *panel_to_hx8394(struct drm_panel *panel)
@@ -88,98 +88,94 @@ static inline struct hx8394 *panel_to_hx8394(struct drm_panel *panel)
 	return container_of(panel, struct hx8394, panel);
 }
 
-static int hsd060bhw4_init_sequence(struct hx8394 *ctx)
+static void hsd060bhw4_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
 {
-	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-
 	/* 5.19.8 SETEXTC: Set extension command (B9h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETEXTC,
-			       0xff, 0x83, 0x94);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETEXTC,
+				     0xff, 0x83, 0x94);
 
 	/* 5.19.2 SETPOWER: Set power (B1h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETPOWER,
-			       0x48, 0x11, 0x71, 0x09, 0x32, 0x24, 0x71, 0x31, 0x55, 0x30);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETPOWER,
+				     0x48, 0x11, 0x71, 0x09, 0x32, 0x24, 0x71, 0x31, 0x55, 0x30);
 
 	/* 5.19.9 SETMIPI: Set MIPI control (BAh) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETMIPI,
-			       0x63, 0x03, 0x68, 0x6b, 0xb2, 0xc0);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETMIPI,
+				     0x63, 0x03, 0x68, 0x6b, 0xb2, 0xc0);
 
 	/* 5.19.3 SETDISP: Set display related register (B2h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETDISP,
-			       0x00, 0x80, 0x78, 0x0c, 0x07);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETDISP,
+				     0x00, 0x80, 0x78, 0x0c, 0x07);
 
 	/* 5.19.4 SETCYC: Set display waveform cycles (B4h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETCYC,
-			       0x12, 0x63, 0x12, 0x63, 0x12, 0x63, 0x01, 0x0c, 0x7c, 0x55,
-			       0x00, 0x3f, 0x12, 0x6b, 0x12, 0x6b, 0x12, 0x6b, 0x01, 0x0c,
-			       0x7c);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETCYC,
+				     0x12, 0x63, 0x12, 0x63, 0x12, 0x63, 0x01, 0x0c, 0x7c, 0x55,
+				     0x00, 0x3f, 0x12, 0x6b, 0x12, 0x6b, 0x12, 0x6b, 0x01, 0x0c,
+				     0x7c);
 
 	/* 5.19.19 SETGIP0: Set GIP Option0 (D3h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETGIP0,
-			       0x00, 0x00, 0x00, 0x00, 0x3c, 0x1c, 0x00, 0x00, 0x32, 0x10,
-			       0x09, 0x00, 0x09, 0x32, 0x15, 0xad, 0x05, 0xad, 0x32, 0x00,
-			       0x00, 0x00, 0x00, 0x37, 0x03, 0x0b, 0x0b, 0x37, 0x00, 0x00,
-			       0x00, 0x0c, 0x40);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETGIP0,
+				     0x00, 0x00, 0x00, 0x00, 0x3c, 0x1c, 0x00, 0x00, 0x32, 0x10,
+				     0x09, 0x00, 0x09, 0x32, 0x15, 0xad, 0x05, 0xad, 0x32, 0x00,
+				     0x00, 0x00, 0x00, 0x37, 0x03, 0x0b, 0x0b, 0x37, 0x00, 0x00,
+				     0x00, 0x0c, 0x40);
 
 	/* 5.19.20 Set GIP Option1 (D5h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETGIP1,
-			       0x19, 0x19, 0x18, 0x18, 0x1b, 0x1b, 0x1a, 0x1a, 0x00, 0x01,
-			       0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x20, 0x21, 0x18, 0x18,
-			       0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
-			       0x24, 0x25, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
-			       0x18, 0x18, 0x18, 0x18, 0x18, 0x18);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETGIP1,
+				     0x19, 0x19, 0x18, 0x18, 0x1b, 0x1b, 0x1a, 0x1a, 0x00, 0x01,
+				     0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x20, 0x21, 0x18, 0x18,
+				     0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+				     0x24, 0x25, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+				     0x18, 0x18, 0x18, 0x18, 0x18, 0x18);
 
 	/* 5.19.21 Set GIP Option2 (D6h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETGIP2,
-			       0x18, 0x18, 0x19, 0x19, 0x1b, 0x1b, 0x1a, 0x1a, 0x07, 0x06,
-			       0x05, 0x04, 0x03, 0x02, 0x01, 0x00, 0x25, 0x24, 0x18, 0x18,
-			       0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
-			       0x21, 0x20, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
-			       0x18, 0x18, 0x18, 0x18, 0x18, 0x18);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETGIP2,
+				     0x18, 0x18, 0x19, 0x19, 0x1b, 0x1b, 0x1a, 0x1a, 0x07, 0x06,
+				     0x05, 0x04, 0x03, 0x02, 0x01, 0x00, 0x25, 0x24, 0x18, 0x18,
+				     0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+				     0x21, 0x20, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+				     0x18, 0x18, 0x18, 0x18, 0x18, 0x18);
 
 	/* 5.19.25 SETGAMMA: Set gamma curve related setting (E0h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETGAMMA,
-			       0x00, 0x04, 0x0c, 0x12, 0x14, 0x18, 0x1a, 0x18, 0x31, 0x3f,
-			       0x4d, 0x4c, 0x54, 0x65, 0x6b, 0x70, 0x7f, 0x82, 0x7e, 0x8a,
-			       0x99, 0x4a, 0x48, 0x49, 0x4b, 0x4a, 0x4c, 0x4b, 0x7f, 0x00,
-			       0x04, 0x0c, 0x11, 0x13, 0x17, 0x1a, 0x18, 0x31,
-			       0x3f, 0x4d, 0x4c, 0x54, 0x65, 0x6b, 0x70, 0x7f,
-			       0x82, 0x7e, 0x8a, 0x99, 0x4a, 0x48, 0x49, 0x4b,
-			       0x4a, 0x4c, 0x4b, 0x7f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETGAMMA,
+				     0x00, 0x04, 0x0c, 0x12, 0x14, 0x18, 0x1a, 0x18, 0x31, 0x3f,
+				     0x4d, 0x4c, 0x54, 0x65, 0x6b, 0x70, 0x7f, 0x82, 0x7e, 0x8a,
+				     0x99, 0x4a, 0x48, 0x49, 0x4b, 0x4a, 0x4c, 0x4b, 0x7f, 0x00,
+				     0x04, 0x0c, 0x11, 0x13, 0x17, 0x1a, 0x18, 0x31,
+				     0x3f, 0x4d, 0x4c, 0x54, 0x65, 0x6b, 0x70, 0x7f,
+				     0x82, 0x7e, 0x8a, 0x99, 0x4a, 0x48, 0x49, 0x4b,
+				     0x4a, 0x4c, 0x4b, 0x7f);
 
 	/* 5.19.17 SETPANEL (CCh) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETPANEL,
-			       0x0b);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETPANEL,
+				     0x0b);
 
 	/* Unknown command, not listed in the HX8394-F datasheet */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_UNKNOWN1,
-			       0x1f, 0x31);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_UNKNOWN1,
+				     0x1f, 0x31);
 
 	/* 5.19.5 SETVCOM: Set VCOM voltage (B6h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETVCOM,
-			       0x7d, 0x7d);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETVCOM,
+				     0x7d, 0x7d);
 
 	/* Unknown command, not listed in the HX8394-F datasheet */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_UNKNOWN3,
-			       0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_UNKNOWN3,
+				     0x02);
 
 	/* 5.19.11 Set register bank (BDh) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETREGBANK,
-			       0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETREGBANK,
+				     0x01);
 
 	/* 5.19.2 SETPOWER: Set power (B1h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETPOWER,
-			       0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETPOWER,
+				     0x00);
 
 	/* 5.19.11 Set register bank (BDh) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETREGBANK,
-			       0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETREGBANK,
+				     0x00);
 
 	/* Unknown command, not listed in the HX8394-F datasheet */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_UNKNOWN3,
-			       0xed);
-
-	return 0;
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_UNKNOWN3,
+				     0xed);
 }
 
 static const struct drm_display_mode hsd060bhw4_mode = {
@@ -205,114 +201,110 @@ static const struct hx8394_panel_desc hsd060bhw4_desc = {
 	.init_sequence = hsd060bhw4_init_sequence,
 };
 
-static int powkiddy_x55_init_sequence(struct hx8394 *ctx)
+static void powkiddy_x55_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
 {
-	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-
 	/* 5.19.8 SETEXTC: Set extension command (B9h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETEXTC,
-			       0xff, 0x83, 0x94);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETEXTC,
+				     0xff, 0x83, 0x94);
 
 	/* 5.19.9 SETMIPI: Set MIPI control (BAh) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETMIPI,
-			       0x63, 0x03, 0x68, 0x6b, 0xb2, 0xc0);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETMIPI,
+				     0x63, 0x03, 0x68, 0x6b, 0xb2, 0xc0);
 
 	/* 5.19.2 SETPOWER: Set power (B1h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETPOWER,
-			       0x48, 0x12, 0x72, 0x09, 0x32, 0x54, 0x71, 0x71, 0x57, 0x47);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETPOWER,
+				     0x48, 0x12, 0x72, 0x09, 0x32, 0x54, 0x71, 0x71, 0x57, 0x47);
 
 	/* 5.19.3 SETDISP: Set display related register (B2h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETDISP,
-			       0x00, 0x80, 0x64, 0x2c, 0x16, 0x2f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETDISP,
+				     0x00, 0x80, 0x64, 0x2c, 0x16, 0x2f);
 
 	/* 5.19.4 SETCYC: Set display waveform cycles (B4h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETCYC,
-			       0x73, 0x74, 0x73, 0x74, 0x73, 0x74, 0x01, 0x0c, 0x86, 0x75,
-			       0x00, 0x3f, 0x73, 0x74, 0x73, 0x74, 0x73, 0x74, 0x01, 0x0c,
-			       0x86);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETCYC,
+				     0x73, 0x74, 0x73, 0x74, 0x73, 0x74, 0x01, 0x0c, 0x86, 0x75,
+				     0x00, 0x3f, 0x73, 0x74, 0x73, 0x74, 0x73, 0x74, 0x01, 0x0c,
+				     0x86);
 
 	/* 5.19.5 SETVCOM: Set VCOM voltage (B6h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETVCOM,
-			       0x6e, 0x6e);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETVCOM,
+				     0x6e, 0x6e);
 
 	/* 5.19.19 SETGIP0: Set GIP Option0 (D3h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETGIP0,
-			       0x00, 0x00, 0x07, 0x07, 0x40, 0x07, 0x0c, 0x00, 0x08, 0x10,
-			       0x08, 0x00, 0x08, 0x54, 0x15, 0x0a, 0x05, 0x0a, 0x02, 0x15,
-			       0x06, 0x05, 0x06, 0x47, 0x44, 0x0a, 0x0a, 0x4b, 0x10, 0x07,
-			       0x07, 0x0c, 0x40);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETGIP0,
+				     0x00, 0x00, 0x07, 0x07, 0x40, 0x07, 0x0c, 0x00, 0x08, 0x10,
+				     0x08, 0x00, 0x08, 0x54, 0x15, 0x0a, 0x05, 0x0a, 0x02, 0x15,
+				     0x06, 0x05, 0x06, 0x47, 0x44, 0x0a, 0x0a, 0x4b, 0x10, 0x07,
+				     0x07, 0x0c, 0x40);
 
 	/* 5.19.20 Set GIP Option1 (D5h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETGIP1,
-			       0x1c, 0x1c, 0x1d, 0x1d, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05,
-			       0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x24, 0x25, 0x18, 0x18,
-			       0x26, 0x27, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
-			       0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x20, 0x21,
-			       0x18, 0x18, 0x18, 0x18);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETGIP1,
+				     0x1c, 0x1c, 0x1d, 0x1d, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05,
+				     0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x24, 0x25, 0x18, 0x18,
+				     0x26, 0x27, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+				     0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x20, 0x21,
+				     0x18, 0x18, 0x18, 0x18);
 
 	/* 5.19.21 Set GIP Option2 (D6h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETGIP2,
-			       0x1c, 0x1c, 0x1d, 0x1d, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02,
-			       0x01, 0x00, 0x0b, 0x0a, 0x09, 0x08, 0x21, 0x20, 0x18, 0x18,
-			       0x27, 0x26, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
-			       0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x25, 0x24,
-			       0x18, 0x18, 0x18, 0x18);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETGIP2,
+				     0x1c, 0x1c, 0x1d, 0x1d, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02,
+				     0x01, 0x00, 0x0b, 0x0a, 0x09, 0x08, 0x21, 0x20, 0x18, 0x18,
+				     0x27, 0x26, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+				     0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x25, 0x24,
+				     0x18, 0x18, 0x18, 0x18);
 
 	/* 5.19.25 SETGAMMA: Set gamma curve related setting (E0h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETGAMMA,
-			       0x00, 0x0a, 0x15, 0x1b, 0x1e, 0x21, 0x24, 0x22, 0x47, 0x56,
-			       0x65, 0x66, 0x6e, 0x82, 0x88, 0x8b, 0x9a, 0x9d, 0x98, 0xa8,
-			       0xb9, 0x5d, 0x5c, 0x61, 0x66, 0x6a, 0x6f, 0x7f, 0x7f, 0x00,
-			       0x0a, 0x15, 0x1b, 0x1e, 0x21, 0x24, 0x22, 0x47, 0x56, 0x65,
-			       0x65, 0x6e, 0x81, 0x87, 0x8b, 0x98, 0x9d, 0x99, 0xa8, 0xba,
-			       0x5d, 0x5d, 0x62, 0x67, 0x6b, 0x72, 0x7f, 0x7f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETGAMMA,
+				     0x00, 0x0a, 0x15, 0x1b, 0x1e, 0x21, 0x24, 0x22, 0x47, 0x56,
+				     0x65, 0x66, 0x6e, 0x82, 0x88, 0x8b, 0x9a, 0x9d, 0x98, 0xa8,
+				     0xb9, 0x5d, 0x5c, 0x61, 0x66, 0x6a, 0x6f, 0x7f, 0x7f, 0x00,
+				     0x0a, 0x15, 0x1b, 0x1e, 0x21, 0x24, 0x22, 0x47, 0x56, 0x65,
+				     0x65, 0x6e, 0x81, 0x87, 0x8b, 0x98, 0x9d, 0x99, 0xa8, 0xba,
+				     0x5d, 0x5d, 0x62, 0x67, 0x6b, 0x72, 0x7f, 0x7f);
 
 	/* Unknown command, not listed in the HX8394-F datasheet */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_UNKNOWN1,
-			       0x1f, 0x31);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_UNKNOWN1,
+				     0x1f, 0x31);
 
 	/* 5.19.17 SETPANEL (CCh) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETPANEL,
-			       0x0b);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETPANEL,
+				     0x0b);
 
 	/* Unknown command, not listed in the HX8394-F datasheet */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_UNKNOWN3,
-			       0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_UNKNOWN3,
+				     0x02);
 
 	/* 5.19.11 Set register bank (BDh) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETREGBANK,
-			       0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETREGBANK,
+				     0x02);
 
 	/* Unknown command, not listed in the HX8394-F datasheet */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_UNKNOWN4,
-			       0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
-			       0xff, 0xff);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_UNKNOWN4,
+				     0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+				     0xff, 0xff);
 
 	/* 5.19.11 Set register bank (BDh) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETREGBANK,
-			       0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETREGBANK,
+				     0x00);
 
 	/* 5.19.11 Set register bank (BDh) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETREGBANK,
-			       0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETREGBANK,
+				     0x01);
 
 	/* 5.19.2 SETPOWER: Set power (B1h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETPOWER,
-			       0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETPOWER,
+				     0x00);
 
 	/* 5.19.11 Set register bank (BDh) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETREGBANK,
-			       0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETREGBANK,
+				     0x00);
 
 	/* Unknown command, not listed in the HX8394-F datasheet */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_UNKNOWN5,
-			       0x40, 0x81, 0x50, 0x00, 0x1a, 0xfc, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_UNKNOWN5,
+				     0x40, 0x81, 0x50, 0x00, 0x1a, 0xfc, 0x01);
 
 	/* Unknown command, not listed in the HX8394-F datasheet */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_UNKNOWN2,
-			       0xed);
-
-	return 0;
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_UNKNOWN2,
+				     0xed);
 }
 
 static const struct drm_display_mode powkiddy_x55_mode = {
@@ -339,131 +331,127 @@ static const struct hx8394_panel_desc powkiddy_x55_desc = {
 	.init_sequence = powkiddy_x55_init_sequence,
 };
 
-static int mchp_ac40t08a_init_sequence(struct hx8394 *ctx)
+static void mchp_ac40t08a_init_sequence(struct mipi_dsi_multi_context *dsi_ctx)
 {
-	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-
 	/* DCS commands do not seem to be sent correclty without this delay */
-	msleep(20);
+	mipi_dsi_msleep(dsi_ctx, 20);
 
 	/* 5.19.8 SETEXTC: Set extension command (B9h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETEXTC,
-			       0xff, 0x83, 0x94);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETEXTC,
+				     0xff, 0x83, 0x94);
 
 	/* 5.19.9 SETMIPI: Set MIPI control (BAh) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETMIPI,
-			       0x63, 0x03, 0x68, 0x6b, 0xb2, 0xc0);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETMIPI,
+				     0x63, 0x03, 0x68, 0x6b, 0xb2, 0xc0);
 
 	/* 5.19.2 SETPOWER: Set power (B1h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETPOWER,
-			       0x48, 0x12, 0x72, 0x09, 0x32, 0x54,
-			       0x71, 0x71, 0x57, 0x47);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETPOWER,
+				     0x48, 0x12, 0x72, 0x09, 0x32, 0x54,
+				     0x71, 0x71, 0x57, 0x47);
 
 	/* 5.19.3 SETDISP: Set display related register (B2h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETDISP,
-			       0x00, 0x80, 0x64, 0x0c, 0x0d, 0x2f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETDISP,
+				     0x00, 0x80, 0x64, 0x0c, 0x0d, 0x2f);
 
 	/* 5.19.4 SETCYC: Set display waveform cycles (B4h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETCYC,
-			       0x73, 0x74, 0x73, 0x74, 0x73, 0x74,
-			       0x01, 0x0c, 0x86, 0x75, 0x00, 0x3f,
-			       0x73, 0x74, 0x73, 0x74, 0x73, 0x74,
-			       0x01, 0x0c, 0x86);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETCYC,
+				     0x73, 0x74, 0x73, 0x74, 0x73, 0x74,
+				     0x01, 0x0c, 0x86, 0x75, 0x00, 0x3f,
+				     0x73, 0x74, 0x73, 0x74, 0x73, 0x74,
+				     0x01, 0x0c, 0x86);
 
 	/* 5.19.5 SETVCOM: Set VCOM voltage (B6h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETVCOM,
-			       0x6e, 0x6e);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETVCOM,
+				     0x6e, 0x6e);
 
 	/* 5.19.19 SETGIP0: Set GIP Option0 (D3h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETGIP0,
-			       0x00, 0x00, 0x07, 0x07, 0x40, 0x07,
-			       0x0c, 0x00, 0x08, 0x10, 0x08, 0x00,
-			       0x08, 0x54, 0x15, 0x0a, 0x05, 0x0a,
-			       0x02, 0x15, 0x06, 0x05, 0x06, 0x47,
-			       0x44, 0x0a, 0x0a, 0x4b, 0x10, 0x07,
-			       0x07, 0x0c, 0x40);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETGIP0,
+				     0x00, 0x00, 0x07, 0x07, 0x40, 0x07,
+				     0x0c, 0x00, 0x08, 0x10, 0x08, 0x00,
+				     0x08, 0x54, 0x15, 0x0a, 0x05, 0x0a,
+				     0x02, 0x15, 0x06, 0x05, 0x06, 0x47,
+				     0x44, 0x0a, 0x0a, 0x4b, 0x10, 0x07,
+				     0x07, 0x0c, 0x40);
 
 	/* 5.19.20 Set GIP Option1 (D5h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETGIP1,
-			       0x1c, 0x1c, 0x1d, 0x1d, 0x00, 0x01,
-			       0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
-			       0x08, 0x09, 0x0a, 0x0b, 0x24, 0x25,
-			       0x18, 0x18, 0x26, 0x27, 0x18, 0x18,
-			       0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
-			       0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
-			       0x18, 0x18, 0x20, 0x21, 0x18, 0x18,
-			       0x18, 0x18);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETGIP1,
+				     0x1c, 0x1c, 0x1d, 0x1d, 0x00, 0x01,
+				     0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+				     0x08, 0x09, 0x0a, 0x0b, 0x24, 0x25,
+				     0x18, 0x18, 0x26, 0x27, 0x18, 0x18,
+				     0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+				     0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+				     0x18, 0x18, 0x20, 0x21, 0x18, 0x18,
+				     0x18, 0x18);
 
 	/* 5.19.21 Set GIP Option2 (D6h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETGIP2,
-			       0x1c, 0x1c, 0x1d, 0x1d, 0x07, 0x06,
-			       0x05, 0x04, 0x03, 0x02, 0x01, 0x00,
-			       0x0b, 0x0a, 0x09, 0x08, 0x21, 0x20,
-			       0x18, 0x18, 0x27, 0x26, 0x18, 0x18,
-			       0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
-			       0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
-			       0x18, 0x18, 0x25, 0x24, 0x18, 0x18,
-			       0x18, 0x18);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETGIP2,
+				     0x1c, 0x1c, 0x1d, 0x1d, 0x07, 0x06,
+				     0x05, 0x04, 0x03, 0x02, 0x01, 0x00,
+				     0x0b, 0x0a, 0x09, 0x08, 0x21, 0x20,
+				     0x18, 0x18, 0x27, 0x26, 0x18, 0x18,
+				     0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+				     0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+				     0x18, 0x18, 0x25, 0x24, 0x18, 0x18,
+				     0x18, 0x18);
 
 	/* 5.19.25 SETGAMMA: Set gamma curve related setting (E0h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETGAMMA,
-			       0x00, 0x0a, 0x15, 0x1b, 0x1e, 0x21,
-			       0x24, 0x22, 0x47, 0x56, 0x65, 0x66,
-			       0x6e, 0x82, 0x88, 0x8b, 0x9a, 0x9d,
-			       0x98, 0xa8, 0xb9, 0x5d, 0x5c, 0x61,
-			       0x66, 0x6a, 0x6f, 0x7f, 0x7f, 0x00,
-			       0x0a, 0x15, 0x1b, 0x1e, 0x21, 0x24,
-			       0x22, 0x47, 0x56, 0x65, 0x65, 0x6e,
-			       0x81, 0x87, 0x8b, 0x98, 0x9d, 0x99,
-			       0xa8, 0xba, 0x5d, 0x5d, 0x62, 0x67,
-			       0x6b, 0x72, 0x7f, 0x7f);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETGAMMA,
+				     0x00, 0x0a, 0x15, 0x1b, 0x1e, 0x21,
+				     0x24, 0x22, 0x47, 0x56, 0x65, 0x66,
+				     0x6e, 0x82, 0x88, 0x8b, 0x9a, 0x9d,
+				     0x98, 0xa8, 0xb9, 0x5d, 0x5c, 0x61,
+				     0x66, 0x6a, 0x6f, 0x7f, 0x7f, 0x00,
+				     0x0a, 0x15, 0x1b, 0x1e, 0x21, 0x24,
+				     0x22, 0x47, 0x56, 0x65, 0x65, 0x6e,
+				     0x81, 0x87, 0x8b, 0x98, 0x9d, 0x99,
+				     0xa8, 0xba, 0x5d, 0x5d, 0x62, 0x67,
+				     0x6b, 0x72, 0x7f, 0x7f);
 
 	/* Unknown command, not listed in the HX8394-F datasheet (C0H) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_UNKNOWN1,
-			       0x1f, 0x73);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_UNKNOWN1,
+				     0x1f, 0x73);
 
 	/* Set CABC control (C9h)*/
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETCABC,
-			       0x76, 0x00, 0x30);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETCABC,
+				     0x76, 0x00, 0x30);
 
 	/* 5.19.17 SETPANEL (CCh) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETPANEL,
-			       0x0b);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETPANEL,
+				     0x0b);
 
 	/* Unknown command, not listed in the HX8394-F datasheet (D4h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_UNKNOWN3,
-			       0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_UNKNOWN3,
+				     0x02);
 
 	/* 5.19.11 Set register bank (BDh) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETREGBANK,
-			       0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETREGBANK,
+				     0x02);
 
 	/* 5.19.11 Set register bank (D8h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_UNKNOWN4,
-			       0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
-			       0xff, 0xff, 0xff, 0xff, 0xff, 0xff);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_UNKNOWN4,
+				     0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+				     0xff, 0xff, 0xff, 0xff, 0xff, 0xff);
 
 	/* 5.19.11 Set register bank (BDh) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETREGBANK,
-			       0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETREGBANK,
+				     0x00);
 
 	/* 5.19.11 Set register bank (BDh) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETREGBANK,
-			       0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETREGBANK,
+				     0x01);
 
 	/* 5.19.2 SETPOWER: Set power (B1h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETPOWER,
-			       0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETPOWER,
+				     0x00);
 
 	/* 5.19.11 Set register bank (BDh) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_SETREGBANK,
-			       0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_SETREGBANK,
+				     0x00);
 
 	/* Unknown command, not listed in the HX8394-F datasheet (C6h) */
-	mipi_dsi_dcs_write_seq(dsi, HX8394_CMD_UNKNOWN2,
-			       0xed);
-
-	return 0;
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, HX8394_CMD_UNKNOWN2,
+				     0xed);
 }
 
 static const struct drm_display_mode mchp_ac40t08a_mode = {
@@ -493,35 +481,28 @@ static int hx8394_enable(struct drm_panel *panel)
 {
 	struct hx8394 *ctx = panel_to_hx8394(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-	int ret;
-
-	ret = ctx->desc->init_sequence(ctx);
-	if (ret) {
-		dev_err(ctx->dev, "Panel init sequence failed: %d\n", ret);
-		return ret;
-	}
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret) {
-		dev_err(ctx->dev, "Failed to exit sleep mode: %d\n", ret);
-		return ret;
-	}
+	ctx->desc->init_sequence(&dsi_ctx);
 
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
 	/* Panel is operational 120 msec after reset */
-	msleep(120);
+	mipi_dsi_msleep(&dsi_ctx, 120);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret) {
-		dev_err(ctx->dev, "Failed to turn on the display: %d\n", ret);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	if (dsi_ctx.accum_err)
 		goto sleep_in;
-	}
 
 	return 0;
 
 sleep_in:
+	int ret = dsi_ctx.accum_err;
+
+	dsi_ctx.accum_err = 0;
+
 	/* This will probably fail, but let's try orderly power off anyway. */
-	if (!mipi_dsi_dcs_enter_sleep_mode(dsi))
-		msleep(50);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 50);
 
 	return ret;
 }
@@ -530,17 +511,12 @@ static int hx8394_disable(struct drm_panel *panel)
 {
 	struct hx8394 *ctx = panel_to_hx8394(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret) {
-		dev_err(ctx->dev, "Failed to enter sleep mode: %d\n", ret);
-		return ret;
-	}
-
-	msleep(50); /* about 3 frames */
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 50); /* about 3 frames */
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int hx8394_unprepare(struct drm_panel *panel)
-- 
2.49.0


