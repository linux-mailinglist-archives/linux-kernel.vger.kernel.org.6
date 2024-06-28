Return-Path: <linux-kernel+bounces-233755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA62F91BC9A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C971C234CF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA79154BEA;
	Fri, 28 Jun 2024 10:29:21 +0000 (UTC)
Received: from smtp134-33.sina.com.cn (smtp134-33.sina.com.cn [180.149.134.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9631A1509B6
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719570561; cv=none; b=Q7yqmIgqi5zxijV3rptPJsj8DwBgJM96iZnQbXVGCcJq4DNqAionuCnB7qXYJsUo1aLhsdZrR7wyq5CnNJI5SZwQa1Mv4gUFmMeTwzNXGO4zER1sJ2/2OI2LR7Y3TSAc+1uIGdAO8SFUBD4zwLzVvh0taViEGMPNik4f7ntA+mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719570561; c=relaxed/simple;
	bh=RoLXQnjQ8abYCHG8gjOwNFdS7rcc5bh0p2vDMZQ1gao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R4PW2PpPwayiVV+8fqAaO1uxsEeyX8jmnTbWcpHIak5twkD5k0OVmDJMBoV4vbnQVQ7FtyPHwrR07ss1FBA1v6wNlE7kGyug2SsGZPxBeqN9Xm0GHU40oz9hqbmIrle8kwObVNfcyS6ofdHvoBOJi7vPvFN2+qI4eMsu1aUlUv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.25.117.159])
	by sina.com (10.185.250.21) with ESMTP
	id 667E907300002FC1; Fri, 28 Jun 2024 18:29:09 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6899853408378
X-SMAIL-UIID: 5E587FB5658F48B6B8C054B8CD1FB2B3-20240628-182909-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+b471b7c936301a59745b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in l2tp_tunnel_del_work
Date: Fri, 28 Jun 2024 18:28:59 +0800
Message-Id: <20240628102859.2379-1-hdanton@sina.com>
In-Reply-To: <000000000000454110061bb48619@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 25 Jun 2024 03:40:20 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    b0d3969d2b4d net: ethernet: rtsn: Add support for Renesas ..
> git tree:       net-next
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a90fb1980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git  185d72112b95

--- x/net/l2tp/l2tp_core.c
+++ y/net/l2tp/l2tp_core.c
@@ -1298,8 +1298,10 @@ static void l2tp_tunnel_closeall(struct
 	list_for_each_safe(pos, tmp, &tunnel->session_list) {
 		session = list_entry(pos, struct l2tp_session, list);
 		list_del_init(&session->list);
+		l2tp_session_inc_refcount(session);
 		spin_unlock_bh(&tunnel->list_lock);
 		l2tp_session_delete(session);
+		l2tp_session_dec_refcount(session);
 		spin_lock_bh(&tunnel->list_lock);
 	}
 	spin_unlock_bh(&tunnel->list_lock);
--- x/net/l2tp/l2tp_ppp.c
+++ y/net/l2tp/l2tp_ppp.c
@@ -393,14 +393,6 @@ abort:
  * Session (and tunnel control) socket create/destroy.
  *****************************************************************************/
 
-static void pppol2tp_put_sk(struct rcu_head *head)
-{
-	struct pppol2tp_session *ps;
-
-	ps = container_of(head, typeof(*ps), rcu);
-	sock_put(ps->__sk);
-}
-
 /* Really kill the session socket. (Called from sock_put() if
  * refcnt == 0.)
  */
@@ -444,22 +436,8 @@ static int pppol2tp_release(struct socke
 
 	session = pppol2tp_sock_to_session(sk);
 	if (session) {
-		struct pppol2tp_session *ps;
-
 		l2tp_session_delete(session);
-
-		ps = l2tp_session_priv(session);
-		mutex_lock(&ps->sk_lock);
-		ps->__sk = rcu_dereference_protected(ps->sk,
-						     lockdep_is_held(&ps->sk_lock));
-		RCU_INIT_POINTER(ps->sk, NULL);
-		mutex_unlock(&ps->sk_lock);
-		call_rcu(&ps->rcu, pppol2tp_put_sk);
-
-		/* Rely on the sock_put() call at the end of the function for
-		 * dropping the reference held by pppol2tp_sock_to_session().
-		 * The last reference will be dropped by pppol2tp_put_sk().
-		 */
+		l2tp_session_dec_refcount(session);
 	}
 
 	release_sock(sk);
@@ -831,6 +809,7 @@ static int pppol2tp_connect(struct socke
 out_no_ppp:
 	/* This is how we get the session context from the socket. */
 	sk->sk_user_data = session;
+	l2tp_session_inc_refcount(session);
 	rcu_assign_pointer(ps->sk, sk);
 	mutex_unlock(&ps->sk_lock);
 
--

