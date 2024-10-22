Return-Path: <linux-kernel+bounces-376109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 103689AA02F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C76FB22AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504A919ABAB;
	Tue, 22 Oct 2024 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="BenDzSPg"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6D319B3D8
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729593490; cv=none; b=SiyjquoW/7CjE1mv/czSpu5JSlOEtKATG/Myr0s/yd9ftWTwxNg857Iv5Y9jMhruKbqMmLHlno74WOJPb4r4tlvxSsqqQQJ15s3JwVTZtxcoCM4RbsBo3OHHYmUqDfLtsJf+EBv+yp+UZpkmBKQuaEZLANfo6/UzsGJJUhQGITE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729593490; c=relaxed/simple;
	bh=iNwDcYtlbxvi4NbJQ1Qv0xRcHf3mR6Uqwsa3JIcyDJQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pCCSQqE+YK8f547S8EhuA/1VcF2M8EpcD8brdfQM2AKc7IGfAW5/5eprLeHTbSfpuzzp7/0m6F2hFfoybMbBMPNw4mOTWQBxJR9aZ35L0ubbIk52eH3A+73aBYZ3WaRWJb3xYuN+sG8YPvm//NOGzMuRWR1VlwER3iqPz1SKOGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=BenDzSPg; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d51055097so3964518f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 03:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1729593486; x=1730198286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3DqeiQ/4GJHdOQ7JJjqx8kLtxbudI+1y5YQkYzghUQ8=;
        b=BenDzSPgWOLrLpDaZK3Y7k7nJncb/7CvK39OHhF0sKGhMdsIfMp1DDtrYFGvaDsNEf
         vEu6ax1vRJxK5N/OY9qdw8aLJX++sO7mhDD+/HbWwupBSlwRs6aTHO7RhdhnBEoQIw63
         V9JeA9VWILExwqKHjaAbDbXlgoH9S6yaQGZkYm6kLEvabvlxbOrjAzfOIEnccB4tvw2u
         YVVwypVi+EoB8rM+atG11lvFgV4YelGlobNK1eOdF3yrA8G+ARxix9k4GjhLnaiS5GQO
         HKLXnDO10a7B9O6WQ/DAzs68pQL3ykvt9e4tBBZVUTxhPBdQQFMYeFMVMNRSL4xO3TRA
         0RZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729593486; x=1730198286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3DqeiQ/4GJHdOQ7JJjqx8kLtxbudI+1y5YQkYzghUQ8=;
        b=fFS0b40YGfTnxfOTbMP/4HV5u5kKo5y1YDRBi9dazTEYZWkbJG6Mv54JcC9FIMU8d+
         hitNgJV7yvjm/w2P8jAWdcEhFDeQ7CquNY/ijVbNTG5eCNz9YEDaacweedD1fv6H59rf
         j8RQVFt7xwnQ/nQ0rxshCrBLSYuzhjDaYC6Xp/2KiJ2x4ZRZUCIC1tC+pX+5ZLtQ6vMw
         JNbaZb53m8kPiro/4C07QPEE/w6hItAgXaCPvVW5fgM7oPjGxbYfCHUXpqUPWEujYP2j
         hWkoVv0HI8SPCIMgqcuVgOSQQHyNIdqESqVr8arv6045C9fiXubYuVpn0c6VS5MlBZDa
         VI8A==
X-Forwarded-Encrypted: i=1; AJvYcCXWkgSKtDX6tmF0WLprBrBeh5ul+1qOYtM0bIvXynWTc0oT8+ItuB+uXD4e8x2/5umH7/XfzBBz0N1bXs4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdfzveeq/AAVQXlyclGJ4QslO3E3e+HTmboMcLOns4cuI1D5en
	4KjiL8Biui6NYCGZzdWdGSN2da4wV0Hx9kwii/d27oi9Q726bt+kr+OuMGiQ/WY=
X-Google-Smtp-Source: AGHT+IE2IQWBiMB+M/1I2TW/3oVxcQmmQ8LKMmQ9f08j/0oNw9aZKwVh5bm+wsUlo8PaGwno1otOKA==
X-Received: by 2002:a5d:4e49:0:b0:37d:3301:9891 with SMTP id ffacd0b85a97d-37ea2164d8bmr9308914f8f.17.1729593485673;
        Tue, 22 Oct 2024 03:38:05 -0700 (PDT)
Received: from stroh80.lab.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a4864csm6352974f8f.35.2024.10.22.03.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 03:38:04 -0700 (PDT)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	sylv@sylv.io,
	linux-hwmon@vger.kernel.org,
	Naresh Solanki <naresh.solanki@9elements.com>
Subject: [PATCH] dt-bindings: hwmon: pmbus: Add bindings for MPS MP297x
Date: Tue, 22 Oct 2024 16:07:49 +0530
Message-ID: <20241022103750.572677-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove mps297x from trivial-devices as it requires
additional properties and does not fit into the trivial
devices category.

Add new bindings for MPS mp2971, mp2973 & mp2975.
It is Dual-Loop, Digital Multi-Phase Controller with PMBUS
interface

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 .../bindings/hwmon/pmbus/mps,mp2975.yaml      | 75 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  6 --
 2 files changed, 75 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/mps,mp2975.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/pmbus/mps,mp2975.yaml b/Documentation/devicetree/bindings/hwmon/pmbus/mps,mp2975.yaml
new file mode 100644
index 000000000000..f7bc4f077929
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/pmbus/mps,mp2975.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/pmbus/mps,mp2975.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MPS MP2975 Synchronous Buck Regulator
+
+maintainers:
+  - Naresh Solanki <naresh.solanki@9elements.com>
+
+description:
+  The MPS MP2971, MP2973 & MP2975 is a multi-phase voltage regulator
+  designed for use in high-performance computing and server
+  applications. It supports I2C/PMBus for control and monitoring.
+
+properties:
+  compatible:
+    enum:
+      - mps,mp2971
+      - mps,mp2973
+      - mps,mp2975
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description:
+      List of regulators provided by this controller.
+
+    patternProperties:
+      "^vout[0-1]$":
+        $ref: /schemas/regulator/regulator.yaml#
+        type: object
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        regulator@58 {
+            compatible = "mps,mp2973";
+            reg = <0x58>;
+
+            interrupt-parent = <&smb_pex_cpu1_event>;
+            interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+
+            regulators {
+                vout0 {
+                    regulator-name = "pvccin_cpu1";
+                    regulator-enable-ramp-delay = <200>;
+                };
+                vout1 {
+                    regulator-name = "pvccfa_ehv_fivra_cpu1";
+                    regulator-enable-ramp-delay = <200>;
+                };
+            };
+        };
+    };
+
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 15f89d7ecf73..08de873f9f98 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -281,12 +281,6 @@ properties:
           - mps,mp2888
             # Monolithic Power Systems Inc. multi-phase controller mp2891
           - mps,mp2891
-            # Monolithic Power Systems Inc. multi-phase controller mp2971
-          - mps,mp2971
-            # Monolithic Power Systems Inc. multi-phase controller mp2973
-          - mps,mp2973
-            # Monolithic Power Systems Inc. multi-phase controller mp2975
-          - mps,mp2975
             # Monolithic Power Systems Inc. multi-phase controller mp2993
           - mps,mp2993
             # Monolithic Power Systems Inc. multi-phase hot-swap controller mp5920

base-commit: d79616b04f0e08178ceb716a5d2ef60ab723d532
-- 
2.42.0


