Return-Path: <linux-kernel+bounces-526079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9C5A3F99A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA06316CE11
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A36220E70B;
	Fri, 21 Feb 2025 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fZGDEv6P"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738071F3FC1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153133; cv=none; b=YiX37kyIMClhfoVLnzRQtbxrQUR0sgokHAlt8PA0fPBe/9ILoRxVYZcPKvWJ1RQK6k9lmufVCIfuzXmPSFT2X91+oEj+UJPZ6pVKAB7ujnIVLRzpkWbfr9FgjcS+y2D00laTQpIgHW6haMKJYxrF842wChUqbN5LLtZLf0dqu9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153133; c=relaxed/simple;
	bh=2EB6HQ3Xg729UaJzi6eQwoGHABfEKMGzkAxaHZxQ0PY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ADvRhiPbthW54Hw+8YwaLtGh2xWbbgzkpJQKcVijpEwwgIxmEEzQ0Fp1BsiKngdPFPdmthW0NX8dMPJBJvw5tTp58C9nPxZ639NefvLKCnzl4tWIUjRXyzdmJQhDrmae56SV2Vzaxr7+Eq2NlPU3COBUDUh7w3JiMCa6jAMUa7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fZGDEv6P; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5452e6f2999so2343875e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740153129; x=1740757929; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ywz5+X0tFc1uge/ko+PjpyJKNH56apxqeqThZAdXh4A=;
        b=fZGDEv6PET70MlRf1Dlo7UNOB0iYIGoKuIi/1cE4egLE7SSvAQBz9NDwypBOVkhzcx
         pM9eqW69Pa3ZanfaHvJZOCtQFraC65du/9C6xwELxhjoCwVPKswxD+fOG0fDmydHIIXi
         7wjaSGb+lIFKH1Tq939UFZDMzlseXrQZckYCl87kpflPcvyr1zl+3T6ATnlimVk4KLZe
         SU3Ua+EjAkBYrspA1vnAYe761ISsErZepKBpAZl0RIqJjmd00NPLtE/kkehBnnkr5ypt
         7pO/JsoTvkwlNUGkDj442cta51oQJeYTLwYTbQ7SBbWpRUavuuL8qjo3z0TwhooNrEUC
         IsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740153129; x=1740757929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywz5+X0tFc1uge/ko+PjpyJKNH56apxqeqThZAdXh4A=;
        b=a9Gigvu2NKvEL7WMTPyPlGAZM7odHayygmV3/EYbFgDhkt1hpGly9ILtwjLLgj3YNO
         XG2oaZauKsm/9IjBKCLLIRvzhn2vJYCBepOViiP3OShTpKK2icipIHXiv3+/ad+WUMJD
         e/kUUuA0xYlf004jPY2gwanE4OTh1eqQDc8+h8gcOnjjZf+TTnU/2xhsxgvJPIE4kX4t
         BmTLUnfwohzatWbUf5xnlP2+gUjJV7K8kGl1mpCqirwCVnWN20NxXeMEiM03i/lauaZ6
         9W5VQ5NVihLT9JyrcnPGMuP6i1z5DEfmYjeaYUJ/IQnB/HjAhzC36XedRI+RqZUaHEB3
         c7ow==
X-Forwarded-Encrypted: i=1; AJvYcCVgz3K6kWkvqIopvhC0w4JhqbVocRqnJXyLmrmiiL/TFPvjUQDtUoA4DVkVDG4nMAMcmP4uDScT2K2jHnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6rpGp5vHOBkdcZy9RgHUlH20b/vs5IPS/5SYTyyTc3A7H75RK
	egsLpns6PdrxUl0RCBD0R9F9e9AlMYCNG6H7LxuHt707lnDKDrQI6rBAm7UUhtk=
X-Gm-Gg: ASbGncuvj0iHQ8c8I0prTB92cnU1iIhF/LwvscMTN+JtiMvzLH+d2ByX1HZBw10fFXT
	7HReMPRX2GPWSM+R7YNsDkKd6gmFTQ0Rv6+/jWqof1s2zF0MTMGBmZweujLF1PLwXEh5UAyv9CX
	Y5s4uP+CrPM6mQlU1RTKt4zh32PKNHnNxQBcEfKm6yFwi0pSrbFImtGkOqFItL8D1kLegEM3a/9
	U4SxA+kwyhw88Q+nc3c3tyRYEfbVbS4yhUtWjZ3vjPGzfE3+4OLAxegF5gvF3WIw6hPynwPz0xA
	ssvyIrNm1AIUmWpWgVMWSbJIGUTpSdw12AhrqRZVoOek6WIyI1Kh/QonkDp5AnqodE65jw==
X-Google-Smtp-Source: AGHT+IG5nl9eE/0JUL1JRbbOoYJgi12gehtW3O2h6zIyVUIoOfhbKmGKz3tOwr6bSiIFCoJEUrY0/w==
X-Received: by 2002:a05:6512:3e04:b0:545:16d3:3bd4 with SMTP id 2adb3069b0e04-54838f5e443mr1378311e87.53.1740153129385;
        Fri, 21 Feb 2025 07:52:09 -0800 (PST)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00--782.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::782])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54816a55851sm287643e87.27.2025.02.21.07.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:52:09 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 21 Feb 2025 17:52:03 +0200
Subject: [PATCH v3 5/8] dt-bindings: PCI: qcom-ep: add SAR2130P compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-sar2130p-pci-v3-5-61a0fdfb75b4@linaro.org>
References: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
In-Reply-To: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mrinmay Sarkar <quic_msarkar@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2475;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=2EB6HQ3Xg729UaJzi6eQwoGHABfEKMGzkAxaHZxQ0PY=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnuKEhIOyO9evi4YM+xJTK2NM4Yj/jKLQrJ9Snz
 KarRzpLmseJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZ7ihIQAKCRAU23LtvoBl
 uIa5D/95JI992C4uMMAmvNAtQO1N1b1d3cIaBQQVRB+Z6u8P4D13JhJcv4BtFqF0hzhQolon93z
 9l3Xt0lR2aSvVR/1BELh26VmhYUXIMJJlan2zlWPz5VQ+TucKB+9gdO3gsoJvGcDx/e7p5uhjkC
 dM89xqHhbhO3Yj7Yuv5wDiYg7RhcQebXG5nrkTRaRK4XJC1+vJhfd2CG0Jq3T2hRXDDUGZqzuXg
 5B50dWo/fCPli8sPsFf9Zj/aRFqTZzbMRD3LDu2aSU/YRzKCoUJkwY2q5+IZjoKDyFXn0zsHuf3
 7Ei7ogJ+tO4A46l1sGyUNJZrhWnR2jtH1Z1cWOf137KJbT8Y62gbK4hHJtXDlCU0FMN3ApMAIPs
 Xg980d93pVpCE2ttFBhB4ZkZ13DkG1p8QwE24r7ynV7nRUf9Z8Xy583X3xRiDy5wLHUJFrqydz2
 iyob4YM5FqEN317+gQBddC7V5v+XYKfhDMmHk1oRB0rRE2bt1zRmBTVMQknOn762+l1XvfcQYps
 lKXUmK5gvMjE/QW9Ck+fVLaL6zjaUuk+xxcK2fJpzmkWmBXylrojfbv2clYbpQv+IGDU7xS4S1b
 pbqm+OUBd+A7zktC5r1T52ZtIEYLmwQrlPQAMjO9H8g1vJ6D1Z48OB4qFpbV6mtuR95cCGJO41X
 okUVDAdDo5Pgung==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add support for using the PCI controller in the endpoint mode on the
SAR2130P platform. It is impossible to use fallback compatible to any
other platform since SAR2130P uses slightly different set of clocks.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 36 ++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index 2c1918ca30dcfa8decea684ff6bfe11c602bbc7e..ac3414203d383bbd1a520dc11f317a5da9ca33e4 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -14,6 +14,7 @@ properties:
     oneOf:
       - enum:
           - qcom,sa8775p-pcie-ep
+          - qcom,sar2130p-pcie-ep
           - qcom,sdx55-pcie-ep
           - qcom,sm8450-pcie-ep
       - items:
@@ -44,11 +45,11 @@ properties:
 
   clocks:
     minItems: 5
-    maxItems: 8
+    maxItems: 9
 
   clock-names:
     minItems: 5
-    maxItems: 8
+    maxItems: 9
 
   qcom,perst-regs:
     description: Reference to a syscon representing TCSR followed by the two
@@ -132,6 +133,37 @@ required:
 allOf:
   - $ref: pci-ep.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sar2130p-pcie-ep
+    then:
+      properties:
+        clocks:
+          items:
+            - description: PCIe Auxiliary clock
+            - description: PCIe CFG AHB clock
+            - description: PCIe Master AXI clock
+            - description: PCIe Slave AXI clock
+            - description: PCIe Slave Q2A AXI clock
+            - description: PCIe DDRSS SF TBU clock
+            - description: PCIe AGGRE NOC AXI clock
+            - description: PCIe CFG NOC AXI clock
+            - description: PCIe QMIP AHB clock
+        clock-names:
+          items:
+            - const: aux
+            - const: cfg
+            - const: bus_master
+            - const: bus_slave
+            - const: slave_q2a
+            - const: ddrss_sf_tbu
+            - const: aggre_noc_axi
+            - const: cnoc_sf_axi
+            - const: qmip_pcie_ahb
+
   - if:
       properties:
         compatible:

-- 
2.39.5


