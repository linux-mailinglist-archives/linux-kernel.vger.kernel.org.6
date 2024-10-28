Return-Path: <linux-kernel+bounces-384916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F439B301B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7441B23B68
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C4C1DA624;
	Mon, 28 Oct 2024 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ja9k82Uc"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2EA17C61;
	Mon, 28 Oct 2024 12:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118261; cv=none; b=hAfSqMVUhF9Xp9McHfEDIA1uESm3mUUjz4RvcGQ2HSxt2JBDCryIwEahE+p6nNYdR5CY8kqBBv3kG8sIdIgdAlNE8tJ/jwff2toGcvBT09F0g9Ueb5WxTBf77S8WlSkR85ny/gMZt7hPLVyyyt6hnSDh5f+VH71LsWjH67OZNMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118261; c=relaxed/simple;
	bh=uR4ht+lKiDKQgZTnmiMOAlgCPo2O1B7r9O1DG6jviiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQ4nzk0xNv+pjA9kjgur2oUaMlOK98tNEpEaa0do8gnudUVeJjJS3wC8JAMalszpaomWB1rEIGHkQYNmqau0sS7yp7E16OnwrswoZ9qhivLxHqcv80RDZDnPwjaqkzCYWJ7rjwSse23MauccbcQVZytM7q5B3a9QLL3WL/shwO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ja9k82Uc; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 6824AFF803;
	Mon, 28 Oct 2024 12:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730118257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPgqHIjlq4HFFMwEwOWNB6mYkGD8E5DqDXkYCdDNvJ8=;
	b=Ja9k82UcoLdr3XJGju52FmH5wlgqj9kYAHlUivXn5lcsCBlCdVpajkuav8a5gaEv9m1wL/
	einH4WSuFdytzEgufB7PrFy+Gf6N1ob+cu/I8laKt7kImvzfiLk656vWmN/XMb2ABnMDBe
	RcCdVlrYwx65DrMQyY3Bw5Udl79Q0dqixvmzPf0cWkoZE4hnppeFKEui5rI5YNxQT9Z83g
	Hy1hSWQAYYGhPrnbKOQ3mQPFmdMmi5ehdNtJET9zumsxmu6Lv9PI7LnLxQtknwhcPB3eEo
	jvLIUirtziymTm8C679t2E99Tyr1McVXtMQLq6dIvAevUyFJR0hZM72gu6aYbQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-next@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH 2/2] misc: lan966x_pci: Fix dtc warn 'Missing interrupt-parent'
Date: Mon, 28 Oct 2024 13:24:03 +0100
Message-ID: <20241028122405.27090-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241028122405.27090-1-herve.codina@bootlin.com>
References: <20241028122405.27090-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

dtc generates the following warning when building the LAN966x devicetree
overlay (lan966x_pci.dtso):
  Warning (interrupts_property): /fragment@0/__overlay__/pci-ep-bus@0/oic@e00c0120: Missing interrupt-parent

The oic interrupt parent is the PCI device itself. The PCI device node
is the node on which the dtbo will be applied and this node already has
properties needed.

In order to remove the warning, add the missing properties in the
overlay fragment node. Properties in this node will not be added when
the overlay is applied (which is what we expect) but makes dtc happy.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20241025110919.64b1cffb@canb.auug.org.au/
Fixes: 185686beb464 ("misc: Add support for LAN966x PCI device")
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
The referenced commit is in the reset tree
---
 drivers/misc/lan966x_pci.dtso | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/misc/lan966x_pci.dtso b/drivers/misc/lan966x_pci.dtso
index 5466d013da7d..ed5c35809b2f 100644
--- a/drivers/misc/lan966x_pci.dtso
+++ b/drivers/misc/lan966x_pci.dtso
@@ -15,6 +15,16 @@
 / {
 	fragment@0 {
 		target-path = "";
+
+		/*
+		 * These properties allow to avoid a dtc warnings.
+		 * The real interrupt controller is the PCI device itself. It
+		 * is the node on which the device tree overlay will be applied.
+		 * This node has those properties.
+		 */
+		#interrupt-cells = <1>;
+		interrupt-controller;
+
 		__overlay__ {
 			#address-cells = <3>;
 			#size-cells = <2>;
-- 
2.46.2


