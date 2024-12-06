Return-Path: <linux-kernel+bounces-435672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C38979E7ADD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9A41889938
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BAE2309B6;
	Fri,  6 Dec 2024 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="HG3ppt9h"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BEF21507A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 21:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519951; cv=none; b=RBp267HN0Hnn0ibQvathOrgEPbIN6wG8BYZbBQ71Oe60JndIEhiyorckEkUW2dYxNCHXhfo0SjhmvkWnJRbLsS3nGT6hzxM+vDvBYFq/CRVARUteKC+igs47uSEh5MoiEnqCSm/eXL0+UnLGtm4h0Je7ND3YZ8UJ2jgIDklg9BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519951; c=relaxed/simple;
	bh=2w03x074C1Ch4YmIvqL1EZXwi46cvkQyIQqVLlfb0iE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IPPPVPlpZ8bI+4coogvbgLlXvRU85nodlQ36LVsNU2ie5NYyddY6YNzFYkl28dkFT7qIyLB/WfE6/uEWWE28M6EUYucjAqGckb2Spa6PDVPL8jWCe1sHDPM+S9yMwy7foQMgl57z7DHYIxVosbNBFRRbg+gk2dRjfzrxNSgXHaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=HG3ppt9h; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4349fb56260so16869075e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 13:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733519947; x=1734124747; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4bvAlWIlAJT3sFXjrq4CK+OVCRXz5cWRmVw86mNfzs=;
        b=HG3ppt9hAFUhMvCmzuNo03SAhkpMEuuZrjVsQJrjspmS2c0DK9DP1EW/BcG68Nu2No
         D3WkA890eIVPLKP8upA6oPd4Q/wGg9/wT3WUdCld6wKw5vssEJ2iN+asyBDQBHq7qwy9
         4fgQvib5A7xI4lc6epv9ZS/HiiYVMp/QnOnApPHULYF1FKKSRhNi84QeVaNfu9oGD2eI
         sjMjmO42sx2aPkQA0iURYXbUhrO1m0oKAsTycUo/CacOPKAu88qyUsgZ8AzvM6nOVbLh
         nzudhi1YESdyCRdE+t7JpA2Bd38hjEw73zLRmnCMXWWThiA+ViGMizrYRnTQBEvccDZ9
         DiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733519947; x=1734124747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4bvAlWIlAJT3sFXjrq4CK+OVCRXz5cWRmVw86mNfzs=;
        b=kFzeJBlENiwYGh5tOj1H3UKNtAcGQd6Ha6ExCvVXfp8A5fAId1Ngyn2/m1cuDNi9Wt
         ByasPl07zF+uppwEpKcRPvqWxmoRaFIMrHeLaU5wOQKVsJSSRCLJJLR6RKchr2a24ACr
         Ty8Zt8UORn0GBa2qCYtzeD+L5xiiTyDTaAXERNnTfTNRIr9S3xrXPhmVkSB++1mG7d+2
         zAPDf5Fm++DtVgYZIVCTRWy4JuR35/S4ubaU5IUAIfyZQQIUb3vbpZ/cy2MSIetJ//DY
         gx0JCtP6jTAY7xQenU8waiiClxptLlDgvFSbPBhjahBqZrqQKWLdzo+lFx96XHfps+kc
         z61Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9FbHww6B1g40LLupIVuVci1QlWLrEU401Al00RekSeM51bURHubP732aYJ5MImIUZ362tj9erFH2Vp2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkw+3QpBcpdf2TRrxTSoSR6W5eSWDglB8tB2FC6I1LRqcDhyxi
	csFTKUq38UgDa1zg/cK89HUeKgNvIpqWFNcQ57nkltxIzsuwpmPH+KahVgdQBA5RHW2k3ZPNjyH
	T
X-Gm-Gg: ASbGnctz+f/wuliJv+ymH273bvub5oqFfHW3K5iMB6jyzhEdIdY7fUbvREdNrDeFNfz
	3EZUC7PCV+RTrYBtvPgZIJSIrc2Np/I6xmv8egLE7JDAMd5vK4RSD1/ggPCIbs2iU9RbYECllVT
	lFJRbJwN62JoWbhabJ7q5s4r7Arwrcjrb2algiscKdM1LXZ3Apn1p+2ruoQN4ii6z01hiDNcIuy
	KO6BfzRHZW5Pq6n/Fyaivzh57Ra9+3vIFJb8SxD6KQ0gl832RVH9kZxzPHDOw==
X-Google-Smtp-Source: AGHT+IFSjSjMhiQMS8VWsflopktJGfhitDQ7FDIuh3kjk6gXUKkDDRLoGE3YnTJVra59glYzddWAuA==
X-Received: by 2002:a05:6000:707:b0:385:decf:52bc with SMTP id ffacd0b85a97d-3862b36cbdfmr3822557f8f.32.1733519946936;
        Fri, 06 Dec 2024 13:19:06 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3cee:9adf:5d38:601e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fd46839sm5441302f8f.52.2024.12.06.13.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 13:19:06 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 06 Dec 2024 22:18:45 +0100
Subject: [PATCH net-next v13 20/22] ovpn: notify userspace when a peer is
 deleted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-b4-ovpn-v13-20-67fb4be666e2@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3261; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=2w03x074C1Ch4YmIvqL1EZXwi46cvkQyIQqVLlfb0iE=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnU2pYFD31m0FHJtYbIP1Xr9CYkOZ84DtmsU0MA
 5YphUs/wYqJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1NqWAAKCRALcOU6oDjV
 hyT1B/9QVLNiYUB7LCwNANozCQ7d15veqaLn+jNQWkQ+wZ1RFnGQ0b1Hutkech+hChL5/8gLsg0
 m+/4o+bTGabSktOQNTXgSIKwYVxPZbI+w7IQjs56tzc0GNbo0lEWdVR8Wv2kUnyo/MJmWdVRQGX
 fGodNpEunkhY79QV78Htny1gCmhK49jUH813G/4Uq2dI1pIbMy1l14ROu/wpYNx8Gz6ofoXc/QY
 EpSatp+DJVIFfLgBdZIzUrRB6PB7AnpW/FSPsLQhzaDpZQhPfIBgdzaKDrxwqqDCLsqeH4oMv1M
 qnOhI5HsX9NQfQJDielDxFkvIQrXcNufg1mde6+YCxOUqDUO
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
index 355cd3aa4849b518bc794152e6d9d0bce7ed0f6b..20e9d6b5e92c2647b00f8d50f508b5b1bd8d83d2 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1044,6 +1044,61 @@ int ovpn_nl_key_del_doit(struct sk_buff *skb, struct genl_info *info)
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
index 86caac747c6173672e4d3294639f60cd4138ac43..513b738364b9281861ea6b83a6330e78cbea5f4f 100644
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


