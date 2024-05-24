Return-Path: <linux-kernel+bounces-189000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8BF8CE9DC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69D6A1F2338E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6214086245;
	Fri, 24 May 2024 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="KelZL+Nx"
Received: from mail-wm1-f100.google.com (mail-wm1-f100.google.com [209.85.128.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC12240861
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575280; cv=none; b=C5qFLedjHvbCEewzuTUvKgx/jnCLSSLrCgz/8uoJs4sZCXVcXYftwxahJTZ+gjR6Vcvehu4KgqRtpHU93ksEDKGQd9BtACB0ebPXgTse76tX+H5WprSMdgwYRMe0EzAqIbR31RTYAUnI2l4R98Nox8ErLaffpQSkSzrxr5Nt83E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575280; c=relaxed/simple;
	bh=uJR9uKYukjwMUHwhOo3zWcIKx8YU7Uzest2LYe4K6KI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uksGH5yGEhkuASDs6rZFRRCSc43U9dl8+m+4v5+8pXqDQP0pThKMm/uEtdd2HRcW5loIUigpfYEZssGyTS1J+7+14KoQhKidQjgMI2AHUVNsuMuM2jP79gAhnZ1DHI+7J2QmvTIrYoyU2+d4O+6OTDStr3ueBrKus5VDhhgSqAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=KelZL+Nx; arc=none smtp.client-ip=209.85.128.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f100.google.com with SMTP id 5b1f17b1804b1-42101a2ac2cso20612515e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 11:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575274; x=1717180074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWDOi4FnuIg8+afcsNOQvw2Jh+B2uESuovEt5c+znUw=;
        b=KelZL+NxJWXtNt1p5TObgeYeTIYe/fqNpTUxhf8qeRC/yWBeBez5iBn6uXJBJ43U7u
         dtHcMZg/CAs7F9+mWArEWGUsKY3LxvGVx1eGZn/8ZJI1A4JAGB9uA01FbQGD2SXy9QA4
         Q5EcuvMJf7PvDGqmeRg93i93r5+6ph5d9sBIay+B9DZuTKbRpdSt4OKv0OxyEkqi1Nr8
         4EJdXAJ+4WW8HMyeuKOZR11SgP2T3g9mKEQTteb3+m25rsnjhrgQ5mIjdEs3w7PTJ2w9
         md3vwFFld2ioevQ2Yx/dgbI2EhOdQjMZ2wyyFuYXGZD4aT3nJFHbWUoshbtItGK7lCku
         BR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575274; x=1717180074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWDOi4FnuIg8+afcsNOQvw2Jh+B2uESuovEt5c+znUw=;
        b=wsEpcHtliwIRLl8n2Qd57PlZz59rEeK+k1BcsqgYHm3hNNkbadQqRd+iwWeQMaRrtg
         KB0MY2PRJl2x7doUzBioYIejLSvPcPoVPakp2zPVNgQC5Lpri8lukTKtNLN+g+cL83ER
         Ea9drc5iLqrfKgAO5R7hwOz3mRTPYrpEIfp1PAKknfP7M5wrtFR/SxczeCuIKadLojQc
         7c+R4Hqv5bq27fA2lJXIJgnXUIdrPZFdVEW30dtS3ywB2wxWokc+CERIHltA1FLTUacp
         d0UOjTNmfj47NeiF/IRgSztgWeF9hMXwjr3cp74H3yNvKYWr2ySqieiqOLj5idJB60e2
         3nEg==
X-Forwarded-Encrypted: i=1; AJvYcCWx135xW5g/VOfD4cJQlbDLa6p6N4LQe51SxZ5mX5EAVuYlg+Gut02/46Wneq8tlf+riY34If1DfaG/iUWjC3hw6sTsVUg0T44P0+bj
X-Gm-Message-State: AOJu0YwGCQcGVUtLtC7n0ysXmTIX6xa0lfSkKeG5G7v2/svqN151UygV
	swBydImbk1OFOlm1MlIh+98b0lruwcm+/iZerY8pGkBHyyjHL6vKoeSuouTYxfw3SngtVlwMvq3
	8hGQ5LCrnjQlHfiNrnumXSqhk2P92ZPno
X-Google-Smtp-Source: AGHT+IGIsyeooWRqeftH29E3jxJT2At/nTJ1Uu/BdgAMBJJVRNDQOp3tq7uahyaHfy6aSgJSk6q/Wsrk7a1Y
X-Received: by 2002:a05:600c:314c:b0:41c:5eb:4f8f with SMTP id 5b1f17b1804b1-421089d7c33mr24729315e9.15.1716575273960;
        Fri, 24 May 2024 11:27:53 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-42100eeb86fsm5721785e9.4.2024.05.24.11.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:27:53 -0700 (PDT)
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
	Stefan Wahren <stefan.wahren@i2se.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: [PATCH 05/18] dmaengine: bcm2835: move CB final extra info generation into function
Date: Fri, 24 May 2024 19:26:49 +0100
Message-Id: <20240524182702.1317935-6-dave.stevenson@raspberrypi.com>
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

From: Stefan Wahren <stefan.wahren@i2se.com>

Similar to the info generation, generate the final extra info with a
separate function. This is necessary to introduce other platforms
with different info bits.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/dma/bcm2835-dma.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 7cef7ff89575..ef452ebb3c15 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -229,6 +229,29 @@ static u32 bcm2835_dma_prepare_cb_info(struct bcm2835_chan *c,
 	return result;
 }
 
+static u32 bcm2835_dma_prepare_cb_extra(struct bcm2835_chan *c,
+					enum dma_transfer_direction direction,
+					bool cyclic, bool final,
+					unsigned long flags)
+{
+	u32 result = 0;
+
+	if (cyclic) {
+		if (flags & DMA_PREP_INTERRUPT)
+			result |= BCM2835_DMA_INT_EN;
+	} else {
+		if (!final)
+			return 0;
+
+		result |= BCM2835_DMA_INT_EN;
+
+		if (direction == DMA_MEM_TO_MEM)
+			result |= BCM2835_DMA_WAIT_RESP;
+	}
+
+	return result;
+}
+
 static void bcm2835_dma_free_cb_chain(struct bcm2835_desc *desc)
 {
 	size_t i;
@@ -644,7 +667,8 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_memcpy(
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	struct bcm2835_desc *d;
 	u32 info = bcm2835_dma_prepare_cb_info(c, DMA_MEM_TO_MEM, false);
-	u32 extra = BCM2835_DMA_INT_EN | BCM2835_DMA_WAIT_RESP;
+	u32 extra = bcm2835_dma_prepare_cb_extra(c, DMA_MEM_TO_MEM, false,
+						 true, 0);
 	size_t max_len = bcm2835_dma_max_frame_length(c);
 	size_t frames;
 
@@ -675,7 +699,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_slave_sg(
 	struct bcm2835_desc *d;
 	dma_addr_t src = 0, dst = 0;
 	u32 info = bcm2835_dma_prepare_cb_info(c, direction, false);
-	u32 extra = BCM2835_DMA_INT_EN;
+	u32 extra = bcm2835_dma_prepare_cb_extra(c, direction, false, true, 0);
 	size_t frames;
 
 	if (!is_slave_direction(direction)) {
@@ -723,7 +747,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 	dma_addr_t src, dst;
 	u32 info = bcm2835_dma_prepare_cb_info(c, direction,
 					       buf_addr == od->zero_page);
-	u32 extra = 0;
+	u32 extra = bcm2835_dma_prepare_cb_extra(c, direction, true, true, 0);
 	size_t max_len = bcm2835_dma_max_frame_length(c);
 	size_t frames;
 
@@ -739,9 +763,7 @@ static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 		return NULL;
 	}
 
-	if (flags & DMA_PREP_INTERRUPT)
-		extra |= BCM2835_DMA_INT_EN;
-	else
+	if (!(flags & DMA_PREP_INTERRUPT))
 		period_len = buf_len;
 
 	/*
-- 
2.34.1


