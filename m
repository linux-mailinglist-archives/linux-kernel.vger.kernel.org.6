Return-Path: <linux-kernel+bounces-329494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D16A979208
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 18:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8EB71F2297B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 16:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F19F1D049D;
	Sat, 14 Sep 2024 16:12:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A754E39ACC
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726330324; cv=none; b=cP3o0++9wCQeG0A0aDihIgaR1OEl3yDRlxuJ7lPIXXsXrvirFOdrQ/K1tWW7gYljQuSY2mDF3EJ+/030mbtxVsKvVN+s3K6igoLE0awf+EvaSV8oMXzRVcHvnx7Kqhw0hmKdZV6wxYezHopbLi7S08De08ss2gzwSUdlA92+y5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726330324; c=relaxed/simple;
	bh=3/RaIZT7WdvooM9BNOa0osJLBSkrxtxxgxDPh4ZRNTU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DVx0eDqxUJ9HxsTGwuzPr9upAstGdx99df0RHspz65FTr8H/NnpvBW/RL4XKLDQF/uYAyVgSHbqxdB02eB+CSsM/ZnpYa0UXctnf4iwKozR5L96SYZlKA0c1YuvlGUM8tWJisB/n8OKzel7g9vi0nRHRoz8SzaZr9XyhrQT6tsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a04c2472f6so55963525ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 09:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726330322; x=1726935122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=elLGdhu/N7XTEKaqxHm49lH0bwEsUUVJ3oDAKjdaD5Q=;
        b=P4pFR7q5JBQFlw+B5wFWTrTOfCbE+uavAE7YUNqflo/qq1L2J/JQe49Dg3j3GeLpNU
         uuW86B/D/oOqW2eLXwesOUyWjY3+bxeaCTTRHani1ACYLhVuWECn/gdg0TdJ8tJI+wH2
         UOTgdNxCo7TdwVZjcdtdTk8ipdP7ietr4iStXQitIwiEAdmrCDHLlfJlfTgEt2reGH2d
         I6RZFrcVaHCVrES4DGSBu/51kMm5dPft2tte3HCMIZU72ZmaCMxVUx2/ZdcFWvavprlH
         /KlC5wELgN1x+f6HngCmrtxLxAx+dwFHo7x5Ur8QbmCfJnwdCBuI3A/JafKWlH0zhVjz
         71kw==
X-Forwarded-Encrypted: i=1; AJvYcCUanFHY86C0fRY58LzBseNO7LaWGh2mdSM9ylI/uGizRGDbX00O5NCmeWtSb6xhZ+Yh3pC5sU/iqZyM9Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzafqiZlQbTALvb68XWo7sNEhix1koluSJXfJwDnJPtRDtek7oD
	3WUrIiMxk3hIt3BCr8S08YxOe+aNWMPTaozztg7PjtnwXCUu1n7LT9weAEgU8dKDrT9o4252Obs
	jmoQiSWy82q92e24zkFg1z3RzzD2si7fPjbVadeRTEZbear5+LfDTqlQ=
X-Google-Smtp-Source: AGHT+IEc++CMyi6bkWbEuObVzejUUGoJZN+8Kp9MFs8scQOh5Rafy+cL57mjP3DXHmucVMmExu3iETWNncLa6nd6JZ8MiIDzZQDF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2e:b0:3a0:9d2c:b079 with SMTP id
 e9e14a558f8ab-3a09d2cb143mr92265ab.19.1726330321813; Sat, 14 Sep 2024
 09:12:01 -0700 (PDT)
Date: Sat, 14 Sep 2024 09:12:01 -0700
In-Reply-To: <0000000000005c8e95060babfa0e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66e5b5d1.050a0220.115905.0008.GAE@google.com>
Subject: Re: [syzbot] [virt?] [netfilter?] INFO: rcu detected stall in
 ip_list_rcv (6)
From: syzbot <syzbot+45b67ef6e09a39a2cbcd@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	jhs@mojatatu.com, jiri@resnulli.us, kadlec@netfilter.org, kuba@kernel.org, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
	pablo@netfilter.org, rjw@rjwysocki.net, syzkaller-bugs@googlegroups.com, 
	vinicius.gomes@intel.com, virtualization@lists.linux.dev, 
	vladimir.oltean@nxp.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit e634134180885574d1fe7aa162777ba41e7fcd5b
Author: Vladimir Oltean <vladimir.oltean@nxp.com>
Date:   Mon May 27 15:39:54 2024 +0000

    net/sched: taprio: make q->picos_per_byte available to fill_sched_entry()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17264407980000
start commit:   753c8608f3e5 Merge tag 'for-netdev' of https://git.kernel...
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8715b6ede5c4b90
dashboard link: https://syzkaller.appspot.com/bug?extid=45b67ef6e09a39a2cbcd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15abc0e2e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b0c7c2e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: taprio: make q->picos_per_byte available to fill_sched_entry()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

