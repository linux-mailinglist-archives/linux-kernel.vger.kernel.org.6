Return-Path: <linux-kernel+bounces-283530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF5C94F5F7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38161282489
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567441898EE;
	Mon, 12 Aug 2024 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NgoLLMCJ"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A3F184540
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484503; cv=none; b=SBaNu+2Lk2/eiGkjU3KRCwr57wHtdCZ4EdUsGgOzTw+E8l6mE1G22MdKgUHxk/XfGmLX0kYz+DQlIafD2+dmFr7n0FbbgKPBRUJa17N3gzzC6/sSgBUKVrTcSIVfLf8T9oItZ498L2RrDFL5AUmMyE7+KQRLWmzGILJcbN4urSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484503; c=relaxed/simple;
	bh=8lMJZZMWj/hTmhImFRx4GYddF8BEY6S1juYvB/xrNhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WKCDfCKJjgLGLoR9/79YWf0ZXBL83xBMfRvxmbUWnOqiblVWhRE2aQAvuwxK4tmuqK+T4cJCdIh/H8ReVm1abJqRZ7sLHQoZQ119cdRFMHyCuYOLhdbBbB1okMDboDnTWcHS6pPErIoZkX6e3GJmT9mXCimBa5T545WEiNiwWvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NgoLLMCJ; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723484499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/4g5AstBf1dmI4SOaZ5hNLPO4RZC6PVnFvBCU45/bQ=;
	b=NgoLLMCJu8UDjzStpCiZNF7p/PAPHJayI6lqlKGrq+KH+0EJqAwfY5BzIRbR9r1xCTNZu7
	BHh/sRkwTxy+YEhmRnu28yWL+6QLQVZIDmVK4WO4DKqY8PDM1bk9zPclkqoVZhWWuOl06+
	xHax1XphmuhJYXpKTrJFoIycTiJsjn0=
From: Sean Anderson <sean.anderson@linux.dev>
To: Andrew Lunn <andrew@lunn.ch>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Eric Dumazet <edumazet@google.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next v2 1/2] net: xilinx: axienet: Report RxRject as rx_dropped
Date: Mon, 12 Aug 2024 13:41:17 -0400
Message-Id: <20240812174118.3560730-2-sean.anderson@linux.dev>
In-Reply-To: <20240812174118.3560730-1-sean.anderson@linux.dev>
References: <20240812174118.3560730-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The Receive Frame Rejected interrupt is asserted whenever there was a
receive error (bad FCS, bad length, etc.) or whenever the frame was
dropped due to a mismatched address. So this is really a combination of
rx_otherhost_dropped, rx_length_errors, rx_frame_errors, and
rx_crc_errors. Mismatched addresses are common and aren't really errors
at all (much like how fragments are normal on half-duplex links). To
avoid confusion, report these events as rx_dropped. This better
reflects what's going on: the packet was received by the MAC but dropped
before being processed.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

(no changes since v1)

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index ca04c298daa2..b2d7c396e2e3 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1296,7 +1296,7 @@ static irqreturn_t axienet_eth_irq(int irq, void *_ndev)
 		ndev->stats.rx_missed_errors++;
 
 	if (pending & XAE_INT_RXRJECT_MASK)
-		ndev->stats.rx_frame_errors++;
+		ndev->stats.rx_dropped++;
 
 	axienet_iow(lp, XAE_IS_OFFSET, pending);
 	return IRQ_HANDLED;
-- 
2.35.1.1320.gc452695387.dirty


