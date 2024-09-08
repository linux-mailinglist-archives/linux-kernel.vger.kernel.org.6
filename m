Return-Path: <linux-kernel+bounces-320004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 588729704F9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 05:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00EB41F21EC1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 03:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD81922638;
	Sun,  8 Sep 2024 03:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jpWBzJ/n"
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0730B11C92
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 03:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725765697; cv=none; b=T/levdXAYRN0mdBzVkJFHOzg1ww8BWq8YhCnMs7mKANekrgv/AGEt50XlzmPz40W0KfjhA3tewO+/tZd5D1fAK3tI2i3xfqJsar0qPjzyCYQK0fpCd1lF3IER+RPSE4rn0B3Kiz1dLcQxeBJ/bWjtoAPQBEM0Kc2uBWSfYN7Rls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725765697; c=relaxed/simple;
	bh=ostqFxmtpDqQc7Dg9xf3SBNDQtoJdq/Ru9fUGaTfJvE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=GDEHCJznKtX212E15/SZWtxRq0L+eh3uoL0nIT06vm8JaZHUqlrDkO8W1aIL77kgQa7PdAUkSOXJLHSKCpzQQzx4QjRCyCX4YBGQ9zdzweZMi8nurimzyz0n3EXJwiaAzYsXjXs/k4S+zxEK8SjGI5F8vSC02uiSQioN7+gmieg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=jpWBzJ/n; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725765692; bh=qQoc9TWRF8Fcv8tdfcnwwwYSIt0xHTdd4ONoTIHghu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jpWBzJ/nTGc0FBX8LdOI/QuqsfX6wLkoFakSBuPG6LwMnemGG+TgZe5FWUyd4akUh
	 cP3uQoCy4Ecn6lTjIuujby4ondJkXSn2DRuxIUMmU7+4Nsu2yclrzPQeZvTqeRmx/L
	 32SkAB1DXFDZeXwRvT/eCaTUvD7eSg3D8KKISumc=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 3D42BA3E; Sun, 08 Sep 2024 11:15:20 +0800
X-QQ-mid: xmsmtpt1725765320tssqofoe1
Message-ID: <tencent_716CE97A03B68449F760577CC6C6336E2305@qq.com>
X-QQ-XMAILINFO: NvKyM24IHTKS82gOX5jqS7t05/XEnWpky2PW8I7ubsN+DMluluNW0sL3To3Mra
	 iO9ARJ7nhxYkqTQJzR/pmkarjbYoMM7CavX9Yiosk2NMzBlAyTT0qoKISBnJPDRKEJV7qJW7wYpY
	 o62ncQvb7sChT6+COCVOssiu2ZZWvCVHm6VUa1BRmoLxC81QQImufBr6Jh6WQAd8wlqanzSBFWb/
	 BoYsfB+ZVD6dnBipJyPlHDWiZgVAL8Z9HbJxKMu2RTYvqp7La55qoyfxMmF4zlFprHS/lYafuGIZ
	 ZGbmk9u+M5FfMX6enLgFDE5pX4hhC1jzfv6ebIfgV1xWaJrBi+S1sbx4+oGRE/MfdPL0784ImKes
	 lLS8jawjMIN+kBXuP73TqNieZ1G6kJhpSTo0k1FAjBypIrSrDBKXUSIijEeFYQhEJDazml08RNpr
	 dVvsOsD43955jKcocy3Lui/uK/7w+3kx4jfvAq4TsIgdxOgFRUKlxS2PoU94zwVLY7RmueG3h+1j
	 XI4zb7LRFB/bXswtz3/AdG6V8ZhZjja2bdO10T8GIFeI7bDueknMpLSzt3+30ZhpaRnGpE9+WWUr
	 9W90FP8IvdN3wN4HbHOyBPvMzAXnvKCpYl38/jGpl0BR4Ar4ei86Bw4QrzAZHWPcYkLMQGHQ7BUd
	 IvFmRvITB7/LF+uD7R0Ax+a+O/1OCUmQd6PuPiiwzOx54mqxHd2KDsf4yIb7dPn+EUqIkU2xoLMe
	 8lcYe0NaUj3+dMtQP56KJ+QQDUFaC/bRPTMPYL3pWNGBWsEdbQh/XdjYE4V6nx6Vg0zeOOPP7FuC
	 6fS9eY9EC6JNmI875DX6JIGivb0J4Q65soQ2ctYlXGS4bYeL+GRDpiJE2Iboff6N8wurvL2zCcup
	 YwxD3GZsSj3CX7Yykbs6tEQd4nhjjnW7QairEQJUzegjSYReWenck/z7wmAWPM3XP2kFVcOQxh
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_connect (2)
Date: Sun,  8 Sep 2024 11:15:20 +0800
X-OQ-MSGID: <20240908031519.1338677-2-eadavis@qq.com>
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


