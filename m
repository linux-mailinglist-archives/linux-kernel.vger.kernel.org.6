Return-Path: <linux-kernel+bounces-370262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA159A2A04
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6673B1F21894
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A001EBFE0;
	Thu, 17 Oct 2024 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vDX9n/S4"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBA21E3764
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184239; cv=none; b=NlkyxM7OdmVxYTGrLILmD7IySGAoC1yevaqHdbkI3sES7O/tSJeLG7MFSdXcNVJyM9QUD6129dUunlCSsMaZNGZ1vCcYPJW9ijgmzHpjdKU2P7I3desmZeC4rZr0T0EYxyvtq5BLR8XOlllk7oKrVJvwuX9lkoPdmxnqBx5Fyvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184239; c=relaxed/simple;
	bh=14axJ57FbtWb4/jR92DfjULo+XXCtDQGIgTfdhTzMXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=os90ACAaTZ7p/oS9nyrok2WieaCDysmMlTnl9xcRogIjVKPM6WQ9TmZS8niERixi6LC71KuPUWmJuACPiEqABwgIG2DlIQF9FPGJyO9qKmDpf6iwZM8BQBpUiZlwBDFZfrF4vtdOkTrgXLCaxRDSgD2as2DrexebNlpWbpV1x7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vDX9n/S4; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e690479cso1393288e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729184232; x=1729789032; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENqIH0Vaspt2CZ8fDMyaIQtRaMVXtP7wRvavqANXfOo=;
        b=vDX9n/S4NUtBzOeIJgzXpFXihGV3j2FjBccrdJGNJQz3x1NGy/DAXwVnCFgoykApAz
         UwKJNQI7V07d3WrHroqh7LfhcIeZEvqAD51kElVRyvpLqUjHXuf9+roZ5K8FSDp8QeEl
         Yv18Jya4gJkf7VPaTq0Rgqph8jLXwqtVilmiGQ1zBpdHW9glSkDL0BUL9i4onatTyUj6
         hlOElLpS7kgT4sbiOMNfDyj/UdqBjv0ShWgcQNdpUHiqZ3pBmYJGRx41kpXKDWg3k7jU
         RUCxkgX671jAdMbKLgHwnh77NBO7mu4TQ1pdgVFK2v/PeJoQ0AsACp/ByF+CTCBK2PkC
         QfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729184232; x=1729789032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENqIH0Vaspt2CZ8fDMyaIQtRaMVXtP7wRvavqANXfOo=;
        b=taQcK6SOEDMjVDfUW5YxnlmvBT0iru4lemT6/hG85Yxii2JrtkztN1GKS4SZ4Bq9ze
         eutiM45EZSVP+sZajPCWZMH1iHllLnAFDJvJ8V5ElcwxVXNbUVJ1vwee/5TA5gJ6YPWN
         Qa3PTbdxYySiHdGLihSEplpw8W9bo9+ZRohj/V4LDHteANRFhGNoQ8sSIkWFHRyFUCCL
         5iI79dr72d4Q9pq5vP7UkRwKYZKNSmTDu05Q7uH5QNMLJCR7nMBTKyGplHV8vpkNqmqc
         Hpf5zPe9mlnh671MHA7YF4z3O/D7xRsnagKiK87/c9DmnIz6Leo6AJUPWTr7NKhaZIFO
         7x4g==
X-Forwarded-Encrypted: i=1; AJvYcCV30VoZhYXEOAACxaR3XsvluV1NgfuzBm7rxXwUxah8Z044VHlTbGiC7pmH8Jac9p4jeZ8GYavrA6pyw2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmgpLIGx5tGwD1esmWfSJRAoK2dtXK3qJRZcUH1SWOLInj1c/G
	mqC5NwaHNSlbYGXmB3CYH+yQWYPRL0bDuXXyQW7NBd0yq6qNNgN74DkP5Fl/yPE=
X-Google-Smtp-Source: AGHT+IEcGrDyVzcEIzZRfyzlFuV9wQDyJiLO4vLVAKRpWIKWz44COicxpmd9zvvP8vuCF2wnWNhVXw==
X-Received: by 2002:a05:6512:1598:b0:52c:9e82:a971 with SMTP id 2adb3069b0e04-539e54d77c8mr10757466e87.7.1729184232038;
        Thu, 17 Oct 2024 09:57:12 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a00007078sm821563e87.212.2024.10.17.09.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 09:57:11 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 17 Oct 2024 19:56:54 +0300
Subject: [PATCH 04/14] dt-bindings: clock: qcom,sm8550-dispcc: Add SAR2130P
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-sar2130p-clocks-v1-4-f75e740f0a8d@linaro.org>
References: <20241017-sar2130p-clocks-v1-0-f75e740f0a8d@linaro.org>
In-Reply-To: <20241017-sar2130p-clocks-v1-0-f75e740f0a8d@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=848;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=14axJ57FbtWb4/jR92DfjULo+XXCtDQGIgTfdhTzMXE=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnEUHaITb+BlRrcr5PjObGdH6vg9UuJ7Tx8zPv8
 GAu3FNRoDCJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxFB2gAKCRAU23LtvoBl
 uLLSD/0aOLEGwGB2tgzBdQXSAGiihf0HpuXVAsScLG3c3Ztgd7N/UxK6vH9yWtYCaA5+5L46Cun
 eDYrXsEteuKYAehHGKKbTma6aB0S/IEiTtLRueMrYabOq1DwYPbgUwHhU1lCxP3hwQqGqsAEXAY
 YRrQ/EJCItKfVsZyU/gUAIaHMd+g2ZyDocrTC12h6df0U0X9acsyBL6JszePBNlOvEMnfRjbfNR
 hKVqeB48kFHVaLlrENz/Z18+ERZRYRhEdePg+TU9J/TdIQblP/8gj/Kw38AUNO91f7zFJ4eZ1Ns
 dfqGgNhPKongci07+4EGjzd2qL//SszOXtjSZoZaiqZg5FQ5Xt1Bf5T9URUkXvyvZ7ZMnDKZUEn
 /KlQHbShdHzI7RpuO9E8j90DtZM9Psy6dUvbPSGBRDoOu6+9AaDZ7NMMgjZrM1p0EAVlGT/ZwY+
 VAKPHsX2p/fWgZV9F3PCIKPXxRePqgob1c14OyxzbLdTtcUoYXg3FHmXyM9yxZy/rB5tb+6j5bY
 vmDpCM0/z66n9C825zg0AZo3bNVoyuvmLoayizXSYHQC1i2dkT0ilf+fLAV0nFdew+qnRK8iOUo
 FjBuE63Hm6tLx8bo98SdfTorjv/G+71WCJIRviPKQGt2Ir9Zmx+M9xnpv1Fuz5NpI1sz3+VIRgl
 k83hPGTaszpimNA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Document compatible for the Display Clock Controller on SAR2130P
platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
index c17035a180dbf3dde715a281bc54165122739618..c57d55a9293c214c4c101902cdd9603074e2243d 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
@@ -22,6 +22,7 @@ description: |
 properties:
   compatible:
     enum:
+      - qcom,sar2130p-dispcc
       - qcom,sm8550-dispcc
       - qcom,sm8650-dispcc
       - qcom,x1e80100-dispcc

-- 
2.39.5


