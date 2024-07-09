Return-Path: <linux-kernel+bounces-245666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 748A692B5C8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0D5284C7F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74D115957D;
	Tue,  9 Jul 2024 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MOpyRtCe"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77592158D72
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521962; cv=none; b=lNDQjKiuSqwNnICpKGX3sjtIV9XGxJdWARzpz8CtVs+N8hmIVaIWEfMR75tx3A19/lgdBx9MEfaUmWfBeS0W0/506Kakt6y+WEee7i9kkJPxr0y2fKuI8BF+yUojaB0z9wR7fbtiGbrlCcmK+otn9Gl00dvRtrgEt+zckRlKH3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521962; c=relaxed/simple;
	bh=Il2UvibnuII6pAMEt7ZcsOO48MoDeeFboVabC36fJtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PmtOK+hUhoypNl9qYt+Aix45LoYVbFmTt23FR6IxL8LAKZu3sK60toTYnbCATv3TKNHqFSHPVtzzdPsbB9v00tA+IhrMbfIXUbfn0UTaZaXxhuiWf4kfqpMbVYgc4Gr2KlA9a4nFq1YzSL/8jkp0Sdz3hkumuYvF1jSAHAIOdcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MOpyRtCe; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7523f0870cso606228366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 03:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720521959; x=1721126759; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZxsbIBefCYoeKy9Cb25bQD5JKjjQqCGKHe9J4bV87I=;
        b=MOpyRtCe7jlTwghXztKAiZ3DAoc9a96SFsmOOToI8TOl80Cfc5kvWGQBTrKJZ2HO7p
         Vp3t8St9d+UCtXrDrMGPaTfBBhISlKxW6xK1wGLpgzf0iIx5nFbJCqPCpbBlIvJ9rFx+
         nBEgXhWi0mOiARgS3nmw1quxwM2EOJG3oChhV0aK8Fch11ACnNk6UduEbkBLblb4OV5L
         gkoYALdFBNiGgUUw/wwV32RHGKO/jRYw4NUX2tRgsgjN4ilwKx3xrLb1ifbVAzJ/G1kg
         dzPW3kzQGTntBEbs+Lrs9JPhbcVkTJb/ojX1V0QkFQu8QYOV+5gBDLL2LgovVJzhqcWe
         saLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720521959; x=1721126759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZxsbIBefCYoeKy9Cb25bQD5JKjjQqCGKHe9J4bV87I=;
        b=oZFMOIzyuLpDQ6d82rhGfvw8PZTjzMMPmlWd4VZ/tzKkPICYIpuuuntL/3vPVMn1Pq
         rtEk6wYCyC0ofQucZVQdrt8g0UsJGWZQ+PGLF7SV7w55J26iGeR9wtNF/fk0QEvVgz2l
         AMf6EWK0CIw78rZQ6yRzLIWdfDsI73b1PC5AG92wFv4dfJ6M0Haf+gcmmRBRbHQ6nrzf
         j4yqn+34CQj8DKE/xD1Cvfc0kvCOnRGQooui67eUJU+t7UKNqJjcvK60XJXfBUvUNyU/
         AL7Byp3lw5qYz0HuU0vRuaVhyEJgkvTQlR2+0rQtM0CX3lhAvhpuWNkumkbcd0cGgwvW
         dviQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1wHb2wXP5DbXm/vSQwjWpcn2laLsFvJaTYgoLwxOvnA7v7NZ8BLxxnL7ileT7KE6zewaZ/TqzsgSWoYQFUA/yZ8mzgBui7zymec6D
X-Gm-Message-State: AOJu0YzI5OaDAUNw0LVw25DSC66X2+evpBzajJvmINte/kw7BLyXqPxa
	FO6+f8SLWZnQZT4s4hzPdQWO3LWLHwWajoL8d/YU7pWt35yLdUHriKFlnTbK4Tc=
X-Google-Smtp-Source: AGHT+IGvYcfPFQV+7DBEYzRD0HAnZlDvmx5BFJoXF/V4cTRfvWKAKQqrkJLnm9w0OQ8iV7jmOHjokw==
X-Received: by 2002:a17:906:c309:b0:a77:e55a:9e91 with SMTP id a640c23a62f3a-a780b6b0e59mr135132566b.19.1720521958889;
        Tue, 09 Jul 2024 03:45:58 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7ff038sm66295466b.115.2024.07.09.03.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:45:58 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 09 Jul 2024 12:45:33 +0200
Subject: [PATCH v5 5/5] arm64: dts: qcom: sm8550: Wire up GPU speed bin &
 more OPPs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-topic-smem_speedbin-v5-5-e2146be0c96f@linaro.org>
References: <20240709-topic-smem_speedbin-v5-0-e2146be0c96f@linaro.org>
In-Reply-To: <20240709-topic-smem_speedbin-v5-0-e2146be0c96f@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720521930; l=2474;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Il2UvibnuII6pAMEt7ZcsOO48MoDeeFboVabC36fJtY=;
 b=UbAw9OwhyAwE8k7rUjhzv7OltpusBA6x/6YgB89OJWD+ojTrhyLuMSRDX4HAiIBsrrG0jevUW
 UobpDIs2ywfBIgClNuK2w9UxluMiW7//vluUrY7DilgVsJMyXYkgv3/
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add the speedbin masks to ensure only the desired OPPs are available on
chips of a given bin.

Using this, add the binned 719 MHz OPP and the non-binned 124.8 MHz.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 4c9820adcf52..c1e3cec1540a 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2119,48 +2119,67 @@ zap-shader {
 				memory-region = <&gpu_micro_code_mem>;
 			};
 
-			/* Speedbin needs more work on A740+, keep only lower freqs */
 			gpu_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
+				opp-719000000 {
+					opp-hz = /bits/ 64 <719000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
+					opp-supported-hw = <0x1>;
+				};
+
 				opp-680000000 {
 					opp-hz = /bits/ 64 <680000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-supported-hw = <0x3>;
 				};
 
 				opp-615000000 {
 					opp-hz = /bits/ 64 <615000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
+					opp-supported-hw = <0x3>;
 				};
 
 				opp-550000000 {
 					opp-hz = /bits/ 64 <550000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					opp-supported-hw = <0x3>;
 				};
 
 				opp-475000000 {
 					opp-hz = /bits/ 64 <475000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L1>;
+					opp-supported-hw = <0x3>;
 				};
 
 				opp-401000000 {
 					opp-hz = /bits/ 64 <401000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					opp-supported-hw = <0x3>;
 				};
 
 				opp-348000000 {
 					opp-hz = /bits/ 64 <348000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0>;
+					opp-supported-hw = <0x3>;
 				};
 
 				opp-295000000 {
 					opp-hz = /bits/ 64 <295000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+					opp-supported-hw = <0x3>;
 				};
 
 				opp-220000000 {
 					opp-hz = /bits/ 64 <220000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
+					opp-supported-hw = <0x3>;
+				};
+
+				opp-124800000 {
+					opp-hz = /bits/ 64 <124800000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
+					opp-supported-hw = <0x3>;
 				};
 			};
 		};

-- 
2.45.2


