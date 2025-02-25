Return-Path: <linux-kernel+bounces-530867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6731FA43989
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7DE18991FA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D40256C7B;
	Tue, 25 Feb 2025 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R2eIzvDa"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E221C860C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475857; cv=none; b=f9nZLtIPzJUgymnfcrSy45nqBMSGRZ1gXtvKbR51UDiiLVNuiWiu/I0Ny+j8TVwlrmqW0GlEZsal5xl3PwCeMl5GuCdHuO3+tD2+jVC8rLlL+V6J3XJwfL9h2zWL3aIQJdgiyMF/WfxUFNVOLz4McMRvGAWgwgBttSrn1QjiFqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475857; c=relaxed/simple;
	bh=Tu0wrCNQbs7SeX2KXHKzypxoD8BKPLt0X1AhllqWK/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TaGjucKHVawPUy8/bev3ymZLgRbPAGME09wXgNUMftnM4xTT40JhM5E8i6kVLoiKDthKSwiJRY+nJSdyBXqGQS6o47937g3B6Mt4v5SnVqvWQ217k9yw43WyWxQsAJ5Z+oOxcnXDMr3WqHxOf+CpwhFMM+ivUTeVoOsx3q5bT8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R2eIzvDa; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dbf5fb2c39so887961a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740475854; x=1741080654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9eYtHkeTugcicE4QpN0FwS9XxN6NIPRCZ3nNLtCSc8A=;
        b=R2eIzvDawNwhMmOwGl7CPSWCXGgzfPWMx698K9O2bxXVCO3wefvNZgSQ/7KFLe9QGA
         dFQzDOjsWlx2HIE43V7a9yuTgqzq+1L1d5yq5GLR46NrvHijBVslnNAJFwFC+21s5sAu
         GfRTP17zn75+VbFHsoG+3OaVjxgewiMANEKmeXB/PJ5EmDXes1wlzN1I6o4tQe092cjR
         aqZfSiMXMrIxTI0n+Zf9R0lrvHM7Mok3c4n6nvUNQDs3yAItlhsgzFMjhOiPKjh7Q/qg
         2Wz3YOyjCjcNXdu8Yp47NlywFMVH7KYe7wV0HrhucTybQ03ksL2Q4Lkzas0f1sX4PRoR
         c83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740475854; x=1741080654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9eYtHkeTugcicE4QpN0FwS9XxN6NIPRCZ3nNLtCSc8A=;
        b=mKvSj87heIKeSm9upi07QGiINmn3gJgbnAgcFPU48m4OeeG06masJO6mz02LxZFSXX
         xNB8ki0nLELkbYmXBl4T7+I25AbD4IU7b9PM5aPZT+g1O95rM7zWLvRskTAeKigPS+Na
         UNgpZaF8s/6Vkac3uagU1cBZ7QaVa862/2eCk875dzjIfyHZGZleE3zgkdilwuUXsdkv
         YnLaWDISYL9Ufk9a1sfkbehXkmmKtVIbnck70FKl6Y7QtHgrP5EkigJKd/XNtC1WDJD8
         iATWXFWS0OApBXLk/ys5QraAfU4aM4EBzjEH1NVqn5dkT83hw1M1yJIjmVFSvWlwh9hY
         ETLw==
X-Forwarded-Encrypted: i=1; AJvYcCWbFYbb//Nl3r6WgTYVKSJugXDEN7L3xknbjH1UfhtrkJFtnSCbaBrHs7vHK/dvFInfGe1P55EEfI0KcNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwdTyLnIBup612n9u4uUiVZnuzz8DeuruUEyxKt9uuy7sj6qlu
	InCC+Whhwl9teMuef0+LmX5Li20o7sG6H9wJes60hPnjBF1HzxlmL8HiWkwcEkc=
X-Gm-Gg: ASbGncs9Bpp1m2f7k4LHRhvshm2Bmv1CLT5zs0Tm04YOrIUh/iIYrNGI2MTGgxDL6ot
	/9fjYDLljIokgtgoexG2qumf55jwkr9YjKyzCS4Wqvh02K+/LrqUK978IP4eSroBrjYOLa9Oxyu
	7Y2mZ2/XUtfaQc+KyJZaeyHLRXs8sTEaRNRU0Lnl5Id9qkiC+5Ozw4Q56uS3jLY63vGxNo5IpPV
	30i7gdlbNau2WNFpZ3j8XcApB9J3xu+WoUY+HcnpN0cTalqzx+z9Rm9ebezVQIgfoYKKPNYDjXv
	Ee6ffUVc4PfcVtvwZbZWGLZ9qyzJbOvidqADpNNF3/k4lWFps1HunYatwvw57NEH2ejSUGnZf8U
	=
X-Google-Smtp-Source: AGHT+IEAXazWhifLPGaLDMrdqG1jBglNulFz4jD8p8GTVNKHnMYVgFnc4WJYXJthmOdHQz5hCElo8Q==
X-Received: by 2002:a05:6402:50ce:b0:5dc:882f:74b1 with SMTP id 4fb4d7f45d1cf-5e0b70e2e62mr5718546a12.3.1740475853940;
        Tue, 25 Feb 2025 01:30:53 -0800 (PST)
Received: from krzk-bin.. (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e459b4b67csm949490a12.11.2025.02.25.01.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:30:53 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: x1e80100-slim7x: Drop incorrect qcom,ath12k-calibration-variant
Date: Tue, 25 Feb 2025 10:30:51 +0100
Message-ID: <20250225093051.58406-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no such property as qcom,ath12k-calibration-variant: neither in
the bindings nor in the driver.  See dtbs_check:

  x1e80100-lenovo-yoga-slim7x.dtb: wifi@0: 'qcom,ath12k-calibration-variant' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
index a3d53f2ba2c3..9aff5a1f044d 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
@@ -674,8 +674,6 @@ &pcie4_port0 {
 	wifi@0 {
 		compatible = "pci17cb,1107";
 		reg = <0x10000 0x0 0x0 0x0 0x0>;
-
-		qcom,ath12k-calibration-variant = "LES790";
 	};
 };
 
-- 
2.43.0


