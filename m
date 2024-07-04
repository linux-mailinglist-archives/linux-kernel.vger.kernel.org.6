Return-Path: <linux-kernel+bounces-240543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50934926E99
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8309B24635
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB5A145FF8;
	Thu,  4 Jul 2024 04:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="eNpH6fZ1"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B822143C57
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720068650; cv=none; b=BnjsIykWab9mTM3T0v98lMR0UORfp/ui5/W9XH25ByQ297OgCl+iWNshj16wz93rsEDTBshhQzC6YCdm9HO4QR+zEaCHsKwPx4aX0PsBR4DNUxU/ZnzkGP+b+l2AK5akeQlzmzEp6uxPO9Nf0qFKTbf1fw3xwaPjVSsN59bCkcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720068650; c=relaxed/simple;
	bh=NrDd/CFPb1cghbCYmwp/5w1J8wSLiTpRlpHxCdl2CFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fol1setfomigWbGwk5Y5TaCdExS00b58KKEFFIvfSYgNg3AyI2ZN2TtRCb9H3OBeSP8mZtEmZyjPEiiG+0ANjCU4e56lGnZe/ujMr/HSueRnAn89C0pEpcMe4hh2532BupEVmBU3Saic/6nJyJR7NgBC3zJil9YuEPfqXd2ylig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=eNpH6fZ1; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70af5fbf0d5so171797b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 21:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1720068645; x=1720673445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YEP4Pq59dsIwYHVB+3j/E35J2uSNOsK6zNODVCesHM=;
        b=eNpH6fZ1NPTRMVTzujBUCoX3H7NFwW++bnSJimOFWanp8FY4Al4gaHhGCK+Djb9lxb
         ET27OquG+lJACn5bQMh/z3MOzHr1yBE+EuYR1p0b+DgVGxpLG46dfo2WipGJVcJaXjBo
         g3i6FPOLA7g0eH+8MQo//UpMaBBTa1ebL6z20wO7NPlw7MO31dUuRpCPG33tCpkg3m1S
         k1Gol10Un2NeYUh7IlG8uS565domLZpdXgOoKLxmYv4ye+M5GQNWdym9TA+lmxXILGu4
         rWj6aJm4o0YIVvY2XgaAcuMDB9xUer/yZR8O2hYJ9zC5m5/iUQ5tcClrBBHIN8p5PJxL
         tM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720068645; x=1720673445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YEP4Pq59dsIwYHVB+3j/E35J2uSNOsK6zNODVCesHM=;
        b=NXg0rJDr6QVrPd/ynQFibMMxdunxKZGycPHaEssDu5+lIRaUUSKw8tSU28MXX6pQ1a
         phaekBDe4QJSLVc7KtGR4KJj7UGyEU679dkkFhSd5bgx+8mdY2dvbgFkJvawgBZ+KKu+
         01YuBxteWO0ithFFHi/QMt02ltpAPGra7yCzpoieMwGQXOfb1tkpfA/lJGIZOb5Nf+yO
         nUQGHISgc1l7PwIoUbWpRXjd6QYqyBuH5z187Opt19T/2OpEmfoeehFSgK2ChkvnpL3B
         bzdfjluy9H/mC+NbuuKazGHc1z6emflwGtWtUztaoPAG9e5Zxp+QpghzjRxS+/XFyJ1V
         a6ew==
X-Forwarded-Encrypted: i=1; AJvYcCVBvPwF0WbNzLe3O1C+GkXtyVyc+/pRD1tAhvCI7DJlX7e8hSv4TJqyLxQ4DmFyv+RliA65HZVrtLo6+kI5PxhvFtcQ+tRxoDu4V+Ee
X-Gm-Message-State: AOJu0YzKLZME6fqa4FoHF5VpBDVLW/a7+rLXFXJHmIqrePMx50+nfrgK
	89ZaSbl8n/95AqaLISbcW9UOgneCf7k+Wm3cDSZ9uhU02PttZ3r5rf8WeYcFE2o=
X-Google-Smtp-Source: AGHT+IHuX5KUBMOSZtD7UAvek5USheWSgaTr64NI2c2gOrXik2u/mBbBLgPRtkMTdjpqPjSzpDJbLg==
X-Received: by 2002:a05:6a00:99a:b0:707:fa61:1c6a with SMTP id d2e1a72fcca58-70b01b33706mr509515b3a.10.1720068645137;
        Wed, 03 Jul 2024 21:50:45 -0700 (PDT)
Received: from yc.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a8ec1asm11291826b3a.188.2024.07.03.21.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 21:50:44 -0700 (PDT)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@chromium.org,
	linus.walleij@linaro.org,
	swboyd@chromium.org,
	airlied@gmail.com,
	dmitry.baryshkov@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org
Cc: lvzhaoxiong@huaqin.corp-partner.google.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v2 3/3] drm/panel: jd9365da: Break some CMDS into helper functions
Date: Thu,  4 Jul 2024 12:50:17 +0800
Message-Id: <20240704045017.2781991-4-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704045017.2781991-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240704045017.2781991-1-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These panels have some common cmds (e0h~e3h,80h), let's break
them into helper functions.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 89 +++++++++++--------
 1 file changed, 53 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index 5b525a111b90..04d315d96bff 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -48,6 +48,19 @@ struct jadard {
 	struct gpio_desc *reset;
 };
 
+#define JD9365DA_DCS_SWITCH_PAGE	0xe0
+
+#define jd9365da_switch_page(dsi_ctx, page) \
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, JD9365DA_DCS_SWITCH_PAGE, (page))
+
+static void jadard_enable_standard_cmds(struct mipi_dsi_multi_context *dsi_ctx)
+{
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xe1, 0x93);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xe2, 0x65);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xe3, 0xf8);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x80, 0x03);
+}
+
 static inline struct jadard *panel_to_jadard(struct drm_panel *panel)
 {
 	return container_of(panel, struct jadard, panel);
@@ -198,12 +211,10 @@ static int radxa_display_8hd_ad002_init_cmds(struct jadard *jadard)
 {
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
 
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE1, 0x93);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE2, 0x65);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE3, 0xF8);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x03);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x01);
+	jd9365da_switch_page(&dsi_ctx, 0x00);
+	jadard_enable_standard_cmds(&dsi_ctx);
+
+	jd9365da_switch_page(&dsi_ctx, 0x01);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x00);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x7E);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x00);
@@ -276,7 +287,8 @@ static int radxa_display_8hd_ad002_init_cmds(struct jadard *jadard)
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x37);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x23);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x10);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x02);
+
+	jd9365da_switch_page(&dsi_ctx, 0x02);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x47);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x47);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x45);
@@ -360,13 +372,15 @@ static int radxa_display_8hd_ad002_init_cmds(struct jadard *jadard)
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7C, 0x00);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7D, 0x03);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7E, 0x7B);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x04);
+
+	jd9365da_switch_page(&dsi_ctx, 0x04);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x0E);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0xB3);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x60);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0E, 0x2A);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x59);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x00);
+
+	jd9365da_switch_page(&dsi_ctx, 0x00);
 
 	return dsi_ctx.accum_err;
 };
@@ -398,12 +412,10 @@ static int cz101b4001_init_cmds(struct jadard *jadard)
 {
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
 
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE1, 0x93);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE2, 0x65);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE3, 0xF8);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x03);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x01);
+	jd9365da_switch_page(&dsi_ctx, 0x00);
+	jadard_enable_standard_cmds(&dsi_ctx);
+
+	jd9365da_switch_page(&dsi_ctx, 0x01);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x00);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x3B);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0C, 0x74);
@@ -471,7 +483,8 @@ static int cz101b4001_init_cmds(struct jadard *jadard)
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x20);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x0F);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x02);
+
+	jd9365da_switch_page(&dsi_ctx, 0x02);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x02);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x02);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x00);
@@ -584,12 +597,14 @@ static int cz101b4001_init_cmds(struct jadard *jadard)
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7A, 0x17);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7D, 0x14);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7E, 0x82);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x04);
+
+	jd9365da_switch_page(&dsi_ctx, 0x04);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x0E);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0xB3);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x61);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0E, 0x48);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x00);
+
+	jd9365da_switch_page(&dsi_ctx, 0x00);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE6, 0x02);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE7, 0x0C);
 
@@ -623,12 +638,10 @@ static int kingdisplay_kd101ne3_init_cmds(struct jadard *jadard)
 {
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
 
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe1, 0x93);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe2, 0x65);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe3, 0xf8);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x03);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x01);
+	jd9365da_switch_page(&dsi_ctx, 0x00);
+	jadard_enable_standard_cmds(&dsi_ctx);
+
+	jd9365da_switch_page(&dsi_ctx, 0x01);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x74);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xc7);
@@ -694,7 +707,8 @@ static int kingdisplay_kd101ne3_init_cmds(struct jadard *jadard)
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x26);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x14);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x02);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x02);
+
+	jd9365da_switch_page(&dsi_ctx, 0x02);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x52);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x5f);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x5f);
@@ -808,12 +822,14 @@ static int kingdisplay_kd101ne3_init_cmds(struct jadard *jadard)
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x00);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x05);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x2a);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x04);
+
+	jd9365da_switch_page(&dsi_ctx, 0x04);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x0e);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0xb3);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x61);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x48);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x00);
+
+	jd9365da_switch_page(&dsi_ctx, 0x00);
 
 	return dsi_ctx.accum_err;
 };
@@ -854,12 +870,10 @@ static int melfas_lmfbx101117480_init_cmds(struct jadard *jadard)
 {
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
 
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe1, 0x93);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe2, 0x65);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe3, 0xf8);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x03);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x01);
+	jd9365da_switch_page(&dsi_ctx, 0x00);
+	jadard_enable_standard_cmds(&dsi_ctx);
+
+	jd9365da_switch_page(&dsi_ctx, 0x01);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x74);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xbf);
@@ -932,7 +946,8 @@ static int melfas_lmfbx101117480_init_cmds(struct jadard *jadard)
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x24);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x12);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x02);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x02);
+
+	jd9365da_switch_page(&dsi_ctx, 0x02);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x52);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x55);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x55);
@@ -1046,14 +1061,16 @@ static int melfas_lmfbx101117480_init_cmds(struct jadard *jadard)
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x00);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x05);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x2a);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x04);
+
+	jd9365da_switch_page(&dsi_ctx, 0x04);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x23);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x11);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x48);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x49);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x08);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2e, 0x03);
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x00);
+
+	jd9365da_switch_page(&dsi_ctx, 0x00);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe6, 0x02);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe7, 0x06);
 
-- 
2.25.1


