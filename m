Return-Path: <linux-kernel+bounces-353288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBB9992B99
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4269B281172
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989A01D2B24;
	Mon,  7 Oct 2024 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HMVPdWPx"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8621D26EE
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303847; cv=none; b=C8isZj2Jlyq3U0KqbD4+iCRYs9V7i4Zet4wZn+qNLXQuUS9pTr7qvr05Y3w7hywgwFUoEu7Z0wl5AF3wapYa8EUIHzew0ZwRX4U5KswFJkRcg+cLtmr9el2e6HXOKbDs5Godbrmavl8WlZaMla+t2PBgGuneWdjAVUljZMMFce0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303847; c=relaxed/simple;
	bh=gG0Kl0JZgDzMtPQi0iW2OUfad0iNnu1PE2ZxUL4VzyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZpJUirZIxnthKcoLVz1jQV6w0Qyj0sQHrXNS1He9i8bW1KaRiKXAeU0/5D4NNEHu+pbBwCWUCW07nbCej7XWtIiDK9Uc+HIyKJZaiz5GD5EMuTg2b7FVauVwmMVz6e631W+8V1UfKvDsrIhelHzXZYmjAkIBXwtmwIfiLBxZdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HMVPdWPx; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37ccfbbd467so3217258f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 05:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728303843; x=1728908643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGEx0PqXJtkFOmfslpcNhDWKLxmXujVpKffyfiMkAQo=;
        b=HMVPdWPxq/nUt2n2J6aFMICveRu4GOnspda1Kkep3yma13XW0pn3ZsDVWo0O5nm9K7
         HWPxnL4YwuBkMwEGqGv10qHigl1FUH13qBOSwnAUdwd48egJDNxWD+1KtW3qM2DQ+vgc
         SGKaHyI09TlOo0deNQH/RY+ZJxER55ggXmHQD156rINq4XR22tgMvPKQDHYkpSvZZt2z
         rlYC8gC7oW5aH8hLVk0VhRnhPuQLuZC2GYtofTol8id+HQnCmNpPdQsQzdNK0pdGkjlo
         QqsY2Rl7tq/AqS+bEIHonilIuj6Z3WehmPCJnoIUD7E8zRdAg+cBAjfQdf4OAC95X0uT
         x6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728303843; x=1728908643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGEx0PqXJtkFOmfslpcNhDWKLxmXujVpKffyfiMkAQo=;
        b=NmPXHQKvx+QV4s0fS/TelCatKRLZE/t9DlYi0+vCTUz5d01nsOHBj6N9lscxRKAzEm
         J0XmrsI9FkvaA4nvhVw28Df+3/L56ynjf2A/qL0nfiCADTselQbPOJTu+sDu9kB9vA+t
         /8NQwzNrKDLMi2jI1jKuJR2sNCGJupxCIF1xXW0L3/UltgJNfRZGwqQBxpZFwEpb+tw3
         GneTJUj7BEwI62plH4fKdVpbhgBK1zZmggFW8c81vuWdvLd+PBiNQaDRMRc5QsRoVWWT
         pX8FwEfZqinx3Km6mxo5HHXMutrAatjlaouF6ww2o+I6LggPAl6a5IQkBmqUhDkLEPce
         ilVA==
X-Forwarded-Encrypted: i=1; AJvYcCWZPTx9Z1Ji/+bo6wn+WQDsavKoKUOGq6PE8a1kTVr9J4ApDEyD1j9tmi2uv2xkACbMGtn5LSuwrzPwRWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5w1oZxgc5qqzkHhBqaNKc5fMF11K/bJ6Kdkrlip1du+kFVyqe
	6O+vGMDgnCC0B27NjvOX0DGT1FSiGrEfR8VR1+0iLWEEpIjzBVhEIs9zXCJeDiQ=
X-Google-Smtp-Source: AGHT+IG3223yd5krdGXCAeXQtchm5yoDR1rjmKlsg43mtdR4eUr7d5W6MmDV+vaoAWxHhdsKeuM+aw==
X-Received: by 2002:a05:6000:4586:b0:371:8a90:112f with SMTP id ffacd0b85a97d-37d0e8df590mr6469416f8f.44.1728303843426;
        Mon, 07 Oct 2024 05:24:03 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6100:637:cbe9:f3bc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1695eee7sm5626914f8f.82.2024.10.07.05.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 05:24:02 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 3/3] mtd: rawnand: davinci: use generic device property helpers
Date: Mon,  7 Oct 2024 14:23:50 +0200
Message-ID: <20241007122350.75285-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007122350.75285-1-brgl@bgdev.pl>
References: <20241007122350.75285-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There's no reason for this driver to be using OF-specific property
accessors. Switch to using generic device property interfaces and
replace the of.h include with property.h. This allows us to no longer
check the existence of the associated of_node.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/mtd/nand/raw/davinci_nand.c | 42 ++++++++++++++---------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 6c884b59bc98..aa7619eec59e 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -16,8 +16,8 @@
 #include <linux/module.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/rawnand.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 #define NRCSR_OFFSET		0x00
@@ -490,7 +490,7 @@ MODULE_DEVICE_TABLE(of, davinci_nand_of_match);
 static struct davinci_nand_pdata *
 nand_davinci_get_pdata(struct platform_device *pdev)
 {
-	if (!dev_get_platdata(&pdev->dev) && pdev->dev.of_node) {
+	if (!dev_get_platdata(&pdev->dev)) {
 		struct davinci_nand_pdata *pdata;
 		const char *mode;
 		u32 prop;
@@ -501,23 +501,24 @@ nand_davinci_get_pdata(struct platform_device *pdev)
 		pdev->dev.platform_data = pdata;
 		if (!pdata)
 			return ERR_PTR(-ENOMEM);
-		if (!of_property_read_u32(pdev->dev.of_node,
-			"ti,davinci-chipselect", &prop))
+		if (!device_property_read_u32(&pdev->dev,
+					      "ti,davinci-chipselect", &prop))
 			pdata->core_chipsel = prop;
 		else
 			return ERR_PTR(-EINVAL);
 
-		if (!of_property_read_u32(pdev->dev.of_node,
-			"ti,davinci-mask-ale", &prop))
+		if (!device_property_read_u32(&pdev->dev,
+					      "ti,davinci-mask-ale", &prop))
 			pdata->mask_ale = prop;
-		if (!of_property_read_u32(pdev->dev.of_node,
-			"ti,davinci-mask-cle", &prop))
+		if (!device_property_read_u32(&pdev->dev,
+					      "ti,davinci-mask-cle", &prop))
 			pdata->mask_cle = prop;
-		if (!of_property_read_u32(pdev->dev.of_node,
-			"ti,davinci-mask-chipsel", &prop))
+		if (!device_property_read_u32(&pdev->dev,
+					      "ti,davinci-mask-chipsel", &prop))
 			pdata->mask_chipsel = prop;
-		if (!of_property_read_string(pdev->dev.of_node,
-			"ti,davinci-ecc-mode", &mode)) {
+		if (!device_property_read_string(&pdev->dev,
+						 "ti,davinci-ecc-mode",
+						 &mode)) {
 			if (!strncmp("none", mode, 4))
 				pdata->engine_type = NAND_ECC_ENGINE_TYPE_NONE;
 			if (!strncmp("soft", mode, 4))
@@ -525,16 +526,17 @@ nand_davinci_get_pdata(struct platform_device *pdev)
 			if (!strncmp("hw", mode, 2))
 				pdata->engine_type = NAND_ECC_ENGINE_TYPE_ON_HOST;
 		}
-		if (!of_property_read_u32(pdev->dev.of_node,
-			"ti,davinci-ecc-bits", &prop))
+		if (!device_property_read_u32(&pdev->dev,
+					      "ti,davinci-ecc-bits", &prop))
 			pdata->ecc_bits = prop;
 
-		if (!of_property_read_u32(pdev->dev.of_node,
-			"ti,davinci-nand-buswidth", &prop) && prop == 16)
+		if (!device_property_read_u32(&pdev->dev,
+					      "ti,davinci-nand-buswidth",
+					      &prop) && prop == 16)
 			pdata->options |= NAND_BUSWIDTH_16;
 
-		if (of_property_read_bool(pdev->dev.of_node,
-			"ti,davinci-nand-use-bbt"))
+		if (device_property_read_bool(&pdev->dev,
+					      "ti,davinci-nand-use-bbt"))
 			pdata->bbt_options = NAND_BBT_USE_FLASH;
 
 		/*
@@ -548,10 +550,8 @@ nand_davinci_get_pdata(struct platform_device *pdev)
 		 * then use "ti,davinci-nand" as the compatible in your
 		 * device-tree file.
 		 */
-		if (of_device_is_compatible(pdev->dev.of_node,
-					    "ti,keystone-nand")) {
+		if (device_is_compatible(&pdev->dev, "ti,keystone-nand"))
 			pdata->options |= NAND_NO_SUBPAGE_WRITE;
-		}
 	}
 
 	return dev_get_platdata(&pdev->dev);
-- 
2.43.0


