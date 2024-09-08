Return-Path: <linux-kernel+bounces-320262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F22E97081E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BCB41F21D20
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D637C17278D;
	Sun,  8 Sep 2024 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VStpNEui"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96708171089
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725805314; cv=none; b=I88WII2RWyVk0NegdwG984T6XeLTIDJYijXVXcUc4j/uYJ91bLn4VS+uNY/cKZYdOI6k4tCjnuZs3AyY8EzuAicwjk0r/D6F7rs8TPJDH7uA++nPfdPQ4U2uQGNlFBd8sjNzZlFsfy0Dywk7PzYgiL9SlGtSJeFvalq4LPTG3WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725805314; c=relaxed/simple;
	bh=aPIjI3wvog8RSD6EiSqaW+WBy8gBpWkoykw90m+N8VY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ss208k8BLZV7Fvo/VtfsHm+xfSdsTpQxa7jrcdO5chbvgJ/uiE8dZWkv9VlLsw4xu48REZCd6QTRfkX/JfYl3fPw0n/FfVTIUVw4RVn7/ABLA/JqXQIoAVjejWccWnL9KFmJSSSGaX4MJP7KBMEuItVzs1AGmlbxv9yjNqyP7io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VStpNEui; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cae563348so1906105e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725805311; x=1726410111; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HvzK9QbnMsy2ymdJa9zUCc35kOJVXO+e6EJ8AnZPJwM=;
        b=VStpNEuiA5YkxWKV+Grqy7oYRrYvv6kTHyqmAyG1OlgHbfiyYx9mUEyxIrcQbleGdx
         pwVixpOaEl1MbIm8LRvLoFVNFNJxxk4TuShx+dj3ZLhfYJ8LXWlJ0GWJqIast4tYSsWh
         UGxidR+rVYgYGBbse+3olvzjJcyU3bZeqLGagdxde2zYtzQSW6RNFli8chC0u8aKLCGn
         2n2zmS/cz2Uv6641NKFf5A32DGiBmTUqYF3MQvurpotfCjLn7XoMfaSyqj9OOv2qxQgH
         bR1uGunhaW+rtgPwXgEvpzYr6dPfp4ERA0CY5auDViFtAMmga234nfUYfeXGY4ZfQene
         XYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725805311; x=1726410111;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvzK9QbnMsy2ymdJa9zUCc35kOJVXO+e6EJ8AnZPJwM=;
        b=upsmqNIZNdzAc9esegcu6ttwO6FDSyF8EGJt4iXabR+JX+nneHDnSbxKS2knzqOkqH
         2igYpiehuod1rRU2qtX9Or7aRnrw8NCvuW9pd30YT+RuB/CwMx984fjdNIMDCwW1FwZb
         cDuGwe1iOE4x+CTxcZU620to/uakrNahTvdO5piqUrQvcCG6iQuznfZ1bmheQPorCgQo
         TYBZXqylxd6P4TMtMGp73YWusbjaHEZbD0fEnsrqQwu1btdpQGQ+Saz01/gKIimvSLU7
         8gfi2gdtUTj8Jl1roRW0rJb35OhNtUVcwLm3g1nMuLP0xqp27qusUdPES7b885wV1SND
         e98g==
X-Forwarded-Encrypted: i=1; AJvYcCVLi5G1B2pOEchBB4Pw7SdgRGICakOEzodFRaYGEtbtTK8pUvUPclc+aXCcdflNk6+9hsJHR/NGZ+87Fdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLH2O1pz06r3H7H3x2kIoFr1tsHFIah+ZBTJJHLJPYz1ndsZG6
	JIanoIrvO298MoZF1n+1zJMSOKjdYrQFxh6Uj1WZn8jcaMGiwnZUXn+GEZtEIMQ=
X-Google-Smtp-Source: AGHT+IFGkCKTBZFIvwjzPmyy0UxMVxAvqoCnC4DEkYoje5P7hwJW0E6txtMBs/tVw5PKSAk1OLHtoQ==
X-Received: by 2002:a5d:598c:0:b0:378:9560:32f with SMTP id ffacd0b85a97d-3789560049bmr1143708f8f.12.1725805310725;
        Sun, 08 Sep 2024 07:21:50 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675bc9sm3465092f8f.56.2024.09.08.07.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 07:21:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 08 Sep 2024 16:21:32 +0200
Subject: [PATCH 2/5] drm/meson: constify regmap_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240908-regmap-config-const-v1-2-28f349004811@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=776;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=aPIjI3wvog8RSD6EiSqaW+WBy8gBpWkoykw90m+N8VY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBm3bL0T6C6l0T+jasscr2GbjpaQ6wcbyWT35jQc
 Va62zQLwNOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZt2y9AAKCRDBN2bmhouD
 1/0DD/9l6CzinqqFZnvJrhrKjqaSkq5E45kzLhr5PHD/mkCKkD0YY+T84/txfFf6/AaEP/HodmP
 78HhSeHWNPcjWpnxhaRVW3IbwBdX2aFF3BW+2zQ1R/y2F+Jnz6FxpsUuuUljHW2p050ebNx9x/7
 zHQg7WBZPrCGzFSBzDmEGmZvGPfnQYBtODxdINnnoSMRDR4jdbfyXKZq7MMKkdcgBSF6w+1rGp3
 JijCE1endeNXX7boyGXcRaPvGd6NyeeXqwjq2UbzV4NQdccHpQvAxPqhuLsh2+tT53bvTeqXB2A
 jLYI3MzrcVxhUsYstfk2+KtczefK237WvepVp0agYSsV0fWeu4dhhjfpdjzNqXdbkBKdFzdER6b
 IzbEI9wKEN2j66N32zv9zDouDzI8413GbVHRo6DsRQ49rKInBpthEx1mdvklnkPbGLyVrMkflM3
 JGhj7U7GJLZquuk2dLqCQyoSfWnQMRWMQCJ3DBRmhsKLeYOe3jtQvgwxJL8wHmPlqGq+eQwzgrJ
 drJS/MmBSCJOhUk0IqcXBeKumH5sF4VQY3ea9su0SfPWijaHAaZBZvjM/qDhnOtxZB048N5EJhZ
 MjGGdoBwWnh/NeQ74ple37I5eEF0/6l3V82Qs0HJ+mEM9MLVmHcOuTxPeR28pOP5KrThISJF+w6
 gV3tP7nWzxcLwlA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Mark local static 'struct regmap_config' as const for safer and more
obvious code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


