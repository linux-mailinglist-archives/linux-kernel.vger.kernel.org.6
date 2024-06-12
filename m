Return-Path: <linux-kernel+bounces-211168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A1D904DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79AF1F27124
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA98916D9B0;
	Wed, 12 Jun 2024 08:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="N7AdyKes"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B92816D32E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180438; cv=none; b=WJpXI7MFOWgW9HqtLRKIyqltzQnXswUZLanTgJ0hyEIrYetiCCYFyDS9vXRQ0MyiKwFw6+PJ1YcncOGfQWvC2OxUCwXT+4iy8yB6D5AT8cYzhjlIuDCyn9I/PV1w8hjJ+Yf93H1Qsd+Kq15qBqFeF8zb8BIg4g02CSVPAyAp88U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180438; c=relaxed/simple;
	bh=z26s4JsQKN7nhVU9IlT3jZC8JXh2Ex5Rgl+dEf47fr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UECMXUc78EmQXZ2b+J2nhqaNEzUGkAX54jIFokG+QJFd7twipcjirY8QrEtH/aPbhN3UcG80fvSR34UBcIU9XygxrPI/fEFx/N7Za7H6p6IXkQh9vGypte1cTJav7AUd9N3y/OhUtg/jeIoaFceIurDnqOZeKiNdLt1DN7OgyH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=N7AdyKes; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-421cd1e5f93so14105275e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718180436; x=1718785236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIW5MiXtA4tOd1cdWHl86xShNBL3C/n3QwINP9u0b7k=;
        b=N7AdyKesdnPpZgl+1aIaSQIskXCfXr4ZC+L4aAfeULB4n5ssKHQ3EbEv/rDNN4JAuc
         Zl2psvxp3bQWSbFuus08Gi1Svzd199PKGooghkryxkbZ5h2Kc2AMNq+hKXy9rmgVe1vE
         A189rDNGu+KI4Kjkjj7yVkoqrtJPCeNhHbX9eaG21tDGmw2tAeZ6uttmLxfVAkdEqDda
         YJBTFIlWRjRlqAFYjs+B9qDRCMtiFeX10gGvNd02YZLf65lIF9YpY2/TUGhnLP7mkITD
         Z9fh9rxww8YYyj+Ysqau0aitbuSPpv42e9y02ezgtbGtFYN89OXV94aoq61MLAgBE35A
         mmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718180436; x=1718785236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIW5MiXtA4tOd1cdWHl86xShNBL3C/n3QwINP9u0b7k=;
        b=WubFsD3/M3UXN9xhA4cZvoKuEUycw7Xr7Hxh8WG1+Zl3nDL1s+hew9drIK55NXvE1s
         uOH2Jo/Rr9tDEA91RY09dstF+hMDYGzn2WiR3/bvRgIjY0QB2eDAyfV3oTLqzVBbjhyG
         BpQa/sANSWJuDCQ9VgOMHFoD2nKBvOXGa3w9NzqkTp9+X1QbpuMBlTxrTPw/mZ4NIfKQ
         mcQlzeuY8Nk8rJmzVAteLLb5p65wBtSFLuEqqn7D1lHle8DHTDqDlaKkQ8/h/KmiH4XB
         SX4FbANi3GandMGDd544Fp0ozZcaREQQSHTXQEHK2+ELEWUD4Cux/FXAwLC7fQq9ZWIn
         VoGw==
X-Gm-Message-State: AOJu0YwspczeIjBcNSWrWd0K60XFLHLwsxsWzwTS5+asHbTnSdUAt6Df
	ZMzTwYQgFF5BuHDPptDTrcTrqvgMgQ0mfMXZ/gfua6YoMIiBhtBqywgCcXb17rF3U++316CX5sH
	+
X-Google-Smtp-Source: AGHT+IG9Rij3GV3AvhS8/gHaDIBHzVZNeS/qRg41WD1ilZnkGyrSf4ZGr67ktcUGtkFnv9o6bCtsNQ==
X-Received: by 2002:a05:600c:474a:b0:422:8557:2ef9 with SMTP id 5b1f17b1804b1-422865ac148mr12520255e9.30.1718180435895;
        Wed, 12 Jun 2024 01:20:35 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:8d3:3800:a172:4e8b:453e:2f03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4229207d1a7sm6011775e9.1.2024.06.12.01.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:20:34 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v9 2/5] PCI/pwrctl: Reuse the OF node for power controlled devices
Date: Wed, 12 Jun 2024 10:20:15 +0200
Message-ID: <20240612082019.19161-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612082019.19161-1-brgl@bgdev.pl>
References: <20240612082019.19161-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With PCI power control we deal with two struct device objects bound to
two different drivers but consuming the same OF node. We must not bind
the pinctrl twice. To that end: before setting the OF node of the newly
instantiated PCI device, check if a platform device consuming the same
OF node doesn't already exist on the platform bus and - if so - mark the
PCI device as reusing the OF node.

Tested-by: Amit Pundir <amit.pundir@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD, SM8650-QRD & SM8650-HDK
Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # OnePlus 8T
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/of.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 48ba95e4ab05..dacea3fc5128 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -6,6 +6,7 @@
  */
 #define pr_fmt(fmt)	"PCI: OF: " fmt
 
+#include <linux/cleanup.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
@@ -13,6 +14,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
+#include <linux/platform_device.h>
 #include "pci.h"
 
 #ifdef CONFIG_PCI
@@ -25,16 +27,20 @@
  */
 int pci_set_of_node(struct pci_dev *dev)
 {
-	struct device_node *node;
-
 	if (!dev->bus->dev.of_node)
 		return 0;
 
-	node = of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn);
+	struct device_node *node __free(device_node) =
+		of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn);
 	if (!node)
 		return 0;
 
-	device_set_node(&dev->dev, of_fwnode_handle(node));
+	struct device *pdev __free(put_device) =
+		bus_find_device_by_of_node(&platform_bus_type, node);
+	if (pdev)
+		dev->bus->dev.of_node_reused = true;
+
+	device_set_node(&dev->dev, of_fwnode_handle(no_free_ptr(node)));
 	return 0;
 }
 
-- 
2.40.1


