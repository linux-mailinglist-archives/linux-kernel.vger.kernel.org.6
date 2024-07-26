Return-Path: <linux-kernel+bounces-263603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AAED893D833
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B1A1F21629
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD64F14A609;
	Fri, 26 Jul 2024 18:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YISZNTAS"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C763BBC0;
	Fri, 26 Jul 2024 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017885; cv=none; b=I9iVKhLX3jogwmyLpC1LEQRfBetDGlE93/z19u3s7io/cFMkYxkaA4A+XEMtZhVAjKMBiRb5nYIaglfZGIZhdqD9vNMFIjo0Wc1qmRR4en/HQtOEcdWpe4DTgW1wyyLdJJNRzqf4GFYbVhEcAO+KPz2qL1HLFS3s0Tl6cNkOxfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017885; c=relaxed/simple;
	bh=L9WuGK3/+JBnFAYDNw+LiekWRfrj2s7kyJZfovAMN50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e0J5uBQLjptXmG3f2RvslB4IbQJi+FFqF/9jnCZAnGYxtGSQiay6pUkIHatz1gCwufr3W3HnXdzb8D6Lz9FTK14xwrB6NR/Fy4MK/9shjOjkA5kbbeUvVGeHvuRhJwn9keZr3GEjcXrtUgK4OIKoeHRcexNT5+zLpSjrXoqqz4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YISZNTAS; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 95BDCC0009;
	Fri, 26 Jul 2024 18:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722017881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZYia7FGurB9of6IzHnVjgaTJVQiLrxPMBa0JK9qcOU=;
	b=YISZNTASZcu9lL4M+MHFMKTHcQtXdc/AEFh0XrKSLydZP3UUmXSCJOMXkGLnVzUf2h4hhR
	cRTZwaTCyGUiUPTanbVXyq4AS4ucXZblnM4ZfludQbknbf0L51ZwxGz4T59bNwMbO2/6lI
	jWsnuAtyyuvG9uIdMk/trfGZWv68HiwENG7boPnhQnpVQ/Sn32GnyA4g9JTOTknZr2/tOp
	1JCF6C4aLPetxME1h5Bni6uWpgmVUUVZMybB8LsFex272FPRGBQtQHNKZKFEzvPwiwUrZ+
	1Ssg8B1gwrH4UbjZ9WLnLdGX+TOzw07OXu3ok1zShDm2WaFurfCq3CqaYQECKA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 26 Jul 2024 20:17:57 +0200
Subject: [PATCH v5 09/12] xhci: introduce xhci->lost_power flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240726-s2r-cdns-v5-9-8664bfb032ac@bootlin.com>
References: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
In-Reply-To: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Roger Quadros <rogerq@kernel.org>, 
 Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>, 
 Mathias Nyman <mathias.nyman@intel.com>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Kevin Hilman <khilman@kernel.org>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: theo.lebrun@bootlin.com

The XHCI_RESET_ON_RESUME quirk allows wrappers to signal that they
expect a reset after resume. It is also used by some to enforce a XHCI
reset on resume (see needs-reset-on-resume DT prop).

Some wrappers are unsure beforehands if they will reset. Add a mechanism
to signal *at resume* if power has been lost. Parent devices can set
this flag, that defaults to the XHCI_RESET_ON_RESUME value.

The XHCI_RESET_ON_RESUME quirk still triggers a runtime_pm_get() on the
controller. This is required as we do not know if a suspend will
trigger a reset, so the best guess is to avoid runtime PM.

Reset the xhci->lost_power value each time in xhci_resume(), making it
safe for devices to only set lost_power on some resumes.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/usb/host/xhci.c | 8 +++++++-
 drivers/usb/host/xhci.h | 6 ++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 0a8cf6c17f82..2c9b32d339f9 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1029,9 +1029,12 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
 
 	spin_lock_irq(&xhci->lock);
 
-	if (hibernated || xhci->quirks & XHCI_RESET_ON_RESUME || xhci->broken_suspend)
+	if (hibernated || xhci->lost_power || xhci->broken_suspend)
 		reinit_xhc = true;
 
+	/* Reset to default value, parent devices might correct it at next resume. */
+	xhci->lost_power = !!(xhci->quirks & XHCI_RESET_ON_RESUME);
+
 	if (!reinit_xhc) {
 		/*
 		 * Some controllers might lose power during suspend, so wait
@@ -5228,6 +5231,9 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 	if (get_quirks)
 		get_quirks(dev, xhci);
 
+	/* Default value, that can be corrected at resume. */
+	xhci->lost_power = !!(xhci->quirks & XHCI_RESET_ON_RESUME);
+
 	/* In xhci controllers which follow xhci 1.0 spec gives a spurious
 	 * success event after a short transfer. This quirk will ignore such
 	 * spurious event.
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index ebd0afd59a60..ec7c6061363f 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1640,6 +1640,12 @@ struct xhci_hcd {
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
2.45.2


