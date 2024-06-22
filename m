Return-Path: <linux-kernel+bounces-225600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AE89132BD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 10:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2510B2848C2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 08:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B598A14C596;
	Sat, 22 Jun 2024 08:25:07 +0000 (UTC)
Received: from smtp134-33.sina.com.cn (smtp134-33.sina.com.cn [180.149.134.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB131335B5
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719044707; cv=none; b=V4Myksvpcmh86E0hkyfFlUgEbOdQ2vTvC/nr+quWtv93AYxC4UrkAI3X7WFtPWfAd02SMWmcux3k/I15jUrBw9b3Rn6urHePZ0+qSZa9zNVzfsILh9quN627zyEb45FMB8+fkpzI2y5zklLoFoRAhckSSPeGChtkS08rFOP1R2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719044707; c=relaxed/simple;
	bh=WQIORIFbZnT250aT0KuLkNng9TdmYTfcOsh3bV8Jfpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CAEoxf4jFcdO8zCTYcniwVxEPj4H0TYJ3ixfqYc9z491mT5RNm241CHEB67uBeyUdVYcfqA5ioNZKonqCpqphuzIM5Z+eku9BXAqw0usdpcLIjFJ5qouFC1yxuRVOgAMgTneV66Feg/fL/t5XOaaRkP0lHNOjosowvdCbpHRbQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.178])
	by sina.com (10.185.250.21) with ESMTP
	id 66768A4A0000061D; Sat, 22 Jun 2024 16:24:45 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3574463408376
X-SMAIL-UIID: 30755088F6ED4C5CAF65F705BCFF430F-20240622-162445-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] general protection fault in l2cap_sock_recv_cb
Date: Sat, 22 Jun 2024 16:24:33 +0800
Message-Id: <20240622082433.1865-1-hdanton@sina.com>
In-Reply-To: <000000000000b0906d061a468b93@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  cc8ed4d0a848

--- x/net/bluetooth/l2cap_core.c
+++ y/net/bluetooth/l2cap_core.c
@@ -6756,6 +6756,7 @@ static void l2cap_conless_channel(struct
 {
 	struct hci_conn *hcon = conn->hcon;
 	struct l2cap_chan *chan;
+	int rc;
 
 	if (hcon->type != ACL_LINK)
 		goto free_skb;
@@ -6767,6 +6768,8 @@ static void l2cap_conless_channel(struct
 
 	BT_DBG("chan %p, len %d", chan, skb->len);
 
+	l2cap_chan_lock(chan);
+
 	if (chan->state != BT_BOUND && chan->state != BT_CONNECTED)
 		goto drop;
 
@@ -6777,15 +6780,15 @@ static void l2cap_conless_channel(struct
 	bacpy(&bt_cb(skb)->l2cap.bdaddr, &hcon->dst);
 	bt_cb(skb)->l2cap.psm = psm;
 
-	if (!chan->ops->recv(chan, skb)) {
-		l2cap_chan_put(chan);
-		return;
-	}
+	rc = chan->ops->recv(chan, skb);
 
 drop:
+	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
+	if (rc) {
 free_skb:
-	kfree_skb(skb);
+		kfree_skb(skb);
+	}
 }
 
 static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
--- x/net/bluetooth/l2cap_sock.c
+++ y/net/bluetooth/l2cap_sock.c
@@ -1237,6 +1237,7 @@ static void l2cap_sock_kill(struct sock
 	if (!sock_flag(sk, SOCK_ZAPPED) || sk->sk_socket)
 		return;
 
+	l2cap_pi(sk)->chan->data = NULL;
 	BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
 
 	/* Kill poor orphan */
@@ -1481,11 +1482,16 @@ static struct l2cap_chan *l2cap_sock_new
 
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
-	struct sock *sk = chan->data;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct sock *sk;
+	struct l2cap_pinfo *pi;
 	int err;
 
+	if (!chan->data)
+		return -ENXIO;
+
+	sk = chan->data;
 	lock_sock(sk);
+	pi = l2cap_pi(sk);
 
 	if (chan->mode == L2CAP_MODE_ERTM && !list_empty(&pi->rx_busy)) {
 		err = -ENOMEM;
--

