Return-Path: <linux-kernel+bounces-320237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 458D79707DB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 15:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03D26284907
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A49916C448;
	Sun,  8 Sep 2024 13:38:18 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7021C2F2C
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725802698; cv=none; b=k9dhK971LuHiOiQ8DLUk030z0RA7omno15VkXHbDqN0AnkNZHANBM13STVyMz2eiebep+AtrVuA+ZYCUZZcb3pWXbm2Qy8r83AQFAU9kyyzcgl4qNakmBF1M7aBLddkB7X4egdvOiMN/hQzubM3ZBuUYqLQGAjS+r0tWlMOsXWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725802698; c=relaxed/simple;
	bh=2bRdqF1sR3IosEDcQcM6xUizaPsR36HeYnAmt6yG7hU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r1GnPsc/1ZJKtY0niZe7gm/iJEtjuBedVEduRCUg4quDT9PEBT1eHFYex0BRlcSFXxrbotke8UbYAN+wwrl5tMf+ZkawYJ2WoJN/3WIvtoT5eGrIN7rZpwSDt/WIYESVNr/s5SyTQPMmohYIp7y8t3PesaEUw/4Nut2HnEfOqmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.65.196])
	by sina.com (10.185.250.23) with ESMTP
	id 66DDA8B600005F9E; Sun, 8 Sep 2024 21:38:01 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4490698913388
X-SMAIL-UIID: 27D844117B5E4FB8B7EE030CC8D55A4F-20240908-213801-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_connect (2)
Date: Sun,  8 Sep 2024 21:37:47 +0800
Message-Id: <20240908133747.2610-1-hdanton@sina.com>
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
@@ -3782,13 +3782,18 @@ static void hci_acldata_packet(struct hc
 
 	hci_dev_lock(hdev);
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
+	if (conn)
+		hci_conn_get(conn);
 	hci_dev_unlock(hdev);
 
 	if (conn) {
 		hci_conn_enter_active_mode(conn, BT_POWER_FORCE_ACTIVE_OFF);
 
+		hci_req_sync_lock(hdev);
 		/* Send to upper protocol */
 		l2cap_recv_acldata(conn, skb, flags);
+		hci_req_sync_unlock(hdev);
+		hci_conn_put(conn);
 		return;
 	} else {
 		bt_dev_err(hdev, "ACL packet for unknown connection handle %d",
--

