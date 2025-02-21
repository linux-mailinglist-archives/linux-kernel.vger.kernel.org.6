Return-Path: <linux-kernel+bounces-525737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6C1A3F403
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5B707AB105
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FCC20ADEC;
	Fri, 21 Feb 2025 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tKK7Mvwo"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC90209F58
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 12:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740140230; cv=none; b=ED9/UpeRq7sIIdczTZ3toBkjrz7NTi6GIOjtvpVbpkQVAThoXiqwnDFOJYfn8pJk4ioiGOnYWrgm3frVT9Xe9XF4dDI7GcHXLwlRCxc75kLq5Z6LlP4z7j+4UpKVO73ZPtlV+hMpOmRZTJNBUpc+rRnxbYiFDsxCSP5ng5+RxkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740140230; c=relaxed/simple;
	bh=98nF4YMzGSjsJfK6fBfJ4XB56FEClC9kTVlWMWXJKO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SpDW2nzqNAUKAuFdAsfAfnm97TMlzCqOPMbQmtSIMQ7+O89x/nQCilz10C6pwWjZjpuQNS1tPiqT7xh6J3kLcMflNJ4i8fTmQ7JdlFgJPz/R+Edk+CEx9aYD+PpzAMzMMsuWFeX9wFEBUwrrXrQTRNjCwLrCE+eNspY6lfEbwv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tKK7Mvwo; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab7ee6f5535so30312266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 04:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740140227; x=1740745027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eAeiE8ep92u5I2OEjsiUsdxt/J43hiJGD52gUZJ3zJ0=;
        b=tKK7MvwofH2RLFuI6TSQcJbJigQm/xH8UE0gjZbvwXiAkJg2Ak7+IYR362O1QUv9Tf
         aqVLgUeFj8+caawsPcD2aQtglTwWBpmMciZ0n1Z1RqyjMjXqKU2bi5aRxU3OcLw4k+/R
         dKk8n2oFENPkB/1uAiYsKc55XMTf87wp8OJTbDd+2NIeHJnVJu1PUAHsQ4YMk+Y6erQo
         W7wf6NDNBqlYGB1w0EZNwzVluVT3uChoKSylesO3Th1pN/7Po5SQhLE5QlpVCQI/J/1r
         4+ZxL+I/MjRxjaP+MMJPSuBA09iuR/w79penTSu+TnC7+XpjFRNHxfTPoF8NafsPwMZi
         7EvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740140227; x=1740745027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAeiE8ep92u5I2OEjsiUsdxt/J43hiJGD52gUZJ3zJ0=;
        b=ji+mukAS1zgEGxwYXi+Iomt+IkuGqP40aw0Yo9TQ0Pv72aBw0qsUt+Mb0fCRqOcaq9
         M1DA1K/2ci4wotUqIi8LcEa3Ze5YhDyESZKBcHDhDZ/t3KClO+Wjv1USqONx35U4XZJF
         wyMQSYhANHtcBbigF4bzuAgYcifM3TSl3XmO36ziA18wDoo8V1jWjvjBd3CWxaCFQ4ZK
         4Opcllgm8o4mwYdeVqsE7qxQk4gRFk7iPrSWKBsgW4nvVmnY1Yw+t5YD3bkbsRolt94F
         Xfgv+H+qVYaea6941ZtG7Wwzr19NS6PZtZsPtcqaCx6K4BlSpIgGqGf/EYBlSSBdZFiU
         nLmw==
X-Forwarded-Encrypted: i=1; AJvYcCVLVq9ljAsqUKAZgkzxUzfN7iKTrZBPWc3Qjqw6zobcCZprg0l2eJv1+kebQIr26ErTYgLQAKPITrute6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeL+D9v8T2VpBQ4A7uey1M5aD2AUjm1T2h7dy1p/ICR/KZc9IE
	98LiXAussHu5AJt7ndiLI0UjkG1mL/vkQZjhd324KeMfE9wyRkCxOH55fbrHBKM=
X-Gm-Gg: ASbGncs68LsV+wOYTuM75E55reNy4lBInKCmDbZDO+fn5fdu8PnGBCyaMKNKpnsgzrc
	weTfVa/ns+KGbV9byWFttJXcD+Z2S7kKn0m3MVxw3VBeCqLAKLMFRH9ybPYXPIpcwqWecfaC8VA
	OLWpW5nOOOjEawsZeVWHGKIn6hsQIi2p6sGPu199fIq34ySPTAObodNWWnr9czZFWyr4ecFfDM5
	T1ndxd5KLTrRPnnC9wJwmcK5L3QJmmpW1n4CImIypezkymiFcvyTNE0+qjXEa2TGvk8u9aA0P7P
	fmufDntKQz2LgRza4GdjDsZixQqZ+q0GBq1zEeaOILIpszIvNYdf9uOX6BTJn8VntmLysq5Ylt8
	=
X-Google-Smtp-Source: AGHT+IHuU1zR/BA+Pe2MYhCuCM+VStRQ9WlfH6VW1Kurq6t3qWN2H1iXwJJ1LKrJXNRHpLQnGQxwPA==
X-Received: by 2002:a17:907:a089:b0:aa6:9574:1728 with SMTP id a640c23a62f3a-abc09a0bf96mr111665666b.6.1740140227001;
        Fri, 21 Feb 2025 04:17:07 -0800 (PST)
Received: from krzk-bin.. (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb916db37bsm1041690566b.165.2025.02.21.04.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 04:17:06 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
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
Subject: [PATCH] dt-bindings: display/msm: qcom,sa8775p-mdss: Add missing eDP phy
Date: Fri, 21 Feb 2025 13:17:03 +0100
Message-ID: <20250221121703.72230-1-krzysztof.kozlowski@linaro.org>
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
 .../display/msm/qcom,sa8775p-mdss.yaml        | 32 +++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
index a90a8b3f1a9e..9c5648f63901 100644
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
+            reg = <0x0 0x0aec2a00 0x0 0x200>,
+                  <0x0 0x0aec2200 0x0 0xd0>,
+                  <0x0 0x0aec2600 0x0 0xd0>,
+                  <0x0 0x0aec2000 0x0 0x1c8>;
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


