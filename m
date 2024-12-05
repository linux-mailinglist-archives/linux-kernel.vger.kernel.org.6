Return-Path: <linux-kernel+bounces-433494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7790F9E593D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381F518854EE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50859222587;
	Thu,  5 Dec 2024 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XPnDUiNU"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF9222147C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410890; cv=none; b=HI3ExQmuvaqQEMzBdJveAwc3spChuiAcG3/P7XfAP+ax/uAduL05FwBX7xRagNvtgI23d1JrgjKSb7wqnn37mIikAs270NEtdURPIgz0gH+9Q6/cOUuF1QlR3iUHaTB03LOUcf/Tkcfb/TTJgHgU2hL5Hc1y5b/EMu/dvkfxeCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410890; c=relaxed/simple;
	bh=IgxztTAMWyT29UYzJNKnw7bdbAV70geqeOh7ctUQCIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a5F7SYTf9rOwm/yug9tzeoxRyKIkDAe4QJm2k/7+YtNGaS0psUGQ+pCYg6krPrA6WUNBaTRssv6X/OCsMi2r/dbPkCE8E3etJ2mVJTkXSmjEznYoPVqhfRSdHWQmhgpbY+GqdkwHSSLozrfHU+qDW7ga5DgYqIsl3g4jdu0938Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XPnDUiNU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434ab938e37so7162415e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 07:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733410887; x=1734015687; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPWex3NjhW2vBY02766onHCegT7hgDE9dyhsg/tMa2g=;
        b=XPnDUiNUcFP3Cb5p1EoI2tajowtOurA/BvaRvtw6Pl7CQQk9RPpnMO+QylLBXeL1Xa
         aj45Ecy9EF37i0Z9rawuPdh5YKXNwUhiGbxJDgPpbmQjth3kaRvQDCx1gix6wJ4sOO14
         WaRdWD0XRLcLa/ApRbAxCrlnb8R8UpoAgTjpLBP65PMMWkgaoKhtNyIo8hDN3P0K9DHZ
         nXy2cjqW8mjo/zMaWFSzhS9HOXIFHKn/hd5OZTSSz4TSDIwZQb7FwJzzuPLB9wt99dpX
         TdddNUI714L37X42wmXAKJTfb94RKbyonL3cMbz1YnLfZudWYdhWrhofLj4y2zgKbRdq
         RBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733410887; x=1734015687;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPWex3NjhW2vBY02766onHCegT7hgDE9dyhsg/tMa2g=;
        b=f8yMLHwyZSqtdrYtU0P/utcRs3X59fCFGPMf6C8b5x4xWLjcmy1nOZhlLks+eP4grc
         BCumzHRK9o6Xwu8eyoTOaRsn570/AVKAK9cc8HC2Vlew400TEheejurUddqVZFqaxDda
         mJ4sBjt33SrK+JpT6l+uwxmKBXy3kJhV0ygzdthXyPYWphwZPBmb+fOUf7zrVswppCiY
         TIVnOiyvcxwIU2phDUY398zPuUj0rDHXvCKlV3QIY+OVUNWRZak7b7qZeGC9mB6pzwCJ
         aPT281UR6aJypObn2fcPMfjb3CaUElahuG7EL5P23YRBPLqhzFFQKQ+ZwF45GXU5luRz
         1H8w==
X-Forwarded-Encrypted: i=1; AJvYcCVkMxHaBqWjbg7+nOszG+vch7d6+jECUJ/8GecG8+mg7C0eKq1mDtnIg4gaOdfv5BAgCfNrKpWXIV1MbeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGFKeOFVVm1oDoUuiotM6wNyMUORpTAs+J2wfzEF1PJCCRc65m
	PPEBBJ6Q+53cZnS+QxOg7HxcFbBLEHomICwJyPxPteIn9OiUA/RrDqoYth2q8Eg=
X-Gm-Gg: ASbGncsHLED7C1VHq9Z8zaQh7sHgdbwd6ofoQvYrdBJNgm2yHAoYSuaqoDJi1QYx5AD
	LIsEHQoy7HnYNX1S0tmQXJ060LjmpjyGBD5kokQEAwNOws9DczWFnF9gp2D4Xdt54Vp6c9q7XMd
	UnkZvRIG8hfvHFhpfQD8C50RQADqi22vVw9HFtVTbudJgo3qOqy3ycyHx/zKQ+WRUAtMp/YxtBw
	RaP2T0ZLz9vxgYrQn5HJVKDHMd6cZ9Te3H8uqY/dB89CVs8slnGiN4AQXFzFlfWH9dAsQQ=
X-Google-Smtp-Source: AGHT+IGKNF8m6/P0t+uOND8u3TqccJB3NWyZR7DF6laJJjSGk7SxVgGuFUCe2VWQPy6USrZuONmIlA==
X-Received: by 2002:a05:600c:4ed0:b0:434:a929:42bb with SMTP id 5b1f17b1804b1-434d3fae263mr79611665e9.18.1733410884709;
        Thu, 05 Dec 2024 07:01:24 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52c0bc7sm62830795e9.35.2024.12.05.07.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:01:24 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 05 Dec 2024 16:01:11 +0100
Subject: [PATCH v4 7/7] arm64: qcom: dts: sm8650: add interconnect and
 opp-peak-kBps for GPU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-topic-sm8x50-gpu-bw-vote-v4-7-9650d15dd435@linaro.org>
References: <20241205-topic-sm8x50-gpu-bw-vote-v4-0-9650d15dd435@linaro.org>
In-Reply-To: <20241205-topic-sm8x50-gpu-bw-vote-v4-0-9650d15dd435@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2682;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=IgxztTAMWyT29UYzJNKnw7bdbAV70geqeOh7ctUQCIM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnUcA6jBwt5/lJeHAuMw2p6QcJ8KfjQQOOW4fyFl/Y
 WsBO3zGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ1HAOgAKCRB33NvayMhJ0e20EA
 CdtdyWN37WortzYjsbLjT6L16akMfEu8GAtTyJt4D8BSQ1G0yVf0YbZhZbO+cIksZi9QkgfPsR+9eh
 73pd5WF+1wx6Navr5WyAm9I6yO0Cc3M2iVEM/nb00z6p4o5rr+N04AxVyhOnJOTFdzM92wvC9LXySn
 BBDc18x3Ka+L08ygo/P8c2Yvh4Qurr8lM4OHbwarxYl3+ZqQNC/gyt66qvTy5rohJS7Wb24yKlbl3H
 Q+8gGmjsohJoT+5Ny3E+EhZkNSWrpL2+pKOHRKpJ37jmPLfR/OM6WsinrPcMWy1WXpz/4oZTEuyjEc
 mxlspjJITpZQ3bwevUkmSBG2kKzVtTaF6S/xhzKM52T37aaXeuN/yh0vi8h6THpVuvt9d2NUSLT09x
 xgB/R7HAAD+WBpsTpCj3bVacxYuTWT9JPh0GDTGdrNCnz5rLe6Qag20/ahOEeQ0wIiuXLSdcgkxmgQ
 xBQnPUBtULm+hS0Q7V+1UFBjHBJY/iKUdT+j1W0Ma5L5tRp8cltsVqp8IsJSVioA5KVQTBw/4DD1+z
 YK9wGfi3YcITvaWCzrlEIbL2ozgfSzYF14ukaytf/4LszqCyo9PJNQJqTlTCoiW8WIOpw1aM3N2kPH
 8Gr/0CneZdDb+EXtaKOZ6Ak0uIhyt54sP9j6tp+zFeCgRGGelx4hp7g2tV9Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Each GPU OPP requires a specific peak DDR bandwidth, let's add
those to each OPP and also the related interconnect path.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 25e47505adcb790d09f1d2726386438487255824..6ee7f362dedb73bcee6e8b2a7da6b71840de9001 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2636,6 +2636,10 @@ gpu: gpu@3d00000 {
 			qcom,gmu = <&gmu>;
 			#cooling-cells = <2>;
 
+			interconnects = <&gem_noc MASTER_GFX3D QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "gfx-mem";
+
 			status = "disabled";
 
 			zap-shader {
@@ -2649,56 +2653,67 @@ gpu_opp_table: opp-table {
 				opp-231000000 {
 					opp-hz = /bits/ 64 <231000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
+					opp-peak-kBps = <2136718>;
 				};
 
 				opp-310000000 {
 					opp-hz = /bits/ 64 <310000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+					opp-peak-kBps = <6074218>;
 				};
 
 				opp-366000000 {
 					opp-hz = /bits/ 64 <366000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0>;
+					opp-peak-kBps = <6074218>;
 				};
 
 				opp-422000000 {
 					opp-hz = /bits/ 64 <422000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					opp-peak-kBps = <8171875>;
 				};
 
 				opp-500000000 {
 					opp-hz = /bits/ 64 <500000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L1>;
+					opp-peak-kBps = <8171875>;
 				};
 
 				opp-578000000 {
 					opp-hz = /bits/ 64 <578000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					opp-peak-kBps = <12449218>;
 				};
 
 				opp-629000000 {
 					opp-hz = /bits/ 64 <629000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
+					opp-peak-kBps = <12449218>;
 				};
 
 				opp-680000000 {
 					opp-hz = /bits/ 64 <680000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-peak-kBps = <16500000>;
 				};
 
 				opp-720000000 {
 					opp-hz = /bits/ 64 <720000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
+					opp-peak-kBps = <16500000>;
 				};
 
 				opp-770000000 {
 					opp-hz = /bits/ 64 <770000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					opp-peak-kBps = <16500000>;
 				};
 
 				opp-834000000 {
 					opp-hz = /bits/ 64 <834000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					opp-peak-kBps = <16500000>;
 				};
 			};
 		};

-- 
2.34.1


