Return-Path: <linux-kernel+bounces-233225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C26B91B484
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65643B22DFF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95644206A;
	Fri, 28 Jun 2024 01:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="otG4VinS"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329A920319
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719536847; cv=none; b=HMe64A8m8oKO6D5cOneHlkCN9xx5sgvsynm5mo4IcEayXbNoqvbvRqFmn7EhdRFlk+lYTm6VDZO5kAbu5Sr0993uOnmzwgyf9npMCUpMVofKpydPMs6skvC0AQdtLgKIvn8nL36ZFk1gpS/0dBwMauuj2rzp7pOhaN4/iXOnUyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719536847; c=relaxed/simple;
	bh=VaJgdAUwAE0Dxl/8QEWuET/yRCAh4TW1cOFSAuG2kP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3bbYTIddOlK+Vpi1MOZhIjMm6eVQHpJ8os+w0no/IDfj7ohJV+V+oM00QCDp0SBy2smg3RrKqlZ1eDJl58PpPsyh7VGRI1W8rIRNvpWJ/zpDnYWgZrZgweCJtVXhDlQXdrTx19OWAyXWDu5IefQzcay+/6wCFy3I1I7AbXKlRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=otG4VinS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-424ad289949so427525e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719536843; x=1720141643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dygKyrjKx/kOGRgW4z+quGaDKz0N+z+SoU7Eqh65Kfs=;
        b=otG4VinSODvlkLHkZPbJja8OFpo3wuVx11A4c5L6L6wSkjANA7IbbzRCi5KWD+BWws
         QHzqptAQDz16++VOTIVyE8V3qLjAchJEgKsH0/dNs3PJT4I6gu/3IOyXPWpXxbHNVBIb
         zC8b19YqR3ietKOwUAQQdNkXBYqR+J+JWhmtyAhOn/wHHjTecdq07fs1DqMP9t4opHMJ
         79eEMcl3+QVAftOdyV5dTER4GlpkAYtpw9hmmcFhUHiQ/aHG/9Y+oiz+FWPQ2JQ/c0qv
         Vc8uo7WrXWlW7ghiKFgHd6suJtyr7jJQAcUEkk9lwzdNKXiXi48zlN6WWo0x+rF5kk93
         ijSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719536843; x=1720141643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dygKyrjKx/kOGRgW4z+quGaDKz0N+z+SoU7Eqh65Kfs=;
        b=JWcBdtdtxqZZ4w0bCEXayES7EHstfhrM+G04zYHl+kzH5exiZwEaCb7R5esQkCCQNo
         dw7dJZh7OROVxeB9SwHvwgHZtXUzWZmha6P0S3lljEwL2qOv865+4BM+Q5nh+pgbihXn
         a5KUyWA2vZJLZxqZYgEhYj1/0BAmDFZSjSMzRHt0N+jzW6kSbwKeUk/gQ9qdCLKZXzmB
         Ya+WLANlZ0g7IXNxM74AaD2oIVHC4fTaz8fyK7o+GNZJnnfFTuHDMsq3H+5Nl+VxZsey
         78X9iK4il++laVTp5bb18xPqvXXfvvfmIbwPE0Zf9a1Fgt9S2SHRHXRG4bUh1kFdWs6t
         Y3oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIW3Vt6jTWQ/NmmZ5vLJJAnomTkuHHk23b30CjIY4QcxO3eeUDFhNA+hI9VBMSPNVXOvSSUV1XnrRj+TBvCXERNmvBgP6ZJ/yaN7tz
X-Gm-Message-State: AOJu0YzlJ53j/z8a7Cb7dPbZzOyo3PRQnZ9sDGZsydGbtLpsyAOaQYEf
	UsRcgviNX2QR0vnYinCtJ0zhlGuaj96QLsr82YiOHobM3YHcvlkPY+Zh0BWSPpQ=
X-Google-Smtp-Source: AGHT+IFPa0BrWjNQbwKC2PbxrY3h/NKDG7XWM5mvy10enz+zNiE0uSA7CMfLfTgpWJljWSV/xaEc6A==
X-Received: by 2002:a05:600c:4f83:b0:424:8c13:edc4 with SMTP id 5b1f17b1804b1-4248c13ee6amr101471675e9.27.1719536843575;
        Thu, 27 Jun 2024 18:07:23 -0700 (PDT)
Received: from fuerta.Home ([2a02:c7c:7213:c700:2cd1:b0e8:abb:540])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af3c27dsm13075805e9.7.2024.06.27.18.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 18:07:23 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: linux-sound@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	bgoswami@quicinc.com,
	lgirdwood@gmail.com,
	broonie@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	elder@linaro.org,
	dmitry.baryshkov@linaro.org,
	krzysztof.kozlowski@linaro.org,
	caleb.connolly@linaro.org,
	linux-kernel@vger.kernel.org,
	alexey.klimov@linaro.org
Subject: [PATCH 7/7] arm64: dts: qcom: qrb4210-rb2: add HDMI audio playback support
Date: Fri, 28 Jun 2024 02:07:15 +0100
Message-ID: <20240628010715.438471-8-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628010715.438471-1-alexey.klimov@linaro.org>
References: <20240628010715.438471-1-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sound node, dsp-related pieces and LPASS pinctrl to enable
HDMI audio support on Qualcomm QRB4210 RB2 board. That is the
only sound output supported for now.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 73 ++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index 2c39bb1b97db..9f4dde927be4 100644
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
@@ -230,6 +232,10 @@ lt9611_out: endpoint {
 	};
 };
 
+&lpass_tlmm {
+	status = "okay";
+};
+
 &mdss {
 	status = "okay";
 };
@@ -307,6 +313,28 @@ &pon_resin {
 	status = "okay";
 };
 
+&q6asmdai {
+	dai@0 {
+		reg = <0>;
+	};
+
+	dai@1 {
+		reg = <1>;
+	};
+
+	dai@2 {
+		reg = <2>;
+	};
+};
+
+/* SECONDARY I2S Uses 1 I2S SD Lines for audio on LT9611 HDMI Bridge */
+&q6afedai {
+	dai@20 {
+		reg = <SECONDARY_MI2S_RX>;
+		qcom,sd-lines = <0>;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -535,6 +563,51 @@ &sleep_clk {
 	clock-frequency = <32000>;
 };
 
+&sound {
+	compatible = "qcom,qrb4210-rb2-sndcard";
+	pinctrl-0 = <&lpi_i2s2_active>;
+	pinctrl-names = "default";
+	model = "Qualcomm-RB2-WSA8815-Speakers-DMIC0";
+	audio-routing = "MM_DL1",  "MultiMedia1 Playback",
+			"MM_DL2",  "MultiMedia2 Playback";
+
+	mm1-dai-link {
+		link-name = "MultiMedia1";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
+		};
+	};
+
+	mm2-dai-link {
+		link-name = "MultiMedia2";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA2>;
+		};
+	};
+
+	mm3-dai-link {
+		link-name = "MultiMedia3";
+		cpu {
+			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA3>;
+		};
+	};
+
+	hdmi-dai-link {
+		link-name = "HDMI Playback";
+		cpu {
+			sound-dai = <&q6afedai SECONDARY_MI2S_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&lt9611_codec 0>;
+		};
+	};
+};
+
 &tlmm {
 	gpio-reserved-ranges = <43 2>, <49 1>, <54 1>,
 			       <56 3>, <61 2>, <64 1>,
-- 
2.45.2


