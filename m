Return-Path: <linux-kernel+bounces-404239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DDC9C4147
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5886282F5F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F123019FA92;
	Mon, 11 Nov 2024 14:55:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F05D1E481
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731336905; cv=none; b=H+nyaYMtB+fVjjUc5lRBbFq/uYWm9ziiDvys5Tl7opD/NrdH2/1kUMf3XmjRUWQxPQh+8W7tE0RMLYm7+L48hjX1GiY8Ew5j1HBP+eVmjNoP1lDh9OVYRsbQqbLm6nAnw1kFNdQ92VKn5zNQP39YBoqu5aKmtGL6z+BavUQ8ir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731336905; c=relaxed/simple;
	bh=7ttyoxP+6G16qz98MlJHAo2yRy0o/o/w9ER0fK/m+3c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BGXBgJlTZZ0et4k2u/UVpUpy/COBE/ifbmpbWbrIGvqpHiwD1CFTdzaSqNi4pB8A0aDN4rPlAGkaQwXGUUrt+Y/rrJjiQb66c8bidbwnVWI390w8xVTLsU+mtJlFGLavUTmD8cczK9z6LL61ji8T4+KrK2KIZelBcHhsz/w0ppU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b9c5bcd8so51498855ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 06:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731336903; x=1731941703;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sfYn7BWZOcxuOga7Ej6itklBNxMCJS+Kz0QRYp4FzNk=;
        b=FxA70jwsxxakFOnGlcN4c0r0hRVeNl7L5OjXyZaN9HpPPLCSxq8GvlH+3SaK4aoKNf
         ocDKnmzgKKT2aQefzllAyhX/yxuwWxCAHQc++hTk4zJtRfrAJsMB/e7jTqyGB5YMhIdr
         phVb1IqreLlXAB84Jb3IvVVDcTGynhZdGiy6u285mcV3PvfS4nSAcdBXuPzdGyPVa0xV
         WBpBLn4wyl2wCnEnqNceccBA6nksd23EoequlY/LnowQf8tVKHY3gQnPXyipdeAd80BC
         Ew/BprN26Wwc7B9iz8WJ4ejVaLILVCGz0mo54AEU564xVNQ91KpXoUQBQX+gDRkAiNYX
         rPEg==
X-Forwarded-Encrypted: i=1; AJvYcCUj87WqxWFr/oBKd+HgcNrkJ7DGaxQT/K+ge4QoC1vZTqVUqVTLO4MNMu1a9UU4SZVG+YSoOVJoI3Xk+vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrdFK9FNl1Np5f6uiTwNRKkEoEOOISS1fupxQyh7SDRAALDu4D
	ASAHCKmdxmNiuGZxVeJSyKBR0Ps4O5u9okP0kMFz7N0Fvb80BraDkWGv+GEwu6BCvuOy5IYR6g7
	2tFB0thxmLRPhjizunyT8RT0nNdjwbkv5/lQGjUne9gjuSfscsRi2G1g=
X-Google-Smtp-Source: AGHT+IGYSO7Y/2h2AJG+q3Wj04pLa0S3pgngnWHjNUUkztsd04WO92Kz9R+XFF4sWQwWcORBHD4MGhbiQOCuBGi0m0GIcDMyv1sS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2482:b0:3a6:ad61:800f with SMTP id
 e9e14a558f8ab-3a6f198e699mr134716115ab.1.1731336903217; Mon, 11 Nov 2024
 06:55:03 -0800 (PST)
Date: Mon, 11 Nov 2024 06:55:03 -0800
In-Reply-To: <CAHiZj8gcQgEXB4XZG09m+pOG2vk_xwEYxS93t6kttzNFED6PQA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67321ac7.050a0220.a83d0.0015.GAE@google.com>
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
BUG: KMSAN: uninit-value in bch2_copygc_get_buckets fs/bcachefs/movinggc.c:170 [inline]
BUG: KMSAN: uninit-value in bch2_copygc+0x1d3f/0x58f0 fs/bcachefs/movinggc.c:221
 rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
 __rhashtable_lookup include/linux/rhashtable.h:607 [inline]
 rhashtable_lookup include/linux/rhashtable.h:646 [inline]
 rhashtable_lookup_fast include/linux/rhashtable.h:672 [inline]
 bucket_in_flight fs/bcachefs/movinggc.c:144 [inline]
 bch2_copygc_get_buckets fs/bcachefs/movinggc.c:170 [inline]
 bch2_copygc+0x1d3f/0x58f0 fs/bcachefs/movinggc.c:221
 bch2_copygc_thread+0x835/0xfe0 fs/bcachefs/movinggc.c:383
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Local variable b205.i created at:
 bch2_copygc_get_buckets fs/bcachefs/movinggc.c:170 [inline]
 bch2_copygc+0x15b3/0x58f0 fs/bcachefs/movinggc.c:221
 bch2_copygc_thread+0x835/0xfe0 fs/bcachefs/movinggc.c:383

CPU: 0 UID: 0 PID: 6674 Comm: bch-copygc/loop Not tainted 6.12.0-rc7-syzkaller-g2d5404caa8c7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
=====================================================
Kernel panic - not syncing: kmsan.panic set ...
CPU: 0 UID: 0 PID: 6674 Comm: bch-copygc/loop Tainted: G    B              6.12.0-rc7-syzkaller-g2d5404caa8c7-dirty #0
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
 bch2_copygc_get_buckets fs/bcachefs/movinggc.c:170 [inline]
 bch2_copygc+0x1d3f/0x58f0 fs/bcachefs/movinggc.c:221
 bch2_copygc_thread+0x835/0xfe0 fs/bcachefs/movinggc.c:383
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Kernel Offset: disabled


Tested on:

commit:         2d5404ca Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f8535f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcca673786a14715
dashboard link: https://syzkaller.appspot.com/bug?extid=8689d10f1894eedf774d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1008535f980000


