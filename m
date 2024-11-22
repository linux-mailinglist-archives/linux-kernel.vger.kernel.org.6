Return-Path: <linux-kernel+bounces-418410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3219D6155
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8FC2160515
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F841DED45;
	Fri, 22 Nov 2024 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OlWsWn/F"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0391DE2BD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732289226; cv=none; b=koYNL9MjUhbICHbpdb68FDELkd69XGVkjIFnBkmgxHsMJipneFfY3UyosW4hJwt1YfZvqeKxL/ManfXTekccAuEpp0TOK0m0KV9nk7Hlk2AV6l7qa1aGzJM6zGuCEJX85liE7DHTZSuUAo1BKhTQ36G1OaqcjsU99pEmjHf/S4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732289226; c=relaxed/simple;
	bh=p49U9NAU5krgj1dSK3Eb2xRq3GLwcQGpQocbS4+mhYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a1sIV02rWGzPSl2mW0BuD96yNxCmxndFLWv001zc6o3BeejPMZSFwY4bU65sMsH+aOAUVDyLeJBxu/sI/rWYjC0NgTUrmALVsM7cUs1tnpLPQiHGbPzDdVB/9CvdrBYW6lYqU2d1eo3cW8dCrDJIOMv6ZPXjLNv3uYFUP4nBhvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OlWsWn/F; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4314e64eba4so1472365e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732289222; x=1732894022; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vvTKaIGEGWboSFBGVBtY0+Yh8vni8ZgsmfuTvGtZ4ZU=;
        b=OlWsWn/FaXqhySJmf/UrZNs90ZDfn7ZI3WkcbfvDcTTaZ2McoiNdrcWHnuoWrYp/pe
         SkipmS0SSGDxfZmmrljFL/VKmDFjnfAg76JAAdd5ERHp19cRce0xG5jpvdNc2Is/OQY6
         9g1tkdoGkGxlpkMynliH5zQxOiFbXyyiwfqiQUpWL2M8fsTxlyDJhO+7O+o1//kwjMa8
         DRdsJoZgUMOqSBJlar2CEiQZWLP7PDxKm+F5hZ0VYA4ueCHYuaPtc9qcfI7jpKCo0h7b
         JZa1baNB2ANJNMdh+kEhfoU662db8JNzegCTyqmaRuKZp5oJbw6EKOL1NWKiEmCOHVUr
         FiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732289222; x=1732894022;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvTKaIGEGWboSFBGVBtY0+Yh8vni8ZgsmfuTvGtZ4ZU=;
        b=xFNlBJ6uVmxvJnbEt4r9QR6+cr8ep+yaqI3rXzGcJdSWInm/aF/Sp4QOFkz2jyVqPH
         0hTTnYz4sCtRTklhTej1ETM8HllgG1FEobD3eyC1xpm0xdrQTJOhmIOKjfNa0rgPF28V
         /EpTuMCTvuo6xJBAzb+IgZKRUXeSu9BP3/as/NoYyOTJ7IRBdJrOCuSoUr071WPbhUah
         eWb78GCMaL8wgeJgMa4CCHn+Zk7GxG6hllfi+sFKU7qvGmmiQoG4Idzg0C3QMEuNSA75
         VD2XZa/JsvTVsB7lTAlx7OQqlh3uhE5RPVM1AOYaws6iqVz6fCxfCX/LB4lu9ELcob3w
         yljg==
X-Forwarded-Encrypted: i=1; AJvYcCW6wHeH1NTWluDNf8lSbxoITw3vQMXzHEP6820QvxON/V7dLeWtfQyaJgl4YtMn+1GgUfCGLMKSK21BDP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA2+44C/Sa+dMlF3rlz1r/m38WaZsEevtBRUeLTxcYHE4d3m28
	I7iJFpXcqcgfiG0QF33u3rhfqMZ0X95UwAKTRcJIyZRknNVFeHisucvuw3JhDYg=
X-Gm-Gg: ASbGncvy97Awp4oMsELEzcyxMvLvMWeX9MqHFytLKdCyd+qlTu4esSDm6DToKOrRYni
	vGqJyoNkebhbNRS+Ih8Z2YbdqUaDFSghmO/S4DOVw15EI8NlknIHuF2OhIyYPkXeBfHBO2+u0Cx
	J+YkAkfdAQ/Pa3hI9Ssv+MIscYANGm5ytQD2f7wL9mbawbjqnSRYUoj4nXqt50P1vzUzspfW467
	vOKnIfAq37ABfwbwOAujRXYvHTM/FBeWxaRGin6jQT8FybK+MTN52LzzyiPFbd4Fg==
X-Google-Smtp-Source: AGHT+IEoQg99+8VQDt9Yj6MiOVpvbYoBq/F11g17I7xjVmQx2kHnHBIHX8GDjlF791PycbsXh4XqSw==
X-Received: by 2002:a05:600c:1d1c:b0:42c:aeee:80c with SMTP id 5b1f17b1804b1-433ce4f28a6mr12136905e9.9.1732289221765;
        Fri, 22 Nov 2024 07:27:01 -0800 (PST)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45d4c68sm93002935e9.22.2024.11.22.07.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:27:01 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 22 Nov 2024 16:26:49 +0100
Subject: [PATCH 2/4] arm64: dts: qcom: sm8750: Add Modem / MPSS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-b4-sm8750-cdsp-v1-2-9a69a889d1b7@linaro.org>
References: <20241122-b4-sm8750-cdsp-v1-0-9a69a889d1b7@linaro.org>
In-Reply-To: <20241122-b4-sm8750-cdsp-v1-0-9a69a889d1b7@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3207;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=p49U9NAU5krgj1dSK3Eb2xRq3GLwcQGpQocbS4+mhYI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnQKK+xQ4ON6WOOKUPsVxACRj4plAeXUcEB5fvm
 KBEmHvY7yaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ0CivgAKCRDBN2bmhouD
 14yxD/0V2vCFHGlSFPSRzj3MQSz6CUCBO9A2HYq2RwFIu4vXB9BE0M+iAmySgBH/YT/aKeV4gwt
 nRMvdSc7ndcaSm4bz3YbG22gESWeFfNBME94ApktGHKYTNrTu0YsQWW307Eq8zdIcSYQ9Nu3rts
 dT98j5K0EM2zK8Pt8u9Chu/yRTAtctG+j74RHLvCsadJZCqr70EmWeyBSxkOFToCrEF60Gcd3P4
 +TLm0mYkOwT2Dp7+nmMk00jaQ9DkYR+FS/lvINvqLzW/en9HDxNKcUQuleWeDK3Jl/qBZKT87FF
 VPpWUZQRkIe8BzUrfaLuOQjVcVNEXq64a1QQLy+C/HaZghK4DnvGlPLo0rNDHTQYpYYlmyFAmB0
 DR5WH78OTGw4nn0wzPsoqKR3Pp/a1C6n5YamBwBKElW9KtCLC9BTQae5wEyD2hAvyS+f4fNP/ct
 e6fZShmp3voTORpqBy8stW8R1pZbu48D/AjB2iX7itAZ6GY6EPxeNNS6wvywS1wycdEu/jiSYn8
 BekXLf4A+y3u55MD8DjDCkk7ucLacfbeyWFrIK5KjLtV+DZbMO6FxsioiRIlPNx20vXKNJFZrqr
 HTcJvkOnfrbXwUzJUIeBizzxDm5iNcxTz9RixhFyIKP6H6mM3I4DEI7kUyz4c9nDRux9/Yshv61
 1auuOEPjU4pzhGw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add nodes for the MPSS and its SMP2P.  These are compatible with earlier
SM8650 with difference in lack of fifth memory region for Qlink Logging.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 92 ++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index 344331cd97e292a46e3061760817acf643fbe1ff..798b3634299fc2bad96ed6061d4a304c35e5bafd 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -577,6 +577,45 @@ smp2p_cdsp_in: slave-kernel {
 		};
 	};
 
+	smp2p-modem {
+		compatible = "qcom,smp2p";
+
+		interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
+					     IPCC_MPROC_SIGNAL_SMP2P
+					     IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&ipcc IPCC_CLIENT_MPSS
+				IPCC_MPROC_SIGNAL_SMP2P>;
+
+		qcom,smem = <435>, <428>;
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+
+		smp2p_modem_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_modem_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		ipa_smp2p_out: ipa-ap-to-modem {
+			qcom,entry-name = "ipa";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		ipa_smp2p_in: ipa-modem-to-ap {
+			qcom,entry-name = "ipa";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		/* TODO: smem mailbox in and out */
+	};
+
 	soc: soc@0 {
 		compatible = "simple-bus";
 
@@ -3440,6 +3479,59 @@ compute-cb@14 {
 				};
 			};
 		};
+
+		remoteproc_mpss: remoteproc@4080000 {
+			compatible = "qcom,sm8750-mpss-pas";
+			reg = <0x0 0x04080000 0x0 0x4040>;
+
+			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_modem_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_modem_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_modem_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_modem_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack",
+					  "shutdown-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			interconnects = <&mc_virt MASTER_LLCC QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MSS>;
+			power-domain-names = "cx",
+					     "mss";
+
+			memory-region = <&mpss_mem>, <&q6_mpss_dtb_mem>,
+					<&dsm_partition_1_mem>,
+					<&dsm_partition_2_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&smp2p_modem_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+
+				mboxes = <&ipcc IPCC_CLIENT_MPSS
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				qcom,remote-pid = <1>;
+
+				label = "mpss";
+			};
+		};
 	};
 
 	timer {

-- 
2.43.0


