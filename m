Return-Path: <linux-kernel+bounces-249031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0671292E546
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3843C1C20C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA1F15A851;
	Thu, 11 Jul 2024 10:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mXAwW7MI"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A8915A84A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720695540; cv=none; b=q5gjk5kA0R3zba0Z91PbpRQXlRRTH6lwtu8CgLKbOav2S624CHfFG6thMuSjemC+npO9YKWhXbJXb7r6xWK4okdwxeWYXn7pSv6CmVznc7VAovnQL2X9NuiV9AFTzMVIkAl5eYglkuuBnRI0URYyp8sjR7FFtVmnkLAVhenHGQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720695540; c=relaxed/simple;
	bh=8F5cu1Nbgdv4LRNHCnmFtoPrKLEu6NjO08uCvgHdr/o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gs1oHTSCsDqOjSmbmkWs2ScLZa8mSrHrHg3wm4pl75UMUv2f40Ncf7yA2bhCt4RAcyUQXO1y8OIMg+54esmKqTPMSUbN9Vt6nlgsVtGWoLOJ3gDuNcTUrvwH2J/p+Rd4nHXYsVTAEmBjCd7coV//uYkLkn7ErZW7lLcFqKEVWQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mXAwW7MI; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7523f0870cso90098166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 03:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720695537; x=1721300337; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LvJE+2dq9rYOh/AV+Ot4mrkMQ+gmhep7qxXNI0HNNrY=;
        b=mXAwW7MIpTWwhasTk4BcsKls1TvBkVVDHPRCXUlFK+1DRXF6qlJJrwwzGl9GnXRQcx
         lO5Dmcc9FNkcAAqzPb01fCJCuAM4TgXn8ZRtsVEunc4dPUC7g4RGFPqenemAhR10hCjh
         TstoEHdO6DfL8t7Y705+kJF61b53bphO5VINyGRcMEUAf8LPYfiqp8wlcaxW1T5AGsAR
         D8CwZ5MS54elnx5OXk8RdmwIGvKUiCb415NoXsY5xwdzvaRZyNIoJsjY9H2MWybK+Kd0
         +VGW+XPyLH4vSlCMobTsd10P3qP+64cEc8vFesa/6jHUmcHu2Oz/rxYtBDe49zdu35Ij
         h7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720695537; x=1721300337;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LvJE+2dq9rYOh/AV+Ot4mrkMQ+gmhep7qxXNI0HNNrY=;
        b=ZARFjc1XSE0FLEBXPHIlMY1nRS5bxPj/4mEdZHRpOA2+dVI5xKFX9yIvxmZKH7q3cV
         /7FpdYu7GpGVNP2PAIvBj/7/t4IuZ4Qd8FwKydUJ7u/6P7yeoEw9y2v1CyIiNkXTWz2B
         21S4+lBCep6u2rl2z0BofTyGfkMRxqJSAtRvKliKVCcXlFql6Es6SdHZRBXzoJmOUTG5
         l9r/o9ALwox8zqTYAlkrlr+SoR66KyBur4tznQb5Yxmt5b6ec6EtrudN7zUK1+KlWgL9
         pQBNHkRHmxMvfjxAuQswvKER3DvvE/gm/YORpwBCzSv1yH7vce+GZwJNJxuqtQ36Iz5T
         IqVw==
X-Forwarded-Encrypted: i=1; AJvYcCWDpe+Q+2kaqV6viQd48QBeN4KeR5RI20vHytKn0Pg3qYWoT3m6PnTyR0VzzIqkkkssVhZ3tmZNyH2PxW/6eqgkBfMiyOpF+O9KZl+y
X-Gm-Message-State: AOJu0Yyew8NtCJP0u5DCyTwHiDmRc9wQyESYRxjPtwxHDnhQkLLYBo1s
	nMdAr2BK/REaPhzy7XNd6hyUJmPQU6NuYWZZQ/TvHXYH7aO415TF1jMHJY0Uu30=
X-Google-Smtp-Source: AGHT+IEAW01nZBJFD5VdSSV3PecfmH4qafPWxkDUGCRoxv1ctIabspJoRoPmVVEBMq++Ku3GjQ0X4A==
X-Received: by 2002:a17:907:868c:b0:a77:c548:6452 with SMTP id a640c23a62f3a-a780b6fe882mr729736466b.41.1720695536680;
        Thu, 11 Jul 2024 03:58:56 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a871f2fsm244209966b.202.2024.07.11.03.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 03:58:56 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] x1e80100 dt cleanups
Date: Thu, 11 Jul 2024 12:58:45 +0200
Message-Id: <20240711-topic-hhh-v1-0-a1b6b716685f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOW6j2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0ND3ZL8gsxk3YyMDF2L5BTj1BQLM4MUCxMloPqCotS0zAqwWdGxtbU
 AikauXFsAAAA=
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720695535; l=833;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=8F5cu1Nbgdv4LRNHCnmFtoPrKLEu6NjO08uCvgHdr/o=;
 b=hdWv2NmA9+0va34hfJCJrN8qQiSgnY7I8O9TBjBXpybIHbC1QZhFtcGOkGe+1jRnaGJeuHsns
 YFR8Ay56WlmDEELQyUpJTOi6JLKxsq2OFmDZW0+F1nN2MPoXVj6S/i6
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

no functional changes

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      arm64: dts: qcom: x1e80100: Fix up hex style
      arm64: dts: qcom: x1e80100: Disable SMB2360_2 by default

 .../boot/dts/qcom/x1e80100-asus-vivobook-s15.dts   |  4 --
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts          |  4 ++
 .../boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  |  4 ++
 arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi       |  2 +
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts          | 12 ++--
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 78 +++++++++++-----------
 6 files changed, 57 insertions(+), 47 deletions(-)
---
base-commit: f477dd6eede3ecedc8963478571d99ec3bf3f762
change-id: 20240711-topic-hhh-8cd3ed860d84

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


