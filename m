Return-Path: <linux-kernel+bounces-258328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8724C93866C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 00:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303951F2110C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 22:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6424F16B381;
	Sun, 21 Jul 2024 22:11:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9851667FA
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 22:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721599865; cv=none; b=bPoqhivOKKvBu3cqvqbJteTBNJS+0M5oeNpFNJsbJ3kLXKW5SUjTCPDPVzxnSbM6GeY3f8o7/QXP+eTl2b6xPdi1cU9bS/WQHoEH2yj1yt2LTLYa8vxT4s5G/e0rIApaO2616+8watCxcdOCAJOwa1LBxXXVuuCAlmgA3XvSBCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721599865; c=relaxed/simple;
	bh=ROuYac/v7HvupO/ZKKFWMQblw6xDVtj71Yh0bJWBPhM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Afe4LxCgIAV0lA2itFNWkbuvCG5WB6CHDYxjPMPmiA5ENEHgfnmyNooy1PP1Vrp2/g1MeO1WkaEWLrLbvcKBZp9HKEeQtGK0CepsHWWVy/+UJhtNdRz5FYw+ZlwcuI0eT5TmlDlp2HE8kDfbJ1XVVgd7qfPFNYG0ex0hCDPOYCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-803bafb0b2eso615587039f.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 15:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721599863; x=1722204663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/ElcXLSEs+o1vvYpa3l7nSiB+TQAeaMdVYMGYY04DA=;
        b=Hm0DlEZBURaHGL/9cT0vEPHixZvrkCPtf9FSU0236qzRHb/XMnARgj9RZsS3tAX0Vi
         GZCS9wQw8KUTraHvRE9bzOB9IpIb16T7xwXEt9yqSlY7jR+5yRfOtUwsM9cUjGw6aksg
         Rvrhz74JF9dUoBwyHgnnzDqStcknigSQLmbrek401ZMLHFPumr74YJ7nxMXRNA3MGdP9
         lrpkVUzKUhrxkI03pviSHlbsacwqaKtRl2NPp7dIJV5Anrzm55KhMumqkRk9qCD2bG4k
         1zmAuBPlqBXvET9KWnBADQRMDBVUjgQZIa0caA8euNnz6GO9+EPEbRXkzc3mWBXmbiuN
         T89g==
X-Forwarded-Encrypted: i=1; AJvYcCUtaftzITYkia0aB7bG1iVGiS9V2lL3BYUh93f2kLLuTyxWmflCYSlh/k2dl1nQPr3qvnHAhXN3cctGFc7tKzJXu/EGCFKAQ/tDM9jr
X-Gm-Message-State: AOJu0YziboZWlbs8/gi9sMFqJa3OP9tpe/6FA8vqctFJzsCC02j7LZUS
	KPGF2hWLclN0RoYA3oZllPjA6JA+kEia0f3Gkrz31sFNDNI+ScyVJHiDp2heZWL13J39PN5SrTV
	8r58TzYR9dz5bzA2Kvxaf5Pl1G9bU6fsnZh4NlOGkLBbMdWMZ7JZq+mk=
X-Google-Smtp-Source: AGHT+IFwlqPBP6jWzZoW3rXuWMFQh7FGBhuuytJsPLPAnDTKR+xV7i3/zG+COlCuJ9KX+tHMpHzb43pblyAGQqs+ies1faZTIBDj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2395:b0:4b9:13c9:b0fb with SMTP id
 8926c6da1cb9f-4c23ffdacafmr276882173.5.1721599862798; Sun, 21 Jul 2024
 15:11:02 -0700 (PDT)
Date: Sun, 21 Jul 2024 15:11:02 -0700
In-Reply-To: <0000000000002501960619e2366b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004485fa061dc93442@google.com>
Subject: Re: [syzbot] [gfs2?] BUG: corrupted list in gfs2_fill_super
From: syzbot <syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, hdanton@sina.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 30e388d573673474cbd089dec83688331c117add
Author: Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu Apr 11 12:13:30 2024 +0000

    gfs2: Switch to a per-filesystem glock workqueue

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13653eb5980000
start commit:   523b23f0bee3 Add linux-next specific files for 20240710
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10e53eb5980000
console output: https://syzkaller.appspot.com/x/log.txt?x=17653eb5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98dd8c4bab5cdce
dashboard link: https://syzkaller.appspot.com/bug?extid=d34c2a269ed512c531b0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16907bb9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ce66a5980000

Reported-by: syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com
Fixes: 30e388d57367 ("gfs2: Switch to a per-filesystem glock workqueue")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

