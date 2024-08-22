Return-Path: <linux-kernel+bounces-297555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F6995BABA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6872283E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63741CDFAE;
	Thu, 22 Aug 2024 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dnNEq5Mu"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9311CCEC4
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341290; cv=none; b=fTJMIMRP3pEjDrwj8i6ct9qyJ/mNrSJbRhz+zWIA0E3QTNG895Ii9iZpAxpfnIq7se5kb8yZ9HtTGNO+PcPY3ks2Mrghf9LU79EDM5HkIrd+pGx/pNXJ3f1HqvLv9dbRJGGvUztmk9xw73mD+4+In2z0S+SXudlR/eUn6vQYR2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341290; c=relaxed/simple;
	bh=Ze4hmZ31kbNNIFYUn/vNQZ3JN5wL90sfLeN9bE2VJkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aHO3T35g+C/tzocyaHyo1YTLzDgkcqeOqqswsNZ6sxeZ2SyHpvS3lTLkjKA0u4O0A0Jm41zYTilyeksXrOHZ+wPzlmB0wSgILaX11c+IZQ3CoqGPsNHOuE+aLVhTWuBeKu1fA7qh9MJjtzyTpLgcfP3QFUyq9U6uRKvYigQcDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dnNEq5Mu; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724341286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WrVWUSGAi65g2KGYwS084DcxvQZ1Z3a88yLyeu+WdHE=;
	b=dnNEq5MubHTWTpg/iJjWqZPAMYW39Bt1K0dhA+YrbCeve7VJX6nTkj8fSpMLA6QTJ7CUPm
	XlUcnYOihpkJAU5iFQ5z3670De/TpykOAzYrFH5KKmcdFhhueyIhvD7bpQ85gXo4yYCmhn
	pGKMQ3KrTKdZXMQgmEM3V+Eohi+iqTs=
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
Subject: [PATCH net-next v3 3/5] net: xilinx: axienet: Don't print if we go into promiscuous mode
Date: Thu, 22 Aug 2024 11:40:57 -0400
Message-Id: <20240822154059.1066595-4-sean.anderson@linux.dev>
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

A message about being in promiscuous mode is printed every time each
additional multicast address beyond four is added. Suppress this message
like is done in other drivers.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Simon Horman <horms@kernel.org>
---

(no changes since v2)

Changes in v2:
- Split off IFF_PROMISC change

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 88ff82c52d0c..f612adb07a25 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -447,7 +447,6 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 		reg = axienet_ior(lp, XAE_FMI_OFFSET);
 		reg |= XAE_FMI_PM_MASK;
 		axienet_iow(lp, XAE_FMI_OFFSET, reg);
-		dev_info(&ndev->dev, "Promiscuous mode enabled.\n");
 	} else if (!netdev_mc_empty(ndev)) {
 		struct netdev_hw_addr *ha;
 
@@ -481,7 +480,6 @@ static void axienet_set_multicast_list(struct net_device *ndev)
 		reg &= ~XAE_FMI_PM_MASK;
 
 		axienet_iow(lp, XAE_FMI_OFFSET, reg);
-		dev_info(&ndev->dev, "Promiscuous mode disabled.\n");
 	}
 
 	for (; i < XAE_MULTICAST_CAM_TABLE_NUM; i++) {
-- 
2.35.1.1320.gc452695387.dirty


