Return-Path: <linux-kernel+bounces-277424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 439F194A149
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0DA61F28566
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B151BE22E;
	Wed,  7 Aug 2024 07:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="YBQu1plp"
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73207C6D4
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 07:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723014092; cv=none; b=TySvmUrfy8SngZQKh8eVS4gsKJmrknynpI0qp8Y3Nlw8dfjVktiEiBM1SvKPCoK32RZK8LIr2I5v+4Ostkg2jM2h5jQP+WZgRSilmrlOS6KYtVXB42ymOCLD30hJh0JND47gW/SsyPGM4rwkK7+vwGSrHgxS4gK2rBYhDsbpxGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723014092; c=relaxed/simple;
	bh=QuB4zfRZoa1J6Umi4r5O8NHozHLRwJzc2ojSnc5z8VA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=iP0Jixqle9An+qnKcoHw/kToLy+h2zh92FbOlsVRChz5zlPx6wguZYrDofXHE2PeDT4vcMYdNpZWoIibS/MG19pSTW+47LXTt673MJI3bdxnHn1DDGVhp0xWXwi5RwsF6/wW2upnxHZP0l5X9z4oJbHKBrN3Hyi3siQXVg6QTS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=YBQu1plp; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723013780; bh=5ES3zOtEV7QigLhw3QMK5L0aUE1F+ixfuHWctuvAepg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YBQu1plpSKy26nLdRD+7uzlVG4YybDx8pv/aPune3rxgzntk3BWy4TfT8UxDXswSC
	 03G9qj0AqHSjBEfKP0aL05sDJyC3FEEwq805LOpxAcCm2oBb/nq6j7HaK9Qh1Q4Lp/
	 fgN2aYtukcXHiEd/rqns160pVf112uN77RGBT57U=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id E12A1CE3; Wed, 07 Aug 2024 14:56:18 +0800
X-QQ-mid: xmsmtpt1723013778tacs74o91
Message-ID: <tencent_6F9E3F1BBF4B3A1B5E25B6BA7BBB14331108@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GFGzFT90N7o615/GuGkoi32E6ugKVe4ZrTctbgvAOhtcLlbJo0o
	 YJy3bNrdHnYevC1Pi9nbCFt7gh04MSPyrbSPz4hHDa9Ex4y+/6Y3K1PQiFYyJixlgXe9lXhwrNGR
	 Fv/h7wu09UdI2frwZGXXL38jYSJxAs/Dtcke2sc3ImoeyFx85PXXjAOYw0yQbxax7XJdyFPh9+LD
	 F9bdZ1V3vmSjB3C6B5Auxk/hQqKIy0qNwRtG/CWWLgJyLe6LCED72DKcfUtxEjWNf8QznkkteJOz
	 L6KwLAwp88YZT1TndtCR7cENZx4DtacB0SZbGFjoz/8m/SD+zrn/ahkZpyIbNfbqAgOiOX0ULjFG
	 ykBksf4V1DSla5ZTy4rkt8EDfiQzAP9FjC+DjHJkQsoXS7IM8GOxc5q8NAw/fdB3OrT99A7QuDRw
	 TzGqbKLrac4+DE6roxoh5WVO6Ysh86IsHjNsAbbvf8G2CAsIJSxMR+hP6GhPV8CgVsUvwn4tT0bZ
	 RY9TbGjwPSvqBRTbFsj3sUUnWROwYOFJlV8JXRaca0p3VY/JZETNBuHSlp9cHABWwe4MqZ3PY7Ul
	 XElLgcp92QyRA6x7b61xMgNsdh/HjrmFZmJuUAbMUa92ToJfbN1M0mjx14QnGqiD+zXphwhL06Pe
	 HCmyyRp2rCcsAPVc0FGNi4s+fn/bId8w6dD8TEtkU6qSRWUJd/YNA9FppNJLMFvCIX47CuxwdPtL
	 0UY+bzRRKWlOhtWzW5B4JqUjKmNtDtTvWW67kbRP4gOqfwE4GaA55kBG4bGxDhJg11U6LfHN6Qdk
	 VbdoHQiFV5kr+uWKHxX5hAq6rxoiiukvNMjnVRJxHijQq8yMsP0E+X+nnxeL98GdUqIT7DoPjdYk
	 g+XnBOYcmx/HacXoTZoK4gta+k5d4HsbtHTljOQW5WleDj71BzqTZl/z+Ue8YKR9EoI+yX/mUUeM
	 teOhTUFFb4dt8xhNhA41e8X4PgmifAq3f4grK2Q9c=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [can?] WARNING: refcount bug in j1939_session_put
Date: Wed,  7 Aug 2024 14:56:19 +0800
X-OQ-MSGID: <20240807065618.117322-2-eadavis@qq.com>
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
index 4be73de5033c..712c0ae4f329 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -279,6 +279,8 @@ static void j1939_session_destroy(struct j1939_session *session)
 	while ((skb = skb_dequeue(&session->skb_queue)) != NULL) {
 		/* drop ref taken in j1939_session_skb_queue() */
 		skb_unref(skb);
+
+		printk("refcnt: %d, skb: %p, %s\n", refcount_read(&skb->users), skb, __func__);
 		kfree_skb(skb);
 	}
 	__j1939_session_drop(session);
@@ -341,6 +343,7 @@ static void j1939_session_skb_drop_old(struct j1939_session *session)
 	if ((do_skcb->offset + do_skb->len) < offset_start) {
 		__skb_unlink(do_skb, &session->skb_queue);
 		/* drop ref taken in j1939_session_skb_queue() */
+		printk("refcnt: %d, skb: %p, %s\n", refcount_read(&do_skb->users), do_skb, __func__);
 		skb_unref(do_skb);
 		spin_unlock_irqrestore(&session->skb_queue.lock, flags);
 
@@ -365,6 +368,7 @@ void j1939_session_skb_queue(struct j1939_session *session,
 	skcb->flags |= J1939_ECU_LOCAL_SRC;
 
 	skb_get(skb);
+	printk("refcnt: %d, skb: %p, %s\n", refcount_read(&skb->users), skb, __func__);
 	skb_queue_tail(&session->skb_queue, skb);
 }
 
@@ -1505,7 +1509,7 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	session->state = J1939_SESSION_NEW;
 
 	skb_queue_head_init(&session->skb_queue);
-	skb_queue_tail(&session->skb_queue, skb);
+	j1939_session_skb_queue(session, skb);
 
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(&session->skcb, skcb, sizeof(session->skcb));


