Return-Path: <linux-kernel+bounces-354306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E9D993B8E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 02:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A641F241B4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 00:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A817B20E3;
	Tue,  8 Oct 2024 00:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H/5b0+dH"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F13B101C8;
	Tue,  8 Oct 2024 00:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728345826; cv=none; b=s/xO66CsI5nR6786FE29ICr0uMxVf2JYqVSaUyaglwwHhM2Pk6LygwMhERQPzYQPG+fRH3mRH3cxfSzGtJuFu4fLcwWG4yk21Vy+iVTlCBXCTxe0Q4xa5EBtQJDzmR/jGmE1fAdgjqeGnPTVVdc1d1cBwMo1OYB0xU6aI8tPc6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728345826; c=relaxed/simple;
	bh=gkroZQ+37GTyJM/uyjWAwX/F+a6aQH4+nH6JOA8RU4c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kU+7GPEO5QJ0cvV62n+zl4Y91f8QYvYwdmzTOUHibOpeLOeMjtCgqi1HB+q6rkawKRkL9S/eovF0Kpn+eOYwq5vnQn/yZibwmxFmRUMi+cnDQHsSV/lFzGQApojeZgHoaLlgrnQPcVgY/Z2NBMkX5fyIQ8Ji2YpRl9gTJ2Z7BRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H/5b0+dH; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 994ADC0000D4;
	Mon,  7 Oct 2024 16:54:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 994ADC0000D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1728345254;
	bh=gkroZQ+37GTyJM/uyjWAwX/F+a6aQH4+nH6JOA8RU4c=;
	h=From:To:Cc:Subject:Date:From;
	b=H/5b0+dHo8+ZbyETrM30BF6y2TFEAQtaeoRhyKRYfAtOCSeF2WLhloEy8aDO3mMYl
	 Z0a+pUSJEnFAPaBUKHPfDLrx4NDax5r5u9UGy7AkdtNA6Tjxy8JcYCYrrUP6K2PWhI
	 CPH1EDgHdvMFxGsn9wugIuVYTGThp5jy5rGuCfCI=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 38B0318041CAC6;
	Mon,  7 Oct 2024 16:54:14 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infreadead.org
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
Subject: [PATCH v2] firmware: arm_scmi: Give SMC transport precedence over mailbox
Date: Mon,  7 Oct 2024 16:54:13 -0700
Message-Id: <20241007235413.507860-1-florian.fainelli@broadcom.com>
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
string, in that order.

After the commit cited in the Fixes tag and with a kernel configuration
that enables both the SMC and the Mailbox transports, we would probe
the mailbox transport, but fail to complete since we would not have a
mailbox driver available. With each SCMI transport being a platform
driver with its own set of compatible strings to match, rather than an
unique platform driver entry point, we no longer match from most
specific to least specific. There is also no simple way for the mailbox
driver to return -ENODEV and let another platform driver attempt
probing. This leads to a platform with no SCMI provider, therefore all
drivers depending upon SCMI resources are put on deferred probe forever.

By keeping the SMC transport objects linked first, we can let the
platform driver match the compatible string and probe successfully with
no adverse effects on platforms using the mailbox transport.

Fixes: b53515fa177c ("firmware: arm_scmi: Make MBOX transport a standalone driver")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
Changes in v2:

- removed downstream Change-Id
- s/SCMI/SMC in the second paragraph
- added details about what changed and how that affects the probing

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


