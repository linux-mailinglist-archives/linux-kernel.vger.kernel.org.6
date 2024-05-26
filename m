Return-Path: <linux-kernel+bounces-189851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2439C8CF5D8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 21:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80D72811AF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 19:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86840132470;
	Sun, 26 May 2024 19:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K5mU3L9P"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D38131BC9
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 19:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716753560; cv=none; b=pJrB7K3FWYTNftPjgQAHOEk6R4SGH+uqoGG8Tg0yeeTWPCh5NcEY2tqE8ATT2Ci6ZOi5mf3PdkQXByKPAiLsyrYBs9QJdRhH1ILSUxr/t3Ix4xq8HdBd6BlqF8RvR56f1SUAk4p2zaTgqjcZeDnITHSo9dgqfNRWeL8ZRncsVu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716753560; c=relaxed/simple;
	bh=ydmk/YchOc4SHakXg/LL+RjHVED3LNZ1vfW9P27w0zY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qwSbH2nn7PUXqvtuZ8Ng95tHbp9lyR362M5hcB+OkV3RQt83fCYSgpqPEBuLBXC6ELBlwMqrxdTLEVY8CczHKsgYsi4jVGoIevU1LloDygqcxX48dm3m/9VabiRP/Cjpl4dTp+KaB154FHzeIUHahFke8MAIx3TY2T1WkwulMgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K5mU3L9P; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: maarten.lankhorst@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716753556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gt1GZxDNDVzPynPm2Fc/jjTcpRuD3aRfoyoaAWA9e3w=;
	b=K5mU3L9PDVN6Qiciorijzn+pS4JN/fokyXR+ka1VTpYo0plVLSwMop8iUnyDiFXqZxk0kx
	tV5Qsp4klcwmsGJi8LmuE8JQd9u1sgt5RMKgrU/KNdXVRjpNOb5h3dRxIbVC2eBhXLxBOm
	PG4V3/tOCefTN52+8w7InI7hFTPCyt4=
X-Envelope-To: mripard@kernel.org
X-Envelope-To: tzimmermann@suse.de
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: markus.elfring@web.de
X-Envelope-To: sui.jingfeng@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v2 1/3] drm/loongson: Add a helper for creating child devices
Date: Mon, 27 May 2024 03:58:24 +0800
Message-Id: <20240526195826.109008-2-sui.jingfeng@linux.dev>
In-Reply-To: <20240526195826.109008-1-sui.jingfeng@linux.dev>
References: <20240526195826.109008-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In some display subsystems, the functionality of a PCIe device may too
complex to be managed by a single driver. A split of the functionality
into child devices can helpful to achieve better modularity.

Another benefit is that we could migrate the dependency on exterinal
modules to a submodule level with the helper created. For example, it's
not uncommon that some exterinal module will return -EPROBE_DEFER to our
driver during probe time. KMS driver has to tear down everything when it
receives -EPROBE_DEFER, the problem is that it's completely not necessary
and rising cyclic dependency problems if not process correctly.

Add the loongson_create_platform_device() function, which allows the KMS
driver to create sub-devices for it. The manually created decice acts as
agents for the principal part, migrate the potential issue to submodule.

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


