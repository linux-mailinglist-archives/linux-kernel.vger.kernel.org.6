Return-Path: <linux-kernel+bounces-239271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 992199258B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BEF4B2A5F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483E917B4E9;
	Wed,  3 Jul 2024 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0DzlE+mN"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618A81741F5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002578; cv=none; b=sV+OGBkIOx2jTtnS/MjaZeVWpnLSfxTAwxbx9nh0h7v1iK8ihYZPoHlpnptf4AGcL8v9BRux0jEq0nvcNRPvTVt/9ds+NqEqy/9CzuWiM3OpdOixixV8w794/jCVO0xv3JlvdHzroZAs3BBTx2dTVKA/QNqxLcXt9TQkRhQPcAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002578; c=relaxed/simple;
	bh=MzE6ItZ/794POonRjSZ60qB1SlzVtmy0+kfDCLFkHkw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAjZXfL3UBiZc5eBPrFB+tPTTiHRtkioaFHZqTo0wz7iZVrtIxOPgRLJeZVSb35TQZlm5vJnGxOk3KjbbwnucyeoA8kXX3Co7/mx2OrCO61obwhCy9KXvNxjRa/N8CgsLCo3o9r//kTyAa83EKhnYz0yOdvZYlTsrmvPbP+O59Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0DzlE+mN; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720002577; x=1751538577;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=MzE6ItZ/794POonRjSZ60qB1SlzVtmy0+kfDCLFkHkw=;
  b=0DzlE+mNdluJ9Lm6QPlVwwvYIOtJSrf1N51+r8ZxRks/eyfHORy+ByHV
   tO5Pbr9sRqV4oVLCxCIkz9IigxBoyl9c9AqdMXTw4l5FzQVvAbU/mTODi
   lU2Jzd5bec5o717vbvLA+16yxzuBPPDWaiPhadt5fBTV0vyb2EYV4bpOg
   40kgIciS2+s+822hE5AsUOo9/MH5nTm8iDmhd2DaDX76mNMMWja7mRY1k
   YUG4O1OUhKVtTekUduESqqlY1klKEc7LIEorLMm3CEyN8II7ZRSSrdR/H
   u71Gq/elR8mNbvK71ap93C3m/sWYUXp1J0uyXQGpPa0NkSrp6/brq36p0
   w==;
X-CSE-ConnectionGUID: JwvaHmRMTXaAt14ps6TIkA==
X-CSE-MsgGUID: u43G7fYtRZCP/ke7nXEcxA==
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="29441555"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jul 2024 03:29:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jul 2024 03:29:23 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jul 2024 03:29:18 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>, <arnd@arndb.de>,
	<rdunlap@infradead.org>, <Jason@zx2c4.com>, <gerg@linux-m68k.org>,
	<palmer@rivosinc.com>, <varshini.rajendran@microchip.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 24/27] ARM: configs: at91: enable config flags for sam9x7 SoC family
Date: Wed, 3 Jul 2024 15:59:15 +0530
Message-ID: <20240703102915.196508-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703102011.193343-1-varshini.rajendran@microchip.com>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Enable config flags for SAM9X7 SoC for the sam9x7 SoC family.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 1d53aec4c836..880f0c0f4cc3 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -16,6 +16,7 @@ CONFIG_ARCH_AT91=y
 CONFIG_SOC_AT91RM9200=y
 CONFIG_SOC_AT91SAM9=y
 CONFIG_SOC_SAM9X60=y
+CONFIG_SOC_SAM9X7=y
 # CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
 CONFIG_AEABI=y
 CONFIG_UACCESS_WITH_MEMCPY=y
-- 
2.25.1


