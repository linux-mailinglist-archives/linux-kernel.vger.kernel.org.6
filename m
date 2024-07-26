Return-Path: <linux-kernel+bounces-263602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD9693D825
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE361C228C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045DB61FED;
	Fri, 26 Jul 2024 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RzgIV18g"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A47038DEE;
	Fri, 26 Jul 2024 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017884; cv=none; b=WE39/zfBNPz/kmgK7s8BBmVOhK4VyyNVEwVpTPQ5MbiT7Xe7UCj1UMq0qFoLphT570d7pxWLFXmEAwg3sph2Mm/o6IBi/3bAVjqKA9femV4/s7btxs1LJL2FIC1hg/Hu5HwMa0lnQgD3SjJFkrWm4/N5IhM/V/DBsvdT07vqqBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017884; c=relaxed/simple;
	bh=Pyq5KT99mvHZELjIb9ex4V6SAyN0u6Ln0t+wD17lvWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HOSgSzD08ZvwP1ggUO5dcnRiHKkyBrDZIuUOs4eC3NDagSD+xZNco4uO1u+z6Bp5nGzJY+hQjy30F2HUBA4YCivvJH8td9to+5qppeufbv4UGwIP9Vh4GlcLTzbWxs0vb5XTRUzl5jC9PhQYLoL0hM5M1lH5SKqK3GCDRDvrxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RzgIV18g; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB411C000B;
	Fri, 26 Jul 2024 18:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722017880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L8BqOp+imFT7RCmJiTvOqUvgDym7zUG3PG+O/IVmdxE=;
	b=RzgIV18gLAeLOEqwiANRhZCopxKO9YmyJJyevs1sTSbgS55Q9aGhSlG/hMCEWGAJQB6fh+
	8p8e4/6fSJIKHac24zvNF1heB4MCuYeMm3/UbQpNjAGA4V72LfW93xPIQK7vSEWWJ7+PKN
	c8y8NtXMJMbbKpDEP0vvn+GQtOTQ03iiqkL3pa6/GSrzTeC4E8Fo8YUV4UqUksKzgVbO1f
	dx9KPVKGjgQiHKsZ8W6+o7s9C6rwc7S+y6vU5ioTlRIus6tMTRGpcgdKXoTwEguxc77o69
	4CWjV56xDYBKTT+9q+qWSY84yV2IyASebwOuuhyED7308sGHT2iIV/K8q5Hqug==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 26 Jul 2024 20:17:56 +0200
Subject: [PATCH v5 08/12] usb: cdns3: rename hibernated argument of
 role->resume() to lost_power
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240726-s2r-cdns-v5-8-8664bfb032ac@bootlin.com>
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

The cdns_role_driver->resume() callback takes a second boolean argument
named `hibernated` in its implementations. This is mistaken; the only
potential caller is:

int cdns_resume(struct cdns *cdns)
{
	/* ... */

	if (cdns->roles[cdns->role]->resume)
		cdns->roles[cdns->role]->resume(cdns, cdns_power_is_lost(cdns));

	return 0;
}

The argument can be true in cases outside of return from hibernation.
Reflect the true meaning by renaming both arguments to `lost_power`.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/usb/cdns3/cdns3-gadget.c | 4 ++--
 drivers/usb/cdns3/cdnsp-gadget.c | 2 +-
 drivers/usb/cdns3/core.h         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index fd1beb10bba7..694aa1457739 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -3468,7 +3468,7 @@ __must_hold(&cdns->lock)
 	return 0;
 }
 
-static int cdns3_gadget_resume(struct cdns *cdns, bool hibernated)
+static int cdns3_gadget_resume(struct cdns *cdns, bool lost_power)
 {
 	struct cdns3_device *priv_dev = cdns->gadget_dev;
 
@@ -3476,7 +3476,7 @@ static int cdns3_gadget_resume(struct cdns *cdns, bool hibernated)
 		return 0;
 
 	cdns3_gadget_config(priv_dev);
-	if (hibernated)
+	if (lost_power)
 		writel(USB_CONF_DEVEN, &priv_dev->regs->usb_conf);
 
 	return 0;
diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index 4a3f0f958256..7d05180442fb 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -1973,7 +1973,7 @@ static int cdnsp_gadget_suspend(struct cdns *cdns, bool do_wakeup)
 	return 0;
 }
 
-static int cdnsp_gadget_resume(struct cdns *cdns, bool hibernated)
+static int cdnsp_gadget_resume(struct cdns *cdns, bool lost_power)
 {
 	struct cdnsp_device *pdev = cdns->gadget_dev;
 	enum usb_device_speed max_speed;
diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 9207bd6365f7..f385d3980545 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -30,7 +30,7 @@ struct cdns_role_driver {
 	int (*start)(struct cdns *cdns);
 	void (*stop)(struct cdns *cdns);
 	int (*suspend)(struct cdns *cdns, bool do_wakeup);
-	int (*resume)(struct cdns *cdns, bool hibernated);
+	int (*resume)(struct cdns *cdns, bool lost_power);
 	const char *name;
 #define CDNS_ROLE_STATE_INACTIVE	0
 #define CDNS_ROLE_STATE_ACTIVE		1

-- 
2.45.2


