Return-Path: <linux-kernel+bounces-189896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A27D8CF6A8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 01:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6C02818EE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 23:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4D513A26E;
	Sun, 26 May 2024 23:16:25 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185061C27
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 23:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716765385; cv=none; b=jpnRIB2WQYEbvJPzjpWLAHxRRnj+HHr+GkHPO1GaYwZJRX5oj6h7OK29PfU4rYrYc2xoE5NAIv54CkoMD2PC1PIeUbuSMhqhk7XufXXMNs7fxI2szcst6C69qQGdAnLuid/D2DVCSgsaNG/CAhph/OqPF9MoEwLmek8lb8HN2vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716765385; c=relaxed/simple;
	bh=pT2C6pkL79vgz+ZCS1ONaWJouZsVnsiaTdxLyoQeLSg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kCCZkSWljQ7cCl3pIAC+4B8/23cbpsfF5Gh+E4jr1KqfrG7ew0ZT0TOjwf+aj0GJw95MRfZset7815ozwoJZlKyKxTNsZHXJo9Jw7hhMnYfxJpNPHWPiSFjdnlJ1YHEJfdJGE4beyQkayPCpeq/ln5t7ruffDL6qErxLnjOunME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36da6da1d98so50120185ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 16:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716765383; x=1717370183;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oC8x2Dny6NMl03OjByychK0bgBBN5LCFjldcNIPARlc=;
        b=hk4NBwXcSFkThWmEQGdhd679Apu1SDwscfUMK6UM96REt1IMCoyar7zN7zCEhvGVf0
         naNdqg82KzMhlTj5/Ch1+ItvehHjTseTUS/U2sw3lf2Zs9oEfkCcshv8zIcQyiA3/hBP
         WbWMYmNALAmIPvEwHwBHQju8fdwpfZKdGbksOMyj2RbwQTMk1lOQtXam5Fb5MQTd6oOS
         KqQaJslXfqfr5GDo/sMXkvn+HtGE0WZQo7wWnNt4IPy/AXA1mbgffEDa6VasVQ9JQD72
         wj+32sHYIYjSz7YUo6yrdgEEEBDIESCAy2niSYKgVjiACl/K9DthUH+hhehotrJOBZds
         3npQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvtYMS6+4g4Rq1dESuip5u7wkNWtqUZJWpYzvQE9u3TA9G/kXNiZisRn8wR9Dd/uvrLcykUdgQeejWXmMHBU3VY8CsLmZdUFadt+6z
X-Gm-Message-State: AOJu0Yzj+hxWDjCoIsP5ZgDT/OuUN8g+l7Fg2ohebOO6zKXhte6dTaYe
	OHb23b/f+34uARfW79XTEBMdjV5pkAanLeMyt0eU6JwkBHCsjX71C4M3SNeSgz3C3zxVYAVWETK
	dy5DSOX8kO9SF2PjfsH5dhVChUewC8HSw1OW/woqM7Gmk40BfYriD1Q8=
X-Google-Smtp-Source: AGHT+IFi8sbn2Y2eQ+ZWTIDbmXh9+hc3xfhZvQ/D/UMAgjOfQHiJed5gSvuonfPxn/POpRN/+WvhIYkvC+nvzIMbcv6LnufCv8KR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0d:0:b0:36d:c039:a51a with SMTP id
 e9e14a558f8ab-3737b3ed18cmr9312675ab.5.1716765383294; Sun, 26 May 2024
 16:16:23 -0700 (PDT)
Date: Sun, 26 May 2024 16:16:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d58eb306196396c1@google.com>
Subject: [syzbot] riscv/fixes build error (2)
From: syzbot <syzbot+55235599b5a8c657dac8@syzkaller.appspotmail.com>
To: anup@brainfault.org, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0bfbc914d943 Merge tag 'riscv-for-linus-6.10-mw1' of git:/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=1471118a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c599cb5e39a20f2
dashboard link: https://syzkaller.appspot.com/bug?extid=55235599b5a8c657dac8
compiler:       riscv64-linux-gnu-gcc (Debian 12.2.0-13) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: riscv64

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+55235599b5a8c657dac8@syzkaller.appspotmail.com

drivers/irqchip/irq-riscv-imsic-early.c:52:9: error: too many arguments to function 'riscv_ipi_set_virq_range'

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

