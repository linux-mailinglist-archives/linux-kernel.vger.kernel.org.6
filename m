Return-Path: <linux-kernel+bounces-245999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B1592BC83
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4E20B25995
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5788319CCE2;
	Tue,  9 Jul 2024 14:10:28 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837CF19B5B7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720534227; cv=none; b=qtkitKY6BS54jg1KWhol0DcbfEfG9WSO9jFDWeqodUETnbuWPE4mAhLNLia9A1A8Jqzdy35jW+ta9StaslDMUD4Nv8y2i6bWXDJLCnxkAgopr8Ek5E+F2YDSqI9dMjgyBYhjNew9QqJa+NPqlJdpKoZqXgwyaxmhQZabxuMqUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720534227; c=relaxed/simple;
	bh=ZCh1kPNmZRZWrKJ7Fo1EYqel/NGuENxFEwfMP46jlKw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HPtuid+DPW9EXDhApNfa2LfRTGE1TQLssFGgz3dFCj/bHKy91e/b5V+RUqeOPRZIhSdP++ThzbupHWOXO1WH9wK0rGf9Fl0mXBr5BZ9sSsLqdQI0b3EeE8cEK4QbLyGZtnIqxv7kXu8nT8qF+PBCOxLO5GM5GFapu8ikreCDpzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f99b5431b8so318580839f.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 07:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720534225; x=1721139025;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3hAOLMptiD0X5Mw/S5pDUJy9zGW0Pc9UAtGsP3cnp0k=;
        b=XL4fNKhsri3N3bimxWCtJ0lLGfI1AdPb7qi1K+QiTH/2Y7znAOSUKeoVL0CB5ifgN7
         +nyTSc7qZqkN1Rfy/w7Qz7mD3hT+1rmN3BqVQviXxGjHImJSW/dQwaM/bCm+XQs0gI9E
         r+zlT+ES+dwwcN/Fk/kJygPOTmA7iE3s6vAGXwjTSwoakUPe776zMjXpI9KuEhtC83VY
         LLsE/tS9M+5z1zsuFqF3oMWUVVWczSBHgqMqW1E8aphoQYQaLSWPY4+2yFCdy+bA7TdA
         Z92L8ucC5SfRm+y7F/a0BTzoQKj1hyzGRViJQRdf+9Z8BlciROnWOoKbHKl5NkZktLVU
         cXpw==
X-Forwarded-Encrypted: i=1; AJvYcCUVsru5EpKsBtgcyrSOU2KkQPOGMUoy6Wf5JBldvrmtN4WJQ7kMl+QcYBIJ3/RDdZH5VAX0wuQDVEflp0tkOTsmyxNS7JktsBE92yCT
X-Gm-Message-State: AOJu0Yz/rvqxHy1bwWwmwKcb1uKUh3dxpSDNF8792G0aPfyoLdg+Jl7t
	TRRSsJMv2dNVfuWM0AW2naSueQWJ/tKInT9SQfDaP3JD3hdXi+sg2G45Z0jc+QaFErwXdlPJnJo
	Ad1B1dVy6HBO8g9ztBf6Hx/yuWO7YadGq0VwQwHDAON9uoByigf5BuEI=
X-Google-Smtp-Source: AGHT+IF+DCaAzEdhUXy/aYDjQP4i1jKPkyvnUCG8GdzOMWyhW2ps5G7TaufmpWQHbof9enn31/nL9PkLT1g1kEgtvc6EFCoPohPL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8323:b0:4bf:2453:3a48 with SMTP id
 8926c6da1cb9f-4c0b2bb42c7mr127207173.5.1720534225445; Tue, 09 Jul 2024
 07:10:25 -0700 (PDT)
Date: Tue, 09 Jul 2024 07:10:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054f703061cd117fb@google.com>
Subject: [syzbot] Monthly kernfs report (Jul 2024)
From: syzbot <syzbot+list4f2c6bb2a0e33e8cf982@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello kernfs maintainers/developers,

This is a 31-day syzbot report for the kernfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kernfs

During the period, 4 new issues were detected and 0 were fixed.
In total, 20 issues are still open and 20 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4937    Yes   BUG: workqueue lockup (5)
                   https://syzkaller.appspot.com/bug?extid=f0b66b520b54883d4b9d
<2>  949     Yes   INFO: task hung in lookup_slow (3)
                   https://syzkaller.appspot.com/bug?extid=7cfc6a4f6b025f710423
<3>  428     Yes   possible deadlock in __kernfs_remove
                   https://syzkaller.appspot.com/bug?extid=4762dd74e32532cda5ff
<4>  321     No    possible deadlock in lookup_slow (3)
                   https://syzkaller.appspot.com/bug?extid=65459fd3b61877d717a3
<5>  246     Yes   WARNING in kernfs_remove_by_name_ns (3)
                   https://syzkaller.appspot.com/bug?extid=93cbdd0ab421adc5275d
<6>  22      Yes   INFO: task hung in kernfs_dop_revalidate (4)
                   https://syzkaller.appspot.com/bug?extid=da20d108162166514db6
<7>  9       Yes   WARNING in kernfs_get (5)
                   https://syzkaller.appspot.com/bug?extid=2f44671e54488d20f0e6
<8>  7       Yes   INFO: task hung in kernfs_remove_by_name_ns (2)
                   https://syzkaller.appspot.com/bug?extid=6d5664213a6db9a5a72c
<9>  1       No    KCSAN: data-race in kernfs_iop_permission / kernfs_iop_permission (4)
                   https://syzkaller.appspot.com/bug?extid=4d9e77bc73d118c6dc78
<10> 1       No    possible deadlock in kernfs_fop_write_iter
                   https://syzkaller.appspot.com/bug?extid=24386307cce6239b5f68

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

