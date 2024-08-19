Return-Path: <linux-kernel+bounces-291684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4556795658B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01AF8282F52
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AE615B14D;
	Mon, 19 Aug 2024 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fhuborTy"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2918F15B0F9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724055892; cv=none; b=T9O/8CpUuuOCUqBVqcZL2pEx3SrvBfqxvw2vbfMuim8KsMk+qi9bCUELyoXdZN/d+vL/L9NhpKlwmPag/xD32u27p6fUTOFVZILw2twFBIMTIzukTWqHLEeGsKj0KA3W1uOqdr0khYnAi3tFn6qNzqrynmGIFijvXLG1df/dStg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724055892; c=relaxed/simple;
	bh=24lOSJFmDWSkbEY8pH1NA7VSnBzPb51HRS0H0RNheRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVcGyHxcVTldv7mxNFbI6CfSDEd7ONNKFyyHIEKra/EZ1WydtuTeuwrCX5C85iIx6wIifVlLGrxWucvrf/DssbsOoIaXgrjj+6dMVS3EPUL683Y7VDK3oD/JFaa41vGBEepPM3GX5g84kiSPQgVpcQa4xSTnwQ+K95WgRxuY2Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fhuborTy; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-371a9bea8d4so884246f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 01:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724055889; x=1724660689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsWIrIhsv9dmLthRnTrPqZ1IbzhzCJfuEFPNZfJR6+k=;
        b=fhuborTyYqccLryBrNrsKUm2N+QK+jV1abwJRKSzHVa5d2xUPhz/GA3wQDQZ9a9Bgr
         av6loILOl3aqiBnPxdKyCqe6ByMej7zmSHApJwTQoZMPDz9makerFx2IZqO4nFCBP7de
         IYC+ur8IByK4kRVClOormeYqZ/4cyakRQBUXqoXCPCiQ2jLLnULF+tkC7YY3lB3j9VaO
         MCghMcw6ECTxtOzrIX/XqjR0S3IS08rtLhHoVIZQL7Htg5wvdDH++fz92Gmt8YI+GvnW
         TdipLYPszOoCWiMYQUymbZ2BmzByIsNj4u0b+yLDdefI7zqxlSxl4EGUc8yZj5ngef8f
         syCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724055889; x=1724660689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsWIrIhsv9dmLthRnTrPqZ1IbzhzCJfuEFPNZfJR6+k=;
        b=dbC1eWFemzHdaAR6MsF08QXNHaXMfdtZIYzpsZV+QSTLLwUO+JnGrfJlUn3AtxHcQA
         dq1AgDnJP5NDSQgXxZIzopC+OUdBh/E7ncKmOd9ZaWfPYzBT5LN9OxyNg+OWTvStMGhp
         F5q0jC3EIMavV6ui3c/q7ewtSLv7/8qwbzNUvuJO5LNp/+IOhSGENCoOAnFbzKpEbx3n
         GAhwh48WhK/wdaNEyklwiO7n4dEKq/eG9J1ZhITIYIC92PJIlobNpPa+DJtFblLrdEot
         e7FnT8hr99poKTWguRk/Wbbw4f13rbZNPkXdTGQVpaJVn3V3I5zyvzTeUVinC7VueRy9
         NqJg==
X-Forwarded-Encrypted: i=1; AJvYcCU/Jiwc2OdaJJc81kgbBw0X5AGQYUbzi67QYSNZIHjCmdjvExqHRdGpz+uaz/vBXQO6ndTyb2UU4TBxAfrL+A9VG1KfyGg6Fl/F67Xh
X-Gm-Message-State: AOJu0Yx96QFc3+GI++6YwTJzuvrOAHV8wdWSMRP6L9Mfl69SMLG3sU2+
	06Q9Tjx8REXI1hzypPrXhu2HwLdGNIJzWKvnUCIf4gWwsTP2ImObRLjvP3axGsQ=
X-Google-Smtp-Source: AGHT+IG3x4XBmoZj8H1/pCkgv2vjfiq22n06VmxlFxNkSHZodygEHM7HxQYQNuYyUVRiIJ17qglPgA==
X-Received: by 2002:a5d:6602:0:b0:371:939e:9845 with SMTP id ffacd0b85a97d-3719464595cmr5946403f8f.23.1724055888810;
        Mon, 19 Aug 2024 01:24:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7b55:8f70:3ecb:b4ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7d5a9sm153441175e9.43.2024.08.19.01.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 01:24:48 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 1/2] PCI: don't rely on of_platform_depopulate() for reused OF-nodes
Date: Mon, 19 Aug 2024 10:24:43 +0200
Message-ID: <20240819082445.10248-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240819082445.10248-1-brgl@bgdev.pl>
References: <20240819082445.10248-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

of_platform_depopulate() doesn't play nice with reused OF nodes - it
ignores the ones that are not marked explicitly as populated and it may
happen that the PCI device goes away before the platform device in which
case the PCI core clears the OF_POPULATED bit. We need to
unconditionally unregister the platform devices for child nodes when
stopping the PCI device.

Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF nodes of the port node")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/remove.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
index 910387e5bdbf..c7092a34a5f6 100644
--- a/drivers/pci/remove.c
+++ b/drivers/pci/remove.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include "pci.h"
 
@@ -16,13 +17,26 @@ static void pci_free_resources(struct pci_dev *dev)
 
 static void pci_stop_dev(struct pci_dev *dev)
 {
+	struct platform_device *pdev;
+
 	pci_pme_active(dev, false);
 
 	if (pci_dev_is_added(dev)) {
-		of_platform_depopulate(&dev->dev);
 		device_release_driver(&dev->dev);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
+
+		if (dev_of_node(&dev->dev)) {
+			for_each_child_of_node_scoped(dev_of_node(&dev->dev),
+						      child) {
+				pdev = of_find_device_by_node(child);
+				if (pdev) {
+					of_device_unregister(pdev);
+					of_node_clear_flag(child, OF_POPULATED);
+				}
+			}
+		}
+
 		of_pci_remove_node(dev);
 
 		pci_dev_assign_added(dev, false);
-- 
2.43.0


