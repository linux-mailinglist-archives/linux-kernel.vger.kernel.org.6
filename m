Return-Path: <linux-kernel+bounces-243604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00993929854
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 16:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FD51C213D1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 14:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED1628DD0;
	Sun,  7 Jul 2024 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="LIEUMajf"
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D92922612
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 14:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720361446; cv=none; b=cJLEr8Cfotrt1Zye6eRg91W0PCFxj86Xw+vZ/8muKIc3YBZq+Bv0ikfDtInqJZ5A1cY8L0tGsQaxgeBvNSaG4WbuxPH20EVdmf/AMd4wWfFzV0NPxQ1gVcnygGmcemO0fEreszTjE2VTEulcGrsA/yLtJhFnxP8wJvB2h7uGQNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720361446; c=relaxed/simple;
	bh=P7+CNfVl047fVV1z6Lx9FBjcixGVWSZCKBHE+nE+b0g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dC06PkNzw3WVVUCHpEhpHfs8md4J06Pg9zEbR9aab3tGFaa+jIpAvjtAv8NwZ2QhqP1ujOCDG+jhagKLPnI8o2ZPsp9PTLxTiCEnqJUXVwzbb/E6kGocBv8SZtlTOGFQI327IWEK3EnLm2jxsWbEzNmfQ7QjrBswJ1lfoBw7PaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=LIEUMajf; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 33104 invoked from network); 7 Jul 2024 16:10:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1720361440; bh=yHu0nKyF0gGpnAcY2CsRwk60KztddVybT3bVgpVwlNY=;
          h=From:To:Cc:Subject;
          b=LIEUMajf1K+OK3fBc5B5bjZVVw0EE0DJMT3DszYSPje4Fx7+VPzLzvF6apGaNpsFQ
           nJNW6ijQ2XOC2HbbCRmHvCpmoiY/mNh4Ai5lneZ9RJ7sA56q+2PvzVg5hSRLPW9HiP
           iY2qUitVahXgJH4V/Vym3bAKqMU+cOgc750IkhRg=
Received: from 83.5.245.171.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.5.245.171])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <davem@davemloft.net>; 7 Jul 2024 16:10:40 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jacob.e.keller@intel.com,
	u.kleine-koenig@pengutronix.de,
	olek2@wp.pl,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Joe Perches <joe@perches.com>
Subject: [PATCH] net: ethernet: lantiq_etop: fix double free in detach
Date: Sun,  7 Jul 2024 16:10:37 +0200
Message-Id: <20240707141037.1924202-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: eb553b4f10c6d53441d0cf719975b7cb
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000B [sZMk]                               

The number of the currently released descriptor is never incremented
which results in the same skb being released multiple times.

Reported-by: Joe Perches <joe@perches.com>
Closes: https://lore.kernel.org/all/fc1bf93d92bb5b2f99c6c62745507cc22f3a7b2d.camel@perches.com/
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/ethernet/lantiq_etop.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 5352fee62d2b..6027e5a179b4 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -217,9 +217,7 @@ ltq_etop_free_channel(struct net_device *dev, struct ltq_etop_chan *ch)
 	if (ch->dma.irq)
 		free_irq(ch->dma.irq, priv);
 	if (IS_RX(ch->idx)) {
-		int desc;
-
-		for (desc = 0; desc < LTQ_DESC_NUM; desc++)
+		for (ch->dma.desc = 0; ch->dma.desc < LTQ_DESC_NUM; ch->dma.desc++)
 			dev_kfree_skb_any(ch->skb[ch->dma.desc]);
 	}
 }
-- 
2.39.2


