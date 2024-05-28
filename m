Return-Path: <linux-kernel+bounces-192769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE948D21CE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6D21F2281F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3B7172BD1;
	Tue, 28 May 2024 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaJNwDtp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A53961FC5;
	Tue, 28 May 2024 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716914502; cv=none; b=k8IQjy7dkqWlzOeWqwJOpgPRcq981uuGFwQvTO/+caX/kcH1xNhyk5xeJz4BbVowIPflKIzneUvLkMG8sPfZ8csCfxeL1BaXPVp4P7Yd+fJ/x1o6Y1UvFqZijHc0iugiENaggRKvoMyS/4MZ4/osshe8l8PXLXc9ga5Ys9JkFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716914502; c=relaxed/simple;
	bh=DMgXSKpLwPGnXLdeaUen3gAjKmTX+D3leZxLgkVaXlo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kmsf0TiewWvioe4Lq3SqH0M82lc8ctkyzZ+OLJclMGGTNyTa9SF4yA9jA1cxo4N4kwqj0KYdEkDFG7BKHZ4KrM4DV66W/J4ZV/LrJl1C4g4UFbgVEe42DvcxHmSnpLBYv5fPbz8+zLxq10aRL+FIr0cur3Ois9RoWXZfqrjouTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaJNwDtp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0DBC32782;
	Tue, 28 May 2024 16:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716914501;
	bh=DMgXSKpLwPGnXLdeaUen3gAjKmTX+D3leZxLgkVaXlo=;
	h=From:To:Cc:Subject:Date:From;
	b=XaJNwDtpSAmeDSf7UPYDPLYGzpjNandQwPlj4GqQNQMcy84ByAlU3Jz0OHUP5+8Pw
	 F3B4baLUu3xBWWefsQ5bso6eja0kPvl4biz8ZDs1ac7Kt3mQFdFSaf4rWNz2iR2NID
	 q2QjpeudjuYrh/fZRoPMLfJUl3dNnjySoE5Zoc7cX8UKkgGqA9g4UAEkiALZ+3RAo6
	 MUsUvU7mmpcVz4i5c5f2qODMpMyigWOINSOU4B4b48LkUqQPOngA9s6C51pl3DavAB
	 f3zYOwUQcdBmE0Sc+4Sy+Le2wXBCivSf1qZY6hkwVVLuwMBumCGq8gnolDv3e3/tTU
	 fsPAVXik0dSiw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sBztL-00GNOx-CY;
	Tue, 28 May 2024 17:41:39 +0100
From: Marc Zyngier <maz@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Cc: Anup Patel <apatel@ventanamicro.com>,
	Saravana Kannan <saravanak@google.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH] of: property: Fix fw_devlink handling of interrupt-map
Date: Tue, 28 May 2024 17:41:32 +0100
Message-Id: <20240528164132.2451685-1-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, apatel@ventanamicro.com, saravanak@google.com, robh@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Commit d976c6f4b32c ("of: property: Add fw_devlink support for
interrupt-map property") tried to do what it says on the tin,
but failed on a couple of points:

- it confuses bytes and cells. Not a huge deal, except when it
  comes to pointer arithmetic

- it doesn't really handle anything but interrupt-maps that have
  their parent #address-cells set to 0

The combinations of the two leads to some serious fun on my M1
box, with plenty of WARN-ON() firing all over the shop, and
amusing values being generated for interrupt specifiers.

Address both issues so that I can boot my machines again.

Fixes: d976c6f4b32c ("of: property: Add fw_devlink support for interrupt-map property")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Anup Patel <apatel@ventanamicro.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/of/property.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 1c83e68f805b..9adebc63bea9 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1322,7 +1322,13 @@ static struct device_node *parse_interrupt_map(struct device_node *np,
 	addrcells = of_bus_n_addr_cells(np);
 
 	imap = of_get_property(np, "interrupt-map", &imaplen);
-	if (!imap || imaplen <= (addrcells + intcells))
+	imaplen /= sizeof(*imap);
+
+	/*
+	 * Check that we have enough runway for the child unit interrupt
+	 * specifier and a phandle. That's the bare minimum we can expect.
+	 */
+	if (!imap || imaplen <= (addrcells + intcells + 1))
 		return NULL;
 	imap_end = imap + imaplen;
 
@@ -1346,8 +1352,14 @@ static struct device_node *parse_interrupt_map(struct device_node *np,
 		if (!index)
 			return sup_args.np;
 
-		of_node_put(sup_args.np);
+		/*
+		 * Account for the full parent unit interrupt specifier
+		 * (address cells, interrupt cells, and phandle).
+		 */
+		imap += of_bus_n_addr_cells(sup_args.np);
 		imap += sup_args.args_count + 1;
+
+		of_node_put(sup_args.np);
 		index--;
 	}
 
-- 
2.39.2


