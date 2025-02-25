Return-Path: <linux-kernel+bounces-530981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE6AA43AAA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CC1160FF3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499ED267B91;
	Tue, 25 Feb 2025 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HMzQesoK"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7D0267B1C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477563; cv=none; b=dDBl5zQci+IKwFKh7u7ReFiXp4DCT+3xYMl6P/jUrn57/LqpzDsYUIWwfwEPdfSg0/KAb8DJsRJcTh2ZSVyPOJ7cmsDjucpWwqmC07wtK/jhJGMqRO6zYakEopfQhwQ0Vy0UhZS/DUqgIt+zGnomdcPPEI8iwD4IRPqktseCOcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477563; c=relaxed/simple;
	bh=WE9dgMDk94L26TE3o6edZD+8yFJ4YY9ACaejqY9X1s4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PgrBoXS1WasPWhZPXhvszAVcfeHXD5TV0kfU/uQ29Dj4rf6QFpHEb4100xpjTzp48sBTU4QWAspAF7lynbgghz3d5U8e2lG+vff80wVqCYtCFE6Bn6HzP89UX+rEFM4IpO4knUYBSUDBLxQJG5eBR35EUvuwQPBRxCx8gnojHLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HMzQesoK; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5decbcd16d2so1050690a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477560; x=1741082360; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vitMg/JdavxTQWg7So3ThI1uGGcw468ISbczDQMGWr4=;
        b=HMzQesoKrA65YlLdfAjgTtOubYcdDXeme/VLJ4bm0eVkyy8ddbHVCoEER2VWMMO7OR
         nk4ZKZY8RRK8WYTAoYjP86y74LQAD9WyVd7GUuv+SS5Cb6hKKRf3K2MTnGEJ6+SI9xoP
         QFxxzMaxQZ4PqSp8BakuZNPebu15oECf6ACGzQaK5oPWO+hRoftNeSgvpvxG9m1zkbr2
         kQRw6ESY4ZhWMPTuli9cw6RwmOJeHSZPSO/9gJSQ3ErDe/hB6gxWDeOEyk+SMFk7rvMF
         f7mXo9TxZbe05DWqNdakjNijsU90ZAGwj8FVUu4R5kBeY0difSA3+C9wgMcootMvjIm7
         Vk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477560; x=1741082360;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vitMg/JdavxTQWg7So3ThI1uGGcw468ISbczDQMGWr4=;
        b=rVlxdD9W7Vs+whVrPELXeZpKciFkICg+SuM0uhMUKoVufwd2vmpoiq/R7gPy+aJJAQ
         345/nWl7F5vKeA1B2D/+tCBpJkITkSHDKEznTZFawoaq6o28z680MLGndgynaUWxWgT8
         5rvX0MyeHvd9mzswZmSkyeKyuPPSnfw61XLGe7fht3uSGdAbXVQMYLcRsVBvpAJ9edQd
         IklApuqI7aWXbF8PAzAe6WGdZ21iZFr8RCqyDBF+deXr61r5oXWvN8w/z3rJ4EkbIz8t
         yTZnAT9dx6Jsdb7Ow1YnHJbSXrdaekvRs+/xbOXc7ubXRhXY3rf6cTSuYkSCKxhn/4n7
         qI+g==
X-Forwarded-Encrypted: i=1; AJvYcCU/VjtRaUq5JVA6oBIKqzIrQCteSDKScB0DbIrMIaYyxtBSrHfmBWvqdKuwKbu6PbNEPUukstgsM96XbQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YweWAbKnCzSwReS9yfkv2cYnFbwZymeyrTWY5FU5+GCFXOCEffL
	qB369/x2xOCxqKoFUUMO+4bjQXKNe7tUDF1P2YjI+nqkB7lD25agftbRiX780I0=
X-Gm-Gg: ASbGncuvRrEkhgDuddCE8sjGmVVv5qOdF1N5ldQkpQuq4nTqTlUWXLU/dZ4Ekj5v3TE
	uEMbuHUSc4ku+Q8X105809geckbvsrJMAnfjHHN8ueMxWBE4zEEQ9zxVFZcdiRfMwvQEsLaFTVk
	+33YEsaVt/LWyLWjg4U4dOyqxHhdV5dCLg58yjYHc5OJNUuqp2pDrX6Aq0LZX/qwU6eWN3+pEoz
	g4khNY7mgPsygZ9cQia7H56kxEBiOvKdQplr0JubEjCmiFkonB6J6v5RX+E5wZdnTBEG/Kff4fU
	QtXto6te++QBICjqLIuq+Jmja9ChfnRgc0u66UX5He4nVuyTae8u1Mc3KMCfbYuSrRRLkKO2diB
	K
X-Google-Smtp-Source: AGHT+IEkszTAFJYEjfFONhK1AW+il0Z901P0AVaHZssDWv/e0RR60wm6bTM6+nsV6uq/3lMpZ1ZxAg==
X-Received: by 2002:a17:907:2d20:b0:ab7:bb4b:aa49 with SMTP id a640c23a62f3a-abc09a0bf7fmr683716666b.5.1740477559752;
        Tue, 25 Feb 2025 01:59:19 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d59391sm115164266b.56.2025.02.25.01.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:59:19 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 25 Feb 2025 10:58:59 +0100
Subject: [PATCH RFC 02/13] arm64: dts: qcom: msm8998: Switch to
 undeprecated qcom,calibration-variant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-dts-qcom-wifi-calibration-v1-2-347e9c72dcfc@linaro.org>
References: <20250225-dts-qcom-wifi-calibration-v1-0-347e9c72dcfc@linaro.org>
In-Reply-To: <20250225-dts-qcom-wifi-calibration-v1-0-347e9c72dcfc@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=WE9dgMDk94L26TE3o6edZD+8yFJ4YY9ACaejqY9X1s4=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGe9lGij20NQqEKq6YTDywdUOWriyR7E419074VLl/cKCzW0r
 YkCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJnvZRoAAoJEME3ZuaGi4PX4CgQAIpn
 XupluihXS0D7/6lRgI2pb2I1tYF1gciuaYOSeeAjjCJXHJCdUOeS5KC9TmnM+6XU3jUglSu+3Rp
 BquzMUb7jYbV9Y8wn5ybG9gtvAAA8K9IZnFqeq9UOcLJIjRJm4dZr37jafThpp8MCUHXp8KFJ6D
 HdAxZJl70m/ItYP9bp0C/zt5biBpWu6PGpqhTGl1CHoxobHPMfRtZ27v71a4V6i+53dXRxaCwpB
 YxWQdxUGS6G7ETZfMOJcXJ45js/6UXKh8N5jY1v2u0F6XItzESen4xMPpNiZ71UYrZSIjVNS7tW
 BBuORLXKyvWDN6ZnfXicELEWDOuXAMcWseFWdou1xUYc8cnLYccTST1hImIFlhhclwKVbgNiXTf
 8nvgScDfVgKuCizegtSlVFCB8s8ocC2PXGzP0YrMBe9wuKf+z1Dx0IpbF6KWVuTamdCGP3sqUUi
 L9g3NdCXFJM0EW8MpHl2DIhhU/cpw1aBE/8F/5QMSKacu71OxW8+CWD9k7EKo//Q1D4YNBxPojy
 U2uHOYsaFR53zxajSRno2CHwYfJec6T0dpyVqgN0AyZMJk4EfDQ0KqeaVplfUuhn/BT4W3JgsAZ
 Lbc2g6HmMnoMiZwJDtRntYxfZKAJdmkQS+CJ+pBk5R7/HcRrkNK+9f54Xn7KPgZk8shVsjjuhn4
 jvoO1
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The property qcom,ath10k-calibration-variant was deprecated in favor of
recently introduced generic qcom,calibration-variant, common to all
Qualcomm Atheros WiFi bindings.

Change will affect out of tree users, like other projects, of this DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Please do not merge until corresponding driver changes hit mainline (see
cover letter).
---
 arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts b/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
index 901f6ac0084db3df02608b2e52a8e8837aad7d96..f160ba562b0af505bdc1357731f75a394b5eeeeb 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dts
@@ -101,5 +101,5 @@ i2c5_hid_active: i2c5-hid-active-state {
 };
 
 &wifi {
-	qcom,ath10k-calibration-variant = "Lenovo_Miix630";
+	qcom,calibration-variant = "Lenovo_Miix630";
 };

-- 
2.43.0


