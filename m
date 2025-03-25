Return-Path: <linux-kernel+bounces-576036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF442A70A32
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC8B188ACDF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0B21EEA30;
	Tue, 25 Mar 2025 19:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ofg2URSg"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CE81B412A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 19:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742930506; cv=none; b=p+lPDhOLL3snobAIWskD2Goq3eehrhV+QYIBa2X6YtQHYCLH5njgaBFphBUbcY8uw/6bk9qLSgQ7CPA9QI0hC/BmzkF1/8G6U3txo8fcrgjcaM/+zo+H0LFxB4yRLTfkIF6APeqp+sLIpp+LPHXm2l3T8ymuv2hyKWvGtgmhKOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742930506; c=relaxed/simple;
	bh=tTDdAbM6FEoC6Rnmp/8WdmqaJi5csQEBgAAwOs8qGxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rIYQRnAssBzF+qCWgY3FjGf/AXWTeVJQFFPRUQTwyb87ikOur12LZDtPI4HhfVr1L4bC5lXNVRBvYAvsD9qlcIIAOBhbe9ww7LH4eGeFAd7Loj1q+HuVNw7vDGkGjdgM5u6BVvA9dMW9w1Y2naJOl/Onwh7YfLNipfXvKT5d4dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ofg2URSg; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso3500660f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742930503; x=1743535303; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xAjj1ZGQzbODWEBIkfTAWZWQleeUyTNk6b3kRAxKYM=;
        b=ofg2URSgjEEXN29tAytCupZuL9oSQ6Fo2sTWNzZzXxVb1rVWZYUMCQW8qTIRPC7u50
         5D4/gxc6RTw4G1xgu/inrK3t6E5jZJVgNpn6cEZFfg6NvGFbjtfUsSjsfqT6+Na5zBpi
         05HK/0G9HudlvL31UHYfIyF0p+Joxfgsn+3EwctN0uNcltXrVGtuFvPg31Rqzuv2JrTK
         jqlMLX4YH/49piUSka587fhZ+uF/CM7sSZrVuV0tYd1T9mcvaAzfvrJvInMfR5S6Qv90
         VXhnixcL1u5V9MSJ52FXVks8JGPJWjnXX/WNLM6Rf0kSKtqwy7/r/nerBvXBqaZGCeju
         AMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742930503; x=1743535303;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xAjj1ZGQzbODWEBIkfTAWZWQleeUyTNk6b3kRAxKYM=;
        b=Mfx/cc3eW0nEFcqqpSMnML8lA75be2t3qR0Uco0WQj/ZWk6EKkws8Rf3Hwa0zWWEK4
         v17f0tibDMpetmcHMssyIxgjWxiscI+8hMRbNRs8uOlgIC0G8Gh/rVVOsWmgXPU19WH1
         zfT37Eiu8attNPfscE/9zDXQB/R8s+iPqT88MqBp201gDjs43IvjEYbAhnftlf1diQ0/
         EtXs+tQ4L4/0YvzUdCJdh7s6ylmw35cF/Vi3FCExN8gbFnIEg4nCYYx21nn7D9wb8wR/
         iDsNCS8G5IXBbgNqTKRrMlGejBin3jsn5MDMB6LHcKVNgUK8cTA6/AzNHlhptv0zKym/
         1fQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrwX1lrJub1vBsVvy0ajGWktilwRXmOQdhDr+b/kPxBQ3dzUoh/7EJ882D+GV2QRYXI/DK6PmUZnoOUZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB80CgEjjSHv5FfAd1vEyHZiybuCNUpuNSaM10Bq3HmrdAhj9j
	4+9bODlUZZexityN3J5fCIllznXCtnmqfXqjxBsvDmzKk8g/UQsT0bXnEu1LrcE=
X-Gm-Gg: ASbGncuXTH87a26gLtCoS+cQV6TWbsOBXVY7FwfavC3BO0g4wxmBPcU+KNxo5Moznm8
	Upue6OD+UEeHjcqs9pyubZbNfs34W9Zi2UqlARARPKU14zwi5eemS5ceGKAupOHCAPzar6zH8t1
	BQ9vSqyL9waOlqagM6a+MIcfxKY2dAggbMWD8ferUG5IIwLd7VVm+xkcFscINOX1ptKqBSn1/Kj
	Gud93BKmSAoAPSggXs3YKWR5hF0S47T8TQCOfIfwhevT+00Agi4t2ORiNvp+lglbWBQVhfWxO+x
	j0435kHPj8EOrakt/MZhxpYV7l4BBNRx/7o1rYxJHQm1pxXijXlhmtwJ
X-Google-Smtp-Source: AGHT+IGmYbu2karVwSKvKAwF5XS/np1cbnnSftiOniiKevwsN7ksXMbWmbShuyMDFyF/HI91Qcd+Vw==
X-Received: by 2002:a5d:6d81:0:b0:397:8ef9:a143 with SMTP id ffacd0b85a97d-3997f90c860mr13768026f8f.23.1742930502791;
        Tue, 25 Mar 2025 12:21:42 -0700 (PDT)
Received: from localhost ([2a00:23c8:b70a:ae01:9cf7:b69:fc50:980f])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f9e66c7sm14633284f8f.79.2025.03.25.12.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 12:21:42 -0700 (PDT)
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Tue, 25 Mar 2025 19:21:26 +0000
Subject: [PATCH v2 1/4] dt-bindings: display: panel: samsung,atna40yk20:
 document ATNA40YK20
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250325-wip-obbardc-qcom-t14s-oled-panel-v2-1-e9bc7c9d30cc@linaro.org>
References: <20250325-wip-obbardc-qcom-t14s-oled-panel-v2-0-e9bc7c9d30cc@linaro.org>
In-Reply-To: <20250325-wip-obbardc-qcom-t14s-oled-panel-v2-0-e9bc7c9d30cc@linaro.org>
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
 Rui Miguel Silva <rui.silva@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, 
 devicetree@vger.kernel.org, 
 Christopher Obbard <christopher.obbard@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167;
 i=christopher.obbard@linaro.org; h=from:subject:message-id;
 bh=tTDdAbM6FEoC6Rnmp/8WdmqaJi5csQEBgAAwOs8qGxY=;
 b=owEBbQKS/ZANAwAKAWNNxPBocEb4AcsmYgBn4wJF7FGQSHT0VbmZT2yMBNAiYq7fD7bvHw/lr
 4Kq+iRYd/aJAjMEAAEKAB0WIQTxi9yLbCX5CqI9UXRjTcTwaHBG+AUCZ+MCRQAKCRBjTcTwaHBG
 +CBAD/9APoHHKoz5Ux3QZFEQYB/24B/r4/Cw8EeywzGzDKkBf0HuS2/jarVACiKA2KzyIRnnA0o
 OrHx39pDhVkO+0wBl0FtK0cWjwlNsEGsrcy5OiL3rZYsz/xnmzeWCu1UJGgbgQ0KJvK5eSqaC1y
 /U++rbQMn3dbQlj16/sWmFiCqrMo5C8qWb1uietBgKlm5hVIUqnTfdYLvxlBi329pynqa8K/AHO
 1Dci97G+SK6X/tXR4fru7iagN0AhcPUH3HI+og/zVqV7/GywsupiSAzy+8Usvv8qXxkE4qhTD31
 ini7tAYORal9ksQn0fhM3wTHa5nZH04AuznDcMTXLMUq5r5cR1UjJOPmj3aQG0AiRgmymtD1n07
 mdKNAXwq/o+vfXNRUvcX36tgjIhWZ2NHhkwnWURqM1hM4fKT9IdoP3FNbVFcqM4S6KSX8GrUFFu
 t1ttLx4Y7s0ko1iXSyEjYa6qv4d4Olb1+RvfdjJ6r2IzBpEtv1JdBxBiZ+HVtJW18S2F9SUZGjO
 fD2c2yfHSaytSFx1SygoVDQgwKJBoFwcWF5B9igCXjLqKX1B48tHjs8EmyvdlfCGx3VF2EtpG8x
 5xYnINf8wSFQHl4KP/DUdhBM8vHvqX2/2o1gOdavJc4IIzFU7+iFzj7CQg0+CzNifKMfHsfB1lT
 pZiCe73XMa7poUQ==
X-Developer-Key: i=christopher.obbard@linaro.org; a=openpgp;
 fpr=F18BDC8B6C25F90AA23D5174634DC4F0687046F8

The Samsung ATNA40YK20 panel is a 14" AMOLED eDP panel. It is
similar to the ATNA33XC20 except that it is larger and has a
different resolution.

Signed-off-by: Christopher Obbard <christopher.obbard@linaro.org>
---
 Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml b/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
index 684c2896d2387077cf2d91cc5a025e0838c0f536..31f0c0f038e494234d896691f3cf0b9b7cd8842d 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
@@ -19,6 +19,8 @@ properties:
       - const: samsung,atna33xc20
       - items:
           - enum:
+              # Samsung 14" WQXGA+ (2880×1800 pixels) eDP AMOLED panel
+              - samsung,atna40yk20
               # Samsung 14.5" WQXGA+ (2880x1800 pixels) eDP AMOLED panel
               - samsung,atna45af01
               # Samsung 14.5" 3K (2944x1840 pixels) eDP AMOLED panel

-- 
2.49.0


