Return-Path: <linux-kernel+bounces-230475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B506917D53
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 12:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D58B1C22822
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0641717C22E;
	Wed, 26 Jun 2024 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y+IExZTE"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC98E176AAB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719396588; cv=none; b=jAdsprnKthBRDVaT+jhvue5RV2dQ1rggsGKF0BVagfOYDTJjEaiNiCqXIEaFuSK8rXOANLcjTg7WQAEFCJNK81hygquQm6KvJZ7NYba+xK7NV25bHJ3v/+UmMXN/eiLmBgrOxYP2taepbztzyI5lVOlFHTH+KoGEtuUIiKt4Hw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719396588; c=relaxed/simple;
	bh=GpB46U0rTX768acpnwCp30n8vR+PPYQrOeVuFcF/H/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mq04+b62wFYPkQXOqJ+JhgMX0q53IRSp74jH/2bEPNcVyS11gAr+flYz/RqI95dpmrqHfUWuftvyagncNOzYTfw+ZKblfcfgtzZdRUwtNkJwBYXJZno2AjMJTnKSHgQ4Ch8kbaspcH7wsyh+ZGVARNKoiDn5P/d470/fdQSgjQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y+IExZTE; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7ebe508fa34so352784939f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 03:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719396585; x=1720001385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lyyT2YLj7brwLoXsAS7A6EY+f9NU6Kl4lWR4a3U/7uY=;
        b=y+IExZTEemIxxRDE8kZNh9p+OiEBtXns/1oDcDgVpF5jCXv5IyFtZ7Ha8RThQPrpzP
         ibPhuydu+yviiDUtPuyw1gDF9P3+MVz64lLXVaY4II+PGFbMQljlL1Pqrx+khbI/ISYE
         2fdd4y13rGS8nSnScRoOuAEFO0eoQr0cfuE0tBRQnN3whBIccvippV2ogxWiHHqosVuS
         4B9lUK9UZ5KXK4YE+oIHLBKN1HuI8XZ9NwJZvaw/zdMlmjc/oguoS6/4Mf1lTnkFJSBa
         4P0V/wt8iEJyHPwrI1U5Nh2oMG+dm6rQ0KgnU0OYkWxNOFVYmwuQK5fG0dRswWi6KbMV
         RVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719396585; x=1720001385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyyT2YLj7brwLoXsAS7A6EY+f9NU6Kl4lWR4a3U/7uY=;
        b=AL1GHgfDOfL7iwg3yjWOIVzNiY4MAZFVBA1uwAztD7lFdg6gdYqnLj82jMTbjywf6b
         /c5U7jrMN0dl+zXEc2i6nwsreROt6MzGnXQ8P8wsrrK+JgRo/1Qa++JxN+RqIyJrlX/P
         0922v1pqeC5quVZ3SJmXy03XGelqg4ot7gQ5q3zNdFc8uosoC9l9ybMLwu/ZP6CxTgoc
         bSwxaInyvNnDgvBWMPU9PYZp0wjGrQhQt4UD73Z7phxnJZ/QLJdM3/v6oF4dOUQgUcvD
         0gJLvZzoE0t9pdfpkhyUWsMuq1+utOvxHIQp/qAvBKwWA6ZF4zsEuNHkq2TWbYtvz3R6
         Kk/g==
X-Forwarded-Encrypted: i=1; AJvYcCVW3HtvSD3RafD9t9TjGUTMAP7CpC/af1LQW9xWoVYTtLfmz2+gYTTG2Ri6mHIseZX40d5pa2GMc0GlN8o7dj2Cw4lf5JNS+xaoUFdi
X-Gm-Message-State: AOJu0YyHrwDTakL536OfLx5SMuAGlrerAgiF2GPSTFtAnd2o3r0GcT7z
	mftzp0yh7d2ByJHT0lgG/Z0kUc7v/cQh/pRz2Z4YiTeiKk4SJv3hxuNEsMNbFYU=
X-Google-Smtp-Source: AGHT+IEMyq8R/7/WsaxJZZQs9BQNgFhkEqurTmNJWnTSsdyT/suqRyRek2pxzdymC0qyY/6OUCmztw==
X-Received: by 2002:a05:6602:27c8:b0:7f3:c683:2257 with SMTP id ca18e2360f4ac-7f3c68323ddmr511439439f.19.1719396585029;
        Wed, 26 Jun 2024 03:09:45 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9d121859csm3079108173.137.2024.06.26.03.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 03:09:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 26 Jun 2024 12:09:11 +0200
Subject: [PATCH v3 2/7] dt-bindings: soc: sprd: sc9863a-glbregs: Document
 SC9863A syscon
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-dt-bindings-mfd-syscon-split-v3-2-3409903bb99b@linaro.org>
References: <20240626-dt-bindings-mfd-syscon-split-v3-0-3409903bb99b@linaro.org>
In-Reply-To: <20240626-dt-bindings-mfd-syscon-split-v3-0-3409903bb99b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1955;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=GpB46U0rTX768acpnwCp30n8vR+PPYQrOeVuFcF/H/I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBme+jOPW/pRpNa5wcaDuQgo+GKD9ufJBS2slVI9
 DUEmVuVg5aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZnvozgAKCRDBN2bmhouD
 16DyEACDsuY0Tktlq051+p1lqoifw/KJMVcMX2UU77MTJEF1HKhqQHK4B6GJyxo3bh2kWVca0eG
 Y9BgrGeXwzifNVFFTuPUDtXDyLHE0Zn5HgLPhoddn/ncOHzt+FxG1id236lYEMGruUsNmeskoPG
 dtLCw8lgZCiQOayt7l/vrnjDzOu8agzemjxc/2/XnkaSdfSC/Yfke4IaRj5/G543Bn496TA4nW3
 gSTr7+97WiCje+TlwGhoMZSkU02yIesrFjbbVgCkC1rGfxK0eNDbnztrbX/jjXz2FfXuh6y6Mzs
 9ftjD85kwaZ7M6byl2isVmGLIXy1DQSh27uVFg6rUXrMKf+AacQaJaf+xBT5BpYe0GwogsnK2HV
 z+v+NYV3v1/C9BZl6VTvapfVb5+imZ1Ofd5JiTECnVTS2hvxSSFGBqctflxKXNKeTiDvOIPWhPa
 FVeO4b+3z27/H4eKATNA/sy97lWgijt7zop2R5SgcJTc+EOZKp0pC6hotTf5PQVJHCf/CfWeaFS
 IJH4YKT25gvpc2MR98qjT4upN8fsBJ3nuas0yRo5Ww6oJVIIZtV207OIc/sHlujBtyO17TwTvcD
 KhqjLNg4nZmcsG67EPl6orIaGJmzT4bvu9S88FJyZO6j0MOBZ6GFv4HylfFtuCLIFCDd8yza2ZL
 ll+MEQ7GYUtEm9g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Document sprd,sc9863a-glbregs compatible already used in DTS and other
bindings example.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/soc/sprd/sprd,sc9863a-glbregs.yaml    | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/sprd/sprd,sc9863a-glbregs.yaml b/Documentation/devicetree/bindings/soc/sprd/sprd,sc9863a-glbregs.yaml
new file mode 100644
index 000000000000..49add564e5e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/sprd/sprd,sc9863a-glbregs.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/sprd/sprd,sc9863a-glbregs.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SC9863A Syscon
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  compatible:
+    items:
+      - const: sprd,sc9863a-glbregs
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  ranges: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+patternProperties:
+  "@[0-9a-f]+$":
+    $ref: /schemas/clock/sprd,sc9863a-clk.yaml
+    description: Clock controllers
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@20e00000 {
+      compatible = "sprd,sc9863a-glbregs", "syscon", "simple-mfd";
+      reg = <0x20e00000 0x4000>;
+      ranges = <0 0x20e00000 0x4000>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      apahb_gate: apahb-gate@0 {
+        compatible = "sprd,sc9863a-apahb-gate";
+        reg = <0x0 0x1020>;
+        #clock-cells = <1>;
+      };
+    };
+
+...

-- 
2.43.0


