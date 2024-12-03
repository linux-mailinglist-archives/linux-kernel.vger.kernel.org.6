Return-Path: <linux-kernel+bounces-429318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E3E9E1A6D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA97716548E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10151E3DC3;
	Tue,  3 Dec 2024 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u/3b56oh"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D74B1E32BE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224360; cv=none; b=B75hN3xh1Y/3/uBzlOXfK5wJthWOlx9kZ/v3i9g0hEp6iqAtcroa6Uverqgggjp+8A2veqs9v6lOWRcAzAAalAshzFsL279Gf5ZKRxlv3VdwtnYfYWTN/9Nj80dCY7/+ZF2orqnYqD/6R1ZJPHMqrvEaUZPLxN+rwh0BHDQZdhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224360; c=relaxed/simple;
	bh=EqMT1lpbEY5/Che+UX6Bncb4AL1x5DYytCF5K+qiu2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WjIfIV7EUg/NiWO2gL8E3f/Bk6Xx+Og58EagIP8jbcOk8fkyLMfPyekBpdURalHcefeg9K467EZL8/jkz6Af7R5VrPupisKKp5WKkFm+nuNQpMvD87nY3AvFTTHrkJ6jB+e8doIQ+g5vhVZUdp/+V6MCYS4mFIJbqIYE7b0POMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u/3b56oh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a12d106dso5246345e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 03:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733224356; x=1733829156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g6kGDnTLAfubcmw4OwqnnlfFoodRzVFFUo0D9f7Dre4=;
        b=u/3b56ohB59V7WSPv7Yc+k/ITb/sqs9PvMHunBnLemxoO8w6UzU3ss3/rvIWaz1Bz5
         rVJTDWBnzbQH2p0GHS7PJdCYggAAP6CSKzv/xfMkL6RJScBupHWLekkK+ADszeBRRJyG
         oqAoUlrB2vdUXkYT7lguY+uw2234PriOkjgm5gCmYjWj+EBIRZ1LD+pgE+c/SzJQEGPB
         8itqFdInJVDNjcy98Th40s+h8ux4f8C5/ZwXfxfe0sA8dkLdtzX//B4O4/mBbhhcDrz5
         Xt3Hu7FNYL2gyGq8nmx/kPZ/uCE9Gsw4765BSGVcmty8+xF8EGQ2idCmYCg+C778W+qw
         oG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733224356; x=1733829156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6kGDnTLAfubcmw4OwqnnlfFoodRzVFFUo0D9f7Dre4=;
        b=rytCJUEiaHtIZwlVcQxplC7d9fXwYGFKCNthTt1RnUrKO8TK/HtYfAONKyIlmYHZQn
         OohkLTCNVDt+wmKxW3U5BqYDYczslBbLulwJvlh3SJZYsE75o7ztEe7Lx0ejDS6cO1a0
         S6FeKdje0nEVF5H2+WwJddgipuJCM/kzUgiRZcZXOQEuZkJ9VDlcQ9QtHu24Y3AnDp/e
         66AjpS4OZ8pMztVXXi2hwz3K1/gHzz7JnD/7gqqN64z5LetOGrEz+ErRJ6GYzYnKhtVM
         +XFAg80Z7hYMWCGRVDdykbbBJZGAO+UgYiPF9vZdoI0dP3KPMpaWjBhcUxW+XfTtyGsW
         cmtA==
X-Forwarded-Encrypted: i=1; AJvYcCU8l7eYR+FsJtk1ioo4K7nmYIqkNV9ftgvqAP3vqvxwVynL9TmLQeiUxCDvkNq0uqeW2n3FnS/XfPSeTDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyilm0/pq46IEZvugLySKolU9xh80yS3+oVB9RxDXjaWEk+0GpU
	xA9MxOkQa8zOR/bCha1wXSoUkMT9M1MeSPkwvgf54ImU45qHbB8gbTPIgGJdOjY=
X-Gm-Gg: ASbGncvi50cY2TcUDMtIDXitHjQLaMNqGYHVIyxSbom92fuUxSsezaev1JCuTrQHmFK
	q6ftIsDKJUpxCkrD20TD6psL2Ru36QR1NMruoUBWcfq4Xj3F5smcEUivm134XSjpgWRvJkNXpLA
	0lpex+qpc9l4RTQFAEgldQBNgP/fE1SP4ej2/pSAa1lRKF0eOBS8Vutv91wcb3WPQHYCcxzSAvp
	pPHHa+9jKPmdJzbujPiVJxqNkwZB5AdA4hLFco7sRumFltNlHS1Qo1FlGhrfvw=
X-Google-Smtp-Source: AGHT+IF2uKiqbnRf8oPSGgAbSOfSre2/+2HTW+tki4BL9CRri386VoZIy2wTzWLIDJ68hlU91fsw9g==
X-Received: by 2002:a05:6000:1fa3:b0:385:eb17:cd3c with SMTP id ffacd0b85a97d-385fd42bcebmr628032f8f.13.1733224355836;
        Tue, 03 Dec 2024 03:12:35 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e3896b76sm9683819f8f.33.2024.12.03.03.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:12:35 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] arm64: dts: qcom: x1e78100-t14s: add sound support
Date: Tue,  3 Dec 2024 12:12:29 +0100
Message-ID: <20241203111229.48967-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Add support for audio on Lenovo T14s laptop, coming with two speakers,
audio jack and two digital microphones.

This is very early work, not yet complete:
1. 2x speakers: work OK.
2. 2x digital microphones: work OK.
3. Headset (audio jack) recording: does not work.
4. Headphones playback (audio jack): channels are intermixed.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
[krzysztof: correct DMIC routing and vamacro pinctrl, re-order nodes,
 add commit msg]
Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Flip pinctrl-0 and names (Konrad)
2. Add Rb tag.

1. Audioreach topology was already pushed to main branch:
https://github.com/linux-msm/audioreach-topology

2. ALSA UCM files are ready and soon will be pushed by Srini.
---
 .../qcom/x1e78100-lenovo-thinkpad-t14s.dts    | 183 ++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
index 975550139e10..386dee8c0412 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
@@ -19,6 +19,32 @@ / {
 	compatible = "lenovo,thinkpad-t14s", "qcom,x1e78100", "qcom,x1e80100";
 	chassis-type = "laptop";
 
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
+		#sound-dai-cells = <1>;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -153,6 +179,85 @@ vph_pwr: regulator-vph-pwr {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	sound {
+		compatible = "qcom,x1e80100-sndcard";
+		model = "X1E80100-LENOVO-Thinkpad-T14s";
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
@@ -185,6 +290,13 @@ vreg_bob2: bob2 {
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
@@ -515,6 +627,24 @@ touchscreen@10 {
 	/* TODO: second-sourced touchscreen @ 0x41 */
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
@@ -645,6 +775,59 @@ &smb2360_1_eusb2_repeater {
 	vdd3-supply = <&vreg_l14b_3p0>;
 };
 
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
 	gpio-reserved-ranges = <34 2>, /* Unused */
 			       <44 4>, /* SPI (TPM) */
-- 
2.43.0


