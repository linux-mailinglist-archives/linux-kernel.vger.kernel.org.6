Return-Path: <linux-kernel+bounces-572054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C53ACA6C5EE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563FB484B0D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF7622E3E9;
	Fri, 21 Mar 2025 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6tmnr4B"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E91C1C3F0C;
	Fri, 21 Mar 2025 22:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595883; cv=none; b=tLWfsRUSdSVdbJmC29XTX4IwOi3K1w8Gj4EGqj2Gv3VkS7ZWp9MVwuRT4IYaxxxe+f9rCPEHKScrKMc99OAnrb8uWVn1cMhSJcr9f14sU49vZEgFp3fnPUGRCNhVINIEtNrLKSxw9gPPvAad+krcSMEgeYKi7JY5QKJM6X6NoU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595883; c=relaxed/simple;
	bh=qz24qExOSm2wfuJwsaYH1AjY6jzhdG234vl101J9svA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jraTvWVE/VWyuLbchp1J9lkV4XC+KKdv3enMffCxsscKr8KyuHutdEp04tcGdj3fuSSaSurV5MSj7KvYpZmyM9YfIop6kapig7vnJGllxsckfqivjcKYEjxglq3e5LcwDtzpnWGRuRe5xYpuEfDZ3UyftSIdvQvFipRLHchtLpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6tmnr4B; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso494188266b.0;
        Fri, 21 Mar 2025 15:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742595877; x=1743200677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6su0Wk8Q5LLrinLu3TIfd+Q+CGE/ahxXpo4bixZ1jA=;
        b=H6tmnr4BH8oyPyg0rFr0uySt7g6AwJ7S0dchD1PuHLMEdm9f/i5EhJHpfLDqw1oWxT
         x2TlF4+YqvSQtTRl7uj/CV96TJA/JHw8daz1LCnP03pFEfkmdIdaILPfpXI+j55A87by
         whe/WZ7SVZeCicuzzBidqc+dHvG/5y9tVc48DZ/wZc5eMK5mqic+AU0HEkRlcwhFD4X5
         spLfkbkFiRuJ3fQPZtHT0Y76LttcvkYXxbiUYNSYPs/hBDo0L9M/HPD3Z7BZiz0UZ5RU
         k1nURQwVwVfmqTRkYQzakNpJfYf++8Krgwrrq+ruXmW/97U+0MXFHPA1I6HhY5gBWkj/
         pn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742595877; x=1743200677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6su0Wk8Q5LLrinLu3TIfd+Q+CGE/ahxXpo4bixZ1jA=;
        b=izRt9fVR6/rQWYKn3u5IX9q9WC1r+qbODXO4rTW158CAUFZVO9I6n3EY7hh2Rk7OpY
         qQSe3wfa15OAtXHTgu94vDknD24xXFBOgS2apLTSv3xrbCmQrHhsiSiKE99Z+9mZf5XM
         cLkz3Xu32vI72y9Qwk2ZX67QFkIvKfewS3iDN4BfEtoFUUPSy/nAYtyDNrhdXdghvIWz
         41pVVNOzn+UuoEbJArbW3gUnrptTg3q07jZszqP5uL/gOenk54YKWdYVutEvgvi76h7q
         WTWIvZUavedWmz9ixyZ3dcO9xXaaWCJbfXg898chiy2YTWOHS0IqvLmjiLAjQ84Q49/+
         eeKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4Uo+H5W4pmWgl9Rkyr46M4hk/1tPjt/fjuQP69PMnHXltzV4tD60ONY6Q6UD751ecqZ+ZzZbAjpvrm3M=@vger.kernel.org, AJvYcCUjrZGut3OkZOEFFLA6DhDlBV5LTyln/VBh83TeMS2oVlcVIMwSXf9QFYqI4H73OBdub92IGynJRaDoVIXJ@vger.kernel.org, AJvYcCWqP58zrhOJruxJCxhPkU0jr2GhyzijCTw7TcXmdNnBhenmt4JxzMUEnUyh4HYG9iBdqjfFaRtQ7B7a@vger.kernel.org
X-Gm-Message-State: AOJu0YzzGrJOvwSztQ9E400AeKuNabylbeJN9fl/AqgGR3r25V1/PCgj
	2NVribpWXXiN7x0cvZzhwvtGv4cBC0coXilSf3gzAsYx6z2rhWpX
X-Gm-Gg: ASbGncsUcdrwGOEQzu31TZSTuFJlca1eSarzRndKKizG5hsITcF+nOWeGYr5KwpCDC3
	kL0r2425h6jbqAxo4ZFddFs0VU03Tgvl7iHd0UFrsJkEuHXYiqeBKSSjXewO6FT8yh5wazqgdaE
	QbIXEAT2VrFj5EaS2dBLj1ijNTPGS8bGl9LCdt8dhSmZdqD6tezm002u7PJVzaTGEeqoCLaWA55
	fQTa0aQVeeVVKbSTB0mZWzs9B7h9e7FyzYSTBjATbiJaFgMPQNYhr6dKd3zi5uJgNzp3ZB+MAKc
	O7a5Dex4Ih8ZBdc++vNfTFLZWGyCz53NlFC5UW9gKkFA7cbIrvfzN6h9Q9uS
X-Google-Smtp-Source: AGHT+IHI5b86sMAVWRF4+hKHifqW5G+CANlmMSpdHf+25a7aNLy8E30E2QKl9OpUgOq5Flne5HnGrw==
X-Received: by 2002:a17:907:ec81:b0:ac4:2b0:216f with SMTP id a640c23a62f3a-ac402b024c3mr217359766b.43.1742595876665;
        Fri, 21 Mar 2025 15:24:36 -0700 (PDT)
Received: from CYBER-ABAKUS.kucica ([87.116.134.57])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac3efd24e7fsm217526966b.153.2025.03.21.15.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 15:24:35 -0700 (PDT)
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
Subject: [PATCH V6 2/2] ASoC: codecs: cmx655: Add CML's CMX655D codec
Date: Fri, 21 Mar 2025 23:22:48 +0100
Message-ID: <20250321222432.8212-2-nikola.jelic83@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250321222432.8212-1-nikola.jelic83@gmail.com>
References: <cdbb8176-d109-4a31-9393-5e1ae6767170@kernel.org>
 <20250321222432.8212-1-nikola.jelic83@gmail.com>
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
        Removed version.h header.
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
 MAINTAINERS                   |    1 +
 sound/soc/codecs/Kconfig      |   28 +
 sound/soc/codecs/Makefile     |    6 +
 sound/soc/codecs/cmx655-i2c.c |   59 ++
 sound/soc/codecs/cmx655-spi.c |   59 ++
 sound/soc/codecs/cmx655.c     | 1030 +++++++++++++++++++++++++++++++++
 sound/soc/codecs/cmx655.h     |  151 +++++
 7 files changed, 1334 insertions(+)
 create mode 100644 sound/soc/codecs/cmx655-i2c.c
 create mode 100644 sound/soc/codecs/cmx655-spi.c
 create mode 100644 sound/soc/codecs/cmx655.c
 create mode 100644 sound/soc/codecs/cmx655.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d4b1bdb4456..7eddd860c671 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5807,6 +5807,7 @@ M:	Richard Walton <rwalton@cmlmicro.com>
 L:	linux-sound@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/cml,cmx655d.yaml
+F:	sound/soc/codecs/cmx655d*
 
 CMPC ACPI DRIVER
 M:	Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 40bb7a1d44bc..0557ad52e581 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -64,6 +64,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_BT_SCO
 	imply SND_SOC_BD28623
 	imply SND_SOC_CHV3_CODEC
+	imply SND_SOC_CMX655D
 	imply SND_SOC_CQ0093VC
 	imply SND_SOC_CROS_EC_CODEC
 	imply SND_SOC_CS35L32
@@ -760,6 +761,33 @@ config SND_SOC_CPCAP
 	tristate "Motorola CPCAP codec"
 	depends on MFD_CPCAP || COMPILE_TEST
 
+config SND_SOC_CMX655D
+	tristate
+
+config SND_SOC_CMX655D_I2C
+       tristate "CMX655D codec (I2C)"
+       depends on I2C
+       select SND_SOC_CMX655D
+       select REGMAP_I2C
+       help
+         Enables support for the CMX655D low-power voice codec with I2C control.
+	 It supports up to two MEMS microphones and one Class-D speaker via I2S.
+
+	 To compile this driver as a module, choose M here: the module
+	 will be called snd-soc-cmx655-i2c.
+
+config SND_SOC_CMX655D_SPI
+       tristate "CMX655D codec (SPI)"
+       depends on SPI
+       select SND_SOC_CMX655D
+       select REGMAP_SPI
+       help
+         Enables support for the CMX655D low-power voice codec with SPI control.
+	 It supports up to two MEMS microphones and one Class-D speaker via I2S.
+
+	 To compile this driver as a module, choose M here: the module
+	 will be called snd-soc-cmx655-spi.
+
 config SND_SOC_CQ0093VC
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 10f726066b6c..c9e33bff98ff 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -59,6 +59,9 @@ snd-soc-aw88399-y := aw88399.o
 snd-soc-bd28623-y := bd28623.o
 snd-soc-bt-sco-y := bt-sco.o
 snd-soc-chv3-codec-y := chv3-codec.o
+snd-soc-cmx655-y := cmx655.o
+snd-soc-cmx655-i2c-y := cmx655-i2c.o
+snd-soc-cmx655-spi-y := cmx655-spi.o
 snd-soc-cpcap-y := cpcap.o
 snd-soc-cq93vc-y := cq93vc.o
 snd-soc-cros-ec-codec-y := cros_ec_codec.o
@@ -477,6 +480,9 @@ obj-$(CONFIG_SND_SOC_AW88399)	+= snd-soc-aw88399.o
 obj-$(CONFIG_SND_SOC_BD28623)	+= snd-soc-bd28623.o
 obj-$(CONFIG_SND_SOC_BT_SCO)	+= snd-soc-bt-sco.o
 obj-$(CONFIG_SND_SOC_CHV3_CODEC) += snd-soc-chv3-codec.o
+obj-$(CONFIG_SND_SOC_CMX655D) += snd-soc-cmx655.o
+obj-$(CONFIG_SND_SOC_CMX655D_I2C) += snd-soc-cmx655-i2c.o
+obj-$(CONFIG_SND_SOC_CMX655D_SPI) += snd-soc-cmx655-spi.o
 obj-$(CONFIG_SND_SOC_CQ0093VC) += snd-soc-cq93vc.o
 obj-$(CONFIG_SND_SOC_CPCAP)	+= snd-soc-cpcap.o
 obj-$(CONFIG_SND_SOC_CROS_EC_CODEC)	+= snd-soc-cros-ec-codec.o
diff --git a/sound/soc/codecs/cmx655-i2c.c b/sound/soc/codecs/cmx655-i2c.c
new file mode 100644
index 000000000000..d3baf01a1049
--- /dev/null
+++ b/sound/soc/codecs/cmx655-i2c.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/of.h>
+
+#include "cmx655.h"
+
+static int cmx655_i2c_probe(struct i2c_client *client)
+{
+	int ret;
+	struct regmap *regmap = devm_regmap_init_i2c(client, &cmx655_regmap);
+
+	ret =
+	    cmx655_common_register_component(&client->dev,
+					     regmap,
+					     client->irq);
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"%s: Register component failed %d\n", __func__, ret);
+	}
+
+	return ret;
+};
+
+static void cmx655_i2c_remove(struct i2c_client *client)
+{
+	cmx655_common_unregister_component(&client->dev);
+};
+
+static const struct i2c_device_id cmx655_device_id[] = {
+	{ "cmx655", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, cmx655_device_id);
+
+static const struct of_device_id cmx655_of_match[] = {
+	{.compatible = "cml,cmx655d" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, cmx655_of_match);
+
+static struct i2c_driver cmx655_i2c_driver = {
+	.probe = cmx655_i2c_probe,
+	.remove = cmx655_i2c_remove,
+	.driver = {
+		   .name = "cmx655",
+		   .of_match_table = cmx655_of_match,
+		    },
+	.id_table = cmx655_device_id
+};
+
+module_i2c_driver(cmx655_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC CMX655 driver, I2C adapter");
+MODULE_AUTHOR("CML");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cmx655-spi.c b/sound/soc/codecs/cmx655-spi.c
new file mode 100644
index 000000000000..d5c5002d9680
--- /dev/null
+++ b/sound/soc/codecs/cmx655-spi.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/of.h>
+
+#include "cmx655.h"
+
+static int cmx655_spi_probe(struct spi_device *spi)
+{
+	int ret;
+	struct regmap *regmap = devm_regmap_init_spi(spi, &cmx655_regmap);
+
+	ret =
+	    cmx655_common_register_component(&spi->dev,
+					     regmap,
+					     spi->irq);
+	if (ret < 0) {
+		dev_err(&spi->dev,
+			"%s: Register component failed %d\n", __func__, ret);
+	}
+
+	return ret;
+};
+
+static void cmx655_spi_remove(struct spi_device *spi)
+{
+	cmx655_common_unregister_component(&spi->dev);
+};
+
+static const struct spi_device_id cmx655_device_id[] = {
+	{ "cmx655" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(spi, cmx655_device_id);
+
+static const struct of_device_id cmx655_of_match[] = {
+	{.compatible = "cml,cmx655d" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, cmx655_of_match);
+
+static struct spi_driver cmx655_spi_driver = {
+	.probe = cmx655_spi_probe,
+	.remove = cmx655_spi_remove,
+	.driver = {
+		   .name = "cmx655",
+		   .of_match_table = cmx655_of_match,
+		    },
+	.id_table = cmx655_device_id
+};
+
+module_spi_driver(cmx655_spi_driver);
+
+MODULE_DESCRIPTION("ASoC CMX655 driver, SPI adapter");
+MODULE_AUTHOR("CML");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cmx655.c b/sound/soc/codecs/cmx655.c
new file mode 100644
index 000000000000..38edef97e1dc
--- /dev/null
+++ b/sound/soc/codecs/cmx655.c
@@ -0,0 +1,1030 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/regmap.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/of.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/tlv.h>
+
+#include "cmx655.h"
+
+#define DEFAULT_RESET_ATTEMPTS 5
+static int reset_attempts = DEFAULT_RESET_ATTEMPTS;
+module_param(reset_attempts, uint, 0444);
+MODULE_PARM_DESC(reset_attempts, "Maximum number of times to reset CMX655 class-D following an overcurrent event, default is "
+		  __MODULE_STRING(DEFAULT_RESET_ATTEMPTS)
+		 ", while value >10.000 disables the limit.");
+
+static const struct reg_default cmx655_reg_defaults[] = {
+	{ CMX655_ISR, 0x00 },
+	{ CMX655_ISM, 0x00 },
+	{ CMX655_ISE, 0x00 },
+	{ CMX655_CLKCTRL, 0x00 },
+	{ CMX655_RDIVHI, 0x00 },
+	{ CMX655_RDIVLO, 0x00 },
+	{ CMX655_NDIVHI, 0x00 },
+	{ CMX655_NDIVLO, 0x00 },
+	{ CMX655_PLLCTRL, 0x00 },
+	{ CMX655_SAICTRL, 0x00 },
+	{ CMX655_SAIMUX, 0x00 },
+
+	{ CMX655_RVF, 0x00 },
+	{ CMX655_LDCTRL, 0x00 },
+	{ CMX655_RDCTRL, 0x00 },
+	{ CMX655_LEVEL, 0x00 },
+
+	{ CMX655_NGCTRL, 0x00 },
+	{ CMX655_NGTIME, 0x00 },
+	{ CMX655_NGLSTAT, 0x00 },
+	{ CMX655_NGRSTAT, 0x00 },
+
+	{ CMX655_PVF, 0x00 },
+	{ CMX655_PREAMP, 0x00 },
+	{ CMX655_VOLUME, 0x00 },
+	{ CMX655_ALCCTRL, 0x00 },
+	{ CMX655_ALCTIME, 0x00 },
+	{ CMX655_ALCGAIN, 0x00 },
+	{ CMX655_ALCSTAT, 0x00 },
+	{ CMX655_DST, 0x00 },
+	{ CMX655_CPR, 0x00 },
+
+	{ CMX655_SYSCTRL, 0x00 },
+	{ CMX655_COMMAND, 0x00 },
+	{ 0x34, 0x29 },
+	{ 0x35, 0x40 },
+	{ 0x36, 0x80 },
+	{ 0x37, 0x80 },
+
+};
+
+static const struct regmap_range cmx655_valid_reg[] = {
+	{ 0x00, 0x0a },
+	{ 0x0c, 0x0f },
+	{ 0x1c, 0x1f },
+	{ 0x28, 0x30 },
+	{ 0x32, 0x33 }
+};
+
+static const struct regmap_range cmx655_read_only_reg[] = {
+	{ 0x00, 0x00 },
+	{ 0x1e, 0x1f },
+	{ 0x2e, 0x2e }
+};
+
+static const struct regmap_range cmx655_write_only_reg[] = {
+	{ 0x33, 0x33 }
+};
+
+static const struct regmap_access_table cmx655_readable_reg = {
+	.yes_ranges = cmx655_valid_reg,
+	.n_yes_ranges = ARRAY_SIZE(cmx655_valid_reg),
+	.no_ranges = cmx655_write_only_reg,
+	.n_no_ranges = ARRAY_SIZE(cmx655_write_only_reg)
+};
+
+static const struct regmap_access_table cmx655_writeable_reg = {
+	.yes_ranges = cmx655_valid_reg,
+	.n_yes_ranges = ARRAY_SIZE(cmx655_valid_reg),
+	.no_ranges = cmx655_read_only_reg,
+	.n_no_ranges = ARRAY_SIZE(cmx655_read_only_reg)
+};
+
+static bool cmx655_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case CMX655_COMMAND:
+	case CMX655_SYSCTRL:
+	case CMX655_ISR:
+	case CMX655_ISE:
+		return true;
+	default:
+		return false;
+	}
+};
+
+const struct regmap_config cmx655_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = CMX655_COMMAND,
+
+	.volatile_reg = cmx655_volatile_reg,
+	.wr_table = &cmx655_writeable_reg,
+	.rd_table = &cmx655_readable_reg,
+
+	.reg_defaults = cmx655_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(cmx655_reg_defaults),
+	.cache_type = REGCACHE_MAPLE,
+};
+EXPORT_SYMBOL_GPL(cmx655_regmap);
+
+static int cmx655_start_sys_clk(struct snd_soc_component *component)
+{
+	int ret;
+	int i;
+	unsigned int val;
+
+	val = snd_soc_component_read(component, CMX655_ISR);
+	ret = snd_soc_component_write(component, CMX655_COMMAND,
+				      CMX655_CMD_CLOCK_START);
+	if (ret < 0) {
+		dev_err(component->dev,
+			"Failed to write start clock command %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < 100; i++) {
+		val = snd_soc_component_read(component, CMX655_ISR);
+		if (val & CMX655_ISR_CLKRDY)
+			break;
+	}
+
+	if (i == 100)
+		ret = -EIO;
+	return ret;
+}
+
+static int cmx655_stop_sys_clk(struct snd_soc_component *component)
+{
+	return snd_soc_component_write(component, CMX655_COMMAND,
+				       CMX655_CMD_CLOCK_STOP);
+}
+
+/**
+ * cmx655_get_sys_clk_config(): Get the clock configuration.
+ * @clk_id: Clock source setting as defined in cmx655.h
+ * @primary_mode: Non-zero if the CMX655 is the DAI primary
+ * @sr_setting: Setting for sample rate 0 to 3
+ * @clk_src: pointer for storing clock source (PLLREF, PLLSEL and
+ *           CLKSEL bits)
+ * @rdiv: pointer for storing PLL's RDIV value (13 bits)
+ * @ndiv: pointer for storing PLL's NDIV value (13 bits)
+ * @pll_ctrl: pointer for storing PLLCTRL register value (8 bits)
+ *
+ * Get the clock setup for the system clock based on clock Id, DAI primary mode
+ * and sample rate.
+ *
+ * Return: 0 for success, negative value otherwise
+ */
+static int cmx655_get_sys_clk_config(int clk_id,
+				     int primary_mode,
+				     int sr_setting,
+				     int *clk_src,
+				     int *rdiv, int *ndiv, int *pll_ctrl)
+{
+	if (clk_id == CMX655_SYSCLK_AUTO) {
+		if (primary_mode != 0)
+			clk_id = CMX655_SYSCLK_RCLK;
+		else
+			clk_id = CMX655_SYSCLK_LRCLK;
+	}
+	*rdiv = 0;
+	*ndiv = 0;
+	*pll_ctrl = 0;
+	switch (clk_id) {
+	case CMX655_SYSCLK_RCLK:
+		*clk_src = CMX655_CLKCTRL_CLRSRC_RCLK;
+		break;
+	case CMX655_SYSCLK_LPO:
+		*clk_src = CMX655_CLKCTRL_CLRSRC_LPO;
+		break;
+	case CMX655_SYSCLK_LRCLK:
+		*clk_src = CMX655_CLKCTRL_CLRSRC_LRCLK;
+		*rdiv = 1;
+		switch (sr_setting) {
+		case CMX655_CLKCTRL_SR_8K:
+			*ndiv = 3072;
+			*pll_ctrl = (0 << CMX655_PLLCTRL_LFILT_SHIFT) |
+			    (3 << CMX655_PLLCTRL_CPI_SHIFT);
+			break;
+		case CMX655_CLKCTRL_SR_16K:
+			*ndiv = 1536;
+			*pll_ctrl = (0 << CMX655_PLLCTRL_LFILT_SHIFT) |
+			    (3 << CMX655_PLLCTRL_CPI_SHIFT);
+			break;
+		case CMX655_CLKCTRL_SR_32K:
+			*ndiv = 768;
+			*pll_ctrl = (12 << CMX655_PLLCTRL_LFILT_SHIFT) |
+			    (3 << CMX655_PLLCTRL_CPI_SHIFT);
+			break;
+		case CMX655_CLKCTRL_SR_48K:
+			*ndiv = 512;
+			*pll_ctrl = (12 << CMX655_PLLCTRL_LFILT_SHIFT) |
+			    (3 << CMX655_PLLCTRL_CPI_SHIFT);
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+};
+
+/**
+ * cmx655_setup_rate(): Setup the clock and sample rate.
+ * @component: sound component to set up
+ * @hw_params: hardware parameters holding the sample rate
+ *
+ * Setup the clock and sample rate. The clock needs to be setup at the same
+ * time as the sample rate in case we are using the serial port as the clock
+ * source.
+ * If the clock source the serial port then the PLL settings are dependent on
+ * the sample rate.
+ *
+ * Return: 0 for success, negative for error.
+ */
+static int cmx655_setup_rate(struct snd_soc_component *component,
+			     struct snd_pcm_hw_params *hw_params)
+{
+	int ret;
+	struct cmx655_data *cmx655_data =
+	    snd_soc_component_get_drvdata(component);
+	struct cmx655_dai_data *cmx655_dai_data = &cmx655_data->dai_data;
+	int srate = params_rate(hw_params);
+	int primary_mode;
+	int srate_setting;
+	int clk_src;
+	int rdiv;
+	int ndiv;
+	int pll_ctrl;
+	int sys_ctrl;
+	int vol;
+
+	primary_mode = snd_soc_component_read(component, CMX655_SAICTRL);
+	primary_mode = primary_mode & CMX655_SAI_MSTR;
+
+	switch (srate) {
+	case 8000:
+		srate_setting = CMX655_CLKCTRL_SR_8K;
+		break;
+	case 16000:
+		srate_setting = CMX655_CLKCTRL_SR_16K;
+		break;
+	case 32000:
+		srate_setting = CMX655_CLKCTRL_SR_32K;
+		break;
+	case 48000:
+		srate_setting = CMX655_CLKCTRL_SR_48K;
+		break;
+	default:
+		dev_err(component->dev, "Unsupported rate %d\n", srate);
+		return -EINVAL;
+	}
+
+	ret = cmx655_get_sys_clk_config(cmx655_dai_data->sys_clk,
+					primary_mode, srate_setting,
+					&clk_src, &rdiv, &ndiv, &pll_ctrl);
+	if (ret < 0) {
+		dev_err(component->dev,
+			"Failed to get system clock settings %i\n", ret);
+		return ret;
+	}
+
+	if (clk_src == CMX655_CLKCTRL_CLRSRC_LRCLK) {
+		dev_dbg(component->dev,
+			"Using LRCLK as clk source. Using LPO for setup then switch over to LRCLK later");
+		cmx655_dai_data->clk_src = clk_src;
+		cmx655_dai_data->best_clk_running = false;
+		clk_src = CMX655_CLKCTRL_CLRSRC_LPO;
+	} else {
+		cmx655_dai_data->best_clk_running = true;
+	}
+
+	if (snd_soc_component_test_bits(component, CMX655_CLKCTRL,
+					CMX655_CLKCTRL_CLRSRC_MASK |
+					CMX655_CLKCTRL_SR_MASK,
+					clk_src | srate_setting) == 0) {
+		dev_dbg(component->dev, "Rate Setup correct skipping setup\n");
+		return 0;
+	}
+	/* Turn all inputs and outputs off before disabling clock */
+	sys_ctrl = snd_soc_component_read(component, CMX655_SYSCTRL);
+	snd_soc_component_update_bits(component, CMX655_SYSCTRL,
+				      CMX655_SYSCTRL_MICR |
+				      CMX655_SYSCTRL_MICL |
+				      CMX655_SYSCTRL_PAMP |
+				      CMX655_SYSCTRL_LOUT, 0);
+
+	cmx655_stop_sys_clk(component);
+	/* Set new sample rate and clock source */
+	snd_soc_component_update_bits(component, CMX655_CLKCTRL,
+				      CMX655_CLKCTRL_CLRSRC_MASK |
+				      CMX655_CLKCTRL_SR_MASK,
+				      clk_src | srate_setting);
+	/* Set new RDIV */
+	snd_soc_component_update_bits(component, CMX655_RDIVHI,
+				      0x1F, rdiv >> 8);
+	snd_soc_component_update_bits(component, CMX655_RDIVLO,
+				      0xFF, rdiv & 0xFF);
+	/* Set new NDIV */
+	snd_soc_component_update_bits(component, CMX655_NDIVHI,
+				      0x1F, ndiv >> 8);
+	snd_soc_component_update_bits(component, CMX655_NDIVLO,
+				      0xFF, ndiv & 0xFF);
+	/* Set new PLLCTRL */
+	snd_soc_component_update_bits(component, CMX655_PLLCTRL,
+				      0xFF, pll_ctrl & 0xFF);
+	/* Now we can re-start the clock */
+	ret = cmx655_start_sys_clk(component);
+	if (ret < 0) {
+		dev_err(component->dev,
+			"System clock failed to start %i\n", ret);
+		return ret;
+	}
+	/* Turn anything on that we turned off */
+	if ((sys_ctrl & (CMX655_SYSCTRL_MICR | CMX655_SYSCTRL_MICL)) > 0) {
+		snd_soc_component_update_bits(component, CMX655_SYSCTRL,
+					      CMX655_SYSCTRL_MICR |
+					      CMX655_SYSCTRL_MICL, sys_ctrl);
+		/* Wait for filters to settle */
+		if (snd_soc_component_test_bits
+		    (component,
+		     CMX655_RVF,
+		     CMX655_VF_DCBLOCK,
+		     CMX655_VF_DCBLOCK) == 0) {
+			/* DC blocking filter off, Shorter wait */
+			usleep_range(3500, 4000);
+		} else {
+			/* This allows time for Mics and DC blocking filter to settle */
+			msleep(320);
+		}
+	}
+
+	if ((sys_ctrl & (CMX655_SYSCTRL_PAMP | CMX655_SYSCTRL_LOUT)) > 0) {
+		/* Store volume */
+		vol = snd_soc_component_read(component, CMX655_VOLUME);
+		/* Lower volume with smooth on */
+		snd_soc_component_write(component, CMX655_VOLUME, 0x80);
+		snd_soc_component_update_bits(component, CMX655_SYSCTRL,
+					      CMX655_SYSCTRL_PAMP |
+					      CMX655_SYSCTRL_LOUT, sys_ctrl);
+		/* Restore volume */
+		snd_soc_component_write(component, CMX655_VOLUME, vol);
+	}
+
+	return 0;
+};
+
+static int cmx655_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_component *component = dai->component;
+	unsigned int reg_val = 0;
+	/* Set primary bit */
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		reg_val = reg_val | CMX655_SAI_MSTR;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		dev_err(component->dev,
+			"Unsupported digital audio interface primary mode\n");
+		return -EINVAL;
+	}
+	/* Set data format */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		reg_val = reg_val | CMX655_SAI_DLY | CMX655_SAI_POL;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		break;
+	default:
+		dev_err(component->dev,
+			"Unsupported digital audio interface data format\n");
+		return -EINVAL;
+	}
+	/* Change invert bits if required */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		reg_val = reg_val ^ CMX655_SAI_POL;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		reg_val = reg_val | CMX655_SAI_BINV;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		reg_val = (reg_val | CMX655_SAI_BINV) ^ CMX655_SAI_POL;
+		break;
+	default:
+		dev_err(component->dev,
+			"Unknown digital audio interface polarity\n");
+		return -EINVAL;
+	}
+
+	/* Write value to codec */
+	snd_soc_component_write(component, CMX655_SAICTRL, reg_val);
+	return 0;
+}
+
+static int cmx655_set_dai_sysclk(struct snd_soc_dai *dai,
+				 int clk_id, unsigned int freq, int dir)
+{
+	struct cmx655_data *cmx655_data =
+	    snd_soc_component_get_drvdata(dai->component);
+	struct cmx655_dai_data *cmx655_dai_data = &cmx655_data->dai_data;
+
+	switch (clk_id) {
+	case CMX655_SYSCLK_MIN ... CMX655_SYSCLK_MAX:
+		break;
+	default:
+		return -EINVAL;
+	}
+	cmx655_dai_data->sys_clk = clk_id;
+
+	return 0;
+}
+
+static int cmx655_dai_prepare(struct snd_pcm_substream *stream,
+			      struct snd_soc_dai *dai)
+{
+	int ret = 0;
+	struct snd_soc_component *component = dai->component;
+	struct cmx655_data *cmx655_data =
+	    snd_soc_component_get_drvdata(component);
+	struct cmx655_dai_data *cmx655_dai_data = &cmx655_data->dai_data;
+
+	if (!cmx655_dai_data->best_clk_running) {
+		/* Stop the clock change over to the correct one an start it again */
+		ret = cmx655_stop_sys_clk(component);
+		if (ret < 0) {
+			dev_err(component->dev, "Failed to stop clock %d\n",
+				ret);
+			goto get_out;
+		}
+		ret =
+		    snd_soc_component_update_bits(component, CMX655_CLKCTRL,
+						  CMX655_CLKCTRL_CLRSRC_MASK,
+						  cmx655_dai_data->clk_src);
+		if (ret < 0) {
+			dev_err(component->dev,
+				"Failed to set new clock setup %d\n", ret);
+			goto get_out;
+		}
+		ret = cmx655_start_sys_clk(component);
+		if (ret < 0) {
+			dev_warn(component->dev, "Failed to restart clock\n");
+			ret = 0;
+			/*
+			 * This will happen if the CPU driver does not start the LRCLK
+			 * until the last point.
+			 * For now we will assume the clock will start
+			 */
+		}
+		cmx655_dai_data->best_clk_running = true;
+	}
+get_out:
+	return ret;
+};
+
+static int cmx655_hw_params(struct snd_pcm_substream *stream,
+			    struct snd_pcm_hw_params *hw_params,
+			    struct snd_soc_dai *dai)
+{
+	int ret;
+	struct snd_soc_component *component = dai->component;
+	struct cmx655_data *cmx655_data =
+	    snd_soc_component_get_drvdata(component);
+	struct cmx655_dai_data *cmx655_dai_data = &cmx655_data->dai_data;
+	unsigned int enabled_streams = cmx655_dai_data->enabled_streams;
+
+	/* Setup clock and sample rate */
+	ret = cmx655_setup_rate(component, hw_params);
+	if (ret < 0) {
+		dev_err(component->dev, "Failed to set rates %d\n",
+			ret);
+		return ret;
+	}
+
+	/* Set mono bit based on channel count */
+	if (params_channels(hw_params) == 1) {
+		dev_dbg(component->dev, "Switching into mono mode\n");
+		snd_soc_component_update_bits(component, CMX655_SAICTRL,
+					      CMX655_SAI_MONO, CMX655_SAI_MONO);
+	} else {
+		snd_soc_component_update_bits(component, CMX655_SAICTRL,
+					      CMX655_SAI_MONO, 0);
+	}
+
+	if (cmx655_data->irq)
+		cmx655_data->oc_cnt = 0;
+	if (enabled_streams == 0) {
+		dev_dbg(component->dev,
+			"First stream to enable, enabling SAI\n");
+		/*
+		 * If first stream to be enabled
+		 * Enable SAI (serial audio interface) port
+		 * We need it running before the platform starts.
+		 * to avoid I2S sync errors
+		 */
+		snd_soc_component_update_bits(component, CMX655_SYSCTRL,
+					      CMX655_SYSCTRL_SAI,
+					      CMX655_SYSCTRL_SAI);
+	} else {
+		dev_dbg(component->dev,
+			"Not first stream to enable, skipping SAI enable\n");
+	}
+
+	/* Inc enabled streams by 1 */
+	cmx655_dai_data->enabled_streams = enabled_streams + 1;
+
+	return ret;
+}
+
+static void cmx655_dai_shutdown(struct snd_pcm_substream *stream,
+				struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct cmx655_data *cmx655_data =
+	    snd_soc_component_get_drvdata(component);
+	struct cmx655_dai_data *cmx655_dai_data = &cmx655_data->dai_data;
+	unsigned int enabled_streams = cmx655_dai_data->enabled_streams;
+
+	if (enabled_streams == 0) {
+		dev_dbg(component->dev,
+			"Shutdown called when SAI not running\n");
+		return;
+	}
+	enabled_streams = enabled_streams - 1;
+	cmx655_dai_data->enabled_streams = enabled_streams;
+	if (enabled_streams == 0) {
+		dev_dbg(component->dev,
+			"Last stream to disable, disabling SAI\n");
+		snd_soc_component_update_bits(component, CMX655_SYSCTRL,
+					      CMX655_SYSCTRL_SAI, 0);
+		cmx655_dai_data->best_clk_running = false;
+	} else {
+		dev_dbg(component->dev,
+			"Not last stream to disable, skipping SAI disable\n");
+	}
+}
+
+static const struct snd_soc_dai_ops cmx655_dai_ops = {
+	.set_sysclk = cmx655_set_dai_sysclk,
+	.set_fmt = cmx655_set_dai_fmt,
+
+	.prepare = cmx655_dai_prepare,
+	.hw_params = cmx655_hw_params,
+	.shutdown = cmx655_dai_shutdown,
+};
+
+static struct snd_soc_dai_driver cmx655_dai_driver = {
+	.name = "cmx655",
+	.playback = {
+		     .stream_name = "CMX655 Playback",
+		     .channels_min = 1,
+		     .channels_max = 2,
+		     .rates = CMX655_RATES,
+		     .formats = CMX655_FMTS,
+		      },
+	.capture = {
+		    .stream_name = "CMX655 Record",
+		    .channels_min = 1,
+		    .channels_max = 2,
+		    .rates = CMX655_RATES,
+		    .formats = CMX655_FMTS,
+		     },
+	.ops = &cmx655_dai_ops,
+	.symmetric_rate = 1
+};
+
+static irqreturn_t cmx655_irq_thread(int irq, void *data)
+{
+	struct snd_soc_component *component = data;
+	struct cmx655_data *cmx655_data =
+	    snd_soc_component_get_drvdata(component);
+	unsigned int status;
+
+	status = snd_soc_component_read(component, CMX655_ISR);
+	if (status == 0)
+		return IRQ_NONE;
+	/* Thermal protection event */
+	if (status & CMX655_ISR_THERM) {
+		dev_err(component->dev,
+			"CMX655 class-D over temperature detected\n");
+	}
+	/* Over current  event */
+	if (status & CMX655_ISR_AMPOC) {
+		dev_warn(component->dev,
+			 "CMX655 class-D over current detected\n");
+		if (cmx655_data->oc_cnt < reset_attempts) {
+			/* Re enable class-D */
+			snd_soc_component_update_bits(component,
+						      CMX655_SYSCTRL,
+						      CMX655_SYSCTRL_PAMP,
+						      CMX655_SYSCTRL_PAMP);
+			if (reset_attempts <= 10000)
+				cmx655_data->oc_cnt++;
+		} else {
+			/* Re enable count reached, do not try again */
+			dev_err(component->dev,
+				"Class-D over current restart attempts exceeded\n");
+		}
+	}
+	return IRQ_HANDLED;
+}
+
+static int cmx655_component_probe(struct snd_soc_component *component)
+{
+	int ret;
+	struct cmx655_data *cmx655_data =
+	    snd_soc_component_get_drvdata(component);
+
+	ret = cmx655_start_sys_clk(component);
+	if (ret < 0) {
+		dev_err(component->dev, "Failed to start system clock %d\n",
+			ret);
+		goto codec_err;
+	}
+	cmx655_data->oc_cnt = 0;
+	if (cmx655_data->irq) {
+		ret =
+		    request_threaded_irq(cmx655_data->irq, NULL,
+					 cmx655_irq_thread, IRQF_ONESHOT,
+					 "cmx655", component);
+		if (ret < 0) {
+			dev_err(component->dev,
+				"Failed to setup interrupt %d\n", ret);
+			goto interrupt_err;
+		}
+		snd_soc_component_write(component, CMX655_ISM,
+					(CMX655_ISM_AMPOC | CMX655_ISM_THERM));
+	}
+
+	return 0;
+
+interrupt_err:
+codec_err:
+	return ret;
+}
+
+static void cmx655_component_remove(struct snd_soc_component *component)
+{
+	struct cmx655_data *cmx655_data =
+	    snd_soc_component_get_drvdata(component);
+
+	if (cmx655_data->irq) {
+		snd_soc_component_write(component, CMX655_ISM, 0);
+		free_irq(cmx655_data->irq, component);
+	}
+}
+
+static const DECLARE_TLV_DB_SCALE(cmx655_level, -1200, 100, 0);
+static const DECLARE_TLV_DB_SCALE(cmx655_ng_thresh, -6300, 100, 0);
+static const DECLARE_TLV_DB_SCALE(cmx655_vol, -9100, 100, 1);
+static const DECLARE_TLV_DB_SCALE(cmx655_pre_amp, 0, 600, 0);
+static const DECLARE_TLV_DB_SCALE(cmx655_dst_gain, -6200, 200, 0);
+static const DECLARE_TLV_DB_SCALE(cmx655_alc_gain, 0, 100, 0);
+static const DECLARE_TLV_DB_SCALE(cmx655_alc_thresh, -3100, 100, 0);
+
+static const char *const cmx655_ngratio_text[] = {
+	"1:2",
+	"1:3",
+	"1:4"
+};
+
+static SOC_ENUM_SINGLE_DECL(cmx655_ngratio_enum, CMX655_NGCTRL, 5,
+			    cmx655_ngratio_text);
+static const char *const cmx655_ngattack_text[] = {
+	"1.5ms",
+	"3ms",
+	"4.5ms",
+	"6ms",
+	"12ms",
+	"24ms",
+	"48ms",
+	"96ms"
+};
+
+static SOC_ENUM_SINGLE_DECL(cmx655_ngattack_enum, CMX655_NGTIME, 4,
+			    cmx655_ngattack_text);
+static const char *const cmx655_ngrelease_text[] = {
+	"0.06s",
+	"0.12s",
+	"0.24s",
+	"0.48s",
+	"0.96s",
+	"1.92s",
+	"3.84s",
+	"7.68s"
+};
+
+static SOC_ENUM_SINGLE_DECL(cmx655_ngrelease_enum, CMX655_NGTIME, 0,
+			    cmx655_ngrelease_text);
+static const char *const cmx655_hpf_text[] = {
+	"Disabled",
+	"SRate/320",
+	"SRate/53.3",
+	"SRate/26.7"
+};
+
+static SOC_ENUM_SINGLE_DECL(cmx655_hpf_capture_enum, CMX655_RVF, 0,
+			    cmx655_hpf_text);
+static SOC_ENUM_SINGLE_DECL(cmx655_hpf_playback_enum, CMX655_PVF, 0,
+			    cmx655_hpf_text);
+static const char *const cmx655_companding_text[] = {
+	"u-Law",
+	"a-Law"
+};
+
+static SOC_ENUM_SINGLE_DECL(cmx655_companding, CMX655_SAIMUX, 5,
+			    cmx655_companding_text);
+static const char *const cmx655_alc_ratio_text[] = {
+	"1.5:1",
+	"2:1",
+	"4:1",
+	"Inf:1"
+};
+
+static SOC_ENUM_SINGLE_DECL(cmx655_alc_ratio_enum, CMX655_ALCCTRL, 5,
+			    cmx655_alc_ratio_text);
+/* Note: The attack and release times are the same as the Noise gate's. */
+static SOC_ENUM_SINGLE_DECL(cmx655_alc_attack_enum, CMX655_ALCTIME, 4,
+			    cmx655_ngattack_text);
+static SOC_ENUM_SINGLE_DECL(cmx655_alc_release_enum, CMX655_ALCTIME, 0,
+			    cmx655_ngrelease_text);
+
+static const struct snd_kcontrol_new cmx655_snd_controls[] = {
+	/* Capture */
+	SOC_DOUBLE_TLV("Master Capture Volume", CMX655_LEVEL, 4, 0, 15, 0,
+		       cmx655_level),
+
+	SOC_SINGLE("Digital Capture Block Switch", CMX655_RVF,
+		   CMX655_VF_DCBLOCK_SHIFT,
+		   1, 0),
+
+	SOC_SINGLE("LPF Capture Switch", CMX655_RVF, 3, 1, 0),
+	SOC_ENUM("HPF Capture Switch", cmx655_hpf_capture_enum),
+	/* Noise gate */
+	SOC_SINGLE("Noise Gate Capture Switch", CMX655_NGCTRL, 7, 1, 0),
+	SOC_SINGLE_TLV("Noise Gate Threshold Capture Volume", CMX655_NGCTRL, 0, 31, 0,
+		       cmx655_ng_thresh),
+	SOC_ENUM("Noise Gate Ratio Capture Switch", cmx655_ngratio_enum),
+	SOC_ENUM("Noise Gate Attack Capture Switch", cmx655_ngattack_enum),
+	SOC_ENUM("Noise Gate Release Capture Switch", cmx655_ngrelease_enum),
+
+	/* Playback */
+	SOC_SINGLE_TLV("Master Playback Volume", CMX655_VOLUME, 0, 91, 0,
+		       cmx655_vol),
+	SOC_SINGLE_TLV("Preamp Playback Volume", CMX655_PREAMP, 0, 3, 0,
+		       cmx655_pre_amp),
+	SOC_SINGLE("Smooth Playback Switch", CMX655_VOLUME, 7, 0x01, 0),
+	SOC_SINGLE("Dogital Capture Block Playback Switch", CMX655_PVF,
+		   CMX655_VF_DCBLOCK_SHIFT,
+		   1, 0),
+	SOC_SINGLE("LPF Playback Switch", CMX655_PVF, 3, 1, 0),
+	SOC_ENUM("HPF Playback Switch", cmx655_hpf_playback_enum),
+	SOC_SINGLE("Soft Mute Playback Switch", CMX655_CPR, 0, 1, 0),
+	SOC_SINGLE("ALC Playback Switch", CMX655_ALCCTRL, 7, 1, 0),
+	SOC_ENUM("ALC Ratio Playback Switch", cmx655_alc_ratio_enum),
+	SOC_SINGLE_TLV("ALC Threshold Playback Volume", CMX655_ALCCTRL,
+		       0, 31, 0,
+		       cmx655_alc_thresh),
+	SOC_SINGLE_TLV("ALC Playback Volume", CMX655_ALCGAIN, 0, 12, 0,
+		       cmx655_alc_gain),
+	SOC_ENUM("ALC Attack Playback Switch", cmx655_alc_attack_enum),
+	SOC_ENUM("ALC Release Playback Switch", cmx655_alc_release_enum),
+
+	/* Digital Sidetone */
+	SOC_SINGLE_TLV("Sidetone Playback Volume", CMX655_DST, 0, 31, 0,
+		       cmx655_dst_gain),
+	/* Companding */
+	SOC_SINGLE("Companding Switch", CMX655_SAIMUX, 4, 1, 0),
+	SOC_ENUM("Companding Type", cmx655_companding),
+};
+
+static const char *const cmx655_mic_mux_text[] = {
+	"Normal",
+	"Swapped",
+	"Left only",
+	"Right only"
+};
+
+static SOC_ENUM_SINGLE_DECL(cmx655_mic_mux_enum, CMX655_SAIMUX, 0,
+			    cmx655_mic_mux_text);
+
+static const char *const cmx655_amp_mux_text[] = {
+	"Left",
+	"Right",
+	"Mean"
+};
+
+static SOC_ENUM_SINGLE_DECL(cmx655_amp_mux_enum, CMX655_SAIMUX, 2,
+			    cmx655_amp_mux_text);
+
+static const char *const cmx655_digital_sidetone_text[] = {
+	"Left",
+	"Right",
+	"Mean"
+};
+
+static SOC_ENUM_SINGLE_DECL(cmx655_sidetone_enum, CMX655_DST, 5,
+			    cmx655_digital_sidetone_text);
+static const struct snd_kcontrol_new cmx655_mic_mux =
+SOC_DAPM_ENUM("SAI Capture Route",
+	      cmx655_mic_mux_enum);
+
+static const struct snd_kcontrol_new cmx655_amp_mux =
+SOC_DAPM_ENUM("Play_SAI Playback Route",
+	      cmx655_amp_mux_enum);
+
+static const struct snd_kcontrol_new cmx655_spkr_en[] = {
+	SOC_DAPM_SINGLE_VIRT("Playback Switch", 1)
+};
+
+static const struct snd_kcontrol_new cmx655_lout_en[] = {
+	SOC_DAPM_SINGLE_VIRT("Playback Switch", 1)
+};
+
+static const struct snd_kcontrol_new cmx655_sidetone_mux =
+SOC_DAPM_ENUM("DST Route", cmx655_sidetone_enum);
+
+static const struct snd_kcontrol_new cmx655_dst_en[] = {
+	SOC_DAPM_SINGLE_VIRT("Playback Switch", 1)
+};
+
+static int cmx655_mic_dapm_event(struct snd_soc_dapm_widget *widget,
+				 struct snd_kcontrol *control, int event)
+{
+	struct snd_soc_component *component =
+	    snd_soc_dapm_to_component(widget->dapm);
+	int reg_val;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		/*
+		 *After turn on give MIC filters time
+		 * Time can be shorter if the DC blocking filter is not enabled
+		 */
+		reg_val = snd_soc_component_read(component, CMX655_RVF);
+		if ((reg_val & CMX655_VF_DCBLOCK) != 0) {
+			/* This allows time for Mics and DC blocking filter to settle */
+			msleep(320);
+		} else {
+			usleep_range(3500, 4000);
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget cmx655_dapm_widgets[] = {
+	/* Input path widgets */
+	SND_SOC_DAPM_INPUT("MICL"),
+	SND_SOC_DAPM_INPUT("MICR"),
+
+	/* Custom widgets for Mics to get them to turn on before switches */
+	CMX655_DAPM_MIC("Left Mic", 1),
+	CMX655_DAPM_MIC("Right Mic", 0),
+
+	SND_SOC_DAPM_MUX("SAI Left Capture Mux", SND_SOC_NOPM, 0, 0,
+			 &cmx655_mic_mux),
+	SND_SOC_DAPM_MUX("SAI Right Capture Mux", SND_SOC_NOPM, 0, 0,
+			 &cmx655_mic_mux),
+	/*
+	 * Note: SAI enable is controlled by DAI's HWparams and shutdown. Using
+	 * DAPM control resulted in I2S sync errors on the platform driver
+	 */
+	SND_SOC_DAPM_AIF_OUT("SAI Left Out", "CMX655 Record", 0,
+			     SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SAI Right Out", "CMX655 Record", 1,
+			     SND_SOC_NOPM, 0, 0),
+
+	/* Output path widgets */
+	SND_SOC_DAPM_AIF_IN("SAI Left In", "CMX655 Playback", 0,
+			    SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SAI Right In", "CMX655 Playback", 1,
+			    SND_SOC_NOPM, 0, 0),
+
+	SND_SOC_DAPM_MUX("SAI Playback Route", SND_SOC_NOPM, 0, 0,
+			 &cmx655_amp_mux),
+
+	SND_SOC_DAPM_DAC("Power Amp", "CMX655 Playback", CMX655_SYSCTRL, 3, 0),
+	SND_SOC_DAPM_DAC("Line Out", "CMX655 Playback", CMX655_SYSCTRL, 4, 0),
+
+	SND_SOC_DAPM_SWITCH("SPKR Switch", SND_SOC_NOPM, 0, 0, cmx655_spkr_en),
+	SND_SOC_DAPM_SWITCH("LOUT Switch", SND_SOC_NOPM, 0, 0, cmx655_lout_en),
+
+	SND_SOC_DAPM_OUTPUT("SPKR"),
+	SND_SOC_DAPM_OUTPUT("LOUT"),
+
+	/* Digital side tone widgets */
+	SND_SOC_DAPM_SWITCH("DST Switch", SND_SOC_NOPM, 0, 0, cmx655_dst_en),
+	SND_SOC_DAPM_MUX("DST Mux", CMX655_DST, 7, 0, &cmx655_sidetone_mux),
+
+};
+
+static const struct snd_soc_dapm_route cmx655_dapm_routes[] = {
+	/* Main output path */
+	{ "SPKR", NULL, "SPKR Switch" },
+	{ "LOUT", NULL, "LOUT Switch" },
+	{ "SPKR Switch", "Playback Switch", "Power Amp" },
+	{ "LOUT Switch", "Playback Switch", "Line Out" },
+	{ "Power Amp", NULL, "SAI Playback Route" },
+	{ "Line Out", NULL, "SAI Playback Route" },
+	{ "SAI Playback Route", "Left", "SAI Left In" },
+	{ "SAI Playback Route", "Right", "SAI Right In" },
+	{ "SAI Playback Route", "Mean", "SAI Left In" },
+	{ "SAI Playback Route", "Mean", "SAI Right In" },
+	/* Main input path */
+	{ "SAI Right Out", NULL, "SAI Right Capture Mux" },
+	{ "SAI Left Out", NULL, "SAI Left Capture Mux" },
+	{ "SAI Left Capture Mux", "Normal", "Left Mic" },
+	{ "SAI Right Capture Mux", "Normal", "Right Mic" },
+	{ "SAI Left Capture Mux", "Swapped", "Right Mic" },
+	{ "SAI Right Capture Mux", "Swapped", "Left Mic" },
+	{ "SAI Left Capture Mux", "Left only", "Left Mic" },
+	{ "SAI Right Capture Mux", "Left only", "Left Mic" },
+	{ "SAI Left Capture Mux", "Right only", "Right Mic" },
+	{ "SAI Right Capture Mux", "Right only", "Right Mic" },
+	{ "Right Mic", NULL, "MICR" },
+	{ "Left Mic", NULL, "MICL" },
+	/* Digital side tone */
+	{ "DST Mux", "Left", "Left Mic" },
+	{ "DST Mux", "Right", "Right Mic" },
+	{ "DST Mux", "Mean", "Left Mic" },
+	{ "DST Mux", "Mean", "Right Mic" },
+
+	{ "DST Switch", "Playback Switch", "DST Mux" },
+
+	{ "Power Amp", NULL, "DST Switch" },
+	{ "Line Out", NULL, "DST Switch" },
+
+};
+
+static const struct snd_soc_component_driver cmx655_component_driver = {
+	.controls = cmx655_snd_controls,
+	.num_controls = ARRAY_SIZE(cmx655_snd_controls),
+	.dapm_widgets = cmx655_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(cmx655_dapm_widgets),
+	.dapm_routes = cmx655_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(cmx655_dapm_routes),
+
+	.probe = cmx655_component_probe,
+	.remove = cmx655_component_remove
+};
+
+/**
+ * cmx655_common_register_component() - registers cmx655 codec.
+ * @dev: bus-specific device descriptor
+ * @regmap: bus-specific register mapping
+ * @irq: interrupt id for the device
+ *
+ * Return: 0 for success, negative number otherwise
+ */
+int cmx655_common_register_component(struct device *dev, struct regmap *regmap,
+				     int irq)
+{
+	struct cmx655_data *cmx655_data;
+	struct cmx655_dai_data *cmx655_dai_data = dev_get_platdata(dev);
+
+	cmx655_data = devm_kzalloc(dev, sizeof(*cmx655_data), GFP_KERNEL);
+	if (!cmx655_data)
+		return -ENOMEM;
+	cmx655_data->regmap = regmap;
+	if (IS_ERR(cmx655_data->regmap))
+		return PTR_ERR(cmx655_data->regmap);
+	cmx655_data->irq = irq;
+	if (cmx655_dai_data) {
+		memcpy(&cmx655_data->dai_data, cmx655_dai_data,
+		       sizeof(*cmx655_dai_data));
+	}
+	cmx655_data->reset_gpio = devm_gpiod_get_optional(dev,
+							  "reset",
+							  GPIOD_OUT_LOW);
+	if (cmx655_data->reset_gpio) {
+		gpiod_set_value_cansleep(cmx655_data->reset_gpio, 1);
+		usleep_range(10, 1000);
+		gpiod_set_value_cansleep(cmx655_data->reset_gpio, 0);
+	} else {
+		dev_dbg(dev, "No reset GPIO, using reset command\n");
+		regmap_write(cmx655_data->regmap, CMX655_COMMAND,
+			     CMX655_CMD_SOFT_RESET);
+	}
+	dev_set_drvdata(dev, cmx655_data);
+
+	return devm_snd_soc_register_component(dev,
+					       &cmx655_component_driver,
+					       &cmx655_dai_driver, 1);
+}
+EXPORT_SYMBOL_GPL(cmx655_common_register_component);
+
+void cmx655_common_unregister_component(struct device *dev)
+{
+	struct cmx655_data *cmx655_data = dev_get_drvdata(dev);
+
+	snd_soc_unregister_component(dev);
+	gpiod_set_value_cansleep(cmx655_data->reset_gpio, 1);
+}
+EXPORT_SYMBOL_GPL(cmx655_common_unregister_component);
+
+MODULE_DESCRIPTION("ASoC CMX655 driver");
+MODULE_AUTHOR("CML");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/cmx655.h b/sound/soc/codecs/cmx655.h
new file mode 100644
index 000000000000..2a727205d4de
--- /dev/null
+++ b/sound/soc/codecs/cmx655.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef CMX655_H
+#define CMX655_H
+
+#include <linux/gpio.h>
+#include <linux/regmap.h>
+#include <sound/pcm.h>
+
+#define CMX655_ISR      (0x00)
+#define     CMX655_ISR_MICR        BIT(0)
+#define     CMX655_ISR_MICL        BIT(1)
+#define     CMX655_ISR_AMPOC       BIT(2)
+#define     CMX655_ISR_AMPCLIP     BIT(3)
+#define     CMX655_ISR_CLKRDY      BIT(4)
+#define     CMX655_ISR_THERM       BIT(5)
+#define     CMX655_ISR_VOL         BIT(6)
+#define     CMX655_ISR_CAL         BIT(7)
+
+#define CMX655_ISM      (0x01)
+#define     CMX655_ISM_MICR        BIT(0)
+#define     CMX655_ISM_MICL        BIT(1)
+#define     CMX655_ISM_AMPOC       BIT(2)
+#define     CMX655_ISM_AMPCLIP     BIT(3)
+#define     CMX655_ISM_CLKRDY      BIT(4)
+#define     CMX655_ISM_THERM       BIT(5)
+#define     CMX655_ISM_VOL         BIT(6)
+#define     CMX655_ISM_CAL         BIT(7)
+#define CMX655_ISE      (0x02)
+#define CMX655_CLKCTRL  (0x03)
+#define     CMX655_CLKCTRL_PREDIV_SHIFT    (0)
+#define     CMX655_CLKCTRL_PREDIV_VALUE    (0x3)
+#define     CMX655_CLKCTRL_PREDIV_MASK     (CMX655_CLKCTRL_PREDIV_VALUE << \
+					CMX655_CLKCTRL_PREDIV_SHIFT)
+#define     CMX655_CLKCTRL_CLRSRC_SHIFT    (2)
+#define     CMX655_CLKCTRL_CLRSRC_VALUE    (0x7)
+#define     CMX655_CLKCTRL_CLRSRC_MASK     (CMX655_CLKCTRL_CLRSRC_VALUE << \
+					CMX655_CLKCTRL_CLRSRC_SHIFT)
+#define     CMX655_CLKCTRL_CLRSRC_RCLK     (0x0 << CMX655_CLKCTRL_CLRSRC_SHIFT)
+#define     CMX655_CLKCTRL_CLRSRC_LPO      (0x1 << CMX655_CLKCTRL_CLRSRC_SHIFT)
+#define     CMX655_CLKCTRL_CLRSRC_LRCLK    (0x7 << CMX655_CLKCTRL_CLRSRC_SHIFT)
+#define     CMX655_CLKCTRL_SR_SHIFT        (5)
+#define     CMX655_CLKCTRL_SR_VALUE        (0x3)
+#define     CMX655_CLKCTRL_SR_MASK         (CMX655_CLKCTRL_SR_VALUE << \
+					CMX655_CLKCTRL_SR_SHIFT)
+#define     CMX655_CLKCTRL_SR_8K            (0x0 << CMX655_CLKCTRL_SR_SHIFT)
+#define     CMX655_CLKCTRL_SR_16K           (0x1 << CMX655_CLKCTRL_SR_SHIFT)
+#define     CMX655_CLKCTRL_SR_32K           (0x2 << CMX655_CLKCTRL_SR_SHIFT)
+#define     CMX655_CLKCTRL_SR_48K           (0x3 << CMX655_CLKCTRL_SR_SHIFT)
+
+#define CMX655_RDIVHI   (0x04)
+#define CMX655_RDIVLO   (0x05)
+#define CMX655_NDIVHI   (0x06)
+#define CMX655_NDIVLO   (0x07)
+#define CMX655_PLLCTRL  (0x08)
+#define     CMX655_PLLCTRL_CPI_SHIFT       (0)
+#define     CMX655_PLLCTRL_LFILT_SHIFT     (4)
+#define CMX655_SAICTRL  (0x09)
+#define     CMX655_SAI_PCM         BIT(0)
+#define     CMX655_SAI_BINV        BIT(2)
+#define     CMX655_SAI_POL         BIT(3)
+#define     CMX655_SAI_DLY         BIT(4)
+#define     CMX655_SAI_MONO        BIT(5)
+#define     CMX655_SAI_WL          BIT(6)
+#define     CMX655_SAI_MSTR        BIT(7)
+
+#define CMX655_SAIMUX   (0x0a)
+#define CMX655_RVF      (0x0c)
+#define     CMX655_VF_DCBLOCK_SHIFT     (2)
+#define     CMX655_VF_DCBLOCK           (0x1 << CMX655_VF_DCBLOCK_SHIFT)
+#define CMX655_LDCTRL   (0x0d)
+#define CMX655_RDCTRL   (0x0e)
+#define CMX655_LEVEL    (0x0f)
+#define CMX655_NGCTRL   (0x1c)
+#define CMX655_NGTIME   (0x1d)
+#define CMX655_NGLSTAT  (0x1e)
+#define CMX655_NGRSTAT  (0x1f)
+#define CMX655_PVF      (0x28)
+#define CMX655_PREAMP   (0x29)
+#define CMX655_VOLUME   (0x2a)
+#define CMX655_ALCCTRL  (0x2b)
+#define CMX655_ALCTIME  (0x2c)
+#define CMX655_ALCGAIN  (0x2d)
+#define CMX655_ALCSTAT  (0x2e)
+#define CMX655_DST      (0x2f)
+#define CMX655_CPR      (0x30)
+#define CMX655_SYSCTRL  (0x32)
+#define     CMX655_SYSCTRL_MICR    BIT(0)
+#define     CMX655_SYSCTRL_MICL    BIT(1)
+#define     CMX655_SYSCTRL_PAMP    BIT(3)
+#define     CMX655_SYSCTRL_LOUT    BIT(4)
+#define     CMX655_SYSCTRL_SAI     BIT(5)
+
+#define CMX655_COMMAND  (0x33)
+#define     CMX655_CMD_CLOCK_STOP  (0x00)
+#define     CMX655_CMD_CLOCK_START (0x01)
+#define     CMX655_CMD_SOFT_RESET  (0xff)
+
+/*  GPIO connection for reset and irq */
+#define CMX655_RESETN   (24)
+#define CMX655_IRQN     (25)
+#define CMX655_CS       (8)
+
+#define CMX655_RATES (SNDRV_PCM_RATE_8000 | \
+		SNDRV_PCM_RATE_16000 | \
+		SNDRV_PCM_RATE_32000 | \
+		SNDRV_PCM_RATE_48000)
+
+#define CMX655_FMTS (SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE)
+
+/*
+ * clock id's when calling set sysclk
+ * Auto = Use RCLK when in DAI primary mode. Use LRCLK in secondary mode.
+ * DO NOT use CMX655_SYSCLK_LRCLK when in DAI primary mode
+ */
+#define CMX655_SYSCLK_AUTO  (0)
+#define CMX655_SYSCLK_RCLK  (1)
+#define CMX655_SYSCLK_LRCLK (2)
+#define CMX655_SYSCLK_LPO   (3)
+#define CMX655_SYSCLK_MIN   (CMX655_SYSCLK_AUTO)
+#define CMX655_SYSCLK_MAX   (CMX655_SYSCLK_LPO)
+
+/* CMX655 microphone widget helper macro */
+#define CMX655_DAPM_MIC(wname, wshift)				      \
+{ .id = snd_soc_dapm_mic, .name = (wname), .kcontrol_news = NULL,     \
+.num_kcontrols = 0, .reg = CMX655_SYSCTRL, .shift = (wshift),	      \
+.mask = 1, .on_val = 1, .off_val = 0, .event = cmx655_mic_dapm_event, \
+.event_flags = SND_SOC_DAPM_POST_PMU }
+
+struct cmx655_dai_data {
+	int sys_clk;
+	unsigned int enabled_streams;
+	bool best_clk_running;
+	int clk_src;
+};
+
+struct cmx655_data {
+	struct regmap *regmap;
+	struct cmx655_dai_data dai_data;
+	struct gpio_desc *reset_gpio;
+	int irq;
+	/* Number of times the class-D overcurrent has been reset */
+	unsigned int oc_cnt;
+};
+
+extern const struct regmap_config cmx655_regmap;
+
+int cmx655_common_register_component(struct device *dev, struct regmap *regmap, int irq);
+void cmx655_common_unregister_component(struct device *dev);
+
+#endif
-- 
2.47.2


