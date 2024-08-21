Return-Path: <linux-kernel+bounces-295144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2178595979D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78F9DB20B54
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11491CEAD7;
	Wed, 21 Aug 2024 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbLA4wAX"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00F419ABB3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724229564; cv=none; b=YmTbdmNZh/cSD9rj/7+osacrMgAufYx7ZZOLLjqsS2mVX8ozXkRqU6c2eQOCkiGbd/vQU19ktmkZLYDbRn0WSmbVBxTF+xbXBtnaNmu3ogmHvcI73g7UQHpBYqfX2Xqyg+IsEAJY8aWudQ9+wimLyWo/L3wYSavOtm62KEdaoXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724229564; c=relaxed/simple;
	bh=0hjm0dG0v8Da7V655fPK+1NlV7mcfIrkrKbGwkw3CAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fiWY9SDyMs5Ym5Mfc9EJFNzbp0cpvZ8tCNr0lyR9fqkMRp9S+lody0F35lHdaZSoRjev2mclrzcWZLNdk4Ej8mmyo/uaIAVxe+DpHzhSQF6+D7rWUXBQHBYyzht6dbGNHM7cKDDRqHlyWV1/FDc/oeC3acPsfUvbtCifBEuhyXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PbLA4wAX; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f040733086so63209351fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 01:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724229560; x=1724834360; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XW5mUnNxro8riCIyxaHkbcC2c1AimCjEWCDq55C4owo=;
        b=PbLA4wAX/H+1R+dTybgr+ZIcWGOMM8byeKRaxDQtF/TvOUKnp+6QGvUsK+D3xmcqxO
         TqNWZpo6lNKhK7zjIZrR2d/EnK94fe0t3B06JzpiNN2RufItbEQxuG+O6kZFUlml43Qf
         NEa94BhWX9p0AJDxA0s8uGHpmvf0dcix/EjCAac6ibmJ4UcaoG6HGmntTaiRlXfo/Hr4
         i8hbtvyChVkVbdWfTShV8ZEB6py3f2zz/EQxFoC75SLITfOHtTUzuQYf927YRvUaqKQy
         E/JtOjK1usEppPqAv+ttTNo1mGvN2mWqpKCM6m7j3SWMiitcH1O4kyWLSV2dSD3GkCZA
         qPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724229560; x=1724834360;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XW5mUnNxro8riCIyxaHkbcC2c1AimCjEWCDq55C4owo=;
        b=Zz3v4b6a4Q+xxJzRPiopux3QYCvfkCHiZZmqPcN4zmyMMRgXLt4wxZfQQuz7Q5H16h
         6pqsmUOckD+WA9ivZa4ENcuS5xQpCYV/H+fMeoPs5eaaVT9T6WMjdxX5h2Sr/YgkMeXC
         eFcDCe/dTBAu5SVCXMrYZDZkCO99L8uJebPmf5WDgef3WqiZ02i2ZeEoUwtCXJXmpTBI
         SwENMfMdEQuMkAFx2tlj/GBGZ+dUGO4J5qmRZa6e8UTjMv9v37EF3Zk4LvfqrGhRHG95
         LZeoIorH+wHSMIkQ6QWWWnzdyCCUYxxGcutU25+gumU/3ts+pkEfCuai/bOD1MfVDBhj
         sajg==
X-Forwarded-Encrypted: i=1; AJvYcCUajnMHANFgFoG+srZ+raG6glbMaIEbEdIDz8/1YxS4QoEG2LbHSgKRI8pQP3LkbLm7qkBFg3plO4B6JXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQMnLKWZMnwk8N3ZdBdkKtPWWR7tdwjEovAgMZxlBrBndPyLhA
	WNEKUQWbJdluof0WzS9MIsbARF5t51CEr+RV9dpsHJVYSe0fnkRmz/HGrWgIqgE=
X-Google-Smtp-Source: AGHT+IERO+IDQyEBp/hErnAumhznnmvnA3dFgXMO7vZvWt4uQGrSdNVPCWdcTB6bCEgyLm2lNmDM0w==
X-Received: by 2002:a05:651c:b12:b0:2ef:26f2:d3e2 with SMTP id 38308e7fff4ca-2f3fd22519bmr3157451fa.2.1724229559656;
        Wed, 21 Aug 2024 01:39:19 -0700 (PDT)
Received: from [127.0.1.1] ([82.79.186.176])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebc0817a8sm7785019a12.84.2024.08.21.01.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:39:19 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 21 Aug 2024 11:39:00 +0300
Subject: [PATCH v2 1/2] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the X1E80100 QMP PCIe PHY Gen4 x4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-x1e80100-phy-add-gen4x4-v2-1-c34db42230e9@linaro.org>
References: <20240821-x1e80100-phy-add-gen4x4-v2-0-c34db42230e9@linaro.org>
In-Reply-To: <20240821-x1e80100-phy-add-gen4x4-v2-0-c34db42230e9@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1471; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=0hjm0dG0v8Da7V655fPK+1NlV7mcfIrkrKbGwkw3CAw=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmxaeyZXFTjg8Mcst9z+XweZ39L4hKqTRTHYjv4
 hZfQCe4LEiJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZsWnsgAKCRAbX0TJAJUV
 VlauEAC0aywWt3dkE/aKcT3+0s01lx7RDGRvwXYEkB4sc1i1pN2MW7fxw8dBtY95ed05z/SLakb
 P5dyowNz+CtjoOUmZX4ZuNrDOCuS50RkTkDk8GiKJHF+CT7jCDCaR209SZQXVRXEcbxC0DH9zle
 MC+nENCbfJ4DV3WItRt6V0bxjcYA8qRWa1wrwNQ7xIl/gsrhvRj3b3obYgDp5enIE/3KR3JQ2jN
 KkGOjPxbyG9AhiusOE963s2QY264GHHLARqqVt++TtPl8uQ1bHbG5dK/OzD4faM+o8w3uuqVu86
 bYGRoLSKBYNq0bFqjf+E2iX8dOfaJIyUtHfQiLoM5XtRt+5xK/6T/U1zjyJQqQR1a/XTbP2Ng0v
 S/iYy6hUeAlec82mTabzRpohNsXlP8LJQFvQu2C/IE/Jhfyz76v/VDkWLeG/WTNwW89AP4KTbXB
 lscfEHhXaXkq1g46LSy5bZhQb8d14Hp24IOuNO4XIPteTzU9o9pzmPIYZ3ImsLtT0cXcoG3e+Ns
 7+rWRru2+eNyz2geJ7uvt+D01XL64IsHCvZCqead/tORbwTrk8jGV0D9jzAcaTd9DpYO2l59lDQ
 LCCHF+Fq8sqE791eHbZ1VMnXbpgwGJ1lNtDv7XO0In4RusHsxoPC3+K/unlBEbIFu95M0iZ2Dtx
 JP5ywwt53W20AKQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The sixth PCIe instance on X1E80100 can be used in either 4-lane mode or
2-lane mode. Document the 4-lane mode as a separate compatible.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 03dbd02cf9e7..dcf4fa55fbba 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -40,6 +40,7 @@ properties:
       - qcom,sm8650-qmp-gen4x2-pcie-phy
       - qcom,x1e80100-qmp-gen3x2-pcie-phy
       - qcom,x1e80100-qmp-gen4x2-pcie-phy
+      - qcom,x1e80100-qmp-gen4x4-pcie-phy
 
   reg:
     minItems: 1
@@ -118,6 +119,7 @@ allOf:
           contains:
             enum:
               - qcom,sc8280xp-qmp-gen3x4-pcie-phy
+              - qcom,x1e80100-qmp-gen4x4-pcie-phy
     then:
       properties:
         reg:
@@ -169,6 +171,7 @@ allOf:
               - qcom,sc8280xp-qmp-gen3x1-pcie-phy
               - qcom,sc8280xp-qmp-gen3x2-pcie-phy
               - qcom,sc8280xp-qmp-gen3x4-pcie-phy
+              - qcom,x1e80100-qmp-gen4x4-pcie-phy
     then:
       properties:
         clocks:

-- 
2.34.1


