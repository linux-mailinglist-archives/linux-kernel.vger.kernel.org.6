Return-Path: <linux-kernel+bounces-437904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27E89E9A4A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86EAD285682
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D572216E2B;
	Mon,  9 Dec 2024 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QHNWSd45"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5531F1C5CB3;
	Mon,  9 Dec 2024 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757524; cv=none; b=ZYCSZ6H/utC0YUg/AmeOUZB7OL8jcvF+8gvwIHziqf37qUHO2VkNvJqWZ28Kgde4/xcyVs1CDRIigoFAPpEf4/lkXdkU+Ibt/vlhUS5yJ/23Y/XQnB72FFma7bJqBuD4+msVH5HkA99s0nw56kTt61eq2wkfY8li/ngM8J27s2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757524; c=relaxed/simple;
	bh=bddoC57aSA5Z++Q1YV92YnSN11dyWZNLBdBNmMRB1cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCUEeqm/Qxbpi0FkUCNDbUCj0aKnrsL6vDUM8eZqfR00YROVlB9BuELaDY+AztA53OVcqmanYLaEBqItfkZx6inBAhwVPpA0ERJ0GKGQduujdg6TiesS/wNWozvwOYVb+7QCZHS/XON+IXy7vbLApPsJFevjxAujjnUbNosRiwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QHNWSd45; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id DAA881C0002;
	Mon,  9 Dec 2024 15:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733757515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N1lLHg+b2rS2dS5LxXdZG0vEvHnYFFE2HcdcCPiiZsk=;
	b=QHNWSd45eqNZBZQrCzHQbh53U0NxOH2eN55RAOghTckOBm2h5TDUuF48MnHbVy74aBYCWU
	YX4nxxnKIFzkFeJM6UtqumbswGzWjAB03U8LFcI4mvqgUTZRjV5MljiwLkaFTekP8mdD2K
	etlGUgo77DfBgGtnW9tCqrn7dojYevDdpFl9rzPc559TKtMlEB1T7jyHIonZ4HNvTMOMDy
	SWiElyYWWlyHN8SYQKTl2xViVOvCxBkETTgxX8U4bLMTt2DAESRW/ZQNsg7NFWn7H2lbYO
	vi8ijZvi0mEVPGgm5IwJQ5l4HeEBqoSSWEtPJ0Wn+uUEsjhdkH06r1UprZaX5Q==
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
Subject: [PATCH 3/7] of: resolver: Add export_symbols in of_resolve_phandles() parameters
Date: Mon,  9 Dec 2024 16:18:21 +0100
Message-ID: <20241209151830.95723-4-herve.codina@bootlin.com>
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

In order to prepare the introduction of the export symbols node
handling, add a export_symbols parameter in of_resolve_phandles().

The export_symbols is the export symbols device tree node the resolver
will use for the overlay symbols resolution.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/of/of_private.h | 2 +-
 drivers/of/overlay.c    | 2 +-
 drivers/of/resolver.c   | 9 +++++++--
 drivers/of/unittest.c   | 4 ++--
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index ea5a0951ec5e..b1bc7b676946 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -94,7 +94,7 @@ static inline void __of_detach_node_sysfs(struct device_node *np) {}
 #endif
 
 #if defined(CONFIG_OF_RESOLVE)
-int of_resolve_phandles(struct device_node *tree);
+int of_resolve_phandles(struct device_node *tree, const struct device_node *export_symbols);
 #endif
 
 void __of_phandle_cache_inv_entry(phandle handle);
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 434f6dd6a86c..28aa0a133eea 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -915,7 +915,7 @@ static int of_overlay_apply(struct overlay_changeset *ovcs,
 {
 	int ret = 0, ret_revert, ret_tmp;
 
-	ret = of_resolve_phandles(ovcs->overlay_root);
+	ret = of_resolve_phandles(ovcs->overlay_root, NULL);
 	if (ret)
 		goto out;
 
diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
index 2560b33fa750..f5f6c46231d1 100644
--- a/drivers/of/resolver.c
+++ b/drivers/of/resolver.c
@@ -239,7 +239,8 @@ static int get_phandle_from_symbols_node(const struct device_node *tree_symbols,
 /**
  * of_resolve_phandles - Relocate and resolve overlay against live tree
  *
- * @overlay:	Pointer to devicetree overlay to relocate and resolve
+ * @overlay:		Pointer to devicetree overlay to relocate and resolve
+ * @export_symbols:	Pointer to devicetree export symbols node.
  *
  * Modify (relocate) values of local phandles in @overlay to a range that
  * does not conflict with the live expanded devicetree.  Update references
@@ -259,6 +260,10 @@ static int get_phandle_from_symbols_node(const struct device_node *tree_symbols,
  * corresponding to that symbol in the live tree.  Update the references in
  * the overlay with the phandle values in the live tree.
  *
+ * @export_symbols can be use in this references update. The resolver tries
+ * first to find a match in the @export_symbols. If not found, it uses the
+ * "__symbol__" node in the live tree.
+ *
  * @overlay must be detached.
  *
  * Resolving and applying @overlay to the live expanded devicetree must be
@@ -269,7 +274,7 @@ static int get_phandle_from_symbols_node(const struct device_node *tree_symbols,
  *
  * Return: %0 on success or a negative error value on error.
  */
-int of_resolve_phandles(struct device_node *overlay)
+int of_resolve_phandles(struct device_node *overlay, const struct device_node *export_symbols)
 {
 	struct device_node *child, *local_fixups, *overlay_fixups;
 	struct device_node *tree_symbols;
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index daf9a2dddd7e..7b97d4fc0236 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1899,7 +1899,7 @@ static int __init unittest_data_add(void)
 	 */
 	of_overlay_mutex_lock();
 
-	rc = of_resolve_phandles(unittest_data_node);
+	rc = of_resolve_phandles(unittest_data_node, NULL);
 	if (rc) {
 		pr_err("%s: Failed to resolve phandles (rc=%i)\n", __func__, rc);
 		of_overlay_mutex_unlock();
@@ -3794,7 +3794,7 @@ static __init void of_unittest_overlay_high_level(void)
 	 * because kmalloc() was not yet available.
 	 */
 	of_overlay_mutex_lock();
-	of_resolve_phandles(overlay_base_root);
+	of_resolve_phandles(overlay_base_root, NULL);
 	of_overlay_mutex_unlock();
 
 
-- 
2.47.0


