Return-Path: <linux-kernel+bounces-435667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB7B9E7AC0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753CB282069
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9E6215044;
	Fri,  6 Dec 2024 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="UMAJ/9ul"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004C8221DAB
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 21:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519945; cv=none; b=hZCZIu+KUuGVwkyXAePD25Hq2wgdBjocC1SeHjAHWJnm5sQmckbFL8G8FA+v3hUDAtCqrz1Nj0zv2Fs97Cqw5L4APROUYSu1LbnSh/YQsdsdK0WXETh7g98d571T8nGe/WUdVOuZZxiyg0P+A1V2t/lJ8vxeSJeB4azJ/JgIMTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519945; c=relaxed/simple;
	bh=erPTYrweFrnKu8N8OGwDdEIbYQXq1gCniqH6iX4uYZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cxg9hoxa0SpDfCdGwH1WRncxHo4v6UUl1ygkZDrcWTwZXecJeFUuWcri7I/schQUmM/TlpmlSr2hJpHwl2CJugwSk7ii8y5eW9Qj2rUcXcDeMG4Dg5PEkJ4skj9PSc5FRW5woUWsX32rlnHUY9lDukWwO6l5niCAM0DSQTiqMQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=UMAJ/9ul; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a14d6bf4so24858495e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 13:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733519940; x=1734124740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1cyT+TFbRaSz+vYeKaMRbh97PUnS/cHongWol9wj6Bw=;
        b=UMAJ/9ulnl8QRuW7pZwQjJeSSiYEN0fVjOy3VH5OgYRfDDn3i3QtucPmfu1GE0CPJ8
         NxhdvKibQ8jM2UflSg+Tsemv8NdWw+uimCs6g5Zx76t6qWl59RFpcsFziqAYpHB+kMso
         5oaE7Q96CGgYboAnz9Q5C06YSI2E8r6Z1dvI93bPSv+ZP5fTIZBjxgMg4onO/r4L0iPl
         7w+PvZQGKIWhhX5NBA2q4UYVGe92/8NTZCGuQj5R6iuL4MCpf5JSyOlrFO3YeJMYz9m5
         huQBYrt+P4ZeeaXR/vawrZfsShADQSLm86sjyWqb2VSTiRdU999rA6zdq7lOzqfjjgcx
         Uu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733519940; x=1734124740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cyT+TFbRaSz+vYeKaMRbh97PUnS/cHongWol9wj6Bw=;
        b=AFQ8hL101yF9hV6ikmNE9uxswND1CeycCJdKxXoSxhzm65Yh3iu4PR2SB0Xgh1C6Ln
         FBIyPkzZQy7CMENN1VwHdut2PC3eK6cWmV2KHOiHSHWvnG1ngK99JBD+Xrv7kbua+BCK
         Vyn36PzhfvZcsuNiUGnRIg6LKxDQBwkfvdtWJJKllBc8o78jEHaZYHUEOC3dYcQpMb3i
         wHRqV9k+kVBTsOJUEr3wEKxfOAr1omVVQUq3kiMwBJ34pfWjk8hDuuoHMKQW58X3Fp5a
         i1aE7+KgNkmz3Pp1Xwk29f6VgD3C8EFJdQsnBzIVoSgQo+u6I8O3hxbiCX4zHTkG8LoF
         bfyA==
X-Forwarded-Encrypted: i=1; AJvYcCUCUrqnpwsMWTEL/NILcAi/NpZ88pXK+C//cutJsVq42PAprRzMmV/TycpQyVhMfqd5n2bJ27POdpDSppg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHNTQ/F3RpIe5p/crvwTZfLwZ/KbUCoZ6mdSyUZh4KOxbzJa6w
	xv/q02xk2YrdEBGrJ//gIN03hthoA6o+jZhn71UiWfmE45CTupp7ztTvAznU4pnZXpJJF4Xt4hk
	H
X-Gm-Gg: ASbGncuBAWDej7N/i6bw0SsOh63/49hgAXcERjarNFBOllM+ASQBB5pVo2yfL1CKOq0
	3spwI+pw57IAObOY/pGBVDuGxeSe3/Vcr4GAakuB929H0jrBXghBN61ElzFxyolbE0v9Hj4APdO
	mMx7j4t0UBn8SfqX7kMcz69TXPx69wrwRMRgTCVf4iVlxZYowcsF94OhZ7HE4kAMFpmxBiwgOcQ
	lgj5r6vukE2dznsx6kTf+TlmNIquCrFOlFnmr0U7040BPmvIxegJoojI3/ZSQ==
X-Google-Smtp-Source: AGHT+IGu6qLY53C0yoO6aT+2nQymjktc9X77m8kuNJGtIHYDdrEE2bGIzUewngaCu8CdjcRxJXFXqg==
X-Received: by 2002:a5d:6da8:0:b0:386:1cd3:8a08 with SMTP id ffacd0b85a97d-3862b3325bemr3770534f8f.5.1733519940294;
        Fri, 06 Dec 2024 13:19:00 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3cee:9adf:5d38:601e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fd46839sm5441302f8f.52.2024.12.06.13.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 13:18:59 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 06 Dec 2024 22:18:40 +0100
Subject: [PATCH net-next v13 15/22] ovpn: add support for updating local
 UDP endpoint
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-b4-ovpn-v13-15-67fb4be666e2@openvpn.net>
References: <20241206-b4-ovpn-v13-0-67fb4be666e2@openvpn.net>
In-Reply-To: <20241206-b4-ovpn-v13-0-67fb4be666e2@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2818; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=erPTYrweFrnKu8N8OGwDdEIbYQXq1gCniqH6iX4uYZ0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnU2pYPaFUu0WM9rmjYa1hIakLvis3UG4dB+ZkA
 cWt6/NXu9OJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1NqWAAKCRALcOU6oDjV
 h2cuB/9bN3LXMG5OFVwkE3CFCaoewrE0mzZ4ZM2diIeWArrXH9Kxn9fBFG6OcFkk60k57ZPDsje
 vLo9i2p8G/jTWidWmKAAAjD93InJbIIfe5hFvu5Q5y5Bzr319nOpNpEOVdWSv0y+2AHQJKWwA1g
 a73wM/RCOJtW3vBDHN6MtIuxckta31w2uhfrZ/4ZXxU5hERGAZJhYO2kdLb4ownoJgIL8CVeKG7
 PCnOg20jiyBU65/dJ9BznTj2La3I6sJ7bIaypZONQKcaKysv5PH68mzZ9N+66MJDgEc3VdR29lY
 r6qBncZ/AST1K/7nHjRNhlLEFa8eS0kHNzefqW8yYXANfzes
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
index 168cec1cbcead962e921d29822fc0d9dec1f28a4..decc80c095d6a82787d42d0b4d50f85016e942ba 100644
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


