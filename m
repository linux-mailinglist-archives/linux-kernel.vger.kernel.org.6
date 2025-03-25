Return-Path: <linux-kernel+bounces-575057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E09A6ED04
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8EF3AE39A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713A9255250;
	Tue, 25 Mar 2025 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPpAQt0X"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61CD254AF6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742896041; cv=none; b=o7tVALAUSWJvzA7tu+UkdNPJjKx8QiDvfe9AAPuODr9rP6I5fBZiGIL45ujdfZhtp9DH5OEvYxG48sz23Ndeu2KwZLvxy7FWhny5LOM6q83wrON4ocVGWxhwhRd3g1Qm0OqKM6gophEuZbi0pbd7qyeHkRJAuAeZEskGEdLl+Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742896041; c=relaxed/simple;
	bh=gPdwBrq1hJamQ+79G/TI4BvLSGYAECoGxXdW44FanpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qfcRkypMtonAiit8hqf4Z2dLHpOT1ouO+0Q93nYS9MsOMgLbCpRbRiNHzCre8tSc1HJAuPHJ6qWuZxDmGbI1Y+FenRwn8P/CsBI85WVudDvGc1jReYFx9wcQsCmtiqlkeVa4vJDgBV+rd3MOrVu2YC4FrsFM9W22wXSQNZNQ96w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPpAQt0X; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-224341bbc1dso101075755ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 02:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742896039; x=1743500839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KhJlowFE0BCTZgFwXQVnrLWzQtFejAOffegD1qT+lVM=;
        b=lPpAQt0XXfPbjjGzd7KouJEHEJI48ZPL650Ofa1ZBP/J2v+TFZ5NDcHVq0Zdd7HBk5
         eOF2kA9lThw5d5LvRs1KJ79MpLWhtw1d0idfzRPsSk9rhwjDUj8OYKvi4ZeCjrToUlF5
         UNj97UBtQTzjmQPdxjxaAROO5m/MRp/ntKqEaH2++UQb95sxB2v6MeVmY6yKIupVWtAp
         ynkXXx4+VbKZ6B7D0GLA9zAWmfIGZsQxh/y/rVIfslOXqLTy2ZhE1TgWb6VgNPTNVF5Q
         /a1GnoS+u3Lm1BMzzggAu0+wxniMkZEsoROhmbk5YqxXJqccwPpFejiK+oUJB5hma0o3
         uxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742896039; x=1743500839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhJlowFE0BCTZgFwXQVnrLWzQtFejAOffegD1qT+lVM=;
        b=mYmU9/OQ3vQLwA0nUD08YJcEGcw08Fcqp6hy9Gw2IPZuBqluk9u2zvNdiX5ufCPHry
         qZDxayrmMNdtebW7L00UJaWX3HhpLev7b7qSunIFK7oqkYRbgcMJfaGK1WMVTVeXduGk
         6sxj6pA5ZX/TQt2YNpb6eLjye0Ss+09SMByn6Qxstu4mryPsH8tbuwsvg3IJmmdINkY/
         8659p/CKFDfFKS744F6GlZHw1gAckIoh7p0q/lVGhPHAF/yeiLrkGOzpW6tQlg2ymCnx
         ynF/ZrLPTS4g6/t5pRhu12gqOhHcxDRB7TWTLadrQaGnqd59BunHXNh+MALRx+XmM2sN
         XRow==
X-Forwarded-Encrypted: i=1; AJvYcCX5I0sxU9wYqlSgV2390+5FusS5nXGtJR/nfgT510EC3opgJI2KvUuDrBAkAUK1bTeI/ZgrGNoFNsf0pVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YytFgWsZxDMOGmkrSAz3H72CYlMQLn1mpmgocsKBJUTQR9kb0YC
	mv70bCCHaFlpl10LAIvXGy2HP8TNeVZvLeXN8MRR6pzykY+90tfl
X-Gm-Gg: ASbGncujcAr/Q8NyuUzM6sd6owaUJkHZyeOGPjfiZ6ee2OrzOoxiM056rvk7WYnuKP3
	3swhG306LmotSloy2YUzUsLypVG85BuAIK11btvzB09h/XCJoSLJLVaNyma2/qzQiH8Hi3hzw8O
	W22AwQmQNfblicYhvDyRbrCjmaRCj5Yc4wz23rQWjLSOQsXMMFg6MA4ixwB1URdd/qzCtRx5rZn
	i8pPSG3XfEnnhqE6Xvaj+j+apaqZXgyZFSPiitGccgrWJHX6gHSXDVhdk4yA0mWeX0nuNDZKbLA
	awWwzpBYzLG6kBpgZNYZGjCo5fhseq9FmZnIyPpARuWpmdPXu1iodKx7U/z4MKbKLA==
X-Google-Smtp-Source: AGHT+IETsvw6Rm5mWW/ql/I12bMlRRKlBdgbhCcMBWix26ySp3Z/Yj9vqpHFcOroRKyQOjwyx9ALSw==
X-Received: by 2002:a17:902:d504:b0:215:bc30:c952 with SMTP id d9443c01a7336-22780c68a03mr220550775ad.6.1742896038499;
        Tue, 25 Mar 2025 02:47:18 -0700 (PDT)
Received: from distilledx.localdomain ([2401:4900:6284:2aee:cc35:9d5:d0e6:da4c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811daa2dsm86030465ad.171.2025.03.25.02.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 02:47:18 -0700 (PDT)
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
Subject: [PATCH v2] drm/panel: himax-hx8394: transition to mipi_dsi wrapped functions
Date: Tue, 25 Mar 2025 15:17:07 +0530
Message-ID: <20250325094707.961349-1-tejasvipin76@gmail.com>
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
---
Changes in v2:
    - Revert behavior change in hx8394_enable
    - Move variable declaration to top of function

Link to v1: https://lore.kernel.org/all/20250323053007.681346-1-tejasvipin76@gmail.com/
---
 drivers/gpu/drm/panel/panel-himax-hx8394.c | 441 ++++++++++-----------
 1 file changed, 210 insertions(+), 231 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx8394.c b/drivers/gpu/drm/panel/panel-himax-hx8394.c
index 92b03a2f65a3..ff994bf0e3cc 100644
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
@@ -493,35 +481,31 @@ static int hx8394_enable(struct drm_panel *panel)
 {
 	struct hx8394 *ctx = panel_to_hx8394(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 	int ret;
 
-	ret = ctx->desc->init_sequence(ctx);
-	if (ret) {
-		dev_err(ctx->dev, "Panel init sequence failed: %d\n", ret);
-		return ret;
-	}
+	ctx->desc->init_sequence(&dsi_ctx);
 
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret) {
-		dev_err(ctx->dev, "Failed to exit sleep mode: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
 
+	if (dsi_ctx.accum_err)
+		return dsi_ctx.accum_err;
 	/* Panel is operational 120 msec after reset */
 	msleep(120);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret) {
-		dev_err(ctx->dev, "Failed to turn on the display: %d\n", ret);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	if (dsi_ctx.accum_err)
 		goto sleep_in;
-	}
 
 	return 0;
 
 sleep_in:
+	ret = dsi_ctx.accum_err;
+	dsi_ctx.accum_err = 0;
+
 	/* This will probably fail, but let's try orderly power off anyway. */
-	if (!mipi_dsi_dcs_enter_sleep_mode(dsi))
-		msleep(50);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 50);
 
 	return ret;
 }
@@ -530,17 +514,12 @@ static int hx8394_disable(struct drm_panel *panel)
 {
 	struct hx8394 *ctx = panel_to_hx8394(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-	int ret;
-
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret) {
-		dev_err(ctx->dev, "Failed to enter sleep mode: %d\n", ret);
-		return ret;
-	}
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	msleep(50); /* about 3 frames */
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 50); /* about 3 frames */
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int hx8394_unprepare(struct drm_panel *panel)
-- 
2.49.0


