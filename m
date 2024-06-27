Return-Path: <linux-kernel+bounces-232678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAFC91ACC9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF351B22D3E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6821993B4;
	Thu, 27 Jun 2024 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="0O0fDBKd"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F96199E96
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505755; cv=none; b=nM3NOF0lf1T7iMF20C4TGRcr+1jxzR+B9Gh95KvZSkKMPDZNIji8DmkQy9VkdPLJ4bRYoiAexwIe7yKzYy4lRmR97HSbg8HQD20+GYiMvups4MknaFFaV2k9zCUlbgycQNHyphVpWS7i5xFqkQG4/Kuv+KGdZOatnR+aJz1SFDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505755; c=relaxed/simple;
	bh=cw+l2A4wgT8PtcMywBx+9XFt3yIbM2+46AeAyO5wlr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JwvcwRtYlDB0pZKiT6IibVJJlzHW/oQWnpR7BkbrMrlsn/8Vg54mR2MvJFPtM9Cc0EU6e/IAbqpHVBkHiERfQuKPaPKIvtsqhwDY1GbSZBS0XK2OdghhGSSt5A0ov8I2F/TOz4t5Q8/IzNz4EviIpM2AILrFng8aPfXLr690MEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=0O0fDBKd; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7068fe9f98aso411441b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1719505752; x=1720110552; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJ1Q8KLXbBvPejPRGDLYr/bC1HXbn69hKei2CLRD37M=;
        b=0O0fDBKdt/BWcT4cQbhFlGY2JfeMP4fV/P2l7kka/Ca1yM5ODNTGromlGd3Sa4EdxX
         Tg2bl1XtVcMfRRUdkdWK0RyPUsJXxNno+/T/1FwWWqC7KhNPJX2AHieQOIaIQVn1DBBi
         CaIhgWUH9V66XLU1kDf8jGA18rcIGYhc442J37xefjhJDOuY7k7V+O2X1N5au+xGeVtu
         fh3/Nnzi1e8AC8anD7L5B3NsmNqTtnLtBM9iVP1MkbAN+qWixefPWHCzbQTSx4kP8JM9
         yWiTnphAsDTdTIsyGOlAsFQu532RcxC27TXbBzQ4Tg7l+XS7xLYvqHiMehYFBKI4Aij5
         Y1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719505752; x=1720110552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJ1Q8KLXbBvPejPRGDLYr/bC1HXbn69hKei2CLRD37M=;
        b=rGgI2Hbdvmq1Wy0GCh86bRs6dpho8O0hU4xvcGPrkr62glvfQBieYJYtAcgZKB9DO6
         1AOott9IoIGpVLBCoSFO9WKmQVA/kYBa6k9JbSe+1e+EyMLeMFa3Dhs83hvPuGmit0a9
         pLGXTSK2c7VPuy3Tp6nlTjIZ8CP/5P5t2aHjXjNNxftOAv/eFlKFni+UFDdWVGrZ+iEb
         OJslgnOG+i/hdjw6cuMZGq+9ddyxucV3hzWlUNX48s0lApqR/CgjWDwl6eV+kS+OkVKX
         09SkWwc4vEmbPEHYHKJrqeLJb7xkegdxsl+XdbhChbsRCrvXYP0BEg5342h7L89Hwf1s
         iqpg==
X-Forwarded-Encrypted: i=1; AJvYcCURblYfhrp7PB8QjCa7hcySJhaHWQ9+Ph/fdNqLzzxxNW5kSyPahfzBdhr9jUzoSynAyckq2ThwQHlT58o+/DSmVUncnZ35XYvgFjjP
X-Gm-Message-State: AOJu0Yz3X1dhOzUZUMDW5PmFvk38kqHntWYWQTVEbNxXDMu9uOg2ZMqz
	+h+6sXB3g79kkBNMjR+WhthS/DqmZ5MNzo0GNnEDgOsvits+GGUY80yj/45vrg==
X-Google-Smtp-Source: AGHT+IH3omPFHGGPxV7skDlndGJ9S2ClJpc2MTVM8kooRW3+wAtdW3I1lvFLR5DYyPEFczJdm/1zgg==
X-Received: by 2002:a05:6a00:8c0d:b0:704:21c2:ae92 with SMTP id d2e1a72fcca58-706649a6b01mr16098893b3a.2.1719505752619;
        Thu, 27 Jun 2024 09:29:12 -0700 (PDT)
Received: from [127.0.0.1] ([2401:4900:1f3e:18b0:e4e6:ed1:4c03:dcec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b4a58dbdsm1560739b3a.198.2024.06.27.09.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 09:29:12 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Thu, 27 Jun 2024 21:56:14 +0530
Subject: [PATCH v5 4/7] spi: Make of_find_spi_controller_by_node()
 available
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-mikrobus-scratch-spi-v5-4-9e6c148bf5f0@beagleboard.org>
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
In-Reply-To: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
To: Mark Brown <broonie@kernel.org>, 
 Vaishnav M A <vaishnav@beagleboard.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>, 
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Michael Walle <mwalle@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 jkridner@beagleboard.org, robertcnelson@beagleboard.org
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ayush Singh <ayush@beagleboard.org>, Ayush Singh <ayushdevel1325@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7524; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=Q5G1t+bBT76IayXqh+ct3R0Xwy8Q7gI2MQZpDn6U4Tw=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBmfZM39ts1Hz8di1m0tcwk+aba8fgbKzU2sWFfL
 dDxLIgR2WOJAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZn2TNwAKCRAFzvXHieVa
 dM2AD/93OV2TFiw4AdubUbDptdezyFQRUOt4vbb1yBRSJbVpqw0STGvI8pwCR6VRNxbd8NrQtX8
 kuxOz63jbSsu6ob+kNVJjeH6wHJB4nelVuf7T3JhjBMv0qTdAc/75f2pklRQx6gJVYTNNmCgfHU
 9Oid495FxS1D8AHZCTp7Ungr+CwIdqTTUyTsUaav9tvrSSoVFqgGDso3URiVi86Xyraa6+aGjbW
 pI2d03Iua9sZOaQ2fmjsoi0mh7+zJzfhDlYLHmRIR+pqPR07zgv4MXoKwPtG+I3mEdLOcBKi7wg
 ZO9d3j0hZFcSqOIpey4mmMrtfT1DpckFEb0smR3mb3p6cmSkgZ53z4ALiIxW+g9NtQhtlBRQT11
 RpAaRWVoRq4jrrqLxrG5/QtA7+begIYPCKmueTZgN6blJ//gU93cOctHEU+MmtptAmPjhNtB9oT
 HCVLZ7vvlZcckDE8i/YP/VKepTVKrkgNxOw21DMYkZo+Pa7uWUjHH6CTtgmNFa0XmeRCEIUqM1v
 BDFmWAhz7lTAxCm2ZMuc/+NxaJCg4/3uhrd5zScJKtS8intFDwaAMKK3NbZKGxX0gZK3G91PHvV
 AB4xqkIebulFZvYJg9kevmPttx3R7mLHeVOMyWednW8m+kQhTGKx6Q5qPqa6RbkQ3o4LS27e5mk
 YOdbHuiZ3uUdyiw==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

From: Ayush Singh <ayushdevel1325@gmail.com>

DONOTMERGE

Externalize and export the symbol of_find_spi_controller_by_node() from
the SPI core akin to how of_find_i2c_adapter_by_node() is already
available.

Also, move it under a CONFIG_OF.

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
 drivers/spi/spi.c       | 206 ++++++++++++++++++++++++------------------------
 include/linux/spi/spi.h |   4 +
 2 files changed, 108 insertions(+), 102 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 54cbe652a4df..565b2e2dd5b9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2340,6 +2340,93 @@ void spi_flush_queue(struct spi_controller *ctlr)
 
 /*-------------------------------------------------------------------------*/
 
+static void spi_controller_release(struct device *dev)
+{
+	struct spi_controller *ctlr;
+
+	ctlr = container_of(dev, struct spi_controller, dev);
+	kfree(ctlr);
+}
+
+static struct class spi_master_class = {
+	.name		= "spi_master",
+	.dev_release	= spi_controller_release,
+	.dev_groups	= spi_master_groups,
+};
+
+static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct spi_controller *ctlr = container_of(dev, struct spi_controller,
+						   dev);
+	struct device *child;
+
+	child = device_find_any_child(&ctlr->dev);
+	return sysfs_emit(buf, "%s\n", child ? to_spi_device(child)->modalias : NULL);
+}
+
+static ssize_t slave_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct spi_controller *ctlr = container_of(dev, struct spi_controller,
+						   dev);
+	struct spi_device *spi;
+	struct device *child;
+	char name[32];
+	int rc;
+
+	rc = sscanf(buf, "%31s", name);
+	if (rc != 1 || !name[0])
+		return -EINVAL;
+
+	child = device_find_any_child(&ctlr->dev);
+	if (child) {
+		/* Remove registered slave */
+		device_unregister(child);
+		put_device(child);
+	}
+
+	if (strcmp(name, "(null)")) {
+		/* Register new slave */
+		spi = spi_alloc_device(ctlr);
+		if (!spi)
+			return -ENOMEM;
+
+		strscpy(spi->modalias, name, sizeof(spi->modalias));
+
+		rc = spi_add_device(spi);
+		if (rc) {
+			spi_dev_put(spi);
+			return rc;
+		}
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(slave);
+
+static struct attribute *spi_slave_attrs[] = {
+	&dev_attr_slave.attr,
+	NULL,
+};
+
+static const struct attribute_group spi_slave_group = {
+	.attrs = spi_slave_attrs,
+};
+
+static const struct attribute_group *spi_slave_groups[] = {
+	&spi_controller_statistics_group,
+	&spi_slave_group,
+	NULL,
+};
+
+static struct class spi_slave_class = {
+	.name		= "spi_slave",
+	.dev_release	= spi_controller_release,
+	.dev_groups	= spi_slave_groups,
+};
+
 #if defined(CONFIG_OF)
 static void of_spi_parse_dt_cs_delay(struct device_node *nc,
 				     struct spi_delay *delay, const char *prop)
@@ -2549,6 +2636,23 @@ static void of_register_spi_devices(struct spi_controller *ctlr)
 		}
 	}
 }
+
+/* The spi controllers are not using spi_bus, so we find it with another way */
+struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
+{
+	struct device *dev;
+
+	dev = class_find_device_by_of_node(&spi_master_class, node);
+	if (!dev && IS_ENABLED(CONFIG_SPI_SLAVE))
+		dev = class_find_device_by_of_node(&spi_slave_class, node);
+	if (!dev)
+		return NULL;
+
+	/* Reference got in class_find_device */
+	return container_of(dev, struct spi_controller, dev);
+}
+EXPORT_SYMBOL_GPL(of_find_spi_controller_by_node);
+
 #else
 static void of_register_spi_devices(struct spi_controller *ctlr) { }
 #endif
@@ -2917,20 +3021,6 @@ static void acpi_register_spi_devices(struct spi_controller *ctlr)
 static inline void acpi_register_spi_devices(struct spi_controller *ctlr) {}
 #endif /* CONFIG_ACPI */
 
-static void spi_controller_release(struct device *dev)
-{
-	struct spi_controller *ctlr;
-
-	ctlr = container_of(dev, struct spi_controller, dev);
-	kfree(ctlr);
-}
-
-static struct class spi_master_class = {
-	.name		= "spi_master",
-	.dev_release	= spi_controller_release,
-	.dev_groups	= spi_master_groups,
-};
-
 #ifdef CONFIG_SPI_SLAVE
 /**
  * spi_slave_abort - abort the ongoing transfer request on an SPI slave
@@ -2958,79 +3048,6 @@ int spi_target_abort(struct spi_device *spi)
 	return -ENOTSUPP;
 }
 EXPORT_SYMBOL_GPL(spi_target_abort);
-
-static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
-			  char *buf)
-{
-	struct spi_controller *ctlr = container_of(dev, struct spi_controller,
-						   dev);
-	struct device *child;
-
-	child = device_find_any_child(&ctlr->dev);
-	return sysfs_emit(buf, "%s\n", child ? to_spi_device(child)->modalias : NULL);
-}
-
-static ssize_t slave_store(struct device *dev, struct device_attribute *attr,
-			   const char *buf, size_t count)
-{
-	struct spi_controller *ctlr = container_of(dev, struct spi_controller,
-						   dev);
-	struct spi_device *spi;
-	struct device *child;
-	char name[32];
-	int rc;
-
-	rc = sscanf(buf, "%31s", name);
-	if (rc != 1 || !name[0])
-		return -EINVAL;
-
-	child = device_find_any_child(&ctlr->dev);
-	if (child) {
-		/* Remove registered slave */
-		device_unregister(child);
-		put_device(child);
-	}
-
-	if (strcmp(name, "(null)")) {
-		/* Register new slave */
-		spi = spi_alloc_device(ctlr);
-		if (!spi)
-			return -ENOMEM;
-
-		strscpy(spi->modalias, name, sizeof(spi->modalias));
-
-		rc = spi_add_device(spi);
-		if (rc) {
-			spi_dev_put(spi);
-			return rc;
-		}
-	}
-
-	return count;
-}
-
-static DEVICE_ATTR_RW(slave);
-
-static struct attribute *spi_slave_attrs[] = {
-	&dev_attr_slave.attr,
-	NULL,
-};
-
-static const struct attribute_group spi_slave_group = {
-	.attrs = spi_slave_attrs,
-};
-
-static const struct attribute_group *spi_slave_groups[] = {
-	&spi_controller_statistics_group,
-	&spi_slave_group,
-	NULL,
-};
-
-static struct class spi_slave_class = {
-	.name		= "spi_slave",
-	.dev_release	= spi_controller_release,
-	.dev_groups	= spi_slave_groups,
-};
 #else
 extern struct class spi_slave_class;	/* dummy */
 #endif
@@ -4720,21 +4737,6 @@ static struct spi_device *of_find_spi_device_by_node(struct device_node *node)
 	return dev ? to_spi_device(dev) : NULL;
 }
 
-/* The spi controllers are not using spi_bus, so we find it with another way */
-static struct spi_controller *of_find_spi_controller_by_node(struct device_node *node)
-{
-	struct device *dev;
-
-	dev = class_find_device_by_of_node(&spi_master_class, node);
-	if (!dev && IS_ENABLED(CONFIG_SPI_SLAVE))
-		dev = class_find_device_by_of_node(&spi_slave_class, node);
-	if (!dev)
-		return NULL;
-
-	/* Reference got in class_find_device */
-	return container_of(dev, struct spi_controller, dev);
-}
-
 static int of_spi_notify(struct notifier_block *nb, unsigned long action,
 			 void *arg)
 {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 85785bcd20c1..58e692226475 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1684,4 +1684,8 @@ spi_transfer_is_last(struct spi_controller *ctlr, struct spi_transfer *xfer)
 	return list_is_last(&xfer->transfer_list, &ctlr->cur_msg->transfers);
 }
 
+#if IS_ENABLED(CONFIG_OF)
+struct spi_controller *of_find_spi_controller_by_node(struct device_node *node);
+#endif
+
 #endif /* __LINUX_SPI_H */

-- 
2.45.2


