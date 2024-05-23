Return-Path: <linux-kernel+bounces-187131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCCC8CCD9B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B93281935
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FBB13D279;
	Thu, 23 May 2024 07:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1dKsC2a"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD2C13CAA4
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 07:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451186; cv=none; b=V2wOdjWAaJXLAr/KC1t9Y1jY+gcV6CSs/WAx+YZC2/zHnO8iahi23T45Aw52/UjUgG63Y25h91ofESEkIKhECbez2S8Bg2+7DSmcKyxziLAbfXfUVmeNxBWOzMXuNhY3UYSBDBA6qXaIZdkc6n9VqjQW8IxBIwidWKYdzZ499hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451186; c=relaxed/simple;
	bh=+j8A4VZeAl+Y4aj2STDkjjffz6s3NT87BVIa8sVLpDk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YAvMCS5XL6acM8X8wP8FwWMPiSspFy4oVgCIKJqvOTpB7D096s9vD0XtuLUaBnRY6EmuawFU2tpNRgLScxhhciM09XMf24uW151NR5MausrcyNrjXf4qczrUjH1PViQbECysLnZDcjzKDnCEBRhmYZYhngOnA2QHk2GnL9Y7pLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H1dKsC2a; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a620a28e95cso357462666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 00:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716451182; x=1717055982; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BBn5fJbZjjKVEfV88PasIUUBNVIZvJAuh9fIwEn4kSQ=;
        b=H1dKsC2avCBDN/vKbLf2ftj4Fk9gqoTyLghBidVPnGj9jLkjMszCdf+VzaCGgbbRnQ
         SrNlSisOpT76OuAEXVkRyDP/x1QVHGATdxTer9YFcQ5rL5zaKBQIzH1c8bABANXGneT0
         HHPd4pZU8b07tAb50hOUyeMNgLBCTU2w5NYVSxChQD+PRHnBHonBkmRUpfI3yXhuE9a8
         pr/vxPKgpuLaTzS9i+iUO6mW1ip1Sm/sWzM0udAaoPKpvRoOQDJWI6Icp/xkSPUMWH8B
         Y9+VT37dIGdzFwvuLqCU5e73zx1YygoF/0GVPAEDsxZZe9CtBSK/wtRISaGlK+UWaaPw
         YjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451182; x=1717055982;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BBn5fJbZjjKVEfV88PasIUUBNVIZvJAuh9fIwEn4kSQ=;
        b=AZ3eQzd1gq1vhalPnsohfOZj8sk7efqwfaiDMH/ugzg9ZjyMm3QUcU1/I7XiO93aX5
         3bvAqTZ0Mjb1Zdvkxz9pg/olNk6hieKocMPRqt1A8fYDgx8E/E5SeqFptPev6vTMd53E
         E3KRZlUrX1F3AMMi3PEi8KJEEX9tm2FD6sMM+ZoBCUCIWw2QaEaKp4bnRrteE0KnvjpD
         ZdvniZ6tVLRVBZoJfMAFV5mKgeLy624zNWgk+IRjt/TcJwal5gcE6PYMii2WJGp5bVn3
         /sh1mJ9MLmccaKbHeOnaBZYrRbtiBG9Vwj9tU3xqsrwuKtc6pPcx2I3mUq8eEdifXdLq
         3tfg==
X-Forwarded-Encrypted: i=1; AJvYcCVkUAj681iNzaB48+Yfy/4D6OH7AfIZ3iLViPsVbxXJgmFmjon4FNHfwP+9vRA+rmeRHX1OubWeTswN3KAVF5hB9Ktb2+6//+qLGvD9
X-Gm-Message-State: AOJu0Yz28q8V9usfjJyMY12v2ojivLBVyEmgE6B22F87dCHOZ5iF3oon
	UZlMk9gVkqNSwuhTntknogis8oxOE0bMaSd5wF8GRWvUMNL5Orl/1sJEWwZbjgY=
X-Google-Smtp-Source: AGHT+IE2a1HuJ87qJ5GF7wgS7CRYREnyk7jhZzWYgIBDeaQk+LSmL0pKqmeh32jI27/6wsPC1TPjHg==
X-Received: by 2002:a17:906:3daa:b0:a5a:8d07:6a00 with SMTP id a640c23a62f3a-a622814c36amr270759666b.64.1716451181810;
        Thu, 23 May 2024 00:59:41 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:982:cbb0:825d:600a:c16:a973])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5ec2a8f320sm719100066b.170.2024.05.23.00.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:59:41 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/3] arm64: qcom: sdm450: add initial support for Lenovo
 Smart Tab M10
Date: Thu, 23 May 2024 09:59:32 +0200
Message-Id: <20240523-topic-sdm450-upstream-tbx605f-v1-0-e52b89133226@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGT3TmYC/x3MwQqDMAwA0F+RnBeIWSubvzJ2qDXOHNTS1CGI/
 76y47u8E0yyikHfnJDlq6bbWtHeGohzWD+COlYDEzvyzFi2pBFtXJwn3JOVLGHBMhwd+QmZSR7
 P4O5xCFCPlGXS4/+/3tf1Azu8EiFvAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=+j8A4VZeAl+Y4aj2STDkjjffz6s3NT87BVIa8sVLpDk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmTvdmN2PpWBGo+DgdsVg3di1/28MIozIYQe4Kh
 iSsDdxrOrGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZk73ZgAKCRB33NvayMhJ
 0VNYEACMzhmilSv/cnWGpD3CJ5na508TP5YZevct065S/q7D/76vqdskqd7bihAaIvNtgVfToie
 f3xCzZe1T6MzhNjpvx3tBihB9xgnU4hxMS0P8iFBqE0WQ5lgnED7APBV5GJoGl6GnuuHvF632yC
 sGod7gp+cVu8x7AU+Y3nB7GB/2aDFVnS/ucL9lf5/6JZhMtPmNH6qJvOtOAUaYYnCqusXfzbiTr
 a1VS57Eh6aMDjvOfBCBrge7iSDaCVYXA0wdIM2cq7Y2j/H6uLMlI8PRtFWfdnEOGyLsGczGiTYL
 OTvBu23RdE/yI+rWPGlKa/oX5pH/3p5eyUCQKC+Yuc6tkIRVkBFoK+Algh6hfEzFlVG/5gvquyT
 Jd6letUrWjNBV8cOuYINAOc8/kpi9tBWoDbrRXQXfRiTrx/oCxkL/NyLjmobCGrr4G+QrOEfXK8
 hymSBp5vrIirJG09vd48+F9/xw2H//m/BUijQLD6sK4NWavgDs7jFwRbXze57XzZIUoarJdYZ1Z
 FP4r+i+5gleIyVIEgxxw3HnMdCWGz/HN9SVEtB1TkpUDKTcu1TpfcfuBgVdGR7rvorSEFc3Q5ie
 uVJNWgklPatoHrUOIHNej5qEPp20j90NXFvr8Bb7f7a+v9vWzSkrpZKadQHh/80+UPrlV+XE7m4
 OG/MW5VlvJf2yJw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add initial support for the WiFi version of the Lenovo Smart Tab M10,
model TB-X605F with:
- SDM450 SoC
- Up to 3GiB of DDR
- 10.1" LCD Touch Panel
- eMMC
- Bluetooth & WiFi
- SDcard Slot
- Camera (unsupported)

Tablet can be found as "Tab M10" and "Smart Tab M10", the "Smart" variant
seems to comes with a dock I do not own.

Vendor page:
- https://pcsupport.lenovo.com/us/en/products/tablets/m-series-tablets/tab-m10

Downstream sources can be found at:
- https://github.com/Yahoo-Mike/android_kernel_lenovo_X605F
- https://gitlab.com/ubports/porting/community-ports/android9/lenovo-tab-m10-fhd/kernel-lenovo-x605

In order to pass DTBs check, the GPU SMMU compatible needs to be fixed.

The current display uses simple-framebuffer, proper support
of the BOE TV101WUM-LL2 DSI panel will be sent separately.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (3):
      dt-bindings: arm: qcom: Add Lenovo Smart Tab M10 (WiFi)
      dt-bindings: iommu: qcom,iommu: Add MSM8953 GPU IOMMU to SMMUv2 compatibles
      arm64: dts: qcom: sdm450: add Lenovo Smart Tab M10 DTS

 Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
 .../devicetree/bindings/iommu/qcom,iommu.yaml      |   1 +
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 arch/arm64/boot/dts/qcom/sdm450-lenovo-tbx605f.dts | 276 +++++++++++++++++++++
 4 files changed, 279 insertions(+)
---
base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
change-id: 20240522-topic-sdm450-upstream-tbx605f-220e89a43cba

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


