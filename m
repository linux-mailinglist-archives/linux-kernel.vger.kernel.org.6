Return-Path: <linux-kernel+bounces-530991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CE6A43ADA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A415174E48
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A5B26BD9B;
	Tue, 25 Feb 2025 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h/s5x4u9"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936F226BD89
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477577; cv=none; b=Yec3Q9F4AZitHwN5caMsluRAtOYVGGS3j4ErGLyAjl/hDfFzYa4j4lsKVRMIapG+L0IBJhruzPxa9fzi7Tb9NWq/VtodKkRtmqKugItHwFIMwlFVCLUWQMg2f5Vj5zupSvvUcFCE9BPnRjbsTYjTSglQL2dGZImUJyw70j2kxCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477577; c=relaxed/simple;
	bh=76VZHvoGl2++QFzu2Tn25ormFyuq86jktjXj+TwuVxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r7C9jSiyhiGYYOTuEUJTKBxCDEQz+YbKCks6dINqm+s0O0VBQxyxj6NusTagVNU3h+8UHGqsAVdk/Dqjq/+oGrLWcnjC3ZKQFem82tA5v54vsvftMWn0bmFcBLXX04BNcoj4QSJLYTaH//7esbEmGGrO6yQifDncKmiyU/AaaTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h/s5x4u9; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abad214f9c9so100205066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477574; x=1741082374; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XiIThfQhXbrAwQXkj4ANCL5DLfu4LkbUJBGwh3gL2H0=;
        b=h/s5x4u9GynBbtW2m0prNadf4dB+O97Ml3Nc9C/vVfk1YUuZDE4S12FxmvSRBX92i5
         A22186uBPFcvV2WjV2ws9xeooz5FkJlKi8J2l+yEFJGXnz6T/ZMd7/gGITgFloOuK/dY
         i4G8noGpR41gzSGr/tQbBlhYCP7VR58O0KDMg+iOnZ4QVQSlxoga9WMVAmYU3OBj/zbP
         BTkqxNy8AeaW6x+T4f1hMvUoFHHSVyKsEDao9lgpLXZyizAEuB7+AQdwKyfielzRWs2v
         uO0o4xQDrxDWhOtZaWGkN/Rn39RAjmw41/keWO2xKhtvwlUCoZfMVIlkz7jCApThMEqc
         1K/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477574; x=1741082374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiIThfQhXbrAwQXkj4ANCL5DLfu4LkbUJBGwh3gL2H0=;
        b=COigLghhRGK4K884kHbuQfZgbKIVdCxpzviAnUHWWf5vkfLNnbnOCuApaN/fu1MC8T
         zjtdLBfsaNbj/3zIrumc5x8TQm11qAasHMtk4dDsyoHoSz2QZLPO6y6hkmpKl4xPgLQr
         Bkl1LxNMjIfKTadHMIbwxdZqc0DXX/bjXgPyljpbTfDAEM+fF9pK6f30di0OQjDmjQyw
         DCaJoNZ+HOcTh7YgCRgw7LlN+dA/r6+mjQQ5VlcUAIbv3nQSqNrZX94WrI66FLqLqv6/
         gYt3wlGFWzJzlAtfbiVZFrBEUyM/J8XIM9/wwLu+zp0uZeOFUfngb/+dBfWQJDILRX5U
         XXBg==
X-Forwarded-Encrypted: i=1; AJvYcCXUjlkbFrIhjWGktc5S/6BVipRVJ6900PdpKOWDvteKmNhfgHPxEO7NKcfOUJqccWdkTrDbdOt8ezDMAxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx24ShlqvKSmCsyxLaefBv+LMCTD6y+78193ogTCOaX7zOFM9il
	WfUgM3EqPOhmM1oKGIsppCg1RRjUqbD85qBkWnatB7bkZUCpwHM3WCQrr9/Ioeo=
X-Gm-Gg: ASbGnctSnQJkep6bb9mI+W4RcX5NN0hc8eFjGXztABrQKZIRQGLgMJSvIT76jcmza8O
	NUEQrgwICGk977GNEN0GbZbbJ1XMiUm3qXuwolmZCuP4+aODLtnGokwxdy8x1XriJ3VLMoIhB9k
	SOpQrHRqtQBnTvktx7Q4KWr6RlDNY0RtcgTDuJ2uNLL2dPDStht6EWnre7J/2OaRUq6d9nlEjIz
	u+kHx1Lbm/cwQWuv23XgW/pv8/8pl6KXoLbbJHLcll+ldZhhad1r2OuG0pMuHO3HQCrgdKHZarQ
	myvXlC4cti3WUss/D04xCwRVTJZ5Ei1IQL1JcIWmT97yNiQ7+40hArazZpPrxxHXyhy3j1Wr7WP
	I
X-Google-Smtp-Source: AGHT+IH0qoPvOYRi0pePLNvXhRbHF8zF5niNCqAPsdg+fbP34wi2Jh+Xdz12/nQ9fJRspmsGttxh4A==
X-Received: by 2002:a17:906:16d5:b0:abc:37ac:6e6b with SMTP id a640c23a62f3a-abc37ac700emr359955966b.7.1740477573805;
        Tue, 25 Feb 2025 01:59:33 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d59391sm115164266b.56.2025.02.25.01.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:59:33 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 25 Feb 2025 10:59:09 +0100
Subject: [PATCH RFC 12/13] arm64: dts: qcom: sc8280xp: Switch to
 undeprecated qcom,calibration-variant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-dts-qcom-wifi-calibration-v1-12-347e9c72dcfc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2940;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=76VZHvoGl2++QFzu2Tn25ormFyuq86jktjXj+TwuVxU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnvZRxY1lK6BA3X8D2PkQo2Zk73pPTEhp1iJlqF
 tekyH4nhwqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ72UcQAKCRDBN2bmhouD
 1/I1EACKdqGgySu1cN0spu2PswY2EOusmnSep+i7rhEWz4ZTr0D6zx+ryGyHbZGeVFtlMFiYfA/
 wm4u7P+tJWG4UDMSOMzzLUg3qgiZIEj3SbcAzx0AjieV3JMoeSy84JxZpNHUsDwagA1TXGcAOHy
 rG1JOnw7WyQH/viiP+S3XQfjER8mY5uKlBeCkfXxfnvAJrELhTcHkxUHnY0ehnS7W/lcrw1MknV
 cJw6iKmJOlHRt9p0SGZHg82Rr1WtFI4NWIpbAUhlrrqgavblrGi22vOj1nECf9VHY4dpkaMtye/
 C8pj8Hfk31VeG7xs2C5AHqp74QJzCSiZDIzq9g01mObqqknJfkm5OWF82SmLzcJhvnLo7dq2DVD
 3Qmg/oJkGn+0mKmFYc6Qkw6G1tb5bPEaXDzhVSL3BsW1wuekcLDQEnaUo6nAA4fmyZxdBkMpLQ8
 V/w2r2KJnZL9mxxckFNfoNKYzUd6b39FZQXF4W2kz1yk8fcZHFXau+CmYsV2n94KspRRoYOfcbE
 sz8GSPGXD4JnjWr3vvwmx/j9caKtRSP8kuzfaKQqEEwgo2fB9H4hTs7JYkoPTVeJRdHG7S77wbs
 GfLLNE3qStTSOf74LReieGK530W680E74s0GcECz0Oryqh3/Xl9nopLtrNudemYN4QC0y9c1i/6
 utiG7lsVWQ2+UsQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The property qcom,ath11k-calibration-variant was deprecated in favor of
recently introduced generic qcom,calibration-variant, common to all
Qualcomm Atheros WiFi bindings.

Change will affect out of tree users, like other projects, of this DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts                  | 2 +-
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 +-
 arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts     | 2 +-
 arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 75adaa19d1c3e0c8fcad40c7d0b0afb504331d75..e7251b76d91e71e94029acd765b927035c2b38e6 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -686,7 +686,7 @@ wifi@0 {
 		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
 		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
 
-		qcom,ath11k-calibration-variant = "QC_8280XP_CRD";
+		qcom,calibration-variant = "QC_8280XP_CRD";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index f3190f408f4b2c7ca9fe368d652d5d66bb3949af..6ddb954a04fd611709a8a241b16f85b589efb691 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -998,7 +998,7 @@ wifi@0 {
 		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
 		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
 
-		qcom,ath11k-calibration-variant = "LE_X13S";
+		qcom,calibration-variant = "LE_X13S";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
index ae5daeac8fe284bbec86622c10e6831d60a25297..d00889fa6f0bac01d326dca9801c66a508ff1d67 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
@@ -536,7 +536,7 @@ wifi@0 {
 		compatible = "pci17cb,1103";
 		reg = <0x10000 0x0 0x0 0x0 0x0>;
 
-		qcom,ath11k-calibration-variant = "MS_SP9_5G";
+		qcom,calibration-variant = "MS_SP9_5G";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
index fa9d9410505226f70c1b1283a7360bf3a56e8c4f..812251324002b50f3b48845b6c244f692d42b9b2 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
@@ -670,7 +670,7 @@ wifi@0 {
 		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
 		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
 
-		qcom,ath11k-calibration-variant = "MS_Volterra";
+		qcom,calibration-variant = "MS_Volterra";
 	};
 };
 

-- 
2.43.0


