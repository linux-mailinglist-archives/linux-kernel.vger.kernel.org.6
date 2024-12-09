Return-Path: <linux-kernel+bounces-437906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B120F9E9A55
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D970C1887959
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADB8223C49;
	Mon,  9 Dec 2024 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L1XcsIzY"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810571C5CC1;
	Mon,  9 Dec 2024 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757525; cv=none; b=JNG1KkmMpAfyYvNGERD0Crs8erBG6WMO5hiJjXv3I9Wip77b4qAMffWor/h+FkP3OeXWv4eyGZIsodADijF/5DrAk79gGTZcu/V/Dq55xhNI75ID+VMYKD2acDE1yxGqGz30g/m2EZWFVqq9DJYX9AdJhsTjV9tJKTXBq0jiUoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757525; c=relaxed/simple;
	bh=7uYFDC/DD6qGCYtp5pFL4NX/XzVCHwPStn3sfh7zDyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBjqVpS4gzEV6jbaR6TgA1n+Q7K7nX6V9RxOH9IOPtueC16HKtC/O+LWPAAh2dswnhC98i2Ijz3rGezYfIepIq+pb6y27cZOP+mz4wVYHVLlvn5Yo99D+pLOdgnPMk5qu0Gj4U8TzYBkZoWetQ2UtaA61rkYfbp0jhQkTQXUqUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L1XcsIzY; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id A06561C0010;
	Mon,  9 Dec 2024 15:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733757516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tr7OhDfkg+fL9ioPWrN+UHmbgRARJumuDlQwW8WsOKg=;
	b=L1XcsIzYKXLsjG4jxuDphCJPUo7uOWpGNXwzuxpeCWfwayTRjC6SpsO/37uNfpuN/NgmOM
	cTSQ7sRk3Kut3G1sQmQZCnWjzwH08ZbcPqZgxmLh3sIU8ChojoALzueZrOLw/jtDAtiBP8
	f708O9aejHqvJ9ckapBKR9VN3UNhRT9MmuoBC+Wyah6+kQnUjU7Oft1Z59w8rlr3lr2Rdc
	rLu/EDmRni7jCoR5a0BTS0iddaIJ1tn6XL/o3vvm8S/JfyIE6sKgi9O98/9D+KPzAcZHz5
	AIbH4tv9kCPavxnOiCQ8ZVEhlP/mfEAtvnh6EhEii/BR3fnNbNePBQmlb8TIbw==
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
Subject: [PATCH 4/7] of: resolver: Add support for the export symbols node
Date: Mon,  9 Dec 2024 16:18:22 +0100
Message-ID: <20241209151830.95723-5-herve.codina@bootlin.com>
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

Symbols resolution done when an overlay is applied looks only at the
global __symbol__ node to resolve unknown symbols from the overlay (i.e
symbols listed in the overlay __fixups__ node).

In order to provide flexibilities and allow to define some additional
symbols visible only when an overlay is applied to a specific node,
introduce the export symbols node.

The export symbols node adds some additional symbols that can be used
in the symbols resolution. The resolver tries to match unresolved
symbols first using the export symbols node and, if a match is not
found, it tries to match using the global __symbol__ node.

Contrary to symbols available in the global __symbols__ node, symbols
listed in the export symbols node can be considered as local symbols.
Indeed, they can be changed depending on the node the overlay is going
to be applied to and are only visibible from the current recolver call.

Handle those additional symbols given by the export symbols node in the
symbols resolution.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/of/resolver.c | 33 +++++++++++++++++++++++++++++----
 drivers/of/unittest.c |  4 ++--
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
index f5f6c46231d1..b685c46b20b8 100644
--- a/drivers/of/resolver.c
+++ b/drivers/of/resolver.c
@@ -222,6 +222,9 @@ static int get_phandle_from_symbols_node(const struct device_node *tree_symbols,
 	const char *refpath;
 	int err;
 
+	if (!tree_symbols)
+		return -ENOENT;
+
 	err = of_property_read_string(tree_symbols, symbol_name, &refpath);
 	if (err)
 		return err;
@@ -236,6 +239,25 @@ static int get_phandle_from_symbols_node(const struct device_node *tree_symbols,
 	return 0;
 }
 
+static int get_phandle_from_export_node(const struct device_node *export_symbols,
+					const char *symbol_name,
+					phandle *phandle)
+{
+	struct device_node *refnode;
+
+	if (!export_symbols)
+		return -ENOENT;
+
+	refnode = of_parse_phandle(export_symbols, symbol_name, 0);
+	if (!refnode)
+		return -ENOENT;
+
+	*phandle = refnode->phandle;
+	of_node_put(refnode);
+
+	return 0;
+}
+
 /**
  * of_resolve_phandles - Relocate and resolve overlay against live tree
  *
@@ -320,7 +342,7 @@ int of_resolve_phandles(struct device_node *overlay, const struct device_node *e
 	}
 
 	tree_symbols = of_find_node_by_path("/__symbols__");
-	if (!tree_symbols) {
+	if (!tree_symbols && !export_symbols) {
 		pr_err("no symbols in root of device tree.\n");
 		err = -EINVAL;
 		goto out;
@@ -332,10 +354,13 @@ int of_resolve_phandles(struct device_node *overlay, const struct device_node *e
 		if (!of_prop_cmp(prop->name, "name"))
 			continue;
 
-		err = get_phandle_from_symbols_node(tree_symbols, prop->name,
-						    &phandle);
+		err = get_phandle_from_export_node(export_symbols, prop->name,
+						   &phandle);
+		if (err)
+			err = get_phandle_from_symbols_node(tree_symbols, prop->name,
+							    &phandle);
 		if (err) {
-			pr_err("node label '%s' not found or invalid in live devicetree symbols table\n",
+			pr_err("node label '%s' not found or invalid in live devicetree symbols or export tables\n",
 			       prop->name);
 			goto out;
 		}
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 7b97d4fc0236..e76ac087ea98 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -4025,7 +4025,7 @@ static __init void of_unittest_overlay_high_level(void)
 	/* ---  overlay_bad_unresolved  --- */
 
 	EXPECT_BEGIN(KERN_ERR,
-		     "OF: resolver: node label 'this_label_does_not_exist' not found in live devicetree symbols table");
+		     "OF: resolver: node label 'this_label_does_not_exist' not found or invalid in live devicetree symbols or export tables");
 	EXPECT_BEGIN(KERN_ERR,
 		     "OF: resolver: overlay phandle fixup failed: -22");
 
@@ -4035,7 +4035,7 @@ static __init void of_unittest_overlay_high_level(void)
 	EXPECT_END(KERN_ERR,
 		   "OF: resolver: overlay phandle fixup failed: -22");
 	EXPECT_END(KERN_ERR,
-		   "OF: resolver: node label 'this_label_does_not_exist' not found in live devicetree symbols table");
+		   "OF: resolver: node label 'this_label_does_not_exist' not found or invalid in live devicetree symbols or export tables");
 
 	return;
 
-- 
2.47.0


