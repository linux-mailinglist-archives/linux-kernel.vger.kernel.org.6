Return-Path: <linux-kernel+bounces-542987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EA8A4D030
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFF037A7D61
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA0D1FA262;
	Tue,  4 Mar 2025 00:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="gBmE2IrJ"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5001F8921
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 00:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048501; cv=none; b=Rl5BfdQmiGRCdQC6P0x1NS/GDW4GpP5wGqfo8w/vZEBCDnoslwmNzOlyr/Co9OvkzhCjAt0pIV719iH3eYsrrfkH2GMw6BJceIBgxRHtctuvZ3gZOoI5WN6L0Py7K5nZXr4qUOZN2i1yMAy0tMH7dvJrRR3A36FlzfFNtQIQ5Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048501; c=relaxed/simple;
	bh=VoexkR3aZQpVtX6l3IsaQ6xTr48vkXTncQgfYecxi4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BgwZjvaOvYNUDPUkmRJjUYGF7Dw1OcspY5rwCE0a7D+fda+gdwrY4Ed1+nwAZQe/1X76iLZRb6fZjzMpg+1Yip1k4/lM3Ykv+O6fse5A1TA9JNLyFNOHhtdc3Qf4B+kb2jSyYS9Z3W7FEP4jaMcn/nKq5VDDjXv8Z9i2xxrpxwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=gBmE2IrJ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-390e88caa4dso2341732f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 16:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741048497; x=1741653297; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZB+CYkwc60/sB5jVm/I/MAbSmf8NKe7CyFfa4i63/M8=;
        b=gBmE2IrJxzJVFug54DyyRtdUkTPITtPK1R6N8uG4bM05xiZh6w0s5aqpBtfZdYvzhi
         0oZ+7ZOkg8QUtGqo2VY5NifJyQVJB9KMaPyFkLF0KKca8/alj8KJ8coSM4UuvM2JxaSP
         boI35alycl+AxyEruX8QmSDxsMbgg9+dROvZHRhdYKk//j6rAtl0vrFeqkeuT9dAdGbY
         o9TH7cDyOrho0YrGXD0NKa0D23w/KSFPjYhFk+U38SiwNzMGMRIs+HBedW090/zKqjqw
         PAn4EbsyirRS0p4UcfacG4IDdIdmnRbEM0oRK8a61okbUXQcMAU7wKTizxP/czMqUAud
         Veig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048497; x=1741653297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZB+CYkwc60/sB5jVm/I/MAbSmf8NKe7CyFfa4i63/M8=;
        b=EMCsTAgF/A0KfRGwCGzufLxa2Ha4dFk0/AcVYRTd0xwSNv0lBLuhXF4vQ8itRPfaFS
         JTOKPngMdUKni65SEcRKuUbSeL0XyNMRy5mNOMeI5WBZAR8lY/KbBDnfY9yia1fIGzt5
         uErNQ2v+Szt7KPw/+bgH6IgDWfCHhjT1J4H1DEtNihk34pekGBVEj/2SV9ektMFXEjU/
         UiqQrLAL98MGJnC+ZErFdYKSV/spGkLoOXNcJ4GonPKUhCbB9W99zaonH20FOGmrmIoz
         kroaea9eRGXMUHBP4zds31SC6JExIN9pHVRUyCG5/rODSGrct+Y2CEFE+uMPzMGMlNcC
         UWNA==
X-Forwarded-Encrypted: i=1; AJvYcCXrcM2s1uKDgxuvMMfLD/cESl2gFeGMZFGZrMs/hP1XyNNj3LGqjtk23WPotEbvPzHw1M8HGdKMsPZIJvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDiT6MaDZcp+kcKCdsRuCfJbwJff1U3DQpaFalc+PW9K9BgQSY
	dE7iSG/kHJw6GKIu+QcqBGHllHsXjVVDxwtqYF2pkXqZCrp3fG1umQR7QGlu8E4=
X-Gm-Gg: ASbGncsLXk5Am+77O2oil+KDa0EskWjGun2Z+VDfmsfoBZaUy1AS4JM5csr8jb/lzHU
	nZdzNqHBGuezSnmX0exsUUZ6Q1aBRW0SybgseEFVeUO6kfJNDczjQPwbVauSozWs2NRpjBQC8si
	rKNZWn6/F1NVqm8SOKc1NFAb+OoQA/gXux1zOWq1HnzU0m0hxxu9zFSewNIzVI48Ux4AcG1yws4
	HNVNN4X4Ov0eyR9VNXOYmQJFq8ET/otntQN0FkNVUULs+0IW9ipp9rl1i0ligk/joHgtaBiwqJO
	sKuTuIkIzT9QM6s5+XoMpD+m2/YKyaFqRXatDWyE6g==
X-Google-Smtp-Source: AGHT+IFx+f6XEoHj57a/jBSrA7MGVQ3ZIzbddfUUNu5msLkuSO7umH4luNDnSEhakroy/bm00MJiHw==
X-Received: by 2002:a05:6000:401f:b0:38f:451b:653c with SMTP id ffacd0b85a97d-390ec7c8f86mr10794498f8f.7.1741048497040;
        Mon, 03 Mar 2025 16:34:57 -0800 (PST)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:49fa:e07e:e2df:d3ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d0asm15709265f8f.27.2025.03.03.16.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:34:56 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 04 Mar 2025 01:33:52 +0100
Subject: [PATCH v21 22/24] ovpn: notify userspace when a peer is deleted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-b4-ovpn-tmp-v21-22-d3cbb74bb581@openvpn.net>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
In-Reply-To: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
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
 h=from:subject:message-id; bh=VoexkR3aZQpVtX6l3IsaQ6xTr48vkXTncQgfYecxi4k=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnxkqQ08dS3FKuKEFytyCl4edbnlgL3DSTnNp26
 l8mKXlou2SJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ8ZKkAAKCRALcOU6oDjV
 h5jyCACahzz59SEjvl8kGOuQwiV6WHyeuRhphNXRPhNxi6O6ioLnvfyCm/dAcZ0a6kpfLCGtWRU
 YWK0hXbcO5rsJcaRrrEIGBhXOH0IzXNEA2QPbodGGyRNf6vlKiwq7il/usqTFbQRfZ+/h6iSKp3
 afrqt0cvXoI+jn8iInvpTHGH5KAWpHatrRptclNKPDnkX/YbUj6cRaiL82mqiAD8xCSzCdZ9Z4i
 UtAZeEjWjpVApj07e8o4bvoknjC8ik82AEO/OTmX+Ys4QuQUroopzcO+W4OGx5Gz8cR6uY1EmrC
 5lxCU6o0p6UwGCzQ+aW00vXUywgd/w2uhf57joFzte5H7gxN
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
index d1845c1b446c82111ae349092e779fd46824c83a..5e08decc961fae1d26065098d64d59cbac70fbc0 100644
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
index 2a9f373b7a2f684203677bdc7b5a147c41ea2daf..f9216c0be42badae79b0077718416dfccb1fb987 100644
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


