Return-Path: <linux-kernel+bounces-194631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A7B8D3F41
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63AB828800F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C453A1C8FAA;
	Wed, 29 May 2024 19:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOMx2RZS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFC91C68B5;
	Wed, 29 May 2024 19:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717012778; cv=none; b=J1Yx/AUqKtiefKTEwjQPWwRZu/gVyBj+DJJah3tNTXJw8XHgWqwCH68g4SlFScYpS2C57AXbPxFQaWCbkZfMn8oL3TIiQQEu5kCEG+ybM7RfT1Q9SaBqZJk23bI6i2lIZOzIABywHpV9cUufn/0w4xR3qhRzBYng7Z3cOAta8Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717012778; c=relaxed/simple;
	bh=yv3sV0IekJXEfS+vnm5tOFqY0f0ZsogndSU+bY2+t+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U2eHHYFx5KR8bgpzaV4Y7nc4AVYGZLhJKW7QFNpqbarqhpX9iBfh6HkLKlplot2SPPPFItLKoxkDK72MpGMz6TQQeIY6MZr6e1/HSHLaG0Aq16U2pGYZDhkaEV8hw5atIW7ssEeSmo6g7NI7bKMIqWf2mgrufvGbBVBxkozFPn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOMx2RZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2A1C113CC;
	Wed, 29 May 2024 19:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717012777;
	bh=yv3sV0IekJXEfS+vnm5tOFqY0f0ZsogndSU+bY2+t+8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OOMx2RZSuUuUO35THJIgMC0eMmcRO9rRnCRuQA6h25AB8TBjaWfHHUnjJj0KQaoUr
	 Oe5t4AH+nB5CxLHAuIG8kJK3HGEyHNCcnf5EslfUUMTDJW3Hv9iB3E3BM8wLzptRXO
	 sdPLP9udgeoAYaoOH0VcTYdUk2NBQPHz89nV5r+h/gcEp5ikS6FvZBnl4VzA+60a0E
	 0UptO85nBP3bUEFNbXAtovO0z+L7RLP5Jx2eFvGMhc3avocnBDBcpWRXDnByc8kgat
	 QMazwfwRA3ZcKQUtHWlywrZgdK+zgvfoRvmRj0ymPy9vYOdoulfYGJd4fsZbHrkjS4
	 oMSHjUF2MYfng==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Wed, 29 May 2024 14:59:21 -0500
Subject: [PATCH v2 2/2] of: property: Fix fw_devlink handling of
 interrupt-map
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-dt-interrupt-map-fix-v2-2-ef86dc5bcd2a@kernel.org>
References: <20240529-dt-interrupt-map-fix-v2-0-ef86dc5bcd2a@kernel.org>
In-Reply-To: <20240529-dt-interrupt-map-fix-v2-0-ef86dc5bcd2a@kernel.org>
To: Saravana Kannan <saravanak@google.com>, 
 Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
X-Mailer: b4 0.14-dev

From: Marc Zyngier <maz@kernel.org>

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

Having 2 versions of parsing code for "interrupt-map" was a bad
idea. Now that the common parsing parts have been refactored
into of_irq_parse_imap_parent(), rework the code here to use it
instead and fix the pointer arithmetic.

Note that the dependency will be a bit different than the original code
when the interrupt-map points to another interrupt-map. In this case,
the original code would resolve to the final interrupt controller. Now
the dependency is the parent interrupt-map (which itself should have a
dependency to the parent). It is possible that a node with an
interrupt-map has no driver.

Fixes: d976c6f4b32c ("of: property: Add fw_devlink support for interrupt-map property")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Co-developed-by: Rob Herring (Arm) <robh@kernel.org>
Cc: Anup Patel <apatel@ventanamicro.com>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/of/property.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 1c83e68f805b..164d77cb9445 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1306,10 +1306,10 @@ static struct device_node *parse_interrupts(struct device_node *np,
 static struct device_node *parse_interrupt_map(struct device_node *np,
 					       const char *prop_name, int index)
 {
-	const __be32 *imap, *imap_end, *addr;
+	const __be32 *imap, *imap_end;
 	struct of_phandle_args sup_args;
 	u32 addrcells, intcells;
-	int i, imaplen;
+	int imaplen;
 
 	if (!IS_ENABLED(CONFIG_OF_IRQ))
 		return NULL;
@@ -1322,33 +1322,23 @@ static struct device_node *parse_interrupt_map(struct device_node *np,
 	addrcells = of_bus_n_addr_cells(np);
 
 	imap = of_get_property(np, "interrupt-map", &imaplen);
-	if (!imap || imaplen <= (addrcells + intcells))
+	imaplen /= sizeof(*imap);
+	if (!imap)
 		return NULL;
-	imap_end = imap + imaplen;
 
-	while (imap < imap_end) {
-		addr = imap;
-		imap += addrcells;
+	imap_end = imap + imaplen;
 
-		sup_args.np = np;
-		sup_args.args_count = intcells;
-		for (i = 0; i < intcells; i++)
-			sup_args.args[i] = be32_to_cpu(imap[i]);
-		imap += intcells;
+	for (int i = 0; imap + addrcells + intcells + 1 < imap_end; i++) {
+		imap += addrcells + intcells;
 
-		/*
-		 * Upon success, the function of_irq_parse_raw() returns
-		 * interrupt controller DT node pointer in sup_args.np.
-		 */
-		if (of_irq_parse_raw(addr, &sup_args))
+		imap = of_irq_parse_imap_parent(imap, imap_end - imap, &sup_args);
+		if (!imap)
 			return NULL;
 
-		if (!index)
+		if (i == index)
 			return sup_args.np;
 
 		of_node_put(sup_args.np);
-		imap += sup_args.args_count + 1;
-		index--;
 	}
 
 	return NULL;

-- 
2.43.0


