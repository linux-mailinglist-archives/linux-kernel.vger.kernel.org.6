Return-Path: <linux-kernel+bounces-320007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E997F9704FE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 05:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76FAAB21B9F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 03:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFB42B9B3;
	Sun,  8 Sep 2024 03:26:11 +0000 (UTC)
Received: from smtp134-33.sina.com.cn (smtp134-33.sina.com.cn [180.149.134.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DBB22638
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 03:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725765970; cv=none; b=CW49S+Z5cQkHXFMyJzrSYae8U0mmRTyQGo5DT/USEXTR3vNMyO+MSxfAoen5iIr9ZMuJPBflWTom0maolZCVRVzcyS859KySgB0m+HTQSc8md8i2CBFOiXvuLONVNlCNVK5m+RBf5oiOLJnpw/U+1958vRUUvcpLaRBaS3WQTYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725765970; c=relaxed/simple;
	bh=+vPd2FYmwdp+ujT82fQtwcQQs8nbSJnHG2HvVKwJXT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oZWZmN8w8AcnyGNc/sEbUubprwJ369+dJG0NOXVfsiVcEblemsTIZhOGu4107wjd3AmfKVHhK+vb1LIZI2uyMeF9MNZul/2VLCwRy5QiJc0b14ykNgA2WSuxHhUt3vhblirr7CsFpMQ3nbCiF5DYSgj4S7jXO4sA7p8S+9bLsts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.65.196])
	by sina.com (10.185.250.21) with ESMTP
	id 66DD193E0000313C; Sun, 8 Sep 2024 11:25:52 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9152453408424
X-SMAIL-UIID: 5F131371AFAA4602B3D14B7C6CA5A000-20240908-112552-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_connect (2)
Date: Sun,  8 Sep 2024 11:25:40 +0800
Message-Id: <20240908032540.2276-1-hdanton@sina.com>
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
+		2cap_conn_put(conn);
 }
 
 static struct hci_cb l2cap_cb = {
--

