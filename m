Return-Path: <linux-kernel+bounces-524093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE95A3DF44
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7858E7AC4C5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E298204698;
	Thu, 20 Feb 2025 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fgXhFClG"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB181FDA62
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066267; cv=none; b=jxa/Of7REUZlTjbVwjzKXfRQuGMXWy5HtFfPgBO2oiSXIqHXWMFCAXmL+A4XrZUohJSAN2s6Lixqt5Rz88GNue0tT/mzWEBUUixzZFuh/+I6ZDUyAd3wU5NgXUUNi/ZCZkmpMqs0ouq7vyhfG6wMHONNqMhYYqbpk3fIWk4NZ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066267; c=relaxed/simple;
	bh=66DlPJwzm+YX/S5sA5DZ6Q8G2mY3WkRT+3p0txpEYGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jA8ijG/W9KuJ452C/XPlYg53hpYj7GAj589N3UqKFybSNf4pMgk5ZBSqR9i0XJFLWpZ+0wAVwfrzE7eJ/yPxKaY93M713QU6Ml+0A7pD3ciAD/8iY8K6gdeO+8E2dqaRGoUdI/G0YkfpCXVIqElMGZb/vC9nL1zfAUfYs9W6SB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fgXhFClG; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dc5a32c313so191820a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740066264; x=1740671064; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2VhvN6jhdR2GkWmkJMAr59edVOoHNxWabkri5JyhKbk=;
        b=fgXhFClG3K3046WKZzvQRXuQjhdydHmbjzvsHpLtOvqAvZg5o3D5Yq8qQq8d9PQWkF
         VslGOParnRgxp5fZQbFuLgGCU/5ed3yI9tTAlq9BT2Auoaq1ArqNO7YKL0hMiDx9SiPD
         nRbnbUuA1NyLiPrrAxJPxO3xmmjOiC73EL21jgGzmTf4afnjyXKnjf9tvNk46IEkNAfJ
         aP7p7M3Z7XePHOC7bUl957Yr6XNz8NslUioiUEhmCwwNd94MgYWDyFlrjhvzWK3v4rwc
         e2WWvmI/M3lz686XjSXNqCPQzTTX4mlAavVhQ/ZF2roffn9nPiz0wjr9sWCr44+sPeMX
         rYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066264; x=1740671064;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VhvN6jhdR2GkWmkJMAr59edVOoHNxWabkri5JyhKbk=;
        b=qzTd6KZ+NlnasucbCIgi366vwC2i3izOYHEAoAAKec6S49UgLsCNESGuHqw8UzizwA
         /kMTLROyNsOwBauA9J3tvdc/yeR4sxtYly+r2gAU9boQ4vQ9vUv8RX4SJuhO1J2ZIYHI
         gWhZ4nQGjegXkDZQKa4DG/JbTU85PIYO3cHlqw+IQZDUQbceYLj0Ul4doNSoTOCRt+5F
         XE+8nFXmEQVJbqoR21axalc7zPSjZ/hYPBBZC+DGgHFsDEGEVtQzhjza/Law01b8tBrs
         /qEumnGF7IJkb1bqJbXRQpdSHQlWT7/3rExnG/P0NtuLqsJC8KRB1yy6nzNZGBhHUZxo
         d7xA==
X-Forwarded-Encrypted: i=1; AJvYcCWQCAAFLLQXAutbQ8SoGqJWE+xqJB5y1lPS1SI3hf6StLZ/5X4XuMiHINmMehBW9ccVz3EWzk0Q2mIb0kA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+vVwVYRgog6rbJlIl9wdGOregkPX2c597mv+beVX49HUubvAu
	OmyuT9dodJAk0D9IrDvD36VtWigAhvNeTDhjYzRjXRtLb51sB3AR5j4tDvHTn0g=
X-Gm-Gg: ASbGncsSHxStc9EeXhYQMA7oLCoa7nHO5qi0wlA4aMATtQ93IyjkGMFdQpJ1+wUZKxX
	TjBvkQYjCwgCPMFCBp86NxzQKvrkBgMawIysiQRmlYXBtSXfh4q0JEUkKUhYQdy+ByU3Zp7JzYE
	cD6C6YG7/0XkJPll1Jd/ZIfdOIu8PPTkwbIgEpw+nf9Ls2Owi3wbxUDXYZ1Do3B79+kj6aTqegc
	HiOpIPW6gzCA4L8HFOsBf6YFsbhE+bJKHlUxv2T5fmqiDN4KIsb20MmG8YZwQQNVho9Tgv6wtNw
	B6BH5SMSCj8spq0WJt/CUlpZ5nJRh1ljeVSP0/4SdiVd42H2571JTTMtiTk3jIGgSg==
X-Google-Smtp-Source: AGHT+IE8sQM0hRfxW07DWV7Y3TfvUZlGpgzh6sAT86PmITsQ0amO9K7Z4jzde+T+DC5ytqhAnpGqsQ==
X-Received: by 2002:a05:6402:234f:b0:5de:3b3c:d02d with SMTP id 4fb4d7f45d1cf-5e036209716mr7777813a12.9.1740066264191;
        Thu, 20 Feb 2025 07:44:24 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece2881b3sm12418151a12.77.2025.02.20.07.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:44:23 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 20 Feb 2025 16:44:12 +0100
Subject: [PATCH v2 2/4] arm64: dts: qcom: sm8750: Add Modem / MPSS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-b4-sm8750-cdsp-v2-2-a70dd2d04419@linaro.org>
References: <20250220-b4-sm8750-cdsp-v2-0-a70dd2d04419@linaro.org>
In-Reply-To: <20250220-b4-sm8750-cdsp-v2-0-a70dd2d04419@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3423;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=66DlPJwzm+YX/S5sA5DZ6Q8G2mY3WkRT+3p0txpEYGE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnt03RUCDywvwWCeVD4w5mEnCSntjeTTA6gxZI5
 jYundXSvcCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7dN0QAKCRDBN2bmhouD
 16KFD/44EsLrwj41La0DqZKJAHxPx6WVw6+Irbl+ruqfHaztxZ7x+Pontl6XVoW+hHyKuf8SqQx
 LlD+D6xzYeP2luZyCCqFxugtcg7cPh4HED2S6WCysAvVzGZVNyu+Y2bt+bCp6+Mhf0sqPDsw1ny
 Uv5Tyrq+3pbhrIhf8ZVSlAeTXhBVvv9MGVUUfqpmCdq7iYiKV/DX3mNirHfeowl9bN1eTfbV4ar
 Fmq1psSuoNyhqlmJ9kqq/x88CZo9zzLiAPmAOU1UQWmHGF85y3i5zwq8JAFqEypGs/Y2AWSuuuS
 nIUCRnMj0z1KTB6ORBO2Gbb4QB48/Nq9GRi1wE82tKhbblLY8e4uvteV14k2ey46dfFzxdBCi0e
 Z7TE91b6CSpOj402uvZVjV7zKO6EtUcSo68zqjzn+ZGW6aNyQKzIc0C9WcfidZqHPJR6hLBSoyr
 880DOaByRAInUJ7FJS/3xHjs/k8vwwRto6X+/seBDva6ZTKNDx/VlHboFRkhEeTdrknyeuxk9fG
 y9hgDRQ6CpIKIgfDoCTN/i432S+Svh1A86jbCstHyc1DM4m0c5xOY58NSkYq1SaOKPZK2sk6n3B
 CScaK8bB7BkDibEe/EXGEiBQC6BqLaE0MBD1ym0tgfDBm8zctXNQ/SDn+jWUtN1kRLYBlCWZ0xd
 Kf0glRgNBd8PD+w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add nodes for the MPSS and its SMP2P.  These are compatible with earlier
SM8650 with difference in lack of fifth memory region for Qlink Logging.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 92 ++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index 033e8153aa73cea00d1d4394c572bf8e19231305..a0316514d8aaa3a3ec3599c1fb2f9b2ba948145f 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -571,6 +571,45 @@ smp2p_cdsp_in: slave-kernel {
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
 
@@ -2011,6 +2050,59 @@ tcsr_mutex: hwlock@1f40000 {
 			#hwlock-cells = <1>;
 		};
 
+		remoteproc_mpss: remoteproc@4080000 {
+			compatible = "qcom,sm8750-mpss-pas";
+			reg = <0x0 0x04080000 0x0 0x10000>;
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
+
 		remoteproc_adsp: remoteproc@6800000 {
 			compatible = "qcom,sm8750-adsp-pas", "qcom,sm8550-adsp-pas";
 			reg = <0x0 0x06800000 0x0 0x10000>;

-- 
2.43.0


