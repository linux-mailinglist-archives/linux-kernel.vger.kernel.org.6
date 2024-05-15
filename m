Return-Path: <linux-kernel+bounces-179528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B249B8C60E7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629D7282FDE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B1D4084C;
	Wed, 15 May 2024 06:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kurWJ3MS"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD7A3EA9B;
	Wed, 15 May 2024 06:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755318; cv=none; b=Wn6NxzcQir0TRKRvO2F2zpOr5hhhau6fpRHhS+7p2NpA5+nW0a/ILD1lZGMaAc+TQGNwW0CDKUUz9fkcXltldkm6eBsoJ6gqoxr3kNMyAsTp+IPx5utiVYKLt22Saw2HGXxIFlDRv7HfBAC+lBOvbne+QOsJK29ZvUZT/ixJLwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755318; c=relaxed/simple;
	bh=GJ6J9YyFmj5g0mLE7msIu5MKiPfm2okuFb6jCKJOrlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IjhhOHYHg4Dv7NPPfuOFAC5jeZhSQZlZG5H/QlM5VkuT4dulHGFe7S8NLUkzqWFifL7V8+EXfUqnWXhl/mY/WsIIP8RBMkfGf9qZ04ohmJGS1hgo5SLzmxghqKlRaCVDM2jl+TqVirpQw29/U8xXIMoRyX2xX09t+vWaThBnfhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kurWJ3MS; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ecddf96313so55199835ad.2;
        Tue, 14 May 2024 23:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715755315; x=1716360115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vbAesE2cgL0USUqqC14KPMjK7GiW9OFjlcB1Mo1yRY=;
        b=kurWJ3MS3zNIzyBVKFOT4KL9L3YcSiej077cQKz3QzSq8MzpgZxUSVVv9GL42SRofy
         kM3SITdGtgo/uGBM+SSQ0sYNXdj1u63NSpcc4sGASDdv1xDd4NMSlVIbK+0SP0e63bs3
         7Y1WxHQ9W8xiads3Bi3r4iMFQVXuhWpBfpL5BsF8oDYUrUPW7EdM6o3+fNAkHXWmfNjF
         /iGOY6doQTsAKE97nLqKqqNG0upwn3jFR2ME3Mb4gt32obhNUckZYf3Fs71I5j616NQt
         wyE5XMfesv0EPYtsVPE0rgtAza0U28KL7GpNoSxvCgDvyEGC24H0Ia/s0Xlsqf7qx8Yn
         bLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715755315; x=1716360115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vbAesE2cgL0USUqqC14KPMjK7GiW9OFjlcB1Mo1yRY=;
        b=ivLDYqf8uK7+Yr4TgUxQTiepF/bJQei5a4FWzFRjLBJLk/fDkYRRfTF/pxXoqOhV/e
         to93dgyKhBLBBcDyd3O8tByoSsAiwxp9YLFibtQhCuw1ruCB637V2mMDFYJEptDBbhpz
         TBdKMLBNkP8VVsaRwfpoW9+Q34/dlYDueTjM5CQgef69rCUqXEbhqsK7J09rzc/gA1Ir
         2kuzf4OVdju3BSTDCuN62VgyMByBr8oFNRmIXLi7+hzgGtkocoN93LWDrSiAT7pR06ub
         PIqgKRt24bS15VVdLkvOMOV0qwy0x/cnuwEsCOP98EuMNC/zTS4bfJkG07xOHEq7uqXN
         2odQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoMbv+GXzH/oLx4KSM7ViII0jzD3YMm0bpVX94zLQWJnk0QGz3B8nbalob2aqZ8BaW8TRFCDZYrBnfJB4I745JU25lA3ZMjhhqTr8tGkgBR7jYGmT96eEu4pluB7d+lSG1E2xCuBdXlZY=
X-Gm-Message-State: AOJu0YxQzDvmyzXzSRteWGy4fFsGE5auWcQcB+IxFiR3LJc7Q4ee5YOI
	4QTuUAqD/mr8U0qABoTnUUb6vm9lAIwtIHhnGH2120S01qglsSs3zze9Xkc9KeM=
X-Google-Smtp-Source: AGHT+IE+WGr6yPwajwKZrvVsEuPpSp4fcpQ4EjJnE9CHFCSlun+DnehwrGK/Fql+9T0Sui9S+jpm/w==
X-Received: by 2002:a17:902:ccc6:b0:1e9:470:87e3 with SMTP id d9443c01a7336-1ef43f4e323mr254736905ad.45.1715755315224;
        Tue, 14 May 2024 23:41:55 -0700 (PDT)
Received: from xiaxiShen-ThinkPad.gigstreem.net ([66.160.179.28])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f08c5f0294sm17177315ad.208.2024.05.14.23.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 23:41:54 -0700 (PDT)
From: Xiaxi Shen <shenxiaxi26@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Cc: shenxiaxi26@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	javier.carrasco.cruz@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH v3] ASoC: dt-bindings: ak4104: convert to dt schema
Date: Tue, 14 May 2024 23:41:39 -0700
Message-Id: <20240515064139.456735-1-shenxiaxi26@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ab4186fa-5a2f-4f97-9aa7-75a6c55bc142@kernel.org>
References: <ab4186fa-5a2f-4f97-9aa7-75a6c55bc142@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert ak4104 binding to DT schema

Changes in v3:
 - Use unevaluatedProperties instead
 - Fix indentations in the example

Signed-off-by: Xiaxi Shen <shenxiaxi26@gmail.com>
---
 .../devicetree/bindings/sound/ak4104.txt      | 25 ----------
 .../bindings/sound/asahi-kasei,ak4104.yaml    | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/ak4104.txt
 create mode 100644 Documentation/devicetree/bindings/sound/asahi-kasei,ak4104.yaml

diff --git a/Documentation/devicetree/bindings/sound/ak4104.txt b/Documentation/devicetree/bindings/sound/ak4104.txt
deleted file mode 100644
index ae5f7f057dc3..000000000000
--- a/Documentation/devicetree/bindings/sound/ak4104.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-AK4104 S/PDIF transmitter
-
-This device supports SPI mode only.
-
-Required properties:
-
-  - compatible : "asahi-kasei,ak4104"
-
-  - reg : The chip select number on the SPI bus
-
-  - vdd-supply : A regulator node, providing 2.7V - 3.6V
-
-Optional properties:
-
-  - reset-gpios : a GPIO spec for the reset pin. If specified, it will be
-		  deasserted before communication to the device starts.
-
-Example:
-
-spdif: ak4104@0 {
-	compatible = "asahi-kasei,ak4104";
-	reg = <0>;
-	spi-max-frequency = <5000000>;
-	vdd-supply = <&vdd_3v3_reg>;
-};
diff --git a/Documentation/devicetree/bindings/sound/asahi-kasei,ak4104.yaml b/Documentation/devicetree/bindings/sound/asahi-kasei,ak4104.yaml
new file mode 100644
index 000000000000..86f6061d3c50
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/asahi-kasei,ak4104.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/asahi-kasei,ak4104.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AK4104 S/PDIF transmitter
+
+allOf:
+  - $ref: dai-common.yaml#
+
+maintainers:
+  - Daniel Mack <github@zonque.org>
+  - Xiaxi Shen <shenxiaxi26@gmail.com>
+
+properties:
+  compatible:
+    const: asahi-kasei,ak4104
+
+  reg:
+    description: Chip select number on the SPI bus 
+    maxItems: 1
+
+  vdd-supply:
+    description: A regulator node providing between 2.7V and 3.6V.
+
+  reset-gpios:
+    maxItems: 1
+    description: Optional GPIO spec for the reset pin, deasserted 
+                  before communication starts.
+    
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec@0 {
+            compatible = "asahi-kasei,ak4104";
+            reg = <0>;
+            vdd-supply = <&vdd_3v3_reg>;
+        };
+    };
-- 
2.34.1


