Return-Path: <linux-kernel+bounces-398643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 663A89BF40E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9712C1C239C8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF91F206515;
	Wed,  6 Nov 2024 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWoz4v9u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3627F1DE4EF;
	Wed,  6 Nov 2024 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730913065; cv=none; b=KczzQYqmiBoTruEGV5bHOBJRW4GLDq2xT8X+/yUXcsNoGIJUaBqby27K8HKGPsoV7tckOjls3Ej4VjVzH3f2DuPwrlud6gq95cUK++LgeyLJ/6HjAa6FiVE+jNZtAFKetwmAKjPlgS/iHJIKk5SLPTaviEWD4CRGRW3yjMoB+ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730913065; c=relaxed/simple;
	bh=FXUgqm5DxwD9CzDMHLka46QpAIfBGKbwRgNSxv+cqeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EeNnk/Sm2TCd6cTB5yYKjsKiVKrOZzjbpbH4JwIALrAmNnuhkxJWy8vj3YUEScJdeROqEkV0/YOvPD2YKA8LHE9WAge7ceChvERnDA63TuTxT9+mwBZx2FTGD7ZP8xli9+ZxvjWwClY9TEKeoxVOFOGC+CtT5kVqGcfdhLAh9nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWoz4v9u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8359C4CEC6;
	Wed,  6 Nov 2024 17:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730913065;
	bh=FXUgqm5DxwD9CzDMHLka46QpAIfBGKbwRgNSxv+cqeY=;
	h=From:To:Cc:Subject:Date:From;
	b=IWoz4v9ur/yXAyLT90tQC+L1/PgVVa+DSIlQWPmYdFFye1Vn+H/hmeIIihMyB9syE
	 1A7Gbv33l46RHJPaoPH8mR7iO2bqwYZxTrbH6xgrU4kE0IXJeMoI+n/z9SQJV09nwT
	 aqO1SYXdgTv+en5ohoLp0CiLbVVwNuxDA1UzoS5jINUUkJTqdSOsC/MJ6bz0VX8XhQ
	 VFp1x4aj01rj1fwhjIXAzbIBW8A6b1CC6aWdIwtXM91r6H61a3GqfNux2yT9Si9amt
	 XYLUq+02QzVHHrqpXlTNdSPJksT5ZBhETEtOqLgSZBfmRjMznHEG9sLVEQgMXrjK4I
	 Xq/cJBzUuVFxQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	Conor Dooley <conor@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] of: WARN on deprecated #address-cells/#size-cells handling
Date: Wed,  6 Nov 2024 11:10:27 -0600
Message-ID: <20241106171028.3830266-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While OpenFirmware originally allowed walking parent nodes and default
root values for #address-cells and #size-cells, FDT has long required
explicit values. It's been a warning in dtc for the root node since the
beginning (2005) and for any parent node since 2007. Of course, not all
FDT uses dtc, but that should be the majority by far. The various
extracted OF devicetrees I have dating back to the 1990s (various
PowerMac, OLPC, PASemi Nemo) all have explicit root node properties. The
warning is disabled for Sparc as there are known systems relying on
default root node values.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - Add a define for excluded platforms to help clarify the intent
   is to have an exclude list and make adding platforms easier.
 - Also warn when walking parent nodes.
---
 drivers/of/base.c | 28 ++++++++++++++++++++++------
 drivers/of/fdt.c  |  4 ++--
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 20603d3c9931..39fb59b666f3 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -87,15 +87,25 @@ static bool __of_node_is_type(const struct device_node *np, const char *type)
 	return np && match && type && !strcmp(match, type);
 }
 
+#define EXCLUDED_DEFAULT_CELLS_PLATFORMS ( \
+	IS_ENABLED(CONFIG_SPARC) \
+)
+
 int of_bus_n_addr_cells(struct device_node *np)
 {
 	u32 cells;
 
-	for (; np; np = np->parent)
+	for (; np; np = np->parent) {
 		if (!of_property_read_u32(np, "#address-cells", &cells))
 			return cells;
-
-	/* No #address-cells property for the root node */
+		/*
+		 * Default root value and walking parent nodes for "#address-cells"
+		 * is deprecated. Any platforms which hit this warning should
+		 * be added to the excluded list.
+		 */
+		WARN_ONCE(!EXCLUDED_DEFAULT_CELLS_PLATFORMS,
+			  "Missing '#address-cells' in %pOF\n", np);
+	}
 	return OF_ROOT_NODE_ADDR_CELLS_DEFAULT;
 }
 
@@ -112,11 +122,17 @@ int of_bus_n_size_cells(struct device_node *np)
 {
 	u32 cells;
 
-	for (; np; np = np->parent)
+	for (; np; np = np->parent) {
 		if (!of_property_read_u32(np, "#size-cells", &cells))
 			return cells;
-
-	/* No #size-cells property for the root node */
+		/*
+		 * Default root value and walking parent nodes for "#size-cells"
+		 * is deprecated. Any platforms which hit this warning should
+		 * be added to the excluded list.
+		 */
+		WARN_ONCE(!EXCLUDED_DEFAULT_CELLS_PLATFORMS,
+			  "Missing '#size-cells' in %pOF\n", np);
+	}
 	return OF_ROOT_NODE_SIZE_CELLS_DEFAULT;
 }
 
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 4d528c10df3a..d79707fb2eb1 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -938,12 +938,12 @@ int __init early_init_dt_scan_root(void)
 	dt_root_addr_cells = OF_ROOT_NODE_ADDR_CELLS_DEFAULT;
 
 	prop = of_get_flat_dt_prop(node, "#size-cells", NULL);
-	if (prop)
+	if (!WARN(!prop, "No '#size-cells' in root node\n"))
 		dt_root_size_cells = be32_to_cpup(prop);
 	pr_debug("dt_root_size_cells = %x\n", dt_root_size_cells);
 
 	prop = of_get_flat_dt_prop(node, "#address-cells", NULL);
-	if (prop)
+	if (!WARN(!prop, "No '#address-cells' in root node\n"))
 		dt_root_addr_cells = be32_to_cpup(prop);
 	pr_debug("dt_root_addr_cells = %x\n", dt_root_addr_cells);
 
-- 
2.45.2


