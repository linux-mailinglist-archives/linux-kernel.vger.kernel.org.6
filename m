Return-Path: <linux-kernel+bounces-568189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA636A68FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96AC616F57B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A051CAA60;
	Wed, 19 Mar 2025 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j8OHzMxh"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C01520297C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394987; cv=none; b=ObcEHPX1KPFtvGukgym/WuaVjGJCQYw4cxqXOmvq0sbiybLt3SAzIouGMQlMXMCyNtzT/Mz2g7CUys2vWyyF6R3LhfyM5vCB07arQxKtxz8hQ0dIvS1gsXpskgeDoWeJmjOPpsrRxWYMol8NtufPwXYiBuB451rkYfjtsF5ffhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394987; c=relaxed/simple;
	bh=4rsTf3BvXwD90ec9+gH33rXrg6dfzVuPYlYo3v5hMos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VGx2CcTtyw9ACgHuiVgSMXKZ5MaiKKoONN7BPNs/sN/i6VeWggRV37tnbg3G4hV9SvbME95T6GgGnCYfRJtalL4/kcrUB6aZtqNSvdrwn8nuzWYkmLkPzuRp5LzX+T/WU7dd5fF7vgRPxq521vhNqCx5NdODU8AGY5pNbL1ZN+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j8OHzMxh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so40951345e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742394982; x=1742999782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mHell48Kd7E4scgc1k3qnnupQqZvsaoDen0sn2BgyaY=;
        b=j8OHzMxhJAR+0GkpPEDnQMq3ziXal2pib9iwlxUU6v/qojGVG9ymuB4Yy0RP95/txv
         tJdKQsxii0dW9Gf2DQ340NjOtfe4SoevYEg/TvByS/5ZZ0xSSNZxfJWX0PyFyDTlS0e3
         IOccLqC9gpY2XhwQF/VfP3knwZuaq94LV1QrbV/3hNapTd+oHACxEkMkYyMZcKzp383I
         joImM1iZ6yhNaEtRH/dY19aS7qYtkt1PPhibHC9mi4HAkhbWcq6FE+HcCvyFxzudOQQV
         QcsDIaf/WpUnjPkOjZPyrNBhedqAWs1rAptoYXZPCTDFWA3rueVnZq+GnOM09SuYuzTX
         i7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742394982; x=1742999782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHell48Kd7E4scgc1k3qnnupQqZvsaoDen0sn2BgyaY=;
        b=TTUGHHtIkbfy5hlGOt3s0rQc3VuTwNo1/NOCKGsFlE41WEGw5uiqJpp+yNeXkvwd1S
         DyBxxhIucna3eK8+Pc6LlmoB7rz0yajLZFEsew3vCstjBG7uAAHperarLkJDsbKhCaEP
         QFORBstE0rYNwDAnDTWvoGlMV/iPzKvStx1CO2rlhETtbQEoRGzNz8A1uYNcFekj30rY
         TnHuDy2onlwnAeK0mtHr8uCVVgDabEU+JRJ3UhUQ8ppGAWahZzq6I+EqynbD2zpFYIXQ
         /+EZ6tmTqhbKZBoRecoctwYJ9yTyMgw39QXQuYrP86nHlsHAtwfKl4E1uTE4trontj66
         1Nsg==
X-Forwarded-Encrypted: i=1; AJvYcCXd/Sv0Ocy5XG+FRwqojBFfvud1F+eHIpE0ku6sZugAN5sCLQGWWrunjtYcjQbWEci8o0WqSyqJdYI2ZEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YywtyuH2IEy4Z1nfVwIle4Hk/FAnvtbUhw++TzWlCTXt0FjUsbf
	N+Mi4Zn99FRIlPOvD7H6uTfRV3NJQ0fY/FnR91CfH8QlehtYD69QF2SIhcHSRV0=
X-Gm-Gg: ASbGncstLqpkpqZ4sHnXFeidYF1IMQ8P7Ugy+DRXKIfABJVKZy8TTrYUuKzWNox2e1k
	pPGWLTrJdeQivhYtd+pEyQImgvRe2zKkBqdth8GDVx+c454rKcVtNeg/1pZXqFNEE8uF3aMT4tH
	b37m9VAnF1dbsD5Jg/sRpwXzJVqMhPeDHK7dkR5sGXOqjIR/+JcM+bBhCNWA+w+7JE+/csxgQBv
	4ylkbq4Yit2cq4k4ib+JcGEiio9W99ymrC2RPpzbb5ZOyPQql0LMYCTj1r5Pdnw+qM4So8Mt6Y7
	SQ90wiiTEAGQQqHo9YZ00pD9B37lNq4bL4J8UxncwaH/A2XICLoX/bEA73Vl4gzqn78vqg==
X-Google-Smtp-Source: AGHT+IEHxJWdyUAwFdqQMllBWP3fWJDJ8hzp5jsaaQhbCu6LdocHLQb5V4StWO1RuGPiDrtJiYq+CA==
X-Received: by 2002:a05:600c:a54:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-43d43855435mr26504815e9.20.1742394982035;
        Wed, 19 Mar 2025 07:36:22 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f32fcdsm21105845e9.7.2025.03.19.07.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 07:36:21 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: andersson@kernel.org,
	konradybcio@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ggo@tuxedocomputers.com,
	ettore.chimenti@linaro.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] arm64: dts: qcom: x1e80100-tuxedo-14: add sound support
Date: Wed, 19 Mar 2025 14:36:13 +0000
Message-Id: <20250319143613.11177-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds sound support for this platform,
support includes
	- 2x Speakers.
	- 2x dmic
	- Headset

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---

This patch depends on
"arm64: dts: qcom: Add device tree for TUXEDO Elite 14 Gen1" patch
 https://lkml.org/lkml/2025/3/6/867

ucm changes:
https://github.com/Srinivas-Kandagatla/alsa-ucm-conf/tree/x1e80100-tuxedo

tplg changes:
https://github.com/Srinivas-Kandagatla/audioreach-topology/tree/tuxedo-elite-14

 .../qcom/x1e80100-tuxedo-elite-14-gen1.dts    | 190 ++++++++++++++++++
 1 file changed, 190 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-tuxedo-elite-14-gen1.dts b/arch/arm64/boot/dts/qcom/x1e80100-tuxedo-elite-14-gen1.dts
index 86bdec4a2dd8..465221b8a3fa 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-tuxedo-elite-14-gen1.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-tuxedo-elite-14-gen1.dts
@@ -20,6 +20,34 @@ aliases {
 		serial0 = &uart21;
 	};
 
+
+	wcd938x: audio-codec {
+		compatible = "qcom,wcd9385-codec";
+
+		pinctrl-0 = <&wcd_default>;
+		pinctrl-names = "default";
+
+		qcom,micbias1-microvolt = <1800000>;
+		qcom,micbias2-microvolt = <1800000>;
+		qcom,micbias3-microvolt = <1800000>;
+		qcom,micbias4-microvolt = <1800000>;
+		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
+		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
+		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
+		qcom,rx-device = <&wcd_rx>;
+		qcom,tx-device = <&wcd_tx>;
+
+		reset-gpios = <&tlmm 191 GPIO_ACTIVE_LOW>;
+
+		vdd-buck-supply = <&vreg_l15b_1p8>;
+		vdd-rxtx-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l15b_1p8>;
+		vdd-mic-bias-supply = <&vreg_bob1>;
+
+
+		#sound-dai-cells = <1>;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -129,6 +157,85 @@ vph_pwr: regulator-vph-pwr {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	sound {
+		compatible = "qcom,x1e80100-sndcard";
+		model = "X1E80100-TUXEDO-Elite-14";
+		audio-routing = "SpkrLeft IN", "WSA WSA_SPK1 OUT",
+				"SpkrRight IN", "WSA WSA_SPK2 OUT",
+				"IN1_HPHL", "HPHL_OUT",
+				"IN2_HPHR", "HPHR_OUT",
+				"AMIC2", "MIC BIAS2",
+				"VA DMIC0", "MIC BIAS1",
+				"VA DMIC1", "MIC BIAS1",
+				"VA DMIC0", "VA MIC BIAS1",
+				"VA DMIC1", "VA MIC BIAS1",
+				"TX SWR_INPUT1", "ADC2_OUTPUT";
+
+		wcd-playback-dai-link {
+			link-name = "WCD Playback";
+
+			cpu {
+				sound-dai = <&q6apmbedai RX_CODEC_DMA_RX_0>;
+			};
+
+			codec {
+				sound-dai = <&wcd938x 0>, <&swr1 0>, <&lpass_rxmacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		wcd-capture-dai-link {
+			link-name = "WCD Capture";
+
+			cpu {
+				sound-dai = <&q6apmbedai TX_CODEC_DMA_TX_3>;
+			};
+
+			codec {
+				sound-dai = <&wcd938x 1>, <&swr2 1>, <&lpass_txmacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		wsa-dai-link {
+			link-name = "WSA Playback";
+
+			cpu {
+				sound-dai = <&q6apmbedai WSA_CODEC_DMA_RX_0>;
+			};
+
+			codec {
+				sound-dai = <&left_spkr>, <&right_spkr>, <&swr0 0>, <&lpass_wsamacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		va-dai-link {
+			link-name = "VA Capture";
+
+			cpu {
+				sound-dai = <&q6apmbedai VA_CODEC_DMA_TX_0>;
+			};
+
+			codec {
+				sound-dai = <&lpass_vamacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+	};
 };
 
 &apps_rsc {
@@ -160,6 +267,13 @@ vreg_bob2: bob2 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
+		vreg_l1b_1p8: ldo1 {
+			regulator-name = "vreg_l1b_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_l2b_3p0: ldo2 {
 			regulator-name = "vreg_l2b_3p0";
 			regulator-min-microvolt = <3072000>;
@@ -534,6 +648,24 @@ eusb6_repeater: redriver@4f {
 
 };
 
+&lpass_tlmm {
+	spkr_01_sd_n_active: spkr-01-sd-n-active-state {
+		pins = "gpio12";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
+};
+
+&lpass_vamacro {
+	pinctrl-0 = <&dmic01_default>;
+	pinctrl-names = "default";
+
+	vdd-micb-supply = <&vreg_l1b_1p8>;
+	qcom,dmic-sample-rate = <4800000>;
+};
+
 &mdss {
 	status = "okay";
 };
@@ -648,6 +780,64 @@ &smb2360_1 {
 	status = "okay";
 };
 
+&smb2360_1_eusb2_repeater {
+	vdd18-supply = <&vreg_l3d_1p8>;
+	vdd3-supply = <&vreg_l14b_3p0>;
+};
+
+&swr0 {
+	status = "okay";
+
+	pinctrl-0 = <&wsa_swr_active>, <&spkr_01_sd_n_active>;
+	pinctrl-names = "default";
+
+	/* WSA8845, Left Speaker */
+	left_spkr: speaker@0,0 {
+		compatible = "sdw20217020400";
+		reg = <0 0>;
+		reset-gpios = <&lpass_tlmm 12 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "SpkrLeft";
+		vdd-1p8-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l12b_1p2>;
+		qcom,port-mapping = <1 2 3 7 10 13>;
+	};
+
+	/* WSA8845, Right Speaker */
+	right_spkr: speaker@0,1 {
+		compatible = "sdw20217020400";
+		reg = <0 1>;
+		reset-gpios = <&lpass_tlmm 12 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "SpkrRight";
+		vdd-1p8-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l12b_1p2>;
+		qcom,port-mapping = <4 5 6 7 11 13>;
+	};
+};
+
+&swr1 {
+	status = "okay";
+
+	/* WCD9385 RX */
+	wcd_rx: codec@0,4 {
+		compatible = "sdw20217010d00";
+		reg = <0 4>;
+		qcom,rx-port-mapping = <1 2 3 4 5>;
+	};
+};
+
+&swr2 {
+	status = "okay";
+
+	/* WCD9385 TX */
+	wcd_tx: codec@0,3 {
+		compatible = "sdw20217010d00";
+		reg = <0 3>;
+		qcom,tx-port-mapping = <2 2 3 4>;
+	};
+};
+
 &tlmm {
 	gpio-reserved-ranges = <28 4>, /* Unused */
 			       <44 4>, /* SPI (TPM) */
-- 
2.39.5


