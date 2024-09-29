Return-Path: <linux-kernel+bounces-342900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A61989483
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 11:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E229F1C20B9E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 09:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA695144D21;
	Sun, 29 Sep 2024 09:28:59 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E9B13BC26
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727602139; cv=none; b=m+pddHDueL+j2teAqjOKxXlfdLiDRNZhBSxhWWchp6BwW7TDT+vcaG5cj3C6h6DSoxPAa0mfp3N4tvwdpLba9+aRHacuuyyyR0faXJRCZrpLN/efArwGUoPphdJ9fPK0S2fPGCHdhJ7/Uxc1JuozcxEV27hSQ5CVqCtm94O0rbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727602139; c=relaxed/simple;
	bh=7aW7egkRQuS7ELnfM60iyy4P9ZP2mHbUPoVKpXMOCIM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A2kBu1TLrXuXlny60/WvxUFEk30GKMjwfQwIkk9s82GtDKbGpGJp0wA45C8wbgaG3bC5z4pHF9iB59voZCRI6IdzzOsY2dzh4Iyokc/MqBREPDDXqMLHn6XBsRJ4mfRreTBq/+0Hygv6ueyUIfUoDrgquNyd3xOKA4JBOiVzgtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a342e872a7so29413145ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 02:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727602137; x=1728206937;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x2RShXlqUWWWarRshzYVxN87onyDppPtO2V8nB2crtw=;
        b=UqcG+17oSu1NpmMjGlLCg9keImkrOY++1yNOTZqUvVxuw1PmMjkgCFqab/hgkKGsCb
         UTNl5pKRiKUNv9Ia6ShYrI+IV9FCT9M3bDMU3BIBvpKzSbcD85olkEzz9v8EYBNpWRUq
         XJFGZS7iAQKY8h7DJdQX3lpeCHNHbmt3NZT10IIGZ5pXffTvl+e5wMUfJs/BOvjaMib8
         dTtgSA8dBC6vX+7L6kOMSZ/abnfb0XMKmxNG+znyI1XpEsf3pp+AvvgGZrNheq98/SFK
         5FNL8Q+xns1voelRGxyai6h/t23jhjorwNFni62j/eG/hCPDp9/RUvFtsyIIQmG1lBJB
         LouQ==
X-Gm-Message-State: AOJu0YycrVvldBqm3Cz1UmUVd1+DakH1m0GXnpiAG4BRs2b6ycax2ZNX
	/XSSBSTh/cmF0XIA9FcEao4mt7J1+QFWj6u48k+a9uOp1J+W1UyBSQRCLO6UpbhCj9bZmjtZUwg
	XGCBg8JlumAy03R0m/S1lq4l6OlqHDq5gUM8ddsvumI0F+1fLN1cOIXs=
X-Google-Smtp-Source: AGHT+IH0Bh2RVHwqXAeKl7nMWS5rWrA2+zbsiES9pxT1satQDaWALUBBAViuWmg8SntkLYsBuPSAsfhE7nim4NACu4WNeAOuJkKI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0a:b0:39f:36f3:1957 with SMTP id
 e9e14a558f8ab-3a345148113mr70097605ab.3.1727602137028; Sun, 29 Sep 2024
 02:28:57 -0700 (PDT)
Date: Sun, 29 Sep 2024 02:28:57 -0700
In-Reply-To: <000000000000abe6b50620a7f370@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f91dd8.050a0220.aab67.0017.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bpf?] [net?] WARNING in sock_map_destroy
From: syzbot <syzbot+f363afac6b0ace576f45@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bpf?] [net?] WARNING in sock_map_destroy
Author: dmantipov@yandex.ru

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git c824deb1a89755f70156b5cdaf569fca80698719

From 12b932f214f0caaaa79f929ab81b46ebea125a06 Mon Sep 17 00:00:00 2001
From: Dmitry Antipov <dmantipov@yandex.ru>
Date: Tue, 10 Sep 2024 14:21:20 +0300
Subject: [PATCH net v2] net: sockmap: avoid race between sock_map_destroy() and
 sk_psock_put()

Syzbot has triggered the following race condition:

On CPU0, 'sk_psock_drop()' (most likely scheduled from 'sock_map_unref()'
called by 'sock_map_update_common()') is running at [1]:

void sk_psock_drop(struct sock *sk, struct sk_psock *psock)
{
        write_lock_bh(&sk->sk_callback_lock);
        sk_psock_restore_proto(sk, psock);                              [1]
        rcu_assign_sk_user_data(sk, NULL);                              [2]
        ...
}

If 'sock_map_destroy()' is scheduled on CPU1 at the same time, psock is
always NULL at [3]. But, since [1] may be is in progress during [4], the
value of 'saved_destroy' at this point is undefined:

void sock_map_destroy(struct sock *sk)
{
        void (*saved_destroy)(struct sock *sk);
        struct sk_psock *psock;

        rcu_read_lock();
        psock = sk_psock_get(sk);                                       [3]
        if (unlikely(!psock)) {
                rcu_read_unlock();
                saved_destroy = READ_ONCE(sk->sk_prot)->destroy;        [4]
        } else {
                saved_destroy = psock->saved_destroy;                   [5]
                sock_map_remove_links(sk, psock);
                rcu_read_unlock();
                sk_psock_stop(psock);
                sk_psock_put(sk, psock);
        }
        if (WARN_ON_ONCE(saved_destroy == sock_map_destroy))
                return;
        if (saved_destroy)
                saved_destroy(sk);
}

Fix this issue in 3 steps:

1. Prefer 'sk_psock()' over 'sk_psock_get()' at [3]. Since zero
   refcount is ignored, 'psock' is non-NULL until [2] is completed.

2. Add read lock around [5], to make sure that [1] is not in progress
   when the former is executed.

3. Since 'sk_psock()' does not adjust reference counting, drop
   'sk_psock_put()' and redundant 'sk_psock_stop()' (which is
   executed by 'sk_psock_drop()' anyway).

Fixes: 5b4a79ba65a1 ("bpf, sockmap: Don't let sock_map_{close,destroy,unhash} call itself")
Reported-by: syzbot+f363afac6b0ace576f45@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f363afac6b0ace576f45
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/core/sock_map.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index d3dbb92153f2..1eeb1d3a6b71 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1649,16 +1649,16 @@ void sock_map_destroy(struct sock *sk)
 	struct sk_psock *psock;
 
 	rcu_read_lock();
-	psock = sk_psock_get(sk);
+	psock = sk_psock(sk);
 	if (unlikely(!psock)) {
 		rcu_read_unlock();
 		saved_destroy = READ_ONCE(sk->sk_prot)->destroy;
 	} else {
+		read_lock_bh(&sk->sk_callback_lock);
 		saved_destroy = psock->saved_destroy;
+		read_unlock_bh(&sk->sk_callback_lock);
 		sock_map_remove_links(sk, psock);
 		rcu_read_unlock();
-		sk_psock_stop(psock);
-		sk_psock_put(sk, psock);
 	}
 	if (WARN_ON_ONCE(saved_destroy == sock_map_destroy))
 		return;
-- 
2.46.0


