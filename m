Return-Path: <linux-kernel+bounces-232679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FFA91ACCC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1CD288D98
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ADE19AA48;
	Thu, 27 Jun 2024 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="cGY8//Ti"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7078619A2B7
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505760; cv=none; b=org0vtsIPqeiPqZbdDpIDGmYICjyoDBAmjZD/whDfKt63yDNsAtgWjZfi1K6NQS/7o1TaHTYKeZ9Ji+GVDnuui5YvOuH8uazbFc7Pl0AFSzklNMxWJ8tGXH+BdNcU+DpZlA/q7DGFq+rbxUus3HCqINpmG7ciFqMyg4HVXFO7M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505760; c=relaxed/simple;
	bh=XvGqbx6PQp8f844mWBPvMecz3kVkfoFZ3ReBD72GOko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UOQgJzOcFfylRYsuEm3FZp1iBj4GUxIlLMGj/FiAriWXaVAc4vyqTxFWg9BIaPL3gn4/f9viHWcRkfuRpWTzy4OOA0KKpgYZhEid116PGVI1HY18xpIfI7Hl+NBXvg6Yf9Ns+FSN8Jn6A4RnylpTL6g2tGKvVVXOpmv5TKoaRJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=cGY8//Ti; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f99e2dc8cdso8598135ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1719505759; x=1720110559; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeUpsO3LRVz0DWVCIRPfUEx9NS9Phcthbxa0dOGg864=;
        b=cGY8//TiqG4hWZp0BaBoLYGf8+I/fJCd6e3WgWFIF2cTies108wDDJTa/MUHheXOAt
         tkdMAF0UC7Y4HE3QTfNEIqFCo6YUinvDbTGAubEXmJmIaIqq/1+yQt4BJOBujx0hv88R
         uLn/tMWYVuPI2JOJ8Gaow5lwdARGY4/VJ56+ha8Hjxf/qVUFP2sExXUD2sSJ9ilIIjS6
         2PMTd/xuZLY19Zoq4MWnVO3IpEteG+5yPfRv4tnaetNfhWEPWqASln5/GHVmjNqLemv6
         v3rR2jedfNACOzbDUyyU6YX2j5HB7K8Zg+vApvKRs7MaMXycSGpOdO7uokRBcPIC8QZw
         LH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719505759; x=1720110559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeUpsO3LRVz0DWVCIRPfUEx9NS9Phcthbxa0dOGg864=;
        b=O8oWZjN+cQKjT89PA0g+lm9fXyOACWQOL3i8eNr3v7yLelaT8ISAizKgX77bVF7LIx
         TItxPiW8dNHsK3Bc6iW6xgQRtUnDaSQlPp6fP0aRu0uxBn9FKVjunHUT0R72tL8KO2Yt
         PK8IRbj2IDLACLoxKzswegUVaSbIDlV9lCh/FBQPs+UQO/pMDwi8nu1ri4ImELfyKgY1
         FsTBXsUPpIc60yOXqAVT7kd5JE1NahHRCk/OuJ3PTT8+NApSLcgkDNge+tjbT9r9/xzz
         MTvMgm7uTos1jEeD7tfNE7RcvK68+9QeBoRN1NjXsC5zVm0cqqYbXiMpgh86bJohSgZs
         IV+w==
X-Forwarded-Encrypted: i=1; AJvYcCXqAQmt2OQZYlo+foE++nTpevjXMvx6DcxS70/sVMbFX1Zd67MZgYJbb8FlJWvAspNqu/XWO0FWgE1/Zu74EI3YGAsHH/iPMV5Lg9KO
X-Gm-Message-State: AOJu0Yz7BNmzsD41Sgjhu4OL+wyEBI8aqSyZAKoGgvCpv1tvDPP2GKJ/
	h1wfRLM+2aXVsUNgj/gru31sYXIHdeg09YHV+WkxhGCmXb6VwLx1mgmRmq2CNw==
X-Google-Smtp-Source: AGHT+IHbEm1F9egL6S/rR3CsIzTMisY42T+/Lsbxvt3sKTUuzPOqGuGmmOan06Ef0cGA9WzFMszx3A==
X-Received: by 2002:a05:6a21:191:b0:1be:d897:797a with SMTP id adf61e73a8af0-1bed89779f9mr1604844637.5.1719505758883;
        Thu, 27 Jun 2024 09:29:18 -0700 (PDT)
Received: from [127.0.0.1] ([2401:4900:1f3e:18b0:e4e6:ed1:4c03:dcec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b4a58dbdsm1560739b3a.198.2024.06.27.09.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 09:29:18 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Thu, 27 Jun 2024 21:56:15 +0530
Subject: [PATCH v5 5/7] spi: Make of_register_spi_device() available
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-mikrobus-scratch-spi-v5-5-9e6c148bf5f0@beagleboard.org>
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
 Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=XvGqbx6PQp8f844mWBPvMecz3kVkfoFZ3ReBD72GOko=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBmfZM4NxJtL4N2ETEWuF7h6QH3spah6hXCZAD9+
 AKPJ1wVgCCJAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZn2TOAAKCRAFzvXHieVa
 dDEYD/9ORM2M+wPDI/+3JsWhR/TBeOz4zPH5zk5O2EQnjY22bvBJ1Xwpw8SPL+I2ggu1Qlge4k8
 1oIIdZeuEHPkabwou1iWkmeax6k50uNYHdN+LFRDTzjmx+S8KWq+scXijT9sWhuUypOLxJRssub
 HKJHtp+f3bK0JyfmcDtnyMz+ZSYR+wnleKZRw1VoBT3ULh5H5wVNHXIZU/syWxRCmuz+JAA1VBZ
 1pR6bfrIRktWYtLhbiuT1wEzvuHkmgoWzsbJPItMO0Kkc3ZqR5Oydprn4bN9dtf4Nz6BsbdoIX3
 vzaGWhkoC9JWF79uqboWBWt72HwgPTUsv91q5wf3puNBUxpAPmVR4qUCui+nywtXqrue/S23q1S
 DAMYKP9Myd7PdDvRx9aLzL6F4DRY+doeb8eyrVbGqqCFb0Iv2eY5ymN9OT/6ZayLyn0t8hCCHmZ
 a7Iej00On+qGkW9l69u5EbuTDTRiKsTKVen1/6OO8MT4PTTiuhwxF0Ypqedp0fkOZH3TQ1UODeS
 YC4KgterW4VKPHkDYBP2sk/hJ5NUAxWKQnVmwNCBlA54t9rpoujo1u0Iswdklq/ilUY45yO08QG
 IO69LYpPkgEOtvhwIthAPvB/7mvOwITrNM1cZOZJ1QBeX1CoUXUDW4cadI5QbZ+gTriOkXNFSsJ
 9og9h5aChNFWZvg==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

DONOTMERGE

Export of_register_spi_device() from SPI Core to allow registering SPI
devices from device tree when the device node is not a child node of spi
controller.

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
 drivers/spi/spi.c       | 3 ++-
 include/linux/spi/spi.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 565b2e2dd5b9..8cd4d61958a2 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2566,7 +2566,7 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	return 0;
 }
 
-static struct spi_device *
+struct spi_device *
 of_register_spi_device(struct spi_controller *ctlr, struct device_node *nc)
 {
 	struct spi_device *spi;
@@ -2612,6 +2612,7 @@ of_register_spi_device(struct spi_controller *ctlr, struct device_node *nc)
 	spi_dev_put(spi);
 	return ERR_PTR(rc);
 }
+EXPORT_SYMBOL_GPL(of_register_spi_device);
 
 /**
  * of_register_spi_devices() - Register child devices onto the SPI bus
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 58e692226475..861b1cb4cca6 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1686,6 +1686,9 @@ spi_transfer_is_last(struct spi_controller *ctlr, struct spi_transfer *xfer)
 
 #if IS_ENABLED(CONFIG_OF)
 struct spi_controller *of_find_spi_controller_by_node(struct device_node *node);
+
+struct spi_device *
+of_register_spi_device(struct spi_controller *ctlr, struct device_node *nc);
 #endif
 
 #endif /* __LINUX_SPI_H */

-- 
2.45.2


