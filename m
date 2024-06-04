Return-Path: <linux-kernel+bounces-200409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA078FAFB2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3221C20CB6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19334131182;
	Tue,  4 Jun 2024 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qll63JQM"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C609144D0C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496106; cv=none; b=DYgMHt4ZxtBJJYKw276IDoFoZK0ESkUEr4eRgHF5bnvZEohWWxae1UAti+jiuzENTGxVXtcPSTpM5Mt+rC8msTMkJPXxTSXGsrb7Tt1lB4u4k1b/pJAAca2CzrZOgmd/c7hoBZF4CCVQ5bcjH7e/r1Ex2KL9OLp6VKPWCtqerm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496106; c=relaxed/simple;
	bh=Kdcf4gyifMvsfIuC5jmydzekNdCdDS2WOulnau3ZpVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F4zoZ2/AnCAP5tU8w6/8ryktDEscDk9wefDKhfOMt7NgU5cIFGzpZydlv9knxkgudjbFLSfrDJV1Xbs1n1BzThKTDwKOowvlMRzdt8XAaOq6eaU9TYwxKjqr6HSKg86sRJLPi+5uoaibVdMJkhVC0fUob/vkxt99UvwVPh+12vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qll63JQM; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e78fe9fc2bso75264021fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 03:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717496101; x=1718100901; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1FiKRjpwxHYIU9bA81jIkxWG1M5TraYGBQQXJ18994=;
        b=Qll63JQMrbnkAZSyxy4Ek00jhjwNQr41IPkTpnsMrqJocxCm0XYkl/1/hwSqHTiHEh
         p8KTmBl1uOm0N4NCPVYEfUZBeS6ctv3Q/Ebl6dhlAuGGvcL8dCYaa5kqdsk1PmshsTCn
         FyvHOxfzPJ0MrMVnKqMsDS0dC4NF+SOQrvum4ELLh/z1cCYZ3BQSpfdVa1uqNb1vuvZl
         htibsb7fOu+pgnqTtLpBA8+6r2QsmDvBGq8BAPXOg6AfAGzaj9/8B2DT0MNwvJOL9vQJ
         7njgsWaHSagiKXquoG/kXsqAvrh/YlPMuB/V7FDAG47Fp1IIlvaMHCRbv314xdD6quQr
         JcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717496101; x=1718100901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1FiKRjpwxHYIU9bA81jIkxWG1M5TraYGBQQXJ18994=;
        b=R7FjWCwC3xDvy8Utpr8PljO5dJLAckmZlywsvMQRcvRBZw8Ml/mjhUIv8jKd0conX/
         7u1oKKbFE1VJ+KpDNgP26EgiIuuSGmtBiayC9ayPBp4fzri/pgpaPX619tIUgsekwMEg
         yVQY3YQa4JtLGZpydqP9M1HC2JFXJPez1oVM2xHVISbWqFWdl/g0Csf9YJP8skgxD9Kq
         9RRdFbnhuBE6+6UhCiQYsFlMVQDuqPWrfDt7OMP8vAS4J8u44ZWE5C3YuOXekCCNKzeM
         AggeI6k1c0AF6ixWi5kB7MDoBX3S/VbkMQgx2LKQHGJ1iwXHTxcRON0XgOdD+VPi8Bct
         OvMg==
X-Forwarded-Encrypted: i=1; AJvYcCX/94D2M2qvOmB9dRm7hFtTNlCtKd3o4A24lIf4adMcRH1tD+lz1VK01fsY/9yhYm2E1EOLhJZbSku0JlmO8L/ZF0+AcVY1tymIRr0I
X-Gm-Message-State: AOJu0YxGZC3BpyMAf9xfukW0bxt5qP8nEthTdEoe9p5yV+9f1hazBQjg
	yeoGlLGZrEy3R9nzK8NyWe+Rmcz8RvdsC2wWBgFDGZwW7YtKdgorUfptZRzCGCA=
X-Google-Smtp-Source: AGHT+IHqunSpSEno7XIpTMSA1ZqbhFUvvCLc6ZuqU+J8t9dY5ZulvB+57VicGIOgT1SORhXY0R0a8w==
X-Received: by 2002:a05:651c:d:b0:2ea:81cc:b146 with SMTP id 38308e7fff4ca-2ea9512b1a0mr74966371fa.18.1717496101503;
        Tue, 04 Jun 2024 03:15:01 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91cf0bcdsm14715451fa.120.2024.06.04.03.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 03:15:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 04 Jun 2024 13:14:59 +0300
Subject: [PATCH 2/2] arm64: dts: qcom: qrb4210-rb2: switch I2C2 to i2c-gpio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-rb12-i2c2g-pio-v1-2-f323907179d9@linaro.org>
References: <20240604-rb12-i2c2g-pio-v1-0-f323907179d9@linaro.org>
In-Reply-To: <20240604-rb12-i2c2g-pio-v1-0-f323907179d9@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, 
 Alexey Klimov <alexey.klimov@linaro.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1512;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Kdcf4gyifMvsfIuC5jmydzekNdCdDS2WOulnau3ZpVE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmXukiGa2sOetdv23AiU1xg+flJKQkPu/8mVACg
 aEuNfzvQsSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZl7pIgAKCRCLPIo+Aiko
 1V0kB/4zi4Phlou1SrTZg8LRE6lrnUqLb8X5a1e/4rXTNWVNqN0zxEMWco5Slv+rZ2R2uOQAU5A
 xuW4zvkMAbHqi3W9924qQa3wbD41H/yZaSHAAYkDH46HVMISE65ngNFLCxMlrFZaeq2GY73blk7
 xkHaJK2dyFbj1x2eF7dNCEM5E3Zk3FQ8IJQXfsXORVp2hFQNEcEPce3Y8mv35040kujixVkzFL9
 VodjV+/aGp4oGVk11S9uRoUnjMOYfVl9WbLr+SdxswZ29Hap6hKERn4TFIdWCaia2pPC/vgQwxP
 r3Pg2tsr3L9lJcYDBD/84gC5dA0ymRS3CYGWdg2ma/x335oO
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On the Qualcomm RB2 platform the I2C bus connected to the LT9611UXC
bridge under some circumstances can go into a state when all transfers
timeout. This causes both issues with fetching of EDID and with
updating of the bridge's firmware. While we are debugging the issue,
switch corresponding I2C bus to use i2c-gpio driver. While using
i2c-gpio no communication issues are observed.

This patch is asusmed to be a temporary fix, so it is implemented in a
non-intrusive manner to simply reverting it later.

Fixes: f7b01e07e89c ("arm64: dts: qcom: qrb4210-rb2: Enable display out")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index 2c39bb1b97db..5bfbd81db032 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -60,6 +60,17 @@ hdmi_con: endpoint {
 		};
 	};
 
+	i2c2_gpio: i2c2-gpio {
+		compatible = "i2c-gpio";
+
+		sda-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+		scl-gpios = <&tlmm 7 GPIO_ACTIVE_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		status = "disabled";
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -190,7 +201,7 @@ zap-shader {
 	};
 };
 
-&i2c2 {
+&i2c2_gpio {
 	clock-frequency = <400000>;
 	status = "okay";
 

-- 
2.39.2


