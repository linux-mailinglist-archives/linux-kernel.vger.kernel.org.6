Return-Path: <linux-kernel+bounces-219085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E8E90C9BE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE0828482E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4161C176251;
	Tue, 18 Jun 2024 10:46:06 +0000 (UTC)
Received: from smtp134-33.sina.com.cn (smtp134-33.sina.com.cn [180.149.134.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B371CAB0
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718707565; cv=none; b=s5u1J/8p+nfl2brHnMpMCG0lMBLrL8fhWoQK+W7qWIaOOP9N2uF6OnAML7rqLHK9DGJUZK4eb8yJieM/wycDGWW6o5SFBz4xyktUWY66ajmCc0iseGhutt1hxzkRtx20QgRbBBpfICYlQuwigYDNJDNQ3sYF01rycD8ZWZ6loMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718707565; c=relaxed/simple;
	bh=yApoxQZ2WPbvyZo7+YIpsjIS6C6r7bZMCNi318Bm2/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fbRTjO01VbYbryaO93+tFkLRB5kO3FiVCGfxV7YPrsCBSMx85J/WwCzjR2j/r5AYDLSUcGm0h0PG8rVzuqPr/mUetY1YP732D2hA9clA70AvNlRB9OLL/LIH5ZiMbC+GWLvnUs08ZUMmPTxlC+57XtZNGPXxvp5VpGhrjyzSAio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.67.77])
	by sina.com (10.185.250.21) with ESMTP
	id 6671655A00000FCE; Tue, 18 Jun 2024 18:45:48 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7131343408425
X-SMAIL-UIID: 7E443357749D4F3E9BFC42CA4551A706-20240618-184548-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+49092daf3dd0a57f9e73@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] general protection fault in l2cap_publish_rx_avail
Date: Tue, 18 Jun 2024 18:45:38 +0800
Message-Id: <20240618104538.1648-1-hdanton@sina.com>
In-Reply-To: <0000000000005346b4061b1c8f49@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 17 Jun 2024 14:22:17 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b077ee980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  2ccbdf43d5e7 

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

