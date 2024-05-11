Return-Path: <linux-kernel+bounces-176746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABF28C345B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 00:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C479A281E21
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 22:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6D03D0D5;
	Sat, 11 May 2024 22:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hS38IkkX"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61580200C7
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 22:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715465053; cv=none; b=DECM5VIzNw5Yfx087xJSVMY3r4aR5cjVib/CAzGyDcTXpoihXJS7hZvyG+DVQUWNFdfSxvHj6KDrLR9Lub+hUcYR9LeJd55tfdtWrobIPR2ZdXkLgabX8Tf9vDSqXn2LPOKa4xxR0k1XcAkOQEhnjnuYK3Z2pGe6I9CamRdygpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715465053; c=relaxed/simple;
	bh=wKungPBCSSjD1QlWhmo9q5C6gnV6NIGz8bqMmpkSAqs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kQz/anJn0TJHdiKQ31lvHUImjDhEkg66QmNuee4Q/dpkFvjhavidhMJJNjeKTdeRhyVXYNyXxRdYoEENcWKdibU3oFRUFEQ4JonJayusG7dXZDVmLw7/emyR2NCbr0tswrb6u5AfGjlyTegbT5BbrUFmTl354rnoxw0dVKLWZlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hS38IkkX; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2df83058d48so40568411fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 15:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715465049; x=1716069849; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lCTpQI7FzrHDNi8N2x64hEd2G2R7SLdvWST+LI9C2s0=;
        b=hS38IkkXuaSGIj8hRGrHF9vNDyqAYvzzmm6UiZUYMh+iUINwrruucIY5nCcCITLnvE
         CWh+dcdpJKRBbi4kwEV6J8P91krJpIfml5QqzrAgNoldYg4WFWDQDYxErfkD4wG8/EV+
         UJffuKXQKEGLGMdxyEjswAz4a+EwXkOHNPEpbONnShMiX6/CvtfqVZGCfpiUhhRCK+9n
         4NcAdtb5y1VHiNZzGgM/GPG9uFuqIDUo16xZ96JBXlMe13zOVrD/hJVtUjlM+pQqi/QN
         rDXHhIVDGFTGV6ermnCbW0gMhEXeLFxp3uL4waVxkO+tJY48hG/NJoH+B+883abmWEaL
         5exA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715465049; x=1716069849;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCTpQI7FzrHDNi8N2x64hEd2G2R7SLdvWST+LI9C2s0=;
        b=ccb90rwMLxzKKgWW3lNcfeOyWKIQolW5JvuyS4ajtGkmsQ+rx6CSXDQUf0/LCDcZxy
         lumJDPsAlAOgEFYpl/DXI8jwWj5BBETg8O7Bfl6PS34PCMdYxif89c83fCsGaCZDYibR
         XmhLpzI/H2xqDYc3yCkto2J3yDwVGSHLyHzqGC51Njx1KLBXFMnDR9fQ9fl8byx0kPph
         dGO0/u6d0/fT0i5jhuUMhzX6O2YEn5btwOabF3GLMWpeA9VKmKR2aLexY4ZSC4NIQWfJ
         8wiv+55l8azo2Coew393l4BJDNpi7beoBOf14IlUcwSnykLqq8VyW97nfNcZ0xatsWtg
         pdZg==
X-Forwarded-Encrypted: i=1; AJvYcCWbp17GQ7YphyUbK2syNWPdGgzY/HC8Z8TDVlju8KL3gJ1gmSAhwDKsUGJs4SpvZxicLQ4gu0nvHL0KeKmG3mGy7JVrlKYOieJHPcD2
X-Gm-Message-State: AOJu0YyeeaYTfnN4Vsop1g6i79tYLoLnGMMaXyA5Q5pdHiZ51YzgtaLW
	FAFrivP2jbMtfElA1KwFYX9uwx17Xb7ZvuDlf/UN0Clxkeho9nO36LJ847snvE0=
X-Google-Smtp-Source: AGHT+IG2/h4e5Ntkaiyx0G5zYjy1Qys3SaD2v73dywbBCYCHlESc/RcMQF7tYN3WB0IWQ14FIvD+NA==
X-Received: by 2002:a19:f708:0:b0:51f:4d57:680e with SMTP id 2adb3069b0e04-5221027bb22mr3592018e87.64.1715465049364;
        Sat, 11 May 2024 15:04:09 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d878fsm1123875e87.206.2024.05.11.15.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 15:04:09 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v4 0/9] arm64: dts: qcom: fix description of the Type-C
 signals
Date: Sun, 12 May 2024 01:04:06 +0300
Message-Id: <20240512-typec-fix-sm8250-v4-0-ad153c747a97@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFbrP2YC/33NzQ6CMAzA8VcxOzvTteNDT76H8TBGhSUKZCNEQ
 nh3Bxc1Eo//Nv11EoG94yBOu0l4HlxwbRND73fC1qapWLoytkBADYQo+7FjK2/uKcMjxwQkkdW
 ZATKQpCKedZ7jdiUv19i1C33rx/XDoJbpH2xQEqQyFrEgIjbH8901xreH1ldi0Qb8EEhtCBiFP
 MmMLdKizHP+EegtaNgSKAop6NIymVIBfQnzPL8AxeumqTUBAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2479;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=wKungPBCSSjD1QlWhmo9q5C6gnV6NIGz8bqMmpkSAqs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmP+tXQG8YH6NcfqWkp8rYoAku8LoXXpE0+0reD
 WtdTRQZF+mJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZj/rVwAKCRCLPIo+Aiko
 1asVB/4owWrV234MoqoEjQpoATMtfHoiArWkKdwwQMVb+BBdyqzZsPP6fXs9clFImX+BCtP3B7e
 Ku+F5QQy+R78CO7QYtuvqEhcXlNb1CXqgln3rkpdGf6QjL5DfujUBe+sTmXdQk6dU3bPclFQ5Ek
 oxnjQdhk/5NFrpJPFydeWWIBpKVAGj8Mch7LPYkDD4nv0JOEXd/eR9XWS6nBNw1KrEHSsJwXd5j
 rxCU0jux2VFquI/i+YfAXez7L+tHGP8cEuKI6C+aQ7z7Gn4VFCxdUtQjXon5GLGc/HMmpT1PzfI
 9ivAGswFQJONlCedsdNTze2RcejO+lAFIf/vLJHUO2dgnfKx
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Rename the HS link between usb-c-connector and the DWC3 USB controller.
Add missing graph connection between the QMP PHY and DWC3 USB
controller.

Reported-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v4:
- Rebased on top of next to remove conflict with USB MP patchset
- Fixed commit message (Bryan)
- Link to v3: https://lore.kernel.org/r/20240401-typec-fix-sm8250-v3-0-604dce3ad103@linaro.org

Changes in v3:
- Fixed dispcc bindings / clock inputs on sc8180x (Rob Herring)
- Link to v2: https://lore.kernel.org/r/20240331-typec-fix-sm8250-v2-0-857acb6bd88e@linaro.org

Changes in v2:
- Fixed other platforms in addition to sm8250 (Bryan)
- Link to v1: https://lore.kernel.org/r/20240322-typec-fix-sm8250-v1-0-1ac22b333ea9@linaro.org

---
Dmitry Baryshkov (9):
      dt-bindings: clk: qcom,dispcc-sm8x50: describe additional DP clocks
      arm64: dts: qcom: sc8180x: correct dispcc clocks
      arm64: dts: qcom: sm8250: describe HS signals properly
      arm64: dts: qcom: sm8250: add a link between DWC3 and QMP PHY
      arm64: dts: qcom: sc8180x: switch USB+DP QMP PHYs to new bindings
      arm64: dts: qcom: sc8180x: describe USB signals properly
      arm64: dts: qcom: sc8280xp: describe USB signals properly
      arm64: dts: qcom: x1e80100: describe USB signals properly
      arm64: dts: qcom: sm8150-hdk: rename Type-C HS endpoints

 .../bindings/clock/qcom,dispcc-sm8x50.yaml         |  28 ++++
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts           |   8 +-
 .../arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts |  16 +-
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts        |  20 +--
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              | 182 ++++++++++-----------
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts          |  20 +--
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     |  20 +--
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |  54 +++++-
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts            |   4 +-
 .../boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi  |   8 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |  24 ++-
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 149 ++++++++++++++++-
 12 files changed, 380 insertions(+), 153 deletions(-)
---
base-commit: 75fa778d74b786a1608d55d655d42b480a6fa8bd
change-id: 20240322-typec-fix-sm8250-33c47a03a056

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


