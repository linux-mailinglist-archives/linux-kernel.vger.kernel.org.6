Return-Path: <linux-kernel+bounces-570887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753EBA6B5D6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9613AF7F8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C1A1EF38B;
	Fri, 21 Mar 2025 08:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="PV2nzyzq"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4BB17C210
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742544793; cv=none; b=aY61mXTm9uTwNjUR4VnTpk/h0jYdwU7HP1JbZn1wqEX5bhWD1/GzK6J7JrD6ZvgjeGSG15zdf1/JPGGjonFd6ekraGr7489YgX6zsbKhfqT2BsPuDkB7nXf1aL+qoMJSm8OP5zM7fb4t+eh1Qkf7V5yeNjB/c4phS/yDaUh0who=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742544793; c=relaxed/simple;
	bh=i9GzDoeYHWXocHTV/J92qBEXkO6eo++ROgOYxc2baOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dPKZCjT+o9rap/mdwH8vkz+dPDZSEJ24+Mk/MjjTkEKA33IDLDIlHiI0cr2c2OAVmmwiHyxdDEr8dh5IIPGp/dKDKwBuaz9+p4TkJHCLW53k80J3fWK82oBWc9YYSEvH7FOaoEA9ibwwqr+G3sLOwm1RDZdXnbEBl1DaXLizrhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=PV2nzyzq; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac345bd8e13so299319566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 01:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1742544789; x=1743149589; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jev2S5q0Uq23ZefU3EZw33sQyKB4WKTRkFhU4RqrJYc=;
        b=PV2nzyzqpCInw/j8dN5reUbNXmuyRJVSHtBjUVWZlHRERuG+05StQwoHTfQOd3sqIr
         svmiqYAfkvoo0q7QrZgBma9ZFAxk6i2NJdmb+4DRt4jWX30NXLPbZy+UGkcl/HV2J0Fd
         jOzfA5XPfIafql8pTAiFXHOwYh/G72VYJRsJx2i6LAd0tcQLtWj4OCyQLw1+V/w3JNiG
         VWdhgX4Mmbit61r9RlDwHBNNk6w4+UkP+/Z7n2hakfVqp5xyFSEG6h8dR276lFHZds4q
         JIknrllwIIkWLYhN5HaeNywvBP7TfelEfxt7uYW7qjVxLePR/NSURNVU+wH6tTI4uHsS
         8Z1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742544789; x=1743149589;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jev2S5q0Uq23ZefU3EZw33sQyKB4WKTRkFhU4RqrJYc=;
        b=C07t/80h9GGK7T43GehDl1goeDcyF/5BC7nKHoFceBoWRYJ4grPxcqUwsLpFNy6xNF
         Pqo2HMOtzw3ikGMQ/58SsOGbCPNEpVnRfcSOqfFEV9zH2+2vonZZjVRER2VZNOmJWkzk
         Y5wH/tQig/IlmRCG7lh1e0mz+2QoGJdgbbzUoYilpqaSvmYIACks2dbYxf5hkg9jabSj
         2p+N4NuA3U5TGcDSQpVj+L75jsi1mTQRiNr7FELiaLhmU68y+sEGiKdmguA7q+vTmeqL
         rAP31OTUgcWuVw9gPkx0s94Yw7+6tMj+eWHyHLQFDwVm/eAMRR8/JVFVtwop+JohDeFN
         E5mA==
X-Forwarded-Encrypted: i=1; AJvYcCWf2uMvkAC4qI6S4zmAtbHwAmw6S28ZkeNb9v9LJbXJa0NM736/RY6AFOAddls1vH18DCwVudaVRWhgcMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR4GysgFV4I8WJnPNwxxEW6/78q1PxW9phdF+ubSXKYjmYOzx6
	jK7UlXc3VLb0flhqI/AOzD09E3R6x54Z/yWrH36E6GzqjQDJZwLMCUV0qqw17Iw=
X-Gm-Gg: ASbGncvIGSsG480qB9ePSB1u+hPiLTqmOmyV0FJ13hOQDvVUw5kyy6kF7/odz0vASex
	/3kwoWRhPikx+ZJ1zOTi65l9YRn6vtOeNmtc8yx5rqDO31T/YEwmEis170LFARb7TDwxIxd2zVy
	muWKuQTenLNQamFt1iaLFaTUxF14w0jsFRUvjiqzSPdAvahtYZlvwNwjzlAHrOGcX6azwSGlD8p
	ZKNtbOgcSI70zjqk+qDIILDmCJfC3n9paT5A9l6BdEtAzRlYS8RmRGWTyxhM8FbsEoeyHQw/kWU
	VJS5Ru/SWLMHugwcWbvkaCXWSgvIljO6PnjVt9MuhQxUmpJLCe4wtn6q7QEDYM5U408WhnmuERc
	ClSBupsKjafKi9ErltA==
X-Google-Smtp-Source: AGHT+IGAzC8uX4v7JqMexA3WN+wQ+YLOprWk5/TUdTQL46LPhqZiEkYuSKewAa1iYNwiAYxSSLKZaQ==
X-Received: by 2002:a17:907:da0c:b0:ac3:f683:c842 with SMTP id a640c23a62f3a-ac3f683c845mr175817866b.42.1742544788929;
        Fri, 21 Mar 2025 01:13:08 -0700 (PDT)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efdaccc0sm104891066b.185.2025.03.21.01.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 01:13:08 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 21 Mar 2025 09:12:57 +0100
Subject: [PATCH] arm64: dts: qcom: sm6350: add APR and some audio-related
 services
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-sm6350-apr-v1-1-7805ce7b4dcf@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAIgf3WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyND3eJcM2NTA93EgiJdQ9M041TzVJNU0+REJaCGgqLUtMwKsGHRsbW
 1ABDZ8zZcAAAA
X-Change-ID: 20250321-sm6350-apr-15f3e7e4e5ca
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

Add the APR node and its associated services required for audio on
the SM6350 SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 59 ++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 00ad1d09a19558d9e2bc61f1a81a36d466adc88e..30d5658665339bdfd803246054878fcb932a4a9d 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -18,7 +18,9 @@
 #include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/phy/phy-qcom-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,apr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -1319,6 +1321,63 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 				label = "lpass";
 				qcom,remote-pid = <2>;
 
+				apr {
+					compatible = "qcom,apr-v2";
+					qcom,glink-channels = "apr_audio_svc";
+					qcom,domain = <APR_DOMAIN_ADSP>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					service@3 {
+						reg = <APR_SVC_ADSP_CORE>;
+						compatible = "qcom,q6core";
+						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+					};
+
+					q6afe: service@4 {
+						compatible = "qcom,q6afe";
+						reg = <APR_SVC_AFE>;
+						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+
+						q6afedai: dais {
+							compatible = "qcom,q6afe-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+						};
+
+						q6afecc: clock-controller {
+							compatible = "qcom,q6afe-clocks";
+							#clock-cells = <2>;
+						};
+					};
+
+					q6asm: service@7 {
+						compatible = "qcom,q6asm";
+						reg = <APR_SVC_ASM>;
+						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+
+						q6asmdai: dais {
+							compatible = "qcom,q6asm-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+							iommus = <&apps_smmu 0x1001 0x0>;
+						};
+					};
+
+					q6adm: service@8 {
+						compatible = "qcom,q6adm";
+						reg = <APR_SVC_ADM>;
+						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+
+						q6routing: routing {
+							compatible = "qcom,q6adm-routing";
+							#sound-dai-cells = <0>;
+						};
+					};
+				};
+
 				fastrpc {
 					compatible = "qcom,fastrpc";
 					qcom,glink-channels = "fastrpcglink-apps-dsp";

---
base-commit: 73b8c1dbc2508188e383023080ce6a582ff5f279
change-id: 20250321-sm6350-apr-15f3e7e4e5ca

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


