Return-Path: <linux-kernel+bounces-175725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE9B8C2417
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6011F22BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA3E16F0E5;
	Fri, 10 May 2024 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vxo4URid"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8185E85C77
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342377; cv=none; b=N6/mCyi+iLtpp4G572Mr/Aszx4nDEOBiSR1xHClA2BOS3/GJrVnj7LrdnB2iDQkgbCi/fU0J8qTFnuxi9qWtyN/eN2LOiOT+8asxx8KwXQ2ZERD3TTvDSy9crMBfrWsAWf097QQ2YYn/MjVk8DrWr7DabpRsyjowQwbIS+R3nmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342377; c=relaxed/simple;
	bh=C2Xbh2lIsR2clKsY4vga0Blv+JwrY6XyqaQNjqovfr4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jpK7X2x5j54OPna0LLcChIdFRReYuNw23ncE4bz1ZKfaupGiZlRTqKg2wlwL2ak1+1X7IdWbuB8bacH2BTp+iiXu9GrJBd7LNRK46n5RPDFCfePGp76v3RXQckgMzXl/XhCwZOgul+fCArKo+fLsz43ZWHjJFHDkKRxg8vTD2CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vxo4URid; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5a1192c664so512615366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 04:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715342374; x=1715947174; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uuQTsZaynSFa8uxr+cQxoFpoXnPzfIzMO/Y0dG8vq1g=;
        b=vxo4URid+76BmfCnYF6Kji0E6GWPlikaoLlqeHsbe6xqoXf6L2b7x3iKjqVzAlvq5t
         Tjv3cKd0rBke7zaCsc7uxRchdE/XoI4sZgjPxa3ajgVnD25m+JTAW2kzVmdUGTpybZnJ
         7MC0K8V7CGhsrCvQLUQq/VNO5+2g5ZOTTRBwbB2XfMo90C+CHDWzWfiR21sIsF9DcWvQ
         ZmaDKosZkjispJ/gVAS/K9axfBvjkRWY8vvTUSfI+RXMXFVC1fzA9lk0y3kx//cB/9Tq
         IAo3JNXXGRm2Kyu047FtMNuIlr/YbEIgBYNEW1LeU4srx0iqVnJQ46qDigfW/b9qQCSV
         fs8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715342374; x=1715947174;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuQTsZaynSFa8uxr+cQxoFpoXnPzfIzMO/Y0dG8vq1g=;
        b=b22JMATcizuBgUSA2JUObovGInRcn4QUMyx+0zmDNvBns5KfAE1e8RH8TFf7b5MvcG
         3lOJU6U5qFPGr1M3kZpckQn6ZjD1N/zUFQJ6KP12emsYaVP3GM7EkSTT7i9YcPI0eYyM
         1iKm4YK9Ka1ek+lZjnREKsexjBQmjH7ksBqOytu8lXCyH6r3/+WNLVtAyzeAOAm1R7uY
         YWsQjGBRgv+jQTr09G92tgiKhgXbdDKHt100kEkDwvMU68Ls8sGN7wPrKkRG+9d7Qpl0
         0GMtOk8UmkhUWW3hpK2BQxHutfQHTtEgqWqCE4mxhyBg/2Vn9zS4Qk8IneMdccl9mR2Z
         NGlw==
X-Forwarded-Encrypted: i=1; AJvYcCXQz82iA6LlkIW5lXGbEUhodnSHfL/BiZF6qNHp4ktlRJggwGOaz/iIU3/j3yihLJ0DStCeNRRHqV18+HJhFD8lwfPKUqFtwrr7XFKa
X-Gm-Message-State: AOJu0YzlNsLsApyv7c2vNA5gxsUhFzaW9In/Fri4o2tb1ca2MOijNVbV
	TaIAt/f3MCHtlDyX9gcTiDsltY14WS/o0Py5RTx4CmzUpwkNA3ACfSqRLxByO/M=
X-Google-Smtp-Source: AGHT+IFrj7hG6cUlkjPWPD5Qrs1k6c5xpex/xTzRHmH109egAyRSVyK5cdM7qq3XUJgYsvFqiaE+9Q==
X-Received: by 2002:a17:907:3601:b0:a52:6159:5064 with SMTP id a640c23a62f3a-a5a2d65ecffmr277664866b.52.1715342373756;
        Fri, 10 May 2024 04:59:33 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7df7sm176795666b.111.2024.05.10.04.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:59:33 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 00/31] Clean up thermal zone polling-delay
Date: Fri, 10 May 2024 13:59:23 +0200
Message-Id: <20240510-topic-msm-polling-cleanup-v2-0-436ca4218da2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACAMPmYC/42NQQ6CMBBFr0Jm7Zi2GkBX3MOwKGUsk0DbtNhoC
 He3cgKX7//89zdIFJkS3KsNImVO7F0BdarATNpZQh4LgxLqKi7yhqsPbHBJCwY/z+wsmpm0ewV
 Utax1O5ChRkDZh0hPfh/uR1944rT6+Dmusvyl/1izRIEkNJEcBzM2bVdqHf3ZRwv9vu9f2bJd1
 MMAAAA=
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14-dev

A trivial follow-up on the changes introduced in Commit 488164006a28
("thermal/of: Assume polling-delay(-passive) 0 when absent").

Should probably wait until v6.9-rc1 so that the patch in question is
in the base tree, otherwise TZs will fail to register.

FWIW, Compile-tested only (except 8280).

To: Bjorn Andersson <andersson@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: cros-qcom-dts-watchers@chromium.org
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Changes in v2:
- Un-drop passive delays. Whether they're useful where they're enabled
  is a topic for another patchset, as it requires examination on a case-
  -by-case basis.
- Better unify the style (newlines between properties)
- Link to v1: https://lore.kernel.org/r/20240319-topic-msm-polling-cleanup-v1-0-e0aee1dbcd78@linaro.org

---
Konrad Dybcio (31):
      arm64: dts: qcom: ipq6018-*: Remove thermal zone polling delays
      arm64: dts: qcom: ipq8074-*: Remove thermal zone polling delays
      arm64: dts: qcom: ipq9574-*: Remove thermal zone polling delays
      arm64: dts: qcom: msm8916-*: Remove thermal zone polling delays
      arm64: dts: qcom: msm8939-*: Remove thermal zone polling delays
      arm64: dts: qcom: msm8953-*: Remove thermal zone polling delays
      arm64: dts: qcom: msm8976-*: Remove thermal zone polling delays
      arm64: dts: qcom: msm8996-*: Remove thermal zone polling delays
      arm64: dts: qcom: msm8998-*: Remove thermal zone polling delays
      arm64: dts: qcom: pm7550ba: Remove thermal zone polling delays
      arm64: dts: qcom: pms405: Remove thermal zone polling delays
      arm64: dts: qcom: pmx75: Remove thermal zone polling delays
      arm64: dts: qcom: qcm2290-*: Remove thermal zone polling delays
      arm64: dts: qcom: qcs404-*: Remove thermal zone polling delays
      arm64: dts: qcom: sa8775p-*: Remove thermal zone polling delays
      arm64: dts: qcom: sc7180-*: Remove thermal zone polling delays
      arm64: dts: qcom: sc7280-*: Remove thermal zone polling delays
      arm64: dts: qcom: sc8180x-*: Remove thermal zone polling delays
      arm64: dts: qcom: sc8280xp-*: Remove thermal zone polling delays
      arm64: dts: qcom: sdm660-*: Remove thermal zone polling delays
      arm64: dts: qcom: sdm845-*: Remove thermal zone polling delays
      arm64: dts: qcom: sm6115-*: Remove thermal zone polling delays
      arm64: dts: qcom: sm6125-*: Remove thermal zone polling delays
      arm64: dts: qcom: sm6350-*: Remove thermal zone polling delays
      arm64: dts: qcom: sm6375-*: Remove thermal zone polling delays
      arm64: dts: qcom: sm8150-*: Remove thermal zone polling delays
      arm64: dts: qcom: sm8250-*: Remove thermal zone polling delays
      arm64: dts: qcom: sm8350-*: Remove thermal zone polling delays
      arm64: dts: qcom: sm8450-*: Remove thermal zone polling delays
      arm64: dts: qcom: sm8550-*: Remove thermal zone polling delays
      arm64: dts: qcom: sm8650-*: Remove thermal zone polling delays

 arch/arm64/boot/dts/qcom/ipq6018.dtsi              |  6 --
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              | 12 ---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi              | 26 -------
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  5 --
 arch/arm64/boot/dts/qcom/msm8939.dtsi              |  9 ---
 arch/arm64/boot/dts/qcom/msm8953.dtsi              | 17 ++---
 arch/arm64/boot/dts/qcom/msm8976.dtsi              | 18 ++---
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 14 ----
 arch/arm64/boot/dts/qcom/msm8998.dtsi              | 19 -----
 arch/arm64/boot/dts/qcom/pm6125.dtsi               |  1 -
 arch/arm64/boot/dts/qcom/pm6150.dtsi               |  2 +-
 arch/arm64/boot/dts/qcom/pm6150l.dtsi              |  3 -
 arch/arm64/boot/dts/qcom/pm6350.dtsi               |  1 -
 arch/arm64/boot/dts/qcom/pm660.dtsi                |  1 -
 arch/arm64/boot/dts/qcom/pm660l.dtsi               |  1 -
 arch/arm64/boot/dts/qcom/pm7250b.dtsi              |  1 -
 arch/arm64/boot/dts/qcom/pm7325.dtsi               |  2 +-
 arch/arm64/boot/dts/qcom/pm7550ba.dtsi             |  1 -
 arch/arm64/boot/dts/qcom/pm8010.dtsi               |  2 -
 arch/arm64/boot/dts/qcom/pm8150.dtsi               |  1 -
 arch/arm64/boot/dts/qcom/pm8150b.dtsi              |  1 -
 arch/arm64/boot/dts/qcom/pm8150l.dtsi              |  1 -
 arch/arm64/boot/dts/qcom/pm8350.dtsi               |  2 +-
 arch/arm64/boot/dts/qcom/pm8350b.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/pm8350c.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/pm8450.dtsi               |  1 -
 arch/arm64/boot/dts/qcom/pm8550.dtsi               |  1 -
 arch/arm64/boot/dts/qcom/pm8550b.dtsi              |  1 -
 arch/arm64/boot/dts/qcom/pm8550ve.dtsi             |  1 -
 arch/arm64/boot/dts/qcom/pm8550vs.dtsi             |  4 -
 arch/arm64/boot/dts/qcom/pm8953.dtsi               |  3 -
 arch/arm64/boot/dts/qcom/pm8994.dtsi               |  1 -
 arch/arm64/boot/dts/qcom/pm8998.dtsi               |  1 -
 arch/arm64/boot/dts/qcom/pmi632.dtsi               |  1 -
 arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi          |  1 -
 arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi          |  1 -
 arch/arm64/boot/dts/qcom/pmr735a.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/pmr735b.dtsi              |  2 +-
 arch/arm64/boot/dts/qcom/pmr735d_a.dtsi            |  1 -
 arch/arm64/boot/dts/qcom/pmr735d_b.dtsi            |  1 -
 arch/arm64/boot/dts/qcom/pms405.dtsi               |  1 -
 arch/arm64/boot/dts/qcom/pmx75.dtsi                |  1 -
 arch/arm64/boot/dts/qcom/qcm2290.dtsi              | 30 --------
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 14 ++--
 arch/arm64/boot/dts/qcom/qcs404.dtsi               | 10 ---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts           | 10 ---
 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi        |  8 +-
 arch/arm64/boot/dts/qcom/sa8775p.dtsi              | 82 --------------------
 .../arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi |  1 -
 .../boot/dts/qcom/sc7180-trogdor-homestar.dtsi     |  1 -
 .../arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi |  3 -
 .../boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi  |  1 -
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi       |  3 -
 arch/arm64/boot/dts/qcom/sc7180.dtsi               | 25 ------
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 45 -----------
 arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi        |  2 -
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              | 26 -------
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     |  2 +-
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi       |  4 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             | 13 ----
 arch/arm64/boot/dts/qcom/sdm630.dtsi               |  9 ---
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts            | 12 ---
 arch/arm64/boot/dts/qcom/sdm845.dtsi               | 21 ------
 arch/arm64/boot/dts/qcom/sm6115.dtsi               | 32 --------
 .../dts/qcom/sm6125-sony-xperia-seine-pdx201.dts   |  8 --
 .../boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts  |  6 --
 arch/arm64/boot/dts/qcom/sm6350.dtsi               | 81 --------------------
 arch/arm64/boot/dts/qcom/sm6375.dtsi               | 78 -------------------
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts  |  4 -
 arch/arm64/boot/dts/qcom/sm8150.dtsi               | 28 -------
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts            | 14 ----
 arch/arm64/boot/dts/qcom/sm8250.dtsi               | 25 ------
 arch/arm64/boot/dts/qcom/sm8350.dtsi               | 29 -------
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts            | 16 ++--
 arch/arm64/boot/dts/qcom/sm8450.dtsi               | 64 ++--------------
 arch/arm64/boot/dts/qcom/sm8550.dtsi               | 82 ++++----------------
 arch/arm64/boot/dts/qcom/sm8650.dtsi               | 88 ++++------------------
 77 files changed, 78 insertions(+), 973 deletions(-)
---
base-commit: 704ba27ac55579704ba1289392448b0c66b56258
change-id: 20240319-topic-msm-polling-cleanup-2616a8bece70

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


