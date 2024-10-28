Return-Path: <linux-kernel+bounces-385494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0FF9B37EC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD702828CA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8354B1DFE0F;
	Mon, 28 Oct 2024 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TtmO3oQl"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4E21DF96A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137226; cv=none; b=UnZafQQB3mpq+Ympsplhs6iFWKvs/Iw9aKW2oBIlp+PutQzNj+24lNg2iMCyPEuKjpoYYem7HEHC0hGGajMb3zMFTC7hhDoaNYktpD7hFeoOKPPHqfHVLV3BOG1OTlVAmFErF6T1GZjv0tb7LNw1dLPeqsYiBmRPjwEBvyJIons=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137226; c=relaxed/simple;
	bh=XYYmgD9hEGtxNIWY9snEM0dWMiWJG8YdzXkcAQHDIMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NeiyqP3sLwgLPMsHqe7qSxIwvNHmM27kJZibz7+mKh2bF8b3xT4CaUh1qoA/ePx4PV6PBnQKk55rkZoKY4O2ZuWkMycNFxCb2jzE9BMDAD/P+Pa6bwiRtwN9Xiwa2648XOMbjKxL86mvYyn+X7qvgq5MHsVw1/fLtPs1NXI41WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TtmO3oQl; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so44444265e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730137223; x=1730742023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7uoSe/osPZM5KlWFY2p8NKc5PKZqtCcQla6SsIgyOw4=;
        b=TtmO3oQlG/GsoTeJDyH5sLoUWlqwIAXWn4GcpxXaCKLoHY8csRTQMg4v4xLnLhEG5I
         YZvq3eNsF6BJZ2+R8fYmtf1ocQNDqU1d6WCxgzSGBbDi7fM7U7t1mGVVhSiuo9M1ZA/X
         Ph3qiMzqJPeBtaHB6W1MEAE0HtOgBNFdnYkKzbBm/1BJpSxCSxIHB6QwyCvHiYy16PWe
         wFcBzE6Eo5uhhdgTDOVdUPUPt3YNfz+I3ndKqSE9Hgd1csmNs76esZAOBGUI/O+ZY+Tf
         kwIjPv8b+QM3atjF/XRZgLJqLFyoRfQBwEapdvjy3D2FDKRg0BHIbCUFgQTpWsm3NjqE
         7sqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730137223; x=1730742023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uoSe/osPZM5KlWFY2p8NKc5PKZqtCcQla6SsIgyOw4=;
        b=RDN3ObeLnEZydWMoK4rWkGDCdgiiBFfL9og4lNZ3bjcxnw9KckMXzGD/w2OArOdYPr
         1thGhRqLMUv2VSRDd/HPfO/3l9PoagajCFMUjlNAxC+6tEEfW1jfubmd6R+rMsmXa6PR
         vYVqxVJdxtbRVKXes62MFTaSxyOW2TwNyhFYPz6GIXMw9FEa9AYDT5TI7YjUXpxEIabR
         tkN6KWxYJa6wAuf/jkNzinpWFF/NW364q6KvN1G7YA/hwvI0+tLAw6l1TDt++SVzoQLO
         hBNXr3dHMDl68P2waKqemctqJ+4uMgcoA3qIYw/01x7MxttHVQupzpOo1jMrwLiVVnk3
         V/jg==
X-Forwarded-Encrypted: i=1; AJvYcCXBqONfnv7rMk81jLgJZA5M0/j/15He/8zoGfMWJ2cWEFN/DfsNNF4B/WeNs7WpSYlyDR642ekP/eXFzP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtsIppQTGpiX7MJYaA5LjMLQivvnYEqsmEVYNH8/PXNFUA9jNN
	yt5x2GDcp3kXwkhqKqyi79AvWPMiXD0P7EaJ4esKfFJY77sXbk2zslCEL4zSP6c=
X-Google-Smtp-Source: AGHT+IEFSR/zG77GxCKMdEA6ZBLL2jNoMnHHBu+9OH7sb56aIGjLWheqa9jEnSLBwlhUQRsnp7JZVQ==
X-Received: by 2002:adf:ea4a:0:b0:37c:d54b:a39a with SMTP id ffacd0b85a97d-38061145761mr6895987f8f.33.1730137222779;
        Mon, 28 Oct 2024 10:40:22 -0700 (PDT)
Received: from localhost ([2001:4091:a245:81f4:340d:1a9d:1fa6:531f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b0ed7bsm10150974f8f.19.2024.10.28.10.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:40:22 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 28 Oct 2024 18:38:09 +0100
Subject: [PATCH v5 3/9] can: m_can: Map WoL to device_set_wakeup_enable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-topic-mcan-wakeup-source-v6-12-v5-3-33edc0aba629@baylibre.com>
References: <20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com>
In-Reply-To: <20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Simon Horman <horms@kernel.org>, 
 Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2839; i=msp@baylibre.com;
 h=from:subject:message-id; bh=XYYmgD9hEGtxNIWY9snEM0dWMiWJG8YdzXkcAQHDIMQ=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNLlz0SxP7w5mbP/+MqNZt6FkftLkoVjHVI7CmTVr63bw
 F358euhjlIWBjEOBlkxRZa7Hxa+q5O7viBi3SNHmDmsTCBDGLg4BWAimycyMhyudZAq0F0tbzN5
 ofD37/u+a2eyLtPZOYVp0WuhHp1jv/Yw/JWLPjLtpkdU+0f5/PDXDRMS+KUe39zqZTBrXlCfSqq
 yIz8A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

In some devices the pins of the m_can module can act as a wakeup source.
This patch helps do that by connecting the PHY_WAKE WoL option to
device_set_wakeup_enable. By marking this device as being wakeup
enabled, this setting can be used by platform code to decide which
sleep or poweroff mode to use.

Also this prepares the driver for the next patch in which the pinctrl
settings are changed depending on the desired wakeup source.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a978b960f1f1e1e8273216ff330ab789d0fd6d51..b358b60a1dee0f39aba9e2ec89dcbd0d65cd7823 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2185,6 +2185,36 @@ static int m_can_set_coalesce(struct net_device *dev,
 	return 0;
 }
 
+static void m_can_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
+{
+	struct m_can_classdev *cdev = netdev_priv(dev);
+
+	wol->supported = device_can_wakeup(cdev->dev) ? WAKE_PHY : 0;
+	wol->wolopts = device_may_wakeup(cdev->dev) ? WAKE_PHY : 0;
+}
+
+static int m_can_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
+{
+	struct m_can_classdev *cdev = netdev_priv(dev);
+	bool wol_enable = !!(wol->wolopts & WAKE_PHY);
+	int ret;
+
+	if (wol->wolopts & ~WAKE_PHY)
+		return -EINVAL;
+
+	if (wol_enable == device_may_wakeup(cdev->dev))
+		return 0;
+
+	ret = device_set_wakeup_enable(cdev->dev, wol_enable);
+	if (ret) {
+		netdev_err(cdev->net, "Failed to set wakeup enable %pE\n",
+			   ERR_PTR(ret));
+		return ret;
+	}
+
+	return 0;
+}
+
 static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS_IRQ |
 		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ |
@@ -2194,10 +2224,14 @@ static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
 	.get_ts_info = ethtool_op_get_ts_info,
 	.get_coalesce = m_can_get_coalesce,
 	.set_coalesce = m_can_set_coalesce,
+	.get_wol = m_can_get_wol,
+	.set_wol = m_can_set_wol,
 };
 
 static const struct ethtool_ops m_can_ethtool_ops = {
 	.get_ts_info = ethtool_op_get_ts_info,
+	.get_wol = m_can_get_wol,
+	.set_wol = m_can_set_wol,
 };
 
 static int register_m_can_dev(struct m_can_classdev *cdev)
@@ -2324,6 +2358,9 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 		goto out;
 	}
 
+	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
+		device_set_wakeup_capable(dev, true);
+
 	/* Get TX FIFO size
 	 * Defines the total amount of echo buffers for loopback
 	 */

-- 
2.45.2


