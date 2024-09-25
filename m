Return-Path: <linux-kernel+bounces-339364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C948E9863F0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0561F27A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F8D1AAC4;
	Wed, 25 Sep 2024 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaPBNpxC"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B251BDC8
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727278986; cv=none; b=bC90XL0f6HkcSqUDgJxeYdCKKLAGQV+TujaGmG3ysWs4IMd6MrzAkstN3ViqEC5tNzcQdcPs118iHGO12Jyl9PjyLwii2L0pKP1ZqvgZ6eBMHcmRUkXVoL3Hm8dXKCrnU8M5U+a4rgdxwHAZ5W5XLdkirRCnm0iFiukDYCqimg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727278986; c=relaxed/simple;
	bh=j5IVdz0beAjnl/rD8q67jV1CX8MClFwEzj++cGsQuD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OdPP5Ltuk1xCrlllWrHB7XHtNtHrXWAYCtrm+ufvpsqN4ElOAyyDuSE0Aa4WWNkm4qjq0zHQAQXoV1sVkYecstFyFX9NIaZ01Z5zzcURqRuJWerC8UX1CiFr2wCi6dN9qjyTD3B9fw1k7/l8Q/FeayicKYxcaw7vTgLvGhR8dao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaPBNpxC; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c245c62362so8430614a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727278983; x=1727883783; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3dpOZ/ioTVT/5il6ou2oxhriDCIeCxURBP+dRZuK6nM=;
        b=NaPBNpxCzhev7/bUuFsGnlHekJD3q7VPGZv9/L2a9C0DuJZjFWlrc/BVuP+M10UaL6
         tIky4r+4cVoJPJviDwmwPt6b6S7KPCezGO7V1IxNJTcxuK/IInQWdZyEYXjiaWVa4AgG
         f/UumVZL4yPxJUHCGmlbmQVoojvAcgsHJrytA5bxl4GXL3rMZCpTjrlDrjx11XX29OYa
         vgnryEd3sv0ZayJPVbm0RLzOOWBWkeP34gYSp8kvMOY4Y9ecSzGfRnsV0PFK/fFCJCkC
         VBNW/INuzwJciuNEm7Ho0spQKm+Lc0zJrBk8TOmwjq9WIIgtDjeDhaL57/GwteXByKBz
         uI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727278983; x=1727883783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dpOZ/ioTVT/5il6ou2oxhriDCIeCxURBP+dRZuK6nM=;
        b=iu5bCx/WM12fmiW54E/rdWSO09bTiUgxZVYL/hibXZmDQx1mgssXyoHP7j1KIrrXOK
         wH4pg1fQCYd+LobzSexU85HkKgsmDZYwi8FV29HosuUdP04Bo1NsApZDx7J4KJ7fAEdW
         TBpJjbstBUQJ8P4A2ztcjjOLgJbAa26wFTbRkP6FQC1OTdCYYBd5s80U4WR9lyIL7QG5
         2BVEIJaJFXnA1HnC63zCXhieGjZkmB3i9IkdTazh3TI1vd7vlSAqI+nflnfQB2FyTlCD
         Mw4AyI4+FKKQvWC+O2q+wnDikzKy3NbuhA/Vw+FLQ3We7scwJDmcr2qDYtuSktoLHGaP
         eBvg==
X-Forwarded-Encrypted: i=1; AJvYcCUTGyZ6IuyRZn/Ih0o11/fp65c0vaz2w0peg4L4CRpPNtkbeSOzlV5XFieveA76KvoML1F+/GZqH6sd95A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBjoIdIecOSAJMpp6FCk52iGnqIkzxM4X2Kph5jyqDxCWfWYuD
	R0XlGhxc/jRb6/Lo1njBuEz3UJIN+BiI1i13hC8PJuBGDsWSEiQJ
X-Google-Smtp-Source: AGHT+IGKuNv7lE0u67hJ2OAhIVHl0bYdcTWRyaXR7IlGUKMo0Hm1JsihuqtBmJ8apswZAkFgkwRFnw==
X-Received: by 2002:a17:907:1ca1:b0:a8c:78a5:8fc4 with SMTP id a640c23a62f3a-a93a036a36bmr248782566b.19.1727278982930;
        Wed, 25 Sep 2024 08:43:02 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f3420esm221803466b.40.2024.09.25.08.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 08:43:02 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 25 Sep 2024 17:42:41 +0200
Subject: [PATCH 2/6] drm/fsl-dcu: Constify struct regmap_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240925-drm-const-regmap-v1-2-e609d502401b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727278971; l=797;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=j5IVdz0beAjnl/rD8q67jV1CX8MClFwEzj++cGsQuD0=;
 b=4dMgS2dx5TyC8IP1MnInm+QJtBRuPpVnV4hoTf094WArm4pWhlF0Mhj9oO7SjZ12DXIAB3adY
 5WH2uozmSnrD87oiirTQsU5nwiuxGKcfiISjPQfFww1GYXuUT2164v3
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`fsl_tcon_regmap_config` is not modified and can be declared as const to
move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_tcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_tcon.c b/drivers/gpu/drm/fsl-dcu/fsl_tcon.c
index 9eb5abaf7d66..49bbd00c77ae 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_tcon.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_tcon.c
@@ -29,7 +29,7 @@ void fsl_tcon_bypass_enable(struct fsl_tcon *tcon)
 			   FSL_TCON_CTRL1_TCON_BYPASS);
 }
 
-static struct regmap_config fsl_tcon_regmap_config = {
+static const struct regmap_config fsl_tcon_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,

-- 
2.43.0


