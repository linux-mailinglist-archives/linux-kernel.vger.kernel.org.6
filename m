Return-Path: <linux-kernel+bounces-342897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A5298947E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 11:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37BC6281D64
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 09:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE3B14900E;
	Sun, 29 Sep 2024 09:26:30 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F7C22092
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727601990; cv=none; b=CIn3yh+bWpvC9Ap7tnIRR67Pb+GomA/++V+U75FHOzHhegbzuP64utoOxyt8sDuERwTQ+lErcrzM+NauRO+qSmJcIUEL/DR7fR7DtL1euWJoBMs6FFZ4fkIqwNMv4dWR7x+cFrv7q82ZXU0rsdXm0uAtxsMaQu2p19huOd1aBOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727601990; c=relaxed/simple;
	bh=IoV4/qXvaw/PKEniiBL+nLujKz/iEoUY3RTYU7vT3TU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s6oiHEmS40sO1XBDSQYYzh8OBeXEaB2GEahsNiFhqMMlOdMg2FQY/N1qoDWzq/22SMsXLxqgrr6vrTjZuX294bwe89PhHXMu/CL86vJmD6246P2MqIN3knh4dGPSPwOavCcHRw5wjkUhsGNEw2KYK8P2e4jrNNuDQNKL8iyHq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3479460f4so20268655ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 02:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727601988; x=1728206788;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p4k4S7F0QcngH584k5Dff8d5BsEwVEVc+07OCGlmuJw=;
        b=hOowON0R9VQSTh/jWO/rCg+9TP+WXilgcWY0UdjpNY9jBuip+mkkowBOjhzqzh6Bho
         j5vXSeziU0Pv1D+BKLQjGDVG6Kv9oDqHVDk3okHOwnPmMMVkQc3vB8htn08c8sHhFY57
         jIjX9jj6sIeOP3lO+5Gk1waljDR4rxSxGwWc1DUlWcbJe1QYcFEwgZ23+OdKS/DqtF2D
         HEM/Gotk4k+gHaYtHYBoYVe9diCFmPx+DwV60MznKoU5h2IrFZOrZRAi1gyNothlsJVv
         9VFs1XWaV9kDi4xwuJTB0A6Sq4TJDOTdW+aTM/Fs1OhoHW0yALEOpntGyWgDsows6pFC
         ZzyA==
X-Gm-Message-State: AOJu0YxI4JXWKKx7q+DfJtRb6GY+q1pZIpOjxjP5TAvfkVa0lBh9oub5
	DsWajp+Fy9i0QfYhG3dHQa953SSo9BsedgaEiDPEMKhxTKybywbEF6rMeBZsbNKn4sQ/PzI3/hF
	AA59zDwq2Mk5ogshTvr/Ei4qOJIm5crMnIHKCZzsHSD6Qyipot6IjJsQ=
X-Google-Smtp-Source: AGHT+IHIhlU6/Xy7BTeB0a+NzmVERjbxKzx4PxxlkgbFvRjcvA3hgLA38niAB/JgFxzEvj20p5r1IQ8K9tKlhuIl8NFCwI8YyPev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c266:0:b0:3a0:8ecb:a1dc with SMTP id
 e9e14a558f8ab-3a34517fac8mr70126225ab.15.1727601987997; Sun, 29 Sep 2024
 02:26:27 -0700 (PDT)
Date: Sun, 29 Sep 2024 02:26:27 -0700
In-Reply-To: <000000000000abe6b50620a7f370@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f91d43.050a0220.aab67.0016.GAE@google.com>
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


