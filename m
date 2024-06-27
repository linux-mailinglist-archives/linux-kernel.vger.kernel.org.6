Return-Path: <linux-kernel+bounces-232130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777C591A3E4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC721C2152B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CC114A4D8;
	Thu, 27 Jun 2024 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A6buyNxD"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE3914884B
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484369; cv=none; b=o8tcstB6ukMFyFA0LFf6X5+c0rC8elolEqQO/GYWETUJbNTXiSGOPKUcnUGVKUQEm1AmFf4C48VgPDYM1VznU89GuPrpcuOzlOT/LdFpXyB1LF+JOKnzU0/G4+49fWv74dePN1fa4RbgEV1NeKJ4LupuWNBMRPfpj7uHnhVtZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484369; c=relaxed/simple;
	bh=8MLHDWyReLz5qqD7wVSiIOMBs4CdtSdIOqFJ3Bu/4Os=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WNb9lv/GVrIAEOkLptyfjsjb9/mCH8P+iUrbHUlfquAm14dmNGicziyrF9s4pWpIUu2oeYAK/v4ldJP0GHk45+X0pO9ZMqwCkeOzrlmXjt3DaFMoHJAhp0pnmZvqTCcncOu1QvlC5gP7cAi7QB4WsIah8O34jnM9QbUr++q5P9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A6buyNxD; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52cd717ec07so7241376e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 03:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719484366; x=1720089166; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+6/jw2l8WbHbxp3JGZOU8peyFUqkM87CC9BxxmyKfM=;
        b=A6buyNxDwjAQvzD7w1517mprbNIYiDd0lwueD7t+iIqrMZ4aO4pya7d7+NPSvsqMQf
         //0nWGzxASnKp/DrQISaVP18KVSlBWsgEGAtF8ef20SrfkNfuVS/OwoYI+fONIpAXAf2
         nuHsehw81N3qR0clSf6U9iz6gnqnHHoPJe2aBF5h+0jpM+MOHQ6Nddedv3IardmDnuOv
         Wk5GPgVoWZ79XQkcKRi1tzW3Fe9HzCZ5Yc8tGDM3n031jFHlG/dFbrAiN/PGCQWtaT/l
         tw+/pvqQmsmwsXnIhYAQIWmaGbZf9mUlMlgWORrNu9ntY/XzBw6mOaKjX7JsdG7iE0ek
         kh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719484366; x=1720089166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+6/jw2l8WbHbxp3JGZOU8peyFUqkM87CC9BxxmyKfM=;
        b=R9UfHuiu4p+dbEUvZzmgeOfE9bYrpXVvug7HWHTc/JqcGOv03JKWtiq9JhFyyYcxDu
         YIVtCuKxHBOZOpUcv/ZrZ8GU2Y0S3Zj++XKACn3TcCVPZVJRQiZ63MuetfyuKCGrx6dY
         9+riX1ameereqq0oisoYj2IH2UoBrICx9GqSj3iUvy/uPZe4xCx/pxDy8H04/H//gjnv
         Sy56cid3k2VsV2d+VJSmt9ySTmyyHkN+6DEQoO2awL4VET+PxiV4M5NOVkBkGZEdbD8i
         KMQ3dYAF6jjys4KLWcReHwmkzjSsV3ed2fnblgIHRWZE9KSXXSWeAE6VhLwsy2CfaFNO
         m3MA==
X-Forwarded-Encrypted: i=1; AJvYcCVsQ/Gvw4kcp50Yt0KoE/Mql/FVw9tjiZBkDueS8JOZ8vN05eJioj2W8/POrrUAu0HiQ5iLvTPwVgooapYlm2D3hKvjeOIADg7ndE+y
X-Gm-Message-State: AOJu0Yw9MI1pBu98HPvLK7WG8IuqBQdoWlD2L8aRXP/2gmz4dxmf6/wl
	nbM5O3Mw9MDUBHlPoBHE4PfYMcYF9XBsFbX7zaWvBGwhHRZN7Zd+pCsV2raaPoI=
X-Google-Smtp-Source: AGHT+IEoS3M9/3U4NjfBgJrciMQw7opzkhWp4q6gkv+HvLfxXQBP/1gIhzOQ1/YNBvMXx8utt1dJpw==
X-Received: by 2002:a05:6512:e95:b0:52c:8a3a:fe2c with SMTP id 2adb3069b0e04-52ce185d049mr9830460e87.45.1719484366212;
        Thu, 27 Jun 2024 03:32:46 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367435852afsm1384352f8f.53.2024.06.27.03.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:32:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 27 Jun 2024 12:32:21 +0200
Subject: [PATCH v4 5/7] dt-bindings: soc: ti: am654-serdes-ctrl: Move to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-dt-bindings-mfd-syscon-split-v4-5-dc6699a9f3e4@linaro.org>
References: <20240627-dt-bindings-mfd-syscon-split-v4-0-dc6699a9f3e4@linaro.org>
In-Reply-To: <20240627-dt-bindings-mfd-syscon-split-v4-0-dc6699a9f3e4@linaro.org>
To: Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Jacky Huang <ychuang3@nuvoton.com>, 
 Shan-Chun Hung <schung@nuvoton.com>, 
 Khuong Dinh <khuong@os.amperecomputing.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chuanhua Lei <lchuanhua@maxlinear.com>, 
 Rahul Tanwar <rtanwar@maxlinear.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 Nishanth Menon <nm@ti.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2452;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=8MLHDWyReLz5qqD7wVSiIOMBs4CdtSdIOqFJ3Bu/4Os=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmfT++cwdCKsMdwI34XqMjKV+VEq2ZPnBb8whmj
 V0GmiqiL/WJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZn0/vgAKCRDBN2bmhouD
 1xqZD/9sRU1DY0+8YUNfIxhuMHDSblSlLWagDywLBIZGUHc2JGkTM3ZDq8UMCH3TCob9i4hHvDs
 caEBDFAV6jT3db5RF7euDLG5eaKkRkxBYFaEG6Z3frqUvm0q+Lf9ORvceA7+cDwkoQDfcRd5+3D
 YTY0UI1NShe72ad9B2k6wnNyZ51kKke/SXW31dwWvtktsF7JIZQcTjM8jvvCWxdJaUURfi/kWtc
 cwbFf8mjHy4bgob7jgWSeYeUoBt6Qh6FzqvEYmJOX4Ub7CqL5cVWgUAd20eDFNJJujyBW3iBCq2
 bJ7fsTQRUlTDJCjW76Z6tL+X+rtKDiTYlU+a9yHfKiC8fcsEt/lCBcDaiwCuuIkVUedG2CtmKhE
 mNHw1jspPphCtsc/nkJmcX2UaPliRHOtUwWpXtQCxCV54G8gU3OKN9HNbI/oYDRzh+MUpxCLQR3
 u1IVGZNOUZFIkTQWa4MW4taT4GFe71Dgk3aFqB1X+NZUEB/DiNHKiYEbDetjNhLk3obLiKt8YtU
 zP4tFl8gMuqnhOmXHHXYalIh5ou1abuXnuxiFi474eOf3xs0qm3UYEFUZk6+pZT4QtZj19Psfql
 P+464fNd8jx+MH0wKWB4CIqPjUnbRkXfFKTusvVRevwlWpwdOQfq3pRw5WyY9O0xLBV0NodRwcH
 wclR31GK76zyBrw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ti,am654-serdes-ctrl is not a simple syscon device - it has children -
thus it should be fully documented in its own binding.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Context might depend on patch in Lee's MFD tree:
https://lore.kernel.org/all/171828959006.2643902.8308227314531523435.b4-ty@kernel.org/
and also further patches here depend on this one.
---
 Documentation/devicetree/bindings/mfd/syscon.yaml  |  1 -
 .../bindings/soc/ti/ti,am654-serdes-ctrl.yaml      | 42 ++++++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 49bf85e8f220..0f6fd1a41dd8 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -118,7 +118,6 @@ properties:
               - ti,am625-dss-oldi-io-ctrl
               - ti,am62p-cpsw-mac-efuse
               - ti,am654-dss-oldi-io-ctrl
-              - ti,am654-serdes-ctrl
               - ti,j784s4-pcie-ctrl
               - ti,keystone-pllctrl
 
diff --git a/Documentation/devicetree/bindings/soc/ti/ti,am654-serdes-ctrl.yaml b/Documentation/devicetree/bindings/soc/ti/ti,am654-serdes-ctrl.yaml
new file mode 100644
index 000000000000..a10a3b89ae05
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/ti/ti,am654-serdes-ctrl.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/ti/ti,am654-serdes-ctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments AM654 Serdes Control Syscon
+
+maintainers:
+  - Nishanth Menon <nm@ti.com>
+
+properties:
+  compatible:
+    items:
+      - const: ti,am654-serdes-ctrl
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  mux-controller:
+    $ref: /schemas/mux/reg-mux.yaml#
+
+required:
+  - compatible
+  - reg
+  - mux-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    clock@4080 {
+        compatible = "ti,am654-serdes-ctrl", "syscon";
+        reg = <0x4080 0x4>;
+
+        mux-controller {
+            compatible = "mmio-mux";
+            #mux-control-cells = <1>;
+            mux-reg-masks = <0x0 0x3>; /* lane select */
+        };
+    };

-- 
2.43.0


