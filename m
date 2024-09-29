Return-Path: <linux-kernel+bounces-342841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44D4989381
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 09:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26EB1C219E4
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 07:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BE913AD11;
	Sun, 29 Sep 2024 07:42:15 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB401F95A
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727595735; cv=none; b=YtFi04qUk6MGsXmw/VttwPvr9ricQW0rdloZFM2kaupPkGLHSNfgUe4EIK2W4oRSLh/KxCein06LMKj4Nvm9Gvl6gXw/75ot6rr8MdSwHYozp4f+6rX7j9zgBtIglh3ppESRvBjVPhyjHuC2Vtd1E0XdVsL96LdmzdncaHrKLcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727595735; c=relaxed/simple;
	bh=TjlCqrNDxdv7rnlhhTFPTfxbuJr5iR9vU8gxgSNY10Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JOKhBfP0D6YSGHYIeDDsBybAz63V+P672x0M5fiMyKHLjQrVMQxFuWe+wT/RVfLmxkb/oicpcpVMjXYSJ3aaJiglOt7u6cqztXMSjBYoYcLrh7Y7MyeMqsLE16TidJ1hXGd64pFo4AuOfPgHuPzS9Opmt2ygmkhoaZPUMjpsZYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a34ebe595bso12929425ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 00:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727595733; x=1728200533;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0rpheSTK8ncRosnkTppulEWeV2sWM+71eKpR1R9g2R8=;
        b=qmza+nJNxU7VMX2/07RchrkGo2N/I5VM2xFqxRRZ0YZtTHnqkwjCiHTEyFAgmncpI8
         FELJbfoYRGlhB8fsYnE6QuZg0Rk4LKJw8PuinXftoDBasC0fjv/bk8muuVFhCblXw+O+
         JhIpseTgTfHs80cyd0I1J/nUNC7dnsrQ6BJIUPhfYtg1xxHNs0IO7TzVYinjvSzOBDz3
         7q7j6+slqG/G2pfS09G9tmadBhiQXS3ol97rxtiAaVZaAunBt/n5ah/YxfU+Cyr59dNM
         QfK38C7cFU+O7KyvfabfCAS8gIneUASNans6D+2PRaXMmNekztNoDHWGlejsPWgfzPpy
         JOEg==
X-Gm-Message-State: AOJu0YywugbZA5mOMMVWsH8nlFR/eQjeLh/LDydp9mKnKVvGw7VGCAE/
	Ev1y0z0brRO5f/0Gtr66goQXKJHt/j6jKvucpjCV4aP5nsnY94cGxM3/CZ5mO1eUMwGRVsIlZmv
	V6CG/DilAQXWln+8WkEMYyHW23LfZjb/jK62zFN1Gd+VxoigA3XF9rnY=
X-Google-Smtp-Source: AGHT+IG7VZnaGepaArTSSr8jOh7R6s3eAwmt84iowwwArY0oCDSXDaHyUe5q8BhsMu8W3UcPJsFn/iMrAxIg11VJShmBk14bBuyx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda8:0:b0:3a3:4391:24e9 with SMTP id
 e9e14a558f8ab-3a3451b68b9mr69156685ab.20.1727595733319; Sun, 29 Sep 2024
 00:42:13 -0700 (PDT)
Date: Sun, 29 Sep 2024 00:42:13 -0700
In-Reply-To: <000000000000abe6b50620a7f370@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f904d5.050a0220.4a974.0019.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bpf?] [net?] WARNING in sock_map_destroy
From: syzbot <syzbot+f363afac6b0ace576f45@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bpf?] [net?] WARNING in sock_map_destroy
Author: dmantipov@yandex.ru

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3efc57369a0ce8f76bf0804f7e673982384e4ac9

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


