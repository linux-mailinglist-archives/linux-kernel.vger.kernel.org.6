Return-Path: <linux-kernel+bounces-352259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD83991C93
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 06:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68DCF1F21D30
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 04:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677AE1667DA;
	Sun,  6 Oct 2024 04:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="o4/xUZQ/"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DA57F6;
	Sun,  6 Oct 2024 04:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728189547; cv=none; b=M2FYka1uNSNt+1/vT2g3CklsOm7Lt3/8Ldx3wS5/JSeNKRlmJLe/GwGDZIcd09shVVf2tJmUOdXFe2Hadel8FHh80dv6WvuzHjnSZ66OE/74sC4G+Mt3NoOHC17ut6P+krrjuhp18nFKDhmvOyQde4UDMw8GbI7ex2DMO5upFBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728189547; c=relaxed/simple;
	bh=OgWcY174jMlqIgoQJR+RJ1sBLdOV/0eU2EwSmfEVl78=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IlUXcSocrx30L53+i+amBe2SkVQFCuZBUmiMZMtqPUlr+r1NoE7WB/2f0Z8XPI/yeRQ9G0GOkT807sgbGX3Dte2NzSet67JbvwsxCR6GVSMOJgdZa9M9x7r0l7rFiOyfhsPXjHmE0E0Fuy3ib47ujTRlHZDrCFfGY+P/nvI6ZeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=o4/xUZQ/; arc=none smtp.client-ip=192.19.144.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 6C13FC0003E0;
	Sat,  5 Oct 2024 21:33:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 6C13FC0003E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1728189200;
	bh=OgWcY174jMlqIgoQJR+RJ1sBLdOV/0eU2EwSmfEVl78=;
	h=From:To:Cc:Subject:Date:From;
	b=o4/xUZQ/Ta5j3XqdyES9BBXAg2/4PPJY5+GjJ+mwDDoW9jO+JQg4oURrIOZvA39ZP
	 A/zHT4BGTaWILF6v5qKS3fjCu/q6rTFEKlpnlv6HIHfjWwt7pmYCBRg3sAOTUWW68q
	 v6SQVf6R3PNLonPS9PFOztyFl4xwvE5316Z64ccY=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 056FC18041CAC6;
	Sat,  5 Oct 2024 21:33:20 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infread.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	arm-scmi@vger.kernel.org (open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE),
	linux-arm-kernel@lists.infradead.org (moderated list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE),
	justin.chen@broadcom.com,
	opendmb@gmail.com,
	kapil.hali@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] firmware: arm_scmi: Give SMC transport precedence over mailbox
Date: Sat,  5 Oct 2024 21:33:17 -0700
Message-Id: <20241006043317.3867421-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Broadcom STB platforms have for historical reasons included both
"arm,scmi-smc" and "arm,scmi" in their SCMI Device Tree node compatible
string.

After the commit cited in the Fixes tag and with a kernel
configuration that enables both the SCMI and the Mailbox transports, we
would probe the mailbox transport, but fail to complete since we would
not have a mailbox driver available.

By keeping the SMC transport objects linked first, we can let the
platform driver, match the compatible string and probe successfully with
no adverse effects on platforms using the mailbox transport.

Fixes: b53515fa177c ("firmware: arm_scmi: Make MBOX transport a standalone driver")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Change-Id: I8e348e3e0deabdc5c1d596929d7f9134793f346e
---
 drivers/firmware/arm_scmi/transports/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/transports/Makefile b/drivers/firmware/arm_scmi/transports/Makefile
index 362a406f08e6..3ba3d3bee151 100644
--- a/drivers/firmware/arm_scmi/transports/Makefile
+++ b/drivers/firmware/arm_scmi/transports/Makefile
@@ -1,8 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
-scmi_transport_mailbox-objs := mailbox.o
-obj-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) += scmi_transport_mailbox.o
+# Keep before scmi_transport_mailbox.o to allow precedence
+# while matching the compatible.
 scmi_transport_smc-objs := smc.o
 obj-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += scmi_transport_smc.o
+scmi_transport_mailbox-objs := mailbox.o
+obj-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) += scmi_transport_mailbox.o
 scmi_transport_optee-objs := optee.o
 obj-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += scmi_transport_optee.o
 scmi_transport_virtio-objs := virtio.o
-- 
2.34.1


