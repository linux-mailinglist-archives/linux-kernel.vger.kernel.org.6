Return-Path: <linux-kernel+bounces-171475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E6C8BE4DA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17EF9284C84
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1178B15ECE6;
	Tue,  7 May 2024 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="JOW1cRZX"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D999D15E80C
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089987; cv=none; b=PPsj4fb2OkseIiPUkOCWZcXLVIA2LrsFb4Fli+nrTT3JQv0lvAVGY248uQ8E8Nlt+s4saqJBOJt2MndM5aeaIsSqmUTfDg3dWm9SM7sOvZ9FMSLwRIXQR/LWs2Lwjf087dvtcjE2EjoUsJn6FEkIA3svvcruiaYUXZtJVWTVE90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089987; c=relaxed/simple;
	bh=pNoqxTwkVwT8fTAr4Y9s7wvZg4LF6/tkPpmq45XAt0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SshpFa/Novohu2W6aQc9drCmk1Va6KWJkbIlcMwhgcnNTd058td2lPJk7s962BXTZVt/obV1UnwI7EnJhRCJVpJQQF+9gGAGkaHbuBmw6ifLSy8X20CZ5S7kOj4BX4GQsclzb5ZsMc9qt1NZJIkd/FHZwn92SC/1Rf2D9+6wUKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=JOW1cRZX; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7daa6bfe4c8so157503639f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 06:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1715089984; x=1715694784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKihI+mKnykufju8wMlqqY7xLlSn+uNJ9BDngg5RE1w=;
        b=JOW1cRZXvxL1iHIZW4A9K3qTvVzP8+yeUSNzZ/50lT6WWvwm9WlgKHFl0Zgz7q5ynk
         u5ypBeItlQgCIJVPoidzGevB7M2bQ+K6yopDjvW8xsmNkA8ygX/kbu8q5cMMJ3BX9bFN
         V9cRgaIrFgYHhIpCl3dg3LKKuOjTnqkF2RD5ZcCZWxwzjMNdC9H38iPyH+Ix9ZCC4xil
         Jxpe+4JYnGdUVWbPGo7PeNGFq3luCfaLAEOSFHH4mDt2TvdqunFsjDo5fMuWervaiAnq
         rxbXup1R30FZRJsQD1yA67GA5gy6J76o2a8tto4RQQODy6LwCK0/MfnE9w5g9LJBX89E
         ALcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715089984; x=1715694784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKihI+mKnykufju8wMlqqY7xLlSn+uNJ9BDngg5RE1w=;
        b=SlLaF4kuj/BJldOnfNRqk8ay+3YprhxIpTeX6jXt81MMTaZui+NNdL0niHLinUv+XR
         4tZScxvjuRHW7PZ/ua+L3VCPp/RzS8qUBjYUjtrLdH/KgwhtXH46EaRDH/U+i53Mnwaj
         7tHRFDrjIpmp4ljR/2QYTpJ2BnYxD7+r+Q8MVQ9a6fST8reo5asvH0i+vlrx2fSTnthV
         /Kt9IGumpQNP7L1gkiq6Yr2Tfnced4JfjsEMqm2oIFKKHjAJ4v08fBaMsH3LwIGuSzSe
         aWt8U9w3rU7nGxKBbAB9/6/GT3SVkq2Wu8YS5Itls80/qw1p0YQj5Z8X3/4CJnq9RoTM
         XHrA==
X-Forwarded-Encrypted: i=1; AJvYcCUnSbPHD6pFoqdqKMaRFioHKhDKbH4ps69G29lnCMUA1OroVueN1t6E17bkmI/nNAoO3rpZnrDhbXzTX69hvQpuFx+uzMmcBRF5lO+S
X-Gm-Message-State: AOJu0Yx14LsSRFNMVM/GBgKR1Gd885di7SQVWXDYf/xi0B6uc9qlgI5b
	7giIHvC9miSlXWkYRfJOE50+xyudhPEPT6lxw07Br0aGWB91DUEvryD8F3KrGsE=
X-Google-Smtp-Source: AGHT+IGIbYbLSaOM86X65rCuLIEmONKCX55o/8nnPMnYgK8Q2MsO8HpIWEBbYGOFi0RtX7mHy7zJ+A==
X-Received: by 2002:a05:6602:2d92:b0:7e1:7d6c:4bf0 with SMTP id k18-20020a0566022d9200b007e17d6c4bf0mr3722915iow.16.1715089983883;
        Tue, 07 May 2024 06:53:03 -0700 (PDT)
Received: from localhost.localdomain ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id e7-20020a63e007000000b005dc8702f0a9sm9850542pgh.1.2024.05.07.06.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:53:03 -0700 (PDT)
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
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xuxinxiong@huaqin.corp-partner.google.com,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v4 2/7] drm/panel: himax-hx83102: Break out as separate driver
Date: Tue,  7 May 2024 21:52:29 +0800
Message-Id: <20240507135234.1356855-3-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507135234.1356855-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240507135234.1356855-1-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Starry HX83102 based mipi panel should never have been part of the boe
tv101wum driver. Discussion with Doug and Linus in V1 [1], we need a
separate driver to enable the hx83102 controller.

In hx83102 driver, add DSI commands as macros. So it can add some panels
with same control model in the future.

[1]: https://lore.kernel.org/all/CACRpkdbzYZAS0=zBQJUC4CB2wj4s1h6n6aSAZQvdMV95r3zRUw@mail.gmail.com

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
Chage since V4:

-  Add hx83102_enable_extended_cmds function, rename UNKNOWN CMDS and depend Dous'series [1].
[1]: https://lore.kernel.org/all/20240501154251.3302887-1-dianders@chromium.org

V3: https://lore.kernel.org/all/20240424023010.2099949-3-yangcong5@huaqin.corp-partner.google.com

Chage since V3:

-  Drop excess flags and function, inital cmds use lowercasehex.

V2: https://lore.kernel.org/all/20240422090310.3311429-3-yangcong5@huaqin.corp-partner.google.com

---
 drivers/gpu/drm/panel/Kconfig                 |   9 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 133 -----
 drivers/gpu/drm/panel/panel-himax-hx83102.c   | 478 ++++++++++++++++++
 4 files changed, 488 insertions(+), 133 deletions(-)
 create mode 100644 drivers/gpu/drm/panel/panel-himax-hx83102.c

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index d037b3b8b999..acd3d09b5a05 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -145,6 +145,15 @@ config DRM_PANEL_LVDS
 	  handling of power supplies or control signals. It implements automatic
 	  backlight handling if the panel is attached to a backlight controller.
 
+config DRM_PANEL_HIMAX_HX83102
+	tristate "Himax HX83102-based panels"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	help
+	  Say Y if you want to enable support for panels based on the
+	  Himax HX83102 controller.
+
 config DRM_PANEL_HIMAX_HX83112A
 	tristate "Himax HX83112A-based DSI panel"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index f156d7fa0bcc..8fa9e38382f6 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_DRM_PANEL_EBBG_FT8719) += panel-ebbg-ft8719.o
 obj-$(CONFIG_DRM_PANEL_ELIDA_KD35T133) += panel-elida-kd35t133.o
 obj-$(CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02) += panel-feixin-k101-im2ba02.o
 obj-$(CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D) += panel-feiyang-fy07024di26a30d.o
+obj-$(CONFIG_DRM_PANEL_HIMAX_HX83102) += panel-himax-hx83102.o
 obj-$(CONFIG_DRM_PANEL_HIMAX_HX83112A) += panel-himax-hx83112a.o
 obj-$(CONFIG_DRM_PANEL_HIMAX_HX8394) += panel-himax-hx8394.o
 obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) += panel-ilitek-ili9322.o
diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index aab60cec0603..4b4b125a6c6b 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1399,108 +1399,6 @@ static int starry_qfh032011_53g_init(struct boe_panel *boe)
 	return 0;
 };
 
-static int starry_himax83102_j02_init(struct boe_panel *boe)
-{
-	struct mipi_dsi_multi_context ctx = { .dsi = boe->dsi };
-
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb9, 0x83, 0x10, 0x21, 0x55, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb1, 0x2c, 0xb5, 0xb5, 0x31, 0xf1, 0x31, 0xd7, 0x2f,
-				     0x36, 0x36, 0x36, 0x36, 0x1a, 0x8b, 0x11, 0x65, 0x00, 0x88,
-				     0xfa, 0xff, 0xff, 0x8f, 0xff, 0x08, 0x74, 0x33);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb2, 0x00, 0x47, 0xb0, 0x80, 0x00, 0x12, 0x72, 0x3c,
-				     0xa3, 0x03, 0x03, 0x00, 0x00, 0x88, 0xf5);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb4, 0x76, 0x76, 0x76, 0x76, 0x76, 0x76, 0x63, 0x5c,
-				     0x63, 0x5c, 0x01, 0x9e);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe9, 0xcd);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xba, 0x84);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe9, 0x3f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xbc, 0x1b, 0x04);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xbe, 0x20);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xbf, 0xfc, 0xc4);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc0, 0x36, 0x36, 0x22, 0x11, 0x22, 0xa0, 0x61, 0x08,
-				     0xf5, 0x03);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe9, 0xcc);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc7, 0x80);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe9, 0x3f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe9, 0xc6);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc8, 0x97);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe9, 0x3f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc9, 0x00, 0x1e, 0x13, 0x88, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xcb, 0x08, 0x13, 0x07, 0x00, 0x0f, 0x33);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xcc, 0x02);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe9, 0xc4);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd0, 0x03);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe9, 0x3f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd1, 0x37, 0x06, 0x00, 0x02, 0x04, 0x0c, 0xff);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd2, 0x1f, 0x11, 0x1f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd3, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00,
-				     0x08, 0x37, 0x47, 0x34, 0x3b, 0x12, 0x12, 0x03, 0x03, 0x32,
-				     0x10, 0x10, 0x00, 0x10, 0x32, 0x10, 0x08, 0x00, 0x08, 0x32,
-				     0x17, 0x94, 0x07, 0x94, 0x00, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd5, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
-				     0x18, 0x18, 0x19, 0x19, 0x40, 0x40, 0x1a, 0x1a, 0x1b, 0x1b,
-				     0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x20, 0x21,
-				     0x28, 0x29, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
-				     0x18, 0x18, 0x18, 0x18, 0x18, 0x18);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd6, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
-				     0x18, 0x18, 0x40, 0x40, 0x19, 0x19, 0x1a, 0x1a, 0x1b, 0x1b,
-				     0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01, 0x00, 0x29, 0x28,
-				     0x21, 0x20, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
-				     0x18, 0x18, 0x18, 0x18, 0x18, 0x18);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd8, 0xaa, 0xba, 0xea, 0xaa, 0xaa, 0xa0, 0xaa, 0xba,
-				     0xea, 0xaa, 0xaa, 0xa0, 0xaa, 0xba, 0xea, 0xaa, 0xaa, 0xa0,
-				     0xaa, 0xba, 0xea, 0xaa, 0xaa, 0xa0, 0xaa, 0xba, 0xea, 0xaa,
-				     0xaa, 0xa0, 0xaa, 0xba, 0xea, 0xaa, 0xaa, 0xa0);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe0, 0x00, 0x09, 0x14, 0x1e, 0x26, 0x48, 0x61, 0x67,
-				     0x6c, 0x67, 0x7d, 0x7f, 0x80, 0x8b, 0x87, 0x8f, 0x98, 0xab,
-				     0xab, 0x55, 0x5c, 0x68, 0x73, 0x00, 0x09, 0x14, 0x1e, 0x26,
-				     0x48, 0x61, 0x67, 0x6c, 0x67, 0x7d, 0x7f, 0x80, 0x8b, 0x87,
-				     0x8f, 0x98, 0xab, 0xab, 0x55, 0x5c, 0x68, 0x73);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe7, 0x0e, 0x10, 0x10, 0x21, 0x2b, 0x9a, 0x02, 0x54,
-				     0x9a, 0x14, 0x14, 0x00, 0x00, 0x00, 0x00, 0x12, 0x05, 0x02,
-				     0x02, 0x10);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xbd, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb1, 0x01, 0xbf, 0x11);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xcb, 0x86);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd2, 0x3c, 0xfa);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd3, 0x00, 0x00, 0x44, 0x00, 0x00, 0x00, 0x00, 0x00,
-				     0x80, 0x0c, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe7, 0x02, 0x00, 0x28, 0x01, 0x7e, 0x0f, 0x7e, 0x10,
-				     0xa0, 0x00, 0x00, 0x20, 0x40, 0x50, 0x40);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xbd, 0x02);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd8, 0xff, 0xff, 0xbf, 0xfe, 0xaa, 0xa0, 0xff, 0xff,
-				     0xbf, 0xfe, 0xaa, 0xa0);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe7, 0xfe, 0x04, 0xfe, 0x04, 0xfe, 0x04, 0x03, 0x03,
-				     0x03, 0x26, 0x00, 0x26, 0x81, 0x02, 0x40, 0x00, 0x20, 0x9e,
-				     0x04, 0x03, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xbd, 0x03);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe9, 0xc6);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb4, 0x03, 0xff, 0xf8);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe9, 0x3f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd8, 0x00, 0x2a, 0xaa, 0xa8, 0x00, 0x00, 0x00, 0x2a,
-				     0xaa, 0xa8, 0x00, 0x00, 0x00, 0x3f, 0xff, 0xfc, 0x00, 0x00,
-				     0x00, 0x3f, 0xff, 0xfc, 0x00, 0x00, 0x00, 0x2a, 0xaa, 0xa8,
-				     0x00, 0x00, 0x00, 0x2a, 0xaa, 0xa8, 0x00, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xbd, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe9, 0xc4);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xba, 0x96);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe9, 0x3f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xbd, 0x01);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe9, 0xc5);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xba, 0x4f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xe9, 0x3f);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0xbd, 0x00);
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x11);
-	if (ctx.accum_err)
-		return ctx.accum_err;
-
-	msleep(120);
-
-	mipi_dsi_dcs_write_seq_multi(&ctx, 0x29);
-
-	return ctx.accum_err;
-};
-
 static inline struct boe_panel *to_boe_panel(struct drm_panel *panel)
 {
 	return container_of(panel, struct boe_panel, base);
@@ -1859,34 +1757,6 @@ static const struct panel_desc starry_qfh032011_53g_desc = {
 	.lp11_before_reset = true,
 };
 
-static const struct drm_display_mode starry_himax83102_j02_default_mode = {
-	.clock = 162680,
-	.hdisplay = 1200,
-	.hsync_start = 1200 + 60,
-	.hsync_end = 1200 + 60 + 20,
-	.htotal = 1200 + 60 + 20 + 40,
-	.vdisplay = 1920,
-	.vsync_start = 1920 + 116,
-	.vsync_end = 1920 + 116 + 8,
-	.vtotal = 1920 + 116 + 8 + 12,
-	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
-};
-
-static const struct panel_desc starry_himax83102_j02_desc = {
-	.modes = &starry_himax83102_j02_default_mode,
-	.bpc = 8,
-	.size = {
-		.width_mm = 141,
-		.height_mm = 226,
-	},
-	.lanes = 4,
-	.format = MIPI_DSI_FMT_RGB888,
-	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
-		      MIPI_DSI_MODE_LPM,
-	.init = starry_himax83102_j02_init,
-	.lp11_before_reset = true,
-};
-
 static int boe_panel_get_modes(struct drm_panel *panel,
 			       struct drm_connector *connector)
 {
@@ -2062,9 +1932,6 @@ static const struct of_device_id boe_of_match[] = {
 	{ .compatible = "starry,2081101qfh032011-53g",
 	  .data = &starry_qfh032011_53g_desc
 	},
-	{ .compatible = "starry,himax83102-j02",
-	  .data = &starry_himax83102_j02_desc
-	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, boe_of_match);
diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
new file mode 100644
index 000000000000..856931239323
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
@@ -0,0 +1,478 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for panels based on Himax HX83102 controller, such as:
+ *
+ * - Starry 10.51" WUXGA MIPI-DSI panel
+ *
+ * Based on drivers/gpu/drm/panel/panel-himax-hx8394.c
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_panel.h>
+
+#include <video/mipi_display.h>
+
+/* Manufacturer specific DSI commands */
+#define HX83102_SETPOWER	0xb1
+#define HX83102_SETDISP		0xb2
+#define HX83102_SETCYC		0xb4
+#define HX83102_SETEXTC		0xb9
+#define HX83102_SETMIPI		0xba
+#define HX83102_SETVDC		0xbc
+#define HX83102_SETBANK		0xbd
+#define HX83102_UNKNOWN_BE	0xbe
+#define HX83102_SETPTBA		0xbf
+#define HX83102_SETSTBA		0xc0
+#define HX83102_SETTCON		0xc7
+#define HX83102_SETRAMDMY	0xc8
+#define HX83102_SETPWM		0xc9
+#define HX83102_SETCLOCK	0xcb
+#define HX83102_SETPANEL	0xcc
+#define HX83102_SETCASCADE	0xd0
+#define HX83102_SETPCTRL	0xd1
+#define HX83102_UNKNOWN_D2	0xd2
+#define HX83102_SETGIP0		0xd3
+#define HX83102_SETGIP1		0xd5
+#define HX83102_SETGIP2		0xd6
+#define HX83102_SETGIP3		0xd8
+#define HX83102_SETGMA		0xe0
+#define HX83102_SETTP1		0xe7
+#define HX83102_SETSPCCMD	0xe9
+
+struct hx83102 {
+	struct drm_panel base;
+	struct mipi_dsi_device *dsi;
+
+	const struct hx83102_panel_desc *desc;
+
+	enum drm_panel_orientation orientation;
+	struct regulator *pp1800;
+	struct regulator *avee;
+	struct regulator *avdd;
+	struct gpio_desc *enable_gpio;
+};
+
+struct hx83102_panel_desc {
+	const struct drm_display_mode *modes;
+
+	/**
+	 * @width_mm: width of the panel's active display area
+	 * @height_mm: height of the panel's active display area
+	 */
+	struct {
+		unsigned int width_mm;
+		unsigned int height_mm;
+	} size;
+
+	int (*init)(struct hx83102 *ctx);
+};
+
+static inline struct hx83102 *panel_to_hx83102(struct drm_panel *panel)
+{
+	return container_of(panel, struct hx83102, base);
+}
+
+static int hx83102_enable_extended_cmds(struct hx83102 *ctx, bool enable)
+{
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	if (enable)
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETEXTC, 0x83, 0x10, 0x21, 0x55, 0x00);
+	else
+		mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETEXTC, 0x00, 0x00, 0x00);
+
+	return 0;
+}
+
+static int starry_himax83102_j02_init(struct hx83102 *ctx)
+{
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	hx83102_enable_extended_cmds(ctx, true);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPOWER, 0x2c, 0xb5, 0xb5, 0x31, 0xf1,
+					 0x31, 0xd7, 0x2f, 0x36, 0x36, 0x36, 0x36, 0x1a, 0x8b, 0x11,
+					 0x65, 0x00, 0x88, 0xfa, 0xff, 0xff, 0x8f, 0xff, 0x08, 0x74,
+					 0x33);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETDISP, 0x00, 0x47, 0xb0, 0x80, 0x00,
+					 0x12, 0x72, 0x3c, 0xa3, 0x03, 0x03, 0x00, 0x00, 0x88, 0xf5);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCYC, 0x76, 0x76, 0x76, 0x76, 0x76,
+					 0x76, 0x63, 0x5c, 0x63, 0x5c, 0x01, 0x9e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xcd);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETMIPI, 0x84);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETVDC, 0x1b, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_UNKNOWN_BE, 0x20);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPTBA, 0xfc, 0xc4);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSTBA, 0x36, 0x36, 0x22, 0x11, 0x22,
+					 0xa0, 0x61, 0x08, 0xf5, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xcc);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETTCON, 0x80);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xc6);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETRAMDMY, 0x97);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPWM, 0x00, 0x1e, 0x13, 0x88, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCLOCK, 0x08, 0x13, 0x07, 0x00, 0x0f, 0x33);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPANEL, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xc4);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCASCADE, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPCTRL, 0x37, 0x06, 0x00, 0x02, 0x04, 0x0c,
+					 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_UNKNOWN_D2, 0x1f, 0x11, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP0, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00,
+					 0x08, 0x00, 0x08, 0x37, 0x47, 0x34, 0x3b, 0x12, 0x12, 0x03, 0x03,
+					 0x32, 0x10, 0x10, 0x00, 0x10, 0x32, 0x10, 0x08, 0x00, 0x08, 0x32,
+					 0x17, 0x94, 0x07, 0x94, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP1, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+					 0x18, 0x18, 0x18, 0x18, 0x19, 0x19, 0x40, 0x40, 0x1a, 0x1a, 0x1b,
+					 0x1b, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x20, 0x21,
+					 0x28, 0x29, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+					 0x18, 0x18, 0x18, 0x18, 0x18);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP2, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+					 0x18, 0x18, 0x18, 0x18, 0x40, 0x40, 0x19, 0x19, 0x1a, 0x1a, 0x1b,
+					 0x1b, 0x07, 0x06, 0x05, 0x04, 0x03, 0x02, 0x01, 0x00, 0x29, 0x28,
+					 0x21, 0x20, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+					 0x18, 0x18, 0x18, 0x18, 0x18);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP3, 0xaa, 0xba, 0xea, 0xaa, 0xaa, 0xa0,
+					 0xaa, 0xba, 0xea, 0xaa, 0xaa, 0xa0, 0xaa, 0xba, 0xea, 0xaa, 0xaa,
+					 0xa0, 0xaa, 0xba, 0xea, 0xaa, 0xaa, 0xa0, 0xaa, 0xba, 0xea, 0xaa,
+					 0xaa, 0xa0, 0xaa, 0xba, 0xea, 0xaa, 0xaa, 0xa0);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGMA, 0x00, 0x09, 0x14, 0x1e, 0x26, 0x48,
+					 0x61, 0x67, 0x6c, 0x67, 0x7d, 0x7f, 0x80, 0x8b, 0x87, 0x8f, 0x98,
+					 0xab, 0xab, 0x55, 0x5c, 0x68, 0x73, 0x00, 0x09, 0x14, 0x1e, 0x26,
+					 0x48, 0x61, 0x67, 0x6c, 0x67, 0x7d, 0x7f, 0x80, 0x8b, 0x87, 0x8f,
+					 0x98, 0xab, 0xab, 0x55, 0x5c, 0x68, 0x73);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETTP1, 0x0e, 0x10, 0x10, 0x21, 0x2b, 0x9a,
+					 0x02, 0x54, 0x9a, 0x14, 0x14, 0x00, 0x00, 0x00, 0x00, 0x12, 0x05,
+					 0x02, 0x02, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETPOWER, 0x01, 0xbf, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCLOCK, 0x86);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_UNKNOWN_D2, 0x3c, 0xfa);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP0, 0x00, 0x00, 0x44, 0x00, 0x00, 0x00,
+					 0x00, 0x00, 0x80, 0x0c, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETTP1, 0x02, 0x00, 0x28, 0x01, 0x7e, 0x0f,
+					 0x7e, 0x10, 0xa0, 0x00, 0x00, 0x20, 0x40, 0x50, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP3, 0xff, 0xff, 0xbf, 0xfe, 0xaa, 0xa0,
+					 0xff, 0xff, 0xbf, 0xfe, 0xaa, 0xa0);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETTP1, 0xfe, 0x04, 0xfe, 0x04, 0xfe, 0x04,
+					 0x03, 0x03, 0x03, 0x26, 0x00, 0x26, 0x81, 0x02, 0x40, 0x00, 0x20,
+					 0x9e, 0x04, 0x03, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xc6);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETCYC, 0x03, 0xff, 0xf8);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETGIP3, 0x00, 0x2a, 0xaa, 0xa8, 0x00, 0x00,
+					 0x00, 0x2a, 0xaa, 0xa8, 0x00, 0x00, 0x00, 0x3f, 0xff, 0xfc, 0x00,
+					 0x00, 0x00, 0x3f, 0xff, 0xfc, 0x00, 0x00, 0x00, 0x2a, 0xaa, 0xa8,
+					 0x00, 0x00, 0x00, 0x2a, 0xaa, 0xa8, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xc4);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETMIPI, 0x96);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0xc5);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETMIPI, 0x4f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETSPCCMD, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, HX83102_SETBANK, 0x00);
+
+	return dsi_ctx.accum_err;
+};
+
+static const struct drm_display_mode starry_mode = {
+	.clock = 162680,
+	.hdisplay = 1200,
+	.hsync_start = 1200 + 60,
+	.hsync_end = 1200 + 60 + 20,
+	.htotal = 1200 + 60 + 20 + 40,
+	.vdisplay = 1920,
+	.vsync_start = 1920 + 116,
+	.vsync_end = 1920 + 116 + 8,
+	.vtotal = 1920 + 116 + 8 + 12,
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static const struct hx83102_panel_desc starry_desc = {
+	.modes = &starry_mode,
+	.size = {
+		.width_mm = 141,
+		.height_mm = 226,
+	},
+	.init = starry_himax83102_j02_init,
+};
+
+static int hx83102_enable(struct drm_panel *panel)
+{
+	struct hx83102 *ctx = panel_to_hx83102(panel);
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	int ret;
+
+	ret = ctx->desc->init(ctx);
+	if (ret)
+		return ret;
+
+	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
+	if (ret) {
+		dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
+		return ret;
+	}
+
+	msleep(120);
+
+	ret = mipi_dsi_dcs_set_display_on(dsi);
+	if (ret) {
+		dev_err(dev, "Failed to turn on the display: %d\n", ret);
+	}
+
+	msleep(130);
+
+	return 0;
+}
+
+static int hx83102_panel_enter_sleep_mode(struct hx83102 *ctx)
+{
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	int ret;
+
+	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+
+	ret = mipi_dsi_dcs_set_display_off(dsi);
+	if (ret < 0)
+		return ret;
+
+	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int hx83102_disable(struct drm_panel *panel)
+{
+	struct hx83102 *ctx = panel_to_hx83102(panel);
+	struct mipi_dsi_device *dsi = ctx->dsi;
+	struct device *dev = &dsi->dev;
+	int ret;
+
+	ret = hx83102_panel_enter_sleep_mode(ctx);
+	if (ret < 0) {
+		dev_err(dev, "failed to set panel off: %d\n", ret);
+		return ret;
+	}
+
+	msleep(150);
+
+	return 0;
+}
+
+static int hx83102_unprepare(struct drm_panel *panel)
+{
+	struct hx83102 *ctx = panel_to_hx83102(panel);
+
+	gpiod_set_value(ctx->enable_gpio, 0);
+	usleep_range(1000, 2000);
+	regulator_disable(ctx->avee);
+	regulator_disable(ctx->avdd);
+	usleep_range(5000, 7000);
+	regulator_disable(ctx->pp1800);
+
+	return 0;
+}
+
+static int hx83102_prepare(struct drm_panel *panel)
+{
+	struct hx83102 *ctx = panel_to_hx83102(panel);
+	int ret;
+
+	gpiod_set_value(ctx->enable_gpio, 0);
+	usleep_range(1000, 1500);
+
+	ret = regulator_enable(ctx->pp1800);
+	if (ret < 0)
+		return ret;
+
+	usleep_range(3000, 5000);
+
+	ret = regulator_enable(ctx->avdd);
+	if (ret < 0)
+		goto poweroff1v8;
+	ret = regulator_enable(ctx->avee);
+	if (ret < 0)
+		goto poweroffavdd;
+
+	usleep_range(10000, 11000);
+
+	mipi_dsi_dcs_nop(ctx->dsi);
+	usleep_range(1000, 2000);
+
+	gpiod_set_value(ctx->enable_gpio, 1);
+	usleep_range(1000, 2000);
+	gpiod_set_value(ctx->enable_gpio, 0);
+	usleep_range(1000, 2000);
+	gpiod_set_value(ctx->enable_gpio, 1);
+	usleep_range(6000, 10000);
+
+	return 0;
+
+poweroffavdd:
+	regulator_disable(ctx->avdd);
+poweroff1v8:
+	usleep_range(5000, 7000);
+	regulator_disable(ctx->pp1800);
+	gpiod_set_value(ctx->enable_gpio, 0);
+
+	return ret;
+}
+
+static int hx83102_get_modes(struct drm_panel *panel,
+			    struct drm_connector *connector)
+{
+	struct hx83102 *ctx = panel_to_hx83102(panel);
+	const struct drm_display_mode *m = ctx->desc->modes;
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(connector->dev, m);
+
+	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
+	drm_mode_set_name(mode);
+	drm_mode_probed_add(connector, mode);
+
+	connector->display_info.width_mm = ctx->desc->size.width_mm;
+	connector->display_info.height_mm = ctx->desc->size.height_mm;
+	connector->display_info.bpc = 8;
+
+	return 1;
+}
+
+static enum drm_panel_orientation hx83102_get_orientation(struct drm_panel *panel)
+{
+	struct hx83102 *ctx = panel_to_hx83102(panel);
+
+	return ctx->orientation;
+}
+
+static const struct drm_panel_funcs hx83102_drm_funcs = {
+	.disable   = hx83102_disable,
+	.unprepare = hx83102_unprepare,
+	.prepare   = hx83102_prepare,
+	.enable    = hx83102_enable,
+	.get_modes = hx83102_get_modes,
+	.get_orientation = hx83102_get_orientation,
+};
+
+static int hx83102_panel_add(struct hx83102 *ctx)
+{
+	struct device *dev = &ctx->dsi->dev;
+	int err;
+
+	ctx->avdd = devm_regulator_get(dev, "avdd");
+	if (IS_ERR(ctx->avdd))
+		return PTR_ERR(ctx->avdd);
+
+	ctx->avee = devm_regulator_get(dev, "avee");
+	if (IS_ERR(ctx->avee))
+		return PTR_ERR(ctx->avee);
+
+	ctx->pp1800 = devm_regulator_get(dev, "pp1800");
+	if (IS_ERR(ctx->pp1800))
+		return PTR_ERR(ctx->pp1800);
+
+	ctx->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->enable_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->enable_gpio), "Cannot get enable GPIO\n");
+
+	ctx->base.prepare_prev_first = true;
+
+	drm_panel_init(&ctx->base, dev, &hx83102_drm_funcs,
+		       DRM_MODE_CONNECTOR_DSI);
+	err = of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
+	if (err < 0)
+		return dev_err_probe(dev, err, "failed to get orientation\n");
+
+	err = drm_panel_of_backlight(&ctx->base);
+	if (err)
+		return err;
+
+	ctx->base.funcs = &hx83102_drm_funcs;
+	ctx->base.dev = &ctx->dsi->dev;
+
+	drm_panel_add(&ctx->base);
+
+	return 0;
+}
+
+static int hx83102_probe(struct mipi_dsi_device *dsi)
+{
+	struct hx83102 *ctx;
+	int ret;
+	const struct hx83102_panel_desc *desc;
+
+	ctx = devm_kzalloc(&dsi->dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	desc = of_device_get_match_data(&dsi->dev);
+	dsi->lanes = 4;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+					  MIPI_DSI_MODE_LPM;
+	ctx->desc = desc;
+	ctx->dsi = dsi;
+	ret = hx83102_panel_add(ctx);
+	if (ret < 0)
+		return ret;
+
+	mipi_dsi_set_drvdata(dsi, ctx);
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret)
+		drm_panel_remove(&ctx->base);
+
+	return ret;
+}
+
+static void hx83102_remove(struct mipi_dsi_device *dsi)
+{
+	struct hx83102 *ctx = mipi_dsi_get_drvdata(dsi);
+	int ret;
+
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
+
+	if (ctx->base.dev)
+		drm_panel_remove(&ctx->base);
+}
+
+static const struct of_device_id hx83102_of_match[] = {
+	{ .compatible = "starry,himax83102-j02",
+	  .data = &starry_desc
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, hx83102_of_match);
+
+static struct mipi_dsi_driver hx83102_driver = {
+	.probe	= hx83102_probe,
+	.remove = hx83102_remove,
+	.driver = {
+		.name = "panel-himax-hx83102",
+		.of_match_table = hx83102_of_match,
+	},
+};
+module_mipi_dsi_driver(hx83102_driver);
+
+MODULE_AUTHOR("Cong Yang <yangcong5@huaqin.corp-partner.google.com>");
+MODULE_DESCRIPTION("DRM driver for Himax HX83102 based MIPI DSI panels");
+MODULE_LICENSE("GPL");
-- 
2.25.1


