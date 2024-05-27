Return-Path: <linux-kernel+bounces-190194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E96D68CFB04
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04A8280F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674485490F;
	Mon, 27 May 2024 08:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mkIKu3FS"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4EA3C6BA
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716797265; cv=none; b=qoGaLpwplvXpqcQ+gzEGLrnn65km9HcmUWnFCh6meoPWD+o9wBg4Yfd9cpdiuYxMMxf446rflCTgkrJzSRcRGcEYQArTrJo2saokLRO0/oBFpq8JC1EQgvPzMQYdmyDoFMpzKjEsaJ3LLbO1EeTdjv0yftkrOCzUY2yq1G54Bqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716797265; c=relaxed/simple;
	bh=0K4VHzS7JijMYhdg/yqlESpYmlpt5lze8eOI2eCFnBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GRfoOLqYIu6eTyXNs74xnja80GmrgrjdmDTpBspOFQUJivyIzdZHk/V5fez2otTUR7b/16SYlOdUBylCuTGfLfL/F51+WZkEngMR92eypvTQTVJ9eLJ/erursTYobJuWtH9VCgqU8PaXI6B75T5znc0tGocqT5Kgt+55dCZKKS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mkIKu3FS; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a628f24a881so98100166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716797262; x=1717402062; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OAkpiG2WcQO5F5//mbNfjMkbNsZQ18DtYIGSneDgeec=;
        b=mkIKu3FS4YgDIHnBoDa/czCctR42w05FSxLeTnxfaMwzuqhofv5QLEtkUIeHeXWAWk
         i2CNbBY+bVvcmLqzsMKtFhrFMS/m1nBQ6R9/dHzoxADu/QawJV9cz4nIKXvPXAKZwUW3
         t5aHNfQihirjYW7HFI8qRDaUxqELmYtEKuMdaE+fcdvUzEXPKL4qaPzOgXY1T5sIpuJm
         d8u2uv3y9cemc5qv/Bry3nwNurEKFN7txe5lDk06gORO1fALOJmllmpxHQx6pHThwPjJ
         2UNCCX+GuFibICzKKAqPN2V6k4xHNv4F5aP3aJrmWmf9EQ6HA4MQ+8GQB+p4o/6i8vvq
         B6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716797262; x=1717402062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAkpiG2WcQO5F5//mbNfjMkbNsZQ18DtYIGSneDgeec=;
        b=IoLnoGEdyg9YhltLzH8mfwkfKL6L9cUu5N+oChoAiFlJpO/n40cdj10R1tZDbV5TAb
         +s3M46negITvg4Ml24VWQwEbkv4ODzMlRQrVopTUMHHCCQFoUEKtEISZEWvAzzWBVFTd
         oZXvGAOiwwx3aIhNp6o5kENm0VI8WSAMpVsjtZtsxmy4bJGlqdJafai8+/E/kyQlNSE0
         67XU+KplU/hC28vi3tOXs3zPBUGebsRA75kGpTl8eO1UDt1Q89d1ABTruXv9pU/jSSAB
         En+CJ03sf2a0YFKE0yCMPOJFvY3nYcUo8VefapOjyjWy6rEobRC9+R9i5TPscTLn2Ciq
         EHaA==
X-Forwarded-Encrypted: i=1; AJvYcCUmEnYn1klDa1G+FfrZzNPOd3iw5rWZmbbuCyaRFJ7z0//EdhPCHalh4nPt1TFZ4RQgZCNmKERXabsjChCjuxK77FU7QKgRNawWSdXE
X-Gm-Message-State: AOJu0YxnFmIFwMMcjDSIbJUIqemn2hJLQAEbQJoL8U9O2c15sv+B3hh2
	ojk33TOt73qBvDQogniKfJH4mvf3+guVeSEDU9CLgxOqLuLVBPHFSHoHLYNWt518B2p4zy+04Rm
	J
X-Google-Smtp-Source: AGHT+IFB9ryjqGl/QrGf5X5oVtJ9MtfYw3bPT+7NOdbkzMdVcAAqG4l+F8nPfMId+xB8gQU7k9IfHA==
X-Received: by 2002:a50:8ad1:0:b0:578:5b30:8bfd with SMTP id 4fb4d7f45d1cf-5785b3098cemr6499750a12.21.1716797262034;
        Mon, 27 May 2024 01:07:42 -0700 (PDT)
Received: from [127.0.1.1] ([188.27.161.69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579d30b82a8sm1240893a12.79.2024.05.27.01.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 01:07:41 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 27 May 2024 11:07:28 +0300
Subject: [PATCH 2/3] arm64: dts: qcom: x1e80100-crd: Add pmic-glink node
 with all 3 connectors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-x1e80100-dts-pmic-glink-v1-2-7ea5c8eb4d2b@linaro.org>
References: <20240527-x1e80100-dts-pmic-glink-v1-0-7ea5c8eb4d2b@linaro.org>
In-Reply-To: <20240527-x1e80100-dts-pmic-glink-v1-0-7ea5c8eb4d2b@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3953; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=0K4VHzS7JijMYhdg/yqlESpYmlpt5lze8eOI2eCFnBI=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmVD9HYydzKT2P+zMLzZyfUebAmSH0ruuw6qjC+
 lTHveMOGq2JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZlQ/RwAKCRAbX0TJAJUV
 Vn1rD/9z9A6LAXjJDXou4iVIMkjaboYZV76C7ty6PcQ+8MHXqlIpw2CCLf9HfYjjjdHePsEwlth
 vLEvROQcWCDVGOOnQv9wZ2Gwz2qvzu/1TNYLi3vqVJ0IvXGnXdL7NL6IGeswQCEH6ID6/p9FICf
 0TLq0ujp2tpaRooxXkn7xA7IV8BMGYH5CrRorZjxyqlbk79LbnScqtSnv2cCOItm+2nVvJuJMq9
 X2RcEUq28RZZKgZoNUFncWX0xN8a3wcBN5BM7qLV7nCqdQF7nN5yhZ73T8+fwWAaoVH3tfdiCyd
 xOfb+7wbuFdK5zXY15IMDeqpQn8a6pdZht6/pC1CT+F9ElvGaOFdNz+KTuSxGChXN3VadCZd7n3
 nvoYkd2kfXi6XIO8LqSSuA/eOCzJFf/RpkmzJ//OmP3Aur98ioVKDf786GndqMscJLP8lmhhTLf
 E5kieOHF1usBMgQyDoC06fnSagf7MWVyfLkXapIaXYAAbCIR6tCUJjnGfPrRVVOLwkiA/IMEama
 fEXWDZwXj7o+ip5MGh5+2CeobWxUyYEsiFzAbOw7LE3cO56G8JTq6OvGb1gWJYY5a2bS93FaGqV
 WLOsJCOjmhGUZi6fe1R19GToaM0Rqfl6kGh4MoDWqQsF1ezQJ4Ba4954wH//BvBZChyrpMYWkM4
 rmLDPZKptaPfbwA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add the pmic-glink node and describe all 3 USB Type-C connectors. Do this
for USB only, for now. The DP port will come at a later stage since it
uses a retimer.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 143 ++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index c5c2895b37c7..2fcc994cbb89 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -49,6 +49,101 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	pmic-glink {
+		compatible = "qcom,x1e80100-pmic-glink",
+			     "qcom,sm8550-pmic-glink",
+			     "qcom,pmic-glink";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		orientation-gpios = <&tlmm 121 GPIO_ACTIVE_HIGH>,
+				    <&tlmm 123 GPIO_ACTIVE_HIGH>,
+				    <&tlmm 125 GPIO_ACTIVE_HIGH>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_ss0_hs_in: endpoint {
+						remote-endpoint = <&usb_1_ss0_dwc3_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_ss0_ss_in: endpoint {
+						remote-endpoint = <&usb_1_ss0_qmpphy_out>;
+					};
+				};
+			};
+		};
+
+		connector@1 {
+			compatible = "usb-c-connector";
+			reg = <1>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_ss1_hs_in: endpoint {
+						remote-endpoint = <&usb_1_ss1_dwc3_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_ss1_ss_in: endpoint {
+						remote-endpoint = <&usb_1_ss1_qmpphy_out>;
+					};
+				};
+			};
+		};
+
+		connector@2 {
+			compatible = "usb-c-connector";
+			reg = <2>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_ss2_hs_in: endpoint {
+						remote-endpoint = <&usb_1_ss2_dwc3_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_ss2_ss_in: endpoint {
+						remote-endpoint = <&usb_1_ss2_qmpphy_out>;
+					};
+				};
+			};
+		};
+	};
+
 	sound {
 		compatible = "qcom,x1e80100-sndcard";
 		model = "X1E80100-CRD";
@@ -852,6 +947,22 @@ &usb_1_ss0_dwc3 {
 	usb-role-switch;
 };
 
+&usb_1_ss0_dwc3_hs {
+	remote-endpoint = <&pmic_glink_ss0_hs_in>;
+};
+
+&usb_1_ss0_dwc3_ss {
+	remote-endpoint = <&usb_1_ss0_qmpphy_usb_ss_in>;
+};
+
+&usb_1_ss0_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss0_ss_in>;
+};
+
+&usb_1_ss0_qmpphy_usb_ss_in {
+	remote-endpoint = <&usb_1_ss0_dwc3_ss>;
+};
+
 &usb_1_ss1_hsphy {
 	vdd-supply = <&vreg_l2e_0p8>;
 	vdda12-supply = <&vreg_l3e_1p2>;
@@ -874,6 +985,22 @@ &usb_1_ss1_dwc3 {
 	usb-role-switch;
 };
 
+&usb_1_ss1_dwc3_hs {
+	remote-endpoint = <&pmic_glink_ss1_hs_in>;
+};
+
+&usb_1_ss1_dwc3_ss {
+	remote-endpoint = <&usb_1_ss1_qmpphy_usb_ss_in>;
+};
+
+&usb_1_ss1_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss1_ss_in>;
+};
+
+&usb_1_ss1_qmpphy_usb_ss_in {
+	remote-endpoint = <&usb_1_ss1_dwc3_ss>;
+};
+
 &usb_1_ss2_hsphy {
 	vdd-supply = <&vreg_l2e_0p8>;
 	vdda12-supply = <&vreg_l3e_1p2>;
@@ -895,3 +1022,19 @@ &usb_1_ss2_dwc3 {
 	dr_mode = "host";
 	usb-role-switch;
 };
+
+&usb_1_ss2_dwc3_hs {
+	remote-endpoint = <&pmic_glink_ss2_hs_in>;
+};
+
+&usb_1_ss2_dwc3_ss {
+	remote-endpoint = <&usb_1_ss2_qmpphy_usb_ss_in>;
+};
+
+&usb_1_ss2_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss2_ss_in>;
+};
+
+&usb_1_ss2_qmpphy_usb_ss_in {
+	remote-endpoint = <&usb_1_ss2_dwc3_ss>;
+};

-- 
2.34.1


