Return-Path: <linux-kernel+bounces-247621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7B792D20B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68DE281B4C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317531922F8;
	Wed, 10 Jul 2024 12:55:46 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DD4191F90
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720616145; cv=none; b=CJ2zFG2eh6Qkghg32ioSwvDtBDhi/LuQz320r0avASuZW97eDD85XwI7yWhy1VSnrEadoploFgAbcRc+MuUd9HwmHS2sRiW/S2WHX8PMW9yfpKqp7h51OZiBqwLwIgo5r8vg6g5n4Ek5dBPIuoKRSV+sLSDidgUlJ9KGUFsKg/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720616145; c=relaxed/simple;
	bh=7c0m9EP43WdOX+PJ2Qf87KTxqKM26HpWQr+ahe1dOAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jKAwFXCTEh7+vRQFsSUmyOA7AUYgyFD4fOyecHVeNWWCS53yLkBhAwl0M6adXJ98gb16zaHjOLtJzvqWGijJf94qaFrIEpZxqUBq1wWfCLPl/jPOE4qZNpP09GwKHvdnLYhxE8oSwStV2FyK5WkOx/9durf+AvtpPlMHFK2SS3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.8.162])
	by sina.com (10.185.250.23) with ESMTP
	id 668E84BD00007223; Wed, 10 Jul 2024 20:55:27 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4861718913454
X-SMAIL-UIID: 946CF0B5F26C4A15BF71C3C5E86A1C55-20240710-205527-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in l2tp_session_delete
Date: Wed, 10 Jul 2024 20:55:18 +0800
Message-Id: <20240710125518.1083-1-hdanton@sina.com>
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

