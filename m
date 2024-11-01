Return-Path: <linux-kernel+bounces-392206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554FB9B90FC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881CD1C210D8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB91B19D081;
	Fri,  1 Nov 2024 12:12:17 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B6C175D2D;
	Fri,  1 Nov 2024 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730463137; cv=none; b=LnyMoaVraVhpnTRwhYb8u2fNrsfbwsekJpG13hIsbxghbp801M/i9C6AYFlWaVXctoPy8NuhY0YvXTo22uVtxcezDIIB94bs0ztLYJEdkDTosS0J5aAe0/asgnkULHgvWWDAHh7FJpJPsiB7Nvh0yTQRRa6EnhEkyNS+gj8vc0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730463137; c=relaxed/simple;
	bh=HxurmUJQWxcSRMH4O3E9mali/L/DmRH282+gjwx2KVI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AK6aVBQ8SYWAOGnM9KphV1i/z6RbF2yZRK8gad5dadocp3H11SCn14f2QX8Bb6NX8k9cPFzncjQlw0tIt0vtue95/sARHnTHm/CsxKbGSuc3MOiCQhVNavbF7eLFgYpREijNGfeNJjpvoHuwKsSJhc/77gdH0X9G4bqxRJairNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 1 Nov
 2024 20:12:01 +0800
Received: from aspeedtech.com (192.168.10.152) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 1 Nov 2024 20:12:01 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <patrick@stwcx.xyz>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<wim@linux-watchdog.org>, <linux@roeck-us.net>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
CC: <Peter.Yin@quantatw.com>, <Patrick_NC_Lin@wiwynn.com>,
	<Bonnie_Lo@wiwynn.com>, <DELPHINE_CHIU@wiwynn.com>, <bmc-sw@aspeedtech.com>,
	<chnguyen@amperecomputing.com>
Subject: [PATCH v4 0/3] Update ASPEED WDT bootstatus
Date: Fri, 1 Nov 2024 20:11:58 +0800
Message-ID: <20241101121201.2464091-1-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series inherits the patch submitted by Peter.
https://patchwork.kernel.org/project/linux-watchdog/patch/20240430143114.1323686-2-peteryin.openbmc@gmail.com/
Besides, the boot status updated in the WDT driver
obeys the rules proposed in the OpenBMC.
https://github.com/openbmc/docs/blob/master/designs/bmc-reboot-cause-update.md#proposed-design
Moreover, WDT SW restart mechanism is supported by HW
since AST2600 platform and is also included in this
patch series.

Changes in v2:
  - Support SW restart on AST2600 by default without
    adding any dts property.

Changes in v3:
  - Get watchdog controller index by dividing register
    base offset by register size.

Changes in v4:
  - Update the commit message for updating bootstatus
    handling patch.
  - Rename aspeed_wdt_config struct to aspeed_wdt_data.
  - Create restart callback function.

Chin-Ting Kuo (3):
  watchdog: aspeed: Update bootstatus handling
  watchdog: aspeed: Change aspeed_wdt_config struct name to
    aspeed_wdt_data
  watchdog: aspeed: Update restart implementations

 drivers/watchdog/aspeed_wdt.c | 170 ++++++++++++++++++++++++++++------
 1 file changed, 144 insertions(+), 26 deletions(-)

-- 
2.34.1


