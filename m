Return-Path: <linux-kernel+bounces-265272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA1693EEBF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF3F1C21B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E63139580;
	Mon, 29 Jul 2024 07:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BGGyTvWw"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7064512D1FD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722238924; cv=none; b=thjrkfXrRkRcyN55VhQGbSEPZB5KuVUFCczJ2ewcYk0listQXVU8c00fDLupPrmXjJ5y3UAHuaiVC6bCQS1kZ4qg3n7l7nXvQ5LLLs4+83/SWrCEcebny3dWTm4JJIFiBSKHSuP5AH9i8aNzy8X1tEam7DFyFOcStIZwmv+SdEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722238924; c=relaxed/simple;
	bh=Ta2L/1ooF+CTfVFwAjB2t5O92X2+ab6FoFth4ZdKJsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDOwIlDaj2fgwOEgrhAPlDKZu/xj0Y0cuMwTCl+6COrMpV/M2r3ldfV9dTSHmYaABs6/XE47q+IBgR7viqflytKe5pZzWLUpVOZCodAnYbmWfwa3Guxa2E79L+vFpLGRQiNDbXrG2VjbzbbVaRlrHS+US2jvRgPZ3ovcfGdmvvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BGGyTvWw; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3687fb526b9so1152917f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 00:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722238921; x=1722843721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeg14f0KbqEGucxcVmm1WXsFuu/G6EBq2QXT7ORiCag=;
        b=BGGyTvWwHZ0X1pkuYWdc12ml6XWvtXZVfBfHY8Q1sLYb72zkf+AO2PA06zZCPQSvv+
         VUEgoSmuoKELl/WnSd/NfdOQIoroa9++zjE4HaVRSj9TeqUbtM0f38I4Xy9M7154cTgw
         84ZWhYB6O37WLov1kgW803jFFIXRQFdpcbg0G1zFWxU68s+S38iu6W2ijfCpVNro3+m/
         jYv0QTA4KkIMZ0tH/WDquwVbvQMCZ9m/CwL568r/agDZGCDL+y+dE1WnPDljDq+gi6VL
         gzXyXutadjPehRYg7eCYWZ9ZF3fvbPK0SyIlEzDgA8vyEHHOm+1pBfz5Z7FxfmBcU/Nl
         er9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722238921; x=1722843721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeg14f0KbqEGucxcVmm1WXsFuu/G6EBq2QXT7ORiCag=;
        b=qkTjpvs34LqyXk3if+g3dkJRM60hZeydAGQAtYJMrecaDh5smkHZ1mLDEk7o92JMXA
         /DHTM+giggzW7e7ZT+Rh5htQf/4k0rqE6qGPyk5cxUQg7grlXSGTshgy4a8NIcWULR9d
         YnsvNdODw0uIq514NNgt35wPTa1WYp8C/aC+ISGXF6tvA+GUB0/iPJctI3um3TkmuNFH
         p2yXm7rKQbvRhMqzQ5HggPLZKivS+8R+lbmud2fvf3EV8ZRP8U+eqvtmTddhheR7WQ8w
         epZXfmHrvsB+ZkRPnlZqQKRjQv48Fpt5+olGs46dT3KqtyCT2HGicdApgOThh2wK3sgi
         0Eyw==
X-Forwarded-Encrypted: i=1; AJvYcCWbSlzgf5Z0CGcQdNtIPMggXLgCxiXckR4HX+vpE+tP4SJvv3a0yn56qaKH4qE1xbqXaWftJNkQq7AfL8RdTbUeJkLYk5NHt34aK6x3
X-Gm-Message-State: AOJu0Yz1jMIO00DOCg5XmC6IEo/xGYXQ+RnOmrjBBFSQ3zDArlPQlzhX
	GajcF3BAF5saLfvyLBase5sPyzfCyDTyBexQ16CB5B5W3feaxCaap7Jl73CyadA=
X-Google-Smtp-Source: AGHT+IG/CESAQDtsmDP2HTDQ8KiBa0jkwD+YkksDTOEwTebAs8MrvspRVYp81dFcTJcPrwx9mnhJyg==
X-Received: by 2002:adf:e94c:0:b0:369:f662:109b with SMTP id ffacd0b85a97d-36b5cf23abbmr4360020f8f.27.1722238920931;
        Mon, 29 Jul 2024 00:42:00 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863aa7sm11460879f8f.109.2024.07.29.00.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 00:42:00 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Michal Kubiak <michal.kubiak@intel.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	Conor Dooley <conor@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/7] can: m_can: Return ERR_PTR on error in allocation
Date: Mon, 29 Jul 2024 09:41:31 +0200
Message-ID: <20240729074135.3850634-4-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729074135.3850634-1-msp@baylibre.com>
References: <20240729074135.3850634-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have more detailed error values available, return them in the core
driver and the calling drivers to return proper errors to callers.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c          | 6 +++---
 drivers/net/can/m_can/m_can_pci.c      | 4 ++--
 drivers/net/can/m_can/m_can_platform.c | 4 ++--
 drivers/net/can/m_can/tcan4x5x-core.c  | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 2e4ccf05e162..5b80a7d1f9a1 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2352,7 +2352,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 					     sizeof(mram_config_vals) / 4);
 	if (ret) {
 		dev_err(dev, "Could not get Message RAM configuration.");
-		goto out;
+		return ERR_PTR(ret);
 	}
 
 	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
@@ -2367,7 +2367,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 	net_dev = alloc_candev(sizeof_priv, tx_fifo_size);
 	if (!net_dev) {
 		dev_err(dev, "Failed to allocate CAN device");
-		goto out;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	class_dev = netdev_priv(net_dev);
@@ -2376,7 +2376,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 	SET_NETDEV_DEV(net_dev, dev);
 
 	m_can_of_parse_mram(class_dev, mram_config_vals);
-out:
+
 	return class_dev;
 }
 EXPORT_SYMBOL_GPL(m_can_class_allocate_dev);
diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
index d72fe771dfc7..05a01dfdbfbf 100644
--- a/drivers/net/can/m_can/m_can_pci.c
+++ b/drivers/net/can/m_can/m_can_pci.c
@@ -111,8 +111,8 @@ static int m_can_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 
 	mcan_class = m_can_class_allocate_dev(&pci->dev,
 					      sizeof(struct m_can_pci_priv));
-	if (!mcan_class)
-		return -ENOMEM;
+	if (IS_ERR(mcan_class))
+		return PTR_ERR(mcan_class);
 
 	priv = cdev_to_priv(mcan_class);
 
diff --git a/drivers/net/can/m_can/m_can_platform.c b/drivers/net/can/m_can/m_can_platform.c
index 983ab80260dd..a5024e2cff8d 100644
--- a/drivers/net/can/m_can/m_can_platform.c
+++ b/drivers/net/can/m_can/m_can_platform.c
@@ -87,8 +87,8 @@ static int m_can_plat_probe(struct platform_device *pdev)
 
 	mcan_class = m_can_class_allocate_dev(&pdev->dev,
 					      sizeof(struct m_can_plat_priv));
-	if (!mcan_class)
-		return -ENOMEM;
+	if (IS_ERR(mcan_class))
+		return PTR_ERR(mcan_class);
 
 	priv = cdev_to_priv(mcan_class);
 
diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 2f73bf3abad8..4c40b4447275 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -375,8 +375,8 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 
 	mcan_class = m_can_class_allocate_dev(&spi->dev,
 					      sizeof(struct tcan4x5x_priv));
-	if (!mcan_class)
-		return -ENOMEM;
+	if (IS_ERR(mcan_class))
+		return PTR_ERR(mcan_class);
 
 	ret = m_can_check_mram_cfg(mcan_class, TCAN4X5X_MRAM_SIZE);
 	if (ret)
-- 
2.45.2


