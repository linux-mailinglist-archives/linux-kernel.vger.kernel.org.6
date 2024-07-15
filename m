Return-Path: <linux-kernel+bounces-253153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D5B931D81
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65181281DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7D21422D1;
	Mon, 15 Jul 2024 23:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b="hAD09gcf"
Received: from mail.flokli.de (mail.flokli.de [116.203.226.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC2322626;
	Mon, 15 Jul 2024 23:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.226.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721085101; cv=none; b=sncMkOjVayuTWgPoj4lWUuNsHAdhB7jZ4s62FYxDO/RKxpnJfobRFT9GVpHYPdUlwOOzzEjdwbfSl+Hq25K2aB2Y6/U9ddD87qu18EApDHXoK8n50GnlrCSDxXAxLXsRBJQn+rLIizL17ouwRtvL14r379cGNJm0Y5RYTsYp9oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721085101; c=relaxed/simple;
	bh=P/5rD6RWBbTL8HddfhOIiRrmv32KW4BGoUn1K4kAU8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uYC/bI91PCxgTwyI/ENGksqpJai2FjDM1WRbSpyx4uy32y9egzuFLhZs+PfcIFl3x9DC/GuukSzFVWLu/NejOAK/rX93ZzcP2XFWhguTAs3cpDsadsFfRcPidHOo2WVFD6X6cjf86Smr61aT0HS8kRSujMYHeHu9sh3EcAMlcUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de; spf=pass smtp.mailfrom=flokli.de; dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b=hAD09gcf; arc=none smtp.client-ip=116.203.226.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flokli.de
From: Florian Klink <flokli@flokli.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flokli.de; s=mail;
	t=1721084599; bh=SjR3vmUlN7ap4Z9Y3SfERz2cTpTFLruN5w+w6iQ3Sbw=;
	h=From:To:Cc:Subject:Date;
	b=hAD09gcfU/W9Vw3PhjVnXQEy49V6oEvEBVWBJtywYM/JGPw2x7USuL0L/0eeLVlFH
	 x+spFK0reQl8wFzDGtCPrEjVysy8asCqsRpBpGSFYPmzjtM7mZqYfmItNZ3x5P9kjx
	 LWBtHPu0CZNDUmN4lIuzrkZe9SS1bVI8b+jM3CkU=
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Florian Klink <flokli@flokli.de>
Subject: [PATCH] ARM: dts: bcm283x: Fix hdmi hpd-gpio pin
Date: Tue, 16 Jul 2024 02:03:11 +0300
Message-ID: <20240715230311.685641-1-flokli@flokli.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HDMI_HPD_N_1V8 is connected to GPIO pin 0, not 1.

This fixes HDMI hotplug/output detection.

See https://datasheets.raspberrypi.com/cm/cm3-schematics.pdf

Signed-off-by: Florian Klink <flokli@flokli.de>
---
 arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts b/arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
index 72d26d130efa..85f54fa595aa 100644
--- a/arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
+++ b/arch/arm/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
@@ -77,7 +77,7 @@ &gpio {
 };
 
 &hdmi {
-	hpd-gpios = <&expgpio 1 GPIO_ACTIVE_LOW>;
+	hpd-gpios = <&expgpio 0 GPIO_ACTIVE_LOW>;
 	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
 	status = "okay";
 };
-- 
2.45.1


