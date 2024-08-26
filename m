Return-Path: <linux-kernel+bounces-301341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E929E95EF45
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5FC8280E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29505153836;
	Mon, 26 Aug 2024 11:01:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D85B13BACE
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 11:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724670097; cv=none; b=EPZcMPiT8rJSdTYucPLKpcENatWrYMkKmyOiIcLmynWNiH0V4lCaxdYxVsS6IROVY9Hv/X8Ctq4n8XnT0u2eWGb+2tX60gjFDx+PGhG50kO9stBuJgiBavmIummP9rrfLiwwEdV0dSmVqvxEeqbGXbX+XOILbRGWj0fb9Eu3zbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724670097; c=relaxed/simple;
	bh=HyycuP4cCUQMchC02lkM7JaPCrNPz+2fYPV91IEocmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nFfPEx37nhdVXiQ6CaKdB7rHYZjwz1Nq+OQm3vj14S6fdS1vpVIiv0mNWO1bCK0Sl4at6BaEm9ntNs9DxA0xkFyjmbg0Z1pl+524CZ0k9jV8eIJZaiTNcWn/0c2IEyi3NzbGFUfwTn/utzWRVFxvjjJSoB4hVaQmV5z94vSO1do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXTY-00047S-JG; Mon, 26 Aug 2024 13:01:32 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXTX-003Ae2-Un; Mon, 26 Aug 2024 13:01:31 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXTX-004aRi-2q;
	Mon, 26 Aug 2024 13:01:31 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 26 Aug 2024 13:01:22 +0200
Subject: [PATCH 01/12] wifi: mwifiex: add missing locking
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-mwifiex-cleanup-1-v1-1-56e6f8e056ec@pengutronix.de>
References: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
In-Reply-To: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724670091; l=1539;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=HyycuP4cCUQMchC02lkM7JaPCrNPz+2fYPV91IEocmk=;
 b=s5oQ7tVj6Okio0v1uYOKT/F0TTjgAKwB13aHx3KG+ER0YFWWL25F8oo90iMJELikgj4HAqTyv
 XlJDPH0hbKVCupMCw6iq1mNlICJ4r7Wfw+nyEuMaPA89mfN0j82vYHQ
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

cfg80211_rx_assoc_resp() and cfg80211_rx_mlme_mgmt() need to be called
with the wiphy locked, so lock it before calling these functions.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c | 2 ++
 drivers/net/wireless/marvell/mwifiex/util.c   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 7894102f03eb0..cdfb307e75131 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -938,8 +938,10 @@ void mwifiex_process_assoc_resp(struct mwifiex_adapter *adapter)
 		assoc_resp.links[0].bss = priv->req_bss;
 		assoc_resp.buf = priv->assoc_rsp_buf;
 		assoc_resp.len = priv->assoc_rsp_size;
+		wiphy_lock(priv->wdev.wiphy);
 		cfg80211_rx_assoc_resp(priv->netdev,
 				       &assoc_resp);
+		wiphy_unlock(priv->wdev.wiphy);
 		priv->assoc_rsp_size = 0;
 	}
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 42c04bf858da3..1f1f6280a0f25 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -494,7 +494,9 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 			}
 		}
 
+		wiphy_lock(priv->wdev.wiphy);
 		cfg80211_rx_mlme_mgmt(priv->netdev, skb->data, pkt_len);
+		wiphy_unlock(priv->wdev.wiphy);
 	}
 
 	if (priv->adapter->host_mlme_enabled &&

-- 
2.39.2


