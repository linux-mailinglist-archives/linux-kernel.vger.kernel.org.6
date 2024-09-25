Return-Path: <linux-kernel+bounces-338817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B36B4985D59
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E404C1C24338
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 13:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C80F1E009B;
	Wed, 25 Sep 2024 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YfTEtCdv"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5F01DFE0F
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 12:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265798; cv=none; b=UK9MNXrZTAJN5u5zk44breoXu5F8MGhtCATld3pfD9zChqfuczub6R1DMw0O/rmm7ew1O4yslhFgp0n7dyCJd9lLjYrZVBWBcOIN6fR9NH4ischg4Vb8bMlfs1rUrHuDo4zkUOUs3Z/hTEX0JONMfG4oLM67lbeqNES2uTYED5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265798; c=relaxed/simple;
	bh=upH0O8JzvIpfiMCChGQ55KjOcO7PFmHXfBFJn2x6/Tg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hfcpuxrq4Pw8J0JPd0Nb73ibpRIhifMGLaLgR6c15csYMOfvQb+H6E250gXEevuT8PD6CsqJznNooL22dN6RBTeAXhsY0lgBX8JfHyJADP3/kqdbpOnKkAH2l0yhfHsn/CWnAcxcC4G9HVtxh/7sUhky/nD3HAHO49zMplwY6iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YfTEtCdv; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727265796; x=1758801796;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=upH0O8JzvIpfiMCChGQ55KjOcO7PFmHXfBFJn2x6/Tg=;
  b=YfTEtCdvKDjVHhS2gNmnO9rAivkvjVM+PjilhlRFxA1jx9KtXe2N16nO
   3HFvU9UlycXtF5+lz1FJgrlHUWyas4Wr4YnETL/XXi6oM9vinZGDmKPEn
   mBP0TCCmHPKhQaI7AmA+nYT3sxOPW74vZHlRiqpVTc5Z5OtTYP8eMi3Su
   vaqTC31JjytS9to/kQDruG/B6Rh0sGjXLDoacKh72OtzPt/wVOaqndTIr
   MwWIPdlUfvirrwAfvxMCCJJDx7TY0So4nVp313Vev7c07UPSNA+wjc84g
   Im8GJ5lG8fL5PavRVYK1VyVsBqsmKBPbRXecqRUvfDVME4biKICoE8iXZ
   A==;
X-CSE-ConnectionGUID: 7pv67hfBR/CMeWSpXiVEqA==
X-CSE-MsgGUID: shnxUCg6T/qj/O+1CC2bsA==
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="263240529"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2024 05:03:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 25 Sep 2024 05:02:44 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 25 Sep 2024 05:02:43 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>
CC: <linux-kernel@vger.kernel.org>, <cristian.birsan@microchip.com>, "Andrei
 Simion" <andrei.simion@microchip.com>
Subject: [PATCH] MAINTAINERS: Update maintainer list for MICROCHIP ASOC and MCP16502 drivers
Date: Wed, 25 Sep 2024 15:02:25 +0300
Message-ID: <20240925120224.120032-1-andrei.simion@microchip.com>
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

Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09d0f09c36cc..7f2f87a2483a 100644
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

base-commit: 2b7275670032a98cba266bd1b8905f755b3e650f
-- 
2.34.1


