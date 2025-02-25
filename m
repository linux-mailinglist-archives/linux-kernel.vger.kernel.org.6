Return-Path: <linux-kernel+bounces-530990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DEDA43AD7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A267C173ACE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5EF26BDAA;
	Tue, 25 Feb 2025 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ydj5M87M"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBA426B2C4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477575; cv=none; b=iarSy5QPpfUw8kAot4s0ovwqql/nBTMd2YlomyfyWCz3Ng+rE7Mb/c+xn9vutVxNEVjW7ExQedz70kjuVb6RVvkEg+KXK9W4W46dM806j81T/S4uX24i05TOm1hc7PaFr23uo6mvr4xw9QSh1oLOpldok5cgm1zCQEBlKhFmAd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477575; c=relaxed/simple;
	bh=9axhRUPtqIp6coUbfFJPOadnSuK9bR15DrSsGVMUkIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WofnZQl4q0r1QaDQgvk8OWH/PiRAVvXrcRKeXBq5JdX8Qa7ff9CjDirnaN7DfefzIH1ccFQ391R8jT+NIvyvZhY/QDv/Xi/vPk5OBfEw7LVYivdNaPsWKTyxRlVap6OlJEsDpIJUWJJRhUVbggtuekBI00AD1qVUjfMpPfEHzNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ydj5M87M; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab7dd005cb0so77669666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477572; x=1741082372; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2IH4+kpUxnVHlE+88wJ2mkHAu8KVwj1hJxUHrr0olA=;
        b=ydj5M87MtVf/Up3kuXI5wH4IPH53yACM9mOjOWAdDEJ1A6SyBTUGirxWsQG7dvMvsl
         hen12cdukrNxX4ijIYm03+96cKgLeNIk8RRSz+PiqKhSjC/XWiu4MTeH/7nruTXPTl58
         SwobR6Ilk4TEcKHxiOf2qU1OEHUaBt5VLUBFJB9jH72oudSARxr/TgPCbbuBBQvmrVv/
         jyur/gd7lGqqaKQ+ZFh4HVuPzqJCtZco4RdCKDALaH713rLHM4lxitxo2Sv1A/DCPbUI
         ZZlP8Q0mcd/vgJ4jcQ2rYDY1QBqAiNIQGN1OHZnmp9BSvPETKBYXHq7JCAAF8yKMyUCo
         2xiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477572; x=1741082372;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2IH4+kpUxnVHlE+88wJ2mkHAu8KVwj1hJxUHrr0olA=;
        b=FA4un0mNuKQo5vdze5FQu+mrOmfYF3/y1KaUTpnbyr4C165yFG3TeCW7vFFXvjLDGX
         hUJAHwXycrPmpTtRCaiRQYpNdgRUlGEuXHb7rAEMxScbox5AwFcJkztQs/rmtbi55Kzl
         xdmnFNA4DZ/lk9FnAhIbqAaUYMk/SGG4QxMfk9iD5jiF/hRlenfr72XGHSEfsRxRJCv0
         uP6mruRKl4PVgRzd8yhpya5xjw/Mh/n4M/vTPZbB64Vri66nVcXpBLIgcSBrFhCsZZbh
         1SFOfORE27DvyIWqwRcs5sTxO1+i9V+wpq49vfqnIAAtlzmi1pEcpaXUUgALffWRmMMS
         vW7w==
X-Forwarded-Encrypted: i=1; AJvYcCXGPBWp+6XI1IiEDLryqCN17+WeLPWXcm+nwIO2Q/ceZdaCjkv8fGgQzD4lHLABE5pmto507jk4K+HNNds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7RCvVM2eNTtUDR2Y+gbiCY/iY7jlW5APMIa9ymt3d8ch3Zst3
	9bg5RDuFGcpLQQ1eH+AcmGH/M36AKnITpapHBM+H5hId2pKqH7N86YJ+lNHzhZE2au0a0yvLatE
	pJsQ=
X-Gm-Gg: ASbGncs+ssP731wGsuGDd7D3A616JmjVn8y9wY8CGPsKq3Da3XF6ySCN97BeeGiHHH6
	/OVm46e1teNI5UQYorIYAmbOY+hPlekU9a/OYP5IZ06liy17qK7yCOPuvjbQmRyyUX4nkb23YKZ
	bV4ZqQT7FB+NmEslyqfoxSOTSp6malht5QarJgwUzrIE0VJFwOJ6pKVzAQMkBXsBUrTOChz9sO/
	ZM+NK9ByfyIr0vgAdh3x7YnW3tARLHGr2jUD4VyvqN11PAXAT8qnq5lgPgU/ggC9JYeGukLG8nw
	VlJn0kva5wOZIUJ51FZURUvaWfdjH8xiuxtYK3uDyxRR3dzM0s+muPF8CjmJTJ4VRYY/Qu28KVM
	s
X-Google-Smtp-Source: AGHT+IEzJFTfwpzVJRQ2TXmtpDbGVyMV1SKSC8zAMLLwva0niWRxH2Iz2D/Kp26w4+Ab/IoK0ZPdQQ==
X-Received: by 2002:a17:907:6d22:b0:ab7:6056:7a7f with SMTP id a640c23a62f3a-abc09bccc3amr564699766b.9.1740477572405;
        Tue, 25 Feb 2025 01:59:32 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d59391sm115164266b.56.2025.02.25.01.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:59:31 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 25 Feb 2025 10:59:08 +0100
Subject: [PATCH RFC 11/13] arm64: dts: qcom: sa8775p-ride: Switch to
 undeprecated qcom,calibration-variant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-dts-qcom-wifi-calibration-v1-11-347e9c72dcfc@linaro.org>
References: <20250225-dts-qcom-wifi-calibration-v1-0-347e9c72dcfc@linaro.org>
In-Reply-To: <20250225-dts-qcom-wifi-calibration-v1-0-347e9c72dcfc@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1041;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=9axhRUPtqIp6coUbfFJPOadnSuK9bR15DrSsGVMUkIA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnvZRwryrWt4Axl8R2h2rToTzXHKWUW5i4Rts5F
 ccRySQ9QA+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ72UcAAKCRDBN2bmhouD
 19JoD/0TUzvpihO2CTpRHIsMRX9/3fR/cqRNustTfcnh6Nw2oHN9djgw51V96EL/YShHt8X9C7L
 q6sMZBpEs9UpSCxvbXgeAFXpqS9nk4eeyZaeSGJ5EwXKW+HyMalapX5Rg80dTV814KOiOtMOEDN
 C6D0DrPBIU9v9MBFCd9bHgsU8513UBeY5hcAC5XT+V+Z3apLoa/2fc0S+i4ypKhEBDvyyInbukh
 XXGeZrVSZyVKzVsjrJW7j1+j5+r5Zk4wAzgr2lRtMmYlSc1S0HhFT4mLlhjVB8l2VIxHwxnMixZ
 0frOs4T5SuC3ILy9FZ2ZXjseYbNQxsLCHIK6ePLv9l73ALy+vwEGXK1LeE04KA7gcqGwQVxtHuF
 wF3BgdLugE8U4QRvtWtGYvvXD3IwOVRmilxotDPSy1eWVpmY5+bOd5iGnYJc8I+MYugzdZR720m
 41NohI9FRJ97h8UOB+y3hC8M9aDPnHDpIs4zNwGsewhELfJfqeHrar7AdPPG6pX470mawLmVrDT
 Wq25z7QPbdDu/X2jyyrnacHJServhMWTkhJQxBNLvLRK2PaNp09+RaC1+G1D620wojQ6zB5WS92
 QCKNFt8B/h/OKfKva/V1Ss3oJS5RDaRtgU0dGL1CNHtXFZAt2HtRyEa1QzUqHb/rSGyqHZji0CK
 MmaSPRyX2v0kn3w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The property qcom,ath11k-calibration-variant was deprecated in favor of
recently introduced generic qcom,calibration-variant, common to all
Qualcomm Atheros WiFi bindings.

Change will affect out of tree users, like other projects, of this DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
index 175f8b1e3b2ded15fc3265ac8c26b14473b618f6..fd841adc7791042f9cc6e3fdb76d250c7cbb6a0a 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi
@@ -878,7 +878,7 @@ wifi@0 {
 		compatible = "pci17cb,1101";
 		reg = <0x10000 0x0 0x0 0x0 0x0>;
 
-		qcom,ath11k-calibration-variant = "QC_SA8775P_Ride";
+		qcom,calibration-variant = "QC_SA8775P_Ride";
 
 		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
 		vddaon-supply = <&vreg_pmu_aon_0p59>;

-- 
2.43.0


