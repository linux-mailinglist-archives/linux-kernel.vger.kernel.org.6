Return-Path: <linux-kernel+bounces-339368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BEF9863FD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1243E28E10C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0F81B963;
	Wed, 25 Sep 2024 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z05ra4yZ"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCEA481CE
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727279001; cv=none; b=hDBL7Bgs5VvxTcq+SzKl4PT2QfeabbIY/qjD8zdiwFzSPQyhnC1p7Z7kr+g8E3nUtUad0Fx4q65lKsxF5vvR4dxhvMeD1tGP9DyZC1af2hCQJMIjR43Fb0juU5Q/cWYDlKirOQK7/MyMdlyDq37R7aInCUFdmgDXOBtt8Zuo6Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727279001; c=relaxed/simple;
	bh=/dTvDzTxw0elKvCO5X9KGGNdTLXj/tisL/crl9vaUr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oko4AgJUzIpMbxR8YIxheQOWFA0IaAIqeEoWfkQj0nO+sQ2EWnQkzw6tWi7wJZx88V8QFJxDIXPNnB3aAVhXHEWRH3e6EDNZQF4u1fKt8JsY4Yy2IaRLEgUhvKfSjuiah+9UpF6SIxhqcob5e0mf6PFF57JBwyzRlVE69lSHTVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z05ra4yZ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f763e9e759so78690041fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727278996; x=1727883796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Au0IxjjfAh+IrGj2ay54oiQohRBhlUlTthFZL3EgcLw=;
        b=Z05ra4yZ3kvu27ORNysS+dYGITCVdqZeB2e7eEx67mAQ40girr9lp2iIvP0qqfPEkJ
         +pdbvO4R7VD8gSZSPkONqLOFyfWSd4NSV7hJ9e9H6CzTtBrr/owXgT3CWh+oaGCcEtP6
         nJQI4U7CcqSgHkDiifLscTkI5Gomf3Cnaf6xQCT6CgSPAmSH/aUL9+GYyWfVY6FNpIc8
         4cUOYrkiof4BnHrpDeHpj+wLco6X1IKaAhySHC5V2M7ErfODUCBhxtSG1IOLd7S/vLs3
         xlP9qUvY/N9Z9mapVbDjDcKS+JPhC/T5IowgToFGtIjmu6t8FT3UjkPhJEkfnFCC9KUx
         NDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727278996; x=1727883796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Au0IxjjfAh+IrGj2ay54oiQohRBhlUlTthFZL3EgcLw=;
        b=q77OBlJQG/YA/2x6DwRXTDCHNqgdtX4H80PZzJ1NQIHamB4PYZLD5bCXjRjYwz+WIH
         ScrnxhCZC71M4kd2zTUPAL/cSoUgSPjkBVtioUp0QOx46Xrwl5Mn57SH7K+AAGC0tleo
         /rYBN1FtBSnpU3OUxr3b+zvBABiL9veZgvrAXjqX0LhiuWtKAslwYQPlOVbQJj8jsC4X
         SZHKeEzromMYska5YcSRTQQtGEAJ8cauAaIqdi82/GadTTE/0Hl+8w+CgHiAQy0wYDV/
         inYEGUuy0uetxecIQ8suPTsU1pOe8MsqfuRbUN6wygrGEikdLpJ5B4AHfrP/Y1Trwe3x
         O1pg==
X-Forwarded-Encrypted: i=1; AJvYcCXT0qeMmdIdnFLuQvo5fIZDJdkPD0mawpBQaJMtwMzOIPkL9BT0v4HYQ3m6Rl4av3KoufOl7SRuqR46WU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwbGP7LiEI12/CremXmBxrS6jaJ2HQcEqXHjF4eHVFs8cMNxOf
	42uHz9LoTF0UxumO2qBU2M1bGJpmz8o9496l5G4pmcv1VZTlWihY
X-Google-Smtp-Source: AGHT+IFCWYzAdpSpjVAnQ4BizrMtQKpfIddRrw3ocd29W6scUx1jmeEcp42KXRhfT3R4QSqzAie8lw==
X-Received: by 2002:a05:6512:3b92:b0:535:6a83:86f9 with SMTP id 2adb3069b0e04-538804c7028mr1863446e87.60.1727278995522;
        Wed, 25 Sep 2024 08:43:15 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f3420esm221803466b.40.2024.09.25.08.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 08:43:15 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 25 Sep 2024 17:42:45 +0200
Subject: [PATCH 6/6] drm/sprd: Constify struct regmap_bus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240925-drm-const-regmap-v1-6-e609d502401b@gmail.com>
References: <20240925-drm-const-regmap-v1-0-e609d502401b@gmail.com>
In-Reply-To: <20240925-drm-const-regmap-v1-0-e609d502401b@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727278971; l=759;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=/dTvDzTxw0elKvCO5X9KGGNdTLXj/tisL/crl9vaUr8=;
 b=373HrRNVvIqo811qw5A1e2uUKIh5z7ThMB7W+u2ouyWfcNGoTkirPUv/a3k0By1E45+/+k9nu
 s2jBMDDp7dTCURqw9nlmEGjS03N0BqfD1AngIvdPXCsiLl6HtBQDhfN
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`regmap_txt_io` is not modified and can be declared as const to
move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/gpu/drm/sprd/sprd_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sprd/sprd_dsi.c b/drivers/gpu/drm/sprd/sprd_dsi.c
index 0b69c140eab3..44a7a579660f 100644
--- a/drivers/gpu/drm/sprd/sprd_dsi.c
+++ b/drivers/gpu/drm/sprd/sprd_dsi.c
@@ -209,7 +209,7 @@ static int regmap_tst_io_read(void *context, u32 reg, u32 *val)
 	return 0;
 }
 
-static struct regmap_bus regmap_tst_io = {
+static const struct regmap_bus regmap_tst_io = {
 	.reg_write = regmap_tst_io_write,
 	.reg_read = regmap_tst_io_read,
 };

-- 
2.43.0


