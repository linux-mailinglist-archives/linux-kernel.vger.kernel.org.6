Return-Path: <linux-kernel+bounces-339365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C564C9863F1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478031F2783E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6C817BB4;
	Wed, 25 Sep 2024 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iv6tsktn"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A23241E7
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727278990; cv=none; b=JFv7tIP+YFiCHiFP2xBduGL4QOlvKiNNHgHCs6hEdKls+YDnHl4qWAO3vWrxv4R6BSNkoaX3F0034RmPpEMtCHT653ymMDcxLaG/pkZdWtOK5MRH1Wgzemgy3s+Vxz3Y2HbvvCqX1VLrku4iF0bLEx2HIt+UKcvZ7O0W6zhwMgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727278990; c=relaxed/simple;
	bh=Akh6/NmxNUGKnN3cTl+ADfEVv/jFRL48hClqI8/xUq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LcfVzOzuKtJDlk8OoXtKmQjEwTVXAgBjyDs4tV0YpDn7y80dE8iH3tMYgHDk2heu7XSFUIupHCR44xtdOVDfaoRpO0qrR39QvX2KJ7OcbZ9AAJn43Jk7ubY4cKO7ME/pakS7U9PQn6fDyu3Vr31Y35uGWzUPDs8UBHPwfqxLXp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iv6tsktn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so88019895e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727278986; x=1727883786; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=by/nTcqi0aVjyTogWtw3F/RwUIoI+ZIDj6x5N4uN+wg=;
        b=iv6tsktnZKSbMhobbq1zgaFhx6YjPewUxNOQd+PQ/1/wfiacNazNylJ0zOqvH/r9Oj
         Qpmp3z2cLy6VhfqqL9ovCl/jOpb/haGPyvMpwcMTn/nml2OxZfsONBx8rimZloPgSCZd
         zxjChlzPS5oBJmaVOmztlQ8VSkBLCx3g7VCRvHXZKxx+YMR/8DskAFuTKJRZ/wI/u93K
         S8uv2ll5Tw5lc3b8huvaW5j44KKwpmGA/+NzSVfk4jMY1ejv9DMxlaDCgS3pv+vMaxKk
         x3/vBXpjcLbBH9zbUSQ3jUKUsAg5UCy+kJmtUtZznUIRR7jZyyQNTpGE5OEVLAw5LYUv
         /kiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727278986; x=1727883786;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=by/nTcqi0aVjyTogWtw3F/RwUIoI+ZIDj6x5N4uN+wg=;
        b=GP3nGmuin3+HTgYl5Hyn5w8Ppg2F/Gs42gAZKHUDFO/viC4x3aNplajeCjsdOiHLmr
         aabWk/f7zL3DcpmeWPl4xhOCLpK4RCRikpHjsR2YKxdzAGGLfCi+5FowcWTg9fzRkY84
         qnFzjxvFkiYF2UF3P8ExjgxBuiI5ZRZIyzCIPE9OF/umGQAh/OO6cIi+Aq2N0CRBjhUA
         w4gkaQF7b1fuazAbH903QiihAlqTNzsN/mqrJDHlGB8Afl7Bl7ojD1tBHsVx+NbJPpxe
         E2HyWp6WBJ0QZnxbQSt3+T52V5qmNFVRDKPSE4DUKI0PhEkbdRV2cAJ19w4SF13o04q6
         MabQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0kkvE+M8XmyKvPiyqnx+L17KKach/shgAODpI7xrxU8ZARQYZ9Neyg051o7R/S9JAg65Kux+Vb0k2UFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YySXU6cGJaGkHk4SwNTVrWawJ0+KlGRiOaP/pELzPz5ZNE8reR+
	tzBqEI7YsyKliC18GTEkmgBokP4UfQkRn3g1bkWqnvNBo6S01/gAmcBzH9Yl
X-Google-Smtp-Source: AGHT+IHJhvH9gplBfs4rlapKgfN74X4J8uVmh8ECXCHmFytouFZD6MReKNv2uyQvggR0QFC+8+ktEQ==
X-Received: by 2002:adf:fbcc:0:b0:374:c44e:ef27 with SMTP id ffacd0b85a97d-37cc245dd30mr2854153f8f.8.1727278986389;
        Wed, 25 Sep 2024 08:43:06 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f3420esm221803466b.40.2024.09.25.08.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 08:43:06 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 25 Sep 2024 17:42:42 +0200
Subject: [PATCH 3/6] drm/mediatek: dp: Constify struct regmap_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240925-drm-const-regmap-v1-3-e609d502401b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727278971; l=784;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=Akh6/NmxNUGKnN3cTl+ADfEVv/jFRL48hClqI8/xUq8=;
 b=IjANioE+JCFwAjMkuWw7rvXfaWWxlLsFG0TPSDiWvDMe+XOLw4C6wtw/QweEtNdXjuNtLJZ0b
 bWnz5DBwP4dBi/Bl+1Ajyf6T97mjVaMth7Bkz45oPrpPhWhldTvE638
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`mtk_dp_regmap_config` is not modified and can be declared as const to
move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index d8796a904eca..f0f6f402994a 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -311,7 +311,7 @@ static const struct mtk_dp_efuse_fmt mt8195_dp_efuse_fmt[MTK_DP_CAL_MAX] = {
 	},
 };
 
-static struct regmap_config mtk_dp_regmap_config = {
+static const struct regmap_config mtk_dp_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,

-- 
2.43.0


