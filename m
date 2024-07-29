Return-Path: <linux-kernel+bounces-264965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FDE93EAAB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D8C1F21DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEEA78C6D;
	Mon, 29 Jul 2024 01:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCJROw88"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1901F2C861;
	Mon, 29 Jul 2024 01:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722217456; cv=none; b=bK5XO8Nlsb/JNJSb4dHS33ECc6q3+ugfKmLXm9gFF1PRsFvc6+LeG61i7P1Y5yL5reeft+6NfDbf5cqJSJ2BC1oMQx3eduzbGAlKySywHCrXWCAXMSktAx7YlrPydQ2oi+NDT7RRYzYxmocDiAikUcdgf9WxuWBo7cODlQnicEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722217456; c=relaxed/simple;
	bh=1Kjce9NUJo+797HEI90jfmHAaOgPKQucLsKNc9AiKo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6arPaGPZ1N+zIL7grtwLzWYwX8GyCtueKF+3usw7pjch7dQTrF3i9bB/gSLGygU6NeIi8myWrbRJEg+T3I2uktL8awK5jOnsKjiCyXW0sJAw1CtwfwURphKpuHSMbQRietu46BjW9jQrMhgQ4vaTQAP+Ogja/eX6EwdOKQMXjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCJROw88; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a1dd2004e1so178476185a.3;
        Sun, 28 Jul 2024 18:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722217454; x=1722822254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfBdzHirvwzeGzsbgCKAQ58RGrXODzjEORPTNKuV9o4=;
        b=cCJROw88lCUWGvcMGbXSSYh3zGzGrSHXhFaWNC4UseLk3hBENz1rTiyiPbD0cLGBjn
         albAzJ3lhah5LC4YEBlYlEikUHrO3gVtPBLJBjeLeG3wAXD1GHicZChMv9L22QAvvO4S
         aOni46V56N8o3BdMVg/xpHb/p0xQ3uum4IXDSH8D72PZhjiXfjkeIn1txe4E7iPEYqRy
         ytUpwJeTM7Ud22nUpZtcLqCErz6l9RPz2Xne0qKh9Sv5XPn+uuwoSL5Iq2X0eYPBGizk
         pHLiNDkwvUxnJBoEh8bRgFg85WDEf5wUBfcUWKuAlHmDzqK658srmzkev2iBwh4IUB8s
         lG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722217454; x=1722822254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfBdzHirvwzeGzsbgCKAQ58RGrXODzjEORPTNKuV9o4=;
        b=ZkRk7Zy0X0l4fWnMvFnqVYSySoJhAMAeyhBnygY8bGohSlC6L8ebj6n2hDabapiDm4
         eGRJFO79+SaTwjKSn04igiJ8lH+7VHf0RyXDQ7+zMpDxPt57QE1n8tOC3j72FbPqzYpl
         2j9AFEmSCToQT0P6Hm18ZLdbNDqcMMRSiAoRxqj2VRWu2XE1RO/taavheBir2iGyuBvy
         FvZ1zkQxslpXgY2+jOG3xW9IQIHxwTLtW2/Gec+GmWw4/jgDYBq/qFjiKeV4dDIfQq5U
         8Y8xM9a/zpGsxymDB7BZLfFkDq9kOXt3hKSigbsLzwaWs2uJEkQTWDAUP6hlDPlSNCLo
         jzew==
X-Forwarded-Encrypted: i=1; AJvYcCXHBYwFKBsqAm225Ux+KTYVtJWajQasDDFaiYF1iyF0uFcsAHl/AC2f4b6muir89s0nKO57cKNYyHfEAzVkyAj5JAtjlLjYvWrCzygYfcATHRt2jx7wwSLK4mqe9DlvE0cWBI/Ua4oQ3A==
X-Gm-Message-State: AOJu0YxJ6D930In0SUP40hPrlMTBxCeBgmXnZTFb/9Zza+oo46SUNbM+
	0MY9t2idhtUQLFR1AQVxxW8VmIDfsHWYlb7dB0nDvCTv8JPDXVlJ
X-Google-Smtp-Source: AGHT+IHE+YFJJvmf6lPjsaiXU3M+j6OcZqwwlKCjIQ3Ft+bCYjRdz9W1xxCh0VvFj//pquV/o6nekQ==
X-Received: by 2002:a05:620a:4488:b0:79f:498:2a67 with SMTP id af79cd13be357-7a1e5247a0fmr926324285a.21.1722217453830;
        Sun, 28 Jul 2024 18:44:13 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8199a6fsm37191171cf.58.2024.07.28.18.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 18:44:13 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: christophe.jaillet@wanadoo.fr,
	Alex Lanzano <lanzano.alex@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mehdi Djait <mehdi.djait@bootlin.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: display: Add Sharp Memory LCD bindings
Date: Sun, 28 Jul 2024 21:42:41 -0400
Message-ID: <20240729014311.1746371-2-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729014311.1746371-1-lanzano.alex@gmail.com>
References: <20240729014311.1746371-1-lanzano.alex@gmail.com>
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


