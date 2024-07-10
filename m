Return-Path: <linux-kernel+bounces-247462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A75492CFC4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC5F01C2204C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EB5192B82;
	Wed, 10 Jul 2024 10:47:22 +0000 (UTC)
Received: from smtp134-31.sina.com.cn (smtp134-31.sina.com.cn [180.149.134.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376BE192B7B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720608441; cv=none; b=GDAxWHcB6/ugz/b9yGyw9fbllSoX5SIsO6XACaO6LD31HQmk17PUWTofB9ldHCD8IW/tukh+dWtlX8L46tJoNvtiiOBIRdN2DlfEobP7g98sMCL/n5IDX+L9/a+r0Y6A+IbDpBLQOXnsaoQ8vj5zEuiHCCnx9Bkul5g2xUwBk4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720608441; c=relaxed/simple;
	bh=JkyAGJaQlvJtzJH9Qt1bJrKG63IdwAosYi5StyRN+g0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N5qmr2uYeQuzxOYtq6qzOIZsdnncwhHNu1/yhojU2GWwN4f6TdBkQW2HWG+WMY8Jj4CTwG9iEYdMEwZQNNFM+WMJah5CTUyJgNsI5s5NtxRTUJuSFfp2Qk1m7dYXwrUSnppY8YG3S1XJwlkSLQv8vxz3ZPHiAOayT79EAakPfDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.8.162])
	by sina.com (10.185.250.21) with ESMTP
	id 668E66A200003EFF; Wed, 10 Jul 2024 18:47:01 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8061163408407
X-SMAIL-UIID: BE62F0BD8E9F4D2993F37A295FF2F72D-20240710-184701-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in l2tp_session_delete
Date: Wed, 10 Jul 2024 18:46:50 +0800
Message-Id: <20240710104650.1032-1-hdanton@sina.com>
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

--- x/net/l2tp/l2tp_ppp.c
+++ y/net/l2tp/l2tp_ppp.c
@@ -446,6 +446,7 @@ static int pppol2tp_release(struct socke
 	if (session) {
 		struct pppol2tp_session *ps;
 
+		schedule_timeout_idle(HZ/10);
 		l2tp_session_delete(session);
 
 		ps = l2tp_session_priv(session);
--- x/net/l2tp/l2tp_core.c
+++ y/net/l2tp/l2tp_core.c
@@ -1290,17 +1290,20 @@ static void l2tp_session_unhash(struct l
 static void l2tp_tunnel_closeall(struct l2tp_tunnel *tunnel)
 {
 	struct l2tp_session *session;
-	struct list_head __rcu *pos;
-	struct list_head *tmp;
 
 	spin_lock_bh(&tunnel->list_lock);
 	tunnel->acpt_newsess = false;
-	list_for_each_safe(pos, tmp, &tunnel->session_list) {
-		session = list_entry(pos, struct l2tp_session, list);
+	for (;;) {
+		session = list_first_entry_or_null(&tunnel->session_list,
+						   struct l2tp_session, list);
+		if (!session)
+			break;
+		l2tp_session_inc_refcount(session);
 		list_del_init(&session->list);
 		spin_unlock_bh(&tunnel->list_lock);
 		l2tp_session_delete(session);
 		spin_lock_bh(&tunnel->list_lock);
+		l2tp_session_dec_refcount(session);
 	}
 	spin_unlock_bh(&tunnel->list_lock);
 }
--

