Return-Path: <linux-kernel+bounces-252638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD3793162C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B8D1F224C2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4EB18EA7C;
	Mon, 15 Jul 2024 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4m+6sF8"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1949618E769;
	Mon, 15 Jul 2024 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721051776; cv=none; b=jRO80PQa6efJBingx1oWkmq4ACAO9GLXWWUrjE2q4bzx7QxtDUQlTrOMXiDNR1sX46qDV0UEYc5wD6nhm5c70oKSn97afKeVpKKCPNrQfaWFlgnYD0j3cgV/t8yGNP1xoryLxJTKHzQ4ObXKpcy6rnDO1XQkQs+C81fte7CqidE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721051776; c=relaxed/simple;
	bh=JmicNeKrNHRspeEe8Tj3/aopdoEQSKULODDnupH8/YI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fZ8I7K0yqVP/gGgbrTum8o71uBCJjbED1VNAihJV8jYNCDly0zkutez+ValO0rpj8n6maGwiWowNwKq7bpV/4UIl8ucDJBM8nJjCL8Kwh1sQ1uGCFzqDevRxN0XYmGvVowYQtkaVW/Sgs0mZ5zFqp1TWf6TafQFUUB6HZ6IJceQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4m+6sF8; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58b966b41fbso5368097a12.1;
        Mon, 15 Jul 2024 06:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721051773; x=1721656573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zJEofbM7JJv/OPvTziaKTUDT40OBgVWW/o2FBZFQ/8c=;
        b=X4m+6sF8+5ClnJXcv9voQoEmI2ldl7nd/IGMIARibcykmabfmJKe+vev1lA4pEvEsV
         9/F8q9frkczCqlo5cemyQCyZ9+vUMctsY6feJ9O7zJwRub0jZBD/X+ewzHE5uKvILT2P
         64R23yfbF8Os/WW10n/N5GWFvv3Uh4RZscal/pJcvHetSi03nRBpgrz1cO+aTL9sYBaf
         wRbE4rThNYPhXa8OGPiRyXbRLD13zNkHk90bMK8V8uzER8DADIX/7zhD9dPM4uqExYQz
         I+8DG76voqqk9lqRUqDlCRhFWwI/fMxwCfUDOWpRfoV4hqcsVVCkdA16jxbf2o2cR1h+
         0Qqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721051773; x=1721656573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJEofbM7JJv/OPvTziaKTUDT40OBgVWW/o2FBZFQ/8c=;
        b=rLsiNYv+pM7ofe+bFMnqnb912nGNCKNadxZWz/1MA61f3gfNvm27W3qP2QbvBSRfEO
         4miWR4602V8bZVODjWkZyk9CttlhcbKrmsQ57uTfjxtG8XOuEFIsh/Rs9XcX+AWeEApn
         LHlBmPTJz9LwOmYtEf+lU3eAydnjZ8BV7u9m18vLD6+q/xD7O61TdpHWcMtyvzzBTN61
         OGcmYukpSIWRHlGRuEpU7NJHkwnfqtuT5g+lZL0CfnQ/cj7evGoFYrfJZhCpeFpj//NA
         YSGIhOTNRUJxAQqck6YOLGUvc9Pq5Ou/MGiIq6ODc7Viof2A919qbhlPOVVb5cWltQc2
         lIHA==
X-Forwarded-Encrypted: i=1; AJvYcCWRXK0odXoivt4DTRjzf4zEG+3N2HCKRqWFgzYamG0U22QTn2QjCBmskdidinps5su9Ewwm81D1QtpyP59Vgfp63/d6nCfGeuchsDRHad8MiR0an/+QSwJNpAnRJQ6t41Au9lKZlVbN4w==
X-Gm-Message-State: AOJu0Yz5AZyeywZhhWppaY+SAox5dKs6zOGxWOjnvwY1qn6DqVpKHuuU
	b8yxJxz+8VuVQAOUFbjRTPEMP6CwlH/8dQ+bwkzAcLDd2o4GkKpGg+U/gQ==
X-Google-Smtp-Source: AGHT+IGFwyv96gykRh2WQAFospTSXU2UQACz9q8YtryxBrJrikNX9BsuYSLrXYopy2ZsFmRYUjaEzg==
X-Received: by 2002:a17:906:2797:b0:a77:c5e4:eebf with SMTP id a640c23a62f3a-a780b87ef50mr1185426566b.54.1721051773034;
        Mon, 15 Jul 2024 06:56:13 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc820fb5sm214152666b.212.2024.07.15.06.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 06:56:12 -0700 (PDT)
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
Subject: [PATCH 1/2] dt-bindings: nvmem: convert U-Boot env to a layout
Date: Mon, 15 Jul 2024 15:54:33 +0200
Message-Id: <20240715135434.24992-1-zajec5@gmail.com>
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
I'm resending this approved by Rob PATCH in a proper series

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


