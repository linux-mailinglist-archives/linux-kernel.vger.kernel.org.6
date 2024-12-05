Return-Path: <linux-kernel+bounces-432808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685A79E508B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D38286EE4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55CF1D5CC2;
	Thu,  5 Dec 2024 09:04:29 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B851D3566
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733389469; cv=none; b=qdwfOR8olDN4iXuCCHOuKLR/7ojxVdgym2GRYU8CBtazkFrmLZ8+DEL2sd3APIKTFB2m+gAPvZ1SkU2WKYpznEP3QqxAl3/Xt34Tuo/sQAZqdYbetAZ6r/sgWXU+I3sGMhlnriiin+V5ExuXXsQuhjBCnuXcWOOGCbSxjSjAAUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733389469; c=relaxed/simple;
	bh=zgVVy5XTLk3ptOAekcjfO0olEswNPRCyhZPPRQnNnwQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZWgc3g50i1p8YqEPQdn1Bcof9RriTaPYcj58GpuPZ8xV5wZY4FwpASDfVK+IOGWcWpc9zYHNjCJm8zgdZfKzbFU8MyvXPT0nBckiUs2J02rfutOz0TJS1E50f2dJ2Ie7O9oCcXhFvTscMUP5Lb1FeoMps+Kk+M473n4dRFyCUos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-843dd952aa7so71739039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 01:04:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733389467; x=1733994267;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A50ennj8/l5LmpVJOQIb11du27QuZZWN9nvndJYiIt8=;
        b=W5WZx70UlJCkLtsLAonbXNRoeHXDPAhCRiXiHBcSrYIx8dFE+lpJ31MLy67P6g0ZJe
         x8GPn/D1Ss5lzvezZC+D3ocnQQXQTXkEpvv7LKN1wUteLnfnUR8NCzNVoEBlInPwVjg3
         q5LA6lLNt6E+77lg7xSm/Wdpr0xCUhxFStVsWjOZd3moWtzSN7iQquhA2bjQsKTTPRQG
         yUBqRud0or/H9Kev4NPWzhZ512ALHnFxQzU+e7FCNwcoTceoP0zlKTxgqig+vVOFKyid
         WBvD3Ork71hlJBGOmqVp8Fe/9XqXvn4qYJ7w0WxYL8KhNAzFFQBY6/RNu/it5Z1Fz3Nm
         3Rew==
X-Gm-Message-State: AOJu0Ywlf5jhhhYd+UCU3fjQVh+Sut0B6yjYhn6cTeimPodxAhKROJEo
	2WthR7n11A745m0DjDXC9x2iDEbfbafSvVvFs56qfy8FEG19sHB/vzN2kYtzBDIrxAsUg1iWF6O
	8rnYkzF9A1y+ncqJG/Ixd+a19HToRT9YSyTbF4HbuMeiOpcAtNJ+DH5o=
X-Google-Smtp-Source: AGHT+IGkizZga7sN5CYWA5QG1tBS31IluCqSzfXOIYfU5mE+eH6H+k9kkXC3INhDqYtZ1bVXrqsdHzGTV31W1c+dJe40KXNLf+zL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a02:b0:3a7:c2ea:1095 with SMTP id
 e9e14a558f8ab-3a7f9a372a3mr133223625ab.1.1733389467082; Thu, 05 Dec 2024
 01:04:27 -0800 (PST)
Date: Thu, 05 Dec 2024 01:04:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67516c9b.050a0220.17bd51.0090.GAE@google.com>
Subject: [syzbot] Monthly net report (Dec 2024)
From: syzbot <syzbot+list3c1df63765a7b6dd6d70@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 14 new issues were detected and 8 were fixed.
In total, 123 issues are still open and 1544 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  229243  Yes   possible deadlock in team_del_slave (3)
                   https://syzkaller.appspot.com/bug?extid=705c61d60b091ef42c04
<2>  31386   Yes   unregister_netdevice: waiting for DEV to become free (8)
                   https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
<3>  7345    Yes   possible deadlock in smc_switch_to_fallback (2)
                   https://syzkaller.appspot.com/bug?extid=bef85a6996d1737c1a2f
<4>  6028    Yes   WARNING in inet_sock_destruct (4)
                   https://syzkaller.appspot.com/bug?extid=de6565462ab540f50e47
<5>  5974    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<6>  5836    Yes   WARNING: suspicious RCU usage in dev_deactivate_queue
                   https://syzkaller.appspot.com/bug?extid=ca9ad1d31885c81155b6
<7>  4913    Yes   possible deadlock in do_ip_setsockopt (4)
                   https://syzkaller.appspot.com/bug?extid=e4c27043b9315839452d
<8>  3323    Yes   KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
                   https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
<9>  2606    Yes   possible deadlock in team_port_change_check (2)
                   https://syzkaller.appspot.com/bug?extid=3c47b5843403a45aef57
<10> 2505    No    possible deadlock in do_ipv6_setsockopt (4)
                   https://syzkaller.appspot.com/bug?extid=3433b5cb8b2b70933f8d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

