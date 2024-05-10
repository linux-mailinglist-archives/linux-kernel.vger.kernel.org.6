Return-Path: <linux-kernel+bounces-175730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB748C2427
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9FA1C20CE6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F4717109A;
	Fri, 10 May 2024 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CiROlHh8"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6032817088E
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342383; cv=none; b=ClsWj/acx4FlsO/yG7sQcpM17vk/zoP3K7wZDfaRvBFQKfqyR3hk4dIVNoT6yAQho6kLa94B2pEyR0aY9XNyllkMjr9xnpwlyE7ShvcwmKYftSa9MX0A0Yv57HP/AOsEjZasN9Ul13Uu0RGtiJRcqSkASGD4clRcvT6hQ9CfO6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342383; c=relaxed/simple;
	bh=mB8GgOOV7Biwjyidpy4/BPgdtAv/kn+KG8YTxBcyRsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G2dN7gDXh5A1o8ldmb/TPwb3eqbTnTAqJxgQnOtjqcPTblb2b/CjLJgwjQU1ad0XTyPiSm+7nKOztHH2Elel2qOmJzmWR4HsDqUgkmCAFzVPxjZ4Wn9byr/1YkDvactPCTEZiG6L6Ak0RoV1K+OAsIe2HiKp5BxrezjCEpqQCUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CiROlHh8; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59c448b44aso500913566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 04:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715342381; x=1715947181; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8OG+JNgGzK/aqpupcVQEj46I3a/vANHttWVBqlAf0ww=;
        b=CiROlHh8jwBgCocA+ot740tZj4M4XEmN+jGoAupVo1B5W/teSH8zvgE0y/s27vqMQf
         MZSG/zJfoXQjiM1kKpx4xNbbfIg/gLWpUpQzAL+DmoxNrux4q6wdfAlJXnzUHKroe2Hv
         lQv1o4bpmXlOGS6Z2T3vCf6x9BqwqfPHbd8wttNHu64IVrOHqNzUT3IcBrPR/dvENP0R
         HMRmvVBIG9GZqCm/vIpRz2+GlHP6Kl6Vo/gHdBnnRNIHC8VDRnw+qzvdmK99rTW7O+4B
         4cgKMPUiFn1DBae+UNiUhcHj1TpORg+9IPO1INCHqI8F1OE7BeG6IVFuivQolQnrbJtB
         QDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715342381; x=1715947181;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OG+JNgGzK/aqpupcVQEj46I3a/vANHttWVBqlAf0ww=;
        b=dKjdlGl22IRRwaHUOMx4JZqrunC2k8A4N3LER+lwoG2G0+v7BSEpYyayQkrxcd0UOB
         l2D1djln/OiiVO4hIs0RyjfCP0LTMmC7SxC6nytnHNgujWOM8uu1TCDXokNktydeYXb2
         52XLNfQCvIOar6YxD0OCSFmn84pyjD9J3yn/Ip74z2CQ4i5CEF2dFJb6W9JPs+TeebjK
         Z+0FNc80bjeZG0y7CawCtc6W684wYI8mZIjZoPpsKvWRNu4vHGvORhcEKH0Fbb+YMRs9
         84EzB9PVpkYxp5e1/5ZunZWPEU7lOHJcsHY7LFnhcy4jeQce+W1cvnjbHyJg1oOKiuAx
         +K3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3n2swfXB2XECJUHrAmnSoP5flbDJL0XlJ7C2XpVWWhNYCSs1No4AJJvdIxyZnPL9ovZZBXfUoNtKelOgOBPxP87M0PajXRUxM2LkP
X-Gm-Message-State: AOJu0YxhfOWSng1m6zqtUUKsDkFzwjk42u7UMPX659/bPdc4RIoYdJ0h
	FTZQ6bTkFAvzBE8awFTTxq6t2sq5sr/xT6fmEwMo7ncrnfCNpzUvOc9UOzO6+Fk=
X-Google-Smtp-Source: AGHT+IGikFhSPQpUN0aelTz1pV11rD++e8fWx3itBhzAdPXY9gwx0GU92QGUHaJTIDtXVdL4rVm/+g==
X-Received: by 2002:a17:907:7893:b0:a59:bf43:4e43 with SMTP id a640c23a62f3a-a5a2d58a672mr143187366b.31.1715342380910;
        Fri, 10 May 2024 04:59:40 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7df7sm176795666b.111.2024.05.10.04.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:59:40 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 13:59:28 +0200
Subject: [PATCH v2 05/31] arm64: dts: qcom: msm8939-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-msm-polling-cleanup-v2-5-436ca4218da2@linaro.org>
References: <20240510-topic-msm-polling-cleanup-v2-0-436ca4218da2@linaro.org>
In-Reply-To: <20240510-topic-msm-polling-cleanup-v2-0-436ca4218da2@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14-dev

All of the thermal zone suppliers are interrupt-driven, remove the
bogus and unnecessary polling that only wastes CPU time.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8939.dtsi | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index dd45975682b2..24f3bd197095 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -2299,7 +2299,6 @@ apcs2: mailbox@b1d1000 {
 	thermal_zones: thermal-zones {
 		cpu0-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 5>;
 
@@ -2330,7 +2329,6 @@ map0 {
 
 		cpu1-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 6>;
 
@@ -2361,7 +2359,6 @@ map0 {
 
 		cpu2-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 7>;
 
@@ -2392,7 +2389,6 @@ map0 {
 
 		cpu3-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 8>;
 
@@ -2423,7 +2419,6 @@ map0 {
 
 		cpu4567-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 9>;
 
@@ -2454,7 +2449,6 @@ map0 {
 
 		gpu-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 3>;
 
@@ -2482,7 +2476,6 @@ gpu_crit: gpu-crit {
 
 		modem1-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 0>;
 
@@ -2497,7 +2490,6 @@ modem1_alert0: trip-point0 {
 
 		modem2-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 2>;
 
@@ -2512,7 +2504,6 @@ modem2_alert0: trip-point0 {
 
 		camera-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 1>;
 

-- 
2.40.1


