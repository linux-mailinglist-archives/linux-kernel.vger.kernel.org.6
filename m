Return-Path: <linux-kernel+bounces-339363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9BF9863EB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA5A28C3E1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238B41D5ADC;
	Wed, 25 Sep 2024 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe3fhykG"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E051E1D5ACE
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727278983; cv=none; b=TTWHOtauqmZOd0n87IBzRGd4KhHRvdcTmdzgDj7rSTjAH6eb1A09V2gZubN08sWwGgV0wYnLNHNmW3VgK8bu3jtNO8Bhp5aCdU3y+dKBX6GodHAYhMHleFWLtJDCBQO9IwQ2N28p5MhieCe3DFhZegyK/PmyNZz8xWdeC496gCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727278983; c=relaxed/simple;
	bh=7sxYHbFVUy82VPtxBTafFtyJ4V/px/ZO0hSTzcua6/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pqyxoiG9zWKvTFg7uQpqKwJBuqg+HWdlKNfzIoucUXf2W3/G+PItlvSNBCTA7cB/tSd447mB1gy6xab9tSmcDqMq1fxEMDDj8O/tTZF6Mhy1TIoAEuTwKlW4ihBpgUl1R9a4M4hRVEFQKmK4vGoE2UMo0qNaYolAgjd8l+JlOmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pe3fhykG; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8a6d1766a7so967705266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727278980; x=1727883780; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWbh6GTwX/Nur9rLh4dOxd0uol8CDj0VjkbwHekxRn0=;
        b=Pe3fhykGoFwmAZTW1wXvtjVIZxXK7z66Lndd008LpeJmev4YLiZ4tjf4XaOy3SVtSi
         fDK7MljuzquTPFrmDG6BgX2V2fMuvuXtGmLATA/yshxhEPOLMxOu2tBtbHv6zVWXmX0E
         AKvxAhQAy/epyoZBeAIGgaayWxOrCpuYngISFUQU2KzRSWsGEp2S5ovEHXFZpX2OtQLt
         F8J7lxtXmrHQ8z7afLLQvAA37rl9K1Z7xiD8l3qu7s6K0M4k2BhUGLloZ5192I35NnDu
         S3Hx+eyB7dlJztu7KiS1ECa+onesWKg6jDp8bb4Qh7tEdqWgUrzQ+3nvZyTmFoE4/aoI
         HbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727278980; x=1727883780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWbh6GTwX/Nur9rLh4dOxd0uol8CDj0VjkbwHekxRn0=;
        b=ZhBanlzN4QydDC4wJG3vRDLcbJ6/Mx1TT2rd+bJOyRYP2MIttQ9CxgqQ3s8vcdie/A
         t6z4oC8AbWy550QYABmE/UyEbDY0KwIldq7qnc2+0H4/+fOT3Hf4eKdeHViYLVxaqv6a
         1v0aFou8F4jc1L/DLiN3xNK4hoibwGzhG027uayxQjaYgbAtGeKIMJq4GsHEH54usfC0
         bgPk49i5rGkwpAcYMEG7ZqvW/gbQge7fsiMPM219zx1KNxAetewHxWmOvDXwOYhHDfDF
         NuFtT5p5AgFs/xqZJP6V/AwScxcG89s0SavD0OWkJIvIAJkdyIz7WMwLjzwRX8EHB7Gj
         GQEw==
X-Forwarded-Encrypted: i=1; AJvYcCWnRsBLV8ekFQ5D49uiRoK29F91M0EBdFsFf8DJmPe41mg5IfA88cNvAE5Sw3yYg6e4r1NugUSgWWknVM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpzUKXsMFQY68rHnjrWfduBIrCut8x255zPzUXRiI8n3ELiX/f
	FWrAuS0Ag9wA3N1++fYivfQhJYN9wJMCl7Y9Dbihj09UPed76Ggr
X-Google-Smtp-Source: AGHT+IFOGCZlm7hxWZEDil/VHBukKjDMSy3xe8mZT1I0E9J+s+NIqup/Xj8x8pzeHvNlSTbRH1jJ6w==
X-Received: by 2002:a17:907:742:b0:a8b:6ee7:ba28 with SMTP id a640c23a62f3a-a93a0341396mr287138266b.1.1727278979968;
        Wed, 25 Sep 2024 08:42:59 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f3420esm221803466b.40.2024.09.25.08.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 08:42:59 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 25 Sep 2024 17:42:40 +0200
Subject: [PATCH 1/6] drm/bridge: dpc3433: Constify struct regmap_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240925-drm-const-regmap-v1-1-e609d502401b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727278971; l=841;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=7sxYHbFVUy82VPtxBTafFtyJ4V/px/ZO0hSTzcua6/s=;
 b=a1oRJ13BKg+sndE24RLHGwgqk3PJapTy3e06yyGNw7SE3ROWSvYabdohlrCbkn9bjP2TpGvpw
 SI97afI/Lq2DamjammUDr/YLmCMfIJxNhTzop91yyMyj7KjM74Q+KXg
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`dlpc_regmap_config` is not modified and can be declared as const to
move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/gpu/drm/bridge/ti-dlpc3433.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-dlpc3433.c b/drivers/gpu/drm/bridge/ti-dlpc3433.c
index 6b559e071301..a0a1b5dd794e 100644
--- a/drivers/gpu/drm/bridge/ti-dlpc3433.c
+++ b/drivers/gpu/drm/bridge/ti-dlpc3433.c
@@ -94,7 +94,7 @@ static const struct regmap_access_table dlpc_volatile_table = {
 	.n_yes_ranges = ARRAY_SIZE(dlpc_volatile_ranges),
 };
 
-static struct regmap_config dlpc_regmap_config = {
+static const struct regmap_config dlpc_regmap_config = {
 	.reg_bits		= 8,
 	.val_bits		= 8,
 	.max_register		= WR_DSI_PORT_EN,

-- 
2.43.0


