Return-Path: <linux-kernel+bounces-261614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB5593B9ED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 02:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0EB22824DE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 00:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391704A2F;
	Thu, 25 Jul 2024 00:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE3tIgb3"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D995E79CD;
	Thu, 25 Jul 2024 00:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721868497; cv=none; b=VfQfuDmncru49WaJdOdvGyUt+bPhDa9KKw3HowBmlk1/Og7Q55jQU/lQ8DCuEV/NdVTg3h41RWDPcg8/yMEvc9zK1gdMbGNSRNcITldiEkHfFbwK43dmry342Od7r8X08EwWU+JW/u6Xgj46ZwJ8oU8fUmT8iR0gkWlyLOwIQNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721868497; c=relaxed/simple;
	bh=IXLT/PkFvy8zx+tNmbny4uxUcbVB56nR6hUIchrv9DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l54HOuJK3IPG4ATQFPVVBv7iKVZLdjtU0qBmDoya/fy7DuiCDzf7SrlzoekFrW45OndCgUmTZLUlfxV4S1thVvCPPmakO/610b3qhPKBmBVCTLBBqe8dHfbPFSMRO55VZ4o3OD4psxYS1mOydcmopt2WMQ0/OEaCC7bKM59MYKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dE3tIgb3; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1d024f775so19297485a.2;
        Wed, 24 Jul 2024 17:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721868495; x=1722473295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AcNLYjqyP+dKBUQYZH9o81V8DikvAh6HKnAT525IT4=;
        b=dE3tIgb3RiiSWWt8a5PSVWCwUuZrlxqMca5dUlb6e7wfZeYDn5TKotCehzhYJEP1am
         mTc0gGSgJQum1ptN6n5iIoCk4RRGPmI7ifFt42iUJzDaK22KfHwifyEu7RlJVYABrPQf
         Bae9cf3ZeFObB6xRcbH0FdKWVbwKqOMWS5aAfOjBMXIkPNJ8ogEruq3j1nvjR27sPcQ0
         hbR3VngnU9NnwittpdqIIpyQCtFBEstT8TBXNn2bIEP3BHH15wlIpRauMQL04gd6+dro
         nWNkZlpsmbCQnEVAIlOIO+qkP8H21V3YZ/XbdwYgJh9Uzz84qrLFpI3SBD37Dupf0VYQ
         lg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721868495; x=1722473295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AcNLYjqyP+dKBUQYZH9o81V8DikvAh6HKnAT525IT4=;
        b=RSa4WxeOL2hidS3soKSfD5jZ17K1Rm93W5tzUhTATc2lqAwWBDtLzKmLklkWOuoybq
         f+Y3Z2QpBN3PsFIi2wcPNmndjf8a5RsKjLlK7tRg9xgut463vxT+bIlHyQw1fgWu7LQ6
         SV9JZUBTO1iZUBi5L6B0QpkeNKto2R/wdoEjnDCuS7w/nSRXR51KHO8Oop2dQ4pyps3+
         MV0uULDOgMsYQEFO7n4b3n7TtqCQdZyMgDhQFxci0jg622Rb8L5xNvlCtcUumW7XKyuh
         sdpH4OQ4vaed3G5RvYsPBqw9JxJJj9qa/ZjnyoSw/A+r6ikFwuIdc/TLiFkDmKfx2rFr
         VMbw==
X-Forwarded-Encrypted: i=1; AJvYcCUvbeFBQxTDpCHHYnu2kuPgVHTjtuQNdbYS88LBeIGGEY/LiNR2JktvlP1V+hS/LL/aYV32NKGc04BwLO4KsVtzzyf1XIRW175HTbacve3XgAqWkmXObLg0MkIET2MSfh0eIl6KBRYUPA==
X-Gm-Message-State: AOJu0YwbLuTyy5X3hn+VAM10H6h2XVDgrMwagjTwpLKFyKQDdBwRQiyp
	2eq4WaeKexTQiXIzR330H5e1/7o7MU1qtka35vzNH2u2z/VI5hfi
X-Google-Smtp-Source: AGHT+IEjRAGyubNfJqWNroANBDispQ3nRK1qQTjcXY7+9WOlVqFdfZLSX59oQxqjiTjboCT9cxf3iw==
X-Received: by 2002:a05:620a:454b:b0:79d:532a:fcbb with SMTP id af79cd13be357-7a1d7e142b9mr33533985a.2.1721868494691;
        Wed, 24 Jul 2024 17:48:14 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d74353e6sm19339885a.87.2024.07.24.17.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 17:48:14 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: mehdi.djait@bootlin.com,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: display: Add Sharp Memory LCD bindings
Date: Wed, 24 Jul 2024 20:47:02 -0400
Message-ID: <20240725004734.644986-2-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725004734.644986-1-lanzano.alex@gmail.com>
References: <20240725004734.644986-1-lanzano.alex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the monochrome Sharp Memory LCD

Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
---
 .../bindings/display/sharp,sharp-memory.yaml  | 97 +++++++++++++++++++
 include/dt-bindings/display/sharp-memory.h    |  9 ++
 2 files changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sharp,sharp-memory.yaml
 create mode 100644 include/dt-bindings/display/sharp-memory.h

diff --git a/Documentation/devicetree/bindings/display/sharp,sharp-memory.yaml b/Documentation/devicetree/bindings/display/sharp,sharp-memory.yaml
new file mode 100644
index 000000000000..a79edd97c857
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sharp,sharp-memory.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sharp,sharp-memory.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sharp Memory LCD panels
+
+maintainers:
+  - Alex Lanzano <lanzano.alex@gmail.com>
+
+description:
+  This binding is for the Sharp Memory LCD monochrome displays.
+
+properties:
+  compatible:
+    enum:
+      - sharp,ls010b7dh04
+      - sharp,ls011b7dh03
+      - sharp,ls012b7dd01
+      - sharp,ls013b7dh03
+      - sharp,ls013b7dh05
+      - sharp,ls018b7dh02
+      - sharp,ls027b7dh01
+      - sharp,ls027b7dh01a
+      - sharp,ls032b7dd02
+      - sharp,ls044q7dh01
+
+  reg:
+    maxItems: 1
+
+  spi-cs-high: true
+
+  spi-max-frequency:
+    maximum: 2000000
+
+  vcom-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      VCOM is a signal that prevents DC bias from being built up in
+      the panel resulting in pixels being forever stuck in one state.
+      vcom-mode can be set to one of three modes
+
+      SHARP_MEMORY_SOFTWARE_VCOM - This method uses a kthread to periodically send a
+      "maintain display" message to the display, toggling the vcom
+      bit on and off with each message
+
+      SHARP_MEMORY_EXTERNAL_VCOM - This method relies on an external clock to generate
+      the signal on the EXTCOMM pin
+
+      SHARP_MEMORY_PWM_VCOM - This method uses a pwm device to generate the signal
+      on the EXTCOMM pin
+
+    enum: [ 0, 1, 2 ]
+
+  enable-gpios:
+    maxItems: 1
+    description: Enables display
+
+  pwms:
+    maxItems: 1
+    description: External VCOM signal
+
+required:
+  - compatible
+  - reg
+  - spi-cs-high
+  - vcom-mode
+
+if:
+  properties:
+    vcom-mode:
+      # SHARP_MEMORY_PWM_VCOM
+      enum: [2]
+then:
+  required:
+    - pwms
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/display/sharp-memory.h>
+
+    spi {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            display@0{
+                    compatible = "sharp,ls013b7dh03";
+                    reg = <0>;
+                    spi-cs-high;
+                    spi-max-frequency = <1000000>;
+                    vcom-mode = <SHARP_MEMORY_SOFTWARE_VCOM>;
+            };
+    };
+...
diff --git a/include/dt-bindings/display/sharp-memory.h b/include/dt-bindings/display/sharp-memory.h
new file mode 100644
index 000000000000..dea14c7bd7ec
--- /dev/null
+++ b/include/dt-bindings/display/sharp-memory.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+#ifndef _DT_BINDINGS_SHARP_MEMORY
+#define _DT_BINDINGS_SHARP_MEMORY
+
+#define SHARP_MEMORY_SOFTWARE_VCOM	0
+#define SHARP_MEMORY_EXTERNAL_VCOM	1
+#define SHARP_MEMORY_PWM_VCOM		2
+
+#endif
-- 
2.45.2


