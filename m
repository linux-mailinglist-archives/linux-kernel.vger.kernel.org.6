Return-Path: <linux-kernel+bounces-289524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A8A954722
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C309A283B36
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE141A01DF;
	Fri, 16 Aug 2024 10:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="niBTVg22"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25C11AB53B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805696; cv=none; b=bdUYbUoQbuNse6fnMN1EiDt7xLNBAm4c3r8lq0wvXqd+qIN4zY+scSbArKZc1n86GaXGu0SePwCMrY5NAZb+lPIh3Q6+hGTSjD8kzHIKpdeGDb8oAFDjRVpeRM1p7VsuexB0RK4I6SfsiemcvUKPtQEn4LfWhUtFUWGcaCvtToA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805696; c=relaxed/simple;
	bh=G2yPrpxBXb4PKw54ECzRtlVki76Ov9GcRLuKMdvmvH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uxUX7fRLnlRJfO0TBD7CtpDbebaZJs+1iTlMjUSXNHL6TbMY2a0jNLIDr20YrQEv3zk2Dh7JEq54vvLHudxfxvEoKgxJBkj/p7AcNImiP9ERHS0ACLadZ/SZoxfhh0iNjgadmBdfFOkHOs0l/2ZyQYRyZxWNySy277bWfhdmo30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=niBTVg22; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3718eaf4046so758335f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 03:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723805693; x=1724410493; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xWelpTr/XRUqKFM91cNQuNNebnp+T2/XDk25EhyUnU=;
        b=niBTVg22lY9aUZImJgPjv0lk/YKpJ/RapBh9iJBWUSJuPRH7c3nZ47x7DT5wUuEKfj
         w2VezXX+hT9SPd263L+DOJ8UGRmkVNj8gNpZxDVli4msOgavqZeC1hfSaZAlfWDIH2iC
         hjl66DusiZAg32ssKROwmmVEvHKPOeBa+gRznn3jmdMn7n6IUW6yl7GyXfg29vFYd8CO
         50hSbg5vvnN9939P2l7DfIUVA9+iej1uKXSakGaN3Cm97yjTxMn+No843+A79Dvs8w60
         4LG54cHEFeJHM969yJhJ1LacGZhvfYNJpjYLfUQ32O+Ernj93fKi2kHRmY6hyDSfn7LZ
         QLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723805693; x=1724410493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xWelpTr/XRUqKFM91cNQuNNebnp+T2/XDk25EhyUnU=;
        b=QnphjnmGj/ldbzqYDXad/0XDpDCfJ/VwNvdakOWA8XtskAFjlttPIbGgcBYhGrZQ1M
         FC4ZG7PYUpk/35jiXLS4l91yPesoOTk7Lif9Du/GMccb5U1Q8L5FGmIwoyHqHW9EJKI2
         GpQuLUl0xJqirNsHLNRBTc1/Jrkbn7UA3AJ2xyp//2WBcMZuJOIWOPn4z9w3utikN8Xe
         CNWme2CIrVhXZS9Rm7ALMF4gOZXvOhlgvJux+/z8qOQPM6pbr7B62g5veX54GmWwppW8
         ctdmz+WC2y4rO6gf48OBIRVL/t4yRslD/5CE0leoRemKbYmrDPDUqV2lHKHeycttXATW
         +tmw==
X-Gm-Message-State: AOJu0YzL21GB+jxaD8jbCD317IJhC2GFLUQsEFewJbm3yJB1Nfs3jt3P
	mos9Yj1KRG0iAM4Pgo7wLby3Hqw86Sl074IHmz2bbJ9KQu9CoUpt7+PmXdFzgpg=
X-Google-Smtp-Source: AGHT+IHD6wj7Dw8hXlamLzfXLE0YX9yxmT0kZMl6frJAfF1JNE4GaKBDulB0vb8SdWVJZ+hZ4bUsCA==
X-Received: by 2002:a05:6000:1368:b0:368:6f64:307c with SMTP id ffacd0b85a97d-371943285e6mr2028271f8f.15.1723805693032;
        Fri, 16 Aug 2024 03:54:53 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed7945cesm19461935e9.40.2024.08.16.03.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 03:54:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 16 Aug 2024 12:54:29 +0200
Subject: [PATCH v2 05/13] memory: stm32-fmc2-ebi: simplify with scoped for
 each OF child loop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-cleanup-h-of-node-put-memory-v2-5-9eed0ee16b78@linaro.org>
References: <20240816-cleanup-h-of-node-put-memory-v2-0-9eed0ee16b78@linaro.org>
In-Reply-To: <20240816-cleanup-h-of-node-put-memory-v2-0-9eed0ee16b78@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Lukasz Luba <lukasz.luba@arm.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1947;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=G2yPrpxBXb4PKw54ECzRtlVki76Ov9GcRLuKMdvmvH8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvy/rb4znf7Gc13+IjmByAMk6RS/9zPzPfxYqw
 7Z6nvJ1sLGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZr8v6wAKCRDBN2bmhouD
 18MYD/oCLaJmWOWxy5n36CttxJFqbO51zWjtlcst6hRwuUgHToAatzCC4rqdYj6BqW6udSiOq2x
 MaCjbbXPxz3iOpxzfwcKWbg19No+lmlb1qk/33S3x0U9G2QJPvwticKeSkQ8rVKoCQ0axG/Jk64
 d59f87Oj+o4vvSe7bsarfpHSoxwEgjUVHG5/GvzVue/zwwfqsjCGsyd4eXS+7TCNWhyCIn5arMy
 d8Na9fDtC0X96Vjb5Pz/N289yVyYzZMtPrRDhdCQf0mxVKutUKhovg+VIGQwfBYJn8zh/ZGk66X
 DnuFEXvtDvlbr3h9lprlTzxCx/NRlVE/inFAV0lmj0GkErB0jire5a0G8+2/TMBDPuOTQu67sWA
 AZbrnvBUiv4vNpo9dtFviLw8KmYvUiZQ9VJCtwrVDwAYjtaKvWwu5pUiODcp98nbefbrm3pI2Rd
 THvcNlzPdoge696l78CgQUFoI5nxUVT8pPm4jjf82IsTJTWP2SWRg6NIldGL9doI71w+PQe6u+I
 dn4MAXawWNYuqEYgnvKY6sKASV82gYBZRe+W8jWBdobXx46WliBPxQqeY5WU5WaZe8OQpG7haL8
 DtnPg9H5b0Fdv+igpVtGJ1c7G6tDzTSUiatX/wgxRi1EO61LToCYLGG6PmXswqAUADLuNbXmpWd
 5flfqJkZrR5Iblg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/stm32-fmc2-ebi.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/memory/stm32-fmc2-ebi.c b/drivers/memory/stm32-fmc2-ebi.c
index 1c63eeacd071..7167e1da56d3 100644
--- a/drivers/memory/stm32-fmc2-ebi.c
+++ b/drivers/memory/stm32-fmc2-ebi.c
@@ -1573,29 +1573,25 @@ static int stm32_fmc2_ebi_setup_cs(struct stm32_fmc2_ebi *ebi,
 static int stm32_fmc2_ebi_parse_dt(struct stm32_fmc2_ebi *ebi)
 {
 	struct device *dev = ebi->dev;
-	struct device_node *child;
 	bool child_found = false;
 	u32 bank;
 	int ret;
 
-	for_each_available_child_of_node(dev->of_node, child) {
+	for_each_available_child_of_node_scoped(dev->of_node, child) {
 		ret = of_property_read_u32(child, "reg", &bank);
 		if (ret) {
 			dev_err(dev, "could not retrieve reg property: %d\n",
 				ret);
-			of_node_put(child);
 			return ret;
 		}
 
 		if (bank >= FMC2_MAX_BANKS) {
 			dev_err(dev, "invalid reg value: %d\n", bank);
-			of_node_put(child);
 			return -EINVAL;
 		}
 
 		if (ebi->bank_assigned & BIT(bank)) {
 			dev_err(dev, "bank already assigned: %d\n", bank);
-			of_node_put(child);
 			return -EINVAL;
 		}
 
@@ -1603,7 +1599,6 @@ static int stm32_fmc2_ebi_parse_dt(struct stm32_fmc2_ebi *ebi)
 			ret = ebi->data->check_rif(ebi, bank + 1);
 			if (ret) {
 				dev_err(dev, "bank access failed: %d\n", bank);
-				of_node_put(child);
 				return ret;
 			}
 		}
@@ -1613,7 +1608,6 @@ static int stm32_fmc2_ebi_parse_dt(struct stm32_fmc2_ebi *ebi)
 			if (ret) {
 				dev_err(dev, "setup chip select %d failed: %d\n",
 					bank, ret);
-				of_node_put(child);
 				return ret;
 			}
 		}

-- 
2.43.0


