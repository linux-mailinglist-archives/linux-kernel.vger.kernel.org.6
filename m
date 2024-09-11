Return-Path: <linux-kernel+bounces-325126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A91F3975550
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0821C233BB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1171519E976;
	Wed, 11 Sep 2024 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="qaU6KKEV"
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B0219E999
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064896; cv=none; b=VnbJrNbNtIzydFfOlK6QFs4Hnuvlk07Mt20DXPTYkRwvJbJCt4U8naT0GJNShesRMaC5zpfP8SpSoXYsBIqBt2o3yd3r+LbHECIlydHmIFU298nldES8+IoXE1sEmEh94eQAVjsktEUtMjNEuhV0f0Z8YRKrM+0PMldd7M/YAsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064896; c=relaxed/simple;
	bh=aIC1K2aHkAKySeXczfO9TX+qUogWDRqxMHBmhbZrBWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WCwgz/ZgTHgc1stiM5XSAaC/XBhzwBvd5oaYkyybay7CHXZsHT5kAPkFiucxOBQM02B+6l3s+bN5Nvej3kSvqyU3pw26aWCaTgP4MiIUaRjIaDxYqFZg0v0ZZDnxumNAMGuH/UDaNye2Pmy2E6jJW4wDOp3M05l1lqvnisKAc0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=qaU6KKEV; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-7d4f8a1626cso5372898a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1726064894; x=1726669694; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oJxb1Dd/nqjN3jOGEzjCvMjgouASIZ/qDf2nqdmTCpQ=;
        b=qaU6KKEV3gORa25JaQg99csgvb85OgGk/ntEVTML+L6tTpn+hsPsfItlR1/5+mpW69
         ty6IWbfoCkf3XoBVxjks8XoDsB6M/O1RlRZJD+J+fewMxevUTiUB+JjNnDovQJ+hF2qm
         awFR4JNxTqD7uN1CHJXOVbUiq0ZA98WAqsYYEj/kpMIkRCtxANnwBFVfkxfTCh2utkhY
         JOhwLl7CjBFJvj4u7jB2M5NxcT6q4fkyMzL7JoKoguhJs4EbuFT22Hb2xtnlmi/hd/Gq
         aenhfO/oiNfACPVFr6K5iA688iwqBfQWUR7VRnR9W3ruFlreoV2pY7Dc8XWIvQ4eXgoY
         6VKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726064894; x=1726669694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJxb1Dd/nqjN3jOGEzjCvMjgouASIZ/qDf2nqdmTCpQ=;
        b=J9AOMdB0CjB1ZVsw5/PeoxzI88xzpQQlBQYgtk3oR8XaZ/bSOv3Vc6UHlAaqcQ88oR
         cZfZHBGeb6/5A833ftjAKABiBQTjv7EpKjMVuquNsa17w3iqp2YP7NSACNHudCnEBMvf
         tT5kHMdi0cgA9SWoT20QSL2OwjKlp599ODdz6rqcQC0SS7Q7xO+r/hQMs3obW2sTaqQs
         EW3u3hBqIb4EHk1jPJ7hBhdwcqG3Eu58/AJ8NJZqHdd/eTucIKyYTdzkVtELh0BxACL6
         6PvezJlp+69xwOcWk2Qv7GjqkFu4krvSvyko7TaeFjWqlDKwyTPMZ0/V2dlBVXn0przT
         rNHA==
X-Gm-Message-State: AOJu0Yy4zCZayixJt2AgqkC8lZn6n6O7ByZWMiBicaGh4rIKswFTUwz8
	DSIcp0xcdvEIkN0WrF1QFj1qGx0pPk3Hvuk/lOY1WDyQqZbMnfkSrVeyFaLUaA==
X-Google-Smtp-Source: AGHT+IHE/LplC/CkwydHVCAYEN6XSx/BzJK9oOj9hYZByiPJ0HRu5OTmb9W9Vhmyyzp/B1ZaF4eEjQ==
X-Received: by 2002:a05:6a21:2d84:b0:1cf:506f:9d3a with SMTP id adf61e73a8af0-1cf5e1d0c8fmr6113767637.46.1726064893948;
        Wed, 11 Sep 2024 07:28:13 -0700 (PDT)
Received: from [172.16.118.100] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbfe46c9sm10639116a91.11.2024.09.11.07.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:28:13 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Wed, 11 Sep 2024 19:57:20 +0530
Subject: [PATCH 3/8] mikrobus: Add mikrobus driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-mikrobus-dt-v1-3-3ded4dc879e7@beagleboard.org>
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
In-Reply-To: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
To: fabien.parent@linaro.org, d-gole@ti.com, lorforlinux@beagleboard.org, 
 jkridner@beagleboard.org, robertcnelson@beagleboard.org, 
 Andrew Davis <afd@ti.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>, 
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3469; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=aIC1K2aHkAKySeXczfO9TX+qUogWDRqxMHBmhbZrBWs=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBm4ajWa7wjGCZ2pwHW97n8mcSyzAy8uGIDEWwCe
 PlMnb28cjuJAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZuGo1gAKCRAFzvXHieVa
 dGtwD/wK0GDxUstHZk9/X3B2dO3mcSFAHK2I87pzLlM/z9OLe1Oh9Bvxa7pIm/b34irjEaCKPZB
 0weGY8nzbMXoshz0VVrhsDP2cgDhQ2+jnn5bhrLdW5fSpjwmncQCiE6SY9UhC7+YSPotD0/Wgvu
 oe91TYvLZ7hBpbJceOOXCCnQI5bLGsuO1wVGXUmnXLdhfA/7/+Uaa7LG2uiHpziq2blWQLxgWpe
 NfNfzXIBZ6WxeyIG7es4PMSHV7cNxOeAqvI+N451kdxz4/0lXFQeTP6tuSxiL0GbFC/TUSFchas
 3w7XuaEgSQebABxomUtx67jw9V3TRhg31f2Vwp2yr9SaGyL7dzhFQnpy78D0KNitbhicVlpCvxP
 4OpAqS+KDs1+6McuHpMavxF1XIoctnOuBgUi4Vd0oIwhxMQkS6EOnbHuhNVo6Mul2A5LW47SVIt
 3BC/4tbB/+pglWxsY9H5XkYmU4cAsFp3f5Wk7XbgQLUj0RrkOParX2gY3Yd8Bi/QlsH9lgKE9jr
 7Iun31RsKGi/Fv6/yrUUZpIeGjUvzRVXkG0qqCEYpW3wqT5+VkVb6lF6XEhP3zyFxg/VGA995sP
 +byFalejshGQE4aYErw2Owqwah7UzhA0cTC0TOq9Pk5yK+uve4o2yqDNAdK9Eo30G60g968rdY4
 sniJ3PiTe5qhtUg==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

A simple platform driver for now that does nothing. This is required
because without a platform driver, the mikrobus_gpio0 nexus node cannot
be used.

In future, this driver will also allow for dynamic board detection using
1-wire eeprom in new mikrobus boards.

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
 MAINTAINERS              |  1 +
 drivers/misc/Kconfig     | 17 +++++++++++++++++
 drivers/misc/Makefile    |  1 +
 drivers/misc/mikrobus.rs | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0cc27446b18a..d0c18bd7b558 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15433,6 +15433,7 @@ MIKROBUS CONNECTOR
 M:	Ayush Singh <ayush@beagleboard.org>
 S:	Maintained
 F:	Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
+F:	drivers/misc/mikrobus.rs
 
 MIKROTIK CRS3XX 98DX3236 BOARD SUPPORT
 M:	Luka Kovacic <luka.kovacic@sartura.hr>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 3fe7e2a9bd29..30defb522e98 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -610,6 +610,23 @@ config MARVELL_CN10K_DPI
 	  To compile this driver as a module, choose M here: the module
 	  will be called mrvl_cn10k_dpi.
 
+menuconfig MIKROBUS
+	tristate "Module for instantiating devices on mikroBUS ports"
+	help
+	  This option enables the mikroBUS driver. mikroBUS is an add-on
+	  board socket standard that offers maximum expandability with
+	  the smallest number of pins. The mikroBUS driver instantiates
+	  devices on a mikroBUS port described by identifying data present
+	  in an add-on board resident EEPROM, more details on the mikroBUS
+	  driver support and discussion can be found in this eLinux wiki :
+	  elinux.org/Mikrobus
+
+
+	  Say Y here to enable support for this driver.
+
+	  To compile this code as a module, chose M here: the module
+	  will be called mikrobus.ko
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index a9f94525e181..86ea188e3cf9 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -72,3 +72,4 @@ obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
 obj-$(CONFIG_NSM)		+= nsm.o
 obj-$(CONFIG_MARVELL_CN10K_DPI)	+= mrvl_cn10k_dpi.o
 obj-y				+= keba/
+obj-$(CONFIG_MIKROBUS)		+= mikrobus.o
diff --git a/drivers/misc/mikrobus.rs b/drivers/misc/mikrobus.rs
new file mode 100644
index 000000000000..a52268efd71b
--- /dev/null
+++ b/drivers/misc/mikrobus.rs
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! MikroBUS driver
+
+use kernel::c_str;
+use kernel::platform::{self, DeviceId};
+use kernel::prelude::*;
+
+kernel::module_platform_driver! {
+    driver: MikrobusDriver,
+    of_table: [DeviceId::new(c_str!("mikrobus-connector"))],
+    name: "mikrobus",
+    author: "Ayush Singh <ayush@beagleboard.org>",
+    description: "MikroBUS connector Driver",
+    license: "GPL",
+}
+
+struct MikrobusDriver;
+
+#[vtable]
+impl platform::Driver for MikrobusDriver {
+    const NAME: &'static CStr = c_str!("MikroBUS");
+
+    fn probe(_dev: &mut platform::Device) -> Result {
+        pr_debug!("Mikrobus Driver (probe)\n");
+        Ok(())
+    }
+
+    fn remove(_dev: &mut platform::Device) {
+        pr_debug!("Mikrobus Driver (remove)\n");
+    }
+}

-- 
2.46.0


