Return-Path: <linux-kernel+bounces-242491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8419288D2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECFFD1F2515D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5B114B086;
	Fri,  5 Jul 2024 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="5OHvvjoQ"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C6C14A61A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720183217; cv=none; b=SUlz1bPBSBf6FrMwhdcr13IshOs2EW2M9KehGdlo6VR2keOVHb5FHWETya8S7TBvDHnb4owrc3h8npwARUAoZ4DAIRREa3APKJe2gaT3A/CxzDw+XKrfzl+IPTmbkG+q5QB81crcaIYqRDMznCWF5L0AW7GbXpI9wZlBhCpC30U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720183217; c=relaxed/simple;
	bh=Bx/r7C98r8y+Q01nth1t1QOQY/SzRCdAabao15b9jqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=priPQ/vOW7mxP/9MFu3jTe3rgsw/VSFxAQ0mdmppMQum/hz+Q/FoWwGTGMmYVO9hDMGPnfui6IY+T4sb4dodqPFL+fiR4ZwoJEQ+AP5xCpMmcFFUWklOtXQJbNY2dJqs2WdzawNp4hNGciDbbf4H91TqLnCfm/TXS1ySEb8lBlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=5OHvvjoQ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a77bf336171so229621366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 05:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1720183214; x=1720788014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7B3X1HRJq5YzkKC2Hubg20so80avGRngimSnJNAkkXU=;
        b=5OHvvjoQdFgQlXx3FxCIW76glNs9Li9alEOxj0Ll+beW4BJQy5HxQk+6Y7SAolzAF3
         HdRXTO01BvXL58iVmDU4AnL4j+q4BF4qzMZWvzc0A2YZ0XszC5tk/8leYhpxnromS6dq
         M+TuzsJQE0KlW+kUwPxGb9Ip+pPWAnCdNvom0YOcrFIGFavWDvX5cLQ7xVCh1jRz1f3B
         PNov9zWeKT51i8HgPqzM7WSnVbAE68LlhiO1K2UI9Ahh27XNV+zWDf/y2bNZGz8dxfdV
         uWoiaVwZPPhpSPxM+rfx3Z/4rrGyjgg1cIfSSea1QUgmQg1Az6iLvdHdnKSQJCBEqbRz
         0Nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720183214; x=1720788014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7B3X1HRJq5YzkKC2Hubg20so80avGRngimSnJNAkkXU=;
        b=aOR0AbOjAdWg6Sezs1JNNumfhImz9dK3TtPL7ebWgSJLFuP952XT/Pom2pK9YA94uo
         hY1AitWAdt/OunWIgypmEOAg37TF2G5y+bRnNdUSWYQNdaCzMSh9yB/6kXa8RQzdf4UF
         wXXeK/2r5otT6N5rE0av2rPjh84aTrGFlIWqR9C6b1Ain0MRqfCV3PErVbRsOubGhBPr
         tqwHuB3rrvb8zIc46nLplOBS70+n5RwluSSV07Z9ug6OXp7V82uunctPSJ6IwdlBu+KA
         kzoq9eMAECpnOxa0m+xZB5bFlm5r7Vw3ZlRU9XrRxKXoCJOQ0fDtLb3KFDsfGajCWQAG
         cVJA==
X-Forwarded-Encrypted: i=1; AJvYcCUoJzAtS8Knh5KZKVoK2pgJ4xnfK3/JLOwgcG9jww64bkcenHZMM/SW5N0xU7qvw+ASv+waFWY9eAsvytKrl27r0sMUEwsVYDs8Kqu9
X-Gm-Message-State: AOJu0YwlTUaB1LU9DvmS74CiN5aShPTgWguUKGJoccqKH6bosF8UVWIo
	GiMJyQtGsubaoboY0NXs7oPJXKfUd77YvwMpwbiyoGwL4jZaYgNT+LmOE29KcUU=
X-Google-Smtp-Source: AGHT+IFCemR+7bPg60avplVhzqJqo0NQegzU1N1nBVsF47D67mlHLzCuqqmaa0eis18ZgO2OLiFzBw==
X-Received: by 2002:a17:906:f8d4:b0:a77:ba4d:a4ea with SMTP id a640c23a62f3a-a77bda09b81mr331173266b.23.1720183213560;
        Fri, 05 Jul 2024 05:40:13 -0700 (PDT)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77d0908f51sm40930666b.125.2024.07.05.05.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 05:40:13 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 05 Jul 2024 14:40:09 +0200
Subject: [PATCH v2 1/2] arm64: dts: qcom: sm7225-fairphone-fp4: Add PMK8003
 thermals
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-fp4-thermals-v2-1-a4870a8d084f@fairphone.com>
References: <20240705-fp4-thermals-v2-0-a4870a8d084f@fairphone.com>
In-Reply-To: <20240705-fp4-thermals-v2-0-a4870a8d084f@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.0

Configure the thermals for the XO_THERM thermistor connected to the
PMK8003 (which is called PMK8350 in software).

The ADC configuration for PMK8350_ADC7_AMUX_THM1_100K_PU has already
been added in the past.

The trip points can really only be considered as placeholders, more
configuration with cooling etc. can be added later.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index 4e67bb80a026..e263010c348c 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -136,6 +136,18 @@ trip1 {
 				};
 			};
 		};
+
+		xo-thermal {
+			thermal-sensors = <&pmk8350_adc_tm 0>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
 	};
 };
 
@@ -712,6 +724,17 @@ &pm7250b_vbus {
 	status = "okay";
 };
 
+&pmk8350_adc_tm {
+	status = "okay";
+
+	xo-therm@0 {
+		reg = <0>;
+		io-channels = <&pmk8350_vadc PMK8350_ADC7_AMUX_THM1_100K_PU>;
+		qcom,hw-settle-time-us = <200>;
+		qcom,ratiometric;
+	};
+};
+
 &pmk8350_rtc {
 	status = "okay";
 };

-- 
2.45.2


