Return-Path: <linux-kernel+bounces-359703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EEA998F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FFF31F25A79
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384271CDA3C;
	Thu, 10 Oct 2024 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYUeEiQd"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16081C9EA4
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583599; cv=none; b=EfAPLFJjTGoLGXtZtGV8CH48ndoD2lG/6lkfsOT5GffG353CmwDupk4glVzrK2XvDBaTw4Gpd1eSGMFqBj15kbH5tFlYJbwB8J7y9GDzbwafXxjrzJPaswQy+rXvkLnTnRoBNB4SBUe+v6WSZsP8MuNl7PwU7IsWwnS423Yotug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583599; c=relaxed/simple;
	bh=aNb62zhsaKHIGiPAT70VpnT9AK5gMixXxxVjnHNtWyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aXuEwkl7U8LXMd5uDzSKuv1ssqA7Yo9tA6UzRJ56APhxSGMPDW1u9AEtHWoH/eHAlLTC0XNYrQQur2XfgyotNdBqJfHj5uyAsma7S+S9UAdbTiRBh9Eb8qEw+CGqCsjFIJenNGbXQ8h5SVjA072/uMAHgXcn6mb/nTzLBzPxX+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JYUeEiQd; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c942ef8d83so103654a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728583596; x=1729188396; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9TkkM0LfkMfefPTa5rHdBKo7UEPK6bYMYTQ0A6kZ7h4=;
        b=JYUeEiQdBN819BTclfLBxEneGFD9dd+nnFydxvn/aKh/4ndfkPJjzQXBMc6PvmYInO
         guOhnyWJDwikrVoinxYIzwNQxBDSDDQ1PAGdc3I3/Qn0UzjOjSG6tCZthAgDXIBFPKT8
         Uga/RNd+CnFYRVJ5GHDvGmR7jsz065AuD2EHug8bgYL/OfFyTmx3OvWUtHwQvtrxDa3K
         Ygjymg8G2X3GRLcYnMDhTYXTxqFINSX7pjR3WpYO5lzyONvz3mnJHesCHWtYZ72ytwOT
         4/vyREVehm2Hfsj+2vXBpU2Jo7S1bOpBCG2y5DwEZyj9vsVXrIbbdEtoEyiiK7pFtjb/
         Mmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728583596; x=1729188396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9TkkM0LfkMfefPTa5rHdBKo7UEPK6bYMYTQ0A6kZ7h4=;
        b=ePuFiMsf+sZ7pzUi+64NYCCDtUGpI+shZbYfYXd8XAoNc/kO2BxrF7AgbUWTeiDYcO
         Kpc9VLL+9pYRoDCiuoIpHeFxeDm3Ng2g5HGKPi7S7bIXYuewMd9c810sv7HFOJSv2cGe
         vsVSZuRc+HrZHWygEzlS0UgQk0Kx/y4k2jrr93lNvtByX3P7TnQwKqN1Ohx8f8wfjQUd
         DzusEOvDvTHirt1c3g+NisMDpCoztoF1apCTgBHwUX4NozKzE1c6sU07SRjAUtY8BbmM
         FHe9XbP4eSgzbnx59uB8CwSpVJ++AiXaCGZAt4/NNpvFb42MieupPFqoZanQlVaONTEC
         //iw==
X-Forwarded-Encrypted: i=1; AJvYcCWFmovmEQN6Bz+VBB7VTbEqE4O9Q12cv2IHzvyU7/GPuyvkIO16d94gQyiPCYxcgVQu6FU7S0m2gM/La60=@vger.kernel.org
X-Gm-Message-State: AOJu0YyERXgK7YPSWp+EJdx0SRouxWTi7+tUOVzqKaE+fPMXw709reQg
	vIp+VWPXUpLMldJatsJNEuks5ha4AggL9Cn7xBY2jXxgyzb0DhmYhGWyWUb2n+4=
X-Google-Smtp-Source: AGHT+IHQRcErwxHEKdjZt+qsy96mbwbA+guyRE+y4sdV2qs9+3gIUD4PBa5Cd/NrmsCIMD8+zgg50A==
X-Received: by 2002:a17:906:7956:b0:a80:f63e:159b with SMTP id a640c23a62f3a-a998cf45766mr262023366b.0.1728583596117;
        Thu, 10 Oct 2024 11:06:36 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80c1b8asm119757966b.116.2024.10.10.11.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 11:06:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 10 Oct 2024 20:06:18 +0200
Subject: [PATCH v4 2/6] thermal: of: Use scoped memory and OF handling to
 simplify thermal_of_trips_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-b4-cleanup-h-of-node-put-thermal-v4-2-bfbe29ad81f4@linaro.org>
References: <20241010-b4-cleanup-h-of-node-put-thermal-v4-0-bfbe29ad81f4@linaro.org>
In-Reply-To: <20241010-b4-cleanup-h-of-node-put-thermal-v4-0-bfbe29ad81f4@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2767;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=aNb62zhsaKHIGiPAT70VpnT9AK5gMixXxxVjnHNtWyg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnCBehPqvqDFh6IfCbkUeXvLZoTSi0gnsGqnksp
 eTAMoFrw+KJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZwgXoQAKCRDBN2bmhouD
 1ye1D/486TX4yMFc+ACmtgLM7zbJrXqUMiIGwM0J59oJV5FJLLInEAecAXxLtIUAEj0lC59biU9
 Ny0TJWWJatFtaWOlaTJkn9IS37gYCHGuCPHBVclw7lwJ8X+6w8MlCj2K4XcjXSBpC9AMKRfUyBa
 fTeYhRMZs8KR6TyNmbDhxSkpKD4Ehx6UnFdM9EMg6yylnWIE117rJtSwcHyZkCS+IzVaV57YjDu
 UHCV181U0knrxBjU0QGzvK0yafY471v7ykkgueBYUc+OdZDELxoSGlPcTpcIBIiJp7opZ1mWdDM
 w6+ka7YoWt9Qz3CtkNApPn0oSbyj0ZEKN2lZ5X0gqtckJVh/VeHGJl+TFpsM6gR9OC1KtuEIHQK
 4zQvpJggWGVRC6Zm6RGfi2R9woFXMnEdwEso/Nzt8eUQkKLaQS7KACvC21U6rmUt77/GXq2BRHX
 HyXlvc+1nIZP/zj0n1m6xL0SB1mYf5KMFbCeleY/qjjif7gXpOSRZ7jNsnWGwG2ASNHNWM1u/tQ
 OmdtPnSTluq5tZGFzgB5vldo45QwkB4tf9o9jUxNJkPihsXpiqb2PnFGnwoYnCXAkRw340DAMMT
 tx/Ijc0LsoVxeKkEp9y1gnSL1mHUdAzUH2q2lkIwiXklkpSppBTOGuFiBq0jwNmLYBcNXORr2Lf
 SaxsThJH/GQ8tSA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Obtain the device node reference and allocate memory with
scoped/cleanup.h to reduce error handling and make the code a bit
simpler.

The code is not equivalent in one minor aspect: outgoing parameter
"*ntrips" will not be zeroed on errors of memory allocation.  This
difference is not important, because code was already not zeroing it in
case of earlier errors and the only caller does not rely on ntrips being
0 in case of errors.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>

Changes in v4:
1. Significant change: kzalloc() also with scoped-handling so the entire
   error handling could be removed.
2. Due to above, drop review-tags (Chen-Yu, Jonathan).

Changes in v2:
1. Drop left-over of_node_put in regular exit path (Chen-Yu)
---
 drivers/thermal/thermal_of.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index f0ffc0e335ba9406f4fd858d6c561f9d23f4b842..37db435b54b124abf25b1d75d6cc4fb75f1c1e5c 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -95,11 +95,9 @@ static int thermal_of_populate_trip(struct device_node *np,
 
 static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *ntrips)
 {
-	struct thermal_trip *tt;
-	struct device_node *trips;
 	int ret, count;
 
-	trips = of_get_child_by_name(np, "trips");
+	struct device_node *trips __free(device_node) = of_get_child_by_name(np, "trips");
 	if (!trips) {
 		pr_err("Failed to find 'trips' node\n");
 		return ERR_PTR(-EINVAL);
@@ -108,36 +106,23 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
 	count = of_get_child_count(trips);
 	if (!count) {
 		pr_err("No trip point defined\n");
-		ret = -EINVAL;
-		goto out_of_node_put;
+		return ERR_PTR(-EINVAL);
 	}
 
-	tt = kzalloc(sizeof(*tt) * count, GFP_KERNEL);
-	if (!tt) {
-		ret = -ENOMEM;
-		goto out_of_node_put;
-	}
-
-	*ntrips = count;
+	struct thermal_trip *tt __free(kfree) = kzalloc(sizeof(*tt) * count, GFP_KERNEL);
+	if (!tt)
+		return ERR_PTR(-ENOMEM);
 
 	count = 0;
 	for_each_child_of_node_scoped(trips, trip) {
 		ret = thermal_of_populate_trip(trip, &tt[count++]);
 		if (ret)
-			goto out_kfree;
+			return ERR_PTR(ret);
 	}
 
-	of_node_put(trips);
+	*ntrips = count;
 
-	return tt;
-
-out_kfree:
-	kfree(tt);
-	*ntrips = 0;
-out_of_node_put:
-	of_node_put(trips);
-
-	return ERR_PTR(ret);
+	return no_free_ptr(tt);
 }
 
 static struct device_node *of_thermal_zone_find(struct device_node *sensor, int id)

-- 
2.43.0


