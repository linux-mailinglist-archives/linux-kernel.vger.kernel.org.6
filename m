Return-Path: <linux-kernel+bounces-403432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FCA9C35A9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37DCE1F21126
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 00:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A420AD58;
	Mon, 11 Nov 2024 00:54:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7777E28EC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731286446; cv=none; b=L3GlxO5c0icudYPpf/xJACRjmtmLmoGozXGZvuUVmFhUD8flKLAvE9D6qsDxDMDlqUOmLkYaD8kJdpP3J/pzLIopxo2y3vDskXRETJkBLlirfFhr6wV9s9Ve0qLG+DuN31APr1IqGRcX3y1hfErn7a7t/SFxEtRthnQGk6cYqCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731286446; c=relaxed/simple;
	bh=ApmCT5cnWuroD4cp5Oj5H1ghdG0uyVocG7NzcJ51/eU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XYWOKzEDHVNRZLreh1D7Lun50MgIl6CDApllAYqgsPGikwAZh0y9bRZok3Xfg0ChObe828LC/rPJhfNStFILBw2e/uE2ZbykMEYFAMddiUTGLyQPuXMrc4KbWjURWY8ZFxw0yMmNNq6u2gXxkNgJRPqn2h46KDwi8JjCaVZCgcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83aecd993faso441716639f.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 16:54:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731286443; x=1731891243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZiQTJSXb+dM7SOuBpw+d8tJFPZfnS3IdFxNDjVPzEA=;
        b=ed/GF4oc2C7gVXxJbdZA1ko4rHC5+xyiAHnCEw2nhksOQi2KxaBPvOY27RicbaK3nn
         QutJsgMBEV9+i8VDU5maC/rCtN7YsZFyKpUQI+NA0z+09fhK2Q6GH88ZPFAh8oJ+X95B
         VcK3fvuJlTPpjGrIWqmv3u2qyme2ZjMzlIFd2eNpm3DL+9alZugeDYEMybDc0vXiSN5t
         P/nudqF0j3bhyXq1X4YbqTpdYj4ryaLo6dmnptrro+Qs1ABQeGrFVevX8VyP3mk48HNH
         ir5gGWLubc1Zpam0zV399aJ08A2vP2ClJBpiaYl6poRGXLa0ywYjy+i8kUmh3Zh5+l+O
         +YHA==
X-Forwarded-Encrypted: i=1; AJvYcCW4TftyuH6QYMwbIPpaUzq/yEKSAuzpW/+KT+Tg3Wsz/NTXogwEZDxnS4mpw3BpFkDolJtVfB5hGBaY/Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygi6DiLIXb3W+vihrpZGeibaPQLJcaLB+nRKErGgw54UrK0s1Q
	BF7B8oOCUI4VUNS0FSnmAZdCHbth9FRgbEvLo/Q31KeBSymBxNPBwCtWU/lg/xN71kmsciyX2Sj
	BhGBd0OeSpxcjE/XSxCoDGWqGily8Wf+1MrQ4H/etP6pxoFbtG1J3xmE=
X-Google-Smtp-Source: AGHT+IGyghi6kOcG3rB5k1wRzHAsz3nmfeMABM8tI8oKNd1/jauj+ZMc6fPW9c3BfbpeIs24irDtCLxSmYvR0jtVmp7qedjQQ/ka
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c88b:0:b0:3a0:ce43:fb62 with SMTP id
 e9e14a558f8ab-3a6f11d4c97mr96226615ab.11.1731286443694; Sun, 10 Nov 2024
 16:54:03 -0800 (PST)
Date: Sun, 10 Nov 2024 16:54:03 -0800
In-Reply-To: <2a46b846-9279-4cde-91c9-b01fc77e9052@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673155ab.050a0220.1fb99c.013d.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_copygc
From: syzbot <syzbot+8689d10f1894eedf774d@syzkaller.appspotmail.com>
To: gianf.trad@gmail.com, linux-kernel@vger.kernel.org, 
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
BUG: KMSAN: uninit-value in bucket_in_flight fs/bcachefs/movinggc.c:145 [inline]
BUG: KMSAN: uninit-value in bch2_copygc_get_buckets fs/bcachefs/movinggc.c:171 [inline]
BUG: KMSAN: uninit-value in bch2_copygc+0x1d3f/0x58f0 fs/bcachefs/movinggc.c:222
 rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
 __rhashtable_lookup include/linux/rhashtable.h:607 [inline]
 rhashtable_lookup include/linux/rhashtable.h:646 [inline]
 rhashtable_lookup_fast include/linux/rhashtable.h:672 [inline]
 bucket_in_flight fs/bcachefs/movinggc.c:145 [inline]
 bch2_copygc_get_buckets fs/bcachefs/movinggc.c:171 [inline]
 bch2_copygc+0x1d3f/0x58f0 fs/bcachefs/movinggc.c:222
 bch2_copygc_thread+0x83a/0xff0 fs/bcachefs/movinggc.c:383
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Local variable b205.i created at:
 bch2_copygc_get_buckets fs/bcachefs/movinggc.c:171 [inline]
 bch2_copygc+0x15b3/0x58f0 fs/bcachefs/movinggc.c:222
 bch2_copygc_thread+0x83a/0xff0 fs/bcachefs/movinggc.c:383

CPU: 1 UID: 0 PID: 6672 Comm: bch-copygc/loop Not tainted 6.12.0-rc7-syzkaller-g2d5404caa8c7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
=====================================================
Kernel panic - not syncing: kmsan.panic set ...
CPU: 1 UID: 0 PID: 6672 Comm: bch-copygc/loop Tainted: G    B              6.12.0-rc7-syzkaller-g2d5404caa8c7-dirty #0
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
 bucket_in_flight fs/bcachefs/movinggc.c:145 [inline]
 bch2_copygc_get_buckets fs/bcachefs/movinggc.c:171 [inline]
 bch2_copygc+0x1d3f/0x58f0 fs/bcachefs/movinggc.c:222
 bch2_copygc_thread+0x83a/0xff0 fs/bcachefs/movinggc.c:383
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         2d5404ca Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=115e135f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcca673786a14715
dashboard link: https://syzkaller.appspot.com/bug?extid=8689d10f1894eedf774d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=168608c0580000


