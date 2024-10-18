Return-Path: <linux-kernel+bounces-371692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720039A3EB5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A5061C2367D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CA717ADF0;
	Fri, 18 Oct 2024 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="GTLkgxIj"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A9B1F947
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729255780; cv=none; b=Ba238PwOQAZZ1HX98iaiCzX6jt9IzEKi21+t+G21gz3J0J8fABrtG5pBoPfEuMyZWo9cwBbsN8lglReVkKmgCrfQQSxsQV3ZjWBmei0YLTzBFaz7kyAMSREwA5hrkyCb0I7ouJkJBFiuNBI8ncaI3nm+uF9RGS8d/AtVcKPCjIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729255780; c=relaxed/simple;
	bh=KW0DM9y521xnsIzlWoKOHn3iGMEHMEaiggaJBCMHLqU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cQE+TicAiQw1jOAr6jcFU1oOqFLQBDqIzTwIC6zMysG6vJYNvW4ZiJQNxaiOSQYpAfFvTl7aLUFiwrAmwn8NArzP6xSwZ7YLXoYa2i3BmnAVbMiAmeOohd9smApmtS0AIW/2QiqAao1juza+kHz1Ch6baFUE1hW0jsIebbv4/YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=GTLkgxIj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso15886165e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 05:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729255778; x=1729860578; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tHQm1A3wWG4ttDQv8G9o0qpK3fTgulr9fH3cUF69eYs=;
        b=GTLkgxIjpFFoLdw5iSlS4lxFisiv2atGbxSazY983opUndmGV8IYOwPRpSm/MLCWCG
         MqiCLxBXdyM3yQVknrzVonJHmRJNIEsT70uKaCMHy6tqygWal8IOD+ELTnOmVKst6NKX
         TSnsnyz9XMk6FtjOuRyClPPyi37ydoGt+s8b56h+0M5HfsZwRWL5+Qmf1JrO6rb+rfar
         SZZfMXmmRNAu+FtNPvswTRR8h+6IL3qANqXQUoPgZYKxYgyUmHJJEEg7X0eqZ6svX1Eo
         WgEzCjrvLakZqU3Jqr2iFWLp3w7Z4iNXW+9uehgGs7sgZc5ERlpvHXrCzYQNV5HZOEpA
         YIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729255778; x=1729860578;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHQm1A3wWG4ttDQv8G9o0qpK3fTgulr9fH3cUF69eYs=;
        b=I6Panbuk3elhNRRMObpKh5vd9U/fizXk2Li0Mm8WvL9mcliybMhO0+qZliDhY8zXwt
         BDZgP1mxccZyWVGM/nIYBvjrCtMYr2E+X9k4z05soqClHUlcou3pgJ3GKNTkQkaWm1UB
         KGyjKy6ySxycXV77kZ4NaI5k82gCRJRruHbCzedPrHoQxn6f9NkJ05ZSc/lP3xW0ImcA
         /htlFikc4liqvCbGLvcWzIixFAyw1eFQcC4d0/KyPVnr2j7Ao2kDqvEiU3lAs6czPdpn
         uRMfRQYIjt3kYr8/6A0d/3okZKj2+6B07jo7WPQyx8kv1//pFFKk3NO0wHBjv3vbEVQ4
         LIyA==
X-Forwarded-Encrypted: i=1; AJvYcCVwtYln2YTeRC2QUIsWHhewS1JT1GQJeAuW2fxvIs8bMjdoTfD12RRRWM8ShGuxMQNuHnCViRU3rTNtoSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR70dyAt7mDhBgwBlGLJCNg/s/junjMp5CkqUWJAf1lgzm1ZGe
	Cy9whBLDim4jO+1zvvfHNQFu09KWjpiKXfCy7C7trxMw5MgOg+4zK48Dcl2gioc=
X-Google-Smtp-Source: AGHT+IF6WeKiITXXszsGmJw+wxsyKHZzbIw4J/ll8ntLiADsff1uQwo7y5tsHpGvq/+T+R1J5ysj2Q==
X-Received: by 2002:a05:600c:1e28:b0:42c:b750:1a1e with SMTP id 5b1f17b1804b1-431615991f4mr19110665e9.0.1729255777585;
        Fri, 18 Oct 2024 05:49:37 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:45a3:93e:5196:d8ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160695d8fsm26640835e9.27.2024.10.18.05.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 05:49:37 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v6 0/6] arm64: dts: qcom: enable Bluetooth and WLAN on
 sc8280xp and sm8450 boards
Date: Fri, 18 Oct 2024 14:49:10 +0200
Message-Id: <20241018-sc8280xp-pwrseq-v6-0-8da8310d9564@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEZZEmcC/x3MQQqAIBBA0avErBNESqeuEi3KpppNmQMlSHdPW
 r7F/xmEIpNAX2WIdLPweRTYugK/T8dGipdiMNo0GrVT4tGgTkGFJwpdys0W227BxvoWShUirZz
 +4zC+7we8+06hYQAAAA==
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Johan Hovold <johan+linaro@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Steev Klimaszewski <steev@kali.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3207;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=KW0DM9y521xnsIzlWoKOHn3iGMEHMEaiggaJBCMHLqU=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnEllaYumzIkevzpZBf3QebQlGMbQOMBsycQUWb
 YTOZvudTHKJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZxJZWgAKCRARpy6gFHHX
 cs/+D/0eOhVz2lphUv5iwdjz8bpqDiiJhBEtVB2NfR9oSPcie8TyDmZPrUdpBM1u7OGP5/OP5Zk
 1IpsUpCzEcX5IwRurjqN7qEazCzk3rWxgCOiQNWKGZR9NDQPkkxOrpH0Sdvugl+G9qhPiLNvFnx
 ZFR9Imab3Tsnvmg5WbvkgY13GPBUsLwoGPMUyFeUGicxR+dBnoS23HvhVomXc8KZ2MzLZTKFmvP
 rx5e0E/Ay6QgM9PhnODjHz3lQwxPHWAPmEJ976WUdbvTvZu92QJVPTg9DCpHTLMIZyueFAwkLdz
 6V/KtSRoL/9yEMbV+EtCWUqEHxbs87gTs9NZay/llceNUGTrtjaTsRSgriRCMnvqIsS4Ed+0GLR
 UT+l762EYV9ogO8ns3kqtxHFcL0FCWfZUjF2ll8FdIXtfv8Q3iQLYTJ2Lrg7VmeehSWBz90ylXu
 eKGXRIelEdwriDZQyVIGOPU4zVlebMGa58W54R4FImZrspTLaaJIPeNlF203p6u00Mc7ho2c55m
 8rQFCOu5unoQQnR0wzTj14S9lk7eq9BkHOb0AfqjdOxG6qgNgTvuyXFo34XLCP7va4Qi1jpDySB
 9YcA8859npIXDHpRo/mbEUsdVbvHCu/hvbJoa0P8xRemzY5e2phhYoGctITFkkA6et5OJtOZ3Hq
 tEAVXFNKO2GPBqA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

This series previously only concerned sc8280xp but while enabling
WLAN/BT on sm8450 I noticed some more changes will be required so I
folded the latter into this series and updated the sc8280xp CRD and X13
patches.

==

This models the WLAN and Bluetooth modules on several boards using the
WCN6855 module.

The wcn6855 (also known as qca6490) is a bit different from the qca6390
so modify the power sequencing driver to support it with separate device
match data.

For the sc8280xp-crd and sm8450-hdk we add the PMU, wifi and bluetooth
nodes with the correctly modelled wiring between them. For the X13s, we
rework existing nodes so that they align with the new DT bindings
contract.

On sm8450-hdk we require some additional toggling of the XO-CLK signal
so add that to the driver as well and update the bindings.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v6:
- add the xo-clk signal handling to the pwrseq-qcom-wcn driver
- add a patch enabling wifi and bluetooth on sm8450-hdk
- add missing supplies to the PMUs on sc8280xp boards
- Link to v5: https://lore.kernel.org/all/20241008102545.40003-1-brgl@bgdev.pl/

Changes in v5:
- put vreg_s10b under the "B" PMIC on the CRD instead of modeling it as a
  fixed regulator
- order pinctrl nodes alphabetically
- restore the drive-strength property for all pins to what bootfw sets it to
- disable bias on wlan-en pin on the CRD
- remove stray newline
- add the swctrl pins to the PMU node

Changes in v4:
- bind bluetooth pins on X13s in patch 3/3
- only drop the regulator-always-on properties for vreg_s11b and vreg_s12b
  and fold this change into patch 3/3

Changes in v3:
- move adding the bt-enable-gpios to the PMU on the CRD to patch 2/4
- add a patch removing the regulator-always-on property from regulators
  on X13s that no longer need it

Changes in v2:
- fix commit message in patch 1/3
- drop drive-strength from the wlan enable pin function
- drop the calibration variant property from the wifi node of the CRD

---
Bartosz Golaszewski (6):
      regulator: dt-bindings: qcom,qca6390-pmu: add more properties for wcn6855
      power: sequencing: qcom-wcn: improve support for wcn6855
      arm64: dts: qcom: sc8280xp-crd: model the PMU of the on-board wcn6855
      arm64: dts: qcom: sc8280xp-crd: enable bluetooth
      arm64: dts: qcom: sc8280xp-x13s: model the PMU of the on-board wcn6855
      arm64: dts: qcom: sm8450-hdk: model the PMU of the on-board wcn6855

 .../bindings/regulator/qcom,qca6390-pmu.yaml       |  12 ++
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts          | 169 +++++++++++++++++++++
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     | 103 +++++++++++--
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts            | 157 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |   2 +-
 drivers/power/sequencing/pwrseq-qcom-wcn.c         | 101 +++++++++++-
 6 files changed, 526 insertions(+), 18 deletions(-)
---
base-commit: f2493655d2d3d5c6958ed996b043c821c23ae8d3
change-id: 20240807-sc8280xp-pwrseq-7b6859d846c5

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


