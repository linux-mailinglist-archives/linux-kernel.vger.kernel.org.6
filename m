Return-Path: <linux-kernel+bounces-370258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E91F9A29F4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 291A91C208A0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60F31E200F;
	Thu, 17 Oct 2024 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UzsltYrL"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35831E0DFE
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184232; cv=none; b=MGLXzGwqPYVNNpoiVpoqZObZIih21npt+n4Evk56fBWr+W4k/5FfU1sYsAj16mKTf1kCiBIeAsTqJuvZqZ7trSFXJ75GmEwRjT70vIswF6jRYyUd95ZZRwk7zwXQoT2vAUl712cqV9EpXRoGO0wijXN0upPUkA8gzy06dsENGRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184232; c=relaxed/simple;
	bh=OAZejn9mCT0AFo77p3qhjE8gA31X50sk9TKnxj1/KOQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B0vfbdj+e+fOqGUX4NZQZWWuaGH3vZrIN41Vj/FklA4KoNSPQE3VniQNN2UPqUw+eOAXjowFlL3HjGWRrsi3ZwPL4FlQ6P0UGhSDVMz31NzwYlz8Ap0u3m9P+111erm1THXGXRAKDEX9ajm/VoF1cT70yC6YBwLXos8W3KbP11c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UzsltYrL; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so1918443e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729184224; x=1729789024; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EoqB7xn1sq/321TIs9/YxkzBFt+QUHBAyoVOc2ArVVs=;
        b=UzsltYrL3ZPOM/4J4bfkPBusURmRMH0pgnhdfPLSUq/TTr0hs6/hlymr+zEnRGfv6p
         KAiNvgkZVj/j0JfVDbLJ1BrMIG/0HBWXkZQ54KptWRXsn+G8eVVbY+I4fHYrTd9wT8xD
         3I0z/Ln9nS7/jRLModxxvwZpXY6CGxEii8hvqQJy+PZsuRnbecz+53Sp6iI0nLXH069G
         xs4Bz8Ibo4re6z3nnDx0Q424381DdVC99bZLzSAHXD4ntZKmi0PYq1z/gmZL6zX9ky/S
         oN7tAn5XXfsnCTyohqmXwXpPurh3SYS5jKpVBz42kUCzcAmld2c9aHbJEJJ9ukFio+Rt
         qocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729184224; x=1729789024;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EoqB7xn1sq/321TIs9/YxkzBFt+QUHBAyoVOc2ArVVs=;
        b=EyT6upwv2xOJDebyQCqwoP5nOnJrpvwGNbNdp9dw0tTxCrflVKm8pRHLOXymaFc9mD
         70UVKAbbcfbXj2uzagfjxgrkrjVgZiE8Sezh/vSEJdQ/tleUYi5Hw+/fOOqMjtt/55/4
         +BZ9Wucp6Dru9MYh8ghx9T+lvxE5w2aXpIVTzfNWMTHlIYT42iWetPX4nhtSgkOiAJlX
         JdUvzcm5ZTE369c0SPV0Ccjf+ibxAzYqybtT2xn0myg60Fe5amgZNElxSyom9GYBZF2b
         FJQ5B+ZdQpW+9BMFsqoEuYNhfTPhsjMSnKEV34xb1qQAT303Ua98+N14mcn0V6tJJo5V
         5bpg==
X-Forwarded-Encrypted: i=1; AJvYcCWXBiKXQ9tHxEC1rh3I2WFttyUjNABiJ9iRmwrOjwW4TRL2ay0XEs2qrBZTO6JBZ1zZ4ynbFXfgC4Ko39k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrLD+VJjOqxb/5A/oPjINOsWdWTH+yWYA6aqaUsUCwSMZHPWre
	IOpVCnCjgPJweYZPh16XxTuxIADSqnrWvOHz5rXdy7JaGMLhra91ypirJrhVRgo=
X-Google-Smtp-Source: AGHT+IFsRl7d5jySpCJR2pi4kgD5G4mJaVqnhOby46a2PJHokCrJ5kP+vSdv4P1Zdjyvlfk+yFgmLQ==
X-Received: by 2002:a05:6512:138f:b0:533:e83:c414 with SMTP id 2adb3069b0e04-53a03f949ecmr6066547e87.59.1729184223695;
        Thu, 17 Oct 2024 09:57:03 -0700 (PDT)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00-70b-e6fc-b322-6a1b.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:70b:e6fc:b322:6a1b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a00007078sm821563e87.212.2024.10.17.09.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 09:57:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 00/14] clk: qcom: add support for clock controllers on the
 SAR2130P platform
Date: Thu, 17 Oct 2024 19:56:50 +0300
Message-Id: <20241017-sar2130p-clocks-v1-0-f75e740f0a8d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANJBEWcC/x3MTQqAIBBA4avErBPUjKirRAt/xhoKDQciiO6et
 PwW7z3AWAgZpuaBghcx5VSh2gb8ZtOKgkI1aKmNkmoQbItWnTyFP7LfWfTRhTC6KA0i1OosGOn
 +j/Pyvh8xlu7xYQAAAA==
X-Change-ID: 20241017-sar2130p-clocks-5fbdd9bf04ee
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kalpak Kawadkar <quic_kkawadka@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2707;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=OAZejn9mCT0AFo77p3qhjE8gA31X50sk9TKnxj1/KOQ=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnEUHYFVQMVMHSbHTOAHD1NZ0f1npaoX8xSe/jX
 dHtb1j+T1iJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZxFB2AAKCRAU23LtvoBl
 uHflD/oDv9yr4s6KsV+BENXK65lQFt1Bt2DFxk436NTmthVQwS32VFoq+gxnKUQzP5tSkfsOl/C
 kmYcFTeyjAD+LraC9YAVoHrkZMWZWU+IzzSZe++Mnku1XS0B0KiL8JLOhRz41cs4zpJn0mExTqE
 vAhiPMkVsCmK3sEzysjlrPhNZIwzRlLnERGukVZzfuQ78AWS7Dy+3U/jCLrpDPEV3ReF6bdMOj1
 Op3u1kLNO5J3kNGX4M7C45ZnePfvVUMHVzSnDz7U611xAW8aSPIunkB6L9kO/6VFwQNX1WRC19E
 q884PyTZcpQcyGfmyJzCY2gBxbHG22xkdWyDoj3/L8t0fuDYs6HKCnMsPNPY9EIusDzru3bHIJh
 anskGw4iMzlksC7D/pZGQhHdb0Pq1mcMsb6qqcwrhDuA/VL1+dqLn2iOqjzf4IincE8GnqMETJY
 Mwt0SuqTBAir9HZwjoDaCOA8oTMozKQDJ49M3poNst9r7pZYh8PZIilWPcc8N4tltbJRZzhfcJh
 20jBfR5NXp3lg1zxm9CVTEeh1p3hiuZWaSt1Krc5njvsxiq/cexFapu5ODNZdvjEsi3ehHCP3UI
 S1v+qDxUhxNXHVV3ENcpJPeSmBwYLdMM3fwtewkg6Qjkmxn6ugoDasLfPX3AmtXfExd7tFsN4Xi
 tBBBwwLynkNQuEg==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add support for the RPMh, TCSR, Global, Display and GPU clock
controllers as present on the Qualcomm SAR2130P platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (10):
      dt-bindings: clock: qcom,rpmhcc: Add SAR2130P compatible
      dt-bindings: clock: qcom: document SAR2130P Global Clock Controller
      dt-bindings: clock: qcom,sm8550-tcsr: Add SAR2130P compatible
      dt-bindings: clock: qcom,sm8550-dispcc: Add SAR2130P compatible
      clk: qcom: rcg2: add clk_rcg2_shared_floor_ops
      clk: qcom: gdsc: add separate sleep state collapse vote support
      clk: qcom: rpmh: add support for SAR2130P
      clk: qcom: add support for GCC on SAR2130P
      clk: qcom: tcsrcc-sm8550: add SAR2130P support
      clk: qcom: dispcc-sm8550: enable support for SAR2130P

Kalpak Kawadkar (2):
      clk: qcom: clk-branch: Add support for BRANCH_HALT_POLL flag
      clk: qcom: clk-branch: Add support for SREG branch ops

Konrad Dybcio (2):
      dt-bindings: clk: qcom,sm8450-gpucc: add SAR2130P compatibles
      clk: qcom: add SAR2130P GPU Clock Controller support

 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    1 +
 .../bindings/clock/qcom,sar2130p-gcc.yaml          |   65 +
 .../bindings/clock/qcom,sm8450-gpucc.yaml          |    2 +
 .../bindings/clock/qcom,sm8550-dispcc.yaml         |    1 +
 .../bindings/clock/qcom,sm8550-tcsr.yaml           |    1 +
 drivers/clk/qcom/Kconfig                           |   22 +-
 drivers/clk/qcom/Makefile                          |    2 +
 drivers/clk/qcom/clk-branch.c                      |   39 +-
 drivers/clk/qcom/clk-branch.h                      |    5 +
 drivers/clk/qcom/clk-rcg.h                         |    1 +
 drivers/clk/qcom/clk-rcg2.c                        |   48 +-
 drivers/clk/qcom/clk-rpmh.c                        |   11 +
 drivers/clk/qcom/dispcc-sm8550.c                   |   18 +-
 drivers/clk/qcom/gcc-sar2130p.c                    | 2463 ++++++++++++++++++++
 drivers/clk/qcom/gdsc.c                            |    8 +
 drivers/clk/qcom/gdsc.h                            |    2 +
 drivers/clk/qcom/gpucc-sar2130p.c                  |  507 ++++
 drivers/clk/qcom/tcsrcc-sm8550.c                   |   18 +-
 include/dt-bindings/clock/qcom,sar2130p-gcc.h      |  181 ++
 include/dt-bindings/clock/qcom,sar2130p-gpucc.h    |   33 +
 include/dt-bindings/reset/qcom,sar2130p-gpucc.h    |   14 +
 21 files changed, 3430 insertions(+), 12 deletions(-)
---
base-commit: 7df1e7189cecb6965ce672e820a5ec6cf499b65b
change-id: 20241017-sar2130p-clocks-5fbdd9bf04ee

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


