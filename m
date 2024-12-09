Return-Path: <linux-kernel+bounces-437903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9F89E9A49
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5969285685
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FD02165EA;
	Mon,  9 Dec 2024 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IqYHYxEo"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553811C5CB4;
	Mon,  9 Dec 2024 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757524; cv=none; b=IBOo9m2rHX9ELJu+BpqW1wwuEUGAqcrmS6LNT/helAoDXTAQYHzjFe19nlwx38/XAaWA7/hiLxcMV1KBccG0gwhbUE/WTxTz64fGSVylrWwSH5+gqLh+9UB/0x6jel90rhv5oQxDU0xOhUAwVKW1cVgP5NaGblonvoxr38RTijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757524; c=relaxed/simple;
	bh=xcE1Dp+GtZr4tqDbYM//n9fyWpJ+43fYPFpmfVaOKt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tB2qpXt7AUVBaG8eSWKJl+eaV+AKndFjes1KFOnVrrme/DY2A0O9CbmZsnw5Ead3CcWrtum1p+GTGW1c1auC8UR51XuTL3S7Zs92xELmWz6U8Srt9iVt/0Qeq7fX0jL4cZeH0CjqmsYQWB49KSgPgCx1WpC+rb+oTnXOtT8nGwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IqYHYxEo; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 180FA1C000D;
	Mon,  9 Dec 2024 15:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733757514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aTiTEyB+NdrrDnoEp3UcmqGVspuxMmOtaQInMG+LjNg=;
	b=IqYHYxEo4st2YMIrFOpbxOVAr3N9YEBR8aR4Ct15yVy9yRyz7p2nmr8h3GXVji1oXlmGUe
	+d7gujNRYtahKTE45JRebnGKLpoh0MskccrqbtwlZGaVllENmDTib8sUNBAXLeQN3lkBBW
	IvK6S4gLcYON7UTuY73lvJMmCxV4OWiFWjmE8SzgkPJ1K/NBPgwRFhX+advwHVyhPLtr51
	NFpahxN7uWuz2HqJGgGDsWHvbm7vlIb9NwbUDYpqo0Ke8197zA2T4d+xv1k7vS5w8VHQX9
	xSJFzUA/rOBedde4hjFa18HPk0J85qKOEBGIb4bsP5OQeJOXgKeB0tV7qhRTZA==
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
Subject: [PATCH 2/7] of: resolver: Introduce get_phandle_from_symbols_node()
Date: Mon,  9 Dec 2024 16:18:20 +0100
Message-ID: <20241209151830.95723-3-herve.codina@bootlin.com>
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

In order to simplify the introduction of the export symbols node
handling, group necessary operations done to get a phandle from the
__symbols__ node in this dedicated get_phandle_from_symbols_node()
function.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/of/resolver.c | 44 +++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
index 779db058c42f..2560b33fa750 100644
--- a/drivers/of/resolver.c
+++ b/drivers/of/resolver.c
@@ -214,6 +214,28 @@ static int adjust_local_phandle_references(const struct device_node *local_fixup
 	return 0;
 }
 
+static int get_phandle_from_symbols_node(const struct device_node *tree_symbols,
+					 const char *symbol_name,
+					 phandle *phandle)
+{
+	struct device_node *refnode;
+	const char *refpath;
+	int err;
+
+	err = of_property_read_string(tree_symbols, symbol_name, &refpath);
+	if (err)
+		return err;
+
+	refnode = of_find_node_by_path(refpath);
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
@@ -249,11 +271,10 @@ static int adjust_local_phandle_references(const struct device_node *local_fixup
  */
 int of_resolve_phandles(struct device_node *overlay)
 {
-	struct device_node *child, *local_fixups, *refnode;
-	struct device_node *tree_symbols, *overlay_fixups;
-	struct property *prop;
-	const char *refpath;
+	struct device_node *child, *local_fixups, *overlay_fixups;
+	struct device_node *tree_symbols;
 	phandle phandle, phandle_delta;
+	struct property *prop;
 	int err;
 
 	tree_symbols = NULL;
@@ -306,23 +327,14 @@ int of_resolve_phandles(struct device_node *overlay)
 		if (!of_prop_cmp(prop->name, "name"))
 			continue;
 
-		err = of_property_read_string(tree_symbols,
-				prop->name, &refpath);
+		err = get_phandle_from_symbols_node(tree_symbols, prop->name,
+						    &phandle);
 		if (err) {
-			pr_err("node label '%s' not found in live devicetree symbols table\n",
+			pr_err("node label '%s' not found or invalid in live devicetree symbols table\n",
 			       prop->name);
 			goto out;
 		}
 
-		refnode = of_find_node_by_path(refpath);
-		if (!refnode) {
-			err = -ENOENT;
-			goto out;
-		}
-
-		phandle = refnode->phandle;
-		of_node_put(refnode);
-
 		err = update_usages_of_a_phandle_reference(overlay, prop, phandle);
 		if (err)
 			break;
-- 
2.47.0


