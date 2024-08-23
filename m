Return-Path: <linux-kernel+bounces-298656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E113D95C9E4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154EE1C20B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945BF17E01A;
	Fri, 23 Aug 2024 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ms5Vlod6"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC015FA7B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407661; cv=none; b=AQt+47E2EFD+EDnsDokBWJoZ5VAU/FokTIv2Gd4FvjkVgVd+IYS4eJr916nEh+d6ENnxun6pubFdi9DRrwYPEs8LQvgK6hs2RzaJ2QpL8TEh3zybbvytQpqcZQ5HqyQU5T9JCD6pf5YOgGlOv9sVaJUiF99pxboqi7ybykJBHc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407661; c=relaxed/simple;
	bh=IMfHgSysfliVdmvBbihWba9hMmrZ2ai1xhR3j2t6LRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rYIDuJGKbKAqjoTEMYwFMvvAatp9st4GPRmaUc9jF8PtgKSIHwC+wBVGIeisljCm0S1w7CxNoFp8Zu/6OUI+8k3cEX0OwRoq7fzwEe+al8AuFDNd922cZKg1PujPSlBIWmvdnZPzf7RNqCaTHkgMEXXlsTgmuvjDhp/mBRi8cNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ms5Vlod6; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8368F40009;
	Fri, 23 Aug 2024 10:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724407657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=meikMgk2Gv60sMmnHNfNv+7xx4h4bVy4LOlG+4/2uIk=;
	b=ms5Vlod6n0omdWNqcV5qytvFCSEzSg/WjynAp+48t5xvMhqcVZboIU9NlMr6Nk2EtnrAXD
	9IqvUb6GruphKcQ0xvzx0bR8KwiujTv+mF3+7jMPg4iXNnHVqIRUimDQP6IqCxTK2N45kx
	TjhwpqfYlkLoZsPS7x8vo2RuLwUpdnVGQkCmqG8x4KEzMgMExW08MMmzf6vE3z3fgOMO6b
	evsvCf2pe3Q5xhMv5tTBFPYKhgGuv5WwARge3jN48Rqg0ayl51cSUv4IVMdI2SxkGOxkRq
	Fbcnst8LwDAHgIIuZoML8U2sJydfkHhFz9+DiI0opKHzC0EnSwHN3NdvcU2OYw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH] irqchip/irq-msi-lib: Check for NULL ops in msi_lib_irq_domain_select
Date: Fri, 23 Aug 2024 12:07:12 +0200
Message-ID: <20240823100733.1900666-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The irq_domain passed to msi_lib_irq_domain_select() may not have any
msi_parent_ops set. Move the test for NULL ops before the first use of
that pointer.

This was found on a MacchiatoBin (Marvell Armada 8K SoC), which uses the
irq-mvebu-sei driver.

Fixes: 72e257c6f058 ("irqchip: Provide irq-msi-lib")
Closes: https://lore.kernel.org/all/20240821165034.1af97bad@fedora-3.home/
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/irqchip/irq-msi-lib.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index b5b90003311a..d8e29fc0d406 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -128,6 +128,9 @@ int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 	const struct msi_parent_ops *ops = d->msi_parent_ops;
 	u32 busmask = BIT(bus_token);
 
+	if (!ops)
+		return 0;
+
 	if (fwspec->fwnode != d->fwnode || fwspec->param_count != 0)
 		return 0;
 
@@ -135,6 +138,6 @@ int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 	if (bus_token == ops->bus_select_token)
 		return 1;
 
-	return ops && !!(ops->bus_select_mask & busmask);
+	return !!(ops->bus_select_mask & busmask);
 }
 EXPORT_SYMBOL_GPL(msi_lib_irq_domain_select);
-- 
2.45.2


