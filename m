Return-Path: <linux-kernel+bounces-172042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED0D8BEC5C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 21:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03441C23DB5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5658616DEB6;
	Tue,  7 May 2024 19:11:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A173116D9DC
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715109065; cv=none; b=MKg+XUcH/VONip8ysfvl+2IuIWfTFTLRwXCdPmmcNFiiDh4igfVCKK6xmj5qo6rVCollfqUlDCn3mhw4GIfh0PMiUiSaLaeHe/bQnwfCZYX3UcH/SOknu5NoNgkRrzUsQ64YxH68qILnexBFEtilzakMvC7Bta706VaLcVPFPgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715109065; c=relaxed/simple;
	bh=MZDRcTYIrPY/KVDPzLf3Ur1jeAmwMRwZb4IO6MJFfP4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uhNYaP4TLZNP+G6HxuapEPseSnrYoPzIb4CYrnfB90jW9AVV9yN4xx4kIADwB2MalzTbeezaF1zDwYnTBO05k/o7dSKy2FnAnf5506IhkqoUOAnKZ0ImoqK3+B9HNAp30OwnIh8F5qvylQ34M1xooO0dmh31JPLuV8vMU9GWa2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36b1fda4c6dso39823245ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 12:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715109064; x=1715713864;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EMMmdnnhlCk6lDibFaruqJ+bDg8KgHzYf4Lb5blyQuQ=;
        b=aghpxapTGK5dFQufNKf/g8/BcvlWOmvrUhZIKbTmK8A53OWlwZ00GFfCcsLk86PqMQ
         GRDieA2/YhaU+CcUEwRzj7TEfzCJumITXyb+ptkta5HV22r5UbALX60zpXpvdYXrs7sH
         1lhnKwq3I6oBLQ+4zEYSKq382UcPbzUBK7MjpCk4snIaU8iIjp9jorbNLCwx2CL8bsfp
         hWIY6qykSfq7yW+aQy9t7xv2WidHObx7E3Fz8ypX9qSKpNdSLLnGc2X+8mH4bHBGLTEU
         BZibjea12z7JHyEIswy3F5Qz1sBSso7RfW0zkUzVPAApiglxsHWAGCIovjtKMsxa7nwc
         RYsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUbkgDvomg8WICYi9vZ3/zFEDzzlyo00g6GFDJTtjVYBl8i8rZypE6nuBnNOMA0WMXH27nh0CacmZQnth2/ZvUCIOo0gBA2oOvjfJl
X-Gm-Message-State: AOJu0YzhDDtpOykEo/WQJ0Zt1VOd1cqVjAXhJdOjc8bflrLaOjgeZ7jz
	4icnRPHdTQ5QoFcf3IchpNTBiKwasyHnoF5XKT8/YQ8tqYyQoRVI7I9KJYhHP0giOs8mcJBklnM
	p785rsJgw17XHNagilu1bjqhP23RknNKjxNMSUrYLj+MZhkqYIeXCjeo=
X-Google-Smtp-Source: AGHT+IEtr+Z39qefIZO5XPc+3zq+HrmB0hikp4+IjhHgaHCLJ1/SO5ihOTsmd39/5axw913OgOIRhRdWd2p2AaH1XlWhF4l6RT8a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9c:b0:36c:5520:9597 with SMTP id
 e9e14a558f8ab-36caed58de7mr195005ab.6.1715109063836; Tue, 07 May 2024
 12:11:03 -0700 (PDT)
Date: Tue, 07 May 2024 12:11:03 -0700
In-Reply-To: <0000000000000498630617b740d3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008059400617e1f284@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in rewrite_old_nodes_pred
From: syzbot <syzbot+594427aebfefeebe91c6@syzkaller.appspotmail.com>
To: bfoster@redhat.com, eadavis@qq.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Sep 23 22:41:51 2023 +0000

    bcachefs: Ignore unknown mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17afcbc0980000
start commit:   7367539ad4b0 Merge tag 'cxl-fixes-6.9-rc7' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=146fcbc0980000
console output: https://syzkaller.appspot.com/x/log.txt?x=106fcbc0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=594427aebfefeebe91c6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d1b2a0980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=135c2ca8980000

Reported-by: syzbot+594427aebfefeebe91c6@syzkaller.appspotmail.com
Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

