Return-Path: <linux-kernel+bounces-336329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41589983938
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 23:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704371C2175F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325A584FAD;
	Mon, 23 Sep 2024 21:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="f/KR0hbI"
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D726B84A32
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727128207; cv=none; b=h1EXc6WZ69oPYBO6V/9iT63YCoaPs5/A3YwUWBwfau7Q6sJJhWzu+gihYDrC3DS1T1lltQq3b3Emrn+8o+bAp9OJ96YDwV8q+OmnvQM+aYDTGaYaz2tQ7bnMjd0ihiSacePu285mtNZLetNDA+q6SadhZu3Pol1SznF/1w35t70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727128207; c=relaxed/simple;
	bh=gwJUyWLWMHja5ixUGK2nFxlVhCgyGJ3nK5o8vRyAUoo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pEBAZVVIrxIlGXTtIvw1D9DlbmVENCki6VEgISrCI0/QAWKbc8r9o793/FszC/LMyaXToeffMtWDlUGpwl4nASnwLZ5dEYQTn65L0EAIvBNkGbPQVuFbsqnsTT9EgxhmUnboSw3sSLLT6XRUvj7LZ6l13awCxdVY8xhiw/iExxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=f/KR0hbI; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 37212 invoked from network); 23 Sep 2024 23:49:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1727128196; bh=VkaBMdOdPAgr5FeCKoBsc2WOUZxsyeUGs/7/e8yFhno=;
          h=From:To:Subject;
          b=f/KR0hbIU8J524WZH+7XPxNl08gZngdboXYdDw60cRmjlGXgpMoNjApZsktUi6zEN
           SJ+ZsHSLADUrOJ1ruuu6+n8XP9pnhgV7V2wpCfiEpqsRn5n1haASY5vj85dg2ancZ0
           y8lWAAD4Tqj8ViHsMHDYf/oYq25DQ4jTvcjFKBSY=
Received: from 83.24.122.130.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.122.130])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <davem@davemloft.net>; 23 Sep 2024 23:49:56 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	olek2@wp.pl,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	john@phrozen.org,
	ralf@linux-mips.org,
	ralph.hempel@lantiq.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 1/1] net: ethernet: lantiq_etop: fix memory disclosure
Date: Mon, 23 Sep 2024 23:49:49 +0200
Message-Id: <20240923214949.231511-2-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240923214949.231511-1-olek2@wp.pl>
References: <20240923214949.231511-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 94f8f4b0e5bc779445e0e527846c0b6f
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [8ZME]                               

When applying padding, the buffer is not zeroed, which results in memory
disclosure. The mentioned data is observed on the wire. This patch uses
skb_put_padto() to pad Ethernet frames properly. The mentioned function
zeroes the expanded buffer.

In case the packet cannot be padded it is silently dropped. Statistics
are also not incremented. This driver does not support statistics in the
old 32-bit format or the new 64-bit format. These will be added in the
future. In its current form, the patch should be easily backported to
stable versions.

Ethernet MACs on Amazon-SE and Danube cannot do padding of the packets
in hardware, so software padding must be applied.

Fixes: 504d4721ee8e ("MIPS: Lantiq: Add ethernet driver")
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/ethernet/lantiq_etop.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 3c289bfe0a09..7179271f63b6 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -481,7 +481,9 @@ ltq_etop_tx(struct sk_buff *skb, struct net_device *dev)
 	unsigned long flags;
 	u32 byte_offset;
 
-	len = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;
+	if (skb_put_padto(skb, ETH_ZLEN))
+		return NETDEV_TX_OK;
+	len = skb->len;
 
 	if ((desc->ctl & (LTQ_DMA_OWN | LTQ_DMA_C)) || ch->skb[ch->dma.desc]) {
 		netdev_err(dev, "tx ring full\n");
-- 
2.39.5


