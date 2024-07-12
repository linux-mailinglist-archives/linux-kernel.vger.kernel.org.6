Return-Path: <linux-kernel+bounces-250508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3A592F8AA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125B8281B47
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B556C15ADA4;
	Fri, 12 Jul 2024 10:05:23 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1408157478
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720778723; cv=none; b=ewN1UVKp/2yGWL1WH6JGnB8PwcAfE5JGJn+IsB3AvakHgWMjOZwn3618GLAyF4/bTDZJZ/ckFlRpj4oD45Xk4QJeGOyQJhn8PjvLb4wRz9kZUUZCV3bG2eOp7Qyw+UyUwWMOe4EoTf/AeE7OfSQ4+4Qju5zK6ZWpfSuuyWFNlNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720778723; c=relaxed/simple;
	bh=cnp/jBauw5TdNqTWXgohodyEGsjA86x4uCkuOKVGfRE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=G9uOasjv9/yKiFl4bZNRbyNabphMF3MfMBSOOj+yVYoCfciZHkbzMlFaWNXTyexEp94tkS4p1ZS807CNPr8kauHsxmxE9wuI3QxgmzXxdenx78EQT9fzKEGFBqXoegsuGx/U2KylgkJmD6U4PuMvqmCr9FLItMOhtXfqmds8BJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8045e14c387so259282239f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720778721; x=1721383521;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iyg9rhejF8Qe5A3voFgG9tU6Ju6NThvDf3tGPwmTcgg=;
        b=UVZZBjATV2W7ZBrOBvs3zK5fFekUWxyxO4jzg/cMmHNGXPP+C5wE6PKxiRVgeDjGvv
         KFOIth27I/aSNRTNCF64rvVUWjzqw/vehA2kb3GGd/Y1IBidD3sbc/Uh/Yq0fqCL4Wwp
         GpAmlcfGfc//hgzBFgHkVm39YC43yLoUagw9Unp1BSUxNHxdUfLAcIqM7mDjGMPovm1P
         7nf5bGL4d3hgpilkAwHMY6DP/4OI8gps61nOMJVnxt6mL+7gn7BAoji6twuiu7AIiXrn
         cYaJEZMmAohvDxUIBK7kQzWvjmaZq5NAv7UXaBOkcFgtj9k5QOUmtpME4OwEgvKgPCjP
         izpA==
X-Forwarded-Encrypted: i=1; AJvYcCV6jrk6zb/acpudTLntX1qxgTX/j/7KFcuUb31Ii/ZuWlx40/bwALV5CWyxSXfa/4EcBjLkWHaoCU1+rDOHYjdIYXCa3ox3SzMG+7Va
X-Gm-Message-State: AOJu0Yy0Hl8A6fhvHoxPSPXmd26HGFQDfOlzZvkXmvcqQA9Hm6kncXti
	vgZWddiMTNvz7rxFTQ2omQKdNSs00PiECMG4W1sjdOUflm2wMWZFxwXYpKpY0wgI6IQDZO652Bc
	bExavf71fFuyhqThR0xjtRmsD6j/ljqkwdCFjDaw6SgdtURVp3TliDXM=
X-Google-Smtp-Source: AGHT+IFFBk/W1SQSv0kMIAhACc/3QzDzQ1IHiTDda01MIv9ZAbtoVD6gv6Et4UAM+5UIVNANJhxXnWsOn0amnEVcYvFYxkoWdGnx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24d5:b0:4c0:a8a5:81f5 with SMTP id
 8926c6da1cb9f-4c0b2b331c3mr891446173.4.1720778721119; Fri, 12 Jul 2024
 03:05:21 -0700 (PDT)
Date: Fri, 12 Jul 2024 03:05:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068db93061d0a0468@google.com>
Subject: [syzbot] Monthly serial report (Jul 2024)
From: syzbot <syzbot+list7b2f8c4a3e5b92bb88db@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 0 new issues were detected and 0 were fixed.
In total, 16 issues are still open and 42 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 114     Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<2> 67      Yes   BUG: soft lockup in tx
                  https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
<3> 39      No    INFO: task hung in filemap_fault (6)
                  https://syzkaller.appspot.com/bug?extid=cbbcd52813dd10467cfe
<4> 13      Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                  https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<5> 6       Yes   INFO: task hung in paste_selection (2)
                  https://syzkaller.appspot.com/bug?extid=275e275bd3f536725dd8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

