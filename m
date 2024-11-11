Return-Path: <linux-kernel+bounces-404626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9767A9C45DD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494E71F22B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2411ABEB5;
	Mon, 11 Nov 2024 19:31:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9BB1BC4E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 19:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731353465; cv=none; b=Wqj62eZQqXibtnFd4jcGkQ3EqaT5AntAOx9wS+uiKyskkjx8WvXDW8hru0G7/dnZ+l1lKaJtZAov0Ha0UugAKi+hgVNoqjV49Z1/GJWfB5qNAflZWTCLZJkYXXawqDfyW6uZ58SAv+fkJ27c4PVF0z9wd6RDxLAemHVIs9oB+1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731353465; c=relaxed/simple;
	bh=8lD6pjqUaEEnz8Lwcni9udrkwgXEMo9rhg8y3GEpFSQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ATCzMp61Q9BqQeNQoAl04X6AadOEoCW6SKKtoOhyhvk1NiJuw+I/BBkrxaYo7T+HSIf3Bhn0miyd9tNwBykUE5ftoWBbNGSixnzPqhiQfSp/4cP3aZlfJrDD1I2LpqernwQp7PlWI0T0ehkOZ1yhRb6DbMxJoqq5g/T+rp3Cc9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6b9f3239dso59280365ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731353463; x=1731958263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlzYQgUumPnzekRxkdmJBUji2yXE83PUYAHCHvSLvSc=;
        b=anR6847t9KyWVb+lrF5orwKRUcMWVyRI1WKHZQT/fUdB0rEAYoQaBziqboCNFWTr3+
         zTjX4PWArJmoH+m2dQcQqhz8Wt392BSXHC1zzcwmqLe/N4bbDJsvYSh4anNKyrHkY4f5
         ADlmCMe6j0UP5JuPKBqd6dYFtPQAXQvl8eOL+0k4kc6DHnhrfKIXg0I3n1R0izIPdZM4
         Hn6d8Y081KiH6cR13Aice0mn4TbguvJkdkHq4/WXYjKQdEs9gmJCeS71fp66o2aMICbc
         zUxRJd8dVGJrtwFEo761o6iWLwN4vrxXa88JfB1zBtNsbrT2fZujNDRMZN+fzavQsD/l
         Nylg==
X-Forwarded-Encrypted: i=1; AJvYcCVpZy9RI/nPQrh9oKxas0L62+66NCuxNK43S3vKzvRxSQLrpXMqTL9LqYvs0PVJ5U85wHoek/LyVt8voI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUcwslaCFmWH7wNBi0KZxk+4zL5pHh2AMg+OBpb1yNXh2cdoYQ
	irrcMxMroKwa2HjieMWJp2OvinE1Semr4T6nEAUVR7n3JOAhZQ1/MsSva5+KZoYjUZeP53XwUUu
	6Jf0MeToNdTx8Sjoknvxwrauip6qaop/WPxc2n+W86w9q4P903xaTlPw=
X-Google-Smtp-Source: AGHT+IFyBbSMfXYwp/piVxzfWXG6Yip8TVhwMUwFN5Ms2DQoEKAqdMxR7gKcE/BbcUdWUymDtIukG9/i3gpbJB+BoUPDv5h53xUS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f03:b0:3a5:e532:799d with SMTP id
 e9e14a558f8ab-3a6f19e86dcmr134852095ab.3.1731353463440; Mon, 11 Nov 2024
 11:31:03 -0800 (PST)
Date: Mon, 11 Nov 2024 11:31:03 -0800
In-Reply-To: <000000000000f3d57d060d0556a1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67325b77.050a0220.1fb99c.0151.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING: ODEBUG bug in advance_sched
From: syzbot <syzbot+ec9b5cce58002d184fb6@syzkaller.appspotmail.com>
To: davem@davemloft.net, dmantipov@yandex.ru, edumazet@google.com, 
	hdanton@sina.com, jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	leandro.maciel.dorileo@intel.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	vedang.patel@intel.com, vinicius.gomes@intel.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit f504465970aebb2467da548f7c1efbbf36d0f44b
Author: Dmitry Antipov <dmantipov@yandex.ru>
Date:   Fri Oct 18 05:13:38 2024 +0000

    net: sched: fix use-after-free in taprio_change()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13a7b4e8580000
start commit:   fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=ec9b5cce58002d184fb6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b37db1180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1371c30d180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: sched: fix use-after-free in taprio_change()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

