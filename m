Return-Path: <linux-kernel+bounces-398705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB1B9BF4ED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 108A7285E3E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74871207A39;
	Wed,  6 Nov 2024 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="ophAy6CZ"
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAAD2076DE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916813; cv=none; b=EWyqipYiBxPWLXP8dx6382pdUn3VjFwGBh4+en+7z4wu2S9Bvz5rnbfSSIGltjRQUuko47osQi95ZmZ41I+gCrC4xITDyvQe6soGuCUWx/aiKsdRKttAUQy1Yg+QMKm2H7y6REojgcGphjYN73jgjEeyf3afyXgH2Ce43BH3KeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916813; c=relaxed/simple;
	bh=CjR3zzRrP/Tq/gW6QLzF1lfcrd4/ESzxdp2qlsMrvbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ox++9P4Lm7sFHBP/hNFSCQkmwVve3vocygVVj1C7gQnsmSzwlXV6SNerve3QAY7Fd1JWReAXWtZBmhgu5s/67bnsrx0NQkHO2WWi1ecZ+2glqdP7SUzU9+BnYSvu7uaQHI7+hb8xvvBpW1m8LUJv+1cAVTDlnTTb4aDl+dKmdzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=ophAy6CZ; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:ca3f:3ca4:dc38:27ae])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 350E87DCA0;
	Wed,  6 Nov 2024 18:07:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1730916426; bh=CjR3zzRrP/Tq/gW6QLzF1lfcrd4/ESzxdp2qlsMrvbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20syzbot+332
	 fe1e67018625f63c9@syzkaller.appspotmail.com|Cc:=20linux-kernel@vge
	 r.kernel.org,=0D=0A=09syzkaller-bugs@googlegroups.com|Subject:=20t
	 est=20fix=20for=20WARN_ON=20in=20l2tp_exit_net|Date:=20Wed,=20=206
	 =20Nov=202024=2018:07:06=20+0000|Message-Id:=20<20241106180706.330
	 326-1-jchapman@katalix.com>|In-Reply-To:=20<672ba5ac.050a0220.4939
	 3.016b.GAE@google.com>|References:=20<672ba5ac.050a0220.49393.016b
	 .GAE@google.com>|MIME-Version:=201.0;
	b=ophAy6CZkD/JLCpgBqpdNunq7yADdmoyFCf0EqBUvTkz6KZWqgbT4NNR0lHnWEVnD
	 mjc3A+H58A7M2JYjy7woGfwkG+nWopemG/Ky54E6ufoU6kSNI9xluZ+egbYpPAcks8
	 eG3Zy1vim/X9aCVK7sLvgu+7eaMNT0uk9Q+hmQXzipkKjZI2vXNwygtX8Xr6e1sC+D
	 wQR0qeSu6kBGSCbYOSMpiBlBjHbsqyPxsesGptRpLw6gWcuM7IB2ZgfEhfu/jjji6Z
	 IoNClwRiXH7oQFxc9XZMU3Y60kANgxlWpZXs5qKaGkIjQlY7ymoWiqrQe7ireyx1dM
	 g2p5pwV45t2yQ==
From: James Chapman <jchapman@katalix.com>
To: syzbot+332fe1e67018625f63c9@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: test fix for WARN_ON in l2tp_exit_net
Date: Wed,  6 Nov 2024 18:07:06 +0000
Message-Id: <20241106180706.330326-1-jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <672ba5ac.050a0220.49393.016b.GAE@google.com>
References: <672ba5ac.050a0220.49393.016b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resend to include the patch inline.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git ccb35037c48a

From fa6758c4ac6439c3ef4bedf6c0abfbf3ee17d36e Mon Sep 17 00:00:00 2001
From: James Chapman <jchapman@katalix.com>
Date: Wed, 6 Nov 2024 16:04:44 +0000
Subject: [PATCH] l2tp: fix warning in l2tp_exit_net found by syzbot

l2tp uses idr_is_empty to check that its IDRs are empty in its net
exit handler before calling idr_destroy and warns if the IDR isn't
empty. syzbot is able to hit this warning by injecting a memory
allocation fail inside idr_alloc_u32 (radix_tree_node_alloc). However,
this leaves the IDR root with its IDR_FREE tag unset such that the IDR
appears non-empty to idr_is_empty callers.

Fix this in l2tp by checking that the IDR is empty using idr_for_each
instead of idr_is_empty.

Reported-by: syzbot+332fe1e67018625f63c9@syzkaller.appspotmail.com
Fixes: 73d33bd063c4c ("l2tp: avoid using drain_workqueue in l2tp_pre_exit_net")

---
 net/l2tp/l2tp_core.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 3eec23ac5ab1..a665bdf3f9c6 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1870,15 +1870,26 @@ static __net_exit void l2tp_pre_exit_net(struct net *net)
 	}
 }
 
+static int l2tp_idr_item_unexpected(int id, void *p, void *data)
+{
+	const char *idr_name = data;
+	pr_err("IDR %s not empty\n", idr_name);
+	WARN_ON_ONCE(1);
+	return 1;
+}
+
 static __net_exit void l2tp_exit_net(struct net *net)
 {
 	struct l2tp_net *pn = l2tp_pernet(net);
 
-	WARN_ON_ONCE(!idr_is_empty(&pn->l2tp_v2_session_idr));
+	rcu_read_lock_bh();
+	idr_for_each(&pn->l2tp_v2_session_idr, l2tp_idr_item_unexpected, "v2_session");
+	idr_for_each(&pn->l2tp_v3_session_idr, l2tp_idr_item_unexpected, "v3_session");
+	idr_for_each(&pn->l2tp_tunnel_idr, l2tp_idr_item_unexpected, "tunnel");
+	rcu_read_unlock_bh();
+
 	idr_destroy(&pn->l2tp_v2_session_idr);
-	WARN_ON_ONCE(!idr_is_empty(&pn->l2tp_v3_session_idr));
 	idr_destroy(&pn->l2tp_v3_session_idr);
-	WARN_ON_ONCE(!idr_is_empty(&pn->l2tp_tunnel_idr));
 	idr_destroy(&pn->l2tp_tunnel_idr);
 }
 
-- 
2.34.1


