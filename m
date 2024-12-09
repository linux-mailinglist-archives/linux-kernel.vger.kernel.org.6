Return-Path: <linux-kernel+bounces-437901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 502C19E9A4C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9463416775C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2C61E9B03;
	Mon,  9 Dec 2024 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A8kJMkpq"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7DB1C5CBC;
	Mon,  9 Dec 2024 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757523; cv=none; b=nHH/zdRpagikprM4vV5xNoMLK9d47GWs36B5xjQHcYuGE7D0HiaROTez2L1eCQ11kFOvn4l3GY/ch8Kia5HLhhF4qOGUInMTp+DO7NKI7BKlK4/XtCxpo9pdpgK68EnU4QmdcFXERc6sS8b4H7bqeBaguSW2ixsOXGRHUYvQf4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757523; c=relaxed/simple;
	bh=GlHe5MSqIY/qCyPEONQZv5fJdEQl5XjwDqUWxFDiHno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BvyhBqg0+8hV6vQEvHe2bMthA+S1OpWUjNZzP34YieirPSTDq7zKBmroCvsfAOckxHITU47HU5DwKn//wWmSgWc+llbLla2XE77qksTKttIAuTjh3ala/NAxkkdfP9mdQjUDn3xxWvNChgbgLQ1rjx7wZDQRi+Nf1zxQAdeO3aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A8kJMkpq; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 14EA91C0012;
	Mon,  9 Dec 2024 15:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733757518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7gQVQsO33py92daYEPtx0h2qEmnzEGdMuLYStCbvuyw=;
	b=A8kJMkpqZMp805S8+u/fx6IcH3WxIZtpP1DMAXAPAjHgflPtc9wPTyeGmgLTZXInhF6VDK
	NwvckGGEgYJTHvqyA7rwiGVoxee57ggTli5+roj4DBfFvxy9TOsqUdppQzTMUPZZtjr2nc
	25ydkHUCXwlKp2JUByiQNMosw/2te4nsocM3vzozBsCzUQjri60VEvk7Y8457Z3mQBg0KK
	Q81vURZxC7G8SWAnxHJS6MnNZ/HteTP14KdOBeWvKNdfzfrdPklb4kuAHSEoCO/taUvTyI
	h2ReqMvGbkFm+3M7IT0I/eG9OJ4C/aXQU5DsOjr0bedoWa1Ezt0F9NW6AZDRVg==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Davis <afd@ti.com>,
	Ayush Singh <ayush@beagleboard.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 7/7] of: unittest: Add tests for export symbols
Date: Mon,  9 Dec 2024 16:18:25 +0100
Message-ID: <20241209151830.95723-8-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241209151830.95723-1-herve.codina@bootlin.com>
References: <20241209151830.95723-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The export symbols feature allows to use some additional symbols
provided in an export symbols node to resolve overlay symbols.

Add tests to exercise the export symbols feature.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/of/unittest-data/Makefile             |  5 ++
 .../unittest-data/overlay_export_symbols.dtso | 15 +++++
 .../of/unittest-data/testcases_common.dtsi    |  1 +
 .../unittest-data/tests-export-symbols.dtsi   | 30 +++++++++
 drivers/of/unittest.c                         | 64 +++++++++++++++++++
 5 files changed, 115 insertions(+)
 create mode 100644 drivers/of/unittest-data/overlay_export_symbols.dtso
 create mode 100644 drivers/of/unittest-data/tests-export-symbols.dtsi

diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
index 01a966e39f23..b51be046749a 100644
--- a/drivers/of/unittest-data/Makefile
+++ b/drivers/of/unittest-data/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_OF_OVERLAY) += overlay.dtbo.o \
 			    overlay_gpio_04a.dtbo.o \
 			    overlay_gpio_04b.dtbo.o \
 			    overlay_pci_node.dtbo.o \
+			    overlay_export_symbols.dtbo.o \
 			    overlay_bad_unresolved.dtbo.o
 
 # enable creation of __symbols__ node
@@ -66,6 +67,10 @@ DTC_FLAGS_testcases += -Wno-interrupts_property \
 #			  overlay_bad_add_dup_prop.dtbo \
 #			  overlay_bad_phandle.dtbo \
 #			  overlay_bad_symbol.dtbo \
+#
+# Also overlay_export_symbols_ovl.dtbo is designed to be applied to a specific
+# node and cannot be applied statically with fdtoverlay
+
 
 apply_static_overlay_1 := overlay_0.dtbo \
 			  overlay_1.dtbo \
diff --git a/drivers/of/unittest-data/overlay_export_symbols.dtso b/drivers/of/unittest-data/overlay_export_symbols.dtso
new file mode 100644
index 000000000000..89c9df4ef89b
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_export_symbols.dtso
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/ {
+	fragment@0 {
+		target-path="";
+		__overlay__ {
+			ovl_node {
+				ref-base = <&test_export_base>;
+				ref-node = <&test_export_node>;
+			};
+		};
+	};
+};
diff --git a/drivers/of/unittest-data/testcases_common.dtsi b/drivers/of/unittest-data/testcases_common.dtsi
index 1c2cdf353ae3..21ffe0fb03ef 100644
--- a/drivers/of/unittest-data/testcases_common.dtsi
+++ b/drivers/of/unittest-data/testcases_common.dtsi
@@ -18,4 +18,5 @@ node-remove {
 #include "tests-address.dtsi"
 #include "tests-platform.dtsi"
 #include "tests-overlay.dtsi"
+#include "tests-export-symbols.dtsi"
 #include "tests-lifecycle.dtsi"
diff --git a/drivers/of/unittest-data/tests-export-symbols.dtsi b/drivers/of/unittest-data/tests-export-symbols.dtsi
new file mode 100644
index 000000000000..1650289b34cd
--- /dev/null
+++ b/drivers/of/unittest-data/tests-export-symbols.dtsi
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/ {
+	testcase-data {
+		test-export-symbols {
+			test_export_symbols_b0: base0 {
+				test_export_symbols_n0: node {
+					dummy;
+				};
+
+				export-symbols {
+					test_export_base = <&test_export_symbols_b0>;
+					test_export_node = <&test_export_symbols_n0>;
+				};
+			};
+
+			test_export_symbols_b1: base1 {
+
+				test_export_symbols_n1: node {
+					dummy;
+				};
+
+				export-symbols {
+					test_export_base = <&test_export_symbols_b1>;
+					test_export_node = <&test_export_symbols_n1>;
+				};
+			};
+		};
+	};
+};
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index f19e15f8b288..1be4ffb7a4db 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -4043,6 +4043,69 @@ static __init void of_unittest_overlay_high_level(void)
 	mutex_unlock(&of_mutex);
 }
 
+OVERLAY_INFO_EXTERN(overlay_export_symbols);
+
+static __init void of_unittest_export_symbols(const char *prefix,
+					      const char *base_full_path)
+{
+	const struct overlay_info ovl = OVERLAY_INFO(overlay_export_symbols, 0, 0);
+	struct device_node *ovl_node;
+	struct device_node *base;
+	struct device_node *node;
+	struct device_node *ref;
+	int ovcs_id;
+	u32 size;
+	int ret;
+
+	base = of_find_node_by_path(base_full_path);
+	if (unittest(base, "%s: Get base (%s) failed\n", prefix, base_full_path))
+		return;
+
+	node = of_get_child_by_name(base, "node");
+	if (unittest(base, "%s: Get node from %pOF failed\n", prefix, base))
+		goto end_put_base;
+
+	size = ovl.dtbo_end - ovl.dtbo_begin;
+	ret = of_overlay_fdt_apply(ovl.dtbo_begin, size, &ovcs_id, base, "export-symbols");
+	if (unittest(!ret, "%s: Apply '%s' failed (%d)\n", prefix, ovl.name, ret))
+		goto end_put_node;
+
+	ovl_node = of_get_child_by_name(base, "ovl_node");
+	if (unittest(ovl_node, "%s: Get ovl_node from %pOF failed\n", prefix, base))
+		goto end_remove_overlay;
+
+	ref = of_parse_phandle(ovl_node, "ref-base", 0);
+	if (unittest(ref, "%s: Parse 'ref-base' from %pOF failed\n", prefix, ovl_node))
+		goto end_put_ovl_node;
+	unittest(ref == base,
+		 "%s: Node from 'ref-base' phandle mismatches (got %pOF, expected %pOF)\n",
+		 prefix, ref, base);
+	of_node_put(ref);
+
+	ref = of_parse_phandle(ovl_node, "ref-node", 0);
+	if (unittest(ref, "%s: Parse 'ref-node' from %pOF failed\n", prefix, ovl_node))
+		goto end_put_ovl_node;
+	unittest(ref == node,
+		 "%s: Node from 'ref-node' phandle mismatches (got %pOF, expected %pOF)\n",
+		 prefix, ref, node);
+	of_node_put(ref);
+
+end_put_ovl_node:
+	of_node_put(ovl_node);
+end_remove_overlay:
+	of_overlay_remove(&ovcs_id);
+end_put_node:
+	of_node_put(node);
+end_put_base:
+	of_node_put(base);
+}
+
+static __init void of_unittest_overlay_export_symbols(void)
+{
+	of_unittest_export_symbols("base0", "/testcase-data/test-export-symbols/base0");
+	of_unittest_export_symbols("base1", "/testcase-data/test-export-symbols/base1");
+}
+
 static int of_unittest_pci_dev_num;
 static int of_unittest_pci_child_num;
 
@@ -4281,6 +4344,7 @@ static int __init of_unittest(void)
 	of_unittest_overlay();
 	of_unittest_lifecycle();
 	of_unittest_pci_node();
+	of_unittest_overlay_export_symbols();
 
 	/* Double check linkage after removing testcase data */
 	of_unittest_check_tree_linkage();
-- 
2.47.0


