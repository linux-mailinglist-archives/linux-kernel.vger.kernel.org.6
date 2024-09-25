Return-Path: <linux-kernel+bounces-339119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB53986088
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6091C26662
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F431ABEAF;
	Wed, 25 Sep 2024 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Mtl4Yz/l"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16E6147C79
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727269727; cv=none; b=JR0CV8CpFhpu4QWgJMrS6XHBjqb/mHZ2HNLYfTDUuvctfUXUtAnFL5cYT5HDUONkgloOUrWLd5Kj8TFjZit1naZlkxsb9LvS34loFnF2ZkuyoySnKu8wY628c2JiqjjmujzyWAz5pl1OvzX3e5rZI7cIbrTxuo8Si8I14IrkS1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727269727; c=relaxed/simple;
	bh=xfyKxiJ0VdCTnYIVTPcXWqUPqfQyCG2ceYDOz7S/23o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GzHjrRT7wiv8rS9q88L3Tgn2iS8tG6jLTvvxHqxZsRXjvD1dA+D2e/r4tIIdvNwvD4vsXE50JLa8TwIv42eL4Cz6gz8qYCSDUGbJ7wwFjHaRDAS4jtA/Eh4GYxB0dSYP2z+HaAxgm8BCQgklyYZpGe7xL9It3C7YKEEQyKhGs6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Mtl4Yz/l; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727269726; x=1758805726;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xfyKxiJ0VdCTnYIVTPcXWqUPqfQyCG2ceYDOz7S/23o=;
  b=Mtl4Yz/l5o2nJixHQGmxqmkre5Q0JXIt3Z/Su4ExRhHI+7PAs1JM/2CS
   SABfqf++UNDVa9MEEBMUOwJkRtuLvh1dWm1AlxZ1E1RvoOmNjR6wt6ajJ
   PGGJ3rR25rqREpFkbYV3K05UbH0kr/595sW9DrD9zJJdxCRKvWsTZI6/I
   bUZRa61fv3GG0J/YT8imOYs8D+bnurSbfagzqVuRwqerT8HNDcJI9QhrO
   W76sVfjNDJsWYOhGbcExyEBypNhMtgT+RAV9Yop/g96nQxuZnWzGcygYd
   Myl+M2mQX19slYz8SIjtcDpn8AAHtT47VOD7fkwSJfO/lxmdrWrbrDBNA
   w==;
X-CSE-ConnectionGUID: E01jMMOtQJGPKYHP3FcoBg==
X-CSE-MsgGUID: X7+G096kSaOyfAeW0z/AtQ==
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="32223755"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2024 06:08:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 25 Sep 2024 06:08:04 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 25 Sep 2024 06:08:02 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>
CC: <linux-kernel@vger.kernel.org>, <cristian.birsan@microchip.com>, "Andrei
 Simion" <andrei.simion@microchip.com>
Subject: [PATCH v2] MAINTAINERS: Update maintainer list for MICROCHIP ASOC, SSC and MCP16502 drivers
Date: Wed, 25 Sep 2024 16:07:13 +0300
Message-ID: <20240925130711.122950-1-andrei.simion@microchip.com>
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
index 09d0f09c36cc..12e6777bb6b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15088,6 +15088,7 @@ F:	drivers/spi/spi-at91-usart.c
 
 MICROCHIP AUDIO ASOC DRIVERS
 M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
+M:	Andrei Simion <andrei.simion@microchip.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/sound/atmel*
@@ -15196,6 +15197,7 @@ F:	include/video/atmel_lcdc.h
 
 MICROCHIP MCP16502 PMIC DRIVER
 M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
+M:	Andrei Simion <andrei.simion@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/regulator/microchip,mcp16502.yaml
@@ -15327,6 +15329,7 @@ F:	drivers/spi/spi-atmel.*
 
 MICROCHIP SSC DRIVER
 M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
+M:	Andrei Simion <andrei.simion@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/misc/atmel-ssc.txt

base-commit: 2b7275670032a98cba266bd1b8905f755b3e650f
-- 
2.34.1


