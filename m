Return-Path: <linux-kernel+bounces-232278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C0791A626
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446F41C230A5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F4914F9E8;
	Thu, 27 Jun 2024 12:06:10 +0000 (UTC)
Received: from smtp134-33.sina.com.cn (smtp134-33.sina.com.cn [180.149.134.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F212F14F9E9
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719489970; cv=none; b=l3ll9lGMboRSWtZdLMRMbXZiqrE3Ej16ybo8u5/2OL/mpIGSSFEQLqDyxcS0Ddhyn8L5IGWoeu1fg8Wxs4vN7v/ktW86Os3QnU/fXxqO/VBqfim7Nw4gegOYxmLUIrfS1w21WtTRefndKcEvmxuj0aa6+1UO1gIyCqdvk/KB7Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719489970; c=relaxed/simple;
	bh=5PWJ0cY43UHKPLM+bWDOVtM0JhL4CzeKvU/5b2U7HEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZpxPQyJh7DgKaGThPmTJqImg3d+6+aPF/FaMpvgIAgwbcTyAeo/fIqrjVmMaaaGnTcIcM8Dd451XAsW9j3v7Hx2rqaeouM7HM0inA1Di7MnpTrNkwZnGHxUCkVCTLj7Puvutk3PArJ9WOMFg/v0tuNQXK78IG3FR2GhtSFO+ofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.136])
	by sina.com (10.185.250.21) with ESMTP
	id 667D557600001CC9; Thu, 27 Jun 2024 20:05:12 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3132043408377
X-SMAIL-UIID: 8234244A102B4F8FA3816B7776B3A493-20240627-200512-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in l2tp_session_delete
Date: Thu, 27 Jun 2024 20:05:02 +0800
Message-Id: <20240627120502.2200-1-hdanton@sina.com>
In-Reply-To: <0000000000008405e0061bb6d4d5@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 25/06/2024 14:25, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    185d72112b95 net: xilinx: axienet: Enable multicast by def..
> git tree:       net-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1062bd46980000

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

