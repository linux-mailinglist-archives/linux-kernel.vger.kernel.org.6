Return-Path: <linux-kernel+bounces-297552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC6A95BAB5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4C81F247DD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A781CCEC2;
	Thu, 22 Aug 2024 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cpyg94nP"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFFE1CC160
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341287; cv=none; b=Z9ruZGSvcYOeBJFWZH1ie1k44LH2J8p51rfLRrG8i3US6tTBrdDXYppR+ZrdZjDVLQ59pxis7npo1C/9yeNGf7etwwk/tvB95jL+v+B49VIukoAO+J01SdgeeN++3oVu62XZNeyj8ot/d6Yux6OudWL1bY1mQofM15n637xHFGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341287; c=relaxed/simple;
	bh=dzCXGaFReauwOK1YthHIV8ZrILBfMiz1n2GhKtNfezI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CYAaGMlxd4XmMyB7267ppGn/1Z9UDEG+P75AOSUYw+tXDqmQNLGOlUldmRBoTTT2tdOm4mldMrAWH23xfq/jSffCM5twwtDdaVyXWwVyMiSNkT3vUii1vxNgzSLFwRbGk3eWvCevDorY64kw336numeGen58Ag3Au74L8dXatQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cpyg94nP; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724341281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Swnhdbla4FFcBOXmANTpBJTCNvMqxhSTYkB1DquWAZQ=;
	b=cpyg94nPbPW0BA/TdsKmBx18YBoIKViU7/9NMB3UYey6CtoMEuaGQDwVLvUh9m0HxAO8AI
	wuGOcUveW/Eagx467n269MXAx0AaGreqPRVEqqsuHii626gpcyPSanI6Q23r51ZPY0NkCW
	Uqr7jiRPYzDNXwRbL8mASrDqjKjIC6k=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	Eric Dumazet <edumazet@google.com>,
	Michal Simek <michal.simek@amd.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v3 1/5] net: xilinx: axienet: Always disable promiscuous mode
Date: Thu, 22 Aug 2024 11:40:55 -0400
Message-Id: <20240822154059.1066595-2-sean.anderson@linux.dev>
In-Reply-To: <20240822154059.1066595-1-sean.anderson@linux.dev>
References: <20240822154059.1066595-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If promiscuous mode is disabled when there are fewer than four multicast
addresses, then it will not be reflected in the hardware. Fix this by
always clearing the promiscuous mode flag even when we program multicast
addresses.

Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Simon Horman <horms@kernel.org>
---

(no changes since v1)

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 38f7b764fe66..6fad473a937b 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -451,6 +451,10 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 	} else if (!netdev_mc_empty(ndev)) {
 		struct netdev_hw_addr *ha;
 
+		reg = axienet_ior(lp, XAE_FMI_OFFSET);
+		reg &= ~XAE_FMI_PM_MASK;
+		axienet_iow(lp, XAE_FMI_OFFSET, reg);
+
 		i = 0;
 		netdev_for_each_mc_addr(ha, ndev) {
 			if (i >= XAE_MULTICAST_CAM_TABLE_NUM)
-- 
2.35.1.1320.gc452695387.dirty


