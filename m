Return-Path: <linux-kernel+bounces-277208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D502E949DDE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 04:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A0828708F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 02:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A5F190065;
	Wed,  7 Aug 2024 02:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Cp7QGIM7"
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E5A19007F
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 02:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722998343; cv=none; b=X8ZyP4Tc4r4eVxm4tFGHwO0WaUFf5HaSmIGg3flPXiKgGcTlkgIL8JJpsq2l6/tZn/SzKnMTHIIJYtR+SwLl4Bkv/H/lwz27Wc2Wm2jJQtfalC0S4tajAGHaDmSKnMlZiwU863+QhZyPFUvPDlab8rhbxJeyVv0i89ipCgI4W8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722998343; c=relaxed/simple;
	bh=Xi7Zf//B8s9ZqUhDy278iJFnxKRyY1luSOvLvBCCNMw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=m86Ijt0/weQqDy84p2B8Dus7XoZFKiH9I1kUAoLKcR/cG4WHoId0DskINJ8aJhGj+pP+O6ZdbUxBNh9xeBzyVPdJjyh0ykc6Z6Wd/RpCZyrnOviixeAfVxYstvAY4zdUke4LQg7DfN8I+ODhKNvolZZeao0VfWvOMjtiQxOqWLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Cp7QGIM7; arc=none smtp.client-ip=203.205.221.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722998339; bh=+VuXD6BhT1HyFGqEU3bUMR5gB3qtMWEmgVp7ISSVFGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cp7QGIM7grLHZR7YWM7CuqoQS1WKhVNfjwXmdsVvHPuo/ZxYGhlXD+7Z/o0FOFdFx
	 f8P/RckGGiBS6rbr7qFJWkdPbSoGTRrSnaoFe4b0kSbj2SG35+ZWEduNm+WhZCZpyW
	 I6AnN4911jSsk7znMPe28SH403kOMIJrUMdh/S5I=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 9B9AE007; Wed, 07 Aug 2024 10:38:57 +0800
X-QQ-mid: xmsmtpt1722998337t0lh7u3fa
Message-ID: <tencent_FADDBB192B4F958DFF25E68DEF920F5D8507@qq.com>
X-QQ-XMAILINFO: NwU6Bou9okj/85WEExNoPZQefocctXfKRDUKHq+nToFmzLn1yPvwLHC5rTGN35
	 z1gkQfKhlond9/81RcaryZBHWImtFEE+13TsSnZcOAeeJMsyFJK02B+FHlJv004KQWHSDoRbTczf
	 2bMzJGOlmI4eUjKvGdUo2xgr9EmjnY6gz6SVxU2GTcdRGCTCQm6hi+ddb1gQ3VWgkg+Pu/LZ43eR
	 o+r4B1k83vnAOX8HsnMf6ZqKyQ5j8E3H0Dpl0z071jvLuEsxeCUJjg1KKKzx63MirpUQeKYZIHA+
	 QJmonyk+0WM47Yu/klb4Kw4fGqR6iToz5DKYx2EYWf++PqHwtYjqTCVW5qaVAyFnVdI4y2+QQ/aa
	 oVFAjIB5DHdJ+aGgpE691wn48ZHOC3xwg+P8oEh+JhLi1Da9I4m/ffzQrDn3iXBbAvkzs4Kc0GQd
	 05EzcD08bUg9WMqZYJ/6MBCDp7KRYiwCA4Os8jpCXKfi9au+G8zDE5XKUmho/B1TnuDh1coRDH6U
	 aGjTvJ/tQrX9/Kojr6+F3epw+4R5B22r77ezfKifMlimiX80dc0n/s6DKnLhC9fHTNB+0RLy/+oZ
	 I/12DDuOqG7XzfPAvW6E9hAIV5wZvCcSeCKtMqeTcL7W58JyyeEawVzWiYO8+NlBOeqKcqUmcnhU
	 /hsnf29FVbHC4IXUnegy8gb+XUG3P8cpz6XhtXzHF5IDHrG7Noq6YP9jaCR60un0cTzCktX6EO1s
	 vwfwgfHdj1N0JM725I5fveNJ1JyXu0oR858/qxt0p8wyE/Cr8GHaXY493Uh64K/QtRaDaRg9wYlQ
	 CIqq/KOq/qLv3qcbxPHlVNIBuM0uoroOGVnbq8tTCm3pZDY8fYqwps/AI1kroBaTKOh1ly8d2jFN
	 je+LRixhLklGK5o5htM8ovhutLPmwhBuqnuZHi8vBe/hxiUmOuqIxoS9UXBRh36WYuffBrORVnQq
	 2jTi6ws9WRbehpagAXxrc4BzuugmnUJgGSGK2kGi0=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [can?] WARNING: refcount bug in j1939_session_put
Date: Wed,  7 Aug 2024 10:38:58 +0800
X-OQ-MSGID: <20240807023857.4053536-2-eadavis@qq.com>
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
index 4be73de5033c..257740076616 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -279,6 +279,9 @@ static void j1939_session_destroy(struct j1939_session *session)
 	while ((skb = skb_dequeue(&session->skb_queue)) != NULL) {
 		/* drop ref taken in j1939_session_skb_queue() */
 		skb_unref(skb);
+		if (IS_ENABLED(CONFIG_DEBUG_NET) &&
+		    refcount_read(&skb->users) <= 0)
+			refcount_set(&skb->users, 1);
 		kfree_skb(skb);
 	}
 	__j1939_session_drop(session);


