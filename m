Return-Path: <linux-kernel+bounces-213652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E34C907862
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC561C238BA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFF714830D;
	Thu, 13 Jun 2024 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eFs0LCY7"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06842143C59
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296452; cv=none; b=m4GeymH1YY+DvN3ZAPA++49zJvqZtduA6M9MKdGYvP399Vr1rOamY8T3UdtGn126gJcm6fWL5NlhRcOlLQef5+WpDhO97rF+zIBwGCHmcsDv1gT9bt2eKVRcPOlDhDyp2kGecldw1FoDEas+4YR+jI1h2Qjvy8KRpAv9xODm6wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296452; c=relaxed/simple;
	bh=TH6yUbejSw9+JlXPysbovmJBDZzKEu7WvN4dTHb6Tok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rL4sDjnfAZKSZtc3CuR43EdJP/bfw0bbaGxPX0oedrKYE2dTS/cRR2m2eP02ggt0GCbaeaFc+VwK1a+Qu0MhuWDLXKicKn1Qgxfeo5q5zJ+yRYZ1+FUYS5vVjQ7YPpc/TmMqMUgRxDLZgkRnvOhmYUqrh2/lnoc1xLjEd+AFeeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eFs0LCY7; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4405e343dd8so5846091cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718296449; x=1718901249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jnTqeJui//cZvCx8TIdIEgkp7fczgV1PTRw+9hdKvO0=;
        b=eFs0LCY79hUWbCNK0mgWjc9pyxmcrLfetrN1J7mIB4gERGy/kIxSHeOirM+Zpc0Tpi
         aE8ORly9Mmv9ZYiJzUigNJYFpTlszXyI+xrteHtw+85jvbFUDWEReYijkuGIVOaRWqse
         q1veWdS4UXOgC43WbbRSc015IbkbbBZBpoAEAAQq9Gj3t4+1C3qRcIHoXan6zIn6qyV5
         hErl5Qzdc8JOcFDM2xUfrrslhQSAoIvJFFx/jzyidItPhY8iDpFX2qYVh/2pFH47lufz
         vakSG7x8kjM8LXQXBc5WDc3bYLqzwRoRm4QNxUfZQ10D85VkekA8FXkrGZuuiD0bEwCJ
         H1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718296449; x=1718901249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jnTqeJui//cZvCx8TIdIEgkp7fczgV1PTRw+9hdKvO0=;
        b=nSKkNPnsH/NZ4ZRzzIm7f7nKFLbcgR5MyMxG4oWeSpNO8YpbYBHcUiX7agsBf+yiOg
         u6PKvF8JSksVjiHYPbhy6o3SaqUzge2qH+899sT5VSWOKOVBzJg00O+HkKHBLfUv0quR
         rnMVA/GE0faw+wkeor9Fr/ARZbPVhDCDRK9fvHce+gImPEWQkYNnYDTKrDzdT8+RKvZV
         jT2xITpKkhiRwzknFSjHkC/+vm/lUo9kxr9HVuTJp80ff7znkY6Idme4NyJtdrtv83Kj
         yx3CDl/IZUibS08h+qOe/mk1Op9TsQKVnenq82ghl6LrPjaaYNnwWxiOiTQ7L64cOrhQ
         KoOw==
X-Forwarded-Encrypted: i=1; AJvYcCVfXylDaBkdcoVMGLDCZl6jXJYdHvCif8WJvhTtSZrSlK0y8UA9NNFO1SPgF44odhWHplNJSH5GAZEVDok1cGWEINCa1Micuyp9+AfS
X-Gm-Message-State: AOJu0Yx96ctLwMnMXyoqIwN6DrXDwj2TxL6/wNLxxMfQNdDx6NCetkZw
	XwZnFyx4hTznzf3sTeXKWddYZt/Pp2toQ3X+Es8Zcbt2GVbTssZFQB3NPInzWlM=
X-Google-Smtp-Source: AGHT+IHuqdhXoaTBFdtn9ov3LvddNezgc3CiIjKhWKx8XUQamhaY/ID6htUbUnQzSxu8vYpFzCveXA==
X-Received: by 2002:a05:622a:4cb:b0:440:5275:d435 with SMTP id d75a77b69052e-442168ad9e8mr1673321cf.30.1718296448835;
        Thu, 13 Jun 2024 09:34:08 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4420f96efbbsm5884171cf.54.2024.06.13.09.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 09:34:08 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: adi-axi-adc: improve probe() error messaging
Date: Thu, 13 Jun 2024 12:34:06 -0400
Message-ID: <20240613163407.2147884-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current error handling for calls such as devm_clk_get_enabled() in
the adi-axi-adc probe() function means that, if a property such as
'clocks' (for example) is not present in the devicetree when booting a
kernel with the driver enabled, the resulting error message will be
vague, e.g.:

|adi_axi_adc 44a00000.backend: probe with driver adi_axi_adc failed with error -2

Change the devm_clk_get_enabled(), devm_regmap_init_mmio(), and
devm_iio_backend_register() checks to use dev_err_probe() with some
context for easier debugging.

After the fix:

|adi_axi_adc 44a00000.backend: error -ENOENT: failed to get clock
|adi_axi_adc 44a00000.backend: probe with driver adi_axi_adc failed with error -2

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/adc/adi-axi-adc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 0cf0d81358fd..99998c2769d5 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -292,7 +292,8 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	st->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 					   &axi_adc_regmap_config);
 	if (IS_ERR(st->regmap))
-		return PTR_ERR(st->regmap);
+		return dev_err_probe(&pdev->dev, PTR_ERR(st->regmap),
+				     "failed to init register map\n");
 
 	expected_ver = device_get_match_data(&pdev->dev);
 	if (!expected_ver)
@@ -300,7 +301,8 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 
 	clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
+				     "failed to get clock\n");
 
 	/*
 	 * Force disable the core. Up to the frontend to enable us. And we can
@@ -328,7 +330,8 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 
 	ret = devm_iio_backend_register(&pdev->dev, &adi_axi_adc_generic, st);
 	if (ret)
-		return ret;
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to register iio backend\n");
 
 	dev_info(&pdev->dev, "AXI ADC IP core (%d.%.2d.%c) probed\n",
 		 ADI_AXI_PCORE_VER_MAJOR(ver),
-- 
2.45.2


