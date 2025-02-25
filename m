Return-Path: <linux-kernel+bounces-530982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9654A43AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7DF1164391
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78118267F7B;
	Tue, 25 Feb 2025 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pNHBVcO5"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2236267B72
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477565; cv=none; b=SExo543I1+htq7Q4dUBjh+cElDQnwgyxWfo+cah/SC+JLrfguPjmQdP7ACRpP1jvZfHDLRc44/zG0U8Xl0rZzUsDWMABGjdKwTlMDiduVLMmMroxxGttAKud6mtCuZahQ5qWK7DEED0MUEshk5n2IYEwoHO4VZTYTAmpEvgZPvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477565; c=relaxed/simple;
	bh=PHhn7wQXwSAnPlOc9CJuQaRSaQL2R12W2WrGC1wsw0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LsbWms+byUbDqY8lZSsBkPGHBYG95YW9jA/ha+nf9JXPhjFKH3TVvWivxU14hiQ9vnLTWz3kjIv3n3AGKki6/iR7SFCMT1bNZdPKHIyLijn4whCDDK8YFM3ctKFnIxDO7jl2AMUHPZJF9p0DjDcPgOkwUZE+DEpz6v9Nso7S4vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pNHBVcO5; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abb4944fa73so79723966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477561; x=1741082361; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ma756ndc+pIRJ/H+gAq8ldxRABYUB9ZZKe2x5wsM8AY=;
        b=pNHBVcO5dC8oq5ROLhGCTIwd2eTJlmR7GIGI18pS8os2XPdSvHAAU9tx5tJpPMah3N
         5TIIcB0AwbMgQUmfdY30yuvAjOuDNCdtIHG7PLSvIQx9AzBm3Pyrljp1RYCoIhXCeT6C
         fAZOX8Ct40MwOQd9necdt7hasaE/iq7CmAF9FSnFJJqOfYG3MmKRhgRyVXcn7BXPblxH
         x2QeT326FxPZs/Y6R7J8oVYhU0FKDZ59ATMYPbqAkoh0tcYyapMePvx0L49hbJHgICJE
         mPfciNy1Qz2wAOlknljt+ixbryGlRTCqo9NrOl41Op6NZW8NxnIziRsO/DEQpoV/Zi7/
         fWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477561; x=1741082361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ma756ndc+pIRJ/H+gAq8ldxRABYUB9ZZKe2x5wsM8AY=;
        b=TCDScvN/Xs/OStAoONieuJpsA626D7GC3kq340BeLCdIFbxbnu0v9HDwqocR7JZlCN
         DZROr64wgawq/FoLZjsENr0iOFGfQuMxLuVPRkWaVl9Ww6Wv00H2QGo5unii0/zdqCCa
         srwrE9xaoZK/vLvgxaQMvwPEE5uv5qZisgzAynyGBQc6cqElo7kj6kqndIRiRG5+afkJ
         a13rXzS417jB6A4ibmpEK1r5zpSN1QwifLwLJ6RSlfGdnlzasTJPPqRTWtCqFJgyoHKl
         jORDa0BpLWiQSIsRF7bAlnVolPnrTDIb88f7G6F2yoQe+VEORogiS0q9I8zRSB7s1SQg
         ra7A==
X-Forwarded-Encrypted: i=1; AJvYcCVzMZllDzTF3vsD4JJ26jvV4NE6PJdgDmNK+IDHX/SJTSoZpvruIBpTKI3c0llXcQBIOCvyjV1YI6u1Vcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn+xTCLM4bQuhLzgA6pGoTkc99Vz8EMFrsSEyqwa2FHD/BIoc0
	6G9UnpHVT5HwmqmuIw/UA4WFMHi/B3jLFvSHgvcrcw/N/DggwJwt4DzkgasIp58=
X-Gm-Gg: ASbGncu2TpFLwppMRvSnrEZdxERsZoDEAchmoejwb9LdqiPXrUJBYKkkjwLKEAuC83S
	b9SxdVsBwKXq/XDNSFY4d1b1qwQiNObeDs/x1HIJwf5RqX76UupOUgsQz5xM9t4T3hIPEDjGBr1
	pZrU9qTcNlYSoTWhbt3ED+nMixmh+RZIZfHWbVlKDiQ753nSS2XSRGWaOEK6qLf4vFgjnKt6O9g
	XCCvg4YQf5wHOV6WMRoAala8yoRSjaLLSQE0LHPxT7E4GYbMUoyAj/zoQwVLmjnhilH29AR7lvc
	p7hxZprvoJy4WKib529npnrw738sIbPyoeC4oQL5Q/Ccr6BDqouyN0MIF40P3JKkREYKgBYeUCg
	U
X-Google-Smtp-Source: AGHT+IHO13ZymScRyMKMBOez9uWuVR12jpE5I+6oXWsaXHjr7l1h3h0TjIvmOvMfQNObJNShbvXV9g==
X-Received: by 2002:a17:907:9713:b0:ab7:f92c:8ff9 with SMTP id a640c23a62f3a-abc099c6f28mr692870366b.1.1740477561225;
        Tue, 25 Feb 2025 01:59:21 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d59391sm115164266b.56.2025.02.25.01.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:59:20 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 25 Feb 2025 10:59:00 +0100
Subject: [PATCH RFC 03/13] arm64: dts: qcom: qrb2210-rb1: Switch to
 undeprecated qcom,calibration-variant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-dts-qcom-wifi-calibration-v1-3-347e9c72dcfc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=PHhn7wQXwSAnPlOc9CJuQaRSaQL2R12W2WrGC1wsw0M=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnvZRpTkEjFODry039YOD0/5jOw4saaEcTaE2h3
 p/sVPQKtK+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ72UaQAKCRDBN2bmhouD
 1/gSD/4ulGFlVuLZF9SGnbZ62nru4/SM6ti0xw1YAR/cnSiWDq9gsLo37zipWJ5WWVRVkTqH2fd
 RwSHiqEReT2+MPe9tUoIYtGodk8d5KpOOf4d7h5bfTFz6uZtFMPeGlHtJdZeYu1FIvNHXWaJdte
 /b5ONfDNRvxYQG3k29bbTQUApwVqXaiNqrr6cjR+QBqppujIgI3OvNiq6aURjsAdOz885bQrH1/
 g1TlEIAcWd277d5lm4+C/QPkA4esO1HYYsACQRVE5rn0Z6va9SoKaTahg9sb8pkQDY27RvDqov4
 +pu0oQl+HbBMPUfVOtC3Jv3jbrNjcjH+mKIvFoUJ0AYWkk4++U5XkL15Wd0zArmWNzLA+0rrIzh
 rJCcHDnQfb7j8EQKlx24NJ6dP9L77FzedUcSb738rlPv6BjM5YDtxD/76H1bNzVxyfB4G/rr6o2
 J2Sc08qeFRwnofZt+zPX10P1Bj/sq8snua4cvAORCXiC52sGvJbTDknWG8rDF3wYsMy1oaOs/CK
 f/QT0rb/zSTTT3/TUwJ1REOLLzumwU1K9idlv9iJT4APd+WxHfY15k+w3aFCPTB5Kfm4EmHmFMC
 1obAWb+5aVxv1r1hxuQIaU/UWDH6LSqaEUW2/NJ0mQkBzzSunxT7xuHdjpfDuLm9EUJ3WC+trnn
 LdHf7ft9C0b4mzQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The property qcom,ath10k-calibration-variant was deprecated in favor of
recently introduced generic qcom,calibration-variant, common to all
Qualcomm Atheros WiFi bindings.

Change will affect out of tree users, like other projects, of this DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index 7a789b41c2f1887f0c41ae24da2e2fe8915ab13c..bef1fa782f1260e95e347abd52989d2da490af98 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -620,7 +620,7 @@ &wifi {
 	vdd-1.8-xo-supply = <&pm4125_l13>;
 	vdd-1.3-rfa-supply = <&pm4125_l10>;
 	vdd-3.3-ch0-supply = <&pm4125_l22>;
-	qcom,ath10k-calibration-variant = "Thundercomm_RB1";
+	qcom,calibration-variant = "Thundercomm_RB1";
 	firmware-name = "qcm2290";
 	status = "okay";
 };

-- 
2.43.0


