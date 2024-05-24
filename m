Return-Path: <linux-kernel+bounces-189013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A665B8CE9EC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2331F244C1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68D013118D;
	Fri, 24 May 2024 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="l0IgCMzK"
Received: from mail-wm1-f99.google.com (mail-wm1-f99.google.com [209.85.128.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246BE57CB8
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575291; cv=none; b=u70DqT/Izrbn5QH1b/AsYyxSNvfdzRLantQGmxL7KFCfmaRV81cRujyZtIvTKppMJIFC7MR7fTKTWY77cb5DzHJiZN/XxkEfvS6Ie4wGDGtyNhlqaKL+6XzxTWM3fGLKuiynK3qcG77+lamuUAZAgeeQcP8OJCdgrzgtX9yo2KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575291; c=relaxed/simple;
	bh=WfcHrNiYZ1rUh5ZyFbpbA7wYQtF/ZVKkB0GXxiX6I+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m2h1/groujMULQweL/VNBxIG7TCMYZ56LcwIqhZ6z3vN7qwASRCnTbAoqs5ddFJgu+56fNGFfhQ2o2YeznJfZaPoRbNV5vSlKY00/zSSxqjc/BAMY0ZK1Sudt8UGzvld/UgCbro4AfXM70a3LdK/eIr8k0hBjZv547NSEL7fchs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=l0IgCMzK; arc=none smtp.client-ip=209.85.128.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f99.google.com with SMTP id 5b1f17b1804b1-420180b5922so41045235e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 11:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575281; x=1717180081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0fkVyk6q1d4tTjNi28+nVqK2ri87Lnbs7bXh9cTiug=;
        b=l0IgCMzKayqPSpiSaOfEjaUxi7Xb5gpOxwaSeJeBQW4L4hUjXABzfWycLEL/u5Dq7t
         gu7ojxEmvGT6eeV2pCKUlRGjiGIuh4uJktn1c51/v726sTlmuji08gdJGt3yYLevm/59
         gqvcaQh2knAcmzejRhAtS0yk8M4cbOkqS9rFNVPBDc//B7E+b2eaTJTTBIg8SMFSkIA9
         06hbrAC/6JviK3Np2dd+FTYCEl168sR2y7TgDVDc4Lc1Xd+GlfnTbQbcXeZR0ifxM9rv
         DD4QIDmwMRLiZE7rY3i8NkR2gyCcfPK9Dd97mbkP1SIfBlI1UxzBez5y8bRTMmj2FCEa
         W4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575281; x=1717180081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0fkVyk6q1d4tTjNi28+nVqK2ri87Lnbs7bXh9cTiug=;
        b=xBn7iPPRphHj4Jem+AaLqnK0xnQyGp+YylknkHLckd6XptPU7oYzpK2rFaNSGRMIqd
         Hf8+2ap/CfbZmjQRkzttgiGJVocMSt08UkaEZ3fNF28jeeJ9MWxrDUzduoGV4r39yNGz
         90Wdl31ViQt72PANHwkRvfCIKmqLuYSMX8RLl8GLQ1CICUZkxK7ZXHawi0SBG1znS9jU
         +3ye34/duevs5lyxeAgh6JCyhl0ucRpv24H57YYQvqMJz2SmE4B+lZQLIUOgdJnv/AY5
         TzcIvF9qOQBaTRy818Qh0YioeL81eg3EkE4Ry4+t16YJe5FYTJuzrwzGn4CTnOdRFcP+
         4xww==
X-Forwarded-Encrypted: i=1; AJvYcCVOL5SBLa1ZokcjqSPHO/znsI5eKnyWXIwWl+1opTfWI2jgtsq68fc1Z6QUYhnkvrUq4C2HvfwO0fP/ZtZAnPgFuNpya+Jrekwat1g4
X-Gm-Message-State: AOJu0Yyv/Oi23qyiUgJPccCV4TvhmL7AiHNlPN/iPdiZjt2APX57k4E4
	YLb70I8kvWgplJ/nlm2slq0Wm8yHS5SAzH2P4685ffsQwNrtu4eqKaJc6jc+6qrjJ9NvpOJKz+q
	79onicTB5nWHRp/VKnKaEtRJTN8/SSksO
X-Google-Smtp-Source: AGHT+IGBxnWkfl21ZWcAGGbY9pK5CCtvRZEInE2s9wbG2L53cMYgxcodxHXuIlPQ/f02qRVKa1ge9AFPlvFh
X-Received: by 2002:a05:600c:3152:b0:421:757:4d3e with SMTP id 5b1f17b1804b1-42108a40f7emr33721035e9.16.1716575280608;
        Fri, 24 May 2024 11:28:00 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-42100fb1394sm5457725e9.43.2024.05.24.11.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:28:00 -0700 (PDT)
X-Relaying-Domain: raspberrypi.com
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-mmc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-sound@vger.kernel.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH 16/18] drm/vc4: Use phys addresses for slave DMA config
Date: Fri, 24 May 2024 19:27:00 +0100
Message-Id: <20240524182702.1317935-17-dave.stevenson@raspberrypi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
References: <20240524182702.1317935-1-dave.stevenson@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phil Elwell <phil@raspberrypi.com>

Slave addresses for DMA are meant to be supplied as physical addresses
(contrary to what struct snd_dmaengine_dai_dma_data does).

Signed-off-by: Phil Elwell <phil@raspberrypi.com>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index d30f8e8e8967..c2afd72bd96e 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -2696,7 +2696,7 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 	struct snd_soc_card *card = &vc4_hdmi->audio.card;
 	struct device *dev = &vc4_hdmi->pdev->dev;
 	struct platform_device *codec_pdev;
-	const __be32 *addr;
+	struct resource *iomem;
 	int index, len;
 	int ret;
 
@@ -2732,22 +2732,15 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 	}
 
 	/*
-	 * Get the physical address of VC4_HD_MAI_DATA. We need to retrieve
-	 * the bus address specified in the DT, because the physical address
-	 * (the one returned by platform_get_resource()) is not appropriate
-	 * for DMA transfers.
-	 * This VC/MMU should probably be exposed to avoid this kind of hacks.
+	 * Get the physical address of VC4_HD_MAI_DATA.
 	 */
 	index = of_property_match_string(dev->of_node, "reg-names", "hd");
 	/* Before BCM2711, we don't have a named register range */
 	if (index < 0)
 		index = 1;
+	iomem = platform_get_resource(vc4_hdmi->pdev, IORESOURCE_MEM, index);
 
-	addr = of_get_address(dev->of_node, index, NULL, NULL);
-	if (!addr)
-		return -EINVAL;
-
-	vc4_hdmi->audio.dma_data.addr = be32_to_cpup(addr) + mai_data->offset;
+	vc4_hdmi->audio.dma_data.addr = iomem->start + mai_data->offset;
 	vc4_hdmi->audio.dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	vc4_hdmi->audio.dma_data.maxburst = 2;
 
-- 
2.34.1


