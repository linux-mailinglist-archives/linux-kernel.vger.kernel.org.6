Return-Path: <linux-kernel+bounces-233899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D65191BEFB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DDF1C21A67
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3B819F477;
	Fri, 28 Jun 2024 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="gA6C0CYu"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE6A19AD93
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578769; cv=none; b=lrMOYg4M4Bb22MtZ7MRXYnMRLII42RN6EEYNqyzQQ+1cjV3zHM2IreoT2hmdkv+Nsq+aHpiCN3v8j3PtaW7c7tFwsGURvY8+65dvSt/14VBd3gXVtON2r/12lDN88Dz4rNBRMuzda2qrvB31VBFEsLcOxzjn72rflnTx2T6Y03s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578769; c=relaxed/simple;
	bh=pNZs9jyP/A7Pf2JchDUxylJEiYsyQSUgSvF66qCzCUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=iXOmcgR+FoJPz1HLn1DUYJYts4OQCYMsDX5UU1LN3Vu2JFEq6hL8AH0rwtmrrw5B8QvByLdUSGduRiExXK8xLuyEpThH3yMIA0uGfsCNHjsUfO4xL+7ahVe4J329xqOKJGZldWI1A/cXK+rB2NI0BQrdSqLCApaUmMVhrUERbG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=gA6C0CYu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f9cd92b146so2977695ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 05:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1719578757; x=1720183557; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NYdcAWuXYTWQAAXUNDXbS02yL9oAgEK+cNVTslAtCcU=;
        b=gA6C0CYuJWUh8DgW+ovhN3aBcQoVIMhLd9CAJdRdHqyM+Vji6NpOzn0CSSgyRpLLrV
         qSmcjU4gJIH9DyvjFam7q3xxjTwTGuV70dmWtjGh21zFb+7+ZH5+HA7PCQpL/iwDNA5o
         pFQXzRNxQefzO4AblacKT3QRXcJmDT95501pfgJ9bi07oa5uNkREr2p8P9mzIunUnHhx
         me6/MsS4j7t9lH2XFVCyTJwazQbK+VroEO7/KN0UJITQJllMymylImwYHCqe3zqeZTYo
         UhLB3cBgfDIOQCHxZ6Xw8FqrpyvO6Ghe31w734roshKfRiFb5Srgvpz/80GghW/AA+WM
         ZJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719578757; x=1720183557;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYdcAWuXYTWQAAXUNDXbS02yL9oAgEK+cNVTslAtCcU=;
        b=W5jRX1+SN+HLguotVUlDVZKUuXdiMIpgF3xsjU3PCp5uCy0XTPw+zeQuJqkpUZ8kFH
         tRDRJQatAsxVml/6QYJDo0sVwQbP3pYftB8dvuti50eL3QmBa0nCJyQ14MFH01/4zeli
         EARd+RlJ1Zkpltwq0vNTbDDqrLCl6BArxksJt9ZSnDmHHy8BzuMy5yufw8cY4L1W8Q5x
         hgcq/aJ7P2+q1OBl4gRdTf4bG9M0n7z3nVTTxJtMC/H4395PByuEPxrcugWx6JEP/GA8
         xll1IOVPIHGuiXyBRVi4gBSZ39qqz8oaed/p5DCxxd2TXkjmga/qPulKjTL24PqB2Xsu
         /rNA==
X-Forwarded-Encrypted: i=1; AJvYcCVlwBMYTJgU+vxo0W16BSeq08Npm0ANsGkea1FeyjB0olDWHXxTsFFuDlh1UTaUclG9wEjwLJt/Q+ahpie2Qcn8nFl2QfEKPZxLrtzb
X-Gm-Message-State: AOJu0YxpyzbtJL0MrTnGVsmjH4ulfeoGpXKLZo/aQDquoCIG7s9OpfWl
	WJVEopY3SJteQNFBJg15gjceP5RArxkhcfYVsKg56tyM+f8LZMtDZog9Fbj4RiQ=
X-Google-Smtp-Source: AGHT+IG+25MIgZJbSQk/taFj6VG+AknyVI+V2GARb6Z9W0SrNi26/KVVGwlFQTZ6sulU8JHp9mZozQ==
X-Received: by 2002:a17:902:ea11:b0:1f9:b697:b246 with SMTP id d9443c01a7336-1fa1d3de553mr202286995ad.5.1719578757393;
        Fri, 28 Jun 2024 05:45:57 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15695b4sm14346255ad.225.2024.06.28.05.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 05:45:56 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.co,
	dianders@google.com,
	hsinyi@google.com,
	jagan@edgeble.ai,
	neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v6 5/5] drm/panel: jd9365da: Add the function of adjusting orientation
Date: Fri, 28 Jun 2024 20:44:44 +0800
Message-Id: <20240628124444.28152-6-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240628124444.28152-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240628124444.28152-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This driver does not have the function to adjust the orientation,
so this function is added.

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
---
Changes between V6 and V5:
- 1. No changes.

V5: https://lore.kernel.org/all/20240624141926.5250-6-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V5 and V4:
- 1. Change dev_err() to dev_err_probe().

V4: https://lore.kernel.org/all/20240620080509.18504-5-lvzhaoxiong@huaqin.corp-partner.google.com/

Changes between V4 and V3:
- No changes.
---
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index b5265d95be4e..f002a80527b1 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -42,7 +42,7 @@ struct jadard {
 	struct drm_panel panel;
 	struct mipi_dsi_device *dsi;
 	const struct jadard_panel_desc *desc;
-
+	enum drm_panel_orientation orientation;
 	struct regulator *vdd;
 	struct regulator *vccio;
 	struct gpio_desc *reset;
@@ -178,12 +178,20 @@ static int jadard_get_modes(struct drm_panel *panel,
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
 
 static int radxa_display_8hd_ad002_init_cmds(struct jadard *jadard)
@@ -880,6 +888,10 @@ static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
 	drm_panel_init(&jadard->panel, dev, &jadard_funcs,
 		       DRM_MODE_CONNECTOR_DSI);
 
+	ret = of_drm_get_panel_orientation(dev->of_node, &jadard->orientation);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to get orientation\n");
+
 	ret = drm_panel_of_backlight(&jadard->panel);
 	if (ret)
 		return ret;
-- 
2.17.1


