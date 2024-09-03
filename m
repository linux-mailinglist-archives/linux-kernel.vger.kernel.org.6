Return-Path: <linux-kernel+bounces-313438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F18896A578
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C41CD2885D5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E208318F2D3;
	Tue,  3 Sep 2024 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTndXZIb"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A9A18EFF8
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725384742; cv=none; b=BQoyo70fPOg+8t23EpSdKWdWf6ipATpKWVeKL15HCTuekxpiwOGutcbuhXH6B1NcbL+7s5tLz0tbmO/cKGJME5uux8uWuYMcych2CcHk4vLG01tBfXobOyXt9hykOaTzXuzWb8io701AWyq1rIaipCK1HTbiwHG9TptY4Ez46Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725384742; c=relaxed/simple;
	bh=veBQh8sTRvFn44RWBv4pf2WLQg8YGyP5+ypecjaJNio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b/8J2+DMcth/rRDmUqY54ooqpOzoaIsiaiYx+Bh+1rJxtShplEzKQKhnfxC7OkiylcoD3oKrrBbGaVaAjO5A4Kt5fNZK2NmmoQyM/m26odvZMhqlVXRHsHTRwJ9afINxV2ofcmmmoAlzvjEe9wK0qSCZsm9qVkcaLBZnceRanwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTndXZIb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2057917c493so18006485ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 10:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725384739; x=1725989539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HiLJoUgwiPwqGNm0lpObn/bqZI0GgOcal7bzp7/tmt0=;
        b=GTndXZIbvtClTRc0ajQKnyk3sXrP1Dd4km05iltj4x2rNY60ww6S21WsVv01mNhOpJ
         GIFqqLWJyMwLnM+CuexGR+QSqCfGgxxnie/40nJawD3yYjfpc2KfBK3cX1vtWE2jWiam
         Bxe05PgtPL7KDqxSKuvJJhFFciqyQY0WA5N0qtI8r2uR/97xPOseep/9WusORa/Qbr9b
         /2yyVBoM2O37+NjO/cvTPqdAsquc3MXk0nu8qdnOj2/BOA20SvHiopgq8SIkA96hQV1t
         ObPoRgEX1vOF39YqAkwLmOyAh/5RgBRGrEK4rPqnGm/bZgY4kv0bfR8JuG95hkBMMdTd
         cYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725384739; x=1725989539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HiLJoUgwiPwqGNm0lpObn/bqZI0GgOcal7bzp7/tmt0=;
        b=t262zRHHCQDx3yvm4Gsky100Z3Wt90y/ycjQJjK+K0xWDjMncl3+dMspjs3uN48sYf
         LeYDhF53hzV89moaACo/BsUxk//0NZjwx4Mi4QIZvAaQ3dc9ZL6/GnUlbHxdmT1HCAdz
         29UMJTiG0zowW3oCBNRdWCfk5iuz4BxPIs15UqpK/LlzCWcTOzIYDhddieeplZuVaa8k
         TlYooZ3erwsg1gNjqQ8K1MzXEzZBlQt+a9HOps8697OJMOGlO2RhhcFPs0m/dI4zsg7B
         Zmow+BbdGH1uBTw4LpOcJX701Q4t1P5Dfprxc1TSFmYDXxDWHX1BDxAhsU1BMLc8mzYF
         MWCA==
X-Forwarded-Encrypted: i=1; AJvYcCWYOEi3K1HUWqoN65mrM95s6w3j5k7nEBPdm/rBWSy+TcYrOA3bX3qQBoddYwFvq70R7XIc8LDHGcTBy9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNFFikgFVhbBCoW+EqB7C9ztyx2UnvAdnEV82iQ9btRJi22OC6
	Jdiulb0V4oCOO5MfQuXAIvcayReIWSzBdRe8k62Gog7o10yTKCnF
X-Google-Smtp-Source: AGHT+IGdRQdOkVQPkh7f2Sk8ELepHXS+iAMlvClTHLu6I1uh9McKj94RRlPbaPEesRcO8TQ72q997A==
X-Received: by 2002:a17:902:e54e:b0:205:6c15:7b75 with SMTP id d9443c01a7336-2056c157df2mr137582805ad.7.1725384739290;
        Tue, 03 Sep 2024 10:32:19 -0700 (PDT)
Received: from embed-PC.. ([106.222.229.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae9558cfsm1092315ad.101.2024.09.03.10.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 10:32:18 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: quic_jesszhan@quicinc.com,
	skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] drm/panel: hx83112a: Transition to wrapped mipi_dsi functions
Date: Tue,  3 Sep 2024 23:01:30 +0530
Message-Id: <20240903173130.41784-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Transition to mipi_dsi_dcs_write_seq_multi() macros for initialization
sequences. The previous mipi_dsi_dcs_write_seq() macros were
non-intuitive and use other wrapped MIPI DSI functions in the
driver code to simplify the code pattern.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409040049.2hf8jrZG-lkp@intel.com/
Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
Changes in v2:
- Update the commit message to explain the reason for the change.
- Correct the code by changing 'dsi->mode_flags' to 'dsi_ctx.dsi->mode_flags'
This change addresses a build error in v1 reported by kernel test robot
caused by using an undeclared variable 'dsi'.
[v1] : https://lore.kernel.org/all/20240902170153.34512-1-abhishektamboli9@gmail.com/

 drivers/gpu/drm/panel/panel-himax-hx83112a.c | 140 ++++++++-----------
 1 file changed, 60 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx83112a.c b/drivers/gpu/drm/panel/panel-himax-hx83112a.c
index 466c27012abf..6c457d17fd11 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83112a.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83112a.c
@@ -58,30 +58,28 @@ static void hx83112a_reset(struct hx83112a_panel *ctx)

 static int hx83112a_on(struct hx83112a_panel *ctx)
 {
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
-
-	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+	struct mipi_dsi_multi_context dsi_ctx = {.dsi = ctx->dsi};
+
+	dsi_ctx.dsi->mode_flags |= MIPI_DSI_MODE_LPM;

-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETEXTC, 0x83, 0x11, 0x2a);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETPOWER1,
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETEXTC, 0x83, 0x11, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETPOWER1,
 			       0x08, 0x28, 0x28, 0x83, 0x83, 0x4c, 0x4f, 0x33);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETDISP,
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETDISP,
 			       0x00, 0x02, 0x00, 0x90, 0x24, 0x00, 0x08, 0x19,
 			       0xea, 0x11, 0x11, 0x00, 0x11, 0xa3);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETDRV,
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETDRV,
 			       0x58, 0x68, 0x58, 0x68, 0x0f, 0xef, 0x0b, 0xc0,
 			       0x0b, 0xc0, 0x0b, 0xc0, 0x00, 0xff, 0x00, 0xff,
 			       0x00, 0x00, 0x14, 0x15, 0x00, 0x29, 0x11, 0x07,
 			       0x12, 0x00, 0x29);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x02);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETDRV,
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETDRV,
 			       0x00, 0x12, 0x12, 0x11, 0x88, 0x12, 0x12, 0x00,
 			       0x53);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x03);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETDGCLUT,
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETDGCLUT,
 			       0xff, 0xfe, 0xfb, 0xf8, 0xf4, 0xf1, 0xed, 0xe6,
 			       0xe2, 0xde, 0xdb, 0xd6, 0xd3, 0xcf, 0xca, 0xc6,
 			       0xc2, 0xbe, 0xb9, 0xb0, 0xa7, 0x9e, 0x96, 0x8d,
@@ -90,8 +88,8 @@ static int hx83112a_on(struct hx83112a_panel *ctx)
 			       0x06, 0x05, 0x02, 0x01, 0x00, 0x00, 0xc9, 0xb3,
 			       0x08, 0x0e, 0xf2, 0xe1, 0x59, 0xf4, 0x22, 0xad,
 			       0x40);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x02);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETDGCLUT,
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETDGCLUT,
 			       0xff, 0xfe, 0xfb, 0xf8, 0xf4, 0xf1, 0xed, 0xe6,
 			       0xe2, 0xde, 0xdb, 0xd6, 0xd3, 0xcf, 0xca, 0xc6,
 			       0xc2, 0xbe, 0xb9, 0xb0, 0xa7, 0x9e, 0x96, 0x8d,
@@ -100,8 +98,8 @@ static int hx83112a_on(struct hx83112a_panel *ctx)
 			       0x06, 0x05, 0x02, 0x01, 0x00, 0x00, 0xc9, 0xb3,
 			       0x08, 0x0e, 0xf2, 0xe1, 0x59, 0xf4, 0x22, 0xad,
 			       0x40);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETDGCLUT,
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETDGCLUT,
 			       0xff, 0xfe, 0xfb, 0xf8, 0xf4, 0xf1, 0xed, 0xe6,
 			       0xe2, 0xde, 0xdb, 0xd6, 0xd3, 0xcf, 0xca, 0xc6,
 			       0xc2, 0xbe, 0xb9, 0xb0, 0xa7, 0x9e, 0x96, 0x8d,
@@ -110,13 +108,13 @@ static int hx83112a_on(struct hx83112a_panel *ctx)
 			       0x06, 0x05, 0x02, 0x01, 0x00, 0x00, 0xc9, 0xb3,
 			       0x08, 0x0e, 0xf2, 0xe1, 0x59, 0xf4, 0x22, 0xad,
 			       0x40);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETDGCLUT, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETTCON,
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETDGCLUT, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETTCON,
 			       0x70, 0x00, 0x04, 0xe0, 0x33, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETPANEL, 0x08);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETPOWER2, 0x2b, 0x2b);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETGIP0,
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETPANEL, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETPOWER2, 0x2b, 0x2b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETGIP0,
 			       0x80, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x08,
 			       0x08, 0x03, 0x03, 0x22, 0x18, 0x07, 0x07, 0x07,
 			       0x07, 0x32, 0x10, 0x06, 0x00, 0x06, 0x32, 0x10,
@@ -124,105 +122,87 @@ static int hx83112a_on(struct hx83112a_panel *ctx)
 			       0x00, 0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 0x08,
 			       0x09, 0x30, 0x00, 0x00, 0x00, 0x06, 0x0d, 0x00,
 			       0x0f);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETGIP0,
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETGIP0,
 			       0x00, 0x00, 0x19, 0x10, 0x00, 0x0a, 0x00, 0x81);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETGIP1,
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETGIP1,
 			       0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
 			       0xc0, 0xc0, 0x18, 0x18, 0x19, 0x19, 0x18, 0x18,
 			       0x40, 0x40, 0x18, 0x18, 0x18, 0x18, 0x3f, 0x3f,
 			       0x28, 0x28, 0x24, 0x24, 0x02, 0x03, 0x02, 0x03,
 			       0x00, 0x01, 0x00, 0x01, 0x31, 0x31, 0x31, 0x31,
 			       0x30, 0x30, 0x30, 0x30, 0x2f, 0x2f, 0x2f, 0x2f);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETGIP2,
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETGIP2,
 			       0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
 			       0x40, 0x40, 0x18, 0x18, 0x18, 0x18, 0x19, 0x19,
 			       0x40, 0x40, 0x18, 0x18, 0x18, 0x18, 0x3f, 0x3f,
 			       0x24, 0x24, 0x28, 0x28, 0x01, 0x00, 0x01, 0x00,
 			       0x03, 0x02, 0x03, 0x02, 0x31, 0x31, 0x31, 0x31,
 			       0x30, 0x30, 0x30, 0x30, 0x2f, 0x2f, 0x2f, 0x2f);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETGIP3,
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETGIP3,
 			       0xaa, 0xea, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xea,
 			       0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xea, 0xab, 0xaa,
 			       0xaa, 0xaa, 0xaa, 0xea, 0xab, 0xaa, 0xaa, 0xaa);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETGIP3,
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETGIP3,
 			       0xaa, 0x2e, 0x28, 0x00, 0x00, 0x00, 0xaa, 0x2e,
 			       0x28, 0x00, 0x00, 0x00, 0xaa, 0xee, 0xaa, 0xaa,
 			       0xaa, 0xaa, 0xaa, 0xee, 0xaa, 0xaa, 0xaa, 0xaa);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x02);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETGIP3,
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETGIP3,
 			       0xaa, 0xff, 0xff, 0xff, 0xff, 0xff, 0xaa, 0xff,
 			       0xff, 0xff, 0xff, 0xff);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x03);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETGIP3,
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETGIP3,
 			       0xaa, 0xaa, 0xea, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa,
 			       0xea, 0xaa, 0xaa, 0xaa, 0xaa, 0xff, 0xff, 0xff,
 			       0xff, 0xff, 0xaa, 0xff, 0xff, 0xff, 0xff, 0xff);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETTP1,
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETTP1,
 			       0x0e, 0x0e, 0x1e, 0x65, 0x1c, 0x65, 0x00, 0x50,
 			       0x20, 0x20, 0x00, 0x00, 0x02, 0x02, 0x02, 0x05,
 			       0x14, 0x14, 0x32, 0xb9, 0x23, 0xb9, 0x08);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETTP1,
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETTP1,
 			       0x02, 0x00, 0xa8, 0x01, 0xa8, 0x0d, 0xa4, 0x0e);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x02);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETTP1,
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETTP1,
 			       0x00, 0x00, 0x08, 0x00, 0x01, 0x00, 0x00, 0x00,
 			       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 			       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x04, 0x00,
 			       0x00, 0x00, 0x00, 0x02, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETBANK, 0x00);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_UNKNOWN1, 0xc3);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETCLOCK, 0xd1, 0xd6);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_UNKNOWN1, 0x3f);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_UNKNOWN1, 0xc6);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_SETPTBA, 0x37);
-	mipi_dsi_dcs_write_seq(dsi, HX83112A_UNKNOWN1, 0x3f);
-
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
-		return ret;
-	}
-	msleep(150);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETBANK, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_UNKNOWN1, 0xc3);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETCLOCK, 0xd1, 0xd6);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_UNKNOWN1, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_UNKNOWN1, 0xc6);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_SETPTBA, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83112A_UNKNOWN1, 0x3f);

-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display on: %d\n", ret);
-		return ret;
-	}
-	msleep(50);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 150);

-	return 0;
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 50);
+
+	return dsi_ctx.accum_err;
 }

 static int hx83112a_disable(struct drm_panel *panel)
 {
 	struct hx83112a_panel *ctx = to_hx83112a_panel(panel);
-	struct mipi_dsi_device *dsi = ctx->dsi;
-	struct device *dev = &dsi->dev;
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = {.dsi = ctx->dsi};

-	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+	dsi_ctx.dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;

-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to set display off: %d\n", ret);
-		return ret;
-	}
-	msleep(20);
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 20);

-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
-		return ret;
-	}
-	msleep(120);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	mipi_dsi_msleep(&dsi_ctx, 120);

-	return 0;
+	return dsi_ctx.accum_err;
 }

 static int hx83112a_prepare(struct drm_panel *panel)
--
2.34.1


