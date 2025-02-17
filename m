Return-Path: <linux-kernel+bounces-518221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3BBA38BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C863AED89
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AA5237160;
	Mon, 17 Feb 2025 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PcJWsTxU"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05486236A8E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818587; cv=none; b=gpsyI1XbXPAP7e/w44m762GqFtZFlXw/NwyrDMdeS5r8jPGkUzr0PSCqHWn9hM5rAhJdx1+f+YcmfoL+nxh4bmFQO/KvrIok0fbdH2g+G/efRueJNpNuX0HGtXHdw3n25L+i6Uw8df8qZFEcsOAECCvofdShyt2tHuEMLD6hGnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818587; c=relaxed/simple;
	bh=l4JKzQ7pT7dVKATcLHSyA8F/AwMI6R5uxNc1u1FYr2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DanYtLwLBq82haJz0WlldvmW3uJOl2PqCUJjIITKFuWCsKt9mPSSO/rsOUnx/6hTMOlKBa8D5cd82X7egtC65wXgYTm2+NiFUklnOnGR2xZLJ/3mmo0+qW8Ua1d5l1JyYJgz+sfgqyDLpZ0aEqPsvgLsqJd81f74RL5WaUwoOC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PcJWsTxU; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5439a6179a7so4887233e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739818584; x=1740423384; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bz6BpF1sTUoyQbskCCw4iC8Ct5cQ1B/7naF3psgq1HQ=;
        b=PcJWsTxU8Es1qVasq2OOyladhhPSu1JpWD9a3TCQCfmj7NxZYWJiOl/Mkiaxh6dgBX
         cyA8p0b/8gJ8tCn7wTzAZBoptUMg3BKo+2weG9oA4ZlKgqB+x+tAMQDHxVSGYI11dUr/
         D1qZ4rtIUYfMO99TFyuCbV9buoneAfwMDIrvo/BiTYIKEWvZ9APM7xSiyfNlg481OR7+
         4tPv0/bDVImoJliFJ6XMYsXJEQcvJzggcJU3f+bk+lGuW7hoMaw7Vi6uNidqbxDgyRqM
         /MXlRY4ipZlXbTtlrNAq+PnumGzdl0Ljxs7LOQpLN8VkXLrP5IcKwt0V+MLbV7/iYvsz
         0Gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739818584; x=1740423384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bz6BpF1sTUoyQbskCCw4iC8Ct5cQ1B/7naF3psgq1HQ=;
        b=bDrprKu9C5XeJlK7XZw6os6Yyy2Fw7YB0lDVWTR8IKGlP3IzjE86JRAHOqciG9X4h8
         hL4geutYzf7d6bvr1hTYkg3DGScuTNCrIgZTjR9y37PBPyr8yb3TuS8PpxH4eHCkEE1Y
         5EnM/21CQ48NtkGOW39Q/EEqbHN5QC1lb7UVvNfhSHlu8nkO/OnDDndfVzAjqOHOeOFr
         3xZee/u6pIGq40fANTsaLkwF1TcazfPt9BZPoI3k+0WP9I/fnHQwlTUM0ON67NRiW7/m
         IARaFoQdxHCTc1pGS0NefBRAiyV+ZRmTVu2nqTwcEkP4oqL6CumR9SDwY2AHE6JNNr6v
         WDTg==
X-Forwarded-Encrypted: i=1; AJvYcCUVG7h76c4+rC93uyxx6JfRNibexdB0oI5FIQ8C3nXpGjDfmwWO227B51NLns7c7MuAjcpzDZg9t7weSGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznWgCizXHIJhvH1WY3DhQgwcZOpezmarEe9qkPYc7rkZGw+nb7
	CSWwStD5IKattsVU7IWrIpqWw659SiFaqk+Ku7s62a4x1NzLzwm99q4LPgk39vI=
X-Gm-Gg: ASbGnctt8F4Qpj8y99hKVk61F6SikbmdAdlVilziLBfVjmpdKIWWUQiyxKGo3pr9KxH
	tYISrNhrncAZtA1CwhNys+nD0UAB6NsR6y9d0s27E4X8VeFsmPWEeBLaJRSU+A2RZ0b6Q/DBiSs
	fLQkgdYy4BzjypXxY734fJzoUmJplfxJLgfvdiygXOBTykLl2/02IFvuteK81qWZbQGW4RNMeM2
	LCr4/micd4dxllFeR/q7nJ6w3cjgUlRc7t0GKdRQcwq8nKrfy+PsWWvaRuBlGfuoZBljmnx8aOQ
	pKMkJ/usrDN0CdTMaJaIsQZWtlWUcCMhA7fQoEjyH2RICnfgDWERnFMRVBI=
X-Google-Smtp-Source: AGHT+IHN2v198izquScuzTQDg28XFm7jz6L4NWpqzntJBOiAYfiwQ5drbWExIGyigAAFAUDYzPn9lw==
X-Received: by 2002:a05:6512:3b8d:b0:545:2e8a:941c with SMTP id 2adb3069b0e04-54530362603mr3406655e87.24.1739818584199;
        Mon, 17 Feb 2025 10:56:24 -0800 (PST)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00--782.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::782])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5462006b0ecsm559806e87.160.2025.02.17.10.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 10:56:22 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 17 Feb 2025 20:56:14 +0200
Subject: [PATCH 2/6] dt-bindings: PCI: qcom-ep: enable DMA for SM8450
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-sar2130p-pci-v1-2-94b20ec70a14@linaro.org>
References: <20250217-sar2130p-pci-v1-0-94b20ec70a14@linaro.org>
In-Reply-To: <20250217-sar2130p-pci-v1-0-94b20ec70a14@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=l4JKzQ7pT7dVKATcLHSyA8F/AwMI6R5uxNc1u1FYr2M=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBns4ZPWq89hJ26Q/eFUKUe1IK+q3E5JsH6r76PA
 2E+VX3413+JAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZ7OGTwAKCRAU23LtvoBl
 uOhHEAC2NdE9o/AGIi7osGKgLOcKSpXu1swFXSoUf2bzkz3MuEImLUcfqu0tE6eRU6ljFDsBq1+
 ML86ZgpBM6Aev9ZUVEM119lGLwb0S3xWNVOmx6N7DOnf23viSZ+txgggjd7F4wg6MClkdfrEK0G
 f6sIOgMLYx/g7T5oNXdrUxjPee1qW1Jjq6xb4F9N2LM3uGJKxNTUAp0vjAasJcSw8gIv2iedGEK
 2XWly4PX7Kdxd/mYhmQTcQKMUz8JJnoNtCktjxZhRHLFeNqNkYG+3faKxt9DgOgacwE43QEyoSE
 ieh/MHGmU0T6xwzr6jus4bM/sjQcHWdz3QLbyHo2wZTDvwAfCpy9tXRXMFVy+UHUqR6iFpVqGvM
 YQT5ZfuKqeNj6D/kmzOmzSK6oz7isEB0FrpeaehmDcJyry4+5vQO+kDoy84P7ZLRlCSdwdH6qb2
 /ZogTYfFE6PxN5JhRsUmcTjDD8G1SX8JckKo/yEeXtsiuiPNpB5ZL5jMcc3+nG5YXaYCC7irCfp
 O3NEpH57Sr3z8PdvL5NieSXpapmgtZUJXbLmIyj/OqB8TxI/cNzTVfLNNRsd6FCe0kdfVszPR88
 qeQWMtdT50en+Q1+y8G1fBLxZXdVPHnlKRnzOxehfX6axmqdM6nIzRWO8MB6/M0yILPmB/VephT
 aOULzSgydXDrqwA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Qualcomm SM8450 platform can (and should) be using DMA for the PCIe EP
transfers. Extend the MMIO regions and interrupts in order to acommodate
for the DMA resources. Upstream DT doesn't provide support for the EP
mode of the PCIe controller, so while this is an ABI break, it doesn't
break any of the supported platforms.

Fixes: 63e445b746aa ("dt-bindings: PCI: qcom-ep: Add support for SM8450 SoC")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index 800accdf5947e7178ad80f0759cf53111be1a814..460191fc4ff1b64206bce89e15ce38e59c112ba6 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -173,9 +173,9 @@ allOf:
     then:
       properties:
         reg:
-          maxItems: 6
+          maxItems: 7
         reg-names:
-          maxItems: 6
+          maxItems: 7
         clocks:
           items:
             - description: PCIe Auxiliary clock
@@ -197,9 +197,9 @@ allOf:
             - const: ddrss_sf_tbu
             - const: aggre_noc_axi
         interrupts:
-          maxItems: 2
+          maxItems: 3
         interrupt-names:
-          maxItems: 2
+          maxItems: 3
 
   - if:
       properties:

-- 
2.39.5


