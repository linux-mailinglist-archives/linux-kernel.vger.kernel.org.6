Return-Path: <linux-kernel+bounces-320066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF739705CF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD69BB21B54
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 08:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A256A136337;
	Sun,  8 Sep 2024 08:33:12 +0000 (UTC)
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0CE7D07D
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725784392; cv=none; b=fjBSspLWfLqwNgpZrrEg3g2wLPrzgeZ54TvN3EBp1m3PBasxJsRMTeeHu01d4Jida1G+xFvdcS9AkMmXWHiKao+xjz2imHJaDKkBrCPzxNaPKS63hiMr1vbNgazJnHeTUWjInsifuuai4ZcLVWg05xmakJHUgWbX4hpteCYDf5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725784392; c=relaxed/simple;
	bh=JM6sWCaxiUXtNMP7Bmj/fVAfIlGVpMuithZEfIDgzDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=axXwG0bqffFbDSKV4Q9CMnbKC9QiUDP/jrSbY+IytCalaUEgASbImUXqS7elyAkEFEbO98NYf7HUNRWT0dAIhUrcbz7wLgLvdASDC9ZhKxnwCfD6CxXFW/PYRfaSXt8ZLZgptUB+idE/+PmURVVIgfwheYicm5Wht377JsjVcyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.65.196])
	by sina.com (10.185.250.24) with ESMTP
	id 66DD613800000795; Sun, 8 Sep 2024 16:32:58 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 79833410748088
X-SMAIL-UIID: 9062114413BC429FBD1FD941F0267B94-20240908-163258-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_connect (2)
Date: Sun,  8 Sep 2024 16:32:46 +0800
Message-Id: <20240908083246.2329-1-hdanton@sina.com>
In-Reply-To: <0000000000004a130a0621888811@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 07 Sep 2024 07:42:26 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    788220eee30d Merge tag 'pm-6.11-rc7' of git://git.kernel.o..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1304189f980000

#syz test

--- l/net/bluetooth/l2cap_core.c
+++ c/net/bluetooth/l2cap_core.c
@@ -1747,6 +1747,8 @@ static void l2cap_unregister_all_users(s
 	}
 }
 
+static DEFINE_MUTEX(l2cap_conn_del_mutex);
+
 static void l2cap_conn_del(struct hci_conn *hcon, int err)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
@@ -1797,8 +1799,10 @@ static void l2cap_conn_del(struct hci_co
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
 		cancel_delayed_work_sync(&conn->info_timer);
 
+	mutex_lock(&l2cap_conn_del_mutex);
 	hcon->l2cap_data = NULL;
 	conn->hchan = NULL;
+	mutex_unlock(&l2cap_conn_del_mutex);
 	l2cap_conn_put(conn);
 }
 
@@ -7480,11 +7484,21 @@ void l2cap_recv_acldata(struct hci_conn
 	struct l2cap_conn *conn = hcon->l2cap_data;
 	int len;
 
-	if (!conn)
+	if (!conn) {
 		conn = l2cap_conn_add(hcon);
-
-	if (!conn)
-		goto drop;
+		if (!conn)
+			goto drop;
+		l2cap_conn_get(conn);
+	} else {
+		mutex_lock(&l2cap_conn_del_mutex);
+		conn = hcon->l2cap_data;
+		if (conn)
+			if (!kref_get_unless_zero(&conn->ref))
+				conn = NULL;
+		mutex_unlock(&l2cap_conn_del_mutex);
+		if (!conn)
+			goto drop;
+	}
 
 	BT_DBG("conn %p len %u flags 0x%x", conn, skb->len, flags);
 
@@ -7512,6 +7526,7 @@ void l2cap_recv_acldata(struct hci_conn
 		if (len == skb->len) {
 			/* Complete frame received */
 			l2cap_recv_frame(conn, skb);
+			l2cap_conn_put(conn);
 			return;
 		}
 
@@ -7576,6 +7591,8 @@ void l2cap_recv_acldata(struct hci_conn
 
 drop:
 	kfree_skb(skb);
+	if (conn)
+		l2cap_conn_put(conn);
 }
 
 static struct hci_cb l2cap_cb = {
--

