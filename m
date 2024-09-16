Return-Path: <linux-kernel+bounces-330450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE770979EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7009BB22396
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D019014B07A;
	Mon, 16 Sep 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Hdz1Usje"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BDE1CF83;
	Mon, 16 Sep 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726480230; cv=none; b=R/O23QvU/wwmGs5PE1ziTckqqv9uI24zPTMvJNIEJq5bJ4vxsYl2oIr2koRlZ6lMDJ5+XKaux9EcTUEQwDbFFFC75PKVqnuL32ZSPvLJtijgl6Z3JxBsRl69t/i1T8GUP3ErsglCSkSCnByNTxPurrnjgrCc84N8QzVvahdAC1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726480230; c=relaxed/simple;
	bh=81G0ZIqPpK32ColvW3mBdzGEdoFLeRQtUH2qKA11TrY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=edOdnVMwEunRKcLKcSGc694JxY2xkbKxgmaz++sF+nObLYBMst7aXFhttFuaE/Od69FkZO1Bj8wwk9qa5PNGSfNWX6BIyJYVGK6VR5zUu6FgkY8jLvyzAVvCR3QzbqsnCXJlZ/U8UIV4Ys0r/nHWn31+pr17ZdbYwdQpKmKGi/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Hdz1Usje; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726480229; x=1758016229;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=81G0ZIqPpK32ColvW3mBdzGEdoFLeRQtUH2qKA11TrY=;
  b=Hdz1Usjes7FG4d/a64wI2gPyMgEkUTr+S3hkaNAov8udPmI0mPq5h+lz
   elFcZHLHzd58rAHiBucWObU8sAG24hm92s9WnNexjFqSV4bpXlQOqwNCx
   9v9fXBsvLKOWQf8csud6dN3IUnt6RRkmCe1pMBWEaY7+lXmgNzm6VR7hZ
   9//DFWGQr6XEiJRab8t9+hm8VULbFIaTMkvfdvhsuLIbhGBK96QbNOxUQ
   A2i4gEU1xl67+gHNU/Zq5u0ppCDISpV6/LWVmrjeoHw/ZLOYiVp83A+o5
   BnIXlGZZMPlpnSmYGat9UijY2FY0SUX9ysvxTFFPNH9Jj+cKU8+8aFA/5
   Q==;
X-CSE-ConnectionGUID: As66prBtTYKW6R/VrMccAw==
X-CSE-MsgGUID: gnkbXwtdTOS+giHcB3RwWw==
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="262821347"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2024 02:50:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 16 Sep 2024 02:50:14 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 16 Sep 2024 02:50:12 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH 0/4] clk: lan966x: add support for lan969x SoC clock driver
Date: Mon, 16 Sep 2024 11:49:18 +0200
Message-ID: <20240916-lan969x-clock-v1-0-0e150336074d@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB7/52YC/x3MwQqDMAyA4VeRnBeoRWTZq4wd0pjNMKnaogjiu
 1s9fof/3yFrMs3wqnZIulq2MRbUjwqk5/hTtK4YvPONo9rjwJFa2lCGUf7I0gQh754tCZRmSvq
 17f69P8WBs2JIHKW/Lp2uOC+6KBzHCUEBKzx7AAAA
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kavyasree Kotagiri
	<kavyasree.kotagiri@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14-dev

Add support for the lan969x SoC clock driver in the existing lan966x
driver. The lan969x clock controller contains 3 PLLs - cpu_clk, ddr_clk
and sys_clk which generates and supplies the clock to various
peripherals within the SoC.

Patch #1 adds compatible strings for lan969x SKU's in the dt-bindings

Patch #2 makes the clk_names var const char * const

Patch #3 prepares the lan966x driver for lan969x, by adding private
         match data.

Patch #4 adds support for lan969x

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Daniel Machon (4):
      dt-bindings: clock: add support for lan969x
      clk: lan966x: make clk_names const char * const
      clk: lan966x: prepare driver for lan969x support
      clk: lan966x: add support for lan969x SoC clock driver

 .../bindings/clock/microchip,lan966x-gck.yaml      | 13 +++-
 drivers/clk/clk-lan966x.c                          | 79 +++++++++++++++++-----
 2 files changed, 75 insertions(+), 17 deletions(-)
---
base-commit: 3cfb5aa10cb78571e214e48a3a6e42c11d5288a1
change-id: 20240912-lan969x-clock-ac4bc920869c

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


