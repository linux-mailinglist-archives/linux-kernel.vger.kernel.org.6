Return-Path: <linux-kernel+bounces-442813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8869C9EE24D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E8518856D5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE1720E31D;
	Thu, 12 Dec 2024 09:11:55 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECB820C499
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733994715; cv=none; b=VTGNt09x6axdYdLX5SVOfBQWCEXr6JBQdmgcGK7aKPJKon96dwcyh/6aBmQDGzFA56z6dkdT4L9AWe+RK5+/5cFeprsfpIDMMc+TC5A82MuUgaoAAo+boYiagL1bS614I4ZP0Qz68XvP+/47ZcDVV2MQDQ2MtPpPcuYDMj3hrUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733994715; c=relaxed/simple;
	bh=YvzfaZqoAhws0X0dD6GV90bHHv20ZBj2S1BxeR9pZsw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=niRbAWH5+gSHFYc7XPhJHFohfkhQhfDZQCfhl0+S9BNWrrU4Gu5fDMmZTb/LpplgJ6/N8UosUtGgw93ew3VEQMiarQBtgdis+7eKtBREnGYF6S2CuZA8zkcYEmCU/HD79No9RNIF0oAYq1ss0cRaPtINRQfgu2f84Lw0QDdwkU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:a086:deff:83e6:222b])
	by laurent.telenet-ops.be with cmsmtp
	id nlBl2D0021T2bNC01lBlLn; Thu, 12 Dec 2024 10:11:45 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tLfEU-000pz5-H8;
	Thu, 12 Dec 2024 10:11:45 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tLfEX-00DEig-1r;
	Thu, 12 Dec 2024 10:11:45 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 net-next] ethernet: Make OA_TC6 config symbol invisible
Date: Thu, 12 Dec 2024 10:11:43 +0100
Message-Id: <3b600550745af10ab7d7c3526353931c1d39f641.1733994552.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit aa58bec064ab1622 ("net: ethernet: oa_tc6: implement register
write operation") introduced a library that implements the OPEN Alliance
TC6 10BASE-T1x MAC-PHY Serial Interface protocol for supporting
10BASE-T1x MAC-PHYs.

There is no need to ask the user about enabling this library, as all
drivers that use it select the OA_TC6 symbol.  Hence make the symbol
invisible, unless when compile-testing.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Target at net-next instead on net, as suggested by Simon,
  - Replace Fixes-tag by description, as suggested by Simon.
---
 drivers/net/ethernet/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 9a542e3c9b05d877..977b42bc1e8c1e88 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -159,7 +159,7 @@ config ETHOC
 	  Say Y here if you want to use the OpenCores 10/100 Mbps Ethernet MAC.
 
 config OA_TC6
-	tristate "OPEN Alliance TC6 10BASE-T1x MAC-PHY support"
+	tristate "OPEN Alliance TC6 10BASE-T1x MAC-PHY support" if COMPILE_TEST
 	depends on SPI
 	select PHYLIB
 	help
-- 
2.34.1


