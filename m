Return-Path: <linux-kernel+bounces-204338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 689898FE764
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23972872D0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A91C195FDA;
	Thu,  6 Jun 2024 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ujbQ/eGf"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9885194C9A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679719; cv=none; b=q9Dz8nLTqTLiK9bbttWYalE9PoIRP//Dvb+7eDmWtd0M3AOTyl7cTUaKAqP0TZDjb3i+aEQ6Nknpias7Hm6KAWREDG7fvbU0bDgLlI1wkkpNzaiUH+WSwUb37nkLkzQHe9dLt9y9+lPaicn8mrMWcVr2TxAyd+zwoLum5s/VriU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679719; c=relaxed/simple;
	bh=ifgqih26nGwEUb+VADWix3TIA1A7UraZIFOAnjNBJ2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aiuWpzb4ZDhGKuEzUeSWXI0xEb0yv5juKuaymAlThFRNSVXqL2UxBZjhfKBIFMpZnJU5X4tyPMBU8m1NORJk3wN1SASPc6nGnBAx93xkQmEune6BlH/63vPYOVUz4MQ41Murgo6kh7jVJy4lnfCzYuyZ9ymstPGV6rGjSxO8tAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ujbQ/eGf; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-35dc7d0387cso1152389f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717679715; x=1718284515; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MutauDGZ5LvIHf1GxJ/Kkch8vYilJF3OfUKPFD5XiLA=;
        b=ujbQ/eGfpkEV1KH6+b0MUTdSpPlHoNlGp46PV678TNBA4HZTNoSjz+NdT9ppDUaD0t
         zIzIJB0vmTycXOx+kR65tBmhEkJG1thIRQVTzOGhz8MAVFCEA2UA+tbxHYJSvIrSesnc
         r2F7dG7j2tFhLV016qS8suLuSHFzDCHANw93ZRkEHclFvbhd6kJ7emXfdQ6Xv4Y06o9B
         hCZcAXO6Tdf1nXOPw6tWbaHjk2QVMOWWSa1J/YHVxzs5ShvexNqkGqBn5A/7d6aPqCx+
         PjXwfYevOwS8X2tpXSdFDnNKWesciu0BMS+F72OoDho8XDTIf2cJBnZaGaKjveSvNOBc
         c9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717679715; x=1718284515;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MutauDGZ5LvIHf1GxJ/Kkch8vYilJF3OfUKPFD5XiLA=;
        b=SGQOtqN8m8N5/2bQEMu18SUljS41aPWvJKUkc0+WrE7St/wRLeAaZdRPmKAUoTtIR9
         SFJG4Ts73NZirAaKk0DGc5/KmuqW0CihyGJSvD3szCZOP0W3Pz/s3wZgyPZdr8OqsHqG
         J0DWWt7x8YT8qIWmzIpWv5oWK60jAXGQlgwSjUyA2fmoJn+PQWaqfY+rHtX2ghywdkNI
         7dCK7OaJ8YBv9ssUPIytuMKlBOaRL80+sjevxmaOCEV/bCzirygd4hKCf8rMZu6/qFOV
         byzKJpnrLzaTtfWm5T/PIhLDPLgNBFZWa8gnT55EyFV+YaiQM61Dmh8wYf/cZt9qcZz5
         rwbw==
X-Forwarded-Encrypted: i=1; AJvYcCUHYka4gYRuuxh/BIFeyQpZasFWpJlYxfR3LxwTUEf0Xc0ES+xME5fVwfhxqKg1HCUVW+GnhuwOiSC00xypstvqVX7KR4YtAuqPlmsH
X-Gm-Message-State: AOJu0Yxmyb08wwZdiSapiYj7z6n0axTocKPAH2FYY8CpLEV04VbmR/oU
	MR5Tw3bHt+IkQms5vcSxP/vf41P8xR0dn4MglyM2hLZBazU9KlQZsZiRkfz8qmE=
X-Google-Smtp-Source: AGHT+IHE2iU8tD9EQLBqF698RfYd9HC+NNoZVPGXSGg54w1e5bsfBfjfLQEgMhsbn9rNCiOKOGu97g==
X-Received: by 2002:a5d:464a:0:b0:357:7590:921d with SMTP id ffacd0b85a97d-35e98099153mr5147467f8f.66.1717679715117;
        Thu, 06 Jun 2024 06:15:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5e989b3sm1558378f8f.71.2024.06.06.06.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 06:15:14 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 06 Jun 2024 15:15:12 +0200
Subject: [PATCH v2] dt-bindings: iommu: qcom,iommu: Add MSM8953 GPU IOMMU
 to SMMUv2 compatibles
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-topic-sm8953-upstream-smmu-gpu-v2-1-67be88007d87@linaro.org>
X-B4-Tracking: v=1; b=H4sIAF+2YWYC/x3NQQqDMBBA0avIrDsQRhO0VyldmHQaZxENGVMK4
 t0NLt/m/wOUi7DCszug8E9UtrWBHh2EZV4jo3yagQwNxhmH+5YloKZxsj3WrHvhOTWnijFXJG9
 HCv3gg3fQIrnwV/734PU+zwuIgLidcAAAAA==
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ifgqih26nGwEUb+VADWix3TIA1A7UraZIFOAnjNBJ2c=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmYbZho8agAAwKO4MpxitX6pjWoQ65Lw/7Hs2x+Ol3
 1mW2wZyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZmG2YQAKCRB33NvayMhJ0VHWD/
 0ceqrd0qGn9q8+TkXtxou9bRW/zUapvB3Xpo6idXcnSxBxwl0CNEfj6EsbyZ/80pIgD1xPAUxO4oMS
 2/NpMJEM6fU6+17ma/KGOG0GEER2uttsNGq1t9M48V5cu4uMt5M0eveGjNZFI5buwNyRHxWCrt6LF6
 RJH0UbPxr1r3JFwTHcpMcZGsI2ORKYZvvktQN32CFpoFBh4CCpa1huupwIr9oiKGtHgVNcHUDBE7Ou
 qffaPARY0rzZq6nmLpHBC1u0lYIq5UgbYvgWMhU2H3fRL+axM2qiaJKnIrxilbVJmBIHPHTMLSwAKz
 yk4BW456MjBBpTUxd3BXv5y5ux4+EvXP2WwDkxPYiDFQIUCmZ4/4BA+WBQRrYI7T8nIV8LEofAqV7W
 7iMOk3I5IZZQmfG+6LZWQ3Ica6mS1h//J2udiu5RF91QrJyfxonXYu43aeDYPABsw1K5OJTbLkARHZ
 CyiSrlUAQwt5QXFGI4gZhQI9u+xga1LMDUsxx+9+mGJoTZ2hyFrn+E6lGtXANezCuP7qBRGxSMermS
 lPOHV9mCqypqAbpIZdgfa/btTQix+HQJLJ+pS2BHcrwxr7n4jGXPDpEV2J2FxmZnvl0b/zSLV0JhNe
 aW3v0+lSfICep8aXLG6hKBUMYIDHOGV+4j7pIzF50+qKeBQF7lPTeQDO8zdg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add MSM8953 compatible string with "qcom,msm-iommu-v2" as fallback
for the MSM8953 GPU IOMMU which is compatible with Qualcomm's secure
fw "SMMU v2" implementation.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
[1] https://lore.kernel.org/all/20240523-topic-sdm450-upstream-tbx605f-v1-0-e52b89133226@linaro.org/
---
 Documentation/devicetree/bindings/iommu/qcom,iommu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
index a74eb899c381..571e5746d177 100644
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
@@ -25,6 +25,7 @@ properties:
           - const: qcom,msm-iommu-v1
       - items:
           - enum:
+              - qcom,msm8953-iommu
               - qcom,msm8976-iommu
           - const: qcom,msm-iommu-v2
 

---
base-commit: ee78a17615ad0cfdbbc27182b1047cd36c9d4d5f
change-id: 20240606-topic-sm8953-upstream-smmu-gpu-2b582c34bcb6

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


