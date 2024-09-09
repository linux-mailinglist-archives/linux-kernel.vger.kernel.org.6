Return-Path: <linux-kernel+bounces-321745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1662971ED4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681B21F2481F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 16:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D685415F404;
	Mon,  9 Sep 2024 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T5/7VLwh"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB45139CFE
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898233; cv=none; b=fpJdBPOCpH+ikfhK4XHBvk62/MqB0/39IBvXgwEKxxP3DA8wBVsK4NNfR7OBiIIZuX2ApEvsEVFrcQ0ijOgpeMvjMWcoG/ePOOiZcyBA3uxZHzCeC2GHCLLkWw5LfIhzV9BOR3eQMXdbleNYIV84UFI9WhGXylyHMvboi06VhLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898233; c=relaxed/simple;
	bh=2Kjk0w21kcQXy0DYQRZx0fZyS85YzXT+9u2Q3jHgQy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uve0iUKQ3H4OY8MXiOICAyLFSurotRIdFCqsDAAsjZpsLK06oo5FOvu3BnderrvEkweqxzOHRNilMU+BvvXAyYXjh4lMHWh+V2ghLgwj69kHbKUfGNfQvS42v0KbnJLVIgiOivIxG0+h7wvYmWXSNyOED/t/9cSkxtfTuNAEEPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T5/7VLwh; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725898229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYLjaJjab8lWILZwaUDKtxHDlmqX2R9MWPau9VCILks=;
	b=T5/7VLwhGGEvLhNjsfyIe+LzHATEMF010ZU8OMtFrSM2z6VgninQV+HPMNdauzWTsk4jUw
	qxWNEs3FZK4I8mkDV7pYmGdnmyC9b5YaAyubV/f4PvnyR1zySgs2ULqnAJ0W2TOZFBV89A
	4SXKZnNml7VJZTYNvWxV4Lnyk46GTPw=
From: Sean Anderson <sean.anderson@linux.dev>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 4/4] net: xilinx: axienet: Relax partial rx checksum checks
Date: Mon,  9 Sep 2024 12:10:16 -0400
Message-Id: <20240909161016.1149119-5-sean.anderson@linux.dev>
In-Reply-To: <20240909161016.1149119-1-sean.anderson@linux.dev>
References: <20240909161016.1149119-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The partial rx checksum feature computes a checksum over the entire
packet, regardless of the L3 protocol. Remove the check for IPv4.
Additionally, testing with csum.py (from kselftests) shows no anomalies
with 64-byte packets, so we can remove that check as well.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: Simon Horman <horms@kernel.org>
---
Testing was performed with csum.py between two axienet netdevs. I also tested
with a macb netdev, but I saw some errors due to 007e4ba3ee13 ("net: macb:
initialize checksum when using checksum offloading"). I also tested
manually with a dpaa netdev, but I wasn't set up for ssh.

Changes in v2:
- Expand commit message with testing methodology

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 2f7ab0922aed..4185c5708742 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1188,9 +1188,7 @@ static int axienet_rx_poll(struct napi_struct *napi, int budget)
 				    csumstatus == XAE_IP_UDP_CSUM_VALIDATED) {
 					skb->ip_summed = CHECKSUM_UNNECESSARY;
 				}
-			} else if ((lp->features & XAE_FEATURE_PARTIAL_RX_CSUM) != 0 &&
-				   skb->protocol == htons(ETH_P_IP) &&
-				   skb->len > 64) {
+			} else if (lp->features & XAE_FEATURE_PARTIAL_RX_CSUM) {
 				skb->csum = be32_to_cpu(cur_p->app3 & 0xFFFF);
 				skb->ip_summed = CHECKSUM_COMPLETE;
 			}
-- 
2.35.1.1320.gc452695387.dirty


