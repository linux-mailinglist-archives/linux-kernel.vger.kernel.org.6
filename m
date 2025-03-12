Return-Path: <linux-kernel+bounces-557731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E8FA5DCF9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44DEB189AE24
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5632459FF;
	Wed, 12 Mar 2025 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gb1wuII7"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39CE24397A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783502; cv=none; b=H+WSJth6v+WBbWqwJB+E0XGf+ZD+0a2NZySrDr/PLugCEf3waOIdmdBUWlR97YuxhLMp2yRTrsL+cuOBg9zv68oUNOuUJrmvQ/5zruSXm22auBxBJafxNnCycvhQlxPgtZcRMy7Q5CeK8HA3P+9YY8pWtENeii82Q5TjDeibfXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783502; c=relaxed/simple;
	bh=a7vBfyWdHtvx4mO4TB+ducScmcsPPyI6gKuJEnJKnGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qaNkhNFnyt+C9cz0v3VpL+kynCu1WdEVan1jRHW1J7/WmJHuwqxllifrSuutXfynNP4278coBCXqA4+02J+X2uf/FmrSFLECRterQ0u/nEl3kFHevek2xmsFptq8ncsq49i443C2az3/LtNNWLY3BsP8NopOlbyEhmucFfIGj1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gb1wuII7; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab7e08f56a0so102169666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 05:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741783499; x=1742388299; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0WSUGkq+A9k1Zn6MebQMLzVhjJdMmJCahWZMmfiSK2k=;
        b=gb1wuII7X2E3I3OUTYBdsWnwvxlvwoinh2PpaOJ8nZFKKUupsAH7ooE1azOQX8mKO/
         pryKGp9kVEZlK7p920BPHi2BU9plddsZpIE2K0M+oxhhPuv3+pXFCacU0RCBK2QonFEe
         4jb1TzfH+/2MAkdiI1wQGwOVkj4heIUSfpgj8XAwy1rP97U3sx7/F3NlhfTvjKwBi/bV
         4dVwxlT/rT9Oy9JpeaOMuIjhdZH5keNTYS9B1eFmVPl+3Slbkndlb9nHkV9moj20x9Fv
         h+8s20IlxKuUCNuPnGEmXN0aDuIy9aqooRqFJeSvvM1UBXWVVqnxn2xave06GrMuSy3X
         KdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741783499; x=1742388299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WSUGkq+A9k1Zn6MebQMLzVhjJdMmJCahWZMmfiSK2k=;
        b=VdeawDqweeZx7b9w5Wifyy4kcUFjIo3AOc5kBRu7Q6j9nYlx/lenGBrgs/nvfDABbd
         t+LRVKSUmi48hSgYBxzkTpH5E2FYKJkJC1fbOpmsOy9KnIE+7nobvPVZqXCInIp1ir7+
         hGlkIeEAUYPeG5izQGT3UBZQfl8AKFMf6xV3s6GU/ZFzgqe2EWMen+q7XX4tt7H590Id
         sjqxFGV2JVJy/F/1wxPep5xdnMLYozYBBjYUD8YwG2cYhZqFif36iq8a83DJ7pYvPTPp
         cEeej0L7MPnQVyD+j5QIe+W6fIHyFl69nDFlCXoj11CrCB/QbiFS2a9kzAqfB9gguyVS
         J6cw==
X-Forwarded-Encrypted: i=1; AJvYcCUVIdV8y6P0PzGUSylT/JNOBt4UAN6xCX9IxAK4k1d89jPwM86mRBnhbdY7jp2P9e061VxhOdsB6gNT3ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwjWHTJqan7vdFii4oF8R86fh3qWRXfKuFSr93sVHXpoLQaZMr
	BPGeXpJq9KRKYHnx3mvLT0t1Iq4PQ0wNrWs+282VmKOQSranvWTiNiOtcaFp+YA=
X-Gm-Gg: ASbGncsG4lKVF2x7N5i8hwzuBbjJDwykbQj/kY58p8UbA9xUxp5gy8bg9nNAEejjQp6
	WmMVzUzEa56m/iBKQeNU9yBhW/bBjDghE6diKv6U3q0O8Ea3lP8q9Vm7kcXjq7gMlAKejRR7ZfQ
	GIia0wlkFLsWbYro8mo1y/ecpH4j+AEHdd2eciIhgbcLWSrbBM+Uy5scp3DP1E4DJ0PkdvbqP4W
	w8jgzIG9UMR+ajV5YVV+yLgBbp4Flg1GZZZAgqpUwXbqaprO1DDpeJiAOfDRQ3+//gENMj0qb+X
	/OyanO8uUdfQchmdMm2ra9jg7pI6VaVOSxyEvB3ROuG+QK4n4yiBxToPg4Q=
X-Google-Smtp-Source: AGHT+IGnWk9NgAcrzgf26yHVf2FFvWkcFibZ+l0og5/TQw+itFT9WzpBvRt/o15Wc/2GnxpKs+5htQ==
X-Received: by 2002:a17:907:3f20:b0:abf:58f7:67c4 with SMTP id a640c23a62f3a-ac2b9de9594mr399655266b.4.1741783498924;
        Wed, 12 Mar 2025 05:44:58 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac287653d1esm628955866b.125.2025.03.12.05.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:44:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Mar 2025 13:44:46 +0100
Subject: [PATCH v3 2/4] arm64: dts: qcom: sm8750: Add LPASS macro codecs
 and pinctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-sm8750-audio-v3-2-40fbb3e53f95@linaro.org>
References: <20250312-sm8750-audio-v3-0-40fbb3e53f95@linaro.org>
In-Reply-To: <20250312-sm8750-audio-v3-0-40fbb3e53f95@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Melody Olvera <quic_molvera@quicinc.com>, 
 Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6947;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=a7vBfyWdHtvx4mO4TB+ducScmcsPPyI6gKuJEnJKnGo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn0YHDanZY7p4g2p5nd2pPCtmUpCmDMuobn9UAa
 31h6GU/MiKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ9GBwwAKCRDBN2bmhouD
 1+nOD/9QNok9gnkZubgKdZy/ny6h6KeiqJpPIRS3to+vpOOERDOIpKKfb2rmA1A3apSULDfrBN3
 /EvFyP90aHUSnexRQhTSJ/zMwcqNC8B528qJYvC9k4MnxfVvhdHYQsSpJ4g4xCLuj5/NjCe+/4s
 9Ty4vksYlB5P2wriMINtz9TpGQFRknYTmTwCXVDMfNFmusyCK+HOVlJ+zBR2ccXx8QT3Kwmkbnu
 QlcGBhWPoY0NOggeb7aJAjOYqH71/fxVo5jp3hb81lwjz8uX8Oc7eTPlO0A101cS/JLF/zueZQl
 KNXQLWGzLWp6ZBCQCcadxqpEWLvPAdl56sLEm9f9rxeVwsLBMbV1l6MTk52+LdIYNERi6/Xbsvy
 3tb5eEn1npwxcuUuI83C80cIgbCpsmOAX/AGe2xKktXWgMfaWVIrzsO4Ji/m2AdAzQT+Eg2jyJ7
 UKkRkGfc7WNu/tDWCGXsUZsbh1uhKHk9Jqz28foOfk37OVMlfLu2xriaS4ZrMdTlUzqGtq2E4z4
 dNhvMvhQm+c7qNVhTxc07SIcTHzWFJbKhpD8bXkspuOagyvYkAHP9ypxEQx++TonCX7OuZP9rSh
 9ueSKuOEtIdKQlStNgbLbRqJLLMk4YqUj/gYJqqY7cbewOMrGIl7Dt0JgEZdxhQrAVSccRJMzZT
 A5zGNMaHOW44uhg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add LPASS macro codecs and LPASS TLMM pin controller on Qualcomm SM8750
for proper sound support.  These are fully compatible with earlier SM8550.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 202 +++++++++++++++++++++++++++++++++++
 1 file changed, 202 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index 76efb46edbb149b83179a5f4cbcb9072a5b5b107..20ddc16c49462cc316e22272cb630cf2478f52fe 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -2072,6 +2073,74 @@ q6prmcc: clock-controller {
 			};
 		};
 
+		lpass_wsa2macro: codec@6aa0000 {
+			compatible = "qcom,sm8750-lpass-wsa-macro", "qcom,sm8550-lpass-wsa-macro";
+			reg = <0x0 0x06aa0000 0x0 0x1000>;
+			clocks = <&q6prmcc LPASS_CLK_ID_WSA2_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&lpass_vamacro>;
+			clock-names = "mclk",
+				      "macro",
+				      "dcodec",
+				      "fsgen";
+
+			#clock-cells = <0>;
+			clock-output-names = "wsa2-mclk";
+			#sound-dai-cells = <1>;
+		};
+
+		lpass_rxmacro: codec@6ac0000 {
+			compatible = "qcom,sm8750-lpass-rx-macro", "qcom,sm8550-lpass-rx-macro";
+			reg = <0x0 0x06ac0000 0x0 0x1000>;
+			clocks = <&q6prmcc LPASS_CLK_ID_RX_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&lpass_vamacro>;
+			clock-names = "mclk",
+				      "macro",
+				      "dcodec",
+				      "fsgen";
+
+			#clock-cells = <0>;
+			clock-output-names = "mclk";
+			#sound-dai-cells = <1>;
+		};
+
+		lpass_txmacro: codec@6ae0000 {
+			compatible = "qcom,sm8750-lpass-tx-macro", "qcom,sm8550-lpass-tx-macro";
+			reg = <0x0 0x06ae0000 0x0 0x1000>;
+			clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&lpass_vamacro>;
+			clock-names = "mclk",
+				      "macro",
+				      "dcodec",
+				      "fsgen";
+
+			#clock-cells = <0>;
+			clock-output-names = "mclk";
+			#sound-dai-cells = <1>;
+		};
+
+		lpass_wsamacro: codec@6b00000 {
+			compatible = "qcom,sm8750-lpass-wsa-macro", "qcom,sm8550-lpass-wsa-macro";
+			reg = <0x0 0x06b00000 0x0 0x1000>;
+			clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&lpass_vamacro>;
+			clock-names = "mclk",
+				      "macro",
+				      "dcodec",
+				      "fsgen";
+
+			#clock-cells = <0>;
+			clock-output-names = "mclk";
+			#sound-dai-cells = <1>;
+		};
+
 		lpass_ag_noc: interconnect@7e40000 {
 			compatible = "qcom,sm8750-lpass-ag-noc";
 			reg = <0x0 0x07e40000 0x0 0xe080>;
@@ -2093,6 +2162,139 @@ lpass_lpicx_noc: interconnect@7420000 {
 			#interconnect-cells = <2>;
 		};
 
+		lpass_vamacro: codec@7660000 {
+			compatible = "qcom,sm8750-lpass-va-macro", "qcom,sm8550-lpass-va-macro";
+			reg = <0x0 0x07660000 0x0 0x2000>;
+			clocks = <&q6prmcc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			clock-names = "mclk",
+				      "macro",
+				      "dcodec";
+
+			#clock-cells = <0>;
+			clock-output-names = "fsgen";
+			#sound-dai-cells = <1>;
+		};
+
+		lpass_tlmm: pinctrl@7760000 {
+			compatible = "qcom,sm8750-lpass-lpi-pinctrl",
+				     "qcom,sm8650-lpass-lpi-pinctrl";
+			reg = <0x0 0x07760000 0x0 0x20000>;
+
+			clocks = <&q6prmcc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6prmcc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			clock-names = "core", "audio";
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&lpass_tlmm 0 0 23>;
+
+			tx_swr_active: tx-swr-active-state {
+				clk-pins {
+					pins = "gpio0";
+					function = "swr_tx_clk";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-disable;
+				};
+
+				data-pins {
+					pins = "gpio1", "gpio2", "gpio14";
+					function = "swr_tx_data";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-bus-hold;
+				};
+			};
+
+			rx_swr_active: rx-swr-active-state {
+				clk-pins {
+					pins = "gpio3";
+					function = "swr_rx_clk";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-disable;
+				};
+
+				data-pins {
+					pins = "gpio4", "gpio5";
+					function = "swr_rx_data";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-bus-hold;
+				};
+			};
+
+			dmic01_default: dmic01-default-state {
+				clk-pins {
+					pins = "gpio6";
+					function = "dmic1_clk";
+					drive-strength = <8>;
+					output-high;
+				};
+
+				data-pins {
+					pins = "gpio7";
+					function = "dmic1_data";
+					drive-strength = <8>;
+					input-enable;
+				};
+			};
+
+			dmic23_default: dmic23-default-state {
+				clk-pins {
+					pins = "gpio8";
+					function = "dmic2_clk";
+					drive-strength = <8>;
+					output-high;
+				};
+
+				data-pins {
+					pins = "gpio9";
+					function = "dmic2_data";
+					drive-strength = <8>;
+					input-enable;
+				};
+			};
+
+			wsa_swr_active: wsa-swr-active-state {
+				clk-pins {
+					pins = "gpio10";
+					function = "wsa_swr_clk";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-disable;
+				};
+
+				data-pins {
+					pins = "gpio11";
+					function = "wsa_swr_data";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-bus-hold;
+				};
+			};
+
+			wsa2_swr_active: wsa2-swr-active-state {
+				clk-pins {
+					pins = "gpio15";
+					function = "wsa2_swr_clk";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-disable;
+				};
+
+				data-pins {
+					pins = "gpio16";
+					function = "wsa2_swr_data";
+					drive-strength = <2>;
+					slew-rate = <1>;
+					bias-bus-hold;
+				};
+			};
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sm8750-pdc", "qcom,pdc";
 			reg = <0x0 0x0b220000 0x0 0x10000>, <0x0 0x164400f0 0x0 0x64>;

-- 
2.43.0


