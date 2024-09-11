Return-Path: <linux-kernel+bounces-324783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F2C9750D2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96F61F2390D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C206185B69;
	Wed, 11 Sep 2024 11:30:23 +0000 (UTC)
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63942156993
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726054222; cv=none; b=ABcYcrsRSG92X9kbIJcmwVlccC9Yb6pE4MJKAcAfMWmQDsp4Ly+EA2WMbZlNQeL5WRQ/SZvTZPxCiRVFdYbVtmv6zDHxJlWZkvxFLSbhhWV+LMOFYxM6cqY85xk/PnrgmRSWhLXDKnlWS4DkPR6xtEYLxGnanB+1QLBp2jDl7RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726054222; c=relaxed/simple;
	bh=IGN6E1zR+4fA1x5bkypmjCg8pHj0lfRPgko1tJCcsWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JjrEIGBX6R0jXQI2VozZVsBxCnH6hZQqUUpFmC/aaSCCD+ydvgirts9Dcdabd74IpleGCJH1hzh1nhOzq3mTs63wVneb+mSkoF8R8HxBvTEFTXTypKLN+IaxBUlxc4uLehxGWrAtET86Hl8AcwJTRiD1dF3JWaegcLr9h18RLCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.131])
	by sina.com (10.185.250.24) with ESMTP
	id 66E17F3E000025A0; Wed, 11 Sep 2024 19:30:09 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5650910748381
X-SMAIL-UIID: 90D3498D0EE64749892DD0B384CE9CAC-20240911-193009-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_connect (2)
Date: Wed, 11 Sep 2024 19:29:58 +0800
Message-Id: <20240911112958.2845-1-hdanton@sina.com>
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

--- x/net/bluetooth/hci_core.c
+++ y/net/bluetooth/hci_core.c
@@ -3782,6 +3782,8 @@ static void hci_acldata_packet(struct hc
 
 	hci_dev_lock(hdev);
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
+	if (conn)
+		hci_conn_get(conn);
 	hci_dev_unlock(hdev);
 
 	if (conn) {
@@ -3789,6 +3791,7 @@ static void hci_acldata_packet(struct hc
 
 		/* Send to upper protocol */
 		l2cap_recv_acldata(conn, skb, flags);
+		hci_conn_put(conn);
 		return;
 	} else {
 		bt_dev_err(hdev, "ACL packet for unknown connection handle %d",
--- x/net/bluetooth/l2cap_core.c
+++ y/net/bluetooth/l2cap_core.c
@@ -1792,13 +1792,10 @@ static void l2cap_conn_del(struct hci_co
 
 	mutex_unlock(&conn->chan_lock);
 
-	hci_chan_del(conn->hchan);
-
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
 		cancel_delayed_work_sync(&conn->info_timer);
 
 	hcon->l2cap_data = NULL;
-	conn->hchan = NULL;
 	l2cap_conn_put(conn);
 }
 
@@ -1806,6 +1803,7 @@ static void l2cap_conn_free(struct kref
 {
 	struct l2cap_conn *conn = container_of(ref, struct l2cap_conn, ref);
 
+	hci_chan_del(conn->hchan);
 	hci_conn_put(conn->hcon);
 	kfree(conn);
 }
@@ -4073,11 +4071,15 @@ static int l2cap_connect_req(struct l2ca
 		return -EPROTO;
 
 	hci_dev_lock(hdev);
+	if (hcon->state == BT_CLOSED) {
+		hci_dev_unlock(hdev);
+		return -EPROTO;
+	}
 	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		mgmt_device_connected(hdev, hcon, NULL, 0);
-	hci_dev_unlock(hdev);
 
 	l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP);
+	hci_dev_unlock(hdev);
 	return 0;
 }
 
@@ -7486,6 +7488,14 @@ void l2cap_recv_acldata(struct hci_conn
 	if (!conn)
 		goto drop;
 
+	hci_dev_lock(hcon->hdev);
+	if (conn != hcon->l2cap_data)
+		conn = NULL;
+	else
+		l2cap_conn_get(conn);
+	hci_dev_unlock(hcon->hdev);
+	if (!conn)
+		goto drop;
 	BT_DBG("conn %p len %u flags 0x%x", conn, skb->len, flags);
 
 	switch (flags) {
@@ -7512,6 +7522,7 @@ void l2cap_recv_acldata(struct hci_conn
 		if (len == skb->len) {
 			/* Complete frame received */
 			l2cap_recv_frame(conn, skb);
+			l2cap_conn_put(conn);
 			return;
 		}
 
@@ -7576,6 +7587,8 @@ void l2cap_recv_acldata(struct hci_conn
 
 drop:
 	kfree_skb(skb);
+	if (conn)
+		l2cap_conn_put(conn);
 }
 
 static struct hci_cb l2cap_cb = {
--

