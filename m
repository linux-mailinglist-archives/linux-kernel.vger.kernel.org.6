Return-Path: <linux-kernel+bounces-403145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44EA9C3199
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 11:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2D8281811
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 10:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5359D323D;
	Sun, 10 Nov 2024 10:29:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C442563
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731234544; cv=none; b=LLeL5ug7LJHaF/djd7rkvhCzmtzcZFeD3ARk+5AJZJ2EC4Ml2rQe92OxfGcEAYJ0T8pBB6qsKbzG5BCvwGqInBNk06T5i8aZCLNywrCmEdjn+78ROzMtpzWV4tpP0prHryP7p+EQ2Dgj+O8c4k5j/5nd96zMkFL7iUcjhiqAeIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731234544; c=relaxed/simple;
	bh=ZDV9DrPd5Fn9DiOWrrPc8SVGF0rY28BuX14K/BhjTa8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NgWK03ayz7Bnu2AVhKMo4BdZDlvkeVXbI0F+sbgMfSzyVQSlJqbuRfmsRrnEve5+MqXCEO7/lPPw6Ur5Xs7t87J1ujes9ENtiko+r1F8tTU78ZCbdMwHV/vG26ePef6NFRuxPYXyBlaHX+YRP53rTC7/aDZ7EJALvWpgOlzVYbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6b563871eso43681415ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 02:29:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731234542; x=1731839342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ohjvkhyrNBM8QruFwNM4KFzLSCzL37uESi2wXlUJ/JA=;
        b=TBH1fysbvSZlLs0TAPaXkv9+E7zMSLqhwhPLgU1013iSy3o1VMrLA14+9JgUlkTgUo
         Fqprts6FMfVBWqVFj71SHoANEz7N+vq2qYweipKNIMZiJ4CrIVt25x55qD2tTzoDJf5B
         eBXzcGkN9+97SQ2k2aNokqbldnYPVwOxxjO6dtWQSFQFQzxQGptt7mLe+EioMImhTZZ9
         Tqg+5g/LE2rMl/xgrSKitDDdsrP9QBxUvjKX6UfJmK3I/Y2EFdt44eRubXHLSsUHNyWS
         b10ZHCKpTQ5vjNQMlfwLSbtPYGlk5vukJJv1czB5o8MpKMVKA2XQRRhS7fVPlGYUn5wH
         1EHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZfoKJ9akvK/kgVjXhAiYHGUmQ1oJKvVpEDgSRyEllg/APpT4PFkwNqb6v0Sq8OiSjmKGab1s/Vk315GU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOGKDuxG0ipmIQ44/LdKU9SUn91dtr59J7v/n5HuomWcszV42Q
	LDlsu9gukTpMJav1UGVVbKDTngiF6pO3/tI92LlRcKO7Y9eYtGkYwjR1Hrj7IDVsN9TPrxkteSs
	r4paV7Fqf+/0Y+XdJT3ZNGF40P1gUW9VDHwlCdBd21l3R4NNM43aC5Kg=
X-Google-Smtp-Source: AGHT+IHxv1DOZUA8WE1UIRPvNKotW8J62xedsBUneqTASq+HdYXFl++iD3MAuslLwEQ+l/uDv3mcAMHfRbp3nEGnRxLleIEa02Ug
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a28:b0:3a6:b258:fcf with SMTP id
 e9e14a558f8ab-3a6f19a0126mr114185185ab.2.1731234542576; Sun, 10 Nov 2024
 02:29:02 -0800 (PST)
Date: Sun, 10 Nov 2024 02:29:02 -0800
In-Reply-To: <CAHiZj8jPNG+_4CHjud8qYxGkzXYsCXNxCw6ejQ0wCeFcKxBR3w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67308aee.050a0220.138bd5.004d.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_copygc
From: syzbot <syzbot+8689d10f1894eedf774d@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in bch2_copygc

=====================================================
BUG: KMSAN: uninit-value in rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
BUG: KMSAN: uninit-value in __rhashtable_lookup include/linux/rhashtable.h:607 [inline]
BUG: KMSAN: uninit-value in rhashtable_lookup include/linux/rhashtable.h:646 [inline]
BUG: KMSAN: uninit-value in rhashtable_lookup_fast include/linux/rhashtable.h:672 [inline]
BUG: KMSAN: uninit-value in bucket_in_flight fs/bcachefs/movinggc.c:144 [inline]
BUG: KMSAN: uninit-value in bch2_copygc_get_buckets fs/bcachefs/movinggc.c:184 [inline]
BUG: KMSAN: uninit-value in bch2_copygc+0x20b9/0x5970 fs/bcachefs/movinggc.c:235
 rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
 __rhashtable_lookup include/linux/rhashtable.h:607 [inline]
 rhashtable_lookup include/linux/rhashtable.h:646 [inline]
 rhashtable_lookup_fast include/linux/rhashtable.h:672 [inline]
 bucket_in_flight fs/bcachefs/movinggc.c:144 [inline]
 bch2_copygc_get_buckets fs/bcachefs/movinggc.c:184 [inline]
 bch2_copygc+0x20b9/0x5970 fs/bcachefs/movinggc.c:235
 bch2_copygc_thread+0x7f7/0xfa0 fs/bcachefs/movinggc.c:395
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Local variable b232.i created at:
 bch2_copygc_get_buckets fs/bcachefs/movinggc.c:184 [inline]
 bch2_copygc+0x1925/0x5970 fs/bcachefs/movinggc.c:235
 bch2_copygc_thread+0x7f7/0xfa0 fs/bcachefs/movinggc.c:395

CPU: 0 UID: 0 PID: 6614 Comm: bch-copygc/loop Not tainted 6.12.0-rc6-syzkaller-00279-gde2f378f2b77-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
=====================================================
Kernel panic - not syncing: kmsan.panic set ...
CPU: 0 UID: 0 PID: 6614 Comm: bch-copygc/loop Tainted: G    B              6.12.0-rc6-syzkaller-00279-gde2f378f2b77-dirty #0
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x216/0x2d0 lib/dump_stack.c:120
 dump_stack+0x1e/0x30 lib/dump_stack.c:129
 panic+0x4e2/0xcf0 kernel/panic.c:354
 kmsan_report+0x2c7/0x2d0 mm/kmsan/report.c:218
 __msan_warning+0x95/0x120 mm/kmsan/instrumentation.c:318
 rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
 __rhashtable_lookup include/linux/rhashtable.h:607 [inline]
 rhashtable_lookup include/linux/rhashtable.h:646 [inline]
 rhashtable_lookup_fast include/linux/rhashtable.h:672 [inline]
 bucket_in_flight fs/bcachefs/movinggc.c:144 [inline]
 bch2_copygc_get_buckets fs/bcachefs/movinggc.c:184 [inline]
 bch2_copygc+0x20b9/0x5970 fs/bcachefs/movinggc.c:235
 bch2_copygc_thread+0x7f7/0xfa0 fs/bcachefs/movinggc.c:395
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         de2f378f Merge tag 'nfsd-6.12-4' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a994e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4580d62ee1893a5
dashboard link: https://syzkaller.appspot.com/bug?extid=8689d10f1894eedf774d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1715635f980000


