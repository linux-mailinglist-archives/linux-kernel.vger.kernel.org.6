Return-Path: <linux-kernel+bounces-247279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8198E92CD77
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C691C22F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7933B16D4E2;
	Wed, 10 Jul 2024 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="SiboNZOy"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B4B16B39E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601277; cv=none; b=dQx8Lv/ZAleFOuZQtTCuG44I9S5MeLQgSGnMX6OekaGmide/LJmhMBJbH7PGLwAmgDbsoFryzjIemivpp8XEcWjR+bLih9pBw2/cVfFFF1kUmN3+gd+TOB4k7nME8OWy3Su6Msf2wj8mJA2at/9BzS3fiF0t+TY7ZcZHMTi6B6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601277; c=relaxed/simple;
	bh=PjWgtoSEauozcWTKiF9wVsSaXFw5EtUJNT7qcQdGvzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gzqc8SwPHHkmeilNVTXNIzdqDjYNcP0RIXSY6vpnGf2+BpnMIdE0+S/MNdCY4hTk+aPSKw/g1LO5AkzED1U8yZjvj8Hozn8u/ARFfOJTEQW3qq68vY3/YfmLCgeGU4mhw3B+zTjXJla/alnsiq/OiQuFvpgIs1JxxPmqSjGUL1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=SiboNZOy; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d932f991f6so1776090b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1720601271; x=1721206071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tn6/JTVF220KfPuRiI9l9VKV8sAaLbQJuZW2WMReItY=;
        b=SiboNZOyPRVkKaYVroBGmGbJYwTVN+1CjgsGDjl0R+e7/hrRUroXZDokmEajJRzfRC
         MVznxrceHje+imSXluu/BvY1W8F8Vaph5boZ4/+gLmT28yd/gNBfXtIQgU5Kmqi1ofiE
         gCkaFN8lqYBQMnfOUAf/0Ls3DG0cTmAujYCIHgr1sS+5dUmUOhi0TaBfqIlaICZcbAvf
         9T4Xg//DL3E3xsGq33jrZkdXYC4teCat4zaHMADXoslVDFsLExl55w307TQ1kXh4FJSn
         h4nOy/aekT9io1WzxYPRe/mbtUZGVa3oAPa4nlvpYnzJaNp+INpHAFZrXMbx/Z+AghXU
         7GzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720601271; x=1721206071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tn6/JTVF220KfPuRiI9l9VKV8sAaLbQJuZW2WMReItY=;
        b=bbkvOBWqyJH9trH3GQCFILDp9HnL4AYBuonBqoGptyxfTLA+LDa25WDb5AAi9vGHC1
         XQi/5ftKhpKYN1gtklT0jGYuXkE3MgIV99SIQCurQDcjV8fRzFM91sX1LnYxeSOA/YTl
         bXjMVz/OS/KJK4O2WIUZTNSf77L4NjDrfah612suamPpk5sFLrDURuuAyTX1ddUTE6WO
         6BjfVgCRTsQ8a6q/oZ6MyQawjN5Y+gz63rojA42d4fyIeCdg+4e5ucoke/QsEj72Vgii
         6Jwvkg01BOq+dABFJ3oa4xMw24ARAm++lMBeLtf+eulOxXEhtnj2jaUWxhYLQ3DsnC3O
         tj2A==
X-Forwarded-Encrypted: i=1; AJvYcCWbQzqGAt8xD99EvMSnRkJ9t1Gtf4UVIumtv66+79R8eoA+agn9Rtpd1yDYb3P/zWR6U9GT9MOUMj6JPYUR9s8mtX4F/6g2psqta+3Z
X-Gm-Message-State: AOJu0YxBRsVp9jVC2wkr7mYLVIXUpUh0Sl2GxS2bkCz/oHAs0PoKqpnb
	i1VsdLmxPsSzcGUjKTikpo4J1R3E51s3qfY/V/SiuNMdZCoOVZ5SBWJe6oUl/CM=
X-Google-Smtp-Source: AGHT+IFbgZB844oOUhZMaqOQ/5Pw8rPZQwKP9tFroRsoUhUFwclz9BfFci1WoXFSlj5HkkqIjeCNZg==
X-Received: by 2002:a05:6808:210b:b0:3d6:3174:8ac with SMTP id 5614622812f47-3d93c085952mr5381382b6e.38.1720601271698;
        Wed, 10 Jul 2024 01:47:51 -0700 (PDT)
Received: from yc.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438997d4sm3216077b3a.28.2024.07.10.01.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 01:47:51 -0700 (PDT)
From: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To: quic_jesszhan@quicinc.com,
	neil.armstrong@linaro.org,
	mwalle@kernel.org,
	dianders@chromium.org,
	linus.walleij@linaro.org,
	airlied@gmail.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [PATCH v1 3/4] drm/panel: nt36672e: Break some CMDS into helper functions
Date: Wed, 10 Jul 2024 16:47:14 +0800
Message-Id: <20240710084715.1119935-4-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240710084715.1119935-1-yangcong5@huaqin.corp-partner.google.com>
References: <20240710084715.1119935-1-yangcong5@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Break select page cmds and reload cmds into helper functions.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
 .../gpu/drm/panel/panel-novatek-nt36672e.c    | 69 ++++++++++++-------
 1 file changed, 44 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
index e81a70147259..8c9e04207ba9 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
@@ -44,6 +44,16 @@ struct nt36672e_panel {
 	const struct panel_desc *desc;
 };
 
+#define NT36672E_DCS_SWITCH_PAGE	0xff
+
+#define nt36672e_switch_page(ctx, page) \
+	mipi_dsi_dcs_write_seq_multi(ctx, NT36672E_DCS_SWITCH_PAGE, (page))
+
+static void nt36672e_enable_reload_cmds(struct mipi_dsi_multi_context *ctx)
+{
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xfb, 0x01);
+}
+
 static inline struct nt36672e_panel *to_nt36672e_panel(struct drm_panel *panel)
 {
 	return container_of(panel, struct nt36672e_panel, panel);
@@ -51,16 +61,16 @@ static inline struct nt36672e_panel *to_nt36672e_panel(struct drm_panel *panel)
 
 static void nt36672e_1080x2408_60hz_init(struct mipi_dsi_multi_context *ctx)
 {
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0x10);
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xfb, 0x01);
+	nt36672e_switch_page(ctx, 0x10);
+	nt36672e_enable_reload_cmds(ctx);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0xb0, 0x00);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0xc0, 0x00);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0xc1, 0x89, 0x28, 0x00, 0x08, 0x00, 0xaa, 0x02,
 				     0x0e, 0x00, 0x2b, 0x00, 0x07, 0x0d, 0xb7, 0x0c, 0xb7);
-
 	mipi_dsi_dcs_write_seq_multi(ctx, 0xc2, 0x1b, 0xa0);
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0x20);
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xfb, 0x01);
+
+	nt36672e_switch_page(ctx, 0x20);
+	nt36672e_enable_reload_cmds(ctx);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x01, 0x66);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x06, 0x40);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x07, 0x38);
@@ -76,8 +86,9 @@ static void nt36672e_1080x2408_60hz_init(struct mipi_dsi_multi_context *ctx)
 	mipi_dsi_dcs_write_seq_multi(ctx, 0xf7, 0x54);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0xf8, 0x64);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0xf9, 0x54);
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0x24);
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xfb, 0x01);
+
+	nt36672e_switch_page(ctx, 0x24);
+	nt36672e_enable_reload_cmds(ctx);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x01, 0x0f);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x03, 0x0c);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x05, 0x1d);
@@ -139,8 +150,9 @@ static void nt36672e_1080x2408_60hz_init(struct mipi_dsi_multi_context *ctx)
 	mipi_dsi_dcs_write_seq_multi(ctx, 0xc9, 0x00);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0xd9, 0x80);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0xe9, 0x02);
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0x25);
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xfb, 0x01);
+
+	nt36672e_switch_page(ctx, 0x25);
+	nt36672e_enable_reload_cmds(ctx);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x18, 0x22);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x19, 0xe4);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x21, 0x40);
@@ -164,8 +176,9 @@ static void nt36672e_1080x2408_60hz_init(struct mipi_dsi_multi_context *ctx)
 	mipi_dsi_dcs_write_seq_multi(ctx, 0xd7, 0x80);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0xef, 0x20);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0xf0, 0x84);
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0x26);
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xfb, 0x01);
+
+	nt36672e_switch_page(ctx, 0x26);
+	nt36672e_enable_reload_cmds(ctx);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x81, 0x0f);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x83, 0x01);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x84, 0x03);
@@ -185,8 +198,9 @@ static void nt36672e_1080x2408_60hz_init(struct mipi_dsi_multi_context *ctx)
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x9c, 0x00);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x9d, 0x00);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x9e, 0x00);
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0x27);
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xfb, 0x01);
+
+	nt36672e_switch_page(ctx, 0x27);
+	nt36672e_enable_reload_cmds(ctx);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x01, 0x68);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x20, 0x81);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x21, 0x6a);
@@ -215,8 +229,9 @@ static void nt36672e_1080x2408_60hz_init(struct mipi_dsi_multi_context *ctx)
 	mipi_dsi_dcs_write_seq_multi(ctx, 0xe6, 0xd3);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0xeb, 0x03);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0xec, 0x28);
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0x2a);
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xfb, 0x01);
+
+	nt36672e_switch_page(ctx, 0x2a);
+	nt36672e_enable_reload_cmds(ctx);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x00, 0x91);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x03, 0x20);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x07, 0x50);
@@ -260,8 +275,9 @@ static void nt36672e_1080x2408_60hz_init(struct mipi_dsi_multi_context *ctx)
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x8c, 0x7d);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x8d, 0x7d);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x8e, 0x7d);
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0x20);
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xfb, 0x01);
+
+	nt36672e_switch_page(ctx, 0x20);
+	nt36672e_enable_reload_cmds(ctx);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0xb0, 0x00, 0x00, 0x00, 0x17, 0x00, 0x49, 0x00,
 				     0x6a, 0x00, 0x89, 0x00, 0x9f, 0x00, 0xb6, 0x00, 0xc8);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0xb1, 0x00, 0xd9, 0x01, 0x10, 0x01, 0x3a, 0x01,
@@ -286,8 +302,9 @@ static void nt36672e_1080x2408_60hz_init(struct mipi_dsi_multi_context *ctx)
 				     0x01, 0x03, 0x1f, 0x03, 0x4a, 0x03, 0x59, 0x03, 0x6a);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0xbb, 0x03, 0x7d, 0x03, 0x93, 0x03, 0xab, 0x03,
 				     0xc8, 0x03, 0xec, 0x03, 0xfe, 0x00, 0x00);
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0x21);
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xfb, 0x01);
+
+	nt36672e_switch_page(ctx, 0x21);
+	nt36672e_enable_reload_cmds(ctx);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0xb0, 0x00, 0x00, 0x00, 0x17, 0x00, 0x49, 0x00,
 				     0x6a, 0x00, 0x89, 0x00, 0x9f, 0x00, 0xb6, 0x00, 0xc8);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0xb1, 0x00, 0xd9, 0x01, 0x10, 0x01, 0x3a, 0x01,
@@ -312,8 +329,9 @@ static void nt36672e_1080x2408_60hz_init(struct mipi_dsi_multi_context *ctx)
 				     0x01, 0x03, 0x1f, 0x03, 0x4a, 0x03, 0x59, 0x03, 0x6a);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0xbb, 0x03, 0x7d, 0x03, 0x93, 0x03, 0xab, 0x03,
 				     0xc8, 0x03, 0xec, 0x03, 0xfe, 0x00, 0x00);
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0x2c);
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xfb, 0x01);
+
+	nt36672e_switch_page(ctx, 0x2c);
+	nt36672e_enable_reload_cmds(ctx);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x61, 0x1f);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x62, 0x1f);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x7e, 0x03);
@@ -327,12 +345,13 @@ static void nt36672e_1080x2408_60hz_init(struct mipi_dsi_multi_context *ctx)
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x56, 0x0f);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x58, 0x0f);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x59, 0x0f);
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0xf0);
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xfb, 0x01);
+
+	nt36672e_switch_page(ctx, 0xf0);
+	nt36672e_enable_reload_cmds(ctx);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x5a, 0x00);
 
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xff, 0x10);
-	mipi_dsi_dcs_write_seq_multi(ctx, 0xfb, 0x01);
+	nt36672e_switch_page(ctx, 0x10);
+	nt36672e_enable_reload_cmds(ctx);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x51, 0xff);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x53, 0x24);
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x55, 0x01);
-- 
2.25.1


