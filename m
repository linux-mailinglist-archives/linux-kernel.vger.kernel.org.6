Return-Path: <linux-kernel+bounces-310378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56148967BFF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 22:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76E521C2106E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 20:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5FF7D401;
	Sun,  1 Sep 2024 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoLeAZys"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543C1433CE;
	Sun,  1 Sep 2024 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725221522; cv=none; b=Yicf/n9gFWYHl/oNTfNgX4Lf8HVbfATX6Z2UfmS4V9P0ueE0888Jout8fEtRwbJ9OGuKbo5oKbjyzyTW1rNGOW8ujTdib37B10DIqX+kD8mueanKI0qZhjHLDEVDMrS3MyTHcIo+LUIPlxl6WjZfBdagoXsf4/7PZydaL1kZJYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725221522; c=relaxed/simple;
	bh=ATWjVFRLnSAGMkjhwfJQWOO/tfzmabf7vU0TjFmd0gY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1uF25zi3xn8Rphy/33EVdycylHUb5LL+hjR6TA8CP6Cn7d1NknQmHulh1uwYW/NcjcRvviHEb2nDOteSD17OM8MAVFa/XSRqVoQisL2ES8+ePuhaIh2tnktlVSc2zwQAW/EP+dBb6IGjWtoMEdohyZvd6lKEWkFbHuhlur/xwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoLeAZys; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3df687c6623so283144b6e.0;
        Sun, 01 Sep 2024 13:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725221520; x=1725826320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WK7eqKzfxTCXYjY4yBuvM5uGMWIrx3TALuq0TWoNpjA=;
        b=KoLeAZysEuTx8NpNAxSqrGXLx1ozsPfu8XnP63wabqt7VBEhowMgpNzShAJ/NvnPy5
         FQZapDIBdD/vj+j12zegPPLVt7A09TBxn264noJNA1yJDYFmhS2MG6iF+REEBOkt7ejH
         ue/kBikUgfZz3yL8O2aSk4l+qWAiUtNfYJyX9tw0r31rjqj+OFJBmgbNtNU6Rmwkh3HL
         CwlIN5uRpGe0Q/aCrW0tUj2QTdQOLohT+TH8frPQt9nLw8DNoozGAYS9sbY2UuVw2hg8
         erb9osmxJl6oftJIT/jva45908vjCISvf6GPjRqNaE0yd7FUSmEZsNvxbdzdBzaMxf94
         ccHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725221520; x=1725826320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WK7eqKzfxTCXYjY4yBuvM5uGMWIrx3TALuq0TWoNpjA=;
        b=kLwvgnAgPi0X1bwJ9EfKDJXqNzbV76IE4abNkRBrmaZNbSnYN2P6x9QeketupXfu1L
         GHIyK8T07HCrCTyrUJuLGbEKrM6GBpiWZLKyq8KZhK/ad0irW3LxdD95MEwd0RyAjgey
         DOeO5K2fH20yMMoKI2r0br6Od21UxRkGM+n/B+Jdyy/+YBFCqNdEI+lWAh5ISvZBVM8S
         berqZmY0aYCaOZCRxySunCRC8bd2OUXfcmc1mwH58PnU4fiwARhBtMUGk7ZS9qI0/7Lv
         z6sleUOnl+BYVxtOI2OPDyYBtHEtEVjcTCc6XLSB4XCTR/UDwjFgUQezcx/v7gC1osge
         Mm3w==
X-Forwarded-Encrypted: i=1; AJvYcCUhRgJW0bx8eKXW2RBx29CHnfe+V5j1o+0Jvh0bhvG7hYutrcudxtUY1uEpwSFclsCzo/SdTM5a7wVq37fQ@vger.kernel.org, AJvYcCUubklbiCi8KZOJxEtpUcHYYGTpKd7NsxLiW5/+PBWZSrLFG0dJzHMLyoL/vsGHNyhYI5q38TeQJbSs@vger.kernel.org
X-Gm-Message-State: AOJu0YxJxmeJgAmi4nrh9K+ENcK2D+v0s81IPR/O1HSmUjiX3XBeRolq
	2do4IgdtiK3BFifvOOFhXEHIRHybZ8PLPrTqgVSmGj0tUQ3xWpoq
X-Google-Smtp-Source: AGHT+IEO7V3UByUuTsWsUXgVd2L9NR39/cVWR3S7jRsH5UcHElVvVEfREF9DhFgBb6fbyyO2/ndK9w==
X-Received: by 2002:a05:6830:6d08:b0:70a:988a:b5fd with SMTP id 46e09a7af769-70f5c406907mr17173440a34.24.1725221520359;
        Sun, 01 Sep 2024 13:12:00 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340bfa823sm35926966d6.7.2024.09.01.13.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 13:11:59 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mehdi Djait <mehdi.djait@bootlin.com>
Cc: christophe.jaillet@wanadoo.fr,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: display: Add Sharp Memory LCD bindings
Date: Sun,  1 Sep 2024 16:10:49 -0400
Message-ID: <20240901201118.3179206-2-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901201118.3179206-1-lanzano.alex@gmail.com>
References: <20240901201118.3179206-1-lanzano.alex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the monochrome Sharp Memory LCD

Co-developed-by: Mehdi Djait <mehdi.djait@bootlin.com>
Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/display/sharp,ls010b7dh04.yaml   | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml

diff --git a/Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml b/Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
new file mode 100644
index 000000000000..8097f091c2a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sharp,ls010b7dh04.yaml
@@ -0,0 +1,92 @@
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
+  a SPI bus. The displays require a signal (VCOM) to be generated to prevent
+  DC bias build up resulting in pixels being unable to change. Three modes
+  can be used to provide the VCOM signal ("software", "external", "pwm").
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
+    enum: [software, external, pwm]
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
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        display@0 {
+            compatible = "sharp,ls013b7dh03";
+            reg = <0>;
+            spi-cs-high;
+            spi-max-frequency = <1000000>;
+            sharp,vcom-mode = "software";
+        };
+    };
+...
-- 
2.46.0


