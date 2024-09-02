Return-Path: <linux-kernel+bounces-311508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 070319689F5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21BC11C22B14
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263E121C164;
	Mon,  2 Sep 2024 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C30CjmmP"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A742101A4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287408; cv=none; b=G82iPu5uOe3DZTgaeOPdJXRPcgudYRMwnZ4ZtiWbxo9klmg+A6ToGGAJ6hpe6ZMn/FKrBxrl0p0udMMKncYAFc/QmNSjAymUdcHIeAOIQpE7Zj7C5oBWeT/gK7V4cNQUk+pvznzxVG3Die1c78CdPRkyPNa80z+yT5Ll59Ddfbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287408; c=relaxed/simple;
	bh=h5zRnSqV6ZjYe7APYo72vG+udW0w8mr58ffVRWIhG/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zd9zhXiHSb0RD69iH7BQAjciXmAMj/7qNSaS5lU2brk2GOlj98ayIV2pNpQxY+tCDTQ6NmKOGKDYIL6TfM+a3EE/31xh5Vdseve5Wp0H3HTQ1vtutNxXcqbgG0kUwGz23KOZaXa50U9XssAHOCreqvxqB8ztr7JSaMjVFgGgefY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C30CjmmP; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-533463f6b16so5451919e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725287404; x=1725892204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uw/A+psE7NhGXyP2Q8ULoJ+2L7aFu1+StWQ11Vu7C+U=;
        b=C30CjmmPYEs7u/GNN5OTWkQNsKM0mwzmtMTWBvZac3Q7d6L0BlnRBnMRfl29tSjIua
         ho1ryXDoj46p3Kb4LOntJC2XS/0yjOhhEiGPxRY3PnmqdNZmX1IzecThFmq5LKtgyU3d
         6YJLCHWKzqMRbveneJ8qt//GbJXXt8qFX2MRf4Pmx2thi2FME5SL2RFVhlzxm4rbEDgX
         OyGUGD9IJIys+RGVENOqzD7HaAEync+skA9Sb25HqxXHhy2RpA9adXki7Xem+iI2p+dD
         EW59sUd6pNzpfLkmros8qFDen4pD0EDvqVLqOGidBmg36lIjgAsm8YB/Jfr9Iamz1B5L
         V7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287404; x=1725892204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uw/A+psE7NhGXyP2Q8ULoJ+2L7aFu1+StWQ11Vu7C+U=;
        b=LmjFcYyIyJznFBZXFOBavJA743oZYmXWeAizBviX7QfL8D3aLnUR9h2p6F6iS3seRv
         8XEOsfl49++oM4dT8Y423g4AapGeK5jcJy/GO1ELoElek1QuuT+9ZwHecti3QNKE8T+p
         Qq6VTIkWyehKOH+RFFDACIScVcBjRudMt6rRemdV9uAsulXpsXnxzq8BtYZk4e3EEZ59
         ntlTeZwIbmX4v3+mEcuqNsX5KMqMJc8iiqNijSEAdI9IIfOD9uDmgFCg0cJNxwzBFHCE
         FkwkfxbyFzh0SyOOjnbR27kJkP/9AGXFMV3LoEM2B/yTLb//Yb5uXzJ4B0IlTSHprF+x
         vf1w==
X-Gm-Message-State: AOJu0YxEdeIi+jM6R9ntam7iWu7JiumiHdhTjChM8JHnVinenCmNAbVp
	Z69rYwnm7Pvq6CaHpL29Ie88qwK23U7zlMM070KGX3ml/jTCtewZQMzNJpA1i+ysygNa9WcnSRJ
	4
X-Google-Smtp-Source: AGHT+IHtMYM9NUyJ6BH+L3sxKU/gxl5azI4XsHviIEiPjFmV6nStxz5798arhccnqTkWTHloZKAoBQ==
X-Received: by 2002:a05:6512:3085:b0:52c:d56f:b2cc with SMTP id 2adb3069b0e04-53546bb8a31mr7297929e87.58.1725287403971;
        Mon, 02 Sep 2024 07:30:03 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d80fcsm566011666b.181.2024.09.02.07.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:30:03 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Rob Herring <robh@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/9] dt-bindings: nvmem: convert U-Boot env to a layout
Date: Mon,  2 Sep 2024 15:29:46 +0100
Message-Id: <20240902142952.71639-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902142952.71639-1-srinivas.kandagatla@linaro.org>
References: <20240902142952.71639-1-srinivas.kandagatla@linaro.org>
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
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
2.25.1


