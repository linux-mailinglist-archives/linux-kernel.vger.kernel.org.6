Return-Path: <linux-kernel+bounces-204124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D448FE486
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB5B8B235C8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402011957F8;
	Thu,  6 Jun 2024 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QyPaXgVt"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6796194C96
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 10:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717670532; cv=none; b=ttrRMPShCOdfYN31s2tjtiNAMq/tMvAhZM74caTnPp357+NyOaBWJOBvhj9+dXQhrlxIXKAFg0jGkxDTFd8xYSk8N8M6xHXGCHaTo++grVks+KqteG6FHo3o8zS6qBKM2ou1tX90Uu9gX7I/pvSIfjEgZhY1VBtz9gU5qt5rlpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717670532; c=relaxed/simple;
	bh=h0PX2xTWiWhOg10/xZkVPboJAIggiMEW4Fgl8sXfOiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OGNgRnccC8xDnvpGz0AQr9vXTeC7SAv0/YPnA1aMKM2lJxDKTM+zmhoAIglQopnKgDtfNy9vaBpltEiQjv3P1sHp6o2Qi9+VHkOvAEnx9YSBamNfwp4YjnI1r6OL5hyNPq5cf+71MTmWOBKZaZQXcJBqr2BBd8VnzZVCn0/Lhb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QyPaXgVt; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a68e9b84d0eso39685766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 03:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717670529; x=1718275329; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=towJUXLHUKORyZCMho0ELl/n6081XE90hez3yF0wXVQ=;
        b=QyPaXgVtOgkYYlzOWuS7elGkoFQmeVK99PbeMFRiW5rAE5N9In1codnQbqqnq7Ob0/
         sq37LcRgKMULzQK5/1mi6NrVo0ntoGmgmFRDOqmIzUzPIjHC3AwyVB3Pcn6+NKS1ZZw9
         56QKc5R7s9/gihYqtxTOBh9iKCrYvxWjYjTxoCs5X1HxNmDPLTHTec/A/jr8kTmUIeB7
         rrDHjDDSmQM2DywKllmzk6wwCF6hZI5tTvRwkhkFS6XB54U1ZJTtfwZcb88Ma+pfV9s0
         4IAGzKXh01nGst03VyGBEtr/ntwgRQFf1s0NVZFSyOcyFfeapZttBsbUqDs6eZHJXtGt
         2CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717670529; x=1718275329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=towJUXLHUKORyZCMho0ELl/n6081XE90hez3yF0wXVQ=;
        b=XJ03kJJE2hN9JauST4seTOrRLd0BhO4qLlFfEaydPo2wq94e0AKqULgS/OAWAas42m
         Hj3erhBUiNnkuFWw892f1JnXEmP+mu5G7yesYcz8qIt+1Zt1sa8mcw2EZqgINSzgqlh5
         Nvm9BSNGEyCQWgwOTi5IGTOhzXkO1WOlJ5nVcgrrovyCzU9RizdpoHXRhkfPQdx5HGXF
         OdM+W3B+NIOYzb/VBYcEXKQ5brLDOAzljn2TBobd0wfgwjYYw6LQV4wlXkN0kxIl0Zhw
         O4PGSxneA9Y6VMW407VoDn3n5DQ5lnwSkUKR9sM5/Sx+fl1VLovbLojoAywIBjmMLdJF
         asVw==
X-Forwarded-Encrypted: i=1; AJvYcCXFStvkgyvNNbBtGAPgDQdzPZbikE5RbUZ30gmAqsf+RpTX71w5lrswYjeufHNyiO/TYN/p83oW8avSOPX8e2+TBrzhPibQMvjKobSC
X-Gm-Message-State: AOJu0YybbjsmEM5KE1MQZ/LEENvRIHHsR72YjYSmF/OBUf3SMJEtqgTJ
	Krq/nae1y9T2JcvV+kR+AkAOfKkxPe/BUtIO77T1p+cYiFRUl4hJGp1dOIQAFjA=
X-Google-Smtp-Source: AGHT+IECARh5qgMJ1VCpc7OxMZxTSxc5TaC3Q+5phFFxK4uSho0MrtdordDoIQbD5aQSeuMCRg5Mwg==
X-Received: by 2002:a50:a455:0:b0:578:6c08:88fb with SMTP id 4fb4d7f45d1cf-57a8b6ab286mr4409555a12.12.1717670528994;
        Thu, 06 Jun 2024 03:42:08 -0700 (PDT)
Received: from [127.0.1.1] ([188.27.161.69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae0cc36bsm871477a12.26.2024.06.06.03.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 03:42:08 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 06 Jun 2024 13:41:53 +0300
Subject: [PATCH v2 2/3] arm64: dts: qcom: x1e80100-crd: Add pmic-glink node
 with all 3 connectors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-x1e80100-dts-pmic-glink-v2-2-972c902e3e6b@linaro.org>
References: <20240606-x1e80100-dts-pmic-glink-v2-0-972c902e3e6b@linaro.org>
In-Reply-To: <20240606-x1e80100-dts-pmic-glink-v2-0-972c902e3e6b@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3535; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=h0PX2xTWiWhOg10/xZkVPboJAIggiMEW4Fgl8sXfOiI=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmYZJ6OahTJsB5Y59YtGmbgZG3EfPMnO+IeIdgc
 s4B56/eu2eJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZmGSegAKCRAbX0TJAJUV
 VsKwD/4h8naLMfHdya1fw22uwF7iCGWXJCS6WDNC0Hp/wAux/tuEPXZKZQKXOZ/KWiW1j8BdIyP
 jj75hgJD7or8qBSvehVKFiAzsm4h+NTBkC4Wo0KgvVZ70LjFUG79oJFgvG9RhXDJ8j59kDR/nzV
 YaXOioTWXtOHX/uT0zXTNqgEeZlCAznIGN7C3BDqLhH3kAfxJa1toHW6Hnm/6SGGRRsAqmkPlXR
 mrfhza/+XrETugPY+Qs7F80TJMz+QcLPMJ9bneG6uzo1xgr+sA3ebFGknkUcWsjDfMSbrCkgKC9
 ln/ioFVWIjO5TEFpsGLmRzu7AJ4TglFEe0cwt/Uy7+9z+iUlo9Qt8yn5e123IbjDSZ+yDlIuruI
 p9cIO5Pa8qA0m1n6dHE/lsDCo7ZlhO+QrK8gdd7124HJ5ktJ01X1VYRdJVamoZW84URFvRJCglQ
 zyrYmCbA3p7h0TXxllUnLfvfx7pSPTkdX4KIwNT8rEZ350V4bG0B5nc5Le2/7n4u9NQS6r2r/k8
 Aycy+ucDpMPxuVNd0sL4ujNQDhkwKmJ2hmZQ76Qo+JKQqvARngqdrKpHwxAZU3WR6v9fmDI5Mhc
 7MElAGvat1sl2agV0AE98nN+wBT+IiWIvULPCepADzymlf7G+ipKJOUB+eAU8OBiQ+ycbrFU3m7
 VFG5yQNAFc4QdnA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add the pmic-glink node and describe all 3 USB Type-C connectors. Do this
for USB only, for now. The DP ports will come at a later stage since
they use retimers.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 122 ++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index f19d89d3d6e1..d0f28d8547b1 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -49,6 +49,104 @@ chosen {
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
+		/* Left-side rear port */
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
+		/* Left-side front port */
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
+		/* Right-side port */
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
 	reserved-memory {
 		linux,cma {
 			compatible = "shared-dma-pool";
@@ -915,6 +1013,14 @@ &usb_1_ss0_dwc3 {
 	dr_mode = "host";
 };
 
+&usb_1_ss0_dwc3_hs {
+	remote-endpoint = <&pmic_glink_ss0_hs_in>;
+};
+
+&usb_1_ss0_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss0_ss_in>;
+};
+
 &usb_1_ss1_hsphy {
 	vdd-supply = <&vreg_l2e_0p8>;
 	vdda12-supply = <&vreg_l2j_1p2>;
@@ -939,6 +1045,14 @@ &usb_1_ss1_dwc3 {
 	dr_mode = "host";
 };
 
+&usb_1_ss1_dwc3_hs {
+	remote-endpoint = <&pmic_glink_ss1_hs_in>;
+};
+
+&usb_1_ss1_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss1_ss_in>;
+};
+
 &usb_1_ss2_hsphy {
 	vdd-supply = <&vreg_l2e_0p8>;
 	vdda12-supply = <&vreg_l2j_1p2>;
@@ -962,3 +1076,11 @@ &usb_1_ss2 {
 &usb_1_ss2_dwc3 {
 	dr_mode = "host";
 };
+
+&usb_1_ss2_dwc3_hs {
+	remote-endpoint = <&pmic_glink_ss2_hs_in>;
+};
+
+&usb_1_ss2_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss2_ss_in>;
+};

-- 
2.34.1


