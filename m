Return-Path: <linux-kernel+bounces-535318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03508A4714D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6581890FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6879C22B584;
	Thu, 27 Feb 2025 01:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="T2ZGeNVV"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F391521576D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619400; cv=none; b=LFONNEc4YtkGTV9+PgFamE2E/MvFnr4rjk6Vn/iFYGDv29BDaXg0Nub086MMT8s04M6+eDM/W2Zi+z64cpgR5BDcB+b34rZKBenAOzmddGT8F/pVi4TATHwCrnDbzkRn1PhYYFrbT7TQOgvb8w+GdjmYY/KXkUmISpWVRHkc5ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619400; c=relaxed/simple;
	bh=erbB63BOdTxWd+5ssGTgV8h7t3UG4fLRCwZg+mhkk2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cfPZYONSstZ+6YidroOV2BFC8Qrt4R0kLPVk2RIRxjXKpb1NgnWuo5pEzKcJ1Hy+ahKJTY18tnHNVExGlNHf+mQaw0FqcFDbs7bDryR6h1s++CZtu4jNL/9XtKztdaFJzvr50MA2GDxZoqXdO6gpPGkD8H8IzFNg5JyfVoVp+ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=T2ZGeNVV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-439ac3216dcso2754665e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1740619396; x=1741224196; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qrXM/kmydgEGP0ttoagisPtBBMfWzDic3a3yicN0P8M=;
        b=T2ZGeNVVAVzwvNsjcy2DPrYX9/Sr07IEeynfW68cjXMP+VQ8VCiGVa43rDmhj2QgWZ
         9vXP78XEc8xfzExrWhgXzg0RiWsXoBfq2dYwg06ctlsL/Tfg2nDyI6VEECexqT3GzaiJ
         zFbZUw2BWJdNMy7WDn+97ZIcv0ktpt9KWEcU+NbAhgJmvwO9+2JVAJc9bIrxadTDKMoy
         T6stqQNk+P+KRAsL80UOxl8Ah+1h78nNIPfLghZ+k7KmA4PAs/l4cf47JTvc+/8441cA
         nDg5UB5RW/D4NEb/niEWid3VvpLVqOtaXXLHaCDhzZk4JyHJprLAbzaSUG7fPwV8fNlg
         nEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740619396; x=1741224196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qrXM/kmydgEGP0ttoagisPtBBMfWzDic3a3yicN0P8M=;
        b=S85b+zId+BxeSO2hEJY5+x3s5T8dBcS2EJYVHpj1gPPi84+Zif3OtYBfd3NDtHGSrc
         1KFQvc9El9iV7tYnATK8+BhcHw7LVIxZSUJeoDFm+Og+IZ9kbqvWNuwjAjB+ZzOLdlxb
         +XOmQLb9FvlyO8sZSretrKKWiryIiUKu6bQCIOP996MfVUzv6jaRScgaDc52qU3Jdmt8
         iApDqsZiSGdl0W89kRpz1+2K/SZoQsBt3Z4nVqvzAfwyrJysPXKfw8M5/KWhbQoiODMj
         nodKGMsAjadfhJbZT6hJOQqhfRGe3NrSgXYCiBOg00wuC7NJ22oG0Zxckj/NapyVbNSj
         +EgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkiZqsPWchP2jM+Ce+WfJ/JWjoNQRlmRvn4bm1y+Xjg1/fdcVgL6yPWFPUfEa7gxzfNkWZvVTrywaRXLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5lQfqbFNSP6aVHj+YeKvdrQB4NMORjLVxJpyna04LQ+EHV+v7
	AnE5JT4R/C8c4A8ojQ6da9ozza8W1i3ffPnX7AkfOhDIwdi6UOXYO/kRyb6AyxKtDS+hpPzhF8h
	3
X-Gm-Gg: ASbGncsNbxW8ICJwnb3tyKoO8jC5Aqvkrsal3rvvZyre3BkodFr9hSD5Y3Y0Q9OnomH
	2MIteQinDlEj7y3UnIjqfYKHc9lPaaeWlxeV5pBGmhYXjBvRBe2wluei2wG7DJnLGTMzYEI2gWl
	gHjkfz1UiVUyzXs7x6xcdhSOa/kv4bIaTmyG8tiDEM2GWJ2hxRU33flkbvViGwg21snrc0SKcia
	Qegb9O6nXLsTNNemdxUPQjiDSTArRLw8oh+Vwbwtgeuqejre8zNdnd+GjvkYh4Fp0g3UG3F763F
	FN6kE5PbyWPoL2N3K5ErjeXLq23d22SNpkxjJw==
X-Google-Smtp-Source: AGHT+IFJpRbgkIW+2aykTe24F/h+uXGsztLO3mC+FzDuym7ccpIm8AWKjELNatwBjkSf2bVfuHnfdw==
X-Received: by 2002:a05:6000:2c7:b0:38f:21ce:aa28 with SMTP id ffacd0b85a97d-38f70827b21mr16804237f8f.36.1740619396030;
        Wed, 26 Feb 2025 17:23:16 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:7418:f717:1e0a:e55a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5327f0sm38375395e9.9.2025.02.26.17.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 17:23:15 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 27 Feb 2025 02:21:48 +0100
Subject: [PATCH net-next v20 23/25] ovpn: notify userspace when a peer is
 deleted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-b4-ovpn-v20-23-93f363310834@openvpn.net>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
In-Reply-To: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3531; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=erbB63BOdTxWd+5ssGTgV8h7t3UG4fLRCwZg+mhkk2U=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnv75hKhtBSEZmMN4vZvCoCLINPBLM3rc6+ft6a
 qCsAjbX95SJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ7++YQAKCRALcOU6oDjV
 h3poB/9KC/IW+on103KV07vYK3NwxYAYrpLOOFZhFX43McRXX4BpWWXv0+/yqHHvzLoxfG0WAJa
 jbIrzTJ7kbnpqciIeu+opYkeM1YAVkg8klpUZoP1a7kh3oaLuD48wNPl1+bhhVIzSAxY368NNrq
 Zqy6MYnLC0AMRv/HMfRZCFMLurGb5faQu0bu74RZhJp6hfeCccMM7qlQYeHeF9ebJQRHQ058iA0
 qZ8UXIybslzCBq1rXbZW+eyP3pfzHyFVE1m9tnHHcUI9kgeC/m1u/K8CTMNXs4K5riM0hLr1uLh
 sgjO00wFj7GdZql02K2reXZiwgoiQZPq/GYe3i4KWRvEFyrI
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Whenever a peer is deleted, send a notification to userspace so that it
can react accordingly.

This is most important when a peer is deleted due to ping timeout,
because it all happens in kernelspace and thus userspace has no direct
way to learn about it.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h |  1 +
 drivers/net/ovpn/peer.c    |  1 +
 3 files changed, 67 insertions(+)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 0838b65212aa4b077a8ecb0b21807f886a397193..efe787b15c9d9d6271da670506b5e6396f744e37 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1094,6 +1094,71 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+/**
+ * ovpn_nl_peer_del_notify - notify userspace about peer being deleted
+ * @peer: the peer being deleted
+ *
+ * Return: 0 on success or a negative error code otherwise
+ */
+int ovpn_nl_peer_del_notify(struct ovpn_peer *peer)
+{
+	struct ovpn_socket *sock;
+	struct sk_buff *msg;
+	struct nlattr *attr;
+	int ret = -EMSGSIZE;
+	void *hdr;
+
+	netdev_info(peer->ovpn->dev, "deleting peer with id %u, reason %d\n",
+		    peer->id, peer->delete_reason);
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, 0, 0, &ovpn_nl_family, 0, OVPN_CMD_PEER_DEL_NTF);
+	if (!hdr) {
+		ret = -ENOBUFS;
+		goto err_free_msg;
+	}
+
+	if (nla_put_u32(msg, OVPN_A_IFINDEX, peer->ovpn->dev->ifindex))
+		goto err_cancel_msg;
+
+	attr = nla_nest_start(msg, OVPN_A_PEER);
+	if (!attr)
+		goto err_cancel_msg;
+
+	if (nla_put_u8(msg, OVPN_A_PEER_DEL_REASON, peer->delete_reason))
+		goto err_cancel_msg;
+
+	if (nla_put_u32(msg, OVPN_A_PEER_ID, peer->id))
+		goto err_cancel_msg;
+
+	nla_nest_end(msg, attr);
+
+	genlmsg_end(msg, hdr);
+
+	rcu_read_lock();
+	sock = rcu_dereference(peer->sock);
+	if (!sock) {
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+	genlmsg_multicast_netns(&ovpn_nl_family, sock_net(sock->sock->sk),
+				msg, 0, OVPN_NLGRP_PEERS, GFP_ATOMIC);
+	rcu_read_unlock();
+
+	return 0;
+
+err_unlock:
+	rcu_read_unlock();
+err_cancel_msg:
+	genlmsg_cancel(msg, hdr);
+err_free_msg:
+	nlmsg_free(msg);
+	return ret;
+}
+
 /**
  * ovpn_nl_key_swap_notify - notify userspace peer's key must be renewed
  * @peer: the peer whose key needs to be renewed
diff --git a/drivers/net/ovpn/netlink.h b/drivers/net/ovpn/netlink.h
index 5dc84c8e5e803014053faa0d892fc3a7259d40e5..8615dfc3c4720a2a550b5cd1a8454ccc58a3c6ba 100644
--- a/drivers/net/ovpn/netlink.h
+++ b/drivers/net/ovpn/netlink.h
@@ -12,6 +12,7 @@
 int ovpn_nl_register(void);
 void ovpn_nl_unregister(void);
 
+int ovpn_nl_peer_del_notify(struct ovpn_peer *peer);
 int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id);
 
 #endif /* _NET_OVPN_NETLINK_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index cfe5396da584fb2b6ecbd84cd9b65446e123b6f3..b3cbe070bdfe2d129fb4b8f94401004b55cf32d5 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -689,6 +689,7 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	}
 
 	peer->delete_reason = reason;
+	ovpn_nl_peer_del_notify(peer);
 
 	/* append to provided list for later socket release and ref drop */
 	llist_add(&peer->release_entry, release_list);

-- 
2.45.3


