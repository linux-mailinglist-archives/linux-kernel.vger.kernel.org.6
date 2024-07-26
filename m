Return-Path: <linux-kernel+bounces-263608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1648E93D839
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474371C22795
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C0414F133;
	Fri, 26 Jul 2024 18:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E9JgL+qk"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D0A76025;
	Fri, 26 Jul 2024 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017887; cv=none; b=tbhYkCY0jg3HiEpkFYaMjHnPa8BAE+twNm8scjSx5lHra3Fj7wug59/NBL1/WDEhivIGdUhr61uqqf7WxRkz7mxoWESZRRraBpxtmZ7+fvOB//LJx/16iIweogkafwp/I26rSsCxoj+kmjuNeJA7Zwy93dWMbUiCMriraHTUZZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017887; c=relaxed/simple;
	bh=rYnGXjSRCRrtol49qQV4Bn9yrJ+qw4IRbEIVU55OEr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AkpZeQr2t5o6RPw39opjnNfGvD91YVmmc9FvfC4lv53RRf5BXrkxUGv1UF+qwEyeOxL9zXS5KacUcPpJ/p0DX6QCMWaiDyRz7CaCXtTtMNCNhArqvN9ca2tBE+wSCZma24BKrtgau4c5PTcZBTI24hJksuMsnTYk9wqZSGZ6wxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E9JgL+qk; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5231DC0007;
	Fri, 26 Jul 2024 18:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722017878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rs1+QAvC+jZKXsMcSqVeWFXio+625byt2ino+7lcNkU=;
	b=E9JgL+qkpiuGRDvWxLP3R3OdEU1cluDeiFz53pCJFaTMQvq6VwcVygV3CV9xX7fY+8pBJJ
	jt0vPJY2NChKEYExC/ZDHfO1hATCIrOL+cqgzjqBAU1LCtM7pz0qRGGWWneN7a/05pcdmn
	VHXXCLN60j/tx/HZaNkb13AwyWynr5mJPDactO7E6qlQ9SG7hsWNDjXZkgAJwUDJlJYV4m
	HjsjZ6jJyKxt8AyKr7plXHke3C8cLzki8LD9o2HOCxxV8s1c+tI5cVu1P2AgZXB8hpOZAS
	5iS/we8p6JG77MQHilKQDo5kAzWdwJHon5O9Pty1UuZrf/w4TsbCIaOdKWUg7Q==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 26 Jul 2024 20:17:53 +0200
Subject: [PATCH v5 05/12] usb: cdns3: add quirk to platform data for
 reset-on-resume
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240726-s2r-cdns-v5-5-8664bfb032ac@bootlin.com>
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

The cdns3 host role does not care about reset-on-resume. xHCI however
reconfigures itself in silence rather than printing a warning about a
resume error. Related warning example:

  [   16.017462] xhci-hcd xhci-hcd.1.auto: xHC error in resume, USBSTS 0x401, Reinit

Allow passing a CDNS3_RESET_ON_RESUME quirk flag from cdns3 pdata down
to xHCI pdata. The goal is to allow signaling about reset-on-resume
behavior from platform wrapper drivers.

When used, remote wakeup is not expected to work.

Acked-by: Peter Chen <peter.chen@kernel.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/usb/cdns3/core.h | 1 +
 drivers/usb/cdns3/host.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 57d47348dc19..9207bd6365f7 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -45,6 +45,7 @@ struct cdns3_platform_data {
 	unsigned long quirks;
 #define CDNS3_DEFAULT_PM_RUNTIME_ALLOW	BIT(0)
 #define CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE	BIT(1)
+#define CDNS3_RESET_ON_RESUME			BIT(2)
 };
 
 /**
diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
index ceca4d839dfd..d2cb529630e4 100644
--- a/drivers/usb/cdns3/host.c
+++ b/drivers/usb/cdns3/host.c
@@ -103,6 +103,9 @@ static int __cdns_host_init(struct cdns *cdns)
 	if (cdns->pdata && (cdns->pdata->quirks & CDNS3_DEFAULT_PM_RUNTIME_ALLOW))
 		cdns->xhci_plat_data->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
+	if (cdns->pdata && (cdns->pdata->quirks & CDNS3_RESET_ON_RESUME))
+		cdns->xhci_plat_data->quirks |= XHCI_RESET_ON_RESUME;
+
 	ret = platform_device_add_data(xhci, cdns->xhci_plat_data,
 			sizeof(struct xhci_plat_priv));
 	if (ret)

-- 
2.45.2


