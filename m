Return-Path: <linux-kernel+bounces-437289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBD59E914D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B4816117D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28329219A7B;
	Mon,  9 Dec 2024 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w+MeWeUH"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED7E21661A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742152; cv=none; b=o47L1Kgwy+dVyaAJyHp80DlhXBG+xNPfnbmIuUn1/Lzkpijv8mwai3QzR9GOW2L9Np/ZomDkm/jeaKBzEXumP0pS+oOeIfM6r4DB38A3MIf4wqWFCVlZJhtavb7+JspJDsSzIN3rYLZ7Qi2nHVlpQhN8Kr8G7UC/8W6psdWyJR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742152; c=relaxed/simple;
	bh=IEgdroHjxv1/fUwCBSn5itHcu1a4UfbLETbiD99XN4Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FepExRUP96y+sJUm/d643WiJLeZcSxK2DbOHsIc6DAQcaQdSnlPZhSDPt9NLtK1gXZQZC5vZ9lQRz6QFtkueg8RWX8/j+/1dB6RUSdlCxBqyeOAA4Xp5VhWhfnM2B/glKWKefge6kk4jT14I7aLPpjh1YL5PcrTI0oqXO5vJMd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w+MeWeUH; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d0d6087ca3so625021a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 03:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733742148; x=1734346948; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wDBYepE70cf1Fcx/3O7JjO6/QxgauEXUIrl3j5K/sQ8=;
        b=w+MeWeUH2NZJO4WUT/OtrdQMa7qqyB8+ODj5bmn68Rty5CQ0JVXH6INqxCk0YUr1MR
         GnbDkptAgWh1SOdIXDrj58Ysi+TMmG3agThXqhFBTOfGtypx2yj18iXC/7eHlytMsHsi
         j5Obs75eV/jQASQHSbhBdaboXmAqRDE3T0Fu7s9njqiVAazeY9kMD1M8jsxKyMY5TiVm
         v5wCK2xyQt7rzbnVzfgersWp0BmLlnymmY8wdf7d8enaUUehd3NxgcFxEzMsAk7Pg+Qs
         SuHqIgEhN49eWJTy4qZ/C1oG/6Jf073s+xtaQxw0siP41aYs0A4Bz81kTOFk+2PzmC7k
         f7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733742148; x=1734346948;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDBYepE70cf1Fcx/3O7JjO6/QxgauEXUIrl3j5K/sQ8=;
        b=CmLRWaey26nWuMOa8c6U4yTXwg3gBEcaAC8Yd8rgQNFT3Tcry8A8gZxx0v1KEvZjm/
         0dZUMbvb7aqwJCPUqxVIopApvyAkwFDto/4N1aN1u84czpav3oWUtFtQuiL+LDmxFcqs
         zM/2JBs1tWoW9PSfAI8FGllnwLF1CU7dypOcbeJ1YpZdmFzjEVW+HLSZfjP8YRK/dnwA
         xcSxxGnQdOCStph/uIb29vGzf2nj/OM7MkT4TQ4RhimEQMGHEGDdFTOHWV8u1TdRRt+V
         rzWLFkKO94+o3PmA7sRKcxG1YKgKLy8KJ59YN24B42tW4pmXOsfRb/NVhYqOKg3GX1rU
         NEwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpPqadofrsVG81bPIqCEulTeNOIMhyF9PrsK1XV1RWdt4jrOdRT17FwvZ7qWDgWBjjAEzumQFGVl9Q1A8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyXNUQy63GiJ1dACn7KhD12aeqwdBWHg+4u9vGSqxShBkzrzi8
	5+uLZeqHP0ZXBatU9c+bO+C3sDpF6FxD46cyyVo+Dl6RJdSpbbUZtigIg+fmR+I=
X-Gm-Gg: ASbGncu4a9aPOSSv2oo4Kup74HTdMFD+cx0z30WBsEA5VfVujrXPQhWlor1qf9lRbry
	MiXVG0GvqEp277fM8E0+VCBircsLW4Hg+il48uEf/PggrUQFEF7MAN15LyuFrlgIp9tgJJTpjg7
	9sSxR+hjBXBKXuBvCaZ4JaS5MF1mzhh2vd/+Y1A8SuGhcpip+8sjwFwoJOK7t4ZufGN9B3FPiTz
	LmtNV5e3fWh48TofPRZOc3K0pl3qRxsDjwIHxZh8Tbk5/8djmRcPM4/uAcF21SjUg==
X-Google-Smtp-Source: AGHT+IEhSQwrYUcPJVu4awvtf0CAZIIypgbOVC3IGxdA5RSE6ZoA6mC4Wd0Bj6Jzqp1oCHZpf3m32Q==
X-Received: by 2002:a05:6402:2791:b0:5d0:8111:e958 with SMTP id 4fb4d7f45d1cf-5d3be7c4f80mr4621046a12.9.1733742147892;
        Mon, 09 Dec 2024 03:02:27 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3dd4f641bsm3348818a12.51.2024.12.09.03.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:02:27 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 00/19] arm64: dts: qcom: Fix remoteproc memory base and
 length
Date: Mon, 09 Dec 2024 12:02:05 +0100
Message-Id: <20241209-dts-qcom-cdsp-mpss-base-address-v2-0-d85a3bd5cced@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC3OVmcC/43NQQ6CMBCF4auQWTumlIrBlfcwLMZ2gCZCcYYQD
 eHuVk/g8nuL92+gLJEVLsUGwmvUmKYMeyjADzT1jDFkgzXWldbUGBbFp08j+qAzjrMq3kkZKQT
 hDOKzd6Ym35CH/DILd/H1K9za7CHqkuT9C67ld/3/ey3RoO0q17ALJ6qr6yNOJOmYpId23/cPg
 nRiis8AAAA=
X-Change-ID: 20241206-dts-qcom-cdsp-mpss-base-address-ae7c406ac9ac
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2700;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=IEgdroHjxv1/fUwCBSn5itHcu1a4UfbLETbiD99XN4Q=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnVs4wOsWMjSmmGWFeHxM+eHsRKjMqDTy5ShkSW
 btq6KnQwDCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1bOMAAKCRDBN2bmhouD
 1226D/sHv42ZR101iYFAonLKQErRTziRoF0Caqepk6uW0XVbUMHIWRICUtCFZ2KrTXCzsiL+cai
 9hY7CCwGzO1Zg/ES0uBW6QB/1MT5Y0AsRozFtkhl0qnqvDpwBzv0dVs0b/fige0tR+XtdPjKyPt
 NJUmmfI43T48DeHPit34tK5jPcZXQHdmp0FtL+h9tlXQt0P4MFwpHu/xROK7eR2qd2On4LhBK2e
 g26izWZyVHpT98PhnfdyD9Fu7m6DjvwRDbRRGQfW2O6FC9pBXgLBCCoB6G2RWsw7X9zu6j1JNu/
 th7GJw63KlnkWowWn9JgDP0YO19o83/JAJVdgv+ppOjyNeYFLjTX+HSlF85bVWOLfAPrin3k1Mj
 tdiBD6xwBOQETcgPGaDDz3I5I0oBjPzeWTv7sXrpSpCIr7Y9vKiWXUtEVm5ZBsQRQTFbFlYGI/I
 z3jZ0DGvF2TYqmYJBFX0/VW563nv8ZGorOyt6DPCZ5ztxYHD+58BJhlm580KijwutYlMrrbD/2o
 RlEn6e7hJVkHW3WP9Rtjk5ZArJA/7TpvSMV/CZrcQY1Bt7sdqodJnEuldRZKFW3qnzq/+QDUPKt
 elD7Vb6+H+ejSqQUmvQpZnV9INBJooM6ZPAGVjbXRZc8kPO1TDXErtKGeOgqe3ktE6VIE+iw9C2
 dxpI0nONBRE/ihA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Changes in v2:
- arm64: dts: qcom: x1e80100: Fix ADSP...:
  Commit msg corrections, second paragraph (Johan)
- Add tags
- Link to v1: https://lore.kernel.org/r/20241206-dts-qcom-cdsp-mpss-base-address-v1-0-2f349e4d5a63@linaro.org

Konrad pointed out during SM8750 review, that numbers are odd, so I
looked at datasheets and downstream DTS for all previous platforms.

Most numbers are odd.

Older platforms like SM8150, SM8250, SC7280, SC8180X seem fine. I could
not check few like SDX75 or SM6115, due to lack of access to datasheets.

SM8350, SM8450, SM8550 tested on hardware. Others not, but I don't
expect any failures because PAS drivers do not use the address space.
Which also explains why odd numbers did not result in any failures.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (19):
      arm64: dts: qcom: sm8350: Fix ADSP memory base and length
      arm64: dts: qcom: sm8350: Fix CDSP memory base and length
      arm64: dts: qcom: sm8350: Fix MPSS memory length
      arm64: dts: qcom: sm8450: Fix ADSP memory base and length
      arm64: dts: qcom: sm8450: Fix CDSP memory length
      arm64: dts: qcom: sm8450: Fix MPSS memory length
      arm64: dts: qcom: sm8550: Fix ADSP memory base and length
      arm64: dts: qcom: sm8550: Fix CDSP memory length
      arm64: dts: qcom: sm8550: Fix MPSS memory length
      [RFT] arm64: dts: qcom: sm8650: Fix ADSP memory base and length
      [RFT] arm64: dts: qcom: sm8650: Fix CDSP memory length
      [RFT] arm64: dts: qcom: sm8650: Fix MPSS memory length
      arm64: dts: qcom: x1e80100: Fix ADSP memory base and length
      arm64: dts: qcom: x1e80100: Fix CDSP memory length
      arm64: dts: qcom: sm6350: Fix ADSP memory length
      arm64: dts: qcom: sm6350: Fix MPSS memory length
      [RFT] arm64: dts: qcom: sm6375: Fix ADSP memory length
      [RFT] arm64: dts: qcom: sm6375: Fix CDSP memory base and length
      [RFT] arm64: dts: qcom: sm6375: Fix MPSS memory base and length

 arch/arm64/boot/dts/qcom/sm6350.dtsi   |   4 +-
 arch/arm64/boot/dts/qcom/sm6375.dtsi   |  10 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi   | 492 ++++++++++++++++-----------------
 arch/arm64/boot/dts/qcom/sm8450.dtsi   | 216 +++++++--------
 arch/arm64/boot/dts/qcom/sm8550.dtsi   | 266 +++++++++---------
 arch/arm64/boot/dts/qcom/sm8650.dtsi   | 300 ++++++++++----------
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 276 +++++++++---------
 7 files changed, 782 insertions(+), 782 deletions(-)
---
base-commit: c245a7a79602ccbee780c004c1e4abcda66aec32
change-id: 20241206-dts-qcom-cdsp-mpss-base-address-ae7c406ac9ac

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


