Return-Path: <linux-kernel+bounces-339366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD869863F7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D0F1F282E8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974A61D5AD4;
	Wed, 25 Sep 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKWBX2p4"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9CE26AE6
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727278993; cv=none; b=Nlz8gg1rxyfsj7C6vFnHlCbG+M7tKCfbFjzSbo7kxcz9fK7C6u4JRc/dVa3T1N/ZhaBxqS8OnRcyvACwGAYWDuiPRIWL+BYrOon1gbHNg3zxxj+hhPqCFyhYL9rFkGA4k4T5/mSBAge8QdfY9j5l9PF6CfBsJQNGAVb5E9Crhks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727278993; c=relaxed/simple;
	bh=5LX2h6KUZ5if9Uj2vao0DwqWNuvKw18cUv/GkRmqevw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mhDvpcFYFEGx1IhoVSNugOW8Shpgrnpin0GMouTXoo0r1TrfueLKo1JY2f2XufdYD5JY5GbFk/3FButwfalYB2KKIB5p1Ys1da51hT2YdlEN6Exe/6UsgxJrvKK8nOeOObcPIuFLu6O7i/pKtDzhI5tE4GJx3HspbeXe38aDqAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKWBX2p4; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d51a7d6f5so1021417266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727278989; x=1727883789; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjGKEXG/YIg5uwQvEVpB+Au2CtHAgTgzoyA92gxhP0w=;
        b=LKWBX2p4sMQb41iP9AtUpNk03fdg7NiBT1KIBK3zvXJDBlnCvb4Hpyrlok7tEz1CxY
         81pLkHyRGARDNOiKEe2nxBuXNRnPQTVUDuVs7nzSXvOnigD3EIYXzo+qv0WCp34vlc0z
         hMiOnpG2zNsW6E/aUm0mTrz+rgIMkZYZygusqALmw3nonYX6iCCUvf/XqOMyJZMV59CR
         PBiJT/E7UJp3oG7PMWZbGcjRUVxgFzL5HBfU+vUZv3SVic/f5GoDkGYgacIMj4Q+HLDv
         8t4cwYxoT8IDT6FCSJPO5bpW4sgGHBWtzU7k6d8MrVrCkOmpzBdk+7uHjkaW2dKmFdWs
         Zy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727278989; x=1727883789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xjGKEXG/YIg5uwQvEVpB+Au2CtHAgTgzoyA92gxhP0w=;
        b=J+r5OKkhXvd+xG8Kz141IwwWi5h4oC2fM27FjWqGU/9hpgJz3/TrQel0fsB0Rj0XMA
         P8l4IMhXygiyhv3iCqEXJOYQnaKtfGy9QXJaVx1NtscXFpTDAiYWvkTrONRFbPqivUsh
         XAT+7vXvmr81Uto0PLH4wdYWGvN392d6QBXkNeVpK0RvNjO9BbPpa6eG2dlnnTlct2Q1
         hGdvWXywXmqrKt1rBNfs36w/rHtQAcCnnjWH1g8ptzGqjorR3uNYoT1qV4/oZN8YW21W
         vWfNndUrB9Ypg7jrQhWKCp67E2k10oPSz//DCt11Cn/WHf+P5X9WAqklZH/TVbVR5Aqr
         iLfg==
X-Forwarded-Encrypted: i=1; AJvYcCUe92ZU8uigj8NXEOPQ9y5O5McVZuPC7X6UGYdtk/Dt9X4Xj0zwqURpg+fmWRsf/IeWHwlVw0QMPLUh1pU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7wGkrer127SOkNjLtc5N615DGAU3ff1WtSISgcqMBLxlN/nkd
	XDroGTLbrksFkIhRK2aIdmRB2kslUVQppNr3y5FIve+w8BIDKxf9
X-Google-Smtp-Source: AGHT+IGAQfbPRbsfTpM0aK4D6fvZG1rsiktVYt61uGomOVbKMmopBwPFSptvkm9mzsan2gR9cCCh1g==
X-Received: by 2002:a17:907:36c1:b0:a86:7924:11bd with SMTP id a640c23a62f3a-a93a05fff3amr378300766b.41.1727278989391;
        Wed, 25 Sep 2024 08:43:09 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f3420esm221803466b.40.2024.09.25.08.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 08:43:09 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 25 Sep 2024 17:42:43 +0200
Subject: [PATCH 4/6] drm/meson: Constify struct regmap_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240925-drm-const-regmap-v1-4-e609d502401b@gmail.com>
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
 bh=5LX2h6KUZ5if9Uj2vao0DwqWNuvKw18cUv/GkRmqevw=;
 b=i/26hRvR0+ATIZUcXlMm3e7auzpYVGdXGLS4TiyMLWDOmWVpEOZntFsYtA6UIGOAGHiXCzB2L
 ugbC+ZKd/ssD1Wn8wgdhVT2jaSlKi3OSJfOxsagoBy2dqeu80xbwgz/
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`meson_regmap_config` is not modified and can be declared as const to
move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 4bd0baa2a4f5..6c8677d1f562 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -126,7 +126,7 @@ static bool meson_vpu_has_available_connectors(struct device *dev)
 	return false;
 }
 
-static struct regmap_config meson_regmap_config = {
+static const struct regmap_config meson_regmap_config = {
 	.reg_bits       = 32,
 	.val_bits       = 32,
 	.reg_stride     = 4,

-- 
2.43.0


