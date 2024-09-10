Return-Path: <linux-kernel+bounces-322531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED58972A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8EBDB237DB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EC717C7B1;
	Tue, 10 Sep 2024 07:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qhJ4Wfg3"
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF261531E8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952533; cv=none; b=pkfTSYFeqFXZEm2URvz2ordeRaIw4kCTMeTg5o+sOVMb/B211GAQa9ZrqP0133WHJup4Lc9nHL7dJjSe7PNHuUoJcBk0NQirFj3Ru6Yk47JyqeO+s35j/Tlly1/6gd9pEHiaya4NBSllrVPoaHV6NQsuq1vo+aRHc4JvNQADLeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952533; c=relaxed/simple;
	bh=kxYJb5V/LhW01DJtfOeC4SwOtPiANTCMuR0iVHpXIBI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=RoNsZdYY2pAchsdN84BjjLubx9uVwdRtTcqfEdlpt1Ctzv/mFD5zfSoZchmgNaMqvMjZ3t477uPtEou8+DWcrz9R7xipn7yNaKGmW51S2EV37U0I1oMusOaih5GU/bWQcgBv3hpcegaw2XNe2P/SM7mRnxD4jofEDD1J/MAQwG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=qhJ4Wfg3; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725952221; bh=s3PIMvCxMbaL2HtFJGosc8Wzz+rPn3DLimSK1Cwyaps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qhJ4Wfg3D4qpp+NLSoUvYtAiniVrZJcLtVDasbf0mXy8J35Qwq9hbHa0g1Rfp0oys
	 l6krxhJki5g8KGty+x3ueajq6GKWwuK0DxNxaKatTcKy0Z3xbEhjp9AmcU9T2T8SWD
	 JAakDRACbEk5Tlrocdc+g7Hgf6h5Ogb/8t38qHqA=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 2941C42F; Tue, 10 Sep 2024 15:10:20 +0800
X-QQ-mid: xmsmtpt1725952220tvp1pscse
Message-ID: <tencent_B068E96703AA4446F774176E66C1B3778305@qq.com>
X-QQ-XMAILINFO: NhpLzBn2I3XwRIhnVD2AWmolOp+dbw01P9tkuHpZT6ENfeTNLsBV5TS6CWHdii
	 zha/g/K9jNTvpzTksLSSvpHHO6SxQ92Nb3DoAyuwWvOmtiXjqgVQyEWY4Coe4yT9Kx6OrHWwM0zx
	 pQ7YQMDoGqc+BtbdIGOFayrPHq7etxDRZJxdQ8ql/RvKFGu1q+uml6M8I/8QZm7SnWnXoeLOvDJI
	 IK0Nwoko1Kvbx2gQ04JniiAnMe1RrCgwLbDIHNNavKdiyyOFi/64pevlioOInsPG/AVYI9ws81Bs
	 A3MGi7C8Ak8YGqzNwVBNswWfCfFOykUJqDoh3MOpmtmJXLU8nub2XRUaVz4jCF5bSyN06jE6qvmN
	 ZApwL+arYhRiZkFq4fvzxBNTvwLlDq4wqRd9cp7Mm0K7YhrMysV0R/0U4JEPhPTxWm1cyOWImiKo
	 w0ZY0CZJU+SvRvZjHhbBJghARaeJN/4t3PBJQKyh/K7DIjfsnmRRqNsAyW3y6pH6+/MRhbISzfq/
	 FKbsyOrqb5szyVV+39Y9k+1LsJiNCgsvZU3ZGpEkOu1tzIhoa/xZHPqmljbMcBX4PbYKgd3LR+Da
	 iI84v8kyUGeN+k/Na8mDoee0SbOTZelY7Fctdz6J0RjWMTrTYJgBo6bLEeGcBvDPeUaoZH+6Bzrv
	 mY/HYD7G+VihbwZfOVS2b5JYZepsCmlSOZbDi6X6ZvPLFgyMbh9HMmEhh0g+f1nwC8cPkXsc+VTO
	 FX4qZManXrLJLJysZhHw/Rrz4N8gdGVL2MUWB0zhBGzebfPgupeIA31cCg+/j1D4NPvcYPamRRjN
	 dsy8MjBEcoY3gYUvfFWjyFr5lM38Z9Zj4Pk1LC1zM5iEG5j9Nd9yoKrypJyk1xFl+2byjJDWxpYJ
	 PNVPRrcn48XAW0X185S/8PO8KIsCsrbJMoGezVuTeG/BNFwM6bMaEh+iyMpPYlmD1rPQLHcqEM
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [mptcp?] KASAN: slab-use-after-free Read in __timer_delete_sync
Date: Tue, 10 Sep 2024 15:10:20 +0800
X-OQ-MSGID: <20240910071019.2465755-2-eadavis@qq.com>
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
index 3e4ad801786f..b09268fc7fc9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -329,17 +329,28 @@ struct mptcp_pm_add_entry *
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
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry && (!check_id || entry->addr.id == addr->id))
-		sk_stop_timer_sync(sk, &entry->add_timer);
+	/* no lock, because sk_stop_timer_sync() is calling del_timer_sync() */
+	if (add_timer)
+		sk_stop_timer_sync(sk, add_timer);
+
+	spin_lock_bh(&msk->pm.lock);
+	if (!check_id) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+	spin_unlock_bh(&msk->pm.lock);
 
 	return entry;
 }
@@ -1426,16 +1437,7 @@ int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int
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


