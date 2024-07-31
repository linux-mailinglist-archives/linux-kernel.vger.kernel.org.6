Return-Path: <linux-kernel+bounces-269381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3EF943235
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F1C1C23CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB951BBBD1;
	Wed, 31 Jul 2024 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lJc+bV3A"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB7C1BBBC5
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722436891; cv=none; b=Vh0nwHW9hZcd+FTlunJ0rpVgM072w8H60RjgJihmySeSeZKmfs7vBjgltIRgfa3DSq6ht69iauF3e+Ra/lPxQbqAQMM8EIkLjAWScJP9Zx6j/51gpYt0ZfZL15e04jfyv9vS0aJDQCEPja2KbZUsqcLUBslyiKbDnTY9fssKfFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722436891; c=relaxed/simple;
	bh=E6KgNnYzbt91dEC1MO1HJTuDpyeBTNgliEJaGbzyBoc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HdS+kH1boj32LBF5519D3XLzayHiG+9ZhTNvLllIzSGYuuorSEH8h7t9jH5hKeyCn4xAun6vVjhK7j4ZcPPvzVMCEIqUJHhcprFQKoy5r1dQ6+yoLDVaFVITB8t3xt930RPN+A7iMdl0XFfA3sNSzf6cFAUskHGOV0r+KpyoG1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lJc+bV3A; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722436890; x=1753972890;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E6KgNnYzbt91dEC1MO1HJTuDpyeBTNgliEJaGbzyBoc=;
  b=lJc+bV3AFQMhF2AUTqpsu/F3z0zvW0bPVharWeIItq4uwC2fU53TdW6E
   4rx+/aIVbx8o4+/haJP9JE/MNSNTHIYIUFcqGlkWSfOtorsmLvH8b24Wu
   Y+RBCVNR19/dKT223k7flaKCBqMffbUH5DDgRkzSjf6kwBZavHFKfBwDx
   jzuiYNi4cQa3MrKHEq4iErjVuCJL8FAzj5EjaePmxFXqJsXHT0cBUF6ww
   /Ea8kL3tEXMhKa9KjvjGPmb84hjCB0AdxtJK7uzhay9/Vws1B2J9mDj20
   +RZqTSmwLls297R4KJv1AqMX/ITu4I+dbAcGanlHi8tYIq9fhxHVMGO+o
   w==;
X-CSE-ConnectionGUID: XfuieRZyT9252deHyk6jNA==
X-CSE-MsgGUID: ITh+0UB7QUuZq+okRPsyvg==
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="29926944"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jul 2024 07:41:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jul 2024 07:41:01 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jul 2024 07:40:59 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <cristian.birsan@microchip.com>
CC: <linux-kernel@vger.kernel.org>, Andrei Simion
	<andrei.simion@microchip.com>, Conor Dooley <conor@kernel.org>
Subject: [PATCH] MAINTAINERS: Update DTS path for ARM/Microchip (AT91) SoC
Date: Wed, 31 Jul 2024 17:41:00 +0300
Message-ID: <20240731144100.182221-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Update the path to the supported DTS files for ARM/Microchip (AT91)
SoC to ensure that the output of the get_maintainer.pl script includes
the email addresses of the maintainers for all files located in
arch/arm/boot/dts/microchip.

Suggested-by: Conor Dooley <conor@kernel.org>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
Based on discussion:
https://lore.kernel.org/lkml/20240709-education-unfreeze-a719c6927d73@spud/
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 36d66b141352..c9f320ba8bc9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2542,8 +2542,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 W:	http://www.linux4sam.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git
-F:	arch/arm/boot/dts/microchip/at91*
-F:	arch/arm/boot/dts/microchip/sama*
+F:	arch/arm/boot/dts/microchip/
 F:	arch/arm/include/debug/at91.S
 F:	arch/arm/mach-at91/
 F:	drivers/memory/atmel*

base-commit: cd19ac2f903276b820f5d0d89de0c896c27036ed
-- 
2.34.1


