Return-Path: <linux-kernel+bounces-335056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E96CA97E062
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 08:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BB5DB20FCC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 06:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A3418DF6D;
	Sun, 22 Sep 2024 06:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="Wd6ayejO"
Received: from forward203b.mail.yandex.net (forward203b.mail.yandex.net [178.154.239.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97B9188007
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726988378; cv=none; b=TrHgVqI8maoD2f6iY8/CfYlkgcgvbw7+SPwDmO3p5kkxflzgJCT5KiLutXbayRJ52B5rJzrx7s/qievXQ3RjIkryTPdBTNy4xZ5YYu6GQVTT0t6jYOg1Cxo9hlh13K6z1CzAPArKZneeflpXDAidNclyD6e0JXQCp0PQSaebo1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726988378; c=relaxed/simple;
	bh=OEZgsz+8+tmSsJ2uXHlC8hMkZczxuQ/9soZrJNT/wMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J+Snn0zVh8AJvVfnTgEVx2y1C6JCr8KusvUEdBDAdySVhqAkw0ZFJhOiFgTLm+lDC5/WGTDeILOGnSgQJpOZ12WihEArK4R7WnsV6Q0D5nuVzwaHjY1DaZ5hOVxe/FqA4KuvRXtWczhluXmj2QEcJSKySKSU37llMcS2FnJCqk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=Wd6ayejO; arc=none smtp.client-ip=178.154.239.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward203b.mail.yandex.net (Yandex) with ESMTPS id D3FF264177
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 09:52:40 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net [IPv6:2a02:6b8:c10:2222:0:640:c513:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 3BC73609A4;
	Sun, 22 Sep 2024 09:52:33 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id VqK6swHKgGk0-SKf1IWSs;
	Sun, 22 Sep 2024 09:52:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1726987952; bh=cR0z3zHJ6ex0YlacTW/7IBtcte6v9l8dGs3WdWJYB9I=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Wd6ayejOlu4Dm9SN+krk9SQNNqYKMZB5+a1OWuF8MAO1z7oNXb0mXr9EzL3HPXZmm
	 YKcI4+j24DVph0Vln+CR4cR8Ac9hilPg9yKs3u1LThp2nQdoJmgUIglCR/Rmzjae1P
	 Hmy7C27I69vxRDRfmxQhBOHytUSIhd0lsLMrCU64=
Authentication-Results: mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Arnd Bergmann <arnd@arndb.de>,
	soc@kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	linux-kernel@vger.kernel.org,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] net: cirrus: use u8 for addr to calm down sparse
Date: Sun, 22 Sep 2024 09:52:12 +0300
Message-ID: <20240922065212.7483-1-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ep93xx_eth.c:805:40: sparse: sparse: incorrect type in argument 2
				     (different address spaces)
ep93xx_eth.c:805:40: sparse: expected unsigned char const [usertype] *addr
ep93xx_eth.c:805:40: sparse: got void [noderef] __iomem *

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409212354.9CiUem7B-lkp@intel.com/
Fixes: 858555bb5598 ("net: cirrus: add DT support for Cirrus EP93xx")
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 drivers/net/ethernet/cirrus/ep93xx_eth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cirrus/ep93xx_eth.c b/drivers/net/ethernet/cirrus/ep93xx_eth.c
index 2523d9c9d1b8..c2007cd86416 100644
--- a/drivers/net/ethernet/cirrus/ep93xx_eth.c
+++ b/drivers/net/ethernet/cirrus/ep93xx_eth.c
@@ -771,6 +771,7 @@ static int ep93xx_eth_probe(struct platform_device *pdev)
 	struct resource *mem;
 	void __iomem *base_addr;
 	struct device_node *np;
+	u8 addr[ETH_ALEN];
 	u32 phy_id;
 	int irq;
 	int err;
@@ -802,7 +803,8 @@ static int ep93xx_eth_probe(struct platform_device *pdev)
 		goto err_out;
 	}
 
-	eth_hw_addr_set(dev, base_addr + 0x50);
+	memcpy_fromio(addr, base_addr + 0x50, ETH_ALEN);
+	eth_hw_addr_set(dev, addr);
 	dev->ethtool_ops = &ep93xx_ethtool_ops;
 	dev->netdev_ops = &ep93xx_netdev_ops;
 	dev->features |= NETIF_F_SG | NETIF_F_HW_CSUM;
-- 
2.43.2


