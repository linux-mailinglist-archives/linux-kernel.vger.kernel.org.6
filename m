Return-Path: <linux-kernel+bounces-526139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C63E2A3FA87
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D42441FC3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3E5201269;
	Fri, 21 Feb 2025 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fLRJQsPv"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0171FF7BE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153790; cv=none; b=dyMzXEdQhvQMu/Rh0VphoyR+udv2HKmr+IVPo+8ssSsG76hVjuSA/FiL9L0uOHumGJjK3S5KGExfFLgdqZFUOYAdg5u64PjshiR+gR1Mgs7nl/lMZ4i9JsNOLWAk47Jao9exIb02relvlku4pBeujNZ9/dWQcGeMiOPxdvrSr1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153790; c=relaxed/simple;
	bh=RYYrqjZBBPZWi7VA/WRn8140pmz5H68xLv5MzgliR78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AUEO66OKLO+eyQhEuGHYU9lf95fZRzk3atlUZkKa4Pl/1Q2ScKvhJUURtm6xnY6xvItLW7X561q7jkkpdgjYT+72AP6tHoEfVG7s+ksC8GLiwV3s7PXzxjoiIAl96Mm4fWZ2IzvDiNbWYMNJuHwxhvb2m3gs4eosTF8y4i52iJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fLRJQsPv; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab7098af6fdso35218266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740153787; x=1740758587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iecpj9KIMrY3zBOzgwFtaRTFMVnp7wDD9F9a7Nu1whg=;
        b=fLRJQsPvpsPxK9IVBT0WhA9wHoBXOW/bAFqOatLe49WYbn3T0q3mXQ1mbjBlzjLPB3
         1q7Ku3syMUVBONjEc9eMXf+jmv3CmZGIs/129+UcXjqmBksyno0kWJ8UhevZ+BpuqpcB
         rvGtwh6nRezkwFMoejBD4aT4iVkoGQUISQ+6eVavVS1EkpXLhSYq6UTb4M1hQc3N8W3I
         5U873zWJ20Fz6Y0ANLaj0XsPVr3q7m+A1wX84HEypPIOZd6o8XtbRmq6C4ll8GCoG7ZJ
         CIYtDzum4LJ2/9vt0Yf4qCqQSnKg9PO+e++YKWuGDuNFbFUoyPTM9jPw9b/Y/XJdimjZ
         f8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740153787; x=1740758587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iecpj9KIMrY3zBOzgwFtaRTFMVnp7wDD9F9a7Nu1whg=;
        b=YW9rwqF7QS31G0bu7y/HPTgeTZoxuWSYwlB7Gdw4DqbnArL3YnnobD0i6qKnFFIISn
         lEKunuL8t03+0qdIe0w3ZF3CosysxgCl5nrIaO5Fk5U++CnUQJNvpBgeYYHw+94H7FNj
         2B3LGFC0vnVED5wWI0CvxmrD5r9rOP52HIYUcXkDDzWc8PfGUWuU4tJZ805/zj1msNCz
         APimpl4VYrojpXnv98AcIAEe1dc4QS1+rYPC2Rcmrcs+KBUqSMpYFoWVYRwfyKU1O6Ls
         Ug3NkFI6qPh3PTYD4j3g/0H8cee6fUBZaywxurXUC6zpTaz7ep1jSDKbq6EpLi2P9KyD
         cCEg==
X-Forwarded-Encrypted: i=1; AJvYcCWGDGFCbUTVQ5a17PVrwi978G0trLjkNTQeX3foOjiaKvLCeiulwofvw88pLYtpy671sEjyLgMcoGzcfVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVJwrhen305ZwJ+41nh6ML2LWae98t2UWslkcZR990b1nA4tdk
	BOQ0HvDEYU7DMOBJg0ebi+6egGE4sGy3i/cY2v7RP3d+51z43uZA5NALTTUHldM=
X-Gm-Gg: ASbGncsvcFCaGQrzS/AlbeFjNGS2wuD9QNw34xXS9+idNhSwHFUvS9LEY3Kspw8C/tQ
	XiAK7cFVU/z7ddB88b3WCZkH2c89nq1Dp4a5D1osZ8vi28gobaaQTsOq8mZ4yplSmW9OUvzi48w
	wkCQtdyhmhx0SAZprjzAiDOIe4JPkhR9iaodPAMhOIDr4y1TyUweiVadhOu3RgGyHPDiP7KbkuY
	BQ6ajPof6HCYc6XYOw+HTxvUrxqN0ujDU8TyiqQmJ7BDBz7ajHYHasLtzvIcVeS2izHYMu8x8jH
	OKr21aS9jKbSWqNBw3n5X0IicWCvZSTG/9XY1MCVV9+r6H1BIjbh8l9vrB9n3+L9fIT+ag/qwUI
	=
X-Google-Smtp-Source: AGHT+IFD94Z2C6E/AhuO+19C1vGdBFuuX7tNp0Xx3W8Vs2QPQWhGEEzUJ2reXTaWktyO+VoDRaxiJA==
X-Received: by 2002:a17:907:9722:b0:ab6:d3b6:d825 with SMTP id a640c23a62f3a-abc09a578efmr125277166b.6.1740153785316;
        Fri, 21 Feb 2025 08:03:05 -0800 (PST)
Received: from krzk-bin.. (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb98640619sm1040782766b.54.2025.02.21.08.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:03:04 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH RFC v2 1/2] dt-bindings: remoteproc: Add SM8750 MPSS
Date: Fri, 21 Feb 2025 17:02:59 +0100
Message-ID: <20250221160300.160404-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add remote processor PAS loader for SM8750 MPSS (modem).  Device looks
fully compatible with SM8650, however it lacks fifth memory region for
Qlink Logging, according to downstream sources.  This is a bit tricky,
because updated downstream sources for newer downstream release dropped
that fifth memory region as well.

There might be other differences against SM8650, because the modem
currently crashes after starting.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
Split from previous MPSS+CDSP:
https://lore.kernel.org/all/20250220154132.199358-1-krzysztof.kozlowski@linaro.org/

Retain the Ack - no changes to the binding itself.
---
 .../bindings/remoteproc/qcom,sm8550-pas.yaml    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
index 8bfded3c66ef..2dd479cf4821 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,sm8650-adsp-pas
           - qcom,sm8650-cdsp-pas
           - qcom,sm8650-mpss-pas
+          - qcom,sm8750-mpss-pas
           - qcom,x1e80100-adsp-pas
           - qcom,x1e80100-cdsp-pas
       - items:
@@ -164,6 +165,21 @@ allOf:
           minItems: 5
           maxItems: 5
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm8750-mpss-pas
+    then:
+      properties:
+        interrupts:
+          minItems: 6
+        interrupt-names:
+          minItems: 6
+        memory-region:
+          minItems: 4
+          maxItems: 4
+
   - if:
       properties:
         compatible:
@@ -191,6 +207,7 @@ allOf:
             - qcom,sdx75-mpss-pas
             - qcom,sm8550-mpss-pas
             - qcom,sm8650-mpss-pas
+            - qcom,sm8750-mpss-pas
     then:
       properties:
         power-domains:
-- 
2.43.0


