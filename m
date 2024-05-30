Return-Path: <linux-kernel+bounces-195618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A86D18D4F5C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193911F23B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13AC1C68B4;
	Thu, 30 May 2024 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MOSw0XBF"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249E6186291
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717083838; cv=none; b=AysJDtLx5WAt4QhBWQq/Jiz/4sv+vIeBs5vk72HmKGpAEJ5Agbp+CmI/I0/+cdx6OSL2JJlV9LtUGLLKu3MqIrR9Il7XJWhhbrg6HXj++kgFhcsuzh3CVqJ4VZwKJiKbHaJSZNq6cMtzryCGOeuVkc7R1N5jzHmD9zX4fIXU6Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717083838; c=relaxed/simple;
	bh=1LTJ1ZbHYVIiunTosxnkif5rOzcNdAVdISpvTDGmP+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OHYMv9KdNVWjcsz2DZBRtUF77tbIQqope4S7eoqvGph8dR4FTWj8H92LS9hNJVxEn3m5BEa5W1dlnJc/rS/Y7jcUd1/vzRK1wLBNY3QUcCz0pvrARHJucZTn42DJpqQsPLFGxm9im8+sXwR9R1/iCcbmOdsi5tz8i0ceFRadXXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MOSw0XBF; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e72224c395so9258951fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717083834; x=1717688634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EB2qCn5UGV9aqEQdkg+7453N3Kl73IeR9N5SJgjDlZA=;
        b=MOSw0XBFxKosNI7CmEuiyqnisXNwCoPWoY1+ypwgQg5f6RwCvGAiEsBPzLc9SnMHyW
         3UXC+SEeXmM9/g19zIMVF06tfj22G2/XJEEkc/bKUkjejGJXk3gto0winJ+1t/NYVEH9
         ushOzckZQOnkDqbRBAWMQbNMecuIIwsPx3FreQqigppjCHumdOcbVubVdjb1Rv3psZQf
         lhcb4U8La6NZA99YXK2KtdvOObN5dGxSWRkmHI6Alw+G1nHZL6ZctKJI5wxokeLFTV+y
         Th4OWaQzjn3E4z2s5kEWKLc5BrzwMcieQ4x69SX4rOXLhjLQoNTYFjVa71EyVslLztme
         +SGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717083834; x=1717688634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EB2qCn5UGV9aqEQdkg+7453N3Kl73IeR9N5SJgjDlZA=;
        b=r9yiscrptBj5QW0RxIH2kwx2uJCCWf++SxlhkGtMuafzmy0gXmc3sxSyv8xutoTLIZ
         rgHGKIEyllYWi1JcAVOT3ATSopyy+LuxD9+h8lGwjYR/ssTG2P4kdAsDLpNxE9WPsgze
         x6MeOBa1v3eHldgX200yi1bvu6GRLDFz9A/qZKqLxU2yXDNkGSi4NoUCjdaEOTGIjyZx
         MygJyMuCJ3Q1lAzl1lkx5UOfJVJO0VUjvMUbTPOjTbRL7bH2lkqNWYdY9WDpe3OzdsHE
         1Tgy4FI/p0osbJWMXxYu22azHHyKKzEw/ISH6T/oSd8SrVhfw2QEYKv7lwQAXmBAg50f
         JY/g==
X-Forwarded-Encrypted: i=1; AJvYcCXccozUJ/DXgpAL6gcpYk2ldwDBfEiYgAeBSLDcPk415+4//jnH0x0m8sVZMBfmRIX4Em5bU0pEf+8caOF9iZuHjwDsGYXC2qDEfHw7
X-Gm-Message-State: AOJu0YxpQ0J8IdbZso2P52zK1oYtdo+tw3JjHVzAE+9Vzvo822rNn47h
	qcTFcO13UcTLYkc29gM01IdTLzMStALgIf0U2x3DBJSvAgMAzyVyGmCXXGzANgg=
X-Google-Smtp-Source: AGHT+IE9RqDBgAa9w5lbGC/woJK3bS0VJZz4UwnYIRaetdKK7Bsv/24VfWtedXzFLf8LE6feJRopIA==
X-Received: by 2002:a19:9107:0:b0:52b:8435:8f22 with SMTP id 2adb3069b0e04-52b84358fb1mr159455e87.36.1717083833902;
        Thu, 30 May 2024 08:43:53 -0700 (PDT)
Received: from [127.0.1.1] ([188.27.161.69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579deb8f406sm4879700a12.34.2024.05.30.08.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 08:43:53 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 30 May 2024 18:43:41 +0300
Subject: [PATCH 3/3] arm64: dts: qcom: x1e80100: Describe the PCIe 6a
 resources
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-x1e80100-dts-pcie6a-v1-3-ee17a9939ba5@linaro.org>
References: <20240530-x1e80100-dts-pcie6a-v1-0-ee17a9939ba5@linaro.org>
In-Reply-To: <20240530-x1e80100-dts-pcie6a-v1-0-ee17a9939ba5@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3861; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=1LTJ1ZbHYVIiunTosxnkif5rOzcNdAVdISpvTDGmP+4=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmWJ6zBz/myBiTnzwAi5HLTb6p8fI3Q7PU4Wm4R
 KK7hJ76asSJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZlieswAKCRAbX0TJAJUV
 VnGaD/9Ia2Vi5BnGohM0XdArqmAz+X5XQeQ0Mqd3Cljv5YYfZVhAwscEanXwSYbDMZf2ZXpnHrs
 suNKoS3MtEgCLYxirTIMG427DOxCk1EVlzj8gv1I8EY9/4hQ6LfYSoK59w4033YiVHZw+Ay0RKN
 IoOhPP5bEu/gM17W5nY5fMY9boFYSWIEM53WyCyzz6HmirklhjzBJW5ouIG16hAyE5jBKo6E7G4
 siFPLQWqEfcFiSENAu1qqvH0hOfWDxBsvcDVXxGbyRETIRNbOVMVyiMIttbwYSUvUTC5bvTnft2
 Pgv1AVP3DtxxHkCyF/205qNUe1TsA6JtuYOAUCXkE5YIjysucznE5ARODt8ZlKvpP8jbIDQco3r
 36QZ3vdEX8+jPllbll934E8PcYHkG++DsyhMG26VOZLoCexx3nM7SoGQyAnKH8/zD8Si1p3ZThE
 1E2/86D2unl3PmduOSPy3QeYX4gy2UH7QmZ5W27k8yL6o+LDuRpvESpwvt1zTsIwztOVIHM9ODS
 yqGXYGKJzB/3ZPSOPDcuuNRuxVI0bbkkFuzZKzgDfYp6sUOVFpq/KmPq4TqT+5yL4FTB8Hc8JIJ
 5vc6P7zvIFN7F2WeYA3QTrCfclVvt309NxKcEbOiNMmrL3Kppdi1mIn2vEiTlgfkIKZQlojIg2W
 LW3uIDxWnIQ4k1Q==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

On both the CRD and QCP, on PCIe 6a sits the NVMe. Add the 3.3V
gpio-controlled regulator and the clkreq, perst and wake gpios as
resources for the PCIe 6a.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 52 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts | 52 +++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index 3ce2c8a841ec..10ec40a193fb 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -173,6 +173,20 @@ vreg_edp_3p3: regulator-edp-3p3 {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	vreg_nvme: regulator-nvme {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_NVME_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 18 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&nvme_reg_en>;
+	};
 };
 
 &apps_rsc {
@@ -655,6 +669,14 @@ &pcie4_phy {
 };
 
 &pcie6a {
+	perst-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
+
+	vddpe-3v3-supply = <&vreg_nvme>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie6a_default>;
+
 	status = "okay";
 };
 
@@ -804,6 +826,36 @@ kybd_default: kybd-default-state {
 		bias-disable;
 	};
 
+	nvme_reg_en: nvme-reg-en-state {
+		pins = "gpio18";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	pcie6a_default: pcie2a-default-state {
+		clkreq-n-pins {
+			pins = "gpio153";
+			function = "pcie6a_clk";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-n-pins {
+			pins = "gpio152";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		wake-n-pins {
+		       pins = "gpio154";
+		       function = "gpio";
+		       drive-strength = <2>;
+		       bias-pull-up;
+	       };
+	};
+
 	tpad_default: tpad-default-state {
 		pins = "gpio3";
 		function = "gpio";
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index e1b19177523f..ab02a6e35eb6 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -59,6 +59,20 @@ vreg_edp_3p3: regulator-edp-3p3 {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	vreg_nvme: regulator-nvme {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_NVME_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 18 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&nvme_reg_en>;
+	};
 };
 
 &apps_rsc {
@@ -466,6 +480,14 @@ &pcie4_phy {
 };
 
 &pcie6a {
+	perst-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
+
+	vddpe-3v3-supply = <&vreg_nvme>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie6a_default>;
+
 	status = "okay";
 };
 
@@ -528,6 +550,36 @@ edp_reg_en: edp-reg-en-state {
 		drive-strength = <16>;
 		bias-disable;
 	};
+
+	nvme_reg_en: nvme-reg-en-state {
+		pins = "gpio18";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	pcie6a_default: pcie2a-default-state {
+		clkreq-n-pins {
+			pins = "gpio153";
+			function = "pcie6a_clk";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-n-pins {
+			pins = "gpio152";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		wake-n-pins {
+		       pins = "gpio154";
+		       function = "gpio";
+		       drive-strength = <2>;
+		       bias-pull-up;
+	       };
+	};
 };
 
 &uart21 {

-- 
2.34.1


