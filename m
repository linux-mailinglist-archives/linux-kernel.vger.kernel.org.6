Return-Path: <linux-kernel+bounces-552842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28667A57F4B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 23:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ECE5188E866
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 22:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D59120E00D;
	Sat,  8 Mar 2025 22:17:23 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA697346F
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 22:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741472242; cv=none; b=FtyPlT3hN4BNSPLTrY0ROEla25DO1weGLlEQbmD92qql8i21tf8j2uvcuicnlKInFl610HLbzE3K891b0ZUuYD0mtWftv+o6pVOC4igRin44H9557Zu3DoeYom6Bw6u7ZNlpPcbVQMLjeCVZZvvWktND0COYLkFzpIG4z0tJNzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741472242; c=relaxed/simple;
	bh=SaTkhtG0SkaBVklFl3Ngn63TnegBv53XmZOw6nVp0II=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kGi2i7v40fP3G8406WG/xafOltGjJlRdmL7vmaGfHMsRVSOEQNTsjBg1URSXMWgxWgDOi3lErlTB+I1KvQ22KgQCkao2QZFouvx1q7G8jzAMwqRyIZMS3euBjTLjMvCyhEUwSudnyRSfa1U5q0oSA1UsHHY4RlQe9j5ghhEEK4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d43621bb7eso29116595ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 14:17:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741472240; x=1742077040;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YG5ILowWsEuUT19TjhP+3edOOuFjMjQ6i4y2LcVwbow=;
        b=Bgkzt6jN0y5PuCf5PgtB4FU8lR1VEq2QcsAjlcIvCoSVlO3lPESFmDKXJpvrbj2G00
         0sgE2zqsCk1UUJs2xj6AveQz3CmuJOLNjvMeHJbBMU8L2hlWV5fBBqs2z/jHB5atHf40
         rOaObPIIzUCVnGdxH6zDihaWssJpU7uQOG1JNIR9n06ljJSUDHGtOOgsllzAirzOKwZ6
         XuftBwY1gcJDHpDxKmKgx8s1UIuhftL56kmotXIEjYIJDBM3dx9DNuh6PrhlhrzE6yvQ
         el9E8+ZlZdr3jWv6nGgLV41rpjUFf4ESyMWRGnRaCg0swffp2O9G/bc6wfK0ve2pOC0M
         T1cw==
X-Gm-Message-State: AOJu0YzrnJEeVJ2QsGhtRwU5fwLtxf1iGFhaJMeF8qBkf8abMWERlzom
	tI/HzMKwYobonka8nVzh3gJUify4MPSoE29u/TaPo+anKUKJ/sWph7xaymnyE6NR43VsRHz9AsU
	exveGiWffwYVzBcTIn/RsXnLWxMTmYrycOLbhqEx4wt3k9SK/zDILZ9E=
X-Google-Smtp-Source: AGHT+IFlHdfId2qa7tgSdU4uU+v4LWE1zzqSKiBGTx9q2+hXmGyACQ446Nrl/tFuRJUGXTOBSxy3kq4rJN6HjUy8AM7ZYXEhBdyg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ca:b0:3d3:f15e:8e23 with SMTP id
 e9e14a558f8ab-3d44af3375amr52658495ab.10.1741472240574; Sat, 08 Mar 2025
 14:17:20 -0800 (PST)
Date: Sat, 08 Mar 2025 14:17:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ccc1f0.050a0220.14db68.0059.GAE@google.com>
Subject: [syzbot] Monthly net report (Mar 2025)
From: syzbot <syzbot+listfe984f00d0c1292a848b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 9 new issues were detected and 7 were fixed.
In total, 135 issues are still open and 1587 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  288132  Yes   possible deadlock in team_del_slave (3)
                   https://syzkaller.appspot.com/bug?extid=705c61d60b091ef42c04
<2>  60606   Yes   unregister_netdevice: waiting for DEV to become free (8)
                   https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
<3>  23481   Yes   possible deadlock in smc_switch_to_fallback (2)
                   https://syzkaller.appspot.com/bug?extid=bef85a6996d1737c1a2f
<4>  11616   Yes   possible deadlock in do_ip_setsockopt (4)
                   https://syzkaller.appspot.com/bug?extid=e4c27043b9315839452d
<5>  7654    Yes   WARNING: suspicious RCU usage in dev_deactivate_queue
                   https://syzkaller.appspot.com/bug?extid=ca9ad1d31885c81155b6
<6>  6743    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<7>  6207    Yes   WARNING in inet_sock_destruct (4)
                   https://syzkaller.appspot.com/bug?extid=de6565462ab540f50e47
<8>  5554    Yes   KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
                   https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
<9>  3542    Yes   possible deadlock in do_ipv6_setsockopt (4)
                   https://syzkaller.appspot.com/bug?extid=3433b5cb8b2b70933f8d
<10> 3166    Yes   INFO: task hung in linkwatch_event (4)
                   https://syzkaller.appspot.com/bug?extid=2ba2d70f288cf61174e4

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

