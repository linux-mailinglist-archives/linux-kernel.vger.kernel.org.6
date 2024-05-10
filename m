Return-Path: <linux-kernel+bounces-175728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E708C2421
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 166AD289E12
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8B8170885;
	Fri, 10 May 2024 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="alDbKK/E"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AB416F829
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342381; cv=none; b=GEs5BG+L4OgVdQe9omEpQ1qk5rw2Ntg07O1gwM5MQfT285Vdk2yKOA78Wn7syNAhaNFlKflBGtdtTamtph9WfwEyYPd5Y34gDsqUT7UBAdgNeZW/sMft5AcnlNCEg95pHh+bhgofvXH/a3GVX5kTnp3gYE0nFhL+AKc8RmbF07I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342381; c=relaxed/simple;
	bh=AI/6GDzleNINtkezjfAEmbDXxNIt1iLgs6smOMt1BtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EzoN79CIga0XGonfgGZvSUWrhuUIVuxH5RRua/2+Dp6w0xYOIWmf+6vsVCgORYmNIvMxoCMiOJnsGHOtBWI686M97QMd+IQlXZQTFFUHEdxOlZK1OvNq9i3W7OAUOiKrvyqYbyqv3v6C2bTK/8gFLjRtBuveifdwQBkdSGgmWww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=alDbKK/E; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59a5f81af4so475893366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 04:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715342378; x=1715947178; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cK/DjygM8+bO8NZk8MSB3Ko2HzSfu+tnWhQWu8DehZc=;
        b=alDbKK/EUYVoCq/CnK2KBUM42uE0P/T6Bq3dZQ2kj+qaqVjDh4dJ1w13QbCoIAnXId
         UA/Q+T2ZfPsj7Orq5Kn0B6loFW9VDJmlESOwFkPqcaJ5shjnIEm2NBAguK2CioCd2mlC
         EcTsz1E8L7KqbPd2UTLlccBeO3VMO5tSxTTLG4XaQSKvJw6aakjCWeze8vCFEaW0Pi19
         ZgQXlt7OI9IopEv0h3LjRCVB4SfVKL2+H3g26BP6ZSnoFpofXt/2WiYRt8HYBznDnolo
         DsK2Lb51Ib2XlWwadpGmQXeouDwTgF7FvuGmkX5SnO2o2h8Kums3tusz4XHoj3UPmhGQ
         mKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715342378; x=1715947178;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cK/DjygM8+bO8NZk8MSB3Ko2HzSfu+tnWhQWu8DehZc=;
        b=bmag3zLqKykFRDeb9ZJ8nmzJNmimX46bABVL/Bzgn1M273gF2UVrg+6jZ4bXic3BIV
         6akswrl9RKiql0bh50BqFqsZcU2Q0gx0Nokukwksvvmfg9y4VL2HLYX40houLOssx3t6
         IWWcrOpoJdT7FQuN26H7w445h1I9J+uigOr/xkNjzpgYg2Fnq9CRN34fSnMJ8hUhsX+h
         TkPAK8IT0XRETPSe5LegJH1J25tiQiv8fgAEX2xHtmOoj4+G1e3ZfdMs7UKd9fN5+G54
         koAKj88vPZgv+ljUMo2i1qIOn+kXmcPapsRKyVjKIBGEMnSQfgELEgcWrjBZOSe4UI3R
         Aesg==
X-Forwarded-Encrypted: i=1; AJvYcCV2OYUVKBsyp/RaLDEUBTU+m00qPwWeBKTCYdDyVYBcOnhvw+aek0SGTswcq9AP1rhihLrCwy0irJVWmJ3NXXE9tWgEcQ73OTX6n/HJ
X-Gm-Message-State: AOJu0YwUDCRgsuPGOtwkxnfOFkivrd8dFoW+SAg8dzZcv99gcYafvFtd
	WhwhniiXBZXBeT+oFOZd0zx9vtFL02brWWvAYFVqPsGOAI5wLUrnPT9uWvN6axk=
X-Google-Smtp-Source: AGHT+IFPWY5L99y0/3UoXIdhBXt3bc2a2CoPm6/qZ8/9dr3nD5KxFPDCwXUpbTfxCKikH7sDj+0P8A==
X-Received: by 2002:a17:906:37d4:b0:a59:c28a:7eb6 with SMTP id a640c23a62f3a-a5a2d5c8bd8mr184495366b.24.1715342377923;
        Fri, 10 May 2024 04:59:37 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7df7sm176795666b.111.2024.05.10.04.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:59:37 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 13:59:26 +0200
Subject: [PATCH v2 03/31] arm64: dts: qcom: ipq9574-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-msm-polling-cleanup-v2-3-436ca4218da2@linaro.org>
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
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 7f2e5cbf3bbb..98c5623f4391 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -749,8 +749,6 @@ frame@b128000 {
 
 	thermal-zones {
 		nss-top-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 3>;
 
 			trips {
@@ -763,8 +761,6 @@ nss-top-critical {
 		};
 
 		ubi-0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 4>;
 
 			trips {
@@ -777,8 +773,6 @@ ubi_0-critical {
 		};
 
 		ubi-1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 5>;
 
 			trips {
@@ -791,8 +785,6 @@ ubi_1-critical {
 		};
 
 		ubi-2-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 6>;
 
 			trips {
@@ -805,8 +797,6 @@ ubi_2-critical {
 		};
 
 		ubi-3-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 7>;
 
 			trips {
@@ -819,8 +809,6 @@ ubi_3-critical {
 		};
 
 		cpuss0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 8>;
 
 			trips {
@@ -833,8 +821,6 @@ cpu-critical {
 		};
 
 		cpuss1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 9>;
 
 			trips {
@@ -847,8 +833,6 @@ cpu-critical {
 		};
 
 		cpu0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 10>;
 
 			trips {
@@ -877,8 +861,6 @@ map0 {
 		};
 
 		cpu1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 11>;
 
 			trips {
@@ -907,8 +889,6 @@ map0 {
 		};
 
 		cpu2-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 12>;
 
 			trips {
@@ -937,8 +917,6 @@ map0 {
 		};
 
 		cpu3-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 13>;
 
 			trips {
@@ -967,8 +945,6 @@ map0 {
 		};
 
 		wcss-phyb-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 14>;
 
 			trips {
@@ -981,8 +957,6 @@ wcss_phyb-critical {
 		};
 
 		top-glue-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens 15>;
 
 			trips {

-- 
2.40.1


