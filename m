Return-Path: <linux-kernel+bounces-252008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88115930CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 05:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271871F2132D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 03:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDDC16D9AA;
	Mon, 15 Jul 2024 03:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="CUnIiEXj"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F0915FA8A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 03:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721013569; cv=none; b=nLtgbT1+8aUF7PMXab+SFF8aP/qqQXnQ2ebQG30xdKfmiAGJL9G29MH1x/1EF5jRe6x/WKAHxyJyLo/NvhxLbPxHUbttOqUPWXvFpccDTqPFyi2uWjNg+yy5+yUKRRipMpl4ZdTzHbRiy0hsksCGs6vsfuHXTbsB6A96DpCYhxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721013569; c=relaxed/simple;
	bh=Vkuiyb4Zb6H7nJOaFzcvqRz19gZXG4ll1U7q2mBP5zE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lVzsMOAnYJeksEdofVPhAVbbKOLrg4lZ/zqVcY3nqMdQIHQsLxUIyVnwWg6brlzkPXO6DMnax6lwyeA8w/mACUDOGwyjCzBaTI9s+f0JIIkChT8NV4Rn2ZsAXVbJBweYLaRGhgqA8CP6S9i2J8mlf3f4fe0XY80+/akAMMCFA1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=CUnIiEXj; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-75cda3719efso2075629a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 20:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1721013567; x=1721618367; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Ay8dHb/d/u1SYxFKuzba6qcuASuaNu7Y01CqhutO6A=;
        b=CUnIiEXj17jHPS4/eA+pI6XPbl+HrLKcoZIptbxQkjrxf7alIJspMskG/E6kR1LfhQ
         BYETW7XEQLJy2t3CAyvlAYlMtb8CGKfs5LvGEz8hb9oU/Gfg+okDcXZMqF89i2KoRA/r
         NPgEqAU3emSxgYgrodLjiyoYeq0ps5AusqbFDMb49RicQ54NM9+/7vYlBQOGoBDAe/fQ
         W6P0ZfGkcBVsZk+41e5j8tMU8C7TivhLSTqjlnGZt7zh/4AGi96MD4j4PUloalAz3ca9
         JkT+TLYejN+15aw2+C70wjHthpksx3fxhnwTQIqZZChSxopsTLqsg564I9OZPLXDplp5
         SvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721013567; x=1721618367;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ay8dHb/d/u1SYxFKuzba6qcuASuaNu7Y01CqhutO6A=;
        b=aPmb2lj24aKO9Ft0jK4r5D/5UtVGA1lD0avhMIDaAocW/s/Yij4mE+onmABb+OG/GD
         KioWmE94Ews0H3wFiMXA3yDh6h7dE0rOKN/ApRu7jmq0bZiVtVMxe5fD6akQASeZ7Ccr
         YCF4q4AUpF/Dzh6oLB2hHeLhov1491Ck60Q9uS+SG2DjAGfOQBo9A2O39ppJILInzjds
         RJxituxztYEj2YxIwFUE4Yz4ndtMBYO99OR/a4keb9e7e8g80/qfXRgboanZzug/sngQ
         umB4b6Czh9onQwZH9q16WAhTQ0sXitrwEbainH+CY3dUHcNOs1ggwUZR6/E5/6gDhCdi
         Cy8g==
X-Forwarded-Encrypted: i=1; AJvYcCU96GYpdzIKF1n2y17C7Wkt21sDkIflcpXPu4x8TqGu0nTirztgV9F602cdUnrHlDJ3dcVPefxz38IwAKcGEjkkX8npUOt7Q1E1a00r
X-Gm-Message-State: AOJu0Yy1IDH8dsSzaSeoRgCsZfCTCop7cCXInY5CmQzwiBvpaAbUSFmF
	d1T+rSInGGAnmm8qmw/u4ysGA5Y5oRyrwPAysUu1kHVkeIR3EmsmfvVyRfxhvh0=
X-Google-Smtp-Source: AGHT+IHtAU4k8V9WMmfWGlFSBuSRGwKW+2XcDchRVew5q6MSnM4nfRhYNT80/b+1aNDq+glL+2iEVQ==
X-Received: by 2002:a05:6a20:4320:b0:1c2:8af6:31d3 with SMTP id adf61e73a8af0-1c29820b81dmr20549419637.10.1721013566064;
        Sun, 14 Jul 2024 20:19:26 -0700 (PDT)
Received: from lvzhaoxiong-KLVC-WXX9.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc451e4sm29962635ad.247.2024.07.14.20.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 20:19:25 -0700 (PDT)
From: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	airlied@gmail.com,
	mripard@kernel.org,
	dianders@google.com,
	hsinyi@google.com,
	awarnecke002@hotmail.com,
	quic_jesszhan@quicinc.com,
	dmitry.baryshkov@linaro.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: [PATCH v1 1/1] drm/panel: boe-th101mb31ig002 : Fix the way to get porch parameters
Date: Mon, 15 Jul 2024 11:18:45 +0800
Message-Id: <20240715031845.6687-2-lvzhaoxiong@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240715031845.6687-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240715031845.6687-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The current driver can only obtain the porch parameters
of boe-th101mb31ig002. Modify it to obtain the porch
parameters of the panel currently being used.

Fixes: 24179ff9a2e4524 ("drm/panel: boe-th101mb31ig002 : Make it compatible with other panel.")

Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
---
 drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
index b55cf80c5522..d4e4abd103bb 100644
--- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
+++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
@@ -312,15 +312,14 @@ static int boe_th101mb31ig002_get_modes(struct drm_panel *panel,
 	struct boe_th101mb31ig002 *ctx = container_of(panel,
 						      struct boe_th101mb31ig002,
 						      panel);
+	const struct drm_display_mode *desc_mode = ctx->desc->modes;
 	struct drm_display_mode *mode;
 
-	mode = drm_mode_duplicate(connector->dev,
-				  &boe_th101mb31ig002_default_mode);
+	mode = drm_mode_duplicate(connector->dev, desc_mode);
 	if (!mode) {
 		dev_err(panel->dev, "Failed to add mode %ux%u@%u\n",
-			boe_th101mb31ig002_default_mode.hdisplay,
-			boe_th101mb31ig002_default_mode.vdisplay,
-			drm_mode_vrefresh(&boe_th101mb31ig002_default_mode));
+			desc_mode->hdisplay, desc_mode->vdisplay,
+			drm_mode_vrefresh(desc_mode));
 		return -ENOMEM;
 	}
 
-- 
2.17.1


