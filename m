Return-Path: <linux-kernel+bounces-277390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDE494A01F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACFA61F25AC4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 06:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE53C1BE23C;
	Wed,  7 Aug 2024 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="iPQbr5Tm"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CA91BC9FF
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 06:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723012953; cv=none; b=DaNVV1P65VVwRx/+WmqpfLPTmCQHFbZy/eFijmJpmL1Q66SsCxGpNIrylTzQXp5xaXaMszwL6ZoYI3A2xitSFVFJFa1n7G1drstM52IyztpR+XzwnDbVQMTo5MwKFZm8pslMBVufLqEIQITisQTRzY1k9EipHc+iTcki6dJCId4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723012953; c=relaxed/simple;
	bh=hxh5qXxYbT1iXZ2sIFpJk6Fy8uXJc4rB1mjRM1/xy5s=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=QScbNn5IlHsC9hAGL1slolq/AIKQd8Ik4l2LMkuObQylBGc6UBe0cWaKnd9AM+EZKGRbjjf65K/9YUBE5SqkAn4u7Bczkoc5p3XcXPKxUETf7z9kIHoPws8LBOV8HLYMTwhB9CF5kqlPOqKCBeie/DMx25feSImCg7LKl4R5zR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=iPQbr5Tm; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723012926; bh=hQRCpQqNwdcaS26FrOg5YtWCY/Aj09TWBmYsPE0HBik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iPQbr5TmCCyHm7/OXOJ43JMACAA4/DjPmQGH03tkIdRc/EP4pybwaZmSltZyEE8mV
	 CWYEGYvuzuQ32n9S3FnYeqeVp7eWSwBaz7lGIeSaOzxNnB72tLvtdD63Rhb8KIojeg
	 sLEbpHd5+UdGIkFdd/h0GqcXW3F1lZWbeZmr+Ep8=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 55497CDC; Wed, 07 Aug 2024 14:21:20 +0800
X-QQ-mid: xmsmtpt1723011680tpc1qzn3m
Message-ID: <tencent_FD6E4F9F8DDFA5970D8A921DDDB65D851907@qq.com>
X-QQ-XMAILINFO: NKdJ5YK+graLnocCVpSlv31IdjeMbx+yuALzCmhOzYPs23kg1GqXzuU8NSSZd1
	 haVdmNNdiK+Fg1P7F8CctLxKazmnbFzJ3iBCP/8qj/KDsC9mx9c3/7LPO0r2mUT8wPpXEkaoKnlz
	 bOdQYoOfkLOWsJROW4bgqqHTAnjZWQ9uKkgLl8yUYE+FK7tuD8ci3sO9CkQc62rFJPvOSobwCS/e
	 1EJ85IZbsqdpZywQYHuk+Ef6AmGHHXL4pmaxFKPNUqlJ2zYprGHHjqu2z5n9X5ttvObz6cUPjUOb
	 AuVDpZ3rbwgCnNbvcBLIrMM93aJ/TfoOwNYEPa10xa8LodH462k64fm/haCdSEb3C8Bdnl0PCTy1
	 KxVSVFWfUrCwdcpRoiYzUJ+qXsJkaZiaz2XPkT28bt4sXj1WMmA88QQZ5iFac4kb5zxDLl5Br+/p
	 i4XlsTe+KUAL6SqKh9zfl+os/Z/uIGmFGe4gAuwI48Z2KfpKdBUbbY8QjU3eCz5ZnhuzdpwE/o4R
	 hWFbu5w/3lgiChpGoCU6/Thz3aZKCDecb7z9hR9eLNqj4yQzUXZHuaIRf4odyX37sBFRPp9bROxs
	 3r0HlxxiRSpwWVqJYRaUuNk0qfv4ERjjZEhsE9Afcmxv2uHy940GBXvoL4W5mcb2TJ2p++QJczdE
	 Pw0CNuQLN41JPQJ6eIHmr1XlJHftHP32jDVGYS+Zg1y3UypIZO/akd3c8IOzbqO/B35nneTvn7kN
	 AVeV5T1FZmMyNC1uIq2ynfzcm8DunSRwhbGo7SDQqVUzU3QNqqmnwRJWtQ8G7YFbPrJ8PHa3o6Qp
	 uGosbMc45zvq9YYdUtd8lnzLOgULncQ2dkhGLA53pGl/b/r8hBSr+GSoTOCTVOp6r+/fWK/HhrAB
	 YDsOeOpKyLYb26XvpubJyyHQ/rW6A2zQ9AcHL3VQaOfMd7sVcRlgWoPZTVNt7SKhHqdob+AffFSj
	 hRtC1WzLj0eCt6ZWDwi1SXx/NE5G7RGkA+2er2mSc=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [can?] WARNING: refcount bug in j1939_session_put
Date: Wed,  7 Aug 2024 14:21:21 +0800
X-OQ-MSGID: <20240807062120.82090-2-eadavis@qq.com>
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

Root cause: In commit c9c0ee5f20c5, There are following rules:
In debug builds (CONFIG_DEBUG_NET set), the reference count is always  decremented, even when it's 1

This rule will cause the reference count to be 0 after calling skc_unref,
which will affect the release of skb.

#syz test: net-next 743ff02152bc

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 4be73de5033c..bff135a62712 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -261,6 +261,7 @@ static void __j1939_session_drop(struct j1939_session *session)
 static void j1939_session_destroy(struct j1939_session *session)
 {
 	struct sk_buff *skb;
+	struct j1939_sk_buff_cb *skcb;
 
 	if (session->transmission) {
 		if (session->err)
@@ -278,7 +279,11 @@ static void j1939_session_destroy(struct j1939_session *session)
 
 	while ((skb = skb_dequeue(&session->skb_queue)) != NULL) {
 		/* drop ref taken in j1939_session_skb_queue() */
-		skb_unref(skb);
+		skcb = j1939_skb_to_cb(skb);
+		if (skcb->flags & J1939_ECU_LOCAL_SRC)
+			skb_unref(skb);
+
+		printk("refcnt: %d, skb: %p, %s\n", refcount_read(&skb->users), skb, __func__);
 		kfree_skb(skb);
 	}
 	__j1939_session_drop(session);
@@ -341,6 +346,7 @@ static void j1939_session_skb_drop_old(struct j1939_session *session)
 	if ((do_skcb->offset + do_skb->len) < offset_start) {
 		__skb_unlink(do_skb, &session->skb_queue);
 		/* drop ref taken in j1939_session_skb_queue() */
+		printk("refcnt: %d, skb: %p, %s\n", refcount_read(&do_skb->users), do_skb, __func__);
 		skb_unref(do_skb);
 		spin_unlock_irqrestore(&session->skb_queue.lock, flags);
 
@@ -365,6 +371,7 @@ void j1939_session_skb_queue(struct j1939_session *session,
 	skcb->flags |= J1939_ECU_LOCAL_SRC;
 
 	skb_get(skb);
+	printk("refcnt: %d, skb: %p, %s\n", refcount_read(&skb->users), skb, __func__);
 	skb_queue_tail(&session->skb_queue, skb);
 }
 


