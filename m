Return-Path: <linux-kernel+bounces-185419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F2A8CB4B9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED651C21AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF68149C4E;
	Tue, 21 May 2024 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pSbRIQPi"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5280AD51E
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716323452; cv=none; b=XskMqrkSlOI6L6qUTan20j1Z1A72jVR+xj5g6RqODOHNLCGDlour3IGZrmugEKmstaoodp7rNiZoBobc7yV7RswizcPnYT5CK3hNyh2vgSAKAdvKlJ7yTi+tsD4oolqnh0DmcJ1/P1h78OvSbtydTjwOis/ivP4pa+MoLsp4u1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716323452; c=relaxed/simple;
	bh=M+EhpWdi/uciO0AorqL0bUSVVqrzDF3BrW557EWnWVE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T6u2CLKO/8Uxot5ozuGVnrs54kZ32NV0q/OlosrsOPSNuqLb/urlrPFPSrzGzIqE3TxXYQXrpgiRH1EgEdeX4wvioBlSYsuKfwg6Q1dhts5UNfSz1HJ+sV2vtnBqWTpqnqOOqHbhhvU1ahFWlVHUznrRT97g+obfhI3+K13WxLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pSbRIQPi; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52389c1308dso5603102e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 13:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716323447; x=1716928247; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pCzVBCkChxcSIogrmuJcf7U7dBGPAxnq9O89uPJ42iM=;
        b=pSbRIQPiyHs5Kuvovf1igaf1HmQvlQEWbmOf7osq24AH1zoO1cK52bDLr1A8jGHEVX
         KyyOF8fT45gaTQtp+0zb06T7+S+OSch+xdaMvh11a0DIRJMRMz6aOVrYjE9dpgVRj6fP
         V2jqHqcCKr5TxTf1IflKikyjdFk2wRYqAn8h2o6rOQrlX/n+KvBIDVHNQhyzJeVh6lty
         cCOBBPr6ep8mUvLp0ab/GdwVP1S/zrbnlAlcNrPTH5hBKQht3GZg9ac50uNbla0HWsbn
         ZKjNCntNiF+IQ71XaJhW51fdqZNnEgQZIkiROCs3xTEXfRZqfRSoN1V0thpBvdZCL6ee
         J+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716323447; x=1716928247;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pCzVBCkChxcSIogrmuJcf7U7dBGPAxnq9O89uPJ42iM=;
        b=cTZcNIcCk5BuAl3dPDaWLFygLmhuS+itFnUaLP8Ws+8+dQR/MPFFh6flWy2jV8dQKi
         pDgraE+mok0rQ3G1Y4k1ex6jRT/ibaLdozIYCOd+riarojsOZeZ9PIV0IyWH8OviK5zG
         upIHe9gcouRXAw42bKBXSTGBA0GSPCghXXMxpj9TvOhhs6trkQTuPYOLJrg10hAd/gnh
         iOIPi9oAp4Kb4qawihGUOqv7cJyFumO6aMasGfL8f251qjvTOLxtpXT3XkKUMWjwj3nN
         WRt9QB8DqorXAZr/tJsBc32VRMMy6qt5vxivyYKGFREFgapKMTOVAS+QT+nCminEws/7
         qhcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWMAnDI1yarG04Bm2bNo7eic/poIbUHJB3exZ6NwKDVJ6BRS28/j1ouEjgUQ45s/ARhFcmzfYsq5BbbzSjXl0Fcb/U3W9sjIirdNsn
X-Gm-Message-State: AOJu0YzhruWvr9wwqJtO4wAG3K/zD8Rij+vaxtXyFPAqVt18OvL7NfrI
	dYXnK2uC6gkAWIa6skED66vUs+Mg66PQlXc0uUeU7+gLhIrHcLFvJ50sPBOI2Ec=
X-Google-Smtp-Source: AGHT+IHvKMY2c/VALGOXGWq7fbmVfPrO3CBOa/9czLbPQck3nzzxirPm7tzr3AFSfgRpDwmRJL3DwQ==
X-Received: by 2002:a05:6512:3ba8:b0:523:9297:2506 with SMTP id 2adb3069b0e04-52392972629mr15632841e87.58.1716323447549;
        Tue, 21 May 2024 13:30:47 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5238ec18fd2sm2538664e87.155.2024.05.21.13.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 13:30:47 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/2] phy: qcom: qmp-pcie: drop second clock-output-names
 entry
Date: Tue, 21 May 2024 23:30:44 +0300
Message-Id: <20240521-fix-pcie-phy-compat-v1-0-8aa415b92308@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHUETWYC/x2MywqAIBAAf0X23IKKdehXooOPrfaQikYU0b8nH
 Qdm5oFKhanCKB4odHLlFBuoToDfbFwJOTQGLbWRvVa48IXZM2HebvRpz/ZAJ5dgyJnBBQutzIW
 a9l+n+X0//fGiKGUAAAA=
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1150;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=M+EhpWdi/uciO0AorqL0bUSVVqrzDF3BrW557EWnWVE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmTQR2U2rXolmbrWdg8e6wAttQMImRrg1Pyc9ok
 rA28n9AO4aJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZk0EdgAKCRCLPIo+Aiko
 1SnkB/9cgUDX95JWEa0NHEJK8aRFtxpKZu8Khyq4djF+wMNkIMUC5ekxB3tsfX3XFRIPOWnRVae
 /8vFprf0JoufRr0eGnI8wUGaHk8IiUnTaG3+sQEO9Keeb9XtID/F1vKtdDnLIKaLB7z8jlv1QRS
 ycPHorVLVHnIDpaSv17XxpgHH2VQACIq+hCq3ZfirI+Ls15bXa7DChLR4UuE6tO1bBaQ7OTcxIv
 TKfS5ZNss0NebfRxaO1SgSAHEWKnXZUg3z5VuXM+FAQ580TdP3G0BuqL8/joVgCNG0FwodhUxWu
 0VtEBDMKL8Hul34ot1vmadPpod5f9PYtGaHh+GqIdbZM1Bs1
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

While testing the linux-next on SM8450-HDK I noticed that one of the
PCIe hosts stays in the deferred state, because the corresponding PHY
isn't probed. A quick debug pointed out that while the patches that
added support for the PIPE AUX clock to the PHY driver have landed,
corresponding DT changes were not picked up for 6.10. Restore the
compatibility with the existing DT files by dropping the second entry in
the clock-output-names array and always generating the corresponding
name on the fly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (2):
      phy: qcom: qmp-pcie: restore compatibility with existing DTs
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: drop second output clock name

 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml      | 7 +------
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c                         | 9 +++------
 2 files changed, 4 insertions(+), 12 deletions(-)
---
base-commit: 632483ea8004edfadd035de36e1ab2c7c4f53158
change-id: 20240521-fix-pcie-phy-compat-b0fd4eb46bda

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


