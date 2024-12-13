Return-Path: <linux-kernel+bounces-445000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 637979F0FB1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207BD283648
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0951A1E1A33;
	Fri, 13 Dec 2024 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j93QFN7I"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EC61E1A3F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101666; cv=none; b=mFoPbhNTZakp31/ruxl7G0C0Gq0mH/MtW87PmgkBFcsTJgC4iwVr7pEdFtWHh6W5o1rF61gcNo1EDXdgmq9WBOhcP18aZ5SfrD6HRGfhwY+nZWDI0KLovjeaW5IjZ35G4v460mlfRa2EbD6ht6AmeHQ4/Cj50+VcLjaFTUIpxX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101666; c=relaxed/simple;
	bh=ol9EoljmJly7dAFajmboRG0xeJPOxqAKNyPayhuKeFk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ctt2mEWDFT6vizEhhejrDjw03PzS0qyYpD+2qrK2U9SZk4D5vSRB/93MQY14k3EfCQRQtH9W/tHsqfDhw+KoxSRtnuDqVn/iHyfDhdKfBmZSLHDiy5h3EiA3gJ/fRTZgyjdmvN0Ih3Q/bX7trMqKNDyXQj0UQxuvAXhhojmIweg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j93QFN7I; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434f1e5e77dso1473915e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734101663; x=1734706463; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CVdvYvDpLs71QHH7bZcej5Vn26F9QrVKVYq7HujK4wM=;
        b=j93QFN7Iw7sWV6NpklUp4b6H4iA8EVo9UWtA8MDtmEXKpusW6fJdSNRBbq0BpS/4Nj
         MVUsIFREeiWYbII2esRv+oFMOlZVfdaKT/vTPUTX/QnCUHKjHlMbyDuKWc6/uC5jOQ0v
         Y9KkdNs53CbYVK3m3WGsYXbtwU82dnDwe6lGLMq+e8KVOqRfoMsgij/Wx7ubmgL+FSf7
         EZ+4Wv9Y6aBDkwEBbUwBaB1A9kVxtaIk0BowVXFSowpklZRza3ceJVnUESk2UZWYZYGu
         ppm3yypylorCaDSpPjiWuxruCRKqze0Srv7o0ptoTTBBCzujltsDKzZe1gfdhn0VdCse
         Apfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101663; x=1734706463;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CVdvYvDpLs71QHH7bZcej5Vn26F9QrVKVYq7HujK4wM=;
        b=gSvVrarQRfe62aeZJP1JUpNNscK3UzlgRUshfd+j1HpNUNxvK07ILUcoXJpoVy6iP8
         ckHWXG7BgIgfxh7zLHXHI0DQ9MWFHApkMOR8vC1B8iKgPL0IfzNOYCqQNdLCnndkR7hF
         iln8GjlfiBsuDi3zVGkiiJmA72udTnC6o8y9DR9xujGO573wrNEPZXYEGXJTR6+IWpXq
         Xm58e2fdHVbKByqZ8wb4ngvsolfId+UpxQhSWPxHk/NkYJJqEngH2e3ws/gISjrj995y
         MPHpLK6Ov0HnzQI4RNYi3bEerqbIND4/2ID7sKXskMal3IrtTvBzyMc3pHN3WOwO4z78
         r8Bg==
X-Forwarded-Encrypted: i=1; AJvYcCULwxgtXtsS5TH23S5HiJulc84+8F0ruuBTZdPILpUT/QTAqCqNTToJoK75KzJhQcAuu83a+RBTAepRLDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YydnPANcwriO4R3Vv08wiZBcraXtfeJfeO0+5SLLg4kBZmFmB2n
	Ua3OJugI+6JOCu599Y9+kHaiIhu4PLmLvprd/8c8oRxT+puqo+8kKk8wPzz8uKY=
X-Gm-Gg: ASbGncsSWD+IpazaNqDj+f5dN2GQFclv5lkKuKLcOYpLqwWyQ3PfvhWOCGZ1UkYOIQF
	uexv9Z3S83/6V3hyEyqhsC030MR7McvpIOtNU1orXW8ioBPDyDUn3E9hcxgj65n72CykIGjopg9
	r+Aj+GR8g/2ktQQOsIef79J87BI1RFwOuWySne70lfgGJR+lYMNd9v8UkozVxrLJdq/H7uGTUsg
	LNH8yhtMLrV32NEieIsUHpj9q0VO8TjO33mD0umxsKodoi72t1rwZHinVR/r+16M/YfemBA
X-Google-Smtp-Source: AGHT+IEFAxcRq/PEXqUWHJslMmJj6lZEnIJUSq+7/uopt2OPEhKjrLyAWh/zLrx5IdfcXIjCY5/22Q==
X-Received: by 2002:a05:600c:4f86:b0:432:dc5a:b301 with SMTP id 5b1f17b1804b1-4362aaa980emr9636385e9.8.1734101662133;
        Fri, 13 Dec 2024 06:54:22 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436256b42c8sm51547305e9.29.2024.12.13.06.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:54:21 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 00/23] arm64: dts: qcom: Fix remoteproc memory base and
 length
Date: Fri, 13 Dec 2024 15:53:49 +0100
Message-Id: <20241213-dts-qcom-cdsp-mpss-base-address-v3-0-2e0036fccd8d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH1KXGcC/43NQQ6CMBCF4auQrh0DpaC48h7GxdAZoIlS7BCiI
 dzdwkpXuvzf4nuzEg6ORZ2SWQWenDjfx8h3ibId9i2Do9hKp9pkOi2BRoGH9XewJAPcBxGoURi
 QKHAM5IM1aYm2QquiMgRu3HN7uFxjd05GH17b4ZSt6//2lEEKuslNxYYKLPPzzfUY/N6HVq34p
 D/B6jeoI0jHAvOaCmuZvsBlWd5oCE2sIAEAAA==
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
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3216;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ol9EoljmJly7dAFajmboRG0xeJPOxqAKNyPayhuKeFk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnXEqDAqUsEc1k/XCZtSsb9mCpefodNbwBnkXvA
 5ISbAJzXNaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1xKgwAKCRDBN2bmhouD
 16MGEACPjl1EU91CefBEZ0GwgPgTbkmcbLUSZFl2TBmeVwoITf2Ryt3fswc+FdXBTFippkfUSRY
 +XxJxSCfRDByMU07QOZfcrDYmFmhVmmVmwmheopPUgmaGrHVfsUzUCYVswpCiXHYgBSuW588XOO
 1NK6iN3osNhHYzzKPdV+OVepLT1skBKg5nsHEwTtpzp9vkXMl8vtrrqnXg/rfUBOHFRLD7N4s0c
 54qUw05S2ibQNA7qxNr+ck45YMLk/yw0x44IzE3EEZ+cU0ZlMK0cCWZEoluF5xxCXQyxygOD0SE
 vaAiDkFla2jjHKaawaSpOonaPV/ehdPnTxKmMt7Bb8MvGsdTh0pmUdycvLP+7FQmZG+Eiz46IM/
 vsFrvy2+yxvGTkqtl0ViE7ZDgR6Wr4HCwy6um7dZHPpktvg9d+SzJuMmaOMbzQOWvA07S/T/8Iw
 /iNg4jpv7zYvZqces/5k4uqOrmZ36B4df1UErT7BdpsLalYPMqY/MmO0eYvJw65lNMnEI7Vbhk/
 H1Hp60vvzNuqi2sc0Qxd/rakeSU2GZXtVyzrjR85tEa16IHucsGV/oz6stAQIQnWlpPkOFnv2MJ
 AHVVgpzG3xZKtF2M7dtCOysaZDEWRo7jvuN6Zl2aDZeRx/dXdSAkYjWjjkR0c3jXv3easTRnhVZ
 ovcXRhNmoXL+yJg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Changes in v3:
- Add Rb tags
- Add four new patches (at the end) for sdx75 and sm6115
- Link to v2: https://lore.kernel.org/r/20241209-dts-qcom-cdsp-mpss-base-address-v2-0-d85a3bd5cced@linaro.org

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
Krzysztof Kozlowski (23):
      arm64: dts: qcom: sm8350: Fix ADSP memory base and length
      arm64: dts: qcom: sm8350: Fix CDSP memory base and length
      arm64: dts: qcom: sm8350: Fix MPSS memory length
      arm64: dts: qcom: sm8450: Fix ADSP memory base and length
      arm64: dts: qcom: sm8450: Fix CDSP memory length
      arm64: dts: qcom: sm8450: Fix MPSS memory length
      arm64: dts: qcom: sm8550: Fix ADSP memory base and length
      arm64: dts: qcom: sm8550: Fix CDSP memory length
      arm64: dts: qcom: sm8550: Fix MPSS memory length
      arm64: dts: qcom: sm8650: Fix ADSP memory base and length
      arm64: dts: qcom: sm8650: Fix CDSP memory length
      arm64: dts: qcom: sm8650: Fix MPSS memory length
      arm64: dts: qcom: x1e80100: Fix ADSP memory base and length
      arm64: dts: qcom: x1e80100: Fix CDSP memory length
      arm64: dts: qcom: sm6350: Fix ADSP memory length
      arm64: dts: qcom: sm6350: Fix MPSS memory length
      [RFT] arm64: dts: qcom: sm6375: Fix ADSP memory length
      [RFT] arm64: dts: qcom: sm6375: Fix CDSP memory base and length
      [RFT] arm64: dts: qcom: sm6375: Fix MPSS memory base and length
      arm64: dts: qcom: sdx75: Fix MPSS memory length
      arm64: dts: qcom: sm6115: Fix MPSS memory length
      arm64: dts: qcom: sm6115: Fix CDSP memory length
      arm64: dts: qcom: sm6115: Fix ADSP memory base and length

 arch/arm64/boot/dts/qcom/sdx75.dtsi    |   2 +-
 arch/arm64/boot/dts/qcom/sm6115.dtsi   |   8 +-
 arch/arm64/boot/dts/qcom/sm6350.dtsi   |   4 +-
 arch/arm64/boot/dts/qcom/sm6375.dtsi   |  10 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi   | 492 ++++++++++++++++-----------------
 arch/arm64/boot/dts/qcom/sm8450.dtsi   | 216 +++++++--------
 arch/arm64/boot/dts/qcom/sm8550.dtsi   | 266 +++++++++---------
 arch/arm64/boot/dts/qcom/sm8650.dtsi   | 300 ++++++++++----------
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 276 +++++++++---------
 9 files changed, 787 insertions(+), 787 deletions(-)
---
base-commit: c245a7a79602ccbee780c004c1e4abcda66aec32
change-id: 20241206-dts-qcom-cdsp-mpss-base-address-ae7c406ac9ac

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


