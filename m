Return-Path: <linux-kernel+bounces-540172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5742DA4AEED
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 03:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC7E16F194
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 02:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343EF78F5B;
	Sun,  2 Mar 2025 02:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K4eq/F5+"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E99F9E6
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 02:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740883805; cv=none; b=EZIL7qOpTtvZwpB9x7PTUGgyHngevwccroHH9kyIVT+hHmDukv8eGlJduzeG2Zle/qOU64Qm8Yv4aX5Wh4j0gPO5qlLIqpmZB9ihHJEO61gaqY/2O3l51socn1JY5D8PxkF6fLM+9x4KOvLbDMlrrtF72I1ksHrX7XSkhn907dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740883805; c=relaxed/simple;
	bh=/IqzU/n63BAdW4SOmKEtnTe2FypNMZ+jDWC1G57xNmQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JpRWx54WIf3+3zz73J5Af/Iz2RIUMywXIX5JEzKNOpiv3DzdERfjiS0CNSY4GNC6ZczaTkQEjvQNrRanhjqxI64hin1Q1RjRDkbWMMsaooin6THDcTNCrgNA5gk852hfTidh1Vk6RsoadvBS7JPzEMK3sZpnnQO0jMF5S2ew1Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K4eq/F5+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-439a4fc2d65so35400705e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 18:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740883802; x=1741488602; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iYec184ApMWFnwTMKcyq5mapVYraXn+V3R5ndkdcYqg=;
        b=K4eq/F5+J4L/GAyrgb5kigsQnQzRvsbkUYJnBMWqJwXCvnkisvd5EqZJ8IbdplnHAq
         PtALVZuxwDEafQAzBr4/yiEwRnSbwq7m62Y5w20ywIBIlStviaS6ihd8b6LEfDDdb9UF
         23zgzN/DlLZ8ooi01iFqv6KXenv2C0baLX7QILkFO5egJoArrwnbSvKKl6ebw/iUs/m/
         +f7mYO7CRCZ612OcGFUWh8Ag5w3eWGb3GDKsn8VwNbcHM9QTImrzlakV2dze1kPOztsr
         5AmMYdPlKPBZtyi5C20RBbcmEzTt9dcO6GxblOVaQ0Orr1/Wh+WllHUPdlp+wGl/ueiG
         Py/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740883802; x=1741488602;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYec184ApMWFnwTMKcyq5mapVYraXn+V3R5ndkdcYqg=;
        b=T+Ijms3jP1vM6ZUKv7fKk8LWlEwteXxEyjh/ZmgUR+NC+HTT3qo4zI4+OyUklU+xZk
         CO4Y5PHGgdEMG2tjBpZpReWsmGgsnPovceWnlkk6nDVVjTpbGmJPgAxTinpZnRYe2/fD
         QyVvc/ZegxFH8+SRQGT476VLcX9g3outZSJgtON8AC2uXyIN4QtbZmU9aUy/gacdvqF8
         q9YvBAsvpTMD27EvJ2x79ROF38LAUnPRsffclB8yF6jnp2pO1jbzDU65F1e0Wb+XTuMI
         GpmVVqVnJlICd/BnV08DrYFzAsNuqkey+0ZJnFhfF6PQc2NGJuwkHqz42ej8QVjU/Bh/
         uwEw==
X-Forwarded-Encrypted: i=1; AJvYcCVSVgb/0L6OJNkndqYgq781NZ47aHFvs0DT+XeonKNQyuNoTfM3OmDm97kf3tnJo/w+gWIhqRgmLs4h9GA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMCqMRsEo61iINaNUaNeCi17hMJfoadq23QyDvEOueO3aPUmtx
	FdBETgv22+RZfm2oBZSiEHmzAfbBQTIP1FAyE5A5gtMFwzbb5KDjia9FBkK3Ku4=
X-Gm-Gg: ASbGncunOREyhBLabDsd6gzvmMCSV35Ru26Xic79/y/EUajfdd1D3iPjLlc9apJizgm
	Rz15YewFcoKWa6z74cuG0DwUKVvNopB175E8fX9HulM0XWlptYQw8Xl/gr9uk+6LaKbqt2rnCyW
	TZEGZT5efWVNO689Xl8YP4z3vwSJpLRRM3KMk5PZgFbEJy4Jxj52wW04xOHUbgIfbIpkHxNYLQ1
	4bP4HBNSdcU3i5IzCCU4u43XsAKyj92FiRN7rk+zlTFbHW/mpVXQpdpHld/EkeUm8EtjHC6fRQl
	s/6QS8Aq9S2PtMxFBl14JZ+aP1q9lu7yeFiR1+E+hS6g/RBCBDmi0Q==
X-Google-Smtp-Source: AGHT+IGR5NlYEda30KBCY59v51iXTJ0sUgnzU+5tKf2Kw28XxjXtlDeFK9A3nguMlEjVQ5MSzY/kPQ==
X-Received: by 2002:a05:600c:1990:b0:439:9b80:ca6f with SMTP id 5b1f17b1804b1-43bad205987mr69215705e9.5.1740883802036;
        Sat, 01 Mar 2025 18:50:02 -0800 (PST)
Received: from [127.0.1.1] ([2a02:c7c:7213:c700:e992:6869:474c:a63f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba532b0dsm137845975e9.13.2025.03.01.18.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 18:50:01 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH 0/5] qrb2210-rb1: HDMI/I2S audio playback support
Date: Sun, 02 Mar 2025 02:49:50 +0000
Message-Id: <20250302-rb1_hdmi_sound_first-v1-0-81a87ae1503c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE7Hw2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwMj3aIkw/iMlNzM+OL80ryU+LTMouISXTNT40QzE0tjw8RUUyWg1oK
 i1LTMCrCx0bG1tQCSv5qFZgAAAA==
X-Change-ID: 20250302-rb1_hdmi_sound_first-653a64931ae5
To: Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 Alexey Klimov <alexey.klimov@linaro.org>
X-Mailer: b4 0.14.2

This series adds a feature to playback/output audio via HDMI
on the Qualcomm RB1 board. Since RB1 and RB2 are very similar
to each and other and most likely use the same mainboard therefore
this series is a rework of the similar patchset for RB2.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
Alexey Klimov (5):
      dt-bindings: pinctrl: qcom,sm6115-lpass-lpi: add QCM2290 compatible
      dt-bindings: sound: qcom,sm8250: add RB1 (QCM2290) soundcard
      arm64: dts: qcom: qcm2290: add apr and its services
      arm64: dts: qcom: qcm2290: add LPASS LPI pin controller
      arm64: dts: qcom: qrb2210-rb1: add HDMI/I2S audio playback support

 .../pinctrl/qcom,sm6115-lpass-lpi-pinctrl.yaml     |   8 +-
 .../devicetree/bindings/sound/qcom,sm8250.yaml     |   4 +
 arch/arm64/boot/dts/qcom/qcm2290.dtsi              | 113 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts           |  49 +++++++++
 4 files changed, 173 insertions(+), 1 deletion(-)
---
base-commit: be5c7bbb3a64baf884481a1ba0c2f8fb2f93f7c3
change-id: 20250302-rb1_hdmi_sound_first-653a64931ae5

Best regards,
-- 
Alexey Klimov <alexey.klimov@linaro.org>


