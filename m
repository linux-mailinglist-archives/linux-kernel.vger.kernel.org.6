Return-Path: <linux-kernel+bounces-513444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E52A34A65
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CBD316DD3A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F60266B76;
	Thu, 13 Feb 2025 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dEVuCa37"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA3D245035
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464087; cv=none; b=lm4zAZt0S5GtMzyxp5XSduBD4j/CowJ0n2WU3Q1FkbrtobUDT2wKmyKKFx30q3FMJPfiSdo8bacOaTm+LltNXS87UM3ljpG2VTtZTR1waRqUAytWgKhJqRs6qxZnMVwbBX13MAexoiadC59J7uuPr+p1ljd/74tYBLFgS0FBzmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464087; c=relaxed/simple;
	bh=oNd12i+2YmkCuPYQliiOZGjMa/GCFMaAOwx4UZry5cY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IrVxZhX4cJksJwPBVkZ2rFCt91BEfNrnBCLSSst7V/vy4Fo0e7fVVTtShrsi6P3XTFSCsfsVPaZ73fUs2KWNsFgLofhw6lJ8JQslz5oSSkcj81BnV5WgoR3TOP0TbdhNCNJfLFTz7fluXPHt62men0keFkd/+6DaNKzrJeSHgSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dEVuCa37; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-439585a067eso11586005e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739464083; x=1740068883; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nckyoaf9WMSwIR46ubTH6va+VexZaxBrD6oq84P05tk=;
        b=dEVuCa37xF94crz1EBsIxH0OLchEiFA+EpYWKLk0sxfWJnNxZyo0/7E3yQbx8OW0DA
         V17YsF/0oLClf7g3wBubekl6hX7yl/BYvyKWDRVQWlK6Oq4UQlu1kNi9Olrk7Cc1On1X
         fEV2gav6/Wh1xlb13XaZJzugKAb7VT+TuubGk1AWcrWraLsSmknj0cUc7tIhnMPqc1Em
         LW96lt0ti1cBeZpxtNKZSyBP0cyV6TyKgfdLy8lX0CU0RwHkzsbdpTVshrjN1vKT50D8
         OcRbz1TcQ/Lg6eUZJ/6wg7WPH0CKKpvBzfH+JPZMT3dV1o0J7p6QLggyVeHinsHNAOrM
         NERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464083; x=1740068883;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nckyoaf9WMSwIR46ubTH6va+VexZaxBrD6oq84P05tk=;
        b=RIroJh0xWkOvjxLs4Ns4Au5EstH0DqvGlq/jnCxAFctjnngiaXONScgtUotQieEWcx
         U5KrkTA65c4nQ4r9NGTL7LQTR6LgT4PVhMdwaaVgdQB++8nj+LBVCZo3iArfUJ+1FzMA
         Y2f+aRp9n1sluZ915pneVAiD2Q7hb6uxL8+Bd6VU+0JKvRTRbTIRj3r91BUaS31Zk3Al
         PztV/ZcnpgRlvxHP9e6G8vI/6i+Vnwhd42bA7u1l10fbIAQ+h60YLtqYCCwj/agRR6Ok
         vM5aAIr466QDvXSXPd4klHrXpCpGoUgHhheOgRxj4N5Az6p7Z1xoxHfzI0oTiLyECH+w
         ctSg==
X-Forwarded-Encrypted: i=1; AJvYcCUjj8QM/8UwpjJ5hCxbcP54Kx7MMn/75p07rMko3TMYZK1r09haGZ9a4y2YuyGP/fe2HY4bIsWIa45S8VU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5aGESX7pWnX8AQtYLo+wQuyrz3FHIEnVU2MfXA4oHaelux4Et
	+2o76uRNseiHpmvZVqxsAoIzaQrfkVvKEmvpn990GlfxIRr4sVZBgOEEo+4Ukkk=
X-Gm-Gg: ASbGncux9XspxchW1N5C4V4HssXitY93+TarYvAsyNZAu/STgk42c1oxPqgbBwcoALk
	fF3O1e7SnO/cOLJ/RktmEMYMae72BC2A2ELhnwKBCRTLJTiXZzKBkGf9jJdn3Fn/hUQi9NowcnA
	fPeIhrqYoCIgM8FlJ8UxXi7fuLJ2xP8udnK+aHLBT2IarcShKGvkddlUO0ylVoUUZCZmMSTApt+
	Y7jDshRh7pu+vJncxAaXpRZvv92OEn79v4RIEAIZ171O50r+rrp6RbKm8PsWUoRooEybAZcXt0U
	WVhphBtGySRBFWz12eKXTl9sgK4D1w+H86lv
X-Google-Smtp-Source: AGHT+IELeKCADQgg3H5ZzZcXql0ZPJ1C4Uvb1zOBpoOn1s+Bz0PEz8ZZ92bF4HPtyxGd27LfKSXksQ==
X-Received: by 2002:a05:600c:3544:b0:439:57bb:2aa with SMTP id 5b1f17b1804b1-43958166727mr107502195e9.11.1739464083323;
        Thu, 13 Feb 2025 08:28:03 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b412esm2274382f8f.1.2025.02.13.08.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:28:03 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 13 Feb 2025 17:27:56 +0100
Subject: [PATCH v4 1/4] dt-bindings: display: qcom,sm8550-mdss: explicitly
 document mdp0-mem and cpu-cfg interconnect paths
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-topic-sm8x50-mdss-interconnect-bindings-fix-v4-1-3fa0bc42dd38@linaro.org>
References: <20250213-topic-sm8x50-mdss-interconnect-bindings-fix-v4-0-3fa0bc42dd38@linaro.org>
In-Reply-To: <20250213-topic-sm8x50-mdss-interconnect-bindings-fix-v4-0-3fa0bc42dd38@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1989;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=oNd12i+2YmkCuPYQliiOZGjMa/GCFMaAOwx4UZry5cY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnrh2PxgSsYod7hW5BPfhjvjXJr3Hpc/Y4nGjmbpLq
 /LWeb26JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ64djwAKCRB33NvayMhJ0Q0WD/
 4qd13mpilaLgIGAOQgbLY3IKdNqPNm5kMS18FEVqOC1wxxdtMXcWQ2TV916MPWxwLWyZ0V+Ogkc7Vm
 wj7AE90w09sWjRWMNFJAaevlVjzFtRj7tg8tLEH2WaojWU91xJZZZxhDjnNImc44IiO4fn0OftaVmo
 2J3PnvAEDJpeDqfcDgBr3MWEm9wHjT/kGPjr6Ahi6f7dKqnFqMKAVBAmXEUx82IxzCaJDdnAoxZAlI
 Dx3TVYX5ofK3S3RyvhvJ9Wj8GwF+I8Apc14DU9RQZyBrtw+1Do6t598lCEFkf5UKGoc2WKNknHRoMS
 VmpNK1g+E9t32NnlryQo/qdHVcNuvEw35dcQe9Xhk2J0gYSiJO1ERiD5D6iCZAoFjwWiqw0JV/QlWk
 ENCrWpIIx3f+xkO2O48CRatyzt/5LHDLM9sprI3wfkgo1IdVeOmjDUzqdgQ6l8P/q8pF6out0DEETR
 apeKJV3LdWurx4UNkET5DYpweh4Gqo4tQLcKHrka/6Nw7/TPoVVTfk19sUnvOgA9GS7U+mkdsT+fqo
 xtRoN+LAo3ESej07wlqYf9wx+qprBUirXwTFlTC3QSOMU3aqiQrC8h5LaoAeYjRswn/7dSfjD+Xclh
 AEW9bbl3X2yhN+fPBK0yTONibKBvxtZ7jAeopKOWiGtzNr7J8t17swEwq47Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The mdp1-mem is not supported on the SM8550 SoCs, and having maxItems=2
makes the bindings not clear if mdp0-mem/mdp1-mem or mdp0-mem/cpu-cfg is
required, so explicitly document the mdp0-mem/cpu-cfg interconnect and
add the cpu-cfg path in the example.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml  | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml
index 1ea50a2c7c8e9f420125ad30a80b4ebd05c9367a..59192c59ddb9c126ada43ada1430fa7569651f99 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml
@@ -30,10 +30,14 @@ properties:
     maxItems: 1
 
   interconnects:
-    maxItems: 2
+    items:
+      - description: Interconnect path from mdp0 port to the data bus
+      - description: Interconnect path from CPU to the reg bus
 
   interconnect-names:
-    maxItems: 2
+    items:
+      - const: mdp0-mem
+      - const: cpu-cfg
 
 patternProperties:
   "^display-controller@[0-9a-f]+$":
@@ -91,9 +95,9 @@ examples:
         reg = <0x0ae00000 0x1000>;
         reg-names = "mdss";
 
-        interconnects = <&mmss_noc MASTER_MDP 0 &gem_noc SLAVE_LLCC 0>,
-                        <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
-        interconnect-names = "mdp0-mem", "mdp1-mem";
+        interconnects = <&mmss_noc MASTER_MDP 0 &mc_virt SLAVE_EBI1 0>,
+                        <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_DISPLAY_CFG 0>;
+        interconnect-names = "mdp0-mem", "cpu-cfg";
 
         resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
 

-- 
2.34.1


