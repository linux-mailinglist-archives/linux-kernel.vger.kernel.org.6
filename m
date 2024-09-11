Return-Path: <linux-kernel+bounces-324664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E2F974F73
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBDD1F260FF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5D717C9B4;
	Wed, 11 Sep 2024 10:15:20 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DDF7DA81
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049720; cv=none; b=sd88sd3MvXQCsSXKgps6EKQ0fhGLbtyxDJ4Op8uq5MD/jvfvN6tJDo0Ljpp9Nr2kJPslRLl1EB/R3y2wWUZpZ2egG+5MMAaCyqiTL+qbv80yXBDoGACPD55EjUFuWclbgirKJjFuUuUKGw79NJzlqs0ROhX0zU6Px0P4Va1p53M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049720; c=relaxed/simple;
	bh=6mdRgcOAOg38g4ar5fllj1hp6RTVqNRmiOIkG0FNL3s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gMX6C/YVA70GUfPjPDHd1GMFBWjmGal56wOJ8xYJvgCo9eFqp3NZv3BqBoc3zB3G8aL6gP/4tpN+hyImR5g/AGjHArOtjN7vaN+fA0B2IYv1zcidmTOXHNJ3wGE7FNL5FtsHWhT9OhVrv6AhxTw2MwhNbcOZskp3IuOM+X49Ymw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a049da92a2so135372055ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726049718; x=1726654518;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RtC9OfChq6fLiZ43IfxDHJnr4B5z+CtpRZkAroNJhDU=;
        b=NFOzVpeewEWfRy00g0AeoPim17oSd5zxFEhDhGm5u6PqQQ/7U0lZXqbw9+jB8a+ifX
         IQkeSQmF4hgUrJ2nK+Jyrjdoyz+N0Ezg+mcxVnPYIYB9tWJYCwIxlfTl2t9Fp4xarBVC
         f2/nfwNJeVzyD0571uUQeFvQfSLJc7ijlcQDKO4QJk+Gn7Ca43neicAa4vGao3CgPXxx
         Y/FHemnduvnKBYdbf7i/8k8lrHyFvQWQQf0uUc6gZKBOnyMy7XsyQ6xofKy/3ToqM9I0
         +sLU+MU78NvEIn9Ol0q7KyLSf7BtlGUTNVoAv2xMHBt4+Qu+yrS7CejanGYtBLEhE8vV
         D9mA==
X-Gm-Message-State: AOJu0YzRRwaVeh/rGP28l/Y2PiYcWpZGqDaPa/gW7KWxtYYzbpnd5eP2
	IBWOfeCXCHmDdj0Q5t3+0l+paiYg1pPbh04G49o2xA+1I652YXM92IwI1WsL9ca6yLUXYE3y3AR
	9615Y3vhGyOb88kqFUWWNQ1jg7yGtlgxsvvJq/fJWoybT4fP0Qt3Bk9k=
X-Google-Smtp-Source: AGHT+IEfDIXSIdAmhlko7tblts3VU/t0XjB0G5U8fNYnHVFdoJMIMgRaQQ05TTrZijQllyqsykhRPk94xoMqTVSylyNvhc13IUfo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198b:b0:3a0:468c:8e2c with SMTP id
 e9e14a558f8ab-3a0524a1ca8mr175880265ab.24.1726049718257; Wed, 11 Sep 2024
 03:15:18 -0700 (PDT)
Date: Wed, 11 Sep 2024 03:15:18 -0700
In-Reply-To: <0000000000000311430620013217@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000525c950621d544a1@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] possible deadlock in rtnl_lock (8)
From: syzbot <syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] possible deadlock in rtnl_lock (8)
Author: alibuda@linux.alibaba.com

#syz test

Make Lockdep happy with IPPROTO_SMC

---
  net/smc/smc_inet.c | 17 ++++++++++++++++-
  1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
index bece346..281f0450 100644
--- a/net/smc/smc_inet.c
+++ b/net/smc/smc_inet.c
@@ -102,14 +102,29 @@
  };
  #endif /* CONFIG_IPV6 */

+static struct lock_class_key smc_clcsk_slock_keys[2];
+static struct lock_class_key smc_clcsk_keys[2];
+
  static int smc_inet_init_sock(struct sock *sk)
  {
+   bool is_ipv6 = sk->sk_family == AF_INET6;
     struct net *net = sock_net(sk);
+   int rc;

     /* init common smc sock */
     smc_sk_init(net, sk, IPPROTO_SMC);
     /* create clcsock */
-   return smc_create_clcsk(net, sk, sk->sk_family);
+   rc = smc_create_clcsk(net, sk, sk->sk_family);
+   if (rc)
+       return rc;
+
+   sock_lock_init_class_and_name(smc_sk(sk)->clcsk,
+                     is_ipv6 ? "slock-AF_INET6-SMC-CLCSK" : "slock-AF_INET-SMC-CLCSK",
+                     &smc_clcsk_slock_keys[is_ipv6],
+                     is_ipv6 ? "sk_lock-AF_INET6-SMC-CLCSK" : "sk_lock-AF_INET-SMC-CLCSK",
+                     &smc_clcsk_keys[is_ipv6]);
+
+   return 0;
  }

  int __init smc_inet_init(void)
--
1.8.3.1

