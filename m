Return-Path: <linux-kernel+bounces-292951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0548F9576D7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C3D8B22A46
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E129F188CC5;
	Mon, 19 Aug 2024 21:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlunzHgv"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD9515AD83;
	Mon, 19 Aug 2024 21:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724104234; cv=none; b=iwnNn1w+0rDfVSfJpybUuYdZRJOoLybV68of+br1o9RNQHEewLSQBTI9ICQerEnWFN0l3bwdJYFxoSLNOrynMLhJKYGIcibZSY8a+XU80RMcXXeC5g8XGeD4oYFDro5L18bVoJjqjpYDy0CP2SHGtEhX86AtdlWW/Y36sYafX3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724104234; c=relaxed/simple;
	bh=3drE736KAQSub0SEAAPM8+vK4C5D1YTJF/PXybo2ewQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EsHwG2sY3iDz0NRxSUt1+9HOrJ56z1HuKEOrB4Jt6NIjAD/COg5hbIoTIc1yrwgV+uf9K9uXE8njiFtcrV/QcdbOvmtaDfUQx2FBqb03RuBM3LeSW4OPJC9rHqdtAlo/zH4nwXBqetn6M220nyCfgAkqQa9rnKTmLkdSBCpp4bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlunzHgv; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44fdde0c8dcso27385911cf.0;
        Mon, 19 Aug 2024 14:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724104231; x=1724709031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TlDE69PdaRI6NEvJJ9HZjIBwXM2vSCyzFfsf9EOO6M=;
        b=JlunzHgvsAXhRaJFkKIPX323PsVfzN7T42khG9fzaHJsDf+/AWFd/E6fjyKil7icO3
         n+FP89LgAeXHVcssvbBcDftNSffxSSpnin4zOxKkEP7s5hYSjOmDdzrbEvEyrotbCiuA
         OJzkvthckiC2MASqbGYYDThkCh4RfMpdmzTrclbI8y7KB63efoTVj5rYT+XiaTPw/9uc
         qGBIbQZlk7OULM7WuHtatjx9EQsk5o4IGE7yavjp+nYjt/4iykBpNAge7gUGNq1j/i6E
         qC9eKw5IepRxaeiSiAlOo65vd7kIogT9JQ9hSaaK0Eor3/ZNXA/EQiMMzTWgyO/FPqbW
         NQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724104231; x=1724709031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TlDE69PdaRI6NEvJJ9HZjIBwXM2vSCyzFfsf9EOO6M=;
        b=HDLJ3u2ObLYl2VtjKuORi+7Fd6dTwIdBIRDC3DpF280/rCd8BqaS3uI1kUQzoxsH6T
         J1fw0mUizzFTX+N+olfTczevo7ov2m87VfXd3O2y+Y8gpeTATHMAnZF3aeNt8YOXLBFn
         Y8Ze164DEq8I77YuhkE60uTFM6FlNmARQnZP7vU3sgooUpxq059otqeO/PAtrBR20LcY
         cToPcmruJ8R/+0FIn2Aw91zfIhqYASg9J1yHRpiA4vKpRnBYUeBaiQZwmJF6HkbXK4vg
         FYYZEa2HLAbaLLWU8jzCOOP6Gk4vcXwfQWqr/Lpbs6AsWI16zAUq/zMNj22AanIXQTFX
         emUw==
X-Forwarded-Encrypted: i=1; AJvYcCWbEEaQoKgCU8tjSBVFrXMq5/mqgMG9Wpl6NsEn/X/dv2eFcbvZnspZC0q/O89KkA18Gsj7GNT5qdTCboMz@vger.kernel.org, AJvYcCXSeE2QXc2VryxfwPBwADvYdnRBLnV0SplqjaUVNFoIuIBR8b2ewWN+LA0SBCX419bYa+WDI5a+0/gN@vger.kernel.org
X-Gm-Message-State: AOJu0Yz75lYF3qNhA/Ojda7WD/0FhrUV/o0DOHLEuYXhULLPYzbkbhyn
	LXdoM2rmDbNPkeQxUclG9acbSKLf3uY+296C2ke/mCKX6xINYIEW
X-Google-Smtp-Source: AGHT+IF6hQkzKGEVguizB2ir6vco/5XQNO5iNu2WFO0gqnzobzfo2UQ+E8rKz1lTljZcmKX1+FvUzg==
X-Received: by 2002:a05:622a:2b44:b0:447:ef39:7188 with SMTP id d75a77b69052e-45374247650mr159918511cf.15.1724104231325;
        Mon, 19 Aug 2024 14:50:31 -0700 (PDT)
Received: from localhost.localdomain (23.sub-174-193-28.myvzw.com. [174.193.28.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454e5b2b0dfsm2432741cf.53.2024.08.19.14.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 14:50:30 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: christophe.jaillet@wanadoo.fr,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Mehdi Djait <mehdi.djait@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v4 1/2] dt-bindings: display: Add Sharp Memory LCD bindings
Date: Mon, 19 Aug 2024 17:49:00 -0400
Message-ID: <20240819214943.1610691-2-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240819214943.1610691-1-lanzano.alex@gmail.com>
References: <20240819214943.1610691-1-lanzano.alex@gmail.com>
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
2.45.2


