Return-Path: <linux-kernel+bounces-528199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 084DDA414B5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233FC1896080
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 05:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E061C6FE5;
	Mon, 24 Feb 2025 05:17:41 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B111C5F27
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740374260; cv=none; b=SjAQCbwQCp/sZztTO0j9M7B4DoJuOrGU23zrSv51Kz8kZHDgG8E2pWCet5NySWnpaAC8n/jMtdQpJcGHDR2zwBIlZLm9zth8VEl2m5YVSGwGhtQVydAXlbLcwEDwbUWUf4Em4WcuTjOLp1w2Moz/9ISsZdmXKKM6wjd/rmtEF8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740374260; c=relaxed/simple;
	bh=ZcexFI/4EAc446zMci9zzde286TvXQiyhQuXDVRfTL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kT2V1DiqSiDRYIwk2dNCpYiw+SCt7cAalVPEkyj12VSxy+RkShU9bMDvQC9ygyizb0Z0jdVw7wW1i5HapHcR2O4OChCCgjZGrFxfE0g/0ktcWF+5aJlr7V76NVrjLfw2oJBxyLmSYlD2KRbqysox0ScN4sUvlFx9qth8o/1SkM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tmQqL-0000Ca-SW; Mon, 24 Feb 2025 06:17:25 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tmQqK-002XVo-1p;
	Mon, 24 Feb 2025 06:17:24 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tmQqK-001kmQ-1a;
	Mon, 24 Feb 2025 06:17:24 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 24 Feb 2025 06:17:16 +0100
Subject: [PATCH v2] net: ethernet: ti: am65-cpsw: select PAGE_POOL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-net-am654-nuss-kconfig-v2-1-c124f4915c92@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIANsAvGcC/4WNTQ6CMBBGr0Jm7RhafkRW3sOwKGWAiXFKWiAYw
 t2tXMDle8n3vh0CeaYAdbKDp5UDO4mgLwnY0chAyF1k0KkuUq1TFJrRvMsiR1lCwJd10vOApq0
 o73PKVNVCHE+eet7O8LOJPHKYnf+cP6v62b/JVaFCY22lsvZW3jt6TCTDMnsnvF07guY4ji8lw
 GXOwQAAAA==
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740374244; l=1230;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=ZcexFI/4EAc446zMci9zzde286TvXQiyhQuXDVRfTL0=;
 b=IFPpAWLbRD7QnRn6zV1VTqUMT++P7SbTIjYOpuIXLt65Jw2UTrJZVzSo9Y1ox1AI2zBmeN083
 U7t9xDxs2J6CwVjWQp8IsPjjisIbRz4mEq/8nwCMJ8hHrioxbQTGgyd
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

am65-cpsw uses page_pool_dev_alloc_pages(), thus needs PAGE_POOL
selected to avoid linker errors. This is missing since the driver
started to use page_pool helpers in 8acacc40f733 ("net: ethernet:
ti: am65-cpsw: Add minimal XDP support")

Fixes: 8acacc40f733 ("net: ethernet: ti: am65-cpsw: Add minimal XDP support")
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Changes in v2:
- Add missing Fixes: tag
- Link to v1: https://lore.kernel.org/r/20250220-net-am654-nuss-kconfig-v1-1-acc813b769de@pengutronix.de
---
 drivers/net/ethernet/ti/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 0d5a862cd78a6..3a13d60a947a8 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -99,6 +99,7 @@ config TI_K3_AM65_CPSW_NUSS
 	select NET_DEVLINK
 	select TI_DAVINCI_MDIO
 	select PHYLINK
+	select PAGE_POOL
 	select TI_K3_CPPI_DESC_POOL
 	imply PHY_TI_GMII_SEL
 	depends on TI_K3_AM65_CPTS || !TI_K3_AM65_CPTS

---
base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
change-id: 20250220-net-am654-nuss-kconfig-ab8e4f4e318b

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


