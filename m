Return-Path: <linux-kernel+bounces-544206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85255A4DEB7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1B7176BCD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7CB2046A2;
	Tue,  4 Mar 2025 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kcz72HOA"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3B6202C3A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741093636; cv=none; b=kjoeN4OCzWCi8BmmrQ6AwuINLSRVAqGemm7ZcsiR+4gNosjcky1xo3X6zUft6lmgd0/zHoyFOMFeNplunMs25clv/y+cYURFxYzLxTQ1X48l7CiISfwhYBcQGI31JxkkDJHcxem+zjCoRKBTCnk5Ppfe10WltmBxxoqatexpNJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741093636; c=relaxed/simple;
	bh=zp7dfq9ZHu42Fop+Hzp7Ynopwb9wccKSyGLv3/T6KYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YmqHuXbfH/4/HR8XyDQzAfm6B8f+8aNVN2D3jS7sAgVYvxKIGb9w8sbTMDI71b6I0kdt6a7zDPnGRqlFxMnBBWM6DO7wZKgpyVUvyGHS6IV2UyfKcNWYIeiHgoXBklup99PZ3FXyrmpuhqS/3X0Aq7g2/5LwNqMJaHKi5KT0iZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kcz72HOA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43995b907cfso35987025e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 05:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741093631; x=1741698431; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0qKgshl2F0rJcY3RgeB9zYkoCzuHBzqb6ry7L6OfzQ=;
        b=kcz72HOAtWYz3QzNm8dbICF5Wm4deg46csGs3Af1Duj6G2puOgyHodGALb4sYtWgov
         SwDC9XfZ63zRnPfzeaGa39NTULiIhFfQZ2MPCWaaEsWZ8mtjZcmfBLEaDGURLSLZ5DqD
         h0CKxvJ/mlYqCYNMh9mkEwjnmOrfYILOFvnuV7W99Rk7Xy5jnrliwZwEN5hhJogSnVNi
         U37Uzpw0BddOFydNov/0kRkOB0rOmnDEdXRnWcAg6ZPNAC+/4QhQADMCDIQMRoVmnw3U
         /tP0O+6M+dCURtFMYtYs5reBBgGHKwoomWa8rK9AU2XDiKTNWjo9Y/0Vfb2P87WS7Ipo
         MXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741093631; x=1741698431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0qKgshl2F0rJcY3RgeB9zYkoCzuHBzqb6ry7L6OfzQ=;
        b=gRgTbGMPZTyzNY+qCfD9QeWReCWHcQ5WR/qa6yCPRHXM22krWnunnb/+wS5JLuQVVa
         67zX60HOviMynpHhYRopX0VFkMgICItropXu9sXqj09a3dTY/Dt+LLx1fGoPFr2xKjN0
         YQ+SxnezDU7MeOhXWV1a/vd17mwSGSq12FFM7hcAkNMZzDw9+DIQaOC+/evuW/heAlh5
         Mg9hNxUKr5ohLkqDbkGBBdGDw2PmKZLjrO1r5ruCLfQPBKP3lw/XA2n7MK9XQX9ze5Ix
         vAK7uJOlUq96NRgm3dCrwz9BJcdefOADh6pWqt0DFZcnFIf37heUHaHTkyl9RW5GjjDw
         TyRg==
X-Forwarded-Encrypted: i=1; AJvYcCUdq81RLIUBPAVRAtzaeokebXAznh3SJYX/Gt1clV6ngr3La52U25c7T9gRtyKsxgqwn5dcc1u47szKp7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMFk7yIvXVKSnTjNZTdInuX4lpwwu/dC3/0hlGs+27fGaSmjd8
	qxfWZuNWC54IVQv2KsEx+8rCvUe8FCOGzIgI+dsDQCM1/DNZS6XH/ohCWC7o9rg=
X-Gm-Gg: ASbGncvFRkSRy7dDCZuGn3jZhVi00WD9JEDUB7jtQlsWijeNiecOlWbAXRpGvswjuW2
	2LC+gCM1SBF0nwhVYDJMGVf18mhTMQEg2F5KdoYkYmG1v7nfmSTpBIyOQ1vpluL9lLDmhZmRXyr
	VD5IAQvWuKwCSIpu3spmpH58BWge8FIQt8RWQFKhyveDeaLE6aJXLiIWiNJWRgiSzsLhuoS9QeH
	s6U2JfBBvOLZ3ovGMh/U8Cb2EspWs28Q5Dj/+ARyAvOYa3dfmGoaMzXVeZeiwzg+/J8B0YMzdFa
	iA6ZqgzBmK+q6y9zbEl+T0B9HyrAzXBoeLJdD2IwkzNh43cIe2zufwb84B6BWCjlg2zsTOzcDWe
	xgL+6Kg==
X-Google-Smtp-Source: AGHT+IGt41Z+aO1r0FZqK5TAia+vDzJ+cmrhxgfP8isz0xSsSE8fCGSnzIfP3HUl2KwIfn42/exnSw==
X-Received: by 2002:a5d:59ae:0:b0:391:1652:f0c5 with SMTP id ffacd0b85a97d-3911652f24fmr2043369f8f.37.1741093631080;
        Tue, 04 Mar 2025 05:07:11 -0800 (PST)
Received: from [127.0.1.1] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b6cd8sm17401715f8f.44.2025.03.04.05.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:07:10 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Tue, 04 Mar 2025 13:07:07 +0000
Subject: [PATCH 1/8] media: dt-bindings: Document SC8280XP/SM8350 Venus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-1-279c7ea55493@linaro.org>
References: <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-0-279c7ea55493@linaro.org>
In-Reply-To: <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-0-279c7ea55493@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>
X-Mailer: b4 0.15-dev-33ea6

From: Konrad Dybcio <konradybcio@kernel.org>

Both of these SoCs implement an IRIS2 block, with SC8280XP being able
to clock it a bit higher.

Document it.

Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
Link: https://lore.kernel.org/r/20230731-topic-8280_venus-v1-1-8c8bbe1983a5@linaro.org
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
[ bod: dropped dts video-encoder/video-decoder ]
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../bindings/media/qcom,sm8350-venus.yaml          | 119 +++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,sm8350-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sm8350-venus.yaml
new file mode 100644
index 0000000000000..352ad85ae50cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,sm8350-venus.yaml
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/qcom,sm8350-venus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM8350 Venus video encode and decode accelerators
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+
+description: |
+  The Venus Iris2 IP is a video encode and decode accelerator present
+  on Qualcomm platforms
+
+allOf:
+  - $ref: qcom,venus-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,sc8280xp-venus
+      - qcom,sm8350-venus
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: iface
+      - const: core
+      - const: vcodec0_core
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: core
+
+  power-domains:
+    maxItems: 3
+
+  power-domain-names:
+    items:
+      - const: venus
+      - const: vcodec0
+      - const: mx
+
+  interconnects:
+    maxItems: 3
+
+  interconnect-names:
+    items:
+      - const: cpu-cfg
+      - const: video-mem
+      - const: video-llcc
+
+  operating-points-v2: true
+  opp-table:
+    type: object
+
+  iommus:
+    maxItems: 1
+
+required:
+  - compatible
+  - power-domain-names
+  - iommus
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,gcc-sm8350.h>
+    #include <dt-bindings/clock/qcom,sm8350-videocc.h>
+    #include <dt-bindings/interconnect/qcom,icc.h>
+    #include <dt-bindings/interconnect/qcom,sm8350.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    venus: video-codec@aa00000 {
+        compatible = "qcom,sm8350-venus";
+        reg = <0x0aa00000 0x100000>;
+        interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+
+        clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
+                 <&videocc VIDEO_CC_MVS0C_CLK>,
+                 <&videocc VIDEO_CC_MVS0_CLK>;
+        clock-names = "iface",
+                      "core",
+                      "vcodec0_core";
+
+        resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
+        reset-names = "core";
+
+        power-domains = <&videocc MVS0C_GDSC>,
+                        <&videocc MVS0_GDSC>,
+                        <&rpmhpd SM8350_MX>;
+        power-domain-names = "venus",
+                             "vcodec0",
+                             "mx";
+
+        interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+                         &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
+                        <&mmss_noc MASTER_VIDEO_P0 QCOM_ICC_TAG_ALWAYS
+                         &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+                        <&mmss_noc MASTER_VIDEO_P0 QCOM_ICC_TAG_ALWAYS
+                         &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ALWAYS>;
+        interconnect-names = "cpu-cfg",
+                             "video-mem",
+                             "video-llcc";
+
+        operating-points-v2 = <&venus_opp_table>;
+        iommus = <&apps_smmu 0x2100 0x400>;
+        memory-region = <&pil_video_mem>;
+
+        status = "disabled";
+    };

-- 
2.47.2


