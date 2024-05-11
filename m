Return-Path: <linux-kernel+bounces-176754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE1B8C3474
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 00:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574551F21657
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 22:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974A836139;
	Sat, 11 May 2024 22:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U/Jp0kQ6"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDED357CAC
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 22:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715465060; cv=none; b=Looih5iSnS3dhHHQNlxwby3uNWt3PhTIvAVm4S6dUzdXNbUwqCMLFzlr5PT7XMBHyUOQfLKgOP60MQq5IevOWDvBoG6QIFCZtkg9LeHuZllOPwFuaiugk0sQsYbcvVGYW3SiFObgp3YvatwX1DSpw6no8EbaQ4WD30VUIao+Bqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715465060; c=relaxed/simple;
	bh=a9kcVLJINRQjpoiZC2UmTOwWA8hvy6/mvWba1iebDR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uwclBZYw7SbsmB2KDZN10F5Yy9uFmdeobgJWfNxq+6eAMb7WaZ6qeoCH/OXcRKUg/NpEf3Jl3ZhkviDFwtm1suFh/oZlTx1vKgSdPU5ZXWGK8BtKsDBSWqCpRyJ2JGyBE8s636yoH+RSSfrXJsVunZ4QDiRKjTEMYrwuVFWfTYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U/Jp0kQ6; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51f1b378ca5so5439802e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 15:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715465057; x=1716069857; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ZoNz5ZPbcdfkH8Q9Dq8w1uABfzSqWL28FXolBrGqXI=;
        b=U/Jp0kQ64BvJvU7uavXfVfiQyAZmbbtHRMR4xnRWTroj/LXMDr12h2mFjDOvjUEHoq
         h47lRm0bHOvKYXPMpZuht4RIaH3JthBVhqhlUJZ03+8tQ9YBx0w1TkN7/ULbytAfrM/4
         DFVZ2Pi6c54SLgftm4UwDNwoTwECffrhsy6LOJt3lr6R1vt1HA7EYGl5ts6CSayaeA3Z
         0+azH+cAMFj3etA0PJ9YjOmk/4nP6drpngCP9KDsvNMw8uEkCo3EWoh/ldG76Z6UUxJR
         jNz9pWiaapxBl/zwP3TT/OptUtp6Ddx350ohR5FNwy8ZpgRq+LvMYrD28QAtx/V3+tiF
         WTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715465057; x=1716069857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZoNz5ZPbcdfkH8Q9Dq8w1uABfzSqWL28FXolBrGqXI=;
        b=RcrmgNZ9OBtltJMP5RlA0ok1Wapg8tlvjbJ4b/XrZR2eLSbn0v3GqXTzV/TEo1EQga
         R9JhUNGg+lklCkU3vEMG4rc0BLB9mKAaH6tnb+fXuQuJHYkNcD4ofE6KDhmLtOZLUGtd
         XynDbLiMHeTBFodRS+xzHy5b9nEyztO7dKuX22q3u545ueyQtPmbnZShvYpe4grXgxPs
         9JCXcaamgqV9CHP/qjB4roIAqKA49Wq94LNXxurZdQ9VNe7WryAOhU7Qr/lbZnQtlviL
         Jj/Lk+NSXkHymAQNTK89lFuQZPTUTN/vkd6YlrO4wi8iqgW67N8l0GMeKp9jCpbe61i1
         cRgw==
X-Forwarded-Encrypted: i=1; AJvYcCWOJVOt5Zq+te/sy2izqprvNCx1a65Qti8xZ59l8G7w+b1xYFuTqcI4sF9c7EMZqnPs8E3WgdgqE89Z/o+GoB8GXuK4bSITnYW8ok2e
X-Gm-Message-State: AOJu0YzvgFnLVS2SnNlPaqtT5vKz7uo6iHXrFPEnbhTrGpcR/Gg9tdjs
	Ns8hftEmtQ18J01AjpLUkbEIStsbuY4T98ngCfULUoTTqwUnxl/Mh21BFi2J1kI=
X-Google-Smtp-Source: AGHT+IFti6082kulINHCb11ST0kcJc/2tOw/uyUDSIz/5jCNhk+xNvEJ7quwI/ht3wye4Z45wBEaoA==
X-Received: by 2002:ac2:51a1:0:b0:521:f39d:1a8 with SMTP id 2adb3069b0e04-5220fc7cd5cmr4289151e87.8.1715465056174;
        Sat, 11 May 2024 15:04:16 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d878fsm1123875e87.206.2024.05.11.15.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 15:04:15 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 12 May 2024 01:04:14 +0300
Subject: [PATCH v4 8/9] arm64: dts: qcom: x1e80100: describe USB signals
 properly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240512-typec-fix-sm8250-v4-8-ad153c747a97@linaro.org>
References: <20240512-typec-fix-sm8250-v4-0-ad153c747a97@linaro.org>
In-Reply-To: <20240512-typec-fix-sm8250-v4-0-ad153c747a97@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4103;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=a9kcVLJINRQjpoiZC2UmTOwWA8hvy6/mvWba1iebDR0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmP+tYsFqapM1YYmxE836Xc/0sqOR8DJWESBPvS
 QvSvWS3Z/SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZj/rWAAKCRCLPIo+Aiko
 1ZF+B/4wL1OetoBeuvqaIhWgG9oIV7YNxQKCafZNUz9F+oZ2a5jWm65Tc6tSxscv/20DEfDbR7G
 9aJQlOqC8ogI+wKNOXvYv3I0kBfommG6BV4T6/zNrUTG2hl8+Q2E0vzdGiRD1TXWXzqVDnBEPVQ
 3/M6tvSMjOYk87UuDlZSRo9871VUqBnnKTCU3/ajVjzG7EYomL96m5/866f4MzOBGeo0OM33/d8
 gJjjsTc76PP5Mmx0jpaVwYEM2Q9EimlQ3U1r1/3+7EVymDzryS3pbaX5YHtMb77rL7lJ2hGTiv5
 E81UQ6hKl9vudQ0XID3hfsn/Dhi+SFg1teJqqzJN95uyF/LT
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Follow example of other platforms. Rename HS graph nodes to contain
'dwc3_hs' and link SS lanes from DWC3 controllers to QMP PHYs.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 149 +++++++++++++++++++++++++++++++--
 1 file changed, 141 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 5f90a0b3c016..cf8d8d5b1870 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -2543,6 +2543,33 @@ usb_1_ss0_qmpphy: phy@fd5000 {
 			#phy-cells = <1>;
 
 			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_1_ss0_qmpphy_out: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usb_1_ss0_qmpphy_usb_ss_in: endpoint {
+						remote-endpoint = <&usb_1_ss0_dwc3_ss>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					usb_1_ss0_qmpphy_dp_in: endpoint {
+					};
+				};
+			};
 		};
 
 		usb_1_ss1_hsphy: phy@fd9000 {
@@ -2583,6 +2610,33 @@ usb_1_ss1_qmpphy: phy@fda000 {
 			#phy-cells = <1>;
 
 			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_1_ss1_qmpphy_out: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usb_1_ss1_qmpphy_usb_ss_in: endpoint {
+						remote-endpoint = <&usb_1_ss1_dwc3_ss>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					usb_1_ss1_qmpphy_dp_in: endpoint {
+					};
+				};
+			};
 		};
 
 		usb_1_ss2_hsphy: phy@fde000 {
@@ -2623,6 +2677,33 @@ usb_1_ss2_qmpphy: phy@fdf000 {
 			#phy-cells = <1>;
 
 			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_1_ss2_qmpphy_out: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usb_1_ss2_qmpphy_usb_ss_in: endpoint {
+						remote-endpoint = <&usb_1_ss2_dwc3_ss>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					usb_1_ss2_qmpphy_dp_in: endpoint {
+					};
+				};
+			};
 		};
 
 		cnoc_main: interconnect@1500000 {
@@ -3445,8 +3526,23 @@ usb_1_ss2_dwc3: usb@a000000 {
 
 				dma-coherent;
 
-				port {
-					usb_1_ss2_role_switch: endpoint {
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						usb_1_ss2_dwc3_hs: endpoint {
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						usb_1_ss2_dwc3_ss: endpoint {
+							remote-endpoint = <&usb_1_ss2_qmpphy_usb_ss_in>;
+						};
 					};
 				};
 			};
@@ -3514,8 +3610,15 @@ usb_2_dwc3: usb@a200000 {
 				phy-names = "usb2-phy";
 				maximum-speed = "high-speed";
 
-				port {
-					usb_2_role_switch: endpoint {
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						usb_2_dwc3_hs: endpoint {
+						};
 					};
 				};
 			};
@@ -3590,8 +3693,23 @@ usb_1_ss0_dwc3: usb@a600000 {
 
 				dma-coherent;
 
-				port {
-					usb_1_ss0_role_switch: endpoint {
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						usb_1_ss0_dwc3_hs: endpoint {
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						usb_1_ss0_dwc3_ss: endpoint {
+							remote-endpoint = <&usb_1_ss0_qmpphy_usb_ss_in>;
+						};
 					};
 				};
 			};
@@ -3673,8 +3791,23 @@ usb_1_ss1_dwc3: usb@a800000 {
 
 				dma-coherent;
 
-				port {
-					usb_1_ss1_role_switch: endpoint {
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						usb_1_ss1_dwc3_hs: endpoint {
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						usb_1_ss1_dwc3_ss: endpoint {
+							remote-endpoint = <&usb_1_ss1_qmpphy_usb_ss_in>;
+						};
 					};
 				};
 			};

-- 
2.39.2


