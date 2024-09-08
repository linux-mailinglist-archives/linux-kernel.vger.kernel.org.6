Return-Path: <linux-kernel+bounces-320211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDD797079E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC480282005
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 12:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8BC15F3F3;
	Sun,  8 Sep 2024 12:50:45 +0000 (UTC)
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96961E522
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725799844; cv=none; b=cZfIJ2Qc3wActFcklWeKBbm0yc7ZxRcvzsJLbcehQCpzQESq6IpOQQdj4KuVcBVzit+bS+Wp21Bz6cmITYihWNSUatIWKozuQxbDB1BEjjIhGPo6emSQ+jsQsDzqZ02jj+yILK0gy+FuhOp2FFDtVeG/MxyD3MBUC4jrqVTtlcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725799844; c=relaxed/simple;
	bh=hefThDtLX/Nk4YNwotWsCwXdIafqr3DbVSdifcpl4UA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pN63xGgU7Ehc5lReMnJONUUKilpPdBNf2538a2niYQ0l7fL5qPhhc73rHMN0T4BsA+GZZrGrv+ljkzMozsqd6EuM1HZen+Ojl6T2sdAHYNeOUM7lCj/33YRMeh7Eb9tDcioXO+PF6SJNgk2tkBroxD+Go/nqJKKZUIF5ZpJRZDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.65.196])
	by sina.com (10.185.250.22) with ESMTP
	id 66DD9D9300001051; Sun, 8 Sep 2024 20:50:29 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4317947602730
X-SMAIL-UIID: 1A63C8FDD5254558BEAF2C745CED631C-20240908-205029-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_connect (2)
Date: Sun,  8 Sep 2024 20:50:17 +0800
Message-Id: <20240908125017.2529-1-hdanton@sina.com>
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
@@ -3787,8 +3787,10 @@ static void hci_acldata_packet(struct hc
 	if (conn) {
 		hci_conn_enter_active_mode(conn, BT_POWER_FORCE_ACTIVE_OFF);
 
+		hci_req_sync_lock(hdev);
 		/* Send to upper protocol */
 		l2cap_recv_acldata(conn, skb, flags);
+		hci_req_sync_unlock(hdev);
 		return;
 	} else {
 		bt_dev_err(hdev, "ACL packet for unknown connection handle %d",
--

