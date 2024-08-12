Return-Path: <linux-kernel+bounces-283697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C96A894F7E1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087741C222F9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76D2198A22;
	Mon, 12 Aug 2024 20:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fSR5TP+G"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3772B195F3A
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723493103; cv=none; b=Gdgf2ApeSN87oHWP6c5JuUQ7o8waG/FOgSU6VQy/0boahtFhsqY7jOn1SfpLgtbt1CjL+Ved3/xsUV1VsALgYX7bL8R40jqnzrmIeHO6/R6lNU9h8XgWbecZQjXwfjO9tqfEOgFxx9a+B2afJdHzOuDe35Mzoyxx5oPRbvlnnEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723493103; c=relaxed/simple;
	bh=J0nvZrUfsjvHtyEJuqw0aNa6+zK0Qg/VBPZmKeqMSGo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DmXgzfLa7JIbyuwj84gp2uN6WNC/s9ALLOpSs2LeBjgM8M3PiiNmb9atn0Oq+9qR4tDlVdVCbyNFdBHaDYwypDJGExmcECntm5uULgAChjJA0VyrHJGYfeHKNwcb399BHkQHtKo9dVFAvxfmxTZ//qt/s5Ypm3wGkxEYQ5JEKcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fSR5TP+G; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723493099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NN9ohrWDzAKh5ND5oSSWFgfVnLGZgDo0j5pkupfMzYI=;
	b=fSR5TP+G+9NhbxgRPp1WjkDzeBcETQMBkXkUaIiEp0R2hoLUpJzv/znbINWUcT5pBZMyIZ
	9ZlfjPIU8fVhxweLrdlVaQhB9hBRPSgXZYYu3V5QFQ94d1yb225JEOz7KAj0luo6Pdg5Wu
	3lnG9fwbW5iuNz6FcRX9ITtCaNqf0fU=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Michal Simek <michal.simek@amd.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Ariane Keller <ariane.keller@tik.ee.ethz.ch>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next 3/4] net: xilinx: axienet: Don't print if we go into promiscuous mode
Date: Mon, 12 Aug 2024 16:04:36 -0400
Message-Id: <20240812200437.3581990-4-sean.anderson@linux.dev>
In-Reply-To: <20240812200437.3581990-1-sean.anderson@linux.dev>
References: <20240812200437.3581990-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

A message about being in promiscuous mode is printed every time each
additional multicast address beyond four is added. Suppress this message
like is done in other drivers. And don't set IFF_PROMISC in ndev->flags;
contrary to the comment we don't have to inform the net subsystem.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 1bcabb016ca9..9bcad515f156 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -439,15 +439,9 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 
 	if (ndev->flags & (IFF_ALLMULTI | IFF_PROMISC) ||
 	    netdev_mc_count(ndev) > XAE_MULTICAST_CAM_TABLE_NUM) {
-		/* We must make the kernel realize we had to move into
-		 * promiscuous mode. If it was a promiscuous mode request
-		 * the flag is already set. If not we set it.
-		 */
-		ndev->flags |= IFF_PROMISC;
 		reg = axienet_ior(lp, XAE_FMI_OFFSET);
 		reg |= XAE_FMI_PM_MASK;
 		axienet_iow(lp, XAE_FMI_OFFSET, reg);
-		dev_info(&ndev->dev, "Promiscuous mode enabled.\n");
 	} else if (!netdev_mc_empty(ndev)) {
 		struct netdev_hw_addr *ha;
 
@@ -481,7 +475,6 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 		reg &= ~XAE_FMI_PM_MASK;
 
 		axienet_iow(lp, XAE_FMI_OFFSET, reg);
-		dev_info(&ndev->dev, "Promiscuous mode disabled.\n");
 	}
 
 	for (; i < XAE_MULTICAST_CAM_TABLE_NUM; i++) {
-- 
2.35.1.1320.gc452695387.dirty


