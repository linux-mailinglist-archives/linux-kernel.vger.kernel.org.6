Return-Path: <linux-kernel+bounces-190048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B11AC8CF8CE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C461F21BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 05:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B7CDF60;
	Mon, 27 May 2024 05:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NRu0XEoC"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2FBD266
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 05:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716788327; cv=none; b=dnpBbGMvEE6XFkkwd1oJtFuza5Knibp6RTZ/Z6kPtusxxJFot5+n6IapsFug8PA0pNpl/gqzFFL+itJHc16UY7XFVzQRPY/TY+yIX6McHPlPfwXpxORn01Lc+XH4aAgN3W5Q1HfWydL9/IH6YwVQ7g6PbBetsTKBHO/kp69/0/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716788327; c=relaxed/simple;
	bh=5sg5fBwG3vrMNfKaPklVtBjDGFjvu3Nj2ornLEhhTIE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ty+Ict/G6xwHstVa/iRrhBu6mHIdkZcLB1+PUaiUdwA4OO/qmGcWtkJIceFAmPcC9SO4MQVYxObQQQ8/i7lHmZEAieKCf9PjaHI8pQ8B+q3HLCABT5Dj1pab0bsfk23XWeBGWYWzoOoU5rjoTP0XxPXUo2cDlwXWVTYg3wzHW0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NRu0XEoC; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7010a7df499so541699b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 22:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716788324; x=1717393124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NKMGRGQD4IsOADQqi/JUkrlmutDXh4ub1soGxeAwulc=;
        b=NRu0XEoChnPQdFwQ2ITQkm1eRr3vx71/Qxyy8iF0lswMMPzNckGLCh9hXKepLvs1sQ
         Z44728iLvKuKlxlLztnF3qicTSPrFgcviyuC5trWUxedi64YeZZPUw1QZCahlwv1HZf/
         9l1lBDwdVY+KfRtkczSpLt4q3klMsRnp7n78fhjmS7QV7T01E/G2qVdOp2ILOHkc4NxR
         rg3YXtef9mPAldQH7xgO1FHtEjbQrc+Y1hvD69bPdKW78qjVdAiH5zrTu9iBsHxL10dE
         vt3WO6eFC8JMNou3G6ZaWue0ZTH5Jj8L0mLyzdzuYfVflmmUaBwUd1VUFQqcC0NgnfBz
         1Meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716788324; x=1717393124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKMGRGQD4IsOADQqi/JUkrlmutDXh4ub1soGxeAwulc=;
        b=ef/gxtlZivt8MHPn3rTt+Y/xuKHqahNTEmju5o4FIrVgalwkaV1WFSRg12xYHinEuk
         0UNoYjsSnAqborOB8Xi4h6eXC2h9bWekNcHpaDoGjTt/PwzUugD3wH89TBhVpIdCjB4X
         eF0Sdu3/O6Mk6GnN3I5Qhw+RTqBlWIWCGXSwF5pacj2cLTS+xuT7z4HjQlMbHLTVbq8O
         Y3SuUKsY2luMXvlB6h8U0BNShPTa1BJ6KJgGnAI4GQfRd5y0hnz/tI5YF8GTboEvXYsx
         pHnq80woJEQsQOo3g+SDLdGI8wnVJ/gAQ8K/I5COTcNV/lhT0ra7W2u55aGZenTiSzJr
         vO+w==
X-Forwarded-Encrypted: i=1; AJvYcCWTkoRARkphmCcRC8+/bzi3JFD0xt7pz009p72Lud1dFlZx5DafL4s2UERitDlAjkGyT82cg3pHl1JTFRZ8sY982GDGdVIXtAtNwkeZ
X-Gm-Message-State: AOJu0Yys2eGx1AF6hyRi/fjXxUmHSuHEs0MAYOq3M6WMqOAV2qnGMlO4
	jhnKRBkwdX5MWZy42is2c05XwcSCm3T4e8q7j1p1HN1yH+6t2FGlcHUcWmrVGI8=
X-Google-Smtp-Source: AGHT+IF3zV3yRfCSi0aSgdVrHSQCZGHUpTbemfonAMcARdMq7SQntkUJSeSPc77K34YqCaOQLMkPwQ==
X-Received: by 2002:a05:6a20:3c92:b0:1af:d647:3108 with SMTP id adf61e73a8af0-1b212ced2famr9606539637.2.1716788324134;
        Sun, 26 May 2024 22:38:44 -0700 (PDT)
Received: from sumit-X1.. ([223.178.210.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9684ecsm51903745ad.177.2024.05.26.22.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 22:38:43 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	stephan@gerhold.net,
	caleb.connolly@linaro.org,
	neil.armstrong@linaro.org,
	dmitry.baryshkov@linaro.org,
	laetitia.mariottini@se.com,
	pascal.eberhard@se.com,
	abdou.saker@se.com,
	jimmy.lalande@se.com,
	benjamin.missey@non.se.com,
	daniel.thompson@linaro.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH RESEND2 v5 0/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC board DTS
Date: Mon, 27 May 2024 11:08:23 +0530
Message-Id: <20240527053826.294526-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Schneider Electric HMIBSC board DTS. The HMIBSC board is an IIoT Edge
Box Core board based on the Qualcomm APQ8016E SoC. For more information
refer to the product page [1].

One of the major difference from db410c is serial port where HMIBSC board
uses UART1 as the debug console with a default RS232 mode (UART1 mode mux
configured via gpio99 and gpio100).

Support for Schneider Electric HMIBSC. Features:
- Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
- 1GiB RAM
- 8GiB eMMC, SD slot
- WiFi and Bluetooth
- 2x Host, 1x Device USB port
- HDMI
- Discrete TPM2 chip over SPI
- USB ethernet adaptors (soldered)

This series is a v2 since v1 of this DTS file has been reviewed on the
U-Boot mailing list [2].

Changes in v5:
- Resend again as the v6.10-rc1 is out.
- Addressed another nitpick from Stephen.
- Collected Stephen's review tag.
- Warnings reported by Rob's DT check bot aren't related to HMIBSC
  board DTS but rather they are due to msm8916.dtsi or extcon-usb-gpio.txt
  still not converted to YAML format.

Changes in v4:
- Dropped IRQ_TYPE_EDGE_FALLING for pm8916_resin given the expectations
  of Linux kernel driver. Instead depend on systemd workaround suggested
  by Caleb to get expected HMIBSC reset behaviour.
- Incorporated further DT coding style comments from Stephen.
- Warnings reported by Rob's DT check bot aren't related to HMIBSC
  board DTS but rather they are due to msm8916.dtsi or extcon-usb-gpio.txt
  still not converted to YAML format.

Changes in v3:
- Picked up tags.
- Fixed further DT schema warnings.
- Configure resin/power button interrupt as falling edge.
- Incorporate DTS coding style comments from Krzysztof and Konrad.

Changes in v2:
- Fix DT schema warnings.
- Incorporate suggestions from Stephan.
- Document UART1 mode GPIOs based mux.

[1] https://www.se.com/us/en/product/HMIBSCEA53D1L0T/iiot-edge-box-core-harmony-ipc-emmc-dc-linux-tpm/
[2] https://patchwork.ozlabs.org/project/uboot/patch/20240311111027.44577-6-sumit.garg@linaro.org/

Sumit Garg (3):
  dt-bindings: vendor-prefixes: Add Schneider Electric
  dt-bindings: arm: qcom: Add Schneider Electric HMIBSC board
  arm64: dts: qcom: apq8016: Add Schneider HMIBSC board DTS

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../dts/qcom/apq8016-schneider-hmibsc.dts     | 491 ++++++++++++++++++
 4 files changed, 495 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts

-- 
2.34.1


