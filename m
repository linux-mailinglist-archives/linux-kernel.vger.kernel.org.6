Return-Path: <linux-kernel+bounces-440054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F127A9EB7FB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D615162BAE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A643246F66;
	Tue, 10 Dec 2024 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TGrBid1D"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDC423027A;
	Tue, 10 Dec 2024 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850828; cv=none; b=KI3RECW27QJw8GCHzKYuEpH9TO/K3SVaesECDUOMogdPjup4Svfv0xdJBrbyxulbosnRxAla1ZsTbXd5dUjrdWY1Ehh68atnJJigLCUhdLkGpIEOWpkW0gXyC+82E4Nmf1zd0I8dfejMSqcwBU1nXYqvoMUG+QOpvk2d9YWhUs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850828; c=relaxed/simple;
	bh=9UworTV+MS2F0uSh6HanIBJMieYjtOPqmcELQRuAOVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tzyXkC4/LrlTAOJHAvU7PMuNdPw8fzEdjKBaSypY4Z9+yE4HzGBKQa/cc8CO8P6MQCYNi7I82/64XAeTNqRYqs+gWsNIXPZjeoMfhQ5WfkGZU4yn2cZ2HWMjPj4nela+zVcbvDAoHpyEcVFYzj3JSJBb3ZCDIEwQPUF82NXgTvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TGrBid1D; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B86C02000E;
	Tue, 10 Dec 2024 17:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733850819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XbbIr+l87r3GthSaZw6V9C5/nV0qXTuiEhfkpu/VVQc=;
	b=TGrBid1DB4hY47GDZhFwerb5YK19J+jimSLkvBYdsxe/UU8cx7N/KYmeP9P9+UC7fA7+2p
	MmyYFqKIrwHfgfYItFEQW8a3V1bQlzjh7tlIuQEwc+BZITlDg5povEMNqGsXqTGD6Zldq+
	kp/0uzP5ffFmd0kLjCnPi/Cc2TRxIUjlsmKR8vGmCwron/n1LMjlbb7etJ4vSAEvlYBKNs
	VHXgcrDJ19S7ylH7yKtQ+b4aYqajd7cOPmnWOo1ZzrTGVYVZgJUsTrKfteV+sXQ+9gstqd
	shmZeEoQ3xP02jiIYsKlpch6pgXgjkxFFOO0iRTZT8akGN1x3D7aHk8pjdZEXQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 10 Dec 2024 18:13:39 +0100
Subject: [PATCH v6 5/5] usb: cdns3: host: transmit lost_power signal from
 wrapper to XHCI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241210-s2r-cdns-v6-5-28a17f9715a2@bootlin.com>
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

cdns_role_driver->resume() receives the information if power was lost
across suspend (ie if a reset occurred). Transmit that to the XHCI core
using the newly introduced lost_power flag.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/usb/cdns3/host.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
index 7ba760ee62e3310e9c678d269d7675c9cb952ec6..01a3d6aad12886096ab2833a7bc276467f08cb1a 100644
--- a/drivers/usb/cdns3/host.c
+++ b/drivers/usb/cdns3/host.c
@@ -138,6 +138,15 @@ static void cdns_host_exit(struct cdns *cdns)
 	cdns_drd_host_off(cdns);
 }
 
+static int cdns_host_resume(struct cdns *cdns, bool lost_power)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(cdns->host_dev);
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+
+	xhci->lost_power = lost_power;
+	return 0;
+}
+
 int cdns_host_init(struct cdns *cdns)
 {
 	struct cdns_role_driver *rdrv;
@@ -148,6 +157,7 @@ int cdns_host_init(struct cdns *cdns)
 
 	rdrv->start	= __cdns_host_init;
 	rdrv->stop	= cdns_host_exit;
+	rdrv->resume	= cdns_host_resume;
 	rdrv->state	= CDNS_ROLE_STATE_INACTIVE;
 	rdrv->name	= "host";
 

-- 
2.47.1


