Return-Path: <linux-kernel+bounces-426046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 608689DEE33
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7E83B2324C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3013E19F12A;
	Sat, 30 Nov 2024 01:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KCR+B7Gg"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4170B19D89D
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931110; cv=none; b=qbwC7UF+Od7Y2yMsW6EuLrKu923fEt9FfzvCwj9paE4Gzsa+bEdtmMlUnO4qNyiJr2ZbXNlBoitq//7FiCdlJoL4oukCJgUceFcLxPBBrEIpwiDJrZSRrj4jnX7QuDALHUleZ6pG7WLNS9Y9e7+hjD1PX9AV3dKoUZTlk4I8+hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931110; c=relaxed/simple;
	bh=oCnFN08aVITyKXapk9h/eTP1McSoWUQ0a6cbzA6vc4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZtsoTchsCaajHhAlidBNjvUzdWYgXsEUGiz7vMjeJNQ9xR4//qhNgkbM+buHEJyxrNVbB/LS7MBxJAoFhLErmg4/W8i/OYrcTu7PbZSLIQ3GtFS4wtgTwnowat35cmxYkOnArVFTit7XRsl4RZka9T6zPOU+8/D5ovWGQ7xtOPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KCR+B7Gg; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53de92be287so3840367e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931106; x=1733535906; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o97PprEmFcE1YMTUzaFqHNHrKjzvxr4tsiAOHswBVG4=;
        b=KCR+B7GgTV0THVROQzECdsuKgilcgcLU8wGTbLLaH/QxQ5Xmd/ohy/E8AwMlPerMiV
         +ikrmEsi5bpQUWAVLS5GuaLqV0eVTGvKmWns1t6C7YaWi0fJNBwUCPPcPEh3eWJgJ6od
         U3aNMZ/Zn3vMgUPA/ACfFAoGxEP1Rfb2Lyjc6ArqLIulAKtC5L4VOsV6Vsfd2cSpnyO7
         7lo5VbD43KjpuvSSG4jkMVj+JtkfrArWw4xtmkf07Mokl4LZnztpO9nPI1EkS8CYE6Y0
         cHkuEq+crgZthFDtK0zlJYG4/byS0c+4OA/COqL63cEMElrrp4kwRUpRUNsm3uI+fIQu
         3mpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931106; x=1733535906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o97PprEmFcE1YMTUzaFqHNHrKjzvxr4tsiAOHswBVG4=;
        b=ehrRJbihV9yrvWVttkHnto+XKTvwBOjWJqVYjN2RuEKlnEF37+i6qSHee/9lKU/8Zu
         GoL9FJf2ody9QQHtRKEWmGvREAgiCwHWT1HnG+FObYMAx1KOqhywCC0mOBwGbXnOrJsK
         aFZn9bpmlVFY0zYOuADXfAy2uvjITaLAFgx32YMC6Ul1sqYmBhsBtz4T1U+6NgOxmFlG
         Ew3JnEq70cgsKlOowd6rbej2fyZjeWJIaPa1AcxYdOARsRupePNG91dkF2ipYFmHUywD
         qqMmW1dOlV3B+K/ylp+YRBGwpNNxr9lYEfvEjOINX8ZiKepmo1dR68HAmZXKi6CYwkKO
         LBtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrUP1DHf7k+aNrRfEQK96zNhcqSxMr4kf3z7MYzX7K+X4VUonCQ2vHuw5qvKitD16hGPo/ZEWL1uKheqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFzPtB77GGigFclRd1MdwJirnakZRSELkuO6MXOicPgINYU3Z9
	+JlTVxw6EcgImtiqhL8N9hnn0U6ke1BB5Ju58H3KPrAd6RiOnT0SXx5+fCB8dJ8=
X-Gm-Gg: ASbGnctPbaJOVVrBVin4MVHrF374J4+c9GFHa41yUBKaTcyF84bUMunVo9kGbyfN4MI
	+5vHI1Jo3+InDO38DnAl01E4GSlG8ul7H0fPSds01UowVihYWXjVrPzeAJDHmOaUojezkFSpXHq
	HkeBk3MwCivLfXZKrjM5wAy7WzGHDt7kcrYCNS3lD52/R9jHe6FZs8EgaW4JkSmWsmZ58Y8klbc
	DJAsmQbpCkIy1TMjOXJ8UhuD0fHUvAwT51yd8qhIIjbRDGy5AR0/86ePw==
X-Google-Smtp-Source: AGHT+IE0X4MRI4Yuj1wmpTZCVAUd8U1F3Vx4Rkpc9biwLjDow+iD4g45gPPRgt2c3JAE16rcxIJZqg==
X-Received: by 2002:ac2:51c6:0:b0:53d:a132:14f5 with SMTP id 2adb3069b0e04-53df01172f5mr13349519e87.57.1732931106373;
        Fri, 29 Nov 2024 17:45:06 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a0742sm631946e87.261.2024.11.29.17.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:45:06 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:44:28 +0200
Subject: [PATCH v2 16/31] arm64: dts: qcom: sm8550: correct sleep clock
 frequency
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-fix-board-clocks-v2-16-b9a35858657e@linaro.org>
References: <20241130-fix-board-clocks-v2-0-b9a35858657e@linaro.org>
In-Reply-To: <20241130-fix-board-clocks-v2-0-b9a35858657e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3849;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=oCnFN08aVITyKXapk9h/eTP1McSoWUQ0a6cbzA6vc4M=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSm3152hw1YL7asiFs4Su9D0LkAteWjzprRzAj
 u7wUlgNx7CJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pt9QAKCRCLPIo+Aiko
 1RRUCACeWyG6A8xUX2FF3xZdrvsh31tzdcn3f6pPfdU6n8Taks8khEMH+DAkjLdqcT9OL0499N5
 wMj4Sfb/2pPEg6pk8u1XAzSdcWvu60w1WUjUMsQLIiAb0TylD8i6jmQT8eozYrxUATQD0LPV0NP
 7lc+x9/axKbU1M9HBrfo8tU+jKKQ8TLDVYKcLW4ukm+E6Zf2fhxjypgJc9xA9bQ1nFeG5rdWeRK
 S9KVKvw/mPhqVO8Og+iX1N1o3Kw4mBCCuiUnCTYs86KMPLjYAUv0dRCLEjjbHmek3aVgre0+YrL
 46MUMzLMH0g3/o+6bXHEkT3POLLDu+tvjqqVB9Srg/XjrcJ5
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The SM8550 platform uses PMK8550 to provide sleep clock. According to the
documentation, that clock has 32.7645 kHz frequency. Correct the sleep
clock definition.

Fixes: 0b12da4e28d8 ("arm64: dts: qcom: add base AIM300 dtsi")
Fixes: b5e25ded2721 ("arm64: dts: qcom: sm8550: add support for the SM8550-HDK board")
Fixes: 71342fb91eae ("arm64: dts: qcom: Add base SM8550 MTP dts")
Fixes: d228efe88469 ("arm64: dts: qcom: sm8550-qrd: add QRD8550")
Fixes: ba2c082a401f ("arm64: dts: qcom: sm8550: Add support for Samsung Galaxy Z Fold5")
Fixes: 39c596304e44 ("arm64: dts: qcom: Add SM8550 Xperia 1 V")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi                | 2 +-
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts                     | 2 +-
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts                     | 2 +-
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts                     | 2 +-
 arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts             | 2 +-
 arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi b/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
index f6960e2d466a26bec4e5c3d31ac0bf54168ca1e5..e6ac529e6b7216ac4b9e10900c5ddc9a06c9011c 100644
--- a/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
@@ -367,7 +367,7 @@ &pm8550b_eusb2_repeater {
 };
 
 &sleep_clk {
-	clock-frequency = <32000>;
+	clock-frequency = <32764>;
 };
 
 &ufs_mem_hc {
diff --git a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
index 01c921602605726928bcba71abd937869880ea0d..29bc1ddfc7b25f203c9f3b530610e45c44ae4fb2 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
@@ -1172,7 +1172,7 @@ &sdhc_2 {
 };
 
 &sleep_clk {
-	clock-frequency = <32000>;
+	clock-frequency = <32764>;
 };
 
 &swr0 {
diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index ab447fc252f7dd705fbe29725805bc1c146c10f9..5648ab60ba4c4bfaf5baa289969898277ee57cef 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -825,7 +825,7 @@ &sdhc_2 {
 };
 
 &sleep_clk {
-	clock-frequency = <32000>;
+	clock-frequency = <32764>;
 };
 
 &swr0 {
diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index 6052dd922ec55c65089e6b08e36c355b01bf24fa..3a6cb279130489168f8d20a6e27808647debdb41 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -1005,7 +1005,7 @@ &remoteproc_mpss {
 };
 
 &sleep_clk {
-	clock-frequency = <32000>;
+	clock-frequency = <32764>;
 };
 
 &swr0 {
diff --git a/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts b/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts
index 3c5d8d26704fd925857b5ddcc6067c2b14e1403d..e8383faac576a2f401fff74231a764712c832291 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts
@@ -565,7 +565,7 @@ &remoteproc_mpss {
 };
 
 &sleep_clk {
-	clock-frequency = <32000>;
+	clock-frequency = <32764>;
 };
 
 &tlmm {
diff --git a/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts b/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
index 85d487ef80a0be5c3586d9de69327abd2b64209b..d90dc7b37c4a74cbfb03c929646fda3381413084 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
@@ -722,7 +722,7 @@ &sdhc_2 {
 };
 
 &sleep_clk {
-	clock-frequency = <32000>;
+	clock-frequency = <32764>;
 };
 
 &tlmm {

-- 
2.39.5


