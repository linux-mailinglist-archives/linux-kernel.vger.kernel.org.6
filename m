Return-Path: <linux-kernel+bounces-374108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15B39A638B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B543A1C21D3F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245971EABB2;
	Mon, 21 Oct 2024 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VN0X1MUy"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADA11E907A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506798; cv=none; b=fEtm1AFk8qpbssW8Ifj3hBLM+LzofefqWK7jcQl84awHmiTwILEflYYeKwAKp5lAjDfBWbaT9z4kiqVsVSyWb99Rh9e5HDPwk0oGyioQ1IlWdfTLWAdprPPLA3MK6HJsSBO5IP8ZfwmGJRLAqCh/VaDYjYTg4PjkY9hM4kfoYUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506798; c=relaxed/simple;
	bh=5Y/fABq9b4vk+PutXYP52URTjzKP/DzFXovrE11VWQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Svcl5cJrtr00c192OMqMc8oFEUWzhfmHr+Pdop1w0ZYyD9Uebnt6wrFxoHw8bDYOM0yW60bc/7ROQGXsmaUyPZMpwwSZDdnzggs8jK6K9kUET5Ap1pAWvDsPixT+IQflN9MnkTElywYQAykfhgmWDwOwfrE9WC76nFX/vPLyoNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VN0X1MUy; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f58c68c5so6302359e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729506794; x=1730111594; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYfkdNF3O8TZS4V0T1JegIJYADXSJj7bD5ghT8EX1Qg=;
        b=VN0X1MUyjbUT3M7MvQhMmTsFosBXFXDWP7pfMSf59rDhV45TPRhoR5tTrhdI6u1V3O
         RcD8D+NgMZqFDXH9Lf1z4jNLERZf8xyL45Fy+kbzmhNzq6+Pyb1q0iHwRE6QZ82HesNE
         S4Osy2Iarc4eBJkcGQGW1V6BVRmPuePjngjx/6kHp7J8ZOlGZZPzqwXZpvUKkVUjkfAZ
         2ee8EaUZHUL3WLnIfpq9B36T0VgOJJ0gOz83WXOhDPiYBWQmAV82HF3ex15DfjJSLfHY
         +5X24/Yr0U3bHIXWsmRYVqC0FMKdbtIkgSa0cZG3KBSG5NWWwB7E7RkbSxNl4kd7jfdH
         Uv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729506794; x=1730111594;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYfkdNF3O8TZS4V0T1JegIJYADXSJj7bD5ghT8EX1Qg=;
        b=vq+UT7F19e9W/LYjzvBKiEjlR0ymc8wWQ9WhmE6fgvdnSGSw25Zfe44z5W2vPGb3SY
         vkkRv4uNjxIXBVF/Ws5LQhE/Jgv0c4eVYnsXNt0MI8/jG1TxD9KUsifJSaf4Y3wfGmpc
         UEpAV9B+724yhOCok873pG/z50+JbOpKqzjtsePFCqardJoQN2e9qoW238Ls513D92Wh
         pfjNLPAIfqVAkADLWs/XKAr3d4IU9/Z/ebDNBl8GxZngW/95ARha3nTawoZAx8xCX1xK
         wLEcFrGeZy5yy8vLV+V80VPXfombZO6XsV/aJBAJb4NyxrksokLD59L50B+Uooxr8YZC
         LR7w==
X-Forwarded-Encrypted: i=1; AJvYcCWbQHrhWxmQEmnFncgOxG1Ual6ldscd6PKLRWt4FQcr0wolMC+R/xYUVCZkKsIoZzD2+cIa6GECfHzxy8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YziOSAOzX1ZrKxW2Awimi0/+XzjRJp2NwgPAnjTxTyTfqGz61Ek
	VUFDiscjklApSOxB56jht4vcpAbMyMrcEybcvmZwrg1fqAZtGLRgnL9/+3qvIFM=
X-Google-Smtp-Source: AGHT+IGmbx2g7eFoaGvGb051ZNzvURUqKvBQWmVN8iCU6PsIsn5QCeAVxaRkUqIa877MeDJYqaKWsQ==
X-Received: by 2002:a05:6512:3d1d:b0:539:e0a4:1ec0 with SMTP id 2adb3069b0e04-53a1546c918mr9981537e87.29.1729506794357;
        Mon, 21 Oct 2024 03:33:14 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a22420015sm454132e87.123.2024.10.21.03.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:33:13 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 21 Oct 2024 13:33:08 +0300
Subject: [PATCH v2 2/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Add
 SAR2130P compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-sar2130p-phys-v2-2-d883acf170f7@linaro.org>
References: <20241021-sar2130p-phys-v2-0-d883acf170f7@linaro.org>
In-Reply-To: <20241021-sar2130p-phys-v2-0-d883acf170f7@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1242;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=5Y/fABq9b4vk+PutXYP52URTjzKP/DzFXovrE11VWQU=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnFi3kTP8dkpzDsoU+54Z5eLE8yd9nAJri9R0oS
 ALrmpKRzkGJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxYt5AAKCRAU23LtvoBl
 uJzHEACzUv96sfyayVdpKJ6T0eDjASoB0frXf3HEqlvtfoXQxdAtpB/ENJOhnMFSfv54SD4DOFy
 tFEzraVCsiaTtKwTdWgXkbIhcLehfgBRSevnRZTLpUJ9fEOph4tmnBTpa+n0ewYpE5/IPiw9zjN
 56MHTopXaVGw/3N7qrbscxKFwpqU4149ctHFY0UqaWVi1GkZIX5XogPUR/ET4fgtP5tX1qABBg/
 HaJLZ2PIDXmQ8aOQqDRf0iR3j24icHvrIPNy/HEzkoiA52HzPBdwjCAqNRXcKMqSgywlJfYRS9y
 R3XU78spz5Zp1fN6sQoZcjjF7QDRvTjyODFOFtV2bVfOBedsNs545/SSjqjg3jLD6+GkZ+p2ao0
 drDIzn1h7FXPpbbwF+DBaCYkOdaqm1pQW1iMMK8vEr7egSU4stOd6Ujp8DRWwZWRtkZkKakIlUq
 PJ0ftT7yM7YmZIEsmXWMUScGhgfTi9k2pzfKFys+MqYajo9VYGqzEw6h548oJzaFa9QfvBmT+kg
 U0hnDLf2WMjDDYtShpNQWVfpgixw/hCj9pmHl1h+3z6YWCA3NgLTlLhObf/AxQSo+JJSBzyc40H
 9DSkdoWR/DsY1lx9Bk3RrFkPFkJle6/Gj2TX3h5LKk47uGHjaXZBrcZIXZG3qIybfsnqL+9XSin
 8OD0u9CajZ2n0kA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Document compatible for the QMP PCIe PHY on SAR2130P platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 3c16330a58ec68da32486637e02ae89af9a06a3a..9b3b6fedd70ee924e7757ce531bdab0fb6a3cd8d 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -18,6 +18,7 @@ properties:
     enum:
       - qcom,sa8775p-qmp-gen4x2-pcie-phy
       - qcom,sa8775p-qmp-gen4x4-pcie-phy
+      - qcom,sar2130p-qmp-gen3x2-pcie-phy
       - qcom,sc8180x-qmp-pcie-phy
       - qcom,sc8280xp-qmp-gen3x1-pcie-phy
       - qcom,sc8280xp-qmp-gen3x2-pcie-phy
@@ -139,6 +140,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,sar2130p-qmp-gen3x2-pcie-phy
               - qcom,sc8180x-qmp-pcie-phy
               - qcom,sdm845-qhp-pcie-phy
               - qcom,sdm845-qmp-pcie-phy

-- 
2.39.5


