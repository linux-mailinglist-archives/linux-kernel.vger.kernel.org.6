Return-Path: <linux-kernel+bounces-176382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE70E8C2EEE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 04:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D126D1C21019
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB36E1B947;
	Sat, 11 May 2024 02:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="woyQPtu/"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE691F94C
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 02:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715393642; cv=none; b=POSkMN4DOoZ2NloXI12b7EJW7qFPCx/r8S3hcs4ILN+6eYmc1q3q+ZBMalcDvxaNvhfgv4fV8ABX0/b9gpe1BxnUOWpGj07+6LqIIKqCk5meV/BJ0pLwC4daL8s44oJWHeJrI3G/NhP5lJCgNCI2OrakF1kdmHZL8b9Ra4E5dCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715393642; c=relaxed/simple;
	bh=wxfIPrAQRsM9VrzzpWh2WdDo66yCei/l9YbS4s+tEsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KSOL9YVvLFYSIhqtb3reNFdrj2Alew3sWqSb7bQC1uSwkr301M/kUtTqC57WFlt1U+Pt44RYc8qCa3hChSeZXn4zQvXFXfu/su7xzOHNLanPqGnQQVPNQNadeLSQWuEh/lqIHTtqVUVZsVFIO5E576R6wthBGwKZZ02NSoOoY2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=woyQPtu/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f4e59191a1so898770b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 19:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1715393634; x=1715998434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldfU7QbZhVaK576Gxl8ORTm3YOiMDtw0DywKTU6/R7E=;
        b=woyQPtu/Mgu6JdHigFqON6apOdAhfe4jggVS8BdqLLvUSB2YZow6Vue5AjwikGzDXC
         /e/iPyrr8llSWbHqL4JR8jdUoBWc5zZmGOYh+gqmmrZqprkMnIfCM5SwRgy/pIBJeSTf
         msyAXVyV8gYi6zLrfCsddqqX8VS1ReDddydL9gYUSkW6Mw6kCWQCKJebvAeIc1wsVIy/
         D/PkpQ0lv5mXvtRPiEab1F+KH1zT/HQh04EfSgYTSFdPd7uH+6/BtMZpug3jEmXQMrFY
         werIkNYvBIrqNgrqbQ19vAkHAxYQNhkouToODT+YKd8gbWpj2zzf33l9G4YjVLT82vg0
         k/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715393634; x=1715998434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldfU7QbZhVaK576Gxl8ORTm3YOiMDtw0DywKTU6/R7E=;
        b=ip1wo9GshB1pMP2aMZ9E1mOTm2rc21lb+2aAcw0LZ991a5+Dl7MltSwxMV1ETWRsc9
         24RnSssfQAASd2rBmr40DcJAtGkxhSHUzAP36wnECKprvvBqTvvFrReKo2IMKOYOLNx+
         PJFJcl7I8Y7lbPpIVMTtKIPM59Wxa6m4a7YrKiEsuTwceH2x9xKQmmfz4OYSPkKLkNNZ
         dL0HC9//OX2YnkZfzzqtIqOIsyL1wplr4JmqJjVqtTINWrsN788es+yqPgZZBghI+LGf
         yCeIdYr0ClrQwtVrlzZsUCvpbtvt02JDvdUT90bW3mp42/0lXEMvbW94QPfbUgWsNV6T
         ctCw==
X-Forwarded-Encrypted: i=1; AJvYcCXAKlA61hk1e2j+4YnWmHo4J+mSVPSqoIKZFil0YOw/+YlWM3548E+14InGYeAnqKPSPqpx16CD/3uYO7AqJrxkW6lk5fF1v8KBui0m
X-Gm-Message-State: AOJu0YwD1MqEszpBVl6K+VVrdopT/kxWzSQ2xpJzxV5qUz+n/bSolVay
	1ZFQ0K0xRaW278t8hKPZajk3jFa/7b8UlMWQOswjaiC+n0O391FLkbFAFI5+0aI=
X-Google-Smtp-Source: AGHT+IFdAbY+Q1Dkq+GZscrcNzwz6UAYwDgzEgG8oAWquxRUr7E9Dae2lb5qa2mla39T//S6lFccBg==
X-Received: by 2002:aa7:88d1:0:b0:6f3:eee4:4426 with SMTP id d2e1a72fcca58-6f4e0355589mr4720553b3a.26.1715393633774;
        Fri, 10 May 2024 19:13:53 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a9d9acsm3680340b3a.90.2024.05.10.19.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 19:13:53 -0700 (PDT)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: sam@ravnborg.org,
	neil.armstrong@linaro.org,
	daniel@ffwll.ch,
	dianders@chromium.org,
	linus.walleij@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	airlied@gmail.com
Cc: dmitry.baryshkov@linaro.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuxinxiong@huaqin.corp-partner.google.com,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v6 5/7] drm/panel: himax-hx83102: Support for BOE nv110wum-l60 MIPI-DSI panel
Date: Sat, 11 May 2024 10:13:24 +0800
Message-Id: <20240511021326.288728-6-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240511021326.288728-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240511021326.288728-1-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BOE nv110wum-l60 is a 11.0" WUXGA TFT LCD panel, use hx83102 controller
which fits in nicely with the existing panel-himax-hx83102 driver. Hence,
we add a new compatible with panel specific config.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
Chage since V6:

- No change.

V5: https://lore.kernel.org/all/20240509015207.3271370-6-yangcong5@huaqin.corp-partner.google.com

Chage since V5:

- Adjust inital cmds indentation and check accum_err before calling mdelay in init()..

V4: https://lore.kernel.org/all/20240507135234.1356855-6-yangcong5@huaqin.corp-partner.google.com

Chage since V4:

- Depend Dous'series [1].
[1]: https://lore.kernel.org/all/20240501154251.3302887-1-dianders@chromium.org

V3: https://lore.kernel.org/all/20240424023010.2099949-6-yangcong5@huaqin.corp-partner.google.com

Chage since V3:

- inital cmds use lowercasehex.

V2: https://lore.kernel.org/all/20240422090310.3311429-6-yangcong5@huaqin.corp-partner.google.com

---
 drivers/gpu/drm/panel/panel-himax-hx83102.c | 133 ++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
index 05e8b5fa8c29..0496e39ca5b8 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
@@ -44,6 +44,7 @@
 #define HX83102_SETGIP2		0xd6
 #define HX83102_SETGIP3		0xd8
 #define HX83102_SETGMA		0xe0
+#define HX83102_UNKNOWN_E1	0xe1
 #define HX83102_SETTP1		0xe7
 #define HX83102_SETSPCCMD	0xe9
 
@@ -185,6 +186,113 @@ static int starry_himax83102_j02_init(struct hx83102 *ctx)
 	return dsi_ctx.accum_err;
 };
 
+static int boe_nv110wum_init(struct hx83102 *ctx)
+{
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	msleep(60);
+
+	hx83102_enable_extended_cmds(&dsi_ctx, true);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPOWER, 0x2c, 0xaf, 0xaf, 0x2b, 0xeb, 0x42,
+				     0xe1, 0x4d, 0x36, 0x36, 0x36, 0x36, 0x1a, 0x8b, 0x11, 0x65, 0x00,
+				     0x88, 0xfa, 0xff, 0xff, 0x8f, 0xff, 0x08, 0x9a, 0x33);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETDISP, 0x00, 0x47, 0xb0, 0x80, 0x00, 0x12,
+				     0x71, 0x3c, 0xa3, 0x11, 0x00, 0x00, 0x00, 0x88, 0xf5, 0x22, 0x8f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCYC, 0x49, 0x49, 0x32, 0x32, 0x14, 0x32,
+				     0x84, 0x6e, 0x84, 0x6e, 0x01, 0x9c);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xcd);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETMIPI, 0x84);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETVDC, 0x1b, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_UNKNOWN_BE, 0x20);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPTBA, 0xfc, 0x84);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSTBA, 0x36, 0x36, 0x22, 0x00, 0x00, 0xa0,
+				     0x61, 0x08, 0xf5, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xcc);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETTCON, 0x80);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xc6);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETRAMDMY, 0x97);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPWM, 0x00, 0x1e, 0x30, 0xd4, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCLOCK, 0x08, 0x13, 0x07, 0x00, 0x0f, 0x34);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPANEL, 0x02, 0x03, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xc4);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCASCADE, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPCTRL, 0x37, 0x06, 0x00, 0x02, 0x04, 0x0c, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_UNKNOWN_D2, 0x1f, 0x11, 0x1f, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP0, 0x06, 0x00, 0x00, 0x00, 0x00, 0x04,
+				     0x08, 0x04, 0x08, 0x37, 0x37, 0x64, 0x4b, 0x11, 0x11, 0x03, 0x03, 0x32,
+				     0x10, 0x0e, 0x00, 0x0e, 0x32, 0x10, 0x0a, 0x00, 0x0a, 0x32, 0x17, 0x98,
+				     0x07, 0x98, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP1, 0x18, 0x18, 0x18, 0x18, 0x1e, 0x1e,
+				     0x1e, 0x1e, 0x1f, 0x1f, 0x1f, 0x1f, 0x24, 0x24, 0x24, 0x24, 0x07, 0x06,
+				     0x07, 0x06, 0x05, 0x04, 0x05, 0x04, 0x03, 0x02, 0x03, 0x02, 0x01, 0x00,
+				     0x01, 0x00, 0x21, 0x20, 0x21, 0x20, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+				     0x18, 0x18);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP3, 0xaf, 0xaa, 0xaa, 0xaa, 0xaa, 0xa0,
+				     0xaf, 0xaa, 0xaa, 0xaa, 0xaa, 0xa0);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGMA, 0x00, 0x05, 0x0d, 0x14, 0x1b, 0x2c,
+				     0x44, 0x49, 0x51, 0x4c, 0x67, 0x6c, 0x71, 0x80, 0x7d, 0x84, 0x8d, 0xa0,
+				     0xa0, 0x4f, 0x58, 0x64, 0x73, 0x00, 0x05, 0x0d, 0x14, 0x1b, 0x2c, 0x44,
+				     0x49, 0x51, 0x4c, 0x67, 0x6c, 0x71, 0x80, 0x7d, 0x84, 0x8d, 0xa0, 0xa0,
+				     0x4f, 0x58, 0x64, 0x73);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETTP1, 0x07, 0x10, 0x10, 0x1a, 0x26, 0x9e,
+				     0x00, 0x53, 0x9b, 0x14, 0x14);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_UNKNOWN_E1, 0x11, 0x00, 0x00, 0x89, 0x30, 0x80,
+				     0x07, 0x80, 0x02, 0x58, 0x00, 0x14, 0x02, 0x58, 0x02, 0x58, 0x02, 0x00,
+				     0x02, 0x2c, 0x00, 0x20, 0x02, 0x02, 0x00, 0x08, 0x00, 0x0c, 0x05, 0x0e,
+				     0x04, 0x94, 0x18, 0x00, 0x10, 0xf0, 0x03, 0x0c, 0x20, 0x00, 0x06, 0x0b,
+				     0x0b, 0x33, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP3, 0xff, 0xff, 0xff, 0xff, 0xfa, 0xa0,
+				     0xff, 0xff, 0xff, 0xff, 0xfa, 0xa0);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPOWER, 0x01, 0xbf, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCLOCK, 0x86);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_UNKNOWN_D2, 0x96);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xc9);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP0, 0x84);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xd1);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_UNKNOWN_E1, 0xf6, 0x2b, 0x34, 0x2b, 0x74, 0x3b,
+				     0x74, 0x6b, 0x74);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETTP1, 0x02, 0x00, 0x2b, 0x01, 0x7e, 0x0f,
+				     0x7e, 0x10, 0xa0, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCYC, 0x02, 0x00, 0xbb, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP3, 0xff, 0xaf, 0xff, 0xff, 0xfa, 0xa0,
+				     0xff, 0xaf, 0xff, 0xff, 0xfa, 0xa0);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETTP1, 0xfe, 0x01, 0xfe, 0x01, 0xfe, 0x01,
+				     0x00, 0x00, 0x00, 0x23, 0x00, 0x23, 0x81, 0x02, 0x40, 0x00, 0x20, 0x65,
+				     0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP3, 0xaa, 0xaf, 0xaa, 0xaa, 0xa0, 0x00,
+				     0xaa, 0xaf, 0xaa, 0xaa, 0xa0, 0x00, 0xaa, 0xaf, 0xaa, 0xaa, 0xa0, 0x00,
+				     0xaa, 0xaf, 0xaa, 0xaa, 0xa0, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xc6);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCYC, 0x03, 0xff, 0xf8);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_UNKNOWN_E1, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xc4);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETMIPI, 0x96);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xc5);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETMIPI, 0x4f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x00);
+	hx83102_enable_extended_cmds(&dsi_ctx, false);
+	if (dsi_ctx.accum_err)
+		return dsi_ctx.accum_err;
+
+	msleep(50);
+
+	return 0;
+};
+
 static const struct drm_display_mode starry_mode = {
 	.clock = 162680,
 	.hdisplay = 1200,
@@ -207,6 +315,28 @@ static const struct hx83102_panel_desc starry_desc = {
 	.init = starry_himax83102_j02_init,
 };
 
+static const struct drm_display_mode boe_tv110wum_default_mode = {
+	.clock = 166400,
+	.hdisplay = 1200,
+	.hsync_start = 1200 + 65,
+	.hsync_end = 1200 + 65 + 20,
+	.htotal = 1200 + 60 + 20 + 65,
+	.vdisplay = 1920,
+	.vsync_start = 1920 + 115,
+	.vsync_end = 1920 + 115 + 8,
+	.vtotal = 1920 + 115 + 8 + 12,
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static const struct hx83102_panel_desc boe_nv110wum_desc = {
+	.modes = &boe_tv110wum_default_mode,
+	.size = {
+		.width_mm = 147,
+		.height_mm = 235,
+	},
+	.init = boe_nv110wum_init,
+};
+
 static int hx83102_enable(struct drm_panel *panel)
 {
 	msleep(130);
@@ -451,6 +581,9 @@ static void hx83102_remove(struct mipi_dsi_device *dsi)
 }
 
 static const struct of_device_id hx83102_of_match[] = {
+	{ .compatible = "boe,nv110wum-l60",
+	.data = &boe_nv110wum_desc
+	},
 	{ .compatible = "starry,himax83102-j02",
 	  .data = &starry_desc
 	},
-- 
2.25.1


