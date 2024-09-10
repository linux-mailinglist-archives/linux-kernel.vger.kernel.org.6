Return-Path: <linux-kernel+bounces-322357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 737D09727C1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A62FC1C2372A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0B113C9D9;
	Tue, 10 Sep 2024 04:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="HJsr55+q"
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745B84430
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 04:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725940849; cv=none; b=FU4Rl1lRmSM44i5j2V2OsrFMILxua1n8bJStJQBaOSjo5HJQPIZBHdR95n/1AOcMZvBKyYKDR9NFPD5CGH9EtvmomkmRzsVNRzGaDgZRgaj2zOAy27AFHTWdGcdlv2vjHEm4NijFqByAALtTJ65qqHPc4KXUv62/NyjWA9ALldo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725940849; c=relaxed/simple;
	bh=lSIW3s+hdijq5cV1fJeL4k5xjoJ8+6jpYoJklWnzrEw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=bSf/21IR2qULWabZHp+G1avp9uKE23iv4pVrbp4hDBg9iqJd10Fl8l1jSCIOoW/8zD4rp74wfkdAEoFxV8RBJgaGbnQKifRSpmltVYJCtjOQxeppeSWhRQYMr+v+/Wx9QoDykRDKJCdyoKbzDdE9WM5IOLf7Oou9h08CSkIqPJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=HJsr55+q; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725940839; bh=eTzE04JbZxAPdFCndHmyKznGnfcP4KjrVgmrtycuJDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HJsr55+quvMEy+J4fVQOPYvgI10cb/hYuMWbYPt7mUOKdFL2GogtN0qdOyfFlsRpS
	 z/Ho0FaUG5hw1Gs8zTYSWXAlypqja5U2x5x+nB0XMrLhAhLRtQux/g9Si/+4Mai/hh
	 j5hE0vQVUOYVJt5xhiQEOPJWozCibhN13sD1s4Bw=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id D9CAD214; Tue, 10 Sep 2024 11:54:28 +0800
X-QQ-mid: xmsmtpt1725940468tzg5b3f7b
Message-ID: <tencent_B85DF6DDA2994D4FEB8DABA5AE0DB4122B07@qq.com>
X-QQ-XMAILINFO: MOpJcPT3Yy24miIkJWBEGg/Yvs6Eb91jpn0Bq9rKz6tDjiNNKqfiGXdLKsTW8D
	 G2CEu53UIUbacpN7q1i3SNy/OYiLj3LfRGjaOQVH5hTBJfrbas7pOgdPKQvZDgUBrO9W7r1+3BGU
	 XJWQ5qj+Dp4qdcIxcxMKOhhO20Kv2apeUyLFS/wrmhpE1I/zpSLxO6jdHDOPW+rkxHb6CeBKtPK8
	 6nmFWORN3SY3BW4rvmYCThHKe9rvEctrs5PX9jMpYIKoyxELynCmztSPvXfzmKtw3wmXhzGK93q4
	 4dn8cDMRrtKH3hDE+1n/DtfVkVGddONq86wjerwIwCHZPNcJ6gZjRVW/ZyEcDCSZ7dTyEy0sGBBa
	 FS61EeIACLGwCJwtiMNSjBQXOI5kyUEIcF30Z0aFgMBr0WAJeo4B3gM35BbGzonLKLcCLeC8q4iC
	 5Fm6yobe6YMc9vTltLGUDik9SZa+gspTZWDcY+BxpCojBE3S7kG29WQKYJnw4W6dPF6q0NnIj6NE
	 yg2T+ogvAJ2jyKYXoqJqfbfJxBYBk7lWQmxrgjNqKKdJoRaBNs+14ohzLK5Uz4ODS2b90aCpEuJV
	 J/ieVL/0HXyAJ88cFAfgS4naHl6q7E5dpG44v+grjhxWQ5I/fP5o6l6/7HT8ko9PbUhhJ5Uc5ni4
	 j+29JJdsmGU4ik7Bi5R45rMN6uc8m68lOtdCLi1HqxyaA/K167LVwjIw4+JVHiBZEDvzH/MX7zh8
	 IfYEQLNIJGUbGctXzjbMq7C9TKOGdBlItUtZI0CTX7d+7gy5herQsNa+3kuxBOCZDzy+3V/xMBjw
	 Z3FbZa5brqLMh7KdAC/sIW5bF53HbEuqZniQTxNFeDe0gg31bhfTGUOIAZV11AqVVwW5nk+RbJoZ
	 5vxBnu0rMJ5oEdEbnW9B2kBk6xghh8/RqMIt57BAe+CDS++rihf0Q=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [mptcp?] KASAN: slab-use-after-free Read in __timer_delete_sync
Date: Tue, 10 Sep 2024 11:54:29 +0800
X-OQ-MSGID: <20240910035428.2290576-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <000000000000b341bb062136d2d9@google.com>
References: <000000000000b341bb062136d2d9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

entry need to be protected by pm.lock.

#syz test

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3e4ad801786f..881d0772223e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -329,17 +329,25 @@ struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id)
 {
-	struct mptcp_pm_add_entry *entry;
 	struct sock *sk = (struct sock *)msk;
+	struct timer_list *add_timer = NULL;
+	struct mptcp_pm_add_entry *entry;
 
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	if (entry && (!check_id || entry->addr.id == addr->id)) {
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
+		add_timer = &entry->add_timer;
+	}
+	if (!check_id) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry && (!check_id || entry->addr.id == addr->id))
-		sk_stop_timer_sync(sk, &entry->add_timer);
+	/* no lock, because sk_stop_timer_sync() is calling del_timer_sync() */
+	if (add_timer)
+		sk_stop_timer_sync(sk, add_timer);
 
 	return entry;
 }
@@ -1426,16 +1434,7 @@ int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int
 static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				      const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *entry;
-
-	entry = mptcp_pm_del_add_timer(msk, addr, false);
-	if (entry) {
-		list_del(&entry->list);
-		kfree(entry);
-		return true;
-	}
-
-	return false;
+	return mptcp_pm_del_add_timer(msk, addr, false) != NULL;
 }
 
 static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
-- 
2.43.0


