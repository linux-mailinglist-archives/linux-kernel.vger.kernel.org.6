Return-Path: <linux-kernel+bounces-370372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2AF9A2BA1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC3A28620E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFC21DFE14;
	Thu, 17 Oct 2024 18:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pTlbmQ/d"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BD61DFD8B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188299; cv=none; b=RmgagsmKKYzN5OkcC3ZDRn3nzvjFZFzWFuWXUtS1CR2h5MC4QdmnQlYSMMdTJHtVVOQrgJPxKhenIuMvkq0+V4rWpvK4a5QjpVrUSoRdPS7tDvPSnghx6wrzzUBZUFqrwGvxTjTxK7MHw0wuEJWRCUV5hPtnQT2Yoi3nEL2KtkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188299; c=relaxed/simple;
	bh=O15mCh3VtZU97Mpx6hgeP/jWXAjP95Snr2eA5fDon0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KE+jldzrLZjxhhg6mhdtVKL7sSrdW1Wv1zhrZdEmkAYKDa7sZVLtYaAr9nGe41UVAedRl6Zd4yTiWZ6yPjob/iCZuRnDGxmm5McBaf2UEoQuvl+sqAMwCT4kkA/6lEKWVg40rNgAz2X2M8QT0vFuZsAVaREqVW49Pl6uQDRGKYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pTlbmQ/d; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539fb49c64aso1856636e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729188291; x=1729793091; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XaymF0ZiBA6V8Fk87JggRvX+rVkin1b9pjhriuc27Y0=;
        b=pTlbmQ/d+gL46Dwelxm0zknNBSNnSbZF/+KyiowAFCFexcvkIWcaETHN+CblHQc9UI
         EjGxPao+pKLiK+4/q79m5ZDroquXFPHMPgdnc6+YZBKKJ/+sGZtFE9KGsDzcY0ydw5t0
         gV3kwhHIuUt9oqn+bmqcfXDYebQUQYzm7dd4/THk1jT/mOkcd9Lkpf6ohi2l67zUhycm
         Ui8qVIbERCeddqFiIq4w3gt7mr420t8YET8tIlnybfFmkyP+ryKO4RmOkFe1cEBz/6G+
         9Gb84ZtVCl2a8uOUPlV/sEUNRIWCLpUbtoHunUSOUBR1kr9Vcv+mEYvgFib9RP4YcJYg
         B90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729188291; x=1729793091;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XaymF0ZiBA6V8Fk87JggRvX+rVkin1b9pjhriuc27Y0=;
        b=gnYRU6Vn0QN0YainoQw4nZW45kPtllBIFNo2lq43kPXh4sx7NURAnAGd5i7SFEWven
         VUQ8UJ60PhLGIelr/Gpe+M1sIkxYYmSh+P2HTTTiILWtg+lr48ws1AacJNoaqpfGmlTX
         C7BfCr9zt7U7vjoQDXPNGVpTMnjKKzWPkvkgi9I30TZTIeMkDfqSzIrYFZte17zsmNFC
         7oMG0d4/0oT7mLoyvYnYfYbSyMCjLEM2gF5sWKZnE/PwRpIbu0U9b+kiaraLPPmXm+O1
         4Ynb27vsmcGPDoJpEBsnlbD5oj01Q7aZVTtR+XCUDvOVbER41/sFxI6RgDoFxRed20d2
         JSsw==
X-Forwarded-Encrypted: i=1; AJvYcCVSqjCyTN461vkJXlIw2TWKVRO6QzRJPtteDypQ4duXmNxXANzcEkH51iqTB9JPywzeOfHxTiYn5Qzn+Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuU3rwdMhqYChfqIeu10HXRRZW1QjAigYkRa8xrM6UKNAkjXKe
	N33GI+GfnsAyXQNSvLF6v79a4lZW4QXyuq68Ti0lm4gPkHdm0zW6Ou/kNANJxtNcuyFzNsRh59D
	/3kY=
X-Google-Smtp-Source: AGHT+IEtaSRfi/zuQd0/3BxDiMd84LqpMen+1AmFAWxym0m/1Njhxs+M7M01GS96rbcHuSvVwJ/8mg==
X-Received: by 2002:a05:6512:2244:b0:539:ad93:f887 with SMTP id 2adb3069b0e04-539e5522d3cmr15495948e87.36.1729188291239;
        Thu, 17 Oct 2024 11:04:51 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539ffff3ddfsm826195e87.149.2024.10.17.11.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 11:04:49 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 17 Oct 2024 21:04:47 +0300
Subject: [PATCH] dt-bindings: PCI: qcom,pcie-sm8550: add SAR2130P
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-sar2130p-pci-v1-1-5b95e63d9624@linaro.org>
X-B4-Tracking: v=1; b=H4sIAL5REWcC/x3MQQqAIBBA0avIrBN0CoyuEi1snGo2JgoRiHdPW
 r7F/xUKZ+ECi6qQ+ZEid+ywgwK6fDxZS+gGNDhZY50uPqMdTdKJRAcyhLiznx1DT1LmQ95/t26
 tfUdn/YZeAAAA
X-Change-ID: 20241017-sar2130p-pci-dc0c22bea87e
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1526;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=O15mCh3VtZU97Mpx6hgeP/jWXAjP95Snr2eA5fDon0o=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnEVG/8G68/lf7OSluZpPo++4hB+Ws2ABn0W8AS
 w2HBjUHOKSJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxFRvwAKCRAU23LtvoBl
 uDRFEACjiiUvc4JlyT2BHMwSCQBB6n2qjwJjB4kkuTTtHGHF+okKp8yzFPhmFz9ciLyRfK9PxG0
 kmHEh18U6z4glv7vUbjSaT4wR8gphPEyKAHN/gpXEikXSzlsFKCrwUoghPyDrqEl4+i7yf9Aepf
 PxIp4xfOBzW4QdR2ClFzmPQky3yO2kNXHMO1jH4JyNA0TZk1K0TNRAXlfzND+gh50INLD4eJfMp
 5AqY4nlKURTtrTIwhF0Zwp1t3rXAE94Bz2wjfBbXvwnWUxS+PXQ4K60bNcLjJ+2piuKDlcHlScH
 +eYTeE5Axqm0GXEmyxyOfcX/KuXwMoWl0+NNlSnt1iWhDZPkyLVcQxWI2uAwjy8stLVU8LGItR0
 mABUBlaZ0ATnbP9u88hF/9WiBvXpbhzQvT6U5tzjcv8T9z35xOxzA0l71yovAg4dBX0SdSxS72Z
 MqCVCEdMZSYDh8TScFbynwLi9t+JR+5Af1jls04vW1p0agbKT4dMtyHp/jhFz2ypUERoh4tWJYj
 1n/bLUUV3pJPrqm3HO0Rv0HaGGBiRWJryPcXZWBMUsjDCWg0Xe0dVq+Ky6+b/WX2tXnGol7qbUP
 MnAsIKNnKR3QLNiO7muZFaciN316JZlLBfvEByXZEJtg0a4XfyIpar8qlRlyFS10YWX9RgK49gq
 SIqdnb06KAadgfg==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On the Qualcomm SAR2130P platform the PCIe host is compatible with the
DWC controller present on the SM8550 platorm, just using one additional
clock.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
index 24cb38673581d7391f877d3af5fadd6096c8d5be..2b5498a35dcc1707e6ba7356389c33b3fcce9d0f 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
@@ -20,6 +20,7 @@ properties:
       - const: qcom,pcie-sm8550
       - items:
           - enum:
+              - qcom,sar2130p-pcie
               - qcom,pcie-sm8650
           - const: qcom,pcie-sm8550
 
@@ -39,7 +40,7 @@ properties:
 
   clocks:
     minItems: 7
-    maxItems: 8
+    maxItems: 9
 
   clock-names:
     minItems: 7
@@ -52,6 +53,7 @@ properties:
       - const: ddrss_sf_tbu # PCIe SF TBU clock
       - const: noc_aggr # Aggre NoC PCIe AXI clock
       - const: cnoc_sf_axi # Config NoC PCIe1 AXI clock
+      - const: qmip_pcie_ahb # QMIP PCIe AHB clock
 
   interrupts:
     minItems: 8

---
base-commit: 7df1e7189cecb6965ce672e820a5ec6cf499b65b
change-id: 20241017-sar2130p-pci-dc0c22bea87e

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


