Return-Path: <linux-kernel+bounces-348740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E39F98EB45
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7EDBB2187F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE23313B59E;
	Thu,  3 Oct 2024 08:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d102nr0h"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275CA146017
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 08:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727943282; cv=none; b=GnsLzfgI+FN9sr80a+VTINMt0j4oq3WIKNpv8fQCFLy0cgwiQeyLiJdVFbfHLuQbmjWS72yB2lEQ8d/YDiYqhsxHXdU+LEc2H+s7QE4kikzoP2sfX6M5+atxCQ6+DEfOLFCn+O22Ym4hMU0PEidv/ofnz1KDHA80Tf5oJVKqiMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727943282; c=relaxed/simple;
	bh=AKhgP7q0GaIQSUQKoHkiCv6d3dwP2bPLVjVUtecZON0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FRXAsx8BVM3pPN0IgrApjCSWUt0qvCiT1W8WE2xSbRD0oMigbymaJy+Knu2FakGA6cR/5LjmRD/r+tcG13E7kDFBGjKvNArC6svFa2/oCU2ttnkus39D7cVbdueLSk2G1EFq5/4VfpYPQqZtgQCacLxIjRkMLHdI0wSJhELqdiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d102nr0h; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42f5a663ed5so838435e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 01:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727943277; x=1728548077; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ArBelTC9NYknk17YOAC0+lV31yeITIe1wOVojgMQpJ4=;
        b=d102nr0hk8HMMrfif43TAV7maBp1Z8Wd1Tvgu6by5XAkRZeYR1EDAJ/SW8KYNtYSxb
         i/8Dwxul6Quk9yZqFeuOIrH7u5ocOLVTs1zDZqALcy41miLGd1bjAwSlEutoUvz9vecr
         2ajmVb4v+twQkH6lQzhJzRQLGOnLabji+OOxyGKpy+AEpVE7WATlGGG8o3nW/7WWE3d7
         gk8eC5mldzNlyY6U3KzF4AWyOMIu51ecxq2juqDHBwTnJSuODPDDDQBNgGlTQES3bP4g
         kTe1Ya95ALqTS98arkXm0t3qsVmKEVIbxzF4PtCstucOAi+97HkJlt0Nl+PpgL9Ildl2
         mnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727943277; x=1728548077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArBelTC9NYknk17YOAC0+lV31yeITIe1wOVojgMQpJ4=;
        b=gesqGX2S2zTqxpHb6u2XZXp4tqvmbWcGInRnRbVcId4YuZUvicj7BQeVecR2oXV9ht
         DOyJCYGdHXEXTLLUPVQO5Bna+ei/WUa6YT645edHg+OOkH0QPCeTQV3unvyFQAXdh66C
         SWUr87O+p4irmJmwy3hZ7fRSauoZYc66YbAe4KwZ68//Q8FBebhDSP6rAxJQBH5CMwY2
         X8dfw9p+KJhAEvbETooDhKD7LMW6rLXnMZHQLZ5uVPr/nQChCwVPLJ/to2GE9H6mx/A5
         R6dX3uPJBAMTgyIKJBpa0EbGXFqvY8neCf7rtZbB9R88x67Q18qXnfsemS5jRjT73QUP
         OvJg==
X-Forwarded-Encrypted: i=1; AJvYcCUunFIwpVDmSQ1PtjiItQFIcgEt3mdV9b2DR6P+m/IKaCbhtNVPCz4aoi/3YE/JFNNbGU0SB9J292n1Qoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTq6SfLoNRMJpJWdICMYsjfHjQO48dKsPrFvWF7RQpjYNxg4T6
	uHUa0lD+l6yX7aL+cjO/au10WBD7fpa6QqGCqrDvtF1ax9uaKReXkT4yr+q5l0Y=
X-Google-Smtp-Source: AGHT+IEZZ9yqPRpUkj59+2e4tzhm/Y9ZxH9ngz6j0TXb/L0/Y1YM9lMtfkVQV3nVzkU4l8hHAEAmAg==
X-Received: by 2002:a05:600c:1393:b0:42c:ba61:d20b with SMTP id 5b1f17b1804b1-42f790970b6mr19964015e9.3.1727943277392;
        Thu, 03 Oct 2024 01:14:37 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082d230dsm702027f8f.94.2024.10.03.01.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 01:14:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 03 Oct 2024 10:14:21 +0200
Subject: [PATCH 4/5] dt-bindings: display/msm: merge SM8450 DPU into SC7280
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-dt-binding-display-msm-merge-v1-4-91ab08fc76a2@linaro.org>
References: <20241003-dt-binding-display-msm-merge-v1-0-91ab08fc76a2@linaro.org>
In-Reply-To: <20241003-dt-binding-display-msm-merge-v1-0-91ab08fc76a2@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5495;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=AKhgP7q0GaIQSUQKoHkiCv6d3dwP2bPLVjVUtecZON0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBm/lJi9PKnUZKPp3bxs4fScDOr+KitJedC3+vAz
 0o9qOFFaG2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZv5SYgAKCRDBN2bmhouD
 11upEACJ0BVnq8qjv3Ph2jKpGDLXGePbTEmqdtBS4tTB4aqUTYWkLBhapJkGGUSa04rNy3eDHdx
 2Chu4qCpVLpNcHjHfnPQxkeUZYK0fH1ZJvMfTzbNQsq5OeIkWn8ARRPBO3wISAyh/U276apikcf
 6Pd8hSW0YCJNbyygS807LXfA0RD25MVv8/azvytxtmnLKqvaJpWPdXSI8Fn/7osOh9PcvKs5r19
 rhbTxv6AoRIgeoXHUtKh1/r/tco3c31H9fXHTQsz0J73B6DyoQFjzs7OXXmjDMvwxA/CmDFRlra
 pWEVEAQOC5W2vMFWRp+98Mnj+LlRaeqs+0dCZESTeZg4rlSsknaFiqb9qtqA5yUU+pDBSdIkvL/
 yha2Clkxx243AZ+6wHZd7gVEEBXzFtpkPgOvami5bVTkIW0IDDgE7o1+VRi0z5SrvFiM5JwKUMV
 2cD7ZFojH7Ivko0G5OQvE5bIftcK1Jhx9lvvSGHRE6dwe3l8YN3lyE9s+O8uY0fxjpdCEXoflpX
 XCHXoAg0Fz0AN1onmNQIruiCEav5AmsJm0L5nlBu7tOnNr93ugJlG4LRtHKtyPdHUcqexzaEuN7
 QVkk0g8ddnRWELvo/slmntpKjvyn5X/SxkkMvYAZWo3JjpbrxEf14mX+MJd9J5U6YjX+4yDUX9f
 akLeIow5PLj1HHQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Split of the bindings was artificial and not helping - we end up with
multiple binding files for very similar devices thus increasing the
chances of using different order of reg and clocks entries.

Unify DPU bindings of SC7280 and SM8450, because they are the same.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/display/msm/qcom,sc7280-dpu.yaml      |   2 +
 .../bindings/display/msm/qcom,sm8450-dpu.yaml      | 139 ---------------------
 2 files changed, 2 insertions(+), 139 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
index 3d69a573b450..750230839fc9 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
@@ -8,6 +8,7 @@ title: Qualcomm Display DPU on SC7280
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
+  - Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
   - Krishna Manikandan <quic_mkrishn@quicinc.com>
 
 $ref: /schemas/display/msm/dpu-common.yaml#
@@ -18,6 +19,7 @@ properties:
       - qcom,sc7280-dpu
       - qcom,sc8280xp-dpu
       - qcom,sm8350-dpu
+      - qcom,sm8450-dpu
 
   reg:
     items:
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8450-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8450-dpu.yaml
deleted file mode 100644
index 2a5d3daed0e1..000000000000
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8450-dpu.yaml
+++ /dev/null
@@ -1,139 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/display/msm/qcom,sm8450-dpu.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Qualcomm SM8450 Display DPU
-
-maintainers:
-  - Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
-
-$ref: /schemas/display/msm/dpu-common.yaml#
-
-properties:
-  compatible:
-    const: qcom,sm8450-dpu
-
-  reg:
-    items:
-      - description: Address offset and size for mdp register set
-      - description: Address offset and size for vbif register set
-
-  reg-names:
-    items:
-      - const: mdp
-      - const: vbif
-
-  clocks:
-    items:
-      - description: Display hf axi
-      - description: Display sf axi
-      - description: Display ahb
-      - description: Display lut
-      - description: Display core
-      - description: Display vsync
-
-  clock-names:
-    items:
-      - const: bus
-      - const: nrt_bus
-      - const: iface
-      - const: lut
-      - const: core
-      - const: vsync
-
-required:
-  - compatible
-  - reg
-  - reg-names
-  - clocks
-  - clock-names
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/clock/qcom,sm8450-dispcc.h>
-    #include <dt-bindings/clock/qcom,gcc-sm8450.h>
-    #include <dt-bindings/interrupt-controller/arm-gic.h>
-    #include <dt-bindings/interconnect/qcom,sm8450.h>
-    #include <dt-bindings/power/qcom,rpmhpd.h>
-
-    display-controller@ae01000 {
-        compatible = "qcom,sm8450-dpu";
-        reg = <0x0ae01000 0x8f000>,
-              <0x0aeb0000 0x2008>;
-        reg-names = "mdp", "vbif";
-
-        clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
-                <&gcc GCC_DISP_SF_AXI_CLK>,
-                <&dispcc DISP_CC_MDSS_AHB_CLK>,
-                <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
-                <&dispcc DISP_CC_MDSS_MDP_CLK>,
-                <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
-        clock-names = "bus",
-                      "nrt_bus",
-                      "iface",
-                      "lut",
-                      "core",
-                      "vsync";
-
-        assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
-        assigned-clock-rates = <19200000>;
-
-        operating-points-v2 = <&mdp_opp_table>;
-        power-domains = <&rpmhpd RPMHPD_MMCX>;
-
-        interrupt-parent = <&mdss>;
-        interrupts = <0>;
-
-        ports {
-            #address-cells = <1>;
-            #size-cells = <0>;
-
-            port@0 {
-                reg = <0>;
-                dpu_intf1_out: endpoint {
-                    remote-endpoint = <&dsi0_in>;
-                };
-            };
-
-            port@1 {
-                reg = <1>;
-                dpu_intf2_out: endpoint {
-                    remote-endpoint = <&dsi1_in>;
-                };
-            };
-        };
-
-        mdp_opp_table: opp-table {
-            compatible = "operating-points-v2";
-
-            opp-172000000{
-                opp-hz = /bits/ 64 <172000000>;
-                required-opps = <&rpmhpd_opp_low_svs_d1>;
-            };
-
-            opp-200000000 {
-                opp-hz = /bits/ 64 <200000000>;
-                required-opps = <&rpmhpd_opp_low_svs>;
-            };
-
-            opp-325000000 {
-                opp-hz = /bits/ 64 <325000000>;
-                required-opps = <&rpmhpd_opp_svs>;
-            };
-
-            opp-375000000 {
-                opp-hz = /bits/ 64 <375000000>;
-                required-opps = <&rpmhpd_opp_svs_l1>;
-            };
-
-            opp-500000000 {
-                opp-hz = /bits/ 64 <500000000>;
-                required-opps = <&rpmhpd_opp_nom>;
-            };
-        };
-    };
-...

-- 
2.43.0


