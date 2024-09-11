Return-Path: <linux-kernel+bounces-324534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D73E9974DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 980962860FF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527B315C13F;
	Wed, 11 Sep 2024 09:06:16 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403F215445B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045575; cv=none; b=giZhtLq78nRsXIKErikkxSdnmVo6Ku82r9Xte9YaIyyOZL03qtSi7gXKbykeSW9/iieeTaYE42PLuGc9NRAIxWHVTGkPljtt0Wk2j1aFsaTdaIUHgotXNxRYYgErHY2QHvD5JQS4vxaFDK6ObRUfPM+W4rkwxuPu07C6GxBHAvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045575; c=relaxed/simple;
	bh=McHc0XTZ9m/AKhA60+tEv9WHCGFgjix5e8t8rInyN1Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nbRyRB5pDhELgaguPNOY1/hU5b3NAxShfsMheIQTIDUGb3U0AtYDRsubgKvTee6CfhEolN/NdeJp/+NcI2lCnvnvxFaQt6DxnVntwVZ75wXWPDwg2El75c4AMpHvb2wwwcK9eZJxGYJigsjb9MEm3gNWNjffuAvcE8/JssORJvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a04c905651so92177165ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726045573; x=1726650373;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GO1k+k3ZshwQP0aU7q2Qrrg/Vl2KXbr8e7yQd0U4K8g=;
        b=JHTy4GBJP9DQNB1zVLSj5JZs6u7z7P3J+naev7SL0OuXl1guyMLyBS9PrVJ0Vach9E
         EGTJhjZ2J/61Z2Hq+e0wdU2ixS+zmL4BDg8pbsGXkVdyZylw97AQ38h9OVjyj2nRB6pV
         PXhWcIC6uTH2D//iS33lBLMf5PzMOSnMQeEZnJRekHTZoldj4paLERaHi9I/44QK8t/j
         EcD/N1+A8u2+cO7sFhU4xfkbkiWoF+BVGDPzryci8pQQjYepsRTxlfihfy/CsYlb2d15
         HAoqxeJuF95S+oYokFEB3wMpQshzZ6AytX9BLu5lnOac8NR5O2PYrfukxXdcte922Be5
         51AA==
X-Gm-Message-State: AOJu0YwIlPqcQkpLuV6Q7a5afGSYbS5ysYoYMoaZJwK+hHIbMOCbpN9y
	hP53HmF2UHWmyPZ+5KDqKfISNDQGEZz55dHlZJJl5qeH5KjpDs4J/szDzzVpZXheIq+2oHjoEla
	aasCl2zTHnyhPJWFDGPXru8YbGkhgKxvaehatBd3bhfrBpvm8Ucyp+JE=
X-Google-Smtp-Source: AGHT+IGBu0IWgcvG/OuWjJ/edRcxn2yshQE7C1l3+/UYnqImALcsxDSZ+lyxgc4i4tczSmXc7dYOte3oRKiEsPz8azUH0nxAqx6k
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ca:b0:39e:78d9:ebfc with SMTP id
 e9e14a558f8ab-3a04f0ce281mr219386135ab.17.1726045573395; Wed, 11 Sep 2024
 02:06:13 -0700 (PDT)
Date: Wed, 11 Sep 2024 02:06:13 -0700
In-Reply-To: <00000000000047043b0621624565@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044cafe0621d44d72@google.com>
Subject: Re: [syzbot] [PATCH net v2] mptcp: initialize sock lock with its own
 lockdep keys
From: syzbot <syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH net v2] mptcp: initialize sock lock with its own lockdep keys
Author: matttbe@kernel.org

From: Cong Wang <cong.wang@bytedance.com>

In mptcp_pm_nl_create_listen_socket(), we already initialize mptcp sock
lock with mptcp_slock_keys and mptcp_keys. But that is not sufficient,
at least mptcp_init_sock() and mptcp_sk_clone_init() still miss it.

As reported by syzbot, mptcp_sk_clone_init() is challenging due to that
sk_clone_lock() immediately locks the new sock after preliminary
initialization. To amend that, introduce ->init_clone() for struct proto
and call it right after the sock_lock_init(), so now mptcp sock could
initialize the sock lock again with its own lockdep keys.

This patch does not fix any real deadlock, it only makes lockdep happy.

#syz test

Fixes: 58b09919626b ("mptcp: create msk early")
Reported-by: syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug\?extid\=f4aacdfef2c6a6529c3e
Cc: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
Link: https://lore.kernel.org/r/20240911042425.978665-1-xiyou.wangcong@gmail.com
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/net/sock.h     |  1 +
 net/core/sock.c        |  2 ++
 net/mptcp/pm_netlink.c | 16 +---------------
 net/mptcp/protocol.c   | 22 ++++++++++++++++++++++
 net/mptcp/protocol.h   |  1 +
 5 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index f51d61fab059..2e06e720071a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1226,6 +1226,7 @@ struct proto {
 	int			(*ioctl)(struct sock *sk, int cmd,
 					 int *karg);
 	int			(*init)(struct sock *sk);
+	void			(*init_clone)(struct sock *sk);
 	void			(*destroy)(struct sock *sk);
 	void			(*shutdown)(struct sock *sk, int how);
 	int			(*setsockopt)(struct sock *sk, int level,
diff --git a/net/core/sock.c b/net/core/sock.c
index 468b1239606c..d37e6efc7f91 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2325,6 +2325,8 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 	}
 	sk_node_init(&newsk->sk_node);
 	sock_lock_init(newsk);
+	if (prot->init_clone)
+		prot->init_clone(newsk);
 	bh_lock_sock(newsk);
 	newsk->sk_backlog.head	= newsk->sk_backlog.tail = NULL;
 	newsk->sk_backlog.len = 0;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index fe34297ea6dc..a82b68cc1faf 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1067,13 +1067,9 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 	return ret;
 }
 
-static struct lock_class_key mptcp_slock_keys[2];
-static struct lock_class_key mptcp_keys[2];
-
 static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 					    struct mptcp_pm_addr_entry *entry)
 {
-	bool is_ipv6 = sk->sk_family == AF_INET6;
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
 	struct sock *newsk, *ssk;
@@ -1089,17 +1085,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	if (!newsk)
 		return -EINVAL;
 
-	/* The subflow socket lock is acquired in a nested to the msk one
-	 * in several places, even by the TCP stack, and this msk is a kernel
-	 * socket: lockdep complains. Instead of propagating the _nested
-	 * modifiers in several places, re-init the lock class for the msk
-	 * socket to an mptcp specific one.
-	 */
-	sock_lock_init_class_and_name(newsk,
-				      is_ipv6 ? "mlock-AF_INET6" : "mlock-AF_INET",
-				      &mptcp_slock_keys[is_ipv6],
-				      is_ipv6 ? "msk_lock-AF_INET6" : "msk_lock-AF_INET",
-				      &mptcp_keys[is_ipv6]);
+	mptcp_sock_lock_init(newsk);
 
 	lock_sock(newsk);
 	ssk = __mptcp_nmpc_sk(mptcp_sk(newsk));
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3b837765c84b..7ecaa83794b2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2839,6 +2839,7 @@ static int mptcp_init_sock(struct sock *sk)
 	int ret;
 
 	__mptcp_init_sock(sk);
+	mptcp_sock_lock_init(sk);
 
 	if (!mptcp_is_enabled(net))
 		return -ENOPROTOOPT;
@@ -2865,6 +2866,26 @@ static int mptcp_init_sock(struct sock *sk)
 	return 0;
 }
 
+static struct lock_class_key mptcp_slock_keys[2];
+static struct lock_class_key mptcp_keys[2];
+
+void mptcp_sock_lock_init(struct sock *sk)
+{
+	bool is_ipv6 = sk->sk_family == AF_INET6;
+
+	/* The subflow socket lock is acquired in a nested to the msk one
+	 * in several places, even by the TCP stack, and this msk is a kernel
+	 * socket: lockdep complains. Instead of propagating the _nested
+	 * modifiers in several places, re-init the lock class for the msk
+	 * socket to an mptcp specific one.
+	 */
+	sock_lock_init_class_and_name(sk,
+				      is_ipv6 ? "mlock-AF_INET6" : "mlock-AF_INET",
+				      &mptcp_slock_keys[is_ipv6],
+				      is_ipv6 ? "msk_lock-AF_INET6" : "msk_lock-AF_INET",
+				      &mptcp_keys[is_ipv6]);
+}
+
 static void __mptcp_clear_xmit(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -3797,6 +3818,7 @@ static struct proto mptcp_prot = {
 	.name		= "MPTCP",
 	.owner		= THIS_MODULE,
 	.init		= mptcp_init_sock,
+	.init_clone	= mptcp_sock_lock_init,
 	.connect	= mptcp_connect,
 	.disconnect	= mptcp_disconnect,
 	.close		= mptcp_close,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c3942416fa3a..819a193c0d88 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -812,6 +812,7 @@ void __init mptcp_proto_init(void);
 int __init mptcp_proto_v6_init(void);
 #endif
 
+void mptcp_sock_lock_init(struct sock *sk);
 struct sock *mptcp_sk_clone_init(const struct sock *sk,
 				 const struct mptcp_options_received *mp_opt,
 				 struct sock *ssk,
-- 
2.45.2


