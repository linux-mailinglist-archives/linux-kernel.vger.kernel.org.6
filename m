Return-Path: <linux-kernel+bounces-216298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 463BB909DA3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 15:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82241B212F6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 13:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BDF18C355;
	Sun, 16 Jun 2024 13:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9ElPHIX"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB64188CCA
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718543981; cv=none; b=NWk0LkITNVPZSsa/O9OSlvlyz/kb1Be8nhP3UZ5T3Bk7Pv8kdDKnkWcvfRvpYah65D8A1uuIZbKkDK4Gz3hzLrjNGJ8wzIifR9GLu8DGcquf6rpJmFRrAAaCg1TdaNHNsZRaMD1JTkJ3rcqZAGwXvo9CByQqdsfpB8MepRHd9bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718543981; c=relaxed/simple;
	bh=dzjm2gBTdMjl6mgRsFtrUQDBw9hhYKgIAMant8cvlAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GYGV7FQ7bwmHpq+og3GQn0dcKqnJP9fWA0T7uvwDsqktyoXOI1sHkNEbLqQKEuZexRN7/Ui/rA4+Pqm05v+7CZpifr5y/5Mo0sJwllnz5wRKMF9l6EcRd+XBNQ+mKJGv6epch9pQLmaQRrVQ2HBQJCXzaxb+ZOTZdrKnYtqoElo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b9ElPHIX; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57c73a3b3d7so4052508a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 06:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718543978; x=1719148778; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9ZLKoGKyA/Fzir83VT6KMHwP0QAfjlVUV43lkT6aLM=;
        b=b9ElPHIXhGYplvIOWN2e2Od410TaR5JO7iD1Pahzo3K3ikFaTZSD1WDR/Mr1vptCWK
         H6qvoOitOpSrwSeA9bNMbnXh4i9MirJHoTtqT60fei17rkxxGaQSqt3T4cuMg51uTdNB
         b1YjyEsC8RSNa6T6P764pfq6zq2VqvMrSCGY7o5UvoMPtPW0MCNfAWOZ0YZqTJXOTNc+
         ND5lplGxQFtcrZkjIaLcfQAix7NWyILYmJxc3N0eWhoxloL47HskAOLgaCjSvlofPZJl
         tk7Ej5hpv/6luUXJ5xH2reeDuQ/XsrVf1Ccazx2qSxSmFScsCGZdVqvho3UVO/5vRqW9
         R4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718543978; x=1719148778;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9ZLKoGKyA/Fzir83VT6KMHwP0QAfjlVUV43lkT6aLM=;
        b=cJKbls2ZPeKib+blmpDoMq8vE9KLYdGm2KAC38PkXYvXTMPKVZV4MLyEAtihI5dVKL
         R8L7JDuDEeRBXFEqmWgnzSSG2Z9VoPc7lLPzxzrjBBT4uYWBNJiuoqNuCOkLZlSbyxrz
         /nsyNflRiwDsBdssyemk/cfSzU4QeT1HYBwzMc2nztFU3ubY5v+Cgck3+GkFDATPwg8z
         jN6hYZbsVyt67QsmxkJyLdFv/2q96nt9zb989mXB+7ctBm29yo1Cvhl80YvG5f/9KWcx
         933vB1JY4LnZKlIwI1Nm1U5t9pEG0/18Y/qPlse9YjYkKpGDJx12xrHUUkHplkLkgVW4
         xzrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW31FTA+Y7QJsivjrViuBJAMOZUrIVDOcIDmynMRLaYasPMM2Km2dWqe5jjvcttAPtvqNWSisUDm2lmdl9aEuJC22oLaJ35nm6D2220
X-Gm-Message-State: AOJu0Yz4FUkAGWPvYzbvtkk4JAAn4NEkamJLIS8dS3UBWK4+tjo0T/Kp
	jtB4Z8B+WQVoS5KV9vJXAPn2K0zKQZrcQSTB0Y6rNqT7EkB0uGEz03VLY3wuRSw=
X-Google-Smtp-Source: AGHT+IHO9RnbHcazsIsMGMs7VyXCSngI/q7B/q3+4iSsAbqu/mLW9gJSoHV2U3Z1C3VdPOojDxIbeg==
X-Received: by 2002:a50:9fc4:0:b0:57c:8027:534d with SMTP id 4fb4d7f45d1cf-57cbd69d9b8mr5103771a12.27.1718543977636;
        Sun, 16 Jun 2024 06:19:37 -0700 (PDT)
Received: from [127.0.1.1] ([78.10.207.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb7438815sm5099603a12.80.2024.06.16.06.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 06:19:37 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 16 Jun 2024 15:19:22 +0200
Subject: [PATCH v2 2/7] dt-bindings: soc: sprd: sc9863a-glbregs: Document
 SC9863A syscon
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240616-dt-bindings-mfd-syscon-split-v2-2-571b5850174a@linaro.org>
References: <20240616-dt-bindings-mfd-syscon-split-v2-0-571b5850174a@linaro.org>
In-Reply-To: <20240616-dt-bindings-mfd-syscon-split-v2-0-571b5850174a@linaro.org>
To: Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Khuong Dinh <khuong@os.amperecomputing.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 Nishanth Menon <nm@ti.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1897;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=dzjm2gBTdMjl6mgRsFtrUQDBw9hhYKgIAMant8cvlAI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmbuZfiEg4Htf73PryBDmHhre04Usi0iIsta0KI
 HauaVoH5/aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZm7mXwAKCRDBN2bmhouD
 1wUND/4zJem/xT2bP0jF8QkDD0M/Aj7W3bmFEdpYj9UtYubYLZSSMxUk4qKXCk6kLeYVahA5rPC
 h62lhRFq1txEAblixLgsn+TiseY/cWNGESVoMdjYApbkXurI/OTfmE1WkRvJdzIHZ1lDhBoxFbp
 mAC+A90V0a9L5ylVBxj/TJsS2RT5F8TBkAn3mpkxDSdrBzOz41Hm1DsHPF8sVjKqikmJy7AfK8K
 BiWWaFi/I37y1ETVqfdhc92c8+zfMh5lTZ2TSQDiYoyiwihVNfQNbzEylvUQ3945l9sD/845fGL
 yZmIrK/dseAxgAMGcyKPy4j0YmS+fZTA4pohSsP3EBxoJYXriElXyXwKCAwaVIc2gKrU/uuuaPx
 gnNw324jOnvUWx1jchGv8Qu/wfgxoYDvYt1oXdsY/ya/VtOr7mFMxdxCEkKOAifX0ANsDB2fKdH
 SoXo6LgbDbZNoHzO8bIPOFPx6reVkj2cjnjkb35WY+2ui3BMn93C432nN91zVnS+ikyn70G/1W+
 Lrx8HNeARldbkou56Yt1wyX54daffXOPE28BtlNeL8//88syhIkTtJfUT+DRS8b+VqYs3eTojuw
 qt6esBgduNadtkatmGFC2pTnRlPdvvYDugVj1rpId0PCUt5rVqqAvw8i38jvspVgBfBn6n4Ayek
 E9lvLWTzMeLinfw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Document sprd,sc9863a-glbregs compatible already used in DTS and other
bindings example.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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


