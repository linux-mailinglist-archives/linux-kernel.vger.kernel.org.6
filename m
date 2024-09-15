Return-Path: <linux-kernel+bounces-329757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A0B9795B8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 10:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90541C216A8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E6013957B;
	Sun, 15 Sep 2024 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="RK9aoUqo"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9452549652
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 08:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726387857; cv=none; b=lYLRjHYd445CEQ9mvdALbb2h+NGlsctpzPkM3t1K7OhUCxsuwzqvh71E9UR3WOTj3IA/Ef8q4AA1mmDExODfbvwauBCi4ohM0uCGNAQWiHw9RZBEunaJR115P7Wd1UmPHVdI+m2wzMNJLWMB1KGfp5j/EKYBeqvsAMi6k8BaNds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726387857; c=relaxed/simple;
	bh=I4wNU1+QxgYfquwbwkYGQYdatTeDdrvWgTPrmauHCdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MPGO1txy6lA5X77HUv+cb+pVgfel0X+UtuUAJJrQPYpXSDQNVzS/gtGyXGN71mtZAfMwtBx1wi0lYZzWiL4fSovulEyQrxfAtIZDUl0HLqACwZAPEyt9roLRQQcxyWOsozmdOrelDmqlBT4M7iP7mCpQJQ6wIj3RT7Dw3zWqQdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=RK9aoUqo; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d871bd95ffso678711a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 01:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1726387855; x=1726992655; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jI8AGx19JOnD3u1rifDJzZrI0uRZEbX+cl7EZ8hebKs=;
        b=RK9aoUqolBenPtem6IBs8yZeibv9FoV1UwIeNKfoEdV0ococppgsMyI2AMRmQLWeC8
         jf64V4exJFPZfRwwbOhu8CqmQmRGnuYDu2mPGNvg6K/GqGO3+EsmerWYzuI2EwH2IAch
         HQXslPv1pI7VMf0UEBQlQk/nmQRGeeAP2uMeQXtUiRkfvSkqWcTb2AcloA3tSKfxBPA6
         8RfS6W+6EnLPV7nqkyOCoHhu16wUR53BTov1huMMPqhheBS46l3EfRn5ASBHtCN4wpK5
         AjVP2FiJDLpMqHIendALE0z5EQZLZ8GJRpyuBVwVCW+LjcdpL0FuFiAB2E86tUWPO0mC
         qIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726387855; x=1726992655;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jI8AGx19JOnD3u1rifDJzZrI0uRZEbX+cl7EZ8hebKs=;
        b=rk38okfHCDZAgF2GXcFUdThq48fSGQPV2YT156AfUf2Yvv+9ygg5EOIiOJPXL0eUPJ
         oMo3Wk1Bp41COLEVrg1Rk6xzIuoDI/Hm9mt4AMYX8AQsd+CIzHv+PBZLvFn15T9XMBVU
         LGxrIdQRpeESdAxPpS0i86vX4Xrdl2mPc5Lgm6QVrqKzH68q75/hhwPbGDOCj0NueRI7
         3SgVvYS/ShLFe9OHWackVtIZw9C6CkDFsSBGRRib7m6ZI5rgYAeEPoaG4shHluuJ2ogq
         bRniXjecTzvPDrJgHG8xMplxAkO8pfOkGymvgKp3PL1Sh69AKk1MeE9hq4RpAJZwcpaE
         ADbw==
X-Forwarded-Encrypted: i=1; AJvYcCVcCn8sEFxvNBW44J5Gq2kwZSK1KCOHtWguXt4OMtopKr15BCMjKzqtEfnAcjc9zw//yjdgBMaQfYLzsyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwshFsuMmaLv3oLCGa6TrLejkk9t5xTwYmtvjYAgx9PvMAD0ATc
	9xh5d/Z1lpVB6oW4kK3Gxdg3K0CJCC5NoyCskVs0alLE+MUiep9zcL6iX4WyvPs=
X-Google-Smtp-Source: AGHT+IGKpkbPPStSQ4FEXaJuOSVr/bbexGHTzSisD9VQpGZVl5JVohrbEEYGg+wKhdUkgnQi3bogTg==
X-Received: by 2002:a17:90a:d791:b0:2da:71f8:7ff with SMTP id 98e67ed59e1d1-2dba005b46amr5313010a91.5.1726387854747;
        Sun, 15 Sep 2024 01:10:54 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfd26f2csm2662672a91.31.2024.09.15.01.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 01:10:54 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	sam@ravnborg.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dianders@chromium.org,
	hsinyi@google.com,
	awarnecke002@hotmail.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v1 1/2] drm/panel: jd9365da: Modify Kingdisplay and  Melfas panel timing
Date: Sun, 15 Sep 2024 16:08:29 +0800
Message-Id: <20240915080830.11318-2-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240915080830.11318-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240915080830.11318-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In order to meet the timing, remove the delay between "backlight off"
and "display off"

Removing variables: display_off_to_enter_sleep_delay_ms

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index 44897e5218a6..2f8af86bc2a0 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -31,7 +31,6 @@ struct jadard_panel_desc {
 	bool reset_before_power_off_vcioo;
 	unsigned int vcioo_to_lp11_delay_ms;
 	unsigned int lp11_to_reset_delay_ms;
-	unsigned int backlight_off_to_display_off_delay_ms;
 	unsigned int display_off_to_enter_sleep_delay_ms;
 	unsigned int enter_sleep_to_reset_down_delay_ms;
 };
@@ -69,9 +68,6 @@ static int jadard_disable(struct drm_panel *panel)
 	struct jadard *jadard = panel_to_jadard(panel);
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
 
-	if (jadard->desc->backlight_off_to_display_off_delay_ms)
-		mipi_dsi_msleep(&dsi_ctx, jadard->desc->backlight_off_to_display_off_delay_ms);
-
 	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 
 	if (jadard->desc->display_off_to_enter_sleep_delay_ms)
@@ -858,7 +854,6 @@ static const struct jadard_panel_desc kingdisplay_kd101ne3_40ti_desc = {
 	.reset_before_power_off_vcioo = true,
 	.vcioo_to_lp11_delay_ms = 5,
 	.lp11_to_reset_delay_ms = 10,
-	.backlight_off_to_display_off_delay_ms = 100,
 	.display_off_to_enter_sleep_delay_ms = 50,
 	.enter_sleep_to_reset_down_delay_ms = 100,
 };
@@ -1109,7 +1104,6 @@ static const struct jadard_panel_desc melfas_lmfbx101117480_desc = {
 	.reset_before_power_off_vcioo = true,
 	.vcioo_to_lp11_delay_ms = 5,
 	.lp11_to_reset_delay_ms = 10,
-	.backlight_off_to_display_off_delay_ms = 100,
 	.display_off_to_enter_sleep_delay_ms = 50,
 	.enter_sleep_to_reset_down_delay_ms = 100,
 };
-- 
2.17.1


