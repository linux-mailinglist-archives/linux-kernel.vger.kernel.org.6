Return-Path: <linux-kernel+bounces-535444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5469DA47308
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 03:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1A318879C0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298101B85D1;
	Thu, 27 Feb 2025 02:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fe0Iwat8"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D011B4227
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740623120; cv=none; b=sorjNdbFujEsj6PdD/abrdOMlPHKTB7UIpUWUvE6MdwDmwnOz7SF+JYvyNfXZ1XKl5MCQQ51RkAYSMiAhPyn6gNOtmYcufOoGxhNJj/7a936QBNpB0DHZekpj0P/e30SV1rUCHo76WrRAVaV5a36wBLQYqf+CmsBGmlM+oLa6ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740623120; c=relaxed/simple;
	bh=nAUeCQaacPy4eDcat81zyQ4FPPYgERyNRUqIhBqqdZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S5sm2po+ot/GE8x4q67kttvZ8Yl9qLm4lBGnlOEznr2XXFXET0azWh0ycDP16LMQTKu12zktqIAcd5FnTHUYLeqKVjUNInnB77jT7j/GZHEkmaX/LB0a2Hku//TAwPMyB6kmLBrjGsHkaJ68FzqeRYf0erjzq8Ox30FHb+BfKeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fe0Iwat8; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30a303a656aso5140261fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740623117; x=1741227917; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q5U2PqqsAittXp536ew/SvCsut9jyzjmr2ENiR9whTM=;
        b=fe0Iwat8PSyTJHnfernuyaXQg+VzMR7fYt+dawgcoy8UrssofBvXn3qZDXII07mBzI
         Zrpaoep+biBhvgySYGOAoSEII+aIw2GOVC1xwAh0/9x+HHvXz1yj2t3fyYyIxW7+zR9M
         /BPe12JT6sPoCENA5boLHHEJEDE1Sew02uHyyC+lsB6N1+j1ssPfQRAhTLl+4tjFvUmI
         D9khVF7SOB/Ob9es4EPAyfTabH4iwOPbuPVFU0fgjMnQCpbR06MM2zfZze9Q3dtFQvBx
         Z0MbCvPKcODqr7DjpaSabiNN0YnyNb95vPjGnUWJUb2YXwZk9PmkcZkBn4qwIiF1bdwT
         Wvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740623117; x=1741227917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5U2PqqsAittXp536ew/SvCsut9jyzjmr2ENiR9whTM=;
        b=QTW/S9dbZg1XlSTToT35uJUbr4MK7RSurX49IuwXs/+vyYEuS/vidxLprNcJwnxokZ
         24tJJAu7zyBazt8WIrSYvA7XHI+GskTmgeRcl5cLet5O8yKFbstdE0q2zRCmqd/9v9up
         Bd9EppwdawBC89jwYaQL6U3L5uGvlUswm30aPQWr+ERLCCv+JHQApc54/ZDY3xM5aD61
         IQ95aLIiIABncq9IZcrMo43oDGVP/5JCQyW5biR9N59j2nfRhqFvV6GtnfHLIe47qt3N
         ouH1VB/8TMgtC51yQarLIm6U7jvTHkUitlTYWBxsfMlxfS2jtzaVLn+WmOM93v+o7US+
         BpwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiES0wcWRw1bX+TTJL3V+EmDPv6nn0XltuJBWwwXjb5dGLY0rX/YLfkpjW6/Kc/Gz60YikAFImEhWVuo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK44BQiHbXxIEMBCp/k4lG2B3D2gqUQSeX7MsMY04NaEla0Rmv
	sqsgkywonLceewmnMHQDuK8oo0xDGbd7t9/BvLEVqw9uhrMsvp4gRklNH19aeYA=
X-Gm-Gg: ASbGncsJ0zIWTzJPe23HhAqQD0HKj6AfuhBCb0pg7r0odE8+97g1Nen8XDXx3JsSdVu
	9zhBk2mHNe8oz7HHIx0RenplfM4WsGnpbjngbxteEKhf1NANzuMlFnGNNpTZHzRXLLD4S4EmLov
	Tc0Js1gvBRT7/pLcNGRrFpdwEdvouQ7EoHmitaBRvnZhNMpMI4Sqs5NxS2dQPX/7hhee3tFdxlv
	A0RTgEzSyXfcvXZ2HTXatiwk8uLQ+DrsheZN+D3y9Ivz60CfZH14pTl8vHyMlQqtQnuFMMUvdzs
	iqAtH7NZvN85fX7vLSNuqvKRPnBCn0Sq0g==
X-Google-Smtp-Source: AGHT+IGGp9KrMaDyRbIC/wTKqo5mY4JxnEPl4O+DeJ+ybSnTzA3m+DKpiJplqcNL8wwlCZUgExesLg==
X-Received: by 2002:a05:6512:2347:b0:545:27f0:7b6f with SMTP id 2adb3069b0e04-5483912fc82mr11153371e87.11.1740623116670;
        Wed, 26 Feb 2025 18:25:16 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549441742a0sm48067e87.5.2025.02.26.18.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 18:25:15 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 27 Feb 2025 04:25:09 +0200
Subject: [PATCH v3 1/7] dt-bindings: display: msm: mdp4: add LCDC clock and
 PLL source
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-fd-mdp4-lvds-v3-1-c983788987ae@linaro.org>
References: <20250227-fd-mdp4-lvds-v3-0-c983788987ae@linaro.org>
In-Reply-To: <20250227-fd-mdp4-lvds-v3-0-c983788987ae@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1289;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=nAUeCQaacPy4eDcat81zyQ4FPPYgERyNRUqIhBqqdZk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnv80G1AVXjPfLNQ8ur8MgA/B8hG0n9UdJwoFEA
 3JcymoX9+mJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7/NBgAKCRCLPIo+Aiko
 1UNWCAChp9UJAPMKWIwQHWroB0P5YvcwUfqq3siqgw9PBarSlLO0xCgLeBDo/2zRn2E+OHq7oxB
 EmRoXMsWHJwSDbHd8/uyWb66SkpVKZH+xtYPJyBTBj7it/qpWjOMK7EZM75sHAWwwTnGgaimA+a
 /cW/3uQeNEnukCV2+c6OzEV5W5tkVLvoMuvzzMcoraJPl4sTKCU5++fBGoSYx5ZgR+Wih7rOQ/C
 l8v7QSCRHn0omGtFc4ZyVSG/jdTn1bcAFVzUXf954MGo5XJwxeRwGPM4dTCFt4kD3iBzdMoSO1f
 Z+5iseXm/gQaIZ2W5cMZcQ5bKfMJYmBK4k8CM0b554psYjFr
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Add the LCDC / LVDS clock input and the XO used to drive internal LVDS
PLL to MDP4 controller bindings. The controller also provides LVDS PHY
PLL, so add optional #clock-cells to the device.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/mdp4.yaml | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/mdp4.yaml b/Documentation/devicetree/bindings/display/msm/mdp4.yaml
index 35204a2875795e2c1f7582c8fab227f8a9107ed9..03ee09faa335f332259b64a42eefa3ec199b8e03 100644
--- a/Documentation/devicetree/bindings/display/msm/mdp4.yaml
+++ b/Documentation/devicetree/bindings/display/msm/mdp4.yaml
@@ -18,9 +18,10 @@ properties:
 
   clocks:
     minItems: 6
-    maxItems: 6
+    maxItems: 8
 
   clock-names:
+    minItems: 6
     items:
       - const: core_clk
       - const: iface_clk
@@ -28,6 +29,12 @@ properties:
       - const: lut_clk
       - const: hdmi_clk
       - const: tv_clk
+      - const: lcdc_clk
+      - const: pxo
+        description: XO used to drive the internal LVDS PLL
+
+  '#clock-cells':
+    const: 0
 
   reg:
     maxItems: 1

-- 
2.39.5


