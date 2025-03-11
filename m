Return-Path: <linux-kernel+bounces-556037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B99A5C01F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EECF3A67E5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A9C25B673;
	Tue, 11 Mar 2025 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="TIps7KPF"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C43258CC6
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694605; cv=none; b=rFgneDB0UVTZWczPJ1PKfJwJ0NC+M/AAYmoTqQvV/+HLZRFawBgdtz0uuX+CkhalhGnl95KbzogQ5p9xS3EIAxObE12OT/a/NtAXTRE3hoom0rFyEcs6acaRObQPqtT+xJmVTImS1NsR1WkuO6xBX1CNEFj3CVnXtTOk0vg6GsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694605; c=relaxed/simple;
	bh=5HPzQZvV5JcvSg9f7vwh47fGnzGV91YQ/AAjQQn9Drc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u+owYjG507U1ovJrRFS9tUeK6dj1IalYS0Xi+i9wR1L4QNS3pvKVUCtD8DBPsRWx6pEdk4jKRaY0JZ51vcFSAPu0vB5TyQD4y4yeLpLXfBY5gWrBUeleV374nDbre/sRxpsCrYOPk6SYFeZzxu0FUOwbpN6z47C59fiAMieDZpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=TIps7KPF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso21659235e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741694596; x=1742299396; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=npUZ9JtgGx8bTHXFFtV6RG3s4/J70+07GRwQPQ7xba4=;
        b=TIps7KPFe8/ZqOf3USugwjFABQcgsDnqQPeTcIEedIgiHnvXyRyZuG1JykC2sDj91L
         XdQgdp/57JOBYnujgZriVBoLzPwHoOBMZ2y4yRPXYlnErSH3qTIUYKZe2qDY8hnc+/JB
         wZob1CMKoxYzmuazvDURN4BYeuQaCeQTD+LAAc9ot8sG3Pn518NNxLhu5Z6uE23FgHqZ
         w6tz7oFT0yfBR9GrQjx8lpMR2lUVALvZisw1wVUgKo7QA0jRViDGbFMA59J55O/7AQV/
         3O3B9D+2PWK6PsilsNqY/E+7eUH0WF7iyd4N0fgtqqnf/e8zX61/M38NJF4wPG2lWVuo
         NnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741694596; x=1742299396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npUZ9JtgGx8bTHXFFtV6RG3s4/J70+07GRwQPQ7xba4=;
        b=EiZeHn3+a0DnPKovyaijb9vqWCGf/DcJG1uH4JBvUQvah+CpKxj4HvZp+zg/fVIC4Y
         Mj2F7tfo3MqkgYZ2wTdFJV3joJc/SMeICWwbcTtfEMs4X7jrJ6jm/A9H6EtMY2og3QSe
         eewbWjD+q2NWu4mnZwWB9waAz3Q7gBt2E+tHJI/xtzrYRCbIQ83QfcErTwwIFUPXl8Vr
         Azo7slKr14UcR8ALWy4dV+fgLSwfL5NQlY+lFejQmF2ReP+DNqtjI/jTuuns+nt78tFP
         uRVMTN+vEEHZtq0m8hlhu7KO4rGeXk0ccFTSgkuiDSEkewXFSjnVBL+TOhxg04Yh66Lf
         f+yA==
X-Forwarded-Encrypted: i=1; AJvYcCWI5sc3v6su8Ywesus+CQxghHiOFIdvKcfazyi18WBfFoacI1aQ7jXPrqCAqCzf1/YvOndNOWTRxrL8mns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/R6yZcZF0qennl8rh3NAM+JEaOQKRIxX+SVwyJEdU/xp3/AyZ
	1sFD0dgFpyLQrQqDdl5nM6iKaBk1rHyHjqDyqMsXmEjyMIYovxHi4yJCf4eXUE33GQoMxDeBYXr
	K
X-Gm-Gg: ASbGncviKGU6RrR0L5jak6PfsX2TJAkEZM6lLCmDU77NYSrEkHxk4l+aXoinfeTN+JS
	nDT2DvGg1/wJb049BOM1bhik57gqgQ8PLlXHsM2vMMWPZZ5WAUIuZgUtViiVj8zU4xTkfMiqdlz
	I/soWuO/bTs3WITwFz3ewCWE3yCGmG3C72AErjY4y5DKlTu1jP9A0eZspsPcMxvkAOIGUtl14Cb
	WbtxEOMU4En31vxCL0zUNUOoHGtnxX/G56RFxds9e2uplit5NeBqLWC9N0vLGKnGBypu+X3zHBz
	Zsj2ntFo8lH/mBYNttJ/EBhwtMne0rAkUITFQNRn6g==
X-Google-Smtp-Source: AGHT+IEYNVQVLeGA/fESQOfQLNOjRTH/TtMCgQ5ffODrdnZdyKB0ypvvgFtXRgze1u5boxYID59FLQ==
X-Received: by 2002:a05:600c:4f90:b0:43d:fa:1f9a with SMTP id 5b1f17b1804b1-43d01c22acfmr50333395e9.30.1741694595863;
        Tue, 11 Mar 2025 05:03:15 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:52de:66e8:f2da:9714])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceafc09d5sm110537605e9.31.2025.03.11.05.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:03:15 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Mar 2025 13:02:11 +0100
Subject: [PATCH net-next v22 10/23] ovpn: store tunnel and transport
 statistics
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-b4-ovpn-v22-10-2b7b02155412@openvpn.net>
References: <20250311-b4-ovpn-v22-0-2b7b02155412@openvpn.net>
In-Reply-To: <20250311-b4-ovpn-v22-0-2b7b02155412@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7109; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=5HPzQZvV5JcvSg9f7vwh47fGnzGV91YQ/AAjQQn9Drc=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn0CZwQ9mu5L+3PePYS0HL5ZOKzXv91vXoNojeg
 pny12n2nMGJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9AmcAAKCRALcOU6oDjV
 h0FgB/91e3revd4WHza9unkBqlMXOTD7TMA8wgmMHwreyCP9XI7CnWAOWvNEysg/HdcP28e5Tzo
 GT9f+iVQSvAFJ+CQvUm6s0p6Pf8K6fvn1Q4nQu4jt2pEPPTMhNTYLicnVTrYoYaHw03F+V/5yx6
 j6x1WydShVSGRIGksNhl/JsXrRucAnxdvIWfVTZ7gg8PcjbqbuMT0a+PPodMmXvqfLtmW+fGN66
 bPVZTzNqhYAsh6A64C7uesu7ziBiVWb1kiRhYi2Z1tzBYCKKeOUd+vvqcKRGlR8ipSy8OcG0qX6
 CEJ6UFAnvQFt30h783cCbwCBznFbmzvjGgZYNfsszkAU6w0+
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
index 38c9fdca0e2e8e4af3c369ceb3971b58ab52d77b..04c3345807c5d759daf65cc80a290f784dbf5588 100644
--- a/drivers/net/ovpn/Makefile
+++ b/drivers/net/ovpn/Makefile
@@ -17,4 +17,5 @@ ovpn-y += netlink-gen.o
 ovpn-y += peer.o
 ovpn-y += pktid.o
 ovpn-y += socket.o
+ovpn-y += stats.o
 ovpn-y += udp.o
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index d0b410535ac340a53f010d0b2f20430b26bb012d..50dc2e4c03f01b02bdf616473b755b6e1e6b57f7 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -12,6 +12,7 @@
 #include <linux/skbuff.h>
 #include <net/gro_cells.h>
 #include <net/gso.h>
+#include <net/ip.h>
 
 #include "ovpnpriv.h"
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
@@ -158,6 +161,8 @@ void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
 	struct ovpn_crypto_key_slot *ks;
 	u8 key_id;
 
+	ovpn_peer_stats_increment_rx(&peer->link_stats, skb->len);
+
 	/* get the key slot matching the key ID in the received packet */
 	key_id = ovpn_key_id_from_skb(skb);
 	ks = ovpn_crypto_key_id_to_slot(&peer->crypto, key_id);
@@ -181,6 +186,7 @@ void ovpn_encrypt_post(void *data, int ret)
 	struct sk_buff *skb = data;
 	struct ovpn_socket *sock;
 	struct ovpn_peer *peer;
+	unsigned int orig_len;
 
 	/* encryption is happening asynchronously. This function will be
 	 * called later by the crypto callback with a proper return value
@@ -206,6 +212,7 @@ void ovpn_encrypt_post(void *data, int ret)
 		goto err;
 
 	skb_mark_not_on_list(skb);
+	orig_len = skb->len;
 
 	rcu_read_lock();
 	sock = rcu_dereference(peer->sock);
@@ -220,6 +227,8 @@ void ovpn_encrypt_post(void *data, int ret)
 		/* no transport configured yet */
 		goto err_unlock;
 	}
+
+	ovpn_peer_stats_increment_tx(&peer->link_stats, orig_len);
 	/* skb passed down the stack - don't free it */
 	skb = NULL;
 err_unlock:
@@ -341,6 +350,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto drop;
 	}
 
+	ovpn_peer_stats_increment_tx(&peer->vpn_stats, skb->len);
 	ovpn_send(ovpn, skb_list.next, peer);
 
 	return NETDEV_TX_OK;
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 23eaab1b465b8b88a84cf9f1039621923b640b47..0fe5333c6b8104913526dacc4d7d2260b97f62aa 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -61,6 +61,8 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	ovpn_crypto_state_init(&peer->crypto);
 	spin_lock_init(&peer->lock);
 	kref_init(&peer->refcount);
+	ovpn_peer_stats_init(&peer->vpn_stats);
+	ovpn_peer_stats_init(&peer->link_stats);
 
 	ret = dst_cache_init(&peer->dst_cache, GFP_KERNEL);
 	if (ret < 0) {
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index a9113a969f94d66fa17208d563d0bbd255c23fa9..2453d39ce327c6d174cfb35fe5430865b32c2efe 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -14,6 +14,7 @@
 
 #include "crypto.h"
 #include "socket.h"
+#include "stats.h"
 
 /**
  * struct ovpn_peer - the main remote peer object
@@ -27,6 +28,8 @@
  * @crypto: the crypto configuration (ciphers, keys, etc..)
  * @dst_cache: cache for dst_entry used to send to peer
  * @bind: remote peer binding
+ * @vpn_stats: per-peer in-VPN TX/RX stats
+ * @link_stats: per-peer link/transport TX/RX stats
  * @delete_reason: why peer was deleted (i.e. timeout, transport error, ..)
  * @lock: protects binding to peer (bind)
  * @refcount: reference counter
@@ -45,6 +48,8 @@ struct ovpn_peer {
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
index 0000000000000000000000000000000000000000..d637143473bb913647c79832fd9eb3ebfd9efb59
--- /dev/null
+++ b/drivers/net/ovpn/stats.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2025 OpenVPN, Inc.
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
index 0000000000000000000000000000000000000000..53433d8b6c33160845de2ae1ca38e85cf31950b7
--- /dev/null
+++ b/drivers/net/ovpn/stats.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*  OpenVPN data channel offload
+ *
+ *  Copyright (C) 2020-2025 OpenVPN, Inc.
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
2.48.1


