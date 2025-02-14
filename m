Return-Path: <linux-kernel+bounces-514877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D68E6A35CD7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA94188ECA7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28BF263F47;
	Fri, 14 Feb 2025 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUZDzR9J"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09155263F29
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533661; cv=none; b=IaOaVJFAgbsxae+F0FQTVNXPZWRdKe7hnGr1uMDSvM3MOI6ylMzUyzJai1oOff2/RVt3m+9Q0Cr40+7UZUIjZNfGaKRRYksRW21qvxAo2CIC9Cq8XI0zph4MCxaJqPf/HDy5P++6tbG1Q8mF/wF020M8X0K882j302Aw6u+K+Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533661; c=relaxed/simple;
	bh=rUGDhfFDrk0MWHqYT1IWrnxD3W6PCHEf+7PmS9Epz3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFDVnMaS7JQ+SFxuSIkaL/Nr7T/kp4768yVDi2v8powJT0sKmI9psAtrz57w7K/7W8sk+0Tkd0RDoCDbXRAhm1ZURU/K8DpF7mRLizRBPh1OZGnCGxlMtTYIw8xTZzJzlZ6QUTxoSJYiFh2UMnJ4/0Y2f3rJ6pTid3tY+KDf2mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUZDzR9J; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso12243555e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739533658; x=1740138458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUv19RGcYQpZSEBJ0Vtlqw1z83q+vhXACeQec7ri6KQ=;
        b=GUZDzR9Jm/BTYnG5F6PAJBVzXGt9te1Az6115yZPfrtacobcnnzDBIUXrh4TJqrdka
         z7JaBIwwfG4xAcDPwsjNDHUaqsvM/3LRJXHiqt2gD5QcLsM8AtROn7ADZSEjsG435syc
         cdR14y4VFXVm1BEWJnamgwm6su99xNlCKQCtq494kLc8zjkST4GGj0vZVZT822DDC5N1
         YO5OjQIJ9iw0AHi807GzpY2VPVxujTTv3GycOfgiZQRKmNbfjGGUiZGVUwCVJA+JTGq2
         03ZJJulymOqi1eD0zZbQAcc0Xzf61crFl2v9jBOg+SAFTmhUJcmxHPvFJXosthceNcHV
         COkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739533658; x=1740138458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUv19RGcYQpZSEBJ0Vtlqw1z83q+vhXACeQec7ri6KQ=;
        b=piQ90/ksTFnqyNcEqId1xvvMJFNA+2k9FJELvMUQld00lKhqT0cN2y/pGt5R9qFjPQ
         7IwJMUrXPyGsEa3N1wvGd3E9gyVwMkMjP6BMkBPChn5Uuy03T0JqZ1Eix9jsx/cXWSlU
         3hDtmp8POqZUYoCmh5ZENO3kjO/1g7sAPlPSJROOYeRFEwsylPseaiIyp2aYnhWtSvML
         2O0vKPD+Zf712ju2eaLrfHngGA7tnNr08RBZ5AJTi/CrQgY2ABONOMQ85vMNkB9vJ/Kc
         mCcsdC2jB4KNCvTjx/C+JitX+8zVooOHAK5zdoetk4irO7yNePMrgs9hQ9PwFAGsU9pC
         a4og==
X-Forwarded-Encrypted: i=1; AJvYcCVCnWSxVVANO2fSbPdelAit20L1YK9EW3aAatzn8lcMqU3O+bE95yxTz2o4PvOZ57WS7CDDgKgl6lnHVjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH161izUZkD/1A0Iv6AJn2dtwRBfJm1mRLTgNkfXAod42bvNcx
	y+XLkX4AEahKpZxV4gfR035NmmVg07cESwLk0cGvHBFJRSYbhqGh
X-Gm-Gg: ASbGncuFu+KY0ea60hcWJLqiskqQfKNlPuERwvK2s04PLZbScIcCXsYtGZUDwmlCsiu
	hsH3yksOjgTH/r2zZxAxsObQoNqitFcsHhjja7n0Oz67C21poiLrKILZIzLdeKj8j8Z9wXfFD8V
	TA4kNp352+kVTdsFEJGHYZxqvVII97Lw71T6Iuyt3fFsepxTp+gSFkJlTPn8pd0vbtOwFy5gh2F
	+WdHS709DAngVyLTnZAYjvlgD32weX30PAEUwlw3Fe333f/+PIo2/AlUj07MKsdTpKn+DNFD82A
	v7hV3ektXtZLMN8csZM8BXOyAU/eLM5KEZbw+tuckAmYwTaITP8=
X-Google-Smtp-Source: AGHT+IGEj1EojGorZkgQLdLeySDwST5jQV8w0POuV9puJVnFIALlKFtVNBNwfiSpVsq2bxTCXrNkrA==
X-Received: by 2002:a05:600c:4f0b:b0:439:554e:70da with SMTP id 5b1f17b1804b1-439581cbcfemr135289865e9.31.1739533657879;
        Fri, 14 Feb 2025 03:47:37 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617fccfesm41945245e9.11.2025.02.14.03.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:47:36 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 04/17] staging: gpib: cec_gpib console messaging cleanup
Date: Fri, 14 Feb 2025 12:46:55 +0100
Message-ID: <20250214114708.28947-5-dpenkler@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214114708.28947-1-dpenkler@gmail.com>
References: <20250214114708.28947-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable module name to be printed in pr_xxx and dev_xxx
Use DRV_NAME defined as KBUILD_MODNAME instead of hard coded
string "cec_gpib" in pci_driver struct.

Remove "cec_gpib:" string prefix in messages since module name
printing is enabled.

Change pr_err to dev_err where possible.

Return consistent error codes with error messages:
   -EBUSY when resources are busy
   -ENODEV when device is not present
   -EIO for others.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/cec/cec_gpib.c | 32 +++++++++++++++--------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/gpib/cec/cec_gpib.c b/drivers/staging/gpib/cec/cec_gpib.c
index 18933223711e..8f2b4b46a446 100644
--- a/drivers/staging/gpib/cec/cec_gpib.c
+++ b/drivers/staging/gpib/cec/cec_gpib.c
@@ -4,6 +4,10 @@
  *   copyright            : (C) 2002 by Frank Mori Hess
  ***************************************************************************/
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define dev_fmt pr_fmt
+#define DRV_NAME KBUILD_MODNAME
+
 #include "cec.h"
 #include <linux/pci.h>
 #include <linux/io.h>
@@ -284,31 +288,29 @@ static int cec_pci_attach(gpib_board_t *board, const gpib_board_config_t *config
 			break;
 	}
 	if (!cec_priv->pci_device) {
-		pr_err("gpib: no cec PCI board found\n");
-		return -1;
+		dev_err(board->gpib_dev, "no cec PCI board found\n");
+		return -ENODEV;
 	}
 
 	if (pci_enable_device(cec_priv->pci_device)) {
-		pr_err("error enabling pci device\n");
-		return -1;
+		dev_err(board->gpib_dev, "error enabling pci device\n");
+		return -EIO;
 	}
 
 	if (pci_request_regions(cec_priv->pci_device, "cec-gpib"))
-		return -1;
+		return -EBUSY;
 
 	cec_priv->plx_iobase = pci_resource_start(cec_priv->pci_device, 1);
-	pr_info(" plx9050 base address 0x%lx\n", cec_priv->plx_iobase);
-	nec_priv->iobase = pci_resource_start(cec_priv->pci_device, 3);
-	pr_info(" nec7210 base address 0x%x\n", nec_priv->iobase);
+		nec_priv->iobase = pci_resource_start(cec_priv->pci_device, 3);
 
 	isr_flags |= IRQF_SHARED;
-	if (request_irq(cec_priv->pci_device->irq, cec_interrupt, isr_flags, "pci-gpib", board)) {
-		pr_err("gpib: can't request IRQ %d\n", cec_priv->pci_device->irq);
-		return -1;
+	if (request_irq(cec_priv->pci_device->irq, cec_interrupt, isr_flags, DRV_NAME, board)) {
+		dev_err(board->gpib_dev, "failed to obtain IRQ %d\n", cec_priv->pci_device->irq);
+		return -EBUSY;
 	}
 	cec_priv->irq = cec_priv->pci_device->irq;
 	if (gpib_request_pseudo_irq(board, cec_interrupt)) {
-		pr_err("cec: failed to allocate pseudo irq\n");
+		dev_err(board->gpib_dev, "failed to allocate pseudo irq\n");
 		return -1;
 	}
 	cec_init(cec_priv, board);
@@ -355,7 +357,7 @@ static const struct pci_device_id cec_pci_table[] = {
 MODULE_DEVICE_TABLE(pci, cec_pci_table);
 
 static struct pci_driver cec_pci_driver = {
-	.name = "cec_gpib",
+	.name = DRV_NAME,
 	.id_table = cec_pci_table,
 	.probe = &cec_pci_probe
 };
@@ -366,13 +368,13 @@ static int __init cec_init_module(void)
 
 	result = pci_register_driver(&cec_pci_driver);
 	if (result) {
-		pr_err("cec_gpib: pci_register_driver failed: error = %d\n", result);
+		pr_err("pci_register_driver failed: error = %d\n", result);
 		return result;
 	}
 
 	result = gpib_register_driver(&cec_pci_interface, THIS_MODULE);
 	if (result) {
-		pr_err("cec_gpib: gpib_register_driver failed: error = %d\n", result);
+		pr_err("gpib_register_driver failed: error = %d\n", result);
 		return result;
 	}
 
-- 
2.48.1


