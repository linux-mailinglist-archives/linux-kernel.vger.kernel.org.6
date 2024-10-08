Return-Path: <linux-kernel+bounces-355355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379F4995115
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA070281401
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0DC1DF97F;
	Tue,  8 Oct 2024 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L2UEhF5V"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6C41DFE1B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396390; cv=none; b=PyT83HpQAKG+V5tQEG057MwUYiCrv22d9VQaVvtAB2GykSpVMrVpTM/4IPtvAKYX0AoTdBpFn3ws2uh2gNgTgayKXkl8cngfW78ORneBO/uKDX9ilZCyz8Rg5F9gTg58DdHkLRxS9LrjccC+Bro8n+nOCSRfnCCQ5PAVRLrnW4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396390; c=relaxed/simple;
	bh=HnTSSieNZnln6w8Vcr1MEzPJufKQo6Dj8CE0MlH5veg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HVGJAHWi48vzab7b0+jgBbnhHsYAHoNsw020Avji/sIOYsnBdIo3UAOsenh818O+cvKLj1q5iqCSEzGw+jh2cOMjqtKiYl+wORbmqFztVtIchQ6eYlO6ZEzTDotbBhBrUQm3sbqaHfCQuD12bkNiQRSmWOEABSdgn8ISOGhOzgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L2UEhF5V; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7aa086b077so655315166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 07:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728396387; x=1729001187; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zW3qGb3ZL5G/B18IQmAOlU1aRnTk8u0KXdkSlfqu380=;
        b=L2UEhF5VUs9R12tbWFCoX8Et9NTFKu8WyrjwUfTgaebieVH5Glf7udVwKSKR+x+RCc
         WTIDomeuXolsobBkJ3dXg5s4H6ZehFj2JzXO08l2YyZtAQ7g7LhL9Be+HjyHHutnM83i
         +SI/ow9Kt6xzOd9Tjj74Xj1F4zkO3Ha2VMjUK2v4pod5yz7EwMzEJiNoEzp2peoim7Jy
         WcVb46oN2thPvMdddlLEJbA6tJgstDO0tsEh6W8eG6RDvM83ZztyRkMZ7aZD5YRhSUlP
         3ejnL608nG5OBSyI6Dju/CZFnQMD1sMpuuUcnhSIJUqmtUKZN4foUCVdqdA7T1hjRDkH
         w0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396387; x=1729001187;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zW3qGb3ZL5G/B18IQmAOlU1aRnTk8u0KXdkSlfqu380=;
        b=kJqBBxtPOrhsJWtw3DB66y3cTzS9qz+ubhnxVEDVghTTaYZZMx7y7cnbVLNPam509t
         aiQOPkfutePKqHHtpD4UQwaCwy7hsYTs+l8KXgSkVs6U6d+G7YRidaZJNmyAq/WyUNVk
         Tgn5E92qxqWA4NXVYWWnEPwy9iBG6+CgfFBy34QXavsn+oe2XpC+gIyxgrwZeo+eFkkg
         5yYBKOv3u4qsz/vq+fJFYZstmqxu1YnPOdpBh4XipI6QBTBQ4Qw1oUd5XXXjCqFtjhls
         FVUzGFhaUJyzeSijLCiZaeUUnqZscIIkD+2Y9Yy+ZKtOw6v7RHCRWA8K61L22ENuvLMQ
         JjfA==
X-Forwarded-Encrypted: i=1; AJvYcCXqzb16jaIkf3o7nCK4BqV3s11+XbRl/Bfz1TYlgUOqRyWv3GqY7MAIS/Rhwccch5RFwnxrJ/PsZkDlHNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkqQYXl5OJgYXXeveGmpodO0KNVZ0So3F8nO7huZ0k5GBkw9as
	P7eK8R6pzb/5Ay55xNKsSv6QBMzo1w1daOimqT5R9v8hukhlPTByIc+adyQNY7A=
X-Google-Smtp-Source: AGHT+IGAPJkU/2BX77pEu6SdzFy5D21IvcpFCtEIlOIooAmaIEi6IbF3ADl1oZs59SG5qUVOIXYKVg==
X-Received: by 2002:a17:907:f767:b0:a99:4acc:3a0c with SMTP id a640c23a62f3a-a994acc3ab6mr795246066b.53.1728396387114;
        Tue, 08 Oct 2024 07:06:27 -0700 (PDT)
Received: from [127.0.1.1] ([82.77.84.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994f50fcd4sm320714266b.171.2024.10.08.07.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:06:26 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 08 Oct 2024 17:05:58 +0300
Subject: [PATCH 4/4] arm64: dts: qcom: x1e80100-qcp: Enable SD card support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-x1e80100-qcp-sdhc-v1-4-dfef4c92ae31@linaro.org>
References: <20241008-x1e80100-qcp-sdhc-v1-0-dfef4c92ae31@linaro.org>
In-Reply-To: <20241008-x1e80100-qcp-sdhc-v1-0-dfef4c92ae31@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=HnTSSieNZnln6w8Vcr1MEzPJufKQo6Dj8CE0MlH5veg=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnBTxZ5pw5/X59abM1PzRowDFyBM4dfWvQvCZKC
 68ku9qUTSiJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZwU8WQAKCRAbX0TJAJUV
 VsDpD/47F+PiwUrg4V1wuq9sTBq0KrtQ4LmgaCq02mRN7AU7b/+bCIEpW9nYZw7XIs0WhZZp3xP
 DdVQeHV5HUcPZr4CA0ZghAO1InQYeiwD6sciR0tuN02VYftouZx+Eu9LD2zamJslkzZiaFcbCQ5
 gXzgh4S0lyOXM/d6Rsdn3H27D+z5BVRgBXCBEUzRGxFxPCJnCMjCyjl3KTqPBwTBxi5EHGgue2n
 MHo1wohwNVZ8K6Y5gEha9m6c0RZub5OMgVls5z3I4UQY7DSHcAc3kOHP2bgiTfDBHJK/CMqevP1
 oW3emd8H3KMhEqW9HwgW4bzTkiIUgIkSw0CS/os5GK6bEv8A3jRS50wizmaKSij/DJmqnkxTJwy
 yauuZs0Sd2HxFITFWNv5IxPL9blpOhtgQaZviOcFmBn3KGY0mbnIn6cuaXbACC8H2b74lQXQRAD
 Xm30RKgAFAZRx5WVPFozoMsZx6JFiCNgHl/X83uU1UlxOobqgrf6HVpf+l6P+PTIX0M2mBREkZ/
 aMHzq8jxS+d/PYnOzU1wDj9CQ0IJ2NXlFMMp1byiG7ccklfWVJG0WU5SLHjorLK76IjtktFfL1T
 U+k6IBktWgDNVdBDhRSgRTn5aq1VgDSZhkvu9UsjadAF0FX3xnFO//J5dx3px54cc8vrrjV+iDO
 +mI/ECC0kKtrJeA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

One of the SD card slots found on the X Elite QCP board is
controlled by the SDC2. Enable it and describe the board
specific resources.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index 1c3a6a7b3ed628e9e05002cf4b4505d9f4fb1a63..a82fabaaac9010ce3b8d6718b3425e84d8864171 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -729,6 +729,19 @@ &remoteproc_cdsp {
 	status = "okay";
 };
 
+&sdhc_2 {
+	cd-gpios = <&tlmm 71 GPIO_ACTIVE_LOW>;
+	pinctrl-0 = <&sdc2_default &sdc2_card_det_n>;
+	pinctrl-1 = <&sdc2_sleep &sdc2_card_det_n>;
+	pinctrl-names = "default", "sleep";
+	vmmc-supply = <&vreg_l9b_2p9>;
+	vqmmc-supply = <&vreg_l6b_1p8>;
+	bus-width = <4>;
+	no-sdio;
+	no-mmc;
+	status = "okay";
+};
+
 &smb2360_0_eusb2_repeater {
 	vdd18-supply = <&vreg_l3d_1p8>;
 	vdd3-supply = <&vreg_l2b_3p0>;
@@ -870,6 +883,13 @@ wake-n-pins {
 		};
 	};
 
+	sdc2_card_det_n: sdc2-card-det-state {
+		pins = "gpio71";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
 	wcd_default: wcd-reset-n-active-state {
 		pins = "gpio191";
 		function = "gpio";

-- 
2.34.1


