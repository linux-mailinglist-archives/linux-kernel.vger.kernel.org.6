Return-Path: <linux-kernel+bounces-277159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EA0949D58
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951B41F22BFD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0886A27448;
	Wed,  7 Aug 2024 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="A0Or+LDu"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5BE2904
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 01:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722993905; cv=none; b=scApoYt0z9jRCMrgRqlPAu8UtY+4NN+j9YdTj6f9T203qGcjDkiYwWfChd5F3y6v626+WJLQ3Z4XhebzNA+T+T6318cNjTM5Ra3pD8NFtEt1rhtm9PIspt/XTvJr+6K9KB/tDe00ayKK9ObMVuAejIU0Eq1RZx8LYX2G85FjEzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722993905; c=relaxed/simple;
	bh=PxwGV+qqU2csxDpU+8VqW60VqWUl7ZOZTPoBOboDGuo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=XIvZPTgfi29w9gjMmXgMuCY67DDW9HSme/aM2A2gilawykjzGkXXpdSJUHmawMbR33NlZua6z0foJlXb2ZzqYDnyrmMxyysL9xJ48F4NsS22wWxEiHbxd3YFLHfaEePYc8S08Iee+3O7MKcE/ZbPDgu5O/muJPuXlioFFDzzRww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=A0Or+LDu; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722993897; bh=mzfLDf+9f911g+nzZtvp+JGKv9gvhdYVI7KoNlzaa14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A0Or+LDu4oRu6sRpCdaIvP+FHgNE6DEwEJSC4/0S9lX1M3kt6eZtWR8ya+ZAk6msQ
	 1+yXk2Xe6OYatxvKt/4T9KRRqYkearLVFFR05mtUT/cRNtrRoYBlDlTXG6+wD+okUq
	 Q1K9FkpRsgcDpKtHMZ+TZR6IGJaM5f2TGM4TlkeQ=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 4B4A40E1; Wed, 07 Aug 2024 09:18:52 +0800
X-QQ-mid: xmsmtpt1722993532ts4id2l2l
Message-ID: <tencent_AA68577B46C9D3704361497763B7E44E5705@qq.com>
X-QQ-XMAILINFO: MmPNY57tR1XnR+SLsFOjX2NLxmDL5ySXd5RBBeXPDUazmZZx2pOloLCJtBDm57
	 gK1H5yWVVRUSWfyJleOAX1qHpQRO2O8RipRadkMMOj1JoBh39lekkRK0GvRnH7oMxi4Jo94jpYKG
	 us/2buAqKDIdH2f2cbUgA/iYEe9DA/JxoIU37gSCn7b6Hur0LV1AEqvE2Hvgjgl742ihTqcOt90E
	 UX1R3xQPSrE/5hEgoklVZaDqi7iH0FAf6F70/Xlbs8X57n1IDMMnTaekT9D+fMvLkWlVDJy9331N
	 N9S2C6iutocWi+ysdTCZBvRANVWsLQIJJOvd/YzpL0fhDhIq4rwaaqCd+tN4bu7DewGjUND+DaNM
	 A5tB3hekv/owy7lYtdru0EZV0D6b7E843sLanZWWoSyhAf3oLYry3ZJnVa2FCpKlmSBCPKcGIPzY
	 7koYJvQSJba6/tMZARUPFZZzweAv9xyTmw7ifMf1uzPtbmZA2457wKFrqu894mpUWLIbM0X74BHI
	 dKGwXI4jLexOvlXHMulMGzUEbR0F9NqPHOVpDzbTZDGCVkT+xXLHVeRYA93Uk19KPYTHjIHJ/N8p
	 jU85R+t5EcAtTCgoNShXbOa5c+D8oI8cMt58VMZLf0le/s9wTKmS86QJWL9Ga1ePX7UP6CgmgvYY
	 6tehJiQp+9+9LlHplPVrtjImQhozdnVDcosHIvV49KKLSBiszMffS+qOyqbUPq7anc2EImCJjEA0
	 dCk46XHjA/q9iQRoj0aoRct4sWZRQYWwea0nxjUhNvawTnYGBbMuVKn3K9+4osFRC3Slvp8NIbWh
	 qwAEjXu01WB6x+K/jkQ/+nbawjJm8ROpU7D85pjlSiUIdeWDRRL/VSKrWyHg+dYTbxhnmnGhqJRT
	 PmOkb59hw8/GWPlcC//47QDi15qidWmUpf2gwHaMLcYEs2iaTSnbv3C4Bp7FTXAQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [can?] WARNING: refcount bug in j1939_session_put
Date: Wed,  7 Aug 2024 09:18:53 +0800
X-OQ-MSGID: <20240807011852.3977152-2-eadavis@qq.com>
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

The solution I have proposed is:
Before releasing the SKB during session destroy, check the CONFIG_DEBUG_NET
and skb_unref return values to avoid reference count errors caused by a 
reference count of 0 when releasing the SKB.

#syz test: net-next 743ff02152bc

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 4be73de5033c..50d96015c125 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -278,7 +278,8 @@ static void j1939_session_destroy(struct j1939_session *session)
 
 	while ((skb = skb_dequeue(&session->skb_queue)) != NULL) {
 		/* drop ref taken in j1939_session_skb_queue() */
-		skb_unref(skb);
+		if (!skb_unref(skb) && IS_ENABLED(CONFIG_DEBUG_NET))
+			skb_get(skb);
 		kfree_skb(skb);
 	}
 	__j1939_session_drop(session);


