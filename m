Return-Path: <linux-kernel+bounces-217151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A307B90AC2D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBED1F29777
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0374194A7E;
	Mon, 17 Jun 2024 10:51:23 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9FB1BDCD
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718621483; cv=none; b=FNSq/x7st1iy0pYCJUe1ngBJPiApj6DvjTNsu1X6bK5tglzwcA/8HKtMbr7Vc6UKCbbnMBZLY8w8Jr3+8JAWwyunl0HvGaCp2R5RD9x3XqJUoO69JQ4UA2ny25LsTIHG9lyjOTQ9dGnnIW0+mLv4LVjm2zAIta3WDOEktT85rS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718621483; c=relaxed/simple;
	bh=Hj3WU1vz3B2EpqGyRen0bIQ9yuoD69u8qmfkHSsjK7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DIfdJ6iEfeZ5aSydndBlH1ytB6RoaQuWw0Ci1xAKBPn2lN89MwVhxJECEx6MidAQfSew96MxHUX5z0s09hcYBaCGIKlDinzlYbqp/snFhOAcUrGJBVb8KyTOVo1ZAUaqLC/vJM8oJzXDfBjl4eAWla3HZ0t1kVQ2bJuNYDvBZxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.85])
	by sina.com (10.185.250.22) with ESMTP
	id 66701492000068D1; Mon, 17 Jun 2024 18:48:52 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1884487602751
X-SMAIL-UIID: 135842A3F2374E3581B81F65E175E375-20240617-184852-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9486ac2c18a7693c45d6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in __lock_sock (2)
Date: Mon, 17 Jun 2024 18:48:41 +0800
Message-Id: <20240617104841.1588-1-hdanton@sina.com>
In-Reply-To: <000000000000758110061afed1c0@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 16 Jun 2024 02:53:18 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    cea2a26553ac mailmap: Add my outdated addresses to the map..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115da30a980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  cea2a26553ac

diff -pur c/include/net/bluetooth/l2cap.h d/include/net/bluetooth/l2cap.h
--- c/include/net/bluetooth/l2cap.h	2024-06-17 18:33:27.096664300 +0800
+++ d/include/net/bluetooth/l2cap.h	2024-06-17 18:34:47.465834700 +0800
@@ -612,6 +612,7 @@ struct l2cap_chan {
 	void			*data;
 	const struct l2cap_ops	*ops;
 	struct mutex		lock;
+	unsigned int		closed;
 };
 
 struct l2cap_ops {
diff -pur c/net/bluetooth/l2cap_core.c d/net/bluetooth/l2cap_core.c
--- c/net/bluetooth/l2cap_core.c	2024-06-17 18:32:21.249083200 +0800
+++ d/net/bluetooth/l2cap_core.c	2024-06-17 18:35:47.981139900 +0800
@@ -812,6 +812,7 @@ void l2cap_chan_close(struct l2cap_chan
 {
 	struct l2cap_conn *conn = chan->conn;
 
+	chan->closed++;
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
 
 	switch (chan->state) {
diff -pur c/net/bluetooth/l2cap_sock.c d/net/bluetooth/l2cap_sock.c
--- c/net/bluetooth/l2cap_sock.c	2024-06-17 18:31:43.431535400 +0800
+++ d/net/bluetooth/l2cap_sock.c	2024-06-17 18:41:00.785238900 +0800
@@ -1482,10 +1482,17 @@ static struct l2cap_chan *l2cap_sock_new
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	struct sock *sk = chan->data;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct l2cap_pinfo *pi;
 	int err;
 
+	l2cap_chan_lock(chan);
+	if (chan->closed) {
+		l2cap_chan_unlock(chan);
+		return -ENOMEM;
+	}
 	lock_sock(sk);
+	pi = l2cap_pi(sk);
+	l2cap_chan_unlock(chan);
 
 	if (chan->mode == L2CAP_MODE_ERTM && !list_empty(&pi->rx_busy)) {
 		err = -ENOMEM;
--

