Return-Path: <linux-kernel+bounces-277787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EB394A680
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63190B2830E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F8C1E2103;
	Wed,  7 Aug 2024 10:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Fy20TRGY"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A2A1DE841
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723028394; cv=none; b=ffbyNLIWczc3lCNTz4kQHUwr0ZVrVKjxEPSZqo1katYjXd9JYY8P89DZO+pkNJNKHPhsFRieJAxNsSZOEmxyhVWVzx1RWOzHLJ3Jj+IwRdDzc2AdhO2yjwrKazCiigfxIMSCDkCPuuIJW6CSnwVrXlMH92AgILHO7QAu8aCNCGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723028394; c=relaxed/simple;
	bh=6/MZKGRZ6agIXTBMmUBHI/hy6Zf82glJL99dCKi2ujY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=bcPddugn/j/hxlVKGxlk2GPEolDUUcQ8yu2qWFx4JEpVDFrZ+wt3jFbvW5jYLbp0hw9PXYvzvKQp1NnAfTBUN488//QTFH/zGUGDIK4ULqJZAy12XT8ON782FhGO1rWfpqRHVZ+gg7Zjn2TfCtW869dXTQcO/Jj7PF69FCKMpiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Fy20TRGY; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723028386; bh=MTuj//11WwKuOG+Pby8XJOoyCedlVvhuAhlipqlKZpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fy20TRGYU6isaNaTKmyVxrVqXpMjOZLAS229Z0QonMm+4pYVKmTnakTgCW7bHSrlz
	 aRb6Yhx8a6jPUgSc9hrnhukOvhw+VgT7wDO7H6pF8RbVJ0D4XXT1icZ+mqmWL4NRcX
	 2G7IrfBd7AU89rAiuq2YdBU0h2cwZu73FfXeKTr0=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id EED19EE8; Wed, 07 Aug 2024 18:59:45 +0800
X-QQ-mid: xmsmtpt1723028385t83k9wvda
Message-ID: <tencent_EAB6EEFECE8878FA6F142C596DB09568E80A@qq.com>
X-QQ-XMAILINFO: MmPNY57tR1XnR+SLsFOjX2NLxmDL5ySXd29qe25dfGwKcF7qpGb1g/eTP9aRoS
	 w9MkHJsN6dp/+r5S6m1oJCRVvadvXwuwbAZoHodk2alRXIBaoRUVfYIRJEDeuMl/M/e0Pvzleo9y
	 l5NQ8cDk7eiHkxOjxrZfzk1n8mF/JL30rcTqVb1tCYRROIsc0LZnmUT3Kat8gCmhuUhe9cv6DT/1
	 tWJGLK0yhpDoCFB9OpISu+vRyB/XYsSoTHST/DuwfXumbGjlqAbuddvICREZJodjsZztm+jp9iaM
	 3B94Y0Zepl4CC7Idmq6HIDsj3Ht6pj1xqlohPzZZnfQ6Z1ZsDVOba7+3xE3aY5CbEyBhiY9vGd/+
	 3Vb8zC6fGCfqJM9QbL78yDaGCotHDgqtt5i90ImkLRqRPkeEOPCFjfPXrgP1eoFP8hsY1oSztfsE
	 E49GeQC0eVz6fDfhAZicH2O5jV+nq1fz1JERzBzfIBIzinyil2XCRahVu0xkIynkBA/70u+64j2f
	 Fb6eo39bjhVObUC+U2cQJct1Ul7wCAxmS35AEv5BzikUoL2Pxkb/txJJ+Y01++FisAgiWkuQf+5g
	 k+9xlI/Hjvs2XFvE/pm5rT1fRQ1IJJU+sUvAF/0jctEIzkjfAfy3zKs9FvRnNT7toPHkl5iKByHK
	 gPhOsSrlQTbzLnmqUK+wJ/l76itb0wOE7Rgo2U/z+HaYVQyfYEmdat6H6ix13MVgQSgtWocbCt7w
	 hJG+TIjaLU78B0WKJv3PUN67xd/kxMyY/0pL3vCGybwUS+17e0SG+yMgGqsFnyagZkc4mWKIxuay
	 kYMl0RZOi8ZzUK58izsqjSpPDan5KHKPLWc3ORaIlZ2HazPEIbwouWmEbv3N+sYKmzHfJQGct26q
	 m78mkoxAABUvvTgY680bsvmHU7oDK5zkRGwxHZbJBi5kALlXc+bc8ZJ2+YtCRjgDeyhBxXhV24
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [can?] WARNING: refcount bug in j1939_session_put
Date: Wed,  7 Aug 2024 18:59:45 +0800
X-OQ-MSGID: <20240807105944.362491-2-eadavis@qq.com>
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
index 305dd72c844c..c9b446c60e8c 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -1161,6 +1161,7 @@ static int j1939_sk_send_loop(struct j1939_priv *priv,  struct sock *sk,
 				 * fist in the queue
 				 */
 				if (!j1939_session_activate(session)) {
+					printk("1skb: %p, todo_size: %lu, seg size: %lu, %s\n", skb, todo_size, segment_size, __func__);
 					j1939_tp_schedule_txtimer(session, 0);
 				} else {
 					ret = -EBUSY;
@@ -1170,10 +1171,10 @@ static int j1939_sk_send_loop(struct j1939_priv *priv,  struct sock *sk,
 					break;
 				}
 			}
-		} else {
-			skcb->offset = session->total_queued_size;
-			j1939_session_skb_queue(session, skb);
 		}
+		skcb->offset = session->total_queued_size;
+		j1939_session_skb_queue(session, skb);
+		printk("2skb: %p, todo_size: %lu, seg size: %lu, %s\n", skb, todo_size, segment_size, __func__);
 
 		todo_size -= segment_size;
 		session->total_queued_size += segment_size;
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 4be73de5033c..dd503bc3adb5 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1505,7 +1505,6 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	session->state = J1939_SESSION_NEW;
 
 	skb_queue_head_init(&session->skb_queue);
-	skb_queue_tail(&session->skb_queue, skb);
 
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(&session->skcb, skcb, sizeof(session->skcb));
@@ -1548,6 +1547,7 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 		kfree_skb(skb);
 		return NULL;
 	}
+	j1939_session_skb_queue(session, skb);
 
 	/* alloc data area */
 	skb_put(skb, size);


