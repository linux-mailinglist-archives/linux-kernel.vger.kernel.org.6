Return-Path: <linux-kernel+bounces-175732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73318C242D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2FA28B06E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E07171E59;
	Fri, 10 May 2024 11:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U6V7UgHQ"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC206171646
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342386; cv=none; b=B45geNndUnBI/V+OIeFkgRgw3/RW70eeQyI/askhMPdxF2tlVWK4OYHAQWiJwxT4XGphvk7bFrqm4nKwd5obDEaJJko3MJvzAR2Sjhl5KAJIIui44Am/pE9m36xi98gM0bt8v8NfsjFAj39o4/UkcNnIcYEzCkSg57wCtW/Hvi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342386; c=relaxed/simple;
	bh=Lc/qZcb1UEvRNkKjlc0ptaH3IPwvEDwKSh3RJoXh43E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OuZeymT1yAYI+dYu6TKQHvRGRCqEBd93J1XVN5EvP8kC71uj/VKSKPAAZdhzpOzGkd7Gzgww1qdpPE9+NZXGULD2VGtmTIWznTEYTd0L6VNCIVw/D0KkaTh5Dp/0+APL1hUdt8yNouLpdjzDjaZGGZ80gH55b2VkohFIdvsoios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U6V7UgHQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4702457ccbso495382366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 04:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715342383; x=1715947183; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/2FFq24pdHCjY5SSKH0xO6GPwXsrqMdD9iEeVpRzJjI=;
        b=U6V7UgHQ+1VBuLjw5UP5rRKMI7kYo5a6bWjrw7l640+v1L48/ZGyMojkMnTCAWXnib
         0B9w8VRlneeunnRcF1vKOHpQ6n0aztM4dMbF02p3JED554e/UW5KD8/rUqgD31VG8jCT
         7WweJWkjj8thk5klgtM0hqphXzyIBMF7zsYK9zqfDLttblRuPwzPfsWnxtmuA2ijUzJB
         JN7YzhTR9jQHRg8awIx2Oeu0wX8N4KXP3KL7erAxXVe7yuEnpzyC3swQZqSMZR7VD7HN
         qpZ08kAjKtOSXT4kU2MQlcHlxYnrptM6Bjf7E75IZm4okW2VkFaCO1iWOHt+TXUTIoEr
         FixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715342383; x=1715947183;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2FFq24pdHCjY5SSKH0xO6GPwXsrqMdD9iEeVpRzJjI=;
        b=HfSTkMeSa8yHlUZywNjR5hTitiAoa5jg6Ac9VtV47qB5QqoCjNDztfkHHByMDDVdgU
         UEp7U7TXcaUFYlxVn2/bd8hzfV6SAZfVo/frINpgrnVjP2QDDX7Ti8d4OMK+pVm28c6y
         40RXQed3SoJc6/6aqrgULeY8J6brN/4iYwIeaN10oQydVjqTwbi7pbwQsuO2stspdy3R
         rL58XG13UKSLU7khpUBTMBkMVnoA8YHCPeYDIe6eN0ZMr0zO7C2Em1G7GLyM95MgtS8Q
         eV4k+V2FPwPz0A+avc8ECQRRKLSRZOoYHj71RVkxj/87Fsw1Y/kX1jmYklNCF3vler/N
         iafA==
X-Forwarded-Encrypted: i=1; AJvYcCW9RHYAML4jux6S8IgT1NwP/PYX9JI04FEaoFpmq936OPo4gAlphmC6vrkBKM6oiIGBXb8UozoXmcE1QmhlYhoGpbFSFg1ti41OXHav
X-Gm-Message-State: AOJu0YzynrFMNZdDGBKtfsjbrG9fZmn1fIg4dpGEsZuhhVTRwmT3TN6R
	EFrf+Y0O1RILZBis8Ynz6tLiC+pa7gSL0WFrhUZ+aVclu9gdydY868OR11VYCHI=
X-Google-Smtp-Source: AGHT+IG20lZScTzx7LRtP2dXQZ7+d/7vV2qeN+BFTt/Ra474UYjYw7vgv4MprgEqjfHOtW83zVQhGg==
X-Received: by 2002:a17:906:eb46:b0:a59:a85c:a5c6 with SMTP id a640c23a62f3a-a5a2d585996mr169003366b.22.1715342383341;
        Fri, 10 May 2024 04:59:43 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7df7sm176795666b.111.2024.05.10.04.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:59:43 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 13:59:30 +0200
Subject: [PATCH v2 07/31] arm64: dts: qcom: msm8976-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-msm-polling-cleanup-v2-7-436ca4218da2@linaro.org>
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
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index d2bb1ada361a..4e4620de7f3c 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -1124,7 +1124,6 @@ pil-reloc@94c {
 	thermal-zones {
 		aoss0-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 0>;
 
@@ -1139,7 +1138,6 @@ aoss0_alert0: trip-point0 {
 
 		modem-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 1>;
 			trips {
@@ -1153,7 +1151,6 @@ modem_alert0: trip-point0 {
 
 		qdsp-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 2>;
 			trips {
@@ -1167,7 +1164,6 @@ qdsp_alert0: trip-point0 {
 
 		cam-isp-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens 3>;
 			trips {
@@ -1181,7 +1177,7 @@ cam_isp_alert0: trip-point0 {
 
 		cpu4-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+
 			thermal-sensors = <&tsens 4>;
 
 			trips {
@@ -1205,7 +1201,7 @@ cpu4_crit: cpu-crit {
 
 		cpu5-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+
 			thermal-sensors = <&tsens 5>;
 
 			trips {
@@ -1229,7 +1225,7 @@ cpu5_crit: cpu-crit {
 
 		cpu6-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+
 			thermal-sensors = <&tsens 6>;
 
 			trips {
@@ -1253,7 +1249,7 @@ cpu6_crit: cpu-crit {
 
 		cpu7-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+
 			thermal-sensors = <&tsens 7>;
 
 			trips {
@@ -1277,7 +1273,7 @@ cpu7_crit: cpu-crit {
 
 		big-l2-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+
 			thermal-sensors = <&tsens 8>;
 
 			trips {
@@ -1301,7 +1297,7 @@ l2_crit: l2-crit {
 
 		cpu0-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+
 			thermal-sensors = <&tsens 9>;
 
 			trips {
@@ -1325,7 +1321,7 @@ cpu0_crit: cpu-crit {
 
 		gpu-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
+
 			thermal-sensors = <&tsens 10>;
 
 			trips {

-- 
2.40.1


