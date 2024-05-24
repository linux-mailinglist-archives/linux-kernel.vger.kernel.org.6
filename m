Return-Path: <linux-kernel+bounces-189006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CA78CE9E2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5F21F234C5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2275812DDB5;
	Fri, 24 May 2024 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="Qrxzx9gt"
Received: from mail-wm1-f97.google.com (mail-wm1-f97.google.com [209.85.128.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AA03F9D9
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575284; cv=none; b=hS1Y+1jtvgozbrwNM0HZotoOTeB/4pGJO55brGSWozEj2gstxlLiWcdL9VBQIWbi+/WJtl+O7dAUlfr/DCNj1ES+8lJjZlBQ9Znn6CBQUPA8TxgzxpEbTpuorRWtSryu5SXE5ZiTYTa1eDPuASt23e7Y85qzz6ExzHj9Asn6ft8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575284; c=relaxed/simple;
	bh=NmaIHsHw8WolTjTf8xLqs7ZWhcp53cyRuvb7LqWTrw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZEJf7VnxDUBGPdajQO5mJRj94/hPO+6LLQbN8pmYtvXG4MasfZViXnWkZGqgC6V1E3dA8kds9/U80O920YgmTOuuJXu1IDnqAPB6YOIQ6dzFdt7+TsZHoGuml3luyy86qjlQ6fsuznDCdgYCVinZSVFyoTLFf5NCf3YrV2Ki3g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=Qrxzx9gt; arc=none smtp.client-ip=209.85.128.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f97.google.com with SMTP id 5b1f17b1804b1-4210aa012e5so6627365e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 11:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575278; x=1717180078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLyqz2osfPGnGJK1wbt1y32SqdJNw076C0yH+gVvyYs=;
        b=Qrxzx9gtMDKHLIZIQJUmDluCjQuFlZQ0MtAqoV+lpT+iCJJlTGMa6vnTy198ctxZch
         Wt6yqf+ycRZ5DiP69H3WlPwrNhzCy6Fr9UqQb+ogjWFdrnAu6D2Oao5BpsFop+gK8sRe
         OA0KdggaWUnJ0Xp4lBlQ2sVGrZgLhJBG7Li+/Hm0Hbe615zu5UXT5jkQHGB+n0aWxGmt
         O1yVgckM7WHthqBK6QvREuS5c/ZjdTOF+O/VT3d3q4UApXjd2JNHYXKzOGo3f+g3L6Fo
         eql+wd2bUuQrm+JgKq6PEdvJtP/hy9A8ZLFjFWeJ8YdTqIcJHW90XLaSlkqM1AA+qMGA
         xBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575278; x=1717180078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLyqz2osfPGnGJK1wbt1y32SqdJNw076C0yH+gVvyYs=;
        b=UB21mvH9UgBECFbgzkWqjvHyXb73dVpC/zs+SqZvqlQpwBH+NlwluDqAWJImZNK0av
         W9fUBJh5/3Kii/tbrAL9v8iRzf/Kb8ZkZ2edDlg2k3DlLE8T4QeXexNvVB2X+vil8TWl
         Lbm5hkll+cAWRI2rQXLV7qAuovMlPefbU4vzv9M+ryuIHzTOvx7OyxlspT4Q5FiNIchU
         NqXtIRbn1ZKurwVEjEJbgjvuKaxFhWGqBmVzRejo2poFhOEKxvYvIsXkYGWOqis4gmPN
         gkoHyVjENcz92JkM5yUa7/sRG+p95+ln3yV5SIvBN5ghGqg/yULo5zJ/GBzr1lMZ5ihL
         gIHA==
X-Forwarded-Encrypted: i=1; AJvYcCVJF4X1a7DMek1xfAG3NGEc+uaOUddOTQc8pkKtAwfscBHRp9XxKLeRDbuYE3XtWDUiHDE9cj4+tZ6MW8HIMsxa280BuXgXhpfPXDJs
X-Gm-Message-State: AOJu0YzGeF1GZp/LKT5OTGDCUtgVlZ6pMo8eqMsWE70IK1kylVlvkEXq
	C7smWx7/LgmxSUhudqUeMQz3CGQKWyOk/Z4vgsVrsyEm9uvhLLFUXIUa0g2TkS9T0LPZEc8n5ha
	qLMPKJoqjH5yXpoDtOUv7/KfHBT+gkRtX
X-Google-Smtp-Source: AGHT+IHZyoYiw+ZfDDIW+lJcq4U5OZo2v43Ubu3YaXBugY/8GE8OzbxogUWp09sQZEXs2xF6wDmcdkXhQP7U
X-Received: by 2002:a05:600c:548f:b0:418:c1a3:8521 with SMTP id 5b1f17b1804b1-42108aa8866mr22319455e9.26.1716575277729;
        Fri, 24 May 2024 11:27:57 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-42100fa9be9sm5432805e9.40.2024.05.24.11.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:27:57 -0700 (PDT)
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
Subject: [PATCH 11/18] dmaengine: bcm2835: Use dma_map_resource to map addresses
Date: Fri, 24 May 2024 19:26:55 +0100
Message-Id: <20240524182702.1317935-12-dave.stevenson@raspberrypi.com>
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

There is a need to account for dma-ranges and iommus in the
dma mapping process, and the public API for handling that is
dma_map_resource.

Add support for mapping addresses to the DMA driver.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/dma/bcm2835-dma.c | 46 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 9531c0b82071..e48008b06716 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -67,6 +67,10 @@ struct bcm2835_cb_entry {
 
 struct bcm2835_dma_chan_map {
 	dma_addr_t addr;
+	enum dma_data_direction dir;
+
+	phys_addr_t slave_addr;
+	unsigned int xfer_size;
 };
 
 struct bcm2835_chan {
@@ -294,12 +298,44 @@ static int bcm2835_dma_map_slave_addr(struct dma_chan *chan,
 		return 0;
 	}
 
-	/*
-	 * This path will be updated to handle new clients, but currently should
-	 * never be used.
-	 */
+	if (dev_size != DMA_SLAVE_BUSWIDTH_4_BYTES)
+		return -EIO;
+
+	/* Reuse current map if possible. */
+	if (dev_addr == map->slave_addr &&
+	    dev_size == map->xfer_size &&
+	    dev_dir == map->dir)
+		return 0;
+
+	/* Remove old mapping if present. */
+	if (map->xfer_size) {
+		dev_dbg(chan->device->dev, "chan: unmap %zx@%pap to %pad dir: %s\n",
+			dev_size, &dev_addr, &map->addr,
+			dev_dir == DMA_TO_DEVICE ? "DMA_TO_DEVICE" : "DMA_FROM_DEVICE");
+		dma_unmap_resource(chan->device->dev, map->addr,
+				   map->xfer_size, map->dir, 0);
+	}
+	map->xfer_size = 0;
 
-	return -EINVAL;
+	/* Create new slave address map. */
+	map->addr = dma_map_resource(chan->device->dev, dev_addr, dev_size,
+				     dev_dir, 0);
+
+	if (dma_mapping_error(chan->device->dev, map->addr)) {
+		dev_err(chan->device->dev, "chan: failed to map %zx@%pap",
+			dev_size, &dev_addr);
+		return -EIO;
+	}
+
+	dev_dbg(chan->device->dev, "chan: map %zx@%pap to %pad dir: %s\n",
+		dev_size, &dev_addr, &map->addr,
+		dev_dir == DMA_TO_DEVICE ? "DMA_TO_DEVICE" : "DMA_FROM_DEVICE");
+
+	map->slave_addr = dev_addr;
+	map->xfer_size = dev_size;
+	map->dir = dev_dir;
+
+	return 0;
 }
 
 static void bcm2835_dma_free_cb_chain(struct bcm2835_desc *desc)
-- 
2.34.1


