Return-Path: <linux-kernel+bounces-321237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8A0971647
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21DCA1C22CBD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8491B581C;
	Mon,  9 Sep 2024 11:07:46 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B370C1B5339
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725880066; cv=none; b=Ksato/Pe0dk+5Ut+L3GF2bDLAv+epB5bZhTA4K3bLS7BiB9KOqsZhw6xfsbh7Trn75z/Fwkvq8FgNPaFP/aAgfHOWygjQKVmY0jwcX1DrH9MHWhaWOhrcJMZQEpy4bF+InBD5ah+HQLjuNVYS8Aa+Lfs40dzgtpu5SjC9+UuNd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725880066; c=relaxed/simple;
	bh=IPiWNpyDUFRtmv1iyc3MzPeXqJejYWeCZmhtxSBl+M0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fRySumzFeB1B/DwjHYbGAQ8p96voxpHk9TwcFD3wEwYaBEbCSRcqt+IAzfY6JDgHjAMSyDnyUCO3rnr4ooD9cQwaMJkEviqCCLneoXAvqY7uqFdjhOK4xZM8AI9ViFHfTC0IbQe7+Vpq3+Bso3yJ1vFol7hHwTpSui82QNmD4fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.122])
	by sina.com (10.185.250.23) with ESMTP
	id 66DED6CB000005B6; Mon, 9 Sep 2024 19:06:54 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3876388913418
X-SMAIL-UIID: C74116825ECD4B89A53528549BD3FC77-20240909-190654-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_connect (2)
Date: Mon,  9 Sep 2024 19:06:41 +0800
Message-Id: <20240909110641.2729-1-hdanton@sina.com>
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
@@ -7486,6 +7484,14 @@ void l2cap_recv_acldata(struct hci_conn
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
@@ -7512,6 +7518,7 @@ void l2cap_recv_acldata(struct hci_conn
 		if (len == skb->len) {
 			/* Complete frame received */
 			l2cap_recv_frame(conn, skb);
+			l2cap_conn_put(conn);
 			return;
 		}
 
@@ -7576,6 +7583,8 @@ void l2cap_recv_acldata(struct hci_conn
 
 drop:
 	kfree_skb(skb);
+	if (conn)
+		l2cap_conn_put(conn);
 }
 
 static struct hci_cb l2cap_cb = {
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
--

