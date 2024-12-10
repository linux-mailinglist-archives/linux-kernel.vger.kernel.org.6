Return-Path: <linux-kernel+bounces-440052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B7C9EB7FA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F4C1888E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E360523EA86;
	Tue, 10 Dec 2024 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nQPlrBap"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F2E230273;
	Tue, 10 Dec 2024 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850827; cv=none; b=mDroX5hcZSbaLV0KNddeVR7w7+uOgRV1G5+kzuITmTv7GdlQTXu2Vt66L9r3gKrZ+dxbreMGIDg5lb2r7uFLUXkhBvaA22KULpxa8bwBgsE7m2yb1hT/NgiZct7b4lQv3fNolc0x6MXA0tUPr5DsALQYjzJZKuns/DPKRHBTsKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850827; c=relaxed/simple;
	bh=RZTHxmapeucOexmFPnmzZCVbnuq6HB5uGQZRbjl6/7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YRGNeMBI9HbDGoCqETveJJRRS8okOUnfkgsZiXkAMMndb0Ok+i68E3MVg4b4pP3qF4gm9Ev3maE5UBpKLgxornIJJDtTf0yFh4oEcyBtzEPH4hMxPTRWtcE0uVXD3XP29348RhAO+888kC/8FMEzbbRSToXdo5gLqylBBEYfRbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nQPlrBap; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 401CE20004;
	Tue, 10 Dec 2024 17:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733850818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HTIBfuiAvxsPW2OOJUD1BM9AQyXTmQykYBAwFkvsm3w=;
	b=nQPlrBapthHzpSb79T7d+w6sDG1BUKV9X6/Gv2R6DkzACxHSgYKLCKWoGsaoX3CPIemkP6
	cboCh/y/6YpSCaipSNfsrPipJWiOdId2HJplgvaAgAwjfupA0JKKm97RpsaiSr4PyyEQJS
	YoqyazlxJPgznwBL8NPYsP7oMFdssHO651D/GHPHikk17saoPnpKqMwr7Vxb7FJqfxjFoZ
	2nzuOlT5OsHKSWHLdwK0XUW/qDKeScU/+KYC2MRvKoBE8uvbl0S2e8XXYRzTBEs1/BZX8S
	hWN0LTiNKgW/kexg2YGrRdUTEYBeHtllqIPvLCwaQ+hr5kTMj82UXWihglf5LQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 10 Dec 2024 18:13:38 +0100
Subject: [PATCH v6 4/5] xhci: introduce xhci->lost_power flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241210-s2r-cdns-v6-4-28a17f9715a2@bootlin.com>
References: <20241210-s2r-cdns-v6-0-28a17f9715a2@bootlin.com>
In-Reply-To: <20241210-s2r-cdns-v6-0-28a17f9715a2@bootlin.com>
To: Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>, 
 Roger Quadros <rogerq@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Mathias Nyman <mathias.nyman@intel.com>
Cc: =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: theo.lebrun@bootlin.com

The XHCI_RESET_ON_RESUME quirk allows wrappers to signal that they
expect a reset after resume. It is also used by some to enforce a XHCI
reset on resume (see needs-reset-on-resume DT prop).

Some wrappers are unsure beforehands if they will reset. Add a mechanism
to signal *at resume* if power has been lost. Parent devices can set
this flag, that defaults to false.

The XHCI_RESET_ON_RESUME quirk still triggers a runtime_pm_get() on the
controller. This is required as we do not know if a suspend will
trigger a reset, so the best guess is to avoid runtime PM.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/usb/host/xhci.c | 3 ++-
 drivers/usb/host/xhci.h | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 5ebde8cae4fc44cdb997b0f61314e309bda56c0d..ae2c8daa206a87da24d58a62b0a0485ebf68cdd6 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1017,7 +1017,8 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
 
 	spin_lock_irq(&xhci->lock);
 
-	if (hibernated || xhci->quirks & XHCI_RESET_ON_RESUME || xhci->broken_suspend)
+	if (hibernated || xhci->quirks & XHCI_RESET_ON_RESUME ||
+	    xhci->broken_suspend || xhci->lost_power)
 		reinit_xhc = true;
 
 	if (!reinit_xhc) {
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 4914f0a10cff42dbc1448dcf7908534d582c848e..32526df75925989d40cbe7d59a187c945f498a30 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1645,6 +1645,12 @@ struct xhci_hcd {
 	unsigned		broken_suspend:1;
 	/* Indicates that omitting hcd is supported if root hub has no ports */
 	unsigned		allow_single_roothub:1;
+	/*
+	 * Signal from upper stacks that we lost power during system-wide
+	 * suspend. Its default value is based on XHCI_RESET_ON_RESUME, meaning
+	 * it is safe for wrappers to not modify lost_power at resume.
+	 */
+	unsigned                lost_power:1;
 	/* cached extended protocol port capabilities */
 	struct xhci_port_cap	*port_caps;
 	unsigned int		num_port_caps;

-- 
2.47.1


