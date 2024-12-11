Return-Path: <linux-kernel+bounces-442164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC9C9ED8CB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2B7169FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED8F203D6D;
	Wed, 11 Dec 2024 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="V5IhodvE"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4C71F0E4A
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952795; cv=none; b=eHCu4UR0GrBREMJTOvIlo1TqH49AxWpPJ+TSM130WZJEKt0lG/I6WtukuKhpD/FEHQWNUXy3yX/ZwipOa5NJ0y62loo0uQdeIrVsG4PBryvYrx/XIX5kagm0okBu1VnCUy6dAdacF3ToiiJsSxR6HR7Mfb6n7jEMExSTPP1d3RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952795; c=relaxed/simple;
	bh=hu6mdgf4Aohz12hqPZPfa+7Oo2L8U//PYphNjH8hkAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DFd6uUbbKX+56G8yuRE0FUtS9MFEqjQxTziGFkq+cUqR7rCWqUAMwcMZlsy87IdCB2cQtxDEpImSsq1fxFKzl+5dF4yhKzQmux7QVU40MiVB9l18PbGxgrpc58vFhPjr2ZxnLRoPuTSRVBOBO0M6EuDyAu2u+ujT67BtI8nYg0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=V5IhodvE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4361815b96cso13980675e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733952791; x=1734557591; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+EbxvQfjpwraCJqqVXbm6cpVgKFbo1CnJkpwqz0Hss=;
        b=V5IhodvEn5KokcntBov8HT8FogFhypJ8Qa/iLBSFCo7q51V3XMrudqqKsPCaLZ3YY9
         28xy41ivb+IGZsLMKs6ugjXHrcIBmTVnh6jEq0JPcFG4P34f1Bt9hT4m/r2ccucUpZ5W
         eFw6faE1HGTz+nyepIUFXvxOPoJCcvVwxGBs9MSO9TXIwEL7Qt34uC5vUnwuZ/4FFCAg
         GuWuPFmN+0+GdziPxCjLK3fJtpHo8zV5SLD2ojjchYnYlzu5gdGQvegx/nNJJPRpThBu
         wH3lxhzeAveDHHRfvDXgPbQGp5htCoYC8Bt9bFMBbRq3fAKLCUKd+SMrE+RoC9Qw8jws
         LgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952791; x=1734557591;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+EbxvQfjpwraCJqqVXbm6cpVgKFbo1CnJkpwqz0Hss=;
        b=ffnvxdeIKG6W/TCh81Gj67yRcHWRGuBsJf4c6zYBKzYWZ1jwRgta6Uqo0dNFbCpJvH
         zNayKjqpGEGQcD7qrjEnrMnjOzqA8IPNQcmJKZCJzGSJ/na6HenD0iMTTTtgTm6qv31/
         jDN9ApseyBr8dj58GvnZnvkAOBzr9nAfMSlrRw747S89MJGxb2A+aZI6yBjqyCztABa0
         U8ybR85P2DCr5B9BFgU47Acx6g1gdSpU9g5NBJZ83aZjF6xJASrNscndbBC0h+Qq806l
         MCCYDIflRUb3BY7LEH3PVsP+1kJPfQRHTXVOGZFxgjK8UsxmbPMtjiz6NJCg/VcUP5eQ
         AyjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUOCA7a/6bBBeaCRRI9MvDYJz2FxgmFs5zp79QJGArSuGRrictNf79ST6bmSjBFsiJReRzYzHyg39WSt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRa9dlFV7sXllupXzWKWk/fOA9i6sfGjpfzcVWXb6APeCzLluR
	6qz48v0XF1ZUZ2sKZHeh82C6ZG+G6AyzYDeGiqCMUebqPGH4W/b1Tsu4DT2+g2I=
X-Gm-Gg: ASbGncvEmVtpja3GfoaFz1Rc6uqjVE35DiHWG2U0C9/OoLDhuNxyYkm2Jc3yEZycNqu
	EKeQgarlhAjHJzqBIowlppZ9LPC2TaPjoXYxcOtTlFslc/cJG2zXuLAml03Ee2CWeRizN/F6eVv
	+QNtXaS1Ab/I93ZKFsrHv8kF1mu9lUARHyMshZmmlo6dHLv1RvKNfjkfpylDx+JYjY8J8cn7YTv
	IOWRGlH+ZfgX5LZufPrbM6SLV1RYuLsHSOiFtn74i8DNcpAiSFVHxoaBVZCoB136g==
X-Google-Smtp-Source: AGHT+IGtqoVb1P/9MnDmGM1LpJ4gn2hwhfA1nyANl1MAn7EktdNi6RUq7JdFzvM6VPg8rzWgne1wZA==
X-Received: by 2002:a5d:6c64:0:b0:385:fab3:c56d with SMTP id ffacd0b85a97d-3864cdc1132mr3741720f8f.0.1733952791281;
        Wed, 11 Dec 2024 13:33:11 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3115:252a:3e6f:da41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878248f5a0sm2136252f8f.13.2024.12.11.13.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 13:33:10 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 11 Dec 2024 22:15:24 +0100
Subject: [PATCH net-next v15 20/22] ovpn: notify userspace when a peer is
 deleted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-b4-ovpn-v15-20-314e2cad0618@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3261; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=hu6mdgf4Aohz12hqPZPfa+7Oo2L8U//PYphNjH8hkAY=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnWgUmvdhJjFrBvJtwWAJGA0aXJ1CW5Ttbi6weU
 +aRl/gRvlWJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1oFJgAKCRALcOU6oDjV
 h1bwB/wMEccHw4PLDQmnWB9SO4/PJ3iAFdafTkDQLRpOakxQwW2vqcl0YmY5VZMSY/DR8sXU2xi
 blULh8DHtbfwFy3L8qENWK1YokCVH6GNFgCi39HR7IcWF23iL2j+CAvSsiR7AR7Vty5keOvKGfQ
 bOn2U7rIP4OD9m71BBCneEcZb3CGHBOCA+9dgi0kDBzVQ2kU86vT8YGO6s7I90IzgFSpBys3Czu
 BgTRikfZiEf1wpGPhOcAz2gOjo+X27AuLEzsvydMJRrrTqywECFUoc6/jayxI0ma9R1KBO3J52P
 anmmKTB9ONpvUtFIcGie8svAxxhdSkHG+Hu2g+A6CyVWM1r9
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Whenever a peer is deleted, send a notification to userspace so that it
can react accordingly.

This is most important when a peer is deleted due to ping timeout,
because it all happens in kernelspace and thus userspace has no direct
way to learn about it.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/netlink.h |  1 +
 drivers/net/ovpn/peer.c    |  1 +
 3 files changed, 57 insertions(+)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 0e68f023e95e6dcb41d07f960ea032292b28d0af..5b6a3566e5cd287720ae16a963c7623c06ff4add 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1053,6 +1053,61 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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
+	genlmsg_multicast_netns(&ovpn_nl_family, sock_net(peer->sock->sock->sk),
+				msg, 0, OVPN_NLGRP_PEERS, GFP_KERNEL);
+
+	return 0;
+
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
index 33390b13c8904d40b629662005a9eb92ff617c3b..4ab3abcf23dba11f6b92e3d69e700693adbc671b 100644
--- a/drivers/net/ovpn/netlink.h
+++ b/drivers/net/ovpn/netlink.h
@@ -12,6 +12,7 @@
 int ovpn_nl_register(void);
 void ovpn_nl_unregister(void);
 
+int ovpn_nl_peer_del_notify(struct ovpn_peer *peer);
 int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id);
 
 #endif /* _NET_OVPN_NETLINK_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index ed450be2d2379664a7fe0f17a9af527829474174..7e0de795b389e85e49bcae19d906e7a57ef31690 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -995,6 +995,7 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	}
 
 	peer->delete_reason = reason;
+	ovpn_nl_peer_del_notify(peer);
 	if (peer->sock)
 		ovpn_socket_put(peer->sock);
 

-- 
2.45.2


