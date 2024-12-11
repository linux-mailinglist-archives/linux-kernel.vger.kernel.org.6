Return-Path: <linux-kernel+bounces-442159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC219ED8C7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70FE3188D434
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232111FD797;
	Wed, 11 Dec 2024 21:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="LVt9WpHb"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B681F63E0
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952789; cv=none; b=JrUX85Dll3+XEAK+2jiiSzMOM4SCKrB9g78JAyaHiii71ZkW4pVyj+waY8H6VAD5yUmFOnLlFcUsRJjBmTtfcYozQfa0Xu3i1/Rhh74sz4H0GN3rE/lXhhqBKHbhL8GRDzFdVz8JA7eH6mNXB+Li56NhD12gsgDYBa64+oNU19Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952789; c=relaxed/simple;
	bh=cfVVFW1YSk9Sp4rozyN1I0rQt8bnuFN11hRcZBHCzX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MqKBJ96bp9mGYcHJj2ktsskGLjU1y+vJg/kwLMtFvZJKCBNWbOHSc4uwzy2shg9/69Yf1r7mnwKAP56uXVazGEIzlR7rKCNXkpV8juLSDfnp1osFXhcEyzQQ5HDxjKila7Z44kkHGzSBC4jln03q3ATJ4vytnVcYmXB8k64pa+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=LVt9WpHb; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38634c35129so3590852f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733952784; x=1734557584; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Mca/LyJAWUP5fMD4RwhCraHPvEdCNF6yEEWN1Lkh4c=;
        b=LVt9WpHb2eJTPGaZhjHqR5QFoSN07z3wWnc0UP2tHMC9XrmBwM9HNGU1UcBo0/kJi5
         IyAgE6xO0FP/tMY+IRy77JPiLo1tR4qlYXbRdHa1PXAqaSzHx8WKg6KAEPASS9RWsgQW
         YMrKWStPjKXAhJTuGlx7jHM7VbxYqKDykNs2x2qdluOSLVgYYvEiXWrK1JELndtDwbbY
         7ITu82JiZLXt6/uEy4s+92GyOEW5xsLZVuuL0rmKawMThLOY7N6XAU70eYMchOUTExgD
         3+eJSpUrhdJkXfhvcgD9K/uDC2ufNAB1edJnzsKoEQ2qOfbMmQqZ0mRR4AV3Ol/RgAHS
         c5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952784; x=1734557584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Mca/LyJAWUP5fMD4RwhCraHPvEdCNF6yEEWN1Lkh4c=;
        b=jgTsTvIjflgcZEpoA2wQZLJHk1RxSxwC++kBapd6L867tt2bZZLTAvWtjGHd21Wbox
         omDcNJr0B8KC1UO6JCzF25q1SClfyiRTJFO9xmXKLS068GMi6YuY/QcuuMUY56Mi/7k/
         H+2S6tZOzv6Pys0ehCKVbyV+aAUcOU0v9Z0XCj9PUL+Zpvr3/jUeUW65JlWqHfVoXP8C
         txPNiw36Y6Bo7o5hLnWfPBoAvPCwvdXl+DfcKfVd48nGngE4YM86akIcu9YeFrS4LMji
         pMGyTwCZnUYVXmY5Amjthe9N4QKiWv/Cgkqw0HB3dedllWWOhrPnfY+QYh7ayIVAFSaQ
         ADoA==
X-Forwarded-Encrypted: i=1; AJvYcCUa24Z/es4Ai0PqueFJ7ZlxC2IkiAcct0zgZYfJykQXW6V0gNx7PXG0+QgHlPVC+U9vMj9t+y2IzFkAMdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhI60XyAaOJQlMJgJbOfiXxFux6LIs9xPcZYwAf3CffdgjGE2C
	MMvB3nV8rn+GNwkgAu21wbHWU2fyn8z5RDphh+jQGisrrTJKh2SDzWTmV17TGUI=
X-Gm-Gg: ASbGncs4cBkOyUZ8qUdWBm8yrldXtLSRq8exoYcI7UloszM37yFDgqsTfvOw/tZnZVf
	vI5oL66SzMxNLQIBYE/8b9fD6QtUJ3lAVvCkjV8tMKq6llMPwgJ43CTHVRrF/JPda4IXbPcAuKv
	TRr+/4tRUd+kW98SaLR3/1CrlcIzg/UXpa//fKKHRxVaRHpGlOOXhfxXw/VfBT+M8khrm4nfh4e
	noJQPDdwNrAhkhJQ+I8PjyrO0CRarZt6vdwqtlw3yID4vm3iPFrxqSb58kLQKyk5Q==
X-Google-Smtp-Source: AGHT+IGZighbjX7std4pzfSyBx0+MsFOhZyNAcJFzlKYO+bC8pDuB1636KCn0Y5SF5bgYneCudp7UQ==
X-Received: by 2002:a05:6000:1449:b0:386:4034:f9a4 with SMTP id ffacd0b85a97d-3864cec3aafmr4168759f8f.43.1733952784439;
        Wed, 11 Dec 2024 13:33:04 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3115:252a:3e6f:da41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f5a0sm2136252f8f.13.2024.12.11.13.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 13:33:04 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 11 Dec 2024 22:15:19 +0100
Subject: [PATCH net-next v15 15/22] ovpn: add support for updating local
 UDP endpoint
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-b4-ovpn-v15-15-314e2cad0618@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2818; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=cfVVFW1YSk9Sp4rozyN1I0rQt8bnuFN11hRcZBHCzX0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnWgUm0NLA+HdcRcj+rYusGtWB8pBOwuHsKLKgG
 DKo1jBAVEGJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1oFJgAKCRALcOU6oDjV
 h8MJCACtOWeN4YfTl/OlVyXYhMYutFiHG0LJEgsHOMFmfF0QOgXQSXoivUZ/dKp5jQSwP/yaQ8T
 PZ8+QdEClgpH4GiwPsr0pHCDbl/qNq/jE1gdARon1AZaUe+54bnPXxhKrMeNy+sTEczTsTx9AbM
 w4rOJA5tHRRMLPM61yPUtAw/3TS+q0zJ9uooUFzmMWqM1qeHXSBduz/LTQai/JyFErBcd0y6gE1
 F3WCwiJj0uXil6eeLy7ZPtltVSC1gYRNbhwb8qDre4rj81a1nTBbDYRvUFmziYTI2L2YF0tIUSg
 K0F/E6CsUhjEpEO/20lt7APJ1dinSqOqdx3IXvDWiU5TusjC
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

In case of UDP links, the local endpoint used to communicate with a
given peer may change without a connection restart.

Add support for learning the new address in case of change.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h |  3 +++
 2 files changed, 48 insertions(+)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 7908a4025352094b9c1ad5a75e1e9e2dfb86cb78..bcc7ffdd7a02774999f96b50232d18bf9db72280 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -466,6 +466,51 @@ struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_priv *ovpn, u32 peer_id)
 	return peer;
 }
 
+/**
+ * ovpn_peer_update_local_endpoint - update local endpoint for peer
+ * @peer: peer to update the endpoint for
+ * @skb: incoming packet to retrieve the destination address (local) from
+ */
+void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
+				     struct sk_buff *skb)
+{
+	struct ovpn_bind *bind;
+
+	rcu_read_lock();
+	bind = rcu_dereference(peer->bind);
+	if (unlikely(!bind))
+		goto unlock;
+
+	spin_lock_bh(&peer->lock);
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		if (unlikely(bind->local.ipv4.s_addr != ip_hdr(skb)->daddr)) {
+			net_dbg_ratelimited("%s: learning local IPv4 for peer %d (%pI4 -> %pI4)\n",
+					    netdev_name(peer->ovpn->dev),
+					    peer->id, &bind->local.ipv4.s_addr,
+					    &ip_hdr(skb)->daddr);
+			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
+		}
+		break;
+	case htons(ETH_P_IPV6):
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
+		break;
+	}
+	spin_unlock_bh(&peer->lock);
+
+unlock:
+	rcu_read_unlock();
+}
+
 /**
  * ovpn_peer_get_by_dst - Lookup peer to send skb to
  * @ovpn: the private data representing the current VPN session
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 4316051a12f0b8ada5110dd7aa71afedf29a0c2d..d12fbced1252f84665b084f7a24b6d515bed833d 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -153,4 +153,7 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 void ovpn_peer_keepalive_work(struct work_struct *work);
 
+void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
+				     struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.45.2


