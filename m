Return-Path: <linux-kernel+bounces-412035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F8C9D02A3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 10:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FC641F216EE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 09:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B15E17A5BE;
	Sun, 17 Nov 2024 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ccZB7+in"
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C6515381A
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731837010; cv=none; b=Rm6fSOtJQ4x1nDhVE5KdBbH8Dy2YP2REaK5H88UgO4uvsNfs9v1585w2LkuT+iOG/iydq5S7zT2ALNdwlBtRIL73LzFhoX/cBK78JnSgeyPB2MDsh+o5c5gqUhpmsNVqtS0I7ttUXG2y54NFNb5ycyl79ZpfMWdPKekYIPikyDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731837010; c=relaxed/simple;
	bh=pA7TaN3p9nKy8j+MvPXC090fJ5eTIAnoVE97fwH8th0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVLg4NUyD599c/n79V3Qwqtu9nZdwfD6ulcsM7EqAmAqCb9aqzFJrybDF+he0rNmJtdcD1X6tMRLVcZfNIW7K8qjGrUkbIs7Upzr3jaAEFR4CfaWwsU8LNZgr8J2BfTg0kgAcy9qBdu0Yr8WS9D2zZUBpbpRWzOCuhDIrHcckuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ccZB7+in; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id Cbuot94NAgiuVCbuytxseA; Sun, 17 Nov 2024 10:50:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731837008;
	bh=kcL0WDdTA3rv8TZTAKcOQMiAGV8Z4dLx/jU6aWvfVXk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ccZB7+inssfijFkcKqZ8BrWjwQ4GZKNjUi/kCz1bmQ0NOlMM3PKQGP0MWvL2bTBLA
	 BVENrFLQYlcWz+Efbw/EERihIqa2wJEipdypsDENp5XqZDOw9KzWjFuIJBfB8uM5Tt
	 L2298VkWDxuAmh5PVGquVtFAAadYgV+wCi3JYBKs+w66GqaZaRkqKK9LJbTrtEOVMs
	 5Y1ymD/89JhM9cY+dKvCWZKv7QxbxlUcxyXHeuawJI8Gskr8ny6gZb1TvwX2AmHR9k
	 HSeG6BvyvGFOhUCyk2saAa8eateHJ8i44UjQONkUZDw1hkSPqhG+g6UjROUXrrSAvz
	 ybEWjX1f3WH/g==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 17 Nov 2024 10:50:08 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/5] irqchip: Constify "struct irq_chip *" parameter in cond_unmask_eoi_irq()
Date: Sun, 17 Nov 2024 10:49:44 +0100
Message-ID: <db3ec8b3425552b3921281e88fe6a0b1cd55e20f.1731835733.git.christophe.jaillet@wanadoo.fr>
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

cond_unmask_eoi_irq() doesn't modify its 'chip' parameter.

So change the prototype of this function to accept const struct irq_chip
pointer.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 kernel/irq/chip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 271e9139de77..502133dc3b9c 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -654,7 +654,8 @@ void handle_level_irq(struct irq_desc *desc)
 }
 EXPORT_SYMBOL_GPL(handle_level_irq);
 
-static void cond_unmask_eoi_irq(struct irq_desc *desc, struct irq_chip *chip)
+static void cond_unmask_eoi_irq(struct irq_desc *desc,
+				const struct irq_chip *chip)
 {
 	if (!(desc->istate & IRQS_ONESHOT)) {
 		chip->irq_eoi(&desc->irq_data);
-- 
2.47.0


