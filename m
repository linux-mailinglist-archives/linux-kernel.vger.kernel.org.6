Return-Path: <linux-kernel+bounces-175798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A808C252D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3444A1C2233F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3728712C48B;
	Fri, 10 May 2024 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BmHre4/r"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D2E128386
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715345921; cv=none; b=HjPPS+diyBY4OGP+ss+DH5f062IO1VK1Hgg4ACPFzZEAiv436pjpyHvZ/11hInby/WCmpwBlnMZ/M/0GRzMmavf39hUJGQ29CCcgY+7k7Sg3026UxOSPLnJkPPsUlSnfuK/tXcAAx+U/iTkxETs/1apAlbbN+5ziSPVliB/3mus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715345921; c=relaxed/simple;
	bh=U1sZM6crvXzNr36TY4xzkTtToIbdblQozjw2mMpBGo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WWkyTZKOw8oXAkwQsW9a86YDQfGb5GT3zhTykZrZ/aB+RJK1MlaB7otMGBcTMNpDB/FwZ7ZDLWq0HPTvkIabX0kXgQZs9dT3pq79r5rk2PG7uY6j6rSJmhsSArQ84jjJlVTnJrAM4udNq17Mp6w5xf3Y2XIUvnvvZRqerbKnOJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BmHre4/r; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59a17fcc6bso483007666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715345918; x=1715950718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UviVANTDt/5uiKFqzI1mLhTEEii7CuMYYu8FBGQXpBM=;
        b=BmHre4/rsGV/BTj4++sBLtAHnj/KrXw2W3dk2k7Mm/KRWb9lJjgmCwcAbCWLIUy30G
         kdZovKYJCcYtiQnxEmMJGiHQXVDQVBYZZMJY0942YAJdxXnEHEinjrAAgwttt3SFgPD4
         yXGhBx65lJ7p8ZlGkbEfGPVO62JXbm5v4xXZG+fKRpL3frA9qVeepcWhp0QhvNnhzx/j
         13WgDseb+v+TV4GjUGJxWR5jZqPIGhtib4rqqlW6Op7zaWSlUjMT1ap5AQ6JKNVAoOuK
         bKzgTszggMcMajFaEVLMyYmRPA3MXhTzOFD2wYfSodSbu5Q+tTSqY0kk30+mnxigyM96
         Ykpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715345918; x=1715950718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UviVANTDt/5uiKFqzI1mLhTEEii7CuMYYu8FBGQXpBM=;
        b=t3/SgCgp2Wz2zc/qfnsfB12UdGXmVJgwbZHot6x8m5xCDfVoSoFnT9uyJnxiX+Ns1m
         AHcweVoDxt1fg1mzYZJOi8pE4j7NOX9zxCUQJ0IkSwS+qjyY/S3zQjKjuL9pxzE6WUKb
         8O1qRpLJE/xJnIUb9302qz9pANBjhcNSX+IMsZN+NL+qzM+LperuCJ9NkbKHpbVmrUKa
         fe8sadiFZn5cMn4JuZ0Oy/YzCaxbs15cBhDXw3b+sHCMrSUn1wlh3ujhkzWWzdHRYgW6
         dX8j0L15Zgik8s12b2wB8J2e+NJuOxy+k6N+Jfb59kGXV5us2jDMfAsgPJjAfEZYRzpO
         G1WA==
X-Forwarded-Encrypted: i=1; AJvYcCWU2jg5K3aCHLwlFADknj9ZgzyilyISPNF+OK69OhNMBIAMjOb8dtLnKPcvr9sS40avOl07+Oeo8YjDJMGFE1wEbMs6Op9ZkzFKCqiP
X-Gm-Message-State: AOJu0YyEl9DPec0Przj2nokJOK6faJzzoHHocIA3MtGCO5VlrpK8mabI
	5mGbjpbODqVmbI8ieZNbznQVXd+Gce+3MeVLjGydemSg2+n1NiFiPF2MjOjK9OJUt+F6FC3VlAz
	dRz0=
X-Google-Smtp-Source: AGHT+IFftFdwrJV56gfgsr34xjkjx+Jjl7MXGjKOYrjcpGmW0lfjcSGDIRBYjrCWQu4RRSyGcWCE6Q==
X-Received: by 2002:a17:906:194a:b0:a59:9b75:b90 with SMTP id a640c23a62f3a-a5a2d53ad53mr177181566b.2.1715345918269;
        Fri, 10 May 2024 05:58:38 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d6bfsm181857366b.31.2024.05.10.05.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 05:58:37 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 14:58:31 +0200
Subject: [PATCH 02/12] arm64: dts: qcom: sc8280xp: Throttle the GPU when
 overheating
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-gpus_are_cool_now-v1-2-ababc269a438@linaro.org>
References: <20240510-topic-gpus_are_cool_now-v1-0-ababc269a438@linaro.org>
In-Reply-To: <20240510-topic-gpus_are_cool_now-v1-0-ababc269a438@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14-dev

Add an 85C passive trip point with 1C of hysteresis to ensure the
thermal framework takes sufficient action to prevent reaching junction
temperature. Also, add passive polling to ensure more than one
temperature change event is recorded.

Fixes: 014bbc990e27 ("arm64: dts: qcom: sc8280xp: Introduce additional tsens instances")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index f63951186a5b..65c444cce00c 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -5956,10 +5956,25 @@ cpu-crit {
 		};
 
 		gpu-thermal {
+			polling-delay-passive = <250>;
+
 			thermal-sensors = <&tsens2 2>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpu_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				gpu-crit {
+				gpu_alert0: trip-point0 {
+					temperature = <85000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				trip-point1 {
 					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";

-- 
2.40.1


