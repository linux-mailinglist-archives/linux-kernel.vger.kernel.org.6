Return-Path: <linux-kernel+bounces-233860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B7F91BE6B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972411F21DAA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848B2158860;
	Fri, 28 Jun 2024 12:23:42 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDBC1E898
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577422; cv=none; b=YRatLDoVPYJpjN6bVx+heVCSeeR/R4AxxZsYJNR/3jxDlkpKIf1a3zT3n85rGu31+XdEGOLQk390GPlAP7tlkjCOH18yNmrXt2qKaTIwRNE/3XzmMraNDYXcks7TBunmCzDjsjyg4ADHalcw5axIJ6Wtzz5CEYNlIAUcVFWU2lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577422; c=relaxed/simple;
	bh=x0DDOupEb909J2YBU87gG45MWtvoBT8NytrGnM37QgY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SwEvie/cqPjpJtEGpFeHeZzO90O+UeDuHLJkZMoUSJSTIdMMWc96OZDU17HpTdn4TUYg+0Wtln/scckCxQIBwNOHvIgSAVxgS4mIaWOUqWat4V8FFc+ykQS02h34SZ7x18pWoJdFLE/AK1G8bNqJYfgYvT+BjqqooGtEhvHmDNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:acf4:1256:ab55:12e6])
	by laurent.telenet-ops.be with bizsmtp
	id h0PX2C0025ECAAU010PXHm; Fri, 28 Jun 2024 14:23:31 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sNAdQ-000VEZ-W0;
	Fri, 28 Jun 2024 14:23:30 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sNAdW-00Bkeh-Qv;
	Fri, 28 Jun 2024 14:23:30 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] irqchip/gic-v3: Pass GICV index to gic_of_setup_kvm_info()
Date: Fri, 28 Jun 2024 14:23:29 +0200
Message-Id: <2eb7c6e9c142f08cbe34bc6f423778f389ac67f4.1719577252.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The caller of gic_of_setup_kvm_info() already queried DT for the value
of the #redistributor-regions property.  So just calculate and pass the
GICV index, instead of doing the DT look-up again in the callee.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/irqchip/irq-gic-v3.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 1f70262742f3b7c7..9c03b63277ba5b2b 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -2185,11 +2185,10 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 	of_node_put(parts_node);
 }
 
-static void __init gic_of_setup_kvm_info(struct device_node *node)
+static void __init gic_of_setup_kvm_info(struct device_node *node, u32 gicv_idx)
 {
 	int ret;
 	struct resource r;
-	u32 gicv_idx;
 
 	gic_v3_kvm_info.type = GIC_V3;
 
@@ -2197,11 +2196,6 @@ static void __init gic_of_setup_kvm_info(struct device_node *node)
 	if (!gic_v3_kvm_info.maint_irq)
 		return;
 
-	if (of_property_read_u32(node, "#redistributor-regions",
-				 &gicv_idx))
-		gicv_idx = 1;
-
-	gicv_idx += 3;	/* Also skip GICD, GICC, GICH */
 	ret = of_address_to_resource(node, gicv_idx, &r);
 	if (!ret)
 		gic_v3_kvm_info.vcpu = r;
@@ -2292,7 +2286,7 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 	gic_populate_ppi_partitions(node);
 
 	if (static_branch_likely(&supports_deactivate_key))
-		gic_of_setup_kvm_info(node);
+		gic_of_setup_kvm_info(node, nr_redist_regions + 3);
 	return 0;
 
 out_unmap_rdist:
-- 
2.34.1


