Return-Path: <linux-kernel+bounces-209988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FF1903DC5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ACA01C2333B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38B017D8B4;
	Tue, 11 Jun 2024 13:40:26 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD5517D357
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718113226; cv=none; b=WFchS8/uqGB1oKz1FFQYYYpB4sUb43I7sKeCJaXO4RcUbU0bz+3E4cH4CTY+3lJqUKyCqh+Z8WL5ToT9b5YcV27cGOxpHVF5sb2Nt/Pcs+Mof/Tss/F2GL5dvFYOFtvR5dnaO4NdOTu99TaDtVFk5z1ZJMcPOejGbM7tHpeFJj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718113226; c=relaxed/simple;
	bh=Q+spwWSJC9x9li46TIO+VakRkC5shkNw/e/ETJaivJQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=e/LQzuKkNn7VMn+UYS5LirDRK7Rjq0YCiq6qHYIO00+S//IQuQGGQtjI12MyBjRsIcftmzDBEKiRCslvyFRirCq/cIj9Mf/f81kxLFxcTmf25k65mINe/w9HuL5qt7U/q7DUch0onfTxIxVIOUVt/4GEDVtViOTFraBKEE2hJgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb5cbe815dso496578739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 06:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718113224; x=1718718024;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=40gVOiowLJOudabCaHorAkpoqJRBZmmZN7J4HzK5TFQ=;
        b=U+uULZ1595u4txAOZgKsuD6EoZBn/6Fz/QGoBwGBHiAU/V9KL9bzQCZy+DZvV+2igU
         Lyctwi0OdJ3+SrNncGsMzE27Hrj3fufJ7dnRhZ+lkiphKpl/FdqT5KthbZMVYuk7JVHv
         pQRmcqwFSZEYdbH82iYB9vYv3MjG/Iw5y///uTIHzVzQi2zNxM4PyQvEXflfQA2UYylw
         G3FhHvOHV9u856kM6guQAea7UX0IQoTRP21gazn1FAoc4Lwo6HhyrIWYGwwtfLv6x0yH
         yEnqGutxHWb1iUFxoess28FeLmj/XL5vWhRCYQ60v8OfHi6B/fGHFfvDJktR4B9KMuSq
         +yqg==
X-Forwarded-Encrypted: i=1; AJvYcCXgTMpZ3AjuRDC2XcJY4IVZaj3DJD/u44crj7bnAazlJ6DxIXjnUEozmMCTsvYbrydJLOQU7YkQR70+cdQCepLKNzfPfuMNddxCgIJ1
X-Gm-Message-State: AOJu0Yz7DddOqCanlJDa3UqaA5T7B8Uj+DIjQv2bE+4IzQb2ImK9guL+
	pprjBqB49o2gQi72G7JVa5EpnhnnXiizvgiQ+lOOG7bNKLUgl2oz+O5aJLABHv0ZC6NLB01Jzun
	kJafi9Lenpu6JM/NBZUcWZ4yDFtKp5OHf5UOckThXCRrQunse3Lr3yDo=
X-Google-Smtp-Source: AGHT+IH8SMgjq5IU+Dt5xKArR1nGq1tgA3n51pYNKcPNEzR4RzydNrCHnJiZr+7XwrIrgYWSylZDQhm/bO5m+r1JqVqh6NnTBx51
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2ccf:b0:7eb:a74b:8895 with SMTP id
 ca18e2360f4ac-7eba74b9f08mr17226239f.4.1718113224328; Tue, 11 Jun 2024
 06:40:24 -0700 (PDT)
Date: Tue, 11 Jun 2024 06:40:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b9744061a9d68ce@google.com>
Subject: [syzbot] Monthly hams report (Jun 2024)
From: syzbot <syzbot+list7d9abc7f0e8798d518c5@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 1 new issues were detected and 1 were fixed.
In total, 9 issues are still open and 34 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 162     Yes   KMSAN: uninit-value in ax25cmp (3)
                  https://syzkaller.appspot.com/bug?extid=74161d266475935e9c5d
<2> 25      No    WARNING: refcount bug in ax25_release (3)
                  https://syzkaller.appspot.com/bug?extid=33841dc6aa3e1d86b78a
<3> 5       No    KASAN: slab-use-after-free Read in rose_get_neigh
                  https://syzkaller.appspot.com/bug?extid=e04e2c007ba2c80476cb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

