Return-Path: <linux-kernel+bounces-511859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C01BA330A5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB783A6B19
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC18F20126B;
	Wed, 12 Feb 2025 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ECGsJ4p5"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DB52010EF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391595; cv=none; b=s//GOq2Ps3z7WhhjKwJvXo4y8cI2cUCbcZlx6fvSr8el5mCei3htWF3FTy0h6f+SAlFmR8spyVZF4e2xXSSdHq5WooBa1wI9Sokn4HKNqIhlIOv6jpx/6MXYpdMZTfPO2KNnzIRS/ifTfZDOHPM7n2NI5ZAqJzeg5UUy8JRftJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391595; c=relaxed/simple;
	bh=J9wumi7qlxcc6299rTzUmyAx5YxElF0K+3qqjT1gkcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fbl6Qs87rgl3iXhbP3lM6ZBaV1B4ZED7hJgFHaZknUWDeHGGb7o3OiZ62CdTk3IlqiIKvYaPykp0dcP+Jq6CInlnPzOqTQSgqe7QsNXSHifLAujpF9x0YkRBCR+VczAj/SO7vVZjLieezxWvGQ3B9I7R7fPtbqWo93c6AZlO1TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ECGsJ4p5; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dbf65c0c4fso10467a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739391591; x=1739996391; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u6+F/nzJic4e58KU64FVAzTlIBmwAdN4ZEHOdFxRX/U=;
        b=ECGsJ4p5PHbQjyMKfibD76E2opytpMo+WSZK00rbdjJjA20Khfy5P/7XYZxdZrq4tV
         p10iLA3bo/vYcyT+YfwUC/CecFGT4tm+TBQsmuSv818+tGReYgQZ/NvOH5U1zFWY6kpr
         9BCAJxpsLX6JcWOz3WzPkneBUZVbNh+3s/s9bE89E1OlvieAGQLYdEvqBm6qKcGc5G21
         LmrIRCxVC4WGdg6PcOzOWZ79hxhJY57cfPa/nVjyBItf4du2RQo0FPBkOEkRmqAY82h9
         tGXbODdRy4pHZwEuElrlPxs9ojrAHvbt4LnUppzS2h6nKD1hyamLz7mWpzwuivkUwGUV
         Wonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739391591; x=1739996391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6+F/nzJic4e58KU64FVAzTlIBmwAdN4ZEHOdFxRX/U=;
        b=Jm4CDhiYfAaiMmusFQIR/R80/VsB56vtrT5aa2kq/yVfX0ukb81KqHFrPR1ZCUb9kw
         Vj5ZWpKIhBdx7lEgD3A1jRtDiXUNXlbYG7OQk2z9HjI8MGYJZCXDxUfN93gsFlAHPOLL
         AJ3E7kka/uMOdaZhuTfteaaqJcLRib9MKbFYhnLeDKA2Lesns+PvQ7UsALKO51C5NLel
         Hb3shL6Li+WgjHdLz/Ug5yOwWOS9XM4k7Z/HAKjxxC6CNxPBLnN3t23G2YwZlJb7u2rv
         WO2JVIs6GOy+7VUgmtbm1hZZgfVgo42fDgNvO9cGN/gr99pTAIUm/HE4EjnkOrlqTF+V
         +smw==
X-Forwarded-Encrypted: i=1; AJvYcCV+hrBhv51dnMGNDVoAscV4BGoDIPQCCslNzy9kNlecAUx8FFR3jxrgbNy/T5KSKbrBdBms1kLX3+Wdxfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyykwtJ3Zy8SdAl9FHw9ilu+KMFqxtjFq6SEO98sNqDa7kQ3bFw
	2kpSK1+PxluRJ+WBh0w+sKaC/rK0y3dfTjX+ziMoxCjWIGZYzRutcC56/kDNE4FmCeAY7Go3Yuh
	8
X-Gm-Gg: ASbGncuIb4Ug8t70hwFPKPYzDozIzG7G1h6t19Ax8Zp5NU7WuDaraOpOTVeV+5R/rRP
	VIGZkkmhk3HieWl3ewhXuxQACcVLFpk6IItc678DhJoKHLRFIO3mI4RoKXWBkxCmtWQHEHbK18Y
	juQibiDxH7/Iz6LQyO8/lAIbd80o6RQaT8KMt+X56bjK2NFa8BWjHlYA0UyXInerTHxjNHg3nQU
	S7vYbdKpvH95e9S0hKux98mMY1XeLLbTubhCL0PmvfuDVD+NJTSlK7iOIn7vc1+hz5p0/6+WWbM
	/KmV/vhRWRriD7JPn/IImbgJhA7hbSw=
X-Google-Smtp-Source: AGHT+IFVsggGxzqlN/vZf4SFgQQpoTSQaeE0j9ooOvf/iQpaNXtig8fCxgL3//Gs75L6jr0AEe4gNw==
X-Received: by 2002:a05:6402:40cd:b0:5de:a752:3c7d with SMTP id 4fb4d7f45d1cf-5deade02885mr1522371a12.6.1739391591011;
        Wed, 12 Feb 2025 12:19:51 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de59f893ebsm9436732a12.45.2025.02.12.12.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:19:49 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Feb 2025 21:19:35 +0100
Subject: [PATCH RESEND 3/3] iommu: omap: Use
 syscon_regmap_lookup_by_phandle_args
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-syscon-phandle-args-iommu-v1-3-c3fab486b426@linaro.org>
References: <20250212-syscon-phandle-args-iommu-v1-0-c3fab486b426@linaro.org>
In-Reply-To: <20250212-syscon-phandle-args-iommu-v1-0-c3fab486b426@linaro.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=J9wumi7qlxcc6299rTzUmyAx5YxElF0K+3qqjT1gkcw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnrQJccqLErD/jL7OyJNpS7lTBh7SFfQbhopUl3
 i1FCXVvl7mJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ60CXAAKCRDBN2bmhouD
 1z9SD/0V45R0Dr0Gsk6W+9AJn0o53W0eP5qesp0hzSdhUFvKk1/Nyz0472zLdSR2L38oywV9SbE
 ySEkrA2bKRxcLYKV4kRFeTDxln6ARH0N9GPBNynnsCAz1aUihKYNRY4GyrzMNRyudxEpIarweV1
 XuvYlnx+13q6HL8VkUuA6/s1pBaMOEmHZ0AOVNyxCvbSinQwekU4WmL0BsfmjekqREs1SvLetfj
 Tv75bftsQwlU9LcNXaGXhcpjyfNzFu527W+8OHTGOx/1uIq7Tl2gn4SKfWSCZlC+zrCiHpegy7X
 6SO4akowKQYWh+B+DrmgUQSjP2fbgqrBU4clUhmVTSLxgPhmMghaMk79nnohljMiDNUSS61y07x
 1eYcbSiLpPpwwH+kQ8Y8wmQ+eo8enpx9Za4YAbMu+YbrTqzB1PFkH9ZG4Hsp96U/t1uhPLWYQz3
 iQD9JAmXnEhIh7NxRQP9r/TmFNLbvFiQRvNksJJT5Vezm5Y/mS8wAjOeotMe0bOvhzFFnTH/YP3
 HCp2zNeEaRsuiFF44N50CSPP5kPwWK4IlkWZ2yVkiqneiqeLeMllNVwHnZD9Uoi82wvLDnciGT3
 5WSdFMeQY9iX5Qb/64GcSBuaCpzdZ7AnM5qVy371ckQt8WBoyvxsYkHsXT+YUgG+oVflmnt8ayN
 c/bwFyGivjIl6aA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
syscon_regmap_lookup_by_phandle() combined with getting the syscon
argument.  Except simpler code this annotates within one line that given
phandle has arguments, so grepping for code would be easier.

There is also no real benefit in printing errors on missing syscon
argument, because this is done just too late: runtime check on
static/build-time data.  Dtschema and Devicetree bindings offer the
static/build-time check for this already.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iommu/omap-iommu.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index bce27805805010ae473aa8dbd9e0cb903dd79bba..f12812d3f828ad382c7a84f6ecd604c8f35a6d10 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1127,19 +1127,13 @@ static int omap_iommu_dra7_get_dsp_system_cfg(struct platform_device *pdev,
 	if (!of_device_is_compatible(np, "ti,dra7-dsp-iommu"))
 		return 0;
 
-	obj->syscfg =
-		syscon_regmap_lookup_by_phandle(np, "ti,syscon-mmuconfig");
+	obj->syscfg = syscon_regmap_lookup_by_phandle_args(np, "ti,syscon-mmuconfig",
+							   1, &obj->id);
 	if (IS_ERR(obj->syscfg)) {
 		/* can fail with -EPROBE_DEFER */
 		return PTR_ERR(obj->syscfg);
 	}
 
-	if (of_property_read_u32_index(np, "ti,syscon-mmuconfig", 1,
-				       &obj->id)) {
-		dev_err(&pdev->dev, "couldn't get the IOMMU instance id within subsystem\n");
-		return -EINVAL;
-	}
-
 	if (obj->id != 0 && obj->id != 1) {
 		dev_err(&pdev->dev, "invalid IOMMU instance id\n");
 		return -EINVAL;

-- 
2.43.0


