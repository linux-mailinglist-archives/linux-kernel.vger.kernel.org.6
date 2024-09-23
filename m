Return-Path: <linux-kernel+bounces-335469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358E097E62C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 905BFB20CBA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 06:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CB72C181;
	Mon, 23 Sep 2024 06:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vtxyKclP"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D878119BA6;
	Mon, 23 Sep 2024 06:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727074252; cv=none; b=JKcGcznuA5SCRBa7TRjBX+4unyKs7ol1A7zwubfEyVlJcCodrtSYSUrUgORxgJoRX5qn3/PspeerbMlCThWIngzFTUrfgW7N3m/XWtDjpZl8zUvWyHDvqutqgbNZlyLgWBevjbk6yuQiBjFvxtokTey1yMTGozpcUYed7LrYj6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727074252; c=relaxed/simple;
	bh=VwINCGRlGQnR0rRp781X14ZquLX22Qk6e/b9LdO7DbM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lZip3lZa08g4YGSjDmNp5c09agZWtJPVsAhg3PidnpjrvGLUNhlOGziFLg6xzR19c+ZCbWQ1ybsJu5C+B/FdM6RufqigS0E+EKxIAgt5cWKhGqKMXU6zaZA89zWUqiEqLmYwKy0MZcgLQLojzVCugUTLo0rhZRWw0+kO/Dwyf70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vtxyKclP; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727074252; x=1758610252;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VwINCGRlGQnR0rRp781X14ZquLX22Qk6e/b9LdO7DbM=;
  b=vtxyKclPZWOVq2tbm/7fkZ/K5hn6WZhH3RbiIOH0Sy7b2B9qhn+T8fvV
   OihELLNS5YPil/pOA7jkexCtKd74IdfEqG+Q2ZytIs7+0Y9OfbQDIJiq+
   gyfxaoUduXoLPhMUS5Xpxn9nffxqsB5orPcqMErSD5ud/NlVvsr0J8qA2
   R4CBpLvm3/2ELRZno6TyyezemOEYtie9H4mZ0E6srIt3YRhxqBJszmDSv
   2pbO0UZ7Kv7pm4+DB7CAzXY2kCCsZnkItpBa7BmXwoja1FNKxWP023M/+
   xXEWVtCZvKW6HQBMYB4nmsAbOk7j0IzTSunlmnojDOtTDT6m55wWYbkeX
   A==;
X-CSE-ConnectionGUID: nbowMA2OSLiJEr3vdSwxZA==
X-CSE-MsgGUID: ICsVmeOVSXKAc9BCkLGwHQ==
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="263115654"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Sep 2024 23:50:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 22 Sep 2024 23:50:06 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Sun, 22 Sep 2024 23:50:03 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux@armlinux.org.uk>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 0/5] Add power monitor support on Microchip boards
Date: Mon, 23 Sep 2024 09:49:27 +0300
Message-ID: <20240923064932.5797-1-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series adds power monitor support using PAC1934 on Microchip boards.

[root@sama7g5 ~]$ lsiio
Device 001: pac1934
Device 000: e1000000.adc

[root@sama7g5 ~]$ awk -f pac1934.awk
VDD3V3 current: 161.747 mA, voltage: 3300.29 mV
VDDIODDR current: 72.616 mA, voltage: 1346.68 mV
VDDCORE current: 249.84 mA, voltage: 1204.59 mV
VDDCPU current: 68.4628 mA, voltage: 1301.27 mV

Mihai Sain (5):
  ARM: dts: microchip: sam9x60ek: Add power monitor support
  ARM: dts: microchip: sama5d2_icp: Add power monitor support
  ARM: dts: microchip: sama7g54_curiosity: Add power monitor support
  ARM: dts: microchip: sama7g5ek: Add power monitor support
  ARM: configs: at91: enable PAC1934 driver as module

 .../arm/boot/dts/microchip/at91-sam9x60ek.dts | 31 +++++++++++++++++++
 .../boot/dts/microchip/at91-sama5d2_icp.dts   | 31 +++++++++++++++++++
 .../dts/microchip/at91-sama7g54_curiosity.dts | 31 +++++++++++++++++++
 .../arm/boot/dts/microchip/at91-sama7g5ek.dts | 31 +++++++++++++++++++
 arch/arm/configs/at91_dt_defconfig            |  1 +
 arch/arm/configs/sama5_defconfig              |  1 +
 arch/arm/configs/sama7_defconfig              |  1 +
 7 files changed, 127 insertions(+)


base-commit: de5cb0dcb74c294ec527eddfe5094acfdb21ff21
-- 
2.46.1


