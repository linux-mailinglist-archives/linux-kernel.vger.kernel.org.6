Return-Path: <linux-kernel+bounces-525984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F390A3F82A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 132DF1795F9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05F220A5C3;
	Fri, 21 Feb 2025 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SR9ofafM"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FACC20B7EC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740150802; cv=none; b=Snm5CnG5YD20rfLsKKecwOcY89P92yybgB5vrhpZ0aArlPxBWs5WZRHhSofrWOM1h5H09g52vFHKbFONKcs3R7yBSdZvhZx+P//HRcd3bODFz5RccUr+rg8fSGLuiGVII8F0Tb9sxUKXl/BGt2aij7ZQEUe5eeTGovjT2Zr6MgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740150802; c=relaxed/simple;
	bh=Fa1BddI3XJm8BQciNHEuwUqNi53s9MtiqS6q/dOK9Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CUNlKKzGW3EeYbygnqSNxcVNnbQqfR3C2sgscnkYhaAQDBv7DrMMWdNpgpUBJQQ4RRFJ5PX+hzJZ3sope7TIv0+aNYEFt8rHxv2pw/jkI1xFbyBBcXkGFyqa2XFIC53T+dbjFc/BYJ6TiLkD9iPTTRJl6ryIFmhpVBjdLXQQ6do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SR9ofafM; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5dc050e6a9dso449537a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740150799; x=1740755599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kffi9mM57RBxjp4z5FLBrRuQy7GA5fKXeHplvEZGGf4=;
        b=SR9ofafMegilwl9LWHIOnO6ymnxn9Ndukl8qs1irlSjqzhDbrg3Plxu1E376q5lutJ
         g4AR7Xu1SEgchInZBMOKo8MY4MHdSfenMA8jAfw9JvoFRHhgwUnlWP5cMF5hwiYSzeEB
         n46/HwCSTQ1RT1vRpVigFYIf3CNWwXWWFBaXT5NM79nacKvU8DjcKdDPnkNAt/es8Vmr
         JQUFluZhwzbbFfqGkZHguTcL6G6XLgo9jzSywLPYmejHBzdGKvNCQjW0ny83enLPWd4V
         w5ekHp84g9scuGERSXxEd0uWvarwVaT1MPYhDvtV+IBYmyWDzpUyozOLfkv0Z218qwkC
         fJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740150799; x=1740755599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kffi9mM57RBxjp4z5FLBrRuQy7GA5fKXeHplvEZGGf4=;
        b=fqr7ApcvRnrkz6mNSjW4RIokP02TBZU6be/sbJTBrZKmQeEg5tPAG03eFVf2KpOYsi
         jsqhhl81gDVS2uNMzrJgoTJ7FlSAv1SyRkiYAceO3ZxQID3DctAp/lNNn80Bx79Z8PBY
         hgC3PD41III3RuYRAascqwWDJywFmYRWsRDYnqz00oKzFWyQPK+dHAbRwFlCzoHLu0qz
         mCitnILgfn+NbiIE+BX5zdTWiymU4UGzSohDrNXg7n7vWe7/Pc7HMgz5wsfxxq94898i
         3kLv0Y2NYPHdWgtigVPLLeSXbJU2Bg0KaLPQmt7YmCTISUovJflKsgIrS/TQQxBeUvUf
         ZuKw==
X-Forwarded-Encrypted: i=1; AJvYcCU7hT5DueQpV7m0y+FLQ9zYPE4G+FNMrggCZMnlXdFxcLIQd8zyZVMhreNyTTXczjcK9H0mMLYDfbUDhwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJK4f651nNmq/YtD1wBPNsj5l6soasv/utGRmBN8dXEqR0Dg/4
	QP5lBs5u4bgHZlsfr64u8nUgeZkNX9mCpFkRzgTVz6/36dr8RA0zB6AnzHjXFyU=
X-Gm-Gg: ASbGncuk+eP3xoxB2WRc1IptvriJHpN+TDp5tHzYR5r6icuciNJvjKTGab9nzU/nnLR
	QEPr74jdUbz3HradxG5mOu82owV3DYiRKnsuNfdQmu+qnbKb9zS7yTJVGNyKih+0eLt7R7ke50u
	PK5Ry+kdUF71m4JEhfsM0NBWJZWYOvjUQ0xRLBMonlrSQfCfLIWR9h4VaPxdXHkET/z5w4AT2Rm
	6Up3Uz2B1JDnkraLc0j4kDtks51r7I7JShbutU7AKhKu0u8chUzUi4qM3XbP4edZDtVHCLrfdWu
	4zEUhu7HW1kahJVajiVfsKg4CijJDP2IiDSJ0C6Jg4qRAR7ptI0LF53xHGsIdjo12ND1eTePnuQ
	=
X-Google-Smtp-Source: AGHT+IE2efORy+XnFq6iGRbNUJ79O3DLiV+WA47UQiAkKow39HzZeGH66x8Isz/Apww6BksdMEVRpw==
X-Received: by 2002:a17:907:a089:b0:aa6:9574:1728 with SMTP id a640c23a62f3a-abc09a0bf96mr141099466b.6.1740150798792;
        Fri, 21 Feb 2025 07:13:18 -0800 (PST)
Received: from krzk-bin.. (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8ab30726sm1110640166b.153.2025.02.21.07.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:13:18 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahadevan <quic_mahap@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: display/msm: qcom,sa8775p-mdss: Add missing eDP phy
Date: Fri, 21 Feb 2025 16:13:11 +0100
Message-ID: <20250221151311.138755-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Qualcomm SA8775p MDSS display block comes with eDP phy, already used
in DTS and already documented in phy/qcom,edp-phy.yaml binding.  Add the
missing device node in the binding and extend example to silence
dtbs_check warnings like:

  sa8775p-ride.dtb: display-subsystem@ae00000: Unevaluated properties are not allowed ('phy@aec2a00', 'phy@aec5a00' were unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Fix reg size (address/size cells =1) in the example (Rob)
---
 .../display/msm/qcom,sa8775p-mdss.yaml        | 32 +++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
index a90a8b3f1a9e..5fac3e266703 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
@@ -52,6 +52,13 @@ patternProperties:
         items:
           - const: qcom,sa8775p-dp
 
+  "^phy@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        const: qcom,sa8775p-edp-phy
+
 required:
   - compatible
 
@@ -61,6 +68,7 @@ examples:
   - |
     #include <dt-bindings/interconnect/qcom,icc.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,sa8775p-dispcc.h>
     #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
     #include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
     #include <dt-bindings/power/qcom,rpmhpd.h>
@@ -158,6 +166,26 @@ examples:
             };
         };
 
+        mdss0_dp0_phy: phy@aec2a00 {
+            compatible = "qcom,sa8775p-edp-phy";
+
+            reg = <0x0aec2a00 0x200>,
+                  <0x0aec2200 0xd0>,
+                  <0x0aec2600 0xd0>,
+                  <0x0aec2000 0x1c8>;
+
+            clocks = <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_AUX_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_AHB_CLK>;
+            clock-names = "aux",
+                          "cfg_ahb";
+
+            #clock-cells = <1>;
+            #phy-cells = <0>;
+
+            vdda-phy-supply = <&vreg_l1c>;
+            vdda-pll-supply = <&vreg_l4a>;
+        };
+
         displayport-controller@af54000 {
             compatible = "qcom,sa8775p-dp";
 
@@ -186,9 +214,9 @@ examples:
 
             assigned-clocks = <&dispcc_mdss_dptx0_link_clk_src>,
                               <&dispcc_mdss_dptx0_pixel0_clk_src>;
-            assigned-clock-parents = <&mdss0_edp_phy 0>, <&mdss0_edp_phy 1>;
+            assigned-clock-parents = <&mdss0_dp0_phy 0>, <&mdss0_dp0_phy 1>;
 
-            phys = <&mdss0_edp_phy>;
+            phys = <&mdss0_dp0_phy>;
             phy-names = "dp";
 
             operating-points-v2 = <&dp_opp_table>;
-- 
2.43.0


