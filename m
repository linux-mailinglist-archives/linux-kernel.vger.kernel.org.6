Return-Path: <linux-kernel+bounces-263599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A7193D81E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD561F235A2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDC344C76;
	Fri, 26 Jul 2024 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m01kwFZH"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C56338385;
	Fri, 26 Jul 2024 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017883; cv=none; b=fiQ/LmxxXupe9pA2rCMwwkuUBYOtRm4IH1Y6B86nDz0QYxzdfYlXmZ7qdwWYJ14kj514mQtV+24rwiXWie9LxJ9nfQzWWnlUq9eNCmZ3MqV2qm4PPFSEkfdXCGVHsXpbP/kPpxOX7hiccfls9fmgyp15/BbU9VDFlLiOGs1aLy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017883; c=relaxed/simple;
	bh=cFFBq9xftAOJ8+raON3AZMUJgV5YQctWnS/lEPft84E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U+dEkFGlIOOOGyOPUt2hQ+7pcAMLhATgEbsXlXic7dBipaCauTCaQB9fga7dZw92lhKjLzUO2wsgxG2kIQvTWfTNnNN1Q4PoUpzEZ3jmvAlpdV1q1g1Wum+1t2NhDHH+tExXolmNTpvZFGFu91h+VDQbsbSFyhuDS9Yx7LrSK4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m01kwFZH; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0577FC000A;
	Fri, 26 Jul 2024 18:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722017879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Eayj+ntAEk18/DRsjd8aPm4OTkARNCkPfWA6i3HBMw=;
	b=m01kwFZH8OlhF1iaJg8FIvKh749lS2UavKUm42AMknQ0S5TwCAd+CbX2PovnmjtTekR6rM
	P8lLwHZHsX3zYZHBaKfZ9D3+S/kZ6Z+5Y47CKc5NJh7qgfXPKKuiwIo6bobXfXjkZX5TBC
	rCSsuVtQ/Mgu6fS0Sf2Z4YfsGWDq/hCpi1rh3JC7DZ9H10Kjm2N/EnnFJLPmz1v9gwNWtl
	C+GC3hlpt8W4kRXDUTBWFuVg7r0zf8gNUOjvaR0Wm7PGa4SGeMGoIZtPv1dFyRXUpBohL6
	kH2eE37QGFs+X8gBTsSxIYT0gDGo2vkPj2a8yGrCguftORJEDoVbg7b3iRnoIg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 26 Jul 2024 20:17:55 +0200
Subject: [PATCH v5 07/12] usb: cdns3-ti: add J7200 support with
 reset-on-resume behavior
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240726-s2r-cdns-v5-7-8664bfb032ac@bootlin.com>
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

Add ti,j7200-usb compatible. Match data indicates the controller resets
on resume which tells that to the cdns3 core. This in turn silences a
xHCI warning visible in cases of unexpected resets.

We also inherit the errata quirk CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE from
the default `cdns_ti_auxdata` configuration.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/usb/cdns3/cdns3-ti.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
index 159814dfc856..65b8b6f4c654 100644
--- a/drivers/usb/cdns3/cdns3-ti.c
+++ b/drivers/usb/cdns3/cdns3-ti.c
@@ -258,7 +258,21 @@ static const struct of_dev_auxdata cdns_ti_auxdata[] = {
 	{},
 };
 
+static struct cdns3_platform_data cdns_ti_j7200_pdata = {
+	.quirks = CDNS3_RESET_ON_RESUME |
+		  CDNS3_DRD_SUSPEND_RESIDENCY_ENABLE,   /* Errata i2409 */
+};
+
+static const struct of_dev_auxdata cdns_ti_j7200_auxdata[] = {
+	{
+		.compatible = "cdns,usb3",
+		.platform_data = &cdns_ti_j7200_pdata,
+	},
+	{},
+};
+
 static const struct of_device_id cdns_ti_of_match[] = {
+	{ .compatible = "ti,j7200-usb", .data = cdns_ti_j7200_auxdata },
 	{ .compatible = "ti,j721e-usb", .data = cdns_ti_auxdata },
 	{ .compatible = "ti,am64-usb", .data = cdns_ti_auxdata },
 	{},

-- 
2.45.2


