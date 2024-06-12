Return-Path: <linux-kernel+bounces-211170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B87904E04
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD03EB23EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AD416DEC5;
	Wed, 12 Jun 2024 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Dyb+QMyY"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5FF16D9A0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180442; cv=none; b=KjfzI1NZv2JRwgcM/shvzpkyLR8p4X4JQmG4n2GLhpRC1FvZfcZ6wuXzGO792YkeOOr+j1VBsJnI2Dtefal6YaKbERw6iuTyQt1eh3tc9+LuXSN552Cu1/Xto7XHXdEyIIDO4ZmfRVhmg9fVN1e5bw5ik1uqlp3o6UtRhSfNscQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180442; c=relaxed/simple;
	bh=7VTZIUP9nLWj7cfEX4XfkS/W4JY/pRDIPDXFaZGz00o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCjU6tUExtgKi1l6nNLI5z8kYDFHG76kk1Lr+6t72VQwZi9pNDBbKdim/NnMcB5cTj1dB5nYvN/ybzG3sALtdkEwPFiT9CSw+Odjg+hL2EQ+kKA2Cwcl6WsSUiLiWGWHUEpxG1QTZNQ3IsTlAd/lzWGA9b15GVPufgB3gP7Ef48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Dyb+QMyY; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35f2c9e23d3so396021f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718180438; x=1718785238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RO4KK4ghKfkxpXvlbkG5KB2nyFFgyIDnrF9c5Yq0jtU=;
        b=Dyb+QMyY92SfPQc4JHqfMBQs3TqFOy1etS9uBVK3HHao5f3WdbuZK58pDKlVAQxmWB
         MrxGj57KHCHM6o6R8loD0mjzXQuT1UsonG056sascQXqktRQjeoBFP+r6KsGB+YfM1ct
         ZdYQPEOuq3CGSeb5HTJzEDBTHbvPSWwePpOKXmzakO3qgraIl8Yd+h+8XUzyoHCYGHsI
         siJUbpUygk6MUKaqI/YG6YkJexgSq4l4EZesegQY/2B5Vo/dyNT1FKmLflR4GyBRNtKS
         kOid3v+FYvSIS+7M0+G0fHRRZZv0BN1HI0qBBKVc0MgdWu1YDNhRHFTVjTq1HcThsy4n
         mIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718180438; x=1718785238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RO4KK4ghKfkxpXvlbkG5KB2nyFFgyIDnrF9c5Yq0jtU=;
        b=tYc05n+95xt+ssWjYhQGWyKrPik7mr8N62fzkpnAhcgkmiOWNCLx8S3jISWzHDCq1E
         lEDPbcf5T4m1gYNA0yDFsPB8qs0v61dipQiSMO3sDXZv8+CNX0QQLFk37iCuRKYnmIAM
         t1IJj2YLy4hMSW0WGbk73v/+OfjrlRLmtxCkke1D0UFI+/JrZptHYCPobXtaNBj+Q0vy
         a7b6Gp5iR8FHJYLwwGnaVKzaHDaFmuA/YouWNL4HUMOKg7Nqhi+BruSISTMfJoxLoHdK
         DagL106hpM1epR5jL1aq0R89oO9D1S/aTwlNeztmeT9N4CxOeN1hpEXN/Yz8GkAiLW6D
         A75Q==
X-Gm-Message-State: AOJu0YyrfHP5IA9W0LBEp7so0P59XO+KNznn/vvmJ/7Bsx/yqa5dh9j9
	X/JLnWe8GWS06YrpM5B2g1SLfGoe05DFLk0icjtF1Pm5nwhL5F+i7RS2oewPCe8=
X-Google-Smtp-Source: AGHT+IEKZ9Pm55ZC6EKvZuzsmQYoUGEHjUjFOoy/AGQANYWcyrqioou452tdej8ico1+a6TdVtsKRQ==
X-Received: by 2002:a5d:61c4:0:b0:35f:20a0:db65 with SMTP id ffacd0b85a97d-35f2b3093e7mr4333679f8f.25.1718180437759;
        Wed, 12 Jun 2024 01:20:37 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:8d3:3800:a172:4e8b:453e:2f03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4229207d1a7sm6011775e9.1.2024.06.12.01.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:20:36 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v9 3/5] PCI/pwrctl: Create platform devices for child OF nodes of the port node
Date: Wed, 12 Jun 2024 10:20:16 +0200
Message-ID: <20240612082019.19161-4-brgl@bgdev.pl>
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

In preparation for introducing PCI device power control - a set of
library functions that will allow powering-up of PCI devices before
they're detected on the PCI bus - we need to populate the devices
defined on the device-tree.

We are reusing the platform bus as it provides us with all the
infrastructure we need to match the pwrctl drivers against the
compatibles from OF nodes.

These platform devices will be probed by the driver core and bound to
the PCI pwrctl drivers we'll introduce later.

Tested-by: Amit Pundir <amit.pundir@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD, SM8650-QRD & SM8650-HDK
Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # OnePlus 8T
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/bus.c    | 9 +++++++++
 drivers/pci/remove.c | 3 ++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index dfc99b3cb958..e4735428814d 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
 
@@ -348,6 +349,14 @@ void pci_bus_add_device(struct pci_dev *dev)
 		pci_warn(dev, "device attach failed (%d)\n", retval);
 
 	pci_dev_assign_added(dev, true);
+
+	if (pci_is_bridge(dev)) {
+		retval = of_platform_populate(dev->dev.of_node, NULL, NULL,
+					      &dev->dev);
+		if (retval)
+			pci_err(dev, "failed to populate child OF nodes (%d)\n",
+				retval);
+	}
 }
 EXPORT_SYMBOL_GPL(pci_bus_add_device);
 
diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index d749ea8250d6..910387e5bdbf 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/of_platform.h>
 #include "pci.h"
 
 static void pci_free_resources(struct pci_dev *dev)
@@ -18,7 +19,7 @@ static void pci_stop_dev(struct pci_dev *dev)
 	pci_pme_active(dev, false);
 
 	if (pci_dev_is_added(dev)) {
-
+		of_platform_depopulate(&dev->dev);
 		device_release_driver(&dev->dev);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
-- 
2.40.1


