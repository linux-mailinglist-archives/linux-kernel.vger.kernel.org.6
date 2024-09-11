Return-Path: <linux-kernel+bounces-324632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2349974F04
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914A3284596
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6D416EB54;
	Wed, 11 Sep 2024 09:48:02 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0922814A097
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726048082; cv=none; b=gT3+RSS0pvyORNfUz4XuKnMYZBvoToJPN+V62XVD0UHaYR/VVJZUPkoWqaw5ewG1g1ecfpTcIcZIZx+cTQgOIHo1ZvjaxBC6LQnVlPHFyik5MrOKHTXUD3f0Hikj3Q9jCj//hturhlaqM9d9fByeDZGKLlnuqVU7WBuBzM8Xgwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726048082; c=relaxed/simple;
	bh=JoBM1fuN3Ci8KMccukxu1bHwglfAX1/VWZS/SV9lpeg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EcaEKF0IBOxt7byYsXtXGgOVkssSeeUt86Why2r+8HAXQZJuyp/uBo1xddn6ypOFhpI8ehQ/cCUDlfP0QRvOGjBJOB1OTTIpLwGYV8gc8VV/qSk6C3B5BMsNRle1h2RlCdFDsHyjSme6/dTpVPP5NFb3gVjEA+h3D4qLCLJrkKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82d0daa1b09so78795739f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726048080; x=1726652880;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoBM1fuN3Ci8KMccukxu1bHwglfAX1/VWZS/SV9lpeg=;
        b=vC5BOZwDj7+290ZOZhz3CQ/QV/AMTftu+uLGJcB3SWJ6aaimhoECLwSI6yOlClNctF
         F7EXQwYOphaNvL/Qik3GKRSovTLsjK7Ww+nDKNi9Xmz9pqtGPrKyot31OlqDv3DIV4Uw
         pbU3s55IYTWo5UcW7zuL0hd/kkMCX8EtWvgrxH6x9vWfr2SPRERQ9yu91PAlIoqSubW+
         l8+vOtes2BmcKJBICqykn4IpGdiJCYwdeGHFl1Wk/r6cpTq5hQLEHwlDkjs8AnZOjNtJ
         XdqVhZwHANyNZVtIr6Msw9mTDWe5iag7dWlE0t6bqlVfhuFAZtYkbqeEnfIpEgWDXOCO
         x9aw==
X-Gm-Message-State: AOJu0YzvzgaqGntrHGeOBzv183nKGnJYTa0PAZxdEDNR5K0X4/9psjf6
	uZuT4Xh3LtRIFQtNgpYuymC4kYwfLxB8abEi2BC3ar3eHl9GnB3F1HhgkC4nkcvmXUept1FmBgK
	XYhQoZHMQCgeyEV8OTCQhfqqyrPWY8iXeZZsrTgXjd1FzzjUdOaRjGIY=
X-Google-Smtp-Source: AGHT+IHGhqFkjEiIhr59nd9jlVlbQ+LBj1DnUdnzSSF0C6mxMw6Ha39779C0C5tH2HnXjmHbfSDo72Yo9lEBi+736nJnSYSi0DDx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1583:b0:82a:ac63:e7fc with SMTP id
 ca18e2360f4ac-82aac63e892mr1010356639f.15.1726048080030; Wed, 11 Sep 2024
 02:48:00 -0700 (PDT)
Date: Wed, 11 Sep 2024 02:48:00 -0700
In-Reply-To: <0000000000000311430620013217@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000acfb4e0621d4e20a@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] possible deadlock in rtnl_lock (8)
From: syzbot <syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] possible deadlock in rtnl_lock (8)
Author: alibuda@linux.alibaba.com

#syz test

Make Lockdep happy with IPPROTO_SMC

---
 =C2=A0net/smc/smc_inet.c | 17 ++++++++++++++++-
 =C2=A01 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
index bece346..281f0450 100644
--- a/net/smc/smc_inet.c
+++ b/net/smc/smc_inet.c
@@ -102,14 +102,29 @@
 =C2=A0};
 =C2=A0#endif /* CONFIG_IPV6 */

+static struct lock_class_key smc_clcsk_slock_keys[2];
+static struct lock_class_key smc_clcsk_keys[2];
+
 =C2=A0static int smc_inet_init_sock(struct sock *sk)
 =C2=A0{
+=C2=A0=C2=A0 bool is_ipv6 =3D sk->sk_family =3D=3D AF_INET6;
 =C2=A0=C2=A0=C2=A0 struct net *net =3D sock_net(sk);
+=C2=A0=C2=A0 int rc;

 =C2=A0=C2=A0=C2=A0 /* init common smc sock */
 =C2=A0=C2=A0=C2=A0 smc_sk_init(net, sk, IPPROTO_SMC);
 =C2=A0=C2=A0=C2=A0 /* create clcsock */
-=C2=A0=C2=A0 return smc_create_clcsk(net, sk, sk->sk_family);
+=C2=A0=C2=A0 rc =3D smc_create_clcsk(net, sk, sk->sk_family);
+=C2=A0=C2=A0 if (rc)
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return rc;
+
+=C2=A0=C2=A0 sock_lock_init_class_and_name(smc_sk(sk)->clcsk,
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is_ipv6 ? "slock-AF_INET6-=
SMC-CLCSK" :=20
"slock-AF_INET-SMC-CLCSK",
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &smc_clcsk_slock_keys[is_i=
pv6],
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is_ipv6 ? "sk_lock-AF_INET=
6-SMC-CLCSK" :=20
"sk_lock-AF_INET-SMC-CLCSK",
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &smc_clcsk_keys[is_ipv6]);
+
+=C2=A0=C2=A0 return 0;
 =C2=A0}

 =C2=A0int __init smc_inet_init(void)
--=20
1.8.3.1

