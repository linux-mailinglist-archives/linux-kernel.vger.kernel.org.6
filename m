Return-Path: <linux-kernel+bounces-426030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374DB9DEE05
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77031B21973
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77EA7080B;
	Sat, 30 Nov 2024 01:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G3U7rSah"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB94A2FC52
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931072; cv=none; b=M+NDg3fhExG+aqsebkurv4miqGflhRIcBmq24gU4R42nDH/DeBuo5nO6Ohm2GgIGA3Nhe5Z5PrvZ7vqycztlec85EoH0dC1W2U3s3lmfGUqb0RVlJwLT5dLWhkHsdquVZnaCsduX+wnrg75FB0xULy3ssYDrsiYx21yZcf4Nrvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931072; c=relaxed/simple;
	bh=WFPW8bCZyiKGR4Ml5aZ2UV4BHVPkl0kdGXveRWG/O00=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hA4kXPB2HZsceNlRvMpzdzFFVZuDCdNqv5F7gD/K5c8kZKAd1APMNjhKFVdtT3Y1864iROX4aZfkwrjRF7dCxx746P7qFNmr1TeptVvqoAN7UV0QyC0rKGQPWVADM71i0kFMIeYxxsAd+IJBs72QwHcQdTLkEaqjX6vlNALOrMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G3U7rSah; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53de8ecafeeso2738351e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931067; x=1733535867; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8AlCCDwioPY4kzkqiPxQqN+j6ll5lKNUBZHzZ19bRQE=;
        b=G3U7rSah8Y+kOXE2hzhVGZGBmdrXPRgvIesyUD9qn9e5J6gkNpj1qF9QKTRQlF7AaU
         fhDPXKVePI05NJVr5bnaDPJ0jG6nidta6ro9GpAlL5G7rCdTEM+bKkUqMN2I1Q2I4qGd
         n9Uamj2zE9jVxZUYXaspMtMzbbZA0/FhO8JbCp3ilJRYtsx5K9ozHi0h+d3RfAk+EFRY
         pFfIL0jvLOX0lrqmZKpbrq1/qBZvvSEB+YRdJmnUK/W7REgjYLZlQSVvWhHh2ZFo8mVW
         huHEwv9bGMMuGEGKvLfJPTWFKnhpz9/rZhUgPw8jet/CzAXIYGYS+YNvoxyGxvyALX63
         5s4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931067; x=1733535867;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8AlCCDwioPY4kzkqiPxQqN+j6ll5lKNUBZHzZ19bRQE=;
        b=U3Khc0vwu2PnWqsnPytawcHYaELSPI3E+ThVxAJupCIqS/OqEpJzKyqAZ5RpdNfZdW
         azhZIRwZUEMj0xUcU69J/DcDOz7WzJUhFj57XnlpZWcv0rQC7COTi3k8m0ch0g1G5g0Z
         zd0SFZ1xMn0W63VLrfibEWs+EnMNUf0RkoY5i0NPffDhZiAXgr8yU37T9ypvwYn2zBZf
         9k97VPpRBlXaRwjovvUhVq3dvaZCTb99KBZSqVdUoLc/BLT5p0MIW0gliYSOS0jWbp71
         xj7wyNIATzvEnjBLmkzkdrWDVtbRl/i6mbVjeGpiyUHKW9pj6RNCcLIhggehh1duv7FE
         qhwg==
X-Forwarded-Encrypted: i=1; AJvYcCWJD8+TbQLxsMErIzz3g4uL6LBdeW/KtJrt5sSLcGmjGGeD5OfJ4GUKjIxRUpdLz9KlNIxR/hf97kuhUEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp0cClBrZb3flGoNb451qf1j7GicqPoTmIadmnpfowsDjmbiu8
	YJm3DNPykbXEFwZkfv/D2zTB0vYfIP/QkSH7V496uOkIIgQfrcIlUtAIOgpLY9U=
X-Gm-Gg: ASbGnctnWzHQ+ac+w9a9CvqFDIV68dPrqzu724J6MbaMI7p0ztk+UP7lFH0RxEJkXuj
	5jY8lUSwzljmfKXgmzQaZeygGRNkU+eikkemaxSEU5Ykr0xkBdTo8aX0oNTMhAbpQFerjUW0A5w
	0fzpqN94ExAYn3sAOZnNoGs4Qhq3CYiPL9JbbuBb/IvbEei86oCrEndmAIvJUBdl9An2d9bGU3g
	L2qs4JyjphRHAAD3fNpOc9eHjX5GQHbG8LW2yy1//ZVsdwcRkZJMinu+Q==
X-Google-Smtp-Source: AGHT+IEo/LOWJvqO8ccMsjAMgsL3oXecGqn+jcdaO2d/Iphm+5oRBHqsqVkYxcKPRPAtl9pq06K8QQ==
X-Received: by 2002:a05:6512:224f:b0:53d:d3f1:13aa with SMTP id 2adb3069b0e04-53df00d1177mr8677876e87.20.1732931066746;
        Fri, 29 Nov 2024 17:44:26 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a0742sm631946e87.261.2024.11.29.17.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:44:25 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 00/31] arm64: dts: qcom: move board clocks to SoC DTSI
 files
Date: Sat, 30 Nov 2024 03:44:12 +0200
Message-Id: <20241130-fix-board-clocks-v2-0-b9a35858657e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOxtSmcC/32NQQrCMBBFr1Jm7UgSGyuuvId0kaaTdrA0MpGgl
 Nzd2AO4fJ//398gkTAluDYbCGVOHNcK5tCAn906EfJYGYwyrdbaYuA3DtHJiH6J/pGQTi6QNep
 sOg919hSqnV157yvPnF5RPvtD1r/0jyxrVHjxg1KuDbbz5rbw6iQeo0zQl1K+5YtI1LEAAAA=
X-Change-ID: 20241115-fix-board-clocks-e3afe520627c
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Leo Yan <leo.yan@linux.dev>, Joseph Gates <jgates@squareup.com>, 
 Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, 
 Stephan Gerhold <stephan@gerhold.net>, Zac Crosby <zac@squareup.com>, 
 =?utf-8?q?Bastian_K=C3=B6cher?= <git@kchr.de>, 
 Andy Gross <andy.gross@linaro.org>, Jeremy McNicoll <jeremymc@redhat.com>, 
 Rohit Agarwal <quic_rohiagar@quicinc.com>, 
 Melody Olvera <quic_molvera@quicinc.com>, 
 Bhupesh Sharma <bhupesh.sharma@linaro.org>, 
 cros-qcom-dts-watchers@chromium.org, Stephen Boyd <swboyd@chromium.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Martin Botka <martin.botka@somainline.org>, 
 Jonathan Marek <jonathan@marek.ca>, Vinod Koul <vkoul@kernel.org>, 
 Tengfei Fan <quic_tengfan@quicinc.com>, 
 Fenglin Wu <quic_fenglinw@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, 
 Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Jun Nie <jun.nie@linaro.org>, 
 James Willcox <jwillcox@squareup.com>, Max Chen <mchen@squareup.com>, 
 Vincent Knecht <vincent.knecht@mailoo.org>, Benjamin Li <benl@squareup.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8345;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=WFPW8bCZyiKGR4Ml5aZ2UV4BHVPkl0kdGXveRWG/O00=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSm3yOvQSHM5tX7I2MY0Ae8lwI+Jq5fC7oh7+p
 Ugt5lqeoRGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pt8gAKCRCLPIo+Aiko
 1buqB/9OJMkaga8CQm3odtMo/LO5kS48q5/oYghSlvFJMUzCepAglV+RB3MbrHKUyYDaPCXdrti
 +vlWdhfxll3FldBM+hc8KDNF0EXc6nMDM30SNiQJVgW/U02vZEA7rAhvz/oOZVowZovuVkmqxki
 01yN4DnHPkv4vG9mXGPI4TcaN4K9MbeqXB98GI1NH/5HYvfaqL4X2ezEswbUvpjFX9gEm/5I8xi
 b62ydm5jVJHKsaqf9KZ8FCBomzoRYoq1rm8c1XmaSFlx2US0mobGdevL3ZQ96Y+8TF7b2tOLia/
 GDk6NdZTWQgJ5ery73IZ3yQGk2ZjXhwxqUtiPCsic9+piOwZ
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Multiple Qualcomm platforms play strange tricks with board-level clocks
(XO, sleep) definitions. On some (older) platforms such clocks are
completely defined within SoC.dtsi file (although these clocks are not a
part of the SoC). On other platforms definitions of such clocks are
split between the SoC dtsi file and the board file. Several obscure
platforms define those clocks completely in the board files. Unify the
design and move complete description of those clocks to the SoC DTSI
file.

The XO clock is (usually) an external crystal used by the external PMIC,
which then provides RF CLK and LN BB CLK to the main SoC. However for
technical reasons this part of the PMIC is modelled as a part of the SoC
as RPM or RPMh clock controllers. It makes it impractical to describe XO
clock as being used or being connected to the PMIC.

Sleep clock is a 32.764 kHz RC oscillator provided by one of
PMICs. However pushing it into the PMIC might interact badly with fw
devlink, causing unnecessary probe delays and/or devlink loops. One of
the possible solutions might be to move it to the corresponding
PMIC.dtsi, but model the clock outside of the PMIC node, providing
/clocks/sleep-clk node from that file.

Note, the series includes a set of fixes for the sleep clocks
frequencies. For several platforms I wasn't able to find corresponding
document and as such I didn't change defined clocks. These platforms
are: IPQ5018, IPQ5332, IPQ5424, IPQ6018, IPQ8074, IPQ9574, MSM8953.

Also several MSM8996 / MSM8994 devices define divisor clocks at
32.768 kHz. Most likely these clocks are also generated by dividing the
19.2 MHz clock and should have the frequency 32.764 kHz, but being not
100% sure I decided to leave those as is for now.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Move clocks to SoC DTSI (offline discussion with Bjorn)
- Link to v1: https://lore.kernel.org/r/20241115-fix-board-clocks-v1-0-8cb00a4f57c2@linaro.org

---
Dmitry Baryshkov (31):
      arm64: dts: qcom: msm8916: correct sleep clock frequency
      arm64: dts: qcom: msm8939: correct sleep clock frequency
      arm64: dts: qcom: msm8994: correct sleep clock frequency
      arm64: dts: qcom: qcs404: correct sleep clock frequency
      arm64: dts: qcom: q[dr]u1000: correct sleep clock frequency
      arm64: dts: qcom: qrb4210-rb2: correct sleep clock frequency
      arm64: dts: qcom: sar2130p: correct sleep clock frequency
      arm64: dts: qcom: sc7280: correct sleep clock frequency
      arm64: dts: qcom: sdx75: correct sleep clock frequency
      arm64: dts: qcom: sm4450: correct sleep clock frequency
      arm64: dts: qcom: sm6125: correct sleep clock frequency
      arm64: dts: qcom: sm6375: correct sleep clock frequency
      arm64: dts: qcom: sm8250: correct sleep clock frequency
      arm64: dts: qcom: sm8350: correct sleep clock frequency
      arm64: dts: qcom: sm8450: correct sleep clock frequency
      arm64: dts: qcom: sm8550: correct sleep clock frequency
      arm64: dts: qcom: sm8650: correct sleep clock frequency
      arm64: dts: qcom: x1e80100: correct sleep clock frequency
      arm64: dts: qcom: sc8180x: drop extra XO clock frequencies
      arm64: dts: qcom: ipq5018: move board clocks to ipq5018.dtsi file
      arm64: dts: qcom: ipq5332: move board clocks to ipq5332.dtsi file
      arm64: dts: qcom: ipq5424: move board clocks to ipq5424.dtsi file
      arm64: dts: qcom: ipq9574: move board clocks to ipq9574.dtsi file
      arm64: dts: qcom: qcm2290: move board clocks to qcm2290.dtsi file
      arm64: dts: qcom: sc8280xp: move board clocks to sc8280xp.dtsi file
      arm64: dts: qcom: sm6115: move board clocks to sm6115.dtsi file
      arm64: dts: qcom: sm6375: move board clocks to sm6375.dtsi file
      arm64: dts: qcom: sm8550: move board clocks to sm8550.dtsi file
      arm64: dts: qcom: sm8650: move board clocks to sm8650.dtsi file
      arm64: dts: qcom: sdm670: move board clocks to sdm670.dtsi file
      arm64: dts: qcom: q[dr]u1000: move board clocks to qdu1000.dtsi file

 arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts             |  8 --------
 arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dts |  8 --------
 arch/arm64/boot/dts/qcom/ipq5018.dtsi                      |  2 ++
 arch/arm64/boot/dts/qcom/ipq5332-rdp-common.dtsi           |  8 --------
 arch/arm64/boot/dts/qcom/ipq5332.dtsi                      |  2 ++
 arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts                |  9 ---------
 arch/arm64/boot/dts/qcom/ipq5424.dtsi                      |  2 ++
 arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi           |  8 --------
 arch/arm64/boot/dts/qcom/ipq9574.dtsi                      |  2 ++
 arch/arm64/boot/dts/qcom/msm8916.dtsi                      |  2 +-
 arch/arm64/boot/dts/qcom/msm8939.dtsi                      |  2 +-
 arch/arm64/boot/dts/qcom/msm8994.dtsi                      |  2 +-
 arch/arm64/boot/dts/qcom/qcm2290.dtsi                      |  1 +
 arch/arm64/boot/dts/qcom/qcs404.dtsi                       |  2 +-
 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi               |  8 --------
 arch/arm64/boot/dts/qcom/qdu1000-idp.dts                   | 14 --------------
 arch/arm64/boot/dts/qcom/qdu1000.dtsi                      | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts                   |  4 ----
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts                   |  8 --------
 arch/arm64/boot/dts/qcom/qru1000-idp.dts                   | 14 --------------
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts                   |  4 ----
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts                  |  4 ----
 arch/arm64/boot/dts/qcom/sar2130p.dtsi                     |  2 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi                       |  2 +-
 arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts        |  4 ----
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts                |  4 ----
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts                  |  4 ----
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts |  4 ----
 arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts     |  4 ----
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi                     |  1 +
 arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts           | 14 --------------
 arch/arm64/boot/dts/qcom/sdm670.dtsi                       | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/sdx75.dtsi                        |  2 +-
 arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts        |  8 --------
 arch/arm64/boot/dts/qcom/sm4450.dtsi                       |  2 +-
 arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts            |  8 --------
 arch/arm64/boot/dts/qcom/sm6115.dtsi                       |  2 ++
 arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts          |  8 --------
 arch/arm64/boot/dts/qcom/sm6125.dtsi                       |  2 +-
 .../boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts     |  4 ----
 arch/arm64/boot/dts/qcom/sm6375.dtsi                       |  3 ++-
 arch/arm64/boot/dts/qcom/sm8250.dtsi                       |  2 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi                       |  2 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi                       |  2 +-
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts                    |  8 --------
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts                    |  8 --------
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts                    |  8 --------
 arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts            |  8 --------
 .../arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts |  8 --------
 arch/arm64/boot/dts/qcom/sm8550.dtsi                       |  2 ++
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts                    |  8 --------
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts                    |  8 --------
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts                    |  8 --------
 arch/arm64/boot/dts/qcom/sm8650.dtsi                       |  2 ++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                     |  2 +-
 55 files changed, 59 insertions(+), 237 deletions(-)
---
base-commit: cfba9f07a1d6aeca38f47f1f472cfb0ba133d341
change-id: 20241115-fix-board-clocks-e3afe520627c

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


