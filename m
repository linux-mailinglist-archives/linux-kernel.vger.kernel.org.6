Return-Path: <linux-kernel+bounces-215385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A53A39091D5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2A91C26424
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F241B3741;
	Fri, 14 Jun 2024 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T+mQ/YfD"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DAE1B29AA;
	Fri, 14 Jun 2024 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386389; cv=none; b=XZFkIi/QQ7ld2lMC/Qe4pk+Khomnl2Bp/m7RovCk/hMoIRpm1hwDcPxJuOxikpsobdcHtiNtuKuptPt5ZOkRKyo/Zzvjy5LX/f07cjriRxBtYgUi4F5huMUczxTWs4sobOwqrMAdORzexqV0KCn7Yv5eVEcJUWEFrm4SWJGeDTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386389; c=relaxed/simple;
	bh=CFOBUXD7jTvQ0DUMWL0UDE8CpiU/yP+TFleNjxWwLxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQZLjWqbuLAM9imCb7PyxEbq17oZMSSri/gV9j5WvLTxJNDWYSGNNY0vqfV3whvLJZnD4e1JC7PcHRWAjB0/sqdR4+7L1M274SCSfKJxM0Qav8QzRI6JnLJ0qcvBNOV37lzDXKThp1g3AnUrHnacm5WSlsARrcE8zwhZjgn5klo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T+mQ/YfD; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 2C54AFF811;
	Fri, 14 Jun 2024 17:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JtCflf5DaqbhOm9L/XxD0yo5M1odlrsrVmdrUVelr04=;
	b=T+mQ/YfDW76Ir33ovd2mMbE/wy/n+Lioh//KKzIjrcUfQ+YWbPCBJJrN3TSzvNE/ZKAQ6q
	oDJ6ais8BaG6r0qxRkjs82DqIeSyqEMu6zJUTxWDI+sxIEs3pAaKFTrlyjfosvaUTGuKVI
	LPO3z2+qbyxyUM4/Ps7CNml66YUyGBTVpJtD8B4EGT1k4WtyeaMq/5k2+7fHhIS5B9KKu9
	k1DQTwKQy7+xfEW8vyjfkYne6wvaLt7I4NTdSAICcX9Lu9dNlCusETzRm5OQ9InqfjQo0j
	BhV9u2/tRY43ouYgUyQHVWsx5GgM/gFFTzLSKOylqw+JJ3b8GrtJCPZCYNh0eQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-um@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 23/23] MAINTAINERS: Add the Microchip LAN966x OIC driver entry
Date: Fri, 14 Jun 2024 19:32:24 +0200
Message-ID: <20240614173232.1184015-24-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

After contributing the driver, add myself as the maintainer for the
Microchip LAN966x OIC driver.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..baeb307344cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14727,6 +14727,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/microchip/lan966x/*
 
+MICROCHIP LAN966X OIC DRIVER
+M:	Herve Codina <herve.codina@bootlin.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
+F:	drivers/irqchip/irq-lan966x-oic.c
+
 MICROCHIP LCDFB DRIVER
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 L:	linux-fbdev@vger.kernel.org
-- 
2.45.0


