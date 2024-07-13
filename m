Return-Path: <linux-kernel+bounces-251589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FD293069E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 19:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690481F2322B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 17:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2080D13C8FE;
	Sat, 13 Jul 2024 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="r6VLBqE0"
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8B713B2A5
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 17:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720890567; cv=none; b=eZQbBLSyGP0lbjJZdY5mIuW+Ay3LfnxuE2mbA2fWM50lJErLTQIatyqgY7Fa0Y4oU9W779VHefySomQxCjnBNDjUj4bGfTZas+tSMLugecEGzPmGg1+TOVNMVVJUeWZ515c4xy2TeqYqULsiOhxhCt3iENvAoza8h2jwqdIqUNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720890567; c=relaxed/simple;
	bh=pfQ1m0rvUgOjeAPoUcq8dNXwr6uRl7ZE9dTDU0qqP0k=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=hxS8WEC30yW5faegyUI87QJ/ZtLriFTDCpzRxII35AJcZheIHgnC+/0D+oR2Es09WVia+FPwaU+J/nQPTyonVckjOf+VJeodivGJXSLXLgmU0fR8QMPZGHXGpXeBsscE51CFOjcLEkwpiy2NL1hm5t9UxCr92nMd9/QLdUNCH9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=r6VLBqE0; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 1451 invoked from network); 13 Jul 2024 19:09:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1720890562; bh=7o8mzc213EEKgCOXqvfrefpkdDjhgWDGYyRAq4cTJo0=;
          h=From:To:Subject;
          b=r6VLBqE02iYYFE3IVu876jKXU38PdPH1H0LLDo2bi0eBs5Lrz+R6bt6AiJRs0fHcB
           hleUe9a1jZ0w3MxZES9cN54UWyy/81EcrDH1sNw1Npu+9Mp5xRRjHQEVTaiKmD1UFQ
           0Kq4Us5A4HOY3LGv8gafvM/KepOMq1TKhLFSmj/I=
Received: from 83.24.148.52.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.148.52])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <davem@davemloft.net>; 13 Jul 2024 19:09:22 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	olek2@wp.pl,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	u.kleine-koenig@pengutronix.de,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: ethernet: lantiq_etop: remove redundant device name setup
Date: Sat, 13 Jul 2024 19:09:20 +0200
Message-Id: <20240713170920.863171-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 16fb977d773cd3be13d03770da642e94
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [8VMU]                               

The same name is set when allocating the netdevice structure in the
alloc_etherdev_mq()->alloc_etherrdev_mqs() function. Therefore, there
is no need to manually set it.

This fixes CheckPatch warnings:
WARNING: Prefer strscpy over strcpy - see: https://github.com/KSPP/linux/issues/88
	strcpy(dev->name, "eth%d");

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/ethernet/lantiq_etop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 0b9982804370..9e6984815386 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -675,7 +675,6 @@ ltq_etop_probe(struct platform_device *pdev)
 		err = -ENOMEM;
 		goto err_out;
 	}
-	strcpy(dev->name, "eth%d");
 	dev->netdev_ops = &ltq_eth_netdev_ops;
 	dev->ethtool_ops = &ltq_etop_ethtool_ops;
 	priv = netdev_priv(dev);
-- 
2.39.2


