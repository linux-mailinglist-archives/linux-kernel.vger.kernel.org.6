Return-Path: <linux-kernel+bounces-189192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996558CECFE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 01:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C30C282AB9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 23:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DA4158A15;
	Fri, 24 May 2024 23:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h8qErPMn"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F3F127E1E
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716593855; cv=none; b=HKIAwAXZemKYOq+x+PS4hp5CmYrS0h6/pycZ7ynW7data9Rf+24azkHYYS11uZ5H+hTeEZLFHJZmkOnMIqD2Gqjp57gZGXXN1GQszE78oNp2SxIb7gvRY5Go5cXg7G9TljzmLqYo4G6ViF5A1P2R2lyq5L9g5KIYgK78ekHHEGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716593855; c=relaxed/simple;
	bh=LFBvXcZEt82lZS3JkQJSPCV5wWyA/RFb5NTd2wgZucw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kwLnQMpWQ+YkUgSySDUZX4qYcs7aeVbOo+IcOouarQ5Cld3i+KPV8wB6o5ox2eF4MZ6wFefpYctldfFBndUqOMhjX4eYu/YzPOX880/tXFO/4xJa48Ag09mTIWqWk2IDme73mrC1oKiYVPBqS2ohatLV1S3eaAWRE6jDXSPLNd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h8qErPMn; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5a89787ea4so1194093166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 16:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716593852; x=1717198652; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2avrdftbtvJSgsCBQarLFUeMEb+/jjV/+635MdlU8Y=;
        b=h8qErPMndn5FqCf84IDk/lf55ep6h2pqsyGnVcPhnxaPgBh5ch3571SKOJWf+DNc25
         hbH0aQAp57bHACoYiQai44Cy/hsZAYJtcLJo7Tw/WlcPdtkr/0skkdb6LpiBjFjSpcu3
         wV6ajHZz5j/s37MwlmPQ8IFWrB/0O4bKsMG1dCEFRDVR+uQroAW2lMgcR+AJHSEnVIjf
         OfLXgv6vUP4zdzKS8kHd0Ys+R9XA23vMYvtgXkPTBR29XO1Knzm2qFNUoJQFFbu2/9C2
         v2qCkTal9guEm27uEj/+rawO3g5Hm5Xw1GcOXcNZt7C4ygl7fQADcgyyuCz7MrYnVskz
         8VdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716593852; x=1717198652;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2avrdftbtvJSgsCBQarLFUeMEb+/jjV/+635MdlU8Y=;
        b=rCdYrpl97RUk3lKyDIBIlwh3UArkVJp3zDtaJC0V2/bW0UcgJ7j2affNRr60geCVT9
         5VROpi6TJSEpO3bAb1YAmm/L5ho/tvGgZvu7hBipTwR1JAgwvw/eY3BfCKvIN2gTOPc4
         FOhBfMP8Gtzrd3Dq1rGgquF/euEIl2uzWg4acubEF0Ptzi5IWHs2Mida5bBS0Lld2Hl0
         PZOM4AXEXo0rBEdPWpyA4PJHN5J3sIGaZQpwyIK3kB5eH3SLOS3oBieP6Y2Ek5sf7Syv
         EO0x/UA2TJJz4zAocJhjNE8xEzBGee7ht39SCeGtngAtmK7KzP1ZpV19BlSE96BWVIIR
         UOGg==
X-Forwarded-Encrypted: i=1; AJvYcCXOwkwC6vtOlaY1MrWoPfhnJB0mbSA8/9ve4kmsjgJpyKyO6OglUaw5uYeRMr19AlVqWSD/XuvUTuAyheVmYZyq0vNb2iDf3epXho4o
X-Gm-Message-State: AOJu0YxQS5bmnvkea5ivMq4e9iUnJyAIN4HNpXAvcjvmsNEoLDs0fdKr
	H5ZsF4bRXMDsphJQ7y25ukk6UIaj3D7oM7O61D+mKOdX4yf5QWqws2GK+/mn1r9/yNtxAjU7CGp
	3PC8=
X-Google-Smtp-Source: AGHT+IFlJEclhDE3F56LvaE7zzCAKSHHAs2U1MbZwLlUaVEO0VCumjmo2crk9OQHHd20HpqOE6Aqxw==
X-Received: by 2002:a17:906:12d8:b0:a5c:df6b:a9b5 with SMTP id a640c23a62f3a-a6265128c6dmr231753166b.59.1716593852537;
        Fri, 24 May 2024 16:37:32 -0700 (PDT)
Received: from [127.0.1.1] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c938815sm189475466b.78.2024.05.24.16.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 16:37:32 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 25 May 2024 01:37:28 +0200
Subject: [PATCH v2 1/2] dt-bindings: pinctrl: qcom,pmic-gpio: Document
 PMC8380
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240525-topic-pmc8380_gpio-v2-1-2de50cb28ac1@linaro.org>
References: <20240525-topic-pmc8380_gpio-v2-0-2de50cb28ac1@linaro.org>
In-Reply-To: <20240525-topic-pmc8380_gpio-v2-0-2de50cb28ac1@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14-dev

PMC8380 is a new PMIC used with X1 SoCs. Document it

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index 50846a2d09c8..1e6dd4d2f6b4 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -57,6 +57,7 @@ properties:
           - qcom,pma8084-gpio
           - qcom,pmc8180-gpio
           - qcom,pmc8180c-gpio
+          - qcom,pmc8380-gpio
           - qcom,pmd8028-gpio
           - qcom,pmi632-gpio
           - qcom,pmi8950-gpio
@@ -225,6 +226,7 @@ allOf:
               - qcom,pm8150-gpio
               - qcom,pm8350-gpio
               - qcom,pmc8180-gpio
+              - qcom,pmc8380-gpio
               - qcom,pmi8994-gpio
               - qcom,pmm8155au-gpio
     then:

-- 
2.43.0


