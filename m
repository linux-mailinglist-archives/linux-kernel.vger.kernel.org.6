Return-Path: <linux-kernel+bounces-548310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69242A54339
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2802418943C5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346E61A9B23;
	Thu,  6 Mar 2025 07:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="JTO18am8"
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6777F19DF4D;
	Thu,  6 Mar 2025 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741244754; cv=none; b=sQQYQik5+F7s2kLrxphIqj2C3krs5i9Mc6k3xXTaQodKzz9v93Cv495AgZXBk3NoPpsk1ZqwaNbJHtJrjMCmEnbQrOYyY8qSuy1DAKMjlsIqcfwFvkfcQiRqbOcpx5PCpzYEWOolBnIXJtvFoQV470F8tQ2R0y1popzlJG7Lzmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741244754; c=relaxed/simple;
	bh=4fsBYDyG/UEtkcJyh44OJqX7sie/l9Ni8w36iQM9FbY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RsNsG3VoOHAKYeRSnQf0HFJSn+GWImToIQBIc1eJzjqErnrIe0KJB8Sxq/psi8VKJkIIW8o5WOskoRvn2sqCCrRBEZU8O6ThOrz1YS17nvUk/UeX0RIbh6wMJGBS92oJkAt83BiPoDsB5PPbKQdI+KZvEimiHlJxphbFg50pOwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=JTO18am8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52675MJs82833910, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741244722; bh=4fsBYDyG/UEtkcJyh44OJqX7sie/l9Ni8w36iQM9FbY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=JTO18am8PEgzoe0jl+NBRUznyO+YcUUrswQ4hz1gaYjzjYUeQXbXbRbLXU+YZREfR
	 R1+/oOLFwRt5oaWXPauhLuENMmV0Gwf1GT5fw0LoDgERbhjDrMqE+ncF7yO8dbFtJm
	 sBL50G/HnFPIe5GB4NM+4loSVfWvY2OGRhO3J0iAFu5RaL5Wnxk6bgVYLvTLhr8HbG
	 UZGWufjAnGvwpB9G1O6x9bS3DwPkWdtNbjiWWPwipCbBqAzmBS1IuYiHIs9YbRwyLZ
	 ZSCrdPq83exeuVa/ubp9TykpO0iMEWwpWaNiSE1ctIad66w2EO2WbIlMfyTqynsnAk
	 58yQAEr6Ft0Jw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52675MJs82833910
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Mar 2025 15:05:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Mar 2025 15:05:23 +0800
Received: from RTDOMAIN (172.21.210.70) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 6 Mar
 2025 15:05:23 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net] rtase: Fix improper release of ring list entries in rtase_sw_reset
Date: Thu, 6 Mar 2025 15:05:10 +0800
Message-ID: <20250306070510.18129-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Since rtase_init_ring, which is called within rtase_sw_reset, adds ring
entries already present in the ring list back into the list, it causes
the ring list to form a cycle. This results in list_for_each_entry_safe
failing to find an endpoint during traversal, leading to an error.
Therefore, it is necessary to remove the previously added ring_list nodes
before calling rtase_init_ring.

Fixes: 079600489960 ("rtase: Implement net_device_ops")
Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 3bd11cb56294..2aacc1996796 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1501,7 +1501,10 @@ static void rtase_wait_for_quiescence(const struct net_device *dev)
 static void rtase_sw_reset(struct net_device *dev)
 {
 	struct rtase_private *tp = netdev_priv(dev);
+	struct rtase_ring *ring, *tmp;
+	struct rtase_int_vector *ivec;
 	int ret;
+	u32 i;
 
 	netif_stop_queue(dev);
 	netif_carrier_off(dev);
@@ -1512,6 +1515,13 @@ static void rtase_sw_reset(struct net_device *dev)
 	rtase_tx_clear(tp);
 	rtase_rx_clear(tp);
 
+	for (i = 0; i < tp->int_nums; i++) {
+		ivec = &tp->int_vector[i];
+		list_for_each_entry_safe(ring, tmp, &ivec->ring_list,
+					 ring_entry)
+			list_del(&ring->ring_entry);
+	}
+
 	ret = rtase_init_ring(dev);
 	if (ret) {
 		netdev_err(dev, "unable to init ring\n");
-- 
2.34.1


