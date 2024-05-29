Return-Path: <linux-kernel+bounces-194300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 595898D39BC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C1E1F23F0A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A49C181306;
	Wed, 29 May 2024 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sXlC1aid"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEED169ACE
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716994030; cv=none; b=i9pCwW6LqcPDiAOGBNabdqPjFNaHqVFY5md0ct9nPppM666Bzd9EBzW86aKS1nk/BJRIEAy0jpVpy5JVneQUeK5QMT0XrN5lFVnEixLP2TW69LtyTJTTM0B2/fX4og/64gsm4JVuxBpLCld/hEAZ4h8iw4hxXKv33GwqYzNHygU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716994030; c=relaxed/simple;
	bh=TIUEEL0zWVDZXHy4dYjykNO8VTxvqnQRk1eUuik+L54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KGyM0I685l9NLE8CXcdntzMB8TXH1FNh3E0ZqgBf3uPfXYxT7WPo22j+yBiQOQYCvAX/ry8/98rxo3uqv2T20AqziCzl4IHcUMyjeqapemTay8fTQ97tzrkLG2WRXAMXNwGIVeq54FBZaGYLaIDm8fT9II9ijwL4cEtpGUjOXlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sXlC1aid; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e6f2534e41so21808721fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716994025; x=1717598825; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/quN7i5JwAFNFz24vQKdgeyQcj221jNzz5gL0pGS6+E=;
        b=sXlC1aidW3ae/IDXr9BuXRZkU/GTeDJoHJ0FISA0p5Dz2cGQ7XArrtLlJdNmu0PGtK
         rh0q5UE+henfOf4xnbtzyeTMCMKpmw3qyYqMOWsiLO75w5R69tZEXPQF0MCA0+YyPZvb
         44c73hWiH95yxxf498d/IJ83LVh9jt2V//Om+j1S3s8VKONptc2BOdfaaw+kI+a0muM5
         tdloDTeSBfzik5i+K4tx2YI0DgAla9K50ypUzhOADOzHf35WQ7v/yW/TXJDdgmWQteER
         J3ZxpgQyBsyM0fUsgz0kCDSIvZDc4sd+tbAc3xrluxcbquD3a+gEaKOu5dd0UYJ6lPmL
         f2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716994025; x=1717598825;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/quN7i5JwAFNFz24vQKdgeyQcj221jNzz5gL0pGS6+E=;
        b=wSCtYstXJ7/6NAbYrEhSE9bUoYE3zhEi0Jf4qVKtWw4PFKKQX3lMRUEJOwUYn7XlgV
         ZJUTQ9LMXz93Fey2C6GuqcA082TzVwGe4xDV5qfKVk3Sq2xWEYMbDbcnV/QipD8hV/0A
         s7fObVXXPKuKCTO0Ghk6DGN6Brjq8i42VG1Qlpzz5loADMxdvWsWxK3q17lUQb9S8Lj8
         0Yj7ytfxssRGPxPnyUkYl5fqsZ3yJtV5ytblNr/rPqz/L8B5yVIgx+fK7JCH11O5n+mt
         D+QyHfNWYS0snKsBi8EfrN/EtF6N4NIGPWsrfzFp1sJJI3ndnX94cjjwKMXQdHkwdnng
         NFaA==
X-Forwarded-Encrypted: i=1; AJvYcCWAYbNzJ3C+fqIJN4t5ff9KAPZ1BT/Yv6PKmCu8jyZhgPmh5ina/bXNvNfQ8WszIeZTgNSvVvbq5B2WoEJ2KICXcMw1HKkzx4GrRwCI
X-Gm-Message-State: AOJu0Yy82rPhjkMgRuz2GQEs2TCY5fWppGvNFxBZzXGhpktL0Y/smdoX
	zRfvqnTs/+Dwi1pJYJKqisPxF9K2h3jejn72TniJ1fBGLkMGPx46xoqMZHGpJME=
X-Google-Smtp-Source: AGHT+IFzyXnvMEccVyQXAQkd00PNj4In0S6yHUBxLi5sKQS4f2VGKoHWSEkTSPWFgHqATdDQM2+xMA==
X-Received: by 2002:a2e:9c05:0:b0:2ea:8143:6880 with SMTP id 38308e7fff4ca-2ea8143690amr2792061fa.22.1716994025375;
        Wed, 29 May 2024 07:47:05 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e98c45df0csm3791951fa.68.2024.05.29.07.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:47:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 29 May 2024 17:47:01 +0300
Subject: [PATCH v2 03/14] dt-bindings: clock: add schema for
 qcom,gcc-mdm9615
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-qcom-gdscs-v2-3-69c63d0ae1e7@linaro.org>
References: <20240529-qcom-gdscs-v2-0-69c63d0ae1e7@linaro.org>
In-Reply-To: <20240529-qcom-gdscs-v2-0-69c63d0ae1e7@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Robert Marko <robimarko@gmail.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1680;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=TIUEEL0zWVDZXHy4dYjykNO8VTxvqnQRk1eUuik+L54=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ1q4/ZMLtvzBFvqxb/2+TtnNnrfL5UzBKSPbmc8PJrocL
 2Gduqy3k9GYhYGRi0FWTJHFp6Blasym5LAPO6bWwwxiZQKZwsDFKQATCS5n/x+/4YKj/qY0V+7N
 jhdurQ/ZeOn/gnO69bXKs7dLKf0OrI7qP+ovVTLjluWlRTZzP4XHFyzOu2/y5nmrx7LjJe6TxQ+
 d3f9u3bS+Vb4LEnrlSrN2Re45Ka3p/XxH05XcHVtkG+viVGMWcjg/KPCLtXO/2KsvV3xEy7L7at
 EeKx6Ryn/3Tm8S8lhebhHycu6SGENZNbtKZWXmrk3B4b6m96YUnXWZtnyzBxOPlXS709f6Dd9Y7
 OevFvBJFrq0jftHOLPVG/WHQn8jphjVfWc9n/m6S1PtrJ5KjRsn0+GWF9tPHRXcfqLskrimsK+4
 5jLFFKme+8pLvVQyNOM1XiS8qigpjfXu2Zk7ZWIc54dzAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add schema for the Global Clock Controller (GCC) present on the Qualcomm
MDM9615 platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../bindings/clock/qcom,gcc-mdm9615.yaml           | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-mdm9615.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-mdm9615.yaml
new file mode 100644
index 000000000000..418dea31eb62
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-mdm9615.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,gcc-mdm9615.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller
+
+maintainers:
+  - Stephen Boyd <sboyd@kernel.org>
+  - Taniya Das <quic_tdas@quicinc.com>
+
+description: |
+  Qualcomm global clock control module provides the clocks, resets and power
+  domains.
+
+  See also::
+    include/dt-bindings/clock/qcom,gcc-mdm9615.h
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,gcc-mdm9615
+
+  clocks:
+    items:
+      - description: CXO clock
+      - description: PLL4 from LLC
+
+  '#power-domain-cells': false
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    clock-controller@900000 {
+      compatible = "qcom,gcc-mdm9615";
+      reg = <0x900000 0x4000>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      clocks = <&cxo_board>,
+               <&lcc_pll4>;
+    };
+...

-- 
2.39.2


