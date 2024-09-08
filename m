Return-Path: <linux-kernel+bounces-320265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDD2970821
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21391F21EF4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBC917107F;
	Sun,  8 Sep 2024 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UbkR5Hr1"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F512172BA8
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725805321; cv=none; b=aCTpEOFsMkFEm8e9GkUwbjF53RpTM4Xvzc3jwT9SIaw9kne03GaYeMN1i43hYjtPfZh0xgvlaXKhHSBDrGc/2ihgDDi23dLnADRe46ezrLv0vchNkRzh4YkDq2TxNmNGwRoGB36ZT+5L80V/RiIOGWtS2Zvvz7E6QFeX1LAcjyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725805321; c=relaxed/simple;
	bh=oU64b9cUM1B+FhKojFLvauLBTDBEruXsTRhzx3DV120=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NMRd+kF6xThgpOtKyXK+GlJV5GgboDPjr+QM8qFlxzUfsN0t7KdQmSxwWMsE/RaYZ5QRXs3/hn3Xulit3awqUsI1012x3jdFAbW69UxJCCkmGYZMFvEnT0RIztHZf7D/j2wdtDNPmW2kjhWB57OJl4r0Z+MnhphzXqUlS7aBXdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UbkR5Hr1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb1866c00so1306535e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 07:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725805318; x=1726410118; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0L1ilx+hMa2xq7WP3Qq4RE5fisuDsq/efyV+pjB+nU=;
        b=UbkR5Hr1kDP4UVSU7VvL7hXJ/B0596V9+m6xoQ7tL3oxJa+el3RC3jIWcRlIBhYwrO
         cpilTTRBB36CZ9FbwsTNTxoHfBHjzuL4qeTVJorhdfwo9NaVR1VCu9I7j7xOqhYwjRJz
         7l257Z8HRUJKIFSIsMf+JaLKxmDIyljrnoLCGQK3y6eYTn15FfDvoGy8h7LpNgYLsetC
         i2fCcYS8HJW1bn/Yi1JZ3DA+hpigku/jMp1NhId1Xm3x6d1oZPstnSMrOka5z6tuoYZF
         L0BPjSIj42guHzA5ZYBueZwj24JfP/Gu6lHQxxbWM5m/6AddocN/0yWJt3KwoPZg3gM1
         qrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725805318; x=1726410118;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0L1ilx+hMa2xq7WP3Qq4RE5fisuDsq/efyV+pjB+nU=;
        b=DnmmwZlr+pblV2/fIzjs1AD+VMzHaL3srlRPLM2/Xmo53g3wp98907rKzTt8CX6AtV
         QJoaQ+jU30oNBylgqlaCDXrKMvosawbPqT1isZgMudHm2Bbyg3kgc1wTPaPGcVPiakXh
         pAmZUWYkoywGXVHZme0vXaM8hmxSZxKGWWinweouj5Di3L1dWviQFhBPO5yw9pvuvpZh
         QLWR/WwfWzUe1gPB8PrbNDYc/3tsn+TZg9qRKyFQ2l7/XGjyuYRMSMWHnlDKGjk+wVTY
         TbROZchg0ezaYx1mhG9+lFOR/fri1SQ96vOm3+UOnwSZ8/pqKqbntTM7aD6iJg5PEbjl
         7a3A==
X-Forwarded-Encrypted: i=1; AJvYcCWuktqtCIL8UuNg7E8t5rFpfa9HO0ODfgr6DisOQRY6G1EzwetzBQlMjCcVK1bnRykRPTTpoWhsnVF/I1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT1akhvK+QNpnejQSPcVBMCudV0OJpDD5L4ZfCMOWAiaejvs3a
	yirsqBFTMHhipRVKODhNmGW63oxtzeYC3C+nJMYL5Gs+cN9E+Tiw79Vvymn0dYU=
X-Google-Smtp-Source: AGHT+IHTVEZ6ZfPKh1HQZv1kOYMnnFQNGX2KN1ojIsct/KCdkX/n63VIjNLycr0FImyCNmbejXsuHQ==
X-Received: by 2002:a05:6000:4029:b0:374:b6f5:89aa with SMTP id ffacd0b85a97d-378895ca6ffmr2551755f8f.3.1725805317414;
        Sun, 08 Sep 2024 07:21:57 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675bc9sm3465092f8f.56.2024.09.08.07.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 07:21:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 08 Sep 2024 16:21:35 +0200
Subject: [PATCH 5/5] drm/bridge: ti-dlpc3433: constify regmap_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240908-regmap-config-const-v1-5-28f349004811@linaro.org>
References: <20240908-regmap-config-const-v1-0-28f349004811@linaro.org>
In-Reply-To: <20240908-regmap-config-const-v1-0-28f349004811@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=821;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=oU64b9cUM1B+FhKojFLvauLBTDBEruXsTRhzx3DV120=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBm3bL2DUYDY7DvAGsL0obtzggBzQHcH1rHvgeEl
 aWZ6s/p+46JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZt2y9gAKCRDBN2bmhouD
 1yqTEACYXmHXPSUUnUlz2ip/BtD/rSYishh4B1RnVHWgH7UaLOnusfLIQ/7uJcPa+iqZ9kDBTTb
 3+IIeUgwtZ0RPchNZRGIrVB3QZ5k5oUJtmZe7ayPmckWY6vgDQwhNsKYwet3LEu3RoDZmFRxc6O
 Ulcs0uVhwQYYnrgTBt2u3zDTuXDxjQ8atzPrSuKLYvWjEMQcXvOq0sX77uurGvskgk+g/fmUtOu
 HfmBJKP5xxh2YCKxI0rfz/j4bzSqT3hto0QLumegf7ICdV7B+h7BxXaQsPYKULpXbZWgwr14ZjA
 5f0vJThCx+grRi3BPdIfhcd3BsYrcEKm8T5VUQvT1s8KtwR/En719KsEnIawDIfCAC6fme+ji39
 +EFUJB+jcPU4fh3AcMPpgbwHiok7gJS0XU3w0bd3OeB42/N5tF+mdG+On+WF7GkMX7oXSxfOBY8
 xWXgGEjMmTjPdh1im8PhJMBrF55WMuJIpXXidxoEic0q90Js9mlJsbB/GQ0ezTeJR05r0/+h6fo
 dUW6lXJevucchL0arzAqukqPWHZBJgp2xx415MFZ8EtoUPeOksNPFYd/PF9dvKjNKIYS9KLQYKG
 zmpFhnn+Xb2no9UKnxbsbCqOFrOz+Hv6fDF2CvLMm//r9VtFF7F+JjiNJAXt0R8wm41egewrsBg
 eUBSJIsYNN3VS2w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Mark local static 'struct regmap_config' as const for safer and more
obvious code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


