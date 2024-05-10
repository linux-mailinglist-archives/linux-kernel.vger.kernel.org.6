Return-Path: <linux-kernel+bounces-175745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D89338C2458
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B490280F63
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895E016FF3B;
	Fri, 10 May 2024 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T7oczhUM"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2596417B4FD
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342404; cv=none; b=CEZ9wIF3fto5YqGY/QSeTFVDgF02yhvWYXNGOJwlYWdjBccMdTY6Gwktgv00HHWPnyZ1OTS54HtGWwQNqThKb7Zp8pqSTD5P7ZO6ikBxa0PCOttm7OENbN108j1gXCRB0lveS5bS80fucDYeISPtFvZ2MvSVxV4LTbnzHs3MVoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342404; c=relaxed/simple;
	bh=STPjHaGKG8lMRQ7RNSghGTuvtkvIPGnzrhwmSxlHAgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AhDUzr538T+bpFGxj0uH8rkWr2vJHStJcmUpHZ0Xfn9K74eJ61b6c7EAFd7mDuHIbchtnCEsKxIEx7yTH+jj7vLdOuo1eNHTd+ZBnDm7SMH5yNTEzk6QKxLOflUKQAokiwVF8KnfvOuEU8MabgLuIlFGIcRuuuoxHGCrtSNTu/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T7oczhUM; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a599a298990so472134466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715342401; x=1715947201; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+I21DnvNty/zyDSyKxzKxRbFMMorSs7YKV/gyvrszY=;
        b=T7oczhUM3vUySFP41tuKFSCA0ugDBeFflUlPeQYOzq7TdzaWtOvVil7HsnJ5W720cF
         h5Gw8+LOOniAdXSdS6nTKHW2q52a3DqnV7KiKbv5ca/ETEdFPcyGbFdKdR6JTEd59JNO
         afX0w+M05FGmF/uoAvExt6+I9C2q01JgzfLJFmQm9Y+C+KM7A+E+kyTOFx9RwAHBjGBE
         z2zgXV5viGDlFDuqwyTwCQBt5k3j/SFPv+2iRmJJ8wVtoZOXgsnYChAvjZeUtblDrs+S
         seL8U+DaAE05NT2J8Hd8HL1u7xHY2cJ1OFuLG3Ut1PIVs/4Y6P3/jqu1DWcSm25mkv2l
         up+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715342401; x=1715947201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+I21DnvNty/zyDSyKxzKxRbFMMorSs7YKV/gyvrszY=;
        b=D8poNwdY2wUXbQyDT8fRugRTx5bV6G1V+C/ublYfRRGtgKFRl2+itsZ+Qx08uZxwRX
         /l9hCiOcqZVCB5DfjD81JAwIr23u9Wru+UZ5SdZiE403gJYb7ORZTlHc80cZiHtmHFqq
         ML/UtHxmiHLA6Z8pBTP94CP6FEciTyDPRMlP+IhAkw3zl4qwY/6zzxL+FAQWzSBteUSr
         gm/Sy+yuzfe83mpc0lWHbUF88bj09piKka6Bm8WhVrUPVNP/XVE6bF+rheJhZPLkfiQJ
         3/YTO7mfJcBMyMYgVZbvw7GgSo2K67ZJXGV0cA3qR6Upp0i9ORn4MpUfcSgE734vyJXj
         lfew==
X-Forwarded-Encrypted: i=1; AJvYcCV9J8+PPat9ndRvQv97uutCuGqJmvhv/loLk6poNBN6b6ImR7zQf62RPdKHkntEUhQL3dB+a6mDZ3oqkep2aYaNTgLVUBRU8sU4iLps
X-Gm-Message-State: AOJu0YyX3uSwN/9xJ9+y6QTTgflXotOZ37hHbiqdZmTOKybYlvaLu40F
	71Yfm+kICxchZcZYuwmDlduX+SXCThN05f3Bl1+XrozfuiuvYJ+P0DZh/nipWSE=
X-Google-Smtp-Source: AGHT+IEhxpmHNBgjuYBwmH9bYRqf7jbpbpCMbHjTfWRWqL6htpjUAYOsOUQ0VRtYwYsYFsbFbhX+CA==
X-Received: by 2002:a17:906:7c91:b0:a59:ad47:756f with SMTP id a640c23a62f3a-a5a2d6756e3mr167352166b.74.1715342401721;
        Fri, 10 May 2024 05:00:01 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7df7sm176795666b.111.2024.05.10.05.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 05:00:01 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 13:59:43 +0200
Subject: [PATCH v2 20/31] arm64: dts: qcom: sdm660-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-msm-polling-cleanup-v2-20-436ca4218da2@linaro.org>
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
 arch/arm64/boot/dts/qcom/pm660.dtsi  | 1 -
 arch/arm64/boot/dts/qcom/pm660l.dtsi | 1 -
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 9 ---------
 3 files changed, 11 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm660.dtsi b/arch/arm64/boot/dts/qcom/pm660.dtsi
index 98dc04962fe3..23741ab34b04 100644
--- a/arch/arm64/boot/dts/qcom/pm660.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660.dtsi
@@ -13,7 +13,6 @@ / {
 	thermal-zones {
 		pm660-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&pm660_temp>;
 
diff --git a/arch/arm64/boot/dts/qcom/pm660l.dtsi b/arch/arm64/boot/dts/qcom/pm660l.dtsi
index 6fdbf507c262..0094e0ef058b 100644
--- a/arch/arm64/boot/dts/qcom/pm660l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660l.dtsi
@@ -13,7 +13,6 @@ / {
 	thermal-zones {
 		pm660l-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&pm660l_temp>;
 
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index f5921b80ef94..7702d42e82c1 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -2422,7 +2422,6 @@ sound: sound {
 	thermal-zones {
 		aoss-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 0>;
 
@@ -2437,7 +2436,6 @@ aoss_alert0: trip-point0 {
 
 		cpuss0-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 1>;
 
@@ -2452,7 +2450,6 @@ cpuss0_alert0: trip-point0 {
 
 		cpuss1-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 2>;
 
@@ -2467,7 +2464,6 @@ cpuss1_alert0: trip-point0 {
 
 		cpu0-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 3>;
 
@@ -2488,7 +2484,6 @@ cpu0_crit: cpu-crit {
 
 		cpu1-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 4>;
 
@@ -2509,7 +2504,6 @@ cpu1_crit: cpu-crit {
 
 		cpu2-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 5>;
 
@@ -2530,7 +2524,6 @@ cpu2_crit: cpu-crit {
 
 		cpu3-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 6>;
 
@@ -2557,7 +2550,6 @@ cpu3_crit: cpu-crit {
 
 		pwr-cluster-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 7>;
 
@@ -2578,7 +2570,6 @@ pwr_cluster_crit: cpu-crit {
 
 		gpu-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 8>;
 

-- 
2.40.1


