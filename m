Return-Path: <linux-kernel+bounces-412037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F35499D02A6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 10:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6A61F23309
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 09:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A530518BC2F;
	Sun, 17 Nov 2024 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="S7RQDUAF"
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED3D17DE36
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 09:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731837014; cv=none; b=Cx1dNq+3LUtPFU0G67o2f9Xfc7+/gyAKivCe7oejClDK1P4iVMOVPvdX5vJ2eOn5Xqo0N0mRgSzTUiCnfjHgOupURehuk/YHAJCflcudD5vrYVJcR1muC8gTuRGHzf4Koah9TpaGQafnbQoH0VIHcUPC9bPVZbIEOVijcUSyea8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731837014; c=relaxed/simple;
	bh=YItoIAOS0SMmhYS9IXyLsbxI586VpFxrOh+FXt2aOoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgf2YLyAo560QafwHZ/YcakhHac2jijl8s0onreRwYRtT1esPvSuT78tRtecsJsvTg9xu8Lcjj9bRvgolP4Czf01MMvrCzK+52kuqn3hT1FKmyxQiWIbiqOxd2gbc+SLPc7FHjHtqm+G3i0w++ud9GQvX/F99M26QwHvcWoTMEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=S7RQDUAF; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id Cbuot94NAgiuVCbv2txshp; Sun, 17 Nov 2024 10:50:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731837012;
	bh=QsFY+oFBT/L9WpTZKsV7kPeliUrBcejT52WMrTeVP3Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=S7RQDUAF7ya1otQt2aqeiM6QmAnQ/bWuKsMo5ZK8PaJd3XdDhh4g2VOdmJJb5loVu
	 gpesMNOvf2RAZ1Yq736C0f+MBvsct6oGvp9rE8D/3fk7YoEu3cEiZNfkPLsFo/ACTt
	 ruB6ZU7ATRscZaqU8T6xLCScOBb1W2atYUjxIw2CjXaGCtdSKaIRsl+M+awQEvVZ+G
	 D/hMemT/nl8MJwXLVadOKILBLGP1K/+sHE8ayD5eZrDSE7YnlLCnszYydCAQW7n25A
	 qGZm9oso1ZLX2e7MVlTX0fpllcyWp3bSwjk0nTK16cMvmB8Txk6bOWWjeZNW4cyRdq
	 1LjuPlNpAbIBA==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 17 Nov 2024 10:50:12 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 4/5] irqchip: Constify some irq_desc_get_chip() usage
Date: Sun, 17 Nov 2024 10:49:46 +0100
Message-ID: <a683ada6749705812e9cfc4c36ce36386362d814.1731835733.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731835733.git.christophe.jaillet@wanadoo.fr>
References: <cover.1731835733.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When irq_desc_get_chip() will return a const struct irq_chip, the const
qualifier will be needed for local variables that store the return value of
this function.

So start to add some of these const qualifiers.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 kernel/irq/chip.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index eca39c4dd094..d3acccf7e2e2 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -751,7 +751,7 @@ EXPORT_SYMBOL_GPL(handle_fasteoi_irq);
  */
 void handle_fasteoi_nmi(struct irq_desc *desc)
 {
-	struct irq_chip *chip = irq_desc_get_chip(desc);
+	const struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irqaction *action = desc->action;
 	unsigned int irq = irq_desc_get_irq(desc);
 	irqreturn_t res;
@@ -849,7 +849,7 @@ EXPORT_SYMBOL(handle_edge_irq);
  */
 void handle_edge_eoi_irq(struct irq_desc *desc)
 {
-	struct irq_chip *chip = irq_desc_get_chip(desc);
+	const struct irq_chip *chip = irq_desc_get_chip(desc);
 
 	raw_spin_lock(&desc->lock);
 
@@ -894,7 +894,7 @@ void handle_edge_eoi_irq(struct irq_desc *desc)
  */
 void handle_percpu_irq(struct irq_desc *desc)
 {
-	struct irq_chip *chip = irq_desc_get_chip(desc);
+	const struct irq_chip *chip = irq_desc_get_chip(desc);
 
 	/*
 	 * PER CPU interrupts are not serialized. Do not touch
@@ -924,7 +924,7 @@ void handle_percpu_irq(struct irq_desc *desc)
  */
 void handle_percpu_devid_irq(struct irq_desc *desc)
 {
-	struct irq_chip *chip = irq_desc_get_chip(desc);
+	const struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irqaction *action = desc->action;
 	unsigned int irq = irq_desc_get_irq(desc);
 	irqreturn_t res;
@@ -967,7 +967,7 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
  */
 void handle_percpu_devid_fasteoi_nmi(struct irq_desc *desc)
 {
-	struct irq_chip *chip = irq_desc_get_chip(desc);
+	const struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irqaction *action = desc->action;
 	unsigned int irq = irq_desc_get_irq(desc);
 	irqreturn_t res;
-- 
2.47.0


