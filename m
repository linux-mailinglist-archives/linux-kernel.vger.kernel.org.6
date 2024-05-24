Return-Path: <linux-kernel+bounces-189010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D5B8CE9E8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F611C2294E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6764F130E39;
	Fri, 24 May 2024 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="lfEYg52p"
Received: from mail-wm1-f97.google.com (mail-wm1-f97.google.com [209.85.128.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504EC4EB3C
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716575289; cv=none; b=rhYKl24FXFt4s6oN4Bt0Lx1VQ3DmMaG7y1lvorP+tQ4+aZpfwlVtdlseRSa2akDZAFYpDTzreD/RVHPLi25X5Uop67a26Ss6uLp7vDpIpRmLyGyHww4Lsfp/Fo7bFD4uX4rvg7fP4IC1GE4QUelIMRX1Eq0VpJrDnFpTOZuEolM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716575289; c=relaxed/simple;
	bh=vAXHDE0/SqkQsUMGiVCRffAB088Mi79YDBrfTqisc/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YycS6hyHDqyCBh57hnDezhby7zE9d17QlfIcpyp+Q+SDD9ubawJ9C6qO3An5w+WHoGMIFE4EhgxCsMq68asx4D7aAhnwMgsykxXuqJv4s+gT1y9bPQ2ONAb01hhmVYuPbT8Y7j1+IAz2bqTrgh66LX8DT/8wKAdTPbqjFZbpb08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=lfEYg52p; arc=none smtp.client-ip=209.85.128.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f97.google.com with SMTP id 5b1f17b1804b1-421087b6f3fso11220085e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 11:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1716575278; x=1717180078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LczGECRfXrurv9dI4g4iDY7uh7b4Krp6PtWjBnzvVYI=;
        b=lfEYg52pyu+DKsD80EA7rNZ2YDy7brFQQ1vMXAb1docWr7tuY1IgRRqSq5MT4QWp0P
         sgwiBC90cJ4/L6vugOJxWR0YJO+PP5niD7GiJpqWSLeyW20FOtsPtVk8CPck5MnCpKJh
         DeD1nf2R/CAuWqwhVsJtFCSHgNACajOGFjWIx30547WdOSe6frg6fMruNgUlfWwNuZMo
         nDffxv+b3+/z9TwG3h8mjVLJSpvQai77nfpxJEdD6RvTl1qoU0pxGe8fsFYo3LWfFPrL
         SGVs0gTCyCsT2qPPuxclMo3AEatxcJ7PWRRSSeWTi9g9tEkocdzYubTwdkoOmFkcDbxX
         Y2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716575278; x=1717180078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LczGECRfXrurv9dI4g4iDY7uh7b4Krp6PtWjBnzvVYI=;
        b=QGJDls/0gkaK4paNVZbhW3hj+ViKAfBw0OYmi0xJfc2lAIdEPHS/p01/GqPrEx6uSa
         DnSqbk6kxlS5nSq5cppNcRyvA3PpPvR/QbBJ1pQ06KiFD7h/4R/8rFBQTd9ot2/TlEcy
         fWW7PCUBzCMM6PtzjUebMfbyffn7hIhMOaeiCEiNYtt6dAeLAyiJ8IUBWnmRGJvYWzot
         oqSs1UKDkjwJHupPEz5n5+U0FkAu9wxHnXPmb9FwbYjwijwN03+HO1494XXm6v13uM34
         P7Ee8Omon/CrY9TUva2qaG6SR7K7WimuiaRmS0xjj/0woD17VY2WWTChO5hDLSlsTZPd
         Vs9w==
X-Forwarded-Encrypted: i=1; AJvYcCUv7shqMNFcAr9kbNhUtJckhi7cfL/AhxThXBr8g6SbWX9R9rGcpByHh1R3kf3dfdHRVxZUNznIWxq9cxh45yVsWtz4NulUfvpWj7mT
X-Gm-Message-State: AOJu0YysG1IvfFbnjixET5WAbMiWPoix8144g+CwKZuNaQLFnxgYZhwI
	gpI4qTDouSETnJzs7xsVBRdivC+2yxOgKBq33hHJQUU0mDN743Ir5iqVNqQscL9IYuz8C1BU4LA
	PTKlTW3OFCfePYeEDQ8gGkELMMZTZIFrq
X-Google-Smtp-Source: AGHT+IFZwqy7hi4v9+jui3sDRfDYyIcnFYr2RUg4s5QWzy/T07+ZLpqeeBjaPUd6wfnyXf+trffGHFzZtrlM
X-Received: by 2002:a05:600c:2948:b0:41f:ec3e:9797 with SMTP id 5b1f17b1804b1-421089de607mr27580345e9.16.1716575278201;
        Fri, 24 May 2024 11:27:58 -0700 (PDT)
Received: from raspberrypi.com ([188.39.149.98])
        by smtp-relay.gmail.com with ESMTPS id ffacd0b85a97d-35586b0b42fsm56761f8f.115.2024.05.24.11.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 11:27:58 -0700 (PDT)
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
Subject: [PATCH 12/18] dmaengine: bcm2835: Read ranges if dma-ranges aren't mapped
Date: Fri, 24 May 2024 19:26:56 +0100
Message-Id: <20240524182702.1317935-13-dave.stevenson@raspberrypi.com>
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

We have a historical error in the DT files that don't define
the dma-ranges fully, and DMA users have been passing in
DMA addresses instead of CPU physical addresses.

As DT is ABI, we have to be able to work with old DT but new
kernel, which means handling this missing dma-range mapping
somehow.
The "ranges" property has always been defined correctly, so
abuse that in the event that dma-ranges are missing.

There appears to be no easy route to access "ranges", so
duplicate the functions for handling "dma-ranges" here to
keep the hack contained.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/dma/bcm2835-dma.c | 139 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 134 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index e48008b06716..06407691ef28 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/io.h>
@@ -37,6 +38,12 @@
 #define BCM2835_DMA_MAX_DMA_CHAN_SUPPORTED 14
 #define BCM2835_DMA_CHAN_NAME_SIZE 8
 
+struct bcm2835_bus_dma_region {
+	phys_addr_t	cpu_start;
+	dma_addr_t	dma_start;
+	u64		size;
+};
+
 /**
  * struct bcm2835_dmadev - BCM2835 DMA controller
  * @ddev: DMA device
@@ -48,6 +55,8 @@ struct bcm2835_dmadev {
 	struct dma_device ddev;
 	void __iomem *base;
 	dma_addr_t zero_page;
+	bool ranges_initialised;
+	struct bcm2835_bus_dma_region *ranges_map;
 };
 
 struct bcm2835_dma_cb {
@@ -71,6 +80,7 @@ struct bcm2835_dma_chan_map {
 
 	phys_addr_t slave_addr;
 	unsigned int xfer_size;
+	bool ranges;
 };
 
 struct bcm2835_chan {
@@ -279,6 +289,114 @@ static inline bool need_dst_incr(enum dma_transfer_direction direction)
 	return false;
 };
 
+static int bcm2835_dma_init_ranges(struct dma_chan *chan)
+{
+	struct bcm2835_dmadev *od = to_bcm2835_dma_dev(chan->device);
+	struct device *dev = chan->device->dev;
+	struct device_node *node = of_node_get(dev->of_node);
+	const __be32 *ranges = NULL;
+	bool found_ranges = false;
+	struct of_range_parser parser;
+	struct of_range range;
+	struct bcm2835_bus_dma_region *r;
+	int len, num_ranges = 0;
+	int ret = 0;
+
+	while (node) {
+		ranges = of_get_property(node, "ranges", &len);
+
+		/* Ignore empty ranges, they imply no translation required */
+		if (ranges && len > 0)
+			break;
+
+		/* Once we find 'dma-ranges', then a missing one is an error */
+		if (found_ranges && !ranges) {
+			ret = -ENODEV;
+			goto out;
+		}
+		found_ranges = true;
+
+		node = of_get_next_parent(node);
+	}
+
+	if (!node || !ranges) {
+		pr_debug("no ranges found for node(%pOF)\n", dev->of_node);
+		ret = -ENODEV;
+		goto out;
+	}
+
+	of_pci_range_parser_init(&parser, node);
+	for_each_of_range(&parser, &range) {
+		if (range.cpu_addr == OF_BAD_ADDR) {
+			pr_err("translation of DMA address(%llx) to CPU address failed node(%pOF)\n",
+			       range.bus_addr, node);
+			continue;
+		}
+		num_ranges++;
+	}
+
+	if (!num_ranges) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	r = kcalloc(num_ranges + 1, sizeof(*r), GFP_KERNEL);
+	if (!r) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/*
+	 * Record all info in the generic DMA ranges array for struct device,
+	 * returning an error if we don't find any parsable ranges.
+	 */
+	od->ranges_map = r;
+	of_pci_range_parser_init(&parser, node);
+	for_each_of_range(&parser, &range) {
+		pr_debug("dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
+			 range.bus_addr, range.cpu_addr, range.size);
+		if (range.cpu_addr == OF_BAD_ADDR)
+			continue;
+		r->cpu_start = range.cpu_addr;
+		r->dma_start = range.bus_addr;
+		r->size = range.size;
+		r++;
+	}
+out:
+	of_node_put(node);
+	return ret;
+}
+
+static dma_addr_t bcm2835_translate_phys_to_dma(struct bcm2835_dmadev *od,
+						phys_addr_t paddr)
+{
+	const struct bcm2835_bus_dma_region *m;
+
+	for (m = od->ranges_map; m && m->size; m++) {
+		u64 offset = paddr - m->cpu_start;
+
+		if (paddr >= m->cpu_start && offset < m->size)
+			return m->dma_start + offset;
+	}
+
+	/* make sure dma_capable fails when no translation is available */
+	return DMA_MAPPING_ERROR;
+}
+
+static dma_addr_t
+bcm2835_dma_map_using_range(struct dma_chan *chan, phys_addr_t phys_addr,
+			    size_t size, enum dma_data_direction dir)
+{
+	struct bcm2835_dmadev *od = to_bcm2835_dma_dev(chan->device);
+
+	if (!od->ranges_initialised) {
+		bcm2835_dma_init_ranges(chan);
+		od->ranges_initialised = true;
+	}
+
+	return bcm2835_translate_phys_to_dma(od, phys_addr);
+}
+
 static int bcm2835_dma_map_slave_addr(struct dma_chan *chan,
 				      phys_addr_t dev_addr,
 				      size_t dev_size,
@@ -307,8 +425,11 @@ static int bcm2835_dma_map_slave_addr(struct dma_chan *chan,
 	    dev_dir == map->dir)
 		return 0;
 
-	/* Remove old mapping if present. */
-	if (map->xfer_size) {
+	/*
+	 * Remove old mapping if present and we haven't used our own "ranges"
+	 * mapping (which has no unmap)
+	 */
+	if (map->xfer_size && !map->ranges) {
 		dev_dbg(chan->device->dev, "chan: unmap %zx@%pap to %pad dir: %s\n",
 			dev_size, &dev_addr, &map->addr,
 			dev_dir == DMA_TO_DEVICE ? "DMA_TO_DEVICE" : "DMA_FROM_DEVICE");
@@ -322,9 +443,17 @@ static int bcm2835_dma_map_slave_addr(struct dma_chan *chan,
 				     dev_dir, 0);
 
 	if (dma_mapping_error(chan->device->dev, map->addr)) {
-		dev_err(chan->device->dev, "chan: failed to map %zx@%pap",
-			dev_size, &dev_addr);
-		return -EIO;
+		map->addr = bcm2835_dma_map_using_range(chan, dev_addr, dev_size,
+							dev_dir);
+		if (dma_mapping_error(chan->device->dev, map->addr)) {
+			dev_err(chan->device->dev, "chan: failed to map %zx@%pap",
+				dev_size, &dev_addr);
+
+			return -EIO;
+		}
+		map->ranges = true;
+	} else {
+		map->ranges = false;
 	}
 
 	dev_dbg(chan->device->dev, "chan: map %zx@%pap to %pad dir: %s\n",
-- 
2.34.1


