Return-Path: <linux-kernel+bounces-319787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3803970235
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 14:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3ED1F22B42
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 12:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3F915C132;
	Sat,  7 Sep 2024 12:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bK9b7iIH"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AA0A55
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725713492; cv=none; b=hK+wiuzZc3tiZA2phnFkYJBHLKkvcVIPYntQINUIm+NZey80nquGDzNlTAdngpZAu7svBwXbYm0zPV7O2ThLB37a++srnyjAhQWP5zgTSrR9Fou/yvGPzvfFMKkKoWl+zFKpPon8W6TpBxjSgCId2pAqQZhZMhBGFeKQzkSac1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725713492; c=relaxed/simple;
	bh=Eftm1W+GNJmOJ42BfApHc6KXNrDKzXdFjqNJBwvHC5Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sc0ZjbaRNPedxHf5h2dlCsKICAhqVqwycrWs24OZKnAtWJ22AZQx7YNNKZRL5tOMvJNnbrq+UV12gBkBMjVeeN/t4q+Fo3mGXOZ0jVPh71xX+DaDwtYSjltoyPSlQ0a4DHl2JJYvXJg0iRL2+3aq9NBmdL6ZLeWKmvViPGHrkiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bK9b7iIH; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso4921205e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 05:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725713489; x=1726318289; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eD6sTmDGT5yjbK3VSKihHlljdk27lYNgMECrwSWDT+Q=;
        b=bK9b7iIHHX+zlodbkU75yr/MKLGvBHAWBxGF0SStZYXQFxJ6+/PjU715WxFlaWdQpm
         3ZenteUTuMTkx5SP1E3khcVvEv7TZzFvuzUBbsnstsmzk5G2nCF9xKshUqzcX4eP/zLJ
         nrIxAHV2TFmgXeVJE7O+FNmvvnDfYa9KSfPyVgiMidTymJsSyY/PhliwwIfT3Kj8/ZMH
         EBNqtUUMEvjQ9WEFZmIxSQR7L3uxDg7HrnOXuTckasYs8LU07xL6+MeNs7xSIlAJaGa3
         8lEhzC59TuRPDTDwAYid9yb3cGnEEEwDFe70AGup435DwryJ+pP/10Fg4IYtKJ7QML/I
         tceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725713489; x=1726318289;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eD6sTmDGT5yjbK3VSKihHlljdk27lYNgMECrwSWDT+Q=;
        b=nSK0teBRQVZnggmytWV4zcbo/dd+3OsBp8C6b1NsNNO0LvMayvEOwfDMAFOpa59nS+
         mdqVfJVrrwJLs9KWqLsORb1xwrvGqcSL2z0PO3GSjpyxVmX2Yv+kYaf/P3Xt35te34Yp
         geNWFHfrUic6n05yVJ2WzN+clYz8rN4lEZvIIx46hi6iTwMBn6O/tMil7jktKy7NfL/G
         /KAB/eOkcVAGE+MOCkAW48W1qbquHsme9yrGL/S8IHYdwuNGh/3GH70g+MTpmJKUbExb
         aWASy9rIDTXw/y9jdCfhZ4373Q/BzKpeU2xp1o83iLOV7tAPy511LBFXP+OiY9lQG3vi
         Uf+g==
X-Forwarded-Encrypted: i=1; AJvYcCVElYHfChhso6SlHTg9QdLbSY/eSQ/pNeT8TFDlvcrBdzZN2JKvmdaNLjsBV4CL0SHN9JBAdt9oEy/YdvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YypwTWWKH06LI8har8avQMGXEKmAezeNuvliHkAIP+Jq6ZvcT5Q
	m9h1ZUXGg9MJ3PYHxtMmkjOZmbc4gr6CQD1rbgim8jk1aK4U2VqVV55sfhY8a1kn2btTvMM1Y61
	r
X-Google-Smtp-Source: AGHT+IFN8zhhDATsn6E4CgRGDEeVCxfkMeXdbOgQR1B9tu35EJU80+iclas/Iu/9CbYFdkm2O04eKA==
X-Received: by 2002:a05:6512:2210:b0:530:b773:b4ce with SMTP id 2adb3069b0e04-536587ced63mr5324665e87.33.1725713487707;
        Sat, 07 Sep 2024 05:51:27 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f8cb76fsm143273e87.177.2024.09.07.05.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 05:51:26 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/4] arm64: dts: qcom: qcs6490-rb3gen2: several small fixes
Date: Sat, 07 Sep 2024 15:51:23 +0300
Message-Id: <20240907-rb3g2-fixes-v1-0-eb9da98e9f80@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEtM3GYC/x3LQQqAIBBA0avIrBNsGtC6SrTQmmw2FgoRhHdPW
 j4+/4XCWbjApF7IfEuRMzX0nYL18Cmylq0Z0CCZ0VidwxBR7/Jw0Za8JTTEzgVox5X5D22Yl1o
 /5fOwuV0AAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Komal Bajaj <quic_kbajaj@quicinc.com>, 
 cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ath11k@lists.infradead.org, 
 Kalle Valo <kvalo@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=950;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Eftm1W+GNJmOJ42BfApHc6KXNrDKzXdFjqNJBwvHC5Y=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBm3ExN5mqCwKB4Wh0d4mb4TQ/xYsL7JcidKUc20
 C/0cxQuamWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZtxMTQAKCRCLPIo+Aiko
 1aS9CACTrbXWCyrLgX8zPGjgBynAeh6+PdJa/FG1nqGe+I584L7sLKSNblB5Woq7B7KHJe0Wh23
 MjKleZzQZFEXtXqvVw9Ra/7F6Fj072441VwcUyq3LsGMnMjLyPYBWCNEyeu9JGSnJBTYd2p9sFm
 rkjoEuyzsh227CN1vi09zAoIzRCwkt6Il9gn10grnLVO6FwbfabIT6zU+2I9N31D3mbHvs5Uc5o
 8A7DbmtHEb8DZBxEjsHs0JTpGTLoiN+BvvycT5EYv10K3+b1oz6pfk3sISNyCiafRw911UEixOA
 I9CDmIWu89vIIBHGpm/jsMJ7azDjZpLHM/vnjhGSwlmfQz6l
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

- use modem.mbn instead of modem.mdt
- make GPU disabled by default
- specifiy ZAP blobs
- enable WiFi devices

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (4):
      arm64: dts: qcom: qcs6390-rb3gen2: use modem.mbn for modem DSP
      arm64: dts: qcom: sc7280: don't enable GPU on unsupported devices
      arm64: dts: qcom: qcm6490-idp: enable WiFi
      arm64: dts: qcom: qcm6490-rb3gen2: enable WiFi

 arch/arm64/boot/dts/qcom/qcm6490-idp.dts           | 11 +++++++++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       | 13 ++++++++++++-
 arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi |  4 ++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |  2 ++
 4 files changed, 29 insertions(+), 1 deletion(-)
---
base-commit: c7d810a304e6ed8bbf3a09716ae3827fa185d2b1
change-id: 20240907-rb3g2-fixes-74a74204e88b

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


