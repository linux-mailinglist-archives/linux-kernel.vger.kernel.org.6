Return-Path: <linux-kernel+bounces-176811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5418C354B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 09:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7E71F2153E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 07:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E7F101EC;
	Sun, 12 May 2024 07:21:49 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907CAE556
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 07:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715498509; cv=none; b=Ed0h9+MI3dt+9FLLZMwhBU90pzrpXJiAbRh32A8+KblDH3wPL3mLa84U1odgwnxsQX6TP4SJeIvCe0xfQVMzioK9gvkmd7Fi3d1lME/ZOBCPoZQshoGX90omkqr6n5vOIsXVoTm/Y8Z2J3yUFgpuKOb+jrIjt1lUPZVTVaUnsjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715498509; c=relaxed/simple;
	bh=66Jqedg9cXpHoydTVuNznaoG+hIkMQD7XMiOtPkepiU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=uZvM32iR5x/rYW5m/FJ4HQhhPxfbea07IfWRg3QRs2tqa437iV6qdz/HRSqokAux1IVRvFApGj7EmALY1xB9zsQDrvIHbMiwx9rsMRXr8P0RsLDcPVlOmO/c54Xo+/IxX+z45lQnhJ3Ei34yQYuEGxc8TROZRl0KmLYzN70slX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 44C7LiBq058242;
	Sun, 12 May 2024 16:21:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Sun, 12 May 2024 16:21:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 44C7Li58058238
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 12 May 2024 16:21:44 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <838e7959-a360-4ac1-b36a-a3469236129b@I-love.SAKURA.ne.jp>
Date: Sun, 12 May 2024 16:21:44 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: John Fastabend <john.fastabend@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Network Development
 <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] bpf, sockmap: defer sk_psock_free_link() using RCU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

If a BPF program is attached to kfree() event, calling kfree()
with psock->link_lock held triggers lockdep warning.

Defer kfree() using RCU so that the attached BPF program runs
without holding psock->link_lock.

Reported-by: syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ec941d6e24f633a59172
Tested-by: syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com
Reported-by: syzbot+a4ed4041b9bea8177ac3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a4ed4041b9bea8177ac3
Tested-by: syzbot+a4ed4041b9bea8177ac3@syzkaller.appspotmail.com
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/skmsg.h | 7 +++++--
 net/core/skmsg.c      | 2 ++
 net/core/sock_map.c   | 2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index a509caf823d6..66590f20b777 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -66,7 +66,10 @@ enum sk_psock_state_bits {
 };
 
 struct sk_psock_link {
-	struct list_head		list;
+	union {
+		struct list_head	list;
+		struct rcu_head		rcu;
+	};
 	struct bpf_map			*map;
 	void				*link_raw;
 };
@@ -418,7 +421,7 @@ static inline struct sk_psock_link *sk_psock_init_link(void)
 
 static inline void sk_psock_free_link(struct sk_psock_link *link)
 {
-	kfree(link);
+	kfree_rcu(link, rcu);
 }
 
 struct sk_psock_link *sk_psock_link_pop(struct sk_psock *psock);
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index fd20aae30be2..9cebfeecd3c9 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -791,10 +791,12 @@ static void sk_psock_link_destroy(struct sk_psock *psock)
 {
 	struct sk_psock_link *link, *tmp;
 
+	rcu_read_lock();
 	list_for_each_entry_safe(link, tmp, &psock->link, list) {
 		list_del(&link->list);
 		sk_psock_free_link(link);
 	}
+	rcu_read_unlock();
 }
 
 void sk_psock_stop(struct sk_psock *psock)
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 8598466a3805..8bec4b7a8ec7 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -142,6 +142,7 @@ static void sock_map_del_link(struct sock *sk,
 	bool strp_stop = false, verdict_stop = false;
 	struct sk_psock_link *link, *tmp;
 
+	rcu_read_lock();
 	spin_lock_bh(&psock->link_lock);
 	list_for_each_entry_safe(link, tmp, &psock->link, list) {
 		if (link->link_raw == link_raw) {
@@ -159,6 +160,7 @@ static void sock_map_del_link(struct sock *sk,
 		}
 	}
 	spin_unlock_bh(&psock->link_lock);
+	rcu_read_unlock();
 	if (strp_stop || verdict_stop) {
 		write_lock_bh(&sk->sk_callback_lock);
 		if (strp_stop)
-- 
2.34.1

