Return-Path: <linux-kernel+bounces-275436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6B39485B9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D822B2197E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7CD16EB40;
	Mon,  5 Aug 2024 22:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlgHOr9X"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D0116B399;
	Mon,  5 Aug 2024 22:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722898755; cv=none; b=rzREHiy9nPSuxew5Dhi56NP08+vTS1oUatkvJxa8QmOKl0r6xKc3O3MDm/Cf/F7fR4yYzcbuxi9PV31lo9C++BDiitvWBj/iLDT+OsvPg9QvgWV7pPK1fXmcx68PeC8ABO/K/wa/Z26hBo/fCERjUXy0plNRvAdRCFPziqp74wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722898755; c=relaxed/simple;
	bh=3drE736KAQSub0SEAAPM8+vK4C5D1YTJF/PXybo2ewQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAJpdHASWZYat2yRpr1Cml7cMxlrwph7qzr0ZvVgukvaSSkSMnue5zEB3dPdLljsdq5h8Dd8zYQbrsz3/j1Ge+oIJ3QT+xnVSfzti8ELSGa0yELRtMWjGBPB+HGt3XX+DeP+AfgcotV0YQWo5NRYC98wMMStzYH7Qd9NcBC57xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlgHOr9X; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4929fa64542so2863596137.3;
        Mon, 05 Aug 2024 15:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722898752; x=1723503552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TlDE69PdaRI6NEvJJ9HZjIBwXM2vSCyzFfsf9EOO6M=;
        b=mlgHOr9X4+NRaeyN6gtcdCDsDiajBFSg9yK8/Ptk6f4fB1pd5mSruDIyn8FQC7aK6/
         hLp+gJ4Y4SGs67MPiQe2wITiv9wIxG7ouLoDHRlhZuwUvp+BiyvzMNDu0h8+tVe7QI6z
         P4YzAIYjTQ/+wIyCMUPycfbmO2ZHg+Ozrw43a4chxeBctYub/PREJWrE63yteClvh+kj
         h/C5By/jfmYk/sQR/ThBb4G6fGao0ept/vtnxVEj0AJ+rxqbFj2KsOqL4SvV+kKPFRFY
         HAT5HD8tu02o1dwAnA2DIQ6x41P48Q/CyQrO+0BWA7fhPhnOwQoGNgbucMkT0YTmpUke
         SG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722898752; x=1723503552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TlDE69PdaRI6NEvJJ9HZjIBwXM2vSCyzFfsf9EOO6M=;
        b=sMJTGhu7AjFD1R26mB+75k77cjx6IGgDby87ZSn47hjU+ouYZVqg3QiIxBfFQ05WOC
         4AmZQIvn/+NDNoFb4Aba8H0PZH6L3HNghlwLdRPgz5OgUSrVt+XpOPpIngt+NUtDjaVT
         rL0e3KEOOuDh6/m/e4Oc1TkHvRWBY9GdLlLJ2lk5lqip1bgJAhkowYHOWgzKPHrH7mYB
         vRvR0KdmKWQ0J+pmweFJENBCEfnuHM9G9d3bmAtu6p26glHwA2QgEMufAVNPrflx0BOM
         xMeRld4UALEoYs7Hm60zOfSGBHqSYqVUryubB7pvywKgJEY2s1deFf6bJwicJ+7/K0Oh
         heTA==
X-Forwarded-Encrypted: i=1; AJvYcCXBpz5ufvmaPvzJDB3CnxVIV6CSXmB3KbpnYpioRZgvW7Pt24uajcdfNahONV2MFrj7knv1Y9DOGKYwv/+MEEeQnet56DVgDQhMO/gPC0hC4hScmXM/cMjtNzsX60+XdYZ/CCZwwfWsxA==
X-Gm-Message-State: AOJu0YzliynGHA8nN7/yS4dxWeJplg19jBnxKw+KhAz07A8vXNSEQW/2
	FLQ0C7cTM0cE+9EsV7X5VvmLCCyN2RWPp0kGyEsZUlqnxKtjRUjq
X-Google-Smtp-Source: AGHT+IHuERLfmRU7rMI8BL/GbgSv3C62jjEP5fbGFQYAwBahNGlVXSPsRdJeVCp6pp1tl9h+Bkso+Q==
X-Received: by 2002:a05:6102:e0e:b0:492:9c32:5344 with SMTP id ada2fe7eead31-4945be19768mr17714227137.18.1722898752357;
        Mon, 05 Aug 2024 15:59:12 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c78ad54sm40028016d6.31.2024.08.05.15.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 15:59:11 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: christophe.jaillet@wanadoo.fr,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mehdi Djait <mehdi.djait@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: display: Add Sharp Memory LCD bindings
Date: Mon,  5 Aug 2024 18:57:50 -0400
Message-ID: <20240805225820.13798-3-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805225820.13798-2-lanzano.alex@gmail.com>
References: <20240805225820.13798-2-lanzano.alex@gmail.com>
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


