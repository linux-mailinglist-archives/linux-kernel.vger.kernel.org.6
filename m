Return-Path: <linux-kernel+bounces-263682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E3F93D940
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBD19B221E2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AD351C4A;
	Fri, 26 Jul 2024 19:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AM/SdpNK"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0C721364;
	Fri, 26 Jul 2024 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722023115; cv=none; b=owyObOtprSPxzHA9+7zG+6ERR9l82uQYwBXQxndkQpEGGNe+P2FUA8T4IUbEEEAB+M2u8lFA0uUTTSNUMGkwNsQKlrievac0mMssBKgGxiA3cKLeEsU5xhPzI3WBhNIDk7Ix9LKuIvbSdo98MmenS0vHgFWR3R/n7djLgAoVKds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722023115; c=relaxed/simple;
	bh=xXB1Qc1QpIuP0+vnkwgw9NjE0ZLm3JHlwmbAcfreBbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCooa5xtjNdUoR+OfrNvsnBi6VFQsoT1m2vm54slEkbz+asujYnp1MlyDPtGgWkFDYPx8kKZWqpTVvSXRiJRKKMFnwfEVa14aziXRl/FygMSe51PaRQcyJRXaJlHfJd2QGI96mmOn1abCAwES9xTOUFkqnxoFEj86GGQPheg/1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AM/SdpNK; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1df0a93eeso69932585a.1;
        Fri, 26 Jul 2024 12:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722023113; x=1722627913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXT+wFiyhjvpSkrlHSctlHVmY/Ns41WEic2qjTORCwY=;
        b=AM/SdpNKhYUcAwGKEXu/djw4rWgAfIPBJ2jRe3JtUqM/M7e4Gy39C3R+g4SCDJWPpC
         OaUJbOitLAVB0KmxCm4RW5f/LTK9YvNiUrvO4BNldj3BK2c7Wp+mZXnkqR4s7v9TnOpA
         2OOPNOlku+/lDsbvbYH9AqP9yOO5ZpciupwNF8TxIMoFbiaJsP5BnkeXJD9ZE758XNLq
         xV4HkED5Z8C7kVV4CSMmzwvXguUvmvDAskYztjXPFpWAFSdi6yR3LbIlFwhPXF2MRhfz
         //rlNw4vFoW+AvTZCmxDNgjtX5pNNTdDlWdpLIPNIlnPRZ1lww2OOH69WYpfy0Y7XWdU
         ot3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722023113; x=1722627913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXT+wFiyhjvpSkrlHSctlHVmY/Ns41WEic2qjTORCwY=;
        b=tM+MtdZ/nlf+wa0GL0cr84bXekU7BoakvuYp+voKiHPComhyMKFEgHregrwaheNF5U
         19LYAV5hBcoPEPA7BKP7eCV9HZ3mXUBlgVX8evkZMap9GSWInSxHoCWXe1OI5PCvnpMG
         LOPAYCN5Ov2i1dHFwoe4AZ+AdD/eeshRLj2MGmfKyMI7seRTK2jorpTeL9WyTG9rK3/5
         q1VhTJc4321SrQpkNf03aameG+j63e3d5LXUEENzy6DnsyNVzZH4yvv3c2Fp8i48c2oH
         ape4p5Nh9JdDpaSJ6nQoknyknkLOhA4cQ7aQcbbAR0QegoXxousWLr36Pdo9kIwkJ620
         QGFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh0FMjDbqscHTXLfFt7Sp3ec+9LOEZjN3sVqh3QPVp+8U7RTdxEkpfbfLlj1GZpLV1KfjpUQGYDVjECKb763IXApWIHOjaVk8bIbDOwgqe9oBaEUkoBRUUXig0Hp/sV0JJLYgniVzdvw==
X-Gm-Message-State: AOJu0YyrN/M3lUdokdMCxJL0sf9cd6WPLucjTKjlpzSB0CutSlmE9f3e
	L91fPJ+IWg9JuwJWcPr5HWk8brPdgTS1Fs0az0GhauHsQ85+Bh4y
X-Google-Smtp-Source: AGHT+IHetmOgnr6iiqVdvKKSkNIgh09fAuvmH6sh7ueQCFYgfq+nzE4G03xYGVAiQKb4MhfrwejxJQ==
X-Received: by 2002:a05:6214:20aa:b0:6b7:980b:e0b6 with SMTP id 6a1803df08f44-6bb55a2e971mr9010276d6.26.1722023112927;
        Fri, 26 Jul 2024 12:45:12 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8f83c9sm19409986d6.38.2024.07.26.12.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:45:12 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: mehdi.djait@bootlin.com,
	christophe.jaillet@wanadoo.fr,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alex Lanzano <lanzano.alex@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: display: Add Sharp Memory LCD bindings
Date: Fri, 26 Jul 2024 15:44:25 -0400
Message-ID: <20240726194456.1336484-2-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726194456.1336484-1-lanzano.alex@gmail.com>
References: <20240725004734.644986-1-lanzano.alex@gmail.com>
 <20240726194456.1336484-1-lanzano.alex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the monochrome Sharp Memory LCD

Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
Co-developed-by: Mehdi Djait <mehdi.djait@bootlin.com>
Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
---
 .../bindings/display/sharp,ls010b7dh04.yaml   | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml

diff --git a/Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml b/Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
new file mode 100644
index 000000000000..79bde7bf0d7d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sharp,ls010b7dh04.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sharp Memory LCD panels
+
+maintainers:
+  - Alex Lanzano <lanzano.alex@gmail.com>
+
+description:
+  Sharp Memory LCDs are a series of monochrome displays that operate over
+  a SPI bus when the chip select is high. The displays require a signal (VCOM)
+  to be generated to prevent DC bias build up resulting in pixels being
+  unable to change. Three modes can be used to provide the VCOM signal
+  ("software", "external", "pwm").
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
+  sharp,vcom-mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      software - This mode relies on a software operation to send a
+      "maintain display" message to the display, toggling the vcom
+      bit on and off with each message
+
+      external - This mode relies on an external clock to generate
+      the signal on the EXTCOMM pin
+
+      pwm - This mode relies on a pwm device to generate the signal
+      on the EXTCOMM pin
+
+  enable-gpios: true
+
+  pwms:
+    maxItems: 1
+    description: External VCOM signal
+
+required:
+  - compatible
+  - reg
+  - spi-cs-high
+  - sharp,vcom-mode
+
+allOf:
+  - $ref: panel/panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  - if:
+      properties:
+        sharp,vcom-mode:
+          const: pwm
+    then:
+      required:
+        - pwms
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        display@0{
+            compatible = "sharp,ls013b7dh03";
+            reg = <0>;
+            spi-cs-high;
+            spi-max-frequency = <1000000>;
+            sharp,vcom-mode = "software";
+        };
+    };
+...
-- 
2.45.2


