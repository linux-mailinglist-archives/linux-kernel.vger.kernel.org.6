Return-Path: <linux-kernel+bounces-361371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FA899A755
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D93AA1C22838
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E175119412E;
	Fri, 11 Oct 2024 15:17:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B48D199BC
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728659824; cv=none; b=fPcsCvaazLlSkm5zLU1ryYMNkHz3RjMvEvOcZyYNhXpqfmxM+P7efxPnxwu7VNzt9BThHxvX/FfMzDn6mOn95nsi0orIId3RDCBU7XEYnkFKMmGYhKdqqN200einiFHKNeWcCogF77HYReozGrUnEmZrMZFvP1FFNeZpfIGslDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728659824; c=relaxed/simple;
	bh=btscBbCTnBPEIy8sGxXbXkEpBJp8NPPTiyWTgomGN1k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PfLJzOknwHpVzdF4x9qA5sI8Pgw0mNbLRddYJz4fKcuLiirYu6I+nCVb+0jVj+SZYhqjLvCGy0yR4BIxfhGRWiXeniH8QTn8iN2LGwKd6DSVDBX6sLjFrsujRkkoTrn+LxGvKDddfsAYb5g/OJSuUx8Xa4Xgjy/D8b2MdaKsRNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a19665ed40so13193795ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728659822; x=1729264622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkhsWbmpSIwr7KtaYgxACGZs+m9NItbxmU6IQ53lGPU=;
        b=goqGi9nyoRiEm9nRyQBbSvsYDqmAbjsxRs9plikNrW0tetTPxpbW7ibkLsr7/poMjN
         S/cp1vg3NfMN/haHfo0PBb7pmM86ZjgN+v9LdqyccibVZ+/+uk4aXin/1mSRnTwm5pZl
         ClHp6OC5gLmw1L+40HJXM8S/htRt6CPpbnEOrGHyas1j4URfsVejlnzOiWul1ZOPH5ig
         Hh9CqKFN7VgoA2LzHRcBXJ+xZ2KX4b2Dm6xdJgrtiyjN1PEXgFm8htKDh3ApFpsfaFw1
         QxKS+yjm3E6ertoG3+aqx6BYxycpapdK30tYGIXg/zcGKsZdak0Qkh1BBGWioxWObX6M
         hSJg==
X-Forwarded-Encrypted: i=1; AJvYcCVnF7eJ65Rk+lfoMOoBwOO/9iZZ1Moz10SQWZ/6FzUJejcKEbVc8wEE4QiXcIQQz0uqZNsvQI3rtYUBmHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN5v8wOsLXjsmwfICMt56egnS4oarVejqK4mdOyM/oRGiA43cK
	mNuGCHsscxWIoT9vmcpv7lbPJobX8IFZM5HGWNWM7+qQ99VneydT88+sHcPA+cYPEL7OlNrP8t8
	JZRqu6CwpUAyCpzI/H0GVmjPi4UqF3ZyIokpZ/igOzfzdowAzFqjqEJA=
X-Google-Smtp-Source: AGHT+IGmZEf0vqRnRJZkBPj6kWrDqVq/f2/pkq9A/frbUV4MWpd1ByHBxl8YzWfT/BkWNzm6c3/er26n6U/pAER1JdIghzhRJtVi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a45:b0:39f:507a:6170 with SMTP id
 e9e14a558f8ab-3a3b58aa871mr18180465ab.8.1728659822390; Fri, 11 Oct 2024
 08:17:02 -0700 (PDT)
Date: Fri, 11 Oct 2024 08:17:02 -0700
In-Reply-To: <0000000000005d16fe061fcaf338@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6709416e.050a0220.4cbc0.000b.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: task hung in hugetlb_wp
From: syzbot <syzbot+c391aebb8e8e8cd95c55@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, kasan-dev@googlegroups.com, 
	keescook@chromium.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mcgrof@kernel.org, mhiramat@kernel.org, mhocko@suse.com, 
	mike.kravetz@oracle.com, muchun.song@linux.dev, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 3db978d480e2843979a2b56f2f7da726f2b295b2
Author: Vlastimil Babka <vbabka@suse.cz>
Date:   Mon Jun 8 04:40:24 2020 +0000

    kernel/sysctl: support setting sysctl parameters from kernel command line

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14c7f380580000
start commit:   b983b271662b misc: sgi-gru: Don't disable preemption in GR..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16c7f380580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12c7f380580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb6ea01107fa96bd
dashboard link: https://syzkaller.appspot.com/bug?extid=c391aebb8e8e8cd95c55
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118c6fd0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b6a040580000

Reported-by: syzbot+c391aebb8e8e8cd95c55@syzkaller.appspotmail.com
Fixes: 3db978d480e2 ("kernel/sysctl: support setting sysctl parameters from kernel command line")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

