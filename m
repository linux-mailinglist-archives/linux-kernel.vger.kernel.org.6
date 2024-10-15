Return-Path: <linux-kernel+bounces-366553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B69999F705
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3C61C23696
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9112B1B6CE9;
	Tue, 15 Oct 2024 19:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="juhgP7ay"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3F01F76AF
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019838; cv=none; b=o4Q1Qqzxj6OnZlsjDcnnJcf8pLqkTaBdV0OtBkMl/ISNyTUJvoeXihGEd5Hh/rcabVmF5fHNzf2ozyKmTvvdOBSOiXL5YnX1cFmyV6b5/PGa+Q5l9Q9gwuGr+rkqj+8B/Rpto9NoN2yD0MQevXwXaaVif/0Xg6bjEw2rev2tfYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019838; c=relaxed/simple;
	bh=FuSyoKzeygeLVHKVCKFUjItYDNK1CDXLTHh7H2UiD20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=btH49VAvUMjD4HpvTLoedjS2S6EyUXojJAL7jDG+4wZXqa87BEOhC8N9wKao5hyu7p7vAkZg8LK4cmqDf2n2PJL3XpdfhX3Ol4am2ZnRX4NTo4wVjyCYkCNBegIziQ8H9jUkLCIdQ0Ey9iiiTz4a3S+CRRnPRWvO+Y/0mlAmOBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=juhgP7ay; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a0474e70eso454670366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 12:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729019834; x=1729624634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+gZxIafqFrR6BMcHIhEjszPUzk8N9qpO7jS8LguSsI=;
        b=juhgP7ayi+LvA9yf0QMl8vCElhNfhgE+RsR56GzWQDqX3zJhpuzpaI3DWwTzZ3P5Ab
         uquwk+sENmZDyDHynds7wiEiII7JsskWwuboiH0eJcPrvsKi5CejsAKZNg+BKSD4YQwM
         jjBIZyy0FyCBapLvQ/eOYsu5LT0ANr/tNoeiBovWdhk4cdn1UGHGPBrug5Y6FqdS3xpB
         FnqFygrbHrIBCYN8s/Twh3eFgJgeoz4up26A0xO/n9h+5CbBDliHVft0TYpgrv1FCsdT
         YKrMbXrvXuv+Ak3vx3wUF2h3cZjxXe16AxB5V7lsGr98g5h0d1gswwZJwPfcBKjHuZmN
         Eobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729019834; x=1729624634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+gZxIafqFrR6BMcHIhEjszPUzk8N9qpO7jS8LguSsI=;
        b=cLRzGYGyiXCkmk9Az3pcm5n34Cofh2EnCYWewA9n4cr74nDDGuRI3URNaeS+T8G5h4
         6ggqGBjTa0knh7MacwunMhyrAjGmr6Mtx7zTa+3sdoK9n0tLRSRBeOpA0uu4IOqtx0UM
         TuXdo1rYyXebFgWRHDYowjTCClBlfPSji76I8WQhXrwLB6LznQLcIFCBMMrGwAQ2ilwQ
         Cc8mJH/4XHL0drcIOV+xwrlu0xCRn7Yo+K+IbK10o+I6FeL5UrsC6k5xc3zmgSXaXdMJ
         fankJtlbCSl7/JDShlRjWBdd5sbNnzub249dMXqYHaPKxFvPW9SjOYFyUr4XzrYWffEo
         4ktQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxAxajAWrekHIvEF+vBv6M/2Hzzf1x4mV+t8aFh/Z5Gfdl6et9olIy07ZEpUCMotAqfDa/KCXaLQNjtPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyioCO9KsBiD9eBPKc5Y9lR1d8tcpVxnzqPrMgjhxce1m8HpJYi
	TpJVXJKReMkBAopkvwW2WNhDWvJ28UtgpQdiZ1RYAoGsGMh4mUmjXRu20IpVLDY=
X-Google-Smtp-Source: AGHT+IEnWhyoMdkPWKAnqSZfQ5E35xloBUwyytezjQk7zjPCXojeRmRve/u2bGJ3yuGwNR720ej3zA==
X-Received: by 2002:a17:907:f1c7:b0:a99:8a0e:8710 with SMTP id a640c23a62f3a-a99e3b5b167mr1064453866b.14.1729019834109;
        Tue, 15 Oct 2024 12:17:14 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2988c57asm101052866b.204.2024.10.15.12.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:17:13 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 15 Oct 2024 21:15:58 +0200
Subject: [PATCH v4 4/9] can: m_can: Return ERR_PTR on error in allocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-topic-mcan-wakeup-source-v6-12-v4-4-fdac1d1e7aa6@baylibre.com>
References: <20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com>
In-Reply-To: <20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3520; i=msp@baylibre.com;
 h=from:subject:message-id; bh=FuSyoKzeygeLVHKVCKFUjItYDNK1CDXLTHh7H2UiD20=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNL59k/z2Lj1No/cl7I9t1MUPx1QXZx7ecckPVFvB4mmI
 2vai37N7ShlYRDjYJAVU2S5+2Hhuzq56wsi1j1yhJnDygQyhIGLUwAmsnEtI8MuIZcVy569Tdhl
 d/vE54mpLC8EmrNF9zk++LzZc6pH01NORoZbyw0ily0ubKg1lLGYPcPCO03OcfI1x4lTduVd3MI
 WEsUIAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

We have more detailed error values available, return them in the core
driver and the calling drivers to return proper errors to callers.

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c          | 6 +++---
 drivers/net/can/m_can/m_can_pci.c      | 4 ++--
 drivers/net/can/m_can/m_can_platform.c | 4 ++--
 drivers/net/can/m_can/tcan4x5x-core.c  | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index d427645a5b3baf7d0a648e3b008d7d7de7f23374..5a4e0ad07e9ecc82de5f1f606707f3380d3679fc 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2355,7 +2355,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 					     sizeof(mram_config_vals) / 4);
 	if (ret) {
 		dev_err(dev, "Could not get Message RAM configuration.");
-		goto out;
+		return ERR_PTR(ret);
 	}
 
 	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
@@ -2370,7 +2370,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 	net_dev = alloc_candev(sizeof_priv, tx_fifo_size);
 	if (!net_dev) {
 		dev_err(dev, "Failed to allocate CAN device");
-		goto out;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	class_dev = netdev_priv(net_dev);
@@ -2379,7 +2379,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 	SET_NETDEV_DEV(net_dev, dev);
 
 	m_can_of_parse_mram(class_dev, mram_config_vals);
-out:
+
 	return class_dev;
 }
 EXPORT_SYMBOL_GPL(m_can_class_allocate_dev);
diff --git a/drivers/net/can/m_can/m_can_pci.c b/drivers/net/can/m_can/m_can_pci.c
index d72fe771dfc7aa768c728f817e67a87b49fd9974..05a01dfdbfbf18b74f796d2efc75e2be5cbb75ed 100644
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
index b832566efda042929486578fad1879c7ad4a0cff..40bd10f71f0e2fab847c40c5bd5f7d85d3d46712 100644
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
index 2f73bf3abad889c222f15c39a3d43de1a1cf5fbb..4c40b444727585b30df33a897c398e35e7592fb2 100644
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


