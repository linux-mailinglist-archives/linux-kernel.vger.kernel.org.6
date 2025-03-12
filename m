Return-Path: <linux-kernel+bounces-558446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2B4A5E5ED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33C783BD66D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D237E211489;
	Wed, 12 Mar 2025 20:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="PLkvqPOD"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722B820E32A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 20:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812898; cv=none; b=U9HI1Qp/XH4ppSAOYsw3Vom1813A130TbSP6E5wk0ezGF1/iGBp0ky5IpRdtbKPhZx0GzSNmb8aMdLE/0058H34wzVNhKi9jV3kWttlAGYlgUfNhncMvKzmwCoB1C2xBXZd6zAocN1c1ME2Xf4mZpaw68S5Vtfhusk/rj14hViY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812898; c=relaxed/simple;
	bh=RhUUdlwiC4BQcBlibtMMd8O+kRfJ/EojdYIjhAycAvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PEJ20zZnKUKhyx5Ql04GYOPMdtJH8hMTillXssE2xvRN/wA4v8v1DUpaiWgCu6OxpSUFcEMmvlGbTZN/jLAfepuUopBdhRBcPme3SJnYXBHODV9wSNK6YDQlBlPTrsrT1SzaVmLLJFWDLxahzMLT98DxlL4sXgh68ZV7sPV88OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=PLkvqPOD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso1398055e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741812894; x=1742417694; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2EIRLWzA5R4meMp00lsQZIoIdkQMDg2vUQPqZYQGdm0=;
        b=PLkvqPODG2gX48nUPnrpkwe7YOOiT9E6vhgZBgH1XW9vtVVqh57pXgxJ4Vmyawgvpm
         hQutjhwgnOdtGrKdE8TPL6JpgxmydZkmyN2/t5h9wl4XhnbDJoJw5Tu9EJKIegBojthM
         l0nzHfn0RT+YB22ctKTLZg7Ey68VhTBNHMV74hYYxt4iksjF23xlthYTYi939KHIeIRg
         VOLkE4FYl8U3BWkikEyVIYg85Fb1XU1xeQzVg4I8k4uthW3fMyDHxp9aTK/moV1R7uc0
         6VqIrO1WzKHC10B9yzoPxkyP9S/MPE24CdGr8HhGfaf0ID0l4Lc/67texg1pdgt5Hkru
         NHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741812894; x=1742417694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EIRLWzA5R4meMp00lsQZIoIdkQMDg2vUQPqZYQGdm0=;
        b=ol21KxrPqxo8WN/s/3h/dkJIvbaM4KmstUGPrrkBVSNXg+x05fe+ZmEPNDev7Tz7Mp
         nuUzEflfdMMurx+hPDR3zOUy5HX/ObD9GXjHvqXvrSyxidYmYypy51tyL3XG0dtS274S
         lgOPgaUJMZkZbjIt8N2reMx/2gg1qHqUoQLiIDsybTB0cnLsrPtZHdXqw80UG2RnVOk5
         yQxZCoXbPNQj0gsBKQ4NHnqF1NYY0Wml8bkOF2Bw+CwxKFupfcsoHh0Uy+CK22QQohpl
         3NSedqZHefGT4ruXPZzNqmfGOBwS8HhpfQDl+G1dl9Gca7jACu8lZP0zARfpmnscSGVC
         tdcg==
X-Forwarded-Encrypted: i=1; AJvYcCUm6349N9JEHMsXqhTJ5e3Mo9KLHVLth0SCe8TUldEkqLHIGGM+Bm1baHqtahPqXXHmBLdN+2xVqUL2U1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH+TXWyNjihqesYgstsNkhvDuP2UlnZL5pL0ijt+271Di2aNdo
	f3RS2dHpYXi9IGlKYKmk1KNPWvutR40ViIW2+w9XgGIoaN7CUQRW1h5k2qQVZ5U=
X-Gm-Gg: ASbGnculoeN0Jy2ttcq+4pKa5FkLagP7+hHnx4CUU4e/UsI3DqGbQadR9CqoHkk5ajG
	OsJ6rEi+cTkK019An8GSAC3UoliHvWg6Ce3+jCwqeBPYt0nLdrMB4hcNxAV9uQfrWYL7KlQ8HWv
	cmev/+FND956eFSav3ZdJwsdtYQjA2AIQAQ0SPtMSCfK38NCMHI7HL3kUUGDM3pYYRLQHbpuR5G
	JpEHkArzYbC5i76S1viiLZx87NV8XU5Z57y3brpgGUF4fArvMDoH8jIKxRbsunuS74MYBLf6Glj
	zXJs6xKkRagmL/JWUCYh0Hw/DsfcDhgWuu4WtyYHiQ==
X-Google-Smtp-Source: AGHT+IFr6m0JsmVvbpuUtjiHA+jeqSxa1L8YZD5j2a8Sz1011fGkHTQNjEl3aTczTWjL8I3GNo8c8g==
X-Received: by 2002:a05:600c:3591:b0:43c:f16a:641e with SMTP id 5b1f17b1804b1-43cf16a6b0cmr127564405e9.6.1741812893628;
        Wed, 12 Mar 2025 13:54:53 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:a42b:bae6:6f7d:117f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c10437dsm22481393f8f.99.2025.03.12.13.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 13:54:53 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 12 Mar 2025 21:54:30 +0100
Subject: [PATCH net-next v23 21/23] ovpn: notify userspace when a peer is
 deleted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-ovpn-v23-21-76066bc0a30c@openvpn.net>
References: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
In-Reply-To: <20250312-b4-ovpn-v23-0-76066bc0a30c@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3532; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=RhUUdlwiC4BQcBlibtMMd8O+kRfJ/EojdYIjhAycAvQ=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn0fR8ZPL1pk2QQixze3YTWupk6dN3cTNEWtOTf
 3wI4BT+bxeJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ9H0fAAKCRALcOU6oDjV
 hymFCAC2N/juNFEWaJ1kdhAYjzm/UYKDJMh2c11xW9YJyUBB7hOq2AMoIIfQAaPaXuksHghL4MS
 CLwQxiSZQaLoSmzCOiv9diZQN2wf4E5ptXJmXxLpS4BPqPbxMpMsvGJDMnvmTixkoxMPPRsrAH+
 XREArKELug8VyharCPT71nJk54UyYYV2EsVuwkzucJXkkrg1iKhelYP9V1Gj/zLCxKHGyWmCHXr
 CCznuYqNE6qrmA5hZ2BztEK/jpeJ+xW/o0CRTi+f2ziXFxpaWjmkyZ0tSmHYpI0XKO+oKP3fqy1
 gynW43liu9QMNQixIeukKY1bmEv+afrGqJbBp3G6z00IP97e
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
index 46500e4223d7619a342f803c67aa760166fa6f2b..be3484068cbcb1a8e00e5018c6852e645de37dc2 100644
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
+	if (nla_put_u32(msg, OVPN_A_PEER_DEL_REASON, peer->delete_reason))
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
index aead1d75400a604a320c886aed5308fb20475da3..d9ca62447738416c5c2f89ab36254e4c00e48033 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -706,6 +706,7 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	}
 
 	peer->delete_reason = reason;
+	ovpn_nl_peer_del_notify(peer);
 
 	/* append to provided list for later socket release and ref drop */
 	llist_add(&peer->release_entry, release_list);

-- 
2.48.1


