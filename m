Return-Path: <linux-kernel+bounces-277651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 318AA94A449
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F42E1C20C36
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5FD1CCB55;
	Wed,  7 Aug 2024 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="T2Hv067v"
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9F61CCB37
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022982; cv=none; b=ek5/nQSbWkkMMFAQOiLuVTSCe9P5RKGR+1KtS+4uLqTTCmDj1o+41Dv/e8704ZHtbqJTfQZLN97vVHd9W8mcMnIGw00BVwKeQLa9U3H+Hgn8WTTSpYLlhSodBf2hcunHduOkZLZOyNpbd/vnr6qIrd/gDdocPG1GD7NjUqFhsDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022982; c=relaxed/simple;
	bh=WMZwBA2xHi3cemQvytOl2A4YbsPr4FiWzHQCs3el7xc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=MsIoK5tqUsB8q2DmnwYX24CycURkf4k8/Zootrpl2QIRteYELwYKzpNOhdHSLmFG3ro7Z521WcDcy/1THG0Iw808LzayBiInP7bJ5lkcdvzJzG3lDKw+HtOhITHJmqHeNvFx2ZHUSIID/nn/Jt6EDGs8xqs1Npmylr+LLG/AGds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=T2Hv067v; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723022977; bh=ZA3m6a1a29m1al31x/co6/4+v7AchZ7tnHP8dqD6U3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T2Hv067v8YT39ClP8rhOCzgB0SH9rDLLeRMV+/MJDT2H24IL3LSNUGozqEvfWhxqZ
	 3oCq2mTDfZZeANFAyjlP8xI1jJV5Y9XImHDWX6yY/NLbD/Hoga70sbIXfKElcR0zTK
	 Em3SI6LOs2BKyR/nWznkbRbMJe3pm7+7mNz2IO54=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 7630BC1D; Wed, 07 Aug 2024 17:29:35 +0800
X-QQ-mid: xmsmtpt1723022975tbhy6af75
Message-ID: <tencent_F81769376726C61363E365A966E3A3044405@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1jm0eXw+cn6PXgS1ya6mU5x+q6Wk7+NGGwO9hERihVU0yZlJcT7z
	 WDdIKUiPAL5cKlNnD9pJjKNomW4cbSxo4EcMCHF2MbLgRwQeRmBIvd0gC9Xwqx08wsNZvyHaoyfV
	 ygdH9Ri2MtlF9rJp1EvOxh2MQRr1Qw1oN2d8C7Xw7zN0eqTRcxCY/PLtBmZT9g3NR8Ye4/cuci+A
	 ALVc5flok3mf79hlWXGCczJ2RLo0SZUFb/WGpU21Z762qgiDRZyfraFrKwTDsvjpu565Pz+R6ecP
	 ehG+ITgjwGi1mCCV+BZxFfRenzoUkSEjIl2aBCO7TTpq2BE/HOi3jT4v52G/lr0Q8y1xB2PFecxd
	 EqomC0S+bSScIzYpM+8vXRkVNK7IdX1YS75mX0PDsz6Sh/plbvdLdkmABO2JpsKrVtKs+WC1UTm7
	 AVG61sHy+A0pcOx229U8dmJjD+2FaeFy8XCX6Ad0BLGrtBRGCAJl0n8NAOfJKXxm7MKokP1xI0xd
	 PiUp3LgHip3yfbs0pYPZDF0A8+o/SA1qvWX81vPoOEZM2AvWXPY4A3aak5R6E/0wGbSpx3uequtu
	 zNDlPY399+QRmLqzN4I/bgCQLQMOimFZpHYk6wEm3ZdHSd5lk0RHYmvM21UjKBi+gcIDJXvrqQSv
	 4OfuMtNcdKImwvvcDG1muKUe8AaaNM+lW+bXResNtUV/o/MTTcMgetOt10SXgmn5eFr0LSmn99tD
	 RDGhjPWbAPZH7r57EErnM8tZcQn+MHfJ8nLRKtfzAiRbxvDTOdZSHKO+geSV7zolKQQl93fAqjMM
	 irErWW6m960Zxj2Y/D8J0AbckAbjUxqCfQHmVNhwCtGX7RQoi+fKESeCOnhFHnQi5iEwDDjH3bzQ
	 9493RQTRPse3hTtuwDRILnuC3aUqgkT3Ps72zQOyg/Pgoe+pP75NtyQ6TnFcWsfrAPm0sKqzl4
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [can?] WARNING: refcount bug in j1939_session_put
Date: Wed,  7 Aug 2024 17:29:36 +0800
X-OQ-MSGID: <20240807092935.273955-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000af9991061ef63774@google.com>
References: <000000000000af9991061ef63774@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: c9c0ee5f20c5 ("net: skbuff: Skip early return in skb_unref when debugging")

#syz test: net-next 743ff02152bc

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 305dd72c844c..d3caed131973 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -1170,10 +1170,9 @@ static int j1939_sk_send_loop(struct j1939_priv *priv,  struct sock *sk,
 					break;
 				}
 			}
-		} else {
-			skcb->offset = session->total_queued_size;
-			j1939_session_skb_queue(session, skb);
 		}
+		skcb->offset = session->total_queued_size;
+		j1939_session_skb_queue(session, skb);
 
 		todo_size -= segment_size;
 		session->total_queued_size += segment_size;
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 4be73de5033c..4676585766db 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1505,7 +1505,6 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	session->state = J1939_SESSION_NEW;
 
 	skb_queue_head_init(&session->skb_queue);
-	skb_queue_tail(&session->skb_queue, skb);
 
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(&session->skcb, skcb, sizeof(session->skcb));
-- 
2.43.0


