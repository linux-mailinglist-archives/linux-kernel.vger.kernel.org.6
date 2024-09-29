Return-Path: <linux-kernel+bounces-342898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE96A98947F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 11:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E601F21271
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 09:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838CD13D635;
	Sun, 29 Sep 2024 09:28:20 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A829722092
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 09:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727602100; cv=none; b=Jrm04fSxf4aGyqZMXecbmu980Zu9F0fRhapWEqD+kbq9U8c0b92HH2sKx9INdk8L7Jxh4SgTsJfutCtzAM1rxDnP24bas9YjMtenqrFGvh+pkE8+d0uXPEu2Qy+R2n9Gmxx+jRJF3eHaLDEk/CZhVkgnEJti33VXBYMc08DiM1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727602100; c=relaxed/simple;
	bh=uujRgXHAHkp1u1JvKMDO30nILm4hVgE13ZgCssh8wMc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GLtLH1iOx89DxcchaEiPukY7/+PhStQyoaYvbb9aS7F38ckZ2VsvJmivjlaA2NjqOy36EDaLMUxXNsSurFOFb7Es1i9qvsxVYeg3xlf0+nVVsEf9EJTrPoJd9JmWXpUTOWw8F8CflFfbIUjFESW/GRhJWVVJ/AqfSqWFm3LCENg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a345a02c23so20817415ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 02:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727602098; x=1728206898;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WElKykH/oSF0F12MtFRVBincuNvh2ryDjixuE/6S3T8=;
        b=U9GrPV95qqixfTLLEKA6RPCk9oYZOHb9cq459xmVdUgl2CqD5/vH+ubvCat73x+2U7
         F6P+boE0XJhBT/JCFaaQEiJVedjPIniMQLEcwmZNAeD4deMJ+xc0Ow8fB1qrDhw25Q/S
         r4vDFr1naC+Q3767JfVXUcs09ft3Zz4FAl01qCoHvw9STdI/tL0gTEB+ECFJ8jwm8tLb
         3VQ2cNFo+yn0jE0s5njekREx1Y69PQUZ4o0yPt5oKX33gMWVWcCnXeMe94FhU4QmaXv1
         mhPI0EfwZaIiDoBbQ66JwHG58/UmfRJlQBdIvdHdECYsX047n41KxAF9jpyOxx4R7VSG
         JH/g==
X-Gm-Message-State: AOJu0YyxtN+vdr5OiUAweBFxyInesUY9jVh43Rh0wHwiWnX0E/U2nMRJ
	9+faEyUuHwP0NeEN9NeUBDKQ+xyawFCf4QXKUZ65WB/yfD6UayGrLfFL7cM4AuCmcxY7DnIwENg
	GVpcxUC1ehk8TiNhjUls7Xr/JJTl4ZA9wXP8TRRmMyPRmO3TiFaLG0DM=
X-Google-Smtp-Source: AGHT+IF2i8ABMhEOe8Q6oWoZiAFDcaiuL6dNtaCDjTvHjXGEDF9dPNsaq/DUXzcd69Ysjqmb65LBDZVzqPsGo+/JBTj0+lgnzdxY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2161:b0:376:4049:69e5 with SMTP id
 e9e14a558f8ab-3a3451b6d1cmr72287765ab.23.1727602097780; Sun, 29 Sep 2024
 02:28:17 -0700 (PDT)
Date: Sun, 29 Sep 2024 02:28:17 -0700
In-Reply-To: <000000000000abe6b50620a7f370@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f91db1.050a0220.4a974.001d.GAE@google.com>
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


