Return-Path: <linux-kernel+bounces-444829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0289F0D20
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6713E1889D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 13:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F9A1E009A;
	Fri, 13 Dec 2024 13:16:33 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BB3383
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095793; cv=none; b=eQ7g4OxTQo+vArAEBuQsXYq6++J72rsRQkYo3u8X4x/XO/SbDslNXj7a4kWNYdzYp6TsHgyljphPCu6ehEl+CTVHYG5vB1ELnekc1W1DECCM3Hw1JNE4GKodTHgraZT/AXY4yVT8oHP2b1WUvZJHRgMYX162jETEDStTWUamBBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095793; c=relaxed/simple;
	bh=MfODUbaKjsDTInyPezTB9iD2+taJp9jMC+mbhYdLpKo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KI4axNRNrttDzTq8QxZlUDdU94NParo6IZ2ZssGN547N1VB04YFzGmJLsfXhnEHoztu39MO+o1qr5l/a7Ooax4IOQOfjiTtSnEerQgFRmaPQGgULUE7zSNXElcp9cj3yyu9UwdYH1wuyWzgFBrAjGp9LjNiWE8wd/0N8LVX7QQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a9d195e6e5so15874125ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 05:16:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734095791; x=1734700591;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uoBiKipHNLLpHGGGSTJe/jfqJxnRClX1ADVodHH2Ukk=;
        b=Q1DTjO/xxT+OG8+wTjdfP8itkNKMvNmeDskZZBiykila0xoJSRfbd84MEpIEjV1wLN
         NqjeXy7f85S39ifZ/1kGa2BgOppzw66cuiIY2UNis+HYPEQ3na12e1cgIITqhIUV5TfO
         9QvpyNvHZKcniycY/g+yrR8irFQv0YEvICDp27u+IOiyLuKntF+8bL4FatHewALqRXQp
         KI4v8mAxYShukrcc+ViixZWFrXH3gd5pewm57l16qZCsG+VXykN8n/OGpVdghhOhlFDP
         +iWPkTfPKwpblx4c0YplOr6VrI40uQVmtCZu1ej95tHqF5zUN0pmIaegMI18y8NecyD0
         gGGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlgT2dKg5pcXGFv3oI20zvllEExQNFzCiVK5rXjIVxpUOTBlfHe6UDf14pYmwrsVSf/ZHzNcGXqn91XVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgf8rx0vgmDn6PBwJRv3XUoa99divUtj2EIUK8E01lVgifw5M5
	/OxjDSzR0FmHqKdXXFoW1yPcrs8gTyQTt2n9L6QhwcfU9MD6Ssyhep2jQEFn4cvYCuYpNS2mZ4m
	VcDLaEKncJgELWkraoj5NivNOm5K1icMeOb4fUxHhJz4LmgmG/a4bFq8=
X-Google-Smtp-Source: AGHT+IE/k0fH2aZWvFpnpJL0Kpg078Jm4gbrIke1NK4w8p393GE7mD5tDe40KwEIlaW3OO2uN7GjbOFMai0o7tHJH4bF+ddEJxL9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1448:b0:3a7:7811:1101 with SMTP id
 e9e14a558f8ab-3aff2dd4d49mr35489215ab.20.1734095790862; Fri, 13 Dec 2024
 05:16:30 -0800 (PST)
Date: Fri, 13 Dec 2024 05:16:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675c33ae.050a0220.17d782.0011.GAE@google.com>
Subject: [syzbot] Monthly netfilter report (Dec 2024)
From: syzbot <syzbot+listcc55049a3e829aa8f20a@syzkaller.appspotmail.com>
To: kadlec@netfilter.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfilter maintainers/developers,

This is a 31-day syzbot report for the netfilter subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfilter

During the period, 0 new issues were detected and 4 were fixed.
In total, 12 issues are still open and 181 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2851    Yes   INFO: rcu detected stall in worker_thread (9)
                  https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
<2> 119     Yes   INFO: rcu detected stall in gc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=eec403943a2a2455adaa
<3> 52      Yes   INFO: rcu detected stall in NF_HOOK (2)
                  https://syzkaller.appspot.com/bug?extid=34c2df040c6cfa15fdfe
<4> 47      No    INFO: rcu detected stall in sys_sendmmsg (7)
                  https://syzkaller.appspot.com/bug?extid=53e660acb94e444b9d63
<5> 39      Yes   INFO: rcu detected stall in ip_list_rcv (6)
                  https://syzkaller.appspot.com/bug?extid=45b67ef6e09a39a2cbcd
<6> 37      No    INFO: task hung in htable_put (2)
                  https://syzkaller.appspot.com/bug?extid=013daa7966d4340a8b8f
<7> 10      Yes   KMSAN: uninit-value in ip6table_mangle_hook (3)
                  https://syzkaller.appspot.com/bug?extid=6023ea32e206eef7920a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

