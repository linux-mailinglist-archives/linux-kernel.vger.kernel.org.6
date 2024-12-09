Return-Path: <linux-kernel+bounces-437013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E21C9E8DF9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23508281B5A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B88217F45;
	Mon,  9 Dec 2024 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="acf26DuS"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0897217650
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734395; cv=none; b=AdhmgnEnblwMnx35uOERjGrhSNrg042oAjZ+rZW5nqeJ6GMJBXNf4Y6GKa6bawZB33DDf/1x/eVTegfcGYEzcnOFcpXdqIvpPaCTjbSvr/y1dv6XSPW24jUQTyzP1sGYoNlr6kAqUVWdLWj+gxS0nVUZm6dHduag+mBfM6KFWAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734395; c=relaxed/simple;
	bh=Tcmis1yXyG1Git2X+8o1kprRdEHNd8dKBzBagujoje0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BEZoCoTiFjVIpFwKJiaBj3Di89EiBvdpMHnfBIRJvFfzIZ8+o9NuahCO0plEHG+LKOkS4SWf8HJLcmd+vD0MVRRiygEHUmjl1R1EkGodx/psL1nUFZP5j01g0LDdZnpiJ22o2nIodZlKvQxNZkZVpZGN40EVvfp7GZ0LkjoQHqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=acf26DuS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434ab938e37so26020695e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 00:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733734391; x=1734339191; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ClGXX4576d+FS4AfSrsTJoO8ACeKpgP1Aq3SHCHN4ug=;
        b=acf26DuSRNCRUndJDJq6goiAFydxdZpdmpmf0gTHd66pmlrGG4zV9bBg/ERqV+a16T
         4tpt3VpDM8QKt0jmSmaqDjsFjYeM0ZM4JPvbUAZ3ttQX+HHMr+kIEEkExGO3BPPgLqIB
         Mb10kOOCAkl0aQklaCuCdfxnkxgZbYnz/ASJmbz7dCKZXdHnIpKlbCOPOaS+B9BAfLma
         P5t1P+GMcn5B1OrdAX4x+HL21Jb91iyxyvlwsTC1O0nuh6SzLsemfmCmkW4ERxj1sKU8
         z279xxTWRsNtQ65v1uQb/a8a6Vge5Onz1Dp80K1xH7RTTAJG4v9EaES4xTYxZ0dMWlbE
         jw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734391; x=1734339191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClGXX4576d+FS4AfSrsTJoO8ACeKpgP1Aq3SHCHN4ug=;
        b=tZx0COdk+f1cdmGY1mw1o48PjameEWxEoEhMXq2NP5x+qx4a0qP4gZFoDrzEK3G75i
         HxWhkKXiO/RULp0rtWnWdLm8fI1mCnQYoNI784fXfVbp8Rdqfs1BvMfW6thByEXCkh7v
         WdBcJdkRpualj4XdcylQ0VA2R/jzXwaF8E6xVZH8GCCa+VL3swAUVlPk+E226JmfLA/l
         ctVzn5f4xlpk1KTeit+wQk1iRBGmt+Ew8GF/qeBpPoe4+GrVgRbZAwD1RD4fpR9UMtMr
         AO3h5amwgYzJkWhz701qr3WkvWDhAFTE0IifuCCjduK68AkP3yYmH6imLrKtNKATjjqR
         +Q5w==
X-Forwarded-Encrypted: i=1; AJvYcCXvRP+P2V0FRju4oOSsaPTk2SCp6XbC/wZmXehwhYPaM04HIKv1dM+I7lBrURfc+0+mArReCa5FZ3Hp7qA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4yXJfIFhfw3+PHgL1y8Gp/q7yy0E6qbS6I0phckAzvQvnDxPn
	GRI3uAK9UZEy//mF6WLKf8dl7a/LpZJD0g+RoSnl+ThkRey6KK0wzgpunKc2sU0=
X-Gm-Gg: ASbGncswEJ+El5/vgYbb2sYRtju31LJTcLQN/UgHaR9e6MC1PRksJVuTkdRu2/5KRns
	Sy4Kfxpeqp9V8BjGVav5b0twlIcTOuZt+xFHhSOioy9dq5zFEPkHR94BxjbfvTRfaLePrm0fz61
	q8/HxAQ8HZZK4loyTL7Mn8FC03cEIX0kSQTlq8nqZG2p6DJC8jnxsh6VsTFrrdgmBTSd2cQPD7R
	Cz7gz4pvbMZpeLz4qKb1iGYaw+VF5x80vi6jeQ2O4LLpS6ImPrfGvrGbbRf
X-Google-Smtp-Source: AGHT+IFNszXAW/k/Lr9q2ftpoNdZN7HdZCqbO3kVOV7vBuiyfXkX7GPltu9A0w5MzzYodvxUg82UUQ==
X-Received: by 2002:a5d:6da5:0:b0:385:f9db:3c4b with SMTP id ffacd0b85a97d-3862b33efa4mr7443941f8f.10.1733734390997;
        Mon, 09 Dec 2024 00:53:10 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:c60f:6f50:7258:1f7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbea8sm12439844f8f.97.2024.12.09.00.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 00:53:10 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 09 Dec 2024 09:53:19 +0100
Subject: [PATCH net-next v14 10/22] ovpn: store tunnel and transport
 statistics
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-b4-ovpn-v14-10-ea243cf16417@openvpn.net>
References: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
In-Reply-To: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7121; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=Tcmis1yXyG1Git2X+8o1kprRdEHNd8dKBzBagujoje0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnVrATuf7EU2k9yKqmRJyPVyqakXNvevKMqDEZh
 0IklMIgCgqJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1awEwAKCRALcOU6oDjV
 hygNB/9NsXTnx1IWjMmP6yx8ITmYhoXEEQu875gBO5Ciog3pUo267EPPTJcrNa1ICTBsRUhbTrV
 8lqohoB/JGNen9qe+NZKyLQiMOSkI/Krk+zkbHc0O2s1gTHjEF2wdBef+Iu4Bg/swyL2ZiTO7ET
 Vt5sIGhWhTCK4ohifKNXB1S9s3ZNxnDJht19I9dgCsFGScoSCAthqeQlj8EYvdCIn6sAQTqbOZ3
 ZoGhbFHr6BfhsLlvr2SquaKpabgO7Rk98o++Tk4eE9YxhlseqIpsHnl2Su1++nK14A/sGOD/it/
 rpBuGK2Z0gNm2i8cqwOvDYRw9ah584MkG2n2y7BDc0siX77f
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Byte/packet counters for in-tunnel and transport streams
are now initialized and updated as needed.

To be exported via netlink.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/Makefile |  1 +
 drivers/net/ovpn/io.c     | 12 +++++++++++-
 drivers/net/ovpn/peer.c   |  2 ++
 drivers/net/ovpn/peer.h   |  5 +++++
 drivers/net/ovpn/stats.c  | 21 +++++++++++++++++++++
 drivers/net/ovpn/stats.h  | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/Makefile b/drivers/net/ovpn/Makefile
index ccdaeced1982c851475657860a005ff2b9dfbd13..d43fda72646bdc7644d9a878b56da0a0e5680c98 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -17,4 +17,5 @@ ovpn-y += netlink-gen.o
 ovpn-y += peer.o
 ovpn-y += pktid.o
 ovpn-y += socket.o
+ovpn-y += stats.o
 ovpn-y += udp.o
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index a6db02f712203430942e3908480026f4dbac673a..8414dbd24467d77a5122daa9c3c745aa5e258c98 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -12,6 +12,7 @@
 #include <linux/skbuff.h>
 #include <net/gro_cells.h>
 #include <net/gso.h>
+#include <net/ip.h>
 
 #include "ovpnstruct.h"
 #include "peer.h"
@@ -55,9 +56,11 @@ static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
 	/* cause packet to be "received" by the interface */
 	pkt_len = skb->len;
 	ret = gro_cells_receive(&peer->ovpn->gro_cells, skb);
-	if (likely(ret == NET_RX_SUCCESS))
+	if (likely(ret == NET_RX_SUCCESS)) {
 		/* update RX stats with the size of decrypted packet */
+		ovpn_peer_stats_increment_rx(&peer->vpn_stats, pkt_len);
 		dev_sw_netstats_rx_add(peer->ovpn->dev, pkt_len);
+	}
 }
 
 void ovpn_decrypt_post(void *data, int ret)
@@ -155,6 +158,8 @@ void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 	struct ovpn_crypto_key_slot *ks;
 	u8 key_id;
 
+	ovpn_peer_stats_increment_rx(&peer->link_stats, skb->len);
+
 	/* get the key slot matching the key ID in the received packet */
 	key_id = ovpn_key_id_from_skb(skb);
 	ks = ovpn_crypto_key_id_to_slot(&peer->crypto, key_id);
@@ -176,6 +181,7 @@ void ovpn_encrypt_post(void *data, int ret)
 	struct ovpn_crypto_key_slot *ks;
 	struct sk_buff *skb = data;
 	struct ovpn_peer *peer;
+	unsigned int orig_len;
 
 	/* encryption is happening asynchronously. This function will be
 	 * called later by the crypto callback with a proper return value
@@ -198,6 +204,7 @@ void ovpn_encrypt_post(void *data, int ret)
 		goto err;
 
 	skb_mark_not_on_list(skb);
+	orig_len = skb->len;
 
 	switch (peer->sock->sock->sk->sk_protocol) {
 	case IPPROTO_UDP:
@@ -207,6 +214,8 @@ void ovpn_encrypt_post(void *data, int ret)
 		/* no transport configured yet */
 		goto err;
 	}
+
+	ovpn_peer_stats_increment_tx(&peer->link_stats, orig_len);
 	/* skb passed down the stack - don't free it */
 	skb = NULL;
 err:
@@ -325,6 +334,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto drop;
 	}
 
+	ovpn_peer_stats_increment_tx(&peer->vpn_stats, skb->len);
 	ovpn_send(ovpn, skb_list.next, peer);
 
 	return NETDEV_TX_OK;
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 456fd70ccd2a7e37f0ad1732ca9f5a07f2f54a97..0d625f065255c4947a18ae475b04c27f0cf6bb32 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -47,6 +47,8 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	ovpn_crypto_state_init(&peer->crypto);
 	spin_lock_init(&peer->lock);
 	kref_init(&peer->refcount);
+	ovpn_peer_stats_init(&peer->vpn_stats);
+	ovpn_peer_stats_init(&peer->link_stats);
 
 	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
 	if (ret < 0) {
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 1b427870df2cf972e0f572e046452378358f245a..61c54fb864d990ff3d746f18c9a06d4c950bd1ac 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -13,6 +13,7 @@
 #include <net/dst_cache.h>
 
 #include "crypto.h"
+#include "stats.h"
 
 /**
  * struct ovpn_peer - the main remote peer object
@@ -25,6 +26,8 @@
  * @crypto: the crypto configuration (ciphers, keys, etc..)
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
+ * @vpn_stats: per-peer in-VPN TX/RX stays
+ * @link_stats: per-peer link/transport TX/RX stats
  * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
  * @lock: protects binding to peer (bind)
  * @refcount: reference counter
@@ -42,6 +45,8 @@ struct ovpn_peer {
 	struct ovpn_crypto_state crypto;
 	struct dst_cache dst_cache;
 	struct ovpn_bind __rcu *bind;
+	struct ovpn_peer_stats vpn_stats;
+	struct ovpn_peer_stats link_stats;
 	enum ovpn_del_peer_reason delete_reason;
 	spinlock_t lock; /* protects bind */
 	struct kref refcount;
diff --git a/drivers/net/ovpn/stats.c b/drivers/net/ovpn/stats.c
new file mode 100644
index 0000000000000000000000000000000000000000..a383842c3449b73694c318837b0b92eb9afaec22
--- /dev/null
+++ b/drivers/net/ovpn/stats.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ */
+
+#include <linux/atomic.h>
+
+#include "stats.h"
+
+void ovpn_peer_stats_init(struct ovpn_peer_stats *ps)
+{
+	atomic64_set(&ps->rx.bytes, 0);
+	atomic64_set(&ps->rx.packets, 0);
+
+	atomic64_set(&ps->tx.bytes, 0);
+	atomic64_set(&ps->tx.packets, 0);
+}
diff --git a/drivers/net/ovpn/stats.h b/drivers/net/ovpn/stats.h
new file mode 100644
index 0000000000000000000000000000000000000000..868f49d25eaa8fef04a02a61c363d95f9c9ef80a
--- /dev/null
+++ b/drivers/net/ovpn/stats.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2024 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@openvpn.net>
+ *		Antonio Quartulli <antonio@openvpn.net>
+ *		Lev Stipakov <lev@openvpn.net>
+ */
+
+#ifndef _NET_OVPN_OVPNSTATS_H_
+#define _NET_OVPN_OVPNSTATS_H_
+
+/* one stat */
+struct ovpn_peer_stat {
+	atomic64_t bytes;
+	atomic64_t packets;
+};
+
+/* rx and tx stats combined */
+struct ovpn_peer_stats {
+	struct ovpn_peer_stat rx;
+	struct ovpn_peer_stat tx;
+};
+
+void ovpn_peer_stats_init(struct ovpn_peer_stats *ps);
+
+static inline void ovpn_peer_stats_increment(struct ovpn_peer_stat *stat,
+					     const unsigned int n)
+{
+	atomic64_add(n, &stat->bytes);
+	atomic64_inc(&stat->packets);
+}
+
+static inline void ovpn_peer_stats_increment_rx(struct ovpn_peer_stats *stats,
+						const unsigned int n)
+{
+	ovpn_peer_stats_increment(&stats->rx, n);
+}
+
+static inline void ovpn_peer_stats_increment_tx(struct ovpn_peer_stats *stats,
+						const unsigned int n)
+{
+	ovpn_peer_stats_increment(&stats->tx, n);
+}
+
+#endif /* _NET_OVPN_OVPNSTATS_H_ */

-- 
2.45.2


