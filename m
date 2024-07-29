Return-Path: <linux-kernel+bounces-265320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E7693EF74
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671CB1C21C93
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5478A13A88D;
	Mon, 29 Jul 2024 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngZ4rxYS"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF87013A896;
	Mon, 29 Jul 2024 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240484; cv=none; b=CxHPwJ1Rt/BOQYaqXJpsOQl2dha5dPWQNcCfOFx+2VXsFb4ZjquZLw7NNNQaD16Lska8HnYzTfja0HDq7CsFCoLwpv739+mORcSM0rPWDgdWZUJ7BFR29bxNWIDvJ4hoKszXGZKC4qG7ODSK58Ak5b3wvbmp1frx8UJJXTLrcTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240484; c=relaxed/simple;
	bh=O+OeteTD7FOWggd6ayiPpLHIn9K77OcZnjZLU+lfK9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCMTvPHNt4wx16ElJZ/iY70kpX7JcxW599jkO3RZp9WPB5jmn6X0/ytkNIAH1bDqbG3aYmt5L/ZrxNqVRA2q+4UJqIoY4MM6qEzU21IgZZ+IWMMcuiUIqNEoUd+1btiGS+6XqHjfp0Zc3gHyMXFV+R0Il3O7P27fLXoGUa2v2IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngZ4rxYS; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a1c496335aso3034368a12.1;
        Mon, 29 Jul 2024 01:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722240481; x=1722845281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rl8HdNLgtv5Fxv2Nk9Of+lDPOeD8hPV7F8FWHfhtTmU=;
        b=ngZ4rxYSEl3niL2PjQ1+xvRs+l1c1KIjTfisGs9yxocJDSs7sSt7bzzEKZ+Wy9s0wY
         I9qF0cMcTjsqMqG2X/uT2ZQsiIHGjlD27qSNcde5p9S7200KoI5t1uR9jqQl+RchkayR
         g79BV/OO3a6WJmJLYGbx0eJTusqMmY65d5IAzrDQj0CXOREDbRIxOcCH5tQkL7f+6Kj8
         dxdPIiNPuD22PNPcS6uxm3b8yCELAF0d7cMhGnONxVY+LKN0EgqK8E4KzAA/C7XzVG6d
         l2ola7wmJhfO+ZlwgKGUbW0KpE0Yx6eGv8xyM79+abNujRKc5pvzEoOMxSXrRtuI43bE
         cC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722240481; x=1722845281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rl8HdNLgtv5Fxv2Nk9Of+lDPOeD8hPV7F8FWHfhtTmU=;
        b=t1oqbs7NbIYIK22/09Co9/jfsLAn2Q7Scn7cachBbeSSvPN/wBkngTUm4Q2gu1QVNE
         jNHcxeFSEWL43O/JNorW45cJpIbnkVZ7RVO0Cz11ROGPg9uJFTBf8bMZ/Tf872PQkWbw
         f6RhAX6a1xdwd4H4qPi15zN+/JJ7OThiTGCmhNr1GQqtSSUu1bEIrRJJQ7gZfE9xGtLP
         4HHP7EGbAFebgzwqmVtlb77fbmOzRQ0g9qILClk4qzPynoj0A0zjvuiUN3D1CKnNF016
         AOHi5qsGVEfsHkTVGLrVIvcTTS+E3rzSvqEL8+A1c80llJ0m8fjFrb6IxgL/G6d3MoBD
         En3A==
X-Forwarded-Encrypted: i=1; AJvYcCXOXiV00XcWL3tCxy2TWxz/kgYXq++mOwzuowZLZgUvWn7WPQ7CbANz0a3SXCOvOhAzCSFh0u58UlyP+jkSfUW1ge1sEmGcbDNy588dZyqMviXdhPEOz94vf5/ax3gDTTTripgKhV8wgQ==
X-Gm-Message-State: AOJu0Yw9lJd36LTc9StiEuAXlmF9BLXlOtwHKUXyr0AZ1XQ0dTbAOU3x
	+gs57iIYWYFShKcgKSJs/b5GwvgEZbbwhKK0T+Vk35ekr0+FmkNm
X-Google-Smtp-Source: AGHT+IGSPZPkd0loh76eNxSCbXh4tWMsSkZqipMIwMD0/JvF8wieYG1nkZYy/AvmyWaLsR5QnAao4Q==
X-Received: by 2002:a05:6402:51cc:b0:5a1:de88:a5ef with SMTP id 4fb4d7f45d1cf-5b02317f4c0mr5275599a12.27.1722240480627;
        Mon, 29 Jul 2024 01:08:00 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63590cedsm5352868a12.29.2024.07.29.01.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 01:08:00 -0700 (PDT)
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
Subject: [PATCH V2 2/3] dt-bindings: nvmem: convert U-Boot env to a layout
Date: Mon, 29 Jul 2024 10:07:32 +0200
Message-Id: <20240729080733.16839-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240729080733.16839-1-zajec5@gmail.com>
References: <20240729080733.16839-1-zajec5@gmail.com>
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
2.35.3


