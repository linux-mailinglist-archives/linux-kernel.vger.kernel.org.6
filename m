Return-Path: <linux-kernel+bounces-530980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 345E6A43A97
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209B7188835C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84891267AE9;
	Tue, 25 Feb 2025 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ObBrCYqc"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D36267B1B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477562; cv=none; b=fUZ9+Mc0A9+/j0y8YuhHFDH+zOUe0zUhVDnakijaAn6mOfPtZvJz95BzTKKPsAdRpaLt59eTIvb99PAdQ18gkdXV+tjvFb9VVbSnrxE7QuhOhByXmr889FgOD50/fSf2FiXQ4ECTMcWHg7VDolul1q+lEBohDQm2GwlmP1u43jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477562; c=relaxed/simple;
	bh=MUGXBiVnIGY1MT8QYBDyya3ZpnHbf083QIObBWfqJXw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T2Glx0T5Dxxq8Uctyj/xNiuOiGkKfkMTH9hyZhIzdeXorRS0Om9gZ5xS7X7uMKcSvAxKYD+FdfhoSQUz6GUgcEBcBROVRuHnTZsKOaHSJ65MD0H6zG1EIhI+PUGL0gteRPi5DUF7H/Q57Tg/kUvvgS8yX3g/pnQ6ai+4ADZL4kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ObBrCYqc; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab7d8953b48so86351466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477557; x=1741082357; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GtmskCdb/iQ5GUNmqz9p8e4yoK0c/+1oJ3xektzG9mg=;
        b=ObBrCYqc26tayL6HhMkNY+gHqWK2MkF97fkeZuRpmIQ13CGNmlcqTEdxFKougcSePW
         3KzM5KkVdCgU+Bnfk96lZX4VUjEmAis9ZzPf4EYZ1bpnvtaoE8OMGbarzs+c89YFvmpL
         I3tMHZ/4WI8gjq2Lnl98hqsGX8hazLW+E/McrbqEQptztWHrVl6ggWiRkR+ZP9Bev/zY
         Kk4yU4F526JSdoe5NNjnk/GGvfdWUXx5uz/jdvvLH+9Q5Nut1sH7v5oiQJPpDNQyk8ql
         P+NybMiLLu3A5iM6yZ9dRW1fjIdX7WistIFhjVPbYsjSyA6h7C42ltamdUXaKJ6eALJX
         LnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477557; x=1741082357;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GtmskCdb/iQ5GUNmqz9p8e4yoK0c/+1oJ3xektzG9mg=;
        b=ZIlb51YgEE2UOq5O5hjzbiM7yGvnnCZv71pfLOqv/rJisgjPfZviHzrnL7sLeERhP5
         5yvOoDocjGI1XJmmlSpXd4OFrfBk7XqSwjsXzdSIpc/6Ik5VWiBnvkHIs6aQkeNB4Tv9
         WZTQ+BuVWRaEtjkrlrtlHEmPLOb3yqh2IqYZy32nRYwLnlqr5MUZEaF75T7YD0s/bvrc
         R6ukLZZ1b7mQL5vR6n0Ics863+VURBNRXA5utW6t5k5HZwmss4zMZ1l/xDkJlzT9zT3Y
         BICpAEBHp6qgvvURceSxZEWfLaJjDoJVu1Ic1JMbVp5trxK2bKN0LX3HycHvabiYZbvW
         gLNA==
X-Forwarded-Encrypted: i=1; AJvYcCX6pi6QF0tFewlpG602AFdu3Z5XUQlxJfKJQ70ZddWKMxPo4tSkU1vfWDqBNnJGACF0sXZH2tboJL7NDpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd8ZhWd6tkwMremm5ONjV1Upzb1bh926vo3BqbFl0Zdjj0lcH7
	di3MhOFEFT54RKNGfv2F/BzamwSmuEdIhlO5P1YP72Y4qIi81He5UkOelYr4tBw=
X-Gm-Gg: ASbGncs9DbDL+gMfT1J15jAbt99MYds0gVHOOpXqaE3MVYnazy380XjbjdrvFqP0fa+
	Ipl+/8BAZfUgSNvvItn1oQX+H259Xw6pmuYJ54x1xDym1V2fVz4xHBxGFO/545WR3DwtUybauqd
	Tk9ITFsiCPnqBELXgRkO466Y6ijWUwxEiUypuCge1bwH8oTQ7Tk/CxlUwjooXsEWrfmlJ/KAckU
	y9peSnmOwIZEf1X+/cK74y4DneRCwAgngsaf9SaX3NS+RygRcZzZT62GInBm8MbCLDyAlLOZ4Ia
	qDGStx7Rzkw/jRk6rEPMz4E+6DO7gOJvs0M5tQZZENq5+5u7Gp0m67Irt7whcEf2yfZlbz8QrhN
	p
X-Google-Smtp-Source: AGHT+IGDjCixQUyWlzIQLqe3gqzlo7aQnUb86K/bmLCpIYFi5mYm2khOJB9PgtIT1SeuhmiIo1Mu+Q==
X-Received: by 2002:a17:906:16d5:b0:abc:37ac:6e6b with SMTP id a640c23a62f3a-abc37ac700emr359930266b.7.1740477556598;
        Tue, 25 Feb 2025 01:59:16 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d59391sm115164266b.56.2025.02.25.01.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:59:15 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RFC 00/13] arm: dts: qcom: Switch to undeprecated
 qcom,calibration-variant
Date: Tue, 25 Feb 2025 10:58:57 +0100
Message-Id: <20250225-dts-qcom-wifi-calibration-v1-0-347e9c72dcfc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGGUvWcC/03NTQ6CMBAF4KuQWTtJKaIpWxMP4NawGGDQSZSft
 lYTwt1twBCXbybvfRM4tsIOimQCy0Gc9F0M6S6B+k7djVGamEErnSutc2y8w7Hun/iWVrCmh1S
 WfGwhZURKmT0fsxRif7DcymfZvsLlfIJyPVoeX9Hxv8/GFMmGVOv64vwTgaxQ59FoUtqYnI05F
 CGFcp6/3bM6scoAAAA=
X-Change-ID: 20250225-dts-qcom-wifi-calibration-a3aa0094e731
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4217;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=MUGXBiVnIGY1MT8QYBDyya3ZpnHbf083QIObBWfqJXw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnvZRmd5HI1MARMgl8zz2aBH9HbWofzZqU3QOVc
 otd4aOJbpmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ72UZgAKCRDBN2bmhouD
 14RfD/wP3KVKCDKm4roFcw0y4f2OntDqw7r5AJiTLKQeTUn06L4cpAEny7TUMpZr6TR3U5Hnc2Y
 u5BF6wu3ZTZkBhzgmt6ABwJEGaAXM4zP8/4WfbwZUm5oqx02PtWrj2guOeLQtXXmbQNMD1lil/X
 jMqPjs5At0M80k2xHvZFlk4v+YDr71Ej4QlDmqhaOSjbRPqADeDSzTZTreV3l2x+4USoeTe+TFj
 +NF9iir2a8VRMAYrRflYYj5gk0uXw3C9ZVDSF3lYewoKXl0gGlz17v/XJRIdgbyQdvJx3lXkqkk
 Qh974aYnbabLIekkNeZj4s4+2qu80ojHNH6qK6Ng2EYd/pA06cwBb2UCHkaO46SvElcxofCSJXH
 8I1jOx8RZAxBvkBN6lTnoKZ7LGcWdm91CgXECSqhvdBkNaFmjjjIlzSszTbyOwCSjQQNNothsxt
 V1svPwCQsNAgEmPw7Z/RiN/l/ds0vw8DpJ5Yx4AUgMKMQChnZX680loQFgLRWiuAPIwW38b4Glm
 vPrASCx/u3gkUfziXooJBxEjHbiFn75s+qi5kyuCHIqqs0IYCCqbcAUjKabyNoem40s5RQPnX17
 /FN8PPSSyISkq2qRSiR/lpnU/Jz0K65Kh2Ug5M+OVuIbIcNtW0LUIPB1lM3+DS+X+niNG7yC+nI
 DNmAsRLhdLXROcA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Dependency
==========
RFC, because this should be merged release after driver support is
merged:
https://lore.kernel.org/linux-devicetree/20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org/T/#t

Change will affect out of tree users, like other projects, of this DTS.

Description
===========
The property qcom,ath10k/11k-calibration-variant was deprecated in favor
of recently introduced generic qcom,calibration-variant, common to all
Qualcomm Atheros WiFi bindings.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (13):
      ARM: dts: qcom: ipq4018: Switch to undeprecated qcom,calibration-variant
      arm64: dts: qcom: msm8998: Switch to undeprecated qcom,calibration-variant
      arm64: dts: qcom: qrb2210-rb1: Switch to undeprecated qcom,calibration-variant
      arm64: dts: qcom: qrb4210-rb2: Switch to undeprecated qcom,calibration-variant
      arm64: dts: qcom: sc7180: Switch to undeprecated qcom,calibration-variant
      arm64: dts: qcom: sdm845: Switch to undeprecated qcom,calibration-variant
      arm64: dts: qcom: sda660-ifc6560: Switch to undeprecated qcom,calibration-variant
      arm64: dts: qcom: sm6115: Switch to undeprecated qcom,calibration-variant
      arm64: dts: qcom: sm8150-hdk: Switch to undeprecated qcom,calibration-variant
      arm64: dts: qcom: qcm6490: Switch to undeprecated qcom,calibration-variant
      arm64: dts: qcom: sa8775p-ride: Switch to undeprecated qcom,calibration-variant
      arm64: dts: qcom: sc8280xp: Switch to undeprecated qcom,calibration-variant
      arm64: dts: qcom: sm8250-elish: Switch to undeprecated qcom,calibration-variant

 arch/arm/boot/dts/qcom/qcom-ipq4018-ap120c-ac.dtsi         | 2 +-
 arch/arm/boot/dts/qcom/qcom-ipq4018-jalapeno.dts           | 4 ++--
 arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts       | 2 +-
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts         | 2 +-
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts                   | 2 +-
 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts           | 2 +-
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts               | 2 +-
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts                   | 2 +-
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts                   | 2 +-
 arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi                 | 2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi      | 2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts     | 2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi         | 2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi    | 2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi        | 2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi   | 2 +-
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts                  | 2 +-
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 +-
 arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts     | 2 +-
 arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts  | 2 +-
 arch/arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts        | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts                 | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts                    | 2 +-
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts       | 2 +-
 arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts            | 2 +-
 arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts          | 2 +-
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts                    | 2 +-
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi   | 2 +-
 28 files changed, 29 insertions(+), 29 deletions(-)
---
base-commit: 0b711700b3e432d036512ecd580d1312707a11da
change-id: 20250225-dts-qcom-wifi-calibration-a3aa0094e731
prerequisite-change-id: 20250225-b-wifi-qcom-calibration-variant-92a02995e996:v1
prerequisite-patch-id: 3d5e2355edb04751d04c86263d1aadba0f309fc9
prerequisite-patch-id: 939f220d1859ffb79d2d74d38b8ebdafd5e11925
prerequisite-patch-id: ccc166b6ad2f1c967750b06bf6ab543f22590776
prerequisite-patch-id: f05f46fc9b19b4b48114950c9c86c849e52fbfca
prerequisite-patch-id: 3c61783975dc22358e7817c8ed549334135a2d2a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


