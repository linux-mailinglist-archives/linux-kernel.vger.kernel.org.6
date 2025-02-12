Return-Path: <linux-kernel+bounces-511857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C421DA330A3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4DF167D56
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECB8202C31;
	Wed, 12 Feb 2025 20:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zPLaIga8"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7597201100
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391589; cv=none; b=q1+ZnTuLLWXGcXag3iQOWZKTIVR1ufVMI9OcN9kn5ocgSlio/mvt+UPfLGNZhesoAYTsT8icOzCIaJmd1OqjYobq8CRX77XSIESRAmyLjZqCTJxt4XSaDpuAgC4+SF3/QD4vChPYj3s1Wk2p3F7nifd3KGlCQ3Oim4CbJURhI5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391589; c=relaxed/simple;
	bh=JU0TwdMjeSFQ90hC61OukfyZcV4B06qD4tAIkB9vGZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QCJ6lKN1OJrUgOa0U77YiYgO5CRli1JGFgVTtgqElGcoaMvO1bGMlKZnYpLAZScZcx28SfKiVpzYAhQWD5iCG99gb1g9L+4OZFeJja93LEcSqtLGc9k6DplgxjKd1ftrXMu6flt2D0DXnb4xV55owP8Ymvpi6EgE5XGd1kqMAw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zPLaIga8; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab7bc75e0a1so3858066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739391585; x=1739996385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+PW/3EHqkTVSUDSi98uyP6NlZnYHXc/ieQQmNS4dMCM=;
        b=zPLaIga8f+UDLf1w97+ylGLnAxbbIZsw+M7NOKIyx4XiauDu2fDrtsUodx0X3/EKRA
         sh+7T4gYdhcYc5fURyBrR6RTNuSK3I8qpHhZsRcDz5EMC5U7ITAbfXKo2SewTFRX3pmu
         Epc2w22Ng67lHdjbmhE+ungTljhuIBA5aJX1Vrbkjs2PzrBYrNzdwVch0KkqVgIuaLyd
         YT9IPkjVq+qjDTIxuOtS98dHhtDTCgMthentK6K5YzLBOLO8jfYfrJB2CInjJ5W3b8uK
         c2Di7WruDO3adFE4Bk1McoSypGprvejjufqFhfvgAU40qx/EECytfvSxtPguweOQWRv+
         rgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739391585; x=1739996385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PW/3EHqkTVSUDSi98uyP6NlZnYHXc/ieQQmNS4dMCM=;
        b=mybwlw388joBVu4Hu9fjBarFE+m/8vwy8eVbupQLkw96iXkaYAr2hBXt9hQn2YEwRv
         8+nduWQe6HbzJqMngXgT6Z20jONVuppBNZI46GUF373wSNoOulz7vBhoCZk1B0cnbcqt
         cI4hfNuifzMa9pnJWdZ+1VYECO3EqK18HGdw81fwwYBZgx0i6z/GYwTvkcj4Edd+JUxZ
         +RALQwJZGrZNwutjeaJFssJNZFDo1vJfLNU1/CZmaApQ9oQypnlfPFf/jb65HdIqdRNE
         +08TsppdlENWGUy+ooZzrc/H68hMDbLjjZPboXCa1vCsIgxle8MPdSGyZZqk24+DqAlq
         BAGw==
X-Forwarded-Encrypted: i=1; AJvYcCUATV18eyV+LKNYqrJS7PwtXDjMDAUCQvJF7hnz6/i8sfu1jRYZ4cMqHIqeSqaNY3llzB1nfjmzQ8hzb0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6u3/t2S3CVYHeITujVYqWhPPs5pPA9h66C5ycLGgEdpPzk3Wd
	Xxhtm/PbrB6bNYKLf0e2F3lvXmfeagu39CjbTKuzDpcJ5CeG8xRrR8/Zd7uwJCOsiMHrg0UAHBl
	L
X-Gm-Gg: ASbGncsAv20vJUv1MQtwe6b7sGs4Pm5Z4/K9zi+YT/ceaI36c30iF/lhwtkwohputk8
	45rdzZQpNlcaDChm5Ty0rVrIRU4ElIC9aOhMBxoAG2Bt7NE0UuHwZWkNOhW5r4pvxQArHIgdJBy
	tINQx9RIH0t+fZ5X1kia4mrZiLdf71MiBGMyyMVoBNmPtYiDcIEZvuElUJAvoG11s+ZOVp2t7ET
	X5bJsz7qxD5C29HzyqDZkEFQRS3HFkSd0wyhWK7B9fazZd4UsvBKpYhOR4KKmmgtQwvM2GXa2GB
	Pa704qQt7bD7pA7VqtOZywdFNF0cq50=
X-Google-Smtp-Source: AGHT+IG927cWF3dO5cKv23Ry21as4RwotNysUlOS2yNn+N8Iz4LmKa1CWaZoNBvqmkEZIQ4eSYBhDw==
X-Received: by 2002:a05:6402:40c4:b0:5dc:c277:f787 with SMTP id 4fb4d7f45d1cf-5deadda8af9mr1394914a12.4.1739391585552;
        Wed, 12 Feb 2025 12:19:45 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de59f893ebsm9436732a12.45.2025.02.12.12.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:19:44 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Feb 2025 21:19:33 +0100
Subject: [PATCH RESEND 1/3] iommu: omap: Drop redundant check if
 ti,syscon-mmuconfig exists
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-syscon-phandle-args-iommu-v1-1-c3fab486b426@linaro.org>
References: <20250212-syscon-phandle-args-iommu-v1-0-c3fab486b426@linaro.org>
In-Reply-To: <20250212-syscon-phandle-args-iommu-v1-0-c3fab486b426@linaro.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=977;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=JU0TwdMjeSFQ90hC61OukfyZcV4B06qD4tAIkB9vGZk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnrQJa5ulXnSjG/p4Urz2phkzFIaaIncKVbofVZ
 2XB3AU9FVGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ60CWgAKCRDBN2bmhouD
 187YD/0dYgxFiXk76wBs6vQXu/bOtKtDtMMzI6WlFLh5EGoLkfxVZ+eueTfdJK99vK29yR58p1f
 v7gdgQHFxDUOvdfmp2uu5N/i6b0dAGTKdgpzursxjzvjR9GryeaUnV9Zeujp+FUtMwe+4QfebsT
 aiHMW1/HNJhPFIEccaDgf1UD9hf80cdc43EnajVXGilyQuLkLqBFJon1D0BbycYjha1p359QjDm
 EJDb0+XQrY1P8I+W0eshmNgjUYY/05Uk/lNNcCB2zX0gH3PoTto755PEklkMQ9rtNp4aL2ygTM+
 B8xPkOYSseAYiCcSlMCBDOtceEDVHsKGDx1XTpRK4TTtCCU4yYiSVNn8uaC9ClEem+nQ7bYrAJR
 2efiu1Fk4bZFEORRd30TrUgZHYOERgT4xlYM3Rx0DvP//EMe+Moi6vxxgblhNB5r7f5T7meUQlA
 LBO/sJblGOGkGXsByFzK2MI88MjP7fBswS/vC6gJc7ndUMRbXln8qwcKQCrYFZrR2/j8iDNAl2+
 eu53OjfsXrx1oexE4/p5psrJ+R6ydTEfhd4kMTAQx/1o9SSrSVrrOKv9/3Ykf7H5+wpvPM2Qr+z
 sIm1hhw/1StnZxXSqdaT22e/oopb71QJ1J9D/rqzkUA2Q25DXxaQ8928PB8gznnZ9txHnj1787o
 kPkLIEskBRo5s9A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The syscon_regmap_lookup_by_phandle() will fail if property does not
exist, so doing of_property_read_bool() earlier is redundant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iommu/omap-iommu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 3c62337f43c67720a15b67e8b610da7886f6f39c..04a7deaaba25cb270eb6eeaf6a21030440f78a5e 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1128,11 +1128,6 @@ static int omap_iommu_dra7_get_dsp_system_cfg(struct platform_device *pdev,
 	if (!of_device_is_compatible(np, "ti,dra7-dsp-iommu"))
 		return 0;
 
-	if (!of_property_read_bool(np, "ti,syscon-mmuconfig")) {
-		dev_err(&pdev->dev, "ti,syscon-mmuconfig property is missing\n");
-		return -EINVAL;
-	}
-
 	obj->syscfg =
 		syscon_regmap_lookup_by_phandle(np, "ti,syscon-mmuconfig");
 	if (IS_ERR(obj->syscfg)) {

-- 
2.43.0


