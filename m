Return-Path: <linux-kernel+bounces-286657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C84951D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9102C1F21298
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD561B3F01;
	Wed, 14 Aug 2024 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYq8n8+S"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDD61B32BF
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646293; cv=none; b=ELgTzfgBZt9yUESkbYE7rZD4lQiv0vUiVftcPbmKJx/qx7TwLHUDP1h1tDXUQ3KW6hT7QWAYmcSRTg+3whj0Pqyg5sh2YLxssKJr0Z7mdlN+gypk1ZgBwsiLUImWh/R7lC6zIH3mXwRJ3taMLRLVfBkXYesEwqYlVJDk5r9UTh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646293; c=relaxed/simple;
	bh=3C9sDsuNmN5dsBAPIyEtXc69OWMzSrGVnjgwXX4ZS8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jn0Wvlv8OsFG5Vso9PrfPu6tDrkABGgRqBozEOUdM2+i8arjjbfZVaZ0SkZ3J/zyRELuPxHGa24/gTAeKENzUjXugfHxBuYVHV2d5PnNcpkOii6VOi28VMy2GEAYlOyqKPy3uCcoYy5xweM+bN51pT3GCJwOqYwEWtsP06M17Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DYq8n8+S; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-367940c57ddso4000383f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723646290; x=1724251090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mJ7y9kq+0U5TtPwB6PI3f0VcMiF6i1YIq/oK4o32aJQ=;
        b=DYq8n8+Shk39QS6DQTFec3VO425Zq13rFSlrjH/ubt8I/ejpexMdFDrYceiHMI6/o0
         apRQg5V6DmAIyj6ZBhq0wWwTm4wfgZZLRm62wSaQ79vZ99T/FJSeqRIiiUyKyRtErr/i
         iSaeDOeYu+o5wSY1nBoKhRjRDFZiGplMOID5CzH4HQfyH1aWBXOVv4weRV9kcr4S2oo7
         DJCvwp3GebVjPtsOHFuYz12OrGmfwfVPk293qg8njhN07AWlPINn7eOsrjpH7mbCEmU5
         nTCgOkKS7nhavjjf0Q2e/kNFkdMyF9nVvcecNGtIXAUBHIS9CaHhb4W+x1q+lZ7HMTBs
         VNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723646290; x=1724251090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJ7y9kq+0U5TtPwB6PI3f0VcMiF6i1YIq/oK4o32aJQ=;
        b=c+1GIhm21xw7wqeqrtZE/a37Hx5PdkskF4ueBnwPPNRRLNu8pE/LJzBS71O3SzSHiN
         jF3G7+KenBKEeyFqHhTncQb2vezg9rLmmogrorCPSZx8evyYG00MSxPCFodtZOa8gukY
         e6fyjk5hY+oa12NPfEidbHv793lDMhZtn0LJXDd3XSVgvNDXSzKocHgSeYrUe4PDexOQ
         ze9j2vHQUdUsTCpm2jt/TPi/L3Xnq6TfI6JrZ1zx6gq2YFEANnO314edir14N4D359sC
         1ynBEDXw6s5wJRX63SyTROHT3TZB4joU3hQXO1xuTAxBPkevYQUF+T+dknnC4edkOco3
         +V6A==
X-Forwarded-Encrypted: i=1; AJvYcCVBQWDOa6F+FKzxq0mQl1bZ85IpofRoe75m7UbN9AE61O5cXJseBoFLEGeSjUGTy2D2Vs9QbOOXlqA0bQqHiXqwWHTbiVfGyZiFss7W
X-Gm-Message-State: AOJu0YyUwuHFc9NdkUDVXfFqrEz15CxVbwt5SeB/sVBeNKGSJ4vaAjK8
	vVwpzqSkNpaMKI15nn7XXWINyO8DEq8mm85kD2AHdCb5LizXg4m3D3eGOp52xQg=
X-Google-Smtp-Source: AGHT+IGJxPY/VQIeXxWEF0kHpYxBVoARtRKch9O8Y4tth5MUPOgrnnXR2EvLBNXZdgU1mMmSfBGe5g==
X-Received: by 2002:a05:6000:d42:b0:368:5b78:c92e with SMTP id ffacd0b85a97d-37177764092mr1943457f8f.24.1723646289611;
        Wed, 14 Aug 2024 07:38:09 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36be4dsm13080839f8f.14.2024.08.14.07.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 07:38:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] spi: cadence-quadspi: Simplify with scoped for each OF child loop
Date: Wed, 14 Aug 2024 16:38:05 +0200
Message-ID: <20240814143805.98874-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/spi/spi-cadence-quadspi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 05ebb03d319f..9c0a4fa5128a 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1662,23 +1662,20 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
 	unsigned int max_cs = cqspi->num_chipselect - 1;
 	struct platform_device *pdev = cqspi->pdev;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	struct cqspi_flash_pdata *f_pdata;
 	unsigned int cs;
 	int ret;
 
 	/* Get flash device data */
-	for_each_available_child_of_node(dev->of_node, np) {
+	for_each_available_child_of_node_scoped(dev->of_node, np) {
 		ret = of_property_read_u32(np, "reg", &cs);
 		if (ret) {
 			dev_err(dev, "Couldn't determine chip select.\n");
-			of_node_put(np);
 			return ret;
 		}
 
 		if (cs >= cqspi->num_chipselect) {
 			dev_err(dev, "Chip select %d out of range.\n", cs);
-			of_node_put(np);
 			return -EINVAL;
 		} else if (cs < max_cs) {
 			max_cs = cs;
@@ -1689,10 +1686,8 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
 		f_pdata->cs = cs;
 
 		ret = cqspi_of_get_flash_pdata(pdev, f_pdata, np);
-		if (ret) {
-			of_node_put(np);
+		if (ret)
 			return ret;
-		}
 	}
 
 	cqspi->num_chipselect = max_cs + 1;
-- 
2.43.0


