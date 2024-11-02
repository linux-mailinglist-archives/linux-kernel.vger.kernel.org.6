Return-Path: <linux-kernel+bounces-393590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 213449BA2B7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 23:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABCE11F229A7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 22:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EF51662F4;
	Sat,  2 Nov 2024 22:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9MPRxZg"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642A54120B;
	Sat,  2 Nov 2024 22:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730585839; cv=none; b=HBJXIiZZCsq1bbOacY3QdN4LNElDBMgxN6sI08f9eIPH8wWbHtDvcF2sLt+gE/m+ckI/F0h+aAiUtQOHofEIWgY477534FXymaXwHoyV+eytMxJdrLB7PVS/TfMHA/qbhSIdtnYlPh+0dYmcdCefPbX0kGStlSbNZmSg+vbi/JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730585839; c=relaxed/simple;
	bh=Uk9I+q5+k0HBlwrfb+1T6Z4LdoqzQTxeoqP3WIiSdKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WNBIZJ1JfPfxPUEo3906QWkGuFC5WVctny5qnv1odGREH0D4VBlg2ky4kvU0EoioqgKgJyHfgQmJAlf2ygRmMHU0JlMAJOXcT9LlsaL/Av4eyD3isCY4RVunlUqfNNvb7uOBKGrG9QkI+0icuZRPZ3GEmcpk6Vm7GAjdcMzCtXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9MPRxZg; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso417372466b.3;
        Sat, 02 Nov 2024 15:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730585836; x=1731190636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5vxf8MUw1KHlnGBa/1IMyXj2UG6JCewFqgb6iXxRDuo=;
        b=i9MPRxZgR6XuIgZK2jNC4eIM+YG4CsBMROtQIbA39EcKicZfFCwRDw+3HTqIFPAVvc
         fRLuGu+gFogsp+CSJVpi7aFLLlodNbfg2J8vDBLonbhusV+WuIisI2/TnS6Ly4se2vn5
         Kg0DEVgy1J3z0uxxRvTEI87klHfU/OqNCpQMDkG5SL+Ah5pm9bmOEZhXI1W67i/TY1HE
         UJqKSowflCRtb+a9EvkMy/12LyMG6p6hbynsrwShW6o5yRe0TVwhjBI5FM2rfuiQ0Srj
         LkzUrPJI+/IGUMrUb1q2qTkOnY6TRurPMVHLziYbvQ3dw0/eTkdLUl7C7VLe0Zy2Kh49
         tPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730585836; x=1731190636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vxf8MUw1KHlnGBa/1IMyXj2UG6JCewFqgb6iXxRDuo=;
        b=H/bPwZzRC8Nxin+mrq3YxUfzkyIWQra48zJM4xAjZ0zfAXTzZZKqKro1PpFW/Slrsz
         agCmmwFta3d43VDzAb6kDtZgHeedFnctRho+g3JP02qRlNKVF020gbv5iZMxfvOMC3a2
         h2/sIThZ8Igz8ZxDHnzUEJk+2BJiP4qTNkGA18HjGsGA+SZC7QA7RWcQJrjKY3p8vzYG
         /RlqBgTZ/hP38RqGbic1+qdo4zK+eytsQ+bX1r2Tz5pHWtTT0I/hOzT9nGjiNdKRszaG
         IK7UIz6guXy4fKy5R56t+uKS7aiQUjl48lD3GDQPu3Nlx1JESbRM0/zZWDTalRniJDuk
         xxtw==
X-Forwarded-Encrypted: i=1; AJvYcCVnsdPW4dnFFkundKrWnPSIDAcoEohJaewCNdx4Pew6u1AbbBtR4X9/KKFyf5sbw56hvlmx+I45bg5e@vger.kernel.org, AJvYcCXZ/R+V/YZvzV9rUT0pyKnWmcPlpm0qPtQ0hUvjmpj6zDgKSYGSD92vQQLVPuTgTK70+1dZLvrjzJCeCnsP@vger.kernel.org
X-Gm-Message-State: AOJu0YwA6vgW5QL/Ofy3RMRjTEokuqpVbvnnfGViayLNuK+hFZielcKY
	JAt6noMN+a9LAr7B4OpUpWd0hnYEcGjAgUEYe5Kdp2QK1VexTMZK
X-Google-Smtp-Source: AGHT+IE+SUlLFoN/+EuPuCWvs6qpBKkmSyn3eiHJ8mhwnVR3nprD9gPRGUlcGSR5L/12vtyXRpdvcg==
X-Received: by 2002:a17:906:7311:b0:a9a:8502:6ebb with SMTP id a640c23a62f3a-a9de61ce5c1mr2560597666b.41.1730585835467;
        Sat, 02 Nov 2024 15:17:15 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564c4f2dsm350412566b.52.2024.11.02.15.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 15:17:14 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-actions@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: power: actions,owl-sps: convert to YAML
Date: Sun,  3 Nov 2024 00:17:06 +0200
Message-ID: <20241102221707.2857342-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert the Actions Semi Owl Smart Power System (SPS) bindings to DT
schema.

Changes during conversion:
 - Rename file to match compatible
 - Add a description

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 .../bindings/power/actions,owl-sps.txt        | 21 --------
 .../bindings/power/actions,owl-sps.yaml       | 50 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 51 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/actions,owl-sps.txt
 create mode 100644 Documentation/devicetree/bindings/power/actions,owl-sps.yaml

diff --git a/Documentation/devicetree/bindings/power/actions,owl-sps.txt b/Documentation/devicetree/bindings/power/actions,owl-sps.txt
deleted file mode 100644
index a3571937b..000000000
--- a/Documentation/devicetree/bindings/power/actions,owl-sps.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Actions Semi Owl Smart Power System (SPS)
-
-Required properties:
-- compatible          :  "actions,s500-sps" for S500
-                         "actions,s700-sps" for S700
-                         "actions,s900-sps" for S900
-- reg                 :  Offset and length of the register set for the device.
-- #power-domain-cells :  Must be 1.
-                         See macros in:
-                          include/dt-bindings/power/owl-s500-powergate.h for S500
-                          include/dt-bindings/power/owl-s700-powergate.h for S700
-                          include/dt-bindings/power/owl-s900-powergate.h for S900
-
-
-Example:
-
-		sps: power-controller@b01b0100 {
-			compatible = "actions,s500-sps";
-			reg = <0xb01b0100 0x100>;
-			#power-domain-cells = <1>;
-		};
diff --git a/Documentation/devicetree/bindings/power/actions,owl-sps.yaml b/Documentation/devicetree/bindings/power/actions,owl-sps.yaml
new file mode 100644
index 000000000..6496f3a71
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/actions,owl-sps.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/actions,owl-sps.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi Owl Smart Power System (SPS)
+
+maintainers:
+  - Andreas Färber <afaerber@suse.de>
+
+description: |
+  Actions Semi Owl SoCs feature a Smart Power System (SPS) that manages power
+  domains to optimize power usage across various hardware blocks. Each power
+  domain corresponds to a specific hardware block and is represented by a bit
+  in the power control register and an acknowledgment bit, which is then
+  translated into a corresponding voltage on a rail.
+
+properties:
+  compatible:
+    enum:
+      - actions,s500-sps
+      - actions,s700-sps
+      - actions,s900-sps
+
+  reg:
+    maxItems: 1
+
+  "#power-domain-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#power-domain-cells"
+
+additionalProperties: false
+examples:
+  - |
+    #include <dt-bindings/power/owl-s500-powergate.h>
+    soc {
+      #address-cells = <1>;
+      #size-cells = <1>;
+      sps: power-controller@b01b0100 {
+        compatible = "actions,s500-sps";
+        reg = <0xb01b0100 0x100>;
+        #power-domain-cells = <1>;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 76ea65128..420d06d37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2023,7 +2023,7 @@ F:	Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
 F:	Documentation/devicetree/bindings/mmc/owl-mmc.yaml
 F:	Documentation/devicetree/bindings/net/actions,owl-emac.yaml
 F:	Documentation/devicetree/bindings/pinctrl/actions,*
-F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
+F:	Documentation/devicetree/bindings/power/actions,owl-sps.yaml
 F:	Documentation/devicetree/bindings/timer/actions,owl-timer.yaml
 F:	arch/arm/boot/dts/actions/
 F:	arch/arm/mach-actions/
-- 
2.43.0


