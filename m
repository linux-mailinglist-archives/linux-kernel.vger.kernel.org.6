Return-Path: <linux-kernel+bounces-320157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A23919706CA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BA1DB21676
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F08914D715;
	Sun,  8 Sep 2024 11:15:36 +0000 (UTC)
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAC536B0D
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725794136; cv=none; b=eCXKFaUgnP7MxEXUeuC4Vg0SaVw3J6F4xwvFOpoVD2AgcYxo4eWywWKSutDVJE8viKxAdgyRxwLVRXhI4UNAwsA5ipVOwCitOyLli37z/dlkdBFy66qo3KbR5+nD6PwAqsQPZg0c8RTQOxvvWYu7Cy4pZPbs21Knp6jqypb1VrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725794136; c=relaxed/simple;
	bh=w/PM+27W4wly9VN1ft91DuizPLDIduCoyAjJ/gt+yLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EPLutMLM27jXbvm/v638o7h29PmtZP+kF02YmpUWKVqrtuFXhvwemYHuEA7PB2ZFxrYaMq7Ob35xCIYSk/nAx3ZO4cV0qh6aUJImuMfFJVbSzZH/M4SkpOxpBwrmpgx4DqAAWQax4RwpL68sm1LAOYHxI/EWnLXiah+oUgjlJa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.65.196])
	by sina.com (10.185.250.24) with ESMTP
	id 66DD874D00002549; Sun, 8 Sep 2024 19:15:27 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 52991110748395
X-SMAIL-UIID: E2BC172ABB924FAE876B1DEAEE557DB5-20240908-191527-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_connect (2)
Date: Sun,  8 Sep 2024 19:15:15 +0800
Message-Id: <20240908111515.2457-1-hdanton@sina.com>
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
@@ -1792,14 +1794,15 @@ static void l2cap_conn_del(struct hci_co
 
 	mutex_unlock(&conn->chan_lock);
 
-	hci_chan_del(conn->hchan);
-
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
 		cancel_delayed_work_sync(&conn->info_timer);
 
+	mutex_lock(&l2cap_conn_del_mutex);
 	hcon->l2cap_data = NULL;
+	hci_chan_del(conn->hchan);
 	conn->hchan = NULL;
 	l2cap_conn_put(conn);
+	mutex_unlock(&l2cap_conn_del_mutex);
 }
 
 static void l2cap_conn_free(struct kref *ref)
@@ -7480,6 +7483,7 @@ void l2cap_recv_acldata(struct hci_conn
 	struct l2cap_conn *conn = hcon->l2cap_data;
 	int len;
 
+	mutex_lock(&l2cap_conn_del_mutex);
 	if (!conn)
 		conn = l2cap_conn_add(hcon);
 
@@ -7512,6 +7516,7 @@ void l2cap_recv_acldata(struct hci_conn
 		if (len == skb->len) {
 			/* Complete frame received */
 			l2cap_recv_frame(conn, skb);
+			mutex_unlock(&l2cap_conn_del_mutex);
 			return;
 		}
 
@@ -7576,6 +7581,7 @@ void l2cap_recv_acldata(struct hci_conn
 
 drop:
 	kfree_skb(skb);
+	mutex_unlock(&l2cap_conn_del_mutex);
 }
 
 static struct hci_cb l2cap_cb = {
--

