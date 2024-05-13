Return-Path: <linux-kernel+bounces-177061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 516518C398D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 02:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B056281186
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 00:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5E1290F;
	Mon, 13 May 2024 00:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q9ZNveTR"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933EC210D
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 00:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715559236; cv=none; b=VqISJ3v6GGmKGRoKKg4PP+VjEJhwuEcLupulmA8t8hyn+bGYoZOsLElh/ixs38IcZDztCaEv7zF0ZEqbDoekek59FFk6GiEB5hglELOJYGtabaWfaUcsLIqdn2IfVykdPwaXmp0ZMX7dYSYFP/jQkxL4b7dsydmUf9dO8p4hvbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715559236; c=relaxed/simple;
	bh=75IR+SDgGVMZc3p/WH0Rl8DpIbSB3xec2ffzUOQD+aI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DlbkcVw2RZm8JHpn8yzqgWZB+KnT5+1fsMelIOEPRfL5dl4A5kM080mq/PKD4wUMQ1Xrng6LFHEb0XMY8mOsm5kP1lpzR9gx61Rixkwmu39lK36cCUtdN0VEQT3KCBTAiI84DjDnajqfc0MGahWmlALwStVIG11JtkXHVpVk+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q9ZNveTR; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715559232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e3pEj0WWodLS42WTaYGSsqEklXWqCa1MeU3yE8jdV00=;
	b=q9ZNveTRce1txu2wT/QMCvQF8h05xke4kbajjOEKNMXEiMDEBn1GGbSb5PjWYwTuEv7mlg
	MLsmTalfac1oB+TxkA4R3srQA8SWWIIkUowJBJJnh0MMounveE7o+UPxb17A3sG88aaSR4
	CrM769A5sVoVqqeQWZJT5JjMY5RaAvk=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: Sui Jingfeng <suijingfeng@loongson.cn>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH 1/3] drm/loongson: Add helpers for creating subdevice
Date: Mon, 13 May 2024 08:12:41 +0800
Message-Id: <20240513001243.1739336-2-sui.jingfeng@linux.dev>
In-Reply-To: <20240513001243.1739336-1-sui.jingfeng@linux.dev>
References: <20240513001243.1739336-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In some display subsystems, the functionality of a PCI(e) device may too
complex for a single driver to be managed by a monolithic driver. A split
of the functionality into child devices can helps to achieve better
modularity, eaiser for understand and maintain.

Add the loongson_create_platform_device() function to pove the way for the
mentioned goals. Pure software method, no hardware operations involved.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/loongson/loongson_device.c | 42 ++++++++++++++++++++++
 drivers/gpu/drm/loongson/lsdc_drv.h        |  6 ++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/loongson/loongson_device.c b/drivers/gpu/drm/loongson/loongson_device.c
index 9986c8a2a255..b268549d643e 100644
--- a/drivers/gpu/drm/loongson/loongson_device.c
+++ b/drivers/gpu/drm/loongson/loongson_device.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/pci.h>
+#include <linux/platform_device.h>
 
 #include "lsdc_drv.h"
 
@@ -100,3 +101,44 @@ lsdc_device_probe(struct pci_dev *pdev, enum loongson_chip_id chip_id)
 {
 	return __chip_id_desc_table[chip_id];
 }
+
+int loongson_create_platform_device(struct device *parent,
+				    const char *name, int id,
+				    struct resource *pres,
+				    void *data,
+				    struct platform_device **ppdev)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	pdev = platform_device_alloc(name, id);
+	if (!pdev)
+		return -ENOMEM;
+
+	pdev->dev.parent = parent;
+
+	if (pres) {
+		ret = platform_device_add_resources(pdev, pres, 1);
+		if (ret) {
+			platform_device_put(pdev);
+			return ret;
+		}
+	}
+
+	if (data) {
+		void *pdata = kmalloc(sizeof(void *), GFP_KERNEL);
+
+		*(void **)pdata = data;
+		pdev->dev.platform_data = pdata;
+	}
+
+	ret = platform_device_add(pdev);
+	if (ret) {
+		platform_device_put(pdev);
+		return ret;
+	}
+
+	*ppdev = pdev;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/loongson/lsdc_drv.h b/drivers/gpu/drm/loongson/lsdc_drv.h
index fbf2d760ef27..a2c6b496a69f 100644
--- a/drivers/gpu/drm/loongson/lsdc_drv.h
+++ b/drivers/gpu/drm/loongson/lsdc_drv.h
@@ -47,6 +47,12 @@ enum loongson_chip_id {
 const struct lsdc_desc *
 lsdc_device_probe(struct pci_dev *pdev, enum loongson_chip_id chip);
 
+int loongson_create_platform_device(struct device *parent,
+				    const char *name, int id,
+				    struct resource *pres,
+				    void *data,
+				    struct platform_device **ppdev);
+
 struct lsdc_kms_funcs;
 
 /* DC specific */
-- 
2.34.1


