Return-Path: <linux-kernel+bounces-175796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4548C2528
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4C328570D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3C8128362;
	Fri, 10 May 2024 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VEUJ17zg"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3B74DA04
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715345918; cv=none; b=e//uWmIA5twv0KwjjabWNVqnfqTdgIwOFBRKRRXXYtw251Ksf6qWAEh8huQMlrwFkDGae4qOa1hE3Y3IFyLKW4JfGohuJlR5TxgJCI10Jb6jZ7jtpfn/FMZytCkUpithWsu3fSL4KXEIl4uTweAHAwhLd6OLGfVasS6aIB+q4pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715345918; c=relaxed/simple;
	bh=j6ZhT6JKQdpaQ4nF4OUVdMD6OZP1lkY+RwkwRCLgSkk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U1SGiOp+YGBmJ/GzASva3f64w4EA1hmCR46wcT5We17mN+v+pLasJX4pGQWTrrbMtrqmSKcybLa7X4y75JMN1R8Ry03j4haebQh43MyR3ljeyPdY/erR1Wcu3M9oyoCB53OaI9zgTtkPUd0IBuUAjskIx91xbVn/AVUGnNgbMKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VEUJ17zg; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-573137ba8d7so5570318a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715345915; x=1715950715; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1rF3Vk3nYg5uojFLwj6FcvaVgIkPrJFERDpx5/V2uZE=;
        b=VEUJ17zgxxllVJf1mStUqQrCeuaj9hnBMkhlc9sreKPkSP+g6GbgRmwL6QqAf1CCIk
         2VMOWQR6Jyx39S4Pd20DvMhUFTAZ215fz3I1+mlyo2nih6PHR3x083zphDoblpdFqTUG
         BmW6cHZPBIUXl1HgZkOsqI3OV1KooajIivsBhocwGq4pYQJyQ7Ggi3gBAV0OSEASETXS
         RQgFLjEg+vjbApZRAsFDPvzoI30z+MwubHo3ZTEceRl1hUFOl/0ee+jApD7o+AJ+Hobd
         QzOxOEkuTd0BlMy9BqZkikV9z2MvgggAF5j07lfiis/DxuYoSsT5KCturmewxTFwMuzr
         jXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715345915; x=1715950715;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1rF3Vk3nYg5uojFLwj6FcvaVgIkPrJFERDpx5/V2uZE=;
        b=m1xuws0I9Ez9vtRqFZ6tpaMgXlsE0H6bgGMLIvEDtKnNlxMeo5Z6NGmCnLKnwCyr4B
         wuhRAFKdVEZRyyAuMgTVdQ6wBS8i37sQX0dvjl0kUpkJ/m2QADI06yL9lvglZQz/MsFP
         HAV38tHccbh5JxcoPUTlDIUMtmMe+edKmhYCdem24PwmwEcxIs1FlMVkRf4xRHneHcq/
         jHjA0tDBN8ufPFOF0o8vShWtSKFEfGuVie3eQ1ZN/U4hivqSt+aL7uIomXx0iVElP05h
         E6SSeH98k/eYZ/rAg3BVa+T08UXDYn0HXQO836Twm06Y4cyuMHRBqW7DQVWehRYhbSXH
         giHw==
X-Forwarded-Encrypted: i=1; AJvYcCXoGQmeAfOvr9bkreb3ugCGOvxyJFopvMKvy4j1mGpQr2HJFMny0OzIdOYQ1yyexm8A7GwPdHZ/W46pvXPdYHU7fvpN2RtLZhmXFKbx
X-Gm-Message-State: AOJu0YwfxRh5kPmOWF9nDxYiJ9ygW2SnPLEZlx67k0wdE6CE0UQtxql6
	s0uoxxGgmb5WQ+3xAOzWAtmm6hsJEAY+doWLUoJHhZrKxsfA/fOZGVMgyosIwLk=
X-Google-Smtp-Source: AGHT+IFEWwdsaPUn8ujKgl36DZHxd8effoxjsjwh1WmVFN9CjQrAIjGgg87VdiWkeAbd1uF1pjBf1w==
X-Received: by 2002:a17:906:7748:b0:a59:92b0:e0d3 with SMTP id a640c23a62f3a-a5a118c5393mr399265666b.34.1715345915620;
        Fri, 10 May 2024 05:58:35 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d6bfsm181857366b.31.2024.05.10.05.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 05:58:35 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 00/12] Adreno cooling, take 2
Date: Fri, 10 May 2024 14:58:29 +0200
Message-Id: <20240510-topic-gpus_are_cool_now-v1-0-ababc269a438@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPYZPmYC/x3MTQqAIBBA4avErBMsiqSrREjoaAPhiPYH0d2Tl
 t/ivQcyJsIMY/VAwpMycSho6grMugSPgmwxtLLtZN9IsXMkI3w8sl4SasO86cCXQKusMp3r3eC
 g1DGho/s/T/P7fuPvbe5pAAAA
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14-dev

For the thermal framework to cool devfreq-managed devices properly,
it seems like the following conditions must be met:

1. the devfreq device has a cooling device associated with it
2. there exists some thermal zone provider
3. the cooling device is referenced in a cooling map
4. the cooling map is associated with a thermal trip point
5. the thermal trip point is of the "passive" kind
6. the "passive" trip point is being updated (via polling or otherwise)
7. the trip point is being hit (i.e. the thing gets hot enough)

Various QC DTs have various issues, mostly around 4, 5, 6 and 7.
This series tries to amend the platforms that currently can't have
Adreno throttled, without making much unnecessary/debatable mess,
although sneaking in some configuration unification/standardization.

Further updates can be made in the future.

This was originally brought into attention by Daniel in [1], this
series resolves the issues on a treewide scale.

Developed atop (and thereby depends on) [2].

[1] https://lore.kernel.org/linux-arm-msm/20240116115921.804185-1-daniel.lezcano@linaro.org/
[2] https://lore.kernel.org/linux-arm-msm/b4dba1d5-448a-4a4b-94d5-f27c6ff0010d@linaro.org/T/#t

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (12):
      arm64: dts: qcom: sc8180x: Throttle the GPU when overheating
      arm64: dts: qcom: sc8280xp: Throttle the GPU when overheating
      arm64: dts: qcom: sdm630: Throttle the GPU when overheating
      arm64: dts: qcom: sdm845: Throttle the GPU when overheating
      arm64: dts: qcom: sm6115: Update GPU thermal zone settings
      arm64: dts: qcom: sm6350: Update GPU thermal zone settings
      arm64: dts: qcom: sm8150: Throttle the GPU when overheating
      arm64: dts: qcom: sm8250: Throttle the GPU when overheating
      arm64: dts: qcom: sm8350: Throttle the GPU when overheating
      arm64: dts: qcom: sm8450: Throttle the GPU when overheating
      arm64: dts: qcom: sm8550: Throttle the GPU when overheating
      arm64: dts: qcom: sm8650: Throttle the GPU when overheating

 arch/arm64/boot/dts/qcom/sc8180x.dtsi  |  28 ++++-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi |  17 ++-
 arch/arm64/boot/dts/qcom/sdm630.dtsi   |  12 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi   |  28 ++++-
 arch/arm64/boot/dts/qcom/sm6115.dtsi   |   8 +-
 arch/arm64/boot/dts/qcom/sm6350.dtsi   |  16 ++-
 arch/arm64/boot/dts/qcom/sm8150.dtsi   |  28 ++++-
 arch/arm64/boot/dts/qcom/sm8250.dtsi   |  28 ++++-
 arch/arm64/boot/dts/qcom/sm8350.dtsi   |  24 ++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi   |  48 +++-----
 arch/arm64/boot/dts/qcom/sm8550.dtsi   | 208 +++++++++++++--------------------
 arch/arm64/boot/dts/qcom/sm8650.dtsi   | 169 ++++++++++++++++++++++-----
 12 files changed, 406 insertions(+), 208 deletions(-)
---
base-commit: 2adffd063e54f8790132eedfaf3019bfb6f62268
change-id: 20240510-topic-gpus_are_cool_now-ed8d8c4f5f7f

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


