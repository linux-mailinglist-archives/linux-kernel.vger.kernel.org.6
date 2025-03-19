Return-Path: <linux-kernel+bounces-568461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E7FA695D0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6808916A83C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA9720AF71;
	Wed, 19 Mar 2025 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Wiv+i6Dv"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3A41EF384;
	Wed, 19 Mar 2025 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403820; cv=none; b=AvFMi31OMaes8a9YfbuK3ouND5iwYQE3a45GoiegsWf3BZkjY2YTiuqs+uxnNqfelua9JHT6WCDGFAhpdfJqrm5P+jPsUoMKvBjOwbZ0I8pFaAY69OudfSz6s8oisAVaFpz2ciTlp3MN5VjwrfKiaSVrFCWFl1ErZHVvStUaxj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403820; c=relaxed/simple;
	bh=RnsQ9F2mVzQQMBXA26C3IJlUcZMpGeaYTvQuh7UEXsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8s1nZNLAAuKbyy85c0yoGAupIVuydQlaNqipZe6WbSqXQsq0+T3eGs9WybSVfsTEc+bdYZgyU8BGjRC/iCf+SDDfUMOdYqgEReTkeSaNID+oK88Uzo6LfZpsHcF1zuJcbOvQbkbSKLH2pZozETO5B6D32G5ie5Re/AcmbR4OXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Wiv+i6Dv; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so1116352066b.0;
        Wed, 19 Mar 2025 10:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1742403817; x=1743008617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SiuU7CfDhJwDuJz6ru8RHm/UaVa4fwnp4j5CIzUXKs=;
        b=Wiv+i6DvENMFxJsLtutxg42bDUhKwe475P2/VYWDtskwjRhQSrw+KCZzU1uql/XW/V
         QyuSCqlGai4lOR4u1cUcKm5Q0EVfItglAx+b90hvi625RCxy3YPH4IkeHtB/Lbnkdka+
         GnnR5fclNwvgH1gInPUE0vn0xMGaLZ3QEYjNQXLYadLRpnM1y0sgfVZDXykZwpJcCDyw
         /IFfSEBmCyrdDRgYc543eZ+zWjSMf/T0V7qFLxh5H9657damj/2EVhQqLTiUdBE3WCVk
         blH6zS2Laqg07EMhg2pPtgfCNemjA6YgLhUWgcirBXT3+lza6NNPbs5KLikTGyGj9Yta
         qE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742403817; x=1743008617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SiuU7CfDhJwDuJz6ru8RHm/UaVa4fwnp4j5CIzUXKs=;
        b=asDyJ+xgHyICEc7T8XSnB/6xM34A5lc4621kKTAauEOdqG2/qj8OdDIxyJaYech4jK
         l2WLCFr1qEbNgN/z9/jEbn9SAhPYZfk7hkx1Z5F1/LkWZjI0SYhjh9CYKO3pTCyTzdns
         hJF/zgUZ1SkB0M7K2nk88Sb/fMaNN8ZDmM3oGx4r7aLjxVd2zbIjVYT5USaAEWQJrN55
         HTjrfJzOcdlxaAA9NefXcVyvkd/zBQZHkztnnr/lOkwCBeZazBAQEY9Ydgt0+0m0I5FQ
         MhqZ9v/8TjJfw4v3n8Uyyh5EWGD+y72C9qNwTo1/ofn2sbtqu98uxGzGJ0AduTYh9dDe
         fopQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdogUR4HJgt96RSGcFZsfCO004EbJNYmwsdsi2qwdDEWV0DX321WMtQA0fwDHZ20aKxLdTwRiSC1KgG1Y=@vger.kernel.org, AJvYcCUnbL/FfMo2fOdvcjt5e69XfDqUvqb8r/0f+biVhZe/OUIbH+2q1qqMKLLAadU0bgtLLg8ALWG+2nqA@vger.kernel.org, AJvYcCVqiLQsbSs64nwDzpqOmAF8mBIcJjnom0c8ZByzOKcxtAxNh1arsV5SD6Eu6TOlOZPOyaheFXCLhBuXo7Cb@vger.kernel.org, AJvYcCWY7Wodz/8Msx2ZBn4mhqnNBNRHiI4WrC2LPR+82fxhjceAU7A0RZcKzLwidDi7eQSspcBx82jhJhOt@vger.kernel.org
X-Gm-Message-State: AOJu0YwnLyVjJAqFdh+PpPfA9ybLa7T2oiBeATXLmGzVC1TSsjnDnd/G
	APUsdYtDNzNkeZ+ABjOy8uyGLv/0B0avrBG/bQDd1Zcb3S4udcpF
X-Gm-Gg: ASbGncvkbIVqhQ38+GV0HVkAInL/hG4meytTO0CrMdMWjiTjJoAwSoWuI6jbu1RIM3i
	oebZNauhptnUam1XTCg91zkVddbktdejxCTQsDVKf/lLqCwLfMGvTJyIpdG04Ik5WCIn3NzZa11
	w1BYUtSY0/SU5QH2N8fsV5QOFTIM0XRh37oyeOWtXSPxiBHqrA1f+HXxB3X/vtJ0dDqteWeRm+5
	Cv63aG86cQS22EzjUUzyqgYmkxD10mikyYjZ0huz1I6H8qmjqaprpp9mDxNXPkzO4udSwU6iR0v
	XJNFqj24tyDIxavWXLIiLggm/zMZf8zJ93Wg5cgVRc+mt3zuATqTOiHpNi4Vbv4EXgemAjw=
X-Google-Smtp-Source: AGHT+IEivZ3sWdK4akjEnpYdG1nhuPD91nXTna28mFD2Fly0YuUowthEqtudaddT1Ho/vTidC1534w==
X-Received: by 2002:a17:907:7e5d:b0:ac3:8d36:ead3 with SMTP id a640c23a62f3a-ac3cdf8cac7mr38936366b.12.1742403812254;
        Wed, 19 Mar 2025 10:03:32 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([5.15.67.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3143653a7sm1034235866b.0.2025.03.19.10.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:03:31 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@googlemail.com>
X-Google-Original-From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: 
Cc: Flaviu Nistor <flaviu.nistor@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: hwmon: Add TI TPS389008
Date: Wed, 19 Mar 2025 19:02:29 +0200
Message-ID: <20250319170234.63723-3-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319170234.63723-1-flaviu.nistor@gmail.com>
References: <20250319170234.63723-1-flaviu.nistor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings and an example for the
TI TPS389008 voltage monitor.

Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
---
 .../bindings/hwmon/ti,tps389008.yaml          | 140 ++++++++++++++++++
 1 file changed, 140 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,tps389008.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tps389008.yaml b/Documentation/devicetree/bindings/hwmon/ti,tps389008.yaml
new file mode 100644
index 000000000000..5a32359894cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ti,tps389008.yaml
@@ -0,0 +1,140 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/ti,tps389008.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TPS389008 voltage monitor
+
+maintainers:
+  - Flaviu Nistor <flaviu.nistor@gmail.com>
+
+description: |
+  Voltage monitor from TI (TPS389008, TPS389006, TPS389004) on I2C bus.
+
+  Datasheets:
+    https://www.ti.com/lit/ds/symlink/tps389006.pdf?ts=1741000787840&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FTPS389006
+
+properties:
+  compatible:
+    oneOf:
+      - const: ti,tps38908
+      - items:
+          - enum:
+              - ti,tps38908
+              - ti,tps38906
+              - ti,tps38904
+          - const: ti,tps38908
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    description: Required only if a child node is present.
+    const: 1
+
+  "#size-cells":
+    description: Required only if a child node is present.
+    const: 0
+
+patternProperties:
+  "^vmon@[1-8]$":
+    description: |
+      The node contains optional child nodes for up to x channels.
+      There are 8 channels for TPS389008, 6 channels for TPS389006,
+      and 4 channels for TPS389004. Each child node describes the information
+      of the input source. Input channels default to disabled in the chip.
+      Unless channels are explicitly enabled in device-tree,
+      input channels will be disabled.
+    type: object
+    additionalProperties: false
+    properties:
+      reg:
+        description: |
+          Must be 1 to 8, corresponding to the VMONx
+          ports of the TPS389008, TPS389006, or TPS389004, respectively.
+        enum: [ 1, 2, 3, 4, 5, 6, 7, 8 ]
+
+      label:
+        description: Name of the input source.
+
+      ti,vrange-mult-4x:
+        description: |
+          Must have values 5 or 20 in order for the analog
+          conversion to be done correctly.
+          Value 5 indicates multiply by 1 (x1), and value 20 indicates
+          multiply by 4 (x4).
+        type: boolean
+
+      ti,vmon-enable:
+        description: |
+          Sets each channel status. By default, all input channels are disabled.
+            - 0 = channel disabled
+            - 1 = channel active
+        type: boolean
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        vmon@37 {
+            compatible = "ti,tps389008", "ti,tps389006", "ti,tps389004";
+            reg = <0x37>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            vmon1: vmon1@1 {
+                reg = <0x1>;
+                label = "input1";
+                ti,vrange-mult-4x;
+                ti,vmon-enable;
+            };
+            vmon2: vmon2@2 {
+                reg = <0x2>;
+                label = "input2";
+                ti,vrange-mult-4x;
+                ti,vmon-enable;
+            };
+            vmon3: vmon3@3 {
+                reg = <0x3>;
+                label = "input3";
+                ti,vmon-enable;
+            };
+            vmon4: vmon4@4 {
+                reg = <0x4>;
+                label = "input4";
+                ti,vmon-enable;
+            };
+            vmon5: vmon5@5 {
+                reg = <0x5>;
+                label = "input5";
+                status = "disabled";
+            };
+            vmon6: vmon6@6 {
+                reg = <0x6>;
+                label = "input6";
+                ti,vmon-enable;
+            };
+            vmon7: vmon7@7 {
+                reg = <0x7>;
+                label = "input7";
+                ti,vmon-enable;
+            };
+            vmon8: vmon8@8 {
+                reg = <0x8>;
+                label = "input8";
+                ti,vmon-enable;
+            };
+        };
+    };
-- 
2.43.0


