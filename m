Return-Path: <linux-kernel+bounces-572053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C2DA6C5E2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0D23B5CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01639230D0F;
	Fri, 21 Mar 2025 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhZwgoC9"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4FF1F1539;
	Fri, 21 Mar 2025 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595879; cv=none; b=SaZ2q5EhtfP+s/3K/Z5cm6l7OH/TMFNRSUVPaElZQ3BJnco6ye3N194IeFZzPmoY+uSy3HnSAbd+1B6ycKLMzusaOTwAfi3vaRKdZ+/p3fJV1EDt+cAAt3AD6sqsEFxusDiTHdABgBn48yokgYtdMjIzeWbMuHzNCr5300x5sOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595879; c=relaxed/simple;
	bh=WZhtSDxPj4FGIxmxkfktGZYq6H5wiHjlyV3qnIHuFD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmGDWHav6vH65Q+XBiJ8B2PQpFXTVXCYZMmnJPUkx/mNLB9BBj9A8jllMheQxFpmeaJS8e5eG47gZuX1zmJx3Z/PCfIPtBX0glVpAuGLWMWSSN5GMLUEO83R7rWunSjekUJjCvpdz0lse+Wk69mWkLqREs8+0SdppbVtsaSiVOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhZwgoC9; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2a9a74d9cso512029166b.1;
        Fri, 21 Mar 2025 15:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742595875; x=1743200675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQWJDCA9LRyH5etebVtY5livhzxQ0HXmTvkCVm+e9LQ=;
        b=fhZwgoC90iaW970gGFD18q505i5qeXsLfswc9nzsvZNA0y0pD7jjZ8Qa5tUykjgln2
         mwD2NQ55XSG/WPMWFgeS1YzcMcf8BcizV7uHhJ3s+CsbS19rycNAqi56SRACl1+Fw/n9
         VqkPZWpMLywTuJAlkf50llC4FvVxszcFYwjot4qKjbMJAV+BIDMIxr0lDF2VK9Ojnh2j
         UtSq7kYMPjYoJUC6e5vXRUi14Tc0YWZzkDTxx+n4D18L4fSWEWuxptn9ihc8qIzn8Aci
         cGfNkHRIdoQLxr10Y6M8RzoCXR6TmwUOGMGIspXGxbAYDOTmZUlXjdZQWXY/qC3yiZWE
         z+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742595875; x=1743200675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQWJDCA9LRyH5etebVtY5livhzxQ0HXmTvkCVm+e9LQ=;
        b=Ipddk/9PIJuRQ+gEuduI5jWAB8rOcyewHhErIBt51ovViVqSNSFWIdjLAlYnrFq9J4
         0Cbhb/aKISSBFJuUD/sxyc+tjWBpAFTIo20dzj/41+Ng7fwgg4zitpJr7gHuGFbcOsqj
         jY1A+0gmoCpyRxXcO9XuVfLu3tGse0b6OB9e2CSHk/6/IAzlEjmizFP6YDsg1mUtqyoT
         leIW4HkTenCVK2RMt7FFzn++hQBA/WnWFR8gnYeoG9HQ7QXgnRybtcBMXB19oI0qeX+s
         uDGdUHFjRsmioK+uBVRbo9ianLF76HK1T9459lmBM/ts5d9LfO4X7kzS1MHoSZI3ORvZ
         sHQg==
X-Forwarded-Encrypted: i=1; AJvYcCUkZECVP0dBSZ6dT7Tmqy6ki9THtqDIi4LDTa9TO17J9mhISIr1vqYCBj2G1oGyKHa5Vl/p4FyelX2V@vger.kernel.org, AJvYcCVGxGuxJ/KLji6/PHGF6h7Vo2Rvq4ImsrMip75UKHlzql4dr1rIWJvY34J1Q/56WONcOJ4IWOSTYxKRRvU=@vger.kernel.org, AJvYcCX17ZuV/TYYVFM0z50YLeiyYpHak/9cGGUqLjSmK+Psgp0lDskjCNodkeaJ5i++LTkKcyqVHSWfUrE8K40Y@vger.kernel.org
X-Gm-Message-State: AOJu0YzC0CiQ1fmxyE1L4+rTEqCmqR05SKOZWzkmympdp0JcuAYr9OvO
	bjjlJJj6DMqBU+KqcnFkdiZMGxoAqWPqrGhx/xvf7+8MUQUzi0J1CLDJfc2C
X-Gm-Gg: ASbGncuM+dvaRx0la7IWGUV/0oabr37ZTxCxls1SAZumPnkACcvzrLTY7qgSBZoQM7w
	dBiO+OU/OHPWIE7YJD840qDCNVRrPpzPqTNka9n2AEEFuXjzZq7Roze6xqFu9fxUeqADC/6IBVC
	LRP3xtUqOlhCZ9Y0sQ1HSfxGju9exm4W3YckjmZozr8JDSU+MJmwBHtMpmq+UCxnFuDIYBuEVzY
	d56MnGH03HqYhdVHFaY7FwpOlGZsIR87C5CJ4tt+y9FqaQAVZP2YrQlZGzgZg79MdcGyXabSvG6
	D3RRWJAV9GWrx82Q0LMKZTEC+VToOyuXN+o5b5nd2ihT2tfLTeCT5VXIVNKfXAGntWEMsqg=
X-Google-Smtp-Source: AGHT+IFoDtgmVq+F9CXaaonNCBYKUdHbEGb8YOqcO88B+5dnmetzQt1iDKLqJNRwchIQobUnW0q7pA==
X-Received: by 2002:a17:907:d88:b0:ac3:aae:40c6 with SMTP id a640c23a62f3a-ac3f20ffe56mr589675866b.8.1742595875129;
        Fri, 21 Mar 2025 15:24:35 -0700 (PDT)
Received: from CYBER-ABAKUS.kucica ([87.116.134.57])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac3efd24e7fsm217526966b.153.2025.03.21.15.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 15:24:34 -0700 (PDT)
From: Nikola Jelic <nikola.jelic83@gmail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rwalton@cmlmicro.com
Subject: [PATCH V6 1/2] ASoC: dt-bindings: Add cmx655 codec
Date: Fri, 21 Mar 2025 23:22:47 +0100
Message-ID: <20250321222432.8212-1-nikola.jelic83@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cdbb8176-d109-4a31-9393-5e1ae6767170@kernel.org>
References: <cdbb8176-d109-4a31-9393-5e1ae6767170@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver is for cmx655d audio codecs from CML Micro. The CMX655D is an
ultra-low power voice codec targeted at digital voice and sensor
applications.

Signed-off-by: Nikola Jelic <nikola.jelic83@gmail.com>

---

2025-01-25 Nikola Jelic <nikola.jelic83@gmail.com> V1
        * /Documentation/devicetree/bindings/sound/cml,cmx655d.yaml: added the device tree binding
        * /Documentation/devicetree/bindings/sound/cmx655.txt: added the device tree description file
        * /Documentation/devicetree/bindings/vendor-prefixes.yaml: added CML Micro, Ltd. to the vendor prefixes
        * /sound/soc/codecs/Kconfig: added SND_SOC_CMX655D and its dependencies
        * /sound/soc/codecs/Makefile: added snd-soc-cmx655 and its dependencies
        * /sound/soc/codecs/cmx655.c: added the main driver file for the codec
        * /sound/soc/codecs/cmx655.h: added the main header file for the codec
        * /sound/soc/codecs/cmx655_i2c.c: added the i2c adapter for the codec
        * /sound/soc/codecs/cmx655_spi.c: added the spi adapter for the codec

2025-02-03 Nikola Jelic <nikola.jelic83@gmail.com> V2
        * mailin-list: added the missing recipients
        * mail-header: fixed the subjects of the emails, to align with the norms for the subsystem
        * /Documentation/devicetree/bindings/sound/cmx655.txt: removed the file, obsolete now
        * /sound/soc/codecs/Kconfig: changed the dependencies between the configuration options
        * /sound/soc/codecs/Makefile: renamed i2c and spi files and fixed the dependencies
        * /sound/soc/codecs/cmx655.c:
        Removed unnecessary comments.
        Fixed the comments to conform to the kerneldoc format.
        cmx655_volatile_reg: removed unnecessary bool ret variable.
        cmx655_regmap: changed cache type to REGCACHE_MAPLE.
        Changes symbol exports to the GPL variant.
        Changed usage of master/slave to primary/secondary.
        Introduced the constraint mechanism for the baud rates.
        cmx655_dai_startup: added the function for registering the constraints.
        Renamed several controls and widgets to be more verbose and precise.
        cmx655_common_register_component: moved majority of the registration code from i2c and spi into this function.
        * /sound/soc/codecs/cmx655.h:
        Removed unnecessary comments.
        Fixed the comments to conform to the kerneldoc format.
        Introduced the usage of the BIT() macro.
        cmx655_common_register_component: changed the function's signature
        * /sound/soc/codecs/cmx655-i2c.c:
        Renamed the file
        Reduced the initialisation code, moved to cmx655.c
        * /sound/soc/codecs/cmx655-spi.c:
        Renamed the file
        Reduced the initialisation code, moved to cmx655.c

2025-02-07 Nikola Jelic <nikola.jelic83@gmail.com> V3
        * mail-header: added versioning to the patch series
        * mail-body: added a minimalistic changelog for the patch series
        * /Documentation/devicetree/bindings/sound/cml,cmx655d.yaml:
        Removed '|' from the description field.
        Added descriptions to all used properties.
        Removed pinctrl-* properties.
        Fixed description for the cmx655,classd-oc-reset-attempts property.
        Added minimum and maximum for the cmx655,classd-oc-reset-attempts property.
        Fixed the example of usage.
        * /sound/soc/codecs/cmx655-i2c.c:
        Added a holder variable for the regmap.
        Removed gpio toggling during removal.
        * /sound/soc/codecs/cmx655-spi.c:
        Added a holder variable for the regmap.
        Removed gpio toggling during removal.
        * /sound/soc/codecs/cmx655.c:
        cmx655_start_sys_clk: added newlines after for-loops.
        cmx655_get_sys_clk_config: removed brackets around case values.
        cmx655_setup_rate: error causes an immediate return, no silent drops anymore.
        Removed the constraints functions and structures.
        cmx655_component_remove: added a newline after variable initialisation.
        cmx655_companding: removed "enum" from the name.
        cmx655_alc_gain: removed "Gain" from the name.
        cmx655_mic_dapm_event: removed brackets around case values.
        CMX655_DAPM_MIC: new macro used for the microphone definitions.
        cmx655_parse_data_from_of: fixed the name of the custom property.
        cmx655_common_unregister_component: added gpio toggling.
        * /sound/soc/codecs/cmx655.c:
        CMX655_DAPM_MIC: new macro introduced.

2025-02-10 Nikola Jelic <nikola.jelic83@gmail.com> V4
        * mail-header: capital 'V' for the patch series version
        * /sound/soc/codecs/cmx655-i2c.c: removed version.h header.
        * /sound/soc/codecs/cmx655-spi.c: removed version.h header.
        * /sound/soc/codecs/cmx655.c:
        Removed version.h heaer.
        cmx655_get_sys_clk_config: fixed logical to bitwise 'or'.
        cmx655_mic_dapm_event: fixed reg_val checking.

2025-02-14 Nikola Jelic <nikola.jelic83@gmail.com> V5
        * /Documentation/devicetree/bindings/sound/cml,cmx655d.yaml:
        "compatible" changed to const.
        Removed unnecessary descriptions of properties.
        cml,classd-oc-reset-attempts: removed altogether.
        Removed "status" from the example.
        Fixed the order of the properties in the example.
        * /sound/soc/codecs/cmx655.c:
        Moved reset_attempts to the module parameter.
        cmx655_irq_thread: uses the module parameter now.
        cmx655_parse_data_from_of: removed.
        cmx655_common_register_component: doesn't invoke cmx655_parse_data_from_of anymore.
        * /sound/soc/codecs/cmx655.h:
        CMX655_DAPM_MIC: fixed formatting issues.
        cmx655_data: removed oc_cnt_max field.

2025-03-21 Nikola Jelic <nikola.jelic83@gmail.com> V6
        * branch: rebased to next-20250321 tag
        * mail-body:
        Much more verbose changelog.
        Fixed inconsistency between changelogs in two patches.
        Added "in-reply-to".
        * MAINTAINERS: added the "CML CODEC DRIVER" entry
        * /sound/soc/codecs/Kconfig:
        Fixed a typo in the SND_SOC_ALL_CODECS imply section.
        Added "help" sections to the added configuration options.
---
 .../bindings/sound/cml,cmx655d.yaml           | 62 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 MAINTAINERS                                   |  7 +++
 3 files changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cml,cmx655d.yaml

diff --git a/Documentation/devicetree/bindings/sound/cml,cmx655d.yaml b/Documentation/devicetree/bindings/sound/cml,cmx655d.yaml
new file mode 100644
index 000000000000..577e1d4942c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cml,cmx655d.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/cml,cmx655d.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CML Micro CMX655D codec
+
+maintainers:
+  - Richard Walton <rwalton@cmlmicro.com>
+  - Nikola Jelic <nikola.jelic83@gmail.com>
+
+description:
+  The CMX655D is an ultra-low power voice codec.
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: cml,cmx655d
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  reset-gpios:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: cmx-irq
+
+required:
+  - compatible
+  - reg
+  - '#sound-dai-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        audio-codec@54 {
+            compatible = "cml,cmx655d";
+            reg = <0x54>;
+            #sound-dai-cells = <0>;
+            reset-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
+            interrupt-parent = <&gpio>;
+            interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+        };
+
+    };
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 86f6a19b28ae..49ea70169b1b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -310,6 +310,8 @@ patternProperties:
     description: Carl Cloos Schweisstechnik GmbH.
   "^cloudengines,.*":
     description: Cloud Engines, Inc.
+  "^cml,.*":
+    description: CML Micro, Ltd.
   "^cnm,.*":
     description: Chips&Media, Inc.
   "^cnxt,.*":
diff --git a/MAINTAINERS b/MAINTAINERS
index cc6536141bb3..9d4b1bdb4456 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5801,6 +5801,13 @@ C:	irc://irc.oftc.net/bcache
 F:	include/linux/closure.h
 F:	lib/closure.c
 
+CML CODEC DRIVER
+M:	Nikola Jelic <nikola.jelic83@gmail.com>
+M:	Richard Walton <rwalton@cmlmicro.com>
+L:	linux-sound@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/cml,cmx655d.yaml
+
 CMPC ACPI DRIVER
 M:	Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.47.2


