Return-Path: <linux-kernel+bounces-246554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3911292C370
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CA928275F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFFC182A5E;
	Tue,  9 Jul 2024 18:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akNPpfxv"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CDF18005D;
	Tue,  9 Jul 2024 18:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720550629; cv=none; b=mfzLk48V5gXCsXq5EkVvZWlSn22PLmAEjyeT9oRhaDUlcbVtv8yVB9J7QsW8ntkJlT1Dv4hRASjfUMIzjL89UqQ4rzAtLRlnAlqGWZ0xhxzw/KsFN8zts9p+bEug5xap+E72dMT98swX94xZ4RE/4V2BYrELHG+ZyuwDRQlpiek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720550629; c=relaxed/simple;
	bh=VCkxZ+pGG+YSVbanqtrhKtfrCSVwsi7AFT3M1DJIRSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cW0siFjtJcZdtqrElMTKzUkB61yvOgVCAaT/wTbX5Fam4wfJhrxWscsbR2GdxdhHktIlicrb7KVSHT+wHh4Ilb/djiAA6XHhzlXTK9K/5DsHslSnRXGtjqtD8/8uerWZileoYM1ZGzKRtQCv3qk1bXiOvtL6v3NebUB0arr1o1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akNPpfxv; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d93df6b54dso618179b6e.2;
        Tue, 09 Jul 2024 11:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720550627; x=1721155427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/EJpK7h0+8kfla+x9mc6dab7bKKbfLCaCqSeT7reyNM=;
        b=akNPpfxvUdliG6i9mZCH8d6rqB/vhI3Zdx11hVUDjuwgKOQ0geo+UrDzw/RKGqtzFo
         mk52qbVV/rjaGyY1wReNoSEUAm1+q0lphfyR17Au/e9zCj8PIwt5FQbiYxjBNYBZVafy
         Kc2jKJhi7VsM+mJXbpMc5hujQzkvAN7XggfBk7OZeJhUhGel1HdDubGHmf8FOzNYE4Y6
         udZhpWTizPGezaY1UMSQ4G45H97wskEgOT5lmjophuLVb3O+Uk3sWEiDiJIgwUCpJLcS
         EUe808aU2orEhutjzDk0iEFDSucnAJSSkSzHo+mgWZK+Pa5UPbP0j6RSa1akMuxxINAd
         IqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720550627; x=1721155427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/EJpK7h0+8kfla+x9mc6dab7bKKbfLCaCqSeT7reyNM=;
        b=sB4TWWl+rekhsy5dFEPszmXHE1MOalCtaCc34mODY2ZuT/7HTCS8Xep9ZE+0ECooZu
         91TQMeIjstDA1GcEnPHw7FxjdP0kLfegqfg/H1hdMsvehtopjJUw1TWLswjDICccr5gV
         ggIIryol8z6tg94dkyPuQCj+Eqv8nIOWrCxPr8/oyD+5nDA/5VmzZEo4QxxYr08wg75I
         Nkz0QD6lfaQ0aZp9V0ga+IEmJ+GUMfdUli5kMavXJ0XaelmbHGYFXtme5oCjDiGBMQAP
         52z8s/XVT04fbWo9M3Pb1FW5fAntVAEAPP6A8eLhH3Cpm0Lsp4O8tRUH52/tCHlfNqaR
         efOg==
X-Forwarded-Encrypted: i=1; AJvYcCUS1OKULJEvQYzWmTyU/KkSMKmKc7SAQAGBB+qF8rLUmPdFc2rLrD8xT2r/lY5Eyanlvd/s8FoHbo4Pfv9gJEOqih2RdEaS6Xq1Fc53VUQCBGIxVav4IBHnknXXn95BXR59mNq043Qzrx1bCo846f0Qe3nk51P0EEQqRoo/+wiMFVrjJy4w
X-Gm-Message-State: AOJu0YzQ5lM7oqqyAGTysNfe6ZBcx+L56sQ8iNWOqDqT7rgy7uiaQigE
	1rG8oOPXwDZ8hv6OKKJ0Rmx7ZrwzkhjrX9UEeVYFbhhrhAEypHi0
X-Google-Smtp-Source: AGHT+IETG2JaYyEkIUs57OEWEyQjKyGmBijThps0J2yxIds1meOyf1V8scuBk/IWotf98tiQ4xEPJA==
X-Received: by 2002:a05:6808:148b:b0:3d9:2920:bc2f with SMTP id 5614622812f47-3d93bdd1669mr3866455b6e.10.1720550626620;
        Tue, 09 Jul 2024 11:43:46 -0700 (PDT)
Received: from fedora.. ([45.118.158.79])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d607d5fa5sm1741683a12.31.2024.07.09.11.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 11:43:46 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	patches@opensource.cirrus.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: dt-bindings: cirrus,cs4270: Convert to dtschema
Date: Wed, 10 Jul 2024 00:12:25 +0530
Message-ID: <20240709184231.125207-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Cirrus Logic CS4270 audio CODEC bindings to DT schema. Add
missing va-supply, vd-supply and vlc-supply properties, because they
are already being used in the DTS and the driver for this device.

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>

---
Changes in v2:
  - Added proper description for power supply properties.
  - Added ref to dai-common.
  - Added '#sound-dai-cells'.
  - Dropped unused labels in example.
  - Replaced example node name to a generic name.
---
 .../bindings/sound/cirrus,cs4270.yaml         | 59 +++++++++++++++++++
 .../devicetree/bindings/sound/cs4270.txt      | 21 -------
 2 files changed, 59 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,cs4270.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/cs4270.txt

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs4270.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs4270.yaml
new file mode 100644
index 000000000000..336e11773694
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs4270.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/cirrus,cs4270.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic CS4270 audio CODEC
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+description:
+  The CS4270 is a stereo audio codec. The driver for this device currently only
+  supports I2C.
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: cirrus,cs4270
+
+  reg:
+    maxItems: 1
+
+  '#sound-dai-cells':
+    const: 0
+
+  reset-gpios:
+    description:
+      This pin will be deasserted before communication to the codec starts.
+    maxItems: 1
+
+  va-supply:
+    description: Analog power supply.
+
+  vd-supply:
+    description: Digital power supply.
+
+  vlc-supply:
+    description: Serial Control Port power supply.
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      codec@48 {
+          compatible = "cirrus,cs4270";
+          reg = <0x48>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/sound/cs4270.txt b/Documentation/devicetree/bindings/sound/cs4270.txt
deleted file mode 100644
index c33770ec4c3c..000000000000
--- a/Documentation/devicetree/bindings/sound/cs4270.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-CS4270 audio CODEC
-
-The driver for this device currently only supports I2C.
-
-Required properties:
-
-  - compatible : "cirrus,cs4270"
-
-  - reg : the I2C address of the device for I2C
-
-Optional properties:
-
-  - reset-gpios : a GPIO spec for the reset pin. If specified, it will be
-		  deasserted before communication to the codec starts.
-
-Example:
-
-codec: cs4270@48 {
-	compatible = "cirrus,cs4270";
-	reg = <0x48>;
-};
-- 
2.45.2


