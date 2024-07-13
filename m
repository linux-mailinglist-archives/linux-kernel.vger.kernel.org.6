Return-Path: <linux-kernel+bounces-251652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2345B9307B9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 00:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BFCA2824EA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 22:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E5F13DDA3;
	Sat, 13 Jul 2024 22:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="ViurjQkx"
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057EF29401
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 22:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720910058; cv=none; b=KkZpF1n7EetFyOs+WBIsKFxRE903lr6L/6vpnS3JOkkGGZhGGWfvUnecC1nm8VoX3ROB1K0uhUsl6HiLxzKCnmKCgZzwsFXc1OGk0HZtGdnl30nBmg++/nq6npICMjMbcH0M1tupJu6EBK9e+TlGlzidCwZrPKeSLRufTaZgOaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720910058; c=relaxed/simple;
	bh=H7Wqs9IY0RVk3/f8b71KD0COfcu6Ng2RKx6CTnHunBk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=FQSqt6yFeu9OD2CrG7iDAI+leU7QaEuooALMfQFfbo5SyqEc9IHhLoOoqT9vY8D6ay/2NFaagrSKVp15eBrooPWm0XJrFYI5Tufu6XbTfASjsl331eSmzGt/8lNWZELUa7hnQDOVaJO83nnvYlwaPEKa+g/luewJdY6PQVWXp6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=ViurjQkx; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 44297 invoked from network); 14 Jul 2024 00:34:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1720910046; bh=W3lApuN7YTRnEcM3XCm9T9HOweCmIdx72YW45Ridj4A=;
          h=From:To:Subject;
          b=ViurjQkxraPQnJOQurZBwphlA+HnUEZ4V2AKL4y91ir2Oi+ryDAxD1UXZobPVutKv
           8KnmcgdQWw26NC99xfVCGilzl/0aujJh+d+q3FkoPm92e68LJGwTLACwKXiMnSCFnQ
           L5teRuGhB+xZ12Ng0GAZwLlR6fE4i/QOEGQno4U0=
Received: from 83.24.148.52.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.148.52])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <davem@davemloft.net>; 14 Jul 2024 00:34:06 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	olek2@wp.pl,
	shannon.nelson@amd.com,
	sd@queasysnail.net,
	u.kleine-koenig@pengutronix.de,
	john@phrozen.org,
	ralf@linux-mips.org,
	ralph.hempel@lantiq.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: ethernet: lantiq_etop: fix memory disclosure
Date: Sun, 14 Jul 2024 00:33:57 +0200
Message-Id: <20240713223357.2911169-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: b5f9b250616002899b8321895476c16d
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000B [gaOU]                               

When applying padding, the buffer is not zeroed, which results in
memory disclosure. This patch uses skb_put_padto() to pad Ethernet
frames properly.

It appears that only the MAC in xrx100 and newer SoCs supports
padding by hardware, so software padding must be applied.

Fixes: 504d4721ee8e ("MIPS: Lantiq: Add ethernet driver")
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/ethernet/lantiq_etop.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 0b9982804370..196715d9ea43 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -478,11 +478,11 @@ ltq_etop_tx(struct sk_buff *skb, struct net_device *dev)
 	struct ltq_etop_priv *priv = netdev_priv(dev);
 	struct ltq_etop_chan *ch = &priv->ch[(queue << 1) | 1];
 	struct ltq_dma_desc *desc = &ch->dma.desc_base[ch->dma.desc];
-	int len;
 	unsigned long flags;
 	u32 byte_offset;
 
-	len = skb->len < ETH_ZLEN ? ETH_ZLEN : skb->len;
+	if (skb_put_padto(skb, ETH_ZLEN))
+		return NETDEV_TX_OK;
 
 	if ((desc->ctl & (LTQ_DMA_OWN | LTQ_DMA_C)) || ch->skb[ch->dma.desc]) {
 		netdev_err(dev, "tx ring full\n");
@@ -497,12 +497,13 @@ ltq_etop_tx(struct sk_buff *skb, struct net_device *dev)
 	netif_trans_update(dev);
 
 	spin_lock_irqsave(&priv->lock, flags);
-	desc->addr = ((unsigned int)dma_map_single(&priv->pdev->dev, skb->data, len,
-						DMA_TO_DEVICE)) - byte_offset;
+	desc->addr = ((unsigned int)dma_map_single(&priv->pdev->dev, skb->data,
+						   skb->len, DMA_TO_DEVICE)) -
+						   byte_offset;
 	/* Make sure the address is written before we give it to HW */
 	wmb();
 	desc->ctl = LTQ_DMA_OWN | LTQ_DMA_SOP | LTQ_DMA_EOP |
-		LTQ_DMA_TX_OFFSET(byte_offset) | (len & LTQ_DMA_SIZE_MASK);
+		LTQ_DMA_TX_OFFSET(byte_offset) | (skb->len & LTQ_DMA_SIZE_MASK);
 	ch->dma.desc++;
 	ch->dma.desc %= LTQ_DESC_NUM;
 	spin_unlock_irqrestore(&priv->lock, flags);
-- 
2.39.2


