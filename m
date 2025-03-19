Return-Path: <linux-kernel+bounces-567622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1934A6886D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69373B5B66
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EAF25DAFA;
	Wed, 19 Mar 2025 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CS9SLPm3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5B4255E38
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376786; cv=none; b=LpkIfEQpm5j67eVNWydUW7uD2TY36am9z8RN3ZM6kE/N/LqN5AdniCb7BLA52MR0ia55oAGKiJ4pyqlMcHDvkG/7aOYrWo5MPBnME+cNBZNcr/Y5nevacP6gvgaGn3g1D/+K30dVuJGgGAgfQTxbfHucgvuMnzDK/+yCMgdstXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376786; c=relaxed/simple;
	bh=lpe2nMjBH6bRGUp97awppdXuPJprE/OB2HYTkQFwj2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvXdCa4x9oaKUL+6ZUvOQSmQlEb49XauccCVT2lMGcBXtIfRFtt72cjANNGm3Xqa7QsR2T7V7eUEXK2c2kLlsegCGRUaxDxTk7kBUmM9I7/RYJJ2IqIta2yepFJ1vBbJThgThKBm+83XpB7bBnIQ4yKGIcc3i+YDTRE/DB4ggs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CS9SLPm3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D22C4CEEA;
	Wed, 19 Mar 2025 09:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742376785;
	bh=lpe2nMjBH6bRGUp97awppdXuPJprE/OB2HYTkQFwj2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CS9SLPm3ODFm7grX0xT8oSAGpraaWE481ovNpwZZOPIHEcQZ10Zoi8cmasGql60us
	 KFGXkSaL6cFW/8eNM9cVDTiSexUCg2LLTxXthv976G0uuA41tNbOCrdEOQtPhIPkX9
	 DDRvHfvb03tE2DLHaga2iDgPDL9d8bHb5YTx9M5FA7gj8r2KDJU+avAvtmuzK67hqi
	 x5BmMm3FLMpPcdToibK3SURlyUjyQhcQBehTSeiSP2N3wy2dl+hlI9Nt+jdQwHLoF6
	 bIOzVa3TdWXCoKbBmls/FijoMCsYtLcpY4QY5gyLbqxQt9n82I86TSke8j9jyS8T7z
	 3tzHfHsIMQzeg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: maz@kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 46/57] irqdomain: irqchip: Switch to irq_find_mapping()
Date: Wed, 19 Mar 2025 10:29:39 +0100
Message-ID: <20250319092951.37667-47-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319092951.37667-1-jirislaby@kernel.org>
References: <20250319092951.37667-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

irq_linear_revmap() is deprecated, so remove all its uses and supersede
them by an identical call to irq_find_mapping().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/irqchip/irq-armada-370-xp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index e51612992735..67b672a78862 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -546,7 +546,7 @@ static void mpic_reenable_percpu(struct mpic *mpic)
 {
 	/* Re-enable per-CPU interrupts that were enabled before suspend */
 	for (irq_hw_number_t i = 0; i < MPIC_PER_CPU_IRQS_NR; i++) {
-		unsigned int virq = irq_linear_revmap(mpic->domain, i);
+		unsigned int virq = irq_find_mapping(mpic->domain, i);
 		struct irq_data *d;
 
 		if (!virq || !irq_percpu_is_enabled(virq))
@@ -740,7 +740,7 @@ static void mpic_resume(void)
 
 	/* Re-enable interrupts */
 	for (irq_hw_number_t i = 0; i < mpic->domain->hwirq_max; i++) {
-		unsigned int virq = irq_linear_revmap(mpic->domain, i);
+		unsigned int virq = irq_find_mapping(mpic->domain, i);
 		struct irq_data *d;
 
 		if (!virq)
-- 
2.49.0


