Return-Path: <linux-kernel+bounces-342842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B53B6989382
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 09:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 801A2B20B74
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 07:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E03413AD11;
	Sun, 29 Sep 2024 07:43:03 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CBA13635F
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 07:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727595782; cv=none; b=a2aBH+b3K/ERiWwerkhRKGm08+E03GKgyel+g79WOu2vB8gV+H/vssgZtcRfbYJ/50OBS5Mo9/elXhO0Bi6Kv+XHNeUvktO9N6+utm6CHdLBOv4acWm0yrFsvD+YSU9aSsLLvYs1vfDeFr/4+VwrLd699dsUiWxfL64fNlgtkIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727595782; c=relaxed/simple;
	bh=WrAzwEwP862HdR2SPL8z3eQqYTrS091yKsgGyJon5JI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=W147gvAQR0NASrtN1MgVQkO49xH9d5jQGi1lthBKvXxXwgYCv4Tt4rabr4mI3tl8OyEq7VJc4R1eU9JsOWuWBE3GK+8QdTmBr7SbvZ8Yl0GxYvzEDvTX8YLA4VlGafq8sHcXq/kO9af4j5XByNBPhfTxSSJ0AqmXyxsyzd7jKI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a342620d49so27748355ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 00:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727595780; x=1728200580;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=noL62I4rRESKjdsSl5q3DLv2fgE/q++w/F860QUjIXA=;
        b=jy8fNZY+Kh1fvSvtzuXbxUluxx+7nlhYbaZFzWwqCChN+gKFMn/0cD+gY/08v4Q6jx
         N1XMEVWLuvoGYQATmYBr3f72z3aCDoaZojf5kpvv9M9O78WEhY2rBfm19hFQnlCU9xtQ
         WwY9NeeT/BNATM19qzhZOhY4a/m9Qv6MTzRgQhES8vJ37EXJ98DQn3DkyX+JgqTNX675
         R9VwKD1r3YsZwBEULrLAn7tkTV1sLebvqBxqbfRHzDLTUbyJCmIwCeZvMhtqFgrUyjBR
         SOC87vsayFBgg5++4a8fj2F97ZiGyAaN+amJtspWa6CM976siNZDqVXi44ZBR5BDyViG
         GI3w==
X-Gm-Message-State: AOJu0YzCsmcS0Ph24RrPllhTRFwfW6n2VokVJrQ9vVGVb7c98PtoTQVX
	DwGOV+An9AdgJltl6qf4Z7mti37sWradCkZd4zB1fUERgqImzgYPn4iAWaqRRAQu5xbqSN+KGHn
	qGPG1FNhb+/JbPod00BrsXXbhRbJTeIflv1aZS7vBIDfAI13dar+EVK8=
X-Google-Smtp-Source: AGHT+IGmirK0cIsycnBTfNF2ozrIcsKldQiSY8ydUDsKWOtfXdnjD4AVSvmDrtSdx21R1fmK4y8A/AxwZoaWu9RfUy2tGu/nCX5P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138a:b0:39f:51b8:5e05 with SMTP id
 e9e14a558f8ab-3a3451b93d5mr69932275ab.16.1727595780343; Sun, 29 Sep 2024
 00:43:00 -0700 (PDT)
Date: Sun, 29 Sep 2024 00:43:00 -0700
In-Reply-To: <000000000000abe6b50620a7f370@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f90504.050a0220.aab67.0011.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bpf?] [net?] WARNING in sock_map_destroy
From: syzbot <syzbot+f363afac6b0ace576f45@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bpf?] [net?] WARNING in sock_map_destroy
Author: dmantipov@yandex.ru

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git d505d3593b52b6c43507f119572409087416ba28

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


