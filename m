Return-Path: <linux-kernel+bounces-175733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8CA8C242F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F801F259C0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A79172798;
	Fri, 10 May 2024 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dxDodSw7"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907E1171E41
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342388; cv=none; b=ndhOIasKj8hPxqSSBRQxZOccctqzpqw5e0aLgDZPfzp5TsTbj46eafS5clZwZIRyton8vB5WiEPm53xanfr5pqlnwCJ248uPoJvXfwR2O/U6xYtnjqiaVqiUcaS9oBTSCZZjCrMkRXQPyCn++klSCxM4t/q42/uJIDmofpyBqAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342388; c=relaxed/simple;
	bh=0JBicso3SWIZ4mAFQpIvwNHhSZpkk4EO9ADInwiGK+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dY1pyHKT+NqF80/xh36H8x6NJYzY9IeWfrJYnGtu9l6l0qgXi8EqtfD2gFj/H8lsR8keA2qTh9ZTgO9R3WWCrxXq2rX1CprrL3EYp0Ibzqxv38q+oD1tAtJVeUxLsLszk57QKWyw9sVicNRgkKs5Wm4uF3AiS5nGCwBUs+nQdTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dxDodSw7; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5a157a1cd1so479317166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 04:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715342385; x=1715947185; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xus5xrFsxqYjPmZuFNjHFFx4ZVK0BGErQ8h6vfpBHIE=;
        b=dxDodSw7ieufgc3s6gzKTYb3Qzxk4D7BiZqGB/94+xU13ifRNT7xtpCT82srbCzg2p
         +abiyjn6oh4/N3Xgdto5wQ0IAPtpQlL1NlBor5ZIozBVIUV1s9yssiB4xn06cAzj4IhP
         LX97PQ9LqyFhrh6SGPpsZr24dZ9eW0mQpdBPdMKWhxzRseL701awrPeP00BLSKVs5fA1
         h71ny6So1NLb6xu/ad8wHIfv938BBs2c6GSOR0PioxBJ5NIve3Lq78jqzBdiWttjAeZv
         aJmbx3JNaDhswzoxGwwIw+5KzlalTnfBb67rNpsUYK9qJ6SeeUOCiqO4JO/3bhMZgGie
         2+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715342385; x=1715947185;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xus5xrFsxqYjPmZuFNjHFFx4ZVK0BGErQ8h6vfpBHIE=;
        b=aYyDFA71p/WTQMbq65ZNi4lTptAfwKkDxdP61woDRpZaeU6sYBZcaJwXYHhG6RcyZB
         +qAlsRk7xh7keV56jrxLGaBMPSb8bjP0h7x5YY/W7zU4XdpHlkiDHDbBosIE+8KAsGlZ
         09bs/wWvjPbvEy0zjmR+Faz8mssGvLQmw5erxPZQPX4bEWcUkDmL2BtjSTj9dHYf6ixy
         UXxS8mvD2DSKZ/0OxqvpKo1d+8of8P6MbPOP8fMUTJsf0+h9pa28vfM2+W1sVxl2sY0T
         uwFXGgK8IQxbXDAfXaxjw3DYTjo/e5Kc/3qeKY3jmBLGc8dwx+JZsKlBiKD/BTkRsAvA
         23gg==
X-Forwarded-Encrypted: i=1; AJvYcCUhdZC4D2X0V605Wo50rpMc7DUzmzZ1gcHfXBTAestGTh530JC4kdoNuKYPkXUONPz17CY7BSclQiaHC/LM29ygqCxa3clmzgh0R0jH
X-Gm-Message-State: AOJu0YyryoUZ70fqrVanMuL7f41gsIScTmyYElqoa2CbkEuSxF11CsGv
	yxkkvQxvhkMkQyZoUFkaYnp0CAuwjpQv89qMWzm8smC73obkvYCT9gRWnMZOelU=
X-Google-Smtp-Source: AGHT+IEqlFdMYWLnlOJXoHWqJJbOTHT2BEU7f2VZzQLd0tRT3jWiFHn7fR+Zj/oiVSUO7mnpm8vJ0A==
X-Received: by 2002:a17:906:f6da:b0:a59:a97b:5aff with SMTP id a640c23a62f3a-a5a2d680c8fmr161864366b.73.1715342385122;
        Fri, 10 May 2024 04:59:45 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7df7sm176795666b.111.2024.05.10.04.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:59:44 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 13:59:31 +0200
Subject: [PATCH v2 08/31] arm64: dts: qcom: msm8996-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-msm-polling-cleanup-v2-8-436ca4218da2@linaro.org>
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
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 14 --------------
 arch/arm64/boot/dts/qcom/pm8994.dtsi  |  1 -
 2 files changed, 15 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 8d2cb6f41095..4be294f9bc40 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3654,7 +3654,6 @@ sound: sound {
 	thermal-zones {
 		cpu0-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 3>;
 
@@ -3675,7 +3674,6 @@ cpu0_crit: cpu-crit {
 
 		cpu1-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 5>;
 
@@ -3696,7 +3694,6 @@ cpu1_crit: cpu-crit {
 
 		cpu2-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 8>;
 
@@ -3717,7 +3714,6 @@ cpu2_crit: cpu-crit {
 
 		cpu3-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 10>;
 
@@ -3738,7 +3734,6 @@ cpu3_crit: cpu-crit {
 
 		gpu-top-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 6>;
 
@@ -3760,7 +3755,6 @@ map0 {
 
 		gpu-bottom-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 7>;
 
@@ -3782,7 +3776,6 @@ map0 {
 
 		m4m-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 1>;
 
@@ -3797,7 +3790,6 @@ m4m_alert0: trip-point0 {
 
 		l3-or-venus-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 2>;
 
@@ -3812,7 +3804,6 @@ l3_or_venus_alert0: trip-point0 {
 
 		cluster0-l2-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 7>;
 
@@ -3827,7 +3818,6 @@ cluster0_l2_alert0: trip-point0 {
 
 		cluster1-l2-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 12>;
 
@@ -3842,7 +3832,6 @@ cluster1_l2_alert0: trip-point0 {
 
 		camera-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 1>;
 
@@ -3857,7 +3846,6 @@ camera_alert0: trip-point0 {
 
 		q6-dsp-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 2>;
 
@@ -3872,7 +3860,6 @@ q6_dsp_alert0: trip-point0 {
 
 		mem-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 3>;
 
@@ -3887,7 +3874,6 @@ mem_alert0: trip-point0 {
 
 		modemtx-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 4>;
 
diff --git a/arch/arm64/boot/dts/qcom/pm8994.dtsi b/arch/arm64/boot/dts/qcom/pm8994.dtsi
index d44a95caf04a..353e4a6bd088 100644
--- a/arch/arm64/boot/dts/qcom/pm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8994.dtsi
@@ -8,7 +8,6 @@ / {
 	thermal-zones {
 		pm8994-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&pm8994_temp>;
 

-- 
2.40.1


