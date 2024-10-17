Return-Path: <linux-kernel+bounces-370260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FEB9A29FC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8E61F228D0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285E91EB9E1;
	Thu, 17 Oct 2024 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eOklv7Fb"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9AA1E1A1E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184237; cv=none; b=eV8iYdfXkFM/+V8Glf0K9F4en/Eo8tcBbRdN4nFBcDzKJixbBSp6gK2x8gzlLPC0w9xH9VtUt40/Wg/VoZoHfLRYcKqB+lJtQ0jr/EcwC7R6kLE4zCgiL2Ns5IV/NLDBPqlpjW9/MBB+g3VdVASERpIUOydkcnUPOReYrvbdEGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184237; c=relaxed/simple;
	bh=Bx2eQxGp0RF29+QUY/ufB1DhIZwqeSmn4ux3YLXYV4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vf+6g8VhuAuXsLtOXzl6zA1hOD6Mo2vwYQNW2JopbT6cxgCpPH5Z73/BVyq1BtQJ+QfylwvPNSMGbRb7gst77VCfHDT142aGnRUXnjBRGxMeLSxkcXryszHlAX6r2INm6mKR7LzNgIsm0fFLI1vZNLrPKVXDfXQMD1G4CR8Hai4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eOklv7Fb; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e6c754bdso1224322e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729184230; x=1729789030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yimN+yREz+afeyqqzhay10kgPyw054AnTbgMeMYQ5Zo=;
        b=eOklv7FbPRlzlVqhUDn53ZaVI0smAgI2G8DPazCMVD+fxxrWmeYdZOWzueR8FBdFx6
         vFi92rV234HkndKQabJBkL5GN19Hk+8niHSjAa/unfj/dVXOllne/9phTDLJ/F+4E4RF
         zQdd/aZFXsh1w7iQCP2Y1nBY+c2yVY75d7eegsHA4CJExnlphstq86/U9KHyCDinQ5FB
         zYrI4D6MWGR4wjUy6NqyXC671CJ7DlZ1gA4mk9R7Ru40GRQZhlur0zAQfzBC9n5UpECh
         lCS19lqsNVpI3VNIbbIZ0oOkelKDXkD09axVEqbhi+DE+PMNJ1QUdDBn4z3CwHjynIOe
         WpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729184230; x=1729789030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yimN+yREz+afeyqqzhay10kgPyw054AnTbgMeMYQ5Zo=;
        b=tGueutnXvdFfYbDuIsXtrb7ESgYDaUSYKn++7QsQapG/ATkz4/NUJnLdVvwtroveSe
         g+RBmKUZdrQSxIUN7pADGN0HgJoldn/zhiQFE5QfTP2AuGJ3oFP9g+5mW4cTsYbe473s
         GPH+G2y7q12aYGeXetzXYP3hfSIeeEerp1uih6Jn0LMqB+fjn7dBuzclVdM+oSWjr1Hn
         4MIO4Ad1A6Z4WG2vKQ+jOQMfhYJg2H3oEU/HiLW0m3+21DQPEHQ3wIm494E3LuZjJInr
         m2KVthoaR0e6JxiX5jJk69c4DcL3t1ZsFgjKpsdYxvldBigIW9ffRW7yCLfGC/+eFiQC
         B8DA==
X-Forwarded-Encrypted: i=1; AJvYcCWoQ+o2rS+8HOerrS9RfQmLiyrikg/mcrqKAvl4ftI0dxmEpA9giRjo8zzfg5baTfqQVW1L/bGmitICrRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAn5z+eGRoimTsWch6dJMLAAezw6xlJnDDfFx41TPJeSQxtOlW
	0QJTy6BXAtqYZnwM4QnbrvRZbM3QQ95chWtf17xRov4EIgJ1eiwybSNptKQG0GzUuq1/Fo4OlxF
	bTEc=
X-Google-Smtp-Source: AGHT+IGYF9uU1n1C1YSfETv/Y+Qhu+W/qKUavudU4v6pqsDvXiOx28iCbRn6W2v95lMUD41wG5bHBA==
X-Received: by 2002:a05:6512:3993:b0:53a:aea:81cc with SMTP id 2adb3069b0e04-53a0aea856cmr3573924e87.57.1729184230174;
        Thu, 17 Oct 2024 09:57:10 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a00007078sm821563e87.212.2024.10.17.09.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 09:57:08 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 17 Oct 2024 19:56:53 +0300
Subject: [PATCH 03/14] dt-bindings: clock: qcom,sm8550-tcsr: Add SAR2130P
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-sar2130p-clocks-v1-3-f75e740f0a8d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=928;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Bx2eQxGp0RF29+QUY/ufB1DhIZwqeSmn4ux3YLXYV4I=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnEUHarvw0B3LkgUTtKB13GcxV7h3MBAXu9EcH8
 0Iiexm2zr2JAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxFB2gAKCRAU23LtvoBl
 uLB2D/9L3f2GbYeTHqQ6PCU3Q2PKlGH9sbCJxTiW3Oz9T2s8ZjRBMBAXcEha87jMV7buoB8wdRb
 qbFxJZZE6W5/PoPp1vyYcuynRVlTuwG0e17jHYxiafi5pWRYcbDpwyr25eYQG/S0SlV0dVB2VPv
 5Ux7taAAbpUS8bJ4qkWf7GlKf5e/pboWNriw1lmUy4cpFTQdtdZFDt53uqUFXGlh99EqT+FDped
 tLPZ9JgrpY2kvH2mEZroTc2aXcZQZRXK5MWOhZ5oAlzzXlvnfPM3vMrpzPvhs8fiHqKm55mKWgF
 G2DXZiICE2ok1WFtF4h3c7jaENY9s+/ioYnaR8UT+fptIisfFqejtuHVJjSNBi2d2GGW+sJGPXV
 pdNxjYYjMtOqfb2VRHj6IzG+EFSXmPqAaPz0tTO1K1PU1YZ9VFjE6w+wza0wu5I8TDDHPmwiuQh
 nWOmmWiT2H2hgcfQW/Ye1rr3jEvylCwhhODeLuGq1KMANecBhfIlSvq9Ca8sPw2zTd5LU/Cf/+e
 tQIS9GIoMUf1wcVdVXU5bHpCRTlrH4gdMKPHEWpyZTOsnmj09ju3uYmgjRRexkdhumbgfyqxo5R
 1OorcSliM1HsQlr4Ph/wv2zB9jPWjX8N622fipp3z+kacn+C99CBGxo/M5+HHVmB1T8wLzEw3xY
 43yyIV3Y+FC3adQ==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Document compatible for the TCSR Clock Controller on SAR2130P platform.
It is mostly compatible with the SM8550, except that it doesn't provide
UFS clocks.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
index 48fdd562d7439424ebf4cc7ff43cc0c381bde524..3b546deb514af2ffe35d80337335509e8f6a559d 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml
@@ -21,6 +21,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,sar2130p-tcsr
           - qcom,sm8550-tcsr
           - qcom,sm8650-tcsr
           - qcom,x1e80100-tcsr

-- 
2.39.5


