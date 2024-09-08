Return-Path: <linux-kernel+bounces-320260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5647F970819
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D51FA1F21DA9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4628A170A20;
	Sun,  8 Sep 2024 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G+lF6toq"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC296134AC
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725805310; cv=none; b=dN5CUw/jwfj9R69QOqNfRL4zSZp//k5/GXhfZsyEUmuL/rFn3S8cPWYmcMmPYcU0j9eXpi4e81w1yikefX2gdpNcQub/MekTB0qQyl90+FvL1wTe0cUR8LNzPKtUurJBdnY74RiJ1mNvy0MjWtZRvCJYRTM1uERWCJEKbKZBdRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725805310; c=relaxed/simple;
	bh=cTToaTVq2mBf2Fn9C8i98ir1v99mJbXz1+GQpR3uiOI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OOua62ThHiIy6ukc7Gruo5RSgTAz6anphk+gYg0ZZ+O9Cas1MKAaSFtTahMHdry5iQ943ZTCDqLOnklu8qamHnzRFHpp3vvLzMfvu+b3iNSiPqOyd3rBXzoztBWXr/fnktZUMdz0aS/0hZG4W2fk7uSBBS2KojZlCj43v/6sC3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G+lF6toq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42ca802545aso2815705e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 07:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725805307; x=1726410107; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tqwhJtSpVBRE2P+yWS/8hgOJL8h+VSv3t9HsbyQZCr0=;
        b=G+lF6toqndvPd9aK5XImfNgj57DQhup5Cp+SaX8csunYAmeqEClckG07XRXlVJltcX
         FAfQOihaiJJ9ARMY+CuoAZ5ut/WXE1AtmExbcByGkDNC6D2peJfrLqYIphMXzLoJPFrG
         Qr2wn+oXB8MaF8usu6RJQDvjHouid31r8JJLyIWJMFiU5oLdE8J/TcDZWMf17bLm53ec
         qVg+lW2E3BmrtrnL3hAnzQXwyC1V2NzVIwf3bZmI/FrcLizDzTBQzwsMPU8TBb4Dk/m7
         P+GjpuSPs/l198lh91HTmX0ax7nIfop9ETSktplvXx5/jUs4v9LR21SkH/6TSCnhXx4x
         uK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725805307; x=1726410107;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tqwhJtSpVBRE2P+yWS/8hgOJL8h+VSv3t9HsbyQZCr0=;
        b=Kxyv/VTZ5Mzb+o9rJiNkWCcZQmS1+AY5aROGWoe9gQrp1CSzzZrODObyDEgd+pZCHv
         JD1UQdDkcXW03zlUjnMhBPKvvdHYXUi3velX9u3NhsCj7zU6KEbe4aEZBYX1dAjscmfJ
         5lof6NbrEjNFtsGuTESEiZBcaAdmfqZ56azwFWmaEbxfACR6BDAbNdjchlyAYMQxDCyw
         qo+WJoiIcSCiKSdLMd6pDZRXfm1zsrVU/rj0fOshq3zQKHMmYoPmN0qtFzcQSGppfdtH
         dnteP85tnLOwvw1ZIc0d1k5p5BentDcxXiL4QJGpUY3SZr3QLHz9jArfM5wUkWX5kMGq
         a+oQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8Q4h33G7t7Y7RomidRqXVjDEtLJlQGsVFjWScC5is2ktM0JHz8aAgE67erLYXdvdz1hQLZl7d6VZfSQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIkLsK/gn5A/FttlLj0htoIXdgVlVsSpddWFbCpTN2F83ngVxm
	BV77TTbFMEKKX5zAjHtY0odV8H7Hj/6x1MmZEmpXzqxxOl5o1v4L8MDwuX2/frY=
X-Google-Smtp-Source: AGHT+IG9ZRq/DMRhNGgXiF+TDH9JtKI9MBZDNIgFAd+SfH8Xnqjsitbh2pFtDM7PPUl5w/VKJP4Lag==
X-Received: by 2002:a5d:64e5:0:b0:374:cef0:fd46 with SMTP id ffacd0b85a97d-3788964fa72mr2863505f8f.5.1725805305990;
        Sun, 08 Sep 2024 07:21:45 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675bc9sm3465092f8f.56.2024.09.08.07.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 07:21:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/5] drm: misc: few simple cleanups
Date: Sun, 08 Sep 2024 16:21:30 +0200
Message-Id: <20240908-regmap-config-const-v1-0-28f349004811@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOqy3WYC/x2MQQqAIBAAvxJ7TlCJsL4SHdRW20MqGhFIf886D
 XOYqVAwExaYuwoZLyoUQxPRd2B3HTwy2pqD5HLgE1csoz90YjYGR/5DOZk0Iwo5OjTKQCtTRkf
 3f13W53kBHBWAnmUAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=839;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=cTToaTVq2mBf2Fn9C8i98ir1v99mJbXz1+GQpR3uiOI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBm3bLvNFcaXf8SGW37AV8bPzrMpFogzThXLLuQG
 l+3znii392JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZt2y7wAKCRDBN2bmhouD
 12t0D/oCKBiGiFWPFsnvZbBBzS6lfNLS6Y9kmHg76mabyuHNJMF0vh1D359N4I6rnoOl0eLvI5O
 zzML2lKr9W9iodldL+NGvVQky/fuNnciPMFuiVmyiSUprJ8GbdpaFqoqZurKI18YJm7utqyRo5y
 oVfj2W2DxvKnL0fKgIHnpNTlvHunHINm0Q+5tJtb4WGdi5ccjJm7NP1lOwtbkyrRYZpVM1g5d2R
 ZYKKNey8wi0sWZMr0eI1XRsstmm5oBFK5V1kA2ShdX9B8IRePN/vxpkRZynbDx80HJpnYRCdfMX
 TS/gKTYUxj9xnpdTiaGx2K9pE9eRVVrv8FWBRYnq+PfxRtyK/b4/++or0Ib3763JRCQUTI6KMyG
 +Y9HYhCTjKq0dH72Ur2Id8SWOjrbyCTGAZqdLoQ1rZStOx3KxQE4qjKmIXaqnzwLP4vdy0UYTuC
 Y3TKFIhmMkAasktectjZjE6zcYluKkyyYghp3hKRIbYwuPOgKEjzDXH75nUHHyKLgnjxVIEPbNu
 X8LRB+WxdcYJJ7aLwXvbeTz2zvnEgFIudoJPQA+grpjUsPnWelYqnK6WeJsKKP9RAl7uqi6Cr7O
 jfzM1A05b9FHTIW+dNNbkZOafygeEjHY8eQ0tGoMb9RAA6SywaWmJHtNuRPSpGTZdy3R2VW1/OD
 g1bC0WL8WXxTFKw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

No dependencies, trivial patches.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (5):
      drm/meson: drop unused staitc dw_hdmi_dwc_write_bits
      drm/meson: constify regmap_config
      drm/fsl-dcu: constify regmap_config
      drm/mediatek: dp: constify regmap_config
      drm/bridge: ti-dlpc3433: constify regmap_config

 drivers/gpu/drm/bridge/ti-dlpc3433.c  |  2 +-
 drivers/gpu/drm/fsl-dcu/fsl_tcon.c    |  2 +-
 drivers/gpu/drm/mediatek/mtk_dp.c     |  2 +-
 drivers/gpu/drm/meson/meson_drv.c     |  2 +-
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 14 --------------
 5 files changed, 4 insertions(+), 18 deletions(-)
---
base-commit: ad40aff1edffeccc412cde93894196dca7bc739e
change-id: 20240908-regmap-config-const-2b6e126feb8b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


