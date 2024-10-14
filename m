Return-Path: <linux-kernel+bounces-363690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF1899C5AB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4831C221D1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA2E156968;
	Mon, 14 Oct 2024 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="a4n46Plp"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0347514D428;
	Mon, 14 Oct 2024 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898196; cv=none; b=Y6WnWt0Y2AFIhADQdYHvwcGTQ44HoYA/jtKW9/yWzNxOZmvHse8Nk614j36DliYx8kfMsXry5H4XaKURN+TdGkdjjvuJHDL/N8bhwDLAn119v/4IvKvKkiojaGJ/tqY6iDThwNNAiVpGTJihmqSynj1GoQID9+LBG8gGWFEaR60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898196; c=relaxed/simple;
	bh=+/0MUZYB4A2sleIMMMI/f4e98kGIzrhlAW+0y+eL3lQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jFt1AJi/3QspefCNAYNz8nn7U4+Tp6mY80+9s0X6a82F4FtYQr8Cmn17/1fvyAHL02ZJqkpoGmTJxb8i1fk458MRZb00H/nUwBG/mF8df9iEfKrPKUxsNEHB/MT9+tXg8a+3ISnVcFQl81ph+9EgtFAyidXv4WDMyTGHDZB/RHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=a4n46Plp; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728898195; x=1760434195;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+/0MUZYB4A2sleIMMMI/f4e98kGIzrhlAW+0y+eL3lQ=;
  b=a4n46PlpL0JjF48mfN5D1u6Q+hspT27V022KdgpK+2mTDl4lQPqOe+/6
   J1SN9sOw04VnXBUw9FOGdr5WN/SdUh3k1Pvcc7+nn9Ro1y7g5QY6gA3qR
   PUvzz+s39NifiLoW4itEPVBeRC9/5xCyVkUAIM2Br05MkWKzuPdy/B01z
   l12NLYXflJ2A4FMJuTp6PYleit0DtfTzoNATcp6KFJIqnOuuA1v83nQDh
   e2JEmvx3qxD254CIiNBqAIJhY5k5qUW9Lb8k3EIipPN5h5EamrP083FZk
   s9fspCW4aDhKtp0vgQhS+aIOA24v1FFIjhlFRBfbJV69R+Nvy5gz1VToM
   A==;
X-CSE-ConnectionGUID: pCLDKrORScqRABue8oJFyg==
X-CSE-MsgGUID: AmmQ2eMhSiGkTkZoRt17Qw==
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="32974832"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2024 02:29:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 14 Oct 2024 02:29:33 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 14 Oct 2024 02:29:30 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
	<perex@perex.cz>, <tiwai@suse.com>, <arnd@arndb.de>,
	<gregkh@linuxfoundation.org>, <nicolas.ferre@microchip.com>
CC: <linux-sound@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH v2 RESEND] MAINTAINERS: Update maintainer list for MICROCHIP ASOC, SSC and MCP16502 drivers
Date: Mon, 14 Oct 2024 12:28:31 +0300
Message-ID: <20241014092830.46709-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

To help Claudiu and offload the work, add myself to the maintainer list for
those drivers.

Acked-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
v1 -> v2:
- add acked-by tag
- adjust commit title
- update maintainer list for MICROCHIP SSC DRIVER
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1eebb14efb5e..73afcdd005ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15144,6 +15144,7 @@ F:	drivers/spi/spi-at91-usart.c
 
 MICROCHIP AUDIO ASOC DRIVERS
 M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
+M:	Andrei Simion <andrei.simion@microchip.com>
 L:	linux-sound@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/sound/atmel*
@@ -15252,6 +15253,7 @@ F:	include/video/atmel_lcdc.h
 
 MICROCHIP MCP16502 PMIC DRIVER
 M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
+M:	Andrei Simion <andrei.simion@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/regulator/microchip,mcp16502.yaml
@@ -15383,6 +15385,7 @@ F:	drivers/spi/spi-atmel.*
 
 MICROCHIP SSC DRIVER
 M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
+M:	Andrei Simion <andrei.simion@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/misc/atmel-ssc.txt

base-commit: 7f773fd61baa9b136faa5c4e6555aa64c758d07c
-- 
2.34.1


