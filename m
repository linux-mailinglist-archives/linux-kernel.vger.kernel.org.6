Return-Path: <linux-kernel+bounces-393108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EB49B9BEC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 02:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87432B21898
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331423F9D5;
	Sat,  2 Nov 2024 01:27:38 +0000 (UTC)
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7553B38DE9
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 01:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730510857; cv=none; b=NJzKR4GWGb2EfryWBHYcEXVeQ6fIKDLxjUx4/ZQukLtUbhYaq1vVgTxwg46Pd+W1qK3vdn5l6vOCt6XPFKIbO32bSC4joIliJr2vvN1rGtsBRJZzGfBiPdyvgma/ByiESFubq9seO5sBfd/7Ycguoo3ENqxw/uLNodXMNJOWeW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730510857; c=relaxed/simple;
	bh=+ZpEb4XXWHgHI6O0CFwQFk6PvzIXF7ri9pVNIpmXqSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Id7f4zpWOJoxvmIIGirrM3Pa7zwdqhgkreWsHVMfl9FJsi463nEL9B4E0XlbmSc+T82dIPUA+NevagYEPTWHL17jFNcIx7ilzbIMcdXQpy+mQF9TdDEeSM2bn5slEBA+YZRPYRIfMgu07dvv+PAFChHou70KVCIELt8Hx/NTBp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.22])
	by sina.com (10.185.250.22) with ESMTP
	id 67257FF50000683C; Sat, 2 Nov 2024 09:27:22 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9907477602706
X-SMAIL-UIID: 33F27C514AE541DE86C4CC01BC2C4A83-20241102-092722-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_unregister_user
Date: Sat,  2 Nov 2024 09:27:10 +0800
Message-Id: <20241102012710.2865-1-hdanton@sina.com>
In-Reply-To: <67251e01.050a0220.529b6.0162.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 01 Nov 2024 11:29:21 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    90602c251cda Merge tag 'net-6.12-rc6' of git://git.kernel...
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bd9340580000

#syz test

--- l/net/bluetooth/hidp/core.c
+++ y/net/bluetooth/hidp/core.c
@@ -1302,6 +1302,7 @@ static int hidp_session_thread(void *arg
 	 * delete the session.
 	 */
 	l2cap_unregister_user(session->conn, &session->user);
+	hci_dev_put(session->conn->hcon->hdev);
 	hidp_session_put(session);
 
 	module_put_and_kthread_exit(0);
@@ -1378,6 +1379,7 @@ int hidp_connection_add(const struct hid
 	ret = l2cap_register_user(conn, &session->user);
 	if (ret)
 		goto out_session;
+	hci_dev_hold(conn->hcon->hdev);
 
 	ret = 0;
 
@@ -1405,8 +1407,10 @@ int hidp_connection_del(struct hidp_conn
 				       HIDP_TRANS_HID_CONTROL |
 				         HIDP_CTRL_VIRTUAL_CABLE_UNPLUG,
 				       NULL, 0);
-	else
+	else {
 		l2cap_unregister_user(session->conn, &session->user);
+		hci_dev_put(session->conn->hcon->hdev);
+	}
 
 	hidp_session_put(session);
 
--

