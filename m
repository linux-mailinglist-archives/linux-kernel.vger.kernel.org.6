Return-Path: <linux-kernel+bounces-263607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D5093D837
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863752827B0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548BF14F118;
	Fri, 26 Jul 2024 18:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ls+AnFBC"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CCD73514;
	Fri, 26 Jul 2024 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017887; cv=none; b=X+9fiaKr65qWVNAfI2T8mTYhmpLEqY4I85mbhiDSrev9OEbfm5V7c+YXiERcREvTWxR8tSfnM0K8INcGx3licpqzqWcB9BXxDtaaTfXIRQBVr+FFuPhiPtO+5fPYezzi1BnK9H7rzCY9Be3s7/JkFMa8Nz3lp59Ql7OXQUS2HQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017887; c=relaxed/simple;
	bh=6Daa08I6itJcAFS9/xCN/oDOprQU3OGIjFNs0OxlHgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fw5iO1p5DArGrCSHHrEnN2nkQRBv0o7B6ikX666KBLo0ytirpsKOzW27zJUn5wN4hv3jxjeSM+GIBkKUvMmavNHELbq3yUi4qSea6p/x4XYbHWztwgQn01b2nU70u53ZIkKRnGDQJiOI9Sgmni3c5ct8SXqzXnnobQl7Q8RI8eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ls+AnFBC; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6C3A2C000C;
	Fri, 26 Jul 2024 18:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722017882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nVKDcHNw5TaBkw7ykMrWc0qPl//SaW0x/mq86RauHgc=;
	b=Ls+AnFBCzBN0HwcYy9zP6koWjLz/YO08/2MPGZeHVW+/8c9SdnUo4Yr1yXevYIIdA+JYoE
	lro7oeDBX4Wh3+5DHbesFtvd4e24dVubijUvREJ9hj/WeNhdwbSukzJCWQd9SF1IXydDjb
	4XY+vNTR/4UuTlxtrqISnuDNvRt8QXq85DVzfPnH8QcbGXKUAL8QF0OmFq3XkLt73mL/Ct
	mKBON+s+4BjiAgo4yKjZElTfJZcLFX6qK1ri4g3lMYeXEE3q99Y0xISPQctKBdMSmG2xpN
	29eEr7sHUel6nlcKiS9YtvkEC6nhbD2R/03GTtaxA79IFS8RY7lQO4+2NFPy2g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 26 Jul 2024 20:17:58 +0200
Subject: [PATCH v5 10/12] usb: cdns3: host: transmit lost_power signal from
 wrapper to XHCI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240726-s2r-cdns-v5-10-8664bfb032ac@bootlin.com>
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

cdns_role_driver->resume() receives the information if power was lost
across suspend (ie if a reset occurred). Transmit that to the XHCI core
using the newly introduced lost_power flag. We therefore override its
default value that is based on XHCI_RESET_ON_RESUME.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/usb/cdns3/host.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
index d2cb529630e4..edef39ab8d15 100644
--- a/drivers/usb/cdns3/host.c
+++ b/drivers/usb/cdns3/host.c
@@ -139,6 +139,15 @@ static void cdns_host_exit(struct cdns *cdns)
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
@@ -149,6 +158,7 @@ int cdns_host_init(struct cdns *cdns)
 
 	rdrv->start	= __cdns_host_init;
 	rdrv->stop	= cdns_host_exit;
+	rdrv->resume	= cdns_host_resume;
 	rdrv->state	= CDNS_ROLE_STATE_INACTIVE;
 	rdrv->name	= "host";
 

-- 
2.45.2


