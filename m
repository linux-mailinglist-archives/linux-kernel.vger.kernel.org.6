Return-Path: <linux-kernel+bounces-424842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A67629DBA21
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B5E1647D7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A188819D06A;
	Thu, 28 Nov 2024 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MgMQRqBT"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5921E1A9B2F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732806499; cv=none; b=RHIwxlu8WUQPRD80z/+JLRTNX1IQy9V4gL1W/kwNNH+b6h85JGdY9j7fLyxG7r9XwV6dI49iyLaX6wLGl1gnVugUs0QpuI/iv+hbAW/vyKLE8fIsxSY2c24wy1rnrOH42xQaDV7F0yoEq1Kcf2mtcI1yA3tm2OFQEB40FOE5lr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732806499; c=relaxed/simple;
	bh=CZ6F7nqLC3Ppmtpbab+Dy2ETBIdeM8z83VBVqimbS5E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=baNg1czQHOCBIuzIKXzk6Y0iyJgDA/IH1zoZTlgPJQTbdNHW8b33/2pPpKL70gqk23LSpHyhtzNCpSyRjS4UctslCq96ZOLSRq2I6EZS62eMniHddKv2/7Yolf/UcT7FrPBt5s6f0O4n08yrfbq6wgXHMpTCdnTs/LqBO1+UXUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MgMQRqBT; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385db79aafbso1978f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 07:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732806496; x=1733411296; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cnZyDPBfm5l/EP/tG0UaARM56VhvQaqB17GitPL9u0g=;
        b=MgMQRqBTbHSnHz65CvrOxC1k9K7aIo0JNJK6et8xrxP9/sToDe+w8rXRzc246Z12AA
         g0uyvHcESA7WlGUTqGvmIH4ZTq+/oDJv90n3CRdZPjcy7FTvF6XazJKPMM2FpntqOqrV
         VJ4UIA4uL2h1ElaW6BeIOEYROu3wkJYiSgHKamfmrEFoeSe+NJMZLHbAkF/I9K2lgqfl
         1U24Ic2aVnc14XOHae7rbmv3Dij4PYcJ0N49KmUuBa6fMVwZPbAUTUT3iBph/xJfgNhv
         BtjCV7iHb8lEva/i7Onp72Z1gVerC80Lnf8X31luYGOt9CK+2CvvRiRxAPXrvZ47238f
         7Rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732806496; x=1733411296;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnZyDPBfm5l/EP/tG0UaARM56VhvQaqB17GitPL9u0g=;
        b=T8ARZyv/WF2Qz6vsroEmevamQ20LQXuzMp2GXiAQXMNtYWiBsvQpgxszkYi/Qv3vlT
         UtOKjFxBKTzUa6BMcCZERGMf2napx8o1RH1gfWN56LNWgxRoC0xFcdPMJ2Y/GbCBLe/I
         GVbvG0/WpH0uhzhN/zU18ubVQHG5UalgXwedjgI6UNMejL4nQLr0VK79beUnJSIsmkoa
         FvUl6C5Yu6shwNm9lkn17KU3MCj0XwTz76sB4pXkvfFiBd0rpsk26J6SdUQwtsp00JJB
         iD1nK7XrAmYF5HQ9MAKc1B3t6XB/BnorwU/WYD+m+dt7bpDmBQ7oi2gLGwFjq/Io/r35
         xqOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvtghUCTiSTJgTBMLGTPJhWxM87mVCUf/5ruTvhsmwBQ91hsHVCAAqVKsM/V+G0F3hRxznDrjKadhBHx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNgw4I2gwIaTOyeS9PY6n+S5wtOwyUhIkxE1qQe0EO+CS9bBdw
	3jFqwXPCVciOEk44GseuHrZkKwn30WtpqjnO+Iid+ITgzq8oPR+Skds95Ud4tAs=
X-Gm-Gg: ASbGncvqDJ4fpsCd8Ftw/0NNhhHyvLXF2AueI9Kwv+uLWGCvMgp9p8gsIvi/RvnZZy5
	NmWA6GVrj2NeK5e7OyK5ET/6DTCdK1K/7DDOnQ6bB/6TyHkW/UYqGmpEqpZ0s6gMUmpSiSgv08+
	Y+6pnpz3hAd1872gOzYQ4W/cmMAWbWuKqUEN1SzHcHkUSrbmHidU59cjshCCXGhq4nwim2XEzEP
	pLMM5sTUzvMiG0l50iKM8rrgbo58FF/4W2VIvyewsV+UTNSs2issXWuoqjRlB2A
X-Google-Smtp-Source: AGHT+IH0F/SgQRnJQccJB15pgwsxTAk2sPvb84dHeuiTIlcEPKTfPH4i0ZSHzGkFw4IcGv6Ldbkl8g==
X-Received: by 2002:a05:6000:154c:b0:382:4e71:1a0f with SMTP id ffacd0b85a97d-385c6ebb203mr2554289f8f.7.1732806488992;
        Thu, 28 Nov 2024 07:08:08 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd7fc33sm1828291f8f.94.2024.11.28.07.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 07:08:08 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/3] clk: qcom: sm8750: Add sm8750-dispcc clock controller
Date: Thu, 28 Nov 2024 16:07:58 +0100
Message-Id: <20241128-sm8750-dispcc-v1-0-120705a4015c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE6HSGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyNT3eJcC3NTA92UzOKC5GTdNIO0RPMkM5O0xOQUJaCegqLUtMwKsHn
 RsbW1AKJmVCBfAAAA
X-Change-ID: 20241125-sm8750-dispcc-f0fa7b64facd
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1154;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=CZ6F7nqLC3Ppmtpbab+Dy2ETBIdeM8z83VBVqimbS5E=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnSIdR1orKpaaLqfpdyBOkxr/V/WxoTayfM2sPp
 FMQjutqeFKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ0iHUQAKCRDBN2bmhouD
 100sD/9VJ9Hrx0e5+jwp0shsOpC/+TmO86/seL3ejD5yWFsqb//gmsyi4fLxC2LkJp4HAN9EZvX
 9/iUtWUprPEWrbrUbv3hRiX/cuyfAYEDJrQ9zHFnIzt30iHohqccwluldTaaVOXJ+TXTveSFSyW
 P8Hf1cQxY6C1h7TtynYkA+w0dn6FrD/tgMf8vtoOfO5+BvWtyMeL2CoHp3Yeu+kjQECKelSWY8d
 yZxOUdcbtP1+mu9rIXPwjZWaC3nWMfh7k4Ii5O5oE/w1WnO28cGujvXeIlXeJLKcPzi7qITQw2c
 soNaLUHRvp3SaFAL07KaUVNCAA0JhMEX5FjIQl1vhnnPfpTB/+ArjtD2VFshszRD6hHdp1JwFu4
 G2C6xNIa36CSmi5/X/NoP3Qc/VukKzAgY72n8j5zVMObLNMTzIycurTMJrRYfO19nX+BqsACOwS
 1oo0V/AXN1u1E/toICMcY3rHP7TlI+0Aoevyzvmu+8M4vx+deTkoI3mf0qkZ0QxcGnzqh87r1wm
 ra65O75WRh2pOYBMfXDA2Xh2o4l5QDe4Sv3FBCJJdouaqlR5pCK0zXb/qmcICNAn3xuNhMhX1Dv
 s+e2faQgqAfoARaEIOt2S4tGcznL7cSNO1DxmDqRgB8CheNDk9ZFfODYLSa5ICM51IoNvhlcZKV
 xGuGv+BUlybTkog==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add Display clock controller for SM8750.

Dependency:
1. Taycan PLL and rest of clocks: "clks: qcom: Introduce clks for
   SM8750"
   https://lore.kernel.org/r/20241112002807.2804021-4-quic_molvera@quicinc.com

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      dt-bindings: clock: qcom,sm8550-dispcc: Add SM8750 DISPCC
      clk: qcom: clk-alpha-pll: Add Pongo PLL
      clk: qcom: dispcc-sm8750: Add SM8750 Display clock controller

 .../bindings/clock/qcom,sm8550-dispcc.yaml         |    4 +-
 drivers/clk/qcom/Kconfig                           |   10 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/clk-alpha-pll.c                   |  159 +-
 drivers/clk/qcom/clk-alpha-pll.h                   |    6 +
 drivers/clk/qcom/dispcc-sm8750.c                   | 1960 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,sm8750-dispcc.h     |  112 ++
 7 files changed, 2249 insertions(+), 3 deletions(-)
---
base-commit: 7ef660da3b85122a66ede26d65ec33f65981d378
change-id: 20241125-sm8750-dispcc-f0fa7b64facd

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


