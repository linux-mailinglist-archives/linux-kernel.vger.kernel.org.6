Return-Path: <linux-kernel+bounces-559069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981E2A5EF1D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BAA517DAF1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863E7264609;
	Thu, 13 Mar 2025 09:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MFVQu7Lc"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EE526563C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856918; cv=none; b=XsPILR3Y0oUJ9gUIqYlcT8Kg/oxM4GPficMZQ+W/yLzIHL3k8SBYKN9Lnqmr5Nf329FRD4/sjwTGWiqhyE63KxKEz4KigbVxjOlA1H4wHyGkjFptquUszt0FX7Xms8xDuX0DmI+QNN3HXdPcDKuZKwYf5gRAMvLCYrYZrsVX6O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856918; c=relaxed/simple;
	bh=lgWjTBUuPBm2rSyOlWilGxloVDsYf3mREg200N6emfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=an3gZ9NSfSoGDcFRXGJ7fhgkxHf2P/FuHISkWPgei6R3Q+DEPRKtgbhRK5uZ0bvaC+4nAL93q/oAJ77/3J9xG43RtUUzR8I1bg+xByB5Tcnjf4lYRNmfwh/DyjWMAZ2QkV6jNHvRwDV/FclzQYgVYF5z14BFHpnWzY9B+wr1u9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MFVQu7Lc; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39123d2eb7fso49317f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 02:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741856915; x=1742461715; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILgSQHDxgkKe38HVj8nfhqursLYO9kMPnqoqfjxULgY=;
        b=MFVQu7Lc/1Cq6Kyn4cV0IWAgEp/YDo7YuJNR87HoOLGeCePPi3e8Iubyu/5lEBMYHv
         PJIHy8UX26ilYxE8A+abKAfVhVjSJnizmTeedxyYfjsaj6yY3h54EmGMP8xe8IzfGoZd
         oM5WrEeRWhpKJkanp9wwQlPk2Elyn6+xDej323xwryLUMgG5S5VO6ElTWrS/mZ/fOruX
         lYsIhPSXS0YTBJc9D6aSGSUPUZfmBspDa4iSmZGWXGz2J08CpimDTPmIwOBSsUPDSqIL
         EiOBhWnBiq2CyEbBDlwC3AS9LgyqLcxWbewPAfFCqp2YDB6LCJwfPvn2ZpG105f0wS5g
         ++1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741856915; x=1742461715;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILgSQHDxgkKe38HVj8nfhqursLYO9kMPnqoqfjxULgY=;
        b=fIqgZ4Gx4p6okYSorL+57ciufkoqFFYw7LV+xWFgs5qrkg4iXHV4rXSFtGf4WfSCX6
         Qf1Z4TtJWZ6BZAEaRpjC4ny983hjqFhoN+hxDeyNkKpzbyDSMfWSMhQXUrao+yF2rPtS
         NwHuaNmYFkNQSWq2ONpcRlGozIKYQhUjyp9Ptsqkp7OVeGHD/02CxrAaCdvgWuw+dzB4
         hZWRUJkA0GyTcHOuzchYWazoskhEu0zqcGlQ/lXZL5JSL2MW5R+3l4UEcUsxuE17/2LJ
         xzUV3P5ruFPBi61BTtYsRfihxuiM6HKH3Vh0VNW8DidW0bXUaQe8I75D2s942pA4Vfvl
         cnXg==
X-Forwarded-Encrypted: i=1; AJvYcCVwmXzk9gE8fqjW3x8rQtSDYjUcZhIM31t9pDfa7NsIW5gZOGF5lpGw2YCOCUOZcS2B7AM5Gc/t++9XQfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsLvlBcgcgBpPi/EdDNzjed22wCoPu5x6mZiWZXgkch9Dk0NMm
	d0rlAlPf60eD7bdnidd7+q6CJYsuhPIe3IKGb3U1Hq+sqyuoydYeclHjYfXm8b8=
X-Gm-Gg: ASbGncs+2+SMG99dqRQftKjn7+TIrznAbCOHBdbzqbzYbR5r6/x59pXD4Xin4qb3rKE
	rLIOFGQ0lSED4KXrzHcJRT9JVkmhZ0YF/q1Iyt1tGQCH9SFxUL3g7PZgFzb0LRKW81tvqno5Frv
	qMhvuZH2eFhPeFSHYAUZc1hwvDwY4LGaw0NiNhETaUvHqNln5hmyNHRXiEia0nEEIJ5J5zNX4b3
	QzpZ0Vw+IniJc3EQspddeVT+CumdcMxtE7ql3cubWtNg3NoimrT4j0EDaaTYa48E4WzUGSvvXxM
	GfQJoGdd3JQFXVDblwgrMtRBMEvdP5aXyODB4HcDkD76CnQqkN8U9F9GfLs=
X-Google-Smtp-Source: AGHT+IGKnblChG5aj7F20E/ZbGuy3EkBkhV5BYFgRAEyDthTZcDrxIAPMPB4DtyATCqkmzaKRhL1/g==
X-Received: by 2002:a05:6000:1564:b0:38f:2113:fb66 with SMTP id ffacd0b85a97d-3913bbb7c55mr6487289f8f.9.1741856914566;
        Thu, 13 Mar 2025 02:08:34 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cd78sm1414706f8f.78.2025.03.13.02.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 02:08:33 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 13 Mar 2025 10:08:22 +0100
Subject: [PATCH 3/3] dt-bindings: cpufreq: cpufreq-qcom-hw: Narrow
 properties on SDX75, SA8775p and SM8650
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-dt-bindings-cpufreq-qcom-epss-v1-3-62b0f96ba888@linaro.org>
References: <20250313-dt-bindings-cpufreq-qcom-epss-v1-0-62b0f96ba888@linaro.org>
In-Reply-To: <20250313-dt-bindings-cpufreq-qcom-epss-v1-0-62b0f96ba888@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1987;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=lgWjTBUuPBm2rSyOlWilGxloVDsYf3mREg200N6emfY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn0qCLfEH5UJDAFMqaQ2DbkzgGdEbn37syewUAy
 l6r7fLHoOOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ9KgiwAKCRDBN2bmhouD
 12njD/0eY0bJXpbonUjf7E+cC3ki7olCu78ZoetuTKptbm682BMmu7YIaXDMFe9sQKZZl5hT8x6
 y/HrDw51U8QFxOtyIoqdbclTBld/jSuLfKGhftUSmmX40Gjd/t+CoAp6D/gR6xhD0IZrTR5LzpK
 GNiymRe4JfXtNr1zge85k8gfhT3WsbwAe6Wne37U38lpHYAN2HxBoif9qIeH8u59Mc9mgxek8Ts
 1SABCgcu66eSoDxEmhWXOLU72a6JpgeXMU2yNtGVDWYLPnZkUbCoASv0t3dI+IkJwBumHSDOmqw
 ijFiUMBisvPA6cCl2K22LzT2qIrEedwNI9jn8GRyUPGotkkco2HSg8fMv1gxuWm/Olx7Ib4MQML
 nfrs2wV0rpeOadULI4gwDuUtwcKk9IvlXjrWe57U0brsNlpZe0kLK4dtHMd5zbEJDVxjhIIz/rO
 oPdi52vX0vXfA1nj9+4SslywPSOM9mmC9V3QzPWmN9X5+y3v4ObsG4hAkP6ay1pC2tLyS5cyA0U
 CaVAlwy7uunKGmAlnjY56AKy2QHt5u5nfBhftiIMkghivBIcG/52o9p8ThggCpx+1KNom3d+PpR
 ODbmwwXm12nxzGO7VJeSOsBSCvkfsK34MHKzfmKx6h8SV9RRrTQXNb0kSxWgcVmb3sKOOGVr9Nw
 3nrUZdyP+gBt4yQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add SDX75 and SA8775p compatibles to respective if:then: blocks to
narrow their properties and add a new section for SM8650 with four 'reg'
and 'interrupts' (top-level already allows four).

SA8755p DTS comes without interrupts, but only because they might not
be available for OS under given firmware.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 5c53ceb265b6f0f98509ef1f45aa246e95a20a22..e94baf77d785fa089f2448cf56bd29d52b7b3621 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -111,6 +111,7 @@ allOf:
             enum:
               - qcom,qcm2290-cpufreq-hw
               - qcom,sar2130p-cpufreq-epss
+              - qcom,sdx75-cpufreq-epss
     then:
       properties:
         reg:
@@ -132,6 +133,7 @@ allOf:
             enum:
               - qcom,qdu1000-cpufreq-epss
               - qcom,sa8255p-cpufreq-epss
+              - qcom,sa8775p-cpufreq-epss
               - qcom,sc7180-cpufreq-hw
               - qcom,sc8180x-cpufreq-hw
               - qcom,sc8280xp-cpufreq-epss
@@ -212,6 +214,29 @@ allOf:
           minItems: 2
           maxItems: 2
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8650-cpufreq-epss
+    then:
+      properties:
+        reg:
+          minItems: 4
+          maxItems: 4
+
+        reg-names:
+          minItems: 4
+          maxItems: 4
+
+        interrupts:
+          minItems: 4
+          maxItems: 4
+
+        interrupt-names:
+          minItems: 4
+          maxItems: 4
 
 examples:
   - |

-- 
2.43.0


