Return-Path: <linux-kernel+bounces-352474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A874991FBC
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 18:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF25281FE0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 16:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72B5189BBC;
	Sun,  6 Oct 2024 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G7+8XJTK"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899C118991B
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728233291; cv=none; b=c59JKXFdZ3YWlHVUlwwwIupfOXZvX8XvO7DPp2gejlBqiTrTUzQ3zGKK/dI8Ujvnsqi4OfTuAhWpPFhqETw+MDp7XwlpGWBqP+o97+pGGa1r5uB4xBhm980vOAN4LmrN8b/VIQy9c+JQMzd/tJV+MoZhWsWizL8uboXH0jlmcwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728233291; c=relaxed/simple;
	bh=Gu7LB3UGHKQJrsQedCSEt4sdbmh9d8FC6ZwZTDLlCQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ncUvNdOMJJeh92ZiLLMvJ7p9rXpmW0mJBP9Zpl3Zfbe5c4dS3nNlIfG4LApYiZaFUQ8JI6QqIoYtJC+tskcfnQrieXnhSXrg718PPrgzO1b9JQobXEMCoLctq9k7xqA0jdXXGwANtIKq4tDjAaKIkhPf15evo+1fUFAZtZElv/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G7+8XJTK; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53994aadb66so3260453e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 09:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728233287; x=1728838087; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uzAWnvR2f4WrHC35dBgQ63T3duQgeGlf/PEfaPr78MQ=;
        b=G7+8XJTKtT3emGo7sS6GP87u0iwO7QCw7PCsQLYSkboHO8uEsgIy9PyPrryKljjiHG
         ApfpR2pkBo782KKxOvaBva9H/74ucchw/wwwJnXdqPk9iW8SuCuZPE3flCNMDzbprOb2
         q9NUuZhlQ5QbWcVZmtQ10FZgh8gzrnw1j3d2hB/fgAvmzjrT0H25Y1JA7YHgMpxxZ1YV
         SRI8oMgaW2+uxT64cbOl2iOR3XK9dEV9EIOJYgnzLVjsLf7C67HbHYYNk5CDUYVBP1Jw
         Q2kxBZZ4KH99KQ5DQzIeJFaTjHuo3cg7r4Mq5fsxSNI93fA0CogBH8U69o6O0baMgDPX
         GX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728233287; x=1728838087;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uzAWnvR2f4WrHC35dBgQ63T3duQgeGlf/PEfaPr78MQ=;
        b=m2sAEJc9N8Pk5rLbvf8rPmbDfdBChUaTl5YwbKELIR1CNs6OkyyyWCLMSLhVGWMYph
         PJZinY0P64U7Uq9JBojmERshB21Bro1Pt0Km4tNJFCzcGU67ltBvfcGFA/EnbNLPhR0W
         c1y/YG+goeYRi2qBvykU4SEpKOMSQ8bGqZ4FkaEBYJrCOdqnrh8oE1qjNoj1MVMS8jFo
         hyUASO8ujOh3IqKRmqfZUf4AUDj9VczVAgiBztP+vZ8zeqqIfqVx/kKOtXtB9etMEJLS
         yKbx/NqUkN9ccJse9O+NFTcL5rHNjQbAFTArNPCchkiiBES8RVWXwUwQsL2LaD4BmSRn
         nqlw==
X-Forwarded-Encrypted: i=1; AJvYcCUrghmfDCwhWpJfcqzX6RSfdVDRdqzDPweBxbUPbRKpIs4SvJx6E3h8CRyrSwWfpxMfnYuYMN7PBQaJ1sA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWCS1JfvnM+MSwK7E5xT8YHCoqeXhEa7eufg4KOkD3HeF62qQa
	Csng8kIUWcM9y5uWK/RI4ODwn3vYFrMYdaC8PWbTRCuNz/F8pXvLcWYulXJ6aXCED3K5jaOhWAy
	SWs9p/A==
X-Google-Smtp-Source: AGHT+IHs2SKU88jdrP9Tji3UkTA9/VSEgjFHjoDQRGkq5tRTQB41kleo8afr82s49QRRoa0qKJURew==
X-Received: by 2002:a05:6512:2803:b0:539:9fb4:802f with SMTP id 2adb3069b0e04-539ab858c13mr4697488e87.22.1728233287431;
        Sun, 06 Oct 2024 09:48:07 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff1d0e9sm570759e87.181.2024.10.06.09.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 09:48:06 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 06 Oct 2024 19:47:56 +0300
Subject: [PATCH] arm64: dts: qcom: sm8450 fix PIPE clock specification for
 pcie1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241006-fix-sm8450-pcie1-v1-1-4f227c9082ed@linaro.org>
X-B4-Tracking: v=1; b=H4sIADu/AmcC/x2MQQqAIBAAvxJ7bkFNRfpKdMhaaw+ZKEQQ/j3pO
 DAzLxTKTAXG7oVMNxe+YgPZd7AeS9wJeWsMSigthbAY+MFyOm0EppVJovakBnI+SGOhZSlTc/7
 lNNf6AaxyKONiAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1531;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Gu7LB3UGHKQJrsQedCSEt4sdbmh9d8FC6ZwZTDLlCQ4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnAr9EijfXLHgWl6HDcvQREsHqimYB0cXLp1elN
 6zZLjjjlVyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZwK/RAAKCRCLPIo+Aiko
 1at+B/9m2SCcQOVg4KJHbS3n7DiLGeETatz8q6D9PUMzY4p9qWkqwBhI7HBF67a6X4dZ+5rQznh
 JnO7Smr4VilAJ0aio24UohY+svOficAoHlX4l4QYQSKpEuMgZElxywZ1HotvDRLfTy/6l1mmsro
 yR0BKQVbMM8bRdc2IxyZsjPFUrOuEMC0ljESDXIGbImDTjdxIypd+RbuwaaXGADpR6biEE9E98J
 TWJZK8Uck/vsksloB2QJOVqHdXjpjwuQDi94pG4X8w5xS7Kbxv87n7iwbRvFtFtYPPTfSyFkURf
 DlCwDQetvfeTZXF8n6+gddiJvfNwAPy8VJ+iU69vcJO9p4ew
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

For historical reasons on SM8450 the second PCIe host (pcie1) also keeps
a reference to the PIPE clock coming from the PHY. Commit e76862840660
("arm64: dts: qcom: sm8450: correct pcie1 phy clocks inputs to gcc") has
updated the PHY to use #clock-cells = <1>, making just <&pcie1_phy>
clock specification invalid. Update corresponding clock entry in the
PCIe1 host node.

 /soc@0/pcie@1c08000: Failed to get clk index: 2 ret: -22
 qcom-pcie 1c08000.pcie: Failed to get clocks
 qcom-pcie 1c08000.pcie: probe with driver qcom-pcie failed with error -22

Fixes: e76862840660 ("arm64: dts: qcom: sm8450: correct pcie1 phy clocks inputs to gcc")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 9bafb3b350ff..38cb524cc568 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1973,7 +1973,7 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 
 			clocks = <&gcc GCC_PCIE_1_PIPE_CLK>,
 				 <&gcc GCC_PCIE_1_PIPE_CLK_SRC>,
-				 <&pcie1_phy>,
+				 <&pcie1_phy QMP_PCIE_PIPE_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&gcc GCC_PCIE_1_AUX_CLK>,
 				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,

---
base-commit: 58ca61c1a866bfdaa5e19fb19a2416764f847d75
change-id: 20241006-fix-sm8450-pcie1-4be23e8bf156

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


