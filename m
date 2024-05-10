Return-Path: <linux-kernel+bounces-175800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 687498C2536
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06133B238CD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2D712E1F5;
	Fri, 10 May 2024 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OGBywj3E"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA05212C538
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715345924; cv=none; b=XqtVcJpYU2YAtGDf5Mn4GCKYWfGfbxCFNkOzeayy+KbnLC2EPgt9cwP6FTTcR87YM4DEmqIMdf7B6ykYZqRS9ouEvpNV7btCcuY4N+mvwXJtj6E6QnNUPxY8j/FOQxkMRyXlYAg4bCK4bm7xR6H+yvCGJkT0qNXn8wqznbtI55k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715345924; c=relaxed/simple;
	bh=EFzj6Tk43N52U4aEkFUoO8lDb10sw/xNa2mWF4RskUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BGvseTPvVsn6An52V4eFqCBVucpStE+6EIeS2tY2A4qxAVTW04SZppIihXk6wAjmFfvcafVAfSOqIUgzYByDbflvFzOJwKdSIVaOWI5n9QGfb+VOpeF4DZODkciLM6EwB6AIhqBvB3lUldJKaqf/GP8F+qSn6OumJOmAFeleWow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OGBywj3E; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59a64db066so516674766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715345921; x=1715950721; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8IcYMn2rhQRDvyV2qRDEDnniamQy74klUO7ny02ivo=;
        b=OGBywj3E8P75pvoytHTaTwcv4YNZ8EGUuPM0p6K9AvZrCP+XcEoKtzvOJQANRlAHFv
         1kXlO0FGb4pFn6QzSYKPMtBMDy/P9X2o97uwz8x3cXPcophLbe1nPeesWPTDO9+zQoL0
         CyTENni/yk9UrQQ6Tv8mveDhhQiFx/jMPCGscTYLzrns05NbF1iv3TcaEHBCRRxfRxbI
         CvSV2E1Nie5fBKaEDjPzXNKf3+gPdBInqZlt3h9kQ/sb/ttXazfMKn21KDm5Yq0qAQi+
         ZbEANfgCDPlTejUTiZ0If5ducVhxjKSbFT9sqsX6/007s/SRt45bwRdGRjiuC1H5NZCN
         ARSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715345921; x=1715950721;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8IcYMn2rhQRDvyV2qRDEDnniamQy74klUO7ny02ivo=;
        b=uLKMgb6k3NgDVoyncV18TPbCKXBE9vP/rOD5+kFJBFtd/I47WvUh8u0RiT7HHcsaiT
         4/ZMDgC3pIovHsQGNFwEMT325r7hObVbRpsTCQMh0vWvz5P5Ql9YXin6qml+DiON09dM
         t4TQmklXy8vSBNvisKj7KXvttlWv+3zXxKEN0UWPb3Xl54MZcM7oSVTdD0AEgokoaTnk
         CWVqacs3tvLIgHZf8gg12XmbzonUbvaMzncCHOS4WZk8NWDVLizpPoQ+QMseJUQBgGwb
         uJ2CwxMGYHOGy/llYyfOerQDqQhQ0+aHN8+1twFPMJpF1d0xLT4FRiM95QmDEBc4atr2
         FZ3g==
X-Forwarded-Encrypted: i=1; AJvYcCUoN4g8MPEk4xTn0tyH+14YYUryGjosZq2BQANOcyWBoP0suqR7LkdwzVgt7rGLdy1+PB5uEZdcIwIcMi4Yg+Kb5HpPb1Af7domXKRx
X-Gm-Message-State: AOJu0Yz/U75mj/f1kiA7ChCc3TOKZQO2qjA34F1hgnkDxMl7cvaRc+qe
	0QiaccBdB6WGTd+oVA8LatjcV6yItbCwOna2Y+ZMV935QrCBTohuNAPYVOBHcGE=
X-Google-Smtp-Source: AGHT+IGbaZNwZ9rvGa7Fk+utzQGGqR12rPtV/31n/eaZ6Cr3MEIihnlCx86RwFxBR9LOXfahie7Oew==
X-Received: by 2002:a17:906:6415:b0:a59:adf8:a6d5 with SMTP id a640c23a62f3a-a5a2d6786fbmr169034066b.72.1715345921227;
        Fri, 10 May 2024 05:58:41 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d6bfsm181857366b.31.2024.05.10.05.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 05:58:40 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 14:58:33 +0200
Subject: [PATCH 04/12] arm64: dts: qcom: sdm845: Throttle the GPU when
 overheating
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-gpus_are_cool_now-v1-4-ababc269a438@linaro.org>
References: <20240510-topic-gpus_are_cool_now-v1-0-ababc269a438@linaro.org>
In-Reply-To: <20240510-topic-gpus_are_cool_now-v1-0-ababc269a438@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14-dev

Add an 85C passive trip point to ensure the thermal framework takes
sufficient action to prevent reaching junction temperature and a
110C critical point to help avoid hw damage.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 57507d6ec918..52eda2bb6b09 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -5630,10 +5630,22 @@ map0 {
 
 			trips {
 				gpu_top_alert0: trip-point0 {
+					temperature = <85000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				trip-point1 {
 					temperature = <90000>;
-					hysteresis = <2000>;
+					hysteresis = <1000>;
 					type = "hot";
 				};
+
+				trip-point2 {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
 			};
 		};
 
@@ -5651,10 +5663,22 @@ map0 {
 
 			trips {
 				gpu_bottom_alert0: trip-point0 {
+					temperature = <85000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				trip-point1 {
 					temperature = <90000>;
-					hysteresis = <2000>;
+					hysteresis = <1000>;
 					type = "hot";
 				};
+
+				trip-point2 {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
 			};
 		};
 

-- 
2.40.1


