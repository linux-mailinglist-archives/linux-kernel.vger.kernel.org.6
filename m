Return-Path: <linux-kernel+bounces-342843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43448989384
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 09:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745A41C21C1D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 07:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FD013AD11;
	Sun, 29 Sep 2024 07:43:45 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62161F95A
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 07:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727595825; cv=none; b=cjU6XlEEJL3PrGucEnOXVs5AlRd8r0YOFYGFBYuki3x81FmbKAd9O8pSRTv/bSmnEiybCY1Eo9nw+FrF8JXrbf+0SWdS9VlSjpga6fF6g3C2b+mkqxEb2ux9tWpUS1K45JzBu4NjOchT34vDZRqRbtAsfaZrkMCBx93668DU3WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727595825; c=relaxed/simple;
	bh=akUmuQy40L/jqDwQOVd0SKatg1J6iqfqMtR4anzk33s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VvwNFiOikefP4Cz/BdfomG3pPV+p7CEhRJe8ZFNSVEkV+/T9UizgOl3gUNNVGoV6Wa6Mtcj9FC9p9CtZSg3cQinal0I/tteg3gikrp9rjVxbur1YQOqGKO8ae6V96mysm2eAQziwO50IRKqQhSbDMFhVZQM9yAV8z18bI6vckDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3453139c0so33872985ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 00:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727595823; x=1728200623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4fkJgh5eRWSjF2Qzdbv7OSrzr6wJfbAiblFKeWwScw=;
        b=uYsz1x2a7qVrzZnvm4EoIc68QbtVSX/P/bsTNkRrMzAda37nxVCzts+6QRhcU1Qfo+
         nNUHna+mMYUvm3A7Xfy9t3V2l4jatfX7+pwxnH8Pt91P8Dlo5gFksRkJ9SwJZwrPUxwl
         T96lLQ6xUORLPDZzCLC8uIua8WkmcXCVczpO1KYuhHTeEBVdB7NlGm2bEEV5cB924+3s
         WhVNBKCZ+mwfr4RIP0Bfb2OG64kW9aQrEiBCL7cDUh/FkukZRSSc8LLwMUfBqDQBE1bb
         fr6aVkFimY8ihmv7AaygcnCJxQa/PCmRenPD95AZZ0I0vXftWYySyt7hbmUm88ksWqYJ
         LTag==
X-Gm-Message-State: AOJu0YyMx7LY/DOKJoBvaFuccXUuE83LufFVG0L0yzBT23B+ldegXU+5
	ydRbKiRjyFaQbMGcHMk4kqtG3b9tKErW05CRAnNVvbQ/PcQz+oT7fFQhYhAVWd2QTb9fhnI2eTD
	/lxnlAjMPR64/utmag7koRZAwofuopQnicz7b1sqh45nwDC0Yv+5jHsw=
X-Google-Smtp-Source: AGHT+IG081qtac7Ul2klZTDFP1SUoZhqDcqPvIpMrWsdihevEV4IiO/D47RGS1t352g55mLB+dK0AM0DAHSNTkyy6kMiFLy1VqZf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0f:b0:3a0:9d62:3b65 with SMTP id
 e9e14a558f8ab-3a34514ad10mr71130305ab.3.1727595822922; Sun, 29 Sep 2024
 00:43:42 -0700 (PDT)
Date: Sun, 29 Sep 2024 00:43:42 -0700
In-Reply-To: <000000000000abe6b50620a7f370@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f9052e.050a0220.4a974.001a.GAE@google.com>
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


