Return-Path: <linux-kernel+bounces-511858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF253A330A4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3423A6787
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685E7202C58;
	Wed, 12 Feb 2025 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tLi7jnTB"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1E8202C2E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391591; cv=none; b=dxUnkakNc9sFID6FhDri6TsXpd5JhRcuehA+UyavKWxPUHsNdF4hDG02lmWKPDENiPZ3w7Ifztg5iF480c4Pb1BFvdf1R+T8EOx26ROOrZPgjHJoDpd2Bxyf1y0JcZtI0g/7UbKusFWlESkzL5PYP5pS81G74fdGp2lrSV8U33g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391591; c=relaxed/simple;
	bh=Wjm+/RrFtOEa7BfBgV+P437/knLXydDC/LcDaBSqdzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lH8sNyOtP+Ug9Fn+slCpdFPfhY6UFpM2XeAhTDcrAQ+Q8S3VfvnjbIcaWVFoS/iX/b0QIoE4XewzQY3q+59sAIQsZgPCw5LUqIaBzagEbiiZCc04sLQ/MM03ggTa9S4Y0BGeVzGdiFYDUdjpAs7x/ae57WMwIViZapnnKdD6T8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tLi7jnTB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dc191ca8baso13581a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739391588; x=1739996388; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/qw8YuMgYbNsFsx9INqoN5rDRO1U0upg/GNac9bIpg=;
        b=tLi7jnTBNh3N1HACWYXQ54nDDiHVHybF0l5oteL2wmA7aVsrm/lKIHQNkdiAXyXtuk
         5437Z0kIYFatb5OD3BG90vz9uUuFKv1T7NwNJ+3oBdgDfQFzkT07bOom21XIzWVulMg0
         UlVCuspNtSA5sjuf+b8Er3jMoyZ++Bozm6mzdLHWQ5/kDVsycZhu1YzjtVfNron1Ghsb
         AIrP9F6DGkZ76ljF134BnhxOzzEoKP8wcWTj/cbcSO0r+y1mhcDhtpGfXtMD29KPkmQG
         L1Uo+cTtUCUOzJGvZ225KHCXbxEjaxPDFYC5z+VUB+aHWowsBaPEo8t6bUrmnN8HpEFV
         CVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739391588; x=1739996388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/qw8YuMgYbNsFsx9INqoN5rDRO1U0upg/GNac9bIpg=;
        b=HJqAiWW1Nmt0/emGElhaMCg8any/DU/uDeEEAbGkR/w0XVqVMzOEaroGCdmVie0bPH
         ZBdpmY9GNu4vlWdrVw5VLAApGxExWPuvunEsqizb6OAgHiiuosw5plNWaebjVJkyqV34
         pTR4J2GEDx5ImgD/gbBk8ZkdFiH3cNSPh7QK8f/8pHERFQ50cZxp0rq0E34cpEfAHxu2
         UDMWMl0utvw8EJvEb/8YS/5Z4NM1PnJOtoyjVnEN+OBrKB64s7qpGgRFicYbnFsOv+IY
         FaOLvbPmCRF7yYGEm+yrHa76hqKZ5xfCWKAth+IcqSTAyQXpodxOmkly5xynDQEZ/4X0
         tCgg==
X-Forwarded-Encrypted: i=1; AJvYcCXzUhSQaUNnOCvYqc+jycXwN3lmO9oIFSdRuyYSlqhQp0C2Km3Z0xi3ks865L0aS3efVQJeiwqGZHaShUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx08ku5w3/Lt6Nm+q+AXkL0XI5bbdKwGom5MhTfGW3zjwjoSV99
	GszArRLl5+V69YLmO/0b0YoaGjlG2Fev5g+wf8Et9rhqB+AOCHWr1IVkJg8aGNXuHhHcFM4vyNp
	e
X-Gm-Gg: ASbGncvtDllUxHUOMFfkkEdAPlegAZ8E4e3aN7iHuzEI3JprH51bfS5zSEy07NHF0oX
	gaeXIabPygv5DuilGn/eZvoOPV7Bzy1NFqzWz/11UlrLTdiqTqUxhsZgeFIe8Bw5qr1+8CoYERI
	WFEfQm7KoLMEkFmzaa7ED2OGnk/I9SSfciW9/Eq44IzdC8sFf4SA+xuUiBc1H5DKPAvJ1Bif0lo
	u9WdenKr8kYA8SyS05ilnpz+GIlLmWGFqXXAkrwbDrcgRuSXLYfMvfXqaYwoB+blZHFOqpNv/J8
	kdMzFGZHgYlCIKtztEnrG6ITjx5YcYU=
X-Google-Smtp-Source: AGHT+IGF8pu12XjdIIkO0K7CQJD4mhN8hPLT9Ezts/KvaBalNSFXhsxk2rjSGiqkZ9maq3+XJbTA3Q==
X-Received: by 2002:a05:6402:26d6:b0:5de:a8bd:a231 with SMTP id 4fb4d7f45d1cf-5deadf7f96fmr1405147a12.1.1739391587918;
        Wed, 12 Feb 2025 12:19:47 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de59f893ebsm9436732a12.45.2025.02.12.12.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:19:47 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Feb 2025 21:19:34 +0100
Subject: [PATCH RESEND 2/3] iommu: omap: Simplify returning syscon PTR_ERR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-syscon-phandle-args-iommu-v1-2-c3fab486b426@linaro.org>
References: <20250212-syscon-phandle-args-iommu-v1-0-c3fab486b426@linaro.org>
In-Reply-To: <20250212-syscon-phandle-args-iommu-v1-0-c3fab486b426@linaro.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Wjm+/RrFtOEa7BfBgV+P437/knLXydDC/LcDaBSqdzc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnrQJbpiYmbeOW7tNs95AFVsSVJIEUHNSEy5Wby
 IbCqkEgsPiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ60CWwAKCRDBN2bmhouD
 19pMEACAx4yY1a/yBpXb0g/DvzLC8SYJdzpX2M20o3LO/8RjeqBGdZMUvt2uYkioed9EHRumxjd
 w/v8U1pJ/RUP499WTjw6wzk2icyXn4u3NRSKHyfWHDtYggW2tuHuYP6NXpQUOhrB62HYgsaTX9I
 0PvVfyc7aSiyPVPLjepPQNV0k3zZErixrWg03iYS5UJF+rlRsXIgHsd0fR+bt9xcC9ZKqfTNhSF
 9a7+cuyKylmVGw6Ra/QH3nP22F2O1LxyOkkiqrFmelou2qdA/Biiibf5BSO1ZHMWw+wVAZttHUb
 jO0G8+0cct9vUwzyx0ql041C2OnDVypmXrbBpOfaReOiLWiMD1g/VtEWnYsA5ERIelxkjmTjRFL
 VqPBf1N59kK8lPE8yVM7uhZNh+69X7fxCrUkk2ir/0VR6/BciVl+lmVqHgh8XrQA9cwoQMkiQHN
 AXQ5izBHWaAA8z2tmMuaM5MeCdLvB4oqbP2YqT0dABsqh017fRZbT7u1mhCPsSEokVYb66eRmcK
 fFOCj5UtumQITt+abb5fNhf5h+uvqOOLz6xLcCQ49puaJYF6EymOWRLylHBWpuE5xFRGw+uZE0n
 piguclf4TmtfRdCIEP03l3xoyFDPCbVGYtMO3ZPSFYf+HhNmrB+KnrYkiwCvrzHQxa3DuHI9Cec
 aPjC84+nQHP+m/w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

No need to store PTR_ERR into temporary, local 'ret' variable.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iommu/omap-iommu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 04a7deaaba25cb270eb6eeaf6a21030440f78a5e..bce27805805010ae473aa8dbd9e0cb903dd79bba 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1123,7 +1123,6 @@ static int omap_iommu_dra7_get_dsp_system_cfg(struct platform_device *pdev,
 					      struct omap_iommu *obj)
 {
 	struct device_node *np = pdev->dev.of_node;
-	int ret;
 
 	if (!of_device_is_compatible(np, "ti,dra7-dsp-iommu"))
 		return 0;
@@ -1132,8 +1131,7 @@ static int omap_iommu_dra7_get_dsp_system_cfg(struct platform_device *pdev,
 		syscon_regmap_lookup_by_phandle(np, "ti,syscon-mmuconfig");
 	if (IS_ERR(obj->syscfg)) {
 		/* can fail with -EPROBE_DEFER */
-		ret = PTR_ERR(obj->syscfg);
-		return ret;
+		return PTR_ERR(obj->syscfg);
 	}
 
 	if (of_property_read_u32_index(np, "ti,syscon-mmuconfig", 1,

-- 
2.43.0


