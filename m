Return-Path: <linux-kernel+bounces-431322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA899E3BF3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A9916411F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFC5208983;
	Wed,  4 Dec 2024 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XOv9OT13"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852DA1FBEB4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320838; cv=none; b=ilsHsMgJSCYO9SxFm2A/G/hN6pE9VWXAjl5HDQdgMDaT8HAH51I5aURqZXep4RSoQi5qihJRK7c9lxocYlPtgnIKYy5MsVKvdPwLolwCLyuUF64ZbcH4jtZvCZC+QDrCciKqHxNOyc53bCd4lOKOUuodt8HAaFBbmd0mthkmJLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320838; c=relaxed/simple;
	bh=oQlxhyNXi4VLEYzBv6Mg8vKwQUxEbTCMppfaXRioQD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdRnr3KUqMRx46XpyVIN1zRgV2LeclTTj8tRHUC4YYJpYnFc+nr4Sj3pLnTmyEs3WvHfUU5JZwpli7LIUh6FFDmo5UYu0mn07ye9RN1UhoDrL+lnj2BSVK8oKlDOgmR8mq+ThCjriuVE0tA2Ek2aCo9AanQKx63OMpvV8g/xvhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XOv9OT13; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a2f3bae4so63427425e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733320835; x=1733925635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wo1Wzwh3Br92Add/ZhBjQllfXt/4cGMlJOhUAuIwj4I=;
        b=XOv9OT13Gl5mM0HtNkz3oZJNM0Wfj0NxwXlXp2obUn/8Nhr7BQui3fSrQ4UMO46WcH
         jqm23aRMMXDMmFwHQ2QP70D0u49233dZ8F4DJxa49uoraaxx4CGoYN9Wor2qeOKI8JQj
         huzIuFk9LxwmPxIGfmMI/Q5ybd5OZwjnk9SpGzjwyoXa3XHyZhLkpD/rVMx3ePm39qBZ
         alEWMJQs5+LqW1q1CTsXNNDDc+FNsTF1R3dI5E16gzEUUwWB0ZwOvnjgeclA3SRaYD+V
         bk/Otn3LD3Encxtt89RvOos/GcyWNoj+XpD5mMNeM7C0Jqph71qb4xMMYHUoP8YIXILv
         1Dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733320835; x=1733925635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wo1Wzwh3Br92Add/ZhBjQllfXt/4cGMlJOhUAuIwj4I=;
        b=jW2O0cP5iHQvwW7sIPEgD2+/H4/MylRMNRXhhOw7snY7gwi4dgiNQHMlp7bvMfbbZP
         ZHK9kEufALARZsZyEsFRyTCurcO4CSIv1tTFKHmWDeGEHitsEjDNWC7l6c0O3hYZS50r
         oTLvxzq30Ns24835ZvZeB0z27DYBHRBcMtTvdoq1Jw3pbgRGacYmSbB7NF6RWQFmOs0g
         x6T//jU5FuMwiyrTndxwlQq1hAyDYzFjOhOUrX7Ej3pC5ev7CC2oB5KGefyerBnmqouI
         GJIktlhGqZBeTXAwNGf4dfGgQaeUHVf0cbSuXALH12sEtG4EPN+hltocoyRrHvSg4IsY
         evQA==
X-Forwarded-Encrypted: i=1; AJvYcCVWQjUYZHokbuSP6bGauJBBfvv4d0dHw5UWIK1DqguBpCSYFE8tgFid7onyznATJDFAzKU49vNJqWU4by4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUtvwejZ76TW3eykVwQlFcPYL+5vjpBtfYT9+p/vsRF56mvuLN
	2IcPhOIRNrw5o9GNpONmYTJ7qasC6/vkJ3cdD9TTD93YHzZg5Q30HsFRqyHZq7E=
X-Gm-Gg: ASbGncveLwJ4LQ1qMbMTCCPdXitgV9E022itZAL520C+3PadyT8Gxz20DU6N7R7jTCV
	jwhd+zaixg7YKcocHcjk6f7qi/bJg/4zxzmDguLP6PgGKDl6NmO7+fyeyNhQFpP9yuL0OizPQb1
	v37P9ewJN+DIUG1I7NNuL/huV6Dh3fovlvQizyJSd1WwGwn+/AmGrK5Feslm9No775SxA9ycQP0
	RBdUUTycgWQIyA+mVBW24GcGpD3hn2T1lSEsvo4068u409sr4MSjnfRZpAmacsWm4KwZ78=
X-Google-Smtp-Source: AGHT+IEz3Wzkbnj/7JvjYGuWMu1+ciM8h8hDG3as1EYvNSR4aLNyIUb+eq8UmZ+7LI9j3XWrrIrsuA==
X-Received: by 2002:a05:6000:210d:b0:385:de67:228d with SMTP id ffacd0b85a97d-385fd3e90camr4308405f8f.21.1733320834201;
        Wed, 04 Dec 2024 06:00:34 -0800 (PST)
Received: from localhost.localdomain ([2a00:2381:fd67:101:8e2:966d:36c4:3579])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e2c84d52sm13689978f8f.49.2024.12.04.06.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 06:00:33 -0800 (PST)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: andersson@kernel.org,
	konradybcio@kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: linux-sound@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	krzysztof.kozlowski@linaro.org,
	caleb.connolly@linaro.org,
	a39.skl@gmail.com,
	konrad.dybcio@oss.qualcomm.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/4] arm64: dts: qcom: qrb4210-rb2: add HDMI/I2S audio playback support
Date: Wed,  4 Dec 2024 14:00:27 +0000
Message-ID: <20241204140027.2198763-5-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204140027.2198763-1-alexey.klimov@linaro.org>
References: <20241204140027.2198763-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sound node and dsp-related piece to enable HDMI audio
playback support on Qualcomm QRB4210 RB2 board. That is the
only sound output supported for now.

The audio playback is verified using the following commands:

amixer -c0 cset iface=MIXER,name='SEC_MI2S_RX Audio Mixer MultiMedia1' 1
aplay -D hw:0,0 /usr/share/sounds/alsa/Front_Center.wav

The same path can be used as-is for I2S playback via first low-speed
connector when DIP switches are configured in a way to passthrough i2s
data to that low-speed connector instead of to lt9611uxc bridge.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 51 ++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index a9540e92d3e6..edfb18c85da8 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -6,6 +6,8 @@
 /dts-v1/;
 
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
 #include <dt-bindings/usb/pd.h>
 #include "sm4250.dtsi"
 #include "pm6125.dtsi"
@@ -103,6 +105,47 @@ led-wlan {
 		};
 	};
 
+	sound {
+		compatible = "qcom,qrb4210-rb2-sndcard";
+		pinctrl-0 = <&lpi_i2s2_active>;
+		pinctrl-names = "default";
+		model = "Qualcomm-RB2-WSA8815-Speakers-DMIC0";
+		audio-routing = "MM_DL1", "MultiMedia1 Playback",
+				"MM_DL2", "MultiMedia2 Playback";
+
+		mm1-dai-link {
+			link-name = "MultiMedia1";
+
+			cpu {
+				sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
+			};
+		};
+
+		mm2-dai-link {
+			link-name = "MultiMedia2";
+
+			cpu {
+				sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA2>;
+			};
+		};
+
+		hdmi-i2s-dai-link {
+			link-name = "HDMI/I2S Playback";
+
+			cpu {
+				sound-dai = <&q6afedai SECONDARY_MI2S_RX>;
+			};
+
+			platform {
+				sound-dai = <&q6routing>;
+			};
+
+			codec {
+				sound-dai = <&lt9611_codec 0>;
+			};
+		};
+	};
+
 	vreg_hdmi_out_1p2: regulator-hdmi-out-1p2 {
 		compatible = "regulator-fixed";
 		regulator-name = "VREG_HDMI_OUT_1P2";
@@ -318,6 +361,14 @@ &pon_resin {
 	status = "okay";
 };
 
+/* SECONDARY I2S uses 1 I2S SD Line for audio on LT9611UXC HDMI Bridge */
+&q6afedai {
+	dai@18 {
+		reg = <SECONDARY_MI2S_RX>;
+		qcom,sd-lines = <0>;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
-- 
2.45.2


