Return-Path: <linux-kernel+bounces-265229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2442593EE28
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79856B232B9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0484137903;
	Mon, 29 Jul 2024 07:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QGLwEOD4"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F00212E1C5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236997; cv=none; b=YZJDOoHioGOWlPb3soyZZASTRPF9OF/FZNQ4xdVfNyBJeY+lHJujzMv3hYR4cFQdpp4QyMEZZQAOf1T2oWyGp//WXKf6rNjzjXQhep5z1J+5xJ/x4PLchWGJySLIOV54j5HX3c5/hcZY+6rCIanewHif01x/HTLyXhLBW7ugizk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236997; c=relaxed/simple;
	bh=HIwiMG3fzHfBPs1HXktRdSzwupW0rewW+Ooza3V6tzM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgcqc4aK9q0HZrVzMck0BUChEmw91XvEeiIes+wnC+6hTL7GbYW4vBXMsZGncvVjzHIU5Z9YwzdRgOz6zj4usuJvl/wDcyuUF0piw7UFcPau0aC2s/I6m4LYEIuE2z1Cbz7P38Tiq5tUltyHTVRbmEfboJ1mLZ5zh5b0D0KPLwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QGLwEOD4; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722236995; x=1753772995;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=HIwiMG3fzHfBPs1HXktRdSzwupW0rewW+Ooza3V6tzM=;
  b=QGLwEOD4BQV6qwyUKgGQPmD0mNEMeVf9Aln1U6y1xNaMuUqWVRKYOzEa
   IXvNO1Lt7yi/IkT8NfpsPpxcRMqxkBHL5Kmgv2bXTQWivzQMp1cICSFxw
   0JwlgzDpJ6+WUuqGJHGctM1ZPfibjhELaQ6N6D5tnIKJGO56a+JaDZJcQ
   vKBiny/LaZkZuem+f0gdXRgojGWMlINg5n8lyxjTET8T+2YtxlkQvj4y4
   wxhUB5GsI5l8+5yZi9GHo1YD5JXemBqwwAeOXl9ewO5YnAiHO6lIiKyqs
   yZH7co+BrinmMcdHNR98tv4f20u56XzmINZBnWZfYq8Na2fj/dVKTmX/I
   w==;
X-CSE-ConnectionGUID: YmCZXuD3Tai4yHyg8vJh5A==
X-CSE-MsgGUID: T99tJMQHRK+qiDNKvOTNXQ==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="30454186"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 00:09:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 00:09:33 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 00:09:29 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <linux@armlinux.org.uk>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>, <arnd@arndb.de>,
	<geert+renesas@glider.be>, <palmer@rivosinc.com>, <gerg@linux-m68k.org>,
	<rdunlap@infradead.org>, <dharma.b@microchip.com>,
	<varshini.rajendran@microchip.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 24/27] ARM: configs: at91: enable config flags for sam9x7 SoC family
Date: Mon, 29 Jul 2024 12:39:23 +0530
Message-ID: <20240729070923.1991418-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
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
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
Changes in v6:

 - Updated Reviewed-by tag
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 6eabe2313c9a..2022a7fca0f9 100644
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


