Return-Path: <linux-kernel+bounces-266349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7AD93FE8D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 21:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C702F2845B7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 19:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6F018A934;
	Mon, 29 Jul 2024 19:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fho+fYXS"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60561891B8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 19:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722282743; cv=none; b=m3VJxzAd7CgCMpt3WGO9NK23EFhMawyHu2fMF9tn57G7z6o+lt+noySjJgKwvf7WcHIEacffdTppXHxvJYTPcdEnPArowQHaEZjoMwvzX8PKXfGlO+kCDmxgaLfkCrnxIWg8b3lu997i9LUW1ReRC1NdA3v1QyOqOgPCZh/QsLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722282743; c=relaxed/simple;
	bh=ShlF7topp1rVhGyInCAgMDeIPA25eqOxSbLCWQw2i+E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EAFUK0zg+QqhejI48VOhaa1PhVpa2pbKGc9Etn0j9U7UMBtUchSsWRoFHcYNfbkd45vb46F3IvZ8gZPpw0naeaAmBgAdh6yV71YWjzGKdijWXoKWfPx6oVGo/boVBHgxcQoSoqIo/uVeLsorpHs6Tug2U7bYV5fGFWXavLIlxps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fho+fYXS; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52fc14d6689so3883716e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722282738; x=1722887538; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VD5PikJv4K4yv/VPTbjyVvFb/B4dWYe16gK9mJyOoIM=;
        b=Fho+fYXSWkFmrzQMp62b3lNy7xEnHMtze4/BJ+HaOobuN9qgL7C1z9EhmGN/noC/S6
         oIxmnvdNqJsQKvOpV0yO9SiWVA24ByKZCzkto1ipiVO54Px05EvIorul9X+wtF/rS5HO
         QVK43GgbF3r2kLHSB8NoFd0P+uhRRUkNBPHFsa/ug2GbrPlMyuTPhZ9Pdzd9bEES4pyR
         4RRJhLeFU1Go/rsrYJ1Tafc8Fvu424UNEIE2cRaIzuu+RRVdmeNq3vkINlKStfjz1XIM
         4W6XB2lSsySnqiY1raxbyFpIqEkjm8U5dw66m33mJ4IQuNgHUevVnG0GmUq/GBbHlQ23
         KxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722282738; x=1722887538;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VD5PikJv4K4yv/VPTbjyVvFb/B4dWYe16gK9mJyOoIM=;
        b=bLHHM3NZ9HiP5MUkvuyaezci/JBOyVhzWXwwKSTIucAj5CX4d7MvU0a6ASiXwn5lH4
         CgNzD61L/16HhNmYgmWthJti3OO+PPVT3OJPTMoPfWuMiSLJE8h8glOCVK12lEFHP2Nw
         Xv/uMKLHJPxG3xv9ruHkq5zieHWH0Xv2QF2rw85EMfYzKFVrgjJo6deKSaPNa2uNp068
         S7KDprwMzmgkcm00pwnd0T6bQ6fvyUuvU3i6X79a/GDbcJwTMnkwMZuZbnUaofC29pYy
         O72XJsADeG+d0zgDKOfXbwrZLpYsOyRcT2SdsS9+ChVD4HffaxpHYTf1spSVpThH3UwW
         0oOA==
X-Forwarded-Encrypted: i=1; AJvYcCXYlv7uJF9J4mgpd2SO93ajK48Io8E6SOBv/DuCny4gkeLqENa2GNc8ePVNSKgdla+3F9T1DSUoLwsQIJwo7/sKd+M5plNHzbs0YoMs
X-Gm-Message-State: AOJu0YwY1f9io9CBpXEYY4mu9EM8QdRn3X5wAXOsnkmLlEStxfbX9Utg
	6G28lwZ2XQw1SpQU0sUeObAmYZcASUZJzJaXsQsk/H36JUUlJUOID4eJlYAYego=
X-Google-Smtp-Source: AGHT+IFuq/6ZLfwCne+3wXSdDbfRg7SE11vLXq3Fq6vozrWyuvXfBwn22/wxUKTwF8P6KSNFWUkk4g==
X-Received: by 2002:a05:6512:1143:b0:52e:934c:8e76 with SMTP id 2adb3069b0e04-5309b2bcb7fmr6412687e87.41.1722282738273;
        Mon, 29 Jul 2024 12:52:18 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bd1088sm1615590e87.106.2024.07.29.12.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 12:52:17 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 0/5] soc: qcom: fix rpm_requests module probing
Date: Mon, 29 Jul 2024 22:52:13 +0300
Message-Id: <20240729-fix-smd-rpm-v2-0-0776408a94c5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO3yp2YC/22MQQ6CMBBFr0Jm7Zi2SLGsvIdhUUqFSYSSqWk0p
 He3snb5/s97O0TP5CN01Q7sE0UKawF1qsDNdp080lgYlFAX0SqDD3pjXEbkbUGjG+mvrTXDIKA
 YG/tyH7V7X3im+Ar8OeJJ/tb/nSRRoDHWaFnXzunm9qTVcjgHnqDPOX8BRG1csacAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Stephan Gerhold <stephan@gerhold.net>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-clk@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3021;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=ShlF7topp1rVhGyInCAgMDeIPA25eqOxSbLCWQw2i+E=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmp/LwfsCZ2h2+bBKIeZlfvZWYbksHgOKEPNGUA
 bWWWI6aAyGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZqfy8AAKCRCLPIo+Aiko
 1ZWeB/9cbXMLT0KtCArVjCvqsIGzUvMsUngRlUMv/AXLYhUpyvejYjbUrUsJLG2kUkRSJeYyk3I
 Cml+sfuuyGUppRU+g7HTDUdgkDiS2I3Rwa0ZQWz8U46J4sN5GiFoGw59RGfN5c/2uZIp5nVnv1Q
 GburKTlsLh22P7S2QNPwl+woQe+0xyVPsaFw+wVG2LoiWLXBIo5UOdXpDAM6mtI5Ny2YL6G4UNo
 2ZazynPxiPOqvtfmPn2dUZZesi4nyVY2TvCIUurb/7zqBvA4BCN7Gms9vc8mJ4Dspjm+X9OMMx2
 4++twAOh8WMW22AQvqJyNFvvQ7SMLj8M/44KwZ6yxLreDx1Q
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The GLINK RPMSG channels get modalias based on the compatible string
rather than the channel type, however the smd-rpm module uses rpmsg ID
instead. Thus if the smd-rpm is built as a module, it doesn't get
automatically loaded. Add generic compatible to such devices and fix
module's ID table.

Module loading worked before the commit bcabe1e09135 ("soc: qcom:
smd-rpm: Match rpmsg channel instead of compatible"), because the driver
listed all compatible strings, but the mentioned commit changed ID
table. Revert the offending commit and add generic compatible strings
instead.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Separate fix from the improvements (Krzysztof
- Split the qcom,glink-smd-rpm compat from the qcom,smd-rpm as they use
  different channels underneath.
- Link to v1: https://lore.kernel.org/r/20240729-fix-smd-rpm-v1-0-99a96133cc65@linaro.org

---
Dmitry Baryshkov (5):
      Revert "soc: qcom: smd-rpm: Match rpmsg channel instead of compatible"
      dt-bindings: soc: qcom: smd-rpm: add generic compatibles
      soc: qcom: smd-rpm: add qcom,smd-rpm compatible
      ARM: dts: qcom: add generic compat string to RPM glink channels
      arm64: dts: qcom: add generic compat string to RPM glink channels

 .../devicetree/bindings/clock/qcom,rpmcc.yaml      |  2 +-
 .../bindings/remoteproc/qcom,glink-rpm-edge.yaml   |  2 +-
 .../bindings/remoteproc/qcom,rpm-proc.yaml         |  4 +-
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 74 ++++++++++------------
 .../devicetree/bindings/soc/qcom/qcom,smd.yaml     |  2 +-
 arch/arm/boot/dts/qcom/qcom-apq8084.dtsi           |  2 +-
 arch/arm/boot/dts/qcom/qcom-msm8226.dtsi           |  2 +-
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi           |  2 +-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/ipq9574.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/msm8939.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/msm8953.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/msm8976.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/msm8994.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/qcm2290.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi               |  2 +-
 arch/arm64/boot/dts/qcom/sdm630.dtsi               |  2 +-
 arch/arm64/boot/dts/qcom/sm6115.dtsi               |  2 +-
 arch/arm64/boot/dts/qcom/sm6125.dtsi               |  2 +-
 arch/arm64/boot/dts/qcom/sm6375.dtsi               |  2 +-
 drivers/soc/qcom/smd-rpm.c                         | 41 +++++++++---
 24 files changed, 88 insertions(+), 73 deletions(-)
---
base-commit: 668d33c9ff922c4590c58754ab064aaf53c387dd
change-id: 20240729-fix-smd-rpm-9651e87a9bb0

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


