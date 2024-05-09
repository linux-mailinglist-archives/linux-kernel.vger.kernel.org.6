Return-Path: <linux-kernel+bounces-174369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6482D8C0DBE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C11D283C2E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAC014B07E;
	Thu,  9 May 2024 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o2rgk2Uh"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97ED14BF99
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715247790; cv=none; b=kRyZ9T78K22DGrBj3YVssyTLDEnvRyo1u58Dpdi6EfiUeMCpFSwnvg4ThzFZyIxsIIPpc0ctouKIZH40fUj/Va18kLNky+9dD6jH3PV1rdO8bnYn8vXCD7k+k/SP05tKN9jgTd7fbcktU3nf2DhGhs4OdYqLDQpuS0jEr8yXxWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715247790; c=relaxed/simple;
	bh=rOLbOtL0j3fNcLa8dh2gYUaC17oslauXhmS2cwt0xyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RsMmFnpOhe8L6psihBL3ACsA8ta/LkLSICKhmEHcLA0xk7oz+6bdYRcfLr1nWf+Qc2UY1j748KnHb8QWj+/NZpaiuwfLuuwah0mxQ9Qt3euopFwb1kCmKtzISf+kXOw2En5IuOeb6RW4pTTPuxcOzx+1F0vR9h9AXjXN4keYDIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o2rgk2Uh; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59cf0bda27so81399266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 02:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715247785; x=1715852585; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pIcB8ROOeGsI+9a23MiY0tgY4NZqQ6nSRKRofkAzR9M=;
        b=o2rgk2Uh8VIQykmb3RsvJ0U8o4E5bzhsao1O3bU2gruXWBz7kERiVKAhdaHgoXjTNz
         fR3JCaA2Orl9jf6TkSzuPIN8TsEcmmXqWO5MSQXiT8L9QQauurl651VAu0Fqf0qZF4b/
         GdgZdf6gcaQPgqRfF8TKo8RpcV13TOAPslgeDHMowaodZ2hVYnPgqecT11U/dOvcN6EQ
         0OxalKOHU+XlrwLDG7wh8rsesp1da8/oi2g+Qtxq7qv1HB2YbROJ+o2n/iUTQx4OHFfB
         m8W3Flas/LJl2HF6PLrfeS+0jcw0LulIoHsgfwU8uiOgpSL9FWKGPtl+stVpDngJKEXz
         VsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715247785; x=1715852585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIcB8ROOeGsI+9a23MiY0tgY4NZqQ6nSRKRofkAzR9M=;
        b=hjEGe2cMiH+emF61g1z30hv8MgRtbqXc2Fq6cjtdKX422wVzAVKxdJYAItuQ+HQA3+
         0uw8g6zcUnl54HttbgXdM3HchhYiOe9LfeLQ3telL0mBcpQ2uMIg5HELG4ecX54VpH7m
         ZlrD8kO2mPn8eOW/5ndwQgDl+zllzfbxNLLWuIVPPh6sTKlkxZrLVFUw0DfW6AZuYuD8
         dTAwcv85CuDKNmLrUekEKCViFTzgDfRQ6X17LFNcAPic8JBDEhqlYniws8Z8GpBHJKBj
         q4DPO2fP0oHJGrT7xP++T7mCu1aJUoCERkpA1UGaWmN1nsPsWleYH+2/LHJev1SgZAaJ
         EWSw==
X-Forwarded-Encrypted: i=1; AJvYcCXmAH4n8x8He4G8gjHO64p5+rG10FzuqrjCZXueXn+McKfxxsUWr/4Es1YQZgYBHwOh6WXT5K7cQf5PflXfCHKe+j1heexZXbiHllFQ
X-Gm-Message-State: AOJu0Yx22ekYaf/xMaFTPX1hhmcTv6IjfR2yOEN/WG5KrxNeK7lkDJB8
	OLCDxc9qAgMsxdutqYFzyeGCjJmvO7pRwnaIWkAKpVtyz0Fb9tN2bKrxG6xtBrU=
X-Google-Smtp-Source: AGHT+IEj7t3+XC3p/y5HUrmHjznjQccsuXesrh9U3xAGRKJa6dtg16GiFZW3I2JYdHBt5A2w9dgQzA==
X-Received: by 2002:a50:d7c6:0:b0:572:20cb:475d with SMTP id 4fb4d7f45d1cf-5731d99b894mr4403673a12.7.1715247785050;
        Thu, 09 May 2024 02:43:05 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7deasm53835666b.103.2024.05.09.02.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 02:43:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 09 May 2024 11:42:53 +0200
Subject: [PATCH 3/3] dt-bindings: display: panel: constrain 'reg' in DSI
 panels
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-dt-bindings-dsi-panel-reg-v1-3-8b2443705be0@linaro.org>
References: <20240509-dt-bindings-dsi-panel-reg-v1-0-8b2443705be0@linaro.org>
In-Reply-To: <20240509-dt-bindings-dsi-panel-reg-v1-0-8b2443705be0@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Konrad Dybcio <konradybcio@gmail.com>, 
 Del Regno <angelogioacchino.delregno@somainline.org>, 
 Heiko Stuebner <heiko@sntech.de>, Luca Weiss <luca.weiss@fairphone.com>, 
 Dmitry Baryskov <dmitry.baryshkov@linaro.org>, 
 Shawn Guo <shawn.guo@linaro.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=28776;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=rOLbOtL0j3fNcLa8dh2gYUaC17oslauXhmS2cwt0xyo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmPJqfMq2rxH8MbJMO+pJIFS2UwYRcFPBjOXCh6
 zTq0j0WOy6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZjyanwAKCRDBN2bmhouD
 1zscD/9iTxBJ7hpaqworNyui9zWgBJKjw44Ldh7JBegFQwDSNyfcF7MJ/g5Z6+cV3ZSoQUfcrHi
 2sNSfMnqNMjqK0IKwB+gre++PBjyhnFA7XDDn5AiKSgRVyZIKgduxv+th4P3jbQksG3aUzZQ9g7
 XMoLsov2yJcvgHmzckuhyeHR4I9lZa3bgc8Yed+LdNsoNJk+msKO6t4qcgPS17yFX6g8ASAeirH
 tG3fRR9OiEL+9aOdXNWRdCvJUGEls2utQTA+Lat1QAwEEXoQ1Mv8rGL7nSKIIT8oPQ1ldAVnKV4
 s9yC2wxMunVsK4K+NN6MGI8ZNSGSkgnqk9VWo52vndXkPYR5ZM4gP+2Yv8piqdnqprt6G3eUPxm
 zMHIcUNtrPhRKJVrPVjFrWSpQ4fvCYZQfnWhB8V/ICat2x3aiarDDHoACISquwOoxkOYvK5d6Po
 39eVxkC/SfaQCxOyO/Sa4d4UKwicQbs8VUCpdT7JK7O2SIR1kthxqaErJqwZdH/DaGIyrS7Oo9S
 zTpYdNIPZImnsH2gTHEYzU1P56hV1r9U9FthRqIbznkr0l6ENNkOC7f7VZ56z/syHBBPm3IFxl3
 rlE+GyG/ysajD5vjP6T/NgWCzLnwAb7eYRy2wbNeKQ4+wERRLoeWKYHtt9L9knldRHljHoFktVI
 6ETAqtf0uTWRh9g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

DSI-attached devices could respond to more than one virtual channel
number, thus their bindings are supposed to constrain the 'reg' property
to match hardware.  Add missing 'reg' constrain for DSI-attached display
panels, based on DTS sources in Linux kernel (assume all devices take
only one channel number).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/display/panel/asus,z00t-tm5p5-nt35596.yaml  | 5 ++++-
 .../devicetree/bindings/display/panel/boe,bf060y8m-aj0.yaml         | 4 +++-
 Documentation/devicetree/bindings/display/panel/boe,himax8279d.yaml | 4 +++-
 .../devicetree/bindings/display/panel/boe,th101mb31ig002-28a.yaml   | 4 +++-
 .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml         | 2 +-
 Documentation/devicetree/bindings/display/panel/elida,kd35t133.yaml | 5 ++++-
 .../devicetree/bindings/display/panel/feixin,k101-im2ba02.yaml      | 5 ++++-
 Documentation/devicetree/bindings/display/panel/himax,hx83112a.yaml | 4 +++-
 Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml   | 3 ++-
 Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml | 4 +++-
 .../devicetree/bindings/display/panel/ilitek,ili9881c.yaml          | 4 +++-
 .../devicetree/bindings/display/panel/innolux,p097pfg.yaml          | 4 +++-
 .../devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml       | 3 ++-
 .../devicetree/bindings/display/panel/jdi,lpm102a188a.yaml          | 4 +++-
 .../devicetree/bindings/display/panel/jdi,lt070me05000.yaml         | 4 +++-
 .../devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml     | 5 ++++-
 .../devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml     | 5 ++++-
 Documentation/devicetree/bindings/display/panel/lg,sw43408.yaml     | 4 +++-
 .../devicetree/bindings/display/panel/newvision,nv3051d.yaml        | 4 +++-
 .../devicetree/bindings/display/panel/novatek,nt35510.yaml          | 5 ++++-
 .../devicetree/bindings/display/panel/novatek,nt35950.yaml          | 4 +++-
 .../devicetree/bindings/display/panel/novatek,nt36523.yaml          | 4 +++-
 .../devicetree/bindings/display/panel/novatek,nt36672a.yaml         | 4 +++-
 .../devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml     | 4 +++-
 .../devicetree/bindings/display/panel/raydium,rm67191.yaml          | 4 +++-
 .../devicetree/bindings/display/panel/raydium,rm692e5.yaml          | 4 +++-
 .../devicetree/bindings/display/panel/raydium,rm69380.yaml          | 5 +++--
 Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml | 2 +-
 .../devicetree/bindings/display/panel/samsung,amoled-mipi-dsi.yaml  | 4 +++-
 .../devicetree/bindings/display/panel/samsung,s6d16d0.yaml          | 4 +++-
 .../devicetree/bindings/display/panel/samsung,s6d7aa0.yaml          | 3 ++-
 .../bindings/display/panel/samsung,s6e88a0-ams452ef01.yaml          | 5 ++++-
 .../devicetree/bindings/display/panel/samsung,s6e8aa0.yaml          | 4 +++-
 .../devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml        | 4 +++-
 .../devicetree/bindings/display/panel/sharp,ls043t1le01.yaml        | 4 +++-
 .../devicetree/bindings/display/panel/sharp,ls060t1sx01.yaml        | 4 +++-
 Documentation/devicetree/bindings/display/panel/sony,acx424akp.yaml | 5 ++++-
 .../devicetree/bindings/display/panel/sony,td4353-jdi.yaml          | 3 ++-
 .../devicetree/bindings/display/panel/sony,tulip-truly-nt35521.yaml | 3 ++-
 .../devicetree/bindings/display/panel/synaptics,r63353.yaml         | 6 ++++--
 .../devicetree/bindings/display/panel/visionox,rm69299.yaml         | 3 ++-
 .../devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml       | 5 ++++-
 42 files changed, 126 insertions(+), 44 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/asus,z00t-tm5p5-nt35596.yaml b/Documentation/devicetree/bindings/display/panel/asus,z00t-tm5p5-nt35596.yaml
index 75a09df68ba0..2399cabf044c 100644
--- a/Documentation/devicetree/bindings/display/panel/asus,z00t-tm5p5-nt35596.yaml
+++ b/Documentation/devicetree/bindings/display/panel/asus,z00t-tm5p5-nt35596.yaml
@@ -21,7 +21,10 @@ allOf:
 properties:
   compatible:
     const: asus,z00t-tm5p5-n35596
-  reg: true
+
+  reg:
+    maxItems: 1
+
   reset-gpios: true
   vdd-supply:
     description: core voltage supply
diff --git a/Documentation/devicetree/bindings/display/panel/boe,bf060y8m-aj0.yaml b/Documentation/devicetree/bindings/display/panel/boe,bf060y8m-aj0.yaml
index a8f3afa922c8..8b7448ad9138 100644
--- a/Documentation/devicetree/bindings/display/panel/boe,bf060y8m-aj0.yaml
+++ b/Documentation/devicetree/bindings/display/panel/boe,bf060y8m-aj0.yaml
@@ -26,6 +26,9 @@ properties:
   compatible:
     const: boe,bf060y8m-aj0
 
+  reg:
+    maxItems: 1
+
   elvdd-supply:
     description: EL Driving positive (VDD) supply (4.40-4.80V)
   elvss-supply:
@@ -38,7 +41,6 @@ properties:
     description: I/O voltage supply (1.62-1.98V)
 
   port: true
-  reg: true
   reset-gpios: true
 
 required:
diff --git a/Documentation/devicetree/bindings/display/panel/boe,himax8279d.yaml b/Documentation/devicetree/bindings/display/panel/boe,himax8279d.yaml
index 272a3a018a33..f2496cdd9260 100644
--- a/Documentation/devicetree/bindings/display/panel/boe,himax8279d.yaml
+++ b/Documentation/devicetree/bindings/display/panel/boe,himax8279d.yaml
@@ -18,9 +18,11 @@ properties:
       - const: boe,himax8279d8p
       - const: boe,himax8279d10p
 
+  reg:
+    maxItems: 1
+
   backlight: true
   enable-gpios: true
-  reg: true
 
   pp33-gpios:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/panel/boe,th101mb31ig002-28a.yaml b/Documentation/devicetree/bindings/display/panel/boe,th101mb31ig002-28a.yaml
index 32df26cbfeed..5eaccce13c21 100644
--- a/Documentation/devicetree/bindings/display/panel/boe,th101mb31ig002-28a.yaml
+++ b/Documentation/devicetree/bindings/display/panel/boe,th101mb31ig002-28a.yaml
@@ -18,7 +18,9 @@ properties:
         # BOE TH101MB31IG002-28A 10.1" WXGA TFT LCD panel
       - boe,th101mb31ig002-28a
 
-  reg: true
+  reg:
+    maxItems: 1
+
   backlight: true
   enable-gpios: true
   power-supply: true
diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
index 906ef62709b8..9e603cad1348 100644
--- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
+++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
@@ -38,7 +38,7 @@ properties:
       - starry,ili9882t
 
   reg:
-    description: the virtual channel number of a DSI peripheral
+    maxItems: 1
 
   enable-gpios:
     description: a GPIO spec for the enable pin
diff --git a/Documentation/devicetree/bindings/display/panel/elida,kd35t133.yaml b/Documentation/devicetree/bindings/display/panel/elida,kd35t133.yaml
index 265ab6d30572..f4cb825d1e96 100644
--- a/Documentation/devicetree/bindings/display/panel/elida,kd35t133.yaml
+++ b/Documentation/devicetree/bindings/display/panel/elida,kd35t133.yaml
@@ -15,7 +15,10 @@ allOf:
 properties:
   compatible:
     const: elida,kd35t133
-  reg: true
+
+  reg:
+    maxItems: 1
+
   backlight: true
   port: true
   reset-gpios: true
diff --git a/Documentation/devicetree/bindings/display/panel/feixin,k101-im2ba02.yaml b/Documentation/devicetree/bindings/display/panel/feixin,k101-im2ba02.yaml
index 81adb82f061d..0d8707a5844d 100644
--- a/Documentation/devicetree/bindings/display/panel/feixin,k101-im2ba02.yaml
+++ b/Documentation/devicetree/bindings/display/panel/feixin,k101-im2ba02.yaml
@@ -15,7 +15,10 @@ allOf:
 properties:
   compatible:
     const: feixin,k101-im2ba02
-  reg: true
+
+  reg:
+    maxItems: 1
+
   backlight: true
   reset-gpios: true
   avdd-supply:
diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83112a.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83112a.yaml
index 174661d13811..56bcd152f43c 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx83112a.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx83112a.yaml
@@ -21,6 +21,9 @@ properties:
     contains:
       const: djn,9a-3r063-1102b
 
+  reg:
+    maxItems: 1
+
   vdd1-supply:
     description: Digital voltage rail
 
@@ -30,7 +33,6 @@ properties:
   vsp-supply:
     description: Negative source voltage rail
 
-  reg: true
   port: true
 
 required:
diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
index 916bb7f94206..644387e4fb6f 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx8394.yaml
@@ -26,7 +26,8 @@ properties:
           - powkiddy,x55-panel
       - const: himax,hx8394
 
-  reg: true
+  reg:
+    maxItems: 1
 
   reset-gpios: true
 
diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml
index f4f91f93f490..ff67129c9466 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml
@@ -20,9 +20,11 @@ properties:
           - tianma,tm041xdhg01
       - const: ilitek,ili9805
 
+  reg:
+    maxItems: 1
+
   avdd-supply: true
   dvdd-supply: true
-  reg: true
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
index a015dce72f60..baf5dfe5f5eb 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
@@ -24,9 +24,11 @@ properties:
           - wanchanglong,w552946aba
       - const: ilitek,ili9881c
 
+  reg:
+    maxItems: 1
+
   backlight: true
   power-supply: true
-  reg: true
   reset-gpios: true
   rotation: true
 
diff --git a/Documentation/devicetree/bindings/display/panel/innolux,p097pfg.yaml b/Documentation/devicetree/bindings/display/panel/innolux,p097pfg.yaml
index 5a5f071627fb..4164e3f7061d 100644
--- a/Documentation/devicetree/bindings/display/panel/innolux,p097pfg.yaml
+++ b/Documentation/devicetree/bindings/display/panel/innolux,p097pfg.yaml
@@ -16,9 +16,11 @@ properties:
   compatible:
     const: innolux,p097pfg
 
+  reg:
+    maxItems: 1
+
   backlight: true
   enable-gpios: true
-  reg: true
 
   avdd-supply:
     description: The regulator that provides positive voltage
diff --git a/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml b/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
index 41eb7fbf7715..20afdb4568a2 100644
--- a/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
+++ b/Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
@@ -21,7 +21,8 @@ properties:
           - radxa,display-8hd-ad002
       - const: jadard,jd9365da-h3
 
-  reg: true
+  reg:
+    maxItems: 1
 
   vdd-supply:
     description: supply regulator for VDD, usually 3.3V
diff --git a/Documentation/devicetree/bindings/display/panel/jdi,lpm102a188a.yaml b/Documentation/devicetree/bindings/display/panel/jdi,lpm102a188a.yaml
index 2f4d27a309a7..a8621459005b 100644
--- a/Documentation/devicetree/bindings/display/panel/jdi,lpm102a188a.yaml
+++ b/Documentation/devicetree/bindings/display/panel/jdi,lpm102a188a.yaml
@@ -26,7 +26,9 @@ properties:
   compatible:
     const: jdi,lpm102a188a
 
-  reg: true
+  reg:
+    maxItems: 1
+
   enable-gpios: true
   reset-gpios: true
   power-supply: true
diff --git a/Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.yaml b/Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.yaml
index 63c82a4378ff..0c8b5cb78bfe 100644
--- a/Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.yaml
+++ b/Documentation/devicetree/bindings/display/panel/jdi,lt070me05000.yaml
@@ -16,8 +16,10 @@ properties:
   compatible:
     const: jdi,lt070me05000
 
+  reg:
+    maxItems: 1
+
   enable-gpios: true
-  reg: true
   reset-gpios: true
 
   vddp-supply:
diff --git a/Documentation/devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml b/Documentation/devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml
index a40ab887ada7..e2a2dd4ef5fa 100644
--- a/Documentation/devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml
+++ b/Documentation/devicetree/bindings/display/panel/leadtek,ltk050h3146w.yaml
@@ -18,7 +18,10 @@ properties:
       - leadtek,ltk050h3146w
       - leadtek,ltk050h3146w-a2
       - leadtek,ltk050h3148w
-  reg: true
+
+  reg:
+    maxItems: 1
+
   backlight: true
   reset-gpios: true
   iovcc-supply:
diff --git a/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml b/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml
index d589f1677214..af9e0ea0e72f 100644
--- a/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml
+++ b/Documentation/devicetree/bindings/display/panel/leadtek,ltk500hd1829.yaml
@@ -17,7 +17,10 @@ properties:
     enum:
       - leadtek,ltk101b4029w
       - leadtek,ltk500hd1829
-  reg: true
+
+  reg:
+    maxItems: 1
+
   backlight: true
   reset-gpios: true
   iovcc-supply:
diff --git a/Documentation/devicetree/bindings/display/panel/lg,sw43408.yaml b/Documentation/devicetree/bindings/display/panel/lg,sw43408.yaml
index 1e08648f5bc7..bbaaa783d184 100644
--- a/Documentation/devicetree/bindings/display/panel/lg,sw43408.yaml
+++ b/Documentation/devicetree/bindings/display/panel/lg,sw43408.yaml
@@ -21,7 +21,9 @@ properties:
     items:
       - const: lg,sw43408
 
-  reg: true
+  reg:
+    maxItems: 1
+
   port: true
   vddi-supply: true
   vpnl-supply: true
diff --git a/Documentation/devicetree/bindings/display/panel/newvision,nv3051d.yaml b/Documentation/devicetree/bindings/display/panel/newvision,nv3051d.yaml
index 7a634fbc465e..d3a25a8fd7e3 100644
--- a/Documentation/devicetree/bindings/display/panel/newvision,nv3051d.yaml
+++ b/Documentation/devicetree/bindings/display/panel/newvision,nv3051d.yaml
@@ -24,7 +24,9 @@ properties:
           - powkiddy,rk2023-panel
       - const: newvision,nv3051d
 
-  reg: true
+  reg:
+    maxItems: 1
+
   backlight: true
   port: true
   reset-gpios:
diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
index 91921f4b0e5f..bb50fd5506c3 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
@@ -24,7 +24,10 @@ properties:
       string determines how the NT35510 panel driver shall be configured
       to work with the indicated panel. The novatek,nt35510 compatible shall
       always be provided as a fallback.
-  reg: true
+
+  reg:
+    maxItems: 1
+
   reset-gpios: true
   vdd-supply:
     description: regulator that supplies the vdd voltage
diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt35950.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt35950.yaml
index 7cac93b20944..a9e40493986b 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt35950.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt35950.yaml
@@ -33,6 +33,9 @@ properties:
       to work with the indicated panel. The novatek,nt35950 compatible shall
       always be provided as a fallback.
 
+  reg:
+    maxItems: 1
+
   reset-gpios:
     maxItems: 1
     description: phandle of gpio for reset line - This should be 8mA, gpio
@@ -49,7 +52,6 @@ properties:
 
   backlight: true
   ports: true
-  reg: true
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
index bbeea8cfa5fb..c4bae4f77085 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
@@ -27,6 +27,9 @@ properties:
               - lenovo,j606f-boe-nt36523w
           - const: novatek,nt36523w
 
+  reg:
+    maxItems: 1
+
   reset-gpios:
     maxItems: 1
     description: phandle of gpio for reset line - This should be 8mA
@@ -34,7 +37,6 @@ properties:
   vddio-supply:
     description: regulator that supplies the I/O voltage
 
-  reg: true
   rotation: true
   backlight: true
 
diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
index ae821f465e1c..800a2f0a4dad 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
@@ -29,6 +29,9 @@ properties:
       determines how the NT36672A panel driver is configured for the indicated
       panel. The novatek,nt36672a compatible shall always be provided as a fallback.
 
+  reg:
+    maxItems: 1
+
   reset-gpios:
     maxItems: 1
     description: phandle of gpio for reset line - This should be 8mA, gpio
@@ -44,7 +47,6 @@ properties:
   vddneg-supply:
     description: phandle of the negative boost supply regulator
 
-  reg: true
   port: true
   backlight: true
 
diff --git a/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml b/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml
index 72463795e4c6..e5d8785fdf90 100644
--- a/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml
+++ b/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml
@@ -38,10 +38,12 @@ properties:
   compatible:
     const: olimex,lcd-olinuxino
 
+  reg:
+    maxItems: 1
+
   backlight: true
   enable-gpios: true
   power-supply: true
-  reg: true
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml
index d62fd692bf10..4825792bf712 100644
--- a/Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml
+++ b/Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml
@@ -16,7 +16,9 @@ properties:
   compatible:
     const: raydium,rm67191
 
-  reg: true
+  reg:
+    maxItems: 1
+
   port: true
   reset-gpios: true
   width-mm: true
diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm692e5.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm692e5.yaml
index f436ba6738ca..7ad223f98253 100644
--- a/Documentation/devicetree/bindings/display/panel/raydium,rm692e5.yaml
+++ b/Documentation/devicetree/bindings/display/panel/raydium,rm692e5.yaml
@@ -22,6 +22,9 @@ properties:
       - const: fairphone,fp5-rm692e5-boe
       - const: raydium,rm692e5
 
+  reg:
+    maxItems: 1
+
   dvdd-supply:
     description: Digital voltage rail
 
@@ -31,7 +34,6 @@ properties:
   vddio-supply:
     description: I/O voltage rail
 
-  reg: true
   port: true
 
 required:
diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm69380.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm69380.yaml
index b17765b2b351..ec445ff5631c 100644
--- a/Documentation/devicetree/bindings/display/panel/raydium,rm69380.yaml
+++ b/Documentation/devicetree/bindings/display/panel/raydium,rm69380.yaml
@@ -28,6 +28,9 @@ properties:
       to work with the indicated panel. The raydium,rm69380 compatible shall
       always be provided as a fallback.
 
+  reg:
+    maxItems: 1
+
   avdd-supply:
     description: Analog voltage rail
 
@@ -38,8 +41,6 @@ properties:
     maxItems: 1
     description: phandle of gpio for reset line - This should be active low
 
-  reg: true
-
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml b/Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml
index 95ce22c6787a..04f86e0cbac9 100644
--- a/Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml
@@ -14,7 +14,7 @@ properties:
     const: ronbo,rb070d30
 
   reg:
-    description: MIPI-DSI virtual channel
+    maxItems: 1
 
   power-gpios:
     description: GPIO used for the power pin
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,amoled-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/panel/samsung,amoled-mipi-dsi.yaml
index ccc482570d6a..e8f9e9d06a29 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,amoled-mipi-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,amoled-mipi-dsi.yaml
@@ -33,7 +33,9 @@ properties:
         # Samsung S6E3HF2 5.65" 1600x2560 AMOLED panel
       - samsung,s6e3hf2
 
-  reg: true
+  reg:
+    maxItems: 1
+
   reset-gpios: true
   enable-gpios: true
   te-gpios: true
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6d16d0.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6d16d0.yaml
index 66d147496bc3..2af5bc47323f 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6d16d0.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6d16d0.yaml
@@ -16,8 +16,10 @@ properties:
   compatible:
     const: samsung,s6d16d0
 
+  reg:
+    maxItems: 1
+
   port: true
-  reg: true
   reset-gpios: true
 
   vdd1-supply:
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
index 45a236d2cc70..939da65114bf 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
@@ -24,7 +24,8 @@ properties:
           - samsung,ltl101at01
       - const: samsung,s6d7aa0
 
-  reg: true
+  reg:
+    maxItems: 1
 
   backlight:
     description:
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e88a0-ams452ef01.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e88a0-ams452ef01.yaml
index b749e9e906b7..42634fc3b5b2 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6e88a0-ams452ef01.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e88a0-ams452ef01.yaml
@@ -15,7 +15,10 @@ allOf:
 properties:
   compatible:
     const: samsung,s6e88a0-ams452ef01
-  reg: true
+
+  reg:
+    maxItems: 1
+
   port: true
   reset-gpios: true
   vdd3-supply:
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.yaml
index 200fbf1c74a0..4601fa460680 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.yaml
@@ -16,7 +16,9 @@ properties:
   compatible:
     const: samsung,s6e8aa0
 
-  reg: true
+  reg:
+    maxItems: 1
+
   reset-gpios: true
   display-timings: true
 
diff --git a/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml b/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml
index 57b44a0e763d..ce820b96a7e2 100644
--- a/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sharp,lq101r1sx01.yaml
@@ -37,7 +37,9 @@ properties:
       - enum:
           - sharp,lq101r1sx01
 
-  reg: true
+  reg:
+    maxItems: 1
+
   power-supply: true
   backlight: true
 
diff --git a/Documentation/devicetree/bindings/display/panel/sharp,ls043t1le01.yaml b/Documentation/devicetree/bindings/display/panel/sharp,ls043t1le01.yaml
index a90d0d8bf7c9..b6ea246430ce 100644
--- a/Documentation/devicetree/bindings/display/panel/sharp,ls043t1le01.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sharp,ls043t1le01.yaml
@@ -16,7 +16,9 @@ properties:
   compatible:
     const: sharp,ls043t1le01-qhd
 
-  reg: true
+  reg:
+    maxItems: 1
+
   backlight: true
   reset-gpios: true
   port: true
diff --git a/Documentation/devicetree/bindings/display/panel/sharp,ls060t1sx01.yaml b/Documentation/devicetree/bindings/display/panel/sharp,ls060t1sx01.yaml
index 271c097cc9a4..77a4fce129e7 100644
--- a/Documentation/devicetree/bindings/display/panel/sharp,ls060t1sx01.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sharp,ls060t1sx01.yaml
@@ -16,7 +16,9 @@ properties:
   compatible:
     const: sharp,ls060t1sx01
 
-  reg: true
+  reg:
+    maxItems: 1
+
   backlight: true
   reset-gpios: true
   port: true
diff --git a/Documentation/devicetree/bindings/display/panel/sony,acx424akp.yaml b/Documentation/devicetree/bindings/display/panel/sony,acx424akp.yaml
index 059cc6dbcfca..fd778a20f760 100644
--- a/Documentation/devicetree/bindings/display/panel/sony,acx424akp.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sony,acx424akp.yaml
@@ -22,7 +22,10 @@ properties:
     enum:
       - sony,acx424akp
       - sony,acx424akm
-  reg: true
+
+  reg:
+    maxItems: 1
+
   reset-gpios: true
   vddi-supply:
     description: regulator that supplies the vddi voltage
diff --git a/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml b/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml
index 07bce556ad40..191b692125e1 100644
--- a/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sony,td4353-jdi.yaml
@@ -20,7 +20,8 @@ properties:
   compatible:
     const: sony,td4353-jdi-tama
 
-  reg: true
+  reg:
+    maxItems: 1
 
   backlight: true
   width-mm: true
diff --git a/Documentation/devicetree/bindings/display/panel/sony,tulip-truly-nt35521.yaml b/Documentation/devicetree/bindings/display/panel/sony,tulip-truly-nt35521.yaml
index 967972939598..a58a31349757 100644
--- a/Documentation/devicetree/bindings/display/panel/sony,tulip-truly-nt35521.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sony,tulip-truly-nt35521.yaml
@@ -21,7 +21,8 @@ properties:
   compatible:
     const: sony,tulip-truly-nt35521
 
-  reg: true
+  reg:
+    maxItems: 1
 
   positive5-supply:
     description: Positive 5V supply
diff --git a/Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml b/Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml
index e5617d125567..2fd6e0ec3682 100644
--- a/Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml
+++ b/Documentation/devicetree/bindings/display/panel/synaptics,r63353.yaml
@@ -19,15 +19,17 @@ properties:
           - sharp,ls068b3sx02
       - const: syna,r63353
 
+  reg:
+    maxItems: 1
+
   avdd-supply: true
   dvdd-supply: true
-  reg: true
 
 required:
   - compatible
+  - reg
   - avdd-supply
   - dvdd-supply
-  - reg
   - reset-gpios
   - port
   - backlight
diff --git a/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml b/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml
index 772399067515..30047a62fc11 100644
--- a/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml
+++ b/Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml
@@ -20,7 +20,8 @@ properties:
   compatible:
     const: visionox,rm69299-1080p-display
 
-  reg: true
+  reg:
+    maxItems: 1
 
   vdda-supply:
     description: |
diff --git a/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml b/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
index c407deb6afb1..9c9743a23500 100644
--- a/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
+++ b/Documentation/devicetree/bindings/display/panel/xinpeng,xpp055c272.yaml
@@ -15,7 +15,10 @@ allOf:
 properties:
   compatible:
     const: xinpeng,xpp055c272
-  reg: true
+
+  reg:
+    maxItems: 1
+
   backlight: true
   port: true
   reset-gpios: true

-- 
2.43.0


