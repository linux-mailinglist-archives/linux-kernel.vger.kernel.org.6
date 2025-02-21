Return-Path: <linux-kernel+bounces-526001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1EDA3F89E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A267419C8144
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2319215060;
	Fri, 21 Feb 2025 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VGXdZjyp"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360E121481A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151504; cv=none; b=gQDWMi38lZXxhi+A1Axx6P8DT331fgJ1bTqsuCHq3G1YRhm0IGiPtAIWoCqY4um+Q6rsiWO7/D821iuObHgYXRPd25LU9d4TcKTIg/knxFmPqapQLDfRoV2Q7WBmXJwscW6oF93Iko4DBBmMtrnSvV1HMxArLIxCp7P+LEO9kzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151504; c=relaxed/simple;
	bh=9B2Xq7lYY3q6Y8LyOgUlIBLiX0qqdACiJxxNpgXSDG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e5OjB5x1SP2iN4eQw4QTRRpsJOKg+OQkOPeVEJ0+4cYSIFDFebTE56EgS/DvY5Ds6ZkIkVVbPwjTFV/4fE6g5MvFcj/rUpCrtEFjjtHsTbrkBtPwNWLHZjUYtN6rmxXvISHzX3FLonEzMceW9xb42V8Ld+HJF+QFz6QJo5Pq7xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VGXdZjyp; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab7098af6fdso34128666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740151500; x=1740756300; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rC+p/AJsENqyF24I0F1pgnfGa5IztyP3HTXK8BcRgR0=;
        b=VGXdZjypG0QkdZsgZ+GblLsgt01PU2pyZgHkqQMJleLVA6muOv/rzy+9dOGp4bOp3A
         2uPvCvXzZcKmkfv9Td9sHprFjuYeN7LmvT+BcMjDGbr09fbym111tlAIzSz6771mYMtB
         9ZNVKc02PEGs7JFAuQ+fEprxqUNGrd5GRUf6f9akLwsNZaH2hlHyq6JJFo71NjxqTx1U
         QAAiYr0bmKOEG73BjB2CGpB00OOfg63y6ujYCxQqrDCail7IANuY4ITpuV7EaLKu7WAS
         YTi6uSLe7uFkYVttAbtE1p1So2SkowDDz8L6nFIBB9DhhVWfM3Q/0tnNH1g8cGKSEr1X
         kwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740151500; x=1740756300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rC+p/AJsENqyF24I0F1pgnfGa5IztyP3HTXK8BcRgR0=;
        b=NVoooV5uU9dBRRyuPpxkCrTMf5Lju1f7Tx+71Ty4p3Fom/qNnxjiOF+d14o0HedQbn
         Eg6YEkfpIufIU4Y6uZdohGZgIwPlA1UCh5LagElGfw7dAXd9ot8tAsP6BU0KnTW+nKiC
         HQXj6eDbmiBbe5v6Y9RS0oPYCia0ZFh0OhTuTXSxm0Gd6Gw66JGAGFfI+0EujlbC/+EG
         Pt7yagd+8aufkoWQsut15VSQrkSX/FukD629kb8GoHQJjBGfO7rJOMIUPfLOvtlhsFx/
         QJikYEpmOYRsvFpTH7okPKFNuVLo8LSeawyvR991x0vEmsobcxT1Skhm6EXHnOG1ruj7
         K97g==
X-Forwarded-Encrypted: i=1; AJvYcCWn4B93DfUzjOa/M/QruVyHiaaScuYI95eLXAbOf4S4H3StrB8BTSpx+lfH6VNYaW2ps24wC2r0ncacF3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv1zfzU5Usi2D9Bg4A8M2iYk3/acKRNFjz/bNOmFWT3ytQ6oWr
	9gPX3Vpx4bWr2wP3GDUj4nWgFeT7Sy5jzC2ARDuIFnxQZJ+Ii/3cUKdt9ObFdOg=
X-Gm-Gg: ASbGnct7CNyiTIgmbwKe4tQt/g9qdx8Ll8dwjztVPrcdnNuZaZRSOpL/u6/eC6vW6c5
	5V+r/K10/fmdompGMMkLAzqjzkh7mi+WfsS2adQzhUOpqlihZQPyVR1+l16Tam2KicLu/iWprG5
	wBPlVg8HicW4W7gLVvKAymcdiFD840jps1NJYToXGJdilpGF8ytW3moUfT/sXbbgoGKiYYRuC63
	KLfd/Ff95Nr51OyrtbdkIGBOVJM/njK6N8DVgIPUManbWXdZScXhRtkHuZ8GPzFk0NRGGycw8Pf
	O8tKrnNVLmViXdFMbI+4m2BkyvXdClgM6qdZACL6wDWIGxXUO9uDuytA+pn/E33+3UrC4ZhL7ks
	J
X-Google-Smtp-Source: AGHT+IGUaZJLMfhhvZ6mrcB3zhy337JFIkyRqJ9Bx5R78WejuUWui56ud8b82suf0d+ViP7DXXMidQ==
X-Received: by 2002:a17:907:2d22:b0:ab3:8bcc:3d97 with SMTP id a640c23a62f3a-abc09a46c73mr147175566b.5.1740151500410;
        Fri, 21 Feb 2025 07:25:00 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbaa56026fsm865456666b.113.2025.02.21.07.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:24:59 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 21 Feb 2025 16:24:15 +0100
Subject: [PATCH v3 05/21] dt-bindings: display/msm: dp-controller: Add
 SM8750
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-b4-sm8750-display-v3-5-3ea95b1630ea@linaro.org>
References: <20250221-b4-sm8750-display-v3-0-3ea95b1630ea@linaro.org>
In-Reply-To: <20250221-b4-sm8750-display-v3-0-3ea95b1630ea@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Clark <robdclark@chromium.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1154;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=9B2Xq7lYY3q6Y8LyOgUlIBLiX0qqdACiJxxNpgXSDG4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnuJqwYmhjNiJz64m3Odm70ow8pEs9DwcSnwYWo
 JzWPq3daK+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7iasAAKCRDBN2bmhouD
 107JD/0cDnFr4AxqzNmIIFy59u6RC8j9KAubzvu979pw6xQXoaAnXSToTCm/VZ0zgpRsKmVhUK5
 U8RDOJB/OmjKsL+TB/JFnE9n5qEVJkyrXdtIyIqb72sisTuAIH9KWIfZH7L9eGO5tb7R1ZeZ6aC
 yABdqEWnFASosGW07EiRLchCNtBxYBuG2xzOwnWjT0kTE/o65oR1xI99JvWnUNbsSwzHdbhRdqO
 /gnlkLYxV8/DtgrWiTUUU/AOh2wASm36b1UxnD0jyfPsgi/DJ7dLRW5VwIuawTtpF1lwWiDHwV7
 pNqlHN+z10FQcM9+3JYvtLo1BObW7LCoOxLT5DcULqY5g++QR83Ge+vvRUG5yMlOtTmc9f7/I2d
 JyP+8S0mkVsMJI6f4benMJTa/VcZ6UQ2tD9ZasTGoRmzIN3PrZVqlsecR6i+28sk00Z2l0BfJ5y
 zm5DwXaVG/AJ7kZ8CwVH5QxDIMGClQBp2WGnLJLfAJh3zMwkqOVB7gY6YJRJKf19wIkOkgP7PEj
 DIGT9L9iLkN7z4pj+sVHJus/LV9oOyz5vkpNPaQqaOvyPqws9r9si75nGzW0+a1m80PfrDnPwry
 K+I/C64RDpWjqObRBg/p4SoKg7JAmR3e+Kz7pDKinJvlrbSC6nXOF7ZLZgJkzpXHsYhrzbXT9aa
 h5dhsXxkxEiRthw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add DisplayPort controller for Qualcomm SM8750 SoC which so far looks
fully compatible with earlier SM8650 variant - both are of version
v1.5.1 of the IP block.  Datasheet also mentions that both support 4x
MST for DPTX0 and 2x MST for DPTX1.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v3:
1. Extend commit msg
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index e00b88332f2fed2fc33f6d72c5cc3d827cd7594e..a4bf9e07a28355c0391d1757fab16ebe5ff14a44 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -37,6 +37,10 @@ properties:
               - qcom,sm8450-dp
               - qcom,sm8550-dp
           - const: qcom,sm8350-dp
+      - items:
+          - enum:
+              - qcom,sm8750-dp
+          - const: qcom,sm8650-dp
 
   reg:
     minItems: 4

-- 
2.43.0


