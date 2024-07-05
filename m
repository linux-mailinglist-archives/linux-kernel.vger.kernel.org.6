Return-Path: <linux-kernel+bounces-242948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6625F928F75
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 00:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A481F230EC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 22:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B70148302;
	Fri,  5 Jul 2024 22:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lc7huM2K"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0C9145A0B;
	Fri,  5 Jul 2024 22:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720220322; cv=none; b=rN6Ul1D19sroB5duZZ2SNIZg2dfAmpsubw2q/MTJkp36kDfXXyy6eVA8hmwsoP/2C1LtEWG/gi6sYF5vj0E0Mca1p4N2Z5Fp0qQ/xfXZicYW3YyDtOQ5P7FV/GytggMQ9nNQ07s/IsOJwLkfZdqEqj7xUOkrYq70qmKpKqlGbBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720220322; c=relaxed/simple;
	bh=qoZfP1S+acuGp2s4TC90tooFq8WbbDjK2Fz1Bq+nL2s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dhKEGfXKrYNBrOO0Z3si7tyS1EWp47dC6xia1idVmm733AhWqF+9Za2y2efrlFXuSofSi7+n8U+ySZblZrSpjAnmjhdzD35Us0EdtvIGojhZ6CyhRBxoQUKEl8eiDqLWVnmqaiWsaidsKw3NELmsBfctQ62xz+RH4r8uFJ4oHYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lc7huM2K; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58ba3e37feeso2918571a12.3;
        Fri, 05 Jul 2024 15:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720220319; x=1720825119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FiMeeVhiLcAlXej3uBvwyk/ojiuyjSIG1S2ztz0XYNs=;
        b=Lc7huM2KjsY6GIN9/f8lgu6xV7Qd/sL1+f6qPEpB1NdrMUZh4NqNyznQB0/Oypt5wx
         3hg63sQ43qS+Ds9bgMXC2HWfTF2TCoXx0CJgRYBFFtdpbMnOZ5lvY3CmbqWC/k9a0TNL
         BNssh3BBGj45AXeytwFXObuQUczEMYusWHkuWFYwYmnDrNgm5ZJXrPRWVjW6XnJeUQB2
         mo4rV7tfFBn5iKQ5Piyayn2Cs0LbKzjHprFLOEgXG+brLWXIPzGl/b4jZnPPJr/KscHo
         u9cJ1VuzyCUoCPWlABFV95DqaHS3R+hLq9Ork+010WShnMIsPLO01bzIR2XyPzlKkygM
         wFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720220319; x=1720825119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FiMeeVhiLcAlXej3uBvwyk/ojiuyjSIG1S2ztz0XYNs=;
        b=UClJ6+NYZ+VDW26/utljs9xKoeKkzhvCnV0R2mqExkSO/2a+GpTApbkTpljZDEg+p4
         fqexS3qtafdycD2+3Ip5IIDRBpF7FOtCAtqI4mt/kmVuXSgo3UWIx5LQwldwV/bmTQuB
         sqQZMB59NrXRGykSqxUJAtUUZlV1OkholE3Yzsre3Oxm7e8hBtkrxsKEVnxmU7+P/JZI
         gK7TlhgkHsfpZWfamLkl7JIE4R2EAbFdkKNAJ9uhTFaxySQEetoRULbSn6UZIyJJhGoB
         MBJSjc/AproHTd8gfhIlemHD/oMScCAojxq6A28VO7C/OvA/Y4K52xT6fXH+HeDa9iYT
         QSDw==
X-Forwarded-Encrypted: i=1; AJvYcCWnU5ZjW5ubJRnqgX+93AiuriW3Eixphgxr216iWKNda6c4Pq7+DarOe5yGO/BCX1sKZrSpezuBlolhpGN7d264bgUnlLek0DLECvPMAeCZZXK6MUCCEqtofdPyZSrLzqZ21EhpuNNUXw==
X-Gm-Message-State: AOJu0YyOoVOWCEx+sC7XqZ4lcK5G7HLYp0rNyCdLiyJvcsU0ym7AwZhD
	cOEOXPg5Pwa8vvvtVJATfW2M/0Wrj4c6wsEDx3sP2rGW16DUF43G
X-Google-Smtp-Source: AGHT+IF/EnTZ+25wxqkBsWXqxU8jobntZQ97ZpwWquicNED9QnU285ETFWo0voXR6AyZFnJzN7nEIA==
X-Received: by 2002:a05:6402:254a:b0:586:6365:b3cf with SMTP id 4fb4d7f45d1cf-58e596592cbmr4608643a12.10.1720220318886;
        Fri, 05 Jul 2024 15:58:38 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861381868csm10052128a12.55.2024.07.05.15.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 15:58:38 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Walle <michael@walle.cc>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	devicetree@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: nvmem: convert U-Boot env to a layout
Date: Sat,  6 Jul 2024 00:58:21 +0200
Message-Id: <20240705225821.13196-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

U-Boot environment variables can be stored in various data sources. MTD
is just one of available options. Refactor DT binding into a layout so
it can be used with UBI volumes and other NVMEM devices.

Link: https://lore.kernel.org/all/20231221173421.13737-1-zajec5@gmail.com/
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
I'm sending this PATCH without Linux changes to see if this is the
right approach - for developers and (DT) maintainers to review it first.

My previous attempt (see above Link) turned out in refusal so I'm just
trying to save some time in case this one goes wrong as well.

Hopefully the included example (which I really think we should add)
explains well how I think this binding should be used with layouts.

If I get some positive feedback I'll work on V2 with actual Linux
changes.

 .../bindings/nvmem/layouts/nvmem-layout.yaml  |  1 +
 .../nvmem/{ => layouts}/u-boot,env.yaml       | 39 ++++++++++++++++---
 2 files changed, 35 insertions(+), 5 deletions(-)
 rename Documentation/devicetree/bindings/nvmem/{ => layouts}/u-boot,env.yaml (75%)

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
index 3b40f7880774..382507060651 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
@@ -21,6 +21,7 @@ oneOf:
   - $ref: fixed-layout.yaml
   - $ref: kontron,sl28-vpd.yaml
   - $ref: onie,tlv-layout.yaml
+  - $ref: u-boot,env.yaml
 
 properties:
   compatible: true
diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
similarity index 75%
rename from Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
rename to Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
index 9c36afc7084b..56a8f55d4a09 100644
--- a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/nvmem/u-boot,env.yaml#
+$id: http://devicetree.org/schemas/nvmem/layouts/u-boot,env.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: U-Boot environment variables
+title: U-Boot environment variables layout
 
 description: |
   U-Boot uses environment variables to store device parameters and
@@ -21,9 +21,6 @@ description: |
   This binding allows marking storage device (as containing env data) and
   specifying used format.
 
-  Right now only flash partition case is covered but it may be extended to e.g.
-  UBI volumes in the future.
-
   Variables can be defined as NVMEM device subnodes.
 
 maintainers:
@@ -42,6 +39,7 @@ properties:
         const: brcm,env
 
   reg:
+    description: Partition offset and size for env on top of MTD
     maxItems: 1
 
   bootcmd:
@@ -58,6 +56,17 @@ properties:
         description: The first argument is a MAC address offset.
         const: 1
 
+allOf:
+  - if:
+      properties:
+        $nodename:
+          not:
+            contains:
+              pattern: "^partition@[0-9a-f]+$"
+    then:
+      properties:
+        reg: false
+
 additionalProperties: false
 
 examples:
@@ -101,3 +110,23 @@ examples:
             };
         };
     };
+  - |
+    partition@0 {
+        reg = <0x0 0x100000>;
+        label = "ubi";
+        compatible = "linux,ubi";
+
+        volumes {
+            ubi-volume-u-boot-env {
+                volname = "env";
+
+                nvmem-layout {
+                    compatible = "u-boot,env";
+
+                    ethaddr {
+                        #nvmem-cell-cells = <1>;
+                    };
+                };
+            };
+        };
+    };
-- 
2.35.3


