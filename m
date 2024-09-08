Return-Path: <linux-kernel+bounces-320013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C46BA970509
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 06:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFF21F220FC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 04:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D880A3715E;
	Sun,  8 Sep 2024 04:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="x1tVaZg7"
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DAA28FC
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 04:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725768749; cv=none; b=ekGQ3fSGIaMeotQoQgv7J2Xb5ZDwZpC5WoVDsRGQ0ONrZ/gQrgBYyHwbMzQVN92e5HiQKTp5SdNBIonRWT4o/EpvEufm8n7kxtECSBqW+7evHBPJKtdq4lpOvVotSCawDbib1g7TkB2rgnsY3hf94e3qIfKxmBS/LTFMCA4WZ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725768749; c=relaxed/simple;
	bh=I2l+dZYtO8xyYvTz31QPDr8MCIHGQZpOifbU9r4yhD4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=bldk6ALjydm/RsVx1rcas9zv50H70toi8FWwLkUtbflOu15UcRUg0E/3bRaymWtcLoWZ+U37r6c5F22MwdmzoHDABMFE0b4pdbHw4hmJ4jKuTfo+GcqvPd+I7EBBK2Lv23MxbYiN3K8mCzXPokGk16fVws05S4uFmc3A9uSjdpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=x1tVaZg7; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725768443; bh=5hCDN02vHnOzZJpY4KkDHbaWuVRAbHOGnN3wGSWztQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=x1tVaZg7Qcu0JUM1uIClnL3Wa9p29nbmqfePAuG45ZY5WcC6up/z6i75qPfXIdznr
	 Q3uvnHsebeGApwgvnJH5bMIRsB6Z2QkJP4Y5SY3sn5Xd4h9har7dJC7vyr+O/uSYuG
	 0TveQYpdRmwTgBJB+ZqqHhAKnB0Qb10THdHvsFlc=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 1D5230C8; Sun, 08 Sep 2024 12:07:21 +0800
X-QQ-mid: xmsmtpt1725768441t369304jx
Message-ID: <tencent_6352E6C65F89856EFC6EC18C92E7CCC6FF06@qq.com>
X-QQ-XMAILINFO: OQhZ3T0tjf0aOFsS0p9Z35/zGR0mI2pgyKINPT8KhlimFwfi22o0+IuOyHEeCk
	 8dNWSSDQdYY6JS3YJogMD1UrJY2e0xsoXTTl1EMuYLcpfUDapwCgirJjOhb3hrVv2kWdJsHZHGJe
	 /4iQ5p4WIkE7mQj+lw8jeDlN8uaH8QGP9c6TMT3FFhJvfpWuWqmeNudIBGxLN9ttXXiyWa0Ah7gL
	 Ib7PARq2MVBSJk6+xXTWXbsSYsp3ngDgVzJHQ7w066lEGJmhRH78yddwRsm2/hsCqrlFQYq16KcQ
	 VPhhbh5/u3MOleQ93UbNbK6ztk03Shj1w1pMU7pRHPVYXU01s3hMhJ9eEom2b+p7LYfI+3a3LtbK
	 OEmfvh9K/NxVDGq1An+tCFaBCTizXqAp6SLJGo9R+UknUaB0uS6mbo7RhP1BVL8oNySkN5inABB5
	 x6M9iLt4zItqni3Hg/egU+BYvSnk3fI6/JKPJ+IFVYwa4/VGZQFLQL9gLzT9G7pf5NncD0x1FdRH
	 5nXLVQVBu1Rr89dq7Aw2ZNUqOaYrx6izXCvrryC13SV4cjNJYrEkSFlMjbxcbNLzu+HRLm8Fj3pd
	 4+phVekyEmOhIc7LcyndkmX5SV8AsYQzwTc+iQyrSNnIVWjBFd+3OXh2tIKZJo84840EuhMcEnKz
	 rBhnyC/Tzzkiuy0RHvOebrUyqsWmK5BF0uVfatI71Byh+qbUv2KpAkHWnTneO5fqAJIQ9uRzLzlo
	 kKDPQ4g8BeOFZA3FcuE3Igs7Na/FG1e0CvriJTBBhJdB/vKJC0zuM7bMY2GLbNzNoyzRvud1XYNo
	 Fuu+EeumsnVVXPP8UGTgI25rzSE+a/UGLnRhAgzIPB8su6C6E2lws8+BW93nMf4A9/Jgnp67WIsV
	 XsN9MzBpbm1eJh7UsdD4hAhCNj91XUwu2D6UvByiYbZ6/NB7FL0/GgwxNr2skgNw==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_connect (2)
Date: Sun,  8 Sep 2024 12:07:21 +0800
X-OQ-MSGID: <20240908040720.1380618-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <0000000000004a130a0621888811@google.com>
References: <0000000000004a130a0621888811@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

after release conn, we need to cancle rx_work

#syz test

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f25a21f532aa..4f7b45bb863f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3776,18 +3776,19 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	hci_dev_unlock(hdev);
 
 	if (conn) {
 		hci_conn_enter_active_mode(conn, BT_POWER_FORCE_ACTIVE_OFF);
 
 		/* Send to upper protocol */
 		l2cap_recv_acldata(conn, skb, flags);
+		hci_dev_unlock(hdev);
 		return;
 	} else {
 		bt_dev_err(hdev, "ACL packet for unknown connection handle %d",
 			   handle);
 	}
+	hci_dev_unlock(hdev);
 
 	kfree_skb(skb);
 }
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9988ba382b68..b948b0a3b2f2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4072,10 +4072,8 @@ static int l2cap_connect_req(struct l2cap_conn *conn,
 	if (cmd_len < sizeof(struct l2cap_conn_req))
 		return -EPROTO;
 
-	hci_dev_lock(hdev);
 	if (hci_dev_test_flag(hdev, HCI_MGMT))
 		mgmt_device_connected(hdev, hcon, NULL, 0);
-	hci_dev_unlock(hdev);
 
 	l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP);
 	return 0;


