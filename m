Return-Path: <linux-kernel+bounces-222212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 966FF90FE4A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7041F2464B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8F217623E;
	Thu, 20 Jun 2024 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="vLq9zNgf"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7E717334D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718870754; cv=none; b=DY7DRF0uHsMzglZZWV8N0HB06v9Q1rQJvZMxPAJYZAbsiE4H45A1gdKh1o79BnBAwWyaU2xo5FGutSIhX9Eo6GOTg5CyqR6QiEKH9Ut55n/PU9juWkS3PhaOkDvrc7YPTXEjxJMh0VBQPirjKgyics4HdjCfWZcEnkk49n0hY4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718870754; c=relaxed/simple;
	bh=TR/p/s+7xIFTDCxFlPxAv5HhWtahQakW/X1rrhPB/Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UgmiIhpFqBiYLrMh1rW+KR1bgFMLsua95m6EAtfucR/gjCydh19+s9J1MDIEFtDgkRTnbDLRAAmeyBWwGj2U8yx/prT4rVgD9rxsOyhXwQVHHqSiPVIMpYykRLlNvhMsNNKDiTRYuc2J1Zuob4zFgQZSPrFtlf9qTuSwwPho6js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=vLq9zNgf; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2598ae41389so332142fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1718870749; x=1719475549; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AMOoGP2LakwJmw2FH71ZMogJWrdUzY8/qHEtPyyBbV4=;
        b=vLq9zNgf1gVmIG8qbOyL5na+FHPzzzUbLTcsNitbryKC/GKPuxnfGHsin7QkFSLaTm
         g7MxOjvQHcr/kzJi6mg/C8wkxkAuRU6RTCNBMNsrK5YVG8wQl3XBTPOoDjUtqaRt6w18
         Rtu4pvb9KFDauXzZBRqzdHe2cU5QFh8091IK+Ykg5LoUXNikVpvVATzqyfG07KCDjyF8
         U8U8LJFbVxvurfu5KGPk1nc4jw/g2trQXv9eMwKeCwOdGZb1A53q23MWhDp1841pTq+N
         GUwxq3ANhqZ/lrg47eGA7i0E2JYUu7Wuq7mjwggctbEvUDNevxjKBDO4GEiPDY161NvQ
         Q0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718870749; x=1719475549;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AMOoGP2LakwJmw2FH71ZMogJWrdUzY8/qHEtPyyBbV4=;
        b=GCHGEJ/N72L5isWGxDCdA/a8tzzFBFg8v6985Ff4y3hSgLLlMibucKiTxnWFotiNRZ
         bQ+9D1MzdDFTmTvaGjwIzqtE22mbWBEY7LR9VJHl+qRz1YSicG4U17d6ikIJyyY6Gpkh
         XQwVB7N6kCufEUWF/IFFa5gtBIrAXIAC9YCDFifjy/kBudx9bzC9RSUX4y+bBiRoXhOv
         136MgBS/4y37zaoTuA00i2+SCimM7mKlavee1FpD2rlhogDvHugcfncHmsQBVEnZPEuX
         unAMWWR8RdZakfqW/e46NW9vHmFczNeS2NSLcmd1ZltByFxYvdTJhBZqxLsU+4gZGQUB
         8BpA==
X-Forwarded-Encrypted: i=1; AJvYcCUgpDxEAOEBNzJBAxrNpWKDYpSqZImBR4L52mj0dm39jd6dCfNasCNI7McgXmuOCe1i8DsEV1QRdBG/xdZ/YdvQS0XS67fA+2aB1e5d
X-Gm-Message-State: AOJu0YwsjkPvlit9d6wKLiThuOb7k4LkabKn7VO6iPVUYR7yxYDqP2mw
	48Xa+olGVIrZ5HvQFBzVOelpkVTe98ibxdS7GRuaDqr63+QAczmn6n/JcUUuWig=
X-Google-Smtp-Source: AGHT+IEbQAMEJgVsRzS0P1rsWA85d/j/lSoDKbJ+GhYfS/LOyoubfsealP8TGQ73YDuxPIYvuL2izg==
X-Received: by 2002:a05:6870:b50f:b0:255:1819:b458 with SMTP id 586e51a60fabf-25c948f70cfmr4660143fac.8.1718870749476;
        Thu, 20 Jun 2024 01:05:49 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96c8c5sm11805889b3a.58.2024.06.20.01.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 01:05:49 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.co,
	dianders@google.com,
	hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v4 4/4] drm/panel: jd9365da: Add the function of adjusting orientation
Date: Thu, 20 Jun 2024 16:05:09 +0800
Message-Id: <20240620080509.18504-5-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240620080509.18504-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240620080509.18504-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This driver does not have the function to adjust the orientation,
so this function is added.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---

Changes between V4 and V3:
- No changes.

---
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index 632bffa035ee..2545e22a5c85 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -46,7 +46,7 @@ struct jadard {
 	struct drm_panel panel;
 	struct mipi_dsi_device *dsi;
 	const struct jadard_panel_desc *desc;
-
+	enum drm_panel_orientation orientation;
 	struct regulator *vdd;
 	struct regulator *vccio;
 	struct gpio_desc *reset;
@@ -203,12 +203,20 @@ static int jadard_get_modes(struct drm_panel *panel,
 	return 1;
 }
 
+static enum drm_panel_orientation jadard_panel_get_orientation(struct drm_panel *panel)
+{
+	struct jadard *jadard = panel_to_jadard(panel);
+
+	return jadard->orientation;
+}
+
 static const struct drm_panel_funcs jadard_funcs = {
 	.disable = jadard_disable,
 	.unprepare = jadard_unprepare,
 	.prepare = jadard_prepare,
 	.enable = jadard_enable,
 	.get_modes = jadard_get_modes,
+	.get_orientation = jadard_panel_get_orientation,
 };
 
 static const struct jadard_init_cmd radxa_display_8hd_ad002_init_cmds[] = {
@@ -893,6 +901,12 @@ static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
 	drm_panel_init(&jadard->panel, dev, &jadard_funcs,
 		       DRM_MODE_CONNECTOR_DSI);
 
+	ret = of_drm_get_panel_orientation(dev->of_node, &jadard->orientation);
+	if (ret < 0) {
+		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
+		return ret;
+	}
+
 	ret = drm_panel_of_backlight(&jadard->panel);
 	if (ret)
 		return ret;
-- 
2.17.1


