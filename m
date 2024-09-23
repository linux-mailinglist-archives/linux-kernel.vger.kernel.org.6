Return-Path: <linux-kernel+bounces-335473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA9297E634
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEAE91F215E2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 06:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2EE6F067;
	Mon, 23 Sep 2024 06:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rQcbGYDn"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3395145025;
	Mon, 23 Sep 2024 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727074256; cv=none; b=DZl65GZRj6Img21WgbP9ekodR6XzKaeFYnlIsdIj/Tfy5GTRR6nLHiGxokP3wvSexF4tP6o34S9FSUryJnOPZIa42HrXMmSagAY+uZAOfK4IDuk1S+aGdEMRov9l/A/KtGkQs9eyNsGFVi8vcUD0qI09LOixn2tijy6besJ1lro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727074256; c=relaxed/simple;
	bh=lckwW4uQvCxylSjsWiEw2aSLtvHoRVEH7N8d1FoLgb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OsHAyhEBr3k2gjoM4qL6zoSfRC/gh5MYyOpiGRV8pjQ5fhoGsT+NF7cAimSi5yCTt/PGmPN+4c3qz6dwgFmc9tRRawZ0W52pgoBIhQupH3NNnpWVqkK3RWBSuNnpTQ5HBlf5SGgTaUjgN0f693b3KP2gM6g7cPl9AXmtdKlwbI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rQcbGYDn; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727074256; x=1758610256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lckwW4uQvCxylSjsWiEw2aSLtvHoRVEH7N8d1FoLgb0=;
  b=rQcbGYDnzeuKCuz+m8mUc1yPw3E2IBx0+PvHMRpIR32TsCV4d2pszolm
   0HgRteLKUAEHq0WJJ+OkTV1oMVzW0rAdLdQkH2fc4tunCBpkc9Muapawy
   yxWr/Mzh2+HJTFhy40xF9mdikg+dGRfKRt6/wOkimmJ+ZZhVqgPlb+Kcr
   r8xSOkeUGL860kt5O/6CKtOw5TH/2x8t1ntXnUe2gOuBSauoJu0i6BPX+
   zMPVo0YPYNVXrrvPi+dD/p0nephoxiRCa2povCYmx5v9NwzjOSD3MZRVD
   TqmZadgdMb7da+tbqpVXCtMazvXZ1TIFLSpfXVkwZCly0ISdjis/BZNIH
   w==;
X-CSE-ConnectionGUID: nbowMA2OSLiJEr3vdSwxZA==
X-CSE-MsgGUID: CsBhKaC0RT2ob83R12qREw==
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="263115670"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Sep 2024 23:50:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 22 Sep 2024 23:50:20 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 22 Sep 2024 23:50:17 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux@armlinux.org.uk>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 5/5] ARM: configs: at91: enable PAC1934 driver as module
Date: Mon, 23 Sep 2024 09:49:32 +0300
Message-ID: <20240923064932.5797-6-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923064932.5797-1-mihai.sain@microchip.com>
References: <20240923064932.5797-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Enable PAC1934 driver and build as module.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 arch/arm/configs/sama5_defconfig   | 1 +
 arch/arm/configs/sama7_defconfig   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 2022a7fca0f9..f2596a1b2f7d 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -201,6 +201,7 @@ CONFIG_AT_XDMAC=y
 CONFIG_IIO=y
 CONFIG_AT91_ADC=y
 CONFIG_AT91_SAMA5D2_ADC=y
+CONFIG_PAC1934=m
 CONFIG_PWM=y
 CONFIG_PWM_ATMEL=y
 CONFIG_PWM_ATMEL_HLCDC_PWM=y
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 9096a99b5abd..e447329398d5 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -212,6 +212,7 @@ CONFIG_VIDEO_HANTRO=m
 CONFIG_IIO=y
 CONFIG_AT91_ADC=y
 CONFIG_AT91_SAMA5D2_ADC=y
+CONFIG_PAC1934=m
 CONFIG_ENVELOPE_DETECTOR=m
 CONFIG_DPOT_DAC=m
 CONFIG_MCP4531=m
diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index 7fa5d251ced2..1a2e93c8ee71 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -193,6 +193,7 @@ CONFIG_STAGING=y
 CONFIG_IIO=y
 CONFIG_IIO_SW_TRIGGER=y
 CONFIG_AT91_SAMA5D2_ADC=y
+CONFIG_PAC1934=m
 CONFIG_PWM=y
 CONFIG_PWM_ATMEL=y
 CONFIG_MCHP_EIC=y
-- 
2.46.1


