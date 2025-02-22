Return-Path: <linux-kernel+bounces-526849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FFDA4045D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 01:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 903C6703C33
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92A81386B4;
	Sat, 22 Feb 2025 00:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IaP6DH4f"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E85B7FBAC
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 00:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740184998; cv=none; b=OPEhJVaMHfcFNV3sRN8/8TlInctDnv3qTdgymFNHAxZFTl518PJgyJr6jxb0t7jEt41OClZrp7lgt6zbmEVn2Vs2ago2ROrK42gA5J9Gty9Zih6OIt3OyJZk1wFdVHnRpkD9rFID9xjPQyzR9vWeEhiTpC4zWHEeaw3I9ARqcek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740184998; c=relaxed/simple;
	bh=h659/WKfcn5WwoTnAvkJjpAMTW/DZlukk1ZVdjhaNZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mFum+XtPWJ4rmrLPEq7al2LQq/GFd0sSGnVheCV3cZz+m60bba5WNUFtjZiQVe3wV9lXsmk1IZJeNBHnDcSPbdcPiL6ZX3nYaoGHIpL9JsBXO3Kr6N43S0SaIy3jrIeyvqEJA4gJCvc4PvALoq3IOLLbZsZbxqiFNRbnXM3iROk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IaP6DH4f; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3091fecb637so21414231fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740184994; x=1740789794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=22JGoNtmwRShonr3vNzB0tpp1V2mDr55NA4QKdUlXvY=;
        b=IaP6DH4f9FVzMn/8ok9I8CJCS8E/ceYm4B2w1YbQuJzlrLU9+i+WROvCpgKl4Tz149
         hjpJXA3EZkiPIviFqhCec7orI+2qcQALEk1zqTsP4UtAMMD4AuIHH4xnPVJ16oM+V6ik
         bdZ3SXWAcc0O73WEne5cMaNC46SHLAGy5CU6qSayd2yL8eFtWv0mRLLrX0ggaz0Uo6bS
         ca3dR0ZAOqnmXYUfx1qEFdBs76K6wTX+HxuOKiVYa3ZVV6gSSpz082TriQb89kRWiBYC
         bwwONiaY17bEASnVA9nLVv3iNFrlV4J8ZBmKlf98Jkan2U9rKV8RU6FPAhAlndD8bMH4
         IeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740184994; x=1740789794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22JGoNtmwRShonr3vNzB0tpp1V2mDr55NA4QKdUlXvY=;
        b=HRIVXqsU1L4XHYbqooonqZQEIsxluR8nfi/Zja/CPokipTDAKQAmAUKdn3JTOO2Za0
         W4U2JdtyI3vCynL3vjIiW6Sweg00F2nbDz8vVxLIXTwkSVSEXgBVdsGAdMKQXUOM6Cih
         ijo/pTKaWK9doBbxg6BNVGRFoVf/ldVgLhJGrdI4Vxpg/4Irw9/S72wrHv9brR2o6HsP
         LTh2XvRuEeWj+sOBelXePIgPLL/rXelng4RetVPF4c2k0+iZEVhbdfVLWHeF8swGifGc
         4znin2i5+he2XA8zOpROg6hF22c6axmRTxvlBnyRY3vnegvJxGXZxEFMWKHdkdGFDaZs
         hzPw==
X-Forwarded-Encrypted: i=1; AJvYcCVDe3rogxUKgfDdArI2QoJityvI30tPHh8fSlFnhXah8fd/upTIxS7Xcpi/rTvlghjNThyusDcVVutSPvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2HgL0YgGTY8taVhzZyHdaNfvaLpuqim2ez0hx2q1A30aBx/E+
	dbfNCH3wUhkyFicSjpvkcREj4wLQNIRDxRsTO6ampc6mUfyFS7TIj4EEUdsyw6UbaAWEsGRiM/E
	8
X-Gm-Gg: ASbGncvxxFw1huLdYKb0w+AMYHji6SMgnbx8cdYVFob+ssdvjb8i0TzDCxhGJWgVYGN
	+ZBHMOtSSf56kDzBF5PnK74q7eE/oK8CpM3LSfkxSzXyJWVgyebHw4XpF/YtBAmOHWpcMfAA1D8
	P03e8i3A4/kjZ7wGRaK9UI2adQzaJ+Oip41nXaT58gy7fzDFztfaOZ1N69dq6DZ5W1uZoAk3SLj
	upHG5zga59aqbxEAWbi7WxpbHXbOK+p5i3tobkL3VM8HphmvGCKquK1BOYyzJ5U1ck7zdwYwLvW
	UWHYyizrb13ZBMA14+xRV5wsO8bvGpw+Jw==
X-Google-Smtp-Source: AGHT+IHKnJ9N9n5dWZr5lMn5Lt5+unsyPJYgSkWvxGRGZuPCLuuglDmOcp16SsgwtVoFOQwHuCD9BA==
X-Received: by 2002:a05:6512:e92:b0:545:d72:95e5 with SMTP id 2adb3069b0e04-54838ee3384mr1892856e87.7.1740184994575;
        Fri, 21 Feb 2025 16:43:14 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452c301175sm2412090e87.139.2025.02.21.16.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 16:43:13 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 22 Feb 2025 02:43:05 +0200
Subject: [PATCH 2/2] arm64: dts: qcom: qrb5165-rb5: enable sensors DSP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-rb3-rb5-slpi-v1-2-6739be1684b6@linaro.org>
References: <20250222-rb3-rb5-slpi-v1-0-6739be1684b6@linaro.org>
In-Reply-To: <20250222-rb3-rb5-slpi-v1-0-6739be1684b6@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=842;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=h659/WKfcn5WwoTnAvkJjpAMTW/DZlukk1ZVdjhaNZk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnuR2b3UwUz9bHsFt6poyrYwU54etr6WiysTFZO
 ilF5Pd0DUeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7kdmwAKCRCLPIo+Aiko
 1Z35B/9m8BtjvN74O6hF9mQezxrtsux0MZvH2TFEjbtFsRW5vSUoMrZGoUgCDvj28gzq19kUlTD
 +jIDAE2ORJOWCYI467XHGCnWecDNl7+ynevM815okw/oKDSLqgNfwOPK8iKjdVM7ndE9sUzcR6B
 c3c33XCVx3hZBsIymZaXrcY97QUsFlcM06JN3hzduXO+nz8ZQPbQSP/EoYs7JzGgNf9WI2TRoUg
 7QcEVdCT2xcZsGlvb7zyQ3yYiGalhNtk5BzpYrzNOHSAbwNDWI4OqilXI09jRURZb8nOsLHzYOo
 cbNxwKCVfVR8AKAkEx2MOuZKNrBmb8NYm1M0jPFX8FpCiOCm
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Enable SLPI, sensors DSP, on the Qualcomm Robotics RB5 platform. The
firmware for the DSP is a part of linux-firmware repository.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 7afa5acac3fcf7cb6f8c5274acdc2e55192c1280..15b1873008101d166cfe1b2818b6f9fe61aefc9f 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -1032,6 +1032,12 @@ &sdhc_2 {
 	no-mmc;
 };
 
+&slpi {
+	firmware-name = "qcom/sm8250/Thundercomm/RB5/slpi.mbn";
+
+	status = "okay";
+};
+
 &sound {
 	compatible = "qcom,qrb5165-rb5-sndcard";
 	pinctrl-0 = <&tert_mi2s_active>;

-- 
2.39.5


