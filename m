Return-Path: <linux-kernel+bounces-442160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 228E09ED8CD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4203188D7B8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2551FF5F3;
	Wed, 11 Dec 2024 21:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="aCFUxvRA"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8D91F6671
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952790; cv=none; b=jnIAQfbO563BgYzgNWrYCGL4wfSBBP2bTrlCmbPiCtp+3MhlmUAclWwWC1u0n/NVw21rbRgj/Q6ZHtC071DBMT/xV3BLtZBMvddz/XHvPtDA9r41MdKfbAgQ62vpp2OzDa+JVAAlvsI/KPNYw7VvE0daOPcAUQegTFim+k5pIIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952790; c=relaxed/simple;
	bh=O2PiEBDcBIKDuyOucZR703m9WJ7hV/J3KuQVs7AIPws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I/wG5aJJrGoFF1Pc6RceTrF/1KeJhTDsG19E+6JoBEusnnSTUJ/VFe3k1ns8wd1J/V69/TiSGX4qtu1CSvNSTgxkpJgXIohZZsEe8PWMHG9OKh5ki4ELDdWbj12xfhMghAwaDSvKSf2AiQD5pNkSv7s+ADWK2D61QEYLy4MU4/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=aCFUxvRA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38632b8ae71so3578051f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733952786; x=1734557586; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VpFNlsdk4L7a7Jg4HLE3sRAx8nMjbcmqYIlMcjWLfOY=;
        b=aCFUxvRAzy8N6D/wd+xoYLyCFdEJ7JvQBMWpG6J1m+wFfqR0/I2llYvsQXZCPZ81J7
         OaEwm0n+gyU6SHn17qRsCEn81iEePcQ2wJs5C89nIqBUnCk7WGya1F5LJknmsxpMTwAA
         19228HNM6w2c1O6BAADPHqrCBnTNGvlnM+wkSHHk48KnU93Wh7C8nHadJ32Dvi7CDlSJ
         iye6eo+tU2Vsujjt2DKPr2Jqv9F/UXfDyxEWykaeKJl1bsnwM2m6EqU8Ccqsk5sTF4DO
         QKbLOgepCBq6xWpqgVYpZTE0+7a098DIdXm8OgV3akrwceBjUE3/kv/fW1WnYvwAIHEn
         Oskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952786; x=1734557586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpFNlsdk4L7a7Jg4HLE3sRAx8nMjbcmqYIlMcjWLfOY=;
        b=Yxdse+SVxnkvaaSAbRCF/AUwIfCplyvmKPw8HmXBnJTG4tfV+/n+iFBcAuhNM5KbWu
         KRHOR0rUstkVLfxD3MshoRHNAwS/xMLLFJGgD6pfxoobp1/ShsF52swdDEpRNzWexg62
         c8ddrdlFpkNZUhBdD/bIY5SSKHdAOCY1BBuQLZeF7ivdUiLr71XYrwBfHJ6EHeIZim12
         aK3pBswJhJG7gLgn8kfKJ0pFG8J0McJmwcx781SQce5lsn1gsmbUS+wFN/ht0VU7lDdu
         U2jWYRUfk4v4Nx2oGE9/gLx2P5f8UqhtnGIs3+8u8vjrsF6LfGgA3IviY66U1zZI3hs5
         t3zg==
X-Forwarded-Encrypted: i=1; AJvYcCUBZQ8rmN9m1OrZfHvZ70q4+uTpy46GBxcshhFJx1Wd4FD0JyBifBjwCcZ3CnIEKUSgEYUIXAe6yWL16AU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBEhnQHVkt9/LvV4RKnLRFxZ6aGKBj2A8+kITE0NFuJX30i/ZW
	rOT6ikBFpT18mv/hQOkLR36kk75mPpx4o/xVRf/qYqyw6LcJLYWNr7tO1xKUcCk=
X-Gm-Gg: ASbGncs4j2+JC9F6BoGUpOdw4+SpWkfk3ZuEvApLoX311seD0eNoDPaPGUiqDfxdZAu
	DcotsSZsOXCIFh+iBb5iCLPkIEGWK3V8BmAL8oM78plBmzrneylrNFORhc87cBQKFajl8fJHPuw
	Hwt++NMt4/V0xKhVllB+ZAQ9+DeXpcsS/RRQuim2196ihlJSbcRxGu09p5UsCl3y6N6UlvmvUdz
	M1HlVsLTxrOd1Xm7EbLIeyE6XmuwqVx/GOWzpZVE1Bk+Uw4Qo6f7wP5t0VDzaf3gQ==
X-Google-Smtp-Source: AGHT+IFlFuZgUs+vhEKzRPuk6A/Jy7BCV6OO8V3Fa04nde+pUW4PUDbMvkNqNjkFd7xU3mZtjrVcuw==
X-Received: by 2002:a05:6000:2b02:b0:385:ecdf:a30a with SMTP id ffacd0b85a97d-3864ce9fb55mr2642625f8f.33.1733952785570;
        Wed, 11 Dec 2024 13:33:05 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3115:252a:3e6f:da41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f5a0sm2136252f8f.13.2024.12.11.13.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 13:33:05 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 11 Dec 2024 22:15:20 +0100
Subject: [PATCH net-next v15 16/22] ovpn: add support for peer floating
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-b4-ovpn-v15-16-314e2cad0618@openvpn.net>
References: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
In-Reply-To: <20241211-b4-ovpn-v15-0-314e2cad0618@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10838; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=O2PiEBDcBIKDuyOucZR703m9WJ7hV/J3KuQVs7AIPws=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnWgUmEun+D6tE7IywQfvceIA5S498ucmHnWFvv
 UG0Ku46NsKJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1oFJgAKCRALcOU6oDjV
 h9qMB/wK7lMPovYxqQ8WDwmK+8OlNTQoz2U+BS7XfWvj21bn+GergLsRxct//updi9GgjEYSphz
 v+FZVm3nZ8vO1jL8cO2x5GZJfeB3bTPhPkPOmncWLZbVOMlSy6eyvrvBlMx4IfhCNW69jJAhql3
 JhwkhUKYrNoR/7lr8sPVeTPZoqyHzCJC7Mlasc+97GZ28jHcuoWEsOwy4omeY6vMCT7OxEF4oBb
 R3PBQsTSGfkVgGVqkYa7lkgSTyBf92GrKI4jyqSic1kKKDrKMknQlifYWkV8GcNT/3FomdJ8Z7G
 9+vv39HDlc+/OiYWUjWeckJW+wO7EG+9AV9hlxxy7M2flDQI
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

A peer connected via UDP may change its IP address without reconnecting
(float).

Add support for detecting and updating the new peer IP/port in case of
floating.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/bind.c |   9 +-
 drivers/net/ovpn/io.c   |   4 +
 drivers/net/ovpn/peer.c | 243 ++++++++++++++++++++++++++++++++++++------------
 drivers/net/ovpn/peer.h |   3 +-
 4 files changed, 193 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ovpn/bind.c b/drivers/net/ovpn/bind.c
index b4d2ccec2ceddf43bc445b489cc62a578ef0ad0a..c8ca340cca936a357409e9458807f27831511975 100644
--- a/drivers/net/ovpn/bind.c
+++ b/drivers/net/ovpn/bind.c
@@ -48,11 +48,8 @@ struct ovpn_bind *ovpn_bind_from_sockaddr(const struct sockaddr_storage *ss)
  */
 void ovpn_bind_reset(struct ovpn_peer *peer, struct ovpn_bind *new)
 {
-	struct ovpn_bind *old;
+	lockdep_assert_held(&peer->lock);
 
-	spin_lock_bh(&peer->lock);
-	old = rcu_replace_pointer(peer->bind, new, true);
-	spin_unlock_bh(&peer->lock);
-
-	kfree_rcu(old, rcu);
+	kfree_rcu(rcu_replace_pointer(peer->bind, new,
+				      lockdep_is_held(&peer->lock)), rcu);
 }
diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 0bab35fab06b4399c57e49732453df2fc12e9334..8162b12f7a36b897d685c70f1befd87d774826a1 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -134,6 +134,10 @@ void ovpn_decrypt_post(void *data, int ret)
 	/* keep track of last received authenticated packet for keepalive */
 	WRITE_ONCE(peer->last_recv, ktime_get_real_seconds());
 
+	if (peer->sock->sock->sk->sk_protocol == IPPROTO_UDP)
+		/* check if this peer changed local or remote endpoint */
+		ovpn_peer_endpoints_update(peer, skb);
+
 	/* point to encapsulated IP packet */
 	__skb_pull(skb, payload_offset);
 
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index bcc7ffdd7a02774999f96b50232d18bf9db72280..3a794750a226b4e1bd0b683d5910b03d250cfb47 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -107,6 +107,191 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_priv *ovpn, u32 id)
 	return peer;
 }
 
+/**
+ * ovpn_peer_reset_sockaddr - recreate binding for peer
+ * @peer: peer to recreate the binding for
+ * @ss: sockaddr to use as remote endpoint for the binding
+ * @local_ip: local IP for the binding
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+static int ovpn_peer_reset_sockaddr(struct ovpn_peer *peer,
+				    const struct sockaddr_storage *ss,
+				    const u8 *local_ip)
+{
+	struct ovpn_bind *bind;
+	size_t ip_len;
+
+	lockdep_assert_held(&peer->lock);
+
+	/* create new ovpn_bind object */
+	bind = ovpn_bind_from_sockaddr(ss);
+	if (IS_ERR(bind))
+		return PTR_ERR(bind);
+
+	if (local_ip) {
+		if (ss->ss_family == AF_INET) {
+			ip_len = sizeof(struct in_addr);
+		} else if (ss->ss_family == AF_INET6) {
+			ip_len = sizeof(struct in6_addr);
+		} else {
+			net_dbg_ratelimited("%s: invalid family %u for remote endpoint for peer %u\n",
+					    netdev_name(peer->ovpn->dev),
+					    ss->ss_family, peer->id);
+			kfree(bind);
+			return -EINVAL;
+		}
+
+		memcpy(&bind->local, local_ip, ip_len);
+	}
+
+	/* set binding */
+	ovpn_bind_reset(peer, bind);
+
+	return 0;
+}
+
+/* variable name __tbl2 needs to be different from __tbl1
+ * in the macro below to avoid confusing clang
+ */
+#define ovpn_get_hash_slot(_tbl, _key, _key_len) ({	\
+	typeof(_tbl) *__tbl2 = &(_tbl);			\
+	jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl2);	\
+})
+
+#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
+	typeof(_tbl) *__tbl1 = &(_tbl);				\
+	&(*__tbl1)[ovpn_get_hash_slot(*__tbl1, _key, _key_len)];\
+})
+
+/**
+ * ovpn_peer_endpoints_update - update remote or local endpoint for peer
+ * @peer: peer to update the remote endpoint for
+ * @skb: incoming packet to retrieve the source/destination address from
+ */
+void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
+{
+	struct hlist_nulls_head *nhead;
+	struct sockaddr_storage ss;
+	const u8 *local_ip = NULL;
+	struct sockaddr_in6 *sa6;
+	struct sockaddr_in *sa;
+	struct ovpn_bind *bind;
+	size_t salen = 0;
+
+	spin_lock_bh(&peer->lock);
+	bind = rcu_dereference_protected(peer->bind,
+					 lockdep_is_held(&peer->lock));
+	if (unlikely(!bind))
+		goto unlock;
+
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		/* float check */
+		if (unlikely(!ovpn_bind_skb_src_match(bind, skb))) {
+			if (bind->remote.in4.sin_family == AF_INET)
+				local_ip = (u8 *)&bind->local;
+			sa = (struct sockaddr_in *)&ss;
+			sa->sin_family = AF_INET;
+			sa->sin_addr.s_addr = ip_hdr(skb)->saddr;
+			sa->sin_port = udp_hdr(skb)->source;
+			salen = sizeof(*sa);
+			break;
+		}
+
+		/* local endpoint update */
+		if (unlikely(bind->local.ipv4.s_addr != ip_hdr(skb)->daddr)) {
+			net_dbg_ratelimited("%s: learning local IPv4 for peer %d (%pI4 -> %pI4)\n",
+					    netdev_name(peer->ovpn->dev),
+					    peer->id, &bind->local.ipv4.s_addr,
+					    &ip_hdr(skb)->daddr);
+			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
+		}
+		break;
+	case htons(ETH_P_IPV6):
+		/* float check */
+		if (unlikely(!ovpn_bind_skb_src_match(bind, skb))) {
+			if (bind->remote.in6.sin6_family == AF_INET6)
+				local_ip = (u8 *)&bind->local;
+			sa6 = (struct sockaddr_in6 *)&ss;
+			sa6->sin6_family = AF_INET6;
+			sa6->sin6_addr = ipv6_hdr(skb)->saddr;
+			sa6->sin6_port = udp_hdr(skb)->source;
+			sa6->sin6_scope_id = ipv6_iface_scope_id(&ipv6_hdr(skb)->saddr,
+								 skb->skb_iif);
+			salen = sizeof(*sa6);
+		}
+
+		/* local endpoint update */
+		if (unlikely(!ipv6_addr_equal(&bind->local.ipv6,
+					      &ipv6_hdr(skb)->daddr))) {
+			net_dbg_ratelimited("%s: learning local IPv6 for peer %d (%pI6c -> %pI6c\n",
+					    netdev_name(peer->ovpn->dev),
+					    peer->id, &bind->local.ipv6,
+					    &ipv6_hdr(skb)->daddr);
+			bind->local.ipv6 = ipv6_hdr(skb)->daddr;
+		}
+		break;
+	default:
+		goto unlock;
+	}
+
+	/* if the peer did not float, we can bail out now */
+	if (likely(!salen))
+		goto unlock;
+
+	if (unlikely(ovpn_peer_reset_sockaddr(peer,
+					      (struct sockaddr_storage *)&ss,
+					      local_ip) < 0))
+		goto unlock;
+
+	net_dbg_ratelimited("%s: peer %d floated to %pIScp",
+			    netdev_name(peer->ovpn->dev), peer->id, &ss);
+
+	spin_unlock_bh(&peer->lock);
+
+	/* rehashing is required only in MP mode as P2P has one peer
+	 * only and thus there is no hashtable
+	 */
+	if (peer->ovpn->mode == OVPN_MODE_MP) {
+		spin_lock_bh(&peer->ovpn->lock);
+		spin_lock_bh(&peer->lock);
+		bind = rcu_dereference_protected(peer->bind,
+						 lockdep_is_held(&peer->lock));
+		if (unlikely(!bind)) {
+			spin_unlock_bh(&peer->lock);
+			spin_unlock_bh(&peer->ovpn->lock);
+			return;
+		}
+
+		/* his function may be invoked concurrently, therefore another
+		 * float may have happened in parallel: perform rehashing
+		 * using the peer->bind->remote directly as key
+		 */
+
+		switch (bind->remote.in4.sin_family) {
+		case AF_INET:
+			salen = sizeof(*sa);
+			break;
+		case AF_INET6:
+			salen = sizeof(*sa6);
+			break;
+		}
+
+		/* remove old hashing */
+		hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
+		/* re-add with new transport address */
+		nhead = ovpn_get_hash_head(peer->ovpn->peers->by_transp_addr,
+					   &bind->remote, salen);
+		hlist_nulls_add_head_rcu(&peer->hash_entry_transp_addr, nhead);
+		spin_unlock_bh(&peer->lock);
+		spin_unlock_bh(&peer->ovpn->lock);
+	}
+	return;
+unlock:
+	spin_unlock_bh(&peer->lock);
+}
+
 /**
  * ovpn_peer_release_rcu - RCU callback performing last peer release steps
  * @head: RCU member of the ovpn_peer
@@ -210,19 +395,6 @@ static struct in6_addr ovpn_nexthop_from_skb6(struct sk_buff *skb)
 	return rt->rt6i_gateway;
 }
 
-/* variable name __tbl2 needs to be different from __tbl1
- * in the macro below to avoid confusing clang
- */
-#define ovpn_get_hash_slot(_tbl, _key, _key_len) ({	\
-	typeof(_tbl) *__tbl2 = &(_tbl);			\
-	jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl2);	\
-})
-
-#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
-	typeof(_tbl) *__tbl1 = &(_tbl);				\
-	&(*__tbl1)[ovpn_get_hash_slot(*__tbl1, _key, _key_len)];\
-})
-
 /**
  * ovpn_peer_get_by_vpn_addr4 - retrieve peer by its VPN IPv4 address
  * @ovpn: the openvpn instance to search
@@ -466,51 +638,6 @@ struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id)
 	return peer;
 }
 
-/**
- * ovpn_peer_update_local_endpoint - update local endpoint for peer
- * @peer: peer to update the endpoint for
- * @skb: incoming packet to retrieve the destination address (local) from
- */
-void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
-				     struct sk_buff *skb)
-{
-	struct ovpn_bind *bind;
-
-	rcu_read_lock();
-	bind = rcu_dereference(peer->bind);
-	if (unlikely(!bind))
-		goto unlock;
-
-	spin_lock_bh(&peer->lock);
-	switch (skb->protocol) {
-	case htons(ETH_P_IP):
-		if (unlikely(bind->local.ipv4.s_addr != ip_hdr(skb)->daddr)) {
-			net_dbg_ratelimited("%s: learning local IPv4 for peer %d (%pI4 -> %pI4)\n",
-					    netdev_name(peer->ovpn->dev),
-					    peer->id, &bind->local.ipv4.s_addr,
-					    &ip_hdr(skb)->daddr);
-			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
-		}
-		break;
-	case htons(ETH_P_IPV6):
-		if (unlikely(!ipv6_addr_equal(&bind->local.ipv6,
-					      &ipv6_hdr(skb)->daddr))) {
-			net_dbg_ratelimited("%s: learning local IPv6 for peer %d (%pI6c -> %pI6c\n",
-					    netdev_name(peer->ovpn->dev),
-					    peer->id, &bind->local.ipv6,
-					    &ipv6_hdr(skb)->daddr);
-			bind->local.ipv6 = ipv6_hdr(skb)->daddr;
-		}
-		break;
-	default:
-		break;
-	}
-	spin_unlock_bh(&peer->lock);
-
-unlock:
-	rcu_read_unlock();
-}
-
 /**
  * ovpn_peer_get_by_dst - Lookup peer to send skb to
  * @ovpn: the private data representing the current VPN session
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index d12fbced1252f84665b084f7a24b6d515bed833d..361068a0a40fd11cd4d3d347f83352ed3d46048e 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -153,7 +153,6 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 void ovpn_peer_keepalive_work(struct work_struct *work);
 
-void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
-				     struct sk_buff *skb);
+void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb);
 
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.45.2


