Return-Path: <linux-kernel+bounces-332146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 966DC97B5F5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 00:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2771F24C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14203166F1A;
	Tue, 17 Sep 2024 22:57:47 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5130115C144
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 22:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726613866; cv=none; b=ltc7eRTbdlKNaaKXBXjGqutmC6VrAlD2Lg92ndZu9JzSkSo23IjZIJoTS72mql+RH9mRFDszcXQI+hI/YI4Gkx4Iq/WqAyUlO1iV5ScRrRcVOHq2C5Fm4lKiF3pCCQ+65wWzBdis22oBYfbMbLklSHjGrKBjKq1LWCTTXqoZKgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726613866; c=relaxed/simple;
	bh=xRnxC3RFg1wvnYWAtKHCgiBSzoSkcYHITvn1QpTkXdA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f378SSfJzvxKX4Lkv7Pt6/igXpjIPm1zFAxz+qOBDN3fg/8bJE+TZ/frp30A0bLEAG4NOxXmhGTGi3v2JXkDeC3r4T5JVe7d6AGePP3TOIPVmtjIIh7qoIANGYREKDGIHAycvR1uHtYTCGHh2q1oixaWjWTuDTj3XSzzpbp4DpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a0a4db9807so36641595ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 15:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726613864; x=1727218664;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qqTClFTgVvBIEVRLdYgG5Xx4293FOgi8Cdwdo32lTpI=;
        b=FyeibbmySbGSVqUErq8EnnJqo07xlM9zWlMzkJbV5jnIuyBL3xi4nCcGcUjf0FrPKZ
         zYmv7kfzw2OlHX4wf+ZJjekYCwk/rhC6rl+nOChZLgqoUJDdCGGuOfiBxUm+uLgxA+Ob
         CeWTtdo7cTR2ndJIe+gaSb0GSmRVU+FNyp6HI497Y1nr/SisfTH3W1Gz1n3h0pNPpNg0
         Eje5lY0D1PvOuKl2LJEefa2SxeRCt7Atv5RVtLGrDYZBFUbOwNSDVCLwg4sF+mrJ3pM7
         ACjmDvX1SADZ5WNMMWwDBG7Uza0SaZp21TH91r3RCYvvHTNsHyOSyX0aiY2WkEOB1o3s
         T32w==
X-Gm-Message-State: AOJu0YwNy5pnA9xYFfrpDIG9khQ6edeFabM1HvgMdC8s/hc+bHgpq8ys
	v5l2uoF04i6h6aEQX3AoTUUEWjMFLOXSNW44NUSAZQTxT6OriUxx9TMAUUs/evToj1qnNCeQ41Z
	heVCK+itHZR9JuURMjKjQEs3xp4RNDjlinMAVHLrLAMV5VBK+izs1M9Q=
X-Google-Smtp-Source: AGHT+IFjDLRG1obEqyoR3j6sN8SHSrnA3vxR8kFfqIwLcnmidqzX830UYZF8eUGzK3jDqOYZf/GWB6Ab7I2gi2qjZhmNMTnhWp0O
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164f:b0:39b:330b:bb25 with SMTP id
 e9e14a558f8ab-3a0848f7e52mr196769465ab.12.1726613864446; Tue, 17 Sep 2024
 15:57:44 -0700 (PDT)
Date: Tue, 17 Sep 2024 15:57:44 -0700
In-Reply-To: <00000000000039e8e1061bc7f16f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e0b1c0622589e12@google.com>
Subject: Re: [syzbot] [PATCH] net/ipv4: Fixing circular deadlock
From: syzbot <syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] net/ipv4: Fixing circular deadlock
Author: srikarananta01@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Fixed the circular lock dependency reported by syzkaller.

Signed-off-by: AnantaSrikar <srikarananta01@gmail.com>
Reported-by: syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e4c27043b9315839452d
Fixes: d2bafcf224f3 ("Merge tag 'cgroup-for-6.11-rc4-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup")
---
 net/ipv4/ip_sockglue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index cf377377b52d..a8f46d1ba62b 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1073,9 +1073,11 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 	}
 
 	err = 0;
+
+	sockopt_lock_sock(sk);
+
 	if (needs_rtnl)
 		rtnl_lock();
-	sockopt_lock_sock(sk);
 
 	switch (optname) {
 	case IP_OPTIONS:
-- 
2.43.0

