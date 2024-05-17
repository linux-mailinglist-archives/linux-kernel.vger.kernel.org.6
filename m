Return-Path: <linux-kernel+bounces-182118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C678C86A8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E751B28589D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 12:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8530C5026A;
	Fri, 17 May 2024 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iy2Q7w75"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DB84F890
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715950307; cv=none; b=LJtU+x/3tgelqj9GYJsS/8bXEKxntQAwvgLp6bFfEuOqgUQsR2YVrCdYL1jFrPzEEQgoeRdgWvugJiKe2HoLgG/8571IPU98uLW0Lp/wYKrO42uhHsOhH6MUzWrLJK6mt7+7w2kfmpIqZTx3j954K8eGnRjmxj33A1+hMcr97Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715950307; c=relaxed/simple;
	bh=Vq4/ozJIACZOKOlrKWjGJ/ITZ67a1Onaw8acoBVl86E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AbdbtKIa2pDXhJv/KMD75DRvwezIqymbKtWMga7HsoLDIrqy1bPBn73+av+Qy76cZEVghsI4hbFB/z4rLZLZxcVoyvbwgmyRfzeGY4tQvtdmSQ1ctQX4FmAmCjofHqdp0taMaFVgG3k3CzMPDanA7rUlXb/SC/0imfNIsrjfbW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Iy2Q7w75; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-572a93890d1so5209436a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 05:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715950303; x=1716555103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uBDeP9nwT+3vg7rh6Kfq9TwLIodJdwZEaPm8bRsiuNE=;
        b=Iy2Q7w75h/Zfv9p7KvFkCQVwK/J6wzRch4+kdxQJ1Ht/vZusif1zQ6jBYF2EFbvdGb
         krpTB0oSkXxDBFvEAwR1FZspXwdoKlBDOcHuFj3OWdmnPS2u/9+pcbwmz+M6TNeHFe+m
         GAHrlPOyATwOCDJ1Zlt0YJbI1pjizqRxcVXgBd1uUuyU8hxTVchRxV4J1gMKdpXBFhxS
         BD0gl8MNOema4TwFKZB9UNWBuT+obIxTviPLl/sJDgoh0Nu4QKirjmmSaX4KDwZHP9nm
         n63lNazZmn9HrHNyL79cfinCYGiZ+ef1+GQwtsei8uZMN1M7I8RfWy+Vv5tx9ZC/BoSR
         ypYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715950303; x=1716555103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBDeP9nwT+3vg7rh6Kfq9TwLIodJdwZEaPm8bRsiuNE=;
        b=pNUMO8i9wCeTU4LPXGyUWjmXimovATpkWqX6w6Yqh05YZx6lfZ63lR1Q4a4bZ3xwXt
         l26UFc+SdxsqXHINnv9KRum9/yzKAuA2UWRixb8iaI0PdfYz/bz8lSivUJYWQzrMq5UZ
         LiU6NS2Qj15iqmYAp0Afv8psHhFVhd84WlRyuXWkh/U8eiZEl0qMiT4BkfPCFaT273bO
         pSBHv4H2CXNWjZmXUdiDM3Yb78KFevlAYSyd3vr7NTPSw8VmlrVBeW22WMll61hAvk6M
         cWkegODnQqK7R9q+Y3d8YVjeNnTlhJp28ZZ3QOkcQSkbnTsp0FbtKKNsqnpBUgXsob19
         4g+w==
X-Forwarded-Encrypted: i=1; AJvYcCWKB2cIEm2sd58xBLng0AMDNKzK9x+ew03yCwrcXVTNrmBFu4HHfXJs4TtuPywiGglHnU1wU3pbbual5/gNiBPME2DDdC1+3v1mzJS0
X-Gm-Message-State: AOJu0Yxg4uonlDcRxEl15/Y7+dn4LN/FJp8ODqCQS4ylJZf/o/+pCz1a
	7ParsH5whEKQHoLNXehFaFN21N6AXYhmMm8w1HYQP1CTCpH3vCcrnp/gB7kHq6o=
X-Google-Smtp-Source: AGHT+IH2rlo+iZOPkGsHzGODAy1kMGiRTqA99W8UoQQqxB5KaE7eFk+2sx7TdMoVT9m8zu7m5sMMHQ==
X-Received: by 2002:a50:cd41:0:b0:574:eca8:631c with SMTP id 4fb4d7f45d1cf-574eca865a6mr8447514a12.1.1715950302929;
        Fri, 17 May 2024 05:51:42 -0700 (PDT)
Received: from krzk-bin.. ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5735a2490casm10540527a12.32.2024.05.17.05.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 05:51:42 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: soc: bcm: document brcm,bcm2711-avs-monitor
Date: Fri, 17 May 2024 14:51:38 +0200
Message-ID: <20240517125138.53441-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document alreasdy used binding for Syscon / AVS monitor:
brcm,bcm2711-avs-monitor to fix dt_binding_check and dtbs_check warnings
like:

  brcm,avs-ro-thermal.example.dtb: /example-0/avs-monitor@7d5d2000: failed to match any schema with compatible: ['brcm,bcm2711-avs-monitor', 'syscon', 'simple-mfd']

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../soc/bcm/brcm,bcm2711-avs-monitor.yaml     | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2711-avs-monitor.yaml

diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2711-avs-monitor.yaml b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2711-avs-monitor.yaml
new file mode 100644
index 000000000000..e02d9d7e7d9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2711-avs-monitor.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/bcm/brcm,bcm2711-avs-monitor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom AVS Monitor
+
+maintainers:
+  - Stefan Wahren <wahrenst@gmx.net>
+
+properties:
+  compatible:
+    items:
+      - const: brcm,bcm2711-avs-monitor
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  thermal:
+    $ref: /schemas/thermal/brcm,avs-ro-thermal.yaml
+    description: Broadcom AVS ring oscillator thermal
+
+required:
+  - compatible
+  - reg
+  - thermal
+
+additionalProperties: false
+
+examples:
+  - |
+    avs-monitor@7d5d2000 {
+        compatible = "brcm,bcm2711-avs-monitor", "syscon", "simple-mfd";
+        reg = <0x7d5d2000 0xf00>;
+
+        thermal: thermal {
+            compatible = "brcm,bcm2711-thermal";
+            #thermal-sensor-cells = <0>;
+        };
+    };
+...
-- 
2.43.0


