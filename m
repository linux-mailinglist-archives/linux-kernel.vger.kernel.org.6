Return-Path: <linux-kernel+bounces-426036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F315D9DEE15
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5AC1B22480
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D451531CB;
	Sat, 30 Nov 2024 01:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Muai7xoY"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD6614AD19
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931084; cv=none; b=ozLDPlPfSSy6i/fhSyo2K6UgWKxK+V7f7QwYEADztjLxh5Gfyvs1rUzSYdq6jG9B9S+I3GeuitkGHmvHb+A1DA4iWgA5JmulpDQQSjl+//3cR66I5398+TryAo3XmkwZ4k+6May8Ykbk07uV/vNkegHA69WGr9YkxtGnk9NPHjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931084; c=relaxed/simple;
	bh=Hw/hyP5k8e4mrPZ2Xq4xWEV8pyteJA9D67U7usPU5R4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KRD9nFG5UikwvqbkMPie37by1nfYC4mbYS2CktBzFWyf9HEH+bIgCE/vb6thUb/xs0aaiyvHU68HP/qlPgCBIUsPdSgU3kbGHgYKy9L0JXbtJLtU4IinF/GIkdUFKdjbY1UvhegDj68WDUkRej1thXjcUJCDGTVAOjYwj9IMP2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Muai7xoY; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ffc3f2b3a9so35725301fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931081; x=1733535881; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5n8O27+6FwtaHVPzRSxUX+gZj9rmBVfvJfhu3dGKwOE=;
        b=Muai7xoY6MBuxdlbGBnPZiUkigRYteCsypU1dJiVZ7UD2QgOtkDziIfpQ42FsNap1Y
         5MJbPKLDklnPBCu8KI10cTx4cG5VTp++ms4T7M+x1w1HSpLeZW2zopgg4xCOWHEmtdBT
         gEaZe/yFcOawIcYTABFAfr013GPhTKKjolH6qlmpjnuxZT7r7y+Ijw7EPoUs6yo9rA3X
         mkgilkle/rU+TgTnEwA6oyDUqYZ0qMV/LuyAzB3tJ6V98rf1xmE9TFvEDj2oPaGVwSxu
         xm2K0Tg5T50hQ7Pt6BVPxpYfU0XYWYWvgqfecAo7XyDJfnMX7tYdR0hWVO/mu0fwyt90
         m/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931081; x=1733535881;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5n8O27+6FwtaHVPzRSxUX+gZj9rmBVfvJfhu3dGKwOE=;
        b=sMxvvyHL5uMh+aWryIO+9ePL/BpEj2/ZhudtuqiuWiBOjpKfmUmD7PRbpQO4m2Tes2
         nCQAJ7N3pHh+ZHJGbXnx8Ul0q1hmwz6ylUQ9Iv6Sz/rS9CVGg69Sol/87XXFu+aTFzyw
         XaaKetzGd2M/it3a22Ye/LnUrE+OeeGUYXfBOE9TzCJY/+LxKdFc4UK2iikBgrwRfciV
         7RH8r/in2b5vSrt548DlDS+9jomV1OETcJ7lR+Fd8hPkJrRkYtXvI002ptryZiez2tgj
         AfiCrEYoVKZ9YEa0s9Wm7xM9X1eSpD+dhqigBtctdvNa1ftIMWPd7ID/wakj1jywDNhP
         6GfA==
X-Forwarded-Encrypted: i=1; AJvYcCU1uv3MOyvF4fA7IT9C8UTUXFSY4UXpDZbUDWGAygkXpRPvXb0gFrCDVhBl+iR7oubFkMnjPQtqkDx70gM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbT7NXiWTkrywL2ZA9uSq/rCVBdTUVeTB/NvAnRWY0MkjGxIww
	yYloXpE4iC+mfdG+rbnnV8GQtOKSRxX+tR0Exu5IsFFDukYaKcpEFflTKs/3cfI=
X-Gm-Gg: ASbGncs/mJ9MUJufWGNI+doohOMJvO08WOIRI7jyTvC4h5GyzA/sDfM0PeRXbNlapIj
	x8RgB/zWyezwAuPXy+HQnNNc/VJ8kuQBPOZlzoOB7DTwmIoav4x+o76TjStYfMuGWdEDe4NMzZu
	EdU/3TKJMiU7DHepMd1XqBkSIECkZZ+eluzrzjkqa/5KMgqzpB+daP1Y5C+x4seqRZ8F6XYhs/5
	LglF0Wws/HpRaNvfKE1KSzIgqtNztgHxB0dlVe5k68zlQIQkKGTFCHQvg==
X-Google-Smtp-Source: AGHT+IEcQqU+fRINwT/0cl4nxjKjERySqIRFkBtmD1H6WQPaU/FwbDVYMmhCUuuCTaNlmYtK2S9g8w==
X-Received: by 2002:a05:6512:3d86:b0:53d:a3a7:fe84 with SMTP id 2adb3069b0e04-53df00a96e8mr13447142e87.8.1732931081219;
        Fri, 29 Nov 2024 17:44:41 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a0742sm631946e87.261.2024.11.29.17.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:44:39 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:44:18 +0200
Subject: [PATCH v2 06/31] arm64: dts: qcom: qrb4210-rb2: correct sleep
 clock frequency
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-fix-board-clocks-v2-6-b9a35858657e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=844;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Hw/hyP5k8e4mrPZ2Xq4xWEV8pyteJA9D67U7usPU5R4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSm3z0aH5MHMf2dYty9WKiYyDzF4pWI5O9Wf18
 dfEKdqrOkKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pt8wAKCRCLPIo+Aiko
 1foACACUUWqTouCfHxP5WGemewoFWQwGeF6/iAMEXGy2HPgcqw4JjAlfC6KXkhWeSFjiWxnLDSs
 GsJocutQLttSycnZJHGe4DlqKirCuVxlgy6ig0ztCT1tVBsaxmL6+dIn0VWPwewqyieLtenfjlE
 NJeDMW+CG7rfltYPc0j3aYNcWoErr257Cu1XpfFsChTsYLqsMZfoNnnmCCGYM5sSwoqx3VuR7Kz
 /jwbYYL+mvb2no+NLPweKxgJ+p3+oUxPKTePo0LZ5xGSuHxAV2A3pBGl/XHpnictm/p4JIB4dN+
 89JdoeJ3ltk6DFF4kzgLX7q1kBpsXDJZ7RJX4km9yShTXChO
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Qualcomm RB2 board uses PM6125 to provide sleep clock. According to the
documentation, that clock has 32.7645 kHz frequency. Correct the sleep
clock definition.

Fixes: 8d58a8c0d930 ("arm64: dts: qcom: Add base qrb4210-rb2 board dts")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index a9540e92d3e6fc314fa91d4f055325680233f6c4..d8d4cff7d5abed405d1b4cdf9ab8264aab076830 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -545,7 +545,7 @@ can@0 {
 };
 
 &sleep_clk {
-	clock-frequency = <32000>;
+	clock-frequency = <32764>;
 };
 
 &tlmm {

-- 
2.39.5


